Return-Path: <linux-kselftest+bounces-19341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53299699B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF3284765
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E75192B89;
	Wed,  9 Oct 2024 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pEjEezs9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554FE190074;
	Wed,  9 Oct 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475797; cv=fail; b=j+sgXI1KAyULGYDDeHRwnh8kxtv0N157CV9/ukzRW2gecoP8ymjXR2c6K6JjK8EhS+libxwgpBCPP/LsGZw3zRV13DXzqPcHBVXjXcACqjsOCfR4t2KRZ7d6GHqE1R32FkSSkcImRb51QyVTGIXXbfNq/2YvE7frzpRRHL0ZdGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475797; c=relaxed/simple;
	bh=ode908XCLSDd5G+QWaV3cUIGg0Wd4AxpyTA4eXEeS7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8j+G1zwPTyKgzsKLrRNebtx4WVv7R7+cONAtYM8XoDseQk8zBjzIQTNEIZIu3w4CQkhtS9fNQMZoF+snLGs/vDJmi5Uo7yG4wNRUJ2ySlRRn6BvbtJXUAMRuFR3LdE28KC73lD2yF6gJma+1TaAE36m3dqrJlr7gOfmzIiOA1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pEjEezs9; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5Mm1vGaCQLDwP9+Jjk3shqVDQR6FfKWNE3m1yuJBKAYNChlVXzaG2L4IFft4sQTZ2daDHghF4zSxStTfr9rCgkwTbBiS7eCKqAbmBhOZ2L72R5SaNE6I/mvFKcJrdRMGaQa706dphf0JCtGWnx8XITmU5i8q9sv8PtPNeGSLB66cnMBi19VcqONanrp3tjsGccuKDOz/pYus1L+DvVqmhDh2tWyRZAxaQIN9fEqI/OetkaHmNSbPRu+MIdIwbfgxPNSJc4peOnBoR+o6WrhFdX48D2fT7/HGMIeYOEkjcXq4JlLc79B8E0Ej1PQkkIKEKCkmh5SRaGMAF0IlPdsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb+B/zKUwixV0+EP3ly1AHKv3dETzlNyG43ysfafncY=;
 b=HpjvdHKckScL5M84gUL+FfoQz5QR9jxa/ZJc2BQ+slCQ1d4/Jr+S/VxjR1JC4xPVXPuJBKrZsAdbSLLVWJU0zyCnEtwsr14r4y666RmOH7OktjQ2gRs54c48pJqJlv8w7Ix5FSwiRYM7sJ3GczSbWBHD4iEY5Hip3ZaFEzmtuyC/GR3ANupyF7yi6JUdGduqxdFCLSAHsNaDisqN3HRCY0Kw6IqmcYlDu2qlCnALVxjMGaGdmn+l3LrnbnOeSPAoNSzpTceFGvcvexRx+cj6JoEzpeC7iZ1ZHw6RPuQhwipPwz3ETcjxS+VXIOxiHYKlvSO/v2igo3jQPN4/FIb8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb+B/zKUwixV0+EP3ly1AHKv3dETzlNyG43ysfafncY=;
 b=pEjEezs9YhJzd+vY3+cDgzAFgamuLjZ6Qh7G5ZNXJrkXcInO7UWrAIVvtm8GJUFU4g5JFu9mxJ38HixqWYdD91Rvlrc+lAZHa6N0YufTlf9lqlpP/2qzegT6neoF0/bKf+vQDNeMYjSISz3JtgpY+x0nrRKHl7+rj8ytATXYv2otHHzQoKfnOiH6BoF9UrQv7aPXs9yD4uNyg0jWA0P7SMd/Q+G6nFS31F2FqmaUGIIHeD8UwvcavNiOjoWY5wQddXQVRzKhw1Iwu6mLZj46TcUNMVFAG6/D+rRfWwymSE2EAe420F334dtZT5huCxac2CZVdpJaz7AC0ZUPZPaFfA==
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.25; Wed, 9 Oct
 2024 12:09:51 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::cf) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Wed, 9 Oct 2024 12:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:09:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:36 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/10] selftests: forwarding: lib: Allow passing PID to stop_traffic()
