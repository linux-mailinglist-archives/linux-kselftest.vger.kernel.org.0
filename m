Return-Path: <linux-kselftest+bounces-34996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FEAD9AE6
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70693AFE6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5E229B28;
	Sat, 14 Jun 2025 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k/xF77WS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5C22541C;
	Sat, 14 Jun 2025 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749885356; cv=fail; b=h0ipNbbMQHT0DqqdfQgLstcf8CZxQUZPXm+lGGs126pYq7QE2uHm8IaTXXUWlPHO3Z9PPDi3bYV7ln7wnZq4xOTGXixDYLe1hPioP/YIpLhWRWTQbdrIEXExbnkO5L2xSwX8sahfkaqUnrV5FmUdujPJUHeiu2zOHELR3uvlSuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749885356; c=relaxed/simple;
	bh=pxvXAqlXyApfqynrFzZl6DWR4ew33uuyxc/8C+UL7z4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDOLydAscLzpiuXbI4wlHGktHfU5AmYvlrJBGv2IePV2Qtjq+l8oWpF6gRJ5s70mBnsWm4v3UzZTMGllLVYbH4M2KvQXWzKXGCyi12Nxwe2LvDtJbEZbaESId9d7gSjVyEUZAanbuElGp0h5gtqTr1CTeVnaTqQ+4Wz4hMck3/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k/xF77WS; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaxJWzqewZ/ZdG+5DbIVFtdG5bBBE0szNwmQpyIg6UTvHyZvXKnq+v9RQuC4K5g74zvmFcI9nGcZzpRmvrNi9mkgNnKHga/zQwOjTgCnDN6ZhzEMIrw3GPdXK8uFjCTsdViDDO+vIn0i4tWYKq7ZVtAphWNXSatHfLGcszgnvdIBzfYY8dCGdd9L2YOXbDZzITodoqTVFX542mifhpcwoKHH0ar6q10m96dBSFErU563EvWuQ8Rsp4/jlgZGI12Olk2FPtHryjZ+oF5vfbV2k9QTRuXx1iI0q6bGmeks0dLG4vKbVWe0ylt4yvUDDibjzPFDsZPazkHRCxQUARgwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWL6yF8OYJgnTSLQXiSj7kSEw7TB5DaadJAcGGbg1IQ=;
 b=f3ixC6A86nSJ5piri1xpRXKiogytdeZQ+mswxJoCp0rQFRlxz4I8GZxiNu5SGnzz1jAqyF4QPrGmImw3HbRyaDX9s+2RElmUFgbJcEdfOE4y1x4ayAxHG0ZjMov47SK855/s8Pp6lV1fOc1JENqykHm9DkgWvID6Jm5fCkVNSzmvi2Th50F6MDOpXXmfrgaAGPKnJvHlfwlmP5j20yL3V/WKy9Z+slKVQ1CuQyQDrrN0epXVhGmcyhG2mkgW58jTQ9mYR4B4qdn7NtlKz00MWx5KDCbVQM7tAkNisrnhlWW2RhEu3KnH8BeJ4e4aS09rXZuQMSyq6Vn9j2cYRkC61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWL6yF8OYJgnTSLQXiSj7kSEw7TB5DaadJAcGGbg1IQ=;
 b=k/xF77WSUABXnHQFPbRYrNNt/r7LTL3VQMvW7G0P3GZV2pG8P+HAFH4vG3zX9tlHD4+T/nVG8iouWrAglI8LjkCOuMhcr3DQEUyJtI+e72nB8bzdn+C+ksvtp9NqXn7DYoT4Qh01Dgaa81wzhWKixe9e3+u1pyO8V+EBtwoKlYxp4Z4pTlARK6GUeNolJYOYA0y05O1AjDSUne45XC6FHRcWiSI7/os7vyQ02pgrKhjQ7/48iRFV71iyKZeEAkW4AZMW3FvZi39j/TgQ9QYKqYUYA4bLx1ns0jjbQdl903OW7pL7KLYAZweClOHNJnXPrmw3zcfh4FiKOm1l9EjnlA==
