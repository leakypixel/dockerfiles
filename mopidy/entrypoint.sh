#!/bin/bash
watch -n$LOCAL_SCAN_INTERVAL mopidy local scan &
mopidy
