Return-Path: <linux-kselftest+bounces-22029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8471C9C8CA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44719288E6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DAB74059;
	Thu, 14 Nov 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fu1528dd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3574BE1;
	Thu, 14 Nov 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593592; cv=fail; b=aW2uE09l4evljjYv4pMVDtND8QH4fE+mYMSgksK8LWb6DmsJhn8dZJ6mhyhqDznt59mM/TogJ2wnXcV55M5GSc3CQU2ggugd3bdVKPe3XX+dPSH19c5kLJGEBYQdtJpX1VlVMCQ5SGF9OxFHMShxji43XBPgtDn6kMiiP8yQ+Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593592; c=relaxed/simple;
	bh=Lh9ZeMDtu/EEAYzsGmicpbsxKbm2Hs8eop6jxt0MHLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEOShR2Qv6+B3v4dkGMl8YBox1TrRC2TXgNrhbYKC4+mzcKzwrYhIJqs2FVWAWmDEhkXyIvA971/EDcIS/ncEWAh8Hh9Dcs+4TqeaswPnFgOdAcSv0YMWbzfAr7SSjLpcrlOciYOJvT2WmN30Cf2uguNcJrTdrWCMTYAuMlil/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fu1528dd; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdJz+y7UpvP4Bjar+frxgdFYcfyzKh391dfUmuz1/cl2NCron5tHp3yIQdmjWrvEe++Q1+aPRpQJefmVrOuH49C4ZOIwURDVOFGXa8sZqT6BMH01j12Ri77+cWIcPILoEWrmCrbaUq4hy5NzPS5wQwjs9VPDH9ZejOp49NmzpW5uaIQ14/6Z+mk/b87b00mioK9PQ+xg64bO1rKiL9PUhOU+GOPyxX+zDlng2c4hvt087R4VzlE1ETKItlEQ46sLRktvNUd0BIbcDxOmzSrtutZu1tpC2eFqlJnRtqhG/u/nvK5iwoEFRGgyYAS5oNzhxoNvFDE7S9dvkzTcc/ctKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLhAWSsdS6h4Px/bZX5a9/WrfuXlE0DgG1hrjpze6/s=;
 b=NWVZTMb23U5P8Yxc2bayr2PjCti05PVDvMA3UfkPEg4rlZUpn979Hdk1Z++CVdsVORuDq1bYHDF8gDOuoBSHo6wyK7ZLxIFQikULCt/epeccyorPGgG1QFelBGQ8SR1H2CL6fyUAbKrj0FGJ6vgXNXTN1nj+mzPUtEUNROxV8dlrYqpqntlCkKDiFDdFKKan18Iqpn9k+xM7bq8IvEbNg1ho8OBI9iOlhs4VO70JucMj5v78VgCn4bMKc7qePhxLBFMWxvWV11CMEHWcxZG6+i8RDfMbfHaL7pSsmS6FoMN8Vug+iPJbTISsNeO0qb9QJ7a/xZVXPh1xy1zQTrLYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLhAWSsdS6h4Px/bZX5a9/WrfuXlE0DgG1hrjpze6/s=;
 b=Fu1528dd34MT3OmcRoGRJpwcPmDyBnzegxUV93Az9RBZUMWZi6kfe47tuYNSqX5B56GxjRPHUj+ZzFz6an2qzeD4poOKeaeu+wynxtyOyzYoHUZ47lxgWwwF9fTCY23QG+0KYQqjQz25Ag+L7XVaj/QeFHX+xT/TomZGRTGN4eINWy8UgifI06mDQk1JhK69XlW98rmzTBcddbBZhluT7uHxUxkua+K09egYr7DTTuXVD84IvHv0RgwjYLkohEWUTTW23OsdGwtYlK0nI+9PCz1dPbNqfmX3/B3AI7vn0zQ7rxjB5Xnl9qpWbwxfOhhY/4SbtcQ5tFlKZpMkEHwIaA==
