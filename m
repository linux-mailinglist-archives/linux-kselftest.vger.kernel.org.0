Return-Path: <linux-kselftest+bounces-32957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886DAB7458
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 20:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B577A7223
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107032820D0;
	Wed, 14 May 2025 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xr9UuwF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA31A00ED;
	Wed, 14 May 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247167; cv=fail; b=HXHmMBLpV6CpDrNJX38oVBAGS6/NQtCrZIUlXprdsrEdp9UTVaUc0DeeV0nOR0cq1z1rfmpxeLEYnYy5DGJwPD3e7vFH3QrmBPL67JrNNWgw/1cPZo+uy7woYb59MQXlRmi8AnEetWeU4D56p/B6HOZ9xKHtLQN4aFAfyd1Bjbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247167; c=relaxed/simple;
	bh=0K1p5r+2WyWM7O/Mgm6oAGrC/kTH7kwomXDs3QCtdUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dquOcT3hDR/tjRLg0xmhYsviBY7hCTpEebKJXsXzzcyZvQ2GVuwsAbXZ5zSz1lYYzv0tQSyB/z010ZFziSMEl4+q6/TMZ6DPTZ61zFACEkZf2yS6hXCiqouaR8vSMJcmntL2YgiFpq+SjkR6gOdINu46d3RIfYNOTB7H++Cn9s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xr9UuwF+; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUfOtMMt9SXKqRPIOOzJc48T+yrVfjUrSZzTYqe9//HZSlVCHiF80714TVhRGd0vq7RtSrQ8JL2dt2LUlJ0RlEKoZoM1MLY6qBr1IWKrPK3827kWkqoG2l1K/h8X0eIQfjp6abN44ND4naKtj7kre8LUixT6/Un0cNzvKp3DABAUucQ5LX3MJqNMLXLYltoe187GPlmzd+0pMYAFLatC7sPnLhwICCo/32daYfv2gEOUKExH01ipXbYkiIU+bE0gpo8pko0pLX3AIlAyKm78hAHiZY9WAoSqZcAVpMMV/eCHc9902SZlrNXmHceIikLTPmyExWBc9X95e6TGiRLyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu8bFObBj+haMxNUguP+f/nkoiU54kn7JFVy4YKbt2Y=;
 b=FS/+Eu+kaOovVd6S/uilQHxEe50szd+mEm/+yqgNKMgLiuNsSlNvVGq2lPdkmKQFGhGW83hJR3Y9H0hIeMxmdGuNF0xOkc+eYJDknkXaqLd8bndd1eMkoX4ioEJTuoB4xkRwfCEctNBU7hLLvmuHgA3OfTi5xQT+gc2Kkb5CBQ+BHC+qrCajaErfDVjQnUcGgmmK8dZUKIuKhoU0X1amUx1bxUwyZ0p3sL7uGHroEeLDt5OWa5VDY3pISeJye5Hr/zlLjdJJu4914bs5HIYraFS9VDTBwBIteOe/acd7IQTao78BTSljCjLl+sRrZ0unDjvylRTofft9+9S415wMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu8bFObBj+haMxNUguP+f/nkoiU54kn7JFVy4YKbt2Y=;
 b=Xr9UuwF+H09Evikkq/1f9M1lV+4sigz7vSWjrB0eNKxZNYw6GUB3irmOmHh8KKZGlLZapCe6SbISJ8aA9FvpE8pt9UNea4q8TgmLo/1mGPvRnLkbSyGU33ibs1yHqepwgFweAJQTbsquYaXu/P2AOrfE2tcWlbsd3aUndTtyDFsxMmRZHxuCSYuEMCXloJyjzgvqsIsodL9wKT+U3BYQLiSuhX4QcUt/n4JVC3OeKnloWEaBsGN3la8m8NtRkTsgqtEpHoC+5AAWEs+WZ8YyBzqoFgvhQsOROre61UgHNjnGOcKRbn8FXA6ysOjwIWfI9BVToLY9TU4Ry4dGMKdsiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Wed, 14 May
 2025 18:26:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 18:26:02 +0000
Date: Wed, 14 May 2025 15:26:00 -0300
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
Subject: Re: [PATCH v4 06/23] iommufd/driver: Add iommufd_struct_destroy to
 revert iommufd_viommu_alloc
