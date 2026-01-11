Return-Path: <linux-kselftest+bounces-48687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAAED0F81A
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 18:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBAE7300C980
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C2F34C820;
	Sun, 11 Jan 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dsOQSyyc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727634C989;
	Sun, 11 Jan 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151856; cv=fail; b=ArJXgNWBq0KKyPIFAO6aR7kjx0APX07yylBsQq7iNJzTZ9UsLcSlluAbz71Kx/wd76FCdJVPWJCWySrYOm6UTGXA9jX2tLX0k42D6daCYjV1RS3ReAJb24o7Tun2M9ANvxMfZ0KhZxkMu5vt1GLgwwL8xIYxfoiFieZV6Der8TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151856; c=relaxed/simple;
	bh=XnW+fwoTS4owYjhorq1GziojHnq1crBxeC0dKewWoOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mg9puLNjGpnRF6DAr5A4HnRmlDPw7F4J35bxqyVoqRKIB/JbVmQ0a/tul+W6vBiQRsMTiI2E0QLIgOZgwbTssPI9WQCXgC7jaKffjXsEFqvXQ6eN3PJAY7HyQk9aqKqYtA4FCYQdtAXxNr9C9q9MiZ1/TiaQKmCm0P+o0MssFZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dsOQSyyc; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0CYaNlKuqFgqS+eGXOAwq4wGWPUHCsskSCOFo2A8InBmGrjCPsaeknFsJXyG9kdTtloIIcq3zBBR61dySh5zg6dRfd9OC2F5F2c3Nb05eJ0KxiFHOCI6UBT0dZ6C1adSJcvrz2p/Z/WUXW9YyInH3M2Q2tHXGR2WIb8Y9Lvve5rwC+Ek/xeSpiAZLZ68AOVMI3QvfEjbqHDIQj4LVyGYhoHCmpbzzkIRNx5N3TAnaiVMzux1VjmwxguX9aiY3rCI0eZV+NAsvyu6MSbx2OFhxfG6+6v5yrDJGtLDvtDbzGYFwZxs11ejGgLPAQzUtI95K3OQvyn9byw3pgPtyZDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSnj6f+Ex0DXLpjo+tJCO5qg9wFNX4SARLkrJsfvG34=;
 b=tB0O8cmCCVa5gYYt5fkEl/z3uyQz0yMOKWAmMaVK3gwiEpam3DZEEx9UyLXmC5XGl0zseWpNulIkhyaCMxg0rQMUgOV+VjMZvbK44JdOJShfSjD7n58WUDhcRVdtwzbM2dsAvTE2men3dkMuF9JajO+6EpMbvw9RMraVONoI6Yac/uddHIh/n6vAjnJgqNTGUgt2QuHDjdD2rkb1WVTfg+NSl5PSlA54clwe40GnMzkfAFvrdyKmX5eEjw1dAt6QOdoaC/PWeBo6Dm8maL4a7XoJi7q/tccBiYrluJ6W1EcQfiby5OBbReM6v218YQm/tSdWs7czJqG/8klU3BA+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSnj6f+Ex0DXLpjo+tJCO5qg9wFNX4SARLkrJsfvG34=;
 b=dsOQSyycyncnBS9saH+cGgNYWwqX3tX9VDrxbAr1Lmm8HY84ECYE0cJdpDQtafUrVHl/z+6L17TYcwRVvvrn3mDsFaqjHgx7tCGGh0RczKKGdd8Adrgk5ZCC4312PNIXUZTXtoZrVawpKn41plFrK5/uUTQuGpflZlHkjzDGPh0z6oLmidv/a9FPIcKREoKOs/sR3ENxktoBFaVwAOvfhq8HsWok0JIZyoWG5v4n1vpSHFKQvLIrkQ346P3JTOJ0Q4/7Wtm8NQhw0BOpMO+Z4GbYjtAv64DJLjM49DSJcL3NaRBK+PIJhCEFPqhjASBmGXr/0hK4FxevicA8WY282g==
Received: from PH7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::35)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Sun, 11 Jan
 2026 17:17:21 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::1c) by PH7P222CA0008.outlook.office365.com
 (2603:10b6:510:33a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 17:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 17:17:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 09:17:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 11 Jan 2026 09:17:10 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 09:17:07 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	"Petr Machata" <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next 2/2] selftests: drv-net: fix RPS mask handling for high CPU numbers
