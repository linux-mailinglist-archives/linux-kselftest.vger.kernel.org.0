Return-Path: <linux-kselftest+bounces-11858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEBB9074BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F311F22431
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0514658C;
	Thu, 13 Jun 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="igR8RTgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88E14659D;
	Thu, 13 Jun 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287884; cv=fail; b=WNTudoH8P5QkLPmOqvhkmKwhNSY3sX34d+0V9BlcuxMKMLjhp6WxA+MRqBdLKcVBDaXp8EHSiVNJY/U5Voq8F10Z996pcrROIZIR4U4XGv/9/OjMV2wmD/0Y/DGXtZQmCOKUX9UTfVs6yDFYs1IwS6IHqxx/8ivwzVbAPf2xdPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287884; c=relaxed/simple;
	bh=g+iwjDXVptXhom4c6dLFpDtW58TgoW7xbHyBxOlkL4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmE3MmVKSu2kjTkXHWSSs0tanLyjH9JW4iKNTAYVejcEjrkb9A/90KKzVYKv16Df9PQRAXI/mZOTXWWyRcNOKBun41TeVipbtJer6dHR16rQPo0xr6LtosZvj+FIRy3Vdz8Wwphrt5Gt2F3QEz3wBQW/KfgA2Lc5KCgRO4WlFMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=igR8RTgO; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV8SyLNgPhkKHb/5yMsidmwNpiRfnQhhYYdf/MsZn2ysnC1K2MHp3IriTUvbaTMc/x40Qk5OS4eJhEnhQ6aOqJIeABJyochKr2iB+FPkCc+c4OyBfo0J22uyIZga7yBqe0mkUSRcYZoX7QHTeWcSvC9EdnI46+SszPrpYNr0h0kjriNjTWdWNiIoKu8viSJ7OX9W6NQAjuEsX40wNqB2johBsbUbYm69NEN6p7nP3A5DJtuZhGspLkh5jrJ149cuHPVaYQnyhDIaasC5zPf2WSRzIRFCtEbVUh0/lQEsAgLh1fIX1Uw/1ZMkrIBgL5Ob7c7YvNHjL6v2InNrDnoLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAw9JLXpauvSG0oDNlOYcjvqvWSjHOTAk6S7gwW9Kj0=;
 b=aGSlzSO1L/YXzuNfQEKdrwxUZ82KyEkb/n8sF8B23XyEFtnOaMxoi+MAqQhAuGRAZjzNS/elDHBlpBF28BWOOIIlDpT6N2dvqMkW8pBc7QBqkOqFwdgWB1hOG1+KFOGOYQnKgAK3vY5DHpWS74qsRJ2fd9Qp7NeiHBwsYEAuefzJK6oY9xoI2B63iZ4m3g1bqF592BQvKF/tQl3v/afCiyGU3x71iT4kUnwjdlDrgyL3z3vaiP1O9beyzfnoagWxoOsaLj/WJmF5Alq0H0ld9iA0Vba8NaG7CHH+7SUKmCVAUejlYZXncsz7R+FJPJOJdBB2sH+AQjFgt1H12mgTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAw9JLXpauvSG0oDNlOYcjvqvWSjHOTAk6S7gwW9Kj0=;
 b=igR8RTgOzKTflGrqOc8I0qh1Z/bx8CZ0Bx3hNSkw5dh8iJikE2kdF/niSO6sXir3TobUrvUJ7uNQjLFIyp1IcHssv+L0lDSs3f8EXVEZLcEgY/HsrWK0iOQfnCnwkaTbZSU0vzavxkPDVdMjkJlhVV0eEbdDe6uvw6Pi1vmo+Xmydk1F5LbmCAGGqvC65+BdLQvBOE+JZH5pshNubFKDAdoa3PVpn8bNimF+BfGdNl7vD1yE3Iqkcr3PZdVKnjy4pHaR2rUJisJzgxo5Rs9X2U7oelGHnNwzY2v6ayPWsk0WX54qR57BpDvqf4teSDOEPVtGul4uTY0ituu9LbQv7Q==
Received: from PH7P220CA0099.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::23)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 14:11:18 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::e8) by PH7P220CA0099.outlook.office365.com
 (2603:10b6:510:32d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 14:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 14:11:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:52 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 5/5] selftests: forwarding: Add test for minimum and maximum MTU