Message-ID: <20250514182600.GF382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <fd387a4e4efda1905e270d28986e4563dfee52d5.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd387a4e4efda1905e270d28986e4563dfee52d5.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: c12ef82a-395c-404c-fc65-08dd9314c7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+QXQZhI1zgI8cv+QkQVtHIFyQmTxvg1748KPMD5vPttv7FDJKrI9zGZQffO?=
 =?us-ascii?Q?uUKQlqBja9jUo54HnuBXwYVRL9GqOFEShcbVEviztyOUVBUdkYFg7f3VVrD8?=
 =?us-ascii?Q?X+AUqTZMi6CxOCID3/91KX9llWuf3IKVEbDhu152U6TkCXRIneEsRgm7rSli?=
 =?us-ascii?Q?gpwwsP7lvmYRI9nR9TakhUfbOQEiIeCdoolarFgZu/U6JjidR8k6IcSOPXiJ?=
 =?us-ascii?Q?BlSyMsOZ189csn1IV+HP+HaPGPy9RmiJ2prYNsEOO5rfyH/2GAghGO5hXDYz?=
 =?us-ascii?Q?ZJ4IkILbEPRuP1BS8hrc1zBLaGN5ghuvBTnaIxN2qSVnljOHL2tfv0w4ctw2?=
 =?us-ascii?Q?8u0rQuPS+MWDJoAPVeK6YzSp0fhOJQns3oigFY4bPGAgeMEQ0xQ41nryvg7o?=
 =?us-ascii?Q?NEdboDXp+oXN9SSQEYH9Qp3IWG9dJpkLDOg0DUgSW6hy5LFwWmYmCmtNQ48P?=
 =?us-ascii?Q?KXvNvRxEZFPzkDJEbhtpRtenpy2gJfDXSTjHIE4/gF5Y4V0BuaItRE5DTQ5q?=
 =?us-ascii?Q?0W4ee8mY8G7+TKhbtuNTkd/UBdSgFXTFCOK8+Zqxv0MR+h3LAYT0wnBZlIYx?=
 =?us-ascii?Q?QLgVP66vFgFI46T1PpyiIVpm+nSE3WWoVkJGGfpWo+25Y/I0qFEWWLWb1pv5?=
 =?us-ascii?Q?Kvv86FDjk1lQHPvTDE1VzgMql4Ntmm9blwhTMMD3s/626LRCPFhoFG8n6wJd?=
 =?us-ascii?Q?nO3VvkOnndRsZ9ezo2KPt8J49FndHzrW/4S3ji2UDxpUSEwWl8ZPCcxkqERC?=
 =?us-ascii?Q?lgHx7+qoaah0p9LanZqCfPk+E++pkWcUX7A012BEnT7SZNMQ1xIyH+9OPKlh?=
 =?us-ascii?Q?+s76eKeaI0Te+t/UV0nrVAypR5DFvJNlM3zZdTm2UX/XDZNnoU/sT0p9ZQYs?=
 =?us-ascii?Q?Of9TG92IiRq1NaX2yqO9zvyLMzebdnMbBnTup0fqoMU6OJsl+YYZlh9xDtIb?=
 =?us-ascii?Q?PJQa5SPMvjkf8c0qkBS+9bnCX6vOqQJdGL42SyE7yTI+f9p/7TIBjCcQ5sYw?=
 =?us-ascii?Q?B5w2cV9CJr/c/wAg39WSarcbKSbyeO2sT+CkDY7lAGD+BHbpKnVwOvIIm2Aa?=
 =?us-ascii?Q?WuWxxDgpZFq6huAA0rO7/ddSgUNvkZ68YYaCBPF2Vyg7q69+jcz2nSgOmjro?=
 =?us-ascii?Q?njvLWxbxv4PrvhJLmtqGKyV/JSdkwlinEbBs+BarL/NKuwSG9Tj8AyxzIoCe?=
 =?us-ascii?Q?0xyejMfWFYJaPHrzFKllPGrcNNRQOKPDOOp45w+9D47LPdHp7zmjydi5D2gn?=
 =?us-ascii?Q?B1k+0vprVkcxKoUWWFPBj0z/F2G38BMUHpcZ04+q1AkRRgJBLZsog5pg+RKh?=
 =?us-ascii?Q?X4Uzy8jt9Fdzgei37lf7oOarot7Wa5PDE+SF/fgm8mWfRcIgY0XimHbXgk1l?=
 =?us-ascii?Q?RMIx7mzS8CKP52s6hhP8tIceVPOMbLGhSfF6kMNrCn9ufVV0aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cd7e/Cr8MQ3Cxe1bLYlKMBFoe2er16xufz6V/QRlCxLM8iRudm5nDLT/8szw?=
 =?us-ascii?Q?zTUaV7oA4bi73IfALrzzNQnZ60pOyuvBTw2u6icKT71cCOvpAVMwVf1UVWBw?=
 =?us-ascii?Q?RRKWLkhuy3n2xTU4VoFFFkNmHFd6hQX8Go4RK60Zh6Q44EXbGEQi+Tn9EGhG?=
 =?us-ascii?Q?s0b5bKQ5R4SbbsVJ8defzenld1SaNHKwdSZn7r7HPGg192W9HP9o1m0bvVSR?=
 =?us-ascii?Q?D3WecEXVz3ITM67PN22iNsb+rkFTYx8FIuyC2jjAGy8FZyhNUPV8Jy5wS2p7?=
 =?us-ascii?Q?V6zX+cxW9hnWPyxFfKmcOudTZ62SPOddxlAGepSRCNZBse2cSlu4iPe4Lxkl?=
 =?us-ascii?Q?WKBxosF4m5W2xCjotIaw9lmH1Cmfj5WZyT6y3ilXgSzYw3dalu2Q6cfPAH8G?=
 =?us-ascii?Q?gi1ocwHJjFwi8KE9gdtXFuSPG8Tw382B1VT5xHU7iUcT9bwi4WE1OJZDLiSE?=
 =?us-ascii?Q?geBJbqcpipACnud0IdoBQrBG9yfFH5Dg/d7tkUG///HFProQwZTTJ7KSTl0v?=
 =?us-ascii?Q?guHFmdzOA9B3KASmZQkGv4mluILxkL7NBfdd0o9O9l6RD3REJowo/jSqF8qA?=
 =?us-ascii?Q?dMIR5rXSovfbX0Qs78VYjr1Y+qiA1hJXG1RDkmboBOJQh58mDTzMZY0uPXVz?=
 =?us-ascii?Q?IHhrZgz+94SNktfhvY7Z1/YbNlABZZRwZJ1q0myziWtbxAt2UD2FxKw6jN8h?=
 =?us-ascii?Q?FVer9e966KhPHEokEkbJjYR0mb0jQ/AP6rjtk+RHXTAAyZ8Kw6jP6VBfIN93?=
 =?us-ascii?Q?umJJ/pQ0tOzjMJXprLbKFODjlL5NAvSfq6IEhR9K4nDtNnmDVxXEAUVTd3tS?=
 =?us-ascii?Q?xB3p9NiE6uGOi/yymFzq17T0YCf0xjRn3o14OJ7dI5N73RbqTklHjpy18FYO?=
 =?us-ascii?Q?9GgQvxhpas0it9KtTAkAqHxv07huOsEreVyYgxX0jcoLcG0nrtL5krSh2DjP?=
 =?us-ascii?Q?D2+QwKmMtRlsPMYMRoFp/nAdfY8T7X5SfaO99S7ggHwd8CN6+7Hlpa+9frxw?=
 =?us-ascii?Q?JCEPxzVTrIN8nDHJ82ZG9/uh8X5M5d/lhsb4FqOi+4wHWf3K/e6XOO02gwOs?=
 =?us-ascii?Q?W8VNgyOMlzDBvAiHT0eJeUi8sTEa+0bEmKzSiM7DNLDEfRJ81Z5A3OzVoIxR?=
 =?us-ascii?Q?y7RkSaeFBg04hHLyldRW8X4Nup1wZ8JCRLtSjygDicvDT+k3ICfJ6Q9QDOVE?=
 =?us-ascii?Q?TE2nUuH4f6w38qgU4ZHuYyD/Yehyy/YBigKIJYfMHUFD6Yuz02GCSVKEW7C7?=
 =?us-ascii?Q?15f6ax2ijTcK9l673aZv9HkgBE8fVPWY9VUV+uoYy8sViZQCFvxvjtym0x69?=
 =?us-ascii?Q?VFTKlkOgpQatBiXPCJNm+C+yiWV3zwDjeXyIWqWIPQTRGZs/WbB18Oud02pa?=
 =?us-ascii?Q?ZIAQR2OGR7djgbvxnAuhFNFaT8imjjGGSxwVL7gDmUwJ//XHn3jvqJ5E88AJ?=
 =?us-ascii?Q?SDZy+1qhUCnRgdpsfe8B4GrCKGbrmwpkyffhGkpCdL8E6fTqwl2Cfh1mJALB?=
 =?us-ascii?Q?Df+/fTEAR+F6KnCM6pYrqTS83q6gEirmbCHUUcBb06e6o7ZoFwzNupClW44O?=
 =?us-ascii?Q?z/Zi2SmUUtVQQWj94NxdjBgrJtje43f5dXZlQnv0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12ef82a-395c-404c-fc65-08dd9314c7db
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 18:26:02.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyXjWbZufhTyed3RULG5xk6WIxKTuURFkIRnVhcz8rK/g3wRAjLdrzpFOG76Lr9Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033

