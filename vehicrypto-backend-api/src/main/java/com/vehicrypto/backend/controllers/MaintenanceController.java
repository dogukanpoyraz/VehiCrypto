package com.vehicrypto.backend.controllers;

import com.vehicrypto.backend.models.Maintenance;
import com.vehicrypto.backend.services.MaintenanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/maintenance")
@Validated
public class MaintenanceController {

    @Autowired
    private MaintenanceService service;

    @PostMapping("/add")
    public ResponseEntity<?> addMaintenance(@RequestBody Maintenance maintenance) {
        String referenceCode = service.addMaintenanceRecord(maintenance);
        return ResponseEntity.ok(Map.of("referenceCode", referenceCode));
    }
    
    @GetMapping("/getList/{vehicle_plate}")
	public ResponseEntity<?> getReferenceCodes(@PathVariable String vehicle_plate) {
    	        return ResponseEntity.ok(service.getReferenceCodes(vehicle_plate));
    }
	
    @GetMapping("/get/{referenceCode}")
    public ResponseEntity<?> getMaintenance(@PathVariable String referenceCode) {
        Maintenance record = service.getMaintenanceRecord(referenceCode);
        return ResponseEntity.ok(record);
    }
}
