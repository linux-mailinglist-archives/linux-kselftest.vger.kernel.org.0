Return-Path: <linux-kselftest+bounces-24289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0E5A0A08E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 04:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F553AB039
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 03:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A9A190661;
	Sat, 11 Jan 2025 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W+znC1e8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC51531F2;
	Sat, 11 Jan 2025 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566398; cv=fail; b=eRh/0BunwCDyl9+BYBj7dyQR9aWqxN1wZsvbWjZbLgUmWfa+s7ZthyE7j5L4qOHANygqHATAj9dHLyRNKE5tFL3kWd00jg3XFiLedy29DiTLiob0NVhH9GVTNgObciQk6KzuLwL7DpGagpEcbify12pnf5Yk5Z8YWcNgXAqvXHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566398; c=relaxed/simple;
	bh=RhqBfAHp62bduqvtEu5jJHX1oyI6yX+OuB+XhakHzqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbLOybZtVYmc5fw18hRX7TK5AJsf9+JOccm+JQm0N0tZbyAuAvmXVntywDhMwVG66dj82GuYx8cEDf9/qD6/CUX5riDxP6GptDL/saKjq1/vfMewWy2qxYRCqcGFZruqLqz9XCCZVt58a6B5N88Dd/7aoCme5Dk2/DSmVfBnmu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W+znC1e8; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nold8xqKqKm56O+3TZaFBFpNFsl5ydyNVVSTBaa8hYCYk9bHZDpVK6g2wDMRxNQq5IalDaafSzw5EaKmjBkq3SOdk7gBMKlMeyUNM2iNbR9PnEfihOwGFMflqeNuuX5+OE/tzuurE4RaFOnKhbO+EjMLK5F2Z2KlEcAMzRbNjaRtISJDQjugUeU8bGpkYZ/vASA6grFWwIfxOEUAcAepSyolbiLy3ERAry8y6MkU8lAYfXdsCNHhg69Tl4lk40cAi/3sUbfKu28LCwfIaKpCZpHKupimWvDH3rQre+/T+OWtU6C7NUksyqTgmqqb1riEZbr4S5NOcJosQusUgYjdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUm2xaJt7P67h3vpPA34jvc7F9iZJz0qV32MiUYgaX8=;
 b=kD20WfaG3ZJ4b2KCq9s4cdbAvAaJ/0fEYG8KEwhPuyp4XmKNThqD2psMRlDT/GYWJAq7gutKFXabnNBg5/Xch4mEUjHgKpn67Fy0g+qXWzAb/mipcRq+bavAEmr9APxjfoSEL+dxkafWtmTSXmyVRr3XZz+5cowBcIFtV94jCwrIturfsuaaJUYNzJj85SrIZ6mUDXO/PP5W7rZCYMzNzKKWhrI7B/n2wCvK12W9HSoBRKzF/1CDK6ZcNOBpKHwNnFPf2GCuOXi3/awFZNqR0lB7vAV4PmnIiaBFcKHBa6L0DnhbKeYPToDFGTHiEl65APYCZr5tKPG0bxGUe5V2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUm2xaJt7P67h3vpPA34jvc7F9iZJz0qV32MiUYgaX8=;
 b=W+znC1e8cD/o9SAuzsjmVD0LSQwAPcfxDdurMHkxYsfg1R8de7q/T45IhwdexaAgllbiM55C+U7ARONcs4B8ozar0NoQvPbf7oNsMTxAXXMhX5AOCvQ5WmvLcNi4Oe7KGH4tzZmp2jbdTUDHXKCbMfIZuEt7df8ipjlD/MtaeewwPn2Ztny1usSLHQyJydieA+X8dFGuhVmMz4loTIcpwP19GHdzg8OmzxF3l+Q/mCb1/LhLCqgMF3Ughn+tGvSKfmvHDI1di1wk1/CvP4JUcRc0eRFA30TG1QYdW2+DuydQapp/Lr+6B2CzTURXTs71w6Wd/SquC9Au4EMavy8vPw==
