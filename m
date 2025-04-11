Return-Path: <linux-kselftest+bounces-30507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F07A8545F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 08:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712C84A5D03
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 06:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946827F4C8;
	Fri, 11 Apr 2025 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5ZjNQA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406027EC91;
	Fri, 11 Apr 2025 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353517; cv=fail; b=fs0UEeFkOAfQDc8HN0Mfy134lUgTflMnnawxrAduaOqaOIQYvLWiHXy98twNrc7S1dYu9aQTsOjU2PSk6g7sj1TfsuRluQj/blNMmDC7rJ/qXD6XGpx8XJ6Lzir2a5crWMhIOHl9v/gAHdRvp2VsckBaHhJbVJisaYewp10UHtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353517; c=relaxed/simple;
	bh=mkEz60uOwBQOrndgf0GsPb6ZG22hy6Erud/COc/sTMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYvh010wjBuL/d99xnSY/fUObOvBoFn4vLGaC8YCiYTQHZghPpAXlWzR/EYpCqimUPPdylfvZipJ5WvX6BDH8rleVwP0eMHXHkkOmx3fVKHQjWZ5vtygBg6CGzDaaTzCmU4oxzEp0IKbLCeFqB4yHnYrbZJoMppixk9n9t+Dffc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5ZjNQA/; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLFhvFEZ4O0KA2ZBrD3ftQ+ncqr4uaA1LlsfbLr8AsTTDKfFYzq7OIkIpyNYUaJkZWzAcr1bGXa7ulXxhm1EgL5Vjz0R7d/vJpcQ5k4x36gOSRwI4He4o+dgkVx2R1Cb9KBp6cjrouSkN17ymimxuGegKb5R+ws9twQXFbcxwwQ115IsGPrAGBbqIgJI3DIwYKkvDzDO0x8/S1jBlVo02WF4AAIejm00cBT1p68Ax8AeRHmubG62uKagEs20cdkISx8onEyv7OG776pySJrovkNSbXar8ykdZmDUm1rLMXzwzZ1r+4ad6G07ZR8y8BDvEeT8HiPh6V0PPOGdUErGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSGqmlbJd4Lw+P6Ky4JDSExa3w0cvMP1pSrcEr8Hvt8=;
 b=CPbjVqmGifUUO17D39XV8CuQyb5uJcSrolKtYOlD+aKnjVDcC4FF4zMf1c3R2zwRxIVSIw5Tx4/9sD+Vp0AMt9ioluf+MLVP2q+DJT/6gQq4IeCwtAFptCtXw3OqH3Kfmzi8NvozZhCBbLOcdZ+QymF+ONug2Cx2j1S7USy/+ImDZIYBumES8vN1u/AHqjt7kYYm4omaLUUaZztZ6lM1iihfFKx7w2Wkdeu0zoH7K2ZbLeu+vB6j46vswFVxMuOdIUNYTTeKVb0to/S81Xa0szbqQ8YcKZTb6XOBESKTlqe5+9Odr26i/r05weoQe5wXxZ2yPw3DCh/eDHP839AUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSGqmlbJd4Lw+P6Ky4JDSExa3w0cvMP1pSrcEr8Hvt8=;
 b=l5ZjNQA/dE5ugkU4rjNAnC4VM8GlDLk5Kk4baQwdBV4nyil+oa7AeU6vvlNsEzu5TTKBVdDDgj63yEp7nKwv7U5StmtuZY0+NUysQ5+z410BjKNZ31fp8398DlPgZFvWktBSgxhTwbGOE8cYmwgGf3hxzEdSi8Nl6RhRjYs1WeIBflEtpT2pAba6G5V25yZ94Y9JRFxLlS3Ws/8TWVofl/fXsTFj5ZkBMlqhTV0cj9VZ0rQm2usBWlGEDDb5wFFvK06thLp5tCxA6Hpa5rhKnl0pquiklezsDMY3FnZmRCKsLA6SxoAVqjGM7tennwn5D8PhMrSs5/wgGlf+rfsVGA==
