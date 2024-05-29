Return-Path: <linux-kselftest+bounces-10829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E918D3566
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 13:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FE128A136
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283C16DECF;
	Wed, 29 May 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="miHTnshf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EE16E89B;
	Wed, 29 May 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981710; cv=fail; b=Ukm1ddDRSBRlGLewDAPjwMJ2clPXG4DnaT9b2JqlIOIi98kDYvZAMkxtaFkOkOUeyU8F4QUIIQJbRYHB2TuyL94zhq/8y4coacl4oWzxW0qmbMX2n/C60ylshI9ayutCan/fwgM5eiKyvsxi1zgkecHcacGSEAL4u919cnEIT/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981710; c=relaxed/simple;
	bh=dHTyDr4TplIayyKkWv5mluQu6AGAz7jAy+hgFtRqvXM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGeEC6OFpGc0xTYREDbrO23I0jmuDjm73qZg3RbBHGkBh9tYtQAPrcS0cJvsV6H5gc4lTyD2hqerEmhKgPFIu6UhitoxGTuMYnb5t/1OtO0sBFN8TIrBQI/LA1mYCS7ivP0AKiWIYARI5RNbap1wqO9aFG5tmJCxyb0ERxoD1es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=miHTnshf; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIk2mxKFa4M7LvD3y0BYrw7LP2bbVnghb37GX88GKWXwqos/jT0vg6PdT5NPDvNDH1r37P2I/gXAycr6w0pbK8XzymfGVBJZDrkS4vd1JiLO7dnXcCEHOaX9sqtDf6ZGhIizQGdew3PtyTqolN464Znyv/BAYw/vMQRPIc8H7gAsT86wI/QEHX2pQLcH6ue1oFGvYMCwj2bC0z0d4HcAzyY5MK8s54du5VPXP6kyyfDY2CEDovLPl5gYT4TSUpLlGCacFA3D2CZi0zdNz+FWN+N5bWNs/Ib5KRbzTvh2cmtGc9onhcY65l5GFge3ik4/t5nnDecu/VwZTrozA8DNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5U0+PpsHh78Bp9LTwwLCWRzC3SIk8CvM9kMisVcwaU=;
 b=I/UR94s07k6aS/ENiB9M65rCDTkPO1ux3qKDgRLpQ+3Tq7isPF659BMsEcGiLQs72vbgNzAchg3rWkrVLvTLtVmTwWu7BxGm8+frooIfNI2WIXN35Dkr1Dvlmp2mljDkouKOn2SscvdUr806qFrfksN5GWo9kbvUOJZD5tNQQzCNoYdFPk+/SY/YUF5CTaxa/EcMqAN5I5gHiEdmQog7NNplnlTbEdFjs+kcCkdQO6a4okcQNLwFlvyCgtdNMYVD01wXdKzFjtQ+/TwDeAztYEbshf/pUejroDbjXXMYHl88x2UJt4IuCBMoitXGCERQfIoe6SjnXcfkyPnVUoFxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5U0+PpsHh78Bp9LTwwLCWRzC3SIk8CvM9kMisVcwaU=;
 b=miHTnshfoTiGBgk0HqBvWc1wa4TXIg/1nu+JutJnVCo2+jNRnUbzA+pjFxoRNzsn61r5ZQ1w1Fchpu0vvsOY/+QMd5gMa0IdYwpap+0Woa6KYxoxWqF8n3Dr8+Qr4ovWMSrLIkafq1IOTTzF0FjFjuD+sk/8rfgLZEIQ7HYe3KeC3QfHjceB2Xt197APwHADYMGJm+4LKQtIma7gECAxCqLJZLvEvo5zORBxsYlgFPQFkeATPtYsLEIM8sTM5jyAaOqDY78Tr1rQfKVc6qmETL+kStoPNfRucpdXkw67iqFTHWqN7O/wDn3zJ5UAoTZGqmB0lLgrmVx9cVINNEH+ig==
Received: from SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) by DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 11:21:45 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::45) by SN4PR0501CA0034.outlook.office365.com
 (2603:10b6:803:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18 via Frontend
 Transport; Wed, 29 May 2024 11:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:21:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:32 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:27 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 4/4] selftests: forwarding: router_mpath_hash: Add a new selftest
