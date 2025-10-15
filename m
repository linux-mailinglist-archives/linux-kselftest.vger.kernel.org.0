Return-Path: <linux-kselftest+bounces-43149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13899BDBEBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 02:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB011922E41
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 00:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17FA1EB195;
	Wed, 15 Oct 2025 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H3yTmXK3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC971EFFB2;
	Wed, 15 Oct 2025 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488288; cv=fail; b=TVMhvCdpMNIfBMxAT4lAvi/CIfLBC71Mu7T/vmPEogMAgH8oJxyJR+9I2MmFtwd45K7NLZcTYQOsLnDvgXfKNk8pdQqLyaQxDLd+03yPme5Mt3+6drlu0ypCZxrWQgTxurllWXvmI1gmrYGR4TWlaNAjO3iBgMjZzxrTurgj85k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488288; c=relaxed/simple;
	bh=gBFSXaSwjX2TGU/H+MvIuZ2Ajjfi1zOghdpOd62t9bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RG/6JWDCtY7J/yyU+uFu6d47RBDZY3ho9/iG1c29OX7vrBaU3mv300/A2RoPi5B2h+eL8IDlXPIuRd2UpVM66PIhocf7ywZr4Md6ySx/xn4v5HFnfSv/El085W+iQ+ruxEQyoGXdo8QwqcPAxoFrg9Iy6fG+URNKc5tZutqCJ+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H3yTmXK3; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAbL4OS/O1Jh8kDXaoIsfCRxZBjpcNVTWXFDdGcdpaljhy+OiW1bsZrpgZvN+Zv4wQlk131Y8CnUjyvQLWW9KByHV7xHnZuTIHMXNwGBrSSNsTAbfkpZlNanzmQMlQfOZIj3VNlpEqJalxJIvBBv2OLcE9U5H/DNVF20VaXLWn9MNcsHdQnfB5Ch3EhiNzW2zl/qStYHVKuMryGm+1gEvu3nOsFwxYXYsMiV8KsKwG2pLt7my9d2o9tUE1bzuI+sfocwa5BIrWgRweMRFXIkXk46T9W0SHd6rw75Njz+nIcLBDTDiix3z3LL+cxD0S3VPna4QQFW73HqDwWz9Hzaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUWk0OoKbhD/2wjH6CAqvFv/+VugCg9RD+bCZORflNk=;
 b=mGN98o2b2pPbqFDbWLhs05LHm4+BQRZJUtrsR0HwzO/BpB1iWFTXKklrpCm45m5u84rzKuXR5ryq5szJYRN5eTJdyH74VDLAlZZYE9zkozAI/nNRwxtSVS9VHmVwCK1lmwDmTvZE5NV01AKxWf0FVJgd7gHLd5HKol33nlIZvgLCmn9DBJ73/8949EAXLxIkhVUb6kwAUDEQt1T1NDjQpomnlGrnx4oU8fgyvvCSHFJ525X5kfWnuEoXNHhJhHaeQjZeCxBYGxv/liQGSC4XqGcQBHnrUc9TUXuziXJZ4TlPN85NnLu3uw182ua8mxIifA2Y7nh9/40+Rmj6RGeJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUWk0OoKbhD/2wjH6CAqvFv/+VugCg9RD+bCZORflNk=;
 b=H3yTmXK3dAl4MqRw1Nve/ISj+TgkZBIM5zV6qWOVvTdIr8ePQBzvgXG2wvS2Bdx+4Ygc5rDnJQqJjpCn9pLikGPnPTkRdXKTsM67GdK+1BA/TxUGbU05bwS0wdESBpErefGgnQ3YDnbzIr0PrZZv2sCzuzr8iRTcFaoEnCOx8m8ebrYYF6qkyb7FRJ1AIAamJzegyUq+4mzt5sG5xyqLaKzcVHJrDPGVMy47xHWG2+GuVMb3ya1j4b7Mcv+OITHu4bXVjLEP33p/ROmyb1HDvwtht6Hxx8EEsYQunS0Ta+KCSFguDMc55h/hFI/3dqPU4tmx+MbfA/bAituDySVyaA==
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 00:31:20 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::19) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 00:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 00:31:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 17:31:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 17:31:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 17:31:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: [PATCH v2 4/7] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
Date: Tue, 14 Oct 2025 17:29:36 -0700
Message-ID: <6c36de14b00a3f06df3a602f18baf6b51fde429f.1760487869.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760487869.git.nicolinc@nvidia.com>
References: <cover.1760487869.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b98286-5828-4f13-04b5-08de0b8229a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9cn5mOpaVteQ8IepdGnS9qN+Mpl+JHsS2MsCTfJw8lrHiWmBPF/uW4Rfy9Cj?=
 =?us-ascii?Q?tsElBFY97Q6QINGm2DYSRTFkX7KOnLLkg6j32IHdLfP188ocQiBtgASC3pUN?=
 =?us-ascii?Q?WlhIHipQm28y3Rkqt6nkzyVEmXYt7psl2C/SnkGlyfAKYbxv/K9r228GklFN?=
 =?us-ascii?Q?4D9CFagU+rD9UW3sGx70UPEHWv0tAHzB4dYEFeE4BAnV22RpnKF7QExwoYZD?=
 =?us-ascii?Q?YwIYQ73rAKeveiPRqXI1uaHveRY4eEnQn4nyW5WUtbok5MKSnU7t75LgN6Iw?=
 =?us-ascii?Q?cMag+ZmH7Dd1IEbsBuuzNQ39NSkyeeGCXmCn1RyV8XcXr6g6czyhf/5l7JZM?=
 =?us-ascii?Q?xJGBvCS8aWrVQ/74JmYLLEVrCUsDWh0+E9OijPqmG6pbLZ8YS6Ih6jJwKbNm?=
 =?us-ascii?Q?uf+q3BOerDAi3AGz4QDDq8zpwQyAdrMIA8NVAbRK+WV1m9kOEgUk4Xlt3Ylv?=
 =?us-ascii?Q?NkBuW1Slf9ew/YYbfrwq2Okf766rIdgcRzyTrRro4SPPz+OC46MRYXALi4UP?=
 =?us-ascii?Q?7g0xasymHUmErJ84m2WmLkZ8DBqITZu4ncpUiDHTyTfkPQ0gZ0MtSLIBSHSl?=
 =?us-ascii?Q?kP8IAU/amIli6Lyos5faKCWi5VPBMWxWAzGMslTeC3NNcbRNvIMw50noIm34?=
 =?us-ascii?Q?N4nfLxfskBny6LgfC65idj2mi1guCFhs/hBPMZ6jYIZ1MhAWLIs3H7ZWXJeO?=
 =?us-ascii?Q?694Cjhg0MLqESjD+LmqguJcDvu8YayUV3Ugw07ecQGvTB8J8FshP4hUlQIH7?=
 =?us-ascii?Q?TPp3nMCsXzlQ1RlxQVwbdb38W+wL3Emh/LiWdnCGDfyQe8Yc7DNOZTFSkblk?=
 =?us-ascii?Q?Zw5lD3fwQ3EfSaCNpJEuuRSGEU61MkBuY+l2C/Da0xwx0zVYDzuYoBGNuMYk?=
 =?us-ascii?Q?CqUFjlX0UbnLuzNPifPCI6fLFgjBEjJUWJXwsBG2BODiWfoPKR3jN8Jgg391?=
 =?us-ascii?Q?5hujlMCzuZ2h1qKzWPYa4+pHhKoKjlc6HZ2A4KEKGSxospLV4Ypg1QSX/Q51?=
 =?us-ascii?Q?35d5baudyX7obBHkmV1ogMB2OGdD5rSGy+Zennt23qB2SiGBIhY25fjRsqe4?=
 =?us-ascii?Q?8AnoGHs7lkgK2DWXLEjYB3SJ2Sm4Nu6UPzlNREMwX3/gGi+C4L5ODCzrsPTr?=
 =?us-ascii?Q?SoWODcvBYhq4wzSKEFgFt4Ez5sHo3tONic+10dPUZRh74xWYoChXCvtLyKFC?=
 =?us-ascii?Q?gO2dGG3UNFoyo96HMaY6Sp8nTgfjqP1JDud4GmyDTph4hMXmGCIb23kOU39y?=
 =?us-ascii?Q?EnF3Z33hjr1vNEBC4Io0oeNNlVu7DzFk6RXpBWtb/SMVwSSr5G9rFny/p56V?=
 =?us-ascii?Q?Idy0Tl3LVtLLauPHAL9NIc8EXWkC0K4CIRsbOeXLcQABZjyV/JDM0QBfOkO7?=
 =?us-ascii?Q?KpUE7uHNxD8zYkDYglz2lETqs8jTkHpYM1XDzCarT847eSkmy7m+f+g4FUwY?=
 =?us-ascii?Q?34oHyNXHJsFMTz/6wfElXuKRoCmSZT8nxPcocLnDMEL2jPOdd9DDW/IcmwIh?=
 =?us-ascii?Q?zMY0Hg/8tOXXm35s10ODhnX+U1H0KLzoXrHOFPdLGQ0E7KtoqKsM04AhbbZ4?=
 =?us-ascii?Q?Q/cZ51zuK4dyx5VvR6M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 00:31:20.4919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b98286-5828-4f13-04b5-08de0b8229a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

