Return-Path: <linux-kselftest+bounces-32120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A4AA66FE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB34B1BC1654
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 23:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA4279787;
	Thu,  1 May 2025 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4I87fQH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE61278E40;
	Thu,  1 May 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140533; cv=fail; b=g4fT4BhbueTbKdmP3IVOxrd+R6okqI9nWCytBX1CQN2DUs6fqWvp2hq6ZnglGz4JR8RYxAmUpcRfqbOzm8GGKrGCLUMB3fc4W6GkawB5XD1gKbl1TfB4XgvwdeRf/AvLKwkvlny1l0OMWHlby1l7E9bWqibipDn9KnFoTwTekXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140533; c=relaxed/simple;
	bh=BC/QgbFqjqYFikldPboqaJhLS5sFFlJaVr7F43L0fY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tcidtzst2WxD5ygoOO9ZfDi2GkUyS+tlgS5UhNmQxZ1oF+zeHYzisDKKf3l11pQtw5D8UnUP+knPubm5gwffTy622t70zfXa2txiY8hKLPQnFhYRtPtg2VHj5RZKEwo7S8l+CjA2jczXglFdJvXLg1Hc1CTvM1HCrxOL5B/xN5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b4I87fQH; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOLggWnp/LNV/ivaIz2lBV85/HLYhIjCMVYoqMIVK3C6GTi/7oTxoVBszEKi7ZWDg4zCGCPmJpTDNxBS/qpPVMKnPeuoR72exkPiU4vRU7LZCJKkhJjL/8LTVt8wuUne+ZfYvImPLFh6Sd61XlhVXo126UIJx0RvUrGMq1Nq2QCXMIWtebOL1Vrb4/7snrDBC3fQ651wfvxLbyrf1vmtsmrWvNvIJhPSYeMT15eP8A7scVMQUtxMVbTvY07Yg5t4WzJQiBiU0jI7d4XxFt+FbSVIyfrQ5fxdhU3OcoLL9JCc58gdqO7SA6cNb48R0IiHztbs5Jo73dXNuyY7EfXP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsWBy0IAn3SbtCg8ZF92TmCtdg2wAGzLSN0J15S1f3k=;
 b=iv1apLVFmhH/cjqeqDA9CugVIG2drTIn+psswdLnUHj14jjIfbFLdhW5MkYODinbWZEYpfRvNfHDZhb6ebNWPRrsJ4fo20ywGJvdv0tA24yDPGh2SCG1AIrcEc8HHH1kw97P4cH+FsXJMbTX6k8BZiZRALtyp8BbCeCT1nyRqinh32eLN3TskGqOQhjvO4m5Q0u10XcmRtLBzeCqmpiSUNlJndJvBwMpoC8llLWVz/9yLtyU6My9/e0J1hLfz18/eBPlFLqleryLXE8uPO2FHqndUB86xhQxuWRbr7rNQTLzcF7vncyoJNPfPAVMcZ+HcBqq5UAPJ3KTSS4ehcZFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsWBy0IAn3SbtCg8ZF92TmCtdg2wAGzLSN0J15S1f3k=;
 b=b4I87fQHI31kCoDk6m5kryfD/2t8UQv2DOBf/+dHEKFxzGTR2ucYjzXPwPw34pH0PMfW8cLTTJgLkoKs7EqpVTjdAGBW+/oLrLLA8YJidXGu8G+64eze5MFGbbPG6Nv9ICbau/Y4xfjo+NbuhE5XICtZ8U8vhYNKHtNO8BULFkryyAM0dctTu/T1Kr2XyhTvW3C1izmO7g9UUGXiKSXh5pzcCoOI6AhdyAR/8TDSlf/qQkFCNQ6MX7ic59gwvt/kOs6s5IGxk2mZppzc0PRW9MVLLi+xsT83FZ1nWjm4rIiCW5D10EU43QQ/zaXOAsjbptph5TAOJLlE5V1vyzXosw==
