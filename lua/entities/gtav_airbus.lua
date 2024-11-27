AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_glide_car"
ENT.PrintName = "Airport Bus"

ENT.GlideCategory = "Default"
ENT.ChassisModel = "models/gta5/vehicles/airbus/chassis.mdl"

if CLIENT then
    ENT.CameraOffset = Vector( -600, 0, 120 )
    ENT.CameraFirstPersonOffset = Vector( 10, 0, 5 )

    ENT.StartSound = "Glide.Engine.TruckStart"
    ENT.ExhaustPopSound = ""
    ENT.StartedSound = "glide/engines/start_tail_truck.wav"
    ENT.HornSound = "glide/horns/large_truck_horn_1.wav"

    ENT.ReverseSound = "glide/alarms/reverse_warning.wav"
    ENT.BrakeReleaseSound = "glide/wheels/rig_brake_release.wav"
    ENT.BrakeSqueakSound = "Glide.Brakes.Squeak"

    ENT.ExhaustAlpha = 120
    ENT.ExhaustOffsets = {
        { pos = Vector( -298, 44, 96 ), scale = 2 }
    }

    ENT.EngineSmokeStrips = {
        { offset = Vector( -288, 0, -8 ), angle = Angle( 0, 180, 0 ), width = 60 },
        { offset = Vector( -286, 0, 14 ), angle = Angle( 0, 180, 0 ), width = 60 }
    }

    ENT.EngineFireOffsets = {
        { offset = Vector( -270, -65, 5 ), angle = Angle( 270, 90, 0 ) }
    }

    ENT.Headlights = {
        { offset = Vector( 292, 30, -10 ), color = Glide.DEFAULT_HEADLIGHT_COLOR },
        { offset = Vector( 292, -30, -10 ), color = Glide.DEFAULT_HEADLIGHT_COLOR }
    }

    ENT.LightSprites = {
        { type = "brake", offset = Vector( -293, 41, 10.5 ), dir = Vector( -1, 0, 0 ) },
        { type = "brake", offset = Vector( -293, -41, 10.5 ), dir = Vector( -1, 0, 0 ) },
        { type = "reverse", offset = Vector( -293, 36, 10.5 ), dir = Vector( -1, 0, 0 ) },
        { type = "reverse", offset = Vector( -293, -36, 10.5 ), dir = Vector( -1, 0, 0 ) },
        { type = "headlight", offset = Vector( 290, 41.5, -11 ), dir = Vector( 1, 0, 0 ), color = Glide.DEFAULT_HEADLIGHT_COLOR },
        { type = "headlight", offset = Vector( 290, -41.5, -11 ), dir = Vector( 1, 0, 0 ), color = Glide.DEFAULT_HEADLIGHT_COLOR },
        { type = "headlight", offset = Vector( 290, 31, -11 ), dir = Vector( 1, 0, 0 ), color = Glide.DEFAULT_HEADLIGHT_COLOR },
        { type = "headlight", offset = Vector( 290, -31, -11 ), dir = Vector( 1, 0, 0 ), color = Glide.DEFAULT_HEADLIGHT_COLOR }
    }

    function ENT:OnCreateEngineStream( stream )
        stream.offset = Vector( -100, 0, 0 )
        stream:LoadPreset( "airbus" )
    end
end

