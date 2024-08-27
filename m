Return-Path: <linux-kselftest+bounces-16441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C19614FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F9D1C21023
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818231D47C8;
	Tue, 27 Aug 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oN7Z8jwu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0451D47B1;
	Tue, 27 Aug 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778137; cv=fail; b=AtKX4rdceQ2VKuzYZssQdUfRjUF028QkCviA7qP+MyE+u/xHk+iyo7SN6xLObvnN2F2DybFPBmC7cS/Z7eSWAVJ549GbH6hydCzdHia6qgp/zyRX7oZJrcuylq8UiZoT/Vj7IXUEVGt4mJSYSVxY1MTf1qLe2+IczJ0m5ZpiImw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778137; c=relaxed/simple;
	bh=mNbpCl2ZWrPM9bpio3SEMXNhv5zl8VwUOFQ3I2YNNXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNlYo+/DDKEAVU9cTE3uHQACVoiStMihtStp25ZUHxHIoW35uVgHKqt3U5iBPr3xpiZSkLaDHhByRk9aND/qjT2Pf7rq5T6NBr2igWKnbfkKpD2dJ13zBY767Dtm0+ToJNKY1bzLSYOzMtcnc5fFbT75bkd5uK1lUYJtBrlGqY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oN7Z8jwu; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZV4clupA/2eTpYVhdmQB62czdQ1Qpgqvlb+YbdQaGUHOCksIHwC75sEtwMckSqSRrXjehjRXhrvRwTb2fIoX4eIi2RK1x60yLhwb7ozTFAOrrGbBoy4MXBTqBSswFZLN0qtiOXgWS5m9P8IWb7VJf4xYm0lg2GEGjftqk6kBib+Ed57kRMOaHgUjfJoaJ5qcCEpUaV7RQDiD6yMKZKLZiOVYZxXpI6p4rsJHxyAgdg6YS85zqhUUXtddLELwKLUHcCucBOCEonpFDksBcXXlVISWxxR/bH7BedpkRFWRJL0QHddgUUeW+svMynQiFkRhwuZF+dizx8Bi8R8ePwNPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/VHoxUiLpU/MD5Q98bigKlmbsdt5Sg5CnOVwz95Lgs=;
 b=B95IIDby5L9rgMffQbVEMmvTONstm8DSOcG7G6i8+R9068z7uAFbcHYDBDfbAQQ92JdJtXD8+6Z7CHoOvNbNZOA8U0nsMgKq6d2Y8Avzem4gWeFt2oY2YySXB25oGKu0PDVXrV4tdNhPQT7dtn/bNDMQRQjK1Ez6DKEgdOH+in6ohS6MczFJzcpDmwZicu1Vpl/vCAQdlL3RBS36Jet2+nqjNHgx8x1Ny4zHOMJpVTxaoV2h2zLEoUXfvbYDMhR7aZ/WEYMsVrsGBwhdxRu7f3TlaK1Bbsna0wHCf3V77CUDiTOscHBQK5FvM1ukk39snC51yGISvMMcHWZ2SxEq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/VHoxUiLpU/MD5Q98bigKlmbsdt5Sg5CnOVwz95Lgs=;
 b=oN7Z8jwuGr3vUCDXZiq/4S87JAaEbtvgujQBnodtGvOTxhl/BPCqvBMlP/iwGcz5kv3oG3VbDeHAxOiD3Vz6xtbGxszlLIPPOBmCc0M9k1anhnhDsml9CJJ+9zeecXBVlaNjOGYWNt9E3ViUJG5N9aOmnP/ZbmnNGi+eabkBGXgSNEfmG7Qo9GTyoQhdNiqp0HwhTV7MZaZhzYhlAIRONCg3R8ebxSIuN7mCSVa8dpFKCx0bgpofnK8omhDW6fppA4TV8/MKJi+80Ahe9pq+sKvTz0qnegs8teuVFks6B6PqSZJtX7/8inEI7vLAa6/zCaEcTjAMfqK909/jCypYPg==
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by IA1PR12MB7592.namprd12.prod.outlook.com
 (2603:10b6:208:428::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:02:10 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::94) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 17:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 17:02:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 27 Aug
 2024 10:01:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 10:01:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 10:01:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 19/19] iommu/arm-smmu-v3: Update comments about ATS and bypass
