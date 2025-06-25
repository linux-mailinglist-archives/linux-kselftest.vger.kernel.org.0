Return-Path: <linux-kselftest+bounces-35799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93048AE9013
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 23:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F21E3A2F74
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE0220F098;
	Wed, 25 Jun 2025 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cgym6UUS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205033991;
	Wed, 25 Jun 2025 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886326; cv=fail; b=GRRbYXSxS4LDNkiMjBIWKIiFNINKgpkC59XIcIp55ST3hZgyNISQrLuTrnoxWeNGav9kP8SjLE7/Vp26MrbnalG8MPkMcKNG/ycpvLTzkMVPC+OZg4wjnsDdpCBLHsRkbQegxxBUf0u9DIxWBOW+vaf/2NYOmGq8NWLdxeeZ/jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886326; c=relaxed/simple;
	bh=TV9ypM8J6LJ72afu8kZMZhflvBbo9h5N8tnq86gCmQ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQcfS7bCOeaDNwi9kbpcvE9RaYgHZerYOUGqrx1hei45LEOC1rjdlYsXGnhzQrbNxQuLJtIYOlaeyt3Gu8ww7RBMPY61oSKQ6qR+d9oXOIBqiyGIm+3IKXiKJPcB9k/V/Hb3yiLeqdqL3JXSnWPRNmmf5BNK4oIxLrfFucA7JR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cgym6UUS; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5RIwQjc6IQ9BPMfErXCrAhRANgOAHeGtft/2X2+KUTTIhhle2wzA8A4hke8UtIhwCUBxtXK3w+VIC3wlJcwVHrsN3RBr+HlP96+RdgBTfvhVfxnBl91WNCHVlcCYiBJbeVjxDZPqCChiX1pmpQWmnsGEVnIv57tTkqGNs+bLm+mGVHb3zeFX6n6AvA18p8NAI0s+K32L+KuXqHz6FydQB5W0lzYkXXGZalnNpdSwKaUcAIUwZjiQh2j4BVr+O+hNkM2fvW9QMT2IpGlxgCqT0OR9aG6d6jGAjkfbvnzpxw//IGHUDL3ErH4bm88s9jk1rfc4Nnq8Su2B+cHCQgByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blt2DSE/fcm1N2FSCGYfG3mZXgqscGxW/mz8PCYmkQk=;
 b=IFKqPDXa53pRRPfdbz4VUMhm1PHDlEgeUQ00/Q6iOhj6ESKsYx+bITiIkojwImH+IMQZo4JiFtp52hl2ehXJHLdCn3V1F3AN7JAvIkVsPuxtgd1S6UFyFWx1cQ59H+yi7duiUrOoINa4MyePcoFtxhEF1sUzXQtXD9E3zfE28fXP/rPAVy1KT2/Uy4yaBhqsiDEr9ln/JFpXNb7UWyjEpyEdhqX4//q/MqwQ86Ri+TpQdDO7UgQikGUVK0eaZmx9wMtL/+L84cOfFHzhpYkiMt89P+LPRhr8GiwWyRXl+mlMGPvSS0AIlANmGfZJrI8FH8m+XVp6FV3O7LhCBEYErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blt2DSE/fcm1N2FSCGYfG3mZXgqscGxW/mz8PCYmkQk=;
 b=Cgym6UUSE1sZN3ZNs75LMzouHel5jhMCGWjqMrijuc834Nk76qqOWWVolVVZfLebKS+JzE2ITrUTG5RGBYyPe3SR4gEwDPTos0P3jxhw8AfqqDXQc/rQwyUPXXtJOZlEbMCIbic/FOwhrjpMDdiImxitQwEHkG19mAkVX1qpDRNO02285FHKwAgzmOS3Y10HEfv1U6Crhy6pO4LUSASjZySsqgPPV2TujfqNqP1XjV9zAFSdP+qD83pyEXfegPjS0S8j++2AKJAvHkCn+IHoMkCML5bOP+FYyFXJFf31I+Zi3fGDUDEMcgH33OYF9j0mKxwtMAKg5qxVtVGtbXULMw==
