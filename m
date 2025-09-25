Return-Path: <linux-kselftest+bounces-42317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A60B9F150
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF972A5A4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D92F8BE6;
	Thu, 25 Sep 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nartNGaC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5629BDB9;
	Thu, 25 Sep 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802046; cv=fail; b=PGIDxSSJTohu1Pclygeqoe1AVjSuoeyzpA2KUKu4fkc1JQ8ARcgZcQ2kEr1chCmSJ5aw+L2raLT4/wQ6M5nitkSddWEcLuwAAI9Wjj+KJOPNvNlj+VKpLa/QvB8ZephrmptjVLNp+lpP8HDvHcr9p0XpidPn05UXY+a6yIUPcvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802046; c=relaxed/simple;
	bh=zlSczqmFzqFde0cE2SRJZvPMjdRbtki4QdG5Za7Trmg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc4Y5f+Tv7y0j5w+G5VPiSzgT+alGYnmaK5Ird7DrNhe4yTlNuS/IU+KS421s+gjHKqIdzBoQ1+JeTAJ5cOY80KJkLqZLrWdNQwe/HEY7AeJFvjfzOf/TkO//PGYzRa38fr2RC1gYSB7wLttbjYmCsUWgukQPSv3SSNCCTXuZUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nartNGaC; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr+H4c9rPaen3fFthgQp/gN5s/DaHcRAAYuozGSo016KI8B9Si30dO2MNbZzQ0AOr8b6uWJfUqpTU+9ADgNfV2076LwEqXCs2MZFowqyr3ebs4SQxzdmCi0HB52unE6gOlwbIA/8oZMkAXbCPlaZB7ZRQM+d+0xMNcYVp6KBZFLdCUctjBNKJOeRlZERewUa+2bceBVfxtX5EsQopwKl78F8nV4Uz/E1thDOYzwAVhqNQ57bQLGpgz1mzQatUOd9EFDbn0ZTDVh+nIfvfVovXwbbNTyD3fzq3BkIu3CQTBjXePEjnHO4rktK2I0LbvrgFHfyV4lA1Kl0ygl0Z7n9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHq07CGTzC8anWlItiTPdY6ubPf28cD8j4EWhx1E9kk=;
 b=hDtcb1lZucBbhOOi6he4lQmdtXF312qw6ksFq/h6I79v6lPd0Qa30MjplbJcsY+Y6WUqD0zRtQJLdh2MvToKApRr4nW01Iu4LxdccPGYnNHgK5VWvcaDo7fgdvCqF546whFWrAPySbJFXDzij1FyrJL26/kvKF+cBGpBnrY1MwcOyLo2c8YkIEB5Af1WHGtgS4usyzu0g1tzE/qbvBAZGjROQjIv7egMJh9ZxYvxrootp3h3p5Qjsd6fjlAt1cghCfsoivqEXI5jVVwMjBPQ890p6RfoFlCCtnyawHdP67lBrYNBfDmSnBdvtLvfFJQwgo3tTgCZk3NmL2Yj0OKGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHq07CGTzC8anWlItiTPdY6ubPf28cD8j4EWhx1E9kk=;
 b=nartNGaC/PqNS0PzXsplIN8kWGcxwqIXm3twPdKkBzGF5akvymBydzfGz7XjxE8IsTi3K6JE3IpwgxJk3nPJ9ke5CwP4E7F6JBrTBktnUGCsR6QFklyB6K3nMyxwOfupkmcgOLqY723yuxEOKL1qQAxc9admvctFOpk6RHu/qJQ=
Received: from BN0PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:143::24)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 12:07:21 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::bf) by BN0PR10CA0021.outlook.office365.com
 (2603:10b6:408:143::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 12:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 12:07:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 25 Sep
 2025 05:07:21 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Sep
 2025 07:07:19 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 05:07:11 -0700
Date: Thu, 25 Sep 2025 12:07:04 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, Kevin Tian
	<kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 13/15] iommu/amd: Use the generic iommu page table
