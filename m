Return-Path: <linux-kselftest+bounces-34066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF4AC9390
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B40A4E6D14
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513CA1BCA0E;
	Fri, 30 May 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tC1iOU1L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9134258A;
	Fri, 30 May 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622592; cv=fail; b=hjr7NdOEzlRCh+l9GzabC79c/aPtojhkBYpOmJDhHcSBHFunREob5sMvJiDZ5mI28U4UYvjK76lCIlYjG1I449O0kKZhMKHMbms3Be7VGwqZEM64YUHK3YVzwbICDNdGqHsYf8Kk7j7W6jPHiQB9/xCQFgHTBZEH9Kyk/gAueHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622592; c=relaxed/simple;
	bh=uFyr/FmBbUlOzgbQbC88QtUzjOTReGHr8lnO5+dqJCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DBiJ6y5ulcTFL0/UqOcddw5O4sLp5AutsAcZGiKhx7DuhTjFocUmwwT6kYjzqQEjNBQVepIehku4/hxvmiBlU6zOyd9+Rrors7hRd63c/ORUQI5fHXeZclgeN+wNbJNqmhzL4XmC9t8/eSmIDE04KVaW3O7bheEvJ9ZP5q/Uh3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tC1iOU1L; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUjVJTPwVvVJKZoF0kcI1MSC07ZNrXq4M12FCLnyGwAsfymH0Z/KNF6WVT6XwauCOvzdAnjAx3psJl4yHj1n2dHg6mRGS/Da9TGKy0kJOttN4pg3T5sW4FF8odMdArxFnrWIj0FEYFQcaCdJcjk1lqnZDa8JZ7n2K7wzkxAd8VYHoscBzuojcB/X/82aPN1F14JT0HTWrHS4S3jyoh9VoY58rV1HdGuJ9R+WmgpqVVNflTqIkRZHlxoUntl2q4jnXoHc4+U2Qdv23Y5W5Dm0gBXzQulOwn5eBzu9S3U1CMQRFuIIo7o82LGO7FMhBP6ms0pOc2mxAJfGCNkgqjwIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MUvOusixuY+Ui/5UW1kF6kNKmaZJpX5hFNKXPxsAS4=;
 b=zMuBRmDQIwZu/INZyHQfr9nVGa4ONdqTNHlw/mRJs6HiydWkdj5InX+x6RgT0KvnqrRR5cSzzUl6OkZ9RTb76Fh3CCLpihoQeIOmeEh8han7Yjw/hADoaqYCGbZ9pnZNiTqPiHnSpqugJzkwgBY1l32vBYzVHyoAi2xDnVx5PdugzXZkPIXXHT+KaJgV+MwCsSXWdUWuONr4IDQa7VSQkVznTE9Kg1Tm3N5dXC+ujRYONI6D2iPXiTcm3V/QRpuIYzpSuzwYTrBTGauLouYOMf5PdYrL0xqCLML0b+L7xWH0vEM9uhqeZ0LRaOQKAl9DKQQJLi9ITB67HA8nX6LPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MUvOusixuY+Ui/5UW1kF6kNKmaZJpX5hFNKXPxsAS4=;
 b=tC1iOU1LKDQbJlfL/TBDYQM+r4G+azWVrojRDjHk6O1TW06IKLOQL/ZZjhHsEqYoBk+f7toRo60jFL+oT4NhrsRFHDHqHI5i/ZNSP3SVU2QdJDapNGdtOtB6OUVRLP+7Z5kU4AKm7Z+1Cj3wPip1LV5u8nfnbRBH1NvHIEr6Njz1HmBznkOlVV2FKNBH79+bTuXH3obeUd1C7qyTe+cfGDdceZiyRPE/r80yMenQQyxImXaFOYJcIqShszJ8fZL4nvKryYOG5V3nkiz1IGBPNGy5E1VkBusYm8Lt31r21mzmFkGz/vjffKjQ2jrTvFIOmiKxrebPaLjSS4tpC045hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Fri, 30 May
 2025 16:29:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 16:29:46 +0000
