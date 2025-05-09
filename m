Return-Path: <linux-kselftest+bounces-32701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C9AB0830
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5045B1BA2A62
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B223D290;
	Fri,  9 May 2025 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n0vkjco1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0F23A9B8;
	Fri,  9 May 2025 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759804; cv=fail; b=nDMkEjdxVehjjKZx6nF3e5PVm3I2T99SKN3K7ZI/V+dKoFuamzEKoGscu9oU3JgQkI19wCaXQkxyYtMkMU5hmvMvey+NVmoKLNyaG6vjDRGh+3jX2sRCyH5uXEsTTtyTBCnNHTMJbBtDtSbdujaUMcGm/eZrFAASOs7lst2jHDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759804; c=relaxed/simple;
	bh=/EC17xlQh0mIN6fQ63YxbIXHkHT3Jhq60t6ZwRktshM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sblrDZx4mXrp7JYtP81j8UsxmfjiCDstsPCu61VIgxZ4KR+9F2xkGzpaDdSk7/CCyxXUumkX/BCgq032YTpHsBHSnzPJXA33i0nU6RLMUVajLbhRvBLMaqNjnZ+RJzgjipboELeQprrTALo12kut4m5txT1AR16kKwV2db8xGxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0vkjco1; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVJd+NaGcdt8YddLLnmSJCmqN/eogy54Y8JCGFibI6zdyvCx64uKI/zWpON3dtbHkljITw0Kg5bwlNO+7qP+ILRwhKUcFNoVZgvdCKElCtlWWnLdkxE42+P5xa2R7mmK9PZxqgodRybPF8cPsEvYDQGdLWDtyMNsoCxVE2do/7yHoExQWHTM10zp5fVpuWHQaiZcLBgrfAfiyer4CMdbbiU6yFMUCGP6UBeJE3uSg9SP7dtBeGtgD9msBOwxrBUiMZl7F+0znMEPOf9w6XVSW8pIhCAg4VwcSU+7am1Bhi8j20e7YebvWA4E5RO643eY6MMdNtjURchQnqgkZByQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7/lRs1ZW50lDEzVmT8u2AcsFLvhTtFNneEmA0W39M8=;
 b=KLSbTIB84RMgwfVjkAWmenOVMkBxyq/8wch8uRc1Qp386hopIS9Fw1KDx2+nlhZQ6rYGEwr2al0P5gHIiX+qn98pi49BE0kFdrKVbeoDOjKfdhQWsPJLhQ817rvSWN+kmYEetRJVHoMBu1imc5+NN1PnDqSkh2P5P69mpPiQNQzO3rKAh3JZv+3ixJQIS+HOPiwPyNbFKn+E4QDW2ZU8nw2a4Irdo4qO5jGrMafE3BLJgarmIuBoF6xZTLwPMF5e91Be57rX43FtPCuebv1eOYN5BVcpTXIqx1DnTm2dp5rJRayXDk5yXyJrH2by+vEIg30yweUYf46YrdJBy7GFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7/lRs1ZW50lDEzVmT8u2AcsFLvhTtFNneEmA0W39M8=;
 b=n0vkjco1VyvXfOktsPdzsme5kPFDhhL0jiwbsToHeiN039AwrHvpct4DMbB9ZB7swvknGD7foysCuGs7vQy6RnH0yLmRQNgyewRtOkbfuiJipZzvC3XPAArJBT85NucJ9I1+QntZ6B0tjqRP/afEqvWawvKvusFdLhVAOFwHBQ4jHR1ZzoWGsYnrIftEadsXTfFUXeOc1wod1+QOXARcGx4x0hcwjO9ep5anmYgjvKpGyzD4fQFMsJIfzxykxOd29Ui6OwSeAKDBP8UORrAtBy80x9jfHJMcgEOfltEQ/dnv+n/qAuHPRnmErgGmUHlk5D/Cq0dOeEKkyy7eJ8x3nQ==
