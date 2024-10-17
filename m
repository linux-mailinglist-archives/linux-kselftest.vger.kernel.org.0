Return-Path: <linux-kselftest+bounces-20002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F59A2A78
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114DE280995
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843BF1DEFF6;
	Thu, 17 Oct 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y1Fs+Z3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8DA1D95BE;
	Thu, 17 Oct 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185216; cv=fail; b=fcxteBKZOBRurCq3Pz9yZgKyVlJvf+vr5qFOLr4WxzgJGJN5il9n9pQJIsc1ThM2VYzN2YN1SkhdfbiOqxJXYi5JW4i6PPK3OCmwZmpOpq2Wrn6en4F9pYj75GHxItGiOqTqona8VaqU+pzC1xvqrE+eRN0NByBdWqoASOr4sy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185216; c=relaxed/simple;
	bh=pkfbKkLYtk2o5oY+cNy+dJgPvzx99KEcR+HQezXd0tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uiczXcmLz40Q2PluaFKH6MPlmMwNpp8H9buQkMJgSh4ZCN9Eb4n112ZWo7jsJ58FTN0fC5L0pFLbHEyio8tS0HWYk9MDTYTbTf3YhMWVcBwheykGp+8TBIKkoB23L/u80T7wcKL1EHWcbzIkM1AdXSV0C0EpEq4WZQARed32G6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y1Fs+Z3Y; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzZk8qWjqC3dZUqhLoBsYXOi3NXaYMMsX6YfAx51F0VMRCf5ZXzT6egBT4lUuO9/+Kw1329LYAerz7CDLmUb+ZUB6Pfiow7Qz4IzRGVjnip67AIMZbYXLBF1ItKV4OWeh0Jyq5LHs+KQw5zEW215NKkFIjkG3paxFzxdPqyG2u47NPWohBrAnBnjAg0UHsGkgPD8t9pWBcDlV4b+L2uE3UXQHwEY9r9AY9sI5X7ZpQQKep7+t2xOzo2hx2EnrOWj2wbvMTcVG5sD/vpzCmHWBoa3LaugsS86jU9rkmrpjIPPYKWaEcaFiqBqjGxsSLnZarc3x3/jCIK3Uj34vpNj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjAF3qcM6G9KnWnVYT+9F7CnQ3TFjR8Id1v+n7O0XhA=;
 b=aUJo/WOeL+iACaGI2zrAGNjRa3exabF4ffhPvh9/NP/9+bBCn+A7MJqRkXk899CIxeWSQ3JGyr8DK73jYxZhKRllu+CWnhG1DQqR1d55oVPQPnATB2ctxlTSro7WK8owWLs+QqzVSwWpZP7lTCoBFHNes5eQooPuPbKhrB0OazS7ZA+iPBACMVwBaisMREilN0ANsbFCuBlGWVm8IJEtckiXrQw4gb06dn/hvGIEGOS13Qa/QjX0RK53u9tcuq8XmIChNZlTDcFjy0Jp3u8bFspcwcMFrhhRzqzE7nM17zlNYpHPljWlvWwZL5a2YjQ4xENqZj5xM3HHOIN7u07+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjAF3qcM6G9KnWnVYT+9F7CnQ3TFjR8Id1v+n7O0XhA=;
 b=Y1Fs+Z3YsdAcpDtoXLFbzoHcOPKNKZnenOY4TEi+osebmutTXk9V3itLyJ7DeREa/eIh1hH/17xNJd00k0kkE4qMJS/Zcmu5wb40gdVTcI2i+vZ4qGBVrn7sLO61yEXX3CjdTCueNQaJIYev27ax55fbjGXHowXQdv8DarZb4WQAtVPq699DLiwazTQF13E7YawD8aHGHE2pDUtc/p9WQ3qS14+Us3cLwxZqL7SXOmUEBQ0tISozB/bmxT+s94nwTADT685kmB+n57XyMpsDAXs7Z0XjzYk5qLr/DO8uDBJyRCTn+spRMYN2q/l3eqiB/inKrtwFa6SZSXPTQ0/0BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 17:13:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:13:27 +0000
Date: Thu, 17 Oct 2024 14:13:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 07/11] iommufd/selftest: Add refcount to
 mock_iommu_device
