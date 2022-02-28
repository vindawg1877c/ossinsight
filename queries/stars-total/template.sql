select count(distinct actor_id) as total
from github_events_old
use index(index_github_events_on_repo_name)
where repo_name = 'pingcap/tidb' and type = 'WatchEvent';
