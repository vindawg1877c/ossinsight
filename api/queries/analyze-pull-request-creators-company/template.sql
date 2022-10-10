WITH pr_creator_companies AS (
    SELECT
        TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(gu.organization), ',', ''), '-', ''), '@', ''), 'www.', ''), 'inc', ''), '.com', ''), '.cn', ''), '.', '')) AS company_name,
        COUNT(DISTINCT ge.actor_login) AS code_contributors
    FROM github_events ge
    LEFT JOIN github_users gu ON ge.actor_login = gu.login
    WHERE
        ge.repo_id in (41986369)
        AND ge.type = 'PullRequestEvent'
        AND ge.action = 'opened'
    GROUP BY 1
), summary AS (
    SELECT COUNT(*) AS total FROM pr_creator_companies
)
SELECT
    company_name,
    code_contributors,
    code_contributors / summary.total AS proportion
FROM pr_creator_companies, summary
WHERE
    LENGTH(company_name) != 0
    AND company_name NOT IN ('-', 'none', 'no', 'home', 'n/a', 'null', 'unknown')
ORDER BY code_contributors DESC
LIMIT 9999999999;