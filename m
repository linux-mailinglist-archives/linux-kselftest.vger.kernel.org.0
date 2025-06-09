Return-Path: <linux-kselftest+bounces-34520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37226AD2823
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 22:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06653189515C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FF221283;
	Mon,  9 Jun 2025 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QM/TMkQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B78F40;
	Mon,  9 Jun 2025 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502387; cv=fail; b=dDSbRLm+Xcr7XP1oYtvciRH/wTdbDOFECxyBAANTJoXxJ+52uliHOE4glR1ikM3N8Ty51rrb5r9ieTop67Qw6BrHp+0u2+3ANaOne81UDVaXztqfnNjnW7iW9+s5yHr2Al7rsX0tgqpslPiTyq87XLxM6G7hjQFDxjn+MsAiN74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502387; c=relaxed/simple;
	bh=mi4vLQ7aFd9G0Q9b1eQEt108itILv75PpVEYulGorgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRRIUNVokpmmc27jtkjXUl9aBXLfgRccrTCC11e5LzrALW2C6qxaDlibIPv5I2O6A2Nlc1kLgtUcMrHxJEyn+4FQnWn5Fxdu/xDQl5DZRVF7/sOG91PMqKf4ks6rXkcOcehRHLaWNdUnuhz8iwgKXXKUmxWdY0qMOs4As07qdNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QM/TMkQ/; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l43vT/4jG8esW1EZzB/F2TN/qom6mFtSS2oyQZOS+2msfGrKK4FnPrjlAnULFkj5TwYp3vQyNBajaRpIJP7j2MoxErUcbEDuS+36WF1lXPO3ebYuH7kknkvPHshA0hCOAkVF2MhWWXvSlb7u2p7q0B8D1kxuK6YZuXgw/J1lHFnSVCCu63pUK3Q/5Qhwr0uX8phnQU7dQnf5mZ0RGrMc5t88IVMpDicLDBJNRUhcaAs3D1M1kiz5m3SjFEhyaA6K8Gc/yhBlMvVQvfidSgb3dOeLHXoH8JbGqquoH9z6yGRp2ngjpvOZE51lb4Si2c8BPVhjEJ4urDmRLc5E6G2/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0vweAY4YiusZeqP0JueRd1+R3UK1h6UVgATxRYQpKU=;
 b=gAr/gDy+fjzDO7tfNI6a1Xif5G6mMkgV7j3mu4fSGzxiQOuw9hQh60Dc1oWO3gn6SD0pn+VYrCWDFXlbs90wmO7I1I2C9DeU2/MzN/srkCOUtFlrVYMciCWf1w33FM/sSJu/3wTYs/mBkFLMZjhT2abByh86PucvS1IZ3tHSsYhG1Oz0JTcJFFNi90xa9lS7HwciUSf+c0cCtXvmOlUjYdlWaue7427Nye2JQFuWJeKDVS5/bKxu8Spqvjvtr2Uci+pFcVCnBYLQKIROzS0TBqllwRx+AFqFjZ3Dh57/rI3KnpLReKXvl1cfBdMIBRtulfe3ibr9vl69EU1jwSf3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0vweAY4YiusZeqP0JueRd1+R3UK1h6UVgATxRYQpKU=;
 b=QM/TMkQ/tY/GeZx38jCEnKaNG0uURORJyj4h2WiFsMeIbxU44t5CrjubucceRW/Xle/zQfFw6DenQbsT+d2CofUh7zdHGO/8Shuw5tYbPWR+tjaETfTA1x3Ny8Z1vhcgx9mDEfrobH7KoA0YbQ6tzswCBZZkHnM7Wr71FHeoudfnCLb5/rJ0ZVrj4Y8Popz4eKPEP/7qj7Ajr0IMD1HcX9FKCvANvwqkJ0YccR1R5dcPPt6QNdzt3O85jkLXERYpDdT0uks3+kLFO0SOQthruEiPxoDcF8phji92RjTx1Qoh8NN7EzT7u68Q5iNU1V//Wo/Xb7MTTBrlTmO8Lbei1w==
Received: from PH8P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::9)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 20:52:52 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::ed) by PH8P220CA0001.outlook.office365.com
 (2603:10b6:510:345::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 20:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:52:31 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:52:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 14/14] selftests: forwarding: Add a test for verifying VXLAN MC underlay
