Return-Path: <linux-kselftest+bounces-31262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC96A95572
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234D07A9199
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8581E2606;
	Mon, 21 Apr 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ranJD/Ta"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29D38382;
	Mon, 21 Apr 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257556; cv=fail; b=sa9mPE9XoJgF0vqQqZ1HspKE+CN4Q5ZwvF8XvEJKUKS1GsFnK01iOtJFZA8zrzyHReZoZpbcuLawfXYJsdCPbzMNNNGIT0GBZRA0Pc3w3UvdIBThkGVv6NjDGKl0L1Dh9ju7/hqdxyMiToZFWVKhQpz/TukP5G+Q0P+INhk6IZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257556; c=relaxed/simple;
	bh=2v6HYAoOoVnXSpAD9WQPeSouGleOGD9BKT8SyMg92JQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsDXejcYT7es/nJLplXgb2RgwxlePFqrvV/yWZt5tW2iYgtbqgVd6XO2/czaenBr8NxJzR8A+tLGyOq5fI0qNNgy2STRGctqI3ATCzQD8YRIwL/9xOzKHCPL0A/5335aej1WZd8aUBR2tqJgdBn6SP5/zKYvAZWjIaGZERBUpg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ranJD/Ta; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9CkPMqz+afyoOdzrcU3vdOi3Dl2MCF/vnN0aFVA6eMHbxBVOvk+B10RvoAGmavcjn7yK6chLPo/4nQfdCuOpYafEErfHv9n78o3xj7BM3cfNYi2jUPsE9gwFhTSJZdqetiEQWnEHXiKHQy8w/o5ZEOAXJeq+RhgZTemGWX4yeaQl6BxQx11kX1dpWqq+IwparcoJVirtZyj5rJwE058ksEd3M4ibW1zqQI46MFrOVUQpELlrWuX10jYHOGKNMxoyWFQrtwYIa7JWMJNd5jL05CeIMYyQwMet8QWJ+7L7hQh+CUK7G6hTAmHuk32NndEdzX2hWXA0wLnaIbTpIaqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpTM7giG0T9ltkpCdAciNqI7mcB0BvYyhvCmbixWZ6o=;
 b=rNzsuDmp17AzXrMoKDTolHT/snpqFJnFbw5W1d3vayWQXDPXUiQBQf8lAwn/bAywBqo+Or/EN5O1ZL4r1DdFy29ZTyNu0NUAfWBzVNlkldUnu8yGvtNjMnBFiaa0EaY/igKKFe3dncWXh2u7y0fgWcSUcv1CzWtqPx5P+yk9tr8ZdHJNnMRGFWa2S/zAaQe9QWEdVt8kCXQxW+0La1WICLBSpnYhss2lH1gF7sMGoomXl0G8+Eg7d6vEDv6vLoHKDG1BdnFqlPtGklHRJSgXFkEwdWUIvIiga1/ngH/KJhxoFm4Hj59h1ZBIC6ZbgjSPzE+ESEFV+ZV7i8z1c/ve7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpTM7giG0T9ltkpCdAciNqI7mcB0BvYyhvCmbixWZ6o=;
 b=ranJD/TaUjK+X4Kh4mwcaQsJDR5zB8wuEUWu7ClBmuy+B9rhhCOKpxt7JQXOCZVzBmnJAkrt0l/Cr08jOzEq35E41miSPS/pDA4VzPpmUHFX2dHywViZkrItBSnvjV8SkkvxlkQzQ/ryfTnsLFQKuGaew0PqcFnM63Rh/PEa7OY1d1CN8RxZNzxvtuzuczgfg0f9ovcWQ/xR1QpMqkL6N0GnPw2azK3BHzHvaimjj/NGKKdmYhyGlgVTxEbQD1Fz3vf3Uz+bthNZcM7cTjRdYRKx3oRr6rsyTUW5+F37445Ykm+bacddb5Abm9FxnUzfl2RUGcBjzKrjFgDZ8VPE6w==