Received: from DM5PR08CA0059.namprd08.prod.outlook.com (2603:10b6:4:60::48) by
 LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 03:33:11 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::38) by DM5PR08CA0059.outlook.office365.com
 (2603:10b6:4:60::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Sat,
 11 Jan 2025 03:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Sat, 11 Jan 2025 03:33:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 19:33:04 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 19:33:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 19:33:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>
CC: <joro@8bytes.org>, <shuah@kernel.org>, <reinette.chatre@intel.com>,
	<eric.auger@redhat.com>, <yebin10@huawei.com>, <apatel@ventanamicro.com>,
	<shivamurthy.shastri@linutronix.de>, <bhelgaas@google.com>,
	<anna-maria@linutronix.de>, <yury.norov@gmail.com>, <nipun.gupta@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>
Subject: [PATCH RFCv2 07/13] iommufd: Implement sw_msi support natively
Date: Fri, 10 Jan 2025 19:32:23 -0800
Message-ID: <f70451cf4274bc5955824efe9f98ec7dfdd10927.1736550979.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 836a5e78-35e7-4bba-aa83-08dd31f0ac95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fPr24sJsoF/xe4R+rQJ7JoNJpCKxl3kWShHz97nZYyN/rYFKTU4DG+2fEc9i?=
 =?us-ascii?Q?W1Ymw79Qq9ZH4dZW1oRkrMVVeVE3KoQgIR6txvT6KkhQDzEghyp+XYmKAXsf?=
 =?us-ascii?Q?dQRE39RJURsYQEGyedircDCk/QSSL/efuST4uYZCIjatJbwIOnveXwv8Sm9P?=
 =?us-ascii?Q?70U/DPLx0cC2F1vs46LhGOaCI1IUheQLFqY2fsS0ObWMZD+EUY/A5/1isYbf?=
 =?us-ascii?Q?PT9kmdEvfz/5uma3WDMJwwKQh+az/b71F1VgdyfdqmdMGUyLGHr/637xip6C?=
 =?us-ascii?Q?ptAGL0GOf56O6estodHkeUpB54JGbBo/wHw0Zhlw1xzY+2gp2uT5u2w/5mYr?=
 =?us-ascii?Q?H258W6T/QfyU2cTJpr5IuefRvTg84TqEPCx3A4FHNVOEKseSVuBcOsArhx0j?=
 =?us-ascii?Q?FCjoQNdXmSFtOU7FWtzD9Chnb42zjn8FKb/7NFYof26m6A2syDXr5946qrko?=
 =?us-ascii?Q?CvYqqtGD4sDQVdH/7xfPvr9RauK+o8hQrJ2DS7uydIabLgsYRZAHSgvvh+w9?=
 =?us-ascii?Q?8GkruVsHXn/8NsJ/byJNGlEJq/YhHViEg4UApfucAvtcN3L18WVb5K+irHuH?=
 =?us-ascii?Q?Pkw+VTXQiCc06/ejXviUpw76PAOrGDaYZF61OX4mGDURnGkCGDbEcO52julU?=
 =?us-ascii?Q?Vjptq4xOD8pHR5O6IZLohoDTK+7zUg+E9dNh/c2CKpwdwY6jWxqjSSE6Jgge?=
 =?us-ascii?Q?qH1TOyihotbLFrYaWLuTcOYUzlR/E61qow3y75LYxj7cy2HsVAE4BZHGnmsw?=
 =?us-ascii?Q?2jNrNHBKhf7PSMLtupAY82V45fAo8Q/T8Nw012X6eSzzc5lW9cpHSyIHYEWP?=
 =?us-ascii?Q?bmuqkgKS89nHY3tTdTTIyKMkgAMw5/KGYzRqbEeoRGGWv2mhv4dfEhOAmQu3?=
 =?us-ascii?Q?e1hMSD3cztMt4sZmdLT2sokNdTKBFS6QS6VMEn7h5w0r568M/Nac1RYOpFjq?=
 =?us-ascii?Q?MrAuGmA7xFObg6gksHSn8ctBKgxxUT+1rXOhhFt9UrJyBU83x6whEZuIDukK?=
 =?us-ascii?Q?QnjeOZiz2YBDWZXcuX+CBK5DE85EFiyB3sfygUtEd1CrN93lcavjY4jt0A98?=
 =?us-ascii?Q?nL8mJA+yE7cSCFOlg8ublEoSQg/m9aAROiy67ZUcZburrwyQtIUH1OmWNOe2?=
 =?us-ascii?Q?dBYtiRzjTdTuy3fGVW93o6UywFxQSmwY72oz8jK9vmaE/iCcKo+27B6Bp5IP?=
 =?us-ascii?Q?oYNlRfbgw90iQ2KTRA9n2PGr+KKacwK71WTD7erK+U7twEt++oJCIX9NxnpU?=
 =?us-ascii?Q?aiVwM5bpSxjSSdP/DpQmdVcaPh9ZStOOeN53C4fIyNfoj/heoHOzwil2M7OS?=
 =?us-ascii?Q?wlJjksAuH3Xk+8H3GMSlQsk78y3fh4Z4oH23uoiNl4FltJnfj7HVazQTwhkD?=
 =?us-ascii?Q?YHzOC/lNZf4urGzJ2sB1WUvDCL6FbT08Dlxp1Kn3p/LWjtgvLNp8LZzUOvcV?=
 =?us-ascii?Q?hq26JhgW99ste07/W5IkTYhizwcFzH0LKKyQMD6y0K8sXf4We3y15lOhI2zj?=
 =?us-ascii?Q?hAMB5CyT1u0X1PI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:33:11.2786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836a5e78-35e7-4bba-aa83-08dd31f0ac95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

From: Jason Gunthorpe <jgg@nvidia.com>

iommufd has a model where the iommu_domain can be changed while the VFIO
device is attached. In this case the MSI should continue to work. This
corner case has not worked because the dma-iommu implementation of sw_msi
is tied to a single domain.

Implement the sw_msi mapping directly and use a global per-fd table to
associate assigned iova to the MSI pages. This allows the MSI pages to
loaded into a domain before it is attached ensuring that MSI is not
disrupted.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[nicolinc: set sw_msi pointer in nested hwpt allocators]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  23 +++-
 drivers/iommu/iommufd/device.c          | 158 ++++++++++++++++++++----
 drivers/iommu/iommufd/hw_pagetable.c    |   3 +
 drivers/iommu/iommufd/main.c            |   9 ++
 4 files changed, 170 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 063c0a42f54f..3e83bbb5912c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,22 @@ struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
 
+struct iommufd_sw_msi_map {
+	struct list_head sw_msi_item;
+	phys_addr_t sw_msi_start;
+	phys_addr_t msi_addr;
+	unsigned int pgoff;
+	unsigned int id;
+};
+
+/* Bitmap of struct iommufd_sw_msi_map::id */
+struct iommufd_sw_msi_maps {
+	DECLARE_BITMAP(bitmap, 64);
+};
+
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr);
+
 struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
