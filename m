Return-Path: <linux-kselftest+bounces-3652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C683E6DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DE12915BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C95F86C;
	Fri, 26 Jan 2024 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJQWuRpw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A025D745;
	Fri, 26 Jan 2024 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311328; cv=fail; b=LvyNe+tdBF9dqDh9JOVFbfm23RI28ANwBPpaphaBic9JRyXE7l/LHTDdlX1cJhYr+vtHKy1HR2NIZRZ8r7t/3e37HmflNsorCbPsLv57kZJIlxfarS1C+O+kAUPZY5q6F7RGflYcqpYxXf830mylJj88I+Pt0a6+WqDLVimGw5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311328; c=relaxed/simple;
	bh=6w9vQANJovGfSY1g5pspGk19De/AhchsCn3gyALZcCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJTmwC3gBtFOsdHxsBS94Kpq8at7OzCLwnPMfn6cBTb2AwSL8JLV1zgHP7Hp69GjnzapVbaDIpxByODEw6khOuEmxjqQnjFo6vstKXFK325xvUlkbDPjLwmZY93XQFMF1DJ4iBg4iBI25ZYVh9z6Vt9Ls00+gm1c7slh2P/GNGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJQWuRpw; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0R/eFFcmGF/9YrafDA+/P6W+gPazKA5iIQlPgPGbx9YH8QqRJfIgh1rKFAjUgbZT2Gw90WUb/tji+9IuHxzdA1bDAQO3Ms7zelWkFSJY78fZngMqK2Zvkmop+wfZNw8rTdebHBSHqfSyvEzWfuHSqzEJfNz2RAReVzZDkG4EqLHOzVGnYN0cTj+DAxj0lqB/7fgDkcVqB2Bs887uo9yN2vEjjSuZ76G9CSxz4eSr3g5fO0CRfVzblkaqrk8uR7B+SDXM/qdW2sX+El3TbmWU9FGK3sr8AVC8a9WV8JdCPqgGTpefaIqvrlyTcTFu7ylHfsbn5e7bPAyi74jApMuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO6+iRKPyLNDF2BG2HxvPrY5vhesrEyp8YGGiu2tc/Y=;
 b=kk2kw+tbEUxStcBMpOciS8zbvWLHyV14VXHjb4pVngm3MVJzNjsuQeqU/Lts7w5COQg8ofWP/f0xWgvIe+sGLimTzLPKnUs2pZtqDNKFS8NLY1meYBWyiuIv8IBG5nS+LsmV1/YLrizN9IT6Pko5ej78uvt7Mp83ke/ac723aiSoJqTj5j4i5t7JiGYgCAdN6g1zjqQLokWGuEe/N+CnLsNgK44Rui7fjAmN3kf/+TwmPjPzb4/HX0KEp28FIBmzPLcFmes5vKjCml7OKXosMW2loYtb8+eifX/DwHzYcU1ywQOsgDflbXf4UpZzkQKqLeLJRwYpT6Sr7U9wNu8+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZO6+iRKPyLNDF2BG2HxvPrY5vhesrEyp8YGGiu2tc/Y=;
 b=VJQWuRpwVu+6J6mGwAqa9wW8SZcOP0mZaME0POn7+0TPVvc9fKKqItuntpkJkAJS5eEjtviPjiiwA9XUi8uoR926eqP7I3yaaAd0nZp+ctffZVr/TrBJqN5XcMwC41NOFo+iD92j+OzdwGWdhuaHMFYRwipKOXF+PO93IAqQIRNI586SPTqguAnLeJsIA6es40ecRhNtMMu5xQX8Anl91JKjdIcA4fZIRsKLeN1/OfH4ALswBkc1r20RzPbYnDWrdo+BBJQk2u0U3tOfoOBS7tcVpOypivAZfJTj/4ZgBKCQUCoQSCDvmrmzr0R/LbIjny2nKy1HGrQeT9/L0n05tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 23:22:02 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:22:02 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 5/6] selftests: forwarding: Redefine relative_path variable
