Return-Path: <linux-kselftest+bounces-22782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4C9E2F15
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 23:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F528B432F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9B20A5E7;
	Tue,  3 Dec 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USXPZjiR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144C1F4731;
	Tue,  3 Dec 2024 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263862; cv=fail; b=KNuBC+3wI9f8RSdlSYs6AkC2EjRBx3TfJgznINYCn/loRcyN1lvWUKrpoI5IfWJNfa7WBY31OAFaixfl2vg1rXp4bVEllrQPpS6s6vKipIN9p9vTxgbYaLUclOcT92Ft+dem0ZpIzJZyEIIvaie/O0Zi0biWHYvlIafwonL2ag8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263862; c=relaxed/simple;
	bh=SdCBj2uXLFm+1vQ32Jx4dXmI6GK4VL75xAUnSRyLET8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRLNiWpIzeGt3LW+MyQTC1JjJBbVeAdg7YKAc6UE/4YqbSq/j+gM1BvmuhZWdoRSNYYUBpGA7EYJDisYahHGrsSao66hxmWCBiQ9TUa/CphRk4ydIlcLMbcG98m73pK1rwH53MWya/03zUonmsIvvmpgs92wCTJAy6xFM+VyByM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USXPZjiR; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiiJ8pXEn9IfTCehyy+emCFvqUmFtuCZgB09rMJ/Z7g9CqgWKMix7wcg+zHPk1xCMtTpoViAMPZUwHV58eSgh7QvyVrb2c1mFj7YBz83zM7wtcW+X/fLr6S+wf8/n2cKq2E3+Keabu+XDFR3FL+MqCCUBaUh9NO065YUhlz1/hI3ZGunSnVqR3Oywy18aVkNdLztcVbdODCy5ax9w/UuRd01IVfpI3Kaka584w6E3il3nKTmEHMsNQIZA3anBqdS4r5yoCUNVq8WeE1VMIsvttbtrK33BCjgZDRFutbDM8/jvEKyb4JQ1Lu9n0i7nzXOcXLemroq6viA2ginh4gLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oJWlA0/XfTsiyTYhZqVLMyzG6VJMEKxWTSUuqyJttc=;
 b=yhNORA3NcPRkKHVuUXDmCm4crbe+uh3RVbdFhM1WmpcRHcD304rUCWY8I6wayOB1W6vQsAUXOdSaUQ1fH4DT/QOjP8Dqav2VOYuvzwpEovyGQR7HL5QtT+MoTJJdYmbwwicnY0TqpnIDX75/D+6VAKf0vNb0XcF/DXTnQxqNimKSHG6O2sjtgkLD0yq1VXMH9kLhzYtEFXgaL6OEL5BYbqSgnSbn0/CfDCFEXrcraFkmQXOZ0zsupE30OOChlI6ZQEmJcG5XWi7wUgC7wGUm12tjRJQxunMauWhHGrQdhQ4mkbx6phLeYT1JUtCUiSxuXN3saGSVJrTWzbzZ2LG1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oJWlA0/XfTsiyTYhZqVLMyzG6VJMEKxWTSUuqyJttc=;
 b=USXPZjiRpNeqf6JOaYl3Z/rkuA4CwyS3Qu7JGifK4dDMGimhAO0r0Bn/Ep7jcWMPROC6dJCl23+Yo7sm1HQbFvX5bGwhvvO4M5PQ5IW2yHbgLe/uDe1puZXkWFgmLUVVBEmRt22t7+ROxks3uvdY3iqsxjbnoyfXcjNayjP/eo7IrL+fXOt6OpkGr482cN2V6Z+Qt084mGzZMf1RqSDku5hMr7ES9dE2M+9OqVOTJlAs+aR1iEHhFTojLAB3LSt4jCvV3FnEC3nrzusefu7J/tJ/mBjtLLCWjz5oJ2uyW4fWJgn5deUXskQMm7RigLmrDklsZlpCwXs6Ds66WT5h9w==