Message-ID: <3e7mfy2s535w47z2cafeugv6qcy55wtijnzxeqozjbzhbeto4m@g4hamtjzg7bm>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d578e4-93e9-48c0-ba82-08ddfc2c14da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lk89R40RBpXnpMR/MHzO8HjvnS/L6TohWPUWuCmCodWz/EoK9lHucGpmd8sH?=
 =?us-ascii?Q?nDjDBDzeAiVYwzVfCPrh2o1w6ET06iif+7o3tMW9mrtIjj7W88hrW9QYYlDd?=
 =?us-ascii?Q?g/wm+Zs4cC+HaW5laoQ+CY7GkBLiDcr6IkWcJlrfyxxD56JdBMdX9xgjmRFK?=
 =?us-ascii?Q?Lztam+dCRSXssbWh0nFc6Q6NdhrASS+TcL/b2/PhIhDC77aqptSZFyTcpyBn?=
 =?us-ascii?Q?SJANvcDM4JK4A78pIP50+LdoaIRI2DUImkk/IolSRgYdki0zJ8Zih1BxobMB?=
 =?us-ascii?Q?hWJtQLuJw/rj12vdU3eAMGmD0dZlCYerG4Tw63YKMAsu+XvsLutwymfJ6pY4?=
 =?us-ascii?Q?zXCV/e29q2AbiK38hlylaDIgBq0CliCRyqI0niR/8jNH/4iRUOqkjQEFR/ZE?=
 =?us-ascii?Q?eeZoXdMvnphJEAyt9Q5MS6QqBpXKdUT45nqe7q5V8N8Gopxzx1R0jAb3/8Fp?=
 =?us-ascii?Q?79KNc1FR/wKKGVaVQznw/jP0y9Ch7a+/TgX50eWB1MMeomw8+OqfyYqeahka?=
 =?us-ascii?Q?qDFi21mqp44TpMQ9CGXha6V+kp4+JdUWxaOa3hrxxk+KCEdgEk0INDfuo38N?=
 =?us-ascii?Q?ll+xhu2Np+XUkanNGq8l61mv1+Y2EOb6ugsaV6UeVoMO1awDXZrgjXrITQzf?=
 =?us-ascii?Q?nFAZteGm4iUDQZPH4bsBY2gmvkLO5Fb8/vZkKUqXeBvqMMMU0XHR06ppOyy5?=
 =?us-ascii?Q?yyS7dV9YDteEmDKUQ0jDByjoMIOp/W60ZO3WpwHGpz55EE1TBNthuOsiWesj?=
 =?us-ascii?Q?PzsSJHzfRDlpMHHWvWKs3HSGfg7dGVZh9IrggrW27UrXXlPvQFTFBf7YAXCv?=
 =?us-ascii?Q?5fsC4ssnf8g1vdP88tylzgHSMpEXCD/26/sjDKX7ToTLN/+mXNMgKu3SzN0Y?=
 =?us-ascii?Q?N1w/52ms1zaTbNSLnYYc8kwayv3sNOZ043qGOZXtWFUFV66F140hzDsiaZHX?=
 =?us-ascii?Q?dfLvcRxNmQyYGMo4v9lxRxnX93tVrdbuI+dL8EKoWhXo8ObV3iF6aGxEJhs8?=
 =?us-ascii?Q?4B3jJUdbIcvrW5qsRrkbb3LfB1L9G6yC/IRpHySE5yi9Pc++fUgRYH+h5sH8?=
 =?us-ascii?Q?AeFnKkvZ5lDqVOQ3qtV5pM/a6VFN2rK4MwZWcO2XrmtGB5ZH7nH3n5ubFcGv?=
 =?us-ascii?Q?2ydVGi4j8pwPv2Yi1sW68BZ5lLqDkBNSArJMjeJgyM1upNDNHnHaa5ql5frA?=
 =?us-ascii?Q?0Cj6W1jFuULvlg6RiZth7wvnWzz8YuvYv1tyWSn8KiXKKikHeg6eXWWKdl1W?=
 =?us-ascii?Q?XMIfCpe9T9yLZjFM7jnYKeAH5j5AsDLj3U8Fn/X4+qP9X4lkGWam91Rq2bCZ?=
 =?us-ascii?Q?40p2mM2R4Grd5AthjtT8OTLtZP5Rgm8met+sVAyw2BIX7pL+HdAxBXLfEya/?=
 =?us-ascii?Q?6qzxvZZbXujfUHT7JRKM2YOl/xgq7eBhWZXEF1FjlYtPCVUQxwva8gmvQYPX?=
 =?us-ascii?Q?p0ExMAT6iP8ZIFZf/qWyxaQa9W84JvRydZV4rUreO/TX/ediRnSXaZNd6wzv?=
 =?us-ascii?Q?nET6aMMPyXiKlqxLR8PNfPe1RDD+GH5ZNv2aXpGA55t3Cb2fy+ehocbaAdWp?=
 =?us-ascii?Q?6yuhIG271LueQx7Aygk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:07:21.4692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d578e4-93e9-48c0-ba82-08ddfc2c14da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590