Received: from CH2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:610:60::11)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Thu, 14 Nov
 2024 14:13:05 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::2d) by CH2PR14CA0001.outlook.office365.com
 (2603:10b6:610:60::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Thu, 14 Nov 2024 14:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 14:13:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:46 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:39 -0800
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
Subject: [PATCH net-next v4 7/7] selftests: net: fdb_notify: Add a test for FDB notifications
Date: Thu, 14 Nov 2024 15:09:59 +0100
Message-ID: <910c5880ae6d3b558d6889cbdba2be690c2615c6.1731589511.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731589511.git.petrm@nvidia.com>
References: <cover.1731589511.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: f24f67b7-6f6c-4661-9c66-08dd04b674a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?twYwB1BbJYgeV5RYhfNm2aPJqL/FtQEVkMrXcAsH/CnvsRcml7FTzhgzxeTh?=
 =?us-ascii?Q?p/YWaNnVIe/c5hfYb6nnRSejd0yYCM8THkfXLifd/kG+LSCNkbRqLUv+Mn3h?=
 =?us-ascii?Q?pC+oufvk/xNm33hDUUqAHRQcmF1PQrL8hPlkuDlD0Non+PY/0iWMXlp1T+Qk?=
 =?us-ascii?Q?eTqA1bxWD0Lvkapw9nz+aq6vWCj7J2j6Sp88NFpxDumqP7mapKgGcNUn+MnI?=
 =?us-ascii?Q?0JMfJiXAd7EufofV66KL364ic6qHEMVxoEnXgrC+75Dt6b3AR0fN5o5mYNCE?=
 =?us-ascii?Q?Fc93RbO7lqmcRRJnzjdOu/JQbHLnkPaUVmXfoCGTfbhFKp/6kgaVeQ6cx7+X?=
 =?us-ascii?Q?NmB/a5d5HCJlPnv5xzRAAMHX0xKXp96n+Xu6ZMC1bQwKO/rlO389WP5XRVRi?=
 =?us-ascii?Q?/UPStI9VHSxRB+tBckjcoJ/t1Vc1Zp/1vLLjbVJiR6cI8pL/IGj4oTfXJiAs?=
 =?us-ascii?Q?rw/kFX5Ly1Ktm55tyzakqYYPxXE7g56H98yJhrMDK9ike6iyshYbpdh3C6Vw?=
 =?us-ascii?Q?3/8syPqP8m3eremFXkh2HNv8V5NdZ2gBA1IOEOwK40K9dTnKR/7ZvX3+L0rc?=
 =?us-ascii?Q?1ttwE3qE6y0tgDmeVrQjXzmYkMFK0KUxYjNBymf1QYa3P6uj6CS6jmmUGZpi?=
 =?us-ascii?Q?t695DwUJxFRwAGje4koFKl9on9VbfnPzP1XP7FlEg44NIdYVGkrxarHwuDqH?=
 =?us-ascii?Q?ExporfhmiThfPOjIEt/supDDHGdYdOTdkFer0Jm20WOT8XbvO2igQHpeTdMN?=
 =?us-ascii?Q?aBJ9xfDAieIj9WjVRoPTC1+L/p4FwyCOwpMmUyha6A0WFvmc/eM+3Nq7PNJK?=
 =?us-ascii?Q?INZs84Kisofl56S4WaoilCRtp1BAcEss+ITfMQFliquFdi4qkNU9DjzHT36L?=
 =?us-ascii?Q?k8rDNIPOX4V1jDSulEKYTIc6b0lzEIkZF3Q1CFlijLvptsAnN5LU7Ni60yWj?=
 =?us-ascii?Q?Qhj+rnv4IthrJEBKwhwqclFYCYxttkuv4XK+UARULdViSRHNbd8DzDva8G5d?=
 =?us-ascii?Q?l8hbxWixn03T7308J1LbhKxS0OvFThwoi4Sz1yS6XlukYp7RRTmAmhZYwexO?=
 =?us-ascii?Q?6CEPErLfhcARZhiDWctnYg2IH1Z1hP1q7+5a5yC6asLI2q9wR11zGAe16RGQ?=
 =?us-ascii?Q?Hq1ey+rjlNv0xSwN9LVtpRb9b7NhgWrLH1nfk34nUt3gPJ1HqcEn5V1xHPGG?=
 =?us-ascii?Q?9kXpC/bugCGL2jdq5rU27Eb+TeAjJy0jVM00ZfDGw/dzdpWekAt4MkaCFJBa?=
 =?us-ascii?Q?W1KLc0D1QrS+DayKn0tMtBD9T4cGPBVc2kJ6mJMKxL7lUg3SdBo+YbPN8GTu?=
 =?us-ascii?Q?fdjGEZSb4Ij9CU+WeZW9iWpyxGD70tmvTlko3PBQPtKR7Obw3wdbrK0HOBpB?=
 =?us-ascii?Q?EOz23Wx/z6qK2ZhnLJ5k44Kn0t2HlYfspBBpk+zUAdzvphZgFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:13:04.2314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24f67b7-6f6c-4661-9c66-08dd04b674a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

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
    v4:
    - Adjust the sleep around the FDB op
---
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>

 tools/testing/selftests/net/Makefile      |  2 +-
 tools/testing/selftests/net/fdb_notify.sh | 96 +++++++++++++++++++++++
 tools/testing/selftests/net/lib.sh        | 17 ++++
 3 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/fdb_notify.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 2b2a5ec7fa6a..d1494700f501 100644
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
index 000000000000..c03151e7791c
--- /dev/null
+++ b/tools/testing/selftests/net/fdb_notify.sh
@@ -0,0 +1,96 @@
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
+		sleep 0.5
+		bridge fdb "$op" 00:11:22:33:44:55 vlan 1 "$@"
+		sleep 0.5
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


