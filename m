Return-Path: <linux-kselftest+bounces-27174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D466A3F77A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A94863295
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF620E33A;
	Fri, 21 Feb 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhj2azbA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23C20D4E4
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148805; cv=fail; b=F1325nL0wCWLUBbu2iHEEqaIXV0nsZIOayJDluYrcKh8cCWHVumIhgjwocjKT6yxtPDB6Ghorss4aBLJ9NRfvYoYFLKjrMKpeyXcSWiPo9f0WhYAb1/9H01JJvh/1qSa9vowc+uxexP0rxp5V0sqZyV83HVjFnJtCEoHzI3iwE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148805; c=relaxed/simple;
	bh=X132arYIZjvsPpgLhK/lULynVXPcLeuVMsMu2gOnCKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TK65XiXOuG7jAIORBRcmKcnmX+GWj/j4xEsdtn+5E4I9T+xPYGQm5wvtjQM3JZoND/QqYWGN37cDAIeFKTQcZCPsOXa4dgYityjx1oeN/6BHtaQcizjOGChGNALs2RPvkY3Uv1CyDIPQii5vI8GF2Ar/MOHVzR7G9HFvO2EPx70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhj2azbA; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNO0bqes0NOfMcdjCCxQqoKy0UAh7tYxd88Y2zJXwQFGrnm4bVJnNS5PTTr140NDpsaM+xdRnEjLhGWi6ME04ZdxRE4VwD4/yyJXX4d7EcMlqqHEjx4a6Bzdur0KElspMI+Il4MriFj8AydQlx7HXTNR3VSsVpLkxSDQvP2i8oJ3JypCLWxMm8N7IvW7NfL5RelzbKWoUwWF7xp8TOEznj9Gk3D5ToTjhJFqUI6tx72QiT4Ay7R4Bu5AU1mUUXyfxxoaRM6fvhzEFnEcp0XbJTXAkI8pB0I3rwfzxwyvl2T+zq2MT9/BjCAhDtbQFKMAEwATma+hAmH6sDvb07S57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qlzm09Y9ZAFVMMN9IJvuEgnpuDYOwvZRNpilFRwBSlA=;
 b=hJf62q93TEL8ppzv/EavCK9bDjvU3zMsPOzeB2ebqQw+rXFKjQnNLRbwcTbP4DobNBw2G+G/VZ7qOTd2x1EDoKENcB12nYNHH7xIL2j9Ma3wPCGBOjymsn017SC0T6FhhiG7yrM/5Z0n+OUpNSPqhneOvj+e8JjNTNuZgq4vIZ9S6fvi8Hr+i4qEWjtCzEyhniejwmIET/6oNquYRuli/ok06N7SyNnFEKA66beP5T+UPs2sZn6PtXqx5/PyDepz8Zzqr5DJTFNMErRwvLQdtauP+RXdxwmTpRaTXeU9IAX3gzyQHFMwRReLXZzHSdL89mNjWxF1A9QlESER8XtHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qlzm09Y9ZAFVMMN9IJvuEgnpuDYOwvZRNpilFRwBSlA=;
 b=mhj2azbAbjX9qE9lv85RN0fOIz2Cv4PyxvT93VYMg+59DD9Qoi7IN51hOIlXgQ0jHUNrtsUxjNk+LBk2u4AMp1gaB1mEsxdVkK08sQwuakSnHLs4VJfsbegxbCh1WgOgGkkyDTeRCqkqgoAp1bZlip22oE53qdDQmPYUsSGsq9Jb9Ns2RFPT5WiCXDqTs0/9TmElEqyaRBVX6XSnbhihzFgjecGoBTmDmw5BB545mJjKnb4bbs/hhJ+RxdBsxDZawZ6G5bWqF/ObYbkS/YahHgH6HGZV7bTC6aQCzTmxQZhljYQAW+wK1ZkD6Yqqkb6Pj0qljRGH1rYgBhIcP2KBZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 14:40:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:40:00 +0000
Date: Fri, 21 Feb 2025 10:39:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 7/7] iommu: Turn iova_cookie to dma-iommu private
 pointer
