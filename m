Return-Path: <linux-kselftest+bounces-22028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2D9C8CA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C01E288E77
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016270826;
	Thu, 14 Nov 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHfyBaID"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71A4D8D0;
	Thu, 14 Nov 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593583; cv=fail; b=XruHTUIjIC1ZmTWuInhNg4b3eVHim3j4pEZ9nXK1yFN1Wxyy8Fcq2DJLLO7ptyT51/s6VCzhIuX9Wky2sjH/8gwdSuNYX958bbky0JSnpd71iRPa5bHxDetFqkiRnEDgXiIbU42sJHn/e4lG9xXVR8IHu/yUfv2MEQXyOsca+tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593583; c=relaxed/simple;
	bh=792cE3F7FT7Q8JnDuxa7P2ra7m8ilj9UEgxnE1f0haE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCad0GNOoHfOFI0b8ZH2BPLVWL9oWtJAX15EtdHO30UQVHR1QdVszyDTHK1TEuMyDrcU7/GChgOyvJWqZiFuFRoxEjGK33oVAqkxLn3+gBr3TSAv6PfhmfY8qYG57rCPNXqXeOTFmJStQHv6PAJI7HAF/knnD8xuyZaAmbWRrBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHfyBaID; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mor0CZdq5StheqTEdT8x6lqmwYg5czstGPxnmQdZivxdcSeWReAvHkpFQYcCIzRvhXOkjAlaSeLfPbMY/isW67ciwxl6kWJ90h01OMvVebXQamaYojsYkSIJ8e/LKk2mBx8I+rV1ch995mB/PzNGB/aC0zcfHyAWVpW6rdBuj8wG8oAuLV1nyXEQhcbeLewZAva4ZfhuNQfHyj4MH2Ad3HjvwpxRGRr02jBh/bJKzAGxc/Wh12tQXK3grKijNBDIGIR6yZSkGSv+vrItSGHRpxWAy+qvP3xa/gbZSqNpeGBwuuF7cF9NzPbLhp/ximMXHY37Qh2Bi5HfV/Vx/wgNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+M7JV+EJfAv5VX8yUMf1PJm9BEK/oRTXDHcSdWSh5E=;
 b=A79T9BFcfazRDrGR6wzjIo5m8o53kC6Q6y2RlnewkBkNOI0zPCzIob05KrILPqGRmoI40rTxVre6HCQIUATqUMxCHjIAzIXDrXWrX+uT1HaVgbKJm779Q+ZA6stQuw1Wql+IAloklVOAeWwyxKxxiszZ9ZXRYweM5vO867jFdQMhJ3gBzBVTeNFnO1uLrgt+fSsSkrhFWspso/l5lC0YZ9uYxEJtCFM0cgQKfvfz/24GqYuj8eIzwvlFJmjPJ8ILuxWmQpspW2Nr7ai0duPpCTcA23/Jz1QLDrJcWvZcryqA9anfE8QbG1RQt7Z7K1RR4SvfaH6o0ZJ2mJi7ZAiMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+M7JV+EJfAv5VX8yUMf1PJm9BEK/oRTXDHcSdWSh5E=;
 b=pHfyBaIDOntpcAE6OLCFR2mlNSMeM5n3kQdXN2aTOWwQDAcrGrElbP+hZMXHMgOJUvi9kF7t4fHSxxYdaEj/TN+m6BLQjjEmW+lNPP0yprn6pFpEyzMYLbZhDxfeROTbXydERGuFbuDWy1vnc88cekynzP6pwZCNSufyKRzYtP6Ury84A0IT14o7hDtKWkxk6MSmRK1cfZhtg7H8aJq3f5p/kf1tp/MJI2zbhI6l8+NPU2mFVOTPZPDhMbLqh3Fv3+gnCBlaE9Ec4NUznLAM6JmDiVa9hpitbu1U+xdSkX7ItU06Eamft4GDPk0KHBCYGe9Iq2nDtFjkeLk6jnj7sg==
Received: from SJ0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:a03:3a0::17)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 14:12:57 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::85) by SJ0PR03CA0252.outlook.office365.com
 (2603:10b6:a03:3a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 14:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 14:12:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:38 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:30 -0800
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
	<jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v4 6/7] selftests: net: lib: Add kill_process
