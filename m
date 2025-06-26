Return-Path: <linux-kselftest+bounces-35909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D89DAEA6DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9482C16DE2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EA82FCE34;
	Thu, 26 Jun 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+3SWgSR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161042FBFE2;
	Thu, 26 Jun 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966564; cv=fail; b=PGA17hJxroesHV2rfgom9JXFptgA084OXVJmuimjO0AgH8O5oMq5oBV8bRo2iSlZSZM73P3R6BGroqrI4nFQ4zpclh6kC2+VbGGUxbQ9i4JwK1W577+BvpkjcBnVHtbc2tfsIfzpjgzDIbbIqUuRMikIJ6lFGwf+5sg388mHd20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966564; c=relaxed/simple;
	bh=mAQlo4jIB7ltHPR3Ne/BEUZkZ8E3qiZglOawC0CS1zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rvi6o6/KajuWTMMlpbwFwtpS0HOg6sOwKSiIwluAWrSjZOhdk/8KT0BZiVHcWmUQ3qHbIhdhiRRJWpM4uYOuWuBLTdzI3SjMVl5Hd2udNxIpSTqPvwKgh6oygoItTs2qI9uhMG9ZSieUJ+f1PuzHKj1z28Ju0Om3oxXazEEkLU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+3SWgSR; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWKY+Y5qBjX9lxnGpZ12vVBZZ1hd/sisOxTi7B5A1pffuWWTEpuTXqZgtvXuW5Vhi78uf64xX0BSATEmMw+SUewqtXVZGIPkdgeUiqNBsXus/kkjYznF+Sc3PTe4z8nQXVgZFB6wGrB3qsbfavG8ETTckHv6EBHZV1qwbzP+sbQpFZHs+HqqoLTVCr3A3K4ksPzASGcoTBGbygzxlN9WrbcrHsfsCngrnpPRjDVorMRUz6+k45oeWXygCPGuF1iY4ligGr7eaHEomnjdOpom4vuYNqRbIzAly+M1378nFfVupRi6JOxcBogRxup3QSDOSCg29hxAWDa5miwyfJUx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9XnwpSiRjX9SXv9l8RaL89PhN5AlwZ4r9gZih+9L/U=;
 b=bfXCZk4L5ccQVZWbjC/E8L5+2z+oG8GDHHJLYPhKW5IA607+97Jn9T9udOf5SUN/4GCKvvsxaZTbTnQNGf3qYlKfPT0KaDcXQ/Utjl0nwnuLEjYzLzziIyAnv0AfaRCttUVOebS/q8VeHRBHodsWBYqUv/bFlOLrNBy7+lrSaepXQxjUD2BU1/YnNfpyv8Vrawc5PSoQbbgly3TtgoEvGmIeuvMHd5tAv5+bBYRfQWUfI3vdAEIoDVPqMn39Gwd2Ttl5A9GZoJIqM2QYwOI4YIIotPYWC4b7+Gt0bBG+5tbDtlPE2gEsLf27MbE9l+t3iskheu9Ycn3XR+xC+sHk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9XnwpSiRjX9SXv9l8RaL89PhN5AlwZ4r9gZih+9L/U=;
 b=L+3SWgSR8bSo67KA7IY4OkNDFHww/7GkoEMbkBwJp/NIzpH1TnrkO83CNokGOu4bElZSfXowGHdiB9hhryMTqgU5/Ks3R33au3VFY0CJWQ0X7TVTD6FprlAbB8ugoJHXqK7UB+rJxZ7epChV38K799RP0sn3LX3knRqpWYUCj4W44qnZnI2/DwFvruf+O1xPWpcox+fEuyzqIz1czkMF708sUPi9hjyBwl0y0X0c0y4I8xtM7ZdhwWjZklYLAOFjV00+pw6ppb0w3xfk8KNtSgOxcu3f0b7xKA89sVmwZH38JD1/E6cUO1SzBt/qdbEdceWyme/uSIbIe8SKdfD7eQ==
Received: from BYAPR03CA0025.namprd03.prod.outlook.com (2603:10b6:a02:a8::38)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 19:35:58 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::dc) by BYAPR03CA0025.outlook.office365.com
 (2603:10b6:a02:a8::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 19:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v7 23/28] iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
