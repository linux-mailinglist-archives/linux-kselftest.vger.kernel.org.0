Return-Path: <linux-kselftest+bounces-19365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED059971E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E18280D29
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6881DEFCE;
	Wed,  9 Oct 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QyaKThSZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23D199FB4;
	Wed,  9 Oct 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491944; cv=fail; b=e3KVFn9v+i4BV8wWiff5QpCgQN5qafmSbD/nCrJdFtoW7u4f5Bf6D2L3r/cj/aGPB7x0pnoj9uMITZP0A7ewPcDdpWTk6mYCAl90F4Ri3XUYMpXn/LZ3vAa/mz9zT9YEJM1TK0JR1h5OeMY1nszOe4Oa+6YsjkWFfgzTjXuhDRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491944; c=relaxed/simple;
	bh=6gOoU/+A83eJdcBdeYOxwFPh/8TerSN/URf/KShcp1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKqMMWrdqnoZXzR1WT0bsi0L3HvZpUxxkLNhKekc0jb/DvF+5RIjPeS+NJqvk02zcj70BGMbm3mGaxZRTkySTG5IjfcCIZqofrKUb2upzwDP34ijWvoxiT85Q2PqVaBMgHKTn7eTNaN+f76JlH6RVNkurXzmVy/4QlO9nVV4gS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QyaKThSZ; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUzdI49o85inSXhA3jABIMNsF8Qxx8mwrLe9DTANCmff0xPdKG9X9ECF0iszJBW+4oGrdKQMfl0psoQcOvazfTex0Kfof4ij+U6RHiOtObckYMZHQukRDTqK7CtVWV8MNOkxvuEGgLr3+bSm/eTRgqWC536s48AGjVEoZnHOTp5kLiVHHuSPdXsTClFNDFVkOkAG5R6hDcvrmYIe6/hy9fVA0TxPNl0oZe0bWAfB4oDH3qp3RwdMkWL8XYjC4yBC+qNeHVkYCKKYH9u5ZB1VUOLop7r0ez9LPn4FdvclFxHKaMy2/YLadahTrZAHTK/EmSVWAOLFVfD6NQ6ZblbSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoCSvz1F0OEvk2FDm7s2kIbj3ThNwIHJac2FLYewc5I=;
 b=w2uOixnCdDtQn1T8rA3CRAUZGiRb0CViXff5DaSYQwjjLMJFtpmpPkh5kRoAoEOQznrMV7Qo4FP0MxkwWveYzIqmBPCm4IA4I7hwsLTMtwbDtw8R3nT3zY9/+capSm5zlZyNXxfArjiS5nkyMcG6JUibDpZJdLf6SwxpT/vI0UrU8VeXsJI+PymVpaCMFreJcB8j4jWWKr40HYyAk7HJLK1WrrQQSedfV1+nj6gfXtqFn++m7EKp5vFAnrmtIW5dCwRJyxeMWK7u83ZVrWFSKGGS/eeLkL10o4GKf7JeAVNw6ZHq9He1S9XZqCtSBHNKy9Rm0M1KWdtM5A+FpLCT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoCSvz1F0OEvk2FDm7s2kIbj3ThNwIHJac2FLYewc5I=;
 b=QyaKThSZhAJgo/WCLo/BRlowul/iuXNghfyi++QARq/oZlhTmuWpmShj6kdCN7k6ouiXDNb6OBiR+4Z2tMKkw1+RXpqCyMfaF4csVNtM348xo3PFuZEtIMjbJarpU8KGB64fIT9Tawp3I/g/BITIYL6hmOVSIIPGnEWfze8VJv97ML00CPKNqa42CLk8iGuVMuAdHM5LOEzJ8QKEMpf3p4lfg0rS5y16Dh0CAwKdB9ZsDcmGAFA69HOTYncrL5i37kwCsUHvdak9rE9iqcc0pkxzSpsbczjSKBAvYxsWrf2PkKlIyx1TvyiL4QPqzoMEoeyaNORZtW8BpIjae342iw==
