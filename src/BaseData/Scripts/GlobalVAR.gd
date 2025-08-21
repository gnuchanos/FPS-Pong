extends Node

var lang = "turkish"

##PlayGama
##NoAds
var Platform = 'PlayGama'

var ballSpeedX = 10
var ballSpeedZ = 10
var ballPositionX = 0
var ballOutside = false

var MaxSpeed = 5
var MinSpeed = 2
var AIDelayMin = 0
var AIDelayCurrent = 1.5
var AIMaxDelay = 1.5

var player0 = 0
var player1 = 0

var PlayerFOV_Current = 90
var PlayerFOV_MIN = 90

var PlayerCanMove = true
var PlayerLookingConsole = false
var PlayerLookingSettings = false

var MouseSpeed = 0.5

var pausedMode = false
