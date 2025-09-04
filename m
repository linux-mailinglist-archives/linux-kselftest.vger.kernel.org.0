Return-Path: <linux-kselftest+bounces-40797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B19B4441C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113F4A47822
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839331DDAF;
	Thu,  4 Sep 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sC9/nxKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF131A57D;
	Thu,  4 Sep 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005805; cv=fail; b=eUWWiTugRCzErELxjAHhWBhiTj0TEfIcN1NYULE4W5FPcYTf+8WphQ9mLkn/O+z19WbLLvOgXCyemDv3ox4QEbAJuJh/6hzkp2mSdDzUvupVw9z8c9b1PcQV0e7frmP92DaZs8noJpzPjXBZwME73mQIjDo+xLysa7lM4dESKus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005805; c=relaxed/simple;
	bh=bq9cGEt2ioA4lzn7eM2vP4Dq9g+/9Da5s83XTCCakOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMSEVlOnNHTkR/B/nI6WP+SWFPO6P2Co5EpZhCeN9CRhA8BVMjAqhYO5pGEID7rcsGDYHMrxNlwzuCytfzHnROWvXldeuBQUF/nujg+eMdYFs2oCg3u3dgsD9yoFku4ubvnlPwmOlo8uXjCA7ZcnKyooTFIK4dztuDgsH5QAXUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sC9/nxKo; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYXzJSkkKR6blVin5Y7VzFMLkogpiY+Iz0ouwQVhLaJsWVGyo8ttiXCUdkvlQFcj3bh4QBQsSELuMvXJtHqOrvzW7n4Phx69VN9ecmyU432fvtEc0PORMQzn/WJAFUzZXVqqe6MnSrweozv0lvyAftb6HQ8zYOiMw6ObTY+Jn0W47Dq12i8XERBL1wqI6QLCYbId8hLBB9ePky4nvRtnjOnI9Y0AACxUPOSKpxwLTt03OMQUbiN/F0k61qBEp53gdQ1MxUy1oJ+oxQ//7Kx8+3BFe5JOBr+qg0L6Vou+JAvOY8xB/OLj56d9p58GJdDp2P4/bQbSUQ2Onl2+ggu18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0gwFLbstI0bne31Dy5BdFXkd1Fj3ZoNH/VAuS/3Sxc=;
 b=hPb2g9CiGjUH65ox9L9mGEhdwizwfcw96xcbO56bnUtfEFcu54wAapEP/lfZHAXiJtZLPGSKUVtAMIRrTNyVOdJ/7fsG2LUzJPjEJ+pwFYVcJiCSGrn8/vpoM2rkVbrM9hHOGEYJyYz1kv8Uo3H5IZQXUEjodBUtlDDCXXu/uebaeE5cc7iUZ0Q33OWK6L6TJs3xpWYJjflXY7j44QK6UlG+Xe5tUiG/xM2juzAbOWsqVnXxyuFmWMlbJiLLURKRSTlVGyMyEW9Xq4Ge5V/VsCr12jswAZHUClKy3DSka/CmUo02viknoAOnjEAQ621qvvYUIVOTMK3Zn7JVnsx2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0gwFLbstI0bne31Dy5BdFXkd1Fj3ZoNH/VAuS/3Sxc=;
 b=sC9/nxKo0CMUzBZom1tj9fRBKvSehb3LEcdas++nca/wdp72ZkNguLnBQDtUTwd/qFgcmrrdVBpuW1ZONvYQCQCZp1oVDDWGD1T7/3HD6a/OOLDnJIZiN+fs9djW/8aJODf+nd65B0V1+Gc/jnvpFyc2Og01Tz2JAhCebqkt+NxP19+XUr0M6WAsFcL0GYUO7iuxQ3U0FWajkhzz90jAHLFIrLPjKBdVQ78AOC/qurVEvy/JJu3qCwkAr+18zfkSKUu8Vd886DCCuIlPiCmCEf9R1gTDLZngiFYz8S1/6NCGMS2w8k6tAqez9N7O+dSFCVUNiwYEt6e+CQ84WgrpGw==
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by CH1PPFA0A5C3BCA.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 17:10:00 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::1c) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 17:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:39 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:09:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 10/10] selftests: forwarding: Add test for BR_BOOLOPT_FDB_LOCAL_VLAN_0
Date: Thu, 4 Sep 2025 19:07:27 +0200
Message-ID: <62294f96884ab5d341648eef21243fa099a2dee5.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CH1PPFA0A5C3BCA:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b6c83e-5fee-4d22-bf9d-08ddebd5e14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?599b29z1qyDu7SLmgphw8J/fQTHXf0+Nb+ra6u0vaLlyizP3YKO5XK7RGDy4?=
 =?us-ascii?Q?Vsv3SZmef0BEYjW3MdflHKDrlkz51JUUSpNMO756FCFrAmUivdYyZbCTSanD?=
 =?us-ascii?Q?LNrqcFz3idTP3dYI9x6059O/IzGrlxieLdb/Sjxc2NkDsf3O3bSSw7GLkD3Y?=
 =?us-ascii?Q?fpHQFytbCtJjt3cM9LDM9BqDzem49tUsXRxI0v2jo22NafcOejSesiGtP3OG?=
 =?us-ascii?Q?BPVR0bmAJGt45fTdub+o0sLQVvlh250MhO5Jm9Ak/419+GV01KncoPvpoFUm?=
 =?us-ascii?Q?xajJkvlimHaG+0Y1KeAakhmQUck9B67mpVV/FvgjYlrcBiZ0d5PShWD8tkkZ?=
 =?us-ascii?Q?wU6qitHDc/RfZFCNmCSJzUlj7r2W9SMKWTajqvnhh+28a0vm2Nd6WQtMq+kQ?=
 =?us-ascii?Q?bVW4vEPPXLsipFr82NwxcI0qG9+ymNY6RN5H8O2McqBBiFRk+GG1AcnZ3lM9?=
 =?us-ascii?Q?uxSsFKvqK7FbDR/HN6cUvo5nt7rB2xm2VTcQ5or3Omybsq5Dh7jyr7Mty8EE?=
 =?us-ascii?Q?tuiPhIvoRqkhn+5W+/o4v55ZTyh7WH6ulK6Vn5dVDGeQA1K9iG14t617usp+?=
 =?us-ascii?Q?61NhDR+PBvHpA34VsYbHvNJK+U45RVuzOMGTalurPyEL+PIz/3ypFolulYzz?=
 =?us-ascii?Q?FbGXeKuAf3MSoqLP0FK7BkNkZz2GAiJ0oG3zRmSpaUPijblMQ8m59S7f2+Ns?=
 =?us-ascii?Q?/7ZSqzRDdldu4f/EuzOHM691DK/r1GNEjQPn2aq9XvzsMAus297DKu3D3cnG?=
 =?us-ascii?Q?SUBR12FKxCnDNTVxJi5ZmQpBtS7sg/TJmefO1JtqYqV8CQ+DiPWHZCxHB5Ir?=
 =?us-ascii?Q?/KmglB3RzBvvEUBQiqY1V43Zo1vZXkxTH2iySViJ+j4SAfkxSiTQ7Vm0MHZ2?=
 =?us-ascii?Q?XrRYb5uEMOsEVnfd2Um0J8neJex1YAikCNNsKqpaj69iBdnJUbdH5/Vr72NA?=
 =?us-ascii?Q?tOGdpak2muyegAkgNdg2qgocibxy2QMJ7ujH7yh/vQs83FAiB81fdMNUmTK5?=
 =?us-ascii?Q?s+hm5vrLoE+pHl4ByOlRd1zXb6O4cBwkLCzEE6Ucs6ABa41UD6ebeUJXzc7H?=
 =?us-ascii?Q?xSql4xn55En4hc6Yg6GfvsAE+/2MFPJUr0Bo734W/KyvK0TjsKt7UH9AH7Yt?=
 =?us-ascii?Q?9J62csqSjhOif/nUIwT0WmyFjgMIrDb2WOCXmOavWKJU7t5u6HhNSTIaja6c?=
 =?us-ascii?Q?0ivbN/e4otIQGPvXjCHsIWy/6wUPr0JdxpyiOrowbrWJcJKJ6FFtPrSHyVKK?=
 =?us-ascii?Q?vHI5yRJZxNQMxxDeZfJasY43g39iQmsomh8sIyfpOeHY2Dd15JCgCvx6DJvT?=
 =?us-ascii?Q?mk2d6lK+boD4f+HtySGDl6x/zfp48WsydVejWuhIB9MueFkcT2dNHLjaMA6T?=
 =?us-ascii?Q?qQnMOvd3HAwG+843Ah00fojEUsw16ltsTYjUWYB2ZNR9jPq9e3+5e33z7rmO?=
 =?us-ascii?Q?RTj7d2055FMRXUnFAwggytFHor+OBcvWCAVGGkEiFVBkWs4ICoz2YVv7vAv+?=
 =?us-ascii?Q?eOmF9h5n2tavJQu/TgLp0URdC3oKiWKakrhB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:59.6360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b6c83e-5fee-4d22-bf9d-08ddebd5e14a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFA0A5C3BCA

