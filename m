Return-Path: <linux-kselftest+bounces-21474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7F9BD685
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB521C22832
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0162B2161F4;
	Tue,  5 Nov 2024 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hthQlDLg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7E215F7B;
	Tue,  5 Nov 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837104; cv=fail; b=krs/cYAZsfcWu0votgfYRG/lHdRpIK+S1a9DzZrIT/g4jkqohlTwBPiKm925Y0bK5b53GIqXH8jibK1p27JjNA1OE4i/4Lpuvpm68FskWDv0YnumA0VF7U9NqGNvc58RLOo+GJ9ukO2EYlqtag2q2ivNmx6ExOow40W3n0PrWf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837104; c=relaxed/simple;
	bh=a1M6Xj+EOY5vqxY6NF5R7ZIef0s0hyjAALFMQRLuQmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRJgJww4VsyBGdLQgqJijCO7Yu7wapr/AuLpkak+ufdL6I2nmPkguGeheIVw3SPN+bRybDlNUsJRuBnXk54UEgRSXpFy/3assck2KBdid9hESsAiXmNGCGndcQs5YDF0ZW0AZa+hu8NL0ZJImu6KDuPmmaVthMJ2HKZDEzgIUn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hthQlDLg; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxrKTFCy9oJDp1LilBJN9FLj+hsdf25jZ+WiWyG7iXYTC7QFbLxmQ+/vNM4EkUMqdLFCOSZyEWucIz0DY+LfaSwtAJg5RB2tn1Iik7ZlV2cWEccTtL0Df3BpWxfPdJr6PPX2OMPuh+KUgeF8wwYxlC6dSuArJ45k3O2pTN16AXJzNUj6/ZC8LpKIx8BLaIBdyv/6Zdw7wippKC7JSrpHb7b9uIxdDraoPjVE6TiFttQaC0rt+Quv9z7sIOPPofYn9cNvepTm+y+rlH2LfFxF2oQOBImXv74zaCV3/ftC/KZZpSlcsIgl6I3NsoSQdoq3FlacTyQDl7fMVcJD0aWN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxl5BKf2cVFR686YBxEPCCNYlfJjglgJwFZ2tFWJnjQ=;
 b=e7qkoolhI2EFaftffKXlEgZC7UEBhxx1tt3tLYFRKKrf+0CK899GpJepXzUNijLWiH7twFOKuWKkzXGgCzE8VCe46lvEto12iIgAc1f/KixsnUIkEzpXxj89NjTZin+T8GohTcR5hLs1Ajzo4AsjdiG1Y0IYuuQ9Xc2NB8Hld+sICWbwo8G4b4Ae4CfgMRCCmcvvtdz/AKPg2qyYcSPl2sMVHgF36Y25CxXeb3930tXSJDXD0PfSyYCfAPYqqy/FLJt9TT2Ro/i1QhJxIZAo6fak8ok2mB2WEmsLMFxWrNgruzTrehxeLmZMDhJFTElg9W6MiuW6uBhcMlSoTPNKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxl5BKf2cVFR686YBxEPCCNYlfJjglgJwFZ2tFWJnjQ=;
 b=hthQlDLgLPjjX03l16x4LdInl6ocGoleOYxupWjR/V1uSB9h3aachuy8EyTFoRs9pnvKb6aq8qzFKNCXlWG86EK2StDFMuZwpT96JNEZDJQ8ZRidf1GeU2Uo+Ub+3qpDAVztTdconbnSIfY1ksjZAdBB1gnFWBQsOX1yY8rAbocXnmia8DDpa3IZiZImS4LTmmd2NvVhbn49oL1t7Y1gMbeJXdxC0xPCECA85vf7GZYz/pGs09xkXYoIhFvvp9UcL4TUqN3w0eI/ESzWx3AixtRoqIJ5BxKeHQz2c+hd0Fg0ZCenklVW7R5K+hs6f0IQxFQEX7V6MSHcgd/iB5rxLQ==