Received: from SA9PR11CA0010.namprd11.prod.outlook.com (2603:10b6:806:6e::15)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 9 Oct
 2024 16:38:51 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::7a) by SA9PR11CA0010.outlook.office365.com
 (2603:10b6:806:6e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:38:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:38:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:38:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:38:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: [PATCH v3 04/11] iommufd/viommu: Add IOMMU_VIOMMU_ALLOC ioctl
Date: Wed, 9 Oct 2024 09:38:04 -0700
Message-ID: <352e1701acdec6e038ccddf02227be3a1670706e.1728491453.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491453.git.nicolinc@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 066050bf-6be1-4c5a-1ecc-08dce880db70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dxtUIHB8denvvfMILAVyr5ApZ5q5cnDDNJcGfLO24/2GZnO+am9eki0u6aVL?=
 =?us-ascii?Q?aIheVB7Ib88a6HC6gnWnGbvJnDxnZwwujj5jqSvQBQn7C9ZXcSJW0XXGnBxu?=
 =?us-ascii?Q?4CTGJ84nPVz9TfrBJ/EKtHYlmw2YMjtC+AGoeQWCOL1FLGaoOeGzeLIpdV4L?=
 =?us-ascii?Q?PBszQ0W0uPlLsbEC4srsSGMrnvjaKHIhN23ClgjJQ8dWm1LE0TBK/HHFku6O?=
 =?us-ascii?Q?R3Bmf4b7fGt5bg4epQf/bX4McYtX2kXuwJgvVF6KY8kqkUmTs3Up2Y7D5oFN?=
 =?us-ascii?Q?C+TzBBAjoKq1V0GF/8ukZTvgf+xc5XebLKVFDs5O3QBM+qy5Z2gFMCseT+LK?=
 =?us-ascii?Q?KHjR2cfmQekCPk3yBMYEDCxz/c1LBDOomIl7nWmJq5UvlupzgGPOPpiOqs+l?=
 =?us-ascii?Q?rFZohwWNemRj1WhvUTPbYMHDL40Jq/2lMu55auibdAYUHieJIWk+hvXyf3+g?=
 =?us-ascii?Q?m+glT0iJlnyIqc+2BhEB9QKdb46T9uwva2Ervty2N0OoTq4Qs/SGn3eY8CgZ?=
 =?us-ascii?Q?Iu8RvhIwSctCprzBUzlj8NXYXeJBGfHw43NbL7d1LaPPDxetdypIxCEQ8c3I?=
 =?us-ascii?Q?ygDAOMSl6TBmTR1dbE0RKTxILbKbaPTUSp65CwxPMa/v03rTQF0/eXLQWI+G?=
 =?us-ascii?Q?jCrBs/MjrZsgxGiRYqmo+0qppAGi6Jz/cwTXBYDDOMeYI9aM/AJKKGQWIFvr?=
 =?us-ascii?Q?IirfWbeuxZgpoktm64PmcuISRG1yd2Qklh7wrv++QTvtI/4gNTZBK/bNPEc5?=
 =?us-ascii?Q?4vwtT5ws1wINxZnF7NW1O5XM7jtQKGRMMBW6TFdrzQmiDysbcXo1IKK8Wx3l?=
 =?us-ascii?Q?WjmD6czS1OK+CTTFJLVc6QczlC/YLNxB++clyTT61gZ+Oej4ZU6XegSZfxZv?=
 =?us-ascii?Q?5/vSflIDqzsnDr6tbZbk9ghAq4FXRYlkaMmi3xJk3QuXiLfWSDXQQYfHX7px?=
 =?us-ascii?Q?q4rvpCh82e7LhjRa3pOjpVYFIGI2pg9geS+DHi8+RYi5d6NCV0FEF//fB+Sc?=
 =?us-ascii?Q?woCZ+Pg4e6Q62EpahMRPIOuJMJtp8Knc1KRaOwSH66dT4upVNatH9hrDTisA?=
 =?us-ascii?Q?z+9U+d0wMATWR092mnr3BUN12ffSJoGI4DcqduEzS/yPSCw/IfXihu01BQR3?=
 =?us-ascii?Q?8dJmginozYQzMaYpwwVJlCguIM4Ez8jPST4y9HKMkqyW5CPtv5WgRaoE1yvT?=
 =?us-ascii?Q?Wh4nmmuEXO6WfO9E13DaRuNvn0KkbtCy2S6IpgYpzn1d8HvGlqSlDpoGEtDa?=
 =?us-ascii?Q?avHECeG1WPtAIfX5G/l74X159aPrziJzpF/m+PVMdfgnvcULiezPyER86dQL?=
 =?us-ascii?Q?2pUWBrrxJHd0alc0bzMW2sLaWMR2gKQsrXuEDWEr8hV/28UwqWfeZfAVVOV1?=
 =?us-ascii?Q?/8LyI9emcsO35yc49zfQE1kZ3rjr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:38:51.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066050bf-6be1-4c5a-1ecc-08dce880db70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832

Add a new ioctl for user space to do a vIOMMU allocation. It must be based
on a nesting parent HWPT, so take its refcount.

As an initial version, define an IOMMU_VIOMMU_TYPE_DEFAULT type. Using it,
the object will be allocated by the iommufd core.

If an IOMMU driver supports a driver-managed vIOMMU object, it must define
its own IOMMU_VIOMMU_TYPE_ in the uAPI header and implement a viommu_alloc
op in its iommu_ops.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  3 +-
 drivers/iommu/iommufd/iommufd_private.h |  3 +
 include/uapi/linux/iommufd.h            | 40 +++++++++++
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 91 +++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 93daedd7e5c8..288ef3e895e3 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -7,7 +7,8 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
-	vfio_compat.o
+	vfio_compat.o \
+	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6a364073f699..4aefac6af23f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -521,6 +521,9 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
 }
 
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_viommu_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cd4920886ad0..db9008a4eeef 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
 };
 
 /**
@@ -852,4 +853,43 @@ struct iommu_fault_alloc {
 	__u32 out_fault_fd;
 };
 #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
+
+/**
+ * enum iommu_viommu_type - Virtual IOMMU Type
+ * @IOMMU_VIOMMU_TYPE_DEFAULT: Core-managed virtual IOMMU type
+ */
+enum iommu_viommu_type {
+	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
+};
+
+/**
+ * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
+ * @size: sizeof(struct iommu_viommu_alloc)
+ * @flags: Must be 0
+ * @type: Type of the virtual IOMMU. Must be defined in enum iommu_viommu_type
+ * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
+ * @hwpt_id: ID of a nesting parent HWPT to associate to
+ * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ *
+ * Allocate a virtual IOMMU object that represents the underlying physical
+ * IOMMU's virtualization support. The vIOMMU object is a security-isolated
+ * slice of the physical IOMMU HW that is unique to a specific VM. Operations
+ * global to the IOMMU are connected to the vIOMMU, such as:
+ * - Security namespace for guest owned ID, e.g. guest-controlled cache tags
+ * - Access to a sharable nesting parent pagetable across physical IOMMUs
+ * - Virtualization of various platforms IDs, e.g. RIDs and others
+ * - Delivery of paravirtualized invalidation
+ * - Direct assigned invalidation queues
+ * - Direct assigned interrupts
+ * - Non-affiliated event reporting
+ */
+struct iommu_viommu_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 type;
+	__u32 dev_id;
+	__u32 hwpt_id;
+	__u32 out_viommu_id;
+};
+#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 92bd075108e5..cbd0a80b2d67 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -301,6 +301,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_viommu_alloc viommu;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -352,6 +353,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
+		 struct iommu_viommu_alloc, out_viommu_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -487,6 +490,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
 	},
