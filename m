Return-Path: <linux-kselftest+bounces-36915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093FAFF8DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 08:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3645A4E2EDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 06:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D828B7F0;
	Thu, 10 Jul 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dZHK0qiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521E28750D;
	Thu, 10 Jul 2025 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127233; cv=fail; b=g3QXud0TaDSlVtr9shH8d2j4LpoRXkFlJWWbPnZybMEDbZLzCm6pIA+r6dA8dDnMAqLp9Au+Xuxr9Edo3BoI9+ZWyFTo9wVpPwjFPWKA5bnmwk6Tde59tfmoiYos2mJBlYOJEdKTFMmp2tmjXNXlnbWH4KMqlkvIoHAjbx+a3kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127233; c=relaxed/simple;
	bh=AVAw1tR7SIjY37gcgPHwyuxL/Ua8i1gmzlgZQsAK+j4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wi2xrlYYfkzdD/35tFoQgrMP2lDgyMisxKFLbn9DAU5EhHuBqH0umZM144mxl4tsa1U0D91iF3LzD1Ft/nULYedkJDHcTdJXQgcVznx5QMuSDm9ltVh4uMzixlsf7CNKGRtEcoI99YZ3hc2lFBjLubQEiYzOKi2mD8A3Wx240qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dZHK0qiw; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXyVj9gKQr3sU8qiGsocER91SP0RFci3FMWVy6iJ53tmSsYy1SoiLUY6HmQXdehSIwWk0X1+yEGr4geGaKPazvW34OzgCLW6u8Wo+L/8NSonPcUzic9ioQO1Q0e3nyYJRjh/qIwZwdxdfdju8+LGkk6ypZ7FJE2DgEr3+OrA4FexGnsyklRIp9/YI1aVfSjZq70+rUxcvQn6Nllfz2naB2cRhTwx//zLbC1i5OFhMRtozJGbFbxQPJgeqjJt0UCcv5e+vU15nSzQvCtc0wICNeM9zw7VIDsEqVUDmEqofCBNI40uyHQK/CysOrMYeZGZsbOR8um/aeBna5HCW4KrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dklKg9uUrRmd/WIlyI6ryPma5hxpkYfODl1wQgGp6SA=;
 b=qoKlJSofdh3I7duAQDEbwGGVAQXNcQLVrTIEQJ55+IpHj28D11Pii3MovPSqZkiQVniFjHD0ItFUosmv+BHW4oOsPskAkRCDDGBYA6nDxTP4mKTPdoAcSaIQXdC2x9AJ3Z/W0mtHzOGeNNB7HXeDDBt5PuUyLE1TjrmGDWzbtZGbR0AgU44Mp2jgG7sMnazsi/8hQFRWlvWuymWqB2QUHN7zYAeAtgRurEVlYEJHk199iDsTwwknnuuQsFioIwKaH4IIkoPqOV6ibQYaqv5j/F3WJ8Pdw947qvPFqVsHA4LqlLcGBj3bWHxbhfntDZRTLYxICcMZOe25UX6JwuNMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dklKg9uUrRmd/WIlyI6ryPma5hxpkYfODl1wQgGp6SA=;
 b=dZHK0qiw+G6IbrUa3LClXoYM3flXqiwU7Jr3W2TzVtZH5xO4NkJbKfR2FLgumjH4e46UsrByNxpnq9SriT0rgmvndhot6Q60mj94DMZdE7N2OB019t3LmKaE54Uv6Kei9ZXNImbMaf3tgEySRdayZ8uOgdtpgjldmJ5tkl+LbA9Wqjy9EilMTlid3v4DNi64WOV3ktIlWXys6GUNzK2MDfoQvUnOC5Gxbsv2oZYF12n9tUFY7sesttHrYbjWRm0cllGiH0A0Bk/FdjCsWtDxBvGLmli9wqsKDndIVyxzfROAcadslMjxXGT8iiP7KXRJ+Tt2OVoUDgASRBcRdtF7hg==
