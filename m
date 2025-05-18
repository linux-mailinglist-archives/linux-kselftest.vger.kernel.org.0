Return-Path: <linux-kselftest+bounces-33272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC79CABAD5E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 05:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD3189BF4F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 03:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CDE221FD1;
	Sun, 18 May 2025 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdHt6T6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B2221290;
	Sun, 18 May 2025 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747538570; cv=fail; b=Juey0EfNKf8zeO8LPbhZN1RW5Uj4LioXp1vOk3ccBugGPcJ7TSCGXb2YZy/oIbCOnVO6618yPY/qfGs1dR3297LR5xHPHSQyGAs6LakKdQFRY4tVYWj8D+ALshntcho5cY1LNzUDkoJV1XNZ9drgy1kt3sLdS5GLnkl1ttPxO0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747538570; c=relaxed/simple;
	bh=joiAJUlnZCgymYcTE5utaL7/7K7tjz7G8euDpL3AsfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxwVisxqUg/19zsd0LshZQx63YjBzQd1yaDYyDdvH3swuzn/IiOQJq3GeY5oAKrB0xSPWLtZTn4BNyZMkvx0CP77a+DC983+ZRI69a0nQZho2NE5yc/VmPqBOPcnVMPl3mD3nF08smO5RtxOmxJ9JpgBsHrs2aGsfkH6XtwEUF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdHt6T6d; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1AdOPs5jhlGLyRtdEOvp+cXL91TcOd0SxVDxwZVSbRvEzW0cMqdxfVrg9F9Bf/xjww0YE1JC2+BUYrPmqp6XHbxfFnqsMUtfdmxzMzUXJa2pu3MjyG+d1wcdyvM4Txnonr6mwow6jOwVdOIcw5QGaqTHz5a+krEZPnAGLCt00JC4CXuSE2FsKsPoLKuREKv4Gl1CpoTMV4jS+YamCkFi39Wo/UiI7jG1KzVWmKckPY7WU61xDoWeCjwgyYz5KVgLvVCpjZ5XnA/A4I/CkRjIVZufuqTz+ticya+D1wtXujeZexRcUp2tzYqGS83lbvaBpbHBus1anbOJz7/FwO7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG2wCtx+ljIGdHTl4caMxEmomdd22HRStAjLtt2TBpU=;
 b=Y/dQXEJrVmGRyy+lbzFkk0tj6d/6fnbVxUTvLxfUfe4FrXB86HSS5Afqtz1m5b1UcHImWJGFa/F+iylcRbZGt/aaL3rrzMyt+udS+2J9XFUO7DnYtCQYnjYjC3I/p9WfjXROEbKnpuuIkRZtq7H+cWc5x/Hwu27vYCTuz9wUV63lG6nU6yjLQ+vF2k0PCLrkSEYa20lqZw0rHWndtBMxHksWYUDU+JHObekqGNWonDQ7XjVa0paDAMOMtE3/XzSULOZqjP7NxC+RPBI78Y37VIfgqVpuaYcZxE74eRqeRIsqN9QsMMMnhwypqc38TeIkRStMiF/NXQy4YrE9JzZRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG2wCtx+ljIGdHTl4caMxEmomdd22HRStAjLtt2TBpU=;
 b=kdHt6T6dxJ3SaIZuD2+9sttBMlSpfYb1QBlGQTWCw4o9s4WcbTWgZbSeDqWsMJ0ZagwlQQdy/0mE4D7fG6DBJ1ZhfFww3GotsnHj4VMs4N8b8NFYlh0N5fMKXrRJfS6Ho7Oq4AfdouZqqfEp6aOgmA8Hc3jNJoNMNOIRuIIc/c6iE401jfLsv7zQAj+/4XqlUZsHdebRG36RNGvh8wbm2OaqMR/ga5RFr5KVOSp8sqXmHPXTsN3AYZv4+Id6wwStHdS6Xzpp2F3b9hvOurSx8SmUFlVYtB74kdoNdic8iu7bynMjdl/g8/FE03Qbsfg7dFCvHjJNdu9EhOeYar5tzg==