Received: from SA9PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:21::21)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 21:18:41 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::3e) by SA9PR13CA0016.outlook.office365.com
 (2603:10b6:806:21::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Wed,
 25 Jun 2025 21:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:18:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 14:18:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 14:18:22 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 14:18:20 -0700
Date: Wed, 25 Jun 2025 14:18:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 13/25] iommufd: Add mmap interface
Message-ID: <aFxnmzhtyOYySIkN@Asurada-Nvidia>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
 <20250616141319.GG1174925@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250616141319.GG1174925@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 660acf39-a47a-4159-87ac-08ddb42ddbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VYqq1U/k7OC7r78ESrMNqX0jjgeeoXgbKVxBCwvVTihHu6hNBpFpoWtB6kF7?=
 =?us-ascii?Q?at71Iux6vpqD8INbQ7hzYCKPVDKgv5zrP6oCavf5vf42cpV09kNn72dvDrX4?=
 =?us-ascii?Q?02yTNQMXwOQCDPM2XvrR9rN+Z8ZN6cSbG3vjjq1dJmeTa5TC+gI+Uy/P1D/L?=
 =?us-ascii?Q?dwrDpabG6zlDtkwDNO+euXIvG4D3Aqfk8PsMXEBfvDe3LdnBQGdhz5y39BtC?=
 =?us-ascii?Q?WN5qiVqB9yBWSNB+OVD+tkmu5sZForywKpc1FqhKPAGnoWCrLhbSz9DQPM6e?=
 =?us-ascii?Q?pzDfPArO4mTLU2F/9D7vhmlyjdsvYHFoh1GPP59vZ0KrlUmDaDz5qIDsdxzp?=
 =?us-ascii?Q?C3s1QRZJlqf6mQiVT3xUXNQPmZwNhMtcOEHAkM96j+Ta4gpqCMHPvWu/s9ZW?=
 =?us-ascii?Q?YV5y0G9vQ0hlMJ3jMfg30sqHX4ZqNMdcPEt2msIA+kfL7QAQ6sxKP2InZfB/?=
 =?us-ascii?Q?SEarcEgOME3byN8xSACgC9Q1XMq88W8R9kAfliI+A9IWdiSQG5lopfQPr28I?=
 =?us-ascii?Q?RB6hhyVSg+Al/9jrT8gtdOpurzy5VXW5BfPvCI0nuP59hM/ix/EVwUCqhawj?=
 =?us-ascii?Q?jlURjjg1NmIcbxYMpC95LAFg7R5BeLXDn+cgnJCvJIYcA+sBv7Zsv88hy4j/?=
 =?us-ascii?Q?72VQdUVmAh+1V5dZ4DWfXYPi7P5gmpB2aw+pWaZZJb5hWrh9F97XuS4Gov66?=
 =?us-ascii?Q?nbE8zpJ16nCpJcKo/jZ6g1QXHTy+x6ggp3jXeQP6daIs+3r+NJabL1pAPcW8?=
 =?us-ascii?Q?7KSWEXqPabnQSe2WmaubiZ9nJoRePPGOIqZ08uhbhNI2Arfgd6ERenRbNKhe?=
 =?us-ascii?Q?ZUh+4YBApsMdH8Nn/UPLYzmQ09ieWtLOT64GvBYoMgA1EpmeZ/gkAT2iR4iw?=
 =?us-ascii?Q?EzNvLcED33oBaRiwGvCRELIrO7jQNZ6M+raUc37lRUGvU4gpCF0SqEHD5qPH?=
 =?us-ascii?Q?wPbvquphGdRNcNCicCzYWj7K23wQAvegtI+tZ5GX6c7jDmkl1vfLZqfYl7ig?=
 =?us-ascii?Q?Rz8WdOK01hUrOeyWn9Gqaxn/AdBybio7tydDo48yxTp2rGjrmgxigo0Bx3EM?=
 =?us-ascii?Q?g7TMbcWU3dC/+3rqzs1QfhVaSyE+NPeQFtG1lpot4+xoZ4DcQ8Nwaws/4PNz?=
 =?us-ascii?Q?iTesKHNw/RL+empwXz2VxVZ8H4LBMkSd3bwQA2j1AmjeULQi2G36c2aHrPn1?=
 =?us-ascii?Q?na7e03qhtWPKznMALhNGzeGnlNnl0LVFeL8apjXMxiz3LVgtniXvsV1iKYbO?=
 =?us-ascii?Q?v0AoXa2r0ars+JyOf+u8sxmk1Z6KOBqOPad90dbNjDAB8W8gBgDaabRthwA1?=
 =?us-ascii?Q?yjzEKpE2+TdijJvgnAfuiJFVRx0BtnYwRklKsT/3EPgxnKL8IfRytjTWv2O6?=
 =?us-ascii?Q?Izre0fRTAEpxyCi8y+i2eyf/QKWAXZw2DVCNLhMn3v0/zuiBDZjU7pmy9+Ho?=
 =?us-ascii?Q?K9iH5o2N3ycLgN6/eiIUCtJFYjuIXv3SRPnfQ1EgXkZl/6kTYZDo4PDGtNAT?=
 =?us-ascii?Q?asnNxGuI/SzeV1PzyJCc/1WN/clO8uC3t6R3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:18:41.0261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660acf39-a47a-4159-87ac-08ddb42ddbdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660

