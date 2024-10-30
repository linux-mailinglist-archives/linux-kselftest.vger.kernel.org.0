Return-Path: <linux-kselftest+bounces-21166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC119B6F34
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BDB1C223B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87652281FA;
	Wed, 30 Oct 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ep3AOnd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9B2281DA;
	Wed, 30 Oct 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324111; cv=fail; b=lK8NrFoM7sr605iI9CRPzU1tTvf4MjUR0VUcA/ESI9cVkuzOzcVusCTav22mtG2dc0/VOJoMIjPZp4AMYU8XY7HrpEnCRpQgKWco2p+OscJYxTvtD3YtLVEHatbGPvYOSOyEASfhM3ntXu5hJbHApsXgVL6KHj7ELl814KQRv5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324111; c=relaxed/simple;
	bh=pHf/gD37lHkraB3+JNnYPKaV+hzpKQjuT+yMlPfyooc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyHSfgJQzxxARPvlLVZc4jkdbCVF2iFDjNnQDt9Pr5A6Clpv2w1/L0g/+IFhU9MKRLEsgedUW2OjDMrHwiiHh9EcSF6v839CP0CqMxxAOIvhNYcyCHIaSOO0ZHwFHUkLcpgrwtr8wgnQxlm7CwGoFPrYCM7rLFOEf6SJmzhpErk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ep3AOnd4; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbwJuCdN4j7YLhDvbIAZs7SxhMPM6JNkYu+mffr5eVicKwpYYh74+Vns1QeIsnbAGzUSXDvc6AIMvtvZao/RHXz2VgNgXQMihEm1hdMD/WMhbNm4mIgFG3VSUAcdCzCAprOelozGr8yYERdVa2c0ZsJAeZBZ59zGdgGzVbW84xQycm/DW2FNt35nKAfVKq5vH/eoFOIIJFsd6LtXPWhp42ZXkdYUFyku+nRKNpf49QlFelEzHLqxUsiEzkvGWhx6P2C6sjPTIeUlVbgS25tY6nICPcqLxSvaxR2NYWrZvjCgfsexaqJHPX7ff3XV5FS1zJAI3QgTJqbsuCMDNjPFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiANv90Uqb5h38O3Jt2rHfHoJRszoA8yzSqB2qGaZME=;
 b=IwaKwW3EagFGIWUZ2VDSQWWoo6QKFCnBc9Ep4AaECeETICpXj8HlLv+4CKfSSTg0E6hcRfgZZ28ikpr2jrYfbUgpi+EFFAqDizFuqeN4zAJO95ZiLnCViG+hn3Umq8qiZOQ6Y+fAY8I8J2YQ3X2H/lDIvO4zan81Ks8ibVHtZLFn94xDCi+DT4hNKKLoCLqrBz7c7Nc0m8q3fbIWsNiKUQRnQpY/CfkFiv8/ZNiVZ5DAzYggvyCYVCHNkfR2BSonA+73RQT/PM5kTpRjPzDOUpVaVGLX2bRChBSccchOS0I3Y8Yf9bIQItL4yB0WuHeQXEcdFWHwvevRAQWDekVYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiANv90Uqb5h38O3Jt2rHfHoJRszoA8yzSqB2qGaZME=;
 b=ep3AOnd4eoaUAVHldMQu2aHf+6SGD6PukJ1MRqOEVlrdRK3Y+wDO285WErmuJfQOmH3ijrhytIJ+/yiNGnsi96L+0HahI5LuX9jqjLKWxmGxhUyb1Dcdnnh6Jp4dxzG5Xj50IxKvEy2m0rUPdVlhE4zt5iQwKqASuiNYfhGk06ZMLLikCON9dv4G/yHvUL33vru/GAeXGvvmTjEYDyC8cZIAxoaPzb8R045bgfqKZ6Goleiv+K/l/Fzj2myH7TwTuUyOmgUSmYYbVRkeNGUV7Wn0V+j8q/7gZF/ntmS5f4E5frnLlfDOTkTeHqLfMEkzdVJZ1m+YIOxrBAc7rUIF2g==