Date: Thu, 13 Jun 2024 16:07:58 +0200
Message-ID: <89de8be8989db7a97f3b39e3c9da695673e78d2e.1718275854.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718275854.git.petrm@nvidia.com>
References: <cover.1718275854.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 276a0df5-f776-47f2-e650-08dc8bb2b197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KURRoXWY5nlH2q2qu1ca/8Cr5SD4YezY0eFsFLwpOfn9ppcJsjQTsijoApMa?=
 =?us-ascii?Q?sjkjo/UseEgJAXlM2F/H0Bxkw2h/WrHDqiK22EZr46TBDNk4yFjV80RVWaZH?=
 =?us-ascii?Q?YRtQyGe+hR7/dj9RmISFhGGb5xjfsWcpo4vsfpDZzTgInE/1E7YpnwRUanfo?=
 =?us-ascii?Q?wAQvzpOkv2A6nsK6IWAmjv0PdEi58e89iBgfRHCIOqyYnS1BtRgx760kYvF+?=
 =?us-ascii?Q?LfBNQqypaQe9HBG+jcD3V55pN/q0O7YltDaMzzLASNVeHS0TsYJJTKS0IONa?=
 =?us-ascii?Q?Fy5jd2bWWUSI7NBM5XfRld7VdOLCQvu+/70PHFdEbpDVhMtvMIxV2tIzV5xW?=
 =?us-ascii?Q?9AJamYi4lYNlUgpwPLlRzJx5kmKKeiJHc3hrg3twVTqoLt4xKK7lS3MJSjB0?=
 =?us-ascii?Q?HCjVzmhuX/e8SbY7FR4+nBbMu61FyZ6wmAsYJ0Mb6Ym2kiSAMueKe8GPklFM?=
 =?us-ascii?Q?82IaLOLfbw+HR6wgKPp7fLO1KVopiA8ehOrydv/p0z9ZYUiIWBW9+6wudBXV?=
 =?us-ascii?Q?Bm10FWSGT5qlIBKTId8S9ajqPc6/bSzPsiT9nZ+SeAOBHPZ7RMT0z09Nr/zz?=
 =?us-ascii?Q?ITM515ywWh88Z6s/rWLYpusRoQcCLYDgUug9iQdVAjLVMESYQ7sxO2bbl/we?=
 =?us-ascii?Q?glQqpK34xwzbHBtWefQiRV6Ee4SmL9oTzn5lir7451vd+chf6ot2UsCxfPPq?=
 =?us-ascii?Q?kjriHobW09j0g1OgtHNyPMI/1Cij9s+za5cNLNQxViYTLb4gl0U/UzMobAgQ?=
 =?us-ascii?Q?faEIaILqtJmNSpic8IXlQQQxKSrhKyfMfUbvMB0FltZgST4I1s6BkuTkkT1J?=
 =?us-ascii?Q?eCY7wH8b5UdNhLKZV74EJlTpEq5ir7DUsRDk1Nf3HpXPpKdV3sm5Bo24qiFi?=
 =?us-ascii?Q?S4VABb11skgcTD/tYfza0OFnpqtlEDEs/v4S2yHx7tKuExOpReu6ISbXs9V8?=
 =?us-ascii?Q?rCf+AtDk3AfnZkRzRy9gAbOe+Bl4ETKosjFWWm2WYhJ8G81ETYR5d9e5mmsB?=
 =?us-ascii?Q?WWz88KDKLgHGZV2TbHJCYkllkyToj+QGuoBzHthNwSQHnj4PuQU+z+z7AP1I?=
 =?us-ascii?Q?3V69huxvGgWdRTHg2eYJfWYYCh2P4QvNCUUGLnUc4Cn1t73eY1tnToEU2Inv?=
 =?us-ascii?Q?Zt4U/SUT8IrXFEnBS3dt0IhIEA7kVn8VKZUHOf1h6xP9e3fq9jwXWpFGsvr/?=
 =?us-ascii?Q?hRgxp4e51dJlHRnnH+T7eRp5Gu2cnteQMlGv886JbRKt0jLewRKlqJFNH4bU?=
 =?us-ascii?Q?7b0y45OqWrafODWriW4J6kE6JafphqoulfyrvHIVniHnJoNehSv7xr0UGa4c?=
 =?us-ascii?Q?0tVUwC1Krd65UV6cOriukU1s+ygIhWjSe8Ufu0CBGYMxnlm/fndk8H4Npl+g?=
 =?us-ascii?Q?DsBjTmxfu37+RkbX6TLLcYmyMwr9wj7V1Qin8NzGX+NcwvhE7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:11:17.8635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276a0df5-f776-47f2-e650-08dc8bb2b197
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