Message-ID: <20250221143959.GA272220@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949e28875e01646feac5c4951b63723579d29b36.1740014950.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fc59fa-846a-44d1-c1f2-08dd52859ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bJgqO8X71skcDf90AgcNXCgwTrskulcUw9oIqX1Y2+DOYv1J2x4KX/Xoatgm?=
 =?us-ascii?Q?3Id7B4O/mtyiB6p0H6pf7zeIUN1ozAqMTInWvKeVPw9niREjuDwifV0AVHkV?=
 =?us-ascii?Q?m1vIlF7LVybVLhW+wWbg24Hpz3aDcHmwYkc8RxiVvH1fEnua0or5tTg9yK/c?=
 =?us-ascii?Q?YLrpYVE9MPdo1VsSlTwnaS56+mIZKgX+pr1y7uyZKiD5r85ciODDMxszc71P?=
 =?us-ascii?Q?ME4r5PYFCtsWl6+QsiiqOQ0GX5+fJpbKc8bbs6DwqzMWTCQm3eQatOM3oitA?=
 =?us-ascii?Q?fBWiE5Okij2xfChRljnP6Xuf5ChI5nEb89KaQa3f6KZNn7d0LYqtzYLYEgkl?=
 =?us-ascii?Q?jsoBSWBiYcPcMI3VbaZR85rl3K0oe85wRExngQiS002bSJ5v9fLmSgW/cfoU?=
 =?us-ascii?Q?WXf0m+x8OdNSBGbpXtS4LbdxCeo9nQGFJJ3IcQJr9SLmZHQxjEGEkv8lvJdP?=
 =?us-ascii?Q?qITFFjTg26Ygxm6k/5pWTHaYlVPBldOanvQpx5CbUdG0SfFn4jZSeWV/6ZYZ?=
 =?us-ascii?Q?nGbvC9WIdqIta+giUi32Yx4GzzkBHkW9jl1XvcuVXdTIqLVfG1CYCmBFPWfw?=
 =?us-ascii?Q?Ajs57mQc6WQfqUwyDU4Z0z+tCE/FyLgPanMB8Y34N11SVa5PZP/RQN+KEGXw?=
 =?us-ascii?Q?OHP3ctgO6Mp+xT9uwMIUb3Cy8zthTD5vecOLltz7RE8M7K1zDH+5y8i7iGET?=
 =?us-ascii?Q?L82H3m81r+ivRklMustShY9HD/HgVAilmCB6OHt8dw4itWdC56wfVcKz/M8N?=
 =?us-ascii?Q?CPj+2j5sF3MPEMkqX/zKgLz8pLnE2w7ewzzKAOOciy+oZU0vys2bRFaBItkk?=
 =?us-ascii?Q?5+Rco6B67C7RONHqPYBRvjDqcFNUSeKYGjKmQh97vt56Wx0UhgbXyLUWg1bc?=
 =?us-ascii?Q?6rHJgabSnLmTosoYYXDfRLYdyJLr+FykapoxlZUqC+jUL0JljnO+TKOrghnS?=
 =?us-ascii?Q?iHNKZ2q10+S8mMgrBA2XJzpd9/anS6ga5sKkJIcK8YQ8UTZfJhefJ+CUoI1i?=
 =?us-ascii?Q?qLECgXBWBWtx1FgdUmlhj0i7X972dOj0H0J3+OoFboSrgKvVCQLmZgwuyrSP?=
 =?us-ascii?Q?czkjudWkFUdpV/daNdmOj6dxMq21oBVPb/ruDWIsgwwtaqyPobRddg/fOg4K?=
 =?us-ascii?Q?x6GVmDeA6840w/fDu+Eh8I40Amgfj4Dv2xmU6Fb8Fkr+M9a0rNCpyWeu4EKf?=
 =?us-ascii?Q?7cz7oM+Qpku8l6KRv3maWus1v8yteIAHqD382Ca3KBlQBBnhvg5ru01JQrtX?=
 =?us-ascii?Q?abgzPfM/V4sMVOgDgLW6onI6Ge/SxEQAMYzQgCnRFkiVEwP2Gu1wE3jDsqre?=
 =?us-ascii?Q?iHfRCjz2uDXlsIYrlZC6Rj9TjGHQBAXcpJL8aK0mcoJ3EXYRky+Jul//oa9e?=
 =?us-ascii?Q?XcE1pMLl01saZnF9xVSinsjgHJ4S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2LsP0mlmSOG4XxxSNHHJGSZu1wcN81E0Cy0QRV3VNv8EydEkm/Mwyq/HNMt?=
 =?us-ascii?Q?YBFUFIhcVVDDCuXNeSll8ssCWIpCTuvn3JrgJ0JNo8Ix5e+x3DcVtDsFCIih?=
 =?us-ascii?Q?bVqMfUEMXU9QzH4FXZjbEkuClZ6Udw/0+vbFJjRO1jZ+A+UwEU2fl6kQw5Ci?=
 =?us-ascii?Q?RFUqnU2xjoWEeebHBG8/JOaazbXsm8L6v0XqWeOtWpe3/RUzJlbshRP1fbQg?=
 =?us-ascii?Q?j4O4x7EMxjN5YpTHNxeNiiUatM8KlAbZnJpQ2erePcBGXA81J462igY0DJnS?=
 =?us-ascii?Q?dObWXYR5YNhziNA42rzrxrc5UWXXaXm78+7pRMrwW8eaJCMVT04tuUgJgcan?=
 =?us-ascii?Q?uNxQCSnUidrbcflCXILpG3U7TYhWOBP6Kv3AOB3DSFfI9FeBBv5SLxGBTHBw?=
 =?us-ascii?Q?vCLAo209U5GKEjDg1yXpY5Cf/kAB3FIj8/uF51iOG9yni/BWdNLc3ea/cvPY?=
 =?us-ascii?Q?o/y4UN/8U27gxyQxL6HoTtsfx08YN0x6hqYHBEDOJXJiTRS/VgnNSBzeWkJi?=
 =?us-ascii?Q?0E2IURG2B4XVLetM9tXVPfzpExuiCLvRbfaJ35kzhOigFZcWoL1RyuHoO1pO?=
 =?us-ascii?Q?75oL7flC4AgrcueclzDhs87w4dqaPezYesBYmcmLu8PmmgDPIwVPweWIrmAK?=
 =?us-ascii?Q?uUBqk3ZhXGyjP+xl65suBZ3KDtQduimRtAb4wNWcYOVyDCLtsbgQE74vrqW9?=
 =?us-ascii?Q?EwLqAE8zxH1/G7zAP6irVl8uNjEj8uhOwgOS12Hctqc48jcZnXMO3ZK6avHt?=
 =?us-ascii?Q?HVV67/+Ip5Wv2iQ6wdunL08o1tgGFAKFFXSG+p4ZFflHEmrzX0dptU9ezmr9?=
 =?us-ascii?Q?K5cpl+XNpf7fT1Sw7k7K0UTMYSaYdvSAaXfpr9wrUVNdR8ab8cUJx4vtmvnG?=
 =?us-ascii?Q?i4zFH1w1pqZLmn1Ef1I2u6T0hlaSOaYD8Wm4aVAOvjd3Lh+Ynmwj+lzOiOjs?=
 =?us-ascii?Q?69jInlCrBfGlfPUWBtUABcua082yolxfQOaMH2IbqZmesVJVO7MS9B9MmcMx?=
 =?us-ascii?Q?wxauMoF/bb0WWbab2BtLJ105rqXr+x/S0cnul3boImxoAFulmy3e6tjkfSc8?=
 =?us-ascii?Q?P48FKgebsWZOOgjrIcjDyn3+FywLM72Ks8k4V7pTeeIEl/R1HltGkBByWn62?=
 =?us-ascii?Q?YM9SyCeugz7CcmKXZfajfxD7SJDriQ1RhPhdfVyXIA11Q352NjANMGsdy99s?=
 =?us-ascii?Q?gyYFXAij2CjdkVd9zS9yGY2ghIQPI+6kHoMVjts/bOI1SQPypdgeRvBmcrgf?=
 =?us-ascii?Q?F7h+px4hzHHwuM+pG2eFWgv7qz0ZNEV0siJ3G9NZ3EREUM/vWNtSbvd5Ww6j?=
 =?us-ascii?Q?kvAC9xZzhR5qhn6J5K4GScXwSkIHnz8QJzpbPNp4+XuE36oYfYM/7nZlMGjo?=
 =?us-ascii?Q?spVP6UoFR13cYAlFmZmn2kEP4pwazFvLNavw1w7RfG+m9O9n/Olz2wthUiIt?=
 =?us-ascii?Q?F5Wanfkbk2FF1QcPfswn6ObXGz44vdc7ZsO37HwLpfRRC8Swcl+ycNbS3qx0?=
 =?us-ascii?Q?9be7nEkeeRCZtByJWSAIH4VkCX0XHJoHleY6YR9kaFZzEPvBuT22BSoDSbwn?=
 =?us-ascii?Q?lhSrSxDSocTrHSSWG+Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fc59fa-846a-44d1-c1f2-08dd52859ea6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:40:00.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTw7+p0QcxOkPEb73/a0jFlABd9KRyVCeJQEXhYFn6svNawfNf66/KB7StVSiWpE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

