Return-Path: <linux-kselftest+bounces-32952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF1AB7252
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1BC3A7D3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB68B27BF83;
	Wed, 14 May 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g4yZ8YQa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC11F1931;
	Wed, 14 May 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242405; cv=fail; b=pUYVGOBol/OBUFHlXmJ/egegsojr7h9gMVKKwqY9fenuLYh1P133NLTVr7rkF9gzOLVOJz93ZopQPXzTh5Mr7FY/1WKsP7YEN0f9nKGivZgq1VOpysvO+xKoD9KrBEvzpaEL3XKymV7ywK/m4ouyQVWVHZThTnpHIAllk16ODf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242405; c=relaxed/simple;
	bh=L9MT8dENLO3qYBPaPRm3TcheXbE5wqRlH34x/1cXGU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hu6auVOKG1lG9nhlLXZMWAANSAYCJbM44SWnaLyKuO4J9/IQ80DiS3HHjf74gtrHSmkDnd19uhAYoivsuI5PVvbqC7ODlUyA0j+s4aEL0bjaEIEqTsTxO+zHe4WEZqVt+D1v4gmcveHJhwYK4zSVFDhtHJv8q82aDWd3MLSZE/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g4yZ8YQa; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgdFkVcaLmFHpbxPgHz4jhU6GQhflTjaFkd3p808Q4UiTxqNurbb52B6fUrXJU6wV2IUVAKiWqWTxJwVVg8lNDFW5Mhm+Q11RnW15+vISbQyey/vinJMQqIqRtP3haw8StvDdVsXILBL7IyRsOSWew+NvYCK+phvVeff75ZIrUPZg1RsL8FtN80LhEhPa7Y0hmAlAzvT/5/6OcbDsr1XHDPuGOtT+rWRa30iDUeP7b47GXnsaX0OuzW8gZu8QrmoYo1IIsY3QIjNjbh4y2xeSn660CYuG1ryd6IiStXwRaGpqz3yc1aZrYad/M7K8tnX+RKczJJ3ACj5OQ9prB7Iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boDTYex1lGVFUTPNG/sgRHlgfXXJKbL9Vs7B81Qt9yQ=;
 b=SmtkniDa0eARU97X3h/hdMxgvjcnbpkTvvdVLWYtzA82tmT/YHldBswz/490Ex+0ZlQef69Lg0wOoX0d0gmsIACashFzWtX79GPCDwEJEIkTdeSHcPkKeHfZwWxn5IeHSgJJ+B/44ZVcKO7KHU3DcxKADrseEDhvgFvnnEmTDgmLHsBNZRa+xxEHyrJ8dVfov6TNlMUjXMxj1QjeDUyDfJb59ecjrBWO8g/dAvnEFaNZsYCvhB9GR+ebeWdfYJVpwvKeedqh4uDsXoHErwTWWuW1bC52OkYCVA0ib6C8Zdzsgb6s1NQoW1MpysfjwT4+Kr42hqHhw9xLZ5SNxGh5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boDTYex1lGVFUTPNG/sgRHlgfXXJKbL9Vs7B81Qt9yQ=;
 b=g4yZ8YQazJ9c0z95vlTdFsquZj405ERW6YOO4eWvdlpmxnPrKhH6Eh26o77gdd/obmKzjjkE9sKeMQ63jqya1lJofEfQIuLccYceMybqBCkTOzoyXuD7dTVWgQkp21DqbVagbJUKH0jjnzTwkQmMR1OLj5CWEqwREsV9en24mjlf7a/6ktgfGQHzBQ9Dw0GGOVwsUSCEVApw5cH69lM0+tKBrR2buH4ELCgNEGGX2/kb9sW0Sv7tuqCrfpMVWsIqJqSKeS7DUIjQV9Ks0un4hDTMz8/3Dw/kN7u/d8RrxpCNNQquFcjh62y5J+u7cPcvetpZAhVM+XI1cNFc3PXfxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 17:06:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 17:06:39 +0000
