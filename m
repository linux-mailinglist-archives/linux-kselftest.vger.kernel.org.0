Return-Path: <linux-kselftest+bounces-20398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9109AB178
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540BB1F23F54
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D24C1A0BF3;
	Tue, 22 Oct 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dp8ddWAp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6E1A0BE0;
	Tue, 22 Oct 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608738; cv=fail; b=AopMYLwR+vdrEozMw/yDtBZ3R/hGb79g+XkbC04pacYCwslcwFijqCXxlwfQTrGKJHXTlWpbY5hFWR8EoWVfjNnmBrdQBplFPOmSB0nRiSmw4uat0uK3tEowPuszagToWkn/YAepzODODY9yVPbB7iCpJhttS9CJGa3E1BksYZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608738; c=relaxed/simple;
	bh=lZQvmwDNeH5pMg0XXLgJCG73AbB+ZHDBicthcAv/nLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eP5FlLJNIdEeibaKD3JfM5MoEsugeWOL9FaL0EWtS7TvC2Z6pOffYIrj7FiWk7XILoVJ2KVPv1WlWZy6K5XBgpruMGbPQjYreSaxpmYrJ1Tp4PZmoQXYvdJAqh0d1/hd/JcyqERNDGO/GrqC6/9Zv1ZTzy1HRzxS2XNNoq5PUR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dp8ddWAp; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCddP0QOnh3B96x7/ORX/BY6D70YdKX/AXP4l6nhSsOIFhg+NMx/Ye+vLVZ4DGzxZ7ZtVtdxBx9CB8+wrY0DwJbB+s6+joX6sv9TC4luv3suwrIIeOW9Gzm8jrpzyEV71zAlJkYUzvhEPReO517ZJ+m46RgLZdfkJnfJJxFCOsoOJXU6XwZyHBmNwXH4sVrZQ4I9dj17aIpJpQUoYuJa/D5IP//mvsEqBlDbmARFNV2xGXPIQyoAZ7JR3YTRMEyViMzH2ZNxuA4Ks3KsBA6rwuoK6eeFP7tSZFjP5czWom/QpMx645RNf/SJ9w1qfoGfSu93fQwB022JPUQTGBERGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdTsgNe6H3Wuwwt715kdN/GAzD2TfTrGDPddrZWV6a0=;
 b=NRYy7h8swxBbgs+oLWi1ERJ4Tlu7zXwJmeT1PaQha8SSwiX+W/OBghf0c93ihiigSLaGGOeEsreQbt9A10WbRCLJOHTOvFCNQ0DtY4B7vgPsx8wCc4C4e/1+bZxFYU/ytFf6Po80VzgYpf+GtHPSCQ+omNg+9DNYaAVxyXNk4yxHwOoSVzdIYU+JNFPl0xCzt16uEl33gW1Fie0uvDQhBPDL5Y0eUvd/c4NI0cjGSHwAlwkkBrJDuTbgtyoScYgIXGfx+V5KZZCqP1xkOqlKS7xTb/UX6we0TGrTJ4EJBv85L0SCvl7f9pOrr1u8jQInohjAEBF4FIY0Ra0UrCA4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdTsgNe6H3Wuwwt715kdN/GAzD2TfTrGDPddrZWV6a0=;
 b=dp8ddWApkfz+eCzh8Baxb+i877jdcGMT/OHRcKnz4Kyi4WhmQdXS9fwzExM/S0Wxn4R7aSPqFek0N3xjA9mibKL7wzinwFub52/hDPSRazuSSkU3MzXut+34XnSiB6XVdKbiLe4438SqEXrN9P6LvBhPbCLUa1sYfdngbWajVmx8/Lu0cZkXE02rU46EjsuU+eZZLAwZNZEZ85YYDWbFQuHn0mcV8WOmzenrqx7+rSSljk2cSdNBSkux4RxmLBRG9/e7/9JVv6aHXLqR3XMnpteEx74SBI2AwzRME26vtOYrFwNypq9Ts66uGzuG2d54YuvhiRQXnvkuBkFC8yDPrw==
Received: from DS7PR06CA0034.namprd06.prod.outlook.com (2603:10b6:8:54::18) by
 SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:52:09 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::1c) by DS7PR06CA0034.outlook.office365.com
 (2603:10b6:8:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 14:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 14:52:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:52 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 8/8] selftests: net: fdb_notify: Add a test for FDB notifications