On Wed, Feb 19, 2025 at 05:31:42PM -0800, Nicolin Chen wrote:
> Now that iommufd does not rely on dma-iommu.c for any purpose. We can
> combine the dma-iommu.c iova_cookie and the iommufd_hwpt under the same
> union. This union is effectively 'owner data' and can be used by the
> entity that allocated the domain. Note that legacy vfio type1 flows
> continue to use dma-iommu.c for sw_msi and still need iova_cookie.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e93d2e918599..99dd72998cb7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -216,7 +216,6 @@ struct iommu_domain {
>  	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
>  	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>  	struct iommu_domain_geometry geometry;
> -	struct iommu_dma_cookie *iova_cookie;
>  	int (*iopf_handler)(struct iopf_group *group);
>  
>  #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> @@ -225,6 +224,7 @@ struct iommu_domain {
>  #endif
>  
>  	union { /* Pointer usable by owner of the domain */
> +		struct iommu_dma_cookie *iova_cookie; /* dma-iommu */
>  		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
>  	};

Ugh, there is a problem here:

void iommu_domain_free(struct iommu_domain *domain)
{
	if (domain->type == IOMMU_DOMAIN_SVA)
		mmdrop(domain->mm);
	iommu_put_dma_cookie(domain);

It calls into dma-iommu for all domain types 

And if !CONFIG_IRQ_MSI_IOMMU then this isn't possible to protect it
against iommufd owning the cookie union:

#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
	if (domain->sw_msi != iommu_dma_sw_msi)
		return;
#endif

I came up with the below, but I will drop this patch for now you can
repost it as a cleanup series..

Jason

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3b58244e6344a5..31d53552dc4790 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -418,6 +418,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
  * number of PAGE_SIZE mappings necessary to cover every MSI doorbell address
  * used by the devices attached to @domain.
  */
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	struct iommu_dma_cookie *cookie;
@@ -439,6 +440,13 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
 
+void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
+	iommu_put_dma_cookie(domain);
+}
+EXPORT_SYMBOL_GPL(iommu_put_msi_cookie);
+#endif
+
 /**
  * iommu_put_dma_cookie - Release a domain's DMA mapping resources
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
@@ -449,8 +457,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 	if (domain->sw_msi != iommu_dma_sw_msi)
 		return;
+#endif
 
 	if (!cookie)
 		return;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 022bf96a18c5e4..f07544b290e5b1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -456,6 +456,12 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	return ret;
 }
 
+static void iommu_default_domain_free(struct iommu_domain *domain)
+{
+	iommu_put_dma_cookie(domain);
+	iommu_domain_free(domain);
+}
+
 static void iommu_deinit_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
@@ -494,7 +500,7 @@ static void iommu_deinit_device(struct device *dev)
 	 */
 	if (list_empty(&group->devices)) {
 		if (group->default_domain) {
-			iommu_domain_free(group->default_domain);
+			iommu_default_domain_free(group->default_domain);
 			group->default_domain = NULL;
 		}
 		if (group->blocking_domain) {
@@ -2023,7 +2029,6 @@ void iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain->type == IOMMU_DOMAIN_SVA)
 		mmdrop(domain->mm);
-	iommu_put_dma_cookie(domain);
 	if (domain->ops->free)
 		domain->ops->free(domain);
 }
@@ -3000,7 +3005,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 
 out_free_old:
 	if (old_dom)
-		iommu_domain_free(old_dom);
+		iommu_default_domain_free(old_dom);
 	return ret;
 
 err_restore_domain:
@@ -3009,7 +3014,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
 err_restore_def_domain:
 	if (old_dom) {
-		iommu_domain_free(dom);
+		iommu_default_domain_free(dom);
 		group->default_domain = old_dom;
 	}
 	return ret;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 50ebc9593c9d70..b5bb946c9c1b19 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2271,6 +2271,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			if (!iommu_attach_group(d->domain,
 						group->iommu_group)) {
 				list_add(&group->next, &d->group_list);
+				iommu_put_msi_cookie(domain->domain);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
 				goto done;
@@ -2316,6 +2317,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 out_detach:
 	iommu_detach_group(domain->domain, group->iommu_group);
 out_domain:
+	iommu_put_msi_cookie(domain->domain);
 	iommu_domain_free(domain->domain);
 	vfio_iommu_iova_free(&iova_copy);
 	vfio_iommu_resv_free(&group_resv_regions);
@@ -2496,6 +2498,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 					vfio_iommu_unmap_unpin_reaccount(iommu);
 				}
 			}
+			iommu_put_msi_cookie(domain->domain);
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
 			kfree(domain);
@@ -2567,6 +2570,7 @@ static void vfio_release_domain(struct vfio_domain *domain)
 		kfree(group);
 	}
 
+	iommu_put_msi_cookie(domain->domain);
 	iommu_domain_free(domain->domain);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 99dd72998cb7f7..082274e8ba6a3d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1534,12 +1534,16 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
-#ifdef CONFIG_IOMMU_DMA
+#if defined(CONFIG_IOMMU_DMA) && IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
+void iommu_put_msi_cookie(struct iommu_domain *domain);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
-	return -ENODEV;
+	return 0;
+}
+static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
 }
 #endif	/* CONFIG_IOMMU_DMA */
 

