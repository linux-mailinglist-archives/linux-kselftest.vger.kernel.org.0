Return-Path: <linux-kselftest+bounces-16063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3095B7AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECAE1C23D2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021E1CDFCE;
	Thu, 22 Aug 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rjrxwmG5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859261CDFB8;
	Thu, 22 Aug 2024 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334745; cv=fail; b=SI4Rc8y8/H1BtOEAuIU7mOU87XtauKAKKQ4oLOEI01Ey64slMhT98U41YcoiC8flxN35+eCFi1c68nn3d9BetSVQUXmnJ5UDcQwi5A/gGLaS1JgsV1pUogRPkV/tP5NupwQEh1eivYHQgqzvudhil5Wipmc143p1Vux0SjmO98A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334745; c=relaxed/simple;
	bh=6MUtMYHgYF7sLzXxK0ECWht9de2P0ZQp47bfZKISJVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfAMrh16AVUZPol8OcJZ9KGzz4ZnTpQuGosX4E8EXWKrcmDn64IgUIlbS8Mfqog6QEo8r3ojcpy8B2fWOmNpNwPfRtRPu2Wro2Oev4RKqPHVWzA6iKsUjaJrzIlpMocP4pxx/Zw9L8mQ463uQTKLaD6MSXYSRpHEFbrvF4eqgd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rjrxwmG5; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv0aBMuQRlHQt6QfnCGAm7Z7g4LzKzTwtPQMooF9M/val8NhKILPWSZ2EvjeB4fhhKRg5Sf3ttEJI39z5y5InKhZBIwsdwNRmhkHCz8N0e3cePqMKEsIMKqTkMwfjr2CEH3KGThAX81hFcRzZjc+oQeOe7b55fa7gTsU0W0sdpZiDzVR32HtmjsWxyNxnXZWecxolSJ1zcy3hEmNWJS+7SvvDLwdLo4RdzKAZPTwzHNgcy7VCUadmJEN5LJFs/gOoh1Mm6Yxfgb/Ci5jaubU3DjmOKC1VVtvBJFKauhW0j9ddgGcVxDCkmfm05NEHfzmj99kc/3A5PISQR8mGkooMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPyylWHiVNB1QLLjaS6PtIsSWzJw/Q0qu8oTlzRpg6E=;
 b=kxU4Gt0zHF8wW3gglC5H4c4WudX9GODWmCiWb1bJD0H7bwP7lbF6ktqdHXZ1a2BRaGwSe3uxhEluKD7J+SY6SjhdSnQHZaxXb84DWdfIyHv49UebgBA/sQJkSK+JYY6ZmO2lG07QcMKBnoIMbIgNv5NFP8+uX8CKKrbuSPL/zJFXRDoIMk+bKPnwvry4gt9lT9fk1xBNjEum/GF1LFCfBFMHlm3u+q05QeJI8AlC8Ku28lcwYiJvdzLKZ0BA9XSENnB1mOJYkDPreCTQbVOUIqb7ZfKnBbDdm6dCOLxUqYZZYkPp4zUK1pOeDRxD03nD1cZ+omr4WtiyyHG2ostkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPyylWHiVNB1QLLjaS6PtIsSWzJw/Q0qu8oTlzRpg6E=;
 b=rjrxwmG5xIYGwmOE4bL82CLAHXQu0WYOaslK8lb4DATEnvhmhahgxcg27Gx8fy+ZvdFEyOMvAsGjZGxT0QF743Dbpg0xcKqtzNPv0ZEqXNRJ/SV615BxQtqdD28s185lL4cTZwY5HR3Qja1AbFeoQM7BFEBSkYU6P0fnpK1gopOiU+RHrqG9CeFYZpdRHg0Mota+P0RnWS5UWq4QbImSJBWUvU+GaS8meJ5qnQtoAwzO5mRJVxYDqp3MAit+Er/T7V4ZOgm+ONTDN6Z3awAoj8CfUyOW8ajVnCgMsL8MDJVuGyUe2F+nAxpzpnI47Wh+nhn3ub8/KeB71ib1gxccZQ==
