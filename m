Return-Path: <linux-kselftest+bounces-33953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2BAC6E88
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A540D189B0C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E0728DF08;
	Wed, 28 May 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PqHI9KwD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561728C869;
	Wed, 28 May 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451477; cv=fail; b=Ci7qFkr8AsH75er+2HXa8/4TDymhrwRCkFwDFn0PhzlvbrgdgxzHmf/5oafuwCQ4Av1zs0+/BDHxlz6ls/KZ72AWCXFoGL7JZ7UHr/hGepZzhxBwwSQmZ+zSEdvDQY5leBSvRzdUxQdVFLiIoooFABt/JLRUrj/U9+7EP7FbSuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451477; c=relaxed/simple;
	bh=Qz7GIAxvw/S277vPnRgq6vKfSdCFvnRcCiXJ0KSsLZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BoAQzGgTqCbnD466QJyy1cwEWz0QQ/E3QRaVfCP4iyYubQRbc0KMnZ41OU5EVx/C/iWalkpIcnMJuAVWF9h9YMfiZDvA4Ua0kT0z/fUF5jy0MnAPNwir09XcwrU9OGbjOI0pKF/CUARd5uYo2GAv7CUz2VVSi3S5QByom/AWYO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PqHI9KwD; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0nwRCPgj0fB7GQv4RSNe0M4Zv0xKfgBWqIjb3D/zJLa2siy1Y4oXXYyHXA9FLibNjamWXU3ydvgrIY/WDLbPa6iQtSMVRGWGOQ8JgXcFieDqzHORkuOc6CPI+cNukAAcmY1YXwDYtQv18T0HcE6dTl0nSaXX1e1C0R62xmS1klyP2DHuGwb1+CLA7AihC9KlSTOFKAw+GFSIQ+Cp/OruFEeKZAKfeLwKp1kvPwJWUCdhnRDgiTYZqFic9LCYzT/VTgVSinBCkwzjlOr7zD4LycRDyAlq7j8SZtjq0RMQLCmdOdwmxkjs4KvcToS6Q4KIUnuax4bQTTINDV273cHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BNfg/0b/L405allzu4a2FlySuuEtJOehg+mb8DAZG0=;
 b=QIEOsFU4q3uIuCj411uadjDQDv0kVilILqwUWP4gg0rqEaY6emikQm7SBpOdNz4IaKDJ3fQUlWuOrLMwVZGqspCQRbnRt0FqSpXolbej7NqWPeHrtBYS9jXCZKU2I4ztL4g12rtldOR6t0ksZC6uHHzGOjgQAnjHNmYPYom5vqwrN0208V2DyoaJmjz505bVHHQhVM9GAIqe7jn54NFUaW6J+MV4C+L92+CrBgdy9l9PwVe5NkXWJMJ53+99Rp6e6r6KfuaE6/qxgrj2p1pD1Q4exXcoHNR87+j7yGOomSJjOpnbVm1FUbvog9xpgbxr2qmeuthbvbULxycmNu86mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BNfg/0b/L405allzu4a2FlySuuEtJOehg+mb8DAZG0=;
 b=PqHI9KwDjIukK4bNf+ojrk2/wahIYV0BvX63GFdUBRkjb0i3d+ZZ7mvsWdJ0ElUHwFWLDp0E9OWa19ijtAnhaR9SmHCbLq949OMlmNWtdfEuNEEeSGdmbAG5fGUc3ZACy1M77XQCOg4uho4n1WlCAbg4tTiPEnJjtb0tPiKfOfjUN+nxQbRNpPlWZZ0yLG18v7WwzxcHw5Qc84A1QG1K+Rlt7eF5U29sMoVWzrZ2foF4th3MsfqkpeBWDOEdR92c1f/8G31yc+GEWgA8YQL/qijeGcefytMWYf8XNWNMyNa1kpGX6tDXST1yUo7gIv0Wk1AEYfPudJup+YJ8uT9K6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 28 May
 2025 16:57:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:57:51 +0000
Date: Wed, 28 May 2025 13:57:50 -0300
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
Subject: Re: [PATCH v5 03/29] iommu: Apply the new iommufd_object_alloc_ucmd
 helper