Date: Wed, 29 May 2024 13:18:44 +0200
Message-ID: <20240529111844.13330-5-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240529111844.13330-1-petrm@nvidia.com>
References: <20240529111844.13330-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: c78052de-b3f5-491e-451b-08dc7fd185f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G3N+tNPzQP6nTEI5c4oRj8mHFwRnUPl2HcQ7tU2c30HIRMTKdMgwFjp4l5ba?=
 =?us-ascii?Q?vOWGgbfvz5t9XJOb/bWkx4JFoafk2vWJVw1Js3hoJ0O7Vq+zKjWnowUgWtmg?=
 =?us-ascii?Q?RMMX3Cp3ZJG01W/PfYxVTFM2G4epCbiEZu6svNzksdELx+vhhyZf14ek74K3?=
 =?us-ascii?Q?hfwvxSlyvzza+nmQghXpJpjuC+3HqFH/wH0sY4vMBmnVxjx3O3E0TL/8xwLe?=
 =?us-ascii?Q?3z3BTyqZmLQMZcY8zNFRp7QtASzzgBXUvTJtYwkeFfi/zcBsuM9chqOwmcbu?=
 =?us-ascii?Q?N3PWkQwqHuwGYVEpIJyuRgEnq5LMPtIvYwcdjq5DB6lD54fYesi+3UWBaKks?=
 =?us-ascii?Q?CgFo/lOZsDMW36a0iKcmF79AMTlkbKw/tUfCv3pNl3SHv3M+d7IB1xYGQzDj?=
 =?us-ascii?Q?vcYiVyPLqTI6euI5JbJlOT+hCj4gw55oGSQJ44/F/qFr8Te+y22cmCxRuX1y?=
 =?us-ascii?Q?/mFvwrvnJrtVEEfBFJBfzTZZuP+Q7ZZdvv4WcYC0AInAD/iCPMISPz1yLFcD?=
 =?us-ascii?Q?5+BkHFTCf0vczpddjfwXrKfh9LmkDopgilLRoJ2qPh/2iEjnUfEpToyKNbNn?=
 =?us-ascii?Q?O4yLmIV+v/SmBeaKAQc5XVdQCTl5i5Wak95xxj3u3Ora0uIgdyhThnnfvK7O?=
 =?us-ascii?Q?bpQCsGDpLLo9EPS8KOGgS7orOSY2Ah5JyuRVFgDiZsJjt4cbKnHd3rxy5SN2?=
 =?us-ascii?Q?cWQP/ImbAwaXPNin1qNG3HFAvIdhJimeaUAJD/9YJWDuBZ+5xopBfg1UruFr?=
 =?us-ascii?Q?Q9HmQe/yW276TY2gj+do6MG8E82gMCJn4POIX45alrHlXdyM23IRN8/Fqu6x?=
 =?us-ascii?Q?mcduO1Zywi45rl7K9i2KveRrWgl1TtH7qLQgoTdnI9fu5Fu3HIqs/jJLVsQs?=
 =?us-ascii?Q?KKtFXfr8HNrV+vHKvwY76QgWREnMXv5HoYb1rdC5zjqOyWWlmMccOQarm8bj?=
 =?us-ascii?Q?PowNWNRQ0O/Gqge33uddJ8vs80+ORKgsqwYMi4xRcX2KOWYcJA+TPDSnIJAK?=
 =?us-ascii?Q?xGqnwP0Cca1YTAM9g2t/lX9NXXwxSXSUlLedVRTcUMc2+kj1dhq2Jrj2fURu?=
 =?us-ascii?Q?rjfDwaWz5QJ5Y3E3Mc9C0G5skZRuIfW5RLxCXQASxdAzDTQDigV+hecazdGb?=
 =?us-ascii?Q?ejM5lQHxn6vmFcgeCVcCve9GEchLpfCFY3UkTPbBY5La0a5mylyhfSjJXYvt?=
 =?us-ascii?Q?FxOWokDe0qhuIN66C0Yr8lP7LlcTsuHKoR6oNUE8ccVdVw8w5EA25Z6g1GLV?=
 =?us-ascii?Q?ZwzANInZX8ItIQICUkvRvSNhKCwUUzJGGJsGlxx/uq0fCyKkVhs7SgPs8xW4?=
 =?us-ascii?Q?TW1m8veNCQrl00kT26udt64Zvife7yOmkufVSgIaj9J2C4BT6fC/43V3jZz4?=
 =?us-ascii?Q?PYG8po4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:21:45.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c78052de-b3f5-491e-451b-08dc7fd185f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283