Date: Sun, 11 Jan 2026 19:16:58 +0200
Message-ID: <20260111171658.179286-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260111171658.179286-1-gal@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9933ec-7c79-43ce-374f-08de5135476a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEYENVVPRBvAL5/RNHirTN/BMRV2XAMH9wc47QIYPJlCfeDCbee1MUXrEq1H?=
 =?us-ascii?Q?5rZca6CK6ldCM9oLR5gAwK9UIU4j7Hz5iQMiR5pW3cJRZ1z6YCEXuVpGSTP2?=
 =?us-ascii?Q?0g8TV5E4/kCwnYPF7vkyny1fgjb6oYa8YEtsDAZAlZSNKHFdHCAOa06KY6bj?=
 =?us-ascii?Q?wJ814r0B7F56SjVpZTpt8wvVvj7RZWmGEJFQZwoFAximNXyUElEqiVfRZEw/?=
 =?us-ascii?Q?Wzif5mnZ7tMj+l00/mpnfk88C8cmhuMsc7atZJbFd6/TY/4XXKbLifoO0vB2?=
 =?us-ascii?Q?ut3cMHwaJeIB2Qgkn495Cg5bZi+yePOjr3XjO6NJQL8zKGc9czun/sZylenI?=
 =?us-ascii?Q?2XomkiTQWaGFjjEb54L3ue1z1KfY9hDXXUQNaJQxLjeWbA2gM1nPbWRjMqd3?=
 =?us-ascii?Q?VqJm1alwr+QNqsmKt6ql1yg8GODHkXizZjF3jZsLZXoeKxpV6IOiQFN0g+iS?=
 =?us-ascii?Q?ZY/pFSzFs4u/YdHGSQ5Wl8ccYdUtxhTswKehMBx8r4KGV/V6S5mt+NVuKTeM?=
 =?us-ascii?Q?Yv9MC1BZ08l5v8FUByyql2ryXFZlkCOP+LJ5lfVqV+BILudxjuM3CzL5XQd4?=
 =?us-ascii?Q?u074i+WDPkybZlP7pFbphF2Q4lYZqfA1giCoJSRCsktTSEjRiNZOqrjjboN5?=
 =?us-ascii?Q?nD+QD21GFQu1RtM4JJlSr5EKF5Ay4wOBQwx0YN2wy5ElN/QEIa84EwpaaB6n?=
 =?us-ascii?Q?JwctSdgsQgd75ppDPM6emRdH1AFtFh2feXAtKmQd+ts7DnqN0cHPORmM2vrl?=
 =?us-ascii?Q?zrpE8EYnH0LTGLgm3h+9XPG6JzOBpkg6xkovlrNC/6X2P11WjEZpvxFYob1M?=
 =?us-ascii?Q?VEI2wETR/nfh0otJ6KYBFz432JRv4XpK6jENmkmDfhzwDusqJtvh2YjZY6SG?=
 =?us-ascii?Q?5p2EvwuIFDMMyKGzsFowVVBAFsE7yKpfTzPEWQtG4rAnmgYMq71+yPiLW805?=
 =?us-ascii?Q?O16Hre2hPQMTGwj9RR/vu4O0NEUj7NCNTIVj1paJjDx7VjiINhPDrSjKZ3BK?=
 =?us-ascii?Q?JpXqvKYJfisq2//sA15+GOMCEIPYZa9mtcaDtNTZZzG3xkLDdefI0STbBpBf?=
 =?us-ascii?Q?Ew4KBUT6X9XbCMkVIpfPr3P/65P2zHAm03v/TYctD8AYZC4cy19he/77HqHt?=
 =?us-ascii?Q?XDfxOD9iiiq4gJ+T50tEef6LSjZHsbkm54A0OBOkhQcbjGzLllZx/vW8j178?=
 =?us-ascii?Q?oNR/sNfRDLSKIZFsxoEk3wdvzpcfs6gWoEt/cTV0fec3U/CiGkCBPrrkpBRI?=
 =?us-ascii?Q?x2RzDqQLb25bzWSGpqt59fhQHdEtAiQfUgBtxr6doygdEvD/rhdIrNzXE8XU?=
 =?us-ascii?Q?iLSEvpWVlBCMPWvnEy4UYIPdqPr1bEzHLLUJEQy+ahto4PbsWgA6ySPKg60N?=
 =?us-ascii?Q?eoCIVOJR74yne3YL+yppJ3QZ5QO/xW5Ha+06o7QdutKJFNgU/7UVV+0Gb8I1?=
 =?us-ascii?Q?qB7soOCTEWdw8uvwmSxEtZPmFnnSo3UQCqWxA4iXnl4/2ZAUPX49dgdjwC/x?=
 =?us-ascii?Q?EJawdQvmyVNx/DeK10MOSmvZLM1Z1GcXVF33TmbZxNFVLHXdk0z6xWPDUGwW?=
 =?us-ascii?Q?43vHnLy2F92p9psxkNo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 17:17:20.5516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9933ec-7c79-43ce-374f-08de5135476a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160

The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
0xfff0, only allowing CPUs 0-3.

Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
0-15.

Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/toeplitz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
index d23b3b0c20a3..285bb17df9c2 100644
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -485,8 +485,8 @@ static void parse_rps_bitmap(const char *arg)
 
 	bitmap = strtoul(arg, NULL, 0);
 
-	if (bitmap & ~(RPS_MAX_CPUS - 1))
-		error(1, 0, "rps bitmap 0x%lx out of bounds 0..%lu",
+	if (bitmap & ~((1UL << RPS_MAX_CPUS) - 1))
+		error(1, 0, "rps bitmap 0x%lx out of bounds, max cpu %lu",
 		      bitmap, RPS_MAX_CPUS - 1);
 
 	for (i = 0; i < RPS_MAX_CPUS; i++)
-- 
2.40.1


