Return-Path: <linux-kselftest+bounces-22750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC999E1F6A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9632A166A09
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7301F7595;
	Tue,  3 Dec 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cNfgrxUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2F1F666B;
	Tue,  3 Dec 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236486; cv=fail; b=TjN/YzgOfKF7+y+tJf/foTecxji9S5Eal3nDxVMpGb2Jp5r5qeHTGPH+3QfIe+p4FyC5t2vBTAmy7lZUVwaeM6zJ8MpXaSY/Rxm5DBwa0/kfYaxXhA9FJT6xOL+5PT8PAhJpTjbi1ykAD9UcsKLHCue0OzRvtSt92tt6H5HIKfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236486; c=relaxed/simple;
	bh=sa+vZ4cO2nKVCAsPHtSng8OI9lMw+dXg1EIFqUVLVto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JubTmNMo4QjXdIFXZfgsYYt0cJV0lcAPx/1WPDAZPmOym4CiKg9UnZdZ0HKKHJT2Hpas4CguH77QgmqL8xPZG7gDPNP+8JP15WDf+28yTJu6xHs7D3qpbHXaGrCX5VIGSHt9ZQs9UzRGjezk68caJoKz1qNU+PlfinFmaweaB4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cNfgrxUu; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOi/mNTlmBL6uelMLKqQWdoQ2RaOhhQLHRqz2Ovjz5ZQSaucKW8UFSo0gOeSSz3y1GH+WnN+N8FZ+Sjz2L3WQEZ8XUBBg0e/Q/03+GgJnp4fvdmkbZJjKxf1S5ttmmA4+4WEsfSYqIQ7BFN9Ktcn2Y6FcuL4AMyhbMwdmvResqPg3YcPduXGFPr5WzVrNyJ/Qb3/thzuiEAHbiGFBhyhvbqoCeM8qv9G1FN5dx5yJffVlREyRXi8S8A4pLYwkCFB3VoPV7Gy1fLuGJActPB8ReUJIio8NYZXEyYKUIt1KzB/klS2WZqd58PrrSNuZmynmgIaIAHOzwlKAgDsRzXaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZq6qzGt8ei5DmYVubXAiDaB7Wew5c75RnjQVh/liIA=;
 b=NC8K3whIOc0sqSG2XTJCnFysf4wHe+oghlmkYYxEMuEcdFO1s8iGRLyno+eqrmRfQ9HG4rVn01MpYDgNjsjyGImgo0RQugrWIxF+HiMEyxc6wQqJGed2XJzq4NWxDSUnGZoXAPy8bX1+iVne2vgNpaq66iHS6YdZ5oNm2SehuvSgxGp9oqGJHRxFrfMQoQJIfexh64pd+JxfrC6cf2ap/viI6V11Bhn2HII7MZB6evR24merR588AbCOzJ3S5OMiNYjUAiA3q0Qie7rPT9mVUrefTXus3iaSInUyGTQXuWh2RaEFpcFTZNLj/noskjX9g6DCBwX3Iii332QgVRL2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZq6qzGt8ei5DmYVubXAiDaB7Wew5c75RnjQVh/liIA=;
 b=cNfgrxUu9D02a+LcYkMbAuVl3tc4oBfyyQQIDyMPhf1EUn0XQKKjwuF5qTZd8MwkGpcgBXmdibyEqLgiOJhhZ83PxxJiG+uf/fzpFu8jfqreVFEjOOXgxwr2TjWAPEActWPlJ+Ps4tNJU2d6Cj72OZD87oronSCmoHqoy5KwLgsi+Rhh5zepcszoLicANbE9TJyb3SzfaLFvnpp2oYuOKjWBJpx+ZaBu+qwlQzPWOCsjC4lYPacRxLKoUmMQhVAYclK1U7vRn+0ZLLdsB8uW2EqkkxsDk2TgOkv2oZPdJdyr3F2GzjPA1VGe65SGe0cZ7zA8WVXzOegFhDvA8Q7P6A==
Received: from SJ0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:a03:39e::33)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:34:30 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9f) by SJ0PR03CA0298.outlook.office365.com
 (2603:10b6:a03:39e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:34:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:34:14 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:34:07 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v1 11/11] selftests: forwarding: Add a selftest for the new reserved_bits UAPI
