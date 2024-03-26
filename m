Return-Path: <linux-kselftest+bounces-6639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3DB88C9F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E99E1C6331A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E713D503;
	Tue, 26 Mar 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJpay9RO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5B13D500;
	Tue, 26 Mar 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472434; cv=fail; b=pejeKD//E6HjTU4QYDeOWsHhLygisAgs5W8mSmAd7L1PnXkK0LXaZnMVMZtIigUTX45N+dkW0wUkjTRq793n/ZOgfZyAl4Xm4dHRAmywaBkjqdTcXMWOHVbvvNP5EuJaUBoEnqF59uxwZ+V+ugpn+hQrYXcbWRQBnmdJyddor5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472434; c=relaxed/simple;
	bh=8v9FNUijUG7xwsUH31jckIZPoH1RDSaL9/RZEHgFc58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yh2byJtObTLwBZsVxuLgl2OpBy+geGQXq7Hhrhf1HkneoWU0SpOpdnEMlH8QbwFfCER1kWeQNAn3hdwiS4DDgw+zZj9CsbJgMOu6iU22+wovo1w/oRGwcfDj+5ofS7Nppv3MrEKfVR7OQgMYooJ96t2wD+8FQF5PGyQYIm+BuWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJpay9RO; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcYUQlDWQagC0C71VxJEDg8CyO6dwTejub2/1jZFu/yfmEE6MPRhKPLYWotVpnh+Lojk2nfKWu47aDOg0vtcZci6NSxUjHUzXM+fICYizjYnBuuRksWZplbK6thpPQ6WTfyNaLXJILKqR6CPv0uFwFxC1YMfTX2g6d1e1UImewsPrpOqbpcxIKIkX/ILyTpBYpXyhxctFu6qaT+2u65xNJTFIAOoqevCHyDgYCSQoAIi7yK3Z9KdcMkqhgRIY9FPzDHvWScNy1e1mFTegWbS3nBuKrTmtEfDzttTYQyjpwV1SVQvsN8TPteg553GL79m1xyHIxcyf/5wVgIGoFVFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oevsx6VRQR1iRkez0iT6MBubXdmcpIs/siOpkqu1w+c=;
 b=mrIbKZz49+Pi73INbFWuQZgoMqJ7pLG7xETyjVD3XW2PwhS9UZeXHmGqsNWiCzffsBrk+vldZDMeGroMnOdoJtZkVewxftuGpCT+eJDe5f6GkplgNspJ18TaHnJi1Wm4UJKXKfz+hXZTRH0TtBwxLybws7rsNRMlpndB3PvL9I8vaGY9rhL5D87K/XS+bFlGKXuVAea2e+eCanIW53gmv+NuJ3Z0cm8Yr6H9S4+59DnXeNaYwooOWwOlGHQhLvWJDm9PJ2T1r8mes09e6hv6s5l3bZkFtrDHH1lgRQCwChI/XOtXkHam/ng2STEgpKlNQoKwAZikN3aJ8v/Fje6PuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oevsx6VRQR1iRkez0iT6MBubXdmcpIs/siOpkqu1w+c=;
 b=lJpay9RO6epM8t09ZmaiyrWV7BH4efBQekE2rYm6F4E3MAV0EqUIHygE/ID0KtogKA8PtHpq1kzOU2Kk4zChiW1Ku9Bxneuhr76qA5pgR3HRXul30q++3aW6O72ZDi/RDM+HTnPwL+/zbwvMgzBZ7+Z8F828yomXnxGlXIW9mhWa42IUmo9TbBP66/sVciugxNe+iMEpdKcOz1LHKeD4zMEkuUZ4ODE2yvjnmu3j8glaaMDRuerxolJHWmN2UIwr7guq4GHtTw/au1xwzylqKcDe/pKm5YeAa6s5ifa6EvAHi+4jXONeJxAAVcMXx9VHJvEQAhpDDsv7V/f23p3XsA==
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 17:00:25 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::34) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:00:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:09 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 01/14] selftests: net: libs: Change variable fallback syntax
Date: Tue, 26 Mar 2024 17:54:28 +0100
Message-ID: <1890ddc58420c2c0d5ba3154c87ecc6d9faf6947.1711464583.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711464583.git.petrm@nvidia.com>
References: <cover.1711464583.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: fa61be54-bcb7-4ec9-82cb-08dc4db63ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/+LlmOMBSgq4QQcxw13GRxbuB4eueXZif0weEUMl3qHljOpMA6cP9mACegAbZuRElPa3DOOiWgMpIIbhMQVzCouzmrRjK0OP4qd9qLFRpuuQ+xwMC4oqT297VKn19snjna3u4j5qSmbaQjEqTN4IpYiU3DCCw2SYq3Ik69apPncrfUp/L4JSHlwAKdOvWmNIsUOkJUebKLs92ac7Apq0G60Guxncf6LzqlRMHCu4u+qKUraFlG0Cy1njKiCWvWFiK85w7bA+OsN4AZGmyG/jVemaQSUnFmx9tfwmBeO6Z76ZabOJCSak9sABrVD4X6OJHkFMN4h5Pqzm0XKbaUvQXYGR462o1/V+djIHJCwPT8RN8N0DDS8hH5ZosJ5HWITJIZZ8p3z5G2cdTO9gAe3su/hLvLPuBN1qn28Tk60Mx2k5SwtfFOtEqb2v2aXw3Apiz5AEInjTa1T10C2CH2P+SV8v9J7nWFEnoF1AvgmlIb6cJ3pXkgeBbQRAEuMgAfhjOtYeDEL40QXz+bhuJ6XsGfqIxHwHvrFUuz1b7qxDkQldfTsADTObWM+X9rP9PZw9E37x0+IJs7+lQt1JxS2CatDL9F/uIn4LeufdtNeeq1ZTXV4RIzh78ByRF3dpC/lV4CYE6O1YQbgIwV5asT/ovK+FDAIUhunuKK0aElbmHWaM+8zPFOjrIW+mTanB73Dj7c8Py2FO2M+q6yy1lWm0D4N/Qh286Ovrp9fXo6NT7UzaU+0xhQIgUSWHtl7mkghB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:00:24.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa61be54-bcb7-4ec9-82cb-08dc4db63ab2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