Received: from MW4PR03CA0311.namprd03.prod.outlook.com (2603:10b6:303:dd::16)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 03:03:14 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::19) by MW4PR03CA0311.outlook.office365.com
 (2603:10b6:303:dd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Fri,
 9 May 2025 03:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:02 -0700
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
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>
Subject: [PATCH v4 03/23] iommufd/viommu: Allow driver-specific user data for a vIOMMU object
Date: Thu, 8 May 2025 20:02:24 -0700
Message-ID: <86b279e902a3fe624ca9261b84f378d62c5049e8.1746757630.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746757630.git.nicolinc@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ead9c8-3874-4f63-e648-08dd8ea609ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yyFjACHmf340EXuoi2LI2MLRmBzH7Wnq5qR7ip0xtwj0AnA1snJliEE1KK5Q?=
 =?us-ascii?Q?GTzrqbHYZ3XC4FzpSsETYpw4Ickg8r9+A2Kk5/EgR2t1Ty5c3ahdGMt1VlnP?=
 =?us-ascii?Q?6fXrtJyTW0X+wGs1txdn1Kg8HdE9PIb6gzgWb79XzbeyOzkfoT4ZcosfkiYj?=
 =?us-ascii?Q?9aJ5ztA7DMmE/HOT1YQeTjWtCZdgBoA+FOXT3xkvczhm8HMTSg3sgdV9Wp1O?=
 =?us-ascii?Q?Q6eF4ZyqlgVaP+lz29l4CBalgPI7iXyV8IQt9FWk1T/a79QQ+wbfjLjompu5?=
 =?us-ascii?Q?qWQp/KCczJ2ybGc2fU5J7drqC20v3GNKbJabj8Fwe2EtMScq9tkGjYpFLVMC?=
 =?us-ascii?Q?ter8WqiVMidm3sm0HAV+6B9TnyUS7BFpavrBTCuTbBZuQK1I/9xefwiztrrt?=
 =?us-ascii?Q?EMcUiZMiXKA3dtYP0EwCor/2EhuFpZrPH7p0tkc4QpdgTiV4gOXwSb3vFwSi?=
 =?us-ascii?Q?HIWg8JlrgA3P1709tgWRSfUklJ1Lls0nofPEnwI65xY0NmLXEGvARv86JtVM?=
 =?us-ascii?Q?MN9+74wnWuHH2SwVFRSdVOZ3Z7qu6znph0aXyUt+QRJ9qoAmQZ4qdmjmJih7?=
 =?us-ascii?Q?ws7tkukFnWhp//rMbWQ3QZcJKStfDtH1G7G7uoJJDEa1C1Nk4DD5qBD9YNYj?=
 =?us-ascii?Q?4bgzBKS9GuvxkGCuv7T4Lm6EmLADvkZ21ALce5l5vrJhYTOTxQdGXiDJm3/Q?=
 =?us-ascii?Q?RCjSLAsMqDRl3x19QJF2bDgShbhBzFDse0845Uw5175TVTz9nkHSzP+9Ji6I?=
 =?us-ascii?Q?6XDCZmgAiYLLQe5tUaXzAs0a9K3apHZr1sXHx0dANusL5WSs9FJdkiiR11T3?=
 =?us-ascii?Q?BM42WZq+JOsdxQNRE4aGTDao8fD+yuaaKH23jehhtm74AdIrLdQMcVIpdTtr?=
 =?us-ascii?Q?9zqerYplywpU3cU/vGhOnJnQjyc9nvqLkHY6tG6MPSuR7R2VjnRqs8sdWIMp?=
 =?us-ascii?Q?aPmBrn7U+fpIx2tnI/uT3CRN41oaMkQuEK7FLJTE4DucK31WPXIfMdrsh8tp?=
 =?us-ascii?Q?posYsKqR+SiqfES1pbOQPp5vfb0FfAuByWS3bO+x96I1niDg6s0Bt//3Mghq?=
 =?us-ascii?Q?Qu2xog72d2g/DQLEOjGZ8XTqEjudHHOpUEYlcCbchK8da/ZakQ3o/tjHD5j6?=
 =?us-ascii?Q?Nno5SONvPNkp4o9uFwGKPdG3aDy+DAg8cjMPcbmTsRfLArHSjkPgKpOe5DYB?=
 =?us-ascii?Q?lQu+eLWG0AE/HMCyrOo8Ex1BUiIQTLueLBXG9EM/vVd2JTwEwcodKDrtePRC?=
 =?us-ascii?Q?A9TQySa75AzCUXBacu3KS1tNg6Fgnnhnvf5vNZSyUHF4HuqLaCbymSpLCG6k?=
 =?us-ascii?Q?LGce/b6E1IySSld/WyFVGlPpWKY13FlVyT5OEunaPyaNMYr8Dpnmu36LjVaN?=
 =?us-ascii?Q?198hXNgWhVsQvfA+wR7zxD4COe/5NYTWF+yoBnRWYAcmwnodRUn54Jrkn6OO?=
 =?us-ascii?Q?yILWKD9/VtXum7wX1j4YQ2mIXZyMZj8WLKe3f4MAzWjLns0wOrBhvLRYy7XI?=
 =?us-ascii?Q?K+/AWiHUJBguHYpBjZjshLU+NqbF/3BOV5gs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:13.7961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ead9c8-3874-4f63-e648-08dd8ea609ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
it in via the viommu_alloc iommu op.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Pranjal Shrivastava <praan@google.com>
Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h   | 6 ++++++
 drivers/iommu/iommufd/viommu.c | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f29b6c44655e..cc90299a08d9 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -965,6 +965,9 @@ enum iommu_viommu_type {
  * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
  * @hwpt_id: ID of a nesting parent HWPT to associate to
  * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ * @data_len: Length of the type specific data
+ * @__reserved: Must be 0
+ * @data_uptr: User pointer to an array of driver-specific virtual IOMMU data
  *
  * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
  * virtualization support that is a security-isolated slice of the real IOMMU HW
@@ -985,6 +988,9 @@ struct iommu_viommu_alloc {
 	__u32 dev_id;
 	__u32 hwpt_id;
 	__u32 out_viommu_id;
+	__u32 data_len;
+	__u32 __reserved;
+	__aligned_u64 data_uptr;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index fffa57063c60..a65153458a26 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -17,6 +17,11 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
@@ -48,7 +53,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
-				   ucmd->ictx, cmd->type, NULL);
+				   ucmd->ictx, cmd->type,
+				   user_data.len ? &user_data : NULL);
 	if (IS_ERR(viommu)) {
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
-- 
2.43.0


