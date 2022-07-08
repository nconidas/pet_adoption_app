import enum


class SpeciesEnum(enum.Enum):
    DOG = 1


class SizeEnum(enum.Enum):
    SMALL = 1
    MEDIUM = 2
    LARGE = 3
    XLARGE = 4
    UNKONWN = 5


class GenderEnum(enum.Enum):
    MALE = 1
    FEMALE = 2
    UNKNOWN = 3


class AgeEnum(enum.Enum):
    BABY = 1
    YOUNG = 2
    ADULT = 3
    SENIOR = 4
    UNKNOWN = 5


class CoatEnum(enum.Enum):
    SHORT = 1
    MEDIUM = 2
    LONG = 3
    WIRE = 4
    HAIRLESS = 5
    CURLY = 6
    UNKNOWN = 7


class StatusEnum(enum.Enum):
    ADOPTABLE = 1
    ADOPTED = 2
    UNKNOWN = 3
