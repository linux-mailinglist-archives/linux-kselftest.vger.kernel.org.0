Return-Path: <linux-kselftest+bounces-34846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC7AD7C3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3293917EB46
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4FF2DECDA;
	Thu, 12 Jun 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9Ea85lx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7012D660E;
	Thu, 12 Jun 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759241; cv=fail; b=dyhEdAE1E4CevjbgN2u0eN2sT9iftJx6u/YtZY+E/jrnudn5wvb2MZOcxy6NRPsB4nc3u0pvD/d30zjEP7mVGK+ZUo2i7uRKI0n8vmwgzxe/ZkUcG4mER3n/D+TEEkmO4KRZIHNypa/ZCVI0Qm+fGZP760FpFHMAxvbKymb86io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759241; c=relaxed/simple;
	bh=JTS9WTQcG1wHKXqM8xfovsZwhw31X+qo8Bw1s+EnRwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKzqVcdUJRgf20SwXTPJjPwXUU6F1F/Xf/KvGt+/i2RUE0LLgLncjnX3YS9a3VzFCg8DprTJ6mKwd3ftYf3GvFsqpT2luqCBGBuN4e1dH09zh72iRADho7Q1m9wiRm1VfeVfQ/5C9xfPIJeZXTNxWVtddkLT3g+invfX0a2S4I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9Ea85lx; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l20F94NYJklsvo6jehLtt8gINddgzKAX3wDmdr3EXiwkgGuAvRAAKjBWWpf1E5wf5/LT4epJo1P0Oupo5rJdgQKdEVOKME2YNEnhw+YDUyoVqJiTyCt7mbdbAToP7anee8h/OZUpYdlqtZK/1CNpGANwMEQkvOc8nVV8UObmtcyu1hHUBouWygr9LK36CokOwgSQL0XFV0cc2IQwpepVfmBFudivFAWLzAz3Bc1x3kvtjyugpnDb2g4rbz7FPbIV8LOUkGe71R6p8iGisJg1O3miGmYzey40UZ+binu5VhPeSHl7NHQUenul38QLunTT2SKjFk5PklM1Mv44GexPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX8Rv1nZE8jlvxETU2QgUXqb1q1vyzwWaoQiliByBVs=;
 b=j8iGOHILAZZ/PesCWPLfrmYRfFas/HFQd0Luti2d4adqiMXe6yDgFu17Z3Dmcy9l/Q0uYrEJVJjAfahuilb0r2iJqEZK5BH98a6RhVaO4RrZM6L2iRKGLGuSjLvvP66grhEQzcbkCdCvlJ/YtnzHRZyQ4BpKnZwyQ94hrzN72blX36toaysQPPk8BeSpjo52SWTlntfRlLoa8gKBKDRUXgD7sxBCAdLKUrqMxd1sPII/VJfselO0AqJSs4nBFds9bM1SPRw1kmC1+J8vc2UUA289gc5n1qnZ3E2wNhFoXk1u3/OXgbw0osqT5RvE7bxDMNB6WVhyy9Z5i7Yyg3lxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX8Rv1nZE8jlvxETU2QgUXqb1q1vyzwWaoQiliByBVs=;
 b=g9Ea85lx14Zv7ty5H/wLNvTvww2pbu7ra+cFkrfISEHlkOwkSukKLPtZiXNpLXP+waX5oPu15G6moBtM70fdTTrNjU3ctikDVmEUcIUXYQOqgalnvkBb5zyGLbqBqd9VYyzssdgKD8IJOsw8fhkvoQwX7LWGRP8H40Q8nuqMnFAAVwAMdA/VR3aUDoU0EwtzRqn0xcOEiznbiJyM4eAFSTBwpWFl4mxWVD2vK96Gm377BMcJcFirLgvDt5MwT9/APU/mSWeLnVg2MzzikdCTvc57SNiksWZFQ+jm+TmK3GF5oqttMyg48pWEeu2IluVZ7haylSye9aNoJQuUszNnxA==
Received: from CH2PR10CA0007.namprd10.prod.outlook.com (2603:10b6:610:4c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.22; Thu, 12 Jun 2025 20:13:56 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::5a) by CH2PR10CA0007.outlook.office365.com
 (2603:10b6:610:4c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Thu,
 12 Jun 2025 20:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:37 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:31 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 11/14] selftests: forwarding: lib: Move smcrouted helpers here
