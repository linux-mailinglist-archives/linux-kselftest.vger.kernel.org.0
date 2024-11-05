Return-Path: <linux-kselftest+bounces-21475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C55DF9BD689
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F4E1F23EB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8041216428;
	Tue,  5 Nov 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4dnxJ1E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5C216217;
	Tue,  5 Nov 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730837109; cv=fail; b=IMF/GwzidD++dbd+3bTZ4YbpO3JfdGVQ/w3BIMOFIJMzUVfHz/Us8pMbdfV7lUMYc/tixPOz7pvwpSBUe+Dg6U0v0dK9/9Od8mLHKLrUaG97V216ITPfE9rnqbHILBV/ZKd0gCO49Khap8lBvnzGsBeEy2EycGlCAbWnC0rf9yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730837109; c=relaxed/simple;
	bh=u5pZzL4rN7BY1cRxnreaxEMpsmZzqNVt8WwikkvaCC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mztd+My9z/UszGKpt354Hq0AMgaB6nCxV/HOPWmVZj8NI2tsbOqYod5a/Uj1cvpFSCZpqWVujj1UYBR8k+guB5nDZuVGKml5LgtYJo+5ZA3vQDFyG8F4NNygxsXKb4kRFMZVMBzWhndrQvP9jgeWEIbyd+o9NABuopSLuX6tJXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4dnxJ1E; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSnMMEOu3Gy1QBCilUgk7F0TcbHrycLRfbAPRukSb6mD8vvzn6c8GhCNGUrNr4uLUyq/2H2d/kpbSwb+xPX+qLW8I1HnxsTuftggUcM7VICyuPrZvBnvW7FwEWDeTClBbwt79HDiD5kNcVeEzb8KNgDt4Qi+mzFvff1xWopHrRQdVHCv17mUVFXB8JXA3wMAFgbRYGffP2gAlTXvdWDPaVzop+cLEgc+Z9EbcGQX28KosRxgIsFPCRdKVamTM6rVjqYCELO760Jd2vr2RqFXzDjWw17q8M4ZzXHSunE3HqI8rUKnNwASoCLHwZaCY5fZ90sxLCG7asPtT31KNhK15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA2gBV2134LitfJvCPpvY/fpiZHb96l7kAYadyzY41U=;
 b=auqnSmyqmLuPbHSQwCYjSBcOHZh7iyWlBh8aTPTTvrHyWcsnUDM7sZtWqtF0mo/wHxR0Uu55al1p8GfMDh75p6DHAzZVMbLZVaF1SPvzNp4cCfyf/cVHCE2kpyNY0+c3QKj2fHNQxgBzpaWQn7UDJUjeShqrkSh2LlhEItIRSlLH+wBU0MOS4m1FEd2WGwmMhlulhi5+Zze1uAaPA1dOxUetcsUDC6oAuV+oHPh98xvjZQvjrh49rM4bmCGgt0HpX4i62bcO0NnpUoqLapGc8/UVk18SI0ya2nkLHfz590N0aPD0z4qxjO11vktDVEsb7XAlQDwhO19AXvc/1UnGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA2gBV2134LitfJvCPpvY/fpiZHb96l7kAYadyzY41U=;
 b=i4dnxJ1EqXbfp5DVdEr6MxiR0qhy6l/fuC4PWnZHlaFq4mmVIPi+D389+BEl0P8k2COQ3Ig9PxUtl53l0abL0NNe+EBSRT8OdjYbu7NmJbcjfNGpK9+vfeOANzGlkVAc5KyANDSEyGNd1UVzynxV99EmQOgOVVdKkI+DtHAVn6J3GL+uCI0LqZi2UEW3CGGIm8lVUlA6YATTv0FWl+shqLWSlE4q8mmYfihf+k31Nn6H4dAfQUVKs72snxtSvtbdTPK+CqiAf5X7xpHosY6DToIdn+UExz5kLbjbhfNGSqV4nb6UjTdWmGBCYGW5RL6lNzWmQ36TfTa3vnY6L/itxA==
