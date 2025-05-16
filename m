Return-Path: <linux-kselftest+bounces-33182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C9AB9D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 15:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6EB189D6E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AE43C463;
	Fri, 16 May 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b45lDdjo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CCE487A5;
	Fri, 16 May 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402131; cv=fail; b=OOOBeeAd24aOx+p9/5BQlTsxuBnUjdRPEDhV0AvANEP+VHU9/fGFmfs/XBD4r7TddAjgYK2bGCZLyVz6HIx1TJUN4qdrgYYIOsw6C+lGHdt+PDaykZAwi46ZKg6qdkPsDcCS6bLWCAr7Ibo12MZ3fep7Ldc44+Q8gkGMMlmS8Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402131; c=relaxed/simple;
	bh=8BELiusP9LM4/i+2S3Rt64g1XYfhKhUVze29jS8I+Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SCTKO0N9w8xUlXBdQeLnVL1kKRlzXOm7YCmHYrwTOW3wvnYiGP5M+YetZIIHJzF4LBwSPt/42G/WBy4DtR/QWxaaqN7nWS6dF/bMizNe3KL2ZKQg62+d6PS0faeDlddxS4zRmLq40/VKMwCxcAErrVRBE5l6Z8oT57MeOcd00Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b45lDdjo; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD82cnTcGubqbs6Y5HU4gkLsyye3Tnc0I5WFsSmdf9vHZ9pOe7SbeZHKIbkRcGVfsIJnzg5gxD4ykNikYoTAYBlgFCe3WUr3pEkQGz0yrHj41vMo07Rmp7GmpEz2NTwm5T/Z2vbeL1FhFnw694wfY7Ofycftq5mP880CKgKzzfOUVJulhkzZK5tdbnpJ2c5o5T0LpfxkEAceQoY6zGkyIUsMWJeBV/dMf1qGAsTq7zY1ks9Pzy+XUzuB8w0TmxUAzAd9+AUCg4bqv1VKo/kdzKEYdKmSeIvFrLGFo2bW2hAJhSQv0wRsnpPYtkNQ6L4De98k0K8Ji2VTNkwBpiJUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVYCxsEMOUcHUe4zym6qyQTUpChIU5enzsA3ants4OY=;
 b=G4BHBlBUPG2QWpgyVyr2yMw5s/DbWa/kSOglyp2P9BINZKWRZChw7U7oVfDq7fjslx7NE8apBmvg8VuXXMwQZbWdZ9h+CYkd7oz/X5WZNSt4mzFEbmXbKsfxIu6Vvy7Z+Zienqp078mEQzozh8bKlk4vcL93B1FH6TAZfbKPo4Dsp+XeWIZqlXq2VFNL7+NhfdAZNY9/9CdnrUhZ2Oea1ckbSMc2cDiwREKjVPlyghSBOaCKcIVULMN1gRsSaFW40uLLFggaIN+4tuVb2LhGbbv2fK16zM8DjGYSzvtewTFufp7dnWXHrcFpY86MjoqICc+ShPmJG0TnMLP99eVu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVYCxsEMOUcHUe4zym6qyQTUpChIU5enzsA3ants4OY=;
 b=b45lDdjoWDtniMbpJlOfkotGcf07Bv1ikwAV1evlZ6XbMqQfouIVp/sLriA6+HNHw2OMELU7tmQDS8bxRLFWJ5wRyctiCYbNVIoTWtDDkAulPVJljadNSsIrLdX2QHU0GsCl5M8k0Np4Dcm7XnL5LhZFK20b+VrNLfpwIIwA3hHGYrf7n2td8hEP4yOzYBhkpH5ggruMMm3fgd4TyZ61e3GO19wL5N0WwFd8YfXbo7vUEcSUlK2zQS2k2Cr4QSbBqAI8+qzG0owCYoGEH73XW2C92RZjmiJslW3L2eesXDfKBn2pX/o0VaULPa4YT7uzG+DTzWExvsprJ2eemisCWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 13:28:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:28:46 +0000
Date: Fri, 16 May 2025 10:28:45 -0300
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 05/23] iommufd/driver: Let iommufd_viommu_alloc helper
 save ictx to viommu->ictx
Message-ID: <20250516132845.GH613512@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
 <20250514170637.GE382960@nvidia.com>
 <aCadeeP+Z4s6WzOi@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCadeeP+Z4s6WzOi@Asurada-Nvidia>
