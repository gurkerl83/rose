###
ROSE is a browser extension researchers can use to capture in situ
data on how users actually use the online social network Facebook.
Copyright (C) 2013

    Fraunhofer Institute for Secure Information Technology
    Andreas Poller <andreas.poller@sit.fraunhofer.de>

Authors

    Oliver Hoffmann <oliverh855@gmail.com>
    Sebastian Ruhleder <sebastian.ruhleder@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

require 'Storage/RoseData'

class @Storage
    @addPlatform: (platformName) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.addPlatform(platformName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData()

    @hasPlatform: (platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            hasPlatform = roseData.hasPlatform(platformName)

            callback(hasPlatform)

    @addInteraction: (record, platformName) ->
        return new RSVP.Promise (resolve) ->
            console.log('[INTERACTION] ' + JSON.stringify(record))
            kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
                roseData = new RoseData(roseStorage)

                roseData.addInteraction(record, platformName)

                kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData(), resolve

    @getInteraction: (index, platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            interaction = roseData.getInteraction(index, platformName)

            callback(interaction)

    @getInteractions: (platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            interactions = roseData.getInteractions(platformName)

            callback(interactions)

    @removeInteraction: (index, platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.removeInteraction(index, platformName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData(), callback

    @hideInteraction: (index, hide, platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.hideInteraction(index, hide, platformName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData(), callback

    @addComment: (comment, platformName) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.addComment(comment, platformName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData()

    @getComment: (id, platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            comment = roseData.getComment(id, platformName)

            callback(comment)

    @getComments: (platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            comments = roseData.getComments(platformName)

            callback(comments)

    @hideComment: (index, hide, platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.hideComment(index, hide, platformName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData(), callback

    @removeComment: (index, platformName) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.removeComment(index, platformName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData()

    @addDiaryEntry: (entry) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.addDiaryEntry(entry)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData()

    @removeDiaryEntry: (index) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.removeDiaryEntry(index)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData()

    @updateDiaryEntry: (index, text, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.updateDiaryEntry(index, text)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData(), callback

    @getDiaryEntries: (callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            entries = roseData.getDiaryEntries()

            callback(entries)

    @getPrivacyEntry: (platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            entry = roseData.getPrivacyEntry(platformName)

            callback(entry)

    @setPrivacyEntry: (entry, platformName) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.setPrivacyEntry(entry, platformName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData()

    @getMetaInformation: (callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            meta = roseData.getMeta()

            callback(meta)

    @getStaticInformation: (platformName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            staticInformation = roseData.getStaticInformation(platformName)

            callback(staticInformation)

    @getStaticInformationEntries: (platformName, informationName, callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            staticEntry = roseData.getStaticInformationEntries(platformName, informationName)

            callback(staticEntry)

    @addStaticInformationEntry: (entry, platformName, informationName) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseData = new RoseData(roseStorage)

            roseData.addStaticInformationEntry(entry, platformName, informationName)

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData()

    @getStorageAsJson: (callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            callback JSON.stringify roseStorage, undefined, 2

    @setStorage: (store, callback) ->
        kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', store, callback

    @getSettings: (callback) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            settings = roseStorage.settings
            callback settings || {}

    @setSettings: (key, settings) ->
        kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
            roseStorage.settings[key] = settings

            kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseStorage

    @getLastExtractionTime: (network, extractorName) ->
        return new RSVP.Promise (resolve) ->
            kango.invokeAsyncCallback 'localforage.getItem', 'extractorTimes', (extractorTimes) ->
                data = $.extend true, {}, extractorTimes
                if data?[network]?[extractorName]?
                    resolve data[network][extractorName]
                else
                    resolve null

    @setLastExtractionTime: (network, extractorName, time) ->
        return new RSVP.Promise (resolve) ->
            kango.invokeAsyncCallback 'localforage.getItem', 'extractorTimes', (extractorTimes) ->
                # Set up storage field.
                extractorTimesTemp = $.extend true, {}, extractorTimes
                extractorTimesTemp[network] = {} unless extractorTimesTemp[network]

                # Set timestamp.
                extractorTimesTemp[network][extractorName] = time

                kango.invokeAsyncCallback 'localforage.setItem', 'extractorTimes', extractorTimesTemp, resolve

    @getLastOpenCloseInteractionType: (network) ->
        return new RSVP.Promise (resolve) ->
            kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
                roseData = new RoseData(roseStorage)

                # Find last 'open' or 'close' interaction.
                lastType = null

                interactions = roseData.getInteractions network
                interactions.reverse()

                # Iterate through network interactions.
                for interaction in interactions
                    if interaction.record?.type?
                        if interaction.record.type in ['open', 'close']
                            lastType = interaction.record.type
                            break

                resolve(lastType)

    @setParticipantID: (id, network) ->
        return new RSVP.Promise (resolve) ->
            kango.invokeAsyncCallback 'localforage.getItem', 'roseStorage', (roseStorage) ->
                roseData = new RoseData roseStorage
                roseData.setParticipantID id, network

                kango.invokeAsyncCallback 'localforage.setItem', 'roseStorage', roseData.getData(), resolve