On Mon, Jun 16, 2025 at 11:13:19AM -0300, Jason Gunthorpe wrote:
> On Sat, Jun 14, 2025 at 12:14:38AM -0700, Nicolin Chen wrote:
> 
> > +/* Entry for iommufd_ctx::mt_mmap */
> > +struct iommufd_mmap {
> > +	struct iommufd_object *owner;
> > +
> > +	/* Allocated start position in mt_mmap tree */
> > +	unsigned long startp;
> 
> pgoff_t, looks like this is already in PAGE_SIZE units.
> 
> > +	/* Physical range for io_remap_pfn_range() */
> > +	unsigned long mmio_pfn;
> 
> physaddr_t and maybe don't use pfn?
> 
> > +	unsigned long num_pfns;
> 
> size_t

I made the following changes, though I kept "unsigned long" for
"vm_pgoff" aligning with vma->vm_pgoff:

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index d797b77e878c6..73fcf3a89bf82 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -53,19 +53,19 @@ int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
 	if (!immap)
 		return -ENOMEM;
 	immap->owner = owner;
-	immap->num_pfns = length >> PAGE_SHIFT;
-	immap->mmio_pfn = mmio_addr >> PAGE_SHIFT;
+	immap->length = length;
+	immap->mmio_addr = mmio_addr;
 
-	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->num_pfns,
-			       0, U32_MAX >> PAGE_SHIFT, GFP_KERNEL);
+	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->length,
+			       0, PHYS_ADDR_MAX, GFP_KERNEL);
 	if (rc < 0) {
 		kfree(immap);
 		return rc;
 	}
 
-	immap->startp = startp;
-	/* mmap() syscall will right-shift the offset in vma->vm_pgoff */
-	*offset = startp << PAGE_SHIFT;
+	/* mmap() syscall will right-shift the offset in vma->vm_pgoff too */
+	immap->vm_pgoff = startp >> PAGE_SHIFT;
+	*offset = startp;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_alloc_mmap, "IOMMUFD");
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index cc9088ba5c812..ebac6a4b3538c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -61,12 +61,12 @@ struct iommufd_ctx {
 struct iommufd_mmap {
 	struct iommufd_object *owner;
 
-	/* Allocated start position in mt_mmap tree */
-	unsigned long startp;
+	/* Page-shifted start position in mt_mmap to validate vma->vm_pgoff */
+	unsigned long vm_pgoff;
 
 	/* Physical range for io_remap_pfn_range() */
-	unsigned long mmio_pfn;
-	unsigned long num_pfns;
+	phys_addr_t mmio_addr;
+	size_t length;
 };
 
 /*
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 339a269ebbc81..0fb81a905cb13 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -514,17 +514,15 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (vma->vm_flags & VM_EXEC)
 		return -EPERM;
 
-	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
-	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
+	/* vma->vm_pgoff carries a page-shifted start position to an immap */
+	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff << PAGE_SHIFT);
 	if (!immap)
 		return -ENXIO;
 	/*
-	 * mtree_load() returns the immap for any contained pgoff, only allow
-	 * the immap thing to be mapped
+	 * mtree_load() returns the immap for any contained mmio_addr, so only
+	 * allow the exact immap thing to be mapped
 	 */
-	if (vma->vm_pgoff != immap->startp)
-		return -ENXIO;
-	if (length != immap->num_pfns << PAGE_SHIFT)
+	if (vma->vm_pgoff != immap->vm_pgoff || length != immap->length)
 		return -ENXIO;
 
 	vma->vm_pgoff = 0;
@@ -532,7 +530,8 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
 	vma->vm_ops = &iommufd_vma_ops;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	rc = io_remap_pfn_range(vma, vma->vm_start, immap->mmio_pfn, length,
+	rc = io_remap_pfn_range(vma, vma->vm_start,
+				immap->mmio_addr >> PAGE_SHIFT, length,
 				vma->vm_page_prot);
 	if (rc)
 		return rc;