The current syntax of X=${X:=X} first evaluates the ${X:=Y} expression,
which either uses the existing value of $X if there is one, or uses the
value of "Y" as a fallback, and assigns it to X. The expression is then
replaced with the now-current value of $X. Assigning that value to X once
more is meaningless.

So avoid the outer X=... bit, and instead express the same idea though the
do-nothing ":" built-in as : "${X:=Y}". This also cleans up the block
nicely and makes it more readable.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 48 +++++++++----------
 .../selftests/net/forwarding/tc_common.sh     |  2 +-
 tools/testing/selftests/net/lib.sh            |  3 +-
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index e579c2e0c462..ee48c4603ff0 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -5,30 +5,30 @@
 # Defines
 
 # Can be overridden by the configuration file.
-PING=${PING:=ping}
-PING6=${PING6:=ping6}
-MZ=${MZ:=mausezahn}
-MZ_DELAY=${MZ_DELAY:=0}
-ARPING=${ARPING:=arping}
-TEAMD=${TEAMD:=teamd}
-WAIT_TIME=${WAIT_TIME:=5}
-PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
-PAUSE_ON_CLEANUP=${PAUSE_ON_CLEANUP:=no}
-NETIF_TYPE=${NETIF_TYPE:=veth}
-NETIF_CREATE=${NETIF_CREATE:=yes}
-MCD=${MCD:=smcrouted}
-MC_CLI=${MC_CLI:=smcroutectl}
-PING_COUNT=${PING_COUNT:=10}
-PING_TIMEOUT=${PING_TIMEOUT:=5}
-WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
-INTERFACE_TIMEOUT=${INTERFACE_TIMEOUT:=600}
-LOW_AGEING_TIME=${LOW_AGEING_TIME:=1000}
-REQUIRE_JQ=${REQUIRE_JQ:=yes}
-REQUIRE_MZ=${REQUIRE_MZ:=yes}
-REQUIRE_MTOOLS=${REQUIRE_MTOOLS:=no}
-STABLE_MAC_ADDRS=${STABLE_MAC_ADDRS:=no}
-TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}
-TROUTE6=${TROUTE6:=traceroute6}
+: "${PING:=ping}"
+: "${PING6:=ping6}"
+: "${MZ:=mausezahn}"
+: "${MZ_DELAY:=0}"
+: "${ARPING:=arping}"
+: "${TEAMD:=teamd}"
+: "${WAIT_TIME:=5}"
+: "${PAUSE_ON_FAIL:=no}"
+: "${PAUSE_ON_CLEANUP:=no}"
+: "${NETIF_TYPE:=veth}"
+: "${NETIF_CREATE:=yes}"
+: "${MCD:=smcrouted}"
+: "${MC_CLI:=smcroutectl}"
+: "${PING_COUNT:=10}"
+: "${PING_TIMEOUT:=5}"
+: "${WAIT_TIMEOUT:=20}"
+: "${INTERFACE_TIMEOUT:=600}"
+: "${LOW_AGEING_TIME:=1000}"
+: "${REQUIRE_JQ:=yes}"
+: "${REQUIRE_MZ:=yes}"
+: "${REQUIRE_MTOOLS:=no}"
+: "${STABLE_MAC_ADDRS:=no}"
+: "${TCPDUMP_EXTRA_FLAGS:=}"
+: "${TROUTE6:=traceroute6}"
 
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
diff --git a/tools/testing/selftests/net/forwarding/tc_common.sh b/tools/testing/selftests/net/forwarding/tc_common.sh
index bce8bb8d2b6f..2e3326edfa9a 100644
--- a/tools/testing/selftests/net/forwarding/tc_common.sh
+++ b/tools/testing/selftests/net/forwarding/tc_common.sh
@@ -4,7 +4,7 @@
 CHECK_TC="yes"
 
 # Can be overridden by the configuration file. See lib.sh
-TC_HIT_TIMEOUT=${TC_HIT_TIMEOUT:=1000} # ms
+: "${TC_HIT_TIMEOUT:=1000}" # ms
 
 tc_check_packets()
 {
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index f9fe182dfbd4..5b366cc4fc43 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -4,7 +4,8 @@
 ##############################################################################
 # Defines
 
-WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
+: "${WAIT_TIMEOUT:=20}"
+
 BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
 
 # Kselftest framework requirement - SKIP code is 4.
-- 
2.43.0


