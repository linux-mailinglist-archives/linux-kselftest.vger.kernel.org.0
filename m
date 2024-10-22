Return-Path: <linux-kselftest+bounces-20361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 761039A94D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 02:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7165284ABD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D04D2003D9;
	Tue, 22 Oct 2024 00:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1+lhx83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37F01FF7B0;
	Tue, 22 Oct 2024 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556472; cv=fail; b=Mr1NxlFUx5YE0vccCd3vn+4KTPj1vjlOOKafqNtnx05/D5eZ0RJ+7TGqvq8qIn1PjZnNF66RppTaIUZsx8vjeP7rUq6S6IWRaLP/D81dJ4GRPTfM5MD3AsAwyYdS+9HgTgM94bqpgX1Qav6eAeSrrsxW7aHrK6HB9OMetSrFzb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556472; c=relaxed/simple;
	bh=tE89WDJJ7F17BdHXi1jhvbK3aqAQaw42MGJm7Q4TEFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DygJ0jbIJkLPk5GW+QlXpZVmRd/g8hfw0fyNSPaxkmSsp5rTz2iDSVTzpu9DQLnNb3ZOCTmW5os+OijEUIJWoYGrIYIQuUWpfgYwhlTmg9dP/pW1l7LOtup1e44fP4bhRbVToIdWJj6rqaeNBHs4n2W6UCwKLQd+mjdt0nbI0UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1+lhx83; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqmlm5iwOvCybnWqfn8NgOq314i/2SWDpRcxiNCOHCDEgQLAFnZpyyaQpQeao+stwKEtFquNRnoDsL0CjzZEYljxet/b9RAkQMFo0mNruYmf/IfJDx0NyLBMxqr6k5CMjJh6JpiH9d3L9NFSGKndEApQ8BPiWM16UwYQ+3PaRvqB/Kee36QOAFm4UPYVLNPZTqDmGuq5aHJruhgHzN/+zKShr2qMtO36As10bRcDFNb0TNP+w+W55kYoAbd4b38E6DxWH4mUIDi2JpUwArGg0YdetYlkqe9p3w6OJlGV6bE1ABW1z51eiSDx/xnJ89cEUk6Wqe27D0wAAEBIwATp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxfNjpn4Ei1FTzur+zJ7dk+zvMnGuzwbefZwdQh4NcQ=;
 b=X6EdKwM6Li8t20CVOlExxU14JNAHBwixMCUlSmzdb+7mdOdjFk6GRPYHVXkctRlCTPEqzJftGzsgYHNinz/ir9Vsi2BaiwcwxLI8W6wC0/koRFTHxIJaTcFzj2IpXp/0lR9YUHUVgPBkmajsH+ZClZCSggQeSmRcJOoJqRyim5ouT+hKBJPZKmyHfx/2Yx7ArtpSHWgXPDxHYCf7S1G5AwhU/x6bAF5hay0wzV/XFkOdJT0pFlSa+8rd/xcO5MaxFzhaiE6gqXUnmFb95R1uCbbelZnluXo8cYS/39dPo8PmdjPIjBFp6xFUP4/NyQ/JK6bUEYemlgVuuo6AynFwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxfNjpn4Ei1FTzur+zJ7dk+zvMnGuzwbefZwdQh4NcQ=;
 b=S1+lhx83cVPklopuzrVlg3SEXjgck1+VEg27eQhPpaXM4Y7RQbDOMylOuFznklZV479nWqea2iMqhzA82XE7Qy9ZBCZ8SzIVPO6L5GIC1Uh6ynIAkkM3Reh7f7h7we4aRTW0RRB4EoGHORHYpksPwetDszz0ZpoSFbjJsW5trfoNmYIwsf/GSkr1yf50I0thQaAOoHygzlGdobVo7/8sl8pLooDeMeGXVPRmH5pm+FHpa1AndKAmYPsNeiOpqHliwxfRNW/19CuYQPaoUIc+OT/fgnOcozablrS7Xxc8v/e/E4MJzOfwDbRDVz99kR/xpy38dFz33M27pgHw7KuhWA==
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 00:21:04 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::52) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Tue, 22 Oct 2024 00:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 00:21:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 17:20:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 17:20:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v4 13/14] iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate
Date: Mon, 21 Oct 2024 17:20:22 -0700
Message-ID: <48238ea44b62b0ea500891a76f4daec3ee755e44.1729555967.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
References: <cover.1729555967.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1a5921-2257-4c84-9158-08dcf22f69d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9bU8leiz/3zwRrq+NFB1xWkHEuS0SQj5+67Wcrf0bpcUZQBpp2g5MeDQEWqm?=
 =?us-ascii?Q?9wmVOaMt0XpVzwPtfaefMblGAom/rb5273CRX1dUmVAaCaKC9RVxk4EfvWcc?=
 =?us-ascii?Q?AoODAbbxxTpiff1NtCfQBlYNk8eKL8cRE+9fYgSWZyW2dwGn74kFJxabIegA?=
 =?us-ascii?Q?9lr2KEOQO3xLi//2NhcftJQ9HfzGkOjwDE+NtoIyvxL5uWaWFh4COGATtOad?=
 =?us-ascii?Q?/yjIa4aTkUvo0dZJ+8TaISqNZNgRKw2uV0V8rwsluM1HxqTgxd8n7nOdTJ6o?=
 =?us-ascii?Q?+7W+RCFwMmfqjajCAItVH4MuO4ml1LSi7HZboe1td2u9bFecHnQlfkIhWrJb?=
 =?us-ascii?Q?vfXSnEiR3TyhscyDGFDwf9SFvYoseeaAx/ogtsOcEJZvUByAzfQIYlomDfv8?=
 =?us-ascii?Q?KVdWek49kMWmpCBtt/SY36o/cIXeH6EtVUaFBWvu4fMQKV2Z9w6m+hwK6hWd?=
 =?us-ascii?Q?r/5E7iF+NcB6gUpOG1RjsjQPbFvSXPFL2+ytbKIOk9ae0Ixc6O8GEHw6MdR1?=
 =?us-ascii?Q?QqZ8+Cbei4uUYS8EdDDo7/lhGYFeCUHInt11j/2CHtsD4ecgfT8TsoK6jdnv?=
 =?us-ascii?Q?8qeo9KndTfYXCCyoUE6qYPCG86FnehvHYa0OIZvm4458QDOaR18Bc3GxXFFh?=
 =?us-ascii?Q?/KuHH9F6ytAt9Z0X2MFAl9TdZILadP24xHJ7S2CAWKdu3gcoq+YRs3HoXVrf?=
 =?us-ascii?Q?a6BjbD61RnH9Hv8UzbgoEdpwhilfe7M/f9St6xBFWLkhgr1NHqVsHwNb96hw?=
 =?us-ascii?Q?T70F8VX6GvNDjlSIBlrligASvI+JCIGyr+8xFfH2FN3WePljWiTyCiQzVOt1?=
 =?us-ascii?Q?2ljsyJasnVOmOhRnGetoi77QyNpKNhdNuCdpWBQIIf5X5nLCFdxT1FfcT1xV?=
 =?us-ascii?Q?AamesTTnVGuw7tJahLPB6pdywy4QAX5wRlR7ioEkDKbA7q1YsC7BJJ6M+q57?=
 =?us-ascii?Q?q9xHCxeZO07qiqrVbDdfCGPnoqiUTfgEnIU6HElcaiXyV4SxYf4tNRB9QxXz?=
 =?us-ascii?Q?pCnIA/6svh2N62MOMwSbDB4g88BQYU2kYK7QMvGb5Ph1aF3f8mUfTc22rn2A?=
 =?us-ascii?Q?Cn7o4KhGpbSvXoyWk7R027SyDIz4iuAinxtD15HrXT2mET8hrhfbkKOJzNoG?=
 =?us-ascii?Q?Lvb3gJy/N8x2y9BC0lQ0El6kmhJh9KRma0U7GDLGT8b8k5YP4DoatA+QyTBd?=
 =?us-ascii?Q?wWU1uSDD3sy42r/VgeC2ikcIXF4+QY36+BveJlH2IU8Dkipj7gJTAsBOlHf/?=
 =?us-ascii?Q?61M0qx++JfMLABdYqsT3eyVhmsZGQ25AulHL+2z1kqLXKPJwd44TVAA7hlZk?=
 =?us-ascii?Q?1cgLVBboKlCNkD6+EclFSYP1jtSTMNpiZqV6Eet3dBcFzriRqeTzoNVn4nmi?=
 =?us-ascii?Q?IcXpDe/CibPpweoRKEb6W69FqGqX55jc44+uzk9U3ZTBMw3YXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:21:03.0790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1a5921-2257-4c84-9158-08dcf22f69d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696