From: Amit Cohen <amcohen@nvidia.com>

Add cases to check minimum and maximum MTU which are exposed via
"ip -d link show". Test configuration and traffic. Use VLAN devices as
usually VLAN header (4 bytes) is not included in the MTU, and drivers
should configure hardware correctly to send maximum MTU payload size
in VLAN tagged packets.

$ ./min_max_mtu.sh
TEST: ping						[ OK ]
TEST: ping6						[ OK ]
TEST: Test maximum MTU configuration			[ OK ]
TEST: Test traffic, packet size is maximum MTU		[ OK ]
TEST: Test minimum MTU configuration			[ OK ]
TEST: Test traffic, packet size is minimum MTU		[ OK ]

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org

 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/min_max_mtu.sh   | 283 ++++++++++++++++++
 2 files changed, 284 insertions(+)
 create mode 100755 tools/testing/selftests/net/forwarding/min_max_mtu.sh

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 99576d7ecbf6..224346426ef2 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -39,6 +39,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	ipip_hier_gre.sh \
 	lib_sh_test.sh \
 	local_termination.sh \
+	min_max_mtu.sh \
 	mirror_gre_bound.sh \
 	mirror_gre_bridge_1d.sh \
 	mirror_gre_bridge_1d_vlan.sh \
diff --git a/tools/testing/selftests/net/forwarding/min_max_mtu.sh b/tools/testing/selftests/net/forwarding/min_max_mtu.sh
new file mode 100755
index 000000000000..97bb8b221bed
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/min_max_mtu.sh
@@ -0,0 +1,283 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# +--------------------+
+# | H1                 |
+# |                    |
+# |           $h1.10 + |
+# |     192.0.2.2/24 | |
+# | 2001:db8:1::2/64 | |
+# |                  | |
+# |              $h1 + |
+# |                  | |
+# +------------------|-+
+#                    |
+# +------------------|-+
+# | SW               | |
+# |            $swp1 + |
+# |                  | |
+# |         $swp1.10 + |
+# |     192.0.2.1/24   |
+# | 2001:db8:1::1/64   |
+# |                    |
+# +--------------------+
+
+ALL_TESTS="
+	ping_ipv4
+	ping_ipv6
+	max_mtu_config_test
+	max_mtu_traffic_test
+	min_mtu_config_test
+	min_mtu_traffic_test
+"
+
+NUM_NETIFS=2
+source lib.sh
+
+h1_create()
+{
+	simple_if_init $h1
+	vlan_create $h1 10 v$h1 192.0.2.2/24 2001:db8:1::2/64
+}
+
+h1_destroy()
+{
+	vlan_destroy $h1 10 192.0.2.2/24 2001:db8:1::2/64
+	simple_if_fini $h1
+}
+
+switch_create()
+{
+	ip li set dev $swp1 up
+	vlan_create $swp1 10 "" 192.0.2.1/24 2001:db8:1::1/64
+}
+
+switch_destroy()
+{
+	ip li set dev $swp1 down
+	vlan_destroy $swp1 10
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+
+	vrf_prepare
+
+	h1_create
+
+	switch_create
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
+	switch_destroy
+
+	h1_destroy
+
+	vrf_cleanup
+}
+
+ping_ipv4()
+{
+	ping_test $h1.10 192.0.2.1
+}
+
+ping_ipv6()
+{
+	ping6_test $h1.10 2001:db8:1::1
+}
+
+min_max_mtu_get_if()
+{
+	local dev=$1; shift
+	local min_max=$1; shift
+
+	ip -d -j link show $dev | jq ".[].$min_max"
+}
+
+ensure_compatible_min_max_mtu()
+{
+	local min_max=$1; shift
+
+	local mtu=$(min_max_mtu_get_if ${NETIFS[p1]} $min_max)
+	local i
+
+	for ((i = 2; i <= NUM_NETIFS; ++i)); do
+		local current_mtu=$(min_max_mtu_get_if ${NETIFS[p$i]} $min_max)
+
+		if [ $current_mtu -ne $mtu ]; then
+			return 1
+		fi
+	done
+}
+
+mtu_set_if()
+{
+	local dev=$1; shift
+	local mtu=$1; shift
+	local should_fail=${1:-0}; shift
+
+	mtu_set $dev $mtu 2>/dev/null
+	check_err_fail $should_fail $? "Set MTU $mtu for $dev"
+}
+
+mtu_set_all_if()
+{
+	local mtu=$1; shift
+	local i
+
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		mtu_set_if ${NETIFS[p$i]} $mtu
+		mtu_set_if ${NETIFS[p$i]}.10 $mtu
+	done
+}
+
+mtu_restore_all_if()
+{
+	local i
+
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		mtu_restore ${NETIFS[p$i]}.10
+		mtu_restore ${NETIFS[p$i]}
+	done
+}
+
+mtu_test_ping4()
+{
+	local mtu=$1; shift
+	local should_fail=$1; shift
+
+	# Ping adds 8 bytes for ICMP header and 20 bytes for IP header
+	local ping_headers_len=$((20 + 8))
+	local pkt_size=$((mtu - ping_headers_len))
+
+	ping_do $h1.10 192.0.2.1 "-s $pkt_size -M do"
+	check_err_fail $should_fail $? "Ping, packet size: $pkt_size"
+}
+
+mtu_test_ping6()
+{
+	local mtu=$1; shift
+	local should_fail=$1; shift
+
+	# Ping adds 8 bytes for ICMP header and 40 bytes for IPv6 header
+	local ping6_headers_len=$((40 + 8))
+	local pkt_size=$((mtu - ping6_headers_len))
+
+	ping6_do $h1.10 2001:db8:1::1 "-s $pkt_size -M do"
+	check_err_fail $should_fail $? "Ping6, packet size: $pkt_size"
+}
+
+max_mtu_config_test()
+{
+	local i
+
+	RET=0
+
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		local dev=${NETIFS[p$i]}
+		local max_mtu=$(min_max_mtu_get_if $dev "max_mtu")
+		local should_fail
+
+		should_fail=0
+		mtu_set_if $dev $max_mtu $should_fail
+		mtu_restore $dev
+
+		should_fail=1
+		mtu_set_if $dev $((max_mtu + 1)) $should_fail
+		mtu_restore $dev
+	done
+
+	log_test "Test maximum MTU configuration"
+}
+
+max_mtu_traffic_test()
+{
+	local should_fail
+	local max_mtu
+
+	RET=0
+
+	if ! ensure_compatible_min_max_mtu "max_mtu"; then
+		log_test_xfail "Topology has incompatible maximum MTU values"
+		return
+	fi
+
+	max_mtu=$(min_max_mtu_get_if ${NETIFS[p1]} "max_mtu")
+
+	should_fail=0
+	mtu_set_all_if $max_mtu
+	mtu_test_ping4 $max_mtu $should_fail
+	mtu_test_ping6 $max_mtu $should_fail
+	mtu_restore_all_if
+
+	should_fail=1
+	mtu_set_all_if $((max_mtu - 1))
+	mtu_test_ping4 $max_mtu $should_fail
+	mtu_test_ping6 $max_mtu $should_fail
+	mtu_restore_all_if
+
+	log_test "Test traffic, packet size is maximum MTU"
+}
+
+min_mtu_config_test()
+{
+	local i
+
+	RET=0
+
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		local dev=${NETIFS[p$i]}
+		local min_mtu=$(min_max_mtu_get_if $dev "min_mtu")
+		local should_fail
+
+		should_fail=0
+		mtu_set_if $dev $min_mtu $should_fail
+		mtu_restore $dev
+
+		should_fail=1
+		mtu_set_if $dev $((min_mtu - 1)) $should_fail
+		mtu_restore $dev
+	done
+
+	log_test "Test minimum MTU configuration"
+}
+
+min_mtu_traffic_test()
+{
+	local should_fail=0
+	local min_mtu
+
+	RET=0
+
+	if ! ensure_compatible_min_max_mtu "min_mtu"; then
+		log_test_xfail "Topology has incompatible minimum MTU values"
+		return
+	fi
+
+	min_mtu=$(min_max_mtu_get_if ${NETIFS[p1]} "min_mtu")
+	mtu_set_all_if $min_mtu
+	mtu_test_ping4 $min_mtu $should_fail
+	# Do not test minimum MTU with IPv6, as IPv6 requires higher MTU.
+
+	mtu_restore_all_if
+
+	log_test "Test traffic, packet size is minimum MTU"
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+tests_run
+
+exit $EXIT_STATUS
-- 
2.45.0


