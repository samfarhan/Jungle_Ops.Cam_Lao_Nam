_wpLand = heliGroup2 addWaypoint [LZExtractPosition, 0];
_wpLand setWaypointType "MOVE";
_wpLand setWaypointStatements ["TRUE", "vehicle this land 'GET IN'; ExtractHeliArrived = true;"];