Received: from PH7P220CA0111.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::35)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 06:38:28 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::dd) by PH7P220CA0111.outlook.office365.com
 (2603:10b6:510:32d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.22 via Frontend Transport; Fri,
 11 Apr 2025 06:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Fri, 11 Apr 2025 06:38:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 23:38:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 23:38:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 23:38:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<praan@google.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <jsnitsel@redhat.com>, <mshavit@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>
Subject: [PATCH v1 04/16] iommufd: Add iommufd_struct_destroy to revert iommufd_viommu_alloc
Date: Thu, 10 Apr 2025 23:37:43 -0700
Message-ID: <c8fec9d1107c99e8c1db6c38ed520bf4a8a1b51d.1744353300.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
References: <cover.1744353300.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 08972eeb-e180-4454-b40d-08dd78c3780a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eF/wX77UcK090grbGGTsjxfkvW8f5OKRQkfNatah07PENFDdt4K9qtfLl/Jc?=
 =?us-ascii?Q?Qk/U9E4TIKKobfRcfPj62fydSrLRIqFd5PzNCe4fRv9THlSsS0bNx2FPpfzO?=
 =?us-ascii?Q?JY2/A/9C8dVEfLjVOpWBMTtpXkqVljxh41WwkpEMo/K9OU51zHhp0pbHYn/h?=
 =?us-ascii?Q?3uRcggDDHHj4pfFxy5J/myTg3RKqI5NvDTbURBOkmkF9SGxiF7/c+YcgDmwl?=
 =?us-ascii?Q?2uTzQ2DrL0rzhANysHEnTcAJq72/wmHYGEQOzA+XxV4nnr+BLIZx0XtZ8I5A?=
 =?us-ascii?Q?IwuoaPLqYSa51B1IQpFqkHQhZHuywpAMQ9qZpYrqxFajf5Haz79HjKDw3wZY?=
 =?us-ascii?Q?rRwvukNLUJw6NVNOYjy7ZtFX8KahFuc0yWO8lNTbFXmzsYPkASJrhrtu86WX?=
 =?us-ascii?Q?0z2fC87Cw+OCTVz/b/4kZTWpYPZyhH4haK/ZdGbcJiJmR3pBM8W+EYFdlNhQ?=
 =?us-ascii?Q?eyYgMHLSBDJnzMwsotM6zyxsrDqO9sDhkBoXcKl55b6/e3Zw/BEvZwYMqg+L?=
 =?us-ascii?Q?Ol5hSTW11GJiIwt8KxJ8bEUQlae92m+iPZyxPZT6Xu3cYq/2iDjWMeywNf5F?=
 =?us-ascii?Q?mVDIG/cxeKMUNvh7u03CzQZOAo1269kIKCrWeFE5TVOkHMHpsyrkyjylw7lD?=
 =?us-ascii?Q?2SVYn+Bz+HdCVE7TQ7suiwVscjSDV6aup30C4sjcsU8IzQVYbAwMRZpKujv+?=
 =?us-ascii?Q?S7lG9NbcEUHv5X/iFk0IiEjSSRVDxFcZbd7Z15Yukh1Va1GTbA+v4fAl03Rp?=
 =?us-ascii?Q?rP2X9T42uFxMPUPMdLqW99h60BnFZuaVi5UZZ/XLrWCwcUzCMkwh4hUQ4mb8?=
 =?us-ascii?Q?4HmqnNQRWB5kEfd5ejmbzE4DO9WB+YsngG1onm4s0TQ0GvQ5++hO+f2Ny9jp?=
 =?us-ascii?Q?ZxiY27ePjuHWUtJvqjIuioIg1pJouRuSKJAsmcqSyhjd49BRMr5BrkNy22Qc?=
 =?us-ascii?Q?EMQ7Nmyo9EVlHVbIlhtIPx/SW9pU/btLZAarZzKSfvozLMMF/lKKV8l6jWSl?=
 =?us-ascii?Q?oyKLLIP8r5k/lbjLr0pOW9SIrZxjtuejo8wYVtbQbwv7hvubQh3PMSfY7ZQd?=
 =?us-ascii?Q?GkKmqC8fTCkcZqpFmSwP4vToLxfQpYPkNvb7x78uDmhRSfeb43BLzURV9dsu?=
 =?us-ascii?Q?DyyYCn8E/yW3bhtLKOMKu1RNbGE8rKoqjdt57mSJDiLgiI66h44IezB9Kmoj?=
 =?us-ascii?Q?cGsfeie2EfAWWoklsgZUwJ0RXatvfOVBwHu7ZKYw2T8LDbcYK7GQo8zjURiO?=
 =?us-ascii?Q?afZDCsafvn4p1BYbLITJ2Wy0KC2orMPcidiA7e46yZBjx/DrlnOsDBBxg/Gs?=
 =?us-ascii?Q?cuzpsxHqTeJHxWU1vBrHOaSzqOqTbUGDETvVCdgenV66VUXQ1j6pQ7aBC/rX?=
 =?us-ascii?Q?Ep/JMcBenuVO4WlI6hgrLIDMXMSHmzPGYqs0hIPc3iGMl9d88RSGYddU/4J2?=
 =?us-ascii?Q?02NI5i0oeRjFtXhPEM1TOfGmXQktdiJqv5+y2UrNiREf0JUM96Chz+5Gte2b?=
 =?us-ascii?Q?cUIMyJxJn+1WS9xxbEvmpSZIRnwrpGvjp90K?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 06:38:28.2995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08972eeb-e180-4454-b40d-08dd78c3780a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
if it encounters an internal error after the allocation. So, there needs a
destroy helper for drivers to use.

Move iommufd_object_abort() to the driver.c file and the public header, to
introduce common iommufd_struct_destroy() helper that will abort all kinds
of driver structures, not confined to iommufd_viommu but also the new ones
being added by the following patches.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 -
 include/linux/iommufd.h                 | 15 +++++++++++++++
 drivers/iommu/iommufd/driver.c          | 14 ++++++++++++++
 drivers/iommu/iommufd/main.c            | 13 -------------
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 80e8c76d25f2..51f1b3938023 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -180,7 +180,6 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
 		wake_up_interruptible_all(&ictx->destroy_wait);
 }
 
