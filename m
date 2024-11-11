Return-Path: <linux-kselftest+bounces-21795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83929C4358
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE84CB28EBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2D1A4F21;
	Mon, 11 Nov 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kb49bsN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3910184556;
	Mon, 11 Nov 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345156; cv=fail; b=tQ6zjyhd3hpvRwthF8jRskn4FXCR85wATAo5JC4dXpwwiONojOMGaeBoOMirNik/h4CHT+0tJbuLsG2SwOC926C+kGFVyS22TbjEYCD3vPJo8kvNt21iMGXEcHSCDle3g+fmspglUab1k1b7oDVmIvN0i3iAsabSYkfiINVBpBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345156; c=relaxed/simple;
	bh=pENITIt7/CLg4RZ7fnoBqkbo7fRavKBlcU2Gh85U3f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnmyHe0Np8pWy60n6HcTHKob+pqVNIxAvx4kzrbR/+nUil7vh8FC1japneOFGucXdsVo+jbZwPKccxpQTAHFVuytIhzvWUAz5PPD8LfG0lscltl07BcoZFfOoC/s1eMGQ9R0dSpjhbDwMQZS/f+jAvA3B+nLzddAPXA+c5qppdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kb49bsN1; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge4USRQGkZONP1mmzzsnSRvhYXG6Zvf3eLENX/Nog9tJvZ74Zy+s/g6KGxOSxeDNk6qVVTzwKIaDXCO7WMBCcq31HCgMPW6smPDGYAXD9ojswM9QYZQQ1jM3DxgXReJ0fvgD9JuPnuhdpmo8AGEnyjengbUmb3OMHfANA1Ie+XZ7QmHRCtGfO+Of/L2vQqKk0AyaUp1hCo/HNaGg8yhIut2ffAOlGdX+n2t1qgrYZVBDLhnp6FTP4G9bGV9uDy2NQVY7u6j5zihMp2FHZlUa8VRZk69BNUbjN+10CUCHIC+CTP7HHLz1oAfVz4rWfybUH6hehuMfKRJPGCqm/r++/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVQihhtYWLrg1OTqdWtB8VuH7PoGIhINHuZ/rWXhYkY=;
 b=f6MrEalrhk6Cc73uVUygkv3fornX6djMg656PBNK38oGs2VINnT/RezYGms7H6ZOx+lIOttsCfjiUErc52yp6SzN7Qz8d7/D66R9h7L9R3Mmpmre0IoG4a4sA/oPcGbcJsb9Y5WrHayIY23KjWcGzQaoy/gDEq4ZOpfDNh5ywGEoQrWLSIw8zpp/D1fNN/d15+xaLaYlbUVcp1P8MAGLnTFof6CXVC/JUpkqM78l5VpWkgcSQ9LHCqJ7IYD+bWx5NxVLcBgZKAk/m+YSYymUG879fAzu1kLNTn7bv8+IF1hnn0kUKpZwHVYb9jdWFJ/MAcOkl2zAgkzYTfyS7nMlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQihhtYWLrg1OTqdWtB8VuH7PoGIhINHuZ/rWXhYkY=;
 b=Kb49bsN17iCwQkpZ8xypCnRItV60l6M91qCL9AC2e/ZVYZFKn5sebjBJspRuDRjmjxzOdI2OIWvTk8AtRbw/9CAae6slvXz07YtYkVA/iommkLxY3hi3GArrPW+d0v734gSZtUpLg0opbQwiLp5D/S5sT/gKi5vKy3PKB0Rtm5IJgX5QNlBzrE9NVI+NjJaXm04aFLnqON/e2lF64oTt8acBjtW2Y1TwxQF6dPcN+et+FWPF2bTZUANiL+slMuip+XMHXJ5iK8HkkG5bxQ4HZrCXhYv4hkILy24FUcXfHg5nzLXYLSSrRog0bbw9bUCRf/U20wv12OAV3RUY8BgqPg==