For systems that require MSI pages to be mapped into the IOMMU translation
the IOMMU driver provides an IOMMU_RESV_SW_MSI range, which is the default
recommended IOVA window to place these mappings. However, there is nothing
special about this address. And to support the RMR trick in VMM for nested
translation, the VMM needs to know what sw_msi window the kernel is using.

Moreover, there are cases that the default IOMMU_RESV_SW_MSI region cannot
be reserved as some platforms reserve this address for other purposes:
https://lore.kernel.org/all/20250909154600.910110-1-shyamsaini@linux.microsoft.com/

Provide a simple IOMMU_OPTION_SW_MSI_START/SIZE ioctl that the VMM can use
to directly specify its desired sw_msi window, which replaces and disables
the default IOMMU_RESV_SW_MSI from the driver, to avoid having to build an
API to discover the default IOMMU_RESV_SW_MSI.

Since iommufd now has its own sw_msi function, this is easy to implement.

Keep these two options per iommufd_device, so each device can set its own
desired MSI window. VMM must set the values before attaching the device to
any HWPT/IOAS to have an effect.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 include/uapi/linux/iommufd.h            |  21 ++++-
 drivers/iommu/iommufd/io_pagetable.c    |  15 +++-
 drivers/iommu/iommufd/ioas.c            | 113 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   4 +
 5 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c458ab16736b6..1defd416813c8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -346,6 +346,7 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