Received: from CYZPR14CA0003.namprd14.prod.outlook.com (2603:10b6:930:8f::16)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 13:52:20 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::33) by CYZPR14CA0003.outlook.office365.com
 (2603:10b6:930:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 13:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:52:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:08 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin
 Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: [RFC PATCH net-next 0/5] selftests: forwarding: Introduce deferred commands
Date: Thu, 22 Aug 2024 15:49:39 +0200
Message-ID: <cover.1724324945.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: b991bb46-f2af-4787-ed73-08dcc2b1a42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sc1bxC22W+PJDCEFbBycCSE8ZJHzNwPQCJ8KTjpBbNK9wXvbHL4VmYxXOKTc?=
 =?us-ascii?Q?ZY/ayj+WwqDNM+K5VBhQqlWpLOuzfqOMJTqa37SUH8v8+n+6ed5OZnQ0sEIC?=
 =?us-ascii?Q?TUd7oBqYxuZZwe0xX77vWACK+DcxmQOVhtfUMLHqIPXr/oCuiOOTKvtF024M?=
 =?us-ascii?Q?jRqDgA3XQZnMGZMkw2DdreivLVw2/aiMo6OAEy3g2Hlyi3FN3L+R1ymm5I6i?=
 =?us-ascii?Q?0igvG/F6xYuLWfJANHK0NmTG0tRQhnqdI3smoqgduPLrWcACKojXj0dYLJiD?=
 =?us-ascii?Q?nL7FvJwKNpWnKYf0Y6+ajA9nD0jQholHm5phiEwnF71+Xra68pgb4KnMJVtm?=
 =?us-ascii?Q?Qu+Yzjej3+kaFzMKB0j95M1KwpGDOkHrLc7/zHQx+4t+j54r2P7GDAWXMUiW?=
 =?us-ascii?Q?qEnaKP8+qlmSm21pHx2aSPUQtLZ09srSLtgBevVuBuNmlAgysaqoRcZ5AqlS?=
 =?us-ascii?Q?TftLYvhxQcRQ/Y1LxZsxNh3AWEHoBffT9kxrHDC29C7QfIKma2668Hv7QwfF?=
 =?us-ascii?Q?bbwqbOXbDl3S8igjxN6x65UNOc3RFVm0MR5FLIvENrFDgV6DXzYqqbVYgbfG?=
 =?us-ascii?Q?7wn1tW0CJJAT+qacVqdyVCpbo5VWTIWpNbgbmZwxwQzIR0ndKdm/yp2sj+2M?=
 =?us-ascii?Q?fJBQZW95aCp6paQ4R0TfJkTq0iwKfO7N8ASNl4UY8MNbi5pPib9gXEZY8Wv5?=
 =?us-ascii?Q?TwQypJcBJ8zWNji3uf4sspy/m86332UHV8NQ4CFTmf13+n7sdXcDCl743bt1?=
 =?us-ascii?Q?UBD6emYu+1z9KgCd4vYeEf319Ms0d6rmZUo9hynXbrdhU3kp7Bg3UWY52tYW?=
 =?us-ascii?Q?00LpyLwrSFyLIJRW1yzyomZ1OPJMdLfajXYropTGMqEr0IFZyghk5ScSaE4q?=
 =?us-ascii?Q?+czlmegrGin3ujOrSmY+x3kBYO8U5O5iXrwAwjjNB9vZll2RzGJXBu0fWTN3?=
 =?us-ascii?Q?7xx2RsoNeBYZc3Fmk7sAiaQRQWqcfdo9WiOfL9RpGESVbfRInvo9d0l/7zbo?=
 =?us-ascii?Q?7WYM8Ll1dS1nZqRpKWPpv40hZBxnJJiGoFUhEGB+t4W35u9+03KQXe3vNfmp?=
 =?us-ascii?Q?AwkRq9MoNwdZOJPmMJTh8BEKZCeqMjz3Gzfbj9LcHOpFQvBEnV3jWuFZqUhi?=
 =?us-ascii?Q?XOUgTLjh0pJqZ5ttUD8G3VxlXmlN7iYy+R4Od7PtdpKp0O5437eaavtmKO1t?=
 =?us-ascii?Q?UK0cj8PgUgUja5CiT+Eg5OlSofIFGYfc9tJahMOGKCCSxgC+Tsz83/m3n7x/?=
 =?us-ascii?Q?PnwCc6LAqjqGIlPz9vgNk1PDqzfUI13kdLJ8+j60Qzr5kvK7oObUFnusywQM?=
 =?us-ascii?Q?x2zasO3dGwJffnAtmxCtq8MzIHe9y5BbamvD0Tz5syTHZDyWcugAvZ17e3RS?=
 =?us-ascii?Q?ZhTxNKrA9az08qm/Ynm4hto2Ews63MO+2+yhi+BPpcvx8NCa530P+P+Wla4Z?=
 =?us-ascii?Q?n0234VCHT3pBHcFZOImkOXw0XSYjvvK/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:52:19.8278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b991bb46-f2af-4787-ed73-08dcc2b1a42f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381

Recently, a defer helper was added to Python selftests. The idea is to keep
cleanup commands close to their dirtying counterparts, thereby making it
more transparent what is cleaning up what, making it harder to miss a
cleanup, and make the whole cleanup business exception safe. All these
benefits are applicable to bash as well, exception safety can be
interpreted in terms of safety vs. a SIGINT.

This patchset therefore introduces a framework of several helpers that
serve to schedule cleanups in bash selftests.


As a personal remark. More than once was I bit by stop_traffic not getting
invoked because I C-c'd a traffic scheduler selftest at the wrong time.
This would leave behind a running mausezahn that would break follow-up runs
of the script that I was just debugging, making me question my sanity.
("How did this one extra debug print break the full script? And when I
remove it again, _why is it still broken_?") This is an attempt at
squashing this whole class of problems.


Patch #1 has more details about the primitives being introduced.

Patches #2 to #5 the convert several selftests to give an idea of how it
looks in practice.

Petr Machata (5):
  selftests: forwarding: Introduce deferred commands
  selftests: mlxsw: sch_red_core: Use defer for test cleanup
  selftests: mlxsw: sch_red_core: Use defer for stopping traffic
  selftests: mlxsw: sch_red_*: Use defer for qdisc management
  selftests: sch_tbf_core: Use defer for stopping traffic

 .../drivers/net/mlxsw/sch_red_core.sh         | 131 +++++++-----------
 .../drivers/net/mlxsw/sch_red_ets.sh          |  32 ++---
 .../drivers/net/mlxsw/sch_red_root.sh         |  24 +++-
 tools/testing/selftests/net/forwarding/lib.sh |  83 +++++++++++
 .../selftests/net/forwarding/sch_tbf_core.sh  |   3 +-
 5 files changed, 170 insertions(+), 103 deletions(-)

-- 
2.45.0


