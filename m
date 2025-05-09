Return-Path: <linux-kselftest+bounces-32710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F6AB084F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAC19E2A9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209552459F0;
	Fri,  9 May 2025 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibZLIPNy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552B243958;
	Fri,  9 May 2025 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759824; cv=fail; b=fAPDiFGchBqoNdCZtMkuTUMxegIGcQqDzFYvIP3qXM2BAGtFfyIQZqo/3KJ6dck5l5X4D322KNlYYNsIrMun7q02yAbchecaxiRtCgNBDefOD7agecGJ6oX8Yon66H04JNM1v/B5b2vfNvVJb10ohVZTEtsaPtmkMvrRgMaJTYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759824; c=relaxed/simple;
	bh=juXowaiuZUJ062A14BszWjrSNoyJenihoJi5zyHKc2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiM3rCf+0fOgUSxS2VqSTpYZjLwHKUMNHDGMvlZHrP/VNIvTkW/t6PI2VPBqcSm2v4PmJbnQ1AByrNwFmNJicGVqd1PexO/Srl3fJUFp+dA+ZLOjbpJN2ah/fQnfS3tpTnJ1bp6FV9TJJ6n1SxRgfOOGuYTU01neLybXZ8Ms+gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibZLIPNy; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4D+9/LcYXrN9+GHCE//MhpkW5V7IPdWb4O7OUcGzN4c3N6m5uMXyzxHm+CFLs2KmL3ggcICRyRzvlKthdtZJ5ZSHtmnm1v0WQTFOXp4pv8m0enpH0s8KY3MWQeL8t9/hSudbEtP4SoheDccty65Mzu0mUmQ3xKoIEaEDaObYqGcJpxUp6ae2hXShXcPtHQGFfFOGkfkadYM4fxoMFrmeqmEO0KiQiFyyfF38WDn/TyyOiw4x6SL8qjnVoT3Z09NfOPSweCcg0Gmx9CS8O+b6jVV8O+Ilbb5R7rWfLsvOx1GYS8GdWTe9XGssdiJ0cKVwyKpzvHNWyTykMbEu9Ltqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCt3rTshD/XJgpf69MQV673Z1xglXUusfFjb7ph4a9c=;
 b=sizegxYaUjnOvY40CLnNiiJoWX1y//5hQ3RnkYUbIMY/7WvFnvlxSlq00JVdz5YWMAqBK+KtYF2tB4uoX1U5w5w+gBfbpj71DAdj08+54Yn/ryhKST46E4GJIS+DKDrLCactthJ8EMoUCY3JoxUlvtRASDIDnjmYn5MRieG9qw6P1e82zvr8fUVM7Y90FGSomP6hyfb5IrfSaE/54YFGfblvmeE1C454MG018CpFfz/l9aKjvyU5YTjCcuUBGdU3qzXLE/mvn5SoFquFiXMpqHNLlnKQVa8ppNekQuHNeN2d7RIS5799DRkKNer4wGoROK+9ZtW1uBkW1tBfcdhjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCt3rTshD/XJgpf69MQV673Z1xglXUusfFjb7ph4a9c=;
 b=ibZLIPNyP4CrfV+txmyO1vRLNEqRv7MvdpBEBEzK41VKptRfUBaFj8JjHNA5eYot8qz6jmPvGqYf6sSc1eM/nZmGcUHbcA0lGeO5CTF1jjxAFzczkLnIllpEpWoD8NyfAFF5hr1YQDTUPA8iLQxtX9ybrceFBBE6jCsIeg2nqXJBAU4tNvFDtINjJputQkd8v3zlahlUl0Or5+xwVm1fbV9BGrBuJTNijgj3fuFvXA+LgvCTqp2sUAj1Ro3OnxkG9oV6mz3Vm4GAqETwc3ydUigxH69ey74Qak1/TkfvWLShsAjmGShHULWpzU5/xWuOVhEJ+qVOU8Ql/AaIYitN3Q==