-void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 34b6e6ca4bfa..999498ddab75 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -192,6 +192,7 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -207,6 +208,11 @@ _iommufd_object_alloc(struct iommufd_ctx *ictx, size_t size,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void iommufd_object_abort(struct iommufd_ctx *ictx,
+					struct iommufd_object *obj)
+{
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
@@ -245,4 +251,13 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 			ret->member.ops = viommu_ops;                          \
 		ret;                                                           \
 	})
+
+/* Helper for IOMMU driver to destroy structures created by allocators above */
+#define iommufd_struct_destroy(ictx, drv_struct, member)                       \
+	({                                                                     \
+		static_assert(__same_type(struct iommufd_object,               \
+					  drv_struct->member.obj));            \
+		static_assert(offsetof(typeof(*drv_struct), member.obj) == 0); \
+		iommufd_object_abort(ictx, &drv_struct->member.obj);           \
+	})
 #endif
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 922cd1fe7ec2..7980a09761c2 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,6 +36,20 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, "IOMMUFD");
 
+/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
+void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
+{
+	XA_STATE(xas, &ictx->objects, obj->id);
+	void *old;
+
+	xa_lock(&ictx->objects);
+	old = xas_store(&xas, NULL);
+	xa_unlock(&ictx->objects);
+	WARN_ON(old != XA_ZERO_ENTRY);
+	kfree(obj);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_object_abort, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..2b9ee9b4a424 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -51,19 +51,6 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 	WARN_ON(old != XA_ZERO_ENTRY);
 }
 
-/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
-void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
-{
-	XA_STATE(xas, &ictx->objects, obj->id);
-	void *old;
-
-	xa_lock(&ictx->objects);
-	old = xas_store(&xas, NULL);
-	xa_unlock(&ictx->objects);
-	WARN_ON(old != XA_ZERO_ENTRY);
-	kfree(obj);
-}
-
 /*
  * Abort an object that has been fully initialized and needs destroy, but has
  * not been finalized.
-- 
2.43.0


