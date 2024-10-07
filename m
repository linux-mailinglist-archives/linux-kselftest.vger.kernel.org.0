Return-Path: <linux-kselftest+bounces-19168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7E99334A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1631F2447D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177A21DBB2E;
	Mon,  7 Oct 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OpfONxLv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775DD1DB545;
	Mon,  7 Oct 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318556; cv=fail; b=A7JjxBbaDfbmY2ifpIlZMnSsHXZrv+dJEndW/RSZhG7MDNe4h775AyMhAdNEUvVsyDC5NWSuM/2CVmPkJy39VyzyaG0CIGNAFZpzo1jT/ZoqMVtd8/w1ztRTbo6mNeBsCY43RmDastOxVLIQa5mS7KEdP26kYrk30VxNuRzcedc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318556; c=relaxed/simple;
	bh=3uArr2WkUSxJOZJslTpzs3LF2GDFlY/MD+lN4lsrMm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JC9OVHnUcGWm985XPPleAvbYxwNI0XIoEnHCmzjuQ7ByfmqiC8f0CYSf98+9e5eG+uKkH4B+TdyoPhPiA3WgQllsVl4qCc3BJcKj4gN8yliQB46wGd88MOxJpXt+9uB4HnWJjjZRlWwa2xhiMNMp4UigOnbwoXiJW/OdVycmdAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OpfONxLv; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5gfBYL9y7/7W8DsfcgzMJVG6cKuzLWrHAD647VWE8pkHqB+0ccc4TlPzaWOhYXLu2kB5lA2LVAIvuwBxDfBqFMzc9xTtef1zwzzJTPkNu4jllFfPhKlUvwmhD38JQ0qyzzm03dh6194/48mJyO8TWg73QOcgVNgbUqcpRyWbhgTxb7cFqudGqHc699O6/R3WeNEcdh8yEMrJBTLDqNM3PjIOFhtN0LN5quIvcoNO6s9bgiKQ3C65PNeShRAl8ZTCrfegC0OVAY6dyHxn4ig9fITj3fgz5POC6WT6ShaSF2PoE3oX3vgZg45Lg9NddxW/ronlh4bu277xIPxGZ/XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kucBeUaaD7T0OMvOyX/PlniBj+q//TbrV91GCESvcT4=;
 b=L9i5LXcox+r/zFqWBJST3kXx+PTd8a7LBUe1v25FK7/3/pIbVdX0wNN5CGjaV1yrer/GIEaJV6oqExfwZCs56NEYZcW1zxRYaMC2uixRF2ZSaC1f+5Dhk6BX2i6Hij0SLWHaA9wDfJBANyMP/k0+W3fL6kJS6TdU2kmN5K9ETZU6uqHJSxxPbpljH4sJj7zPfHIfpKHsFsVQtz0uClcbU0dc6RY54lnXaJss6nhTVtjr2RV7VqyqX7TA0AWW0hAYAZEJk3iD/wQjOIkNiNXfBGL158J8f/7INkTNEkkUWaMEnfoGa4kDNR/b7NlJbtaYXpTuU/65Z9wEQ/qQCo4rZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kucBeUaaD7T0OMvOyX/PlniBj+q//TbrV91GCESvcT4=;
 b=OpfONxLv4E295j0iVWDi0P8R5tqLnIjGmO1t+Tfm0UnV4vVM878yM/dl+6PVOmhpFaUykWJ426GCcMWT2QpksI408PnwcwEF1kmaR8V2xPn5NGLu/U0p71hTKAa8aIBXdAcvpY09sPIbDdZAmFenq3lx6QJ6rmvLE5p4JtsPzUrhl8tZW557pVjgpaE8Jt4DDnHWBvwKRMKnsecdGGrL8q3vbrpaGsZ4N/RbYsObSUlGHDDP8LUOFmInaYslqZSAms+5FQot9S3CVSOqaJp2h587wg5uDprghYaET9UjuMSfcgCh1REjpgOEMdedqEB+3kuSMjldTCowrOpafAWudw==
Received: from CH0P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::24)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 16:29:11 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::74) by CH0P221CA0038.outlook.office365.com
 (2603:10b6:610:11d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 16:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 16:29:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:53 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/5] selftests: mlxsw: sch_red_core: Lower TBF rate