+	[IOMMUFD_OBJ_VIOMMU] = {
+		.destroy = iommufd_viommu_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
new file mode 100644
index 000000000000..3a903baeee6a
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include "iommufd_private.h"
+
+void iommufd_viommu_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_viommu *viommu =
+		container_of(obj, struct iommufd_viommu, obj);
+
+	if (viommu->ops && viommu->ops->free)
+		viommu->ops->free(viommu);
+	refcount_dec(&viommu->hwpt->common.obj.users);
+}
+
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	ops = dev_iommu_ops(idev->dev);
+
+	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_paging)) {
+		rc = PTR_ERR(hwpt_paging);
+		goto out_put_idev;
+	}
+
+	if (!hwpt_paging->nest_parent) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	if (cmd->type == IOMMU_VIOMMU_TYPE_DEFAULT) {
+		viommu = __iommufd_viommu_alloc(ucmd->ictx, sizeof(*viommu),
+						NULL);
+	} else {
+		if (!ops->viommu_alloc) {
+			rc = -EOPNOTSUPP;
+			goto out_put_hwpt;
+		}
+
+		viommu = ops->viommu_alloc(idev->dev->iommu->iommu_dev,
+					   hwpt_paging->common.domain,
+					   ucmd->ictx, cmd->type);
+	}
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_hwpt;
+	}
+
+	viommu->type = cmd->type;
+	viommu->ictx = ucmd->ictx;
+	viommu->hwpt = hwpt_paging;
+
+	/*
+	 * A real physical IOMMU instance would unlikely get unplugged, so the
+	 * life cycle of this iommu_dev is guaranteed to stay alive, mostly. A
+	 * pluggable IOMMU instance (if exists) is responsible for refcounting
+	 * on its own.
+	 */
+	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
+
+	refcount_inc(&viommu->hwpt->common.obj.users);
+
+	cmd->out_viommu_id = viommu->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_abort;
+	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
+	goto out_put_hwpt;
+
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &viommu->obj);
+out_put_hwpt:
+	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
-- 
2.43.0