Received: from MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::15)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:12:30 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::56) by MW4P221CA0010.outlook.office365.com
 (2603:10b6:303:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 17:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:12:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:12:12 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:12:05 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>
Subject: [PATCH net-next v3 7/7] selftests: net: fdb_notify: Add a test for FDB notifications
Date: Mon, 11 Nov 2024 18:09:01 +0100
Message-ID: <baf2abd6af2e88f8874d14c97da1554b7e7a710e.1731342342.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731342342.git.petrm@nvidia.com>
References: <cover.1731342342.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: f369eef1-7cf4-4ebe-1839-08dd027405f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTjT1XSJozJz//RH1vHaPfWmCbYTForVs8urxjwAbmTxFOpOg6A2W8jvxwgM?=
 =?us-ascii?Q?QgIM7YY8vDJYD6kNEfsdC2QFC4bLD0YKQMbcQout/OGqBzz4Ii2ONvOrFB7p?=
 =?us-ascii?Q?nDLeLMSeOjSexuSasgofejcRznb336Y+NxB+vzNWW/1uziFLhdMa9eR8gebR?=
 =?us-ascii?Q?Nk0ZH1bkOLEHSA4K4+FbrWWyWbMDj1IiLhNA54cGmAkFNXMwi7pVSZ2OEKsr?=
 =?us-ascii?Q?KGQ2ABja+dzjXVy5e00HpJ8Bqxux6IRDgCAIN1NuZ8WwUUrwHzEMObyaDJij?=
 =?us-ascii?Q?N4ajfTUCLp4IRvDlmv3FgxAjZsEO1MXjjbs2h47JkXcnFCnp8TsUKoDwqUUP?=
 =?us-ascii?Q?50Uf0H0CNoOWrERNZO8wsiN4IbgHVuOwLuwB8T1LiQ5WHb29aaTdD1NB9KtV?=
 =?us-ascii?Q?whKh4l+UmKOwh5fbRLxaQtSBy36lakIce5XXWzrCUyIZvTnZnG51HqAp9ycb?=
 =?us-ascii?Q?Jqet4HzjOTWeeiXF1n0iFpISQvAxyjuICeJm+nrhX5TxLepDaBqVZ0lCRpIF?=
 =?us-ascii?Q?raAOkRGD31rrjbgxlPmuyVUWjFqZsi3iFTgTuqWdYETcY6N2FxOVQWxvyfS/?=
 =?us-ascii?Q?XcSegaI2YbodscLWRnekVwfyL+25P3xZHMYBbxR0Sr1yUcpF2tyxqDZLnvCT?=
 =?us-ascii?Q?QOKTRoeKf5z+5QTnRaE1fEBIqqrwvPwhwhK/OC0fx8HDCoWAvskRycKkyXCp?=
 =?us-ascii?Q?Q4RmwiSkVNVBtRscjW+Qn3ef51TWn6khGrdrZ4L16E11ajzDzstwFkJ+XFXA?=
 =?us-ascii?Q?Ux9gq31tJR4OsGdQEmOjZn3Ea0AJlXMpTi9ePvVoCj8xifM/fOsAOYpo+K48?=
 =?us-ascii?Q?V2Jeo/u1s/KGJFdiP0ePB4MWKZu5P02unzMRifMLcTrano3iivBTJXA2b36s?=
 =?us-ascii?Q?DlcDYzEGirTUIR+6swaKsS4sDe6LQFUyXeuMDYFanxpnTWe5vYNqsiZKil4Z?=
 =?us-ascii?Q?V5agkONA3/XypH/+Q+DsIIGuXyTolMLbbco4y0F+XsrnE3Fz3AWAoHcQBBwt?=
 =?us-ascii?Q?0pJ3vZXvB7epqQjrqGnximKDYtaTCxaMxmtFzn8EFAw69j2IZmAnLiKB8v1h?=
 =?us-ascii?Q?4cZmA5bbHI+CGQFBuyhuD5NgnzDyHzKtG1V/tYENawaIIwJu/0Rxm7j529LN?=
 =?us-ascii?Q?ec1myeVV+dwtADrJjd7reIdDSSR8KinkLkPyxknSSlDWjO9QRzeM6zOj3Hve?=
 =?us-ascii?Q?cGFO17ZCdItLOHbtioUcD7sYI+hSpGu92NG0jG4m5y7Q2iLOvFO6Fo+mZILH?=
 =?us-ascii?Q?WtC9skor6kyb6xisjK4y+z23rOodqQVTSqOc+4sioUCH3c+o4KpK+CAvfedM?=
 =?us-ascii?Q?Z/KoRx15ocpoNXnR6Lsrpqmg6teLyF49CM3MdqFECrfSFZSox8na0XeuR/Nw?=
 =?us-ascii?Q?tKzX/y5qWmxd5YYLFPNrum8lNpGoBEUNo6g9hHYytI6hH5lCXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:12:29.4064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f369eef1-7cf4-4ebe-1839-08dd027405f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314

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
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>

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


