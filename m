Return-Path: <linux-kselftest+bounces-19376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD3997202
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0881C21437
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C11E3775;
	Wed,  9 Oct 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="um+lzf/U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14C1E22FD;
	Wed,  9 Oct 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491958; cv=fail; b=kKTQOw/kynmJDivPahm57u4TxpfF3wmAc+LxQpzVWcTC8wXH/TjQ6nYBYA+Iv6u7urZTvHBR1pVg2d9nSGPyBMunlRKpnxU6LwCDN/S7f85QQJH4KhFFZabxppUI6xGrrStFG3LplP5bqMLLKWWLgs2Jb8q1oYsK4+Q2u+JKW24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491958; c=relaxed/simple;
	bh=xVYfJxBFyiNh8Wka86WH4L9dhL4I2IbxbITgap245Q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+nJ1EmcVYksRecav1+AN4VZOv1w51Sf7InBWiONAbjhhy3tOr6bN87QLVu3KqnhIdpaTJJ5fPS4pyJkdSUlU0ZPRERYdnFaHncnwDqv8EOW6WUXkXMLC7ZeYOHoGKr2VpwGh7z5vy058v2/uZNzxT5T1iFKFIqRbtqg7yzJ70w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=um+lzf/U; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs4wqi3CiNENU8uDSHLvRSwsz086XfivDg0nxPR3VYYTiyc9+4DYqyLAw51KglEKtwzNsNc4bUYOpl+HL47Hm0n3ksoR6FP9qanE8OWs2YDWsxatZHsaJuBM5BPcM8j5EfmTnhZIg34EL8gk2N3Fm0Pr/q6l9M/UVZTe1abfvONRfF64BxS8x1ttpA7YwUgtJU+v7HpwvEq90tQs56ktuUoeQA4eBwi8a9NX6mcDjUP49ZUJy4xhy7kVomBh1IVys6c0C5aMbSwxxzhnY6c0XdH5edb6+UrAKz7+6RTqSODoXkXjU1aO/kLoP2PlRCOfyP5syqfO9c9UDuze+VFoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWiiUBD/BDJcXPbCGKX09n29ZrUurzfWk4q0mppQ5WE=;
 b=jaSNM8Cp1kdQg/StKL8V5UD4PeJxNKzEDtrv6WeQEyoVqMkmZk8b+nOr6rSIV+o+zq8AMluWowu31rYYJWAw6Cg1L6xDolMbxKbizCK4lyWt8H7dS3S+HVWChq3YuBgt1iYbh94vfgfIKYVDT8y0JVB/8R3MJiZ4AE+YTyqUpLsk/l/Lvia6ooHM+d57eKPY/DKT4e8SaA28ICXyxdilxJ+pnDtWWBuW4nbSFAkm4RLOT/H1EX1rB9pAddp7FVZSZhAM1k2DEsdFWsGTMBnFNknFpUpFIarOpnlUkfUqcJUGhydbEpAy5ryuRnG+g14dnOdDv9nCvGMC5tHC2UxC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWiiUBD/BDJcXPbCGKX09n29ZrUurzfWk4q0mppQ5WE=;
 b=um+lzf/UrjeYsz3unV4AtoE+VCmCc028pTbioFOfqafe8VX5N0lWATNn26OhA+Ta6Re9mx+nUPPYuCUHYcQLkFy+RhsOz+6T9Qrgxs/1/ylFtR5/v7k4u6Hs99ctjyK2hTNu80OJZWooZNxCHtFiaFfZIIDbVFtoaqGOOexmkZff0OrJOU+m54NVscBOhikP3kQZsh8buNWQTj1V36sn6Ox8kJM2Kuk0O6dq5OMU+MPKFD2XStSUezzjtznYMRe//veCqu8zHql+q3HhMrG+W8Tbb9YhSB4J7gsKAfmVuWHinFq+9E3p/WD4+taTCnaQyPSPlGYwejxEoobaKaRaag==