Received: from LV3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::14)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 20:05:04 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::4b) by LV3P220CA0014.outlook.office365.com
 (2603:10b6:408:234::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:05:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 12:04:48 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 5 Nov 2024 12:04:46 -0800
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
Subject: [PATCH v7 06/13] iommufd: Add alloc_domain_nested op to iommufd_viommu_ops
Date: Tue, 5 Nov 2024 12:04:22 -0800
Message-ID: <2dcdb5e405dc0deb68230564530d989d285d959c.1730836219.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c73714f-0456-406a-449c-08dcfdd5232f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tTZ6V0W6YgXXVQGmLZ6YqAB+Y+Q2hZEIwtlugmvV4lNTFcQDnPq5wiB4ebyn?=
 =?us-ascii?Q?/3dxyo+OG0x5X4Ps6fB4P3Avr8cmgXD4PqIelOk516neZIP3Re+wIbfUPUKr?=
 =?us-ascii?Q?N3HB96r5PHE3O9JxaU7o8OaQmhgmnOQhC1KVQ4I9ki87U1fOyMLm4RbGVNgB?=
 =?us-ascii?Q?WEygxhrptyNteCFK5iqShSA6eW82gK8tbzyhB5clgCOS3o7n7QZ4sGpH08Kc?=
 =?us-ascii?Q?lWyHX9iFQajPfEy6SqMmyW68NxpaJ5KXl7TzvhQ/UuUlSj1pgJFckE0TaJt+?=
 =?us-ascii?Q?QgRpNNxPe3WB3e8V/ZuPwq6U5qBigvI43fhHXnvpOPWtG6D/0aDA6mmVT3U1?=
 =?us-ascii?Q?AcW4iAv283O69O8eHFuPsvV2CxPmDMeqEq2bFGu/HNzayKATFrB14V3GZGEn?=
 =?us-ascii?Q?taO2enGv1i3bNVesVJFkHOn3/V3HCymDyymW94jOoH5/NvaONiekXndZumG2?=
 =?us-ascii?Q?Kr+HeKecZO7aOsrhRwjui5vOZ901eBoIuTFsM6//57oZhHCyOjB8neLgjBEr?=
 =?us-ascii?Q?ExxmFV/TdeUvH80N5zIgN/3BSTPteJ/twWfcJzTzyxtpYyNSUrbkoW9V9NtX?=
 =?us-ascii?Q?Kfzg3UiY6M9QbLxvojv4uYZAmfZlWyGRQB1VawSdZaefqtT33I1ZRwVa5EsC?=
 =?us-ascii?Q?0ZpfCO9bqnh7TXC1S85YpLr7mIET0l9kbT3KBtQElWA2bDH2u9EXmnt3j3sH?=
 =?us-ascii?Q?IwGptMp8jHANzTU2jrD1a+He/Fsi6QO5JvbumfGmzxT9e/5S7lSywyjTutO/?=
 =?us-ascii?Q?pPXfy7nQQY678FkMwre+qgxK+WuhpGpUOKPYFtVPJVQ7MpouE5HEGu9ZoccJ?=
 =?us-ascii?Q?+UtfPkJEG0vSf3pWYGxzT3LCynb5uHryJNCEvgOLhxrzlHiZPiOyDTSQi7M0?=
 =?us-ascii?Q?zbcyV6Y3Ws0/88ZzC36ZYJFkaglFCru6YsOGt2yg9cYg97aJnQYXMlcHofXL?=
 =?us-ascii?Q?KQBPbIzcMMmUkyTp/I6kTOkyuI3fv3MvfvMoRaxE9eKatr/CHII4kCIUObb4?=
 =?us-ascii?Q?r+f4NsQaaf8vnfJUS7TYcMQFTadVWzJENI9T/irDKUwHmwvGVgwX4q5XdxCi?=
 =?us-ascii?Q?gtVTaHkrQUm8nxgUiQ3xjuGYc4vN9YRT+JkpAuxwpmVBUHLIRKfDVvnt1KCW?=
 =?us-ascii?Q?5EB3Gc4ZWfVotSmjHnOrn8UNR9uiNU7UrNnp9PNrYKf/2nvlU4cJfLzXeWYd?=
 =?us-ascii?Q?SugbQhqSDPCA7JMVho+jE2BrCOEj5uZpTWbjV4Ui7QRsbDQPxwGgh6W+YwcC?=
 =?us-ascii?Q?zOtXsHG5twdgiCKcT+B8DbEttCSJWa3+LGskF7BfjgAVsTWt7aSOkQYWfrAm?=
 =?us-ascii?Q?faVyLK72bOlUPgnqgZTV0XQuT+jWvCR27CTZNqCkpuq/igkls/2DoH7hCDMZ?=
 =?us-ascii?Q?++5x93GRWAfeFPYtymv1NT4nDBiSrq/EB9UTParUZKQcqjA6Sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:05:03.8054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c73714f-0456-406a-449c-08dcfdd5232f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

Allow IOMMU driver to use a vIOMMU object that holds a nesting parent
hwpt/domain to allocate a nested domain.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 4fc2ce332f10..de9b56265c9c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -14,6 +14,7 @@
 struct device;
 struct file;
 struct iommu_group;
+struct iommu_user_data;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -95,9 +96,17 @@ struct iommufd_viommu {
  * struct iommufd_viommu_ops - vIOMMU specific operations
  * @destroy: Clean up all driver-specific parts of an iommufd_viommu. The memory
  *           of the vIOMMU will be free-ed by iommufd core after calling this op
+ * @alloc_domain_nested: Allocate a IOMMU_DOMAIN_NESTED on a vIOMMU that holds a
+ *                       nesting parent domain (IOMMU_DOMAIN_PAGING). @user_data
+ *                       must be defined in include/uapi/linux/iommufd.h.
+ *                       It must fully initialize the new iommu_domain before
+ *                       returning. Upon failure, ERR_PTR must be returned.
  */
 struct iommufd_viommu_ops {
 	void (*destroy)(struct iommufd_viommu *viommu);
+	struct iommu_domain *(*alloc_domain_nested)(
+		struct iommufd_viommu *viommu, u32 flags,
+		const struct iommu_user_data *user_data);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


