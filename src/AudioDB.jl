# Copyright 2022 XXIV
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
module AudioDB

using HTTP
using JSON

export searchartist, discography, searchartist_byid, searchalbum_byid, searchalbums_byartistid
export searchtracks_byalbumid, searchtrack_byid, searchmusic_videos_byartistid

struct AudioDBException <: Exception
    msg
end

function _getrequest(endpoint::String)
    try
        request = HTTP.request("GET", "https://theaudiodb.com/api/v1/json/2/$endpoint")
        response = String(request.body)
        return response
    catch ex
        if isa(ex, HTTP.ExceptionRequest.StatusError)
            return String(ex.response.body)
        else
            rethrow(ex)
        end
    end
end

"""
* `s` artist name

Return Artist details from artist name
"""
function searchartist(s::String)
    try
        response = _getrequest("search.php?s=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["artists"] == nothing || length(json["artists"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["artists"][1]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

"""
* `s` artist name

Return Discography for an Artist with Album names and year onlye
"""
function discography(s::String)
    try
        response = _getrequest("discography.php?s=$(HTTP.URIs.escapeuri(s))")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["album"] == nothing || length(json["album"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["album"]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

"""
* `i` artist i

Return individual Artist details using known Artist ID
"""
function searchartist_byid(i::Int)
    try
        response = _getrequest("artist.php?i=$i")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["artists"] == nothing || length(json["artists"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["artists"][1]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

"""
* `i` album id

Return individual Album info using known Album ID
"""
function searchalbum_byid(i::Int)
    try
        response = _getrequest("album.php?m=$i")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["album"] == nothing || length(json["album"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["album"][1]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

"""
* `i` artist id

Return All Albums for an Artist using known Artist ID
"""
function searchalbums_byartistid(i::Int)
    try
        response = _getrequest("album.php?i=$i")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["album"] == nothing || length(json["album"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["album"]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

"""
* `i` album id

Return All Tracks for Album from known Album ID
"""
function searchtracks_byalbumid(i::Int)
    try
        response = _getrequest("track.php?m=$i")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["track"] == nothing || length(json["track"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["track"]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

"""
* `i` track id

Return individual track info using a known Track ID
"""
function searchtrack_byid(i::Int)
    try
        response = _getrequest("track.php?h=$i")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["track"] == nothing || length(json["track"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["track"][1]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

"""
* `i` artist id

Return all the Music videos for a known Artist ID
"""
function searchmusic_videos_byartistid(i::Int)
    try
        response = _getrequest("mvid.php?i=$i")
        if length(response) == 0
            throw(AudioDBException("Something went wrong: Empty response"))
        end
        json = JSON.parse(response)
        if json["mvids"] == nothing || length(json["mvids"]) == 0
           throw(AudioDBException("Something went wrong: Empty response"))
        end
        return json["mvids"]
    catch ex
        if isa(ex, AudioDBException)
            rethrow(ex)
        else
            throw(AudioDBException(sprint(showerror, ex)))
        end
    end
end

end # AudioDB