Return-Path: <linux-kselftest+bounces-22190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF119D14F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F355280DE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EDF1BD01F;
	Mon, 18 Nov 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UmPRUkd5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE41B6CFC;
	Mon, 18 Nov 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945768; cv=fail; b=D2PaLTEHLpbe9TcLBWaa1lnnGaB2qUVIQosmgNHaeyApEoczwCpICvIPUSxdQ8rJO8ZsogQoIkrUF3ZDBPq9xUawfIC819knlwyoSE81vcdaZ9wsxcttIXXQNtuUHmlZSLwRGA0swZfXyDGhyaQX/y3+oaXYmesXUOpPgdyxuW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945768; c=relaxed/simple;
	bh=sa+vZ4cO2nKVCAsPHtSng8OI9lMw+dXg1EIFqUVLVto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQbQsKUwXxZry6bsO97x2nQ/Ehdb01+opkn42RyN73fGa38kkTXEtaF4BGGUONBKawxAoBQ/aw8hksPvZOujd7kZ9U/LHlAmxhJy5pOKMsq8t+FHLBv9hc3CQB5I4nECb+BsUgDqZo5p3D3wX0XkaJcVpMi5CDUgbk3vCsgeh+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UmPRUkd5; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK7liPe1gBKAasHnMhCs2sTQelfMfJAvAzRtTduoSavfabo5JwHMY7/zRpro9TewZDerIrcxI73m0EqW6BhELEI9jlmil1MLiw31jSBF8JYgESkvnwd87gd3A2BpWB1C4WedMBsb/tyhGe0DJCVxwVopNy/Do2K3sO8zaUpaV4+TtkWDJ5eI7WVGoGSLXbMpNYPO2dIT3sPKGbEPpeC/XqVStSHhT9GDMwHCX5mDJN7OhUGHGyrU8je0b6buszFoB8liJwShbxYheb8nKiWOWmrSdO1lrlvJKkBEmOqKIC7juL0XoR3Rt9vHt6kWwgHNMQOGib3rCw+Rzqg8nOljDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZq6qzGt8ei5DmYVubXAiDaB7Wew5c75RnjQVh/liIA=;
 b=icIOsqZw0I5gdaGkLoVITgOggCMNV24wgCN2FftyYyl3wjjTawTYXN4G6/ywMNmJuOX8ibMrhcjbw074gIeCOBcUpE6H9Z2dg01+umiAvrxcgBIlGTsMZy257bqsi0nZzoeKyRhS+KTshIPBEq8CqylkKwrtNqfPFfO0hwM7emZwj3hyhQvL+v1+yws4PqwFAMw2NqmHZxywGyTHKjrOmvcCbb8E2YOxRnoD6sydEx2r/eC/IivkRHpEpugQQzlnuhtC1eWT44Js9MShHh9nCsoxHm5tF5TUaf+9YTS5JRSxrHVUm3MDvVm9+y/COs7bAcYUCXAPl71Z+km9qJIbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZq6qzGt8ei5DmYVubXAiDaB7Wew5c75RnjQVh/liIA=;
 b=UmPRUkd5NP+hiMdUnIeXqwBGDJMbP/SPDWLLWqpBHrZw9+6/ahiq0Tp7o686r8qf3b1vVKEEeMBXRg9DiU4fXE8BYZEswSkf7bhGBUCHVICc/D++Lmji/z3qQmGFPbc4KCkrILPHA06johwXH7JN2CH1Y/WP3n/MIO9sPTe7BkI2c4fqs+YDXGUguFglDMO/YTM+IxpX2LRrZ846KulmOSzHb8DbpP0Fs8CHWSxY90d0hghxw5vqjdv/XJwdvMAtM9II9fQtL58GPg6NFPfr7xbRxvZeHDo8BoUPD6H6dPNepxRREQZJkLAbE/fOzuUkojdZZj/a/PPrkYSoJ8S8OA==