X-ClientProxiedBy: BL6PEPF00016419.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 743b969b-93fd-4fc5-34c2-08dd947d95dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CwsMpO5UE+fpvEt7kQAe6Fm4UKewkc2yjJwcUVc2qNVorbCUGw2/5MwM+Pi1?=
 =?us-ascii?Q?P7c6qvV0SOJjSUaVHKnqNnRwZmJjpfjofCGM1I/ar63OGhfxJhADIyA8no6/?=
 =?us-ascii?Q?KBL6mSRwBEFxYV/eAH/uXOfyHG3GHZQhuWBOMoTXVXUIyhu8u63eYHImnMvY?=
 =?us-ascii?Q?OBjOqJPJHUIeplc5syjS/paCsMuFHs+U/4bBtJHRYNtFlPetpqT/ZGXd9/AB?=
 =?us-ascii?Q?VxS0+LmJQegqKHgk1zbThpgGCtg8cY4ONGcwb5KUCc2/NWSxo3kVndQ7QX/K?=
 =?us-ascii?Q?EHD3ldsRjsfTmZSWrIYmmZWD2TRkgcMjDGEc5nQXN2NOJcwEh1B4JEFyR8Xz?=
 =?us-ascii?Q?Ofg4ZPQCjXpmEzxnvuayONvkacLTu2Hfdwea0Uw75ZXk9kRJ+yDj9q2294vg?=
 =?us-ascii?Q?hL1qgFHquyO+aaujgeWQPExbzUDs4+MAITnog1LNZX7Joi9qSIU+CJsKa8PV?=
 =?us-ascii?Q?ctsUev1t365C1e1bqqlKCuRbeum0PhU6f/lw6Re1uDAu+8RffpEgkAa+/WCK?=
 =?us-ascii?Q?q9RrX664hWf3fisCYkeSB6F7ukiGhLiXHk75RzZJlJzMN6WwKZ3JsjnIonEO?=
 =?us-ascii?Q?rFCqzwHUkEc4OiKDe0KlofL5P5GIW4QxLk1syPpOSyK2LEgrZrhSQjfOMNJK?=
 =?us-ascii?Q?mI16BYWh/wp9b0SL38hB2hZNW9K1BgrC08WdrLjJz50qC4SNZcQvkHvdBItj?=
 =?us-ascii?Q?ln2V9hLctQs6ncTGxY07cKnRblE+UlGPPqEKwq4niwIKo/BFjAbxzaXcoP9V?=
 =?us-ascii?Q?4QsplsVHcP3E5DqNnI8iDEI+D39j1sEMDzSAWTYZmLmPIyjE+tpvmdx5kL2W?=
 =?us-ascii?Q?OJc8q1VWys5zT+mbxg+kdT5I0GOGhJfC9w2hhzdGkSfZCRC+yrauEh/hWSon?=
 =?us-ascii?Q?fgiN5tQbOcVs11LGy/PDIqECnyQlV/x6g7rmBJveQQxh2vDzwaGfTsFPasr1?=
 =?us-ascii?Q?QOUWVU08QvWU28AlxbmM4rF357fpoNhoelsDaEmtTs3XUk8xMeMce33bakvR?=
 =?us-ascii?Q?e8inz/6Mn3dfRO+sxFvDUwlYvWo7B6LVkW3S2a7gWp5bgMOMcznWDeP6SPl3?=
 =?us-ascii?Q?2l/PY+8R0TkZLfvWWlajBTjcXTGrWrPt+uESKzL3iDitiPi5fZ7I5jkTkZ8L?=
 =?us-ascii?Q?VqKywRAbs2riAJQEe/HuAZJgvV+b6Ry4+RNd82zXztcFlqMU9OJnthzWpfZU?=
 =?us-ascii?Q?vRsrR4xeE/g7S99973mzonZNJVM7colmM+XGmJRN80j1I2WZOzrXkMIwCIHm?=
 =?us-ascii?Q?ar44t3lz4CpcTB9cwqM2oWQ6t50R2FQ9isvG7xXO8t9Bs+OuhEY3dL2Z0HHe?=
 =?us-ascii?Q?1WG+LdSkZ1T4Q5qkJf/POJuWKWNwVN5SqSylljjB8tmj5kL/9/EBJycTj9CH?=
 =?us-ascii?Q?96thWarqhWibmwGYMiFXGacP/eKlDQddQpoTg2RiOAF268MuKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ol+Z3nTibKDlcqrZD2LIDf0F4AZqlHsXeSFL94CTCla3hY2oYmqeUYB8AtqR?=
 =?us-ascii?Q?5l/1lR9bo6o8eg5Dgf+jbnD2KK0+NL7ptQzEKmpTT1v60/kW6b6AJIpU+CXC?=
 =?us-ascii?Q?3EpFYuXNhJDPuRxZfUgv2VyLTtjSio/922B6aiN2VB/uylBzRt0tyD3UQ4zb?=
 =?us-ascii?Q?prTKk83fMZEB5CWzxvy6idzuYl9KD8uJ0yZTwQZC4p79ztKgOYZq7/riBouR?=
 =?us-ascii?Q?qTx9SHL7WLimOQQ9sB8KVlaHSkh3mIaPMEXbAYlW4iAeYJNDu65JKs4aaLPL?=
 =?us-ascii?Q?e9GUYiauDx2Tye7XwE+5vquX3mZGmybK7W+Qm/Ilcsf/q6AecdjwQoe5pEJW?=
 =?us-ascii?Q?u6Eksckfhy/d4agMz/HdRV8srjRWqkNzBUDQs4Wi9dxGuXECibLDXA+45V7Y?=
 =?us-ascii?Q?i67HXb/zUcRjO9gC1G33CDbUbhYXov4LTSCvlk0vlh1mXfm9mqY9mdXiSDHy?=
 =?us-ascii?Q?4L6foL7YhYWoSv5tk5rei4uTrKAkSFuakeOD9FJB2nDH55oXc6p+UV6X7iAr?=
 =?us-ascii?Q?YdFdxjxrC1TIbDcgpa9FLn2tchNQ+MZpB//CoBna7UG2PS92sUjlm+S92A8G?=
 =?us-ascii?Q?8R2Q2Ow/hnVoF5ZbtFvJH8alxMp9/nKx/+y1DcCfU5ac7h6OquH5MEuyPREG?=
 =?us-ascii?Q?+Qatp7XFO5kMVVhzclX7VtlZntt5neu0YqF8O5+XozcNOeXI3wEJdCQJECUg?=
 =?us-ascii?Q?2df2ICI5hirCCVeYX+ZAONJKinq37kwB3bUZSzxlWeu1+q6Pee7VnICLTpH9?=
 =?us-ascii?Q?Svjnidg/rnUnGDFmV0WgP99T2NMg/fufc/t6QD3pydCUSKl70OagYc91st8r?=
 =?us-ascii?Q?1CukLxQYxFAipkQJoQvkg8VvO87nsgpqSY9Ajpaf8GpFAAdPlnP0Qa9yyYQs?=
 =?us-ascii?Q?nBAS9kHjf/jEOgPrEoG1X67IyFfcTPkFAfT6NKWfoPXBKjGKSa0eWBYZmcKG?=
 =?us-ascii?Q?pvuGL05gKKN+IjKRb93z8qh3hck/JXHuqsOf5Rq+wh6XkwuSZ7p0+ARyjPHX?=
 =?us-ascii?Q?GTtjvFCijKb/01WvlOeLpg1efmGIB++OxRJ48Mlf/44GDG1vvNO+le8yCj+1?=
 =?us-ascii?Q?AuwlhuYMjc2MkHzi6NXAsaI8AWHxyjdX3JPR8L1IP51jT/VxmJ/C6RcOHHCq?=
 =?us-ascii?Q?mneFSluGUoaPA429YfidY/+SBZq5fyphfEiSgbTUUFwjtjQjhp+ILo9DRyhL?=
 =?us-ascii?Q?t5KFCTxYIKVr+61ImVQXeORtEjC//j57GL0T8A6AA+MbU8VZbB559aXX0Upx?=
 =?us-ascii?Q?lmfJAUMbe3hxEaL8k5XBPkohAyTZoSgmqX9HO3aHZnqctZRx+j0jEUBAV8Pt?=
 =?us-ascii?Q?8M41Rk2W/YvH+PdsUm7reM/XHx2B9MbYD3ouBC6lx7ppfFQR6GdmDY+tqkNV?=
 =?us-ascii?Q?I4P5xpen4fsQaizffo9N+GvETUaiYUILK7IKypfEl8lpLvZGshT48TXVHpcU?=
 =?us-ascii?Q?rz+HtgQuvdCORMKv+C9CC+qVurVgu867bFbpHelg+anoxsBC0lPK9j9mi4bl?=
 =?us-ascii?Q?MllzJFSwq19GIcPQDJAnCcVT1gAkqKnntJJYIwBUUhq2Vu3KHLaBzgHb6iBO?=
 =?us-ascii?Q?aB2qIpDG8rnNsCh/US061jqdtJLH/Qj6riUzFbz7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743b969b-93fd-4fc5-34c2-08dd947d95dc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:28:46.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c02swL62Xey8snp/B7PidmolLQKGfCLxcOHBPIuT/Kct4/YuaN5JYm75r5ojIHAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743