Date: Fri, 30 May 2025 13:29:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 17/29] iommufd: Add mmap interface
Message-ID: <20250530162945.GF233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <769a7395def9f68c1ac684fa08a0221957e0de6d.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769a7395def9f68c1ac684fa08a0221957e0de6d.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR22CA0027.namprd22.prod.outlook.com
 (2603:10b6:208:238::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: d41c8d34-0189-473f-4c58-08dd9f9730eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZPamHbdQ6QReQrFt7LReSpx9vovCM9zNEDt+WVMSjS7jw4y9xiH6/eeSAvT?=
 =?us-ascii?Q?+3dmJfkGC9eRTEirZQNxzMuST85Eli9bhYi6ffobYj6ywKjYYaBjlCGBKfta?=
 =?us-ascii?Q?Ykjn65w/ln1LU2YftbX9rQXr9PFIUK6hULgWFZJVSzOqVbceMlYyVnmpioln?=
 =?us-ascii?Q?pCeqJPQighM5NUbn7hEAv/xEmVptZtgSMnfxLnSLHvm0GCRuoMj6OYx7eLXB?=
 =?us-ascii?Q?yQ+ur9Z89tJ7JndvAyOzfDIJauDeopGHDQnY0FaZ85hSwe3LTkR9iyVIMllZ?=
 =?us-ascii?Q?WqFLipna6DxXzMZ9b1Jqwdt6F/gFe5HeIFHB5P5yNZoQUDlFS98/Y5OwZ+1a?=
 =?us-ascii?Q?rZzVCfsYlAaBvVA/b4x1DNOHAHDL6ajdUI5sBYAZnEHM5E5tuMbZms0qr+uL?=
 =?us-ascii?Q?bonnzxrd3AOLQwZUxncqhdtv1/9loWKO9OG8EcXUxJtcCaxiN5+4WfXuVo9o?=
 =?us-ascii?Q?CZsZ4I2qzPtN+V4YaIwRZlBf6BUJg2sLqk6bv9byBWhhEiKcxRYQqIsQwhGk?=
 =?us-ascii?Q?aZc9NG2V8NM+4EthR1QGQMNYWoyFYCbB7iQhjz89tPvjbUwJJerjxu9g+mvM?=
 =?us-ascii?Q?rK9LdamD9wHNqxtHmTaHDJMPbNAliQ6M9+sYgWorGZn7jftzsfBHSKCAt2Ov?=
 =?us-ascii?Q?5FEdLe3jHJFrB7YPneFJRGaSyqjGaob5QLUlEdzIUPTm+lRtWk+q4EjSGw2w?=
 =?us-ascii?Q?JK3exIIU6+PVzQmWhXVfoo8mScv9W4WWE2F83zWTJFYwmwDAAfPH9t5zKtvj?=
 =?us-ascii?Q?ycgoI/2yAUwO25z8qEBAmLd/jXCZFUQtKuxR7K5QIx/ij7SIIWRKBAsluAsj?=
 =?us-ascii?Q?uHJoFPtNKTVgdKML8wUMenaVBJUs3dUAuFSgTLEQqQmarpZpfjJ8TnggsOob?=
 =?us-ascii?Q?qWfwbaRdHj6+3Q7HbpxVFCfdbxaDEU82saTzT8B/esHzQxlOc1MTES/EQVkB?=
 =?us-ascii?Q?gBjEq6TvBQfCx7Hbh6PwNQWyLlbvlAaUd+Qgzfda7vSrR28XTwxJgERU0Of1?=
 =?us-ascii?Q?HWjXuISYteO5NhK6h31A+pwlh1vMeOPHgN0ql3o4RphbOo95DuelCfZkaFfm?=
 =?us-ascii?Q?HH0MlDzPOuOSIaArECEMnv9ES4GSt9qet6brFvPjYreoOQNiPxbiSjoDxl5Q?=
 =?us-ascii?Q?lM8iK1d+4YKdTgun45+7bIb+u3OpzDk8Q6L/ucndilSKICL/RQpSeXx1p86F?=
 =?us-ascii?Q?ygsKiIrIWosZAkG/FTvKRkMyfz0qliOUK3Qi4tzNvhG0B9yXcYFn2v+SOqJJ?=
 =?us-ascii?Q?73byF6VE2UhJNIXvnjJc1VlLM/YzStYP7hF2Dk51pM+trlBBXMPM+eBSNnvh?=
 =?us-ascii?Q?r4hLd+ss2pVLmL/uEiOObizA1de+adeu9xQqbYSjicxnu9QQtP2acBBCNCad?=
 =?us-ascii?Q?5BNLWF5+xMS8yjkeB8U4YeuW8Kk7ZZJaUn+VmGBYnfTaSoWcm3weKiOSnXWv?=
 =?us-ascii?Q?aIiLK49N73k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+nZoqpaqyjFN1GgudxpksTLnUgrLUFyvS/oBkurwW/TxYqCxzQD3DTl+sDXG?=
 =?us-ascii?Q?K/S9yeNzILcvvDeR9z08Auv7f1ulIFh+bhSppvMduee3j+1XqKP41kjslB3k?=
 =?us-ascii?Q?06Kesu6vOYtvbFY8Zm4LtASEB8w1oUAfF2NL+n/Bph2UB0dM2OEWdekPLh0B?=
 =?us-ascii?Q?c3WW06b8DQWT1QsJUOhamYC8W2neVL9zv5UOEl6G7gKKZRsxIPPD7vAWt6BO?=
 =?us-ascii?Q?QDxfS80rJvFiqMKfBsSY3WKswV0DkUt7tQH2of/tDNisD+zSjqQaKMEtbOqh?=
 =?us-ascii?Q?0s5oKoMoaRjBHrQAjQBk5UWcPfhlg8HzGHV36pwK6k0on3OhOchPalIkm0c7?=
 =?us-ascii?Q?YIRpg1+neY26p631qlzLcq8YOem1TCYVSlAI5/mVYr8xnLryUT7NEwlYP+Z2?=
 =?us-ascii?Q?YD5ZmX5q+5a10amZUNGqVNSNwpY4Q588sEUIuT/suB8kys9XtvskEv0RTR9P?=
 =?us-ascii?Q?zBTGSqEY+QhFZeN98fQWo+KYXbt7mDLIvYVk3MOZXmuyeXHeEC2RxvoezKvQ?=
 =?us-ascii?Q?/4x+ZyXXD6kraZRmmWDeVJEzEN+TnlIBV9shtGgXkDyq/z0AmMZjoFxI/Ze1?=
 =?us-ascii?Q?3WXCHiyBcvO2Eg6ly8+LjUOtamFsq9aZD2lDj+cghKt71POtryFDkTrjOcGU?=
 =?us-ascii?Q?r5JDvYK0IfH45Os2/65AjLm84N076/poOwy4IMpfqcotDkWii+/KhNnCjNfu?=
 =?us-ascii?Q?usEXHNfdtE7aEAHEnrIu+oVyAW53KgPsr9UqVCOxDqHcyWwfF/Q5UeKEt4Hd?=
 =?us-ascii?Q?r1QW3J7XD+W0lLIH/rQ84DSGmma4AquOgRgkTEiaC+Uc9wlRtOZPczxoblBG?=
 =?us-ascii?Q?UHIgYNF1ceUfkZ902GV4xQDHHR6re1eXXjh9YD+C1Le70TqFMJGQ3+Mm3HJw?=
 =?us-ascii?Q?gj+acyLyF+JR42buykk8DtltWrWgp0Qrr+tx4BoUSYXIyiQxOEVcju0FuEGw?=
 =?us-ascii?Q?//OUebGXdMj1zQrvZw/HTeXfmA6ytvM+Ly1vmP7Zx3b3ZRKwxLi0Sg7jOmDK?=
 =?us-ascii?Q?NFe2JfJ7DqQkBVHEOg0tbUW5fJDLNpHuZJ0kdYgyzEvxH4fF8rh1wKpDlMLb?=
 =?us-ascii?Q?RAeBQZtMHXZvKWpIrZ6mU3cLVwzrZ2RTbX/ZaVY4fWYz/FenBHNUJeMAvd5l?=
 =?us-ascii?Q?nhhnmq/2IGs/IWLdf2itfKlFEDCgRwquixEz9cErS9yqOapFIYzWYIly7WI6?=
 =?us-ascii?Q?urKff6ibHifm2iQ0eETQjnJ9Rji2KP/T2Xuv9tuGY/KyTTnh/6g/j1qd4i8F?=
 =?us-ascii?Q?SjdmbqgwDD7XATR7xTNOSoJBmxiN9Tj7omu+qKVHOM5x/NeIAnnhbQKP98HG?=
 =?us-ascii?Q?K211qaFLS7NJNBb1YxfL84tQPSA5fqX/SK2q4v/uid9JiBym1kOBYWEm5uE1?=
 =?us-ascii?Q?OsH4X2ix6lB31jUTyTAwQ4vEiKxGRfbcmh7ReJ9oomyDwUXEWViroPsiBC29?=
 =?us-ascii?Q?nJDse9VAlM25/qkQ164SD5dJMBjmhIIz+ckYHzZ+gd7WbxVHxVFqiLwiAboc?=
 =?us-ascii?Q?It99qrFkBN1Cr/9hw562g+Ynu1T1J/Q3D1fu53WJiV9jUWX0xXob2k7DqPUk?=
 =?us-ascii?Q?sVokvNq2qUDCVaoJVDc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c8d34-0189-473f-4c58-08dd9f9730eb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:29:46.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICSdUCqSRpulxJSLIABxOQzNFZu7pXbAE6xRq+igJHW3TF8rxmKCp4okThPbbTaF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674

On Sat, May 17, 2025 at 08:21:34PM -0700, Nicolin Chen wrote:
> +/*
> + * Helpers for IOMMU driver to alloc/destroy an mmapable area for a structure.
> + *
> + * To support an mmappable MMIO region, kernel driver must first register it to
> + * iommufd core to allocate an @out_offset, in the context of an driver-struct
> + * allocation (e.g. viommu_alloc op). Then, it should report to user space this
> + * @out_offset and the @length of the MMIO region for mmap syscall.
> + */
> +#define iommufd_viommu_alloc_mmap(viommu, member, mmio, length, out_offset)    \
> +	({                                                                     \
> +		static_assert(__same_type(struct iommufd_viommu,               \
> +					  viommu->member));                    \
> +		static_assert(offsetof(typeof(*viommu), member.obj) == 0);     \
> +		_iommufd_alloc_mmap(viommu->member.ictx, &viommu->member.obj,  \
> +				    mmio, length, out_offset);                 \
> +	})

Why is this like this? It's weird, just

static inline int iommufd_alloc_viommu_mmap(struct iommufd_viommu *viommu,
                                     phys_addr_t mmio_addr, size_t length,
                                     unsigned long *offset);

> +/* The vm_pgoff must be pre-allocated from mt_mmap, and given to user space */
> +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct iommufd_ctx *ictx = filp->private_data;
> +	size_t length = vma->vm_end - vma->vm_start;
> +	struct iommufd_mmap *immap;
> +	int rc;
> +
> +	if (!PAGE_ALIGNED(length))
> +		return -EINVAL;
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (vma->vm_flags & VM_EXEC)
> +		return -EPERM;
> +
> +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> +	if (!immap)
> +		return -ENXIO;
> +	/* Validate the vm_pgoff and length against the registered region */
> +	if (vma->vm_pgoff != immap->startp)
> +		return -ENXIO;

This check seems redundant

Jason

