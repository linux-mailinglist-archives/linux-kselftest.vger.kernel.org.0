Return-Path: <linux-kselftest+bounces-35899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E85DAEA6B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0421C288D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8AE2F432E;
	Thu, 26 Jun 2025 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SaRErPKd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E02F3C01;
	Thu, 26 Jun 2025 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966546; cv=fail; b=FarQt/Hj+okJbU7kXl5noo60cHLblZx5QPSokZRSiLJw7WkEK72ahEzP9Ps7lR1LyS6L37ZrUyP4toCzlWTkTNOZecLK3DXBoek7Ux9ufwxATDKcNJ0e2ulHYe+iJUnEP6zQdEhTGEr7u3+WB/gl5GDLvqZArdn9J+YujQ5I00Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966546; c=relaxed/simple;
	bh=ayvAMQUYXsjri6WfOZqdJR6hyJk/Y3JouvvfUyCtGb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc4vV8s20HYQxw2ngb1NdxvHh4kaED9ub3UoyxlMxrMKG9ObtyzjY4jWI6F3qwytNnWhLL0WzKsROsSxVVrvfq0Pi1oCNGp0UHMHlLKIwkYeGbCqFeOr8J1sZ+ix0Cof61GGPW4RdLEzotMShV1P+8M7RnzTd+QTmiJ81eYXE5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SaRErPKd; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuOHkomN44TR2im4/LBzhfFny+p5c0Dj1iwHeC5gTCINawS4ljn4iWPPfAnvEL3cbI5Wc9zoO04wWOPSqFG47jPhEqrs57rQFOn1LX0MbArUp/kQKiwxxjmRjvqZ+zisLguk37talqG4DOIaJ2AG3M6xOM8k20w7YJ07MhcZxBjSzOodPQTjxMaoEl9dw1tz3xLAjq6MeNHeVwnfzszBzfPw/sToBmkgg+9hnjvpbaeEcxGDec3ydWf2owX6l4qNl2Pq8lepnS99oyXiWnasf1sDHHbj3xVfOcfDrWnyATMWwh5MAj3K4MiQPKIjKAsNJ/kbrZFRg8PtEO5R0owqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3Ao0kin8/iYqA8WNrR1zc+87M0g7FKCNxSBUJc1rlI=;
 b=pfSAF/DG1ff321VVUXEcJRNE6BcFEG1L7cBvJmoGpJbPbjGhij8QWzkHS20ZMBiCeM4Zat/p5KoH7bEqVUJLLFYN5dtWphKHGNXHErk43jSn5p2NOIPvLhAhMkzuiZOH3ZvqBIDEP8Kiib/lKdurB2AchWPkSpHSH4Sl4tnaz7dPWG/OR1LwQNdzzAJ4ldWMWajtu5VaZA1RcOBl0SV6ITqPuQ3H0SRG5zB2obe5KxwCR5UQxBrH2oCKRjqIVZGcLzP88pFzPc7KuaK15jE326Olke7V78m5kz5XfMhycy5mMA054Tzat6kiGLySyN9UvX0cC7AQRAKKVd+H6QY3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3Ao0kin8/iYqA8WNrR1zc+87M0g7FKCNxSBUJc1rlI=;
 b=SaRErPKd2/AggDF/kbczPmAwVPdN2cdqbLoM/VFgUQI61Lcw2HtVr7vD+xTK/vkI7awg2NTtJMNvfo4Pi9pCmhP2rG/w/w7XVVGGJAE3HYRRqSmk69KKDKUOYddGZoOwjLckNX+KQi6qDRPQm5YNrvSQQzGi5AZjAA9nw3h9l/gOi/HKhQDK1jMGn8d/OwZq0gkA2TNmNAcX3iSCMoyLulXvtaYItk5Ro0rr3SGYt2mpmF1s5a/yXE6xniObPpR//cqmg84R8z+TdVjPHeheo9LbbyIQy4c2SlSfNApCwrFVzEV/tIvX/rcAmQjrg2cIdnqHah85PIz5jGxiZhyzfg==