Received: from CH0PR03CA0307.namprd03.prod.outlook.com (2603:10b6:610:118::8)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 06:00:25 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::46) by CH0PR03CA0307.outlook.office365.com
 (2603:10b6:610:118::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 06:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:00:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:00:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:00:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 23:00:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <bagasdotme@gmail.com>,
	<will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v9 11/29] iommufd/access: Bypass access->ops->unmap for internal use
Date: Wed, 9 Jul 2025 22:59:03 -0700
Message-ID: <6df9a43febf79c0379091ec59747276ce9d2493b.1752126748.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c71186-e5e3-4602-d32c-08ddbf77105b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fx3qyQgVvWjQ5uN6jkf2N0Z6jL63lbMv2158pkReFjLk8E4VukOJ9h+ydDJ4?=
 =?us-ascii?Q?6DKXerMk11rNnxRUFzTLkfwR2vIbird9EqY5OG90RVmZO1LCPiU5BMxC/JB3?=
 =?us-ascii?Q?vymHXgP7ccMlZRnT0d8ctzOKJph5X5mJ2UqY8oMZ8qm1kHyhJCJt0HiA3zme?=
 =?us-ascii?Q?VipRgxGbw6F+Yx/c0WL9/6MgLPfnkw1TVw8BR7arvIOhTdx72ftvxitTZOVK?=
 =?us-ascii?Q?bzf4Dj+ZhaAc52AkjV8VgJTT1eduh03D4sISqWzo+FLJxDpmwIigXtKaY4gl?=
 =?us-ascii?Q?Mh6sgCXfqEtofDKg6eigxEB7HSqtSvcrn6Xw8vjinFZjhsh2ZFPywIQ8LTjC?=
 =?us-ascii?Q?XDCB9cVdijbodb1z2V4NhMoR1Yy/Cp+XsI9bfLHtduR3blmIPO+t70mtVe5M?=
 =?us-ascii?Q?eDuh58P8V2ApRuAusgiySWf7CUnAiUr5nsuMwXF++Qdd0Yjz0BaJezoRwm6O?=
 =?us-ascii?Q?7Ki+/i7V2MzNxb1ALNAo7xgs1+lgHrHNMgPT5VKoZEfMTT0d0MQT1z7O1lqI?=
 =?us-ascii?Q?TtDte5tgpxomTUle2E0dfjQlA8EwKTN+M6UreBtDLjG/kIDAcWv2o3YaUOUZ?=
 =?us-ascii?Q?nqUNYVkKCGCCJJaALceTesThYV2ZK+T3UKqNCKNRYit1vFoq7q0TeCEIuFh0?=
 =?us-ascii?Q?IeV8Fkdq8THM91G8BDwZDWYIVXwbDAIrKDbZFsYvSCwK7kvo7nBqEzQF4R1v?=
 =?us-ascii?Q?YGr0/s7noSuTRIuMh6H5iLnjgXQsSPNXX9g1DXNWJOMVovAM0ZR1Whl9p8u+?=
 =?us-ascii?Q?cdA1Sit4SOLsSMLaP9qj7uafQ7LfWMg09vjbyRAGWSgeYU9DeB21sEhF7nS7?=
 =?us-ascii?Q?XJeScyLLpX2NuYb6iXdxmXqaCGRt5lM4oWgGsjukpvV77T6vFzk5uHxSUugW?=
 =?us-ascii?Q?OAl4K2uYtYtnSnT/rQ4dt76DYWaR9ZDDeQPxEgKUhaV+GfojkX3RzUmvPAz0?=
 =?us-ascii?Q?KpjmW8PcnV7PBt0YtmnVntXjGCL54XAb09SfyONnhuzAHYoM0bHdRNuI9D/u?=
 =?us-ascii?Q?3Mt5D0Xw5TUkLR/PCgKtX77LvBQzwx76LT2pTwaKvTrlTOVWUDw8Vi7lSbLq?=
 =?us-ascii?Q?NNlLBA34ndheyiHFWO3xpU5ESYyejySqLzxCVFJdNK/7+yNuNX2XqgeDwwIq?=
 =?us-ascii?Q?6FU6yFGjbuwk0GwhV8aPakPwwrBVcdwugsIE9DTt0s5qqwaOmHq7VQYp2qtn?=
 =?us-ascii?Q?XN7buFjJbqej1oI2iTCfSWAFQ5ZADnRXowl6NkIlb6nEn2KXm352ljQSNLRp?=
 =?us-ascii?Q?rmvGkdfRMmu2oUP1XX2SJ67RST2PQ33s7tWjMlq9xG4Xh0FsE3L9qOgCXOcJ?=
 =?us-ascii?Q?ek30PLuuS3xynyyPXYixFa5YpM/AaRzpbmy0oo9aG3FJ4UjWkaAZcqkt5c5+?=
 =?us-ascii?Q?NYDsN1tnqY2SkkfhU7XdbWzIpmZptRFuZREYEGb3ZZEzsgj1vQG5Qrky238v?=
 =?us-ascii?Q?CCVzBajphuoaNXhXLlX7qBf3wPcdmkzwPvMS+BztFcu07dgXA1c2NjfVJyRr?=
 =?us-ascii?Q?FoM1ReOgKROZO373dGpZLUKS+wfGNNiZs+zc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:00:25.1318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c71186-e5e3-4602-d32c-08ddbf77105b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981