Date: Fri, 26 Jan 2024 18:21:22 -0500
Message-ID: <20240126232123.769784-6-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126232123.769784-1-bpoirier@nvidia.com>
References: <20240126232123.769784-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::24) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9b539f-0aef-45cd-8e58-08dc1ec59a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eHMut48tBqpWOBcFUPbWpLQKfhP6eUK4ux8YlGRP27zAm9bGClTpP5U2Q6n1Lrm4uKuBV/xkbuLJYAtOmK8dWFjBthKAJWshkmVlea+3FHIga7IJkqtqYfNQchnD21VAy/myYopqNbrDaPUZlvrWq2ShjjzPhMvMM2GIfVyhyWLUOOgbc8A+NrnvXHoR2EoD07ytYaCJlVqlvaqGslpcXFg20qoccLDuihyDXcyqov0TvCc3uefHttNgYAii9h/jmK/Bk31/gra/GR2JBrsZqLofkOd4dxYpptH5FlpCFWDrLGecIGBI0AtMe4i9vL93A1yooYzMDxId9fdOeWwajkyrZpSdrf1yYVGQH330S8LQ7UDJGbCH8disl/SVZQIbex/LQ83qxB2vSkZLejUULmRRphr56DHVV4vjVK+9glcwK2PvZ1CtXK3x08MSm3WxJbwrJgxwN8HFSabqqhR7EYqniVq3FwM4tNJ7Jk5VKcvMDVBskmzJecIRe4qeP6O/sROztIzExt8emo994uAus0Yn3nqR58Y3hQZIucNLXsNPWz92qNt/6cr2ogDkMwDa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66556008)(6916009)(66946007)(66476007)(54906003)(316002)(4326008)(8936002)(8676002)(6486002)(478600001)(86362001)(2906002)(36756003)(41300700001)(7416002)(5660300002)(6512007)(26005)(1076003)(83380400001)(38100700002)(2616005)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y+0P2nrk52VrDpGaiNLob1jBYxyddZWarsqOZJw5sx7p75JQph71fpMi6sYc?=
 =?us-ascii?Q?abDmneSG2nFMHnwlG7srVqZThulGKeQXZPJ264F2DGmn6V5CrQ3ZHqF/2V2K?=
 =?us-ascii?Q?kJARd7lqGIFqixv65izXxNTb2p5vrrEGEDSzawHSiI4lY3R7iIeIskyoJ/AN?=
 =?us-ascii?Q?kDN4ipU1RZJi/dDYe43/VKa1NT7lNjL59alzC2W8jzYkO5dwQ0XuSnF+XU8Y?=
 =?us-ascii?Q?wOPQAj2znVxwLB1CETlfURdzIviylWcZPpXJ3XQG9PBFk/6c3EthUiKEYOwK?=
 =?us-ascii?Q?F/p+4e7RFt6iGaZ4RYJpzD2/W5l7wP2hP39ou833EgSWjX/Gv+1qz6eZjzMN?=
 =?us-ascii?Q?Swgj/30dvvHlHmwK5UJ0usGvs9PGfaS0DXcQcV9dcvTZOou/NojLARpjVHZM?=
 =?us-ascii?Q?zEw92AmCdm0Q4dt8yagZaipEFZy5IQLVt7Ld/yI1IwkTlAuNzYAsfTgTmOYa?=
 =?us-ascii?Q?ekTe2DnlFjZNol1fylsSfPwp5aalEj2Ymyq70qiSMBjAye5atNSbZtxF1XfX?=
 =?us-ascii?Q?YBcZCE/rga1iTwMZ0qqgJFUArE5JagpDB5r4/BQLm5uusoRUOEjn73f6FXsQ?=
 =?us-ascii?Q?nsET31LSV8Qpy5RSPc6/o+7qqAMY1acECgxZPDYH5fMVpMzKa+ROLP4vpvXZ?=
 =?us-ascii?Q?zBPEWGeRooi5bYbJRupjOBqbQlRZPW/h8gZvEyac4brnOxPAG1jXsNw4LHas?=
 =?us-ascii?Q?n27yCvpuHS9dcC4mxEeGOFm2bTMINkvQER6HOeFXTNXA1MaXyvCeLFABjefH?=
 =?us-ascii?Q?4wwmrpiyfnrtfYyDt3pjq5rgknyKXj31tZBjnmaOGo/odhq+gqzduUvJgyrZ?=
 =?us-ascii?Q?+SQboO2YPw7jjReZWlUfGkXUCmH5EIEzS6j5H4R3eqMHGZO7Ir9P41KkG9yh?=
 =?us-ascii?Q?GnAL+SldtjMGo2dZqKuQqiFSOFuoHXI9P1rBqPx7fFlbc/P0HvM/bb6jLgLr?=
 =?us-ascii?Q?fR3AMKrKl1W+XBI8PyNoPR4bf4MuWIheSplf/OyTWzE5NB3S3cIOm9qxGqgg?=
 =?us-ascii?Q?cTyg1/45GBO41bMGcd2er7eeBmt7rUadfQdD5zRy2VKHOvt8wPw5E5FCIqgC?=
 =?us-ascii?Q?SejVj6OkKjUONCE/ed5L4FmERid5eQKnAqEJGXzIHK8kHrfuI4HVsAOUuB3q?=
 =?us-ascii?Q?/2Vk+6KG2OlDWzgkTZQ0IEaZrqHMU2sqY3eBU+30AUb61urcCcCbeyF/G+rd?=
 =?us-ascii?Q?6NPIk1TuzaqPcYB6QT3ztW6HURFkHoc/r3CuLbnE4RZmo/MBWyoRU6q4B5PE?=
 =?us-ascii?Q?pF7rSFAo0B96mdzyveJClochH5qTBFiRsWj8m8eFOALsXoH0k9Sl3dd9D/6Q?=
 =?us-ascii?Q?qn54CYCvIxPdrRJqKo90Ih34/MmNILMw0GL+Fo7O6UzxjvxGN0sswcgBwLQd?=
 =?us-ascii?Q?2cs6Ld8tWoZtOBC68MmsbC8acReE1tDXywHBUMms/CZyUmOs/9nNPeLUc8Nl?=
 =?us-ascii?Q?FGOVnQPXmLPSKEwdUHYvJC5mFgxnVrUpd6j5N/EhoEuWXS3X7vnswmn9W+hK?=
 =?us-ascii?Q?eacz02ZZF1N4UQWvD8uD6RSwfeHajwxiPt9JQYZBuxgtHiiJYLYYo7JH3ZJ0?=
 =?us-ascii?Q?nD+e6YuCSTcJyHroDwbpq1yEbXtIgc+hmC12d1Bq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9b539f-0aef-45cd-8e58-08dc1ec59a55
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 23:22:02.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbTJvS4Hg+wmb2Ggo6CHcjbxTcztmjh/0ksZq77e1cWpXYw10ubrh4NDj7U/MKLOUX84cd/54UVkdYboDdJUNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

