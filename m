Return-Path: <linux-kselftest+bounces-34075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 665FFAC944E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A61189699B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01232376EF;
	Fri, 30 May 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gu8G0STV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45A237194;
	Fri, 30 May 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624406; cv=fail; b=JoRZCiJcqxmU/9Br0yWNRrZI4vizp1z/tWRIaf8UtFZTmGigJnhMBxYGet0fzlk8eKHmuw2qHEtYePVDE11N+3iGBORNShge0yryiNn8NS4smDsgH6Gzynt7ONBR1pjtPBKd+2XauzEptGQx0crP1xJw+vJDHRd81F5jlXbGJ2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624406; c=relaxed/simple;
	bh=kuJ0lGrRieFOIbIGPxRGDX6Jpb6Hazn2467keGL9rUQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2sUzT5RRMR7ZFtvtEpg7L7O7sOMh5A3j8Jvu+qYPklboJzjmv8oN6icr7cFERy3Fr7c7+gxM4CPYec+UDt0BbwfXCmWYtm+P5xe+Fcx7Vh0frehDhSVXZLC7TGSJZ7kKxo/nz6eKoovm7r3jsEXz9/laNmHx+aR2Z4921XnMN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gu8G0STV; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcZ6oj+BU29soLouM7XKGmFgi7x778UVFuskC6RRnoF8VIhDz1dU2XzJS/hbrriM2bhIn4327UEwqgWSBgFS3DcYKGShoEY/+zftO56E6cNSf1mWsoOZLZAw4RW3orXm6AOvY+xrN3d4mAqDZcT9ez6VtfMoTsqjTZ7uFQuACaSWSg4Al92niCc1oO40xOkXpXIEgaDmljwBueYAovrYBcu/wF7uNykRj67swPkrdT8M0gque6NDsGn8dc80e9vsE1k3HfXK299u92wuuC4U1x4pFrQCyZlKcnF14agT4eFdpkhZu0I8mpYKbzAAISoq6xgIe9c3xIk7myXSBj6f6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgyhSIvYxhcQpnyHPjeN10wIwGb9fO6yvOQRwdK7w5E=;
 b=GX4CzoecbEkvdIjl6nvBMRLPdPHHpeFdy/RVD13ys8zmnYRocfOXKIJhHpFsv6sZZi5YFncT2vD6+5c2NK0IH9UVn0XAOqyWTvDoNcjTyPpAhyHy4/40Z8U0BwoPMMQxMDU8QYCC86fr82/OWMMimkrvF1iydW3Zz/pcTF6191hEkRu8YxK+iqarixIAP9EGS4yHb54XBz+W11XF3772vYkIiTeCIlbpdEgB2TgR6jX/eqImu+lZCvk4ZY1S52ZR0vva43mTQ88h3nrWavvHF238+Ve7yswLmmQco8MTdUI+ZzO/WBJvMrSTCHl/V+MbCatAkCEg9iWcMnNIvmNi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgyhSIvYxhcQpnyHPjeN10wIwGb9fO6yvOQRwdK7w5E=;
 b=Gu8G0STV72omwY2laS3AVVnrvX2quOR9dZxWDJL4Mm9pxIY/Zx4E9dveAukEaHmuTJe2pfBQ+nBKh865Wy4UpUQnIfw8KX0ex77JLbjSfmbi5bRHeGe1BADx0cIpsNr3G12VnZMeqFqgP/bvhT9VtsRhatdGxeaWSLT/q5uhwMtXBq7vX7lkZQ1ZlrVRi/OBttU+CttSpcwdPndFBDWL/R9U2MRXtdcodvhtjCY7fRZXJkc4z9TzF0R5Vq+ZvqXQa2NIJvlwdaGj1V4uoT6PDxM9TsOpxU7Rt8lviiunpQ+CJrK4CiyKwAaBHcNNpOeI8YPBfF6QKfkHa/Z6pDx9AA==