Date: Wed, 9 Oct 2024 14:06:21 +0200
Message-ID: <4d7cb2f1a05beef5076372b19da4b7d3f08b79d2.1728473602.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728473602.git.petrm@nvidia.com>
References: <cover.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: df53bf79-37f3-466a-f96a-08dce85b4707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xOEjA6XzKsFr2dqPoCNY7rZ/uNwt4e4HKUDDdUZ2UMveJ6nDQpc5R0ZSI2sA?=
 =?us-ascii?Q?nZvNt2cRmsfhTeZYCS2QWwxWwWJO1ithOEpHz0bpQNjJwE+TBAf9ZAM4gYgF?=
 =?us-ascii?Q?gskOY2RmOj2X2Vbf1N7OhAoNXL885l4eZef+DfifJWgWAr0fMBVwEKuf/2yj?=
 =?us-ascii?Q?L25guwlgWNrbbAJzReArIfnNI98d74Pzcvx5BhtTMQ1DJjvteTB8YJh+aNDp?=
 =?us-ascii?Q?mL/JR0aDbO3D4U+s6/2hPk8XrvXMw3RTvhgU6S/VyU/p3iyHJBtbeEkXK3IL?=
 =?us-ascii?Q?FrIE9IC5gvKoR4grNWPRC/tJfUONU7ztUYr59VnT6sLtrm+nIAapLC32rFai?=
 =?us-ascii?Q?SDuKwRVZGHMZznBtYHuMJfi3SwpCs/M1YZmDPP48SSUIqY6EIXXLxmeRd+/i?=
 =?us-ascii?Q?h9ra1lVUyD8fd44gswMnE4Ben0AkMssNOEd0VqyRTmoYNvRG2dUpvRuKzngp?=
 =?us-ascii?Q?bivIc2hjMt25B/IPcW47iZk66m8hpofTHpGsv8CXEHrJqt78sRIrM8SGX0RQ?=
 =?us-ascii?Q?EXJrrRsDbYc3VJoHAZ1wpfObSld+/CTyn723O6L1Cdp7FnUAe/Bd9TjJtZdq?=
 =?us-ascii?Q?FbD/ExFyrfdf7eVjvSff7PybMSFqY3DbAkfGbsFqYU4W13ZrHih8Qn7rRYvb?=
 =?us-ascii?Q?CUXMZXReUKZagnLTmBBQqdAlbpy6+co/OtptgeOQ/TPdGHASEDSiLLBFL857?=
 =?us-ascii?Q?ZEnhnQdLQ+S3Ehzx/yA+1PKY8Cot9tORN2GxVZYDCISfAOGY+Zg2UwGGN5H1?=
 =?us-ascii?Q?meqiGKlZpR3QetaSb91R2atahYca6FK6XWW/VFIr+X1uo47PJZHhQgq/L8i3?=
 =?us-ascii?Q?OS9t0Zn8GisX4mPctMJi77rZxRB1bDWoR1mGZ/uitUxYXCzQMBFpv0ZYGr8s?=
 =?us-ascii?Q?kkLONnpDluwHofgZzmLdCSttMY7xR9V1qXWFH7Vw+ori+6BN5/Iv7VWKN9bx?=
 =?us-ascii?Q?1PIJSp+yMP7mo7DgZlTmAjkY9+sSf0AeEPmNFhPc4EAs8NIApRP5AgFVOeOb?=
 =?us-ascii?Q?K9J7ngvy06bf4UV5ZrE7a3Gz+ueLH37+BHUSo28WcZNgevjAbqBYF96aC4O2?=
 =?us-ascii?Q?BWH3l8YJ6bFel1W3ZY1gYgn4Ll6GcKQQ9J7aRTMDtb4H081MN+F66lTv8XrV?=
 =?us-ascii?Q?He6GWRX1J7aGGoVPS33WqX5rp6/tGTuMjkXOgy/+hY6Ed1vcvlZnr+nZ8a04?=
 =?us-ascii?Q?GaxX2IA3twehaZCaLSWHwMOSuPwXBtmrDBAcuGC/krlKvR8lVvqB/eKcWpuF?=
 =?us-ascii?Q?afHR2dGPhld9MbMltPXkhiPKeu17B4MPOFKlOLbhVSZ++U8JfxPJuiKWgHCH?=
 =?us-ascii?Q?Re6M5+zwjjUbpA3G0gMyeScesR7paGCHdyLylxMpUGlPOexf63V2F6Sv16Z2?=
 =?us-ascii?Q?2HuuX3lRJiHt/zoZQN90/MbF3IKM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:09:50.9734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df53bf79-37f3-466a-f96a-08dce85b4707
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071

Now that it is possible to schedule a deferral of stop_traffic() right
after the traffic is started, we do not have to rely on the %% magic to
kill the background process that was started last. Instead we can just give
the PID explicitly. This makes it possible to start other background
processes after the traffic is started without confusing the cleanup.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 76e6d7698caf..89c25f72b10c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1768,8 +1768,10 @@ start_tcp_traffic()
 
 stop_traffic()
 {
+	local pid=${1-%%}; shift
+
 	# Suppress noise from killing mausezahn.
-	{ kill %% && wait %%; } 2>/dev/null
+	{ kill $pid && wait $pid; } 2>/dev/null
 }
 
 declare -A cappid
-- 
2.45.0