Date: Tue, 3 Dec 2024 15:30:37 +0100
Message-ID: <e4591fe820d539e45a08eae96a69ac7353a2cc7c.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dee7c80-d745-4ed9-b93b-08dd13a798d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bq5mxEMOuFjia2f170TIXttdYoLWidLw//Gb5RCa4UVdDCRdgZHwkIeKLRpm?=
 =?us-ascii?Q?ICHYZn/udmAFyGMBveiqX+4VfVcI7wz+nE8sjs6fiuSksY5Tjr1pnursv+O+?=
 =?us-ascii?Q?fYYbA2WNfTF6mCY25VlEhruWjYY90k8XMdr4rGUKbUOrVbyTqBlEHWQfKw/D?=
 =?us-ascii?Q?zFaYqQIdcl+ZCftf8jxx6zp58rBMdWpaZK3gO9mBWTLbN6t+8nPFt4AojwwX?=
 =?us-ascii?Q?t98Y+Hf8LOhiAAdyHaHG0bsUc51jQ6Bf4LrFME9JP2lElMoCVLuH76T9utHZ?=
 =?us-ascii?Q?8ea3R1krtvwj+avuOzbq1ocpnGY9tW1w60EfFttMDgrobPNYSJKCtEIOMRN6?=
 =?us-ascii?Q?kvOvH5c2FgUw0wbaCx7IPfANfCUtBvc9sqGxcJ2nHKiJYS8qtMfSoTFVqxAg?=
 =?us-ascii?Q?DpK/h48HTjKgiFm8iMQ4InbrCnNA521cJ2wTMhd1cXeMPwc2IMCwK6GsCIyd?=
 =?us-ascii?Q?iVv/pkp6yZvgCTeMbwFQvRWYzOpU1hpJbGigSO8BbbqoziTkrtg7z2dzBHNA?=
 =?us-ascii?Q?jGDwSLfqogAgJ+5UEN4DG7T7J/Gf5ap9qYObuUG0gU0J3eKXJG+wZhuhSsAu?=
 =?us-ascii?Q?8CW+zIXFkXX3na+SQ9NxToXCrnNLGM5odGGiY1nts9CCPC0kmvZ11BzVMJZw?=
 =?us-ascii?Q?K1qnyM5OTOdOBQYnBNDzI0lcAdSuTSgEl6NpaIR9IbtEq1jErF6uC0xuW0Pe?=
 =?us-ascii?Q?v3uK4IHQGvOGDRjTiiYbmxMI9llgAI5wB9faNI/TXM5WqBqdE1BW/wgDXP15?=
 =?us-ascii?Q?M3mwM3DgUJVB8trTEZA22guZGABHtV/ePXPdYaYGHFY0jdbxlVr+JQ0C8761?=
 =?us-ascii?Q?3+SvY8p96+Bm+qpnykqJIXKJBpPTuUvLsmZ25+aki9KzDD4vjy8MUpya5HPz?=
 =?us-ascii?Q?jsB18XxkgnSCzwApVDRxYXeX2nMlkR3jwg0dew/EQTsjCkAJHIZpQ6dd/qkq?=
 =?us-ascii?Q?iByGxVF+QbywCIpu0ZOFk+HlkoEm+6C2k6hDlTNR6sn/Zb8qeSlLY53BTO7I?=
 =?us-ascii?Q?qX30CsopmvN5Oe61bNhQw/X1R2hi+zH3wotg8lboeE8lG+pXYdA/hYNFsgDg?=
 =?us-ascii?Q?82fbSla1oho5Nc8+dFBdu2Lrice29ieWsXuwPlM/mgCiBTU+axjmQddNPbJV?=
 =?us-ascii?Q?DW2Bq/ezqDXlr99wSNQLCtpT7ze+NZCAe6TZzgYI3HLhVlkSuKON3+oon3za?=
 =?us-ascii?Q?DaZ+/UIqHjhin8KHveu7HgGtJkfM1s0DNN8FJaTqJyzWGV0Zwzdmn354LdyQ?=
 =?us-ascii?Q?F59et2Z8KCwRMsxdBqjJ5Y+PBdIiU2JEv+JfEqJIBuTS0qBUbXq3q99XTvbO?=
 =?us-ascii?Q?bsmw+w4AqUPZ5wSLYsc3x8oz2967Dko4sTgWe1c9HMkg/M3gqtp1IT+rkbqO?=
 =?us-ascii?Q?qngKjzbukMvg6GqY90QPvUXJu7pKOQx1lqGYRQjLKOwX3QTbdGy7nIgqFKRA?=
 =?us-ascii?Q?uL+KK+2tCW7b54mjkvKOVaPGy/oIf9gI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:34:29.9354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dee7c80-d745-4ed9-b93b-08dd13a798d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Run VXLAN packets through a gateway. Flip individual bits of the packet
and/or reserved bits of the gateway, and check that the gateway treats the
packets as expected.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: linux-kselftest@vger.kernel.org

 .../net/forwarding/vxlan_reserved.sh          | 352 ++++++++++++++++++
 1 file changed, 352 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_reserved.sh

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