The following code which is part of lib.sh:
relative_path="${BASH_SOURCE%/*}"
if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
       relative_path="."
fi

reimplements functionality that is part of `dirname`:
$ dirname ""
.

To avoid this duplication, replace "relative_path" by "net_forwarding_dir",
a new variable defined using dirname.

Furthermore, to avoid the potential confusion about what "relative_path" is
about (cwd, test script directory or test library directory), define
"net_forwarding_dir" as the absolute path to net/forwarding/.

Tested-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh            | 9 +++------
 tools/testing/selftests/net/forwarding/mirror_gre_lib.sh | 2 +-
 .../selftests/net/forwarding/mirror_gre_topo_lib.sh      | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8a61464ab6eb..cf0ba4bfe50d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -29,13 +29,10 @@ STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
 TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
 TROUTE6=${TROUTE6:=traceroute6}
 
-relative_path="${BASH_SOURCE%/*}"
-if [[ "$relative_path" == "${BASH_SOURCE}" ]]; then
-	relative_path="."
-fi
+net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
-if [[ -f $relative_path/forwarding.config ]]; then
-	source "$relative_path/forwarding.config"
+if [[ -f $net_forwarding_dir/forwarding.config ]]; then
+	source "$net_forwarding_dir/forwarding.config"
 fi
 
 # Kselftest framework requirement - SKIP code is 4.
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index fac486178ef7..0c36546e131e 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-source "$relative_path/mirror_lib.sh"
+source "$net_forwarding_dir/mirror_lib.sh"
 
 quick_test_span_gre_dir_ips()
 {
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh
index 39c03e2867f4..6e615fffa4ef 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_topo_lib.sh
@@ -33,7 +33,7 @@
 #   |                                                                         |
 #   +-------------------------------------------------------------------------+
 
-source "$relative_path/mirror_topo_lib.sh"
+source "$net_forwarding_dir/mirror_topo_lib.sh"
 
 mirror_gre_topo_h3_create()
 {
-- 
2.43.0