@@ -26,6 +42,10 @@ struct iommufd_ctx {
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
 
+	struct mutex sw_msi_lock;
+	struct list_head sw_msi_list;
+	unsigned int sw_msi_id;
+
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
 	u8 no_iommu_mode;
@@ -283,10 +303,10 @@ struct iommufd_hwpt_paging {
 	struct iommufd_ioas *ioas;
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
-	bool msi_cookie : 1;
 	bool nest_parent : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
+	struct iommufd_sw_msi_maps present_sw_msi;
 };
 
 struct iommufd_hwpt_nested {
@@ -383,6 +403,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	struct list_head device_list;
+	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
 };
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 38b31b652147..f75b3c23cd41 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -5,6 +5,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/msi.h>
 
 #include "../iommu-priv.h"
 #include "io_pagetable.h"
@@ -293,36 +294,149 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
+/*
+ * Get a iommufd_sw_msi_map for the msi physical address requested by the irq
+ * layer. The mapping to IOVA is global to the iommufd file descriptor, every
+ * domain that is attached to a device using the same MSI parameters will use
+ * the same IOVA.
+ */
+static struct iommufd_sw_msi_map *
+iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
+		       phys_addr_t sw_msi_start)
+{
+	struct iommufd_sw_msi_map *cur;
+	unsigned int max_pgoff = 0;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		if (cur->sw_msi_start != sw_msi_start)
+			continue;
+		max_pgoff = max(max_pgoff, cur->pgoff + 1);
+		if (cur->msi_addr == msi_addr)
+			return cur;
+	}
+
+	if (ictx->sw_msi_id >=
+	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
+		return ERR_PTR(-EOVERFLOW);
+
+	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
+	if (!cur)
+		cur = ERR_PTR(-ENOMEM);
+	cur->sw_msi_start = sw_msi_start;
+	cur->msi_addr = msi_addr;
+	cur->pgoff = max_pgoff;
+	cur->id = ictx->sw_msi_id++;
+	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
+	return cur;
+}
+
+static int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+				  struct iommufd_hwpt_paging *hwpt_paging,
+				  struct iommufd_sw_msi_map *msi_map)
+{
+	unsigned long iova;
+
+	lockdep_assert_held(&ictx->sw_msi_lock);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
+		int rc;
+
+		rc = iommu_map(hwpt_paging->common.domain, iova,
+			       msi_map->msi_addr, PAGE_SIZE,
+			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
+			       GFP_KERNEL_ACCOUNT);
+		if (rc)
+			return rc;
+		set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
+	}
+	return 0;
+}
+
+/*
+ * Called by the irq code if the platform translates the MSI address through the
+ * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
+ * allocate a fd global iova for the physical page that is the same on all
+ * domains and devices.
+ */
+#ifdef CONFIG_IRQ_MSI_IOMMU
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct iommu_attach_handle *raw_handle;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_attach_handle *handle;
+	struct iommufd_sw_msi_map *msi_map;
+	struct iommufd_ctx *ictx;
+	unsigned long iova;
+	int rc;
+
+	raw_handle =
+		iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
+	if (!raw_handle)
+		return 0;
+	hwpt_paging = find_hwpt_paging(domain->iommufd_hwpt);
+
+	handle = to_iommufd_handle(raw_handle);
+	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
+	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+		return 0;
+
+	ictx = handle->idev->ictx;
+	guard(mutex)(&ictx->sw_msi_lock);
+	/*
+	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
+	 * assume the caller has checked that it is contained with a MMIO region
+	 * that is secure to map at PAGE_SIZE.
+	 */
+	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
+					 msi_addr & PAGE_MASK,
+					 handle->idev->igroup->sw_msi_start);
+	if (IS_ERR(msi_map))
+		return PTR_ERR(msi_map);
+
+	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
+	if (rc)
+		return rc;
+	set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
+
+	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
+	return 0;
+}
+#endif
+
+/*
+ * FIXME: when a domain is removed any ids that are not in the union of
+ * all still attached devices should be removed.
+ */
+
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
-	phys_addr_t sw_msi_start = igroup->sw_msi_start;
-	int rc;
+	struct iommufd_ctx *ictx = igroup->ictx;
+	struct iommufd_sw_msi_map *cur;
+
+	if (igroup->sw_msi_start == PHYS_ADDR_MAX)
+		return 0;
 
 	/*
-	 * If the IOMMU driver gives a IOMMU_RESV_SW_MSI then it is asking us to
-	 * call iommu_get_msi_cookie() on its behalf. This is necessary to setup
-	 * the MSI window so iommu_dma_prepare_msi() can install pages into our
-	 * domain after request_irq(). If it is not done interrupts will not
-	 * work on this domain.
-	 *
-	 * FIXME: This is conceptually broken for iommufd since we want to allow
-	 * userspace to change the domains, eg switch from an identity IOAS to a
-	 * DMA IOAS. There is currently no way to create a MSI window that
-	 * matches what the IRQ layer actually expects in a newly created
-	 * domain.
+	 * Install all the MSI pages the device has been using into the domain
 	 */