On Thu, May 08, 2025 at 08:02:27PM -0700, Nicolin Chen wrote:
> An IOMMU driver that allocated a vIOMMU may want to revert the allocation,
> if it encounters an internal error after the allocation. So, there needs a
> destroy helper for drivers to use. For instance:
> 
> static my_viommu_alloc()
> {
> 	...
> 	my_viommu = iommufd_viommu_alloc(viomm, struct my_viommu, core);
> 	...
> 	ret = init_my_viommu();
> 	if (ret) {
> 		/* Need to destroy the my_viommu->core */
> 		return ERR_PTR(ret);
> 	}
> 	return &my_viommu->core;
> }
> 
> Move iommufd_object_abort() to the driver.c file and the public header, to
> introduce common iommufd_struct_destroy() helper that will abort all kinds
> of driver structures, not confined to iommufd_viommu but also the new ones
> being added in the future.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  1 -
>  include/linux/iommufd.h                 | 16 ++++++++++++++++
>  drivers/iommu/iommufd/driver.c          | 14 ++++++++++++++
>  drivers/iommu/iommufd/main.c            | 13 -------------
>  4 files changed, 30 insertions(+), 14 deletions(-)

One idea that struck me when I was looking at this was to copy the
technique from rdma.

When an object is allocated we keep track of it in the struct
iommufd_ucmd.

