Return-Path: <linux-kselftest+bounces-32960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76782AB74A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F324A1BDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EC14A8B;
	Wed, 14 May 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNmPvTsI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F11EE7DD;
	Wed, 14 May 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248321; cv=fail; b=RbvDTpd+3GOcQ22zNRTsBdMmnow13QXHiFfWfp1VTazy32wqIDG3PtfbRoBvAEFpxNqxSxVcAlEF0mJoir91XozDdK9QDv3/Tz4R/9VfEnhv2CwwQ6NEgBeaZFEuDpQnrPqHUGRnc8O3u3peivy2Mdwsp+LRkxCfSCDVqcj/k/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248321; c=relaxed/simple;
	bh=k+n+MBWQneITQAzAAL3ISZIETaQSFgSRuRH0witai4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=swWOK/iSJwptD1Yg8tqzhyUyK5lXndda6Jt+60xS0Uc+5vp1T8bn4qjBLMdec3cz+Ffk2yGUl1RTuZQHjXOACK/VW81WEspir4QS+ti3iS4jF/BvSW69CRExUVTG78/X+CCSi4/tFsaD0L69pJApQgK8ZrAbF9EYrG6wFs2C//A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNmPvTsI; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrGo+NKXC1y95sRx0tn1FMMnBv+kax4uwk0bOQf51I+fZl/vOfu+FIRVOE5oB2xOucqS+dKmYPkC6inTGoSUNzegb1vQk09Oe/vBKQcJG/c7k2cidizBJRr7M1XP2/zjmyfP5YapYMz3rMcPpqkl8abycsWG5yLQWkPpyXwIFzj+P3nz5xaBa6K5p3e13ZnbRA++F8vJnRc0sAywXbGAEPKmoNOlQVnQDXhwawjb4qbukjtR5b/xYWvOkAdds18E+LgzuRBBj+cL8/73UyzapWaH9zs8DlI58LgtRJKMNBjZ9DAtYP7PhfsjwEgz1jewQjgRA9o21jiRmIrb5a6KPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erh6r1hq2y2CNOCp4Zj7SQ1T2+Z3vYkyt6ut4YnBwx0=;
 b=oyzjR25pFsiPvydYgpS7jmALfzf8xJPztXp5/seDJ+33QxoyG+GWUr08UrrLJUTPvvfpSLxQ67ws6a+5pHKDMg96Jec7hQ/wvXRZwejiOX5Y/csZkid1gDyhQK+Duc3V1UbPj6ygEMK2FJQ72clyvluCGxwdVMS9meiQGddhgf2cBdaizpCDMgdmRUvhu0hFd5L8ZPV4qQU0riMSdHGoXY/zWgs+zSDT3eOZMidOfyD7pYG7o+AKqhXc+onf5MNddymbSzIXePavluGR/qMGx+XPKRsKqbQUIqrY6PZyBNvLx/SR1jlmEgUm/TaolpqgaNixm8BDhcql363xmcXK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erh6r1hq2y2CNOCp4Zj7SQ1T2+Z3vYkyt6ut4YnBwx0=;
 b=tNmPvTsIUWTd0D+tHu4wZsRxGKHBLDaRy8DpU568fOqcUzRdg22A8lUh5x+pSzO87nDuyKoYXrEZX8xaHJPqpU+qGIQjQqY7a0UrB7F+C1YqdpQlbM94p40IU415OjVEjbi2oPFlanAiHiJq15qu5Y0Z7g3v5nAjQqzDg8gy4HrSFf/tUe00S6fQBC14HwnE3rOKdGmPsXT4enjH/HjWCqpcdvLPOOCO7nnVgr91M512xYymNi++jCsWXBGCiw2ckD8XF+oBdi66pxOc0zm2mBSNYfzXR7e+ejNIsK9P1n5dgRXxW3Q+LCeK1ihTejA+9Xre4qsxKEk1u2SiL0Fckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8251.namprd12.prod.outlook.com (2603:10b6:8:e3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Wed, 14 May 2025 18:45:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 18:45:16 +0000
Date: Wed, 14 May 2025 15:45:15 -0300
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
Subject: Re: [PATCH v4 09/23] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <20250514184515.GG382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <88a0b17337897de8ca170afa1e9be26ff7442437.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a0b17337897de8ca170afa1e9be26ff7442437.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:208:32e::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 222e14c0-c0fb-4d53-fd7b-08dd93177803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqigW8aUxplymXoG/kc13Tvx86AY/ywtsY7HZFimna91L6Cp+xYPD8/1t3Ay?=
 =?us-ascii?Q?tguQLpVnKm7/UPAtt9x7TU09lAeUW/Jkf1RTWFpQYEnzLjybQ4w5WRGCiXyJ?=
 =?us-ascii?Q?en+avIkQLPyavinaSKoQ65ENDOaBsI3fJnxYK6buRCHsNvNtbi7Kaknhjycn?=
 =?us-ascii?Q?JxE6HCzdTs1BxUTpBc+z282x/91F8/oi/W5y7mxUPROcLVXbK/psV5EhyKwX?=
 =?us-ascii?Q?iQBXsIzjYwLpqwoNjW7R+vznaGbbwngZCBxhCXP/X1d//+SfRE0gmtYe8X6k?=
 =?us-ascii?Q?R4wT/wgYo9U22NNpwT9YISnJVDWQrnBrEv+1MxwMu8DFxCXkp4dtK/XO0tKv?=
 =?us-ascii?Q?l+8CCZKfjjwSUGxBYs7VwEq44ZsPqsocEdCBtYW5zZw6jWEaTBHb8mRSshPA?=
 =?us-ascii?Q?dlmYlRaqfC+kkMm8vNxdNOpTlinQt0U9mCQipjH3SdRc5WgrZLO9MNVp0ioI?=
 =?us-ascii?Q?niIh6uyv020zq3LNs4FdacO+Uysx9L03rPWjlxPIXIhpZBqy+7RmKV1MLaQr?=
 =?us-ascii?Q?J9OgqFTdhjpjNT1nZsYZyTW0ha8PPK0GUfyuVoS5RlLwDq0SGEZkn/V3kNmC?=
 =?us-ascii?Q?bB4eGWeFEc5ZONVI7I83nbh1bUk7T1pCoBBHVYePNQFVnqND8GhB3Wgfi545?=
 =?us-ascii?Q?1SjYPISqnSqMRIsDm7BAGh6kqRo+W0golKYjNJyDnbcaMkUMchkBebqW2BFm?=
 =?us-ascii?Q?U7ussjQnh734jj/dFfnORLhSaKXaxvZCbQadDYytPzEHBoR1Da/tFNuOP5Z1?=
 =?us-ascii?Q?DSFVOfJdQmNWPv/bvHEbtomZqp4Yk6j+YdKH3frHTbuh4WQ14AXRAAfOHuqL?=
 =?us-ascii?Q?ffv10canmuMbeS/Wkxdp3jdFwnQ0bGCQCHsvfXrgQxUHEhANw6Vz9bBHNbUo?=
 =?us-ascii?Q?dWj/Q79b/KOqDs00hXhlcY1/ry0AS9zfRD9N9oVk3zuE4BTFpqCvKwnHth/x?=
 =?us-ascii?Q?OR4oVJeMspYKiWE7bPrDfU7Qn/9l9yG+qYczTo+gNpRLJOeyaOijSaauR3rV?=
 =?us-ascii?Q?Gx21Xzzs6YJlIVXQDuYxch70oquukabGvJXtYcvJGjv6h2Tj83ts4dE7I2gJ?=
 =?us-ascii?Q?SksmjeDqPsVUgdinxMvW03HDQIZJ3T2t5HGsLnLOtpR6j5X2aTjTq3QVNLoi?=
 =?us-ascii?Q?1KDRCbNqas+/f8zY7kNPxGw4JGp1zK7fm3vrUD+mje7cF1pFbhPgCFjxnFk6?=
 =?us-ascii?Q?BT3sSpdJupLc/JiRbm5wmyrz6QgiDck+Bxq/G7Pkzr7TVhjfg/ZWuYkoF4wh?=
 =?us-ascii?Q?952f6M+aHmMDSoyb1F4vsDu+lgLUD8U49VTtMOfxQYGV3zG3ch8GvDGqD9GY?=
 =?us-ascii?Q?mrUvd5hsF6u/XFFgLn8fEz1GPH1wZp8ogETvEHU16SXc9oTAwAw2Gq+0SbMs?=
 =?us-ascii?Q?oy7GBoXnMgEHM5DZNt/1ESrjX4RpIMk4mbdUF9VPeRWKk4zqK6DXtRf5SBoz?=
 =?us-ascii?Q?PZgClzR8Nxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LR104xwuOFQax99hytjcdLpdRGiV3w4bHlSKYkbCa7/+WUk3eXTULQ9ZOBRq?=
 =?us-ascii?Q?0/QagBsSnl23K53oTFv7SivAF/I4w6EHkIPzZY5RcShdV2dnVctpYEhSdoTl?=
 =?us-ascii?Q?s+XMg7CsfvJ6rV/uddIgG7J8D7Hrz2+QGDygvWlOHErYzTFRSPb8DMGAeNhF?=
 =?us-ascii?Q?SkDJ2q8T4W1LxX+GlR9o3qq5SEuS8xxDKqe6E23xnD3oonB677SuPGC3aqmB?=
 =?us-ascii?Q?LlSfOKFQegsDoqQeRgPxRnPFjhPEHeTUByDoh4ciC56mmkn8xZG/peaDMhI7?=
 =?us-ascii?Q?dDPGzpuFyr+4oaXMTfuYIuv8wq3pU/Ck9LRs7D2y+g1eezzH0zILAJ5fqcXg?=
 =?us-ascii?Q?p6dWauVA0Nv9TRQ3DvSM79QAQJH4ljk8AlEDPiNQ4xzPVMaM0WbLTfN+ZXd+?=
 =?us-ascii?Q?lCYAcZEjeHiaercMJ0I0VQ1akURR2jEGx1n1mZfqrfJ4yrMCwdW6z5mMFkPJ?=
 =?us-ascii?Q?gRfhq2sr0csz/AaxOrdqQsv7EWGwiapGIxXux1t5avUlSDrQage6N6aniPwG?=
 =?us-ascii?Q?HqTyuEvbGpqarlGgTcu6rZ9y3rfi8kHPHf+KFYMJ3A6OdzK/OZnHXTTCGGol?=
 =?us-ascii?Q?ylUxo0qp0/oMvqadDlwmowGU2hCnLvmPP+uPZUP3S85BPlDNhGe//VADUPAq?=
 =?us-ascii?Q?ZXAZYJ/cUTHs/hnMLJEdIwgYRWZse+p43PIgokvp4scuGL80Pi4+eNZIbtg4?=
 =?us-ascii?Q?TvFdElOoUlqw3qrXluv5/ayZNLkO9vKEJU0XDUJ8rOPRiLXU62WEMBcOsOns?=
 =?us-ascii?Q?Jss5ayGeJl1XieY4KKFwjVTubuGu3+KN1b98w8Cy8WIU3dIGIjfkGmPtYwsU?=
 =?us-ascii?Q?Vlk8q2zpEvpsTCMmUdKjSMuUMbwFxB502XP0/6yCB1jhrgG9+xTegBGoKY+t?=
 =?us-ascii?Q?c/6jPMLzVgQ/QXgNGkJxgrxHiruWNlz+ooaACeSJn/cv5cYGuWhWFPYgR5Q4?=
 =?us-ascii?Q?H7JSqStGl3p+Go6J/CZ3jzhZTBXM+qKgDOLaVrn06kAagMTHxeehpAm/f5XM?=
 =?us-ascii?Q?8wII8V9uSEoeamr9D4koQKwWgWnDSgMCKxFTcsDYDorULfq/ujdHJ1yTC6lh?=
 =?us-ascii?Q?3tNsa3PX3Df7+WnEEeYBdnZ6KTE2T1gv+MuGvsEFSI86+Y59lbjCgCxu25xo?=
 =?us-ascii?Q?8xziZHHiyDpiC4Ut6y6tYhJebvioeKz5DdyIFLQzr/ZW0frAZCERUsH8it5u?=
 =?us-ascii?Q?ZiDXUJV0Ols63cACtvYcDhFAr6/8NtLetNkvWeDQGmiwW8MjRvWuU28NAVyL?=
 =?us-ascii?Q?ItxVljQnFhRuNpn8iU+tUTc7I/BXyItcdB9JWsonugAAHrdxmxBG+eSADpVr?=
 =?us-ascii?Q?+kla0o67O1FzJB3Dv1yWWdXObSqPqgjhXwtq752l/w+ddvSzy5eFCLZ+m9Yc?=
 =?us-ascii?Q?ApTH30r9ycj038OtcZvKC3/F/RjN1Zlw0qkxMq9bnggcDswV9kcLWOsON1z9?=
 =?us-ascii?Q?c3loaWwiI1lmZImAEjbabTgD5TKJjlUHGksJyli+3apP9oqdR/ol41dIp1qJ?=
 =?us-ascii?Q?g1N+1O4dveLK2tDFAgWDVmcb1cqPT5HFWp7Btn9gxT397l/Jcc3CVIo//842?=
 =?us-ascii?Q?Y9nNtcV8lEvNqL2wQd8wgX5WydE/1vkb7fOuG+2w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222e14c0-c0fb-4d53-fd7b-08dd93177803
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 18:45:16.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2nOLRoEbszC386RrwBFHG+7ytOlGxIqwZb7SHqXm+l7CMim0WjPjileBgo5Cg/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8251

On Thu, May 08, 2025 at 08:02:30PM -0700, Nicolin Chen wrote:
> The new HW QUEUE object will be added for HW to access the guest queue for
> HW-accelerated virtualization feature. It needs to ensure the guest memory
> pages are pinned when HW accesses them and they are contiguous in physical
> address space.
> 
> This is very like the existing iommufd_access_pin_pages() that outputs the
> pinned page list for the caller to test its contiguity.
> 
> Move those code from iommufd_access_pin/unpin_pages() and related function
> for a pair of iopt helpers that can be shared with the HW QUEUE allocator.
> 
> Rename check_area_prot() to align with the existing iopt_area helpers, and
> inline it to the header since iommufd_access_rw() still uses it.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.h    |   8 ++
>  drivers/iommu/iommufd/iommufd_private.h |   6 ++
>  drivers/iommu/iommufd/device.c          | 117 ++----------------------
>  drivers/iommu/iommufd/io_pagetable.c    |  95 +++++++++++++++++++
>  4 files changed, 117 insertions(+), 109 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