Date: Thu, 26 Jun 2025 12:34:54 -0700
Message-ID: <205f234c05d6b09de52124a72a6978b74d832cfb.1750966133.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750966133.git.nicolinc@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: a492234e-e7f2-4259-b735-08ddb4e8ad19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uU1A/1iz7xcREEsKwD2myGF0fWyogMaG7RdndZ8Yj+YcRLTmKxuAWZpIXYBw?=
 =?us-ascii?Q?2zBpDCID0rYwwDHCXl7r3S8K0/V7cuM4dm3q/idAuZiEIN2cm3yZi6CWUSad?=
 =?us-ascii?Q?nCrsGxyxrtS8QZ/KpNDQ84G3OO9dtEeGUhU5Xcm1AC882pd/i5TW2XOupA/C?=
 =?us-ascii?Q?bn0C66QE3f8UW1ka8J5SM//fn/MjOhV3zzjX84/BY2RWEuVpky+H3jhvUSCe?=
 =?us-ascii?Q?/T2EeUNhGni3izJGcGD5jtnpq6jAW6usXvLU16Sfx8DtWD/ogQXwWqMK9PF0?=
 =?us-ascii?Q?ODpFR5RWABDLVYDvegztHheKRuAqrZNOtgwtMtIorx5ESxq5RVjHps8e27Sn?=
 =?us-ascii?Q?NLWxjnuJb0r4ab+jWRIC1Cw7NhbSoa8t9PO+OqXa3vP2wFEMGRqpllrKeuhk?=
 =?us-ascii?Q?Ckrokl7Uh9pwLSErwIOKgr3yz5Ydi6leaoUvj8ZObAD8fg62oGSnQavU9O9B?=
 =?us-ascii?Q?owHTbpMa4yz8zJYcQc862Rc0387ljRJhc/S1bjrzijLk3yWl6YRjtsIX0XkL?=
 =?us-ascii?Q?tl2fPdFtRwSqh1Gn4fn104v7AdwRxeEJRWpxzUv1+SqONvFG5bNyDyakY4Ti?=
 =?us-ascii?Q?o3rgVfPerHN9jht+Nd+csyFVkKWO5lWBEAJ0CZG4iC4MoPYk+wg6nffGVC+0?=
 =?us-ascii?Q?etJZQwm/uxXaD/MJK20fZAXjxAYu1EAizzybdv7OiXhaJ8gNsx7/kQ9qj1oz?=
 =?us-ascii?Q?51JX5h1YbUMZEhXGoVJI6UWbDrzu6UU8SU/la8F/tAeTTBkHFuLBWEVWAWlE?=
 =?us-ascii?Q?ETDiV8ctsvux9V51dKC0WMTO5dU/4oQP36QyiqhEYjq6WkEPpEfj7THiH/lF?=
 =?us-ascii?Q?1cBuy3KWrr3DkH+SSGXfudHYDIMBjSYylVa57pNzmIYmUSF+92hX9BxFS5er?=
 =?us-ascii?Q?gCzRWv/8XIkIyNbhlWzi9xd+u9tb6BAm52u9tLabKnK+hLja1I+zYreE/Nr0?=
 =?us-ascii?Q?Vow6Dk9/B6ORRVD3Lq42wf6EmHxazgoo6zg0S+7qPn9SDWiEUjGjYERRR68F?=
 =?us-ascii?Q?1OcqTP0ZT4ojtOSGxsaTVkbKk20CbwsyUJ+hl8gOoOq80APF5j2+Urv2hof4?=
 =?us-ascii?Q?qc1gIKGdtPhV/ymv414qgdeKVCSer3TIv3EZE/l1z9nuBiQwISImal/VhAtx?=
 =?us-ascii?Q?9POe85k6ZSlc7Fi8aHLPNIuApFXWX1mK2oGbdmaz7es+ehbE0C4gssPW6OqI?=
 =?us-ascii?Q?iCG/jWSg54jYgQDwf8art3zwTacvYIi4ryUL8FN+TQyh9SGuQgnYRUTUzFwm?=
 =?us-ascii?Q?eNmYRe4sq+8lxEW4b8gXpNOrYNsaXkzSX/NvOSSljL9Bkt0MZguby7lnGno5?=
 =?us-ascii?Q?pEU3XW/8kCqgaT7eVngUZtxeKc7RLzXSbDe1LrY74s8q4tsp+yI+fHE2M1LL?=
 =?us-ascii?Q?OD/HmRd1u9aIxRtauqUyyAJ1PprgRd5tgbGErssGZ5m0exlaL3C3KmxhQRi2?=
 =?us-ascii?Q?p40RLF9pAzScBfw0mUKlT66EBnAlOuAEEezeo6wQT+VLFh+v5CROY6RYkraC?=
 =?us-ascii?Q?n/xEdPfmrSh9nhJwohWymm71qn41MRm1iFsf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:58.5738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a492234e-e7f2-4259-b735-08ddb4e8ad19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

This will be used by Tegra241 CMDQV implementation to report a non-default
HW info data.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 7 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 07589350b2a1..836d5556008e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -721,6 +721,13 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	/*
+	 * An implementation should define its own type other than the default
+	 * IOMMU_HW_INFO_TYPE_ARM_SMMUV3. And it must validate the input @type
+	 * to return its own structure.
+	 */
+	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
+			 enum iommu_hw_info_type *type);
 	const size_t vsmmu_size;
 	const enum iommu_viommu_type vsmmu_type;
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 2ab1c6cf4aac..1cf9646e776f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -11,13 +11,17 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 		       enum iommu_hw_info_type *type)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	const struct arm_smmu_impl_ops *impl_ops = master->smmu->impl_ops;
 	struct iommu_hw_info_arm_smmuv3 *info;
 	u32 __iomem *base_idr;
 	unsigned int i;
 
 	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
-	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
-		return ERR_PTR(-EOPNOTSUPP);
+	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+		if (!impl_ops || !impl_ops->hw_info)
+			return ERR_PTR(-EOPNOTSUPP);
+		return impl_ops->hw_info(master->smmu, length, type);
+	}
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
-- 
2.43.0