-	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt_paging->msi_cookie) {
-		rc = iommu_get_msi_cookie(hwpt_paging->common.domain,
-					  sw_msi_start);
+	guard(mutex)(&ictx->sw_msi_lock);
+	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
+		int rc;
+
+		if (cur->sw_msi_start != igroup->sw_msi_start ||
+		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
+			continue;
+
+		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
 		if (rc)
 			return rc;
-
-		/*
-		 * iommu_get_msi_cookie() can only be called once per domain,
-		 * it returns -EBUSY on later calls.
-		 */
-		hwpt_paging->msi_cookie = true;
 	}
 	return 0;
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index f7c0d7b214b6..538484eecb3b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -156,6 +156,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 		}
 	}
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
@@ -251,6 +252,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		goto out_abort;
 	}
 	hwpt->domain->owner = ops;
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
@@ -303,6 +305,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		goto out_abort;
 	}
 	hwpt->domain->owner = viommu->iommu_dev->ops;
+	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 97c5e3567d33..7cc9497b7193 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -227,6 +227,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	xa_init(&ictx->groups);
 	ictx->file = filp;
 	init_waitqueue_head(&ictx->destroy_wait);
+	mutex_init(&ictx->sw_msi_lock);
+	INIT_LIST_HEAD(&ictx->sw_msi_list);
 	filp->private_data = ictx;
 	return 0;
 }
@@ -234,6 +236,8 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 static int iommufd_fops_release(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx = filp->private_data;
+	struct iommufd_sw_msi_map *next;
+	struct iommufd_sw_msi_map *cur;
 	struct iommufd_object *obj;
 
 	/*
@@ -262,6 +266,11 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 			break;
 	}
 	WARN_ON(!xa_empty(&ictx->groups));
+
+	mutex_destroy(&ictx->sw_msi_lock);
+	list_for_each_entry_safe(cur, next, &ictx->sw_msi_list, sw_msi_item)
+		kfree(cur);
+
 	kfree(ictx);
 	return 0;
 }
-- 
2.43.0


