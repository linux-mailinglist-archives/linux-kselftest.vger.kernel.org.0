Return-Path: <linux-kselftest+bounces-22189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B51F9D150E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 17:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F33BB2F3DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A21B3933;
	Mon, 18 Nov 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ei2Fk602"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9D1B6CFC;
	Mon, 18 Nov 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945762; cv=fail; b=swBCqnUoM27593FmGGUbFIddb7D+THUCgg9kqCaRcR4GCXMfe1GoOiukeQ1ks4aMZhWZbGDa7/frX5Hdp4hG0VLm+z1QukMkEbXDc4OH0Itez0IQZBLgCI44Pj6rt37hDYY8t1UiCQ3qGBj3kFUmWJvpscY9ayA6PNnXK5DW/EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945762; c=relaxed/simple;
	bh=RUmjpS00KQPThj9efFSMqJlPjLPKYyp632VyEJwERTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4Y5jlVJhlQ4+77Suq/8HUZ5p2FpOLWX+kEVaSSHjdwcuww6mWMoKlSTZtREEKcRWP/Lx3QkLVTzlo1NmGPe5WXWuh3xmAfKqNbJwLNFEBFjXb2WkTsd2ZtVJx1C8Xcdrroau0XLDjTmpXhGdXUQrDcYvMbiNZyYeQBt49lxJz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ei2Fk602; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzmwg7UIdCUDhQW27Bu3VuuxKKYku/Puq4yfY8wcCxsNqy5yI01bpw+tHrcq3IK4w4RbjIs/3d0dJsVur2FdPZntR73xP8jERX2kVR59bheV0avHdyv0jyrHsyMAOQFhOcV/uVXTNHuBOm1l7KFwZnTsItC5v7eluE9LZVsqHAyITg143g8ZwTdH81DrQ+G3kSUNs51OugckMvlm6VNzg3c6JEVfXjIpHnp6LXueQvBAsr0LllRfelAUtAZeW+ROeFSzwPGJlJfH6V8T1u6WtRpNSe/lplit3AvT2H+yqdcRmatFqI90svOLR2joLGogeMkvTWw9iJtKSCCjz6U55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iemher0mO6qrlOQ5kx+Fwf3R18yaGpgpyBN2/v8lXvg=;
 b=e0b2JiNZ6WpIM+Sv4K0RnucIMqVQ8WS5/WHQ0NOdopE8c+QtnXvVQzxsbLz39h9MJHbNqFwk+On151Qwgm2H6uVMOhJRIuC0fNJCOhc7OtksvJNMBvo0spx4YQtkbRC55NY7Qn4VwXSQEVPFEg/13CRZpasOHqOpadPnMUm8n0d+ilgmo7gEoJZEMnXkjpc/5qe/URgonPs6Iu7EEW5b1KsGQJ/xxEWfe/yeyhsivCOvEtS2mvLNKIiFXVp7sfXCBhrinwPH3zTNUPJwgpSuWMGGVWmQsDv7JDNzJDwZEV7fZmWWY8ebnCPRcoHt8yb8AKZ/+va4Om9LhRlU4cfwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iemher0mO6qrlOQ5kx+Fwf3R18yaGpgpyBN2/v8lXvg=;
 b=Ei2Fk602UZkajS+rsKUuBHMSx3xUHvCrI3+mlzJHryFadvcd8AQ5TbQ9K+U1/TYX+faavR6TaszORZRp2LHPqEsuefLDGEP/xR1Ur0CabSjfHl2HqI4NV8blPs6MtxRbYuUHfngCQELGMRzJEXa6T5u/HtqW2eEJ/RpHEthV1HgVq6ZSGeWK+6YB4zbs/N7tOwyoLiPSWVfMeGVwKFezAqoTWNeMfIU2hqvFxhdFcCE8XDihJY4WWeVq+iBFBuLZIiDfApyMMwMSUihwHhRK9+IGUL8IFYnz4ZBRFy+bQv7LjN4N+wQBdITsFwF6gXwhvUyoxizVponicuijUrUyzw==
Received: from PH7P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::26)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 16:02:35 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:326:cafe::87) by PH7P220CA0019.outlook.office365.com
 (2603:10b6:510:326::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:02:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:02:07 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:02:00 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH net-next 10/11] selftests: net: lib: Add several autodefer helpers