The access object has been used externally by VFIO mdev devices, allowing
them to pin/unpin physical pages (via needs_pin_pages). Meanwhile, a racy
unmap can occur in this case, so these devices usually implement an unmap
handler, invoked by iommufd_access_notify_unmap().

The new HW queue object will need the same pin/unpin feature, although it
(unlike the mdev case) wants to reject any unmap attempt, during its life
cycle. Instead, it would not implement an unmap handler. Thus, bypass any
access->ops->unmap access call when the access is marked as internal.

Also, an area being pinned by an internal access should reject any unmap
request. This cannot be done inside iommufd_access_notify_unmap() as it's
a per-iopt action. Add a "num_locks" counter in the struct iopt_area, set
that in iopt_area_add_access() when the caller is an internal access.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  5 +++--
 drivers/iommu/iommufd/device.c       | 18 ++++++++++++------
 drivers/iommu/iommufd/io_pagetable.c |  6 ++++++
 drivers/iommu/iommufd/pages.c        | 12 ++++++++++--
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index c115a51d9384..b6064f4ce4af 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -48,6 +48,7 @@ struct iopt_area {
 	int iommu_prot;
 	bool prevent_access : 1;
 	unsigned int num_accesses;
+	unsigned int num_locks;
 };
 
 struct iopt_allowed {
@@ -238,9 +239,9 @@ void iopt_pages_unfill_xarray(struct iopt_pages *pages, unsigned long start,
 
 int iopt_area_add_access(struct iopt_area *area, unsigned long start,
 			 unsigned long last, struct page **out_pages,
-			 unsigned int flags);
+			 unsigned int flags, bool lock_area);
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start,
-			     unsigned long last);
+			     unsigned long last, bool unlock_area);
 int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 			 void *data, unsigned long length, unsigned int flags);
 
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 07a4ff753c12..0567faff5680 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1048,7 +1048,7 @@ static int iommufd_access_change_ioas(struct iommufd_access *access,
 	}
 
 	if (cur_ioas) {
-		if (access->ops->unmap) {
+		if (!iommufd_access_is_internal(access) && access->ops->unmap) {
 			mutex_unlock(&access->ioas_lock);
 			access->ops->unmap(access->data, 0, ULONG_MAX);
 			mutex_lock(&access->ioas_lock);
@@ -1255,7 +1255,8 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 
 	xa_lock(&ioas->iopt.access_list);
 	xa_for_each(&ioas->iopt.access_list, index, access) {
-		if (!iommufd_lock_obj(&access->obj))
+		if (!iommufd_lock_obj(&access->obj) ||
+		    iommufd_access_is_internal(access))
 			continue;
 		xa_unlock(&ioas->iopt.access_list);
 
@@ -1279,6 +1280,7 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length)
 {
+	bool internal = iommufd_access_is_internal(access);
 	struct iopt_area_contig_iter iter;
 	struct io_pagetable *iopt;
 	unsigned long last_iova;
@@ -1305,7 +1307,8 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 			area, iopt_area_iova_to_index(area, iter.cur_iova),
 			iopt_area_iova_to_index(
 				area,
-				min(last_iova, iopt_area_last_iova(area))));
+				min(last_iova, iopt_area_last_iova(area))),
+			internal);
 	WARN_ON(!iopt_area_contig_done(&iter));
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
@@ -1354,6 +1357,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			     unsigned long length, struct page **out_pages,
 			     unsigned int flags)
 {
+	bool internal = iommufd_access_is_internal(access);
 	struct iopt_area_contig_iter iter;
 	struct io_pagetable *iopt;
 	unsigned long last_iova;
@@ -1362,7 +1366,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 
 	/* Driver's ops don't support pin_pages */
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
-	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
+	    WARN_ON(access->iova_alignment != PAGE_SIZE ||
+		    (!internal && !access->ops->unmap)))
 		return -EINVAL;
 
 	if (!length)