Received: from SA0PR11CA0111.namprd11.prod.outlook.com (2603:10b6:806:d1::26)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 18 May
 2025 03:22:43 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::a) by SA0PR11CA0111.outlook.office365.com
 (2603:10b6:806:d1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Sun,
 18 May 2025 03:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 03:22:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 17 May
 2025 20:22:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 17 May
 2025 20:22:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 17 May 2025 20:22:11 -0700
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
Subject: [PATCH v5 10/29] iommufd: Abstract iopt_pin_pages and iopt_unpin_pages helpers
Date: Sat, 17 May 2025 20:21:27 -0700
Message-ID: <49f7143c1b513049fd8158278a11d9f8b6c837d3.1747537752.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747537752.git.nicolinc@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: f1048f2c-cd1b-4b96-7b11-08dd95bb406d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vUjEDQ4SKxQiT010imz5KGJXJAnr/Y5o/gKwwpZ6KOIuEskz9YTQzqtyywdZ?=
 =?us-ascii?Q?hZwivuu2uSGmH+MvHw0p5qjxsz556e9p0sBs4yNC3eL/0OKJiNh7JtY6e4At?=
 =?us-ascii?Q?FLT2wiwam70RwC7DGoZ/jwy2yByB8rABNnIhf1FKL63A/NU7G+OsWoNgXdkR?=
 =?us-ascii?Q?rqqWrSWcRfUOD9LpDmMbHXyjrNtj5x3wMGBrx+a9s/uf79Pk2DUtOZ+AzCQu?=
 =?us-ascii?Q?1AsPjt+DHoQvV4ojuHHbW6PBFuWGtHfPiezaxR5ghuo+wTLMhcw5S2Eh6BHB?=
 =?us-ascii?Q?lUhFKz0Sdz82c3RpYBxFmCpx/bXkATtZL+EF0si/AKPDSEL130TTIfTCuf5i?=
 =?us-ascii?Q?2yfiuPakAUlK1lSXVPYiahFnVErBt4K3XFSNcBkAjjNotXmlBNLNF4dZJRYV?=
 =?us-ascii?Q?8l8hl1ybEGFej1qVotWmsPdlBbq0PvvFHvSdi3b83y/nBX3EvXhIAofCSbiC?=
 =?us-ascii?Q?i0hiCvnR61kmzlmWWOjTYgpxm9+wmEV/lBDEVlTqhxHyTRdqyVDHYrEcQw/W?=
 =?us-ascii?Q?OvU2qKmJvg18XvE6+vf/SBvI9bEocBw7aoWo5x/Ir/gaKk6YmnsEGbSKnZEV?=
 =?us-ascii?Q?DVgScrQLDvqAWdz3xA8waS40anlSMa7cUMR/VTdqf2EqSo4gdzUPlxrH/qnS?=
 =?us-ascii?Q?RX5lfK9iNWGskrr6fXU4GqNO1ov4hp7DmiLCTaPLiEUfKa/aOLUotoiSDsX6?=
 =?us-ascii?Q?ch5b2cGvBVzhY1bEg2LrmWKno10Ule6n/EiI6NqJrdvOM9uu23rbqAs3Oo9h?=
 =?us-ascii?Q?M6mcufRHXgMrElGlXsMNPaW0nwn18wYTe9bFzq4WxQaDAUIsiVGPabOAG/l3?=
 =?us-ascii?Q?hCSP+u5jU6lEbPojVw/SV/81SJd/OtoremlCyIpML8BvhRVidPj+VaFEedfk?=
 =?us-ascii?Q?QOopcekhSokzlko+GIIC8hY8US7eqxf0++fi45PdGmA+Q2nwd04AsKaAk9oS?=
 =?us-ascii?Q?LCuSAzeUaOOZPF8ythjcm2WXtRnMZZkY5HduyVUXKmYGuedGjRGNBeYgVSN8?=
 =?us-ascii?Q?brY2nM//Jvu9UfJBzgZKh9kkZe/wcUN1ytpxBtETDd8Xc1A7dAA669arsE5R?=
 =?us-ascii?Q?fijGTgAerxrME/c/0FzUsU+3SgsT8AG0gdj9BTfI1hegVzafo+/lFlp+LH6K?=
 =?us-ascii?Q?BeAMoyrtevzeWfFrpkPUqGFR83CIj4G7QModnYtv0kUpdMAADajC/NIAdNV3?=
 =?us-ascii?Q?aBECmZPpY1yVNe5RmVqZ9oGVIHGRTFctdMajLdvp7bewU4bYtaL3kuvyQSNR?=
 =?us-ascii?Q?UtqMvk6stm2bPl8tD4vrU1nbOd/Hmn7FMY0F4LFPc+cfxIn6hHmvX5hAJ1mJ?=
 =?us-ascii?Q?MMkwPwwPia31bXqcYrRZrjad82HDg0F/GPXIQQ3CXVCfp9zfGOytsQxdMSVz?=
 =?us-ascii?Q?C9cgK59qKAS/yIdOEdXosDL8kYVprfjy4c48AMcR5b6sbeWN8RBLJPYt9l7q?=
 =?us-ascii?Q?OnKzzF3bQHwHBQ/b8PMelNzwd2ryKIkT11gYffmI+V4zgLfnxoxM3IIufjIv?=
 =?us-ascii?Q?5YpcEibeNNKgOsEb9VunI5a+O429IC40COSd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:22:42.7320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1048f2c-cd1b-4b96-7b11-08dd95bb406d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359

The new HW QUEUE object will be added for HW to access the guest queue for
HW-accelerated virtualization feature. Some of HW QUEUEs are designed in a
way of accessing the guest queue via a host physical address without doing
a translation using the nesting parent IO page table, while others can use
the guest physical address. For the former case, kernel working with a VMM
needs to pin the physical pages backing the guest memory to lock them when
HW QUEUE is accessing, and to ensure those physical pages to be contiguous
in the physical address space.

This is very like the existing iommufd_access_pin_pages() that outputs the
pinned page list for the caller to test its contiguity.

Move those code from iommufd_access_pin/unpin_pages() and related function
for a pair of iopt helpers that can be shared with the HW QUEUE allocator.

Rename check_area_prot() to align with the existing iopt_area helpers, and
inline it to the header since iommufd_access_rw() still uses it.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h    |   8 ++
 drivers/iommu/iommufd/iommufd_private.h |   6 ++
 drivers/iommu/iommufd/device.c          | 119 ++----------------------
 drivers/iommu/iommufd/io_pagetable.c    |  97 +++++++++++++++++++
 4 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 2f2a47a2f9ee..e04dcc79d309 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -115,6 +115,14 @@ static inline unsigned long iopt_area_iova_to_index(struct iopt_area *area,
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
index 16767c231580..cef3e0e0bbb2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -130,6 +130,12 @@ int iopt_cut_iova(struct io_pagetable *iopt, unsigned long *iovas,
 void iopt_enable_large_pages(struct io_pagetable *iopt);
 int iopt_disable_large_pages(struct io_pagetable *iopt);
 
+int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
+		   unsigned long length, struct page **out_pages,
+		   unsigned int flags, bool is_owner);
+void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
+		      unsigned long length, bool is_owner);
+
 struct iommufd_ucmd {
 	struct iommufd_ctx *ictx;
 	void __user *ubuffer;
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2b1ed5c8dc5b..0f2bda9e9d84 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1239,59 +1239,17 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
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
-				min(last_iova, iopt_area_last_iova(area))),
-			false);
-	WARN_ON(!iopt_area_contig_done(&iter));
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
+	iopt_unpin_pages(&access->ioas_unpin->iopt, iova, length, false);
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
@@ -1315,77 +1273,16 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
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
-					  flags, false);
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
-						  iopt_area_last_iova(area))),
-				false);
-	}
-	up_read(&iopt->iova_rwsem);
-	mutex_unlock(&access->ioas_lock);
-	return rc;
+	return iopt_pin_pages(&access->ioas->iopt, iova, length, out_pages,
+			      flags, false);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, "IOMMUFD");
 
@@ -1432,7 +1329,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 			goto err_out;
 		}
 
-		if (!check_area_prot(area, flags)) {
+		if (!iopt_area_check_prot(area, flags)) {
 			rc = -EPERM;
 			goto err_out;
 		}
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 51efebb1c6ed..3b164d364e53 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1477,3 +1477,100 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
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
+		   unsigned int flags, bool is_owner)
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
+					  flags, is_owner);
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
+						  iopt_area_last_iova(area))),
+				is_owner);
+	}
+	up_read(&iopt->iova_rwsem);
+	return rc;
+}
+
+void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
+		      unsigned long length, bool is_owner)
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
+				min(last_iova, iopt_area_last_iova(area))),
+			is_owner);
+	WARN_ON(!iopt_area_contig_done(&iter));
+	up_read(&iopt->iova_rwsem);
+}
-- 
2.43.0