Date: Mon, 9 Jun 2025 22:50:30 +0200
Message-ID: <d47a5edc84638eb27e2f57655a619b06051fa7ae.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ae5de7-e967-4868-7a69-08dda7979944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J6uPrlj6Cl24vHWjBFiuuCJ2LSV1f1pdH9UCavyhwV9lOfZTXjqT6dfCCemT?=
 =?us-ascii?Q?1egPM+fo9sMDYqPVNtYjblLOa9elPYn1qCu9rVhaAYh+ug8mxvYKqZSDpQwt?=
 =?us-ascii?Q?ttr6OT7eFZ8X0nC/Owc4LFcYO5I24PF1qXPynLf1meN5t3DU/UKEuZFLXuMO?=
 =?us-ascii?Q?AkqEMR6gvjtlINNASaql+1Y9U72JC+zTEMlvYKkXIRv/ZlofwfrssWVEvL/P?=
 =?us-ascii?Q?NROZMHCQZJIyFIxcDWZr5S0+rer4AA5FW7eCz8OuSWUcpinjoOjgAf0BbvsZ?=
 =?us-ascii?Q?kyFITT5Kx7V/dZ9pOXG700wCacuJH8U//GB7v93hZycM9FPT/xwCG6Enw/AX?=
 =?us-ascii?Q?Xii9VZWA2Q1K7jiC8t4ud9zA6fh17llkNb0sBPFFpnrjldk7shV6FlW2LtZS?=
 =?us-ascii?Q?5sCMnzmKSlU3J2pLbF/An4D0kTJe6W9BIver87ozaH6SPBVDFOmISqOO152E?=
 =?us-ascii?Q?UXXxm3l4iQR6SjJ5r9fSp+fOE8KNrUyKdi+3R/l6fjJe3DHT/baAXKF+STl2?=
 =?us-ascii?Q?HrbR6aulSZd6vaMpfjO8MO9PnMG/TozaP+/CaK/Y5xpzUbpKrXnDSed6G/oO?=
 =?us-ascii?Q?B9xQIEDV8HrdH4IIUOIwLnmAcxKgC7tiTRgHXi2PwjXJqowxc5VbRTetjrNY?=
 =?us-ascii?Q?iw+tDtyfEM/0uwfLJrdsS7nu4p7oYndd39HdYgWtintVKtrEyDB1i77eJuu4?=
 =?us-ascii?Q?5l0P5ln/mEOngjiakaKQ6Am4IS/pRjPXM1jwJFsAsXabMnN/tqazv/uzEJsE?=
 =?us-ascii?Q?No+bedg7EJy21nVq3C/c8m9aRQUy/Jf+1OGOr/g28HMHzDAdKIh1pyKwJ+VZ?=
 =?us-ascii?Q?E9z9WRxf7qbHRdggWhUlGW9OLgUt5fwTXDjnLNgMpTjKq0pDlO3wXm1QlC1G?=
 =?us-ascii?Q?828zyWx4YP3Y5mHeOT6S17Dl3GFEHF/jVM9U6tSBSazS4ZFyo5gNZF7LJnvW?=
 =?us-ascii?Q?vyc1jtC2Ur3vg+uEPdUtSUDxiz9ibmz3r4aqhKhbbRytnhTnAdF1umAnZ1mR?=
 =?us-ascii?Q?/IEYOkpMJffW8SM7Mievdn1ukhuLxgWENSCOKnmi1Z0a1zDJX9vkqMXTO7nb?=
 =?us-ascii?Q?c27e46sQIn4vYt0tAO7DIxTbhFuCPWaGDKwB3QfA1qsub1VXjjEQgQX8jCbu?=
 =?us-ascii?Q?QZMTZeRMEouHKEBiZBplrXzH+fF5xcpp34ERbtfHQ4mcLfCoSMbMusIYc3jW?=
 =?us-ascii?Q?wM1zNUD3dUr2vGnHklcCBN54AUUZPSe4y91/CrEfVXYoYAPJf+jkXn9zQd0b?=
 =?us-ascii?Q?RqbUrb/HtihyURi9UXEW2115kY9tcNa98OiAvgMQk+6W4vbphTV+IDNtjdU2?=
 =?us-ascii?Q?ZdJg/icZn9qIfBCZLlUDD9S0XHz61nSwfAb/eieDGYqAyZwAt2rUtTLPP2DO?=
 =?us-ascii?Q?sW7tt96M0oB9TbR3nUziztoVGtVnVv5/KX/ysj3i0Pc9kiIZvf3NEaN40UkR?=
 =?us-ascii?Q?gzSSQYXrwXfTnJd7iRxmB0x6jmvc3aCwF9ncsxF0ZhHlZbQOW93TJHBGeUod?=
 =?us-ascii?Q?qTTh598dPcZRHtbSRVT4C/2YuoycvvRfpDNR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:50.8498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ae5de7-e967-4868-7a69-08dda7979944
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