Received: from CH2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:610:60::15)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 23:02:07 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::81) by CH2PR14CA0005.outlook.office365.com
 (2603:10b6:610:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 1 May 2025 23:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 23:02:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 May 2025
 16:01:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 16:01:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 1 May 2025 16:01:54 -0700
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
Subject: [PATCH v3 09/23] iommufd: Abstract iopt_pin_pages and iopt_unpin_pages helpers
Date: Thu, 1 May 2025 16:01:15 -0700
Message-ID: <f861aea216e3ad4853a7937c5fab18caacfec4aa.1746139811.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746139811.git.nicolinc@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0945d8-3bb1-49af-62d7-08dd89043249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f9tUSOa1JEWh5fSjzL0jAVZtuvPWXsGP2v2DdJspVptejsalC6dEc9e7uL+H?=
 =?us-ascii?Q?Glt4E1aG8IEV8X9hkV+pP6lDCv9vEKA3gZo3Icm4dX2bfgdhVrh8OYyxzolo?=
 =?us-ascii?Q?jknZy4xaRexTSm7/VTGdVWVodHcsu6GsYrRk3y7eNvYkY8no9GtTyydiHznS?=
 =?us-ascii?Q?nywENOiwjFvvdYStPZzA9R8GnQLPIyScNo87Hlv1R6hNU4zJEfJDr8Spa2aU?=
 =?us-ascii?Q?VHf3nx7VMApaW1RnDvKUQDlKlCOl4RvEt4uErTd+bumt/XWSr3Wvbsrs+jQo?=
 =?us-ascii?Q?ljJB/hw5TjG4FGIMV5RM5w/ZbYZVd0K1aerq9hiyIxVsg+E9HmnCmZsk4h42?=
 =?us-ascii?Q?jeXTa+Cz17Tv8QG5Dpub/GDQJurUD/qtfx1xBikzJTRvOWTRnA57LY4jiImm?=
 =?us-ascii?Q?SomIztAaUx+9bzj/+/hmQkKkoFtEus6z/ViMBUdyGNA5xQ3B0g+ytlOyz3be?=
 =?us-ascii?Q?m388ZwiIfEH9rc+y1Dcz6lzBTssToDv4U/diADMJ9i7WFbvEFrVqxjAw6Z7o?=
 =?us-ascii?Q?uKNFWzsCCeBgrBnHKrFWVbYUtizlzW8cvss5MnPMc86Enqykk+fdncUaEOq+?=
 =?us-ascii?Q?pk9X+Pu/P9/RGuLys2EMHUuyROYb7evym9/JAuZRDM4wRsCpXgmbl69ermWz?=
 =?us-ascii?Q?JxNvrYxxlzZBaD3yZEgrBoxoyaViDRNK41yq+WIrkCT2rGTd0iwL/GbXwzPO?=
 =?us-ascii?Q?+z2DH+T9J3RuiFwU4yfnZuAsjTxSCQoyDIZ/vfXRpvJXwAkcI86Pdp/VIshF?=
 =?us-ascii?Q?Y/dvG7KY1gkNg5dq/RUwp08NF7TswgBXTv0KQrgR+smmzkPVbzIJBgXhZnYx?=
 =?us-ascii?Q?ziQRXuJShXD4/DTDew/PPefy/cJKFK9JlCp4DMzu528YcydMoAwvupo+YDcn?=
 =?us-ascii?Q?7wJO+sdn8dkdu770hBdjKwCPav7Bz7T19C8UqMCZk+/mnSy96162CWFKE65f?=
 =?us-ascii?Q?0g7gr9uKgn/+B5U0zKjqJmXglw8on65q6la16mo68IH8rj3nhCMFRjR8eLrN?=
 =?us-ascii?Q?94xJHCNj6BO2qMO2Qx/H/gM6PZjm2kqg+eCAX6AZCUoRm35qIgwHYGsHhO6k?=
 =?us-ascii?Q?pIdNNkZO3qm+y6K/oazRMZj+EVFHAyvphftOT2XLLfqQXmAS2zJ6dJg92MRU?=
 =?us-ascii?Q?7E8K0/sx5PUpnyUXjOg99P2iB8n1T0d92J43zLV0O8ppjEtGe6cDGmsTsHqP?=
 =?us-ascii?Q?ENTQVGSlKSoSO4ZuXzfEdg8NrjZa5c1OytgIozkQhWPrc/Wi9SsTp3MPoPJV?=
 =?us-ascii?Q?Tq7aVDAqlM9vpYSC7mLKIe3L/mElTob+FXGBDq+UXtHH3fk4zHap1+mla9CD?=
 =?us-ascii?Q?r0YXCs6uQDhke+Q3CTuG3mzkHj2gH2tKG8fPZ/sMLrgYZ18DgfC4JK8VXG3E?=
 =?us-ascii?Q?4vcbZSZEbtnbHyuKYOj5bMy0eGQXhJs62PcWkH4Bc+q07VslIBVtJieAzBC+?=
 =?us-ascii?Q?m/Fb75NDhpgh9y0ED8TDw5J/u7Hf2cq7i9Zr2QoVEM0uRWHXd5/+ayNZmZ4L?=
 =?us-ascii?Q?kvV1AGsI52I5sc/9V+92FegbWvsA6KbWm3b/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 23:02:07.1530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0945d8-3bb1-49af-62d7-08dd89043249
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

The new vQUEUE object will be added for HW to access the guest memory, for
HW-accelerated virtualization feature. It needs to ensure the guest memory
pages are pinned when HW accesses them and they are contiguous in physical
address space.

This is very like the existing iommufd_access_pin_pages() that outputs the
pinned page list for the caller to test its contiguity.

Move those code from iommufd_access_pin/unpin_pages() and related function
for a pair of iopt helpers that can be shared with the vQUEUE allocator.

Since the vQUEUE allocator will be a user-space triggered ioctl function,
WARN_ON would not be a good fit in the new iopt_unpin_pages(), thus change
them to use WARN_ON_ONCE instead.

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
index 8a790e597e12..160eec49af1b 100644
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
+	if (WARN_ON_ONCE(!length) ||
+	    WARN_ON_ONCE(check_add_overflow(iova, length - 1, &last_iova)))
+		return;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
+		iopt_area_remove_access(
+			area, iopt_area_iova_to_index(area, iter.cur_iova),
+			iopt_area_iova_to_index(
+				area,
+				min(last_iova, iopt_area_last_iova(area))));
+	WARN_ON_ONCE(!iopt_area_contig_done(&iter));
+	up_read(&iopt->iova_rwsem);
+}
-- 
2.43.0