Received: from BN9PR03CA0888.namprd03.prod.outlook.com (2603:10b6:408:13c::23)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 17:00:00 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::6e) by BN9PR03CA0888.outlook.office365.com
 (2603:10b6:408:13c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 30 May 2025 17:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 17:00:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 May
 2025 09:59:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 30 May
 2025 09:59:40 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 30 May 2025 09:59:38 -0700
Date: Fri, 30 May 2025 09:59:36 -0700
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
Subject: Re: [PATCH v5 17/29] iommufd: Add mmap interface
Message-ID: <aDnj+MD0LexufNX4@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <769a7395def9f68c1ac684fa08a0221957e0de6d.1747537752.git.nicolinc@nvidia.com>
 <20250530162945.GF233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250530162945.GF233377@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 756b3b5d-3a05-4641-b89b-08dd9f9b6a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqFS0yd9ERDvJplyR+o+QbV0FFVEt4K6ZlUk+W2pGwvRIWLffTqNVTUNdBqk?=
 =?us-ascii?Q?YPCz22OJqbEAPZ+A9HffWj2xy8drkBIqfQ4/I7dwK0kN0vNU8MQK9QImczTV?=
 =?us-ascii?Q?v2VusgZQDn6V1csVpxdOOQ6ykyRYRe44kMIxojafmnQROtUVrq862MIzG+zC?=
 =?us-ascii?Q?wTnA/IgeuhgBgysCcdgA/unlDpiM/YrbCzLFpy6UAdoaN4Jg1Ixxqbf2s7A3?=
 =?us-ascii?Q?bZHep7vI2uWErl//iGBeuq0lgkjy8DZL2S99fN+7GnqPYCMpHIb6pMiUxZr6?=
 =?us-ascii?Q?LFm8A85azmyTTkhg+EuN1kCylwBWG41yxqSPQUOJ+k05/Zrb5DnKsXuiAF3h?=
 =?us-ascii?Q?8MG5f5/8Mlo1eoK56oWNOvte0oCopun92zQgwl0XI3qkShd+p347E0JRG6uM?=
 =?us-ascii?Q?bs9T0Fxb7QilZuB3zj4eat5KfmlpYV4PrK6ngmRSqX6IpyRPOUgezyLZhjdv?=
 =?us-ascii?Q?h95u3FUdrluqFFEJRWcNm1hQnlAFCHiM1XdfVsjvBW3KPVnJc6hVW2dx2ijP?=
 =?us-ascii?Q?4TIcbiyjcyP9+RdXI3WGX9+9KPC6GbzV2gNIxxyV/UPJMjHf7meM1pkyA6F5?=
 =?us-ascii?Q?yagC8ETYpUk2iaFYQFUZ1lmQdWHyx9aZbpl5vsYwAMkIkj+zNTTudGQzGIxD?=
 =?us-ascii?Q?Gbnb0SRyixVYK4FjZ4Kf1aTMkK9wko9aghmlH/NER7xjXSfmp7F31TpdUBuC?=
 =?us-ascii?Q?FXldFm047Iie4F+LMGv+89qIfODNNlMTK+AqZHeJzmZeawiL4HO2nWZ0b0CI?=
 =?us-ascii?Q?9+dga9zWD3hchWoKMoMuoJFeXL3a06+NDSCTBOBkvs7xbZQUOoBzpiPfrzMf?=
 =?us-ascii?Q?VFET7ux/rFulkXc0EyoxN8VSJ6g0XTCEdhcM6TE2XtTQSqrKHiRYOKbFdSDq?=
 =?us-ascii?Q?wX+k2VOGq6mPZzSOKPTV8j+/D1rqKqrvPi4cUWdrR8/yj1fsNltxBBI/kIQL?=
 =?us-ascii?Q?juqSJ9V9ojH1VDSgtZor0BvMAQBV1VuwzGOxkB390LzEb7J8dc2joDbj6bV0?=
 =?us-ascii?Q?ylcG+GRkGJI5riPvPT2bKHe3UQypqycro//sxcA76u+n2nK4kaC0hL5C4wfp?=
 =?us-ascii?Q?No7ikNoaCjHpg8bCC4m9SrtW55t+6ZJZ9ZmMn55fcEeA+X0UkeoDhiPc9n5v?=
 =?us-ascii?Q?6mxYMCxLKa0GJYzbjhJOwsx/n/TRzpHElyVGWVHK1UTuOJziGowzY95kFmQZ?=
 =?us-ascii?Q?InjH2aJiNM0ZMIPbu+GDytZE2aoH8bnoJRyfLVdQXvzn0Xv/4WC8QhQ3J4+S?=
 =?us-ascii?Q?MAPEp8DtG0oWu1wC8uY4+pvoNZAW8EIcC4f4l973i4v6ISFPa1GYJlduCe3B?=
 =?us-ascii?Q?8XbqhRufESiK6Scp+zodAcZPyrQqTYSKRKr6eNZ5gtlJv5Da/yXdpnG3etSn?=
 =?us-ascii?Q?Z/isRfrEJmsvxiXiFMorbeVcMwI4lNLqKHAs34jDrmKJgTJDM4/hr3WkKEur?=
 =?us-ascii?Q?+6RktuGO91edkTUOKB1fteMIZJCCSY2xQFi77XLmM+F9nqPiMQh1P/Fk4XU5?=
 =?us-ascii?Q?7r++gRQ/eo5o1eGSTLqBs9IHBm+4qnuGH2pGoQxqrJ/UTpKjJbTjTChGkw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:00:00.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756b3b5d-3a05-4641-b89b-08dd9f9b6a05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Fri, May 30, 2025 at 01:29:45PM -0300, Jason Gunthorpe wrote:
> On Sat, May 17, 2025 at 08:21:34PM -0700, Nicolin Chen wrote:
> > +/*
> > + * Helpers for IOMMU driver to alloc/destroy an mmapable area for a structure.
> > + *
> > + * To support an mmappable MMIO region, kernel driver must first register it to
> > + * iommufd core to allocate an @out_offset, in the context of an driver-struct
> > + * allocation (e.g. viommu_alloc op). Then, it should report to user space this
> > + * @out_offset and the @length of the MMIO region for mmap syscall.
> > + */
> > +#define iommufd_viommu_alloc_mmap(viommu, member, mmio, length, out_offset)    \
> > +	({                                                                     \
> > +		static_assert(__same_type(struct iommufd_viommu,               \
> > +					  viommu->member));                    \
> > +		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
> > +		_iommufd_alloc_mmap(viommu->member.ictx, &viommu->member.obj,  \
> > +				    mmio, length, out_offset);                 \
> > +	})
> 
> Why is this like this? It's weird, just

I was trying to follow the pattern of the other two macros that
asks for driver-level structure. But it seems not necessary, as
we have iommufd_hw_queue_alloc taking the core-level viommu..

> static inline int iommufd_alloc_viommu_mmap(struct iommufd_viommu *viommu,
>                                      phys_addr_t mmio_addr, size_t length,
>                                      unsigned long *offset);

OK.

> > +/* The vm_pgoff must be pre-allocated from mt_mmap, and given to user space */
> > +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	struct iommufd_ctx *ictx = filp->private_data;
> > +	size_t length = vma->vm_end - vma->vm_start;
> > +	struct iommufd_mmap *immap;
> > +	int rc;
> > +
> > +	if (!PAGE_ALIGNED(length))
> > +		return -EINVAL;
> > +	if (!(vma->vm_flags & VM_SHARED))
> > +		return -EINVAL;
> > +	if (vma->vm_flags & VM_EXEC)
> > +		return -EPERM;
> > +
> > +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> > +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> > +	if (!immap)
> > +		return -ENXIO;
> > +	/* Validate the vm_pgoff and length against the registered region */
> > +	if (vma->vm_pgoff != immap->startp)
> > +		return -ENXIO;
> 
> This check seems redundant

Hmm, I was trying to follow your remarks:
"This needs to validate that vm_pgoff is at the start of the immap"
https://lore.kernel.org/all/20250515164717.GL382960@nvidia.com/

I also added a selftest coverage for this check.

Thanks
Nicolin