Received: from BLAPR03CA0130.namprd03.prod.outlook.com (2603:10b6:208:32e::15)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 22:10:56 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::26) by BLAPR03CA0130.outlook.office365.com
 (2603:10b6:208:32e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 22:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 22:10:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 14:10:38 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 14:10:38 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 14:10:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>
Subject: [PATCH v2 04/13] iommufd: Rename fault.c to eventq.c
Date: Tue, 3 Dec 2024 14:10:09 -0800
Message-ID: <9e37e420e46844d5a10b055e512e7d94f1446a0b.1733263737.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733263737.git.nicolinc@nvidia.com>
References: <cover.1733263737.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d730eae-557c-44ad-080d-08dd13e75c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3KQC6dAsd2IQDICSVvHNbzN0nBxL243nt5cmCXyqDLy52hNOi72c/O+aRrL?=
 =?us-ascii?Q?fPem2Sg4PmdyPsORWP/WxukBOL12sG0M2ZlfE25qjG7TwukGW80sUQaYnCmR?=
 =?us-ascii?Q?kdw+bvRE7HYMPfcOx3pR+9cJvDg57f1bNE2hH/it3DhpY0rWZslkw5g/HsIP?=
 =?us-ascii?Q?zKlOoUsABvolDlMpW8SDuLXVfOrgWZ0AmoxkWwInjGerO1wr+tKtaLKwOnMw?=
 =?us-ascii?Q?8TJTGC3QF1sJdO0yRsqzR8REQuv7Dahotn7g2+Z+eflGfc7pwfMMcB/C2DWP?=
 =?us-ascii?Q?sR7GL0RRM93ZAGDRRMXiTiu75f/PQ/4uKcxjHx50RplZFzMOM0fSpmF+04Su?=
 =?us-ascii?Q?ZFatt5VDkfZC7V10EsYRuOXwJLyDNPkYapjuhB8n0R2mMGoLy1Vhr38d/VnW?=
 =?us-ascii?Q?IJvYAXonlF3jhZhDVlsSi/Pd04AqtM52pGlTXBSx7WQx/AqMmuAdDpZHM084?=
 =?us-ascii?Q?p+KErW4Y5/N2ZriDRt79lHhwc7CotWR6dwzCJhhCIBWJ3IdqGA6hDJgcDLen?=
 =?us-ascii?Q?GGkefEB+0ZjEbUpU9HhuRwr+Z6mLTGTxJObGL/10J2rzbUcqDUBX0NMqjs2S?=
 =?us-ascii?Q?q/62K4Y115H2A7MKuujw18XNHr7kCqJE8ChGXQJO7PLwvkiGFxgCtpz1JN83?=
 =?us-ascii?Q?k2zTTf5CAs/8kJnCUOxnLvAVy7+WrPlBJHOBe8SbGUZ5isWU7NULzLuGBkyZ?=
 =?us-ascii?Q?0wAVuUpaNIwdNT4FPoIy5wzhzUPndrBaHeHXIH1fbaIblh8k1KL1E40j2lLj?=
 =?us-ascii?Q?gxSB0V0W318T3gRsIvPdVN6D+kSLKw1DU3sFdl9uhMflIUfvr5xVWSLDZCAM?=
 =?us-ascii?Q?vTyNrpDI1CKwhDu+ZQpfLBQ369NGK0W8QegzALc4Puh9QUsR6Uai0xmzzgx1?=
 =?us-ascii?Q?/elNrSzfl/q0qb2/BCk1vOOFgNHKUgqCN+9FB96JN4v6G1fxFaBxBTLjN+g1?=
 =?us-ascii?Q?FikW+zhLeTXsVKo9Q6jnVUnCP6MuAUjIsrjDvdMKI5C30ZHOf0vohELsHQlB?=
 =?us-ascii?Q?VMb5I7KehLSIy7ov9DS97RHLUOJDfa/IZCN41RlHgOpuAOufd7Ex930SjsMO?=
 =?us-ascii?Q?jOaMPuEpVGwJAD8AhPQ85KjsOAW4M9rlSZmYT4lLM2fN/K44Ztg+/dmVmbbl?=
 =?us-ascii?Q?ylcmv7jhbT/xQTgsqW0+aCQmbd4AKHYCM0hNEyzAuU59vUdRzrW7fXWHNBuy?=
 =?us-ascii?Q?XitFfRWwuUoxo1ZGKJwfuM+/uChB+9o9lTdngI+MxMDV7qz3LVWFGj4J8pJ6?=
 =?us-ascii?Q?H/ohYdhf5+M/2HKibOszagC8y0oszEifbsyHtrFr/mDyQsFdK0yXflGYQ+gc?=
 =?us-ascii?Q?qAOi8AcKd0bxMvKq5vOv38bxQi3LA2G9xWREPMYLAn/wxUjn8TpBvSsleplK?=
 =?us-ascii?Q?AKB6lYrOyquLvWWvcQuakUJr2sFwZhrYIInKyxqFCr9gjMOB9FHGW/gTn5MN?=
 =?us-ascii?Q?6UG3XrU8qj/oCkZ2N6rYLWwux4bqAY7r?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 22:10:56.1921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d730eae-557c-44ad-080d-08dd13e75c53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

Rename the file, aligning with the new eventq object.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile              | 2 +-
 drivers/iommu/iommufd/{fault.c => eventq.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/iommu/iommufd/{fault.c => eventq.c} (100%)

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..71d692c9a8f4 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
 	device.o \
-	fault.o \
+	eventq.o \
 	hw_pagetable.o \
 	io_pagetable.o \
 	ioas.o \
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/eventq.c
similarity index 100%
rename from drivers/iommu/iommufd/fault.c
rename to drivers/iommu/iommufd/eventq.c
-- 
2.43.0