Date: Thu, 14 Nov 2024 15:09:58 +0100
Message-ID: <a9db102067d741c118f0bd93b10c75e2a34665ea.1731589511.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd2915e-f0b9-4cd7-72b0-08dd04b67056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36PjSACDRX3sSAhAZd7oYb14H3LMwBi6sAetYZRHyuYBKKRi+URBPERonPKq?=
 =?us-ascii?Q?dqwoLWx7Nk2haEWdl/bCxj8z46F7Ep4tyfvpY5YjFIKZc83tR3kyIXLOIcS4?=
 =?us-ascii?Q?l1mYAZHEg3j6/dBo9bLRNyrxRt+p/9awpy6k927EmXiKIkADGsD/Zwgf7y5Z?=
 =?us-ascii?Q?guQ4kuvD5PQSR68oYVoin0l6dIahM1emN5d5OgjVnAUM7NSmbJs7m32/MFTg?=
 =?us-ascii?Q?TNiNK4VHm54y3pZTwsvVoCnRTWTw1MLH14W+751lAzvBtt9Y+NVPBoKwFRCN?=
 =?us-ascii?Q?PEAsgGWoaqYgwqGmtx2lyGjaUu3clagywbj0M3iEElrjaubN6BZrXM7hJjvG?=
 =?us-ascii?Q?TyTMMw0LYBdT9P6cN4lqABCx+UWN57BKT07QgAPAYOwvh4jF+bsATN5HogGy?=
 =?us-ascii?Q?0ZNnOJld5hybpa0pErKR/n6442tRU4opTUxJwEusb4Si1z7eN5z3ccGvoDbB?=
 =?us-ascii?Q?pMMeXfG915FkpuLwkSrZ2jvH2tC78K9n+g0JcalqmRaX1TcvXiB/KwR1SjIh?=
 =?us-ascii?Q?ljD+uv3hzVEkfxVTcxwvm/VGx5L8/fbcGUwU/oVn5DGUeIpJsdccCg8ZKdQs?=
 =?us-ascii?Q?socMGwCUO7+mGhD2wfAtlFd64jWyJn1Y4oeaLGKjpNipVkWqu1op10vvi5s6?=
 =?us-ascii?Q?JQrkGdBKrlGxYVPZ2rNlIAJvXU5gq0m85gftWDBDD/jnxBdbWKmCr/67JQA5?=
 =?us-ascii?Q?oOSNS2VBc2H5O/QXoBmTyByE8eriHWiFB9mwPOsHEN8eyNsqS7SG0vYmT9Sf?=
 =?us-ascii?Q?ynuaFdKMEqbi8OvWKEwiZv57y9ea1Rw4189eCS+WBgPn7WwFZm/mRmw444B1?=
 =?us-ascii?Q?R/dff86jKooyr/iQba4LUTnsvT7rZyjJYL6JCtR4B09yLQty/wXcEBLtf4E0?=
 =?us-ascii?Q?IODRYQ2UK4VWrzcDRdKgO9aCIqIbO6qI/RHG8qBz3cLlO308XuXqtx278/QB?=
 =?us-ascii?Q?3KPmqrXc9A7VkTP+aGpjnZCTTIYa+tEBey7xM5kRZOtV7l/xdIJGUIIdnDfW?=
 =?us-ascii?Q?mvdxqXFb3ofK3KAkxsHnxMhj46ahzmM6IKi64cLSqbPH2z7h4J938sM26DLT?=
 =?us-ascii?Q?Rfa3nb7RorKH8nkyz46awrukb2OcfGr4YRHpvTce3dAUS+J5pdpWWGCrmNgL?=
 =?us-ascii?Q?3kD7RPu86Z73HIJYQcOcNyYwMrez/Rf1iw5be6XlsAxqOpz7Y2eep6ASfrKY?=
 =?us-ascii?Q?95LEdjThbizNPU+9D5WMsync+ipCBH0dlPfA7sSsUKgRuNWR5pPk6bMWIDAT?=
 =?us-ascii?Q?q+DquMYB68Lda1ksVw4sAQVVrszvcC66jMM0mOYGb0RUlD3z6eIecTuiEhv2?=
 =?us-ascii?Q?MRoQ8jhxQks2ahEGfTgR+pZKbEY0uU2ep0e87q2lIgGZzAlKZmyk6c5nyR+b?=
 =?us-ascii?Q?gYgwEBEBl2x4sP3LpR6zzLUknJba2rQk4dWZ0KqS74fm/PbMKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:12:57.1438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2915e-f0b9-4cd7-72b0-08dd04b67056
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

