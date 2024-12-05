Return-Path: <linux-kselftest+bounces-22871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68C9E5A15
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F4B284DFC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14C224B09;
	Thu,  5 Dec 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N6uCRaid"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9EB222590;
	Thu,  5 Dec 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413490; cv=fail; b=IDfIviDP17TZSehP4TOHRARYxE69F9gCzCpME3bqcyPSzMcaEvOQCr6h11gEIC5EKa2OfOxGSCmfwW+c8Lj7u3D8Ftj3ei6+4l3yNutBRNma7KkNyJY1VVV/xui04WsQRcdxxNXnm52rxC1U0e9KxfQVq10indBC5a4n2GAafoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413490; c=relaxed/simple;
	bh=RUmjpS00KQPThj9efFSMqJlPjLPKYyp632VyEJwERTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IhxVByptLGE95e8kj5fxaenU2EqPWSGdCcCFXeD3AMcuu+TCdmaUVu0NoWnhEg5GCn6smNgeCejyGse9X8W4c1YnrtTr2zC3FSRYa8OJWtUTi0YFr88cTw2bcUOvd0HSC8plO54w1N4jq4karycdNaexvcSrgnki+AFF6f7KpAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N6uCRaid; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOQgStL4ud6XbnN453TPVzKtfImBNVPPPiVxkREYUPCt/SYLFBzplYgFH0C6eIHQ4B1Aub2PJ8/vQolf33dx0n/YGxGnk/s6SeOXQoW2Y7s++hHtJTNP6oT1/xKLBjcgZO3GfqHMYX+OZ7KiksK2D0/Y8LESNTM5MLMb3C3axGQB660vVwOHw+z/eN6xlbQ9cB+cDsPpR0AxAg0RC4jEKDoRDrS8cGTmA9CmOOLc5bsX/KrHDKTE+Cgx7JQdW0vAbNc5PM1elGpZ0MuGTzVfUUiu5pcV+Pv/Ojx8ilVezaC0k8e9tS4kkEhHjjyU9JbaVtm3BItDQ1SCp5RoBfNl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iemher0mO6qrlOQ5kx+Fwf3R18yaGpgpyBN2/v8lXvg=;
 b=nnmVVVr2yj6GhrIdTt1CQGsx8Dbo4ithvBvzPMnInf9rAhW7ji/YVXqmJhBRsseKLlvLOHQ3W5x4qLrsC06h11NuaXjm+RXGAf+r/JetvZfZZs+IJvGYmm82q05vCxWc6fHx5wlEvzDVUVD1mJFZQQflJ+vXA42HOyxv//zNW3iRVk8RzK24QwOKsDCCRjic5v+SiU+Na0WWxIjcoslgOGoE+L2vP7QZ9utYeY/dWwydvujD1OrdVrMwl4CBvGyPGUnBsNR79qsRipKGtUYc6qKPv/VB8XxAfmXLwWrPla/lFa4Z7aRViSqBnSuNNHRTbgN7V/Q7DBIsaWlD09veBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iemher0mO6qrlOQ5kx+Fwf3R18yaGpgpyBN2/v8lXvg=;
 b=N6uCRaid4EdFjrIt/xU+YSep6FeaqVFgbSU+DbJZJ/iJlMMMCImx81XKhFgPxSPTrOdTJR8JPfJ2vzFqkZLrz1T12Vqsvr/0pAKWZM/u1O4OMVsaQswPDEZwGhPstRT4BO/MDs4eM7GMD5mCHo9YJirea9waYN+IbNprEulJIdKOPxRtLEyP2GIj76xAWfYMzrfpcR9KBgrPKky6uYj5Do1SzVLUftQ9QRz9QWBwHGQaIZcFSV0P7QnZblccFgsLbqfxsTka9TXF1sh0Esmip5wnwrgN/0e73qbInBBxnJ9Y4waoDynbJUPSQ1bK2hqBIykY1TD4OJemvDGckPz67Q==
