Return-Path: <linux-kselftest+bounces-31682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E0A9D7E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 08:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085423A05D5
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037441FC114;
	Sat, 26 Apr 2025 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hzseX7/Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479A1F5825;
	Sat, 26 Apr 2025 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745647160; cv=fail; b=dCxY1mJmFpYnHSuk7rvYPNAmNKrNQCiakaK2ZvvPFWBP6Jpmknygua4fDRrD5HaRfK5yc5HBpOKSVjqDFAvlvYU8z209MF6LnaNPaM24VKPcNVFlPYYfjvBmNrQknZRh7qCYpYArxajFthEkb6q+CcWjuRtb75eZ+S4fVdF63n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745647160; c=relaxed/simple;
	bh=zUmFl0akw2TyrGxEA2oEZyKPSrBPqe+fKdfkWkFXqdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZZ7wjmTC5ay582NGi0q9K9wgGmrJOCk/lpxPhcQI1cPokjj7p4j++ok9Hu461DcnkqRXT59BmagubEgwGPZSptcxmITkQjDwIy2YbNiGmdjZw06oAPP/BLVFu5nPEwXUmbGewl/5r+drYw06UWUZcfZVHYZjdkIKVtok3ACMlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hzseX7/Z; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRtf7xmwRKlcW3Ksp6mEm29vx17woGRU1fqCDDbFQFteKte+nnI2P02wpPNnmAM139rgQZMIOul+3/HlMRv5W6hmAqY2gxlrrXGAfcbcHXsB8jn5wZH4Mpx4zgVAUbquwMo576J61xHZlL80UOK+SlfPK0sm8VFiMixp26mNnshpllHf9EeCSXWuoVBFvKjDJFt0zkh8gmyuAfCErxvB3+5T5fxgYAHpqQBsbpHK0plX/7LxXlUw5DnEn5oYBAskd4JxaKO3Xd8A0rFIvX3tzckx8ZrZ+0lW36W/3yqTHzNUOid6Hoob/bfVFAIyY68krzXCSZ4fBpMTPmqFN21XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqB7HSMGrsMuUPxEkqb3O54AQ7uPWiwDFj2bnlSL084=;
 b=lz4XAoCdwp8wN3zXD3xDoRfU981eEBltq6ozxxYPRykXw+0wFoX45WpyqZxdHSO8ESHuTpFfgzXatRHGW34NH6mIGwXmTFiS6ikOmE5PCWsbaqmUbCqIEHKJsqncF2LPbLa3MQiIfwY1y7pvlPYDhuXf7qR41ZYrPzhiXJz9S/DPNI45e/x0BB7dunesz06RlNQxphcmbav3ARouXjIFJ6LeMfsFzc4SB1zTiBLXVFd3dC25ICXqWLE8mceY5VfXE2h6bdga6ZK7rWDeGET0thIcHZoTkxr2aHhk3tn638LsOw2pAa44cTEGHLD+MEusFXX2P6+ncdvEYRauCZ2o8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqB7HSMGrsMuUPxEkqb3O54AQ7uPWiwDFj2bnlSL084=;
 b=hzseX7/ZC8nXu8wrYnypE2KjPTIOaSFz9MNSHJ1mXpsrFX/e2bC+lyaxBdiEhUVnVbNUgAgcwNOqaxpDEmcknsb6P0imi+dDsOxBU4UScNn8NiNI9KRsNsrUu0o0OfeN2+5csMFu9fEDM60QbPkY7VI1VHn+YraDxhFHCzvSXnuiawPopF0DcBTGqordi3RfGENOWGpk1HGRnQWQxNr7i0PKEyDYBRV3bnE2M35QfY17Dw+/WUvVoao6sjPZ9LqnLlSMGSY7s7SSraJK9cj/ph9rh3H/LBzMgS6kQfUvTJ1Ft/9AgaRqjcKCkA8SbSlNNOG1pzL7dxgZSwrZNuweZA==
