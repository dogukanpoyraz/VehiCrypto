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
    private String vehicle_plate;  
    private String vehicle_brand;   
    private String vehicle_model;   
    private String vehicle_km;      

    @NotBlank
    private Boolean engine_oil;      
    private Boolean steering_oil; 
    private Boolean transmission_oil;   
    private Boolean oil_filter;    
    private Boolean air_filter;   
    private Boolean pollen_filter;  
    private Boolean spark_plug;           
    private Boolean v_belt;        
    private Boolean timing_belt;   
    private Boolean clutch_belt; 
    private Boolean front_brake_pads; 
    private Boolean rear_brake_pads; 
    private Boolean front_shock_absorber;   
    private Boolean rear_shock_absorber;  


    @NotBlank
    private String date; 

    private String ipfsCid; 
    private String referenceCodes; 


    public String getVehicle_plate() {
        return vehicle_plate;
    }

    public void setVehicle_plate(String vehicle_plate) {
        this.vehicle_plate = vehicle_plate;
    }

    public String getVehicle_brand() {
        return vehicle_brand;
    }

    public void setVehicle_brand(String vehicle_brand) {
        this.vehicle_brand = vehicle_brand;
    }

    public String getVehicle_model() {
        return vehicle_model;
    }

    public void setVehicle_model(String vehicle_model) {
        this.vehicle_model = vehicle_model;
    }

    public String getVehicle_km() {
        return vehicle_km;
    }

    public void setVehicle_km(String vehicle_km) {
        this.vehicle_km = vehicle_km;
    }

    public Boolean getEngine_oil() {
        return engine_oil;
    }

    public void setEngine_oil(Boolean engine_oil) {
        this.engine_oil = engine_oil;
    }

    public Boolean getSteering_oil() {
        return steering_oil;
    }

    public void setSteering_oil(Boolean steering_oil) {
        this.steering_oil = steering_oil;
    }

    public Boolean getTransmission_oil() {
        return transmission_oil;
    }

    public void setTransmission_oil(Boolean transmission_oil) {
        this.transmission_oil = transmission_oil;
    }

    public Boolean getOil_filter() {
        return oil_filter;
    }

    public void setOil_filter(Boolean oil_filter) {
        this.oil_filter = oil_filter;
    }

    public Boolean getAir_filter() {
        return air_filter;
    }

    public void setAir_filter(Boolean air_filter) {
        this.air_filter = air_filter;
    }

    public Boolean getPollen_filter() {
        return pollen_filter;
    }

    public void setPollen_filter(Boolean pollen_filter) {
        this.pollen_filter = pollen_filter;
    }

    public Boolean getSpark_plug() {
        return spark_plug;
    }

    public void setSpark_plug(Boolean spark_plug) {
        this.spark_plug = spark_plug;
    }

    public Boolean getV_belt() {
        return v_belt;
    }

    public void setV_belt(Boolean v_belt) {
        this.v_belt = v_belt;
    }

    public Boolean getTiming_belt() {
        return timing_belt;
    }

    public void setTiming_belt(Boolean timing_belt) {
        this.timing_belt = timing_belt;
    }

    public Boolean getClutch_belt() {
        return clutch_belt;
    }

    public void setClutch_belt(Boolean clutch_belt) {
        this.clutch_belt = clutch_belt;
    }

    public Boolean getFront_brake_pads() {
        return front_brake_pads;
    }

    public void setFront_brake_pads(Boolean front_brake_pads) {
        this.front_brake_pads = front_brake_pads;
    }

    public Boolean getRear_brake_pads() {
        return rear_brake_pads;
    }

    public void setRear_brake_pads(Boolean rear_brake_pads) {
        this.rear_brake_pads = rear_brake_pads;
    }

    public Boolean getFront_shock_absorber() {
        return front_shock_absorber;
    }

    public void setFront_shock_absorber(Boolean front_shock_absorber) {
        this.front_shock_absorber = front_shock_absorber;
    }

    public Boolean getRear_shock_absorber() {
        return rear_shock_absorber;
    }

    public void setRear_shock_absorber(Boolean rear_shock_absorber) {
        this.rear_shock_absorber = rear_shock_absorber;
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

    public void setIpfsCid(String ipfs_cid) {
        this.ipfsCid = ipfs_cid;
    }

    public String getReferenceCode() {
        return referenceCodes;
    }

    public void setReferenceCode(String reference_code) {
        this.referenceCodes = reference_code;
    }
}
