Return-Path: <linux-kselftest+bounces-22872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C54A9E5A17
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552E0286010
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5721D583;
	Thu,  5 Dec 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y7+Nwnth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E0225762;
	Thu,  5 Dec 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413507; cv=fail; b=B9oGqoAd9vHZuISdIkXVp/oCCQ4WSSB+lJso9jXuhQCobTakVCbtZRQqWrr6O0/TkTcVBIUyt90ULfMpweR0+a+fwnRzcG0NUdg7E3o2cZHZICm7NkCvhhM23KjWtfT+QLedFM5ARo4g1pABHnuJyn1GEiXm41WRU7Pi+ORBNCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413507; c=relaxed/simple;
	bh=i95+KLcasmBaLOXDbeCg3RBd5J9QMw5Ik70fOPsSSmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3ejEvPkRbUHtE/24117rPT6pOmJE7w9A8G7u/0zIDk/nyhZvdRV+jLoXGjn2/oLGQIS7XYz09COSKlp5VFmmzoiz3DljiuxPxSRq8bwMeWtUG8+GruAefTe4nXlvC1zxrCOZkn1dK+Av6m0V/WPS2BjnpUJwyJkuYVDtosxAM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y7+Nwnth; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhdT6WqlE7km2UN6ry2xxF9KlR5y89kHNaonpnbRbrkuF0rzYoR1+OY7TZQHDnbM6pf6bj/Ns4JFOnXcPEOKFKsvWD1L+nl/mDjjjpqWEy8BgHxVR7qJgjGjfjjPO+BBK8j4wai+VfIS1rnaa6Ws1+0RvJuihJU6sEBuFaMb7gncAE6ezNfFskcli9sWDJ8J+TD70Zoa6/KDvbhMsSgdEbLpT0Z84jbX2mz3COFB1yF4F+2ari2V6/zjvIf8XsQnii1AQqkEFunIrh4oLjVVyg5JYWRVqX1d8wxe8/UBJcJcJKRv+pBPur7d4Dwvw8Bq7vjuheFtVlEL/K5UHp+n2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGaF9TAhee8pq5tjJ8dDOAh0SKzCk8l2bVsDZ+NEXT4=;
 b=pRmP7+/uMLf43b5OdplX8iCUY7uqdVeo72BqkrkXOxburrUI9WjmLyC16Ggw3cO4Uxfd5myzkpZEUN/aJ/6p3bWZF18MkxCSDG2RrkjdiXRUDfN1VFfBkkDQGb0R1P2LeJ+ubuO4QyTnxRkZv/ZxEPfQLnf2/ASTQ3CiDR2IhNPjrXUW3PD8eXuKFqk7Z9b0MUwEB7sQn49ykFWhCS8p0cIvtQ8/1V3OdbBaSsTRL4KvstUl1C4W2EI1K5AKKXfB6JLxjICZg9qb5nVeAHrcba+Ig5HjT1S5469GiRqgdpY2lo7h5y5MKZfFxqxOc3N9JoPiuQ2FDl+Kp4X69SwWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGaF9TAhee8pq5tjJ8dDOAh0SKzCk8l2bVsDZ+NEXT4=;
 b=Y7+Nwnthfd27FSKhwPmk59kGY3j+kM2HWhbVJPv4ZiA1v/9R5OBoFMuD/CNaUK76ITzS3uNrplguW+LGXaTxr8SlzDyYZutBeVGlW5iWyvLiE85ezrKGgjpwbW7+FzHzwo5q53Ell1JyDAP56znMfWHYhFxG+P9Q+GPm3wmG74dHgHLpjSFRXR6UWZZ87jb0r18p2otQcS4fNw0bUELb97J3hPuPZLKSqBEOS4QdgINjwL5D655LbzKHLTCekX/GEL5YhPoLQt/UqgsRNiluwV2zjbncf7LMaoACGzI2zOkhvBx8qqZM2lee/qB1Cr1hCF+SNdzpZVSSOXOi/JxPCw==
