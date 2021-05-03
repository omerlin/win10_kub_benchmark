

To add automatically the dashboards, you need to tag config map with "grafana_dashboard"

kubectl -n monitoring create cm windows-exporter --from-file=windows-exporter-for-prometheus-dashboard_rev6.json
kubectl -n monitoring label cm windows-exporter grafana_dashboard='1'