Add a selftest that exercises the sysctl added in the previous patches.

Test that set/get works as expected; that across seeds we eventually hit
all NHs (test_mpath_seed_*); and that a given seed keeps hitting the same
NHs even across seed changes (test_mpath_seed_stability_*).

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org

 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_mpath_seed.sh       | 322 ++++++++++++++++++
 2 files changed, 323 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/router_mpath_seed.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index fa7b59ff4029..99576d7ecbf6 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -70,6 +70,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	router_broadcast.sh \
 	router_mpath_nh_res.sh \
 	router_mpath_nh.sh \
+	router_mpath_seed.sh \
 	router_multicast.sh \
 	router_multipath.sh \
 	router_nh.sh \
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_seed.sh b/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
new file mode 100755
index 000000000000..0ef3687da8b2
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
@@ -0,0 +1,322 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-------------------------+  +-------------------------+
+# |  H1                     |  |                      H2 |
+# |               $h1 +     |  | + $h2                   |
+# |      192.0.2.1/28 |     |  | | 192.0.2.34/28         |
+# |  2001:db8:1::1/64 |     |  | | 2001:db8:3::2/64      |
+# +-------------------|-----+  +-|-----------------------+
+#                     |          |
+# +-------------------|-----+  +-|-----------------------+
+# |  R1               |     |  | |                    R2 |
+# |             $rp11 +     |  | + $rp21                 |
+# |      192.0.2.2/28       |  |   192.0.2.33/28         |
+# |  2001:db8:1::2/64       |  |   2001:db8:3::1/64      |
+# |                         |  |                         |
+# |             $rp12 +     |  | + $rp22                 |
+# |     192.0.2.17/28 |     |  | | 192.0.2.18..27/28     |
+# | 2001:db8:2::17/64 |     |  | | 2001:db8:2::18..27/64 |
+# +-------------------|-----+  +-|-----------------------+
+#                     |          |
+#                     `----------'
+
+ALL_TESTS="
+	ping_ipv4
+	ping_ipv6
+	test_mpath_seed_get
+	test_mpath_seed_ipv4
+	test_mpath_seed_ipv6
+	test_mpath_seed_stability_ipv4
+	test_mpath_seed_stability_ipv6
+"
+NUM_NETIFS=6
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1 192.0.2.1/28 2001:db8:1::1/64
+	ip -4 route add 192.0.2.32/28 vrf v$h1 nexthop via 192.0.2.2
+	ip -6 route add 2001:db8:3::/64 vrf v$h1 nexthop via 2001:db8:1::2
+}
+
+h1_destroy()
+{
+	ip -6 route del 2001:db8:3::/64 vrf v$h1 nexthop via 2001:db8:1::2
+	ip -4 route del 192.0.2.32/28 vrf v$h1 nexthop via 192.0.2.2
+	simple_if_fini $h1 192.0.2.1/28 2001:db8:1::1/64
+}
+
+h2_create()
+{
+	simple_if_init $h2 192.0.2.34/28 2001:db8:3::2/64
+	ip -4 route add 192.0.2.0/28 vrf v$h2 nexthop via 192.0.2.33
+	ip -6 route add 2001:db8:1::/64 vrf v$h2 nexthop via 2001:db8:3::1
+}
+
+h2_destroy()
+{
+	ip -6 route del 2001:db8:1::/64 vrf v$h2 nexthop via 2001:db8:3::1
+	ip -4 route del 192.0.2.0/28 vrf v$h2 nexthop via 192.0.2.33
+	simple_if_fini $h2 192.0.2.34/28 2001:db8:3::2/64
+}
+
+router1_create()
+{
+	simple_if_init $rp11 192.0.2.2/28 2001:db8:1::2/64
+	__simple_if_init $rp12 v$rp11 192.0.2.17/28 2001:db8:2::17/64
+}
+
+router1_destroy()
+{
+	__simple_if_fini $rp12 192.0.2.17/28 2001:db8:2::17/64
+	simple_if_fini $rp11 192.0.2.2/28 2001:db8:1::2/64
+}
+
+router2_create()
+{
+	simple_if_init $rp21 192.0.2.33/28 2001:db8:3::1/64
+	__simple_if_init $rp22 v$rp21 192.0.2.18/28 2001:db8:2::18/64
+	ip -4 route add 192.0.2.0/28 vrf v$rp21 nexthop via 192.0.2.17
+	ip -6 route add 2001:db8:1::/64 vrf v$rp21 nexthop via 2001:db8:2::17
+}
+
+router2_destroy()
+{
+	ip -6 route del 2001:db8:1::/64 vrf v$rp21 nexthop via 2001:db8:2::17
+	ip -4 route del 192.0.2.0/28 vrf v$rp21 nexthop via 192.0.2.17
+	__simple_if_fini $rp22 192.0.2.18/28 2001:db8:2::18/64
+	simple_if_fini $rp21 192.0.2.33/28 2001:db8:3::1/64
+}
+
+nexthops_create()
+{
+	local i
+	for i in $(seq 10); do
+		ip nexthop add id $((1000 + i)) via 192.0.2.18 dev $rp12
+		ip nexthop add id $((2000 + i)) via 2001:db8:2::18 dev $rp12
+	done
+
+	ip nexthop add id 1000 group $(seq -s / 1001 1010) hw_stats on
+	ip nexthop add id 2000 group $(seq -s / 2001 2010) hw_stats on
+	ip -4 route add 192.0.2.32/28 vrf v$rp11 nhid 1000
+	ip -6 route add 2001:db8:3::/64 vrf v$rp11 nhid 2000
+}
+
+nexthops_destroy()
+{
+	local i
+
+	ip -6 route del 2001:db8:3::/64 vrf v$rp11 nhid 2000
+	ip -4 route del 192.0.2.32/28 vrf v$rp11 nhid 1000
+	ip nexthop del id 2000
+	ip nexthop del id 1000
+
+	for i in $(seq 10 -1 1); do
+		ip nexthop del id $((2000 + i))
+		ip nexthop del id $((1000 + i))
+	done
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	rp11=${NETIFS[p2]}
+
+	rp12=${NETIFS[p3]}
+	rp22=${NETIFS[p4]}
+
+	rp21=${NETIFS[p5]}
+	h2=${NETIFS[p6]}
+
+	sysctl_set net.ipv4.fib_multipath_hash_seed 0
+
+	vrf_prepare
+
+	h1_create
+	h2_create
+	router1_create
+	router2_create
+
+	forwarding_enable
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	forwarding_restore
+
+	nexthops_destroy
+	router2_destroy
+	router1_destroy
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+
+	sysctl_restore net.ipv4.fib_multipath_hash_seed
+}
+
+ping_ipv4()
+{
+	ping_test $h1 192.0.2.34
+}
+
+ping_ipv6()
+{
+	ping6_test $h1 2001:db8:3::2
+}
+
+test_mpath_seed_get()
+{
+	RET=0
+
+	local i
+	for ((i = 0; i < 100; i++)); do
+		local seed_w=$((999331 * i))
+		sysctl -qw net.ipv4.fib_multipath_hash_seed=$seed_w
+		local seed_r=$(sysctl -n net.ipv4.fib_multipath_hash_seed)
+		((seed_r == seed_w))
+		check_err $? "mpath seed written as $seed_w, but read as $seed_r"
+	done
+
+	log_test "mpath seed set/get"
+}
+
+nh_stats_snapshot()
+{
+	local group_id=$1; shift
+
+	ip -j -s -s nexthop show id $group_id |
+	    jq -c '[.[].group_stats | sort_by(.id) | .[].packets]'
+}
+
+get_active_nh()
+{
+	local s0=$1; shift
+	local s1=$1; shift
+
+	jq -n --argjson s0 "$s0" --argjson s1 "$s1" -f /dev/stdin <<-"EOF"
+		[range($s0 | length)] |
+		map($s1[.] - $s0[.]) |
+		map(if . > 8 then 1 else 0 end) |
+		index(1)
+	EOF
+}
+
+probe_seed()
+{
+	local group_id=$1; shift
+	local seed=$1; shift
+	local -a mz=("$@")
+
+	sysctl -qw net.ipv4.fib_multipath_hash_seed=$seed
+
+	local s0=$(nh_stats_snapshot $group_id)
+	"${mz[@]}"
+	local s1=$(nh_stats_snapshot $group_id)
+
+	get_active_nh "$s0" "$s1"
+}
+
+test_mpath_seed()
+{
+	local group_id=$1; shift
+	local what=$1; shift
+	local -a mz=("$@")
+	local ii
+
+	RET=0
+
+	local -a tally=(0 0 0 0 0 0 0 0 0 0)
+	for ((ii = 0; ii < 100; ii++)); do
+		local act=$(probe_seed $group_id $((999331 * ii)) "${mz[@]}")
+		((tally[act]++))
+	done
+
+	local tally_str="${tally[@]}"
+	for ((ii = 0; ii < ${#tally[@]}; ii++)); do
+		((tally[ii] > 0))
+		check_err $? "NH #$ii not hit, tally='$tally_str'"
+	done
+
+	log_test "mpath seed $what"
+	sysctl -qw net.ipv4.fib_multipath_hash_seed=0
+}
+
+test_mpath_seed_ipv4()
+{
+	test_mpath_seed 1000 IPv4 \
+		$MZ $h1 -A 192.0.2.1 -B 192.0.2.34 -q \
+			-p 64 -d 0 -c 10 -t udp
+}
+
+test_mpath_seed_ipv6()
+{
+	test_mpath_seed 2000 IPv6 \
+		$MZ -6 $h1 -A 2001:db8:1::1 -B 2001:db8:3::2 -q \
+			-p 64 -d 0 -c 10 -t udp
+}
+
+check_mpath_seed_stability()
+{
+	local seed=$1; shift
+	local act_0=$1; shift
+	local act_1=$1; shift
+
+	((act_0 == act_1))
+	check_err $? "seed $seed: active NH moved from $act_0 to $act_1 after seed change"
+}
+
+test_mpath_seed_stability()
+{
+	local group_id=$1; shift
+	local what=$1; shift
+	local -a mz=("$@")
+
+	RET=0
+
+	local seed_0=0
+	local seed_1=3221338814
+	local seed_2=3735928559
+
+	local act_0_0=$(probe_seed $group_id $seed_0 "${mz[@]}")
+	local act_1_0=$(probe_seed $group_id $seed_1 "${mz[@]}")
+	local act_2_0=$(probe_seed $group_id $seed_2 "${mz[@]}")
+
+	local act_0_1=$(probe_seed $group_id $seed_0 "${mz[@]}")
+	local act_1_1=$(probe_seed $group_id $seed_1 "${mz[@]}")
+	local act_2_1=$(probe_seed $group_id $seed_2 "${mz[@]}")
+
+	check_mpath_seed_stability $seed_0 $act_0_0 $act_0_1
+	check_mpath_seed_stability $seed_1 $act_1_0 $act_1_1
+	check_mpath_seed_stability $seed_2 $act_2_0 $act_2_1
+
+	log_test "mpath seed stability $what"
+	sysctl -qw net.ipv4.fib_multipath_hash_seed=0
+}
+
+test_mpath_seed_stability_ipv4()
+{
+	test_mpath_seed_stability 1000 IPv4 \
+		$MZ $h1 -A 192.0.2.1 -B 192.0.2.34 -q \
+			-p 64 -d 0 -c 10 -t udp
+}
+
+test_mpath_seed_stability_ipv6()
+{
+	test_mpath_seed_stability 2000 IPv6 \
+		$MZ -6 $h1 -A 2001:db8:1::1 -B 2001:db8:3::2 -q \
+			-p 64 -d 0 -c 10 -t udp
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+nexthops_create
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.45.0


