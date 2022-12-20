<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:ogc="http://www.opengis.net/ogc" xmlns:se="http://www.opengis.net/se" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1.0">
  <NamedLayer>
    <se:Name>origens_turisme</se:Name>
    <UserStyle>
      <se:Name>origens_turisme</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>Centre d'Interpretació</se:Name>
          <se:Description>
            <se:Title>Centre d'Interpretació</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Centre d'Interpretació</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Informació turística</se:Name>
          <se:Description>
            <se:Title>Informació turística</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Informació turística</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Caiac</se:Name>
          <se:Description>
            <se:Title>Caiac</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Caiac</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Castell</se:Name>
          <se:Description>
            <se:Title>Castell</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Castell</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Cova visitable</se:Name>
          <se:Description>
            <se:Title>Cova visitable</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Cova visitable</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Església</se:Name>
          <se:Description>
            <se:Title>Església</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Església</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Establiment recomanat</se:Name>
          <se:Description>
            <se:Title>Establiment recomanat</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Establiment recomanat</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Exposició a l'aire lliure</se:Name>
          <se:Description>
            <se:Title>Exposició a l'aire lliure</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Exposició a l'aire lliure</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#adb311</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#adb311</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>21</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <!--Parametric SVG-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PHN2ZyBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCA1ODAgNTgwIiBoZWlnaHQ9IjU4MCIgdmlld0JveD0iMCAwIDU4MCA1ODAiIHdpZHRoPSI1ODAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGQ9Im05OC4yMDEgMzA5Ljk0N2wtNi4xMzggNjEuMzc1IDM5Ljg5NCA0OS4xMDIgMTE2LjYxNCA1Ni43NzJoMTI4Ljg4OWw3Ni43Mi01My43MDQgMzIuMjIzLTU1LjIzOCAxMC43NC02OS4wNDctNTUuMjM3LTc4LjI1NS0zMi4yMjMtNDIuOTYzLTc2LjcyLTE2Ljg3OC0zOC4zNTkgMTQxLjE2NC04Mi44NTcgMTIuMjc1eiIgZmlsbD0icGFyYW0oZmlsbCkiIG9wYWNpdHk9Ii4xIi8+CjxwYXRoIGQ9Im0xNjUuNzE0IDQyOS42M2w5NS4xMzItMTI3LjM1NCA5Ni42NjcgMTIuMjc1IDg4Ljk5NC02MS4zNzYgMzYuODI1IDE4LjQxMyAxNi44NzkgNjkuMDQ3LTMyLjIyMyA3MC41ODItMTM2LjU2MS03OS43ODgtMzIuMjIzIDM4LjM1OSA2LjEzOCAxMDIuODA1LTY1Ljk3OSAzLjA2OHoiIGZpbGw9InBhcmFtKGZpbGwpIiBvcGFjaXR5PSIuMSIvPgo8cGF0aCBkPSJtNDkwLjQ3NiAyNDYuMzIyYy0xNC4zMjgtMjQuMzEyLTQwLjE4OC01My4wNDQtNTkuNTg2LTY2LjE2My0zMy4xNTQtMjIuNDIyLTkyLjc3NC00NC45MTEtMTMxLjU5OS00OS42NjctMTEuMjgzLS42MTktMjIuMjU5LTEuNzM4LTMzLjI5Mi0yLjA1M2wtOC41NDYtNTAuNTM0LTI3LjEwMiAzLjU4MSA4Ljg5MiA0OC40MzJjLTcuMTUxIDEuMTYtMTQuNDQ2IDMuMDgzLTIxLjk2OCA2LjA3bC0yNy4wMjUtNTQuODYzLTIyLjgxMyAxMC40MDYgMjkuNTUzIDU4LjEwM2MtMi43NzMgMy41MjUtNS44NTYgNy42MzYtOC44MDcgMTAuOTA1LTIwLjE2MyAyMi4zMzktMjMuODcgNTQuMDA4LTkuNDgzIDgwLjc2OSAxNC45NTUgMjcuODE3IDEyLjQ0MiA0Ny4wMDEtNi45MzkgNTIuOTc0LTguMjA4IDIuNTI5LTExLjgyMiAxLjg1Mi0yOS45MzgtNS4yNjgtMTEuMzMyLTQuNDUzLTI0LjY4My04LjA2Mi0yOS42NDgtOC4wMy0xNC4wMjguMDkxLTI3LjU1NCA4LjUzNC0zNC45MTYgMjEuNzI4LTUuNTI2IDkuOTAyLTYuNDc5IDE0LjI5Ni02LjU0IDMxLjQ2NS0uMDc5IDIxLjk1IDIuNTk4IDI5LjY2OCAyMC40NTYgNTkuOTEzIDE4LjE0MSAzMC43MjUgNDQuOTc5IDU4LjMwMyA3NS45MzcgNzguMDA3IDIxLjI4NCAxMy41NDggNjAuNDMzIDI3Ljg3MiA4My43NDggMzAuOTIgMTMuOTQ4IDEuODIzIDMyLjM1MiA0LjQ3IDU3LjYyNyA0LjA2OWwxMC4wNjUgNTQuODI0YzEuMTQ2IDguNzg2IDIwLjc1NCA2LjM1MiAyMC40MTctMS45ODNsLTkuMTA4LTUzLjg1OGMxMS44ODYtLjkyOCAyNS4wMjEtMi41MzIgMzkuNTktNS4wODcgMS44NTQtLjQzMiAzLjcwNy0uOTA1IDUuNTU4LTEuMzk4bDE0LjM2NyAyOC4yNjJjMy42NDcgOC4xIDIwLjE3My43MjEgMTcuMzc1LTcuMTU2bC0xMy4yODYtMjYuOTgzYzM1LjYzLTEzLjIwNiA2OC41MzUtMzUuOTcxIDg3Ljg1Ni01OC4xMjMgMjMuNjEtMjcuMDY5IDI3Ljc1NS0zOS4xMzMgMzMuNjQ1LTY4LjE5NyA3LjE3NC0zNS40MS0yLjY3My04NC4wNDktMjQuNDktMTIxLjA2NXptLTE0OC4zMTItMzUuNzUyYzUuNDM3LTYuMjMyIDEyLjU3My0xNS4zNzEgMTUuODc4LTIwLjMxIDQuNjI5LTYuOTE4IDYuNjY2LTguNTc0IDEyLjkzNS04LjYxMS44OTYtLjAwNSAxLjg1NC4wMjMgMi45NDIuMDczIDEyLjcyNC41ODEgMjQuMTkzIDQuOTYzIDI5LjAzIDExLjA4MiA1LjU0NiA3LjAxMyAxMy42MDggNDIuNDQ3IDExLjk1NCA1Mi41MzgtMS4zMTcgOC4wMzktMTkuMTQyIDMwLjI2Ni0yNC4yNzEgMzAuMjY2LTEuMjAzIDAtMy41NjUuNTA2LTUuMjY5IDEuMTI2LTEuNzA0LjYyMS02Ljc4Ni0uNDk3LTExLjI2NC0yLjQ3LTQuNDc3LTEuOTc0LTEwLjk2Ni0zLjY2Ny0xNC40MjQtMy43NzktMTAuNTgzLS4zNDEtMTcuMzE5LTUuNTU0LTIyLjQ5LTE3LjQwNC03Ljk4NS0xOC4zMDItNi42ODgtMjkuMTM4IDQuOTc5LTQyLjUxMXptLTk2Ljk2MS00OC4xODZsOC44NjggNDguMzA0LTIxLjkxMS00NC40ODFjNC4wMzktMS45MzEgOC40MjktMy4yMzggMTMuMDQzLTMuODIzem0xLjYzNSA4NS4yNWMtMjEuODk2LTEuOTMtMzkuMTA2LTIwLjMzOS0zOS4xMDYtNDIuNzMyIDAtOC4wOCAyLjI0My0xNS42MzYgNi4xMzYtMjIuMDg4em0tNzUuNzY3IDE0Ni42Yy0xMi4xMDkgMTAuMDg0LTE1LjgzMyAxMS44MDktMjUuMzYgMTEuODA5LTExLjQyNiAwLTIwLjQ1Ni02LjI5MS0yMC40NTYtMTQuMjQzIDAtMS45NzgtMi43MTctOS40MzMtNi4wMzEtMTYuNTY3LTUuMjY2LTExLjMzNS01LjY5Ni0xNC4xNTctMy41MjQtMjIuNDU1IDMuMDM2LTExLjU5OCAxMy42OTMtMjMuNzk3IDIwLjg5Mi0yNC4xNjEuMjMyLS4wMTIuNDI5LS4wMTMuNjU0IDAgMi45OTQuMTc3IDEyLjc3Mi42NCAyMS43MjggMS4wMTggOC45NTUuMzc3IDE3LjU5NyAxLjY3MyAxOS4yMiAyLjgzNCAzLjkxNCAyLjc5OSAxNC40OTcgMjYuODQyIDE0LjQ5NyAzMi45NTQtLjAwMiA3LjYyMy02LjMyNCAxNi4wNzMtMjEuNjIgMjguODExem0xMTIuMzQzIDIzLjc5OGMtMi41NTkgNS43NDMtNC42ODMgMTIuMjgxLTQuNzIzIDE0LjUzMy0uMDQxIDIuMjUzLTIuNzQ2IDcuNTc5LTUuOTk1IDExLjgwOS01LjE3NCA2LjczNS03LjkwNiA3LjgyMS0yMS45ODEgOC45NzQtMTMuMzM0IDEuMDkzLTE2LjI4Mi42MTgtMTcuNDc3LTIuOTQyLS43OTItMi4zNi02LjItNy4wMy0xMi4wMjYtMTAuMzU1LTcuMTg5LTQuMTAyLTExLjY0NS04LjgyOC0xMy43Ny0xNC42NDItNi43MzctMTguNDI5LS42MjctNDMuNjg4IDExLjAwOS00NS41NjMgMy4xMDItLjQ5OSA3LjI0LTIuNTQ5IDkuMTkyLTQuNTQxIDEuOTUyLTEuOTkzIDcuOTg0LTQuNDI4IDEzLjM3MS01LjQxNCAyLjAxNS0uMzY5IDMuNzM5LS41NjMgNS40MTQtLjU4MSA1LjAyMy0uMDU0IDkuMjkzIDEuNjU4IDE3LjIyMiA2LjI0OSAxMi40OTEgNy4yMzMgMjQuNDE2IDIxLjE0NiAyNC40MTYgMjguNDQ5LS4wMDIgMS45ODQtMi4wOTQgOC4yODEtNC42NTIgMTQuMDI0em0tMTAuNy0yNDkuODg2YzEyLjQ2MSA3LjUgMjAuOCAyMS4xNTUgMjAuOCAzNi43NTYgMCAxMC40NC0zLjczNyAyMC4wMTMtOS45NCAyNy40NTh6bTEwNi4yNTYgMjcyLjIzMWMtNi41NDkgMS42MDctMTUuNjU4IDQuNjk2LTIwLjI3NCA2LjkwMy0xOC45NjMgOS4wNjgtMzMuNjkuNTQ1LTM2LjY2LTIxLjI1NS01LjEzNi0zNy43MTMtNS4xNDUtMzcuNjA0IDUuMjY5LTQ5LjUyMSA1LjYwOS02LjQyIDkuMTgyLTkuNTc3IDE0LjQ5Ny05Ljg0Ny4yOTMtLjAxNS41NjctLjAzOS44NzItLjAzNiA0LjU2NS4wMzggMTAuNTA1IDIuMDQ5IDE5LjgzOCA1LjcwNCA1Ljc1NyAyLjI1NSAxMy41NjUgNS4wNTQgMTcuNDAzIDYuMjQ5IDUuMzk3IDEuNjgyIDguNDE5IDUuNTAxIDEzLjI2MiAxNi44MjIgMTEuNTM4IDI2Ljk3OCA3LjUzMiAzOS42NDUtMTQuMjA3IDQ0Ljk4MXptMTAwLjM4OC0xMTQuODQ5Yy0yLjA1OSA3LjI5NS00LjI2OCAxNy44NjUtNC45MDUgMjMuNTQ0LTIuNjIgMjMuMzMtMTYuNDI4IDMzLjY4MS0zNC40MDcgMjUuNzI0LTMxLjEwNS0xMy43NjYtMzEuMDMyLTEzLjczMS0zNC44NDQtMzAuMDExLTMuODY0LTE2LjUwOC0yLjQ4OS0yMC4wNjIgMTQuNDI0LTM2Ljk1MSA0LjU4NS00LjU3OCAxMC42NTYtMTAuOTY0IDEzLjQ4LTE0LjE3IDMuMjI2LTMuNjY0IDYuNzE1LTUuMDQ2IDEzLjgwNy00Ljk3OCAxLjYzNi4wMTYgMy40NjIuMTI5IDUuNTIyLjI5MSAyNi4xODMgMi4wNTEgMzMuNzU1IDEyLjMzNiAyNi45MjMgMzYuNTUxeiIgZmlsbD0icGFyYW0oZmlsbCkiIGZpbGwtb3BhY2l0eT0icGFyYW0oZmlsbC1vcGFjaXR5KSIgc3Ryb2tlPSJwYXJhbShvdXRsaW5lKSIgc3Ryb2tlLW9wYWNpdHk9InBhcmFtKG91dGxpbmUtb3BhY2l0eSkiIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkiLz4KPHBhdGggZD0ibTE2Ni41MjQgODguMDE3bDIyLTguNjExYy0yLjMzNy05LjQ0NyAxLjkzOC0xNy43NjItOC41MjEtMjcuMzE0LTE0LjYzMi0xMy4zNjItMjEuMTI0LTE3LjA0MS0yOS45NTktMjQuNTAxLTIuMDYzIDE3Ljg3LTUuNzI3IDQwLjY4IDE2LjQ4IDYwLjQyNnoiIGZpbGw9InBhcmFtKGZpbGwpIiBmaWxsLW9wYWNpdHk9InBhcmFtKGZpbGwtb3BhY2l0eSkiIHN0cm9rZT0icGFyYW0ob3V0bGluZSkiIHN0cm9rZS1vcGFjaXR5PSJwYXJhbShvdXRsaW5lLW9wYWNpdHkpIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIi8+CjxwYXRoIGQ9Im0yNTYuMjE5IDc1Ljc3Yy42NTUtOS43MTEgNy44MTMtMTYuNDgyLjA2MS0yOC41Ny0xMC44NDQtMTYuOTEtMTYuMzktMjIuMjU2LTIzLjEzNi0zMS44ODQtNy45NzkgMTYuNTQ5LTE5LjIzMiAzNy4zODctMi41OTkgNjIuNTM5eiIgZmlsbD0icGFyYW0oZmlsbCkiIGZpbGwtb3BhY2l0eT0icGFyYW0oZmlsbC1vcGFjaXR5KSIgc3Ryb2tlPSJwYXJhbShvdXRsaW5lKSIgc3Ryb2tlLW9wYWNpdHk9InBhcmFtKG91dGxpbmUtb3BhY2l0eSkiIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkiLz4KPC9zdmc+Cg==?fill=%23dfd2d3&amp;fill-opacity=1&amp;outline=%23dfd2d3&amp;outline-opacity=1&amp;outline-width=0"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Plain SVG fallback, no parameters-->
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="base64:PHN2ZyBlbmFibGUtYmFja2dyb3VuZD0ibmV3IDAgMCA1ODAgNTgwIiBoZWlnaHQ9IjU4MCIgdmlld0JveD0iMCAwIDU4MCA1ODAiIHdpZHRoPSI1ODAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxwYXRoIGQ9Im05OC4yMDEgMzA5Ljk0N2wtNi4xMzggNjEuMzc1IDM5Ljg5NCA0OS4xMDIgMTE2LjYxNCA1Ni43NzJoMTI4Ljg4OWw3Ni43Mi01My43MDQgMzIuMjIzLTU1LjIzOCAxMC43NC02OS4wNDctNTUuMjM3LTc4LjI1NS0zMi4yMjMtNDIuOTYzLTc2LjcyLTE2Ljg3OC0zOC4zNTkgMTQxLjE2NC04Mi44NTcgMTIuMjc1eiIgZmlsbD0icGFyYW0oZmlsbCkiIG9wYWNpdHk9Ii4xIi8+CjxwYXRoIGQ9Im0xNjUuNzE0IDQyOS42M2w5NS4xMzItMTI3LjM1NCA5Ni42NjcgMTIuMjc1IDg4Ljk5NC02MS4zNzYgMzYuODI1IDE4LjQxMyAxNi44NzkgNjkuMDQ3LTMyLjIyMyA3MC41ODItMTM2LjU2MS03OS43ODgtMzIuMjIzIDM4LjM1OSA2LjEzOCAxMDIuODA1LTY1Ljk3OSAzLjA2OHoiIGZpbGw9InBhcmFtKGZpbGwpIiBvcGFjaXR5PSIuMSIvPgo8cGF0aCBkPSJtNDkwLjQ3NiAyNDYuMzIyYy0xNC4zMjgtMjQuMzEyLTQwLjE4OC01My4wNDQtNTkuNTg2LTY2LjE2My0zMy4xNTQtMjIuNDIyLTkyLjc3NC00NC45MTEtMTMxLjU5OS00OS42NjctMTEuMjgzLS42MTktMjIuMjU5LTEuNzM4LTMzLjI5Mi0yLjA1M2wtOC41NDYtNTAuNTM0LTI3LjEwMiAzLjU4MSA4Ljg5MiA0OC40MzJjLTcuMTUxIDEuMTYtMTQuNDQ2IDMuMDgzLTIxLjk2OCA2LjA3bC0yNy4wMjUtNTQuODYzLTIyLjgxMyAxMC40MDYgMjkuNTUzIDU4LjEwM2MtMi43NzMgMy41MjUtNS44NTYgNy42MzYtOC44MDcgMTAuOTA1LTIwLjE2MyAyMi4zMzktMjMuODcgNTQuMDA4LTkuNDgzIDgwLjc2OSAxNC45NTUgMjcuODE3IDEyLjQ0MiA0Ny4wMDEtNi45MzkgNTIuOTc0LTguMjA4IDIuNTI5LTExLjgyMiAxLjg1Mi0yOS45MzgtNS4yNjgtMTEuMzMyLTQuNDUzLTI0LjY4My04LjA2Mi0yOS42NDgtOC4wMy0xNC4wMjguMDkxLTI3LjU1NCA4LjUzNC0zNC45MTYgMjEuNzI4LTUuNTI2IDkuOTAyLTYuNDc5IDE0LjI5Ni02LjU0IDMxLjQ2NS0uMDc5IDIxLjk1IDIuNTk4IDI5LjY2OCAyMC40NTYgNTkuOTEzIDE4LjE0MSAzMC43MjUgNDQuOTc5IDU4LjMwMyA3NS45MzcgNzguMDA3IDIxLjI4NCAxMy41NDggNjAuNDMzIDI3Ljg3MiA4My43NDggMzAuOTIgMTMuOTQ4IDEuODIzIDMyLjM1MiA0LjQ3IDU3LjYyNyA0LjA2OWwxMC4wNjUgNTQuODI0YzEuMTQ2IDguNzg2IDIwLjc1NCA2LjM1MiAyMC40MTctMS45ODNsLTkuMTA4LTUzLjg1OGMxMS44ODYtLjkyOCAyNS4wMjEtMi41MzIgMzkuNTktNS4wODcgMS44NTQtLjQzMiAzLjcwNy0uOTA1IDUuNTU4LTEuMzk4bDE0LjM2NyAyOC4yNjJjMy42NDcgOC4xIDIwLjE3My43MjEgMTcuMzc1LTcuMTU2bC0xMy4yODYtMjYuOTgzYzM1LjYzLTEzLjIwNiA2OC41MzUtMzUuOTcxIDg3Ljg1Ni01OC4xMjMgMjMuNjEtMjcuMDY5IDI3Ljc1NS0zOS4xMzMgMzMuNjQ1LTY4LjE5NyA3LjE3NC0zNS40MS0yLjY3My04NC4wNDktMjQuNDktMTIxLjA2NXptLTE0OC4zMTItMzUuNzUyYzUuNDM3LTYuMjMyIDEyLjU3My0xNS4zNzEgMTUuODc4LTIwLjMxIDQuNjI5LTYuOTE4IDYuNjY2LTguNTc0IDEyLjkzNS04LjYxMS44OTYtLjAwNSAxLjg1NC4wMjMgMi45NDIuMDczIDEyLjcyNC41ODEgMjQuMTkzIDQuOTYzIDI5LjAzIDExLjA4MiA1LjU0NiA3LjAxMyAxMy42MDggNDIuNDQ3IDExLjk1NCA1Mi41MzgtMS4zMTcgOC4wMzktMTkuMTQyIDMwLjI2Ni0yNC4yNzEgMzAuMjY2LTEuMjAzIDAtMy41NjUuNTA2LTUuMjY5IDEuMTI2LTEuNzA0LjYyMS02Ljc4Ni0uNDk3LTExLjI2NC0yLjQ3LTQuNDc3LTEuOTc0LTEwLjk2Ni0zLjY2Ny0xNC40MjQtMy43NzktMTAuNTgzLS4zNDEtMTcuMzE5LTUuNTU0LTIyLjQ5LTE3LjQwNC03Ljk4NS0xOC4zMDItNi42ODgtMjkuMTM4IDQuOTc5LTQyLjUxMXptLTk2Ljk2MS00OC4xODZsOC44NjggNDguMzA0LTIxLjkxMS00NC40ODFjNC4wMzktMS45MzEgOC40MjktMy4yMzggMTMuMDQzLTMuODIzem0xLjYzNSA4NS4yNWMtMjEuODk2LTEuOTMtMzkuMTA2LTIwLjMzOS0zOS4xMDYtNDIuNzMyIDAtOC4wOCAyLjI0My0xNS42MzYgNi4xMzYtMjIuMDg4em0tNzUuNzY3IDE0Ni42Yy0xMi4xMDkgMTAuMDg0LTE1LjgzMyAxMS44MDktMjUuMzYgMTEuODA5LTExLjQyNiAwLTIwLjQ1Ni02LjI5MS0yMC40NTYtMTQuMjQzIDAtMS45NzgtMi43MTctOS40MzMtNi4wMzEtMTYuNTY3LTUuMjY2LTExLjMzNS01LjY5Ni0xNC4xNTctMy41MjQtMjIuNDU1IDMuMDM2LTExLjU5OCAxMy42OTMtMjMuNzk3IDIwLjg5Mi0yNC4xNjEuMjMyLS4wMTIuNDI5LS4wMTMuNjU0IDAgMi45OTQuMTc3IDEyLjc3Mi42NCAyMS43MjggMS4wMTggOC45NTUuMzc3IDE3LjU5NyAxLjY3MyAxOS4yMiAyLjgzNCAzLjkxNCAyLjc5OSAxNC40OTcgMjYuODQyIDE0LjQ5NyAzMi45NTQtLjAwMiA3LjYyMy02LjMyNCAxNi4wNzMtMjEuNjIgMjguODExem0xMTIuMzQzIDIzLjc5OGMtMi41NTkgNS43NDMtNC42ODMgMTIuMjgxLTQuNzIzIDE0LjUzMy0uMDQxIDIuMjUzLTIuNzQ2IDcuNTc5LTUuOTk1IDExLjgwOS01LjE3NCA2LjczNS03LjkwNiA3LjgyMS0yMS45ODEgOC45NzQtMTMuMzM0IDEuMDkzLTE2LjI4Mi42MTgtMTcuNDc3LTIuOTQyLS43OTItMi4zNi02LjItNy4wMy0xMi4wMjYtMTAuMzU1LTcuMTg5LTQuMTAyLTExLjY0NS04LjgyOC0xMy43Ny0xNC42NDItNi43MzctMTguNDI5LS42MjctNDMuNjg4IDExLjAwOS00NS41NjMgMy4xMDItLjQ5OSA3LjI0LTIuNTQ5IDkuMTkyLTQuNTQxIDEuOTUyLTEuOTkzIDcuOTg0LTQuNDI4IDEzLjM3MS01LjQxNCAyLjAxNS0uMzY5IDMuNzM5LS41NjMgNS40MTQtLjU4MSA1LjAyMy0uMDU0IDkuMjkzIDEuNjU4IDE3LjIyMiA2LjI0OSAxMi40OTEgNy4yMzMgMjQuNDE2IDIxLjE0NiAyNC40MTYgMjguNDQ5LS4wMDIgMS45ODQtMi4wOTQgOC4yODEtNC42NTIgMTQuMDI0em0tMTAuNy0yNDkuODg2YzEyLjQ2MSA3LjUgMjAuOCAyMS4xNTUgMjAuOCAzNi43NTYgMCAxMC40NC0zLjczNyAyMC4wMTMtOS45NCAyNy40NTh6bTEwNi4yNTYgMjcyLjIzMWMtNi41NDkgMS42MDctMTUuNjU4IDQuNjk2LTIwLjI3NCA2LjkwMy0xOC45NjMgOS4wNjgtMzMuNjkuNTQ1LTM2LjY2LTIxLjI1NS01LjEzNi0zNy43MTMtNS4xNDUtMzcuNjA0IDUuMjY5LTQ5LjUyMSA1LjYwOS02LjQyIDkuMTgyLTkuNTc3IDE0LjQ5Ny05Ljg0Ny4yOTMtLjAxNS41NjctLjAzOS44NzItLjAzNiA0LjU2NS4wMzggMTAuNTA1IDIuMDQ5IDE5LjgzOCA1LjcwNCA1Ljc1NyAyLjI1NSAxMy41NjUgNS4wNTQgMTcuNDAzIDYuMjQ5IDUuMzk3IDEuNjgyIDguNDE5IDUuNTAxIDEzLjI2MiAxNi44MjIgMTEuNTM4IDI2Ljk3OCA3LjUzMiAzOS42NDUtMTQuMjA3IDQ0Ljk4MXptMTAwLjM4OC0xMTQuODQ5Yy0yLjA1OSA3LjI5NS00LjI2OCAxNy44NjUtNC45MDUgMjMuNTQ0LTIuNjIgMjMuMzMtMTYuNDI4IDMzLjY4MS0zNC40MDcgMjUuNzI0LTMxLjEwNS0xMy43NjYtMzEuMDMyLTEzLjczMS0zNC44NDQtMzAuMDExLTMuODY0LTE2LjUwOC0yLjQ4OS0yMC4wNjIgMTQuNDI0LTM2Ljk1MSA0LjU4NS00LjU3OCAxMC42NTYtMTAuOTY0IDEzLjQ4LTE0LjE3IDMuMjI2LTMuNjY0IDYuNzE1LTUuMDQ2IDEzLjgwNy00Ljk3OCAxLjYzNi4wMTYgMy40NjIuMTI5IDUuNTIyLjI5MSAyNi4xODMgMi4wNTEgMzMuNzU1IDEyLjMzNiAyNi45MjMgMzYuNTUxeiIgZmlsbD0icGFyYW0oZmlsbCkiIGZpbGwtb3BhY2l0eT0icGFyYW0oZmlsbC1vcGFjaXR5KSIgc3Ryb2tlPSJwYXJhbShvdXRsaW5lKSIgc3Ryb2tlLW9wYWNpdHk9InBhcmFtKG91dGxpbmUtb3BhY2l0eSkiIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkiLz4KPHBhdGggZD0ibTE2Ni41MjQgODguMDE3bDIyLTguNjExYy0yLjMzNy05LjQ0NyAxLjkzOC0xNy43NjItOC41MjEtMjcuMzE0LTE0LjYzMi0xMy4zNjItMjEuMTI0LTE3LjA0MS0yOS45NTktMjQuNTAxLTIuMDYzIDE3Ljg3LTUuNzI3IDQwLjY4IDE2LjQ4IDYwLjQyNnoiIGZpbGw9InBhcmFtKGZpbGwpIiBmaWxsLW9wYWNpdHk9InBhcmFtKGZpbGwtb3BhY2l0eSkiIHN0cm9rZT0icGFyYW0ob3V0bGluZSkiIHN0cm9rZS1vcGFjaXR5PSJwYXJhbShvdXRsaW5lLW9wYWNpdHkpIiBzdHJva2Utd2lkdGg9InBhcmFtKG91dGxpbmUtd2lkdGgpIi8+CjxwYXRoIGQ9Im0yNTYuMjE5IDc1Ljc3Yy42NTUtOS43MTEgNy44MTMtMTYuNDgyLjA2MS0yOC41Ny0xMC44NDQtMTYuOTEtMTYuMzktMjIuMjU2LTIzLjEzNi0zMS44ODQtNy45NzkgMTYuNTQ5LTE5LjIzMiAzNy4zODctMi41OTkgNjIuNTM5eiIgZmlsbD0icGFyYW0oZmlsbCkiIGZpbGwtb3BhY2l0eT0icGFyYW0oZmlsbC1vcGFjaXR5KSIgc3Ryb2tlPSJwYXJhbShvdXRsaW5lKSIgc3Ryb2tlLW9wYWNpdHk9InBhcmFtKG91dGxpbmUtb3BhY2l0eSkiIHN0cm9rZS13aWR0aD0icGFyYW0ob3V0bGluZS13aWR0aCkiLz4KPC9zdmc+Cg=="/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <!--Well known marker fallback-->
              <se:Mark>
                <se:WellKnownName>square</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#dfd2d3</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#dfd2d3</se:SvgParameter>
                  <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>18</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Lloc interès Geoparc</se:Name>
          <se:Description>
            <se:Title>Lloc interès Geoparc</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Lloc interès Geoparc</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Jaciment arqueològic</se:Name>
          <se:Description>
            <se:Title>Jaciment arqueològic</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Jaciment arqueològic</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Mirador</se:Name>
          <se:Description>
            <se:Title>Mirador</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Mirador</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Parapent</se:Name>
          <se:Description>
            <se:Title>Parapent</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Parapent</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Rafting</se:Name>
          <se:Description>
            <se:Title>Rafting</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Rafting</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Telefèric</se:Name>
          <se:Description>
            <se:Title>Telefèric</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Telefèric</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Via Ferrata</se:Name>
          <se:Description>
            <se:Title>Via Ferrata</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Via Ferrata</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Vol en Globus</se:Name>
          <se:Description>
            <se:Title>Vol en Globus</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Vol en Globus</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Zona de bany</se:Name>
          <se:Description>
            <se:Title>Zona de bany</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipus_cat</ogc:PropertyName>
              <ogc:Literal>Zona de bany</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <!--QgsMarkerSymbolLayer RasterMarker not implemented yet-->
          </se:PointSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