Message-ID: <20241017171326.GL3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <1d34e8eb85efbe7e4e47d0297b6eabfc147e5336.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d34e8eb85efbe7e4e47d0297b6eabfc147e5336.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:408:e4::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: a02ccc37-cf8a-412e-4fc6-08dceecf0430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4S9GygqdiJkVsYLRYJ7DszxCn+xvlLWeiiV8aorl9MuGEY36JvI85co5GyFc?=
 =?us-ascii?Q?DUVW1sVOYj4wuz1zmPEWlIZDn+eM/xTkCJpelA8tsCmQ2ZHYEBBbCsYV/CNg?=
 =?us-ascii?Q?9ZrIf6yEx6El+SbNvSgkxy847uiPw5dXedRpqKiv7mJbRtgvKPl6gWinJwVH?=
 =?us-ascii?Q?RM3kiJCviYjL4NuTwOPRPxLMCcb1w/br5y4PsVIB/uxHFp3zspPXhAqpM0J1?=
 =?us-ascii?Q?1n602m3eG4hRPkaGDi63wVoq778IbWEnTxEux7eZt0pZ5wdcqgrNNphl0I7Y?=
 =?us-ascii?Q?EwBAITUN2nVnHEb22df43etqK7eHXZ5xQa7S9E9ULuixPTqJoBp1orfXX0B7?=
 =?us-ascii?Q?IFE77Sm/2SGab0sniG/KphUNc+UHW/ndyRu2PQVx+SbriRgY+lhNb7kiRTnU?=
 =?us-ascii?Q?soEj8QLBVUitzmswfAFGRoO23UnIoNqiboEB29enS2YP4DkB6crZMY04UCe5?=
 =?us-ascii?Q?31VCdwnYMzUFupf3kDxK1uM4etJ0+znsUjWsIKRXTnRKUmKVImPsbvL4lu+d?=
 =?us-ascii?Q?Rak8QGvJk+BH7ukrnG2okdxFczOuinBIMIPvcFnf/UMh04Urp2NuSxhbASS5?=
 =?us-ascii?Q?Xv4jb/6NYvlIh16zYEezQb7i+m6TSA3oSmOJLE2PjH69KsP4AHyDDDmQVBGm?=
 =?us-ascii?Q?d/Ff30alNaLGV5NKX+XbLzuCDNNwF/D+dEaBxMf84oKTA07UKeGD6zx8xRvP?=
 =?us-ascii?Q?IQyKUYIqa/4/5o7az+sNdU48UvEqU3/8esAUvPxwXFbWA4aCbr5ME3vHwpAk?=
 =?us-ascii?Q?eWKdy7lpbdRWWLKMubSDmT5bBKnfi/pWGQg/SrnkuneU8yo3TRry1UC/b1SQ?=
 =?us-ascii?Q?vkllo+TesW1+NIRgCbaG/BiDGD1Yh1jpxmzGwIroKq+CDThoZw4Z9xwCrjd9?=
 =?us-ascii?Q?MZaY4Cg/UQ+8SVMw5vKZ6o0D3kTfHoYDUl4IjFoeoClVAXSgFxS5c2ORXT8/?=
 =?us-ascii?Q?dCaYGsVOY8ZLX2Ego+YEajalQD9QcOrgG+3ullqDlT01TjIW6qgSBMcFOxDp?=
 =?us-ascii?Q?0zzxJMT1T4Xm0lAjQKcbEhC78wn7PvRjSWstJzYcLNp0zrfmYmUPtS/xChff?=
 =?us-ascii?Q?7T+89pjVS7OtEDbInbIaaqiKaEXMwlhQdILBSlYpZ4MGdSNDU/tjRK7JYdkr?=
 =?us-ascii?Q?W3DxMZy7lmcMsBgWy1hqdZso39X2E/5F4Kfgs4zZBsIIu9kLkp0XvlU6kJqz?=
 =?us-ascii?Q?Xubmll5KY+fxNpqz50JQbvRGsAdKIkdxpj2zvbi98AaKYCGF+7Iodtc38UOs?=
 =?us-ascii?Q?3/R+YPKDqedwSMhur5xtfHQ5u8KF8t0IYM1OPj0pZO6skP4G/MAumWUuLfjh?=
 =?us-ascii?Q?5d+0FZXV5BfuD29uSqY5Wbtt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSZNe3jhg5vclVzIrC8V+/PRRfSKikzsOrbMwdrBFcrqFH3P9qidFRGX3SK4?=
 =?us-ascii?Q?+oEeejpAI8K0fMupjz/zOvd97wzPJFbSEnlNQxWAgxsvO3+Je/tO5MT3GmE2?=
 =?us-ascii?Q?LDYjSqUlpUYsAJD/rTYvNKBN8FdwJtE9ngs3tp/zCZXu1kckikV2g6WSdCcd?=
 =?us-ascii?Q?KAbTsMsTfdDsSMYAX1fj35314mHp1rpTwcxv718OOXaTU5ITX07iW3vjNpxt?=
 =?us-ascii?Q?vKkXGpnSXf93WAUCykw2RBycsMuHTD38x94qvRuozNHfyV2R9/j6Z3XHd0N8?=
 =?us-ascii?Q?TIudMf/FKDBZ6OM0xYlTGKklsGwFZUqa1j1UiP7g3W4xRxTNuigLWrD/+RVr?=
 =?us-ascii?Q?VePm0WZdA58uyeNJ0HDMZcvOV2hX5yAy93ehnokkCXVzhy9YP4l2KxV3W5Km?=
 =?us-ascii?Q?VlhscWpBMjG5EMaCXg82lN2Sayq6i46RgDox81Q2sAP3nPIJIIppcEORLY0T?=
 =?us-ascii?Q?O/vsAqwYhbcjyxqR/8hRxsswB4BT9ajjg0UXx8LQ/sQL2VtrP6X0Dv+vg9/t?=
 =?us-ascii?Q?yFU5hH4EFJyFZrOlS4Aeb3Va7fM28MVBddfhoPw7/VymN63Ihs5NBle/i5vH?=
 =?us-ascii?Q?jEzDsj/kuk6mTZ7+bw629eSuIjuSe0/4C+owwelDhbC8lI2z2GzkPt4ekofz?=
 =?us-ascii?Q?9fe5Rq/SQUdLghBJ3+a6PYd99W7xAZjaJVhsxOWa0lIkMzr5ua4jhIm690Dc?=
 =?us-ascii?Q?qMN19v4YB4cHQYhYBTg/EmwcaqC5hC8Rd3GN1GqpEtmmSmboLLIh35KoNCrw?=
 =?us-ascii?Q?5tH1LsHpChf5C4rebDcL7pknveiFe10+R/8q5faiYPaxfA5uPihIk7drXhE8?=
 =?us-ascii?Q?cTw0sf+WCPAeKF0TlJYcPObbwLDZHg8tOurIH4Wh+/iL14beOVfaddumSExm?=
 =?us-ascii?Q?eJmCg3yQdMFbYbjwt7NUBMPtfYC95Nw+D0tq1FisceA87b5YPd4v97MDUEYv?=
 =?us-ascii?Q?tX4ZzncJ0Ok71XOZr1+AoLtoKE7nHNqpOwB/LOfA8W5Rm8h6mFt9TJ5fkdaH?=
 =?us-ascii?Q?jKAsBJy9ghWo3R94aX4qaWbVVx8+0YioSP2CqQWZ0bNgufGEVpZp8Y4B4jth?=
 =?us-ascii?Q?ZStNDoumRqIVd5QE505xtA4S/FaKReAK0DnyhBPj1Hj7xcleP+4SM1FOxrV4?=
 =?us-ascii?Q?upwaEMYQVFcT1S5gQE2lTNOq9jC8CunlSAkaPDZws508qBmSbDvD9zQ2eDpF?=
 =?us-ascii?Q?SLBorGXqmRRqrwaeNfwrs/AuB7K0RCgA9zZcZoXy8COAxzdxErOryNtq4U8t?=
 =?us-ascii?Q?orl5P7AADhd5LmB1ti0/h7gHYmWrtF1qmKixaSlHLd3G+FA5Ss1dClGfZTyK?=
 =?us-ascii?Q?wsoo9en1Jkwrfq4p9uKR4AtofcUFL6HQpW4pn82dxSqb36vxtFUKpaQHDNqI?=
 =?us-ascii?Q?m+aH4AMe4wy6mKDVKnjuvo+2F5mNOOmknhxKnshhi8MLZxumm/3AbSagMu9x?=
 =?us-ascii?Q?xhbJ94yxH+GKB1eTEv4gDZozpQGhEolKizCK7WEGOOYXtOLpo1Qtud17tiVi?=
 =?us-ascii?Q?/iWhEUNMIx4Or6KKVWtm0y2drfcGV1u1mawg97kitTMHvYLnuElRKbYVvNKN?=
 =?us-ascii?Q?wREy78efA2JXjHyQidM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02ccc37-cf8a-412e-4fc6-08dceecf0430
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:13:27.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUgWukq0UBdJJ+50dJ6lA3FckrYW3Dy6KL7VjOFmba3VWAlcJcOi7/AX0oB4shND
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

On Wed, Oct 09, 2024 at 09:38:07AM -0700, Nicolin Chen wrote:
> For an iommu_dev that can unplug (so far only this selftest does so), the
> viommu->iommu_dev pointer has no guarantee of its life cycle after it is
> copied from the idev->dev->iommu->iommu_dev.
> 
> Track the user count of the iommu_dev. Delay the exit routine if refcount
> is unbalanced. The refcount inc/dec will be added in the following patch.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 33 ++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index f4be87b49447..a89a865617db 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -508,14 +508,17 @@ static bool mock_domain_capable(struct device *dev, enum iommu_cap cap)
>  
>  static struct iopf_queue *mock_iommu_iopf_queue;
>  
> -static struct iommu_device mock_iommu_device = {
> -};
> +static struct mock_iommu_device {
> +	struct iommu_device iommu_dev;
> +	wait_queue_head_t wait;

Just use a completion instead of a wait_queue, a few more bytes but it
is easier to code. This has some subtle issue where the device memory
could be freed while a concurrent thread is going to trigger the wait.

Jason

