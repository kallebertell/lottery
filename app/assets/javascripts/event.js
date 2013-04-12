/**
 *  event js
 */
'use strict';

var eventApp = angular.module('event', ['ngResource']);

eventApp.factory('eventService', function ($resource) {
  return $resource('/events/:id/:action', 
          { id:'@id' },
          { 'initialize' : { method: 'GET' }});
});

eventApp.controller('ParticipantsCtrl', function($scope, $http) {

    console.log(location.pathname);

    var eventId = location.pathname.match(/\/events\/([0-9]*)/)[1];

    $http.get('/events/' + eventId + '.json')
      .then(function(res) {
          $scope.event = res.data;                
      });

    $http.get('/events/' + eventId + '/participants.json')
      .then(function(res) {
          $scope.participants = res.data;
          console.log(res.data);
      });

    $scope.addParticipant = function() {
      var participant = {email: $scope.emailText}
      $scope.participants.push(participant);
      $scope.emailText = '';
      $http.post('/events/' + eventId + '/participants', participant);
    };
   
    $scope.participantsTotal = function() {
      return participants.size;
    };
   
    $scope.removeParticipant = function() {
      var participantId = 12;
      $http.delete('events/' + eventId + '/participants/' + participantId)
    };
  });