Received: from DM6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:5:174::28)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 15:44:55 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::24) by DM6PR21CA0018.outlook.office365.com
 (2603:10b6:5:174::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.4 via Frontend Transport; Thu, 5
 Dec 2024 15:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:44:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:35 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:27 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 11/11] selftests: forwarding: Add a selftest for the new reserved_bits UAPI
Date: Thu, 5 Dec 2024 16:41:00 +0100
Message-ID: <388bef3c30ebc887d4e64cd86a362e2df2f2d2e1.1733412063.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733412063.git.petrm@nvidia.com>
References: <cover.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 79336d57-d4be-4fda-3a08-08dd1543c2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+EMbThoD009GXhSh5k1XWHutEhJDPVWbUfTrtVhRwzpZrXoLWuYL0y7/yoT?=
 =?us-ascii?Q?FrWiOKap7PK2p58O5P2lwN3D6YgaFpDt7k7rcxLH5YFyq8dR5KkLPHjyDGE8?=
 =?us-ascii?Q?DfqnfHweCHdOvLkC2bP3tAn66XG3ex/fArIS6YwEOIam8S78O1PVe8tm8mia?=
 =?us-ascii?Q?kvsK2iargvuiMef6+tzGZzx7oCqJ1YwrLa2PZtyBwNmfB2cNPjFB/3EZCkLw?=
 =?us-ascii?Q?3h6KjbMD+KLg9DCilqzwz3Ql0ltUvemNALVnacuZl/boqw8yV5HXjxOlJmOL?=
 =?us-ascii?Q?MKEG0g5XuCj8vh4vcqu5QkjLvF8ggBmWZTZ6+XR6h1YmshoQ/XusZowz+2Af?=
 =?us-ascii?Q?WbcZwgWLYVNugUOAPEgM/Tav0xJv53pAYUjGZ4Bm45cq51+jvV3oQpRxWBcd?=
 =?us-ascii?Q?6YASwc59fC26LhXepI/CPckgkd+6CyrNRuXJg9oZpdoLTGIczkkIFXSsorsy?=
 =?us-ascii?Q?Zu2OQ5STXe78GdI9nt/KExFZVYcIGIdHaMJ5Z1duCIhtH5tefndnRfa3ejPC?=
 =?us-ascii?Q?BpDnviPh01zVXYzEZO6DHUnUX7+HBQSgtgOP+LO1aHDpVFud7AxzM94Hmomw?=
 =?us-ascii?Q?0UmY5LolkVDR+J0T1mQsabEkfusLY/e8FOB0ekQPBJlvBbtMCQw7jqyC+r5v?=
 =?us-ascii?Q?aMEOBCmw8XY8rabInGziTLkMi0eRRMEX8Q0I+BIg5Dcuehfs4wnm7rXchQKu?=
 =?us-ascii?Q?x1EBLtA8mDo6ueoBJaKVkBB0pUsJVndk3NBfSBkC9yXrkAvJ2BdluySO8a5h?=
 =?us-ascii?Q?Op/3A92674jBlS6VLpxSGjcrdxNsxcKK6f6vNAA0vGQcX5ZKEHm+3hIlSYMJ?=
 =?us-ascii?Q?JnlXG15c3xtA+ZoTt14VA0qT4oj70fVvKiI/Q+wjj/w+27HntjfdrPtXwPLf?=
 =?us-ascii?Q?8w1Itztoj2a2pMWNLmueq7bpnQmzCP02LyTNTFtF/HFog3AamTwo6OUa0IQy?=
 =?us-ascii?Q?lBigqZD0GJ41LPPCw8mCUdCvOITb1joPXZNCi4toERgxSFVB5WDKFxZipErR?=
 =?us-ascii?Q?K/szvLoPzMhT3WxYWpx5q37FHzK00bVgAbc7+J88mq9GszxUo12GiCmSC4gY?=
 =?us-ascii?Q?NsM2kOec93nAhRMGsak/EyTEbGMF1ehAt/RDJdVjsSzKciXtGbqUQGl0yvXm?=
 =?us-ascii?Q?gkCtnB/9oXTWNbV9ttinRISwKP9hIvLtAMGg773WuR0mCOLO8dKWl1zOS+xT?=
 =?us-ascii?Q?TzT3PihDDkg37fxjKvtvOprRbOHP6T+Euo6HLoiLeVklz7mr4JTlKXBHBtoX?=
 =?us-ascii?Q?ruNPzAVQ/8+LiNp1I/T4Ij3SmnjST6EywSq3bexAmh5QhBzMglCnD12BkYwQ?=
 =?us-ascii?Q?kXBTH3/VjhvkoMBX5x/RMX4lKkKEz7ZVZ9RkRUzoSx1rMhJ4+kl03JOw8Y2e?=
 =?us-ascii?Q?O8uRMJnS0DpaJpTYnQuCjPyY3xbxoLGBKFigqEmsZeSV6AAoiSa4UZ2Kn/rd?=
 =?us-ascii?Q?s3hZWQP48e6KGk5vSS3qcYknbLuWUXlR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:44:53.0924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79336d57-d4be-4fda-3a08-08dd1543c2d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