Received: from DM6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:333::29)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 15:44:45 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::3b) by DM6PR03CA0096.outlook.office365.com
 (2603:10b6:5:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 15:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:44:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:27 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:21 -0800
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
Subject: [PATCH net-next v2 10/11] selftests: net: lib: Add several autodefer helpers
Date: Thu, 5 Dec 2024 16:40:59 +0100
Message-ID: <add6bcbe30828fd01363266df20c338cf13aaf25.1733412063.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: e2144707-998e-46d6-92d1-08dd1543bded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dq3aUKywAiUFleFHdZ6MKbdTqJ2GS0xCcjLihnkW6aEI5LzPaOrc9L6421kp?=
 =?us-ascii?Q?iIub5Q0zZoiApMG+LGrm/8H8fqWZrQfCevYCI0X1xmoiNGvDG+Tqns9fr9Pt?=
 =?us-ascii?Q?y/3PvPIy33xyxWBY3RFVnJCHg5zwOhU/hXkFUyQWHL+9qGMkaJEUDz9PjnPq?=
 =?us-ascii?Q?G/hs5IbagHUndVQPothp+eyQPkDEwAVG5gJ+XGPEtTdjTUMPUPtowK6GW8G2?=
 =?us-ascii?Q?voRlEUeLOO1t0+xGD1qBGEZ0+KiMxRLMgxmLLQ5b5fTskDqjBrgUPaQ/0cTc?=
 =?us-ascii?Q?7UtEm1D8ulqh1sqoHaLDIHHwNjV7iyOV9Dpi+5rNVJ0xzrnSu/fLfh3vRg8X?=
 =?us-ascii?Q?hcM3mcjlms99Lglen86/z012mF2aMbqkpFxQEWYU74h+VdfjaJ52WKeIK6yN?=
 =?us-ascii?Q?ziWItFuE5X/o8mrnuuKyfdtLwkZFBbQj9ZzilipXYmzZKvRrdBkjNwekYBxr?=
 =?us-ascii?Q?2W+TDFyyTpIsiHdp6SfvPTLPVDO5CZJYWoNmfWqlyBkbvpoZYELM1evtYCIM?=
 =?us-ascii?Q?07kCUjhBheGUmG+5csHuE+YqoD1zeqs+aUorjbMHoH0DdurqK4LFk5nUZhai?=
 =?us-ascii?Q?js+ZjzGT6ulMazfAZY8IEEhw5ejX2s4r/rInLUMoDMh6Yuv7jQd8JRfU7lZ7?=
 =?us-ascii?Q?gNntkhbIWLQNWZrdQ1u35Rbu/VCujoKERtlMndpO9aqzzrPfywPGzEL7V2VK?=
 =?us-ascii?Q?h4+EzXAAAk6WjUFfOhbWzscyMb1IFliLU7m58mVWqXuu5TB7cQw24V5F5uan?=
 =?us-ascii?Q?0wk+WNGDixXpMpXGxSRtLblyQBaYS2/sKsTExti5gJxCHWLF1kAItUR5vNX2?=
 =?us-ascii?Q?9+tdLmC+yhiBDRSpi3vB4aCAf2lF+NNH0CmOBts2c2REFSoOwOSwsninSPjz?=
 =?us-ascii?Q?KPyY14D/x2UpNvzKCf+83eURy9u6YpdGEn3ODzVasqTCuHjPohWwhKIxv1t5?=
 =?us-ascii?Q?p8D/f1C64OYiIrIAbsTOZ45zH3/TYjhbCVpYGD6EzArgLXnf7WfL5qB+v+7I?=
 =?us-ascii?Q?ODv91jhzOxWrLU1P1DbQTjJ0I4RtIeUtK2PZU/lmBxojCQReagT70qY/cOBu?=
 =?us-ascii?Q?c+CI6pracWYsfmw0CEQLxJg0CC0gDVqd49db9uBEhKF0zTpNj27drdMHhvdi?=
 =?us-ascii?Q?FoxCAE3PTQA4PUs6SinSAqE2/YvlNC8z8S9hZR5Elh+Fh2znNaIVoHCtNhF+?=
 =?us-ascii?Q?++21bB5sqn2aVcI98KSM1hkAK2fWayl8KTEuoBybwegATiBwxmC1/6GXQKNF?=
 =?us-ascii?Q?vaG/0UoqvhO7kE1MuvqR6/XESpE5LAKHfbJ00C4foJSQligKTo2bfE/70swj?=
 =?us-ascii?Q?1o8tk0lm6pxtqBbJfpqG3COzVDnLmviw8XB1C0xrzbSJc9T7IfbC6TigrooF?=
 =?us-ascii?Q?ndHOkBqAeyoBI7lfTQkSaynSaHar4HRDmOL6VmU5MEoDcSaTZgeNH3TvoPyM?=
 =?us-ascii?Q?sWfwZFKKZO7OBIK0AUd6ofJu9TBOeVyj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:44:44.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2144707-998e-46d6-92d1-08dd1543bded
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533

Add ip_link_set_addr(), ip_link_set_up(), ip_addr_add() and ip_route_add()
to the suite of helpers that automatically schedule a corresponding
cleanup.

When setting a new MAC, one needs to remember the old address first. Move
mac_get() from forwarding/ to that end.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh |  7 ----
 tools/testing/selftests/net/lib.sh            | 39 +++++++++++++++++++
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7337f398f9cc..1fd40bada694 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -932,13 +932,6 @@ packets_rate()
 	echo $(((t1 - t0) / interval))
 }
 
-mac_get()
-{
-	local if_name=$1
-
-	ip -j link show dev $if_name | jq -r '.[]["address"]'
-}
-
 ether_addr_to_u64()
 {
 	local addr="$1"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 5ea6537acd2b..2cd5c743b2d9 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -435,6 +435,13 @@ xfail_on_veth()
 	fi
 }
 
+mac_get()
+{
+	local if_name=$1
+
+	ip -j link show dev $if_name | jq -r '.[]["address"]'
+}
+
 kill_process()
 {
 	local pid=$1; shift
@@ -459,3 +466,35 @@ ip_link_set_master()
 	ip link set dev "$member" master "$master"
 	defer ip link set dev "$member" nomaster
 }
+
+ip_link_set_addr()
+{
+	local name=$1; shift
+	local addr=$1; shift
+
+	local old_addr=$(mac_get "$name")
+	ip link set dev "$name" address "$addr"
+	defer ip link set dev "$name" address "$old_addr"
+}
+
+ip_link_set_up()
+{
+	local name=$1; shift
+
+	ip link set dev "$name" up
+	defer ip link set dev "$name" down
+}
+
+ip_addr_add()
+{
+	local name=$1; shift
+
+	ip addr add dev "$name" "$@"
+	defer ip addr del dev "$name" "$@"
+}
+
+ip_route_add()
+{
+	ip route add "$@"
+	defer ip route del "$@"
+}
-- 
2.47.0