@@ -1396,7 +1401,7 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 		}
 
 		rc = iopt_area_add_access(area, index, last_index, out_pages,
-					  flags);
+					  flags, internal);
 		if (rc)
 			goto err_remove;
 		out_pages += last_index - index + 1;
@@ -1419,7 +1424,8 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 				iopt_area_iova_to_index(area, iter.cur_iova),
 				iopt_area_iova_to_index(
 					area, min(last_iova,
-						  iopt_area_last_iova(area))));
+						  iopt_area_last_iova(area))),
+				internal);
 	}
 	up_read(&iopt->iova_rwsem);
 	mutex_unlock(&access->ioas_lock);
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 22fc3a12109f..abf4aadca96c 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -719,6 +719,12 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			goto out_unlock_iova;
 		}
 
+		/* The area is locked by an object that has not been destroyed */
+		if (area->num_locks) {
+			rc = -EBUSY;
+			goto out_unlock_iova;
+		}
+
 		if (area_first < start || area_last > last) {
 			rc = -ENOENT;
 			goto out_unlock_iova;
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index cbdde642d2af..301c232462bd 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -2111,7 +2111,7 @@ iopt_pages_get_exact_access(struct iopt_pages *pages, unsigned long index,
  */
 int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 			 unsigned long last_index, struct page **out_pages,
-			 unsigned int flags)
+			 unsigned int flags, bool lock_area)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2124,6 +2124,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access = iopt_pages_get_exact_access(pages, start_index, last_index);
 	if (access) {
 		area->num_accesses++;
+		if (lock_area)
+			area->num_locks++;
 		access->users++;
 		iopt_pages_fill_from_xarray(pages, start_index, last_index,
 					    out_pages);
@@ -2145,6 +2147,8 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
 	access->node.last = last_index;
 	access->users = 1;
 	area->num_accesses++;
+	if (lock_area)
+		area->num_locks++;
 	interval_tree_insert(&access->node, &pages->access_itree);
 	mutex_unlock(&pages->mutex);
 	return 0;
@@ -2166,7 +2170,7 @@ int iopt_area_add_access(struct iopt_area *area, unsigned long start_index,
  * must stop using the PFNs before calling this.
  */
 void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
-			     unsigned long last_index)
+			     unsigned long last_index, bool unlock_area)
 {
 	struct iopt_pages *pages = area->pages;
 	struct iopt_pages_access *access;
@@ -2177,6 +2181,10 @@ void iopt_area_remove_access(struct iopt_area *area, unsigned long start_index,
 		goto out_unlock;
 
 	WARN_ON(area->num_accesses == 0 || access->users == 0);
+	if (unlock_area) {
+		WARN_ON(area->num_locks == 0);
+		area->num_locks--;
+	}
 	area->num_accesses--;
 	access->users--;
 	if (access->users)
-- 
2.43.0