Received: from SN7PR04CA0101.namprd04.prod.outlook.com (2603:10b6:806:122::16)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 21:35:03 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::b) by SN7PR04CA0101.outlook.office365.com
 (2603:10b6:806:122::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.31 via Frontend
 Transport; Wed, 30 Oct 2024 21:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 21:35:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 30 Oct
 2024 14:35:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 30 Oct 2024 14:35:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 30 Oct 2024 14:35:00 -0700
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
Subject: [PATCH v6 04/13] iommufd: Verify object in iommufd_object_finalize/abort()
Date: Wed, 30 Oct 2024 14:34:30 -0700
Message-ID: <6c39c8ed60ea015fe2a5ce36b54132507d570ea2.1730313237.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730313237.git.nicolinc@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 879869e9-2200-4159-e9bc-08dcf92ab6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4NTErLIgs8Jra/3Y6xZVdZM/CNNcEOKHiels8DPurg0t+leHPtVX1PvHiiHT?=
 =?us-ascii?Q?l89OlH76O1soXYDHLn738rbus1VhaDpi7WoOd3RJxArtiq7rRdBa1zd4h/lC?=
 =?us-ascii?Q?JiRVh5gADY4v022PBLRFv90G0SOYD+hD+nBYNFg3r11JkLDzRVKInnVGvOIa?=
 =?us-ascii?Q?7No6O1mtfbBKTgA1bHfg3ik6MiUr8D8UdA04D+RiNp+CFLesL22SPKpoNcqx?=
 =?us-ascii?Q?NxR3mmrkn7UIDYvQEjkLn7Pje71BDa4EEZQWjK4lpTngdFFH68dDgEL/uclS?=
 =?us-ascii?Q?RrMy5FJB6nisjMfj5Z6g+RhT4loptb6gMxjdpTeG6eru/3OF+qyxErzsq6Wh?=
 =?us-ascii?Q?SHVyzskh/oDLfbIlGtnmxNT4RCEU8r3OieaweaiQtKxZDpYs/qiqsmxaWhP6?=
 =?us-ascii?Q?2ZzSh2qOHkI5yIy+0woeusdZGMpcjt14vtEmiayuWFqqSq2HFSKbAOnRxf1M?=
 =?us-ascii?Q?ZH8Jm4skVaUttp215XcymenNFeJjrYOZQMoW90TsNwcD9ahnZ/4/VSjygC3X?=
 =?us-ascii?Q?+qAk011e8fzgfklh1M3mgcmMgwfMNbctRXSY7EGxl5z/B+methZphTJmbZjT?=
 =?us-ascii?Q?zeukH68EcGDiOsYEIN/LR1iLaSww+YVvD10L/+fXqYtkNmvQXKQCz/TUSL1M?=
 =?us-ascii?Q?8jxMhx7YQfT6twBmu7M4SM66+PSK3tLQys3Q8Q+rK/VrR+td99O9kM9w0CSW?=
 =?us-ascii?Q?IcTb1Bi/dUi6Y5ImFP4uHuCks6zutfm9Wv4J6RMwJ1cxBpj6KKF2sRShJb4c?=
 =?us-ascii?Q?6gwiHSG9P8sbTvH5WZcQATEX1uUB8KOT2ZVE8gu/+tf+VZTTSEf4NS2RQwtc?=
 =?us-ascii?Q?yoZiPZev/l321VOuK1wZg0sJM0J4ZH6hA4mPSnbmt7xfiK5Bbo1NcJOyhP8i?=
 =?us-ascii?Q?NYaHxojeOqgafAFXA2AfEY8C2UeMrqpYYgWP88i4mcJVIwdi2RHo7EZyEsRE?=
 =?us-ascii?Q?96uXAmzCgWdonsSH5t5ijk2tpk7t1mpIPk6BQgn0HDeDT6otyWkYzda1mKfZ?=
 =?us-ascii?Q?DhBDav3SZu/VUDNZOthVKdkazF2qVnWXCUBph7G05CmmElo4zGxM1dDC20aY?=
 =?us-ascii?Q?BlszT7ferO+8pF6ThP209OAjGdjtODpeefHn/xM0Inv21wG0UGvVh0n18icQ?=
 =?us-ascii?Q?RiQGfIT4CFR7UXIwhReVCxLUKibW+9fKBCElH8P5nv1fuPtH2aUmOj/1XCT1?=
 =?us-ascii?Q?RyYz9pTb5yuAP9L0S+wiGyG8DtZ/ld1oHiJYuANgnCNL18QvFHKjRUS1YJbT?=
 =?us-ascii?Q?qp1lhNlXoMlqCEoI0FNjuBBCi0rZLca0cO+F1y/rkuVdU9c2pVyRUs2lo63V?=
 =?us-ascii?Q?DXeTfND9WCykjle2wKHjE802ykWKBXcv769XJ+Dbsxr+57kENR/DWGpvDnMT?=
 =?us-ascii?Q?w9+nRb1MM3k9mYTTWFEHjOGaNduofkf/MzIyVfMubXvfXxtHxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:35:02.7679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 879869e9-2200-4159-e9bc-08dcf92ab6b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

To support driver-allocated vIOMMU objects, it's required for IOMMU driver
to call the provided iommufd_viommu_alloc helper to embed the core struct.
However, there is no guarantee that every driver will call it and allocate
objects properly.

Make the iommufd_object_finalize/abort functions more robust to verify if
the xarray slot indexed by the input obj->id is having an XA_ZERO_ENTRY,
which is the reserved value stored by xa_alloc via iommufd_object_alloc.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
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