Received: from BN0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:408:ea::21)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Sat, 14 Jun
 2025 07:15:50 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::49) by BN0PR04CA0076.outlook.office365.com
 (2603:10b6:408:ea::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Sat,
 14 Jun 2025 07:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Sat, 14 Jun 2025 07:15:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 14 Jun
 2025 00:15:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 14 Jun
 2025 00:15:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 14 Jun 2025 00:15:35 -0700
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
Subject: [PATCH v6 20/25] iommu/arm-smmu-v3-iommufd: Add hw_info to impl_ops
Date: Sat, 14 Jun 2025 00:14:45 -0700
Message-ID: <f36b5e42bac83d0cdf5773cad1c3a44c3eaed396.1749884998.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749884998.git.nicolinc@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: 40377587-dae9-475c-e4c2-08ddab134a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qP0HS6KZcV1bvkb2+Q4M6kh/4IzVjN4wSaNT3iTuXN2CqUsAGvymdVTTe0OU?=
 =?us-ascii?Q?JoC0FwBhAhq4nMm6iiKPWlQTOAYyF6YFqwaVeVfwgmwmLI+mtCg/T6p0ed7f?=
 =?us-ascii?Q?7dSRemE+7g/9fRVH1GgY7NSfyvIoY5jHWWv/NaH8KCqIKQlVHUtX2lpkZQkN?=
 =?us-ascii?Q?plmZUxLDkLtd3XwC46mC4ug+98MwPa7JSbGKisY8DzsZyAOI4NkG9e1mCdzh?=
 =?us-ascii?Q?IlisJThRWxO9wtjMebX4PdwJ7DnN31Jfi3jEd7d/GXuEuMIy/+ikxMv9Nfcc?=
 =?us-ascii?Q?jzkpxtD/P50tk7NrqbtwOW1kgVQnPa0s9p32G5jel8YZpJDWAbPk4mnqy51C?=
 =?us-ascii?Q?C4oB4PuNDejE+vMfory/amcrnX2BdXV8xWIQQqbOhXKxmZ1S/eldO4zdo2BT?=
 =?us-ascii?Q?tVNRWM97jXoghrge9u3mlYhh694uSwSByTOaxfNgbp6DvIZFXusEDWIrqNxF?=
 =?us-ascii?Q?w0kkjdiUKjpCSiRnIHHHTc93Z7Tvhy81IHM5xNNiBQQArO+XcnEmUr/Km/vN?=
 =?us-ascii?Q?YYhILz93RBYlNXIHYKKV7EBerY9ZZpbzupJBf5alI8aKzMS0UAEf6Qh9HMgV?=
 =?us-ascii?Q?Uk8L0unK5zNwjQrgSV7KwAAvtLzLyR3PE1bbHDbuof0N+xZkqGTEI/ps1URJ?=
 =?us-ascii?Q?6p5/b8DSUvGMTZdgryWuZt+60fxmnG07uWbvnIemSQQvh4L6ugCfYvS9SwwR?=
 =?us-ascii?Q?KSD9yDM5sNmLC9u5v7ZZbw8EOecQWb9HkPQlAoFYMCs0jemgJw1ILfPIbOgM?=
 =?us-ascii?Q?YKi2VGlWhKaqRIzZyjN3lCjN0+P5/x3wmDbxN1aRwE6FnEah1PM4bjx3DgB9?=
 =?us-ascii?Q?Am6t5QwuCxDt1N5VMja1x+fLrKzV7wUgIwFpu/O5AgCIA1XqFhk0HyVIviaO?=
 =?us-ascii?Q?u9HRoOc0iPkI/5Nm89gl8Gyw3MFxjf/Fl+da0oFI3ngXT5ovK+ozqHqfNaO8?=
 =?us-ascii?Q?FJaDo3bo72S9Im881A7hCnkWnOuhe3uj2OjW/KXRHsEQiz26Ackw/2lLas/f?=
 =?us-ascii?Q?ypWMjEn2BIJ5TySCqPHNcgX+xHyx+8Zc7wuQeKdmQm9b2j0p4vhT/gbubzNb?=
 =?us-ascii?Q?oiRF6G3fO0CDFH8m5ePnWVUPWytvv30WAq9FZsDZ54S55n+GTKykSQ49/NYn?=
 =?us-ascii?Q?0qAmqZtCyE4utIW0N6SsZ4bgIJCiRN9SMQ9aOWCwM4DSKO3U2l3wDlLiXWCV?=
 =?us-ascii?Q?lgyO4fiqfsYfFFo5tT1ZIltfT4oUmUPIDDr6oh7YQ8MmTn5ojrVY5D7hs5/g?=
 =?us-ascii?Q?P6uXKQ8HuCcl6GRR2lluYR3IMjSo0mm05dWVJmr8MoTttxX9xuQykpxKIjn4?=
 =?us-ascii?Q?CelWnmJXXtv3lE4+u2qq6iCDTXAi5rMCo1b5XY3DYzf4yNn4bmPWxg+q8yiQ?=
 =?us-ascii?Q?ZonCUoEXKvS/14iglAahRBCeozM4l5zD6B1pZnbm7ScX0z8oiGE+KpLTMGg/?=
 =?us-ascii?Q?A0oX16XiBw/zyJDQzAcUShT/Eqkl6tU4GingcOJLKgfOVFqbqfHmHth3q6+d?=
 =?us-ascii?Q?SiWIq4gCrmkbOGqdFKIZJWD5ICD8Czzx3r9z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 07:15:49.8385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40377587-dae9-475c-e4c2-08ddab134a92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284

This will be used by Tegra241 CMDQV implementation to report a non-default
HW info data.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 07589350b2a1..c408a035e65d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -721,6 +721,7 @@ struct arm_smmu_impl_ops {
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
 		struct arm_smmu_device *smmu, struct arm_smmu_cmdq_ent *ent);
+	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length, u32 *type);
 	const size_t vsmmu_size;
 	const enum iommu_viommu_type vsmmu_type;
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 445365ae19e0..1c138aff73d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -10,13 +10,17 @@
 void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
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


