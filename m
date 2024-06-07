Return-Path: <linux-kselftest+bounces-11390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD35900878
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEE01F25268
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7C319AA79;
	Fri,  7 Jun 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EOuNYowg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449EA19885E;
	Fri,  7 Jun 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773323; cv=fail; b=C94afRv12smickdElKSPHW2VrobSns3LEZYq2+EPFM6lVRgiKfQutjGdCth/knGfqKwAPxafklEzJRI38rIoUI177y91JLR9DXd+bOXZTdEBXA11UByfDeK6o1+sMNzbn+89cFQWEfi9y/QRQqI0Lp05LnHIcMRbvttF+iAqGQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773323; c=relaxed/simple;
	bh=vdHBwUWCaO/YOuxMhoPw/y7XFO4JwgQxX9z+sJlwbnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7o1dxO+4X1TuIu0pB5vcUnFNBz2mqxnIzFkCCE92HILfvYIYtns06qtAdUOWU0DTsFTN0iGZwP9fbSG6JkuToAZ/NmoqYG24BB3lE7DJ87d2LYrUosRvx/Q27OCoOnfNaKEaiMIH5P8gEDpZ1CqPW0iuqdHsY2aP0LvA2nl6Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EOuNYowg; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsBdkXeEMtsFXnHAuVx/Mr4Rnx2iB/P8gbLGl0QSv3941gDCyz5LxOLIOK9VkjpNBgUO4EIhDjjS+VeizF9br/e5cxKZMQIjsehGFZnRTudMzp641YL2MlYO7Rw2SMP3voLav5+YmAolI11xR1fvUnhnIqnemC7yCVc6spGfEQ7PR6FklWGHiPqAolDdZFiSWpIjvyMBbR/cGVI8e6psWTSecpoN3T48GDFrNobQ3DFo54lRLI8+YsjEQ57HNkt/lhRvCjDD73k0sfeY2jZmzYHrCui6WaMNjwsDAigZi2ZNc1CdwYUVq5QnVOo54qAJmQKCuqkOWTAqEn/B+FPAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NiVE+o4ZswaqIsVty2uSoRzac0/lbYCqG503PWVH4Y=;
 b=Ji7n77UqI6u8CjnIFcyjp+ybcdIJxBd5+mmSpVnxpsKr18Fwqlq5V3rBqgZr4tQ+WUxOKEkyuPqJNf6bPy11LGvNvtFTY8JVrB+krccVs31CrTzbRbBC4SZqd0Jq1fZ+/QdavzQe5ZgksBv0baObhiGOOJo+HhSGdCUGRhUdi5Kea3+SbNTtsVYQ6eMe4e4iWvpdgY7H2HiFv5oJzjK0EYFwkOdp09Ysp6NK2MQuhtjs+/uLEesUHN92FRR0ISZmRf24+rmXUyZ+rGJvXsEyzED+LDpQtVPKB59bx1+C2enpMpYPVX5IMm+MI8eIFw1IYMW67Ykspfcw/1ngwbgQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NiVE+o4ZswaqIsVty2uSoRzac0/lbYCqG503PWVH4Y=;
 b=EOuNYowgsFcG9beWFG8eVuquN1GmZVvso0VDHMxgnk4iKjfi4WB8VoeYGuu7hWA9crHPgW2eK6vaheNANBIYlIth625e5/sw2fAXxVxV9brPKqR72RWvzMZ+/j98ZbGlWVa276+m1qtMLFYSHzZX8Qh/RGK5mv0wtY7UVUxBZErjYWodZV6wnHuE/1Q3fiZTopfImdSQJUSgNTnKFSWoqxhrEdH3zE8uitY693eODQj9tzDG522HczsS1HUg1i6T95Vvz2ZIMCE6/sRV6EGDyz1e4pJZmtshbcFpfH9OSACYx0swW+qStHFLcjZ92SMVvGJymL8dqkHJgNyW0fZbxg==
Received: from MN2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:208:e8::35)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 7 Jun
 2024 15:15:14 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::92) by MN2PR20CA0022.outlook.office365.com
 (2603:10b6:208:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Fri, 7 Jun 2024 15:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 15:15:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:55 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:50 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 5/5] selftests: forwarding: router_mpath_hash: Add a new selftest