Date: Thu, 12 Jun 2025 22:10:45 +0200
Message-ID: <237dd6b217bfb1b706fece78b3a3489641ae243c.1749757582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 721328f9-00c0-4bd3-7eb2-08dda9eda8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FCjJWnhxuxKvMuuR5bCa0vlOgbMNNGLk56StKimpuHryQCJPEzeov5Zuq1c2?=
 =?us-ascii?Q?0AiQGOCFVkmdwYxYd63zrJ+tHfcFin7mDjLmBE27LM1nVOuin9jig7emYROF?=
 =?us-ascii?Q?enBPsDrCSEdQu86OLhscp6lGQ4SU3wJks4gZe3TuPEbSQ0JABqPEDSdUB/KQ?=
 =?us-ascii?Q?xYvsZo8iIcBZfgDkFCNCW0JhHRk4DgYKlKu3X2TU8s8o8yfJxFv5tq+COd8c?=
 =?us-ascii?Q?xeHoPHw7trFCaSL35utGD5hKoDepBXt3kBruwnREyI0PqsWhwhIeIlWlAjcj?=
 =?us-ascii?Q?MF01LCPBt2fYCpE/sSYfdhR0jWFLFr1HavidTvjJXcwcNaBP8lbTzHCBvqf6?=
 =?us-ascii?Q?dEUyuLWFiA++JVS2Bfk/nRQqc4yxUS3o1BhOfZVwByiwrP6h/wqUoTn+KPEN?=
 =?us-ascii?Q?2i7YqTWva04lHv6WV30GPW/YA8exZc+Q8blbsT9LfszFPRfzqXwh5vV17QSL?=
 =?us-ascii?Q?C1VPoW8REyS47T77P8fjAdD5uglBnIjF2U/jegTrKsxhQVUpJXv6j9ETw1P5?=
 =?us-ascii?Q?ldAyYj4LUTsg+l2LC1F5ABfBZwMPQK9CDk/9YPBGiFzQkpRuU9BnSdokwgiw?=
 =?us-ascii?Q?gJc6mmlgLhdLlfxAr7fDtBd0V4O/Hj0GUK7WmIwsotmPdZPO4qQzipP/1tsE?=
 =?us-ascii?Q?ltcuLMWHbH2VEWCvevKfsYXtOZdUtLd62oEfME0MIoitprDG6x+hvDJdUAHk?=
 =?us-ascii?Q?tH1TexNTfsKLm+JSgVdoozz4fIApKI32dmJSSQxfFUqiXEJhin7mde54wI0s?=
 =?us-ascii?Q?Kr4m7Xq+2XJ7uOWeluieNg3in3cq+KBwxom4SewpdUfg/25jiazaqPkOnhy5?=
 =?us-ascii?Q?iPDozAA1g8o/Q4y099mjQWF6ljyScUNv8/Uq3u1U9ZdEdr0OAN6BwtK6cwVi?=
 =?us-ascii?Q?fd0ZQaRqMDSEU9hMnRjzLiOxL3DRdI8R/xLTLedxULrhfuTu9pnoEkyKo265?=
 =?us-ascii?Q?eW+c0d95GiHS02eNb9DxcbaHJtgI/k9feti2rTlmrVeaAuQGq/2KfLHuBjQS?=
 =?us-ascii?Q?vfEWWaIVMyAyGQIiwNO1wZnlKvfTtSqyio95+7CfWpodKEJjMSwe5WUKSak1?=
 =?us-ascii?Q?sOd+YKZLdxsS68MDBEKHzgD3+uO8v6R5KX9fMEkHsF9cm/G0NRCoaIRJs4es?=
 =?us-ascii?Q?js/z+6UsfFKBtPdHO1dWlSW3yNY+jzBOj5RSlEHt08jwiQd1Zzc7EAuqcuWc?=
 =?us-ascii?Q?cbQp0sLW6aAe1yLvxXcwAwEGvHZQt6yR6y0XU13BeiUWmTb6uAZNbdgw8PBJ?=
 =?us-ascii?Q?HIjp+5kduVmuygPtvyhEMUKcI6bZDGIoCgFcBp1NyFv4MA+Fl2W+r4Tte4nB?=
 =?us-ascii?Q?Asj2EVFI3/RDuR6Py9dA7qmiN8v30k2FwpALCuw+3iTc32kxUS5Z42t0VU1h?=
 =?us-ascii?Q?lrZ5yBQHWww4y/r1+xSWJdsYqWKXJySQqscWoMOunj2hgHVSrYkWM7KTPXfJ?=
 =?us-ascii?Q?H92Grvg+CAMY4k7BD74fJrSfq2kmdl5E0ELVpntPOssMwo5MbSabHmoouAqn?=
 =?us-ascii?Q?PxF6bDDFhYeKuh907Hv4OaeUOhhMh1fYtxQc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:55.7935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721328f9-00c0-4bd3-7eb2-08dda9eda8b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