Then when the command is over the core code either aborts or finalizes
the objects in the iommufd_ucmd. This way you don't have to expose
abort and related to drivers.

Something like this:

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2d2695e2562d02..289dd19eec90f1 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -36,6 +36,16 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_object_alloc, "IOMMUFD");
 
+struct iommufd_object *_iommufd_object_alloc_ucmd(struct iommufd_ucmd *ucmd,
+						  size_t size,
+						  enum iommufd_object_type type)
+{
+	if (ucmd->alloced_obj)
+		return ERR_PTR(-EBUSY);
+	ucmd->alloced_obj = _iommufd_object_alloc(ucmd->ictx, size, type);
+	return ucmd->alloced_obj;
+}
+
 /* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 {
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f39cf079734769..f109948a81ac8c 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -473,7 +473,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	if (cmd->flags)
 		return -EOPNOTSUPP;
 
-	fault = __iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT,
+	fault = __iommufd_object_alloc_ucmd(ucmd, fault, IOMMUFD_OBJ_FAULT,
 				       common.obj);
 	if (IS_ERR(fault))
 		return PTR_ERR(fault);
@@ -483,10 +483,8 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	fdno = iommufd_eventq_init(&fault->common, "[iommufd-pgfault]",
 				   ucmd->ictx, &iommufd_fault_fops);
-	if (fdno < 0) {
-		rc = fdno;
-		goto out_abort;
-	}
+	if (fdno < 0)
+		return fdno;
 
 	cmd->out_fault_id = fault->common.obj.id;
 	cmd->out_fault_fd = fdno;
@@ -494,7 +492,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_put_fdno;
-	iommufd_object_finalize(ucmd->ictx, &fault->common.obj);
 
 	fd_install(fdno, fault->common.filep);
 
@@ -502,9 +499,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 out_put_fdno:
 	put_unused_fd(fdno);
 	fput(fault->common.filep);
-out_abort:
-	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->common.obj);
-
 	return rc;
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c87326d7ecfccb..94cafae86d271c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -152,6 +152,7 @@ struct iommufd_ucmd {
 	void __user *ubuffer;
 	u32 user_size;
 	void *cmd;
+	struct iommufd_object *alloced_obj;
 };
 
 int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
@@ -258,6 +259,15 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
 #define iommufd_object_alloc(ictx, ptr, type) \
 	__iommufd_object_alloc(ictx, ptr, type, obj)
 
+#define __iommufd_object_alloc_uctx(uctx, ptr, type, obj)                      \
+	container_of(_iommufd_object_alloc_ucmd(                               \
+			     uctx,                                             \
+			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
+						      offsetof(typeof(*(ptr)), \
+							       obj) != 0),     \
+			     type),                                            \
+		     typeof(*(ptr)), obj)
+
 /*
  * The IO Address Space (IOAS) pagetable is a virtual page table backed by the
  * io_pagetable object. It is a user controlled mapping of IOVA -> PFNs. The
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 1d7f3584aea0f7..0bc9c02f6bfc4f 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -408,6 +408,14 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 	if (ret)
 		return ret;
 	ret = op->execute(&ucmd);
+
+	if (ucmd.alloced_obj) {
+		if (ret)
+			iommufd_object_abort_and_destroy(ictx,
+							 ucmd.alloced_obj);
+		else
+			iommufd_object_finalize(ictx, ucmd.alloced_obj);
+	}
 	return ret;
 }
 