Date: Mon, 18 Nov 2024 17:43:16 +0100
Message-ID: <b30e11c0f1c9bd522784efb1c4b5b34c92648009.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 36682764-62bc-4234-86f1-08dd07ea6a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LFkJQ+luQcaoCLPldT/9PhEaID9RZ1sJ8XWw4KuZR5fqajINJvQzmv6vnzsL?=
 =?us-ascii?Q?v3AOKFdB0YxOEo3H6M8ErPzX3CXmkaja1khuQScFiZ3Zfia1AaRfdHW+dMjT?=
 =?us-ascii?Q?MQ0MHA8+cOg0x5l/mA9E0DXG6muQoCahCWr8t+NCSvMBsrufeJaX2wOnkWJh?=
 =?us-ascii?Q?4Bxb2rEhKzV+0tNobaVvzR1B8FufTAhlwo2eTxvVHBsy9LNXYEzMglnts9Oj?=
 =?us-ascii?Q?mWcW+6a4WzypM5oQWb/3BIRQ9i4HAQ/bj8biELWqy1P8P6ocztf/CSHxmm5e?=
 =?us-ascii?Q?iJZyRMPHCor++y5ZtIm43IfpoUnXlMqTtVCHHwRom3f1I6nrs7jGU8T4zkqU?=
 =?us-ascii?Q?a7nS4VfNsTk2oJNOz9xzyQvlyPezttVdwLIuUw4mR1YK8GrNrH5WDQCMZNaq?=
 =?us-ascii?Q?BBjgS2YCqCAYHBzSp2kI8NgqZqehqIB8FpO8VkSQMPVw37ZBGk/vIdTnezCD?=
 =?us-ascii?Q?TnjP5BAHqOXY4XoWyi64vc6VM0u9NkWH1+xTLcxvT3YOXh2Bcau7VMfL2En5?=
 =?us-ascii?Q?bKB+TAnwmFuuMoyFw5Yq7Mr+UXevKdcDDyo6WbR/NNM3im737bv1x/MisIJa?=
 =?us-ascii?Q?XQwf926SjrDBxU6zj7oItJF6KGTw54tFTi0M9pSF2BIdorFHfvG4NWuVBsdH?=
 =?us-ascii?Q?R74P1kjfzDw7ex6+K5w78O3CfR0/YqCjGGP04jycdfVJw0G2mQmxb3rKWouQ?=
 =?us-ascii?Q?ZdvrZvLn+sOMQuCSeATSLLRGe/JnSF2FDF1PuwPAE/j3aND5mzStpMHfbtqd?=
 =?us-ascii?Q?DwuHStzE8FzA/PjZ+u9wgatUkjA6tpiHCx3rVVya2suPB/uHjJk4ppgQTbKV?=
 =?us-ascii?Q?RKmkS1G1BPTufyUiN76RPNCeWdcjN7MqndG87eX/VgIkSaXtYzuuYWYOHHTw?=
 =?us-ascii?Q?+7yONkpPLuQ5BuGAl9R9vKMQBHStosfVr0FlTDqxNuaixJ9iSRzMXvVzAUhX?=
 =?us-ascii?Q?NrzES8+LlKrCMBpakks1KQEorsf5g7O1b/O2xfcWKHrmnBDFEzSTjAk7/e45?=
 =?us-ascii?Q?emEadsGGcRWMa+H4D35hl7H2Q0UY0CHBUH/t9/SSr6S57pdtJVsMzomnSLUj?=
 =?us-ascii?Q?yWIKF3CryoZycJ2+ECMt7FOjG5MSG9NvEDif3HNQ4vr6/qEKT5gPrsIiTCAj?=
 =?us-ascii?Q?dcrK7t1TnCJ8dTzkgaZ1S9p0eVmab8csNOrs0kaxZ6od6HchYU7SPIPuxpl3?=
 =?us-ascii?Q?Gdt65utKoA8rD95CCDpvfluhEnpo9yY9iErnRQlhYR5rRi7723iay4TW2jiy?=
 =?us-ascii?Q?SuFWv4TqFOSdzruLGWhIs/q9H0fOpjOuKR1gtvICI3JP2SaeQjnwHz9bRIjo?=
 =?us-ascii?Q?Kedwvgs0auvHecB4/yKkNFxz3HzLNkd1WitSD00+0TsycKlvD4rBpIXZ3CTj?=
 =?us-ascii?Q?i4OyEvKol/9MAcNRp2d5UiWoe/XcGkC+HQ0Ei4A+oSXKKUhEMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:02:34.3157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36682764-62bc-4234-86f1-08dd07ea6a58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876

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