router_multicast.sh has several helpers for work with smcrouted. Extract
them to lib.sh so that other selftests can use them as well. Convert the
helpers to defer in the process, because that simplifies the interface
quite a bit. Therefore have router_multicast.sh invoke
defer_scopes_cleanup() in its cleanup() function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Adjust as per shellcheck citations
    
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh | 33 +++++++++++++++++
 .../net/forwarding/router_multicast.sh        | 35 ++++---------------
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 508f3c700d71..253847372062 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -37,6 +37,7 @@ declare -A NETIFS=(
 : "${TEAMD:=teamd}"
 : "${MCD:=smcrouted}"
 : "${MC_CLI:=smcroutectl}"
+: "${MCD_TABLE_NAME:=selftests}"
 
 # Constants for netdevice bring-up:
 # Default time in seconds to wait for an interface to come up before giving up
@@ -1757,6 +1758,38 @@ mc_send()
 		msend -g $groups -I $if_name -c 1 > /dev/null 2>&1
 }
 
+adf_mcd_start()
+{
+	local table_name="$MCD_TABLE_NAME"
+	local smcroutedir
+	local pid
+	local i
+
+	check_command "$MCD" || return 1
+	check_command "$MC_CLI" || return 1
+
+	smcroutedir=$(mktemp -d)
+	defer rm -rf "$smcroutedir"
+
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		echo "phyint ${NETIFS[p$i]} enable" >> \
+			"$smcroutedir/$table_name.conf"
+	done
+
+	"$MCD" -N -I "$table_name" -f "$smcroutedir/$table_name.conf" \
+		-P "$smcroutedir/$table_name.pid"
+	busywait "$BUSYWAIT_TIMEOUT" test -e "$smcroutedir/$table_name.pid"
+	pid=$(cat "$smcroutedir/$table_name.pid")
+	defer kill_process "$pid"
+}
+
+mc_cli()
+{
+	local table_name="$MCD_TABLE_NAME"
+
+        "$MC_CLI" -I "$table_name" "$@"
+}
+
 start_ip_monitor()
 {
 	local mtype=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_multicast.sh b/tools/testing/selftests/net/forwarding/router_multicast.sh
index 5a58b1ec8aef..83e52abdbc2e 100755
--- a/tools/testing/selftests/net/forwarding/router_multicast.sh
+++ b/tools/testing/selftests/net/forwarding/router_multicast.sh
@@ -33,10 +33,6 @@ NUM_NETIFS=6
 source lib.sh
 source tc_common.sh
 
-require_command $MCD
-require_command $MC_CLI
-table_name=selftests
-
 h1_create()
 {
 	simple_if_init $h1 198.51.100.2/28 2001:db8:1::2/64
@@ -149,25 +145,6 @@ router_destroy()
 	ip link set dev $rp1 down
 }
 
-start_mcd()
-{
-	SMCROUTEDIR="$(mktemp -d)"
-
-	for ((i = 1; i <= $NUM_NETIFS; ++i)); do
-		echo "phyint ${NETIFS[p$i]} enable" >> \
-			$SMCROUTEDIR/$table_name.conf
-	done
-
-	$MCD -N -I $table_name -f $SMCROUTEDIR/$table_name.conf \
-		-P $SMCROUTEDIR/$table_name.pid
-}
-
-kill_mcd()
-{
-	pkill $MCD
-	rm -rf $SMCROUTEDIR
-}
-
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
@@ -179,7 +156,7 @@ setup_prepare()
 	rp3=${NETIFS[p5]}
 	h3=${NETIFS[p6]}
 
-	start_mcd
+	adf_mcd_start || exit "$EXIT_STATUS"
 
 	vrf_prepare
 
@@ -206,7 +183,7 @@ cleanup()
 
 	vrf_cleanup
 
-	kill_mcd
+	defer_scopes_cleanup
 }
 
 create_mcast_sg()
@@ -214,9 +191,9 @@ create_mcast_sg()
 	local if_name=$1; shift
 	local s_addr=$1; shift
 	local mcast=$1; shift
-	local dest_ifs=${@}
+	local dest_ifs=("${@}")
 
-	$MC_CLI -I $table_name add $if_name $s_addr $mcast $dest_ifs
+	mc_cli add "$if_name" "$s_addr" "$mcast" "${dest_ifs[@]}"
 }
 
 delete_mcast_sg()
@@ -224,9 +201,9 @@ delete_mcast_sg()
 	local if_name=$1; shift
 	local s_addr=$1; shift
 	local mcast=$1; shift
-	local dest_ifs=${@}
+	local dest_ifs=("${@}")
 
-        $MC_CLI -I $table_name remove $if_name $s_addr $mcast $dest_ifs
+        mc_cli remove "$if_name" "$s_addr" "$mcast" "${dest_ifs[@]}"
 }
 
 mcast_v4()
-- 
2.49.0