A number of selftests run processes in the background and need to kill them
afterwards. Instead for everyone to open-code the kill / wait / redirect
mantra, add a helper in net/lib.sh. Convert existing open-code sites.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>
CC: Andrew Lunn <andrew+netdev@lunn.ch>

 .../selftests/drivers/net/mlxsw/devlink_trap.sh      |  2 +-
 .../drivers/net/mlxsw/devlink_trap_l3_drops.sh       |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_l3_exceptions.sh  | 12 ++++++------
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh    |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh   |  4 ++--
 .../drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh   |  4 ++--
 .../net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh      |  4 ++--
 .../testing/selftests/drivers/net/mlxsw/tc_sample.sh |  4 ++--
 .../drivers/net/netdevsim/fib_notifications.sh       |  6 +++---
 tools/testing/selftests/net/drop_monitor_tests.sh    |  2 +-
 tools/testing/selftests/net/fib_tests.sh             |  8 ++++----
 .../testing/selftests/net/forwarding/devlink_lib.sh  |  2 +-
 tools/testing/selftests/net/forwarding/lib.sh        |  3 +--
 tools/testing/selftests/net/forwarding/tc_police.sh  |  8 ++++----
 tools/testing/selftests/net/lib.sh                   |  8 ++++++++
 15 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
index 89b55e946eed..36055279ba92 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap.sh
@@ -116,7 +116,7 @@ dev_del_test()
 
 	log_test "Device delete"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 }
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
index 160891dcb4bc..db5806d189bb 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_drops.sh
@@ -595,7 +595,7 @@ irif_disabled_test()
 
 	log_test "Ingress RIF disabled"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	ip link set dev $rp1 nomaster
 	__addr_add_del $rp1 add 192.0.2.2/24 2001:db8:1::2/64
 	ip link del dev br0 type bridge
@@ -645,7 +645,7 @@ erif_disabled_test()
 
 	log_test "Egress RIF disabled"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	__addr_add_del $rp1 add 192.0.2.2/24 2001:db8:1::2/64
 	ip link del dev br0 type bridge
 	devlink_trap_action_set $trap_name "drop"
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
index 190c1b6b5365..5d6d88b600f0 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_l3_exceptions.sh
@@ -202,7 +202,7 @@ mtu_value_is_too_small_test()
 
 	mtu_restore $rp2
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $h1 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -235,7 +235,7 @@ __ttl_value_is_too_small_test()
 
 	log_test "TTL value is too small: TTL=$ttl_val"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $h1 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -299,7 +299,7 @@ __mc_reverse_path_forwarding_test()
 
 	log_test "Multicast reverse path forwarding: $desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $rp2 egress protocol $proto pref 1 handle 101 flower
 }
 
@@ -347,7 +347,7 @@ __reject_route_test()
 
 	log_test "Reject route: $desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	ip route del unreachable $unreachable
 	tc filter del dev $h1 ingress protocol $proto pref 1 handle 101 flower
 }
@@ -542,7 +542,7 @@ ipv4_lpm_miss_test()
 
 	log_test "LPM miss: IPv4"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	vrf_without_routes_destroy
 }
 
@@ -569,7 +569,7 @@ ipv6_lpm_miss_test()
 
 	log_test "LPM miss: IPv6"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	vrf_without_routes_destroy
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
index e9a82cae8c9a..4ac1dae92d0f 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip.sh
@@ -176,7 +176,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
@@ -207,7 +207,7 @@ no_matching_tunnel_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
index 878125041fc3..fce885184404 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_ipip6.sh
@@ -176,7 +176,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
@@ -207,7 +207,7 @@ no_matching_tunnel_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
index 5f6eb965cfd1..7aca8e5922cf 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan.sh
@@ -183,7 +183,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
@@ -253,7 +253,7 @@ corrupted_packet_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
index f6c16cbb6cf7..4599c331240b 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_tunnel_vxlan_ipv6.sh
@@ -188,7 +188,7 @@ ecn_decap_test()
 
 	log_test "$desc: Inner ECN is not ECT and outer is $ecn_desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
@@ -262,7 +262,7 @@ corrupted_packet_test()
 
 	log_test "$desc"
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $swp1 egress protocol ipv6 pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh b/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
index 83a0210e7544..bc7ea2df49fb 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/tc_sample.sh
@@ -218,7 +218,7 @@ psample_capture_start()
 
 psample_capture_stop()
 {
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 }
 
 __tc_sample_rate_test()