Received: from CH2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:610:4f::15)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 17:45:49 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::df) by CH2PR18CA0005.outlook.office365.com
 (2603:10b6:610:4f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 21 Apr 2025 17:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:45:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 10:45:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 10:45:30 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Apr 2025 10:45:28 -0700
Date: Mon, 21 Apr 2025 10:45:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 10/16] iommufd: Add mmap interface
Message-ID: <aAaENzZDO9/HQSKX@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <c332a8701959c098f747dd8e8fa083ceda2bf2c3.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB527664BDB7933FA0B7981EE68CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527664BDB7933FA0B7981EE68CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 268212cc-6976-41a3-c273-08dd80fc5a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9oRdDW2ZODi9xFZu0hgq9sQL5KdzA2ifXoE6Y4lPXzqkSWngxaPzJt/TEqNG?=
 =?us-ascii?Q?6vx2RRoVUMqj329FiQaZxTdDoySuVy89IoYZtMoOAQrsiiIulDI1/3PUpBgV?=
 =?us-ascii?Q?T/lEjRoHCgtH4RbYCf/zvTCC1EPN+gEb+CR0xFszun8/zovl+WFph4QxXbVD?=
 =?us-ascii?Q?JFXlwhJYnY9J7pIC1f13ZijBb2KyxcmoGUyTcJKrZlO1gZc+zXtFD2983vq6?=
 =?us-ascii?Q?ATHlksX4KhBVzItnVnUWutiLVHxN0VQOdkd/CKy86T4OIg7ATafYg8lNrl33?=
 =?us-ascii?Q?TnkgNGY5bfgYcCG67GH7QEe/z1FLLvnco8RkZ1HSsT/BOux7rWO3ImKkEdix?=
 =?us-ascii?Q?eD+t/ph0KxxCaTMHwLjHcFLtjZdfNu5qEuoczYywH5n/yuWW8dXqcxFkcjaa?=
 =?us-ascii?Q?wuZC6HcSMfdnpUl2i+zxHjMfvnrMHmUthWUgfMuOIdMsMi8E0HE9YSty+W2i?=
 =?us-ascii?Q?QWM/cHcESlvPmJ5HFn9vriFSDsgOszqM9QH437h1OdL4tmxOzatw5KO1iKgb?=
 =?us-ascii?Q?5YITNRFsPciRsFHihUOBUJnU3Wo+J8dlqTN/8wUkZrWdfmlJjTq9fRFbtOtt?=
 =?us-ascii?Q?V8pudb7x1vUipK0wuEbbz8aGrEMdpR92LV4GKu1G34MYXDsxHmnloQ7TKMbn?=
 =?us-ascii?Q?62UDJWFA6nxWDaCqrlqfBhDELV1IlwcZH7n78qkBtK8Rlht5+rs/E0E84k4r?=
 =?us-ascii?Q?4oDgoIoL+/AfZHagy6D1xyS8JbVjz6P68A5S8h4+dqQbnYqfijZ5OcdrNuIo?=
 =?us-ascii?Q?0+tM1nJBeTQjp5Mv6gzreq3h5IYmAS0TKYthqpltYMOTABvG/ChRQmehVM1N?=
 =?us-ascii?Q?8r6Je6iRKVr3JsSQa2W72BRBkodyNFXkADseYnG10uar89BfjnXW67yD/DdT?=
 =?us-ascii?Q?Wsc0tqS7ZXxFdSWFRrb7AxesKjX6EVQ0jAQ/X7e9RwWos4FKiv7x5VUNJDmg?=
 =?us-ascii?Q?fCVdnIqjPuPD+moGWC83ITXmoaHWNLxe/qLJKCGex24lIqSAmbO7ASDGcrvJ?=
 =?us-ascii?Q?XvYLMlA2Py/hljtAYqSG/rab8+DuPCHC5D//t5bC+vQM+QzDWDhU5sFr9l6/?=
 =?us-ascii?Q?Urg2jw+89C1yLjd7nCLoC09xYR/2+Awwd+rHb4zg5XIwAx15ot7PKCqiKLJv?=
 =?us-ascii?Q?vrHiP7H4IPyC1EgdyhGC7toQoUSzmG7mHcb7q6AE+q9+t2OEECsWSk9UZoGR?=
 =?us-ascii?Q?2uEWYha/m0A1BRkT7UmP9INt0iGoFmUM9r25HeuxywvgLUn5OXWEMu6JLypi?=
 =?us-ascii?Q?CNJsO8B/XjPK4ZGmPQLXiUt2RqzkwESjCkrn/wnslQiXZhlAem6cC5Dh5pXR?=
 =?us-ascii?Q?tcVQCvfDx+YH3ZJYlZOY+JpuA/MNrVl0s3GCykg2GKX3ayH1jWBZWU3A2MYb?=
 =?us-ascii?Q?Oa8On0t8HdxPsMluG2X1UmQJoPnwq11tXhOgJeZ1ESrzWR0Daif2p4uoOFxg?=
 =?us-ascii?Q?3CtpS+9j+VAEIS6qN+QltPdRDPTgHAWqGq7H0y5VXft/GI2O0LKjvbEZIM49?=
 =?us-ascii?Q?58K6MwNrooiELRx0Er+lcIXuMfwePQ3EnNPE?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:45:49.4259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268212cc-6976-41a3-c273-08dd80fc5a88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339