Received: from BYAPR07CA0001.namprd07.prod.outlook.com (2603:10b6:a02:bc::14)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 03:03:30 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::62) by BYAPR07CA0001.outlook.office365.com
 (2603:10b6:a02:bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Fri,
 9 May 2025 03:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 03:03:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 20:03:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 20:03:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 20:03:16 -0700
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
Subject: [PATCH v4 09/23] iommufd: Abstract iopt_pin_pages and iopt_unpin_pages helpers
Date: Thu, 8 May 2025 20:02:30 -0700
Message-ID: <88a0b17337897de8ca170afa1e9be26ff7442437.1746757630.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd3739f-8401-44a7-0c02-08dd8ea6130a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gyiGOqOCpVFQt0naOzOu2YIEp/iathUl2xe9eTXMPL/tAF88oA0n2wFPbxX4?=
 =?us-ascii?Q?g0q1CnmssWaMU09ZUOR0byRw+RDggXTxIEUnCTCehmb28kkOzADissfl/gnf?=
 =?us-ascii?Q?Je/cGdaFmgA9kToMzoPy74K6bCDyF/BsBkrz8QQ71RVLeLAppT+HI8Ny3uQ2?=
 =?us-ascii?Q?ci9u+k1HO5+hW7pvIpT+ekyX5DrbyXMpSGXIGvhEzoT9EYNDK9bqVUnEVTZl?=
 =?us-ascii?Q?vnZPxGgt/Ebs4Sv3uD4cXgPwv1M13nsX5YRarDnZ599DeVJFq9jJBNTUAV2c?=
 =?us-ascii?Q?jXipAlwPMF/2rkoG0Z76uEnAuucGwcgpdnU/jMoYRNJoPOMdVUrU7Zfu46U6?=
 =?us-ascii?Q?DtjRcOeWiTudrXKJxchUWFE37veJBbMVQmUQAELVmgBCJf6D1KK0OcnBhdEW?=
 =?us-ascii?Q?LXSYC38YU8+0qb2I+1O0JYVBymHsjjA3ZXBVUJnUNywyqwhrJFjOl/Vy0KxK?=
 =?us-ascii?Q?lMxzeBmYXYomNsWmIDTRNIVCdw1NDG1FWqr9DMV0hSeRsCdCldi7Ht/FG5ey?=
 =?us-ascii?Q?D7J0HzxPrka91xDOIWdymGEYOTWyh96VJ9t2UExPxSVGNv6/X5wRMjko9k7D?=
 =?us-ascii?Q?fQrhK5gDfHNvMFLJuHNlMIsb1ZTNveIorW6RXD93sNsUhcYoJu5Soe4BYoyh?=
 =?us-ascii?Q?XVQPhcJINogMUYV6aqkzOsMaMPHhJFg4d0+ge0TcKzMQTHLeQZOfN03+uqwj?=
 =?us-ascii?Q?ApkDrwlgZpB3IMxwJthwGMMRsGhwo/KEKNZNwXIHEcMTDC6lxz2DEoPE07ud?=
 =?us-ascii?Q?I7EI4NX1E3hS/NnxIPsVxaMbEwcxBtOa44jLDIy5vHiDwQgjYk1AX6RLlz7z?=
 =?us-ascii?Q?OGX3LXgz+V8VF0FM7Dzu5fdcMYKHHMA+i5jR71063273HTPws9VkH9JL5l33?=
 =?us-ascii?Q?iaDjyq3uCbVIQkH4kl2rjeEq50tpUyEuQW3a+d5UcoiklJgPCwwBqDziw7dB?=
 =?us-ascii?Q?6VjPy2XeoKqkqGOzX/xDb/CwzWs2lISUtPFvJcfuC5cVysNjPKcAa3t7//rT?=
 =?us-ascii?Q?02J2QHe0Ysr/3DgN8y3IdnvVPTV0Ld5AwHuB0LbkCKlwSK1uvrPx/3MHtWZb?=
 =?us-ascii?Q?Sr37vbBDk3NGo2O+O13RiGlPzrV/wX4yp+6/fGkc+aMHe8zibNsRvNorBF9m?=
 =?us-ascii?Q?gRnUxIPhGJtsGA4iBvNoQSRQLkxg0xddkXYl3Uwq4p2tpK7hwkkDfEy6+VUk?=
 =?us-ascii?Q?/74P4vqyCrbmgLAaDXzwtO7/7/0K3i3b/ts09hDi70QRnEmDAPL/S2GGZtfG?=
 =?us-ascii?Q?eQ+I9LAZDsKgm5Z6EHI3cNvRqYgGrANu/qBdMdoBNxx+jwpqxdvf1GXx+uj7?=
 =?us-ascii?Q?ZtPvu3gTi5koZt3GGUR1lYd2IU3gJsAfpZeqGKYxzzl8nYELhOn15l5PNKpZ?=
 =?us-ascii?Q?K6IBnYJ3HHQuLqeFEPJ7ArqYwm5yVE4KWSmifirOM0MRiR0TJHNYCcy51+ql?=
 =?us-ascii?Q?jAlV3VWvVOVf5cgQye+dlDJ/n09i4HP/qTs+JBaKYnuG2gcMn3OHVouXDrGG?=
 =?us-ascii?Q?WZr1ATMeccHSjoOxXZSfxx7skNGRrb+aqJo3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 03:03:29.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd3739f-8401-44a7-0c02-08dd8ea6130a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066

The new HW QUEUE object will be added for HW to access the guest queue for
HW-accelerated virtualization feature. It needs to ensure the guest memory
pages are pinned when HW accesses them and they are contiguous in physical
address space.

This is very like the existing iommufd_access_pin_pages() that outputs the
pinned page list for the caller to test its contiguity.

Move those code from iommufd_access_pin/unpin_pages() and related function
for a pair of iopt helpers that can be shared with the HW QUEUE allocator.

Rename check_area_prot() to align with the existing iopt_area helpers, and
inline it to the header since iommufd_access_rw() still uses it.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h    |   8 ++
 drivers/iommu/iommufd/iommufd_private.h |   6 ++
 drivers/iommu/iommufd/device.c          | 117 ++----------------------
 drivers/iommu/iommufd/io_pagetable.c    |  95 +++++++++++++++++++
 4 files changed, 117 insertions(+), 109 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 10c928a9a463..4288a2b1a90f 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -114,6 +114,14 @@ static inline unsigned long iopt_area_iova_to_index(struct iopt_area *area,
 	return iopt_area_start_byte(area, iova) / PAGE_SIZE;
 }
 
+static inline bool iopt_area_check_prot(struct iopt_area *area,
+					unsigned int flags)
+{
+	if (flags & IOMMUFD_ACCESS_RW_WRITE)
+		return area->iommu_prot & IOMMU_WRITE;
+	return area->iommu_prot & IOMMU_READ;
+}
+
 #define __make_iopt_iter(name)                                                 \
 	static inline struct iopt_##name *iopt_##name##_iter_first(            \
 		struct io_pagetable *iopt, unsigned long start,                \
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8d96aa514033..79160b039bc7 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -130,6 +130,12 @@ int iopt_cut_iova(struct io_pagetable *iopt, unsigned long *iovas,
 void iopt_enable_large_pages(struct io_pagetable *iopt);
 int iopt_disable_large_pages(struct io_pagetable *iopt);
 
+int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
+		   unsigned long length, struct page **out_pages,
+		   unsigned int flags);
+void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
+		      unsigned long length);
+
 struct iommufd_ucmd {
 	struct iommufd_ctx *ictx;
 	void __user *ubuffer;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2111bad72c72..a5c6be164254 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1240,58 +1240,17 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length)
 {
-	struct iopt_area_contig_iter iter;
-	struct io_pagetable *iopt;
-	unsigned long last_iova;
-	struct iopt_area *area;
-
-	if (WARN_ON(!length) ||
-	    WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
-		return;
-
-	mutex_lock(&access->ioas_lock);
+	guard(mutex)(&access->ioas_lock);
 	/*
 	 * The driver must be doing something wrong if it calls this before an
 	 * iommufd_access_attach() or after an iommufd_access_detach().
 	 */
-	if (WARN_ON(!access->ioas_unpin)) {
-		mutex_unlock(&access->ioas_lock);
+	if (WARN_ON(!access->ioas_unpin))
 		return;
-	}
-	iopt = &access->ioas_unpin->iopt;
-
-	down_read(&iopt->iova_rwsem);
-	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
-		iopt_area_remove_access(
-			area, iopt_area_iova_to_index(area, iter.cur_iova),
-			iopt_area_iova_to_index(
-				area,
-				min(last_iova, iopt_area_last_iova(area))));
-	WARN_ON(!iopt_area_contig_done(&iter));
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
+	iopt_unpin_pages(&access->ioas_unpin->iopt, iova, length);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, "IOMMUFD");
 
-static bool iopt_area_contig_is_aligned(struct iopt_area_contig_iter *iter)
-{
-	if (iopt_area_start_byte(iter->area, iter->cur_iova) % PAGE_SIZE)
-		return false;
-
-	if (!iopt_area_contig_done(iter) &&
-	    (iopt_area_start_byte(iter->area, iopt_area_last_iova(iter->area)) %
-	     PAGE_SIZE) != (PAGE_SIZE - 1))
-		return false;
-	return true;
-}
-
-static bool check_area_prot(struct iopt_area *area, unsigned int flags)
-{
-	if (flags & IOMMUFD_ACCESS_RW_WRITE)
-		return area->iommu_prot & IOMMU_WRITE;
-	return area->iommu_prot & IOMMU_READ;
-}
-
 /**
  * iommufd_access_pin_pages() - Return a list of pages under the iova
  * @access: IOAS access to act on
@@ -1315,76 +1274,16 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 			     unsigned long length, struct page **out_pages,
 			     unsigned int flags)
 {
-	struct iopt_area_contig_iter iter;
-	struct io_pagetable *iopt;
-	unsigned long last_iova;
-	struct iopt_area *area;
-	int rc;
-
 	/* Driver's ops don't support pin_pages */
 	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
 	    WARN_ON(access->iova_alignment != PAGE_SIZE || !access->ops->unmap))
 		return -EINVAL;
 