Received: from LV3P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::35)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 19:35:40 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::ba) by LV3P220CA0025.outlook.office365.com
 (2603:10b6:408:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Thu,
 26 Jun 2025 19:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 19:35:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 12:35:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 12:35:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 12:35:23 -0700
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
Subject: [PATCH v7 13/28] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl
Date: Thu, 26 Jun 2025 12:34:44 -0700
Message-ID: <31ab67fa5c4fc1f2c8bea74fa23c1da7b97b9a93.1750966133.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a94d5e-d449-4b68-623d-08ddb4e8a263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIx0uzXEqHQlXhNlQG1It1Z+IPMgTkrXv4642uvHy+gv7b0f8nTEu4W2HLSC?=
 =?us-ascii?Q?Q4RzvqUza9FjGmxtaDXUT89lp7G3yeZXxczUTOH4O846SW+2iDMltf8RNhg2?=
 =?us-ascii?Q?1vxLc7AObb4yuLoilfV1D4SHCM9edej5Vr1NOljzWzomIuXp6FP9yN2/xksA?=
 =?us-ascii?Q?VqaPVBhm+4HZptQfaotN66iFY0WcqiJzFi1/XCByL41im92Q6+FS1x143Qs/?=
 =?us-ascii?Q?PuFY9zMEYY2l59myoE/H/Sz1JCydJU8Djn3ePdMxeyFMmQInJuwZb9jCnqwC?=
 =?us-ascii?Q?zUY2+EXUO5azN+d7cesQ0jr1rN5yE9icd5xLVUiKn3PJmIg6wYzm2106pSBj?=
 =?us-ascii?Q?t4JSxAZaxZ600XEXOCIvzKbtStAWrOPExtLEzsMeJmkaZhNT7QkSQSTVRgiX?=
 =?us-ascii?Q?lPTRqh2B3EW7jDewzp2XORbqBPuR0vqPmvmWXMs1cEc0Gq/Sj+X5GnyU8rgW?=
 =?us-ascii?Q?QdZSWBtUuXxR86P5MrgkrR6NcZODerUeaCUnvvhU6fHsZC9sxmSdwzyl16ck?=
 =?us-ascii?Q?GhvwMTQy1HsBKB72s+HUjTEPZ4blbiuOhB+P+OIrB4dc+/+W6njKqaThfdd6?=
 =?us-ascii?Q?LXvXOp4h0LZFoTb11mrRUTC6bolRS5Pr1Av7hV6ITCFsfV4QSstXOGmBsEEZ?=
 =?us-ascii?Q?CyZOXe9AoEI91PpqN1uDenZj8KfdVBHjP9u++pu3sDZXD8zBdKdGdh3xKdWa?=
 =?us-ascii?Q?9jec/R4HFNQMdZSFEy6p2k9qS4X0RQrnGiapTqatjb6T4zudaDRX8vRu/lH/?=
 =?us-ascii?Q?V2AGNXP5nRzwbNZBxBh9puY7zGcLSD2nwAIg7J7D7JThssKSW5yey3oo8QsO?=
 =?us-ascii?Q?hMZ+1tNQrGRwKXuxR3z5Vnw/42Pde2Zcns3d1KwiSaX9Y/Eoyw60yOec8jgO?=
 =?us-ascii?Q?bu70Fm6m1NxinWgfe3RbW/pD57+jhFmKr48eEdNRTrCoRWLMquJt8+2cH7EV?=
 =?us-ascii?Q?N6alHQPjLBj24/8aDMpYHA1E2uTfb6dRi/9UBncNL12KUk7CD3Nm1pYM3NRJ?=
 =?us-ascii?Q?U9P8hIvFpmDNYOaHzYsC2VevoEFJjcVyf9vBKkS6oVBPQeVL6KffGJeSaLD/?=
 =?us-ascii?Q?2YtxilSkcKLI6mZmgbIhQO6foQdFSvZyZVzpWnb6ftxMnAQv/JkavN+mVvMz?=
 =?us-ascii?Q?0uK3xYXVWZ+nUgzsrdtGm9yJI4pflVL5/6uXWVsOfkGyBrwXr1H+gF/7CUaa?=
 =?us-ascii?Q?qrh8UZXGQkhmXXfML6RyH0Hm0SshWZlSUv8Qnyf6lLFmLS8YAt/B7iOppNhi?=
 =?us-ascii?Q?+GcFxxZncWc85wptaa0zff/gCx3cddPfpiZyuUNa6RJR5mT/eI/vRk6SNBrY?=
 =?us-ascii?Q?7iU2QDZqocLNJVWzDbEcYCEJJxylThypYyd9RtcdDraWfyxbE+kYmdPyUgys?=
 =?us-ascii?Q?LRlZM/+k8jIePRk0ad9RiUeTDEjfq/iTQLO/hp7MYXi9oGtlIkJotI8ghBdJ?=
 =?us-ascii?Q?myxHi7HLYFNhbr0OhypUbeqkPo+Wz+IqRBwIw2cAkBzr2tX1Zopgj0ulAUwl?=
 =?us-ascii?Q?d3ebq5Rmd0XF97B7cjCVg1CxpkOskjPzPE2E?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 19:35:40.4518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a94d5e-d449-4b68-623d-08ddb4e8a263
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

Introduce a new IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl for user space to allocate
a HW QUEUE object for a vIOMMU specific HW-accelerated queue, e.g.:
 - NVIDIA's Virtual Command Queue
 - AMD vIOMMU's Command Buffer, Event Log Buffers, and PPR Log Buffers

Since this is introduced with NVIDIA's VCMDQs that access the guest memory
in the physical address space, add an iommufd_hw_queue_alloc_phys() helper
that will create an access object to the queue memory in the IOAS, to avoid
the mappings of the guest memory from being unmapped, during the life cycle
of the HW queue object.

AMD's HW will need an hw_queue_init op that is mutually exclusive with the
hw_queue_init_phys op, and their case will bypass the access part, i.e. no
iommufd_hw_queue_alloc_phys() call.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 include/linux/iommufd.h                 |   1 +
 include/uapi/linux/iommufd.h            |  33 +++++
 drivers/iommu/iommufd/main.c            |   6 +
 drivers/iommu/iommufd/viommu.c          | 170 ++++++++++++++++++++++++
 5 files changed, 212 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4db8c6890f4c..936387bcd0d0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -652,6 +652,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_hw_queue_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 808536ed97e0..c98edfce5081 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -123,6 +123,7 @@ struct iommufd_vdevice {
 struct iommufd_hw_queue {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
+	struct iommufd_access *access;
 
 	u64 base_addr; /* in guest physical address space */
 	size_t length;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 971aa19c0ba1..f091ea072c5f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -56,6 +56,7 @@ enum {
 	IOMMUFD_CMD_VDEVICE_ALLOC = 0x91,
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
+	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 };
 
 /**
@@ -1156,4 +1157,36 @@ enum iommu_hw_queue_type {
 	IOMMU_HW_QUEUE_TYPE_DEFAULT = 0,
 };
 
+/**
+ * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
+ * @size: sizeof(struct iommu_hw_queue_alloc)
+ * @flags: Must be 0
+ * @viommu_id: Virtual IOMMU ID to associate the HW queue with
+ * @type: One of enum iommu_hw_queue_type
+ * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
+ *         model
+ * @out_hw_queue_id: The ID of the new HW queue
+ * @nesting_parent_iova: Base address of the queue memory in the guest physical
+ *                       address space
+ * @length: Length of the queue memory
+ *
+ * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
+ * allows HW to access a guest queue memory described using @nesting_parent_iova
+ * and @length.
+ *
+ * A vIOMMU can allocate multiple queues, but it must use a different @index per
+ * type to separate each allocation, e.g.
+ *     Type1 HW queue0, Type1 HW queue1, Type2 HW queue0, ...
+ */
+struct iommu_hw_queue_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 type;
+	__u32 index;
+	__u32 out_hw_queue_id;
+	__aligned_u64 nesting_parent_iova;
+	__aligned_u64 length;
+};
+#define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 778694d7c207..4e8dbbfac890 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -354,6 +354,7 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_fault_alloc fault;
 	struct iommu_hw_info info;
+	struct iommu_hw_queue_alloc hw_queue;
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_invalidate cache;
@@ -396,6 +397,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_fault_alloc, out_fault_fd),
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
+	IOCTL_OP(IOMMU_HW_QUEUE_ALLOC, iommufd_hw_queue_alloc_ioctl,
+		 struct iommu_hw_queue_alloc, length),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_GET_DIRTY_BITMAP, iommufd_hwpt_get_dirty_bitmap,
@@ -559,6 +562,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_HW_QUEUE] = {
+		.destroy = iommufd_hw_queue_destroy,
+	},
 	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hwpt_paging_destroy,
 		.abort = iommufd_hwpt_paging_abort,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 081ee6697a11..ce509a827721 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -201,3 +201,173 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+static void iommufd_hw_queue_destroy_access(struct iommufd_ctx *ictx,
+					    struct iommufd_access *access,
+					    u64 base_iova, size_t length)
+{
+	iommufd_access_unpin_pages(access, base_iova, length);
+	iommufd_access_detach_internal(access);
+	iommufd_access_destroy_internal(ictx, access);
+}
+
+void iommufd_hw_queue_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_hw_queue *hw_queue =
+		container_of(obj, struct iommufd_hw_queue, obj);
+
+	if (hw_queue->destroy)
+		hw_queue->destroy(hw_queue);
+	if (hw_queue->access)
+		iommufd_hw_queue_destroy_access(hw_queue->viommu->ictx,
+						hw_queue->access,
+						hw_queue->base_addr,
+						hw_queue->length);
+	if (hw_queue->viommu)
+		refcount_dec(&hw_queue->viommu->obj.users);
+}
+
+/*
+ * When the HW accesses the guest queue via physical addresses, the underlying
+ * physical pages of the guest queue must be contiguous. Also, for the security
+ * concern that IOMMUFD_CMD_IOAS_UNMAP could potentially remove the mappings of
+ * the guest queue from the nesting parent iopt while the HW is still accessing
+ * the guest queue memory physically, such a HW queue must require an access to
+ * pin the underlying pages and prevent that from happening.
+ */
+static struct iommufd_access *
+iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
+			    struct iommufd_viommu *viommu, phys_addr_t *base_pa)
+{
+	struct iommufd_access *access;
+	struct page **pages;
+	int max_npages, i;
+	u64 offset;
+	int rc;
+
+	offset =
+		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
+	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
+
+	/*
+	 * Use kvcalloc() to avoid memory fragmentation for a large page array.
+	 * Set __GFP_NOWARN to avoid syzkaller blowups
+	 */
+	pages = kvcalloc(max_npages, sizeof(*pages), GFP_KERNEL | __GFP_NOWARN);
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+
+	access = iommufd_access_create_internal(viommu->ictx);
+	if (IS_ERR(access)) {
+		rc = PTR_ERR(access);
+		goto out_free;
+	}
+
+	rc = iommufd_access_attach_internal(access, viommu->hwpt->ioas);
+	if (rc)
+		goto out_destroy;
+
+	rc = iommufd_access_pin_pages(access, cmd->nesting_parent_iova,
+				      cmd->length, pages, 0);
+	if (rc)
+		goto out_detach;
+
+	/* Validate if the underlying physical pages are contiguous */
+	for (i = 1; i < max_npages; i++) {
+		if (page_to_pfn(pages[i]) == page_to_pfn(pages[i - 1]) + 1)
+			continue;
+		rc = -EFAULT;
+		goto out_unpin;
+	}
+
+	*base_pa = page_to_pfn(pages[0]) << PAGE_SHIFT;
+	kfree(pages);
+	return access;
+
+out_unpin:
+	iommufd_access_unpin_pages(access, cmd->nesting_parent_iova,
+				   cmd->length);
+out_detach:
+	iommufd_access_detach_internal(access);
+out_destroy:
+	iommufd_access_destroy_internal(viommu->ictx, access);
+out_free:
+	kfree(pages);
+	return ERR_PTR(rc);
+}
+
+int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
+	struct iommufd_hw_queue *hw_queue;
+	struct iommufd_viommu *viommu;
+	struct iommufd_access *access;
+	size_t hw_queue_size;
+	phys_addr_t base_pa;
+	u64 last;
+	int rc;
+
+	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
+		return -EOPNOTSUPP;
+	if (!cmd->length)
+		return -EINVAL;
+	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
+			       &last))
+		return -EOVERFLOW;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
+	    !viommu->ops->hw_queue_init_phys) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	hw_queue_size = viommu->ops->get_hw_queue_size(viommu, cmd->type);
+	if (!hw_queue_size) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	/*
+	 * It is a driver bug for providing a hw_queue_size smaller than the
+	 * core HW queue structure size
+	 */
+	if (WARN_ON_ONCE(hw_queue_size < sizeof(*hw_queue))) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	hw_queue = (struct iommufd_hw_queue *)_iommufd_object_alloc_ucmd(
+		ucmd, hw_queue_size, IOMMUFD_OBJ_HW_QUEUE);
+	if (IS_ERR(hw_queue)) {
+		rc = PTR_ERR(hw_queue);
+		goto out_put_viommu;
+	}
+
+	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
+	if (IS_ERR(access)) {
+		rc = PTR_ERR(access);
+		goto out_put_viommu;
+	}
+
+	hw_queue->viommu = viommu;
+	refcount_inc(&viommu->obj.users);
+	hw_queue->access = access;
+	hw_queue->type = cmd->type;
+	hw_queue->length = cmd->length;
+	hw_queue->base_addr = cmd->nesting_parent_iova;
+
+	rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index, base_pa);
+	if (rc)
+		goto out_put_viommu;
+
+	cmd->out_hw_queue_id = hw_queue->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
-- 
2.43.0