Message-ID: <20250528165750.GW61950@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <c01f145f9fd9a803a3154c3e7221dd76b4f8adfd.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c01f145f9fd9a803a3154c3e7221dd76b4f8adfd.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 5479fa65-48a9-4106-63b2-08dd9e08c87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UzfSSBn//VwPYmaTShWyWPdjwetzVxYs4x8jzTyWhUViJVwNK7B0/P4L9amb?=
 =?us-ascii?Q?YYPByhCTh4ftkK92NGDWFuaBE9ga8CVSGoyc5bakW7lt6Z+5JawnmnAMdXxz?=
 =?us-ascii?Q?ltff3ix8wu1QaW6eas7LOPBwUDnErLYmY9R9hlCa2eFhJYyxBI1E9NQefvUT?=
 =?us-ascii?Q?7CqAX9IRGG55dEE40RiNhGOqDlTa5znDDKqxEg7WXiqqV9qEjDO/qKJdhlB6?=
 =?us-ascii?Q?Q399rx9fxZwpPCX2RxSV2WECWsMySePvPWFeQbu4msY/m+YYhrVBdBX4g1hJ?=
 =?us-ascii?Q?Si3XsNGbbfyYHr0DnEabINhZ3ZwkD1Y0XdUxXbWN7AVcK/9gbkmU3cZpXqNW?=
 =?us-ascii?Q?DCtb6ME4d6kqPv4DDRJNJyGkDbmHlFTpaSMMAsNYcQHh7QUhWwVDxSco3szO?=
 =?us-ascii?Q?fhwcvsuAI9g0JJvvtcwQGD0X/gsktm14St7GJ4Yw/Ve1ud2FYGQD8WFPD/91?=
 =?us-ascii?Q?rM8WIicy8OMZ+YXC0NSOEkDWC4yB6VziTUnij9+mUnVdjVnY1CZ8rWpsB6wS?=
 =?us-ascii?Q?tfh15zCF/lx52dx0P/TkiP/URbrVCQ68hpNY21gL+gbvjMd4f4fQQkZvR5kE?=
 =?us-ascii?Q?zu616X6T0uVrXMvy1O0t+vm/O9SDiBGPIXSEnJqFHDpoUuV6xoYm6WYzKxEd?=
 =?us-ascii?Q?NH5x9JcDckxzeIvj/JdLE7L3xr1ZYosCjO25iZ1+bGF3CifuzJFpXCU70eHw?=
 =?us-ascii?Q?N7I5GVybnrj9oTTxjibnDF5Z+5khBx568UrSoPyN1idM2kdq4TD7OoH55A7a?=
 =?us-ascii?Q?Rs/gnZn0EOdvOAnWlEXN4NGa05cQO7Dr1fmXHMLxTss9h/77fr4gjvrToPjH?=
 =?us-ascii?Q?3uTRDpsK5FbKsvPhQHVDqCITw7ZP4K6k71tgPe6MKdvd45mThwvGWrwtlwjA?=
 =?us-ascii?Q?KUG0zIoJNObD6bnypOE2Um8h+K+w8Okab4eBEeUL/5aVWTeh/h4LcLDPPvnY?=
 =?us-ascii?Q?XNWvA6z9ftEBzAzT4xjsIOZH86hMxUJ3N0I8MhqwUJM/181Xw+4Bx7YR9rFT?=
 =?us-ascii?Q?LEJf+MiJEBJvSehW7zSNR8g20a5nj9yXhpDr7YokATFiGAyEgDxquhU687Az?=
 =?us-ascii?Q?ptk5ZjPsnyyOMcmEAHyfvBVtB84e0X2aGOrsAR4Wu9hqMkNOvNgtiVRoMZuw?=
 =?us-ascii?Q?zF+1QQ0pGNdu9LU0P3OaN4Y7BqbmiKdT284JAns5qTylgSUlklGqNlbvRSPD?=
 =?us-ascii?Q?Jp1REp1nrY+IKbiFLJUyVR7jBudjDhjPhhK6UW6AWRv+QGgQ3lADlw4BWbj+?=
 =?us-ascii?Q?fIFCPytLbp7E2Rt4+ZaHjTCuBY5Qxgb+QRFAP53RalBXVeSguoGtOhQYTLGg?=
 =?us-ascii?Q?wCQIJ5v1OMNtBnB6BvdALalTK0hIWf+H0/4/Bvsyr/TXkqbhEthhh/nzyOJs?=
 =?us-ascii?Q?XAO9dJ0S18emO1vo/u3L9qdEgUp1L4JPzjZ/r4yLCSBrG4+XOZLw+JS42VeP?=
 =?us-ascii?Q?HZwGY4otC9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gflXeNAx9po2N0P/x0bXQYbknZJDRR2LWpNaIU9K6Dn07SJOxV9QrYGN9VbN?=
 =?us-ascii?Q?XiXDAEzH1Z3IeBAWRKaCMoTnbG/t3yA/+Mo9byJWUujubo0WDyDgqNd8TkE8?=
 =?us-ascii?Q?jrXWuqvCqt1Op8MtpSPQU/iJ6RQsN8x5cR2W0Xs5PZzw4hmfaZMVi5S63Bwx?=
 =?us-ascii?Q?27x0Awo2gWxZY0h9snSuKjFFw6a33YNtFrxkUOpIS7Lz8YlRHaVvAGuJ9vTG?=
 =?us-ascii?Q?zwUQkHoc3eP+x7y7YKlsb1cktCjYn1JRX356NKcJsnTiXr4O+85pW+HZ6D41?=
 =?us-ascii?Q?5iu05agG0Aed07q/NRO1Ddl2KVYXbWiWWb6b0fwEaBCGSCcOBVi/A+sU6wHA?=
 =?us-ascii?Q?h7QlYwKKCKHFHW4GAnr5WNluly4Bt93h+6n0/A0Z2s6U1lAkwFyjel0UiEAa?=
 =?us-ascii?Q?/WVHHzy8LUeNy7WXNwKit/JNl161mC8d94nows5g5aJSiGwOI0J+Rz/OLwVw?=
 =?us-ascii?Q?oK2B7TR9lOJ+y+4oG9zGI6rvtuvxM4fTztPKH7ed/nH6HKlkNilQlskL8Eah?=
 =?us-ascii?Q?twsO0bQhE6bmiWXfB3P3hjZzkQDzSQvScikTnxuF+4pF8LqpQekBNrABsw+L?=
 =?us-ascii?Q?8sFzfh3sA5ehFMl/A+ezo+b/mp/FoD7VykzBGdpBxyvh/8LkaznsKTHoQF4U?=
 =?us-ascii?Q?6nlHKNqzZiFbHeM696ZJVWP4lIBm/9NHagluZrhiIhjKru+ZPQvyDmcKTmDj?=
 =?us-ascii?Q?8MgMg6GWpUf/1Xldd+3WAzM0vPuN0ej/YSApBIipinBx3QszWpepPR4QaQjx?=
 =?us-ascii?Q?MyivZTPr1/DzWZQO1TNuDnMooCtYj1hkTo7A7U1hbdvcWUYotOh9tCjje3aJ?=
 =?us-ascii?Q?e3TNAZSXP2JzKq/Z1SOaYudcZb7Jb8AoOfQNm6dkrozKZLEjBftRPTxCwtbq?=
 =?us-ascii?Q?5wrgoK+Tv0HB44A6srsl2r5PlZAh8LW0Hu4uupVOQIA4jcimLZ84K1EX8RBl?=
 =?us-ascii?Q?CbcsOjxvSh0q4Y85gCqlKndvg/jh0pxCUFS+85J37VJo09+E+bxsMj6ImyTy?=
 =?us-ascii?Q?pM2w587OCNBwZJKH2ePx9r6D4x0H68SJItS02luHoiePQbvF9Yts/XSKd8g2?=
 =?us-ascii?Q?r0wceDHo04zczmEjvPHoq4mE08NOP5KbgjFyRKzdeQKHoognhbuf+7BE76li?=
 =?us-ascii?Q?N0vUHGgz1Q7svAHUmli/Xg8f3ITNiW4BelYmxTH7u8ORTBDiMs6t+5AqtzGz?=
 =?us-ascii?Q?FsD7bUGAEmLKHKg+C37/YRvJGZtaDShAu1Mq5HhmenHkOfRlPECz/yd2EeI3?=
 =?us-ascii?Q?PM3kccper2NvwqaQO5zQsdVNgXJRgipWQfW7fh5uchBFDQVKaNbCn5LA70Ip?=
 =?us-ascii?Q?+ayWFG+A3cMzX4h0PgS0wbJONPdbti9IqiguLr00lpQlZ3KY/CbIJflPD82u?=
 =?us-ascii?Q?JlfQ1Kwgxaj+O+GILOqE3p23whS2DU5j39pYQVjhoyNN8m+p9jmLOo6uLG6P?=
 =?us-ascii?Q?Io9kGED4BP78BExWJoCxfQNr76lH28z4jX1LZQ31Ob/Qqr2ZkIeewYC5S9+o?=
 =?us-ascii?Q?iMqwNT77VJJcrMCHsTWBAkciXNJD7Jyhy3megkTi607gwRg1JH7dAY7dybG2?=
 =?us-ascii?Q?Xm3aoFtOm3ylvJKSbGBFwv2M8KzhHvfKT7zTN11M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5479fa65-48a9-4106-63b2-08dd9e08c87e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:57:51.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UpNDcmtlbk/+//wWGJsRtDGmYC1/pANp5Acih6YLhB28qYkde+6XqsfE1dv8ngW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

On Sat, May 17, 2025 at 08:21:20PM -0700, Nicolin Chen wrote:
> Now the new ucmd-based object allocator eases the finalize/abort routine,
> apply this to all existing allocators that aren't protected by any lock.
> 
> Upgrade the for-driver vIOMMU alloctor too, and pass down to all existing
> viommu_alloc op accordingly.
> 
> Note that __iommufd_object_alloc_ucmd() builds in some static tests that
> cover both static_asserts in the iommufd_viommu_alloc(). Thus drop them.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
>  include/linux/iommu.h                         |  6 +++---
>  include/linux/iommufd.h                       |  9 +++------
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  4 ++--
>  drivers/iommu/iommufd/eventq.c                | 14 ++++---------
>  drivers/iommu/iommufd/selftest.c              |  4 ++--
>  drivers/iommu/iommufd/viommu.c                | 20 ++++---------------
>  7 files changed, 19 insertions(+), 40 deletions(-)

Good diffstat..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