-	if (!length)
-		return -EINVAL;
-	if (check_add_overflow(iova, length - 1, &last_iova))
-		return -EOVERFLOW;
-
-	mutex_lock(&access->ioas_lock);
-	if (!access->ioas) {
-		mutex_unlock(&access->ioas_lock);
+	guard(mutex)(&access->ioas_lock);
+	if (!access->ioas)
 		return -ENOENT;
-	}
-	iopt = &access->ioas->iopt;
-
-	down_read(&iopt->iova_rwsem);
-	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
-		unsigned long last = min(last_iova, iopt_area_last_iova(area));
-		unsigned long last_index = iopt_area_iova_to_index(area, last);
-		unsigned long index =
-			iopt_area_iova_to_index(area, iter.cur_iova);
-
-		if (area->prevent_access ||
-		    !iopt_area_contig_is_aligned(&iter)) {
-			rc = -EINVAL;
-			goto err_remove;
-		}
-
-		if (!check_area_prot(area, flags)) {
-			rc = -EPERM;
-			goto err_remove;
-		}
-
-		rc = iopt_area_add_access(area, index, last_index, out_pages,
-					  flags);
-		if (rc)
-			goto err_remove;
-		out_pages += last_index - index + 1;
-	}
-	if (!iopt_area_contig_done(&iter)) {
-		rc = -ENOENT;
-		goto err_remove;
-	}
-
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
-	return 0;
-
-err_remove:
-	if (iova < iter.cur_iova) {
-		last_iova = iter.cur_iova - 1;
-		iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
-			iopt_area_remove_access(
-				area,
-				iopt_area_iova_to_index(area, iter.cur_iova),
-				iopt_area_iova_to_index(
-					area, min(last_iova,
-						  iopt_area_last_iova(area))));
-	}
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
-	return rc;
+	return iopt_pin_pages(&access->ioas->iopt, iova, length, out_pages,
+			      flags);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, "IOMMUFD");
 