Date: Wed, 14 May 2025 14:06:37 -0300
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
Message-ID: <20250514170637.GE382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5288cec9804e7e394be3b7de6b246d8ca9c4792a.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:408:141::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: d12614a0-92e9-4f02-9da9-08dd9309b125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7nP6Aujz5RyM0yAf6IofbyfE48ng15JZwjAOMgtPXt32GcaDpVkuQUJw8NR?=
 =?us-ascii?Q?1/lkEGeLi9Zps17SSQV0/w+LU+1LlA3VtZs/AALz8+/lLg+KF49p67gDdJZG?=
 =?us-ascii?Q?re34pW/vu5wWRUF28AMf4l4a1Pf1+SJ4o9JdT/UmRmnBx68XdPsUUqf8U68z?=
 =?us-ascii?Q?PmiQsco7aMO4rmcLfsSCNfjtjl0tPb07f6wJrOIcjR4PLn8Jk642vuhU+IPM?=
 =?us-ascii?Q?qNNNrkKwuCUorrjdNS/lwXeDK7eFzCWK7AzK3KD1ODS7E1jPPolYE/zVL5lh?=
 =?us-ascii?Q?l7AymGtusaKMDtwCfuYjxrtTcCm76Lrjcijogvs71mBYkvlXt9TrCkNqECPX?=
 =?us-ascii?Q?rhotg0IVnu5aZA6SEvJHu18/yeZp7BBRE8oEfyeTFfqbs86kedXjg4GNDizP?=
 =?us-ascii?Q?slsbmwFvzcuPih7OBHXDK0vk2vW3QVjhiLP0wyToDVD/V/QtqntwGbZ3T/j9?=
 =?us-ascii?Q?oUxfZyf7yce1qnDTezqiO2oNyDgVCN79fkQMU0DF1OucMiVbfA3AzHYpq7Nt?=
 =?us-ascii?Q?gI66wS5Y6fK3Dx52rX4Vo2bbCtEg4pppJCLghwJ1J1Ms71ObtGXSrdq+Phrr?=
 =?us-ascii?Q?lkYAH0p4558DTm9qCXZWyrCgL5gw1J2xD7tXVliBs8qFebeLQF96/BPCNtvn?=
 =?us-ascii?Q?Z9myijHTA0O19azWbqB9Vl3LdSSunvo/GmHkD5zeftTsK7dcqpgTQnhl3qFt?=
 =?us-ascii?Q?j7hbHG/ME5ANKKFwNo0ns4x8cowyftlMfmXJNs0EtBDMXOODvwNvZ6pWOSm6?=
 =?us-ascii?Q?cOviBmbp/8VIL5Mi+eOHryrisWj0dxp8ZpyR+PlxJy6x7gpQR2y44qRTNHTt?=
 =?us-ascii?Q?L9C/EuBXJ3NI5h4Yj8b0BUgFuoA11XrshNheR2hdc2/n/edk4yAh8fLzgjAF?=
 =?us-ascii?Q?fy0k6uciAffEj686jSnAIvf/uIg/SN/5y+4p+akGXKrWIfu4bSDzOJNXo0w3?=
 =?us-ascii?Q?7mDv/HK3hEPWYBFSwlBoLJDKel/3cF5b3HyyL3k4IJkfelVfXQ06rwxIu09n?=
 =?us-ascii?Q?sX+yOYZd8g+7adA/+vxuTlAISEDxgNwnEqWE6wEKi/SCjWBPPi5QhoyWe1h1?=
 =?us-ascii?Q?xnX1tQfIXMwcie9pWTxKw2T3jmthajxVratDoT54W9Q/y+tOxPWxeXT2GKG1?=
 =?us-ascii?Q?AlMHLAeKhFVjimPfMSc0mUlhblok/BRfnCVGh3HxKd6xBL8E7QWZ1xFFsxBb?=
 =?us-ascii?Q?KTmKUEWJ9opOuullYt93dPJKQ7jpU+8bnwwW8IPb17HI2IIgrTdTcXP0Ad3v?=
 =?us-ascii?Q?oYgKVlTxwPdK4dOyIH7Jx+SnzjiOBfuOSF1C+eDK95WCmdkbiX2xzzwUb4Ll?=
 =?us-ascii?Q?P61KV3hL/uew/3gM4gcdcIOrKRg/gJrRk4zLCKnHo+S/xW7vr5iujQtBBDvD?=
 =?us-ascii?Q?Ppe3WkvBgOH70M/TwfWfj56YiHZ0R5KOHfCrRcVRz6tSKbJAixize0S2cweO?=
 =?us-ascii?Q?ET5aOSXwf5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YS81NMjnu+/uWDW9OO4IMIGLVOaA6cxflTMoExJH2o7aWZZifpeKkgEKucUk?=
 =?us-ascii?Q?jGN6Ljm1bqI8D/G/31QQ7hRJddwEYN9YzzXi0jxHtFpS0w49u4qXUIO6fKcD?=
 =?us-ascii?Q?C2hxpgtjFSIXmBUQO0h8u6lEYyyuZMxOK6Kc7WmpN6qYXRg5119Xq66hTpzl?=
 =?us-ascii?Q?GTyd8IZHuflMfu4hNfZhRis93D0J1FvG0QGoPBSaPEmb6nEIIJB1g3EoKSqJ?=
 =?us-ascii?Q?DErnHRMkV1dqqBpUFtEXAOPi0epDuMpOKCLsCaKY10H/sITESUiQZYmrZdFX?=
 =?us-ascii?Q?H5mwkQ56CQa1zJUdbo0ZtS7UFB8ZwqtBkOCiwGMl+vJMrltjxDZ17N7WWj+t?=
 =?us-ascii?Q?9O74ksJVTl+PinXjscXEC0DYw8qwHhJ/NEZQNkgGL374b7568s/e9WytwgUs?=
 =?us-ascii?Q?xTUAxhJ2Rd1xy9y9fxj9TK9nLFLAUTJsIqWVIgxHfDxIoTA52O4UauXSoeCE?=
 =?us-ascii?Q?u5/+0KAEC324SA4Y0UueGgpm/F9FcBZamnPvxRJ8ogG1WswgAzIVt4MRvyh3?=
 =?us-ascii?Q?zfROSxxQn73upTeGwd5GsR7z6zdbNgOEKfmdSKnUSv9lwxvu+7wpwJ28z3UD?=
 =?us-ascii?Q?c9A3p9uKcYyZoAm3c/N6KUrTfB6p5d6RUlpb7U9Rt36I/OQ1fywYoQS/K2lS?=
 =?us-ascii?Q?JWRkU6DsjBr9Pk50fDSU6AGOF2Fswg/nk4cGZRsPK/r9bwfmRqOcRuNYTH+x?=
 =?us-ascii?Q?n0lXbQkgkCPVaTz//ijuxIUZn0ckxemm/JsyzvcMr0UWV+kZTZ0s038ebsTl?=
 =?us-ascii?Q?qes4SKLRhLP5Rz3GJLY2IvKHj5Cw345XQOL3dV73ggY8OZmIJks+XN/DYk0B?=
 =?us-ascii?Q?/ldzMV1RZHs/nypxJAr40zloKx2i7k+ZqPm01QH7GwV+kcTrgEPIheLZiMfi?=
 =?us-ascii?Q?gK8igLEKAkLiI+QU3LHrI95/2+K9YQYlG5Om8DwhCRNST8euwjteF8s0Uq5b?=
 =?us-ascii?Q?mqLIfdR4uxXhQI2QBCM88Vcq9VQ35oXX7xU08yOoQbBKqiFjpb6DjmR9A2V1?=
 =?us-ascii?Q?xAjLTto2o2JQw1ab9G2rWpvPfkqIVqLZdbT465NrFEsPSipDYlFz3zGLYcMS?=
 =?us-ascii?Q?r82oQpDurmdYhWZNflB7LiDGT4H10dQv23DNs03XK5v5CNYOgaAUeB1whrVw?=
 =?us-ascii?Q?BbxOwhQrquZWhtMrBr0svP6ViWIoeIXbWKpYHwiW3XqWrE02pK6TcQDhcmoF?=
 =?us-ascii?Q?MzhfWb8C375tr6MatXLiZYYo4EijxInWWPf1ODQusY+JNh6lYd036yK/HadZ?=
 =?us-ascii?Q?mhGzZBUrjamwnPhT7h4NA8sZNi8huwZ1sbr/FJUuvN7SBd/yo50oks8XxlCV?=
 =?us-ascii?Q?K7yO7w5dwBTL4FKYteyhVGXFBLM59AmHA7i8V50REGHewEcNGfZlr0D0buzw?=
 =?us-ascii?Q?xKlOerCkRyzhSASUnFC+mS2m3wtYO3BNOhLizHatPxweFFyukNx+HD0LieG9?=
 =?us-ascii?Q?ibqVezBheeIDF6SXhAmfLOh3UtksVFPBYneRl2yhoFlJhrpG858it9cGaUzm?=
 =?us-ascii?Q?Av1AMIX7ebLn5k20GyKyIVaUM0+uKYv7Dq0LLFvtxbAU+ZV2ExYeLlujwvAh?=
 =?us-ascii?Q?wAWgiHKAZU7RN70ozdM5cwSGCuzGGEC2frhETn3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12614a0-92e9-4f02-9da9-08dd9309b125
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:06:39.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTz9RWbXeOt625LIqVe8FC3dbULJlnm8Tk60SeVoEO5mbhLau85lt0Yzr6CdBEFg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088

On Thu, May 08, 2025 at 08:02:26PM -0700, Nicolin Chen wrote:
> When an IOMMU driver calls iommufd_viommu_alloc(), it must pass in an ictx
> pointer as the underlying _iommufd_object_alloc() helper function requires
> that to allocate a new object. However, neither the iommufd_viommu_alloc()
> nor its underlying _iommufd_object_alloc() saves the ictx in the allocated
> viommu object, although viommu could hold an ictx pointer.
> 
> When the IOMMU driver wants to use another iommufd function passing in the
> allocated viommu, it could have avoided passing in the ictx pointer again,
> if viommu->ictx is valid.
> 
> Save ictx to viommu->ictx in the iommufd_viommu_alloc(), in order to ease
> a new vIOMMU-based helper that would then get the ictx from viommu->ictx.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

It is OK, but please think carefully if the ictx is actually
needed. The reason most objects don't have an ictx in them is because
their contexts are always inside an ioctl so they get the ictx from
there.

We don't have a lot of viommu allocations so it isn't such a big deal,
but just generally that is how it was built that the ictx comes from
the ioctl not the object.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