On Thu, May 15, 2025 at 07:05:45PM -0700, Nicolin Chen wrote:

> Otherwise, they would be something like:
> 	// in my_viommu_alloc()
> 	my_viommu = iommufd_viommu_alloc(ucmd, ...);
> 	iommufd_viommu_alloc_mmap(ucmd->ictx, my_viommu, ...);
> 	iommufd_viommu_destroy_mmap(ucmd->ictx, my_viommu, ...);
> 	// in my_viommu_destory()
> 	iommufd_viommu_destroy_mmap(my_viommu->ictx, my_viommu ...);

Yes, this is how the other objects work..

> That being said, I ended up doing something more in this patch
> for the ucmd rework and Kevin's comments:
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 98fe5a49c9606..ddd144031af5d 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -136,14 +136,6 @@ int iopt_pin_pages(struct io_pagetable *iopt, unsigned long iova,
>  void iopt_unpin_pages(struct io_pagetable *iopt, unsigned long iova,
>  		      unsigned long length);
>  
> -struct iommufd_ucmd {
> -	struct iommufd_ctx *ictx;
> -	void __user *ubuffer;
> -	u32 user_size;
> -	void *cmd;
> -	struct iommufd_object *alloced_obj;
> -};

You don't need to move this unless you are using inlines. Just use a
forward declaration.

Jason