Date: Tue, 22 Oct 2024 16:50:19 +0200
Message-ID: <f62ae2c14296e9c2935a92311b7839b77f5fec61.1729607879.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729607879.git.petrm@nvidia.com>
References: <cover.1729607879.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: c0381f4f-74d2-46a4-3000-08dcf2a91ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gCgSwJaya0RMkAWaKE8ddIHQM93CjQ3pHcSN4Fe7y1ACz+D7/e8+kXSNvqIL?=
 =?us-ascii?Q?KweFRaQa07Q0dNyV3q6zHA69qlAwwNc1dfU8NQqLtyHg7k1PVBy9QlP5USjj?=
 =?us-ascii?Q?k3hSKFTcYv3/iyd/8Ly/fyfosA4Tlh1BMTgDnQDMm9J07CHLx5Plxb2rHR3T?=
 =?us-ascii?Q?nfn5kS4d0hA8ZJOoeznSau0Sp2uriV4dPfw/WeFdEv8LSgGVXkggQkm/f2Bk?=
 =?us-ascii?Q?rbTypZtPonduE8fvwiZRAPyFKwSh87BnZ41ZA7cpsN2ZJ89ByBDSb5Zz42hJ?=
 =?us-ascii?Q?dCichU2d8TeFqDuTB7sERk8x3WQY3sZaP+W+l2KJX5OiHQOfB2r79jrI4bp4?=
 =?us-ascii?Q?txkDeNKIqFJC2YjRy/gI5jTBcta3XJsxtPodFktf4lQidkdOl36QzYHmAHOL?=
 =?us-ascii?Q?0CFY2Y+/GSXlAdX6oKgAuV+ymxNrp5caaoPcy3itKeGAy/DlNIUfBxgOho7Y?=
 =?us-ascii?Q?nEfhwiW9R+EvIHA2QF+NDwj2yLJPQZZ7m5VEMmtAnnIVpPW1igT/tNKX3mZ7?=
 =?us-ascii?Q?ysvAbhmzYKR0o5Og1G38/Q7yabrIFnew17cwuv5dkSTxecrjbRb6lVQsXGVI?=
 =?us-ascii?Q?Vi36znjIB6oDg4iyluTHpemI6D+p6weUTd9uZW+5s60ypIYPvtvQZqEh+/tX?=
 =?us-ascii?Q?TlJlj8JubhJi2PPspN22pFEa0F02xy5Dbo377gCv5LRTQHXkunIig6MnXmto?=
 =?us-ascii?Q?aw3ymJ50mu4fib+uJFB/kGWBudMxeL5qv8o8FH2lPF6JJ/e//mvho2LsWxrt?=
 =?us-ascii?Q?H3IILLuN7XHOEobYpl2/Qs7DqvkZAJwrUZmPSxDyNU88l//Mhf15iNdohU0u?=
 =?us-ascii?Q?qh0RFI+nDug4PS9EmLg/Bq06PSp0sZG2oVKQbLCalc7cmYcTCRQocFOnPQxR?=
 =?us-ascii?Q?gDf6HRLpyo1gB5STgk0z2C0sHgYMS9WuOJV0hwE2H8P/C4s1gA5RhjOutEMa?=
 =?us-ascii?Q?aDgn3x07DdkcxVSjj8Sf9cL4wNB56mRne0DYWwwgmAFzf2DapmWBWU7/3ovp?=
 =?us-ascii?Q?8bUGkn081+y8IsBjeyOxFKsdtESYVU05VwFz9C+iIvzBtUAf2eKtEozQDUmY?=
 =?us-ascii?Q?oIZqhv+iHp7aT4uzM61idBaXPz/LR/ifzXgQGVYLqKnIeAEgKquEkD5ugO5a?=
 =?us-ascii?Q?JA2SSmtS9TuL5Qct2sTpnmjKIERQdbetqcd/6DIwLSwP0GpnnfHegN8xfKjf?=
 =?us-ascii?Q?2slYhwLgYUL3TLHsVcDzYl4a9D+hsUCe20+rJXd8OBqP7yetLc/v5qycwCF3?=
 =?us-ascii?Q?dt+3vI4q/M3qEWqKfFmylYPveQfCTVsZ1UXOAyZq9McL+Np46dNtWJWrWkoQ?=
 =?us-ascii?Q?s0wwLJds5texhKlt1BklWdHSYpYXYFyVhFRdAbvSDbO0haIw+oiDGm0IPpar?=
 =?us-ascii?Q?IDeUe0edS8KwTxGB18pGI02/BYdn68rp6JZ/DeU6apwz9yqsow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:52:08.9550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0381f4f-74d2-46a4-3000-08dcf2a91ab3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700