Add tests for MC-routing underlay VXLAN traffic.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 757 ++++++++++++++++++
 2 files changed, 758 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 00bde7b6f39e..d7bb2e80e88c 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -102,6 +102,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	vxlan_bridge_1d_port_8472.sh \
 	vxlan_bridge_1d.sh \
 	vxlan_bridge_1q_ipv6.sh \
+	vxlan_bridge_1q_mc_ul.sh \
 	vxlan_bridge_1q_port_8472_ipv6.sh \
 	vxlan_bridge_1q_port_8472.sh \
 	vxlan_bridge_1q.sh \
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
new file mode 100755
index 000000000000..e01e7ccf2c8d
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -0,0 +1,757 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +-----------------------------------------+
+# | + $h1.10             + $h1.20           |
+# | | 192.0.2.1/28       | 2001:db8:1::1/64 |
+# | \________   ________/                   |
+# |          \ /                            |
+# |           + $h1                H1 (vrf) |
+# +-----------|-----------------------------+
+#             |
+# +-----------|----------------------------------------------------------------+
+# | +---------|--------------------------------------+       SWITCH (main vrf) |
+# | |         + $swp1                   BR1 (802.1q) |                         |
+# | |            vid 10 20                           |                         |
+# | |                                                |                         |
+# | |  + vx10 (vxlan)         + vx20 (vxlan)         |      + lo10 (dummy)     |
+# | |    local 192.0.2.100      local 2001:db8:4::1  |        192.0.2.100/28   |
+# | |    group 233.252.0.1      group ff0e::1:2:3    |        2001:db8:4::1/64 |
+# | |    id 1000                id 2000              |                         |
+# | |    vid 10 pvid untagged   vid 20 pvid untagged |                         |
+# | +------------------------------------------------+                         |
+# |                                                                            |
+# |   + $swp2                                                        $swp3 +   |
+# |   | 192.0.2.33/28                                        192.0.2.65/28 |   |
+# |   | 2001:db8:2::1/64                                  2001:db8:3::1/64 |   |
+# |   |                                                                    |   |
+# +---|--------------------------------------------------------------------|---+
+#     |                                                                    |
+# +---|--------------------------------+  +--------------------------------|---+
+# |   |                      H2 (vrf)  |  | H3 (vrf)                       |   |
+# | +-|----------------------------+   |  |  +-----------------------------|-+ |
+# | | + $h2           BR2 (802.1d) |   |  |  | BR3 (802.1d)            $h3 + | |
+# | |                              |   |  |  |                               | |
+# | | + v1$h2 (veth)               |   |  |  |                v1$h3 (veth) + | |
+# | +-|----------------------------+   |  |  +-----------------------------|-+ |
+# |   |                                |  |                                |   |
+# +---|--------------------------------+  +--------------------------------|---+
+#     |                                                                    |
+# +---|--------------------------------+  +--------------------------------|---+
+# |   + v2$h2 (veth)       NS2 (netns) |  | NS3 (netns)       v2$h3 (veth) +   |
+# |     192.0.2.34/28                  |  |                  192.0.2.66/28     |
+# |     2001:db8:2::2/64               |  |               2001:db8:3::2/64     |
+# |                                    |  |                                    |
+# | +--------------------------------+ |  | +--------------------------------+ |
+# | |                  BR1 (802.1q)  | |  | |                   BR1 (802.1q) | |
+# | |  + vx10 (vxlan)                | |  | |  + vx10 (vxlan)                | |
+# | |    local 192.0.2.34            | |  | |    local 192.0.2.50            | |
+# | |    group 233.252.0.1 dev v2$h2 | |  | |    group 233.252.0.1 dev v2$h3 | |
+# | |    id 1000 dstport $VXPORT     | |  | |    id 1000 dstport $VXPORT     | |
+# | |    vid 10 pvid untagged        | |  | |    vid 10 pvid untagged        | |
+# | |                                | |  | |                                | |
+# | |  + vx20 (vxlan)                | |  | |  + vx20 (vxlan)                | |
+# | |    local 2001:db8:2::2         | |  | |    local 2001:db8:3::2         | |
+# | |    group ff0e::1:2:3 dev v2$h2 | |  | |    group ff0e::1:2:3 dev v2$h3 | |
+# | |    id 2000 dstport $VXPORT     | |  | |    id 2000 dstport $VXPORT     | |
+# | |    vid 20 pvid untagged        | |  | |    vid 20 pvid untagged        | |
+# | |                                | |  | |                                | |
+# | |  + w1 (veth)                   | |  | |  + w1 (veth)                   | |
+# | |  | vid 10 20                   | |  | |  | vid 10 20                   | |
+# | +--|-----------------------------+ |  | +--|-----------------------------+ |
+# |    |                               |  |    |                               |
+# | +--|-----------------------------+ |  | +--|-----------------------------+ |
+# | |  + w2 (veth)        VW2 (vrf)  | |  | |  + w2 (veth)        VW2 (vrf)  | |
+# | |  |\                            | |  | |  |\                            | |
+# | |  | + w2.10                     | |  | |  | + w2.10                     | |
+# | |  |   192.0.2.3/28              | |  | |  |   192.0.2.4/28              | |
+# | |  |                             | |  | |  |                             | |
+# | |  + w2.20                       | |  | |  + w2.20                       | |
+# | |    2001:db8:1::3/64            | |  | |    2001:db8:1::4/64            | |
+# | +--------------------------------+ |  | +--------------------------------+ |
+# +------------------------------------+  +------------------------------------+
+
+: "${VXPORT:=4789}"
+export VXPORT
+
+: "${GROUP4:=233.252.0.1}"
+export GROUP4
+
+: "${GROUP6:=ff0e::1:2:3}"
+export GROUP6
+
+: "${IPMR:=lo10}"
+
+ALL_TESTS="
+	ipv4_nomcroute
+	ipv4_mcroute
+	ipv4_mcroute_changelink
+	ipv4_mcroute_starg
+	ipv4_mcroute_noroute
+	ipv4_mcroute_fdb
+	ipv4_mcroute_fdb_oif0
+	ipv4_mcroute_fdb_oif0_sep
+
+	ipv6_nomcroute
+	ipv6_mcroute
+	ipv6_mcroute_changelink
+	ipv6_mcroute_starg
+	ipv6_mcroute_noroute
+	ipv6_mcroute_fdb
+	ipv6_mcroute_fdb_oif0
+
+	ipv4_nomcroute_rx
+	ipv4_mcroute_rx
+	ipv4_mcroute_starg_rx
+	ipv4_mcroute_fdb_oif0_sep_rx
+	ipv4_mcroute_fdb_sep_rx
+
+	ipv6_nomcroute_rx
+	ipv6_mcroute_rx
+	ipv6_mcroute_starg_rx
+	ipv6_mcroute_fdb_sep_rx
+"
+
+NUM_NETIFS=6
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1
+	defer simple_if_fini $h1
+
+	ip_link_add $h1.10 master v$h1 link $h1 type vlan id 10
+	ip_link_set_up $h1.10
+	ip_addr_add $h1.10 192.0.2.1/28
+
+	ip_link_add $h1.20 master v$h1 link $h1 type vlan id 20
+	ip_link_set_up $h1.20
+	ip_addr_add $h1.20 2001:db8:1::1/64
+}
+
+install_capture()
+{
+	local dev=$1; shift
+
+	tc qdisc add dev $dev clsact
+	defer tc qdisc del dev $dev clsact
+
+	tc filter add dev $dev ingress proto ip pref 104 \
+	   flower skip_hw ip_proto udp dst_port $VXPORT \
+	   action pass
+	defer tc filter del dev $dev ingress proto ip pref 104
+
+	tc filter add dev $dev ingress proto ipv6 pref 106 \
+	   flower skip_hw ip_proto udp dst_port $VXPORT \
+	   action pass
+	defer tc filter del dev $dev ingress proto ipv6 pref 106
+}
+
+h2_create()
+{
+	# $h2
+	ip_link_set_up $h2
+
+	# H2
+	vrf_create v$h2
+	defer vrf_destroy v$h2
+
+	ip_link_set_up v$h2
+
+	# br2
+	ip_link_add br2 type bridge vlan_filtering 0 mcast_snooping 0
+	ip_link_set_master br2 v$h2
+	ip_link_set_up br2
+
+	# $h2
+	ip_link_set_master $h2 br2
+	install_capture $h2
+
+	# v1$h2
+	ip_link_set_up v1$h2
+	ip_link_set_master v1$h2 br2
+}
+
+h3_create()
+{
+	# $h3
+	ip_link_set_up $h3
+
+	# H3
+	vrf_create v$h3
+	defer vrf_destroy v$h3
+
+	ip_link_set_up v$h3
+
+	# br3
+	ip_link_add br3 type bridge vlan_filtering 0 mcast_snooping 0
+	ip_link_set_master br3 v$h3
+	ip_link_set_up br3
+
+	# $h3
+	ip_link_set_master $h3 br3
+	install_capture $h3
+
+	# v1$h3
+	ip_link_set_up v1$h3
+	ip_link_set_master v1$h3 br3
+}
+
+switch_create()
+{
+	# br1
+	ip_link_add br1 type bridge vlan_filtering 1 \
+			    vlan_default_pvid 0 mcast_snooping 0
+	ip_link_set_addr br1 $(mac_get $swp1)
+	ip_link_set_up br1
+
+	# A dummy to force the IPv6 OIF=0 test to install a suitable MC route on
+	# $IPMR to be deterministic. Also used for the IPv6 RX!=TX ping test.
+	ip_link_add "X$IPMR" up type dummy
+
+	# IPMR
+	ip_link_add "$IPMR" up type dummy
+	ip_addr_add "$IPMR" 192.0.2.100/28
+	ip_addr_add "$IPMR" 2001:db8:4::1/64
+
+	# $swp1
+	ip_link_set_up $swp1
+	ip_link_set_master $swp1 br1
+	bridge_vlan_add vid 10 dev $swp1
+	bridge_vlan_add vid 20 dev $swp1
+
+	# $swp2
+	ip_link_set_up $swp2
+	ip_addr_add $swp2 192.0.2.33/28
+	ip_addr_add $swp2 2001:db8:2::1/64
+
+	# $swp3
+	ip_link_set_up $swp3
+	ip_addr_add $swp3 192.0.2.65/28
+	ip_addr_add $swp3 2001:db8:3::1/64
+}
+
+vx_create()
+{
+	local name=$1; shift
+	local vid=$1; shift
+
+	ip_link_add "$name" up type vxlan dstport "$VXPORT" \
+		nolearning noudpcsum tos inherit ttl 16 \
+		"$@"
+	ip_link_set_master "$name" br1
+	bridge_vlan_add vid $vid dev "$name" pvid untagged
+}
+export -f vx_create
+
+vx_wait()
+{
+	# Wait for all the ARP, IGMP etc. noise to settle down so that the
+	# tunnel is clear for measurements.
+	sleep 10
+}
+
+vx10_create()
+{
+	vx_create vx10 10 id 1000 "$@"
+}
+export -f vx10_create
+
+vx20_create()
+{
+	vx_create vx20 20 id 2000 "$@"
+}
+export -f vx20_create
+
+vx10_create_wait()
+{
+	vx10_create "$@"
+	vx_wait
+}
+
+vx20_create_wait()
+{
+	vx20_create "$@"
+	vx_wait
+}
+
+ns_init_common()
+{
+	local ns=$1; shift
+	local if_in=$1; shift
+	local ipv4_in=$1; shift
+	local ipv6_in=$1; shift
+	local ipv4_host=$1; shift
+	local ipv6_host=$1; shift
+
+	# v2$h2 / v2$h3
+	ip_link_set_up $if_in
+	ip_addr_add $if_in $ipv4_in
+	ip_addr_add $if_in $ipv6_in
+
+	# br1
+	ip_link_add br1 type bridge vlan_filtering 1 \
+		    vlan_default_pvid 0 mcast_snooping 0
+	ip_link_set_up br1
+
+	# vx10, vx20
+	vx10_create local ${ipv4_in%/*} group $GROUP4 dev $if_in
+	vx20_create local ${ipv6_in%/*} group $GROUP6 dev $if_in
+
+	# w1
+	ip_link_add w1 type veth peer name w2
+	ip_link_set_master w1 br1
+	ip_link_set_up w1
+	bridge_vlan_add vid 10 dev w1
+	bridge_vlan_add vid 20 dev w1
+
+	# w2
+	simple_if_init w2
+	defer simple_if_fini w2
+
+	# w2.10
+	ip_link_add w2.10 master vw2 link w2 type vlan id 10
+	ip_link_set_up w2.10
+	ip_addr_add w2.10 $ipv4_host
+
+	# w2.20
+	ip_link_add w2.20 master vw2 link w2 type vlan id 20
+	ip_link_set_up w2.20
+	ip_addr_add w2.20 $ipv6_host
+}
+export -f ns_init_common
+
+ns2_create()
+{
+	# NS2
+	ip netns add ns2
+	defer ip netns del ns2
+
+	# v2$h2
+	ip link set dev v2$h2 netns ns2
+	defer ip -n ns2 link set dev v2$h2 netns 1
+
+	in_ns ns2 \
+	      ns_init_common ns2 v2$h2 \
+			     192.0.2.34/28 2001:db8:2::2/64 \
+			     192.0.2.3/28  2001:db8:1::3/64
+}
+
+ns3_create()
+{
+	# NS3
+	ip netns add ns3
+	defer ip netns del ns3
+
+	# v2$h3
+	ip link set dev v2$h3 netns ns3
+	defer ip -n ns3 link set dev v2$h3 netns 1
+
+	ip -n ns3 link set dev v2$h3 up
+
+	in_ns ns3 \
+	      ns_init_common ns3 v2$h3 \
+			     192.0.2.66/28 2001:db8:3::2/64 \
+			     192.0.2.4/28  2001:db8:1::4/64
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
+	ip_link_add v1$h2 type veth peer name v2$h2
+	ip_link_add v1$h3 type veth peer name v2$h3
+
+	h1_create
+	h2_create
+	h3_create
+	switch_create
+	ns2_create
+	ns3_create
+}
+
+adf_install_broken_sg()
+{
+	adf_mcd_start "$IPMR" || exit $EXIT_STATUS
+
+	mc_cli add $swp2 192.0.2.100 $GROUP4 $swp1 $swp3
+	defer mc_cli remove $swp2 192.0.2.100 $GROUP4 $swp1 $swp3
+
+	mc_cli add $swp2 2001:db8:4::1 $GROUP6 $swp1 $swp3
+	defer mc_cli remove $swp2 2001:db8:4::1 $GROUP6 $swp1 $swp3
+}
+
+adf_install_rx()
+{
+	mc_cli add $swp2 0.0.0.0 $GROUP4 "$IPMR"
+	defer mc_cli remove $swp2 0.0.0.0 $GROUP4 lo10
+
+	mc_cli add $swp3 0.0.0.0 $GROUP4 "$IPMR"
+	defer mc_cli remove $swp3 0.0.0.0 $GROUP4 lo10
+
+	mc_cli add $swp2 :: $GROUP6 "$IPMR"
+	defer mc_cli remove $swp2 :: $GROUP6 lo10
+
+	mc_cli add $swp3 :: $GROUP6 "$IPMR"
+	defer mc_cli remove $swp3 :: $GROUP6 lo10
+}
+
+adf_install_sg()
+{
+	adf_mcd_start "$IPMR" || exit $EXIT_STATUS
+
+	mc_cli add "$IPMR" 192.0.2.100 $GROUP4 $swp2 $swp3
+	defer mc_cli remove "$IPMR" 192.0.2.33 $GROUP4 $swp2 $swp3
+
+	mc_cli add "$IPMR" 2001:db8:4::1 $GROUP6 $swp2 $swp3
+	defer mc_cli remove "$IPMR" 2001:db8:4::1 $GROUP6 $swp2 $swp3
+
+	adf_install_rx
+}
+
+adf_install_sg_sep()
+{
+	adf_mcd_start lo || exit $EXIT_STATUS
+
+	mc_cli add lo 192.0.2.120 $GROUP4 $swp2 $swp3
+	defer mc_cli remove lo 192.0.2.120 $GROUP4 $swp2 $swp3
+
+	mc_cli add lo 2001:db8:5::1 $GROUP6 $swp2 $swp3
+	defer mc_cli remove lo 2001:db8:5::1 $GROUP6 $swp2 $swp3
+}
+
+adf_install_sg_sep_rx()
+{
+	local lo=$1; shift
+
+	adf_mcd_start "$IPMR" "$lo" || exit $EXIT_STATUS
+
+	mc_cli add "$lo" 192.0.2.120 $GROUP4 $swp2 $swp3
+	defer mc_cli remove "$lo" 192.0.2.120 $GROUP4 $swp2 $swp3
+
+	mc_cli add "$lo" 2001:db8:5::1 $GROUP6 $swp2 $swp3
+	defer mc_cli remove "$lo" 2001:db8:5::1 $GROUP6 $swp2 $swp3
+
+	adf_install_rx
+}
+
+adf_install_starg()
+{
+	adf_mcd_start "$IPMR" || exit $EXIT_STATUS
+
+	mc_cli add "$IPMR" 0.0.0.0 $GROUP4 $swp2 $swp3
+	defer mc_cli remove "$IPMR" 0.0.0.0 $GROUP4 $swp2 $swp3
+
+	mc_cli add "$IPMR" :: $GROUP6 $swp2 $swp3
+	defer mc_cli remove "$IPMR" :: $GROUP6 $swp2 $swp3
+
+	adf_install_rx
+}
+
+do_packets_v4()
+{
+	local mac=$(mac_get $h2)
+
+	$MZ $h1 -Q 10 -c 10 -d 100msec -p 64 -a own -b $mac \
+	    -A 192.0.2.1 -B 192.0.2.2 -t udp sp=1234,dp=2345 -q
+}
+
+do_packets_v6()
+{
+	local mac=$(mac_get $h2)
+
+	$MZ -6 $h1 -Q 20 -c 10 -d 100msec -p 64 -a own -b $mac \
+	    -A 2001:db8:1::1 -B 2001:db8:1::2 -t udp sp=1234,dp=2345 -q
+}
+
+do_test()
+{
+	local ipv=$1; shift
+	local expect_h2=$1; shift
+	local expect_h3=$1; shift
+	local what=$1; shift
+
+	local pref=$((100 + ipv))
+
+	RET=0
+
+	local t0_h2=$(tc_rule_stats_get $h2 $pref ingress)
+	local t0_h3=$(tc_rule_stats_get $h3 $pref ingress)
+
+	do_packets_v$ipv
+	sleep 1
+
+	local t1_h2=$(tc_rule_stats_get $h2 $pref ingress)
+	local t1_h3=$(tc_rule_stats_get $h3 $pref ingress)
+
+	local d_h2=$((t1_h2 - t0_h2))
+	local d_h3=$((t1_h3 - t0_h3))
+
+	((d_h2 == expect_h2))
+	check_err $? "Expected $expect_h2 packets on H2, got $d_h2"
+
+	((d_h3 == expect_h3))
+	check_err $? "Expected $expect_h3 packets on H3, got $d_h3"
+
+	log_test "VXLAN MC flood $what"
+}
+
+ipv4_do_test_rx()
+{
+	local h3_should_fail=$1; shift
+	local what=$1; shift
+
+	RET=0
+
+	ping_do $h1.10 192.0.2.3
+	check_err $? "H2 should respond"
+
+	ping_do $h1.10 192.0.2.4
+	check_err_fail $h3_should_fail $? "H3 responds"
+
+	log_test "VXLAN MC flood $what"
+}
+
+ipv6_do_test_rx()
+{
+	local h3_should_fail=$1; shift
+	local what=$1; shift
+
+	RET=0
+
+	ping6_do $h1.20 2001:db8:1::3
+	check_err $? "H2 should respond"
+
+	ping6_do $h1.20 2001:db8:1::4
+	check_err_fail $h3_should_fail $? "H3 responds"
+
+	log_test "VXLAN MC flood $what"
+}
+
+ipv4_nomcroute()
+{
+	# Install a misleading (S,G) rule to attempt to trick the system into
+	# pushing the packets elsewhere.
+	adf_install_broken_sg
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$swp2"
+	do_test 4 10 0 "IPv4 nomcroute"
+}
+
+ipv6_nomcroute()
+{
+	# Like for IPv4, install a misleading (S,G).
+	adf_install_broken_sg
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$swp2"
+	do_test 6 10 0 "IPv6 nomcroute"
+}
+
+ipv4_nomcroute_rx()
+{
+	vx10_create local 192.0.2.100 group $GROUP4 dev "$swp2"
+	ipv4_do_test_rx 1 "IPv4 nomcroute ping"
+}
+
+ipv6_nomcroute_rx()
+{
+	vx20_create local 2001:db8:4::1 group $GROUP6 dev "$swp2"
+	ipv6_do_test_rx 1 "IPv6 nomcroute ping"
+}
+
+ipv4_mcroute()
+{
+	adf_install_sg
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$IPMR" mcroute
+	do_test 4 10 10 "IPv4 mcroute"
+}
+
+ipv6_mcroute()
+{
+	adf_install_sg
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$IPMR" mcroute
+	do_test 6 10 10 "IPv6 mcroute"
+}
+
+ipv4_mcroute_rx()
+{
+	adf_install_sg
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$IPMR" mcroute
+	ipv4_do_test_rx 0 "IPv4 mcroute ping"
+}
+
+ipv6_mcroute_rx()
+{
+	adf_install_sg
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$IPMR" mcroute
+	ipv6_do_test_rx 0 "IPv6 mcroute ping"
+}
+
+ipv4_mcroute_changelink()
+{
+	adf_install_sg
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$IPMR"
+	ip link set dev vx10 type vxlan mcroute
+	sleep 1
+	do_test 4 10 10 "IPv4 mcroute changelink"
+}
+
+ipv6_mcroute_changelink()
+{
+	adf_install_sg
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$IPMR" mcroute
+	ip link set dev vx20 type vxlan mcroute
+	sleep 1
+	do_test 6 10 10 "IPv6 mcroute changelink"
+}
+
+ipv4_mcroute_starg()
+{
+	adf_install_starg
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$IPMR" mcroute
+	do_test 4 10 10 "IPv4 mcroute (*,G)"
+}
+
+ipv6_mcroute_starg()
+{
+	adf_install_starg
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$IPMR" mcroute
+	do_test 6 10 10 "IPv6 mcroute (*,G)"
+}
+
+ipv4_mcroute_starg_rx()
+{
+	adf_install_starg
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$IPMR" mcroute
+	ipv4_do_test_rx 0 "IPv4 mcroute (*,G) ping"
+}
+
+ipv6_mcroute_starg_rx()
+{
+	adf_install_starg
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$IPMR" mcroute
+	ipv6_do_test_rx 0 "IPv6 mcroute (*,G) ping"
+}
+
+ipv4_mcroute_noroute()
+{
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$IPMR" mcroute
+	do_test 4 0 0 "IPv4 mcroute, no route"
+}
+
+ipv6_mcroute_noroute()
+{
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$IPMR" mcroute
+	do_test 6 0 0 "IPv6 mcroute, no route"
+}
+
+ipv4_mcroute_fdb()
+{
+	adf_install_sg
+	vx10_create_wait local 192.0.2.100 dev "$IPMR" mcroute
+	bridge fdb add dev vx10 \
+		00:00:00:00:00:00 self static dst $GROUP4 via "$IPMR"
+	do_test 4 10 10 "IPv4 mcroute FDB"
+}
+
+ipv6_mcroute_fdb()
+{
+	adf_install_sg
+	vx20_create_wait local 2001:db8:4::1 dev "$IPMR" mcroute
+	bridge -6 fdb add dev vx20 \
+		00:00:00:00:00:00 self static dst $GROUP6 via "$IPMR"
+	do_test 6 10 10 "IPv6 mcroute FDB"
+}
+
+# Use FDB to configure VXLAN in a way where oif=0 for purposes of FIB lookup.
+ipv4_mcroute_fdb_oif0()
+{
+	adf_install_sg
+	vx10_create_wait local 192.0.2.100 group $GROUP4 dev "$IPMR" mcroute
+	bridge fdb del dev vx10 00:00:00:00:00:00
+	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst $GROUP4
+	do_test 4 10 10 "IPv4 mcroute oif=0"
+}
+
+ipv6_mcroute_fdb_oif0()
+{
+	# The IPv6 tunnel lookup does not fall back to selection by source
+	# address. Instead it just does a FIB match, and that would find one of
+	# the several ff00::/8 multicast routes -- each device has one. In order
+	# to reliably force the $IPMR device, add a /128 route for the
+	# destination group address.
+	ip -6 route add table local multicast $GROUP6/128 dev "$IPMR"
+	defer ip -6 route del table local multicast $GROUP6/128 dev "$IPMR"
+
+	adf_install_sg
+	vx20_create_wait local 2001:db8:4::1 group $GROUP6 dev "$IPMR" mcroute
+	bridge -6 fdb del dev vx20 00:00:00:00:00:00
+	bridge -6 fdb add dev vx20 00:00:00:00:00:00 self static dst $GROUP6
+	do_test 6 10 10 "IPv6 mcroute oif=0"
+}
+
+# In oif=0 test as above, have FIB lookup resolve to loopback instead of IPMR.
+# This doesn't work with IPv6 -- a MC route on lo would be marked as RTF_REJECT.
+ipv4_mcroute_fdb_oif0_sep()
+{
+	adf_install_sg_sep
+
+	ip_addr_add lo 192.0.2.120/28
+	vx10_create_wait local 192.0.2.120 group $GROUP4 dev "$IPMR" mcroute
+	bridge fdb del dev vx10 00:00:00:00:00:00
+	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst $GROUP4
+	do_test 4 10 10 "IPv4 mcroute TX!=RX oif=0"
+}
+
+ipv4_mcroute_fdb_oif0_sep_rx()
+{
+	adf_install_sg_sep_rx lo
+
+	ip_addr_add lo 192.0.2.120/28
+	vx10_create_wait local 192.0.2.120 group $GROUP4 dev "$IPMR" mcroute
+	bridge fdb del dev vx10 00:00:00:00:00:00
+	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst $GROUP4
+	ipv4_do_test_rx 0 "IPv4 mcroute TX!=RX oif=0 ping"
+}
+
+ipv4_mcroute_fdb_sep_rx()
+{
+	adf_install_sg_sep_rx lo
+
+	ip_addr_add lo 192.0.2.120/28
+	vx10_create_wait local 192.0.2.120 group $GROUP4 dev "$IPMR" mcroute
+	bridge fdb del dev vx10 00:00:00:00:00:00
+	bridge fdb add dev vx10 00:00:00:00:00:00 self static dst $GROUP4 via lo
+	ipv4_do_test_rx 0 "IPv4 mcroute TX!=RX ping"
+}
+
+ipv6_mcroute_fdb_sep_rx()
+{
+	adf_install_sg_sep_rx "X$IPMR"
+
+	ip_addr_add "X$IPMR" 2001:db8:5::1/64
+	vx20_create_wait local 2001:db8:5::1 group $GROUP6 dev "$IPMR" mcroute
+	bridge -6 fdb del dev vx20 00:00:00:00:00:00
+	bridge -6 fdb add dev vx20 00:00:00:00:00:00 \
+			  self static dst $GROUP6 via "X$IPMR"
+	ipv6_do_test_rx 0 "IPv6 mcroute TX!=RX ping"
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
2.49.0