+int iommufd_option_sw_msi(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
 
@@ -490,6 +491,7 @@ struct iommufd_device {
 	struct iommufd_vdevice *vdev;
 	bool destroying;
 	phys_addr_t sw_msi_start;
+	size_t sw_msi_size;
 };
 
 static inline struct iommufd_device *
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2eb..5e5277f77a97b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -296,7 +296,9 @@ struct iommu_ioas_unmap {
 
 /**
  * enum iommufd_option - ioctl(IOMMU_OPTION_RLIMIT_MODE) and
- *                       ioctl(IOMMU_OPTION_HUGE_PAGES)
+ *                       ioctl(IOMMU_OPTION_HUGE_PAGES) and
+ *                       ioctl(IOMMU_OPTION_SW_MSI_START) and
+ *                       ioctl(IOMMU_OPTION_SW_MSI_SIZE)
  * @IOMMU_OPTION_RLIMIT_MODE:
  *    Change how RLIMIT_MEMLOCK accounting works. The caller must have privilege
  *    to invoke this. Value 0 (default) is user based accounting, 1 uses process
@@ -306,10 +308,27 @@ struct iommu_ioas_unmap {
  *    iommu mappings. Value 0 disables combining, everything is mapped to
  *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOAS
  *    option, the object_id must be the IOAS ID.
+ * @IOMMU_OPTION_SW_MSI_START:
+ *    Change the base address of the IOMMU mapping region for MSI doorbell(s).
+ *    This option being unset or @IOMMU_OPTION_SW_MSI_SIZE being value 0 tells
+ *    the kernel to pick its default MSI doorbell window, ignoring these two
+ *    options. To set this option, userspace must do before attaching a device
+ *    to an IOAS/HWPT. Otherwise, kernel will return error (-EBUSY). An address
+ *    must be 1MB aligned. This option is per-device, the object_id must be the
+ *    device ID.
+ * @IOMMU_OPTION_SW_MSI_SIZE:
+ *    Change the size (in MB) of the IOMMU mapping region for MSI doorbell(s).
+ *    The minimum value is 1 MB. A value 0 (default) tells the kernel to ignore
+ *    the base address value set to @IOMMU_OPTION_SW_MSI_START, and to pick its
+ *    default MSI doorbell window. Same requirements are applied to this option
+ *    too, so check @IOMMU_OPTION_SW_MSI_START for details. User space must set
+ *    IOMMU_OPTION_SW_MSI_START first before setting IOMMU_OPTION_SW_MSI_SIZE.
  */
 enum iommufd_option {
 	IOMMU_OPTION_RLIMIT_MODE = 0,
 	IOMMU_OPTION_HUGE_PAGES = 1,
+	IOMMU_OPTION_SW_MSI_START = 2,
+	IOMMU_OPTION_SW_MSI_SIZE = 3,
 };
 
 /**
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index dee0aa3e7cb4a..7a1016d6dcfe0 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1458,18 +1458,27 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	iommu_get_resv_regions(dev, &resv_regions);
 
 	list_for_each_entry(resv, &resv_regions, list) {
+		unsigned long start = PHYS_ADDR_MAX, last = 0;
+
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
 		if (sw_msi_start && resv->type == IOMMU_RESV_MSI)
 			num_hw_msi++;
 		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI) {
-			*sw_msi_start = resv->start;
+			if (idev->sw_msi_size) {
+				start = *sw_msi_start;
+				last = idev->sw_msi_size - 1 + start;
+			}
 			num_sw_msi++;
 		}
 
-		rc = iopt_reserve_iova(iopt, resv->start,
-				       resv->length - 1 + resv->start, dev);
+		if (start == PHYS_ADDR_MAX) {
+			start = resv->start;
+			last = resv->length - 1 + start;
+		}
+
+		rc = iopt_reserve_iova(iopt, start, last, dev);
 		if (rc)
 			goto out_reserved;
 	}
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a85..f2a4ab98f1665 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -620,6 +620,119 @@ int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 	return -EOPNOTSUPP;
 }
 
+static inline int iommufd_option_sw_msi_test(struct iommufd_device *idev,
+					     phys_addr_t start, size_t size)
+{
+	const phys_addr_t alignment = SZ_1M - 1;
+	struct iommu_resv_region *resv;
+	LIST_HEAD(resv_regions);
+	phys_addr_t last;
+	int rc = 0;
+
+	if (start & alignment || size & alignment)
+		return -EINVAL;
+
+	size = max_t(size_t, size, SZ_1M);
+
+	if (check_add_overflow(start, size - 1, &last))
+		return -EOVERFLOW;
+
+	/* Test if the new sw_msi range overlaps with other reserved regions */
+	iommu_get_resv_regions(idev->dev, &resv_regions);
+	list_for_each_entry(resv, &resv_regions, list) {
+		phys_addr_t resv_last = resv->length - 1 + resv->start;
+
+		/* start/size replaces the driver-defined IOMMU_RESV_SW_MSI */
+		if (resv->type == IOMMU_RESV_SW_MSI)
+			continue;
+		/* IOMMU_RESV_DIRECT_RELAXABLE does not get enforced to iopt */
+		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
+			continue;
+
+		if (resv->start <= last && resv_last >= start) {
+			rc = -EADDRINUSE;
+			break;
+		}
+	}
+	iommu_put_resv_regions(idev->dev, &resv_regions);
+	return rc;
+}
+
+int iommufd_option_sw_msi(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_option *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, cmd->object_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&idev->igroup->lock);
+
+	/* Device cannot enforce the sw_msi window if already attached */
+	if (iommufd_device_is_attached(idev, IOMMU_NO_PASID)) {
+		rc = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (cmd->op == IOMMU_OPTION_OP_GET) {
+		switch (cmd->option_id) {
+		case IOMMU_OPTION_SW_MSI_START:
+			cmd->val64 = (u64)idev->sw_msi_start;
+			break;
+		case IOMMU_OPTION_SW_MSI_SIZE:
+			cmd->val64 = (u64)idev->sw_msi_size / SZ_1M;
+			break;
+		default:
+			rc = -EOPNOTSUPP;
+			break;
+		}
+	}
+
+	if (cmd->op == IOMMU_OPTION_OP_SET) {
+		phys_addr_t start = idev->sw_msi_start;
+		size_t size = idev->sw_msi_size;
+
+		switch (cmd->option_id) {
+		case IOMMU_OPTION_SW_MSI_START:
+			if (cmd->val64 > PHYS_ADDR_MAX) {
+				rc = -EINVAL;
+				break;
+			}
+			start = (phys_addr_t)cmd->val64;
+			rc = iommufd_option_sw_msi_test(idev, start, size);
+			if (rc)
+				break;
+			idev->sw_msi_start = start;
+			break;
+		case IOMMU_OPTION_SW_MSI_SIZE:
+			/* The input unit is MB */
+			if (cmd->val64 > SIZE_MAX >> 20) {
+				rc = -EINVAL;
+				break;
+			}
+			size = (size_t)cmd->val64 * SZ_1M;
+			if (size) {
+				rc = iommufd_option_sw_msi_test(idev, start,
+								size);
+				if (rc)
+					break;
+			}
+			idev->sw_msi_size = size;
+			break;
+		default:
+			rc = -EOPNOTSUPP;
+			break;
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
+
 static int iommufd_ioas_option_huge_pages(struct iommu_option *cmd,
 					  struct iommufd_ioas *ioas)
 {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ce775fbbae94e..9a8ab58d694d4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -398,6 +398,10 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 	case IOMMU_OPTION_RLIMIT_MODE:
 		rc = iommufd_option_rlimit_mode(cmd, ucmd->ictx);
 		break;
+	case IOMMU_OPTION_SW_MSI_START:
+	case IOMMU_OPTION_SW_MSI_SIZE:
+		rc = iommufd_option_sw_msi(ucmd);
+		break;
 	case IOMMU_OPTION_HUGE_PAGES:
 		rc = iommufd_ioas_option(ucmd);
 		break;
-- 
2.43.0


