ENT.Type = "anim"
ENT.Base = "base_glide_car"

ENT.PrintName = "Glide Motorcycle"
ENT.Author = "StyledStrike"
ENT.AdminOnly = false

-- Change vehicle type
ENT.VehicleType = Glide.VEHICLE_TYPE.MOTORCYCLE

-- Setup player sit animations
ENT.SeatDriverAnim = "drive_airboat"
ENT.SeatPassengerAnim = "sit"

ENT.AllowEditWheelRadius = false
ENT.AllowEditSuspensionLen = false

if CLIENT then
    -- Change default sounds
    ENT.StartSound = "Glide.Engine.BikeStart1"
    ENT.HornSound = "glide/horns/car_horn_light_1.wav"
    ENT.ExternalGearSwitchSound = ""
    ENT.InternalGearSwitchSound = ""
end

if SERVER then
    -- Change default car variables
    ENT.ChassisMass = 300
    ENT.AngularDrag = Vector( 0, -0.5, -0.5 ) -- Roll, pitch, yaw
    ENT.FallOnCollision = true
    ENT.SuspensionHeavySound = "Glide.Suspension.CompressBike"
    ENT.SteerSpeedFactor = 1600

    ENT.AirControlForce = Vector( 0.8, 1.5, 1 ) -- Roll, pitch, yaw
    ENT.AirMaxAngularVelocity = Vector( 600, 600, 500 ) -- Roll, pitch, yaw

    -- Bike-specific variables
    ENT.TiltForce = 500
    ENT.YawDrag = -5

    ENT.KeepUprightForce = 1500
    ENT.KeepUprightDrag = -3

    ENT.WheelieMaxAng = 45
    ENT.WheelieDrag = -15
    ENT.WheelieForce = 550

    function ENT:GetAirInputs()
        return 0, self:GetInputFloat( 1, "lean_pitch" ), -self:GetInputFloat( 1, "steer" )
    end

    function ENT:GetGears()
        return {
            [0] = 0, -- Neutral (this number has no effect)
            [1] = 3.0,
            [2] = 1.78,
            [3] = 1.2,
            [4] = 0.9,
            [5] = 0.75,
            [6] = 0.65
        }
    end
end