if SERVER then
    duplicator.RegisterEntityClass( "gtav_airbus", Glide.VehicleFactory, "Data" )

    ENT.SpawnPositionOffset = Vector( 0, 0, 50 )
    ENT.ChassisMass = 1800
    ENT.IsHeavyVehicle = true

    ENT.BurnoutForce = 30
    ENT.UnflipForce = 4

    ENT.AirControlForce = Vector( 0.1, 0.05, 0.1 ) -- Roll, pitch, yaw
    ENT.AirMaxAngularVelocity = Vector( 100, 100, 150 ) -- Roll, pitch, yaw

    function ENT:GetGears()
        return {
            [-1] = 2.9, -- Reverse
            [0] = 0, -- Neutral (this number has no effect)
            [1] = 2.9,
            [2] = 1.8,
            [3] = 1.3,
            [4] = 1.05,
            [5] = 0.9
        }
    end

    ENT.LightBodygroups = {
        { type = "brake", bodyGroupId = 13, subModelId = 1 },
        { type = "reverse", bodyGroupId = 15, subModelId = 1 },
        { type = "headlight", bodyGroupId = 16, subModelId = 1 }, -- Tail lights
        { type = "headlight", bodyGroupId = 14, subModelId = 1 }  -- Headlights
    }

    ENT.SuspensionHeavySound = "Glide.Suspension.CompressTruck"
    ENT.SuspensionDownSound = "Glide.Suspension.Stress"

    function ENT:CreateFeatures()
        self:SetSpringStrength( 1800 )
        self:SetSpringDamper( 8000 )

        self:SetTransmissionEfficiency( 0.8 )
        self:SetDifferentialRatio( 2.1 )
        self:SetBrakePower( 2500 )
        self:SetWheelInertia( 13 )

        self:SetMaxRPM( 15000 )
        self:SetMinRPMTorque( 1000 )
        self:SetMaxRPMTorque( 1200 )

        self:SetSlipForce( 110 )
        self:SetExtremumValue( 6 )
        self:SetAsymptoteValue( 2.5 )

        self:CreateSeat( Vector( 230, 35.5, -4 ), Angle( 0, 270, -5 ), Vector( 250, -100, 5 ), true )

        self:CreateSeat( Vector( 142, -44, -5 ), Angle( 0, 270, 0 ), Vector( 200, -100, 5 ), true )
        self:CreateSeat( Vector( 142, 44, -5 ), Angle( 0, 270, 0 ), Vector( 150, -100, 5 ), true )
        self:CreateSeat( Vector( 98, -44, -5 ), Angle( 0, 270, 0 ), Vector( 100, -100, 5 ), true )
        self:CreateSeat( Vector( 98, 44, -5 ), Angle( 0, 270, 0 ), Vector( 50, -100, 5 ), true )
        self:CreateSeat( Vector( 12, -44, -5 ), Angle( 0, 270, 0 ), Vector( 0, -100, 5 ), true )
        self:CreateSeat( Vector( 12, 44, -5 ), Angle( 0, 270, 0 ), Vector( -50, -100, 5 ), true )
        self:CreateSeat( Vector( -120, -44, 10 ), Angle( 0, 270, 0 ), Vector( -100, -100, 5 ), true )
        self:CreateSeat( Vector( -120, 44, 10 ), Angle( 0, 270, 0 ), Vector( -150, -100, 5 ), true )
        self:CreateSeat( Vector( -260, 24, 10 ), Angle( 0, 270, 0 ), Vector( -150, -100, 5 ), false )

        -- Front left
        self:CreateWheel( Vector( 201, 49, -15 ), {
            model = "models/gta5/vehicles/airbus/wheel_front.mdl",
            modelAngle = Angle( 0, 0, 0 ),
            modelScale = Vector( 1, 0.35, 1 ),
            steerMultiplier = 1
        } )

        -- Front right
        self:CreateWheel( Vector( 201, -49, -15 ), {
            model = "models/gta5/vehicles/airbus/wheel_front.mdl",
            modelAngle = Angle( 0, 180, 0 ),
            modelScale = Vector( 1, 0.35, 1 ),
            steerMultiplier = 1
        } )

        -- Rear left
        self:CreateWheel( Vector( -165.5, 49, -15 ), {
            model = "models/gta5/vehicles/airbus/wheel_rear.mdl",
            modelAngle = Angle( 0, 0, 0 ),
            modelScale = Vector( 1, 0.6, 1 ),
            isPowered = true
        } )

        -- Rear right
        self:CreateWheel( Vector( -165.5, -49, -15 ), {
            model = "models/gta5/vehicles/airbus/wheel_rear.mdl",
            modelAngle = Angle( 0, 180, 0 ),
            modelScale = Vector( 1, 0.6, 1 ),
            isPowered = true
        } )

        self:ChangeWheelRadius( 20 )
    end
end