@@ -499,7 +499,7 @@ tc_sample_md_out_tc_occ_test()
 	backlog=$(tc -j -p -s qdisc show dev $rp2 | jq '.[0]["backlog"]')
 
 	# Kill mausezahn.
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	psample_capture_stop
 
diff --git a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
index 8d91191a098c..9896580c3d85 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/fib_notifications.sh
@@ -94,7 +94,7 @@ route_addition_check()
 	sleep 1
 	$IP route add $route dev dummy1
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications $offload_failed
 	rm -f $outfile
@@ -148,7 +148,7 @@ route_deletion_check()
 	sleep 1
 	$IP route del $route dev dummy1
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications
 	rm -f $outfile
@@ -191,7 +191,7 @@ route_replacement_check()
 	sleep 1
 	$IP route replace $route dev dummy2
 	sleep 1
-	kill %% && wait %% &> /dev/null
+	kill_process %%
 
 	route_notify_check $outfile $expected_num_notifications
 	rm -f $outfile
diff --git a/tools/testing/selftests/net/drop_monitor_tests.sh b/tools/testing/selftests/net/drop_monitor_tests.sh
index 7c4818c971fc..507d0a82f5f0 100755
--- a/tools/testing/selftests/net/drop_monitor_tests.sh
+++ b/tools/testing/selftests/net/drop_monitor_tests.sh
@@ -77,7 +77,7 @@ sw_drops_test()
 
 	rm ${dir}/packets.pcap
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	timeout 5 dwdump -o sw -w ${dir}/packets.pcap
 	(( $(tshark -r ${dir}/packets.pcap \
 		-Y 'ip.dst == 192.0.2.10' 2> /dev/null | wc -l) == 0))
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 5f3c28fc8624..3ea6f886a210 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -689,7 +689,7 @@ fib6_notify_test()
 
 	log_test $ret 0 "ipv6 route add notify"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	#rm errors.txt
 
@@ -736,7 +736,7 @@ fib_notify_test()
 
 	log_test $ret 0 "ipv4 route add notify"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 
 	rm  errors.txt
 
@@ -2328,7 +2328,7 @@ ipv4_mangle_test()
 	$IP route del table 123 172.16.101.0/24 dev veth1
 	$IP rule del pref 100
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	rm $tmp_file
 
 	route_cleanup
@@ -2386,7 +2386,7 @@ ipv6_mangle_test()
 	$IP -6 route del table 123 2001:db8:101::/64 dev veth1
 	$IP -6 rule del pref 100
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	rm $tmp_file
 
 	route_cleanup
diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index 62a05bca1e82..18afa89ebbcc 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -501,7 +501,7 @@ devlink_trap_drop_cleanup()
 	local pref=$1; shift
 	local handle=$1; shift
 
-	kill $mz_pid && wait $mz_pid &> /dev/null
+	kill_process $mz_pid
 	tc filter del dev $dev egress protocol $proto pref $pref handle $handle flower
 }
 
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8625e3c99f55..7337f398f9cc 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1574,8 +1574,7 @@ stop_traffic()
 {
 	local pid=${1-%%}; shift
 
-	# Suppress noise from killing mausezahn.
-	{ kill $pid && wait $pid; } 2>/dev/null
+	kill_process "$pid"
 }
 
 declare -A cappid
diff --git a/tools/testing/selftests/net/forwarding/tc_police.sh b/tools/testing/selftests/net/forwarding/tc_police.sh
index 5103f64a71d6..509fdedfcfa1 100755
--- a/tools/testing/selftests/net/forwarding/tc_police.sh
+++ b/tools/testing/selftests/net/forwarding/tc_police.sh
@@ -148,7 +148,7 @@ police_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 }
 
@@ -198,7 +198,7 @@ police_shared_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 }
 
 police_shared_test()
@@ -278,7 +278,7 @@ police_mirror_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $pol_if $dir protocol ip pref 1 handle 101 flower
 	tc filter del dev $h3 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
@@ -320,7 +320,7 @@ police_pps_common_test()
 
 	log_test "$test_name"
 
-	{ kill %% && wait %%; } 2>/dev/null
+	kill_process %%
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 6bcf5d13879d..24f63e45735d 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -434,3 +434,11 @@ xfail_on_veth()
 		"$@"
 	fi
 }
+
+kill_process()
+{
+	local pid=$1; shift
+
+	# Suppress noise from killing the process.
+	{ kill $pid && wait $pid; } 2>/dev/null
+}
-- 
2.45.0