Received: from SN6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:805:66::32)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 16:39:12 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::a2) by SN6PR08CA0019.outlook.office365.com
 (2603:10b6:805:66::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 16:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 16:39:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 09:39:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Oct 2024 09:39:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Oct 2024 09:39:01 -0700
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
Subject: [PATCH v3 05/16] iommu/viommu: Add cache_invalidate for IOMMU_VIOMMU_TYPE_DEFAULT
Date: Wed, 9 Oct 2024 09:38:17 -0700
Message-ID: <2b57c2f0721237488d194fb00f9d044d60e3038c.1728491532.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ae3f3a-62d2-415d-d25a-08dce880e7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O400zNWdGDdrnWTdmwPosu7MwkP9abKytAKJ6yGrUWP0PjxEimpNhNPhnQfH?=
 =?us-ascii?Q?47yNEMGoDTPp5ENhYhZVr9EyVOqUjliu0TXcBJaCLIlIxvG/nqQjl+BkU9Gw?=
 =?us-ascii?Q?M8+SdJJKvKeF+puYMId/6+z4OIMR0nWA4Q+YOu0WrmUjjZrLgexJwFMYEnyM?=
 =?us-ascii?Q?K+Tr/rdG8CBqAGuKjOm/+lMWlaYknDvslJ6dXAoViA3Y13uSdTJLn4NwHevA?=
 =?us-ascii?Q?x2rR4sa+FBRUMUR43w4BbMksjGCBG1fgE+cvOwspVM4dIu07rjU0ILsmcBmP?=
 =?us-ascii?Q?MeT6idzVbhb5RD/L6h7uquKS6PJTSgBBRfTyaOVAQh3tjebsPhoTdcEsGSHV?=
 =?us-ascii?Q?ozuhj7DtvOUbNLBV+NN1xsJ57zV1uac9KM6VLxlQURChunhnpJyPM7PxSQ46?=
 =?us-ascii?Q?Zbt3ceztqc8Wbl6YnhCwD/S4LkMWohIixbCeYf/sxmSWDRTj14g3JuMVkTDd?=
 =?us-ascii?Q?CNM0/W8Qo/XPMd3gt39ga3W8rZyshDRuu/OzTjeWvqaHMAmMZcbYofrSwrV+?=
 =?us-ascii?Q?64f+cXAJPO0kYR+VN5oovXytBSDapM510ZNvbS4yVYl9xLhHsM8rXf5Ke0Uz?=
 =?us-ascii?Q?mEG8kmUXt80ecenDGbumbzGrpnyIPswmBS/z8FwRvNj+aHj6zqXlsoMk8/2d?=
 =?us-ascii?Q?4HCAGpW3Kp+ZQAk/BMkCEVYdOCQpjgyjjlcdgRDR7UYT2Y8F2TUggYagUWb0?=
 =?us-ascii?Q?4FfyoNpS1MbtkhkMla6g8xQ527wQJqJaIphmtj5vI5uFjp/IevneScf7YlBk?=
 =?us-ascii?Q?YlGZRiWIztqNQqoP4l1cTgxTSrjGsGfhfWOMgHtj1T4qhEfgQx47cDgjHWIu?=
 =?us-ascii?Q?21gbbKPwXViFVmq657Ryd+omhBfd1V9BuTwlxz5EzEDK2m8/25Z1Wf8Hfofe?=
 =?us-ascii?Q?btYSWOPCV3XKOyRS71gQ7sYe9yLGVvucCNnankIZKqPEQ0nbkXkzVLgueHo0?=
 =?us-ascii?Q?oBtdN1U9BIBY2pJPlCiXg2C3y1VBk9ICkHDj9GEQjeXoJ8b9Hme+NGTFX4GG?=
 =?us-ascii?Q?FNGPkld/eFkzVFf+Xs39xkmkWwk1cxcFI2FzIVeVjWThfjC/j8FQU9oKwsHE?=
 =?us-ascii?Q?yMJimoS/lYQ+nJw6jLWN+BTTxXDctSi1TFC0s6NphWiT1t092NoR3xLxzYuh?=
 =?us-ascii?Q?aMSnTQJYE1HHfP8OT7BL/Fn4ELL8klX+YBXouFkPvxGgvcPecMO/ludBuqOa?=
 =?us-ascii?Q?ysL3t/Ix7bAFT2m56Ryx2c4kBm5ptKa6AWbpC9b+kF3TYJEs6DZQHReA0r7o?=
 =?us-ascii?Q?lu8/CFFOOzHYuZ9WD/6bxI9VHxDc9dfOIYSzjGHjLcz1iBnXP7c4bR0fulMd?=
 =?us-ascii?Q?+DoIphT7RCMq05MoJ+ESeppcRy90OdiIigFZ4oeGqFHZxYZglqkfN6m1E6xq?=
 =?us-ascii?Q?iOm+gWw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:39:12.1434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ae3f3a-62d2-415d-d25a-08dce880e7d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

This per-vIOMMU cache_invalidate op is like the cache_invalidate_user op
in struct iommu_domain_ops, but wider, supporting device cache (e.g. PCI
ATC invaldiations).

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5a630952150d..e58b3e43aa7b 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -14,6 +14,7 @@
 struct device;
 struct file;
 struct iommu_group;
+struct iommu_user_data_array;
 struct iommufd_access;
 struct iommufd_ctx;
 struct iommufd_device;
@@ -95,12 +96,21 @@ struct iommufd_vdevice {
  * @vdevice_free: Free a driver-managed iommufd_vdevice to de-init its structure
  *                or HW procedure. The memory of the vdevice will be free-ed by
  *                iommufd core.
+ * @cache_invalidate: Flush hardware cache used by a vIOMMU. It can be used for
+ *                    any IOMMU hardware specific cache: TLB and device cache.
+ *                    The @array passes in the cache invalidation requests, in
+ *                    form of a driver data structure. A driver must update the
+ *                    array->entry_num to report the number of handled requests.
+ *                    The data structure of the array entry must be defined in
+ *                    include/uapi/linux/iommufd.h
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
 	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
 						 struct device *dev, u64 id);
 	void (*vdevice_free)(struct iommufd_vdevice *vdev);
+	int (*cache_invalidate)(struct iommufd_viommu *viommu,
+				struct iommu_user_data_array *array);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