Received: from DS7PR03CA0256.namprd03.prod.outlook.com (2603:10b6:5:3b3::21)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 05:59:14 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::83) by DS7PR03CA0256.outlook.office365.com
 (2603:10b6:5:3b3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Sat,
 26 Apr 2025 05:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sat, 26 Apr 2025 05:59:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 22:59:03 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 22:59:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Apr 2025 22:59:00 -0700
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
Subject: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC ioctl
Date: Fri, 25 Apr 2025 22:58:05 -0700
Message-ID: <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745646960.git.nicolinc@nvidia.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: d1007fa1-61c5-411c-6eee-08dd84877919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OEDQUZFi1kIWjtDPDrToRkN3/+Akr0PqDWisy0qsCs+d2wDvU+m6mL8kgZ6d?=
 =?us-ascii?Q?DtdI61BNGGQqdtRehDxnd3eHNLQVukc7PiuPy4JgmgkhEsYKukQ6+3B5kqOp?=
 =?us-ascii?Q?6D/5gotyCRBeFtQIVDTmMhG4UmE41UDADwd1I0/U0e7nFRhMEjHpA6Rba379?=
 =?us-ascii?Q?ksFaFVG6eBJT9m31DKT1W99NjQMzrxITDP0K4v4oKTUo4opzDq32VD/Oyfpz?=
 =?us-ascii?Q?XyJJE2RD6ilBgxjPlxm0w6VkbrUlalbWPxIig90/g+1ezbWXb7MsQdemPGSc?=
 =?us-ascii?Q?GDi8kGE1JAVhddwy/Nm3/6Dvu0a1eNFI+eC2SiJ4gJ3hQbnTb+Ym+Bkabe1s?=
 =?us-ascii?Q?s9VkNin664/PtD0/UENmUYsvmY/Uol0K+VHlzlHatv26T0bqvLJCr9tN+ohs?=
 =?us-ascii?Q?2odpLiCEJGbzg5IFRYK2Tj2I8UzjxEarH5V7fiGqsNEMoTCPZ5KT+/xqUaXP?=
 =?us-ascii?Q?fNSTqr2huu9nb91KXUMgmBjAJYHQhC9+HoIpFRdh8XDfc+tCyXYub3lqWLAF?=
 =?us-ascii?Q?+RNLMAZqqdE1/C70J7RUen9yxsLvR+cvXJS4Bbzd87KlMqeQPKiVKglD0uwl?=
 =?us-ascii?Q?0bVUQim5Y+alHTjZsLqy8qvsGAud1xWLw05qE031vf57wz0QkqwpHtWTsIjP?=
 =?us-ascii?Q?uwYzIvPis/lh6awVB1gyuaeu5YE81qNcC0VeLA9jdMdjOU+JLQYPvxEsSYK5?=
 =?us-ascii?Q?MH/oKDwlwcGnrCrzEP350Q3pvBuvy9dSW1Md97iuqhV+E5aX28Y/wlgI3/K4?=
 =?us-ascii?Q?ZvSgMNom3DbZqnq0S6fRD7FfkrIwm/AGu7cNbuVCXUlIJ+XG74WQn26Vgl3g?=
 =?us-ascii?Q?gt+8WCd1xTBc8VhQDkoqSJby/bjlFjZeAOjshRErxinxtHYUQ1Zx06HF+v3w?=
 =?us-ascii?Q?jZYiHZO/gqwLRCTHDs80S4GKlGrF/ZREX88DzM+S0zsOMX6R+C3f6AN/PiEl?=
 =?us-ascii?Q?4GyNDsKOFoGEy9HNlKqkSYyoBDmzLKypcoqoI1LTOzP5M7Fr73xppm8l/qxf?=
 =?us-ascii?Q?BIQ5aXCkhBJYvZ3jxXhhtYe0h4kaz9f04yKPEtv56hj1h/00NzmORgn/Z+Xq?=
 =?us-ascii?Q?D1EYIHYcdw1SvsL1FOU6ctF3YkBk5HzgYd4UF8dO14B0zzWGFDA61tETorYV?=
 =?us-ascii?Q?scjjIrxLMQrB8A360BuJKi+WJgviOMdIlZlZ/ovEe3VAeoJvUZa322FcrTyp?=
 =?us-ascii?Q?zSTRbYBCMv2dz1GBonsdUkbu3gWJUaK/zLgtKazU50vkblph0uT751t7X1q0?=
 =?us-ascii?Q?+ry6AYwL+DnrRE2j1kdW4MG2alovytLwGZXe/YYDyW7jmhNrGA/zm4UZgPDH?=
 =?us-ascii?Q?74vTyyP1fC6ZQU4XPRkNXGz+b63Y499ASZ2MwFhZKBil8KmxJPyCMHI+kHro?=
 =?us-ascii?Q?LARFQazcImI3yvzUERRSM1CqK37ZpX/qqjfhyUUmOfl+pr8b7A0OTZ93da5k?=
 =?us-ascii?Q?r5YLDIGCk/z3MK0d5bq13kcbEKaRFpXuu5b1nTD3808lZFozwFB9fufEwXF5?=
 =?us-ascii?Q?F3qsQL+jNKubRYvNpvewnI4tcAPXRdLt+6XG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 05:59:14.2077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1007fa1-61c5-411c-6eee-08dd84877919
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282

Introduce a new IOMMUFD_CMD_VCMDQ_ALLOC ioctl for user space to allocate
a vCMDQ for a vIOMMU object. Simply increase the refcount of the vIOMMU.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 include/uapi/linux/iommufd.h            | 41 +++++++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 94 +++++++++++++++++++++++++
 4 files changed, 143 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 79160b039bc7..b974c207ae8a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -611,6 +611,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_vcmdq_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cc90299a08d9..06a763fda47f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -56,6 +56,7 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_VCMDQ_ALLOC = 0x94,
 };
 
 /**
@@ -1147,4 +1148,44 @@ struct iommu_veventq_alloc {
 	__u32 __reserved;
 };
 #define IOMMU_VEVENTQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VEVENTQ_ALLOC)
+
+/**
+ * enum iommu_vcmdq_type - Virtual Command Queue Type
+ * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
+ */
+enum iommu_vcmdq_type {
+	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
+ * @size: sizeof(struct iommu_vcmdq_alloc)
+ * @flags: Must be 0
+ * @viommu_id: Virtual IOMMU ID to associate the virtual command queue with
+ * @type: One of enum iommu_vcmdq_type
+ * @index: The logical index to the virtual command queue per virtual IOMMU, for
+ *         a multi-queue model
+ * @out_vcmdq_id: The ID of the new virtual command queue
+ * @addr: Base address of the queue memory in the guest physical address space
+ * @length: Length of the queue memory in the guest physical address space
+ *
+ * Allocate a virtual command queue object for a vIOMMU-specific HW-accelerated
+ * feature that can access a guest queue memory described by @addr and @length.
+ * It's suggested for VMM to back the queue memory using a single huge page with
+ * a proper alignment for its contiguity in the host physical address space. The
+ * call will fail, if the queue memory is not contiguous in the physical address
+ * space. Upon success, its underlying physical pages will be pinned to prevent
+ * VMM from unmapping them in the IOAS, until the virtual CMDQ gets destroyed.
+ */
+struct iommu_vcmdq_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 index;
+	__u32 out_vcmdq_id;
+	__aligned_u64 addr;
+	__aligned_u64 length;
+};
+#define IOMMU_VCMDQ_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VCMDQ_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 2b9ee9b4a424..ac51d5cfaa61 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -303,6 +303,7 @@ union ucmd_buffer {
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
+	struct iommu_vcmdq_alloc vcmdq;
 	struct iommu_vdevice_alloc vdev;
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
@@ -358,6 +359,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
+	IOCTL_OP(IOMMU_VCMDQ_ALLOC, iommufd_vcmdq_alloc_ioctl,
+		 struct iommu_vcmdq_alloc, length),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
 	IOCTL_OP(IOMMU_VEVENTQ_ALLOC, iommufd_veventq_alloc,
@@ -501,6 +504,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
+	[IOMMUFD_OBJ_VCMDQ] = {
+		.destroy = iommufd_vcmdq_destroy,
+	},
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
 	},
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index a65153458a26..02a111710ffe 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -170,3 +170,97 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+void iommufd_vcmdq_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vcmdq *vcmdq =
+		container_of(obj, struct iommufd_vcmdq, obj);
+	struct iommufd_viommu *viommu = vcmdq->viommu;
+
+	if (viommu->ops->vcmdq_destroy)
+		viommu->ops->vcmdq_destroy(vcmdq);
+	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, vcmdq->addr, vcmdq->length);
+	refcount_dec(&viommu->obj.users);
+}
+
+int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
+	struct iommufd_viommu *viommu;
+	struct iommufd_vcmdq *vcmdq;
+	struct page **pages;
+	int max_npages, i;
+	dma_addr_t end;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->addr || !cmd->length)
+		return -EINVAL;
+	if (check_add_overflow(cmd->addr, cmd->length - 1, &end))
+		return -EOVERFLOW;
+
+	max_npages = DIV_ROUND_UP(cmd->length, PAGE_SIZE);
+	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_free;
+	}
+
+	if (!viommu->ops || !viommu->ops->vcmdq_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	/* Quick test on the base address */
+	if (!iommu_iova_to_phys(viommu->hwpt->common.domain, cmd->addr)) {
+		rc = -ENXIO;
+		goto out_put_viommu;
+	}
+
+	/* The underlying physical pages must be pinned in the IOAS */
+	rc = iopt_pin_pages(&viommu->hwpt->ioas->iopt, cmd->addr, cmd->length,
+			    pages, 0);
+	if (rc)
+		goto out_put_viommu;
+
+	/* Validate if the underlying physical pages are contiguous */
+	for (i = 1; i < max_npages && pages[i]; i++) {
+		if (page_to_pfn(pages[i]) == page_to_pfn(pages[i - 1]) + 1)
+			continue;
+		rc = -EFAULT;
+		goto out_unpin;
+	}
+
+	vcmdq = viommu->ops->vcmdq_alloc(viommu, cmd->type, cmd->index,
+					 cmd->addr, cmd->length);
+	if (IS_ERR(vcmdq)) {
+		rc = PTR_ERR(vcmdq);
+		goto out_unpin;
+	}
+
+	vcmdq->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	vcmdq->addr = cmd->addr;
+	vcmdq->ictx = ucmd->ictx;
+	vcmdq->length = cmd->length;
+	cmd->out_vcmdq_id = vcmdq->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		iommufd_object_abort_and_destroy(ucmd->ictx, &vcmdq->obj);
+	else
+		iommufd_object_finalize(ucmd->ictx, &vcmdq->obj);
+	goto out_put_viommu;
+
+out_unpin:
+	iopt_unpin_pages(&viommu->hwpt->ioas->iopt, cmd->addr, cmd->length);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+out_free:
+	kfree(pages);
+	return rc;
+}
-- 
2.43.0