Received: from BL6PEPF00013DF6.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:a) by PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 20:04:59 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2a01:111:f403:f901::8) by BL6PEPF00013DF6.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 5 Nov 2024 20:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:04:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: [PATCH v7 04/13] iommufd: Verify object in iommufd_object_finalize/abort()
Date: Tue, 5 Nov 2024 12:04:20 -0800
Message-ID: <334bd4dde8e0a88eb30fa67eeef61827cdb546f9.1730836219.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730836219.git.nicolinc@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 5033ea0f-52bb-4443-ed6e-08dcfdd5206f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JDUd2rgUKuUJiaxwA/HUFNzZP2VJv7LYoV6EUK/caJc86Ryc8cgz3vz882gd?=
 =?us-ascii?Q?Whf4R6i7MLBnYlh098SPHS2GMWr5nGl2bl44lv+SvVhEoNjOBZUOpZMbvkqW?=
 =?us-ascii?Q?7H4J1NFGCzNq7j5IpAIpc9ZCm14BVT5uSKqD4G1dAukANWPRE6K0ez2ahVs4?=
 =?us-ascii?Q?+dIamCLgXQ9DKv83HxBVFB5mEYbj+t5gxTMbGEmOABsEGicOGjgl8DPcz6Wn?=
 =?us-ascii?Q?vf5vgqt+/LSfwE55+z3a/aB/KHmJ1T8xxjpLdvh6xFwbLxTiJcfCGl96lF8Q?=
 =?us-ascii?Q?QN1tpZui1RQ9eTDefJCdKcUi2mnSyEiJhmYn0TzDAIcNyV7GmxUgMrzZl7qj?=
 =?us-ascii?Q?yot8+8htcdpsNxm72vsf3GY+CWvo+C4fuQMfmOFJ6B2Gb32VqugXoiMklZ27?=
 =?us-ascii?Q?95aVWasyhskEgwTWljJyykVc4OMOP8UGqAlooSFBZCwBLs8tLCwJOgpsJW/k?=
 =?us-ascii?Q?TYDQ4OQR86EGp4ZNA8LLOorBrvhu73FDbKB+p41nR6N6st8q++KeSljCD4az?=
 =?us-ascii?Q?z7+5UaHuzfvpLqBwGIWR8AEFrnmaAsLfoAFGx8+hkab7PG9mLkPlsCebwXqa?=
 =?us-ascii?Q?nXK55GoPeH5u9ha+ZBCAOBSKfqoTnXzFyowOVRlN7eSmD6/WlDzuvsga5YuZ?=
 =?us-ascii?Q?269S3mKGIcQtDeVGISiVJK6cI5Y4fGEg4xUdFgu+5zzqP7oS9GiDOHvx25Lw?=
 =?us-ascii?Q?ifQN1yW0URrthyenLKl7u7fgV2rUwCBxVGmHEDqMDO+4mrOOfZS7ET1VEt+4?=
 =?us-ascii?Q?MYm2aBDNDHOr3oC2jrrtm3PkSwgJRg3vRVQ7ZVgrV/3qBRdWIamtGDf9QSJA?=
 =?us-ascii?Q?advvCgoXhWJ80VlnrIyfkMgr6erXToY7rfQZhAHWv7ij9JXPu73t0/9HkVTg?=
 =?us-ascii?Q?M7R/WLd2aSM2gPzlIZQqYqn7ScIv3QUqsN2ZDeIPWT8oX/Jc9eWHDttNTpwr?=
 =?us-ascii?Q?Khe+cOs2fqx1aHaLkXYjzk89P/RFhq9DTg6oDWMgASj8oscAigzbb20EUxca?=
 =?us-ascii?Q?YSwXCnPlFaYZLKUdm6TNGEqNaZmOj/WZLIA0m8ePW9tMRFad346SsARStQVT?=
 =?us-ascii?Q?ijW+AxAjwihZSkfFkBy+sur+WS5EC5mRNRUgiS6vMPan69w3KQt8f5ZrBBr6?=
 =?us-ascii?Q?aF4vzAELOpstTDGbPoGB7XrINzVeIB/jTHqZQsr2cexBnJrruAJ2/hZorra4?=
 =?us-ascii?Q?cZf7S6u/d5Ql092Vaid2+Kjdp0YwoEIBTlfDxvKH4veojFJcaO+CaI251igY?=
 =?us-ascii?Q?iJlZoQnujGfbKkSjHW8lQSejmLpRf6GZajzbb3HpRvBJQqdMCfOgysZDjOjF?=
 =?us-ascii?Q?ou4s+OwND41MSkoGDH+/VA70DP6wEBF23qfI5u8uR4oGzDKAOvvmzKcT/Zp8?=
 =?us-ascii?Q?35Yan8afcCBLvWufVR4HWdDnaLdTv4MtxbPYXP1AnJf1AT9ByA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:04:59.1804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5033ea0f-52bb-4443-ed6e-08dcfdd5206f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596

To support driver-allocated vIOMMU objects, it's required for IOMMU driver
to call the provided iommufd_viommu_alloc helper to embed the core struct.
However, there is no guarantee that every driver will call it and allocate
objects properly.

Make the iommufd_object_finalize/abort functions more robust to verify if
the xarray slot indexed by the input obj->id is having an XA_ZERO_ENTRY,
which is the reserved value stored by xa_alloc via iommufd_object_alloc.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3c32b440471b..30e6c2af3b45 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -41,20 +41,26 @@ static struct miscdevice vfio_misc_dev;
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj)
 {
+	XA_STATE(xas, &ictx->objects, obj->id);
 	void *old;
 
-	old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
-	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
-	WARN_ON(old);
+	xa_lock(&ictx->objects);
+	old = xas_store(&xas, obj);
+	xa_unlock(&ictx->objects);
+	/* obj->id was returned from xa_alloc() so the xas_store() cannot fail */
+	WARN_ON(old != XA_ZERO_ENTRY);
 }
 
 /* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 {
+	XA_STATE(xas, &ictx->objects, obj->id);
 	void *old;
 
-	old = xa_erase(&ictx->objects, obj->id);
-	WARN_ON(old);
+	xa_lock(&ictx->objects);
+	old = xas_store(&xas, NULL);
+	xa_unlock(&ictx->objects);
+	WARN_ON(old != XA_ZERO_ENTRY);
 	kfree(obj);
 }
 
-- 
2.43.0