Date: Mon, 7 Oct 2024 18:26:09 +0200
Message-ID: <c6712f9c5de75ae0bc2ab3d8ea7d92aaaf93af95.1728316370.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728316370.git.petrm@nvidia.com>
References: <cover.1728316370.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 066fcf55-d87f-42d3-e4af-08dce6ed2c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XByQ9rK/SlITGnB8xoABWhvI8djiKjjde0+O9ndJbjqSxhsPG3wrDoEXgbYY?=
 =?us-ascii?Q?SUcKvSy2XydYg2pvqc4Aikcm7c8zUpeUfVXzr06Gua8hHYdRb5UWUNQzLsim?=
 =?us-ascii?Q?D1WDwmjQttPyZKDaMeWruBoxE4XlCyBV0WU2vC1ECJS/TwsMEbUxhAJ6RUbg?=
 =?us-ascii?Q?ze/ueyJUtv6Hk6jWzQtYkkYoLScmiIDNh/NqX1qL1XwmB/V7YEK+Opd3BsdU?=
 =?us-ascii?Q?GNbLbNxMNijpfFAkvdr90Nbeky7fmj0jKx46VTQkQN2PBqTkUQsu3jqukn2E?=
 =?us-ascii?Q?ksKXSLA7Uixn9gWrAGLBnA4xOJCZTkeGZLEmSdFVe2d+1j9MTm2mS64GDNpZ?=
 =?us-ascii?Q?O4Yo+Uj+aYKwt4/DGWx+bCsKfQ2dNECCbUD0KCasdx2fOQa1E5cGTDOP1v35?=
 =?us-ascii?Q?9Jc9SK//OipSjK+vL29Lyr/+JnH2h38iUAupu9bYtiHtTDfuR4rVxjN3tBnF?=
 =?us-ascii?Q?2WuhhSowxSmTAYzLOu/7xL90y/eBwq/1ZXPcyv8dhQkX3PshWlSjKKdt6/XH?=
 =?us-ascii?Q?srRXe6sMs5jvaXYHdGnbSY/A/fygAWsoyYj+tT1DDxsYlqf5KgprdL32bMk3?=
 =?us-ascii?Q?3cxXiUxF6CATfd+vX7Dc5UatotdtQifmqmaee2Fk224LaatDysr983La+k3i?=
 =?us-ascii?Q?b8qRxi8TuJNZic37Xo4Z01cfyQWi/qkcZrwdhGmR0SRvEm51oJ8O0VJ0ghcN?=
 =?us-ascii?Q?BTV64isexsXrCCYNYLflXFRyscj3PN5BpJcLWRcBclInTC8o1mXupM4eWW4X?=
 =?us-ascii?Q?Z0lpkliPujJu2AoGiqk4+QfJchzeabPbKX496Ytyiy5iZxdGjmtJzAHG6yv3?=
 =?us-ascii?Q?+kyrN91xGjB1gt+Lpui7/+hSXMSCPzos9vcqfBCaqjC08xbrrvlqNoKaBA2m?=
 =?us-ascii?Q?zLfDPziFR0S8LxAKW9xEdZIH3+ecRoSq0+cxBjXq38vFSVethyOD4ID9QDVP?=
 =?us-ascii?Q?y2F3/lLEaiA6sJBqo9DUszOSi5iZruPks2rOS/HMomcN/l+AsPWviPlb3T2d?=
 =?us-ascii?Q?lDP98h83fkSTei44b/u7M3YyyT8jM6tFNb0qsvzES6tvySl4xtHDDCKFYTmv?=
 =?us-ascii?Q?WdGE4IEtWUOttY9fuC9vmAP1bYvUpul3i/KGYMZaGBJuMBeHLyPOJoySFjeR?=
 =?us-ascii?Q?MQMMPyNoftznI/JBYa8VkLBaNUM4R81o7rYm/m5I6+nrOvRpYx7srOfrTRwo?=
 =?us-ascii?Q?xT1HYB/tBMfXlTHgBhFs52eQUXt0EO+7VRl6GaHXUFTawFwsrFuoolGxC/2X?=
 =?us-ascii?Q?g7MSRFgamThkM0CFvwusoex5wFEvJUHvQjken4IhzBYtB+uWowvhI4fr1iJy?=
 =?us-ascii?Q?B8m710AhzhW2X+KOEIT+Jrap53B1FqmrqkR+M0OgLU6tSodBgZmk9tkx/z57?=
 =?us-ascii?Q?9Jk8xSo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:29:10.6517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066fcf55-d87f-42d3-e4af-08dce6ed2c8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204

The RED test uses a pair of TBF shapers. The first to get predictably-sized
stream of traffic, and second to get a 100% saturated chokepoint. To this
chokepoint it injects individual packets. Because the chokepoint is
saturated, these additional packets go straight to the backlog. This allows
the test to check RED behavior across various queue sizes.

The shapers are rated at 1Gbps, for historical reasons (before mlxsw
supported TBF offload, the test used port speed to create the chokepoints).
Machines with a low-power CPU may have trouble consistently generating
1Gbps of traffic, and the test then spuriously fails.

Instead, drop the rate to 200Mbps (Spectrum has a guaranteed shaper rate
granularity of 200Mbps, so anything lower is not guaranteed to work well).
Because that means fewer packets will be mirrored in the ECN-mark test,
adjust the passing condition accordingly.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index 316444389c4e..f4c324957dcc 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -137,7 +137,7 @@ h2_create()
 	# Prevent this by adding a shaper which limits the traffic in $h2 to
 	# 1Gbps.
 
-	tc qdisc replace dev $h2 root handle 10: tbf rate 1gbit \
+	tc qdisc replace dev $h2 root handle 10: tbf rate 200mbit \
 		burst 128K limit 1G
 }
 
@@ -199,7 +199,7 @@ switch_create()
 	done
 
 	for intf in $swp3 $swp4; do
-		tc qdisc replace dev $intf root handle 1: tbf rate 1gbit \
+		tc qdisc replace dev $intf root handle 1: tbf rate 200mbit \
 			burst 128K limit 1G
 	done
 
@@ -602,7 +602,7 @@ do_mark_test()
 	# Above limit, everything should be mirrored, we should see lots of
 	# packets.
 	build_backlog $vlan $((3 * limit / 2)) tcp tos=0x01 >/dev/null
-	busywait_for_counter 1100 +10000 \
+	busywait_for_counter 1100 +2500 \
 		 $fetch_counter > /dev/null
 	check_err_fail "$should_fail" $? "ECN-marked packets $subtest'd"
 
-- 
2.45.0