On Mon, Apr 21, 2025 at 08:16:54AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 11, 2025 2:38 PM
> > + * previously given to user space via a prior ioctl output.
> > + */
> > +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	struct iommufd_ctx *ictx = filp->private_data;
> > +	size_t size = vma->vm_end - vma->vm_start;
> > +	struct iommufd_mmap *immap;
> > +
> > +	if (size & ~PAGE_MASK)
> > +		return -EINVAL;
> > +	if (!(vma->vm_flags & VM_SHARED))
> > +		return -EINVAL;
> > +	if (vma->vm_flags & VM_EXEC)
> > +		return -EPERM;
> > +
> > +	/* vm_pgoff carries an index of an mtree entry/immap */
> > +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> > +	if (!immap)
> > +		return -EINVAL;
> > +	if (size >> PAGE_SHIFT > immap->pfn_end - immap->pfn_start + 1)
> > +		return -EINVAL;
> 
> Do we want to document in uAPI that iommufd mmap allows to map
> a sub-region (starting from offset zero) of the reported size from earlier
> alloc ioctl, but not from random offset (of course impossible by forcing
> vm_pgoff to be a mtree index)?

I also did this:

diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index ace0579432d57..f57a5bf2feea1 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -128,11 +128,13 @@ Following IOMMUFD objects are exposed to userspace:
   virtualization feature for a VM to directly execute guest-issued commands to
   invalidate HW cache entries holding the mappings or translations of a guest-
   owned stage-1 page table. Along with this queue object, iommufd provides the
-  user space a new mmap interface that the VMM can mmap a physical MMIO region
-  from the host physical address space to a guest physical address space. To use
-  this mmap interface, the VMM must define an IOMMU specific driver structure
-  to ask for a pair of VMA info (vm_pgoff/size) to do mmap after a vCMDQ gets
-  allocated.
+  user space an mmap interface for VMM to mmap a physical MMIO region from the
+  host physical address space to a guest physical address space. When allocating
+  a vCMDQ, the VMM must request a pair of VMA info (vm_pgoff/size) for a later
+  mmap call. The length argument of an mmap call can be smaller than the given
+  size for a paritial mmap, but the given vm_pgoff (as the addr argument of the
+  mmap call) should never be changed, which implies that the mmap always starts
+  from the beginning of the MMIO region.
 
 All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
 
Thanks
Nicolin

