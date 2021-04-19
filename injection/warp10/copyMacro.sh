#!/bin/bash
POD=$(kubectl -n warpdemo get pod -o custom-columns=:metadata.name)
kubectl -n warpdemo exec -it $POD -- mkdir -p /opt/warp10/macros/Requeteur
cat mod1_req.mc2 | kubectl -n warpdemo exec -it $POD -- tee /opt/warp10/macros/Requeteur/mod1_req.mc2
