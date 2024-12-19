package com.vehicrypto.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Maintenance {

    @NotBlank
    private String vehiclePlate;  
    private String vehicleBrand;   
    private String vehicleModel;   
    private String vehicleKm;      

    @NotBlank
    private Boolean engineOil;      
    private Boolean steeringOil; 
    private Boolean transmissionOil;   
    private Boolean oilFilter;    
    private Boolean airFilter;   
    private Boolean pollenFilter;  
    private Boolean sparkPlug;           
    private Boolean vBelt;        
    private Boolean timingBelt;   
    private Boolean clutchBelt; 
    private Boolean frontBrakePads; 
    private Boolean rearBrakePads; 
    private Boolean frontShockAbsorber;   
    private Boolean rearShockAbsorber;  


    @NotBlank
    private String date; 

    private String ipfsCid; 
    private String referenceCode; 


    public String getVehiclePlate() {
        return vehiclePlate;
    }

    public void setVehiclePlate(String vehiclePlate) {
        this.vehiclePlate = vehiclePlate;
    }

    public String getVehicleBrand() {
        return vehicleBrand;
    }

    public void setVehicleBrand(String vehicleBrand) {
        this.vehicleBrand = vehicleBrand;
    }

    public String getVehicleModel() {
        return vehicleModel;
    }

    public void setVehicleModel(String vehicleModel) {
        this.vehicleModel = vehicleModel;
    }

    public String getVehicleKm() {
        return vehicleKm;
    }

    public void setVehicleKm(String vehicleKm) {
        this.vehicleKm = vehicleKm;
    }

    public Boolean getEngineOil() {
        return engineOil;
    }

    public void setEngineOil(Boolean engineOil) {
        this.engineOil = engineOil;
    }

    public Boolean getSteeringOil() {
        return steeringOil;
    }

    public void setSteeringOil(Boolean steeringOil) {
        this.steeringOil = steeringOil;
    }

    public Boolean getTransmissionOil() {
        return transmissionOil;
    }

    public void setTransmissionOil(Boolean transmissionOil) {
        this.transmissionOil = transmissionOil;
    }

    public Boolean getOilFilter() {
        return oilFilter;
    }

    public void setOilFilter(Boolean oilFilter) {
        this.oilFilter = oilFilter;
    }

    public Boolean getAirFilter() {
        return airFilter;
    }

    public void setAirFilter(Boolean airFilter) {
        this.airFilter = airFilter;
    }

    public Boolean getPollenFilter() {
        return pollenFilter;
    }

    public void setPollenFilter(Boolean pollenFilter) {
        this.pollenFilter = pollenFilter;
    }

    public Boolean getSparkPlug() {
        return sparkPlug;
    }

    public void setSparkPlug(Boolean sparkPlug) {
        this.sparkPlug = sparkPlug;
    }

    public Boolean getVBelt() {
        return vBelt;
    }

    public void setVBelt(Boolean vBelt) {
        this.vBelt = vBelt;
    }

    public Boolean getTimingBelt() {
        return timingBelt;
    }

    public void setTimingBelt(Boolean timingBelt) {
        this.timingBelt = timingBelt;
    }

    public Boolean getClutchBelt() {
        return clutchBelt;
    }

    public void setClutchBelt(Boolean clutchBelt) {
        this.clutchBelt = clutchBelt;
    }

    public Boolean getFrontBrakePads() {
        return frontBrakePads;
    }

    public void setFrontBrakePads(Boolean frontBrakePads) {
        this.frontBrakePads = frontBrakePads;
    }

    public Boolean getRearBrakePads() {
        return rearBrakePads;
    }

    public void setRearBrakePads(Boolean rearBrakePads) {
        this.rearBrakePads = rearBrakePads;
    }

    public Boolean getFrontShockAbsorber() {
        return frontShockAbsorber;
    }

    public void setFrontShockAbsorber(Boolean frontShockAbsorber) {
        this.frontShockAbsorber = frontShockAbsorber;
    }

    public Boolean getRearShockAbsorber() {
        return rearShockAbsorber;
    }

    public void setRearShockAbsorber(Boolean rearShockAbsorber) {
        this.rearShockAbsorber = rearShockAbsorber;
    }


    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getIpfsCid() {
        return ipfsCid;
    }

    public void setIpfsCid(String ipfsCid) {
        this.ipfsCid = ipfsCid;
    }

    public String getReferenceCode() {
        return referenceCode;
    }

    public void setReferenceCode(String referenceCode) {
        this.referenceCode = referenceCode;
    }
}