Hi Jason,

On Wed, Sep 03, 2025 at 02:46:40PM -0300, Jason Gunthorpe wrote:
> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> Replace the io_pgtable versions with pt_iommu versions. The v2 page table
> uses the x86 implementation that will be eventually shared with VT-D.
> 
> This supports the same special features as the original code:
>  - increase_top for the v1 format to allow scaling from 3 to 6 levels
>  - non-present flushing
>  - Dirty tracking for v1 only
>  - __sme_set() to adjust the PTEs for CC
>  - Optimization for flushing with virtualization to minimize the range
>  - amd_iommu_pgsize_bitmap override of the native page sizes
>  - page tables allocate from the device's NUMA node
> 
> Rework the domain ops so that v1/v2 get their own ops. Make dedicated
> allocation functions for v1 and v2. Hook up invalidation for a top change
> to struct pt_iommu_flush_ops. Delete some of the iopgtable related code
> that becomes unused in this patch. The next patch will delete the rest of
> it.
> 
> This fixes a race bug in AMD's increase_address_space() implementation. It
> stores the top level and top pointer in different memory, which prevents
> other threads from reading a coherent version:
> 
>    increase_address_space()   alloc_pte()
>                                 level = pgtable->mode - 1;
> 	pgtable->root  = pte;
> 	pgtable->mode += 1;
>                                 pte = &pgtable->root[PM_LEVEL_INDEX(level, address)];
> 
> The iommupt version is careful to put mode and root under a single
> READ_ONCE and then is careful to only READ_ONCE a single time per
> walk.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/Kconfig           |   5 +-
>  drivers/iommu/amd/amd_iommu.h       |   1 -
>  drivers/iommu/amd/amd_iommu_types.h |  12 +-
>  drivers/iommu/amd/io_pgtable.c      |   1 -
>  drivers/iommu/amd/iommu.c           | 538 ++++++++++++++--------------
>  5 files changed, 282 insertions(+), 275 deletions(-)
> 

../..

