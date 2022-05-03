local t = ...

-- Filter the testcase XML with the VCS ID.
t:filterVcsId('../..', '../../artifact.xml', 'artifact.xml')

return true