@@ -1431,7 +1330,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 			goto err_out;
 		}
 
-		if (!check_area_prot(area, flags)) {
+		if (!iopt_area_check_prot(area, flags)) {
 			rc = -EPERM;
 			goto err_out;
 		}
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 8a790e597e12..4dfe14dcbb51 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1472,3 +1472,98 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	up_write(&iopt->iova_rwsem);
 	return rc;
 }
+
+static bool iopt_area_contig_is_aligned(struct iopt_area_contig_iter *iter)
+{
+	if (iopt_area_start_byte(iter->area, iter->cur_iova) % PAGE_SIZE)
+		return false;
+
+	if (!iopt_area_contig_done(iter) &&
+	    (iopt_area_start_byte(iter->area, iopt_area_last_iova(iter->area)) %
+	     PAGE_SIZE) != (PAGE_SIZE - 1))
+		return false;
+	return true;
+}
+
+int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
+		   unsigned long length, struct page **out_pages,
+		   unsigned int flags)
+{
+	struct iopt_area_contig_iter iter;
+	unsigned long last_iova;
+	struct iopt_area *area;
+	int rc;
+
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(iova, length - 1, &last_iova))
+		return -EOVERFLOW;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
+		unsigned long last = min(last_iova, iopt_area_last_iova(area));
+		unsigned long last_index = iopt_area_iova_to_index(area, last);
+		unsigned long index =
+			iopt_area_iova_to_index(area, iter.cur_iova);
+
+		if (area->prevent_access ||
+		    !iopt_area_contig_is_aligned(&iter)) {
+			rc = -EINVAL;
+			goto err_remove;
+		}
+
+		if (!iopt_area_check_prot(area, flags)) {
+			rc = -EPERM;
+			goto err_remove;
+		}
+
+		rc = iopt_area_add_access(area, index, last_index, out_pages,
+					  flags);
+		if (rc)
+			goto err_remove;
+		out_pages += last_index - index + 1;
+	}
+	if (!iopt_area_contig_done(&iter)) {
+		rc = -ENOENT;
+		goto err_remove;
+	}
+
+	up_read(&iopt->iova_rwsem);
+	return 0;
+
+err_remove:
+	if (iova < iter.cur_iova) {
+		last_iova = iter.cur_iova - 1;
+		iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
+			iopt_area_remove_access(
+				area,
+				iopt_area_iova_to_index(area, iter.cur_iova),
+				iopt_area_iova_to_index(
+					area, min(last_iova,
+						  iopt_area_last_iova(area))));
+	}
+	up_read(&iopt->iova_rwsem);
+	return rc;
+}
+
+void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
+		      unsigned long length)
+{
+	struct iopt_area_contig_iter iter;
+	unsigned long last_iova;
+	struct iopt_area *area;
+
+	if (WARN_ON(!length) ||
+	    WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
+		return;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
+		iopt_area_remove_access(
+			area, iopt_area_iova_to_index(area, iter.cur_iova),
+			iopt_area_iova_to_index(
+				area,
+				min(last_iova, iopt_area_last_iova(area))));
+	WARN_ON(!iopt_area_contig_done(&iter));
+	up_read(&iopt->iova_rwsem);
+}
-- 
2.43.0