> +
> +static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
> +							     u32 flags)
> +{
> +	struct pt_iommu_amdv1_cfg cfg = {};
>  	struct protection_domain *domain;
>  	int ret;
>  
> +	if (amd_iommu_hatdis)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	domain = protection_domain_alloc();
>  	if (!domain)
>  		return ERR_PTR(-ENOMEM);
>  
> -	domain->pd_mode = pgtable;
> -	ret = pdom_setup_pgtable(domain, dev);
> +	domain->pd_mode = PD_MODE_V1;
> +	domain->iommu.hw_flush_ops = &amd_hw_flush_ops_v1;
> +	domain->iommu.nid = dev_to_node(dev);
> +	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
> +		domain->domain.dirty_ops = &amdv1_dirty_ops;
> +
> +	/*
> +	 * Someday FORCE_COHERENCE should be set by
> +	 * amd_iommu_enforce_cache_coherency() like VT-D does.
> +	 */
> +	cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
> +			      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> +			      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
> +
> +	/*
> +	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
> +	 * Unless we run in a virtual machine, which can be inferred according
> +	 * to whether "non-present cache" is on, it is probably best to prefer
> +	 * (potentially) too extensive TLB flushing (i.e., more misses) over
> +	 * multiple TLB flushes (i.e., more flushes). For virtual machines the
> +	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
> +	 * the guest, and the trade-off is different: unnecessary TLB flushes
> +	 * should be avoided.
> +	 */
> +	if (amd_iommu_np_cache)
> +		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
> +	else
> +		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
> +
> +	cfg.common.hw_max_vasz_lg2 =
> +		max(64, (amd_iommu_hpt_level - 1) * 9 + 21);

s/max/min
with 6 level page table max will be 66 and i am seeing boot failure with
this. Please refer below fail log.

[    5.458439] BUG: kernel NULL pointer dereference, address: 0000000000000030
[    5.459338] #PF: supervisor read access in kernel mode
[    5.459338] #PF: error_code(0x0000) - not-present page
[    5.459338] PGD 0
[    5.459338] Oops: Oops: 0000 [#1] SMP NOPTI
[    5.459338] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc3+ #83 PREEMPT(voluntary)
[    5.459338] Hardware name: AMD Corporation RUBY/RUBY, BIOS RRR100DB 08/09/2024
[    5.459338] RIP: 0010:sysfs_add_link_to_group+0x16/0x60
[    5.459338] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 55 49 89 cd 41 54 49 89 d4 31 d2 53 <48> 8b 7f 30 e8 b1 8d ff ff 48 85 c0 74 32 48 89 c3 4c 89 e6 48 89
[    5.459338] RSP: 0018:ff7421b640067c00 EFLAGS: 00010246
[    5.459338] RAX: ff1b1885cb669a20 RBX: ff1b1885c028e0c8 RCX: ff1b1885cb6289b0
[    5.459338] RDX: 0000000000000000 RSI: ffffffffacb14932 RDI: 0000000000000000
[    5.459338] RBP: ff7421b640067c18 R08: 0000000000000000 R09: 0000000000000000
[    5.459338] R10: 0000000000000000 R11: 0000000000000000 R12: ff1b1885c028e0c8
[    5.459338] R13: ff1b1885cb6289b0 R14: ff7421b640067d20 R15: ff1b1885c0a20800
[    5.459338] FS:  0000000000000000(0000) GS:ff1b18951a09a000(0000) knlGS:0000000000000000
[    5.459338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.459338] CR2: 0000000000000030 CR3: 0000000f65640001 CR4: 0000000000f71ef0
[    5.459338] PKRU: 55555554
[    5.459338] Call Trace:
[    5.459338]  <TASK>
[    5.459338]  iommu_device_link+0x36/0xb0
[    5.459338]  __iommu_probe_device+0x123/0x550
[    5.459338]  ? __pfx_probe_iommu_group+0x10/0x10
[    5.459338]  probe_iommu_group+0x29/0x50
[    5.459338]  bus_for_each_dev+0x89/0xf0
[    5.459338]  iommu_device_register+0xca/0x240
[    5.459338]  iommu_go_to_state+0x7d2/0x2340
[    5.459338]  ? __pfx_pci_iommu_init+0x10/0x10
[    5.459338]  amd_iommu_init+0x14/0x40
[    5.459338]  ? __pfx_pci_iommu_init+0x10/0x10
[    5.459338]  pci_iommu_init+0x13/0x70
[    5.459338]  ? __pfx_pci_iommu_init+0x10/0x10
[    5.459338]  do_one_initcall+0x5a/0x340
[    5.459338]  kernel_init_freeable+0x34e/0x530
[    5.459338]  ? __pfx_kernel_init+0x10/0x10
[    5.459338]  kernel_init+0x1b/0x200
[    5.459338]  ? __pfx_kernel_init+0x10/0x10
[    5.459338]  ret_from_fork+0x1a1/0x1d0
[    5.459338]  ? __pfx_kernel_init+0x10/0x10
[    5.459338]  ret_from_fork_asm+0x1a/0x30
[    5.459338] RIP: 1f0f:0x0
[    5.459338] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[    5.459338] RSP: 0000:0000000000000000 EFLAGS: 841f0f2e66 ORIG_RAX: 1f0f2e6600000000
[    5.459338] RAX: 0000000000000000 RBX: 1f0f2e6600000000 RCX: 2e66000000000084
[    5.459338] RDX: 0000000000841f0f RSI: 000000841f0f2e66 RDI: 00841f0f2e660000
[    5.459338] RBP: 00841f0f2e660000 R08: 00841f0f2e660000 R09: 000000841f0f2e66
[    5.459338] R10: 0000000000841f0f R11: 2e66000000000084 R12: 000000841f0f2e66
[    5.459338] R13: 0000000000841f0f R14: 2e66000000000084 R15: 1f0f2e6600000000
[    5.459338]  </TASK>
[    5.459338] Modules linked in:
[    5.459338] CR2: 0000000000000030
[    5.459338] ---[ end trace 0000000000000000 ]---
[    5.459338] RIP: 0010:sysfs_add_link_to_group+0x16/0x60
[    5.459338] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 55 49 89 cd 41 54 49 89 d4 31 d2 53 <48> 8b 7f 30 e8 b1 8d ff ff 48 85 c0 74 32 48 89 c3 4c 89 e6 48 89
[    5.459338] RSP: 0018:ff7421b640067c00 EFLAGS: 00010246
[    5.459338] RAX: ff1b1885cb669a20 RBX: ff1b1885c028e0c8 RCX: ff1b1885cb6289b0
[    5.459338] RDX: 0000000000000000 RSI: ffffffffacb14932 RDI: 0000000000000000
[    5.459338] RBP: ff7421b640067c18 R08: 0000000000000000 R09: 0000000000000000
[    5.459338] R10: 0000000000000000 R11: 0000000000000000 R12: ff1b1885c028e0c8
[    5.459338] R13: ff1b1885cb6289b0 R14: ff7421b640067d20 R15: ff1b1885c0a20800
[    5.459338] FS:  0000000000000000(0000) GS:ff1b18951a09a000(0000) knlGS:0000000000000000
[    5.459338] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.459338] CR2: 0000000000000030 CR3: 0000000f65640001 CR4: 0000000000f71ef0
[    5.459338] PKRU: 55555554
[    5.459338] note: swapper/0[1] exited with irqs disabled
[    5.874958] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    5.875940] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

> +	cfg.common.hw_max_oasz_lg2 = 52;
> +	cfg.starting_level = 2;
> +	domain->domain.ops = &amdv1_ops;
> +
> +	ret = pt_iommu_amdv1_init(&domain->amdv1, &cfg, GFP_KERNEL);
>  	if (ret) {
> -		pdom_id_free(domain->id);
> -		kfree(domain);
> +		amd_iommu_domain_free(&domain->domain);
>  		return ERR_PTR(ret);
>  	}
>  
> -	domain->domain.geometry.aperture_start = 0;
> -	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
> -	domain->domain.geometry.force_aperture = true;
> -	domain->domain.pgsize_bitmap = domain->iop.pgtbl.cfg.pgsize_bitmap;
> +	/*
> +	 * Narrow the supported page sizes to those selected by the kernel
> +	 * command line.
> +	 */
> +	domain->domain.pgsize_bitmap &= amd_iommu_pgsize_bitmap;
> +	return &domain->domain;
> +}
> 2.43.0
> 

Thanks,
Ankit