Check that only one notification is produced for various FDB edit
operations.

Regarding the ip_link_add() and ip_link_master() helpers. This pattern of
action plus corresponding defer is bound to come up often, and a dedicated
vocabulary to capture it will be handy. tunnel_create() and vlan_create()
from forwarding/lib.sh are somewhat opaque and perhaps too kitchen-sinky,
so I tried to go in the opposite direction with these ones, and wrapped
only the bare minimum to schedule a corresponding cleanup.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>
---
 tools/testing/selftests/net/Makefile      |  2 +-
 tools/testing/selftests/net/fdb_notify.sh | 95 +++++++++++++++++++++++
 tools/testing/selftests/net/lib.sh        | 17 ++++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 26a4883a65c9..ab0e8f30bfe7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -92,7 +92,7 @@ TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
 TEST_PROGS += test_bridge_backup_port.sh
-TEST_PROGS += fdb_flush.sh
+TEST_PROGS += fdb_flush.sh fdb_notify.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
diff --git a/tools/testing/selftests/net/fdb_notify.sh b/tools/testing/selftests/net/fdb_notify.sh
new file mode 100755
index 000000000000..a98047361988
--- /dev/null
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+ALL_TESTS="
+	test_dup_bridge
+	test_dup_vxlan_self
+	test_dup_vxlan_master
+	test_dup_macvlan_self
+	test_dup_macvlan_master
+"
+
+do_test_dup()
+{
+	local op=$1; shift
+	local what=$1; shift
+	local tmpf
+
+	RET=0
+
+	tmpf=$(mktemp)
+	defer rm "$tmpf"
+
+	defer_scope_push
+		bridge monitor fdb &> "$tmpf" &
+		defer kill_process $!
+
+		bridge fdb "$op" 00:11:22:33:44:55 vlan 1 "$@"
+		sleep 0.2
+	defer_scope_pop
+
+	local count=$(grep -c -e 00:11:22:33:44:55 $tmpf)
+	((count == 1))
+	check_err $? "Got $count notifications, expected 1"
+
+	log_test "$what $op: Duplicate notifications"
+}
+
+test_dup_bridge()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	do_test_dup add "bridge" dev br self
+	do_test_dup del "bridge" dev br self
+}
+
+test_dup_vxlan_self()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	ip_link_add vx up type vxlan id 2000 dstport 4789
+	ip_link_master vx br
+
+	do_test_dup add "vxlan" dev vx self dst 192.0.2.1
+	do_test_dup del "vxlan" dev vx self dst 192.0.2.1
+}
+
+test_dup_vxlan_master()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	ip_link_add vx up type vxlan id 2000 dstport 4789
+	ip_link_master vx br
+
+	do_test_dup add "vxlan master" dev vx master
+	do_test_dup del "vxlan master" dev vx master
+}
+
+test_dup_macvlan_self()
+{
+	ip_link_add dd up type dummy
+	ip_link_add mv up link dd type macvlan mode passthru
+
+	do_test_dup add "macvlan self" dev mv self
+	do_test_dup del "macvlan self" dev mv self
+}
+
+test_dup_macvlan_master()
+{
+	ip_link_add br up type bridge vlan_filtering 1
+	ip_link_add dd up type dummy
+	ip_link_add mv up link dd type macvlan mode passthru
+	ip_link_master mv br
+
+	do_test_dup add "macvlan master" dev mv self
+	do_test_dup del "macvlan master" dev mv self
+}
+
+cleanup()
+{
+	defer_scopes_cleanup
+}
+
+trap cleanup EXIT
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 24f63e45735d..8994fec1c38f 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -442,3 +442,20 @@ kill_process()
 	# Suppress noise from killing the process.
 	{ kill $pid && wait $pid; } 2>/dev/null
 }
+
+ip_link_add()
+{
+	local name=$1; shift
+
+	ip link add name "$name" "$@"
+	defer ip link del dev "$name"
+}
+
+ip_link_master()
+{
+	local member=$1; shift
+	local master=$1; shift
+
+	ip link set dev "$member" master "$master"
+	defer ip link set dev "$member" nomaster
+}
-- 
2.45.0