Add a selftest to check the operation of this newly-introduced bridge
option.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/bridge_fdb_local_vlan_0.sh | 374 ++++++++++++++++++
 2 files changed, 375 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 0a0d4c2a85f7..e6f482a600da 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -5,6 +5,7 @@ TEST_PROGS = \
 	bridge_fdb_learning_limit.sh \
 	bridge_igmp.sh \
 	bridge_locked_port.sh \
+	bridge_fdb_local_vlan_0.sh \
 	bridge_mdb.sh \
 	bridge_mdb_host.sh \
 	bridge_mdb_max.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
new file mode 100755
index 000000000000..5a0b43aff5aa
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -0,0 +1,374 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-----------------------+ +-----------------------+ +-----------------------+
+# | H1 (vrf)              | | H2 (vrf)              | | H3 (vrf)              |
+# |    + $h1              | |    + $h2              | |    + $h3              |
+# |    | 192.0.2.1/28     | |    | 192.0.2.2/28     | |    | 192.0.2.18/28    |
+# |    | 2001:db8:1::1/64 | |    | 2001:db8:1::2/64 | |    | 2001:db8:2::2/64 |
+# |    |                  | |    |                  | |    |                  |
+# +----|------------------+ +----|------------------+ +----|------------------+
+#      |                         |                         |
+# +----|-------------------------|-------------------------|------------------+
+# | +--|-------------------------|------------------+      |                  |
+# | |  + $swp1                   + $swp2            |      + $swp3            |
+# | |                                               |        192.0.2.17/28    |
+# | |  BR1 (802.1q)                                 |        2001:db8:2::1/64 |
+# | |  192.0.2.3/28                                 |                         |
+# | |  2001:db8:1::3/64                             |                         |
+# | +-----------------------------------------------+                      SW |
+# +---------------------------------------------------------------------------+
+#
+#shellcheck disable=SC2317 # SC doesn't see our uses of functions.
+#shellcheck disable=SC2034 # ... and global variables
+
+ALL_TESTS="
+	test_d_no_sharing
+	test_d_sharing
+	test_q_no_sharing
+	test_q_sharing
+"
+
+NUM_NETIFS=6
+source lib.sh
+
+pMAC=00:11:22:33:44:55
+bMAC=00:11:22:33:44:66
+mMAC=00:11:22:33:44:77
+xMAC=00:11:22:33:44:88
+
+host_create()
+{
+	local h=$1; shift
+	local ipv4=$1; shift
+	local ipv6=$1; shift
+
+	simple_if_init "$h" "$ipv4" "$ipv6"
+	defer simple_if_fini "$h" "$ipv4" "$ipv6"
+
+	ip_route_add vrf "v$h" 192.0.2.16/28 nexthop via 192.0.2.3
+	ip_route_add vrf "v$h" 2001:db8:2::/64 nexthop via 2001:db8:1::3
+}
+
+h3_create()
+{
+	simple_if_init "$h3" 192.0.2.18/28 2001:db8:2::2/64
+	defer simple_if_fini "$h3" 192.0.2.18/28 2001:db8:2::2/64
+
+	ip_route_add vrf "v$h3" 192.0.2.0/28 nexthop via 192.0.2.17
+	ip_route_add vrf "v$h3" 2001:db8:1::/64 nexthop via 2001:db8:2::1
+
+	tc qdisc add dev "$h3" clsact
+	defer tc qdisc del dev "$h3" clsact
+
+	tc filter add dev "$h3" ingress proto ip pref 104 \
+	   flower skip_hw ip_proto udp dst_port 4096 \
+	   action pass
+	defer tc filter del dev "$h3" ingress proto ip pref 104
+
+	tc qdisc add dev "$h2" clsact
+	defer tc qdisc del dev "$h2" clsact
+
+	tc filter add dev "$h2" ingress proto ip pref 104 \
+	   flower skip_hw ip_proto udp dst_port 4096 \
+	   action pass
+	defer tc filter del dev "$h2" ingress proto ip pref 104
+}
+
+switch_create()
+{
+	ip_link_set_up "$swp1"
+
+	ip_link_set_up "$swp2"
+
+	ip_addr_add "$swp3" 192.0.2.17/28
+	ip_addr_add "$swp3" 2001:db8:2::1/64
+	ip_link_set_up "$swp3"
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+
+	swp3=${NETIFS[p5]}
+	h3=${NETIFS[p6]}
+
+	vrf_prepare
+	defer vrf_cleanup
+
+	forwarding_enable
+	defer forwarding_restore
+
+	host_create "$h1" 192.0.2.1/28 2001:db8:1::1/64
+	host_create "$h2" 192.0.2.2/28 2001:db8:1::2/64
+	h3_create
+
+	switch_create
+}
+
+adf_bridge_create()
+{
+	local dev
+	local mac
+
+	ip_link_add br up type bridge vlan_default_pvid 0 "$@"
+	mac=$(mac_get br)
+	ip_addr_add br 192.0.2.3/28
+	ip_addr_add br 2001:db8:1::3/64
+
+	bridge_vlan_add dev br vid 1 pvid untagged self
+	bridge_vlan_add dev br vid 2 self
+	bridge_vlan_add dev br vid 3 self
+
+	for dev in "$swp1" "$swp2"; do
+		ip_link_set_master "$dev" br
+		bridge_vlan_add dev "$dev" vid 1 pvid untagged
+		bridge_vlan_add dev "$dev" vid 2
+		bridge_vlan_add dev "$dev" vid 3
+	done
+
+	ip_link_set_addr br "$mac"
+}
+
+check_fdb_local_vlan_0_support()
+{
+	if ip_link_add XXbr up type bridge vlan_filtering 1 fdb_local_vlan_0 1 \
+		    &>/dev/null; then
+		return 0
+	fi
+
+	log_test_skip "FDB sharing" \
+		      "iproute 2 or the kernel do not support fdb_local_vlan_0"
+}
+
+check_mac_presence()
+{
+	local should_fail=$1; shift
+	local dev=$1; shift
+	local vlan=$1; shift
+	local mac
+
+	mac=$(mac_get "$dev")
+
+	if ((vlan == 0)); then
+		vlan=null
+	fi
+
+	bridge -j fdb show dev "$dev" |
+	    jq -e --arg mac "$mac" --argjson vlan "$vlan" \
+	       '.[] | select(.mac == $mac) | select(.vlan == $vlan)' > /dev/null
+	check_err_fail "$should_fail" $? "FDB dev $dev vid $vlan addr $mac exists"
+}
+
+do_sharing_test()
+{
+	local should_fail=$1; shift
+	local what=$1; shift
+	local dev
+
+	RET=0
+
+	for dev in "$swp1" "$swp2" br; do
+		check_mac_presence 0 "$dev" 0
+		check_mac_presence "$should_fail" "$dev" 1
+		check_mac_presence "$should_fail" "$dev" 2
+		check_mac_presence "$should_fail" "$dev" 3
+	done
+
+	log_test "$what"
+}
+
+do_end_to_end_test()
+{
+	local mac=$1; shift
+	local what=$1; shift
+	local probe_dev=${1-$h3}; shift
+	local expect=${1-10}; shift
+
+	local t0
+	local t1
+	local dd
+
+	RET=0
+
+	# In mausezahn, use $dev MAC as the destination MAC. In the MAC sharing
+	# context, that will cause an FDB miss on VLAN 1 and prompt a second
+	# lookup in VLAN 0.
+
+	t0=$(tc_rule_stats_get "$probe_dev" 104 ingress)
+
+	$MZ "$h1" -c 10 -p 64 -a own -b "$mac" \
+		  -A 192.0.2.1 -B 192.0.2.18 -t udp "dp=4096,sp=2048" -q
+	sleep 1
+
+	t1=$(tc_rule_stats_get "$probe_dev" 104 ingress)
+	dd=$((t1 - t0))
+
+	((dd == expect))
+	check_err $? "Expected $expect packets on $probe_dev got $dd"
+
+	log_test "$what"
+}
+
+do_tests()
+{
+	local should_fail=$1; shift
+	local what=$1; shift
+	local swp1_mac
+	local br_mac
+
+	swp1_mac=$(mac_get "$swp1")
+	br_mac=$(mac_get br)
+
+	do_sharing_test "$should_fail" "$what"
+	do_end_to_end_test "$swp1_mac" "$what: end to end, $swp1 MAC"
+	do_end_to_end_test "$br_mac" "$what: end to end, br MAC"
+}
+
+bridge_standard()
+{
+	local vlan_filtering=$1; shift
+
+	if ((vlan_filtering)); then
+		echo 802.1q
+	else
+		echo 802.1d
+	fi
+}
+
+nonexistent_fdb_test()
+{
+	local vlan_filtering=$1; shift
+	local standard
+
+	standard=$(bridge_standard "$vlan_filtering")
+
+	# We expect flooding, so $h2 should get the traffic.
+	do_end_to_end_test "$xMAC" "$standard: Nonexistent FDB" "$h2"
+}
+
+misleading_fdb_test()
+{
+	local vlan_filtering=$1; shift
+	local standard
+
+	standard=$(bridge_standard "$vlan_filtering")
+
+	defer_scope_push
+		# Add an FDB entry on VLAN 0. The lookup on VLAN-aware bridge
+		# shouldn't pick this up even with fdb_local_vlan_0 enabled, so
+		# the traffic should be flooded. This all holds on
+		# vlan_filtering bridge, on non-vlan_filtering one the FDB entry
+		# is expected to be found as usual, no flooding takes place.
+		#
+		# Adding only on VLAN 0 is a bit tricky, because bridge is
+		# trying to be nice and interprets the request as if the FDB
+		# should be added on each VLAN.
+
+		bridge fdb add "$mMAC" dev "$swp1" master
+		bridge fdb del "$mMAC" dev "$swp1" vlan 1 master
+		bridge fdb del "$mMAC" dev "$swp1" vlan 2 master
+		bridge fdb del "$mMAC" dev "$swp1" vlan 3 master
+
+		local expect=$((vlan_filtering ? 10 : 0))
+		do_end_to_end_test "$mMAC" \
+				   "$standard: Lookup of non-local MAC on VLAN 0" \
+				   "$h2" "$expect"
+	defer_scope_pop
+}
+
+change_mac()
+{
+	local dev=$1; shift
+	local mac=$1; shift
+	local cur_mac
+
+	cur_mac=$(mac_get "$dev")
+
+	log_info "Change $dev MAC $cur_mac -> $mac"
+	ip_link_set_addr "$dev" "$mac"
+	defer log_info "Change $dev MAC back"
+}
+
+do_test_no_sharing()
+{
+	local vlan_filtering=$1; shift
+	local standard
+
+	standard=$(bridge_standard "$vlan_filtering")
+
+	adf_bridge_create vlan_filtering "$vlan_filtering"
+	setup_wait
+
+	do_tests 0 "$standard, no FDB sharing"
+
+	change_mac "$swp1" "$pMAC"
+	change_mac br "$bMAC"
+
+	do_tests 0 "$standard, no FDB sharing after MAC change"
+
+	in_defer_scope check_fdb_local_vlan_0_support || return
+
+	log_info "Set fdb_local_vlan_0=1"
+	ip link set dev br type bridge fdb_local_vlan_0 1
+
+	do_tests 1 "$standard, fdb sharing after toggle"
+}
+
+do_test_sharing()
+{
+	local vlan_filtering=$1; shift
+	local standard
+
+	standard=$(bridge_standard "$vlan_filtering")
+
+	in_defer_scope check_fdb_local_vlan_0_support || return
+
+	adf_bridge_create vlan_filtering "$vlan_filtering" fdb_local_vlan_0 1
+	setup_wait
+
+	do_tests 1 "$standard, FDB sharing"
+
+	nonexistent_fdb_test "$vlan_filtering"
+	misleading_fdb_test "$vlan_filtering"
+
+	change_mac "$swp1" "$pMAC"
+	change_mac br "$bMAC"
+
+	do_tests 1 "$standard, FDB sharing after MAC change"
+
+	log_info "Set fdb_local_vlan_0=0"
+	ip link set dev br type bridge fdb_local_vlan_0 0
+
+	do_tests 0 "$standard, No FDB sharing after toggle"
+}
+
+test_d_no_sharing()
+{
+	do_test_no_sharing 0
+}
+
+test_d_sharing()
+{
+	do_test_sharing 0
+}
+
+test_q_no_sharing()
+{
+	do_test_no_sharing 1
+}
+
+test_q_sharing()
+{
+	do_test_sharing 1
+}
+
+
+trap cleanup EXIT
+
+setup_prepare
+tests_run
-- 
2.49.0