Received: from PH3PEPF000040A0.namprd05.prod.outlook.com (2603:10b6:518:1::51)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:02:39 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH3PEPF000040A0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Mon, 18 Nov 2024 16:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:02:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:02:14 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:02:07 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH net-next 11/11] selftests: forwarding: Add a selftest for the new reserved_bits UAPI
Date: Mon, 18 Nov 2024 17:43:17 +0100
Message-ID: <19411b7f8657ba2ded8c6d257223aa5117ce5344.1731941465.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731941465.git.petrm@nvidia.com>
References: <cover.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8605f0-b26b-4b0b-cdfe-08dd07ea6ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zSb9xsTa3gA3WL1Ekdd4lJ1ChwfArh4U0Ck7XPHYdaYGwhHuqitVl4EWDkPE?=
 =?us-ascii?Q?Miarzum3bdh2FLlhU4n8nW6ACbOMBpZsj5EJR20JTCtPY3AOyIBi/Qw1BZeb?=
 =?us-ascii?Q?WC0V4Gz3cPP7aL8Fd5te3q0hbKYnFWNNdzcAcLwgKJbXhwWmdE8E55un/PdI?=
 =?us-ascii?Q?exa+ZVMhFIReXIE0MLJ5shl1hthCj+YZWYDrMxrZL9Vge5etDtDsgcFrH+QJ?=
 =?us-ascii?Q?s5L5qgFy5WfKRQKv7mfyCLrbX0HPHi2sUBG3AEd5oz0XKs+AxfOq8y+tedvK?=
 =?us-ascii?Q?2tciMWjhhBtVLNhisNAJp93YiNx3wXrsrz/SlZmYSpRQhw0GFJr3T9fKU8Cp?=
 =?us-ascii?Q?/brrGXN2zJpNPa3M2TafMce9XPMG9maPPiw7CtEJZ58zmQGRADqnh6LMPHmH?=
 =?us-ascii?Q?3a6ZFjYM0B9+jD9N+GM6zuLaQLpkm2ugcuSJnhBaeNdEEkN5tU+/PEwiFkID?=
 =?us-ascii?Q?i5scwheAfZqpSmhZcXM6VfBdnAUM17SMYpxrRFhD11Ne4k+jp2q2inTGFr/d?=
 =?us-ascii?Q?giGtVBxMySsS6F37xSJdlfcBOmFbGnYhLI/N8LYFTzv7BrhqjW5JhHaW03lu?=
 =?us-ascii?Q?YONtQOpwWe/uS81LPd6V680FdGohK3os+QOBCrUQGieiKWQ5RG4fTlX+ZPkL?=
 =?us-ascii?Q?nWnePZCRuPRJ2zn/znBL28mQxtMF5/xgJwaSTOPQG6Wn0aBlOMFikeZVJ+t5?=
 =?us-ascii?Q?5Lv0NtZd1kKwSzCouypNSPm4fbHZt5Y97hZf7/dElLjl87GM+Wf/uBmQs7gJ?=
 =?us-ascii?Q?LDHgMTQxCyLIXX06sCsyNfqS6AxlfECIErFJRN+U2chATxpTPS3QGCErNsAo?=
 =?us-ascii?Q?VLEJFBk0vBPxSr5eO77jcjqZ+Y2sTa1orFfNdJpbSZ/wKCGYAK0l05r5YLjE?=
 =?us-ascii?Q?17c+26qgcmCXcPKAuzn9W9d/gDg9M4RuNtfOsDQsAfu5eG31kLEZmHZ14sBR?=
 =?us-ascii?Q?y9Upj+qId9w1jXV/G2tyM5WZlgqAZZGlvGNe916dy84w6s61E0dz3GIPAaDC?=
 =?us-ascii?Q?eiWJD4AmT+wgKxEHyoXM5yy7wb7GJZz9ZgvSDyIbNX49bp92TriVjSyHzSvZ?=
 =?us-ascii?Q?YIgHWnWbegzWG6Lf4dYi5DocglApJz8WuzGq2USp0Z4+VcCoqNqwL06Qz9fQ?=
 =?us-ascii?Q?YTmVME8zKqGwA0/h5Z5kEkONqy1j+pzXx90km+o7feSArpDGaFMtsyTGAHP/?=
 =?us-ascii?Q?n9QusytaLrY0SxU4ChV2XZhvxvaoHPgbtkWnhYThzGzwaJ///6CeZSD/V5bT?=
 =?us-ascii?Q?cjBd+kKz5E5POjr0QjoSUreDL4hmNi+jzZy11UibXma9T/KAgwGlEkF5Jcm3?=
 =?us-ascii?Q?VfEWZs8FWReGMBPM683h4ALJDgErWtK68kvWaG/KP9HkKsIfTXeomIxZqR0g?=
 =?us-ascii?Q?Vcv2hCVjHKL3fyRwn5gHqSzRzIayn89iQgWJg5SlaI9dDTv1yA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:02:38.4266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8605f0-b26b-4b0b-cdfe-08dd07ea6ccb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249

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