Date: Fri, 7 Jun 2024 17:13:57 +0200
Message-ID: <20240607151357.421181-6-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
References: <20240607151357.421181-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 339ee6a3-c6b0-4eb7-1fa0-08dc8704a13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YAU/H2TvQ85UZw3JizCyifLZejwPFkkqtQwrqMvl/O0d6C0kDIHGZXJVhTbv?=
 =?us-ascii?Q?mkMaOlvVD4fY3uWPCeiaz9AKxTRZDCLcEFAqN/bfimP8gUpz/pHrxjhjp8wk?=
 =?us-ascii?Q?XaJOdB6DBRj1SE2Y2KBs6NHYY+W71CucfOpLqAU5gqQ4WC5pNOsAgTxEyW0C?=
 =?us-ascii?Q?QoBSt5sxYvKVNuQz/LqKSv0B128xng3anYjtIbiPjXtePMkmCZQOFx0stCI0?=
 =?us-ascii?Q?oz/L1KIu866nDmOl0VUB1ogFHcz5DhX13GTGVTLmEBxhxYTJVsudbftPfm9J?=
 =?us-ascii?Q?/rA4FdmIiI2IzLQ+wLEQ4Rmwe0fOjeOdE1EA1RMpKEkeN/Pu8NUrA9jHIydG?=
 =?us-ascii?Q?SWpB53ztugjUHFGEDlHgL2rLWB04gjNMEUu1t96zA7d5EZiqK2+oVScwTfDU?=
 =?us-ascii?Q?8KDkZjiH3XuiQPGWI0dZzti4KnhAn3K4+02YPIE8khlIsAnLgb0yO6HFwkQi?=
 =?us-ascii?Q?RcqSI5yfb11AAiyBmFqlXD5jNWko++832Dmcsb4Fh4etgaT/PCiWbwvWPtsn?=
 =?us-ascii?Q?PQYo3PsE+Wxl1MOL/9oNOaEkCc3JklD/o4FMEgYCzFRJpQVmBQf3yDmwoWfW?=
 =?us-ascii?Q?/EmbKmH532JImjyrOykwgqBzgTnXwxmnmDmD33B+o8SEksOKC7v9tRRbgkty?=
 =?us-ascii?Q?UTFCSmas3PjaOopkwm4i9R66TbOMyWG1/xFS3PVXfxG8ctyPZX4xNThXDDvW?=
 =?us-ascii?Q?53pKBjGfqJXqhRYjVhEIwt90ke9/00/Bq2p8RvKW/JevZIC/9Iio4Pi02rZe?=
 =?us-ascii?Q?aE77ibx/oXACTftm9zBtruZGsBZswfYFfbI0RDQlJ3wtqgIV3+AybmU2DthE?=
 =?us-ascii?Q?nVIAaxe2RogcHyLnz1qSn62eV8qqMaU7sJ9Kr4c/kmY2eWpvOlj4Vzbjftdj?=
 =?us-ascii?Q?dkSeErlYuhbJbptDYZKIWmHB0WyQVFSEnIX/1b2ut+8Ec6YA93XPkY+ecb8J?=
 =?us-ascii?Q?iSwcE27SMmMB0MDcNq1qgcenazlqMB0Hpy/Kfrc4oh0RnXc5kndpZQXXLDOc?=
 =?us-ascii?Q?nXdKlan7FhQB76bKJBsWo2zmA1odJJPHILrQh5Fz1hcl1vKsDI7in0viDpWp?=
 =?us-ascii?Q?xBRZJ/k9PwP+s2BkRLQctET+4WIKsox9Vostg8yWqdGQf9l4GobRkJMvBH8j?=
 =?us-ascii?Q?CCxmtT3RtU4QLNfjX/5YTxdggvKLJ+Mvh2QRkgPJxxGz3+kaLqFtup19RgqO?=
 =?us-ascii?Q?Jw0dReJt3qElOWk/O+gBetDV0LoTrd4mX8hbiDOGq1d/67MsubuDl1tlJBf4?=
 =?us-ascii?Q?xVY50hboa+XZc4wGTxyMpJnZmmtytVpFIL1g08F2p/V5Js3t6sryY3gvJKKu?=
 =?us-ascii?Q?m2MGOuiYWvLPKmIvh/XyH/LnI+yBAfetxmdSD3mp9Nt9wJyGBdXao18favb+?=
 =?us-ascii?Q?0WjDtX5W5pxviyAxaj5nIWFnKbawQC6Ut84ZPdqc2Qm6GBRk/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:15:13.2336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ee6a3-c6b0-4eb7-1fa0-08dc8704a13d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

Add a selftest that exercises the sysctl added in the previous patches.

Test that set/get works as expected; that across seeds we eventually hit
all NHs (test_mpath_seed_*); and that a given seed keeps hitting the same
NHs even across seed changes (test_mpath_seed_stability_*).

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org

Notes:
    v2:
    - Do not set seed on test init and run the stability tests first to catch
      the cases of a missed pernet seed init.

 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../net/forwarding/router_mpath_seed.sh       | 333 ++++++++++++++++++
 2 files changed, 334 insertions(+)
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
index 000000000000..314cb906c1eb
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/router_mpath_seed.sh
@@ -0,0 +1,333 @@
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
+	test_mpath_seed_stability_ipv4
+	test_mpath_seed_stability_ipv6
+	test_mpath_seed_get
+	test_mpath_seed_ipv4
+	test_mpath_seed_ipv6
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
+	sysctl_save net.ipv4.fib_multipath_hash_seed
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
+probe_nh()
+{
+	local group_id=$1; shift
+	local -a mz=("$@")
+
+	local s0=$(nh_stats_snapshot $group_id)
+	"${mz[@]}"
+	local s1=$(nh_stats_snapshot $group_id)
+
+	get_active_nh "$s0" "$s1"
+}
+
+probe_seed()
+{
+	local group_id=$1; shift
+	local seed=$1; shift
+	local -a mz=("$@")
+
+	sysctl -qw net.ipv4.fib_multipath_hash_seed=$seed
+	probe_nh "$group_id" "${mz[@]}"
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
+	# Initial active NH before touching the seed at all.
+	local act_ini=$(probe_nh $group_id "${mz[@]}")
+
+	local act_0_0=$(probe_seed $group_id $seed_0 "${mz[@]}")
+	local act_1_0=$(probe_seed $group_id $seed_1 "${mz[@]}")
+	local act_2_0=$(probe_seed $group_id $seed_2 "${mz[@]}")
+
+	local act_0_1=$(probe_seed $group_id $seed_0 "${mz[@]}")
+	local act_1_1=$(probe_seed $group_id $seed_1 "${mz[@]}")
+	local act_2_1=$(probe_seed $group_id $seed_2 "${mz[@]}")
+
+	check_mpath_seed_stability initial $act_ini $act_0_0
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