Run VXLAN packets through a gateway. Flip individual bits of the packet
and/or reserved bits of the gateway, and check that the gateway treats the
packets as expected.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    - Add the new test to Makefile
    
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: linux-kselftest@vger.kernel.org

 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/vxlan_reserved.sh          | 352 ++++++++++++++++++
 2 files changed, 353 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 7d885cff8d79..00bde7b6f39e 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -105,6 +105,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	vxlan_bridge_1q_port_8472_ipv6.sh \
 	vxlan_bridge_1q_port_8472.sh \
 	vxlan_bridge_1q.sh \
+	vxlan_reserved.sh \
 	vxlan_symmetric_ipv6.sh \
 	vxlan_symmetric.sh
 
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
new file mode 100755
index 000000000000..46c31794b91b
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -0,0 +1,352 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +--------------------+
+# | H1 (vrf)           |
+# |    + $h1           |
+# |    | 192.0.2.1/28  |
+# +----|---------------+
+#      |
+# +----|--------------------------------+
+# | SW |                                |
+# | +--|------------------------------+ |
+# | |  + $swp1           BR1 (802.1d) | |
+# | |                                 | |
+# | |  + vx1 (vxlan)                  | |
+# | |    local 192.0.2.17             | |
+# | |    id 1000 dstport $VXPORT      | |
+# | +---------------------------------+ |
+# |                                     |
+# |  192.0.2.32/28 via 192.0.2.18       |
+# |                                     |
+# |  + $rp1                             |
+# |  | 192.0.2.17/28                    |
+# +--|----------------------------------+
+#    |
+# +--|----------------------------------+
+# |  |                                  |
+# |  + $rp2                             |
+# |    192.0.2.18/28                    |
+# |                                     |
+# | VRP2 (vrf)                          |
+# +-------------------------------------+
+
+: ${VXPORT:=4789}
+: ${ALL_TESTS:="
+	default_test
+	plain_test
+	reserved_0_test
+	reserved_10_test
+	reserved_31_test
+	reserved_56_test
+	reserved_63_test
+    "}
+
+NUM_NETIFS=4
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1 192.0.2.1/28
+	defer simple_if_fini $h1 192.0.2.1/28
+
+	tc qdisc add dev $h1 clsact
+	defer tc qdisc del dev $h1 clsact
+
+	tc filter add dev $h1 ingress pref 77 \
+	   prot ip flower skip_hw ip_proto icmp action drop
+	defer tc filter del dev $h1 ingress pref 77
+}
+
+switch_create()
+{
+	ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0
+	# Make sure the bridge uses the MAC address of the local port and not
+	# that of the VxLAN's device.
+	ip_link_set_addr br1 $(mac_get $swp1)
+	ip_link_set_up br1
+
+	ip_link_set_up $rp1
+	ip_addr_add $rp1 192.0.2.17/28
+	ip_route_add 192.0.2.32/28 nexthop via 192.0.2.18
+
+	ip_link_set_master $swp1 br1
+	ip_link_set_up $swp1
+}
+
+vrp2_create()
+{
+	simple_if_init $rp2 192.0.2.18/28
+	defer simple_if_fini $rp2 192.0.2.18/28
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	rp1=${NETIFS[p3]}
+	rp2=${NETIFS[p4]}
+
+	vrf_prepare
+	defer vrf_cleanup
+
+	forwarding_enable
+	defer forwarding_restore
+
+	h1_create
+	switch_create
+
+	vrp2_create
+}
+
+vxlan_header_bytes()
+{
+	local vni=$1; shift
+	local -a extra_bits=("$@")
+	local -a bits
+	local i
+
+	for ((i=0; i < 64; i++)); do
+		bits[i]=0
+	done
+
+	# Bit 4 is the I flag and is always on.
+	bits[4]=1
+
+	for i in ${extra_bits[@]}; do
+		bits[i]=1
+	done
+
+	# Bits 32..55 carry the VNI
+	local mask=0x800000
+	for ((i=0; i < 24; i++)); do
+		bits[$((i + 32))]=$(((vni & mask) != 0))
+		((mask >>= 1))
+	done
+
+	local bytes
+	for ((i=0; i < 8; i++)); do
+		local byte=0
+		local j
+		for ((j=0; j < 8; j++)); do
+			local bit=${bits[8 * i + j]}
+			((byte += bit << (7 - j)))
+		done
+		bytes+=$(printf %02x $byte):
+	done
+
+	echo ${bytes%:}
+}
+
+neg_bytes()
+{
+	local bytes=$1; shift
+
+	local -A neg=([0]=f [1]=e [2]=d [3]=c [4]=b [5]=a [6]=9 [7]=8
+		      [8]=7 [9]=6 [a]=5 [b]=4 [c]=3 [d]=2 [e]=1 [f]=0 [:]=:)
+	local out
+	local i
+
+	for ((i=0; i < ${#bytes}; i++)); do
+		local c=${bytes:$i:1}
+		out+=${neg[$c]}
+	done
+	echo $out
+}
+
+vxlan_ping_do()
+{
+	local count=$1; shift
+	local dev=$1; shift
+	local next_hop_mac=$1; shift
+	local dest_ip=$1; shift
+	local dest_mac=$1; shift
+	local vni=$1; shift
+	local reserved_bits=$1; shift
+
+	local vxlan_header=$(vxlan_header_bytes $vni $reserved_bits)
+
+	$MZ $dev -c $count -d 100msec -q \
+		-b $next_hop_mac -B $dest_ip \
+		-t udp sp=23456,dp=$VXPORT,p=$(:
+		    )"$vxlan_header:"$(              : VXLAN
+		    )"$dest_mac:"$(                  : ETH daddr
+		    )"00:11:22:33:44:55:"$(          : ETH saddr
+		    )"08:00:"$(                      : ETH type
+		    )"45:"$(                         : IP version + IHL
+		    )"00:"$(                         : IP TOS
+		    )"00:54:"$(                      : IP total length
+		    )"99:83:"$(                      : IP identification
+		    )"40:00:"$(                      : IP flags + frag off
+		    )"40:"$(                         : IP TTL
+		    )"01:"$(                         : IP proto
+		    )"00:00:"$(                      : IP header csum
+		    )"$(ipv4_to_bytes 192.0.2.3):"$( : IP saddr
+		    )"$(ipv4_to_bytes 192.0.2.1):"$( : IP daddr
+		    )"08:"$(                         : ICMP type
+		    )"00:"$(                         : ICMP code
+		    )"8b:f2:"$(                      : ICMP csum
+		    )"1f:6a:"$(                      : ICMP request identifier
+		    )"00:01:"$(                      : ICMP request seq. number
+		    )"4f:ff:c5:5b:00:00:00:00:"$(    : ICMP payload
+		    )"6d:74:0b:00:00:00:00:00:"$(    :
+		    )"10:11:12:13:14:15:16:17:"$(    :
+		    )"18:19:1a:1b:1c:1d:1e:1f:"$(    :
+		    )"20:21:22:23:24:25:26:27:"$(    :
+		    )"28:29:2a:2b:2c:2d:2e:2f:"$(    :
+		    )"30:31:32:33:34:35:36:37"
+}
+
+vxlan_device_add()
+{
+	ip_link_add vx1 up type vxlan id 1000		\
+		local 192.0.2.17 dstport "$VXPORT"	\
+		nolearning noudpcsum tos inherit ttl 100 "$@"
+	ip_link_set_master vx1 br1
+}
+
+vxlan_all_reserved_bits()
+{
+	local i
+
+	for ((i=0; i < 64; i++)); do
+		if ((i == 4 || i >= 32 && i < 56)); then
+			continue
+		fi
+		echo $i
+	done
+}
+
+vxlan_ping_vanilla()
+{
+	vxlan_ping_do 10 $rp2 $(mac_get $rp1) 192.0.2.17 $(mac_get $h1) 1000
+}
+
+vxlan_ping_reserved()
+{
+	for bit in $(vxlan_all_reserved_bits); do
+		vxlan_ping_do 1 $rp2 $(mac_get $rp1) \
+			      192.0.2.17 $(mac_get $h1) 1000 "$bit"
+		((n++))
+	done
+}
+
+vxlan_ping_test()
+{
+	local what=$1; shift
+	local get_stat=$1; shift
+	local expect=$1; shift
+
+	RET=0
+
+	local t0=$($get_stat)
+
+	"$@"
+	check_err $? "Failure when running $@"
+
+	local t1=$($get_stat)
+	local delta=$((t1 - t0))
+
+	((expect == delta))
+	check_err $? "Expected to capture $expect packets, got $delta."
+
+	log_test "$what"
+}
+
+__default_test_do()
+{
+	local n_allowed_bits=$1; shift
+	local what=$1; shift
+
+	vxlan_ping_test "$what: clean packets" \
+		"tc_rule_stats_get $h1 77 ingress" \
+		10 vxlan_ping_vanilla
+
+	local t0=$(link_stats_get vx1 rx errors)
+	vxlan_ping_test "$what: mangled packets" \
+		"tc_rule_stats_get $h1 77 ingress" \
+		$n_allowed_bits vxlan_ping_reserved
+	local t1=$(link_stats_get vx1 rx errors)
+
+	RET=0
+	local expect=$((39 - n_allowed_bits))
+	local delta=$((t1 - t0))
+	((expect == delta))
+	check_err $? "Expected $expect error packets, got $delta."
+	log_test "$what: drops reported"
+}
+
+default_test_do()
+{
+	vxlan_device_add
+	__default_test_do 0 "Default"
+}
+
+default_test()
+{
+	in_defer_scope \
+	    default_test_do
+}
+
+plain_test_do()
+{
+	vxlan_device_add reserved_bits 0xf7ffffff000000ff
+	__default_test_do 0 "reserved_bits 0xf7ffffff000000ff"
+}
+
+plain_test()
+{
+	in_defer_scope \
+	    plain_test_do
+}
+
+reserved_test()
+{
+	local bit=$1; shift
+
+	local allowed_bytes=$(vxlan_header_bytes 0xffffff $bit)
+	local reserved_bytes=$(neg_bytes $allowed_bytes)
+	local reserved_bits=${reserved_bytes//:/}
+
+	vxlan_device_add reserved_bits 0x$reserved_bits
+	__default_test_do 1 "reserved_bits 0x$reserved_bits"
+}
+
+reserved_0_test()
+{
+	in_defer_scope \
+	    reserved_test 0
+}
+
+reserved_10_test()
+{
+	in_defer_scope \
+	    reserved_test 10
+}
+
+reserved_31_test()
+{
+	in_defer_scope \
+	    reserved_test 31
+}
+
+reserved_56_test()
+{
+	in_defer_scope \
+	    reserved_test 56
+}
+
+reserved_63_test()
+{
+	in_defer_scope \
+	    reserved_test 63
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+tests_run
+
+exit $EXIT_STATUS
-- 
2.47.0