Implement the vIOMMU's cache_invalidate op for user space to invalidate the
IOTLB entries, Device ATS and CD entries that are still cached by hardware.

Add struct iommu_viommu_arm_smmuv3_invalidate defining invalidation entries
that are simply in the native format of a 128-bit TLBI command. Scan those
commands against the permitted command list and fix their VMID/SID fields.

Co-developed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +
 include/uapi/linux/iommufd.h                  |  24 ++++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 131 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 4 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5a025d310dbe..8bd740f537ee 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -529,6 +529,7 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_TLBI_NH_ALL     0x10
 		#define CMDQ_OP_TLBI_NH_ASID	0x11
 		#define CMDQ_OP_TLBI_NH_VA	0x12
+		#define CMDQ_OP_TLBI_NH_VAA	0x13
 		#define CMDQ_OP_TLBI_EL2_ALL	0x20
 		#define CMDQ_OP_TLBI_EL2_ASID	0x21
 		#define CMDQ_OP_TLBI_EL2_VA	0x22
@@ -949,6 +950,10 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target);
 
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
+				bool sync);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 3486ae2d62d1..007e4b5ebe34 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -686,9 +686,11 @@ struct iommu_hwpt_get_dirty_bitmap {
  * enum iommu_hwpt_invalidate_data_type - IOMMU HWPT Cache Invalidation
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
+ * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
+	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 = 1,
 };
 
 /**
@@ -727,6 +729,28 @@ struct iommu_hwpt_vtd_s1_invalidate {
 	__u32 __reserved;
 };
 
+/**
+ * struct iommu_viommu_arm_smmuv3_invalidate - ARM SMMUv3 cahce invalidation
+ *         (IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3)
+ * @cmd: 128-bit cache invalidation command that runs in SMMU CMDQ.
+ *       Must be little-endian.
+ *
+ * Supported command list only when passing in a vIOMMU via @hwpt_id:
+ *     CMDQ_OP_TLBI_NSNH_ALL
+ *     CMDQ_OP_TLBI_NH_VA
+ *     CMDQ_OP_TLBI_NH_VAA
+ *     CMDQ_OP_TLBI_NH_ALL
+ *     CMDQ_OP_TLBI_NH_ASID
+ *     CMDQ_OP_ATC_INV
+ *     CMDQ_OP_CFGI_CD
+ *     CMDQ_OP_CFGI_CD_ALL
+ *
+ * -EIO will be returned if the command is not supported.
+ */
+struct iommu_viommu_arm_smmuv3_invalidate {
+	__aligned_le64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 70ad857a57b8..6f53a2928c36 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -184,9 +184,132 @@ arm_vsmmu_domain_alloc_nested(struct iommufd_viommu *viommu,
 	return &nested_domain->domain;
 }
 
+static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
+{
+	XA_STATE(xas, &vsmmu->core.vdevs, (unsigned long)vsid);
+	struct arm_smmu_master *master;
+	struct device *dev;
+	int ret = 0;
+
+	xa_lock(&vsmmu->core.vdevs);
+	dev = vdev_to_dev(xas_load(&xas));
+	if (!dev) {
+		ret = -EIO;
+		goto unlock;
+	}
+	master = dev_iommu_priv_get(dev);
+
+	/* At this moment, iommufd only supports PCI device that has one SID */
+	if (sid)
+		*sid = master->streams[0].id;
+unlock:
+	xa_unlock(&vsmmu->core.vdevs);
+	return ret;
+}
+
+/* This is basically iommu_viommu_arm_smmuv3_invalidate in u64 for conversion */
+struct arm_vsmmu_invalidation_cmd {
+	u64 cmd[2];
+};
+
+/*
+ * Convert, in place, the raw invalidation command into an internal format that
+ * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
+ * stored in CPU endian.
+ *
+ * Enforce the VMID or SID on the command.
+ */
+static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
+				      struct arm_vsmmu_invalidation_cmd *cmd)
+{
+	/* Commands are le64 stored in u64 */
+	cmd->cmd[0] = le64_to_cpu((__force __le64)cmd->cmd[0]);
+	cmd->cmd[1] = le64_to_cpu((__force __le64)cmd->cmd[1]);
+
+	switch (cmd->cmd[0] & CMDQ_0_OP) {
+	case CMDQ_OP_TLBI_NSNH_ALL:
+		/* Convert to NH_ALL */
+		cmd->cmd[0] = CMDQ_OP_TLBI_NH_ALL |
+			      FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
+		cmd->cmd[1] = 0;
+		break;
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_TLBI_NH_VAA:
+	case CMDQ_OP_TLBI_NH_ALL:
+	case CMDQ_OP_TLBI_NH_ASID:
+		cmd->cmd[0] &= ~CMDQ_TLBI_0_VMID;
+		cmd->cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
+		break;
+	case CMDQ_OP_ATC_INV:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL: {
+		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd[0]);
+
+		if (arm_vsmmu_vsid_to_sid(vsmmu, vsid, &sid))
+			return -EIO;
+		cmd->cmd[0] &= ~CMDQ_CFGI_0_SID;
+		cmd->cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
+		break;
+	}
+	default:
+		return -EIO;
+	}
+	return 0;
+}
+
+static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
+				      struct iommu_user_data_array *array)
+{
+	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+	struct arm_smmu_device *smmu = vsmmu->smmu;
+	struct arm_vsmmu_invalidation_cmd *last;
+	struct arm_vsmmu_invalidation_cmd *cmds;
+	struct arm_vsmmu_invalidation_cmd *cur;
+	struct arm_vsmmu_invalidation_cmd *end;
+	int ret;
+
+	cmds = kcalloc(array->entry_num, sizeof(*cmds), GFP_KERNEL);
+	if (!cmds)
+		return -ENOMEM;
+	cur = cmds;
+	end = cmds + array->entry_num;
+
+	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
+	ret = iommu_copy_struct_from_full_user_array(
+		cmds, sizeof(*cmds), array,
+		IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3);
+	if (ret)
+		goto out;
+
+	last = cmds;
+	while (cur != end) {
+		ret = arm_vsmmu_convert_user_cmd(vsmmu, cur);
+		if (ret)
+			goto out;
+
+		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
+		cur++;
+		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
+			continue;
+
+		/* FIXME always uses the main cmdq rather than trying to group by type */
+		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
+						  cur - last, true);
+		if (ret) {
+			cur--;
+			goto out;
+		}
+		last = cur;
+	}
+out:
+	array->entry_num = cur - cmds;
+	kfree(cmds);
+	return ret;
+}
 
 static const struct iommufd_viommu_ops arm_vsmmu_ops = {
 	.domain_alloc_nested = arm_vsmmu_domain_alloc_nested,
+	.cache_invalidate = arm_vsmmu_cache_invalidate,
 };
 
 struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
@@ -206,6 +329,14 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
 	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	/*
+	 * FORCE_SYNC is not set with FEAT_NESTING. Some study of the exact HW
+	 * defect is needed to determine if arm_vsmmu_cache_invalidate() needs
+	 * any change to remove this.
+	 */
+	if (WARN_ON(smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * Must support some way to prevent the VM from bypassing the cache
 	 * because VFIO currently does not do any cache maintenance.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index de598d66b5c2..5c652e914a51 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -766,9 +766,9 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  */
-static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				       struct arm_smmu_cmdq *cmdq,
-				       u64 *cmds, int n, bool sync)
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
+				bool sync)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
-- 
2.43.0


