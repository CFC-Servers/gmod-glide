TOOL.Category = "Glide"
TOOL.Name = "#tool.glide_projectile_launcher.name"

TOOL.Information = {
    { name = "left" },
    { name = "right" }
}

TOOL.ClientConVar = {
    speed = 10000,
    gravity = 700,
    lifetime = 5,
    delay = 2,
    radius = 350,
    damage = 100
}

local function IsGlideProjectileLauncher( ent )
    return IsValid( ent ) and ent:GetClass() == "glide_projectile_launcher"
end

if SERVER then
    function TOOL:UpdateProjectileLauncher( ent )
        local speed = self:GetClientNumber( "speed" )
        local gravity = self:GetClientNumber( "gravity" )
        local lifetime = self:GetClientNumber( "lifetime" )
        local delay = self:GetClientNumber( "delay" )
        local radius = self:GetClientNumber( "radius" )
        local damage = self:GetClientNumber( "damage" )

        ent:SetProjectileSpeed( speed )
        ent:SetProjectileGravity( gravity )
        ent:SetProjectileLifetime( lifetime )
        ent:SetReloadDelay( delay )
        ent:SetExplosionRadius( radius )
        ent:SetExplosionDamage( damage )
    end
end

function TOOL:LeftClick( trace )
    local ent = trace.Entity

    if IsGlideProjectileLauncher( ent ) then
        if SERVER then
            self:UpdateProjectileLauncher( ent )
        end

        return true
    end

    local ply = self:GetOwner()
    if not ply:CheckLimit( "glide_projectile_launchers" ) then return false end

    if SERVER then
        ent = ents.Create( "glide_projectile_launcher" )
        if not IsValid( ent ) then return false end

        undo.Create( self.Name )
        undo.AddEntity( ent )
        undo.SetPlayer( ply )
        undo.Finish()

        ply:AddCount( "glide_projectile_launchers", ent )

        local normal = trace.HitNormal
        local pos = trace.HitPos + normal * 5

        ent:SetPos( pos )
        ent:SetAngles( normal:Angle() + Angle( 90, 0, 0 ) )
        ent:SetCreator( ply )
        ent:Spawn()
        ent:Activate()

        self:UpdateProjectileLauncher( ent )
    end

    return true
end

function TOOL:RightClick( trace )
    local ent = trace.Entity
    if not IsGlideProjectileLauncher( ent ) then return false end

    if SERVER then
        local ply = self:GetOwner()
        local speed = ent.projectileSpeed
        local gravity = ent.projectileGravity
        local lifetime = ent.projectileLifetime
        local delay = ent.reloadDelay
        local radius = ent.explosionRadius
        local damage = ent.explosionDamage

        ply:ConCommand( "glide_projectile_launcher_speed " .. speed )
        ply:ConCommand( "glide_projectile_launcher_gravity " .. gravity )
        ply:ConCommand( "glide_projectile_launcher_lifetime " .. lifetime )
        ply:ConCommand( "glide_projectile_launcher_delay " .. delay )
        ply:ConCommand( "glide_projectile_launcher_radius " .. radius )
        ply:ConCommand( "glide_projectile_launcher_damage " .. damage )
    end

    return true
end

local cvarMaxLifetime = GetConVar( "glide_projectile_launcher_max_lifetime" )
local cvarMinDelay = GetConVar( "glide_projectile_launcher_min_delay" )
local cvarMaxRadius = GetConVar( "glide_projectile_launcher_max_radius" )
local cvarMaxDamage = GetConVar( "glide_projectile_launcher_max_damage" )

function TOOL.BuildCPanel( panel )
    panel:AddControl( "header", { Description = "#tool.glide_projectile_launcher.desc" } )

    panel:AddControl( "slider", {
        Label = "#tool.glide_projectile_launcher.speed",
        command = "glide_projectile_launcher_speed",
        type = "float",
        min = 1,
        max = 20000
    } )

    panel:AddControl( "slider", {
        Label = "#tool.glide_projectile_launcher.gravity",
        command = "glide_projectile_launcher_gravity",
        type = "float",
        min = 1,
        max = 2000
    } )

    panel:AddControl( "slider", {
        Label = "#tool.glide_projectile_launcher.lifetime",
        command = "glide_projectile_launcher_lifetime",
        type = "float",
        min = 1,
        max = cvarMaxLifetime and cvarMaxLifetime:GetFloat() or 10
    } )

    panel:AddControl( "slider", {
        Label = "#tool.glide_projectile_launcher.delay",
        command = "glide_projectile_launcher_delay",
        type = "float",
        min = cvarMinDelay and cvarMinDelay:GetFloat() or 0.5,
        max = 5
    } )

    panel:AddControl( "slider", {
        Label = "#tool.glide_projectile_launcher.radius",
        command = "glide_projectile_launcher_radius",
        min = 50,
        max = cvarMaxRadius and cvarMaxRadius:GetFloat() or 500
    } )

    panel:AddControl( "slider", {
        Label = "#tool.glide_projectile_launcher.damage",
        command = "glide_projectile_launcher_damage",
        min = 1,
        max = cvarMaxDamage and cvarMaxDamage:GetFloat() or 200
    } )
end
