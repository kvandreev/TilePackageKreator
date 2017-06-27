/* Copyright 2016 Esri
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import QtQuick 2.7
//------------------------------------------------------------------------------
import ArcGIS.AppFramework 1.0
//------------------------------------------------------------------------------
import "Portal"
import "IconFont"
//------------------------------------------------------------------------------

App {

    // PROPERTIES //////////////////////////////////////////////////////////////

    id: app
    width: sf(900)
    height: sf(675)

    property bool calledFromAnotherApp: false
    property url incomingUrl

    property string iconFont: icons.status == FontLoader.Ready ? icons.name : "tilepackagekreator"
    property string notoRegular: _notoRegular.status == FontLoader.Ready ? _notoRegular.name : "Noto Sans"
    property string notoBold: _notoBold.status == FontLoader.Ready ? _notoBold.name : "Noto Sans"
    property string notoItalic: _notoItalic.status == FontLoader.Ready ? _notoItalic.name : "Noto Sans"
    property string notoBoldItalic: _notoBoldItalic.status == FontLoader.Ready ? _notoBoldItalic.name : "Noto Sans"

    // SIGNAL IMPLEMENTATIONS //////////////////////////////////////////////////

    onOpenUrl: {
        if(url.toString() !== ""){
            calledFromAnotherApp = true;
            incomingUrl = url;
        }
    }

    // COMPONENTS //////////////////////////////////////////////////////////////

    Portal {
        id: portal
        clientId: app.info.value("deployment").clientId
        clientMode: false
        settings: app.settings
    }

    //--------------------------------------------------------------------------

    MainView {
        anchors.fill: parent
        portal: portal
        parentApp: app
    }

    //--------------------------------------------------------------------------

    FontLoader{
        id: _notoRegular
        source: app.folder.fileUrl("fonts/NotoSans-Regular.ttf")
    }
    FontLoader{
        id: _notoBold
        source: app.folder.fileUrl("fonts/NotoSans-Bold.ttf")
    }
    FontLoader{
        id: _notoItalic
        source: app.folder.fileUrl("fonts/NotoSans-Italic.ttf")
    }
    FontLoader{
        id: _notoBoldItalic
        source: app.folder.fileUrl("fonts/NotoSans-BoldItalic.ttf")
    }

    //--------------------------------------------------------------------------

    IconFont{
        id: icons
    }

    // -------------------------------------------------------------------------

    function sf(val){
        return val * AppFramework.displayScaleFactor;s
    }

    // END /////////////////////////////////////////////////////////////////////
}
