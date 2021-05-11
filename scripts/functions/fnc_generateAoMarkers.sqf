_aoMarker = createMarker ["MarkerAO", AOPosition];
_aoMarker setMarkerShape "ELLIPSE";
_aoMarker setMarkerSize [AORadius, AORadius];
_aoMarker setMarkerColor "colorOPFOR";

_aoMarkerUPS = createMarker ["MarkerAOUps", AOPosition];
_aoMarkerUPS setMarkerShape "ELLIPSE";
_aoMarkerUPS setMarkerSize [AORadius, AORadius];
_aoMarkerUPS setMarkerAlpha 0;

// Value of 'Accurate Markers' parameter selected in lobby.
_accObjectiveMarkers = "AccurateObjectiveMarkers" call BIS_fnc_getParamValue;

_objectiveMarker = createMarker ["MarkerObjective", ObjectivePosition];
_objectiveMarker setMarkerShape "ELLIPSE";
_objectiveMarker setMarkerSize [ObjectiveRadius, ObjectiveRadius];
_objectiveMarker setMarkerColor "ColorRed";
_objectiveMarker setMarkerBrush "FDiagonal";

_objectiveMarkerUPS = createMarker ["MarkerObjectiveUps", ObjectivePosition];
_objectiveMarkerUPS setMarkerShape "ELLIPSE";
_objectiveMarkerUPS setMarkerSize [ObjectiveRadius, ObjectiveRadius];
_objectiveMarkerUPS setMarkerAlpha 0;

_objectiveTextMarker = createMarker ["MarkerObjectiveText", ObjectivePosition];
_objectiveTextMarker setMarkerType "mil_dot";
_objectiveTextMarker setMarkerText "Objective";

// No accurate markers.
if(_accObjectiveMarkers == 0) then
{
	_markerPos = ObjectivePosition vectorAdd [Random ObjectiveRadius, Random ObjectiveRadius, 0];
	_objectiveMarker setMarkerPos _markerPos;
	_objectiveTextMarker setMarkerPos _markerPos;
	_objectiveTextMarker setMarkerType "mil_unknown";
}
else
{
	_objectiveMarker setMarkerAlpha 0;
};

_lzInsertMarker = createMarker ["MarkerLZInsert", LZInsertPosition];
_lzInsertMarker setMarkerType "mil_dot";
_lzInsertMarker setMarkerText "LZ Tokyo";
_lzInsertMarker setMarkerColor "ColorBLUFOR";

[_aoMarker, _objectiveMarker, _objectiveTextMarker, _lzInsertMarker];