Date: Tue, 27 Aug 2024 09:59:56 -0700
Message-ID: <c5eec29e1825579bbd94fd8d1b61d52493a1cdac.1724776335.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724776335.git.nicolinc@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ee9509-a54b-435b-46fa-08dcc6b9fd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p6ET5sb+Wgx1w+PSqZmC+liRH/fB0vFOSYzfqhfk4Wo4y5XI0wIpsX3+Tfeo?=
 =?us-ascii?Q?/G5hywQxCPwNs7mhKDnz/r1NpFGqABxV0mgZsY/7SVukWeHCZgIzsZbCCZha?=
 =?us-ascii?Q?S6tl9g2joZaxfhQGZ0LxahZH93PLG44q1x17mmSrCitLjei4Y7/cGP7TF0JH?=
 =?us-ascii?Q?dmpcjH88kE+2F40T4vcUMmuiwZLSdOaJPZdj51dRb71uQd/vd5M8s32r6vXP?=
 =?us-ascii?Q?IV2cEj1bMhpDGFW2e8BMfRrqQn59QVpShkzxsLyWdCjEO36jhcGy05StEWGR?=
 =?us-ascii?Q?GBszE6/Lp8TT14s5A42w/kQIVYjdSViLFK86QV6O1eJeiI9Oj7iI0aI+Xd9c?=
 =?us-ascii?Q?8W9ZMGECigQhnZb2581CpHU6M6Oy2CTFGl4UAPUy5qjWSshrE2wgFVwBoQLQ?=
 =?us-ascii?Q?skqcOTNKp/2/d9EBuXDY2i/QXBNde4MU/xxoDNXAPlWvh/Z/TAnfbopaU8cB?=
 =?us-ascii?Q?bOiDIOPdDPL8qggpkzx/WlQh4GamWD2Mq8XEMlJglb4mkBWOWiMihYOGn7x/?=
 =?us-ascii?Q?c5budxZk+6/wlzzDxLaXte7P/YPE4AXVKuZMQyent1DD1aNJlvZ3VWekMa0v?=
 =?us-ascii?Q?cDw8nQKPTnUqtijvA8isTFU6zdd7TIR7Z+Wtmp+PhUC1OlaDQAnTy2vBvXzM?=
 =?us-ascii?Q?gAcgo8O8AhQKXvmhvI9n1+UxpfgXABgTNDk9hMe8sBg1Gs5ilweqN4DHUhCA?=
 =?us-ascii?Q?52OlhhfudrDRAoXVYA0SWrahpzTQ6tVsplKv3C964KZYIGH9CD4VHeUXjltl?=
 =?us-ascii?Q?KlQIGZ9YudV18oavTa7ysP9iDfEltZi5wuwmTJCBERid1Q5M1W+sTs1nMRxz?=
 =?us-ascii?Q?M4a5hFFjNIXUtu1zy0WC1neCY9t606LDcclD1bUlzWW41/WDlAhVDbsCsGuR?=
 =?us-ascii?Q?tAKj2urM9NWD2mxctMmwLWREPBwum04t05JrGxnSIjDEaazO99dOQqaqDwTR?=
 =?us-ascii?Q?d7VbUcz1A5IpT5jlDY1EEDnz/l247XCPVUicoOlQbbkpoTnkATzyMffJJ8w4?=
 =?us-ascii?Q?HIoXo5tk8T29apId6Y9u6tnuIw8lNbdcwgk0Iy/vSCeaRD0Z1KeFe3CnyHh7?=
 =?us-ascii?Q?XaxczvAxw1CSXATl9d0VOY6nLyK9CALhM1Ky+49HiYvz3RMLYtwFOnk2ts6s?=
 =?us-ascii?Q?nIJGSEcAMnRsxlho6uRdk8glLyVWVjuMkw8HDItSYCQIDWBh0mtFXRadVYib?=
 =?us-ascii?Q?L9E/XyAZDdTCXxkwFQt2+x6GQKBgZghIIYXeadtRqo8d0QRFB6O6AV8Ddqyz?=
 =?us-ascii?Q?YkB0a2It6P19yBqT0Fp2lAUnewDFvDodIHEvO68NYpKviYzhseTv+BHQV15Z?=
 =?us-ascii?Q?xbMwPk9Sqyom249edNgPX6lXSHYW5NBuggREBHuffFGZ+NTj2M+fZwvrSGyJ?=
 =?us-ascii?Q?HhrMMO6U/4cp10goo0fbgVibiHY7EumiGjq8Hdczxjpi1uNT5Qg/S79QG8d4?=
 =?us-ascii?Q?kjLq+Mqzemn1lQUcRdCnCLQaeTz8TI7k?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:02:10.0294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ee9509-a54b-435b-46fa-08dcc6b9fd5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

From: Jason Gunthorpe <jgg@nvidia.com>

The SMMUv3 spec has a note that BYPASS and ATS don't work together under
the STE EATS field definition. However there is another section "13.6.4
Full ATS skipping stage 1" that explains under certain conditions BYPASS
and ATS do work together if the STE is using S1DSS to select BYPASS and
the CD table has the possibility for a substream.

When these comments were written the understanding was that all forms of
BYPASS just didn't work and this was to be a future problem to solve.

It turns out that ATS and IDENTITY will always work just fine:

 - If STE.Config = BYPASS then the PCI ATS is disabled

 - If a PASID domain is attached then S1DSS = BYPASS and ATS will be
   enabled. This meets the requirements of 13.6.4 to automatically
   generate 1:1 ATS replies on the RID.

Update the comments to reflect this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6627ab87a697..ad43351145d0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2830,9 +2830,14 @@ static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
 		 * Translation Requests and Translated transactions are denied
 		 * as though ATS is disabled for the stream (STE.EATS == 0b00),
 		 * causing F_BAD_ATS_TREQ and F_TRANSL_FORBIDDEN events
-		 * (IHI0070Ea 5.2 Stream Table Entry). Thus ATS can only be
-		 * enabled if we have arm_smmu_domain, those always have page
-		 * tables.
+		 * (IHI0070Ea 5.2 Stream Table Entry).
+		 *
+		 * However, if we have installed a CD table and are using S1DSS
+		 * then ATS will work in S1DSS bypass. See "13.6.4 Full ATS
+		 * skipping stage 1".
+		 *
+		 * Disable ATS if we are going to create a normal 0b100 bypass
+		 * STE.
 		 */
 		state->ats_enabled = !state->disable_ats &&
 				     arm_smmu_ats_supported(master);
@@ -3157,8 +3162,10 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	if (arm_smmu_ssids_in_use(&master->cd_table)) {
 		/*
 		 * If a CD table has to be present then we need to run with ATS
-		 * on even though the RID will fail ATS queries with UR. This is
-		 * because we have no idea what the PASID's need.
+		 * on because we have to assume a PASID is using ATS. For
+		 * IDENTITY this will setup things so that S1DSS=bypass which
+		 * follows the explanation in "13.6.4 Full ATS skipping stage 1"
+		 * and allows for ATS on the RID to work.
 		 */
 		state.cd_needs_ats = true;
 		arm_smmu_attach_prepare(&state, domain);
-- 
2.43.0


