Return-Path: <linux-kselftest+bounces-46086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C9C7359D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8CEDE2F551
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1322F7AD2;
	Thu, 20 Nov 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MKkLlpJb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA212DC354;
	Thu, 20 Nov 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632852; cv=fail; b=tW9Q591wFKUUG19RscOO5AGujpQHRdsUAGfLp4If/Z4YdlzjWKjaYfOm+HQKrgXMuk3KG9CFUsW+TCQrgM5T9Aub6yDj2N6NwP8P4mMHAOLKir7EQBpIiQHuXWY92KNgzRA7kSo5fkzR3P4Z5pZ3dK+Emg9tW4mQRRR2Nnlwyxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632852; c=relaxed/simple;
	bh=igUAC5O5TXBHSBiZXAQAcKOXw8ADf+FNEEJ58aCojWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiHy45I0B9Xd9GWCon5J9ydpm8/BpIJkpWit7/BvxxvMoA30C8qCiWJTcjPobzj98mB6NQulaunxbOCxUvE1FC0PTPBuzIhOTm0cHyOWYsTv35dizGKeW9tGSNc3ZLskHqSOxWxHXpzwF3BsaXZ0pmpqrtoXoVr5J16R1pqDmwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MKkLlpJb; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG65eONLY7wHnMPTPPDzVbjXUiIUTKUSxKHzoksN4xwbTV2io06e74viKr0IVVcvOX3L5Vc/Iy2n/UinMJrJrNIJCeggaRovb0RgLqH8FCmixQZwuSfXSDFjxqEQaHB257JcZD6nUGzaNNZXUe9hT4ncgiC9jOM8186y8lCjuVWP+opSrKZQ6xo9Wjs4x8D7XKH0/cPnPaiScVSToFqb0YP/cDdE0le5UG0mq1nLyQ1hxsj048SOA4qRi4aMRiNwXYLUw/Gfek03sJA1OLwVPy1InH4REK6D8U5LJaUsq3KJZgjgttkoU7Rpwj0DagolEz3XJVeQ5PbwOZyLkHMeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX0in5LAb5W29WqiuW9NeaA5ugPLBny5DY6xs7hV2fg=;
 b=Cv2YD13j8fC6ec8sbdLJ/LClC3z4QXb//DbuKMOnlFXLkxXFCZjPRSIrboDnHbSI5f4NQQxY5uFQ5gjBqlh02v7/WOnDFsLiHPm7WWTDf8DfOB0MZcZFUew8KWETyeXgU+AYXTbYfFGCYldWh9GqJIUH4QJO6VphdWj/lYLPeK5QScWbziByFUqAKezJ5q8IcvtKbZMguXZH7eMJgfIe5DmNQEORNnKYsFM9/PSO+mvmXyXYg1RfIP6ovG2q3saAJImhE3fglMArksDcxekHNhQWmmKz2a3Ruqp4hySVEeGNPRuYPu8gkMDvKy1w4On6KSRKCvqBbdQwc8HnJ+tuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX0in5LAb5W29WqiuW9NeaA5ugPLBny5DY6xs7hV2fg=;
 b=MKkLlpJbAqhZrzNuwTh7mg3dts90oM1G3arBjFKhLvaqUMMrF8oSGvPH5aPIgQL4Ji410s0t4Am87VsaCa+VH74n8VlYZtuvpRdlsp2gfmkQuRy/K08S6b3pieeoqb6ghqHTpM6PfX0F4IwsfJM6ZaALcChSa71G9VlgKn0JO1j12qy/5M2hCQpAm4d1WvrpqSXGJRMU8jot+M0FtLrHY02DBzXBGZIvNu32NRn1Gjvq9zFM+vJ7MJl2uhp70CO2DkqJENdvOuoBArBP3q1RccpmRP2MVtqXoOXswtpaM0eP8lU7X0+uPcb1gB2yylWon8qbPHXAFSMrYnq2zWW0bg==
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by LV0PR12MB999091.namprd12.prod.outlook.com (2603:10b6:408:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:00:45 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::22) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 10:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 10:00:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:19 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:18 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 02:00:14 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/6] selftests: drv-net: Add devlink_rate_tc_bw.py to TEST_PROGS
Date: Thu, 20 Nov 2025 11:58:54 +0200
Message-ID: <20251120095859.2951339-2-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251120095859.2951339-1-cjubran@nvidia.com>
References: <20251120095859.2951339-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|LV0PR12MB999091:EE_
X-MS-Office365-Filtering-Correlation-Id: 298eb682-f7fe-4778-37e0-08de281bac65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nYOW1Rb6za1HFgUtZRyVJqrxi40zHZnISiFs6WcMJX2RR50PSLHnE2YIfh6?=
 =?us-ascii?Q?SKwWa4KQRoUS3e+oJRz+doLgj27uY+P/KIRic1jrFr5HdGa7bnK/StF0lASt?=
 =?us-ascii?Q?FA9sMQ+tXRcNWx3t1EVRqLcKF83XVtxPtPpOtSA34gB49sTjszz1SxkgqJ7p?=
 =?us-ascii?Q?xjuoYzhF8SM2kEdFOC8fRVjQ/k1XzMnmLLGQijQkrGM92EzTyxm/5aQkpfiu?=
 =?us-ascii?Q?B1rLT/d4vFDHsg/SILVUrg05F6ZrjHRIQqWyaETAot/U75FSK+nMgK+qlVrC?=
 =?us-ascii?Q?uj+/eiRTyU27jImQfXKjTqNPQYkt1Or4kSMopTCi3Hpeac/+EDbgc0/txFwo?=
 =?us-ascii?Q?D8UPIr0r8ofcMK7wLL8tgp0TdKf2/FFQBSULBTo6a9Qnx/OxWoHGmY8372sy?=
 =?us-ascii?Q?JrpArFWgNfRzBgL9KJkDDL+AYsqejeiCgvjk6QXd9Dfc7suSrjVnMuFEQ1iC?=
 =?us-ascii?Q?lUkftN10UxuDPhgGOvd7sJ/Pf2abcBIVntRMIZRR3X/DoCwiGrd8FQv3gBk7?=
 =?us-ascii?Q?vCCcpTKas65jKtmYOG+l/lwkUqPoz52ae+hDKnANFQa/CYk7lBEdoD+aC+vN?=
 =?us-ascii?Q?5zZVKDBzbK3KPu8oXlZlHU4h122bq/z3uNQvpiKxMmCEMb6L0kzqstL+QdtK?=
 =?us-ascii?Q?E1qgM3rgItKswASBhRPqyOJ0GUTG1x8lpsgvyDv3M2UzqYYwO+/2rBTI3msX?=
 =?us-ascii?Q?ozjy4XZA9OFbsBlj+84BP7tiTbNp05qQAJM4oDTMbngGMxX4kVRO3C9roXKw?=
 =?us-ascii?Q?FWSecJ9wqH/0c5pogProWAs61ZTOyLJSQ27TDvGWc3xZLSMMuHRlvI08Y3T9?=
 =?us-ascii?Q?cX8dAykZ0oDjV3FQkQwRsGK5d9nhWhzkymyRJGwBjC6rYxaYZcMscvBSk3in?=
 =?us-ascii?Q?W6ipwiCdG05KdQM5mcFlL/dN1scDI3zpZtoaIICilzoyTpPrNfYeQRgiAvHb?=
 =?us-ascii?Q?HRnKdbtHFa5aqL0GvfrKsVRtDG8EleffzLL3TucC3+fUvuE/iHNFoWt/05n1?=
 =?us-ascii?Q?kqNBPeJAQMz6FySZTvJIENLr59mKoAC8cgPwHrCdPpYwaq3ppiiwLsIK7uGD?=
 =?us-ascii?Q?EO9UmBfiAStjtsKa/sVuW/BY3qtx+pxLoBo9gTdgQSaW55Et6SHvIh+hi7Mj?=
 =?us-ascii?Q?CNs5p+lJLQKqlb5tXvnb+RuEkxTH1V0J3qSOd2Q32lluIciyrExCvhXMu5iV?=
 =?us-ascii?Q?cnTfZwL+hVQMyCz1VnsmCAd6rWn9XpdMXBz2Dke6lGbLneNvPTJipwnjNQ3j?=
 =?us-ascii?Q?aZ9USr7DwC9ovDJ96E9bF4PiZETTMMMTtjv57VeupnPM3wJW/conYNY586EK?=
 =?us-ascii?Q?WVNBnkByXogf6d0n21ywMJ8lHxYFPO8KwMa727K9SaDMl5xr3KHr/sEZI2Ta?=
 =?us-ascii?Q?Mt1om0Mzz3OIOXwHpxxzSKJjJAABy2zReg04owNskG9/fqOsM4Z/VK5si2SQ?=
 =?us-ascii?Q?SjIWJHHkjBz12CqST4ifGENcq5SsgbaN+xS147VVJpKRMr6mFdUJoX0M6i0X?=
 =?us-ascii?Q?LMJ/F7GbvIdgm0RoCqACXNwdOfiHNd65orR80Q+gKET+xIyjDYJ1hDbrCqnd?=
 =?us-ascii?Q?X9Yfw0gpyig/ooOacMg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:00:45.2776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 298eb682-f7fe-4778-37e0-08de281bac65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999091

This makes devlink_rate_tc_bw.py present in the Makefile under the same
directory.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 8133d1a0051c..2f53eaa929b7 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -23,6 +23,7 @@ TEST_PROGS = \
 	rss_input_xfrm.py \
 	tso.py \
 	xsk_reconfig.py \
+	devlink_rate_tc_bw.py \
 	#
 
 TEST_FILES := \
-- 
2.38.1


