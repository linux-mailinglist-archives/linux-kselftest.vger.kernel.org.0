Return-Path: <linux-kselftest+bounces-33954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BEEAC6EC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 19:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B53B6144
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F528DEF4;
	Wed, 28 May 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C92GKxf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA721F4184;
	Wed, 28 May 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452133; cv=fail; b=T+0jQRiwW2FdRE7CFNjvuA3iQ80C0ixeaee/L3sCauGDPAqZWwtHLdn98bhop3xvHMe79tHs70Yi97Lp9m/H97JFI8IG6m2/4XO2ln0jyUQ1R7I6t+YlLSzQKvdnvhlCliuJMJZIefoZuDlK+EG3em8oqjGzUEzjt8amwYzFXRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452133; c=relaxed/simple;
	bh=WGNeheCiA3iUB+0C8gVhc3AmbvQGLETLWnuMinvfdWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kchQs1KCNd1ELJa4osBmhh843fA7I9iqESbzIZaDz4+bUmS1+FB3eA/fjjIa9k5qICXpBjl7jJoO1xtC6JbIu5DBxFgyJd5XpYcdryR5BKR1EDY74VfngVuSzoavH5A7TGp/9gY1gVEACW3Q5c+wht0YWME+Ze0acMj7sd06sh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C92GKxf+; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk8qW5E+L3pmrBL40hk16bATis5dLGyGpOGaTHKUS9CNXrZA1Akq5OEgEgrdLM3gKApxhQjeq7jd0SsZPseK33mLTXHMJCSA+Lww5WDYSYY9KvcI3SG1JHGV3cMX635zox8aG/NzKF6n2MkUJ3Lhbj94E0yAF+UrpDqHJn4RHXRPQi5CmDQQUnA9J61ltm5zAaL3f7x6jngsrsdXsLu9KwD7pvxkhigENFB68As+fXUMkjt+5rfQMQaCOxSFtyA9S0+U7hSuOUh6UI/SEb3prKTFFYa4XdT92iRCixhGTzD+SjiKZGnbLpbt6gPtj06OgPbcjDDjg/2e9ettQOIRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USmE7MIAJULQcmjuOQMp0PtnMoVzh5eZMW6O2NX6z+E=;
 b=Ipm09z8Uu2Gk/OwQ0cltfF+gWcI9hxtS2+lRj5uEJ09Hm8JPmA90iJ9tiMF0DXzZmUTo3X1KB8dtzg4dh6RIHL+vXErpFKRRKZrUbPFUuS629k87ocJM1x6e8GLW0QsPjhoOg/g74vyRMKxiDzyOyCC7UG9uDxYDxvepStgWahUS4mdrG2E/8DiPxeQkZO0VXBJaXlCd56LH9042a7/P/5+RJDvXYjcUSDrrHUcvq0TgmF07Qw1WY4rF1yoUNYddj/ZkPIjEHyE0bYuFkK9dXagKf5Kci9QOv9KL/5jAGZPKX88LQfdLxpcSkEqpZL0ttXZkakByx4urdmDcEppK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USmE7MIAJULQcmjuOQMp0PtnMoVzh5eZMW6O2NX6z+E=;
 b=C92GKxf+lEbPRk/EIEraJCR4tWJaSn7SCE7jGlpkFC0GhyZHKoV1wIEx09sTxkcVGwNfEvcJtB5yfH8lKQn8a4gobXD6CXTwOf+xR1jTDK+GlcJMXwa44DhD1Zox3S6tFqfgQpjwn0LbfkA2kGePXmH61icotvymEfSNOVcVLcQYm1NmrV53inWMGocUBze2pLDvbss1AdwqYeuPFTx1/OaNYzIIBi6bxPqMQ9Z7SZ85K1LFM9nM2jBTQpbuLbcH4GpM0jaUGuEy2B4AaDC1kYXUPGO1zaQooIoBvHDOzOYT6yfYW7AgtbPrU3hiNJOChg2yb70xkzS6t3sR/a/CoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Wed, 28 May 2025 17:08:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 17:08:46 +0000
Date: Wed, 28 May 2025 14:08:45 -0300
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
Subject: Re: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Message-ID: <20250528170845.GX61950@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9251c734-4665-4ae3-b3ad-08dd9e0a4e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9n6tVteA5IQe/QtdTGrdu+TlfUKfyIGfNP4fDMyblGC/B1XsZjVf3+GIIlBA?=
 =?us-ascii?Q?qdcSD0sJgbSqKibPvKXXFkk3UX3wzt03Kpy14pN5Rk1K+YsAE5lwP/LLxA2D?=
 =?us-ascii?Q?mCx86TTnjZrtpfGjam3fPDlXLTpRzvSQqgbujN+jh3/iRezXN7Q0Odb6+0VF?=
 =?us-ascii?Q?kTaE8xeCudAyu2Hi863bz7W23+TV0uR5rK5T6nfUfvXC9bAfgtYbBwyBLwkC?=
 =?us-ascii?Q?IAHGG2+Y1XJJbfO1Se9TIuhtZjPMDeF35vKV1nPIptSJ+VRkIJdOozUa3YOe?=
 =?us-ascii?Q?pSeeyp0+d/DtkaiirQx/MJlxiaG9O2zApMMZPQAtzbhEzTYycj19GXedtENk?=
 =?us-ascii?Q?VfGVmU4Hb1BM+MOVhAOOkyut3n3xyMFHIOOY65Ju/gfbW7mMlZwp2yidYdos?=
 =?us-ascii?Q?LinaAF9LdEwIm5hi750RJuzZt2J5tgrzTxpofCgXiUYPq/H76shqLhduWBq5?=
 =?us-ascii?Q?9Eu2EitR3S0XoS+TvZKs4XUIUuEvuElgaK+p95T2juXvlmmBSLZHCXqYVNkX?=
 =?us-ascii?Q?yuiwOXOUvmS45+U2UcVPvvBIhutZyMAUtNmXCrMH/0YVVc0DKutv3XRhB60Z?=
 =?us-ascii?Q?cHTycRohzcpm5pgoAPaQwL/H6oNU2iLeG8AuRAAZthjf7muDXJItZ6+HCiBV?=
 =?us-ascii?Q?ODeKkjD6lReO4q/iS9ytJbrgkjbDzYXQW3DoBCrsHX4nXcqvzyq0ACDwB+w9?=
 =?us-ascii?Q?gjJy6IxWulIOMLIfQFRMBx1LiQB4eyRmmafAuFWBx6eyqE1U/T4FvFQOap0J?=
 =?us-ascii?Q?+tQGDs12HHLiVvBQpe5CakV90lyTmLOF13kup8vivp1hkiOVLHdXddFBB+fi?=
 =?us-ascii?Q?xa0WuqaJTzgphDU4m2DklY2isreWmDYV1upVyB40p1FXHX3XOpEHGHtesF3b?=
 =?us-ascii?Q?CvEZ7+kS1CPPwxCVezm2x1EVwiCIJ5/oUHeK3WP7LchXm1hE3P0NDuL0Opa6?=
 =?us-ascii?Q?Z6q4a3OxHdvXDkjwr1YjbzA7/vyFTaanjX8aZxmheFd2YdyhJebNRf/T0r72?=
 =?us-ascii?Q?B9heO2BT/iGdCHmkslJPSlgHfeau+atVusaLQpJKMqss1oFOYp35LQnrBLAG?=
 =?us-ascii?Q?CcGOIaLaXUBlS9xN+XD+ftxMfE2rj0OlxCZiuNgIXZ3sZY3xk7lBfSesMyl3?=
 =?us-ascii?Q?xWD+n9YcGYWccZwFCZhssSnpd/p5BDhYMnrCaMja893+WU/3mWNP684xygYo?=
 =?us-ascii?Q?Pom0WDXCECtlYh1Kc8NoJNCsMAWph5oUJa+TRJBVnQlJPRlQAKjP/uYwziqY?=
 =?us-ascii?Q?iCJ8K0pkXKkHwMF7ynlCFAcU51P/zgjuTb91uPGHeCPNvZ71Xcqjkd+tdK7x?=
 =?us-ascii?Q?5PV1wfjpnxXN83XBVHvSgPFJgmspwZbHpw9WsPXLZLNmdaso1HiIQn2pY5ea?=
 =?us-ascii?Q?lG6h+7trTYNRHdlpx4Vo977FOTU71j7iLApcZquKFbPxwD55kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hYI+GIlMVcnizLvtwNvWNrCkltuyHWK+sHEpXsGv+iQEOIbI1I6ucthBDaMF?=
 =?us-ascii?Q?Jb1GW5QsQRuzUfdhKuNzU4bDwGkdlCDfa47WbTD1rYYLbCZy+/nfKfC/3bId?=
 =?us-ascii?Q?toQ4+WePE8TKgGRyDYFHSShsUHwHP10Kv6NCd+qUetawtzgqM6XpL+APLVpT?=
 =?us-ascii?Q?xSZBjdHoBpkEmOxMTos8umpn8UsrZRjs+JLm7L/EPGPgNHSr3QTk1r2btq+7?=
 =?us-ascii?Q?nlLhl0F7ZjmMOcoaIdJUBoSQiPiToDqzdqov21H3aZu3TaQUHOBdy+fTUYnr?=
 =?us-ascii?Q?h1ikpJ5cX+lfCMGMqPiJ2u1upf4TtCxYNtdm1UtfAeGFNC/xzX3pTVQIeZQW?=
 =?us-ascii?Q?p2TI4kRhoFqKBRLbkQRJzLx2CgjR9rTy2SOz16sVK2r7y2RjCwUQyfn8tdsE?=
 =?us-ascii?Q?XXVLcDeYqd31zEFaeyw5E6qPi94l2cik+pjQS5+PD2mztx0VUaWrDS2FMw/6?=
 =?us-ascii?Q?tyx+qHPQIKa+217E+5D5uI0bqgSPrtpmkrFS75TY5QVGdGdJAEfaIWAXxsar?=
 =?us-ascii?Q?tl0WuIztfQD9/kPeMcJDefarRCxOlelO4rHsn5RZkKGYgaHaJTHMP2BItScm?=
 =?us-ascii?Q?bmoLLtwXO8JSIPUZC2L1PrbL48WJGs9pC4vTZxf+z9ushjkCfyknUxofBfU+?=
 =?us-ascii?Q?UYfOaqF8s5m6+w2W64R6M84fcM8+VOwljWki4/O10VxNdRyd91Y78lbvDp4S?=
 =?us-ascii?Q?bDIYHrMR44n0d+SCJ0sw9DyCmatDr7d6sbej5qbSRjaW1OcAaZLHqeqMBg2S?=
 =?us-ascii?Q?E08FVe9Nhd3Phr+s0WlWAgmGcK+TW0UhXXFPoALN4HgQff1C3y+YESis7+sx?=
 =?us-ascii?Q?atwMV87p+iOV65C2RgmxKEAXuKsVw8ilDiJQtHmu4JJUy+y0E8o52pkLqtAf?=
 =?us-ascii?Q?eKrgJ2B/DNyLpplVFjCNxvL6r4XcCXxylwdM4SVaKXLz1qUya4J1ociQ1Baq?=
 =?us-ascii?Q?dUmrH4+WPn6LdNUDTPlMve8+/F0Q9gQyEzB2FVcvHI1dGiz0LD7BexIZA4EA?=
 =?us-ascii?Q?e6Xod2NX3AF1PElGhsZBA4+Zd1BJJISgpmsqpKa3WkjeAeGU6OW6VOIGZG7F?=
 =?us-ascii?Q?EOuQmuADt4g5HLDULD8qy3M3hyU8GQVV7OLJSIxI4m4lE9Ua/fWP38EdGsv+?=
 =?us-ascii?Q?EDIqoiTDiT1qraUurn5POWRjxlDnwXTTwJ/TgMZpanhZBQtEMPSs1G7ZoktJ?=
 =?us-ascii?Q?ZVpiATLBrJ1Eh1ID6oGj7txMz93RfN0PJJpM59SG/JSimNkHVGv1ITjFDM0j?=
 =?us-ascii?Q?ep+wG8QvCw7G8UqmUuiKo6PQDRZeR4Zx20vOPr7O+sRw/cjHPgcXcG9hUhxs?=
 =?us-ascii?Q?vmeisRcIgJWUHALPRkUBBJ4RENUbeXY70CLiyuaDaTbw5f0SBndrzlnXfwoz?=
 =?us-ascii?Q?8gOuB9SIIPnQcmSxmzqqFE+Rb4mA0mxfuZrJ1kYIE2LHdYjlRpxqcA0sSBNW?=
 =?us-ascii?Q?ftMQkG03HHU4bu7rqYCaEGb5JJa9Y3rv45N+CJUZ2QB4QQ6LzPsX10sV/rj0?=
 =?us-ascii?Q?RF5BkJws9AUOLkkBEV2BnoyXExTTpwcuD8aIShd5iXqkqyXWXV3LjXKMitDI?=
 =?us-ascii?Q?PqtyFS3jbc2od9HpWYwwKM4uU+z97zkIw8DrTe3q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9251c734-4665-4ae3-b3ad-08dd9e0a4e84
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:08:46.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW+TJhsbdMg/lwApMhYc6HxJGGoyhqtaAmGDwaveBAKgdlHPCgVv+8N81n4KB4m3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

On Sat, May 17, 2025 at 08:21:26PM -0700, Nicolin Chen wrote:
> Do not allow to unmap an iopt_area that is owned by an object, giving this
> owner a choice to lock the mapping in the iopt.
> 
> It will be used by vIOMMU's HW QUEUE structure that must prevent the queue
> memory from being unmapped in the nesting parent IO page table, until user
> space destroys the HW QUEUE object first.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.h |  7 ++++---
>  drivers/iommu/iommufd/device.c       |  8 +++++---
>  drivers/iommu/iommufd/io_pagetable.c |  6 ++++++
>  drivers/iommu/iommufd/pages.c        | 12 ++++++++++--
>  4 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
> index c115a51d9384..2f2a47a2f9ee 100644
> --- a/drivers/iommu/iommufd/io_pagetable.h
> +++ b/drivers/iommu/iommufd/io_pagetable.h
> @@ -48,6 +48,7 @@ struct iopt_area {
>  	int iommu_prot;
>  	bool prevent_access : 1;
>  	unsigned int num_accesses;
> +	unsigned int num_owners;
>  };

Owner seems like the wrong word here..

Fundamentally this is supporting accesses that don't have an unmap op
callback.

It could be done differently, with the below just create your access
with a null ops. Prevent mdev drivers from doing this when they create
their accesses. We don't need to optimize this failure case so it is
fine to scan the xarray. All we really need to do here is eliminate
the WARN_ON.

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2111bad72c720f..b88354de299449 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1206,13 +1206,14 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_replace, "IOMMUFD");
  * run in the future. Due to this a driver must not create locking that prevents
  * unmap to complete while iommufd_access_destroy() is running.
  */
-void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 				 unsigned long length)
 {
 	struct iommufd_ioas *ioas =
 		container_of(iopt, struct iommufd_ioas, iopt);
 	struct iommufd_access *access;
 	unsigned long index;
+	int ret = 0;
 
 	xa_lock(&ioas->iopt.access_list);
 	xa_for_each(&ioas->iopt.access_list, index, access) {
@@ -1220,12 +1221,17 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 			continue;
 		xa_unlock(&ioas->iopt.access_list);
 
-		access->ops->unmap(access->data, iova, length);
+		if (access->ops && access->ops->unmap)
+			access->ops->unmap(access->data, iova, length);
+		else
+			ret = -EBUSY;
 
 		iommufd_put_object(access->ictx, &access->obj);
 		xa_lock(&ioas->iopt.access_list);
 	}
 	xa_unlock(&ioas->iopt.access_list);
+
+	return ret;
 }
 
 /**
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 8a790e597e1253..f1cb809500fa19 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -740,11 +740,16 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
 
-			iommufd_access_notify_unmap(iopt, area_first, length);
+			rc = iommufd_access_notify_unmap(iopt, area_first, length);
+			if (rc)
+				goto out_unmapped;
+
 			/* Something is not responding to unmap requests. */
 			tries++;
-			if (WARN_ON(tries > 100))
-				return -EDEADLOCK;
+			if (WARN_ON(tries > 100)) {
+				rc = -EDEADLOCK;
+				goto out_unmapped;
+			}
 			goto again;
 		}
 
@@ -766,6 +771,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 out_unlock_iova:
 	up_write(&iopt->iova_rwsem);
 	up_read(&iopt->domains_rwsem);
+out_unmapped:
 	if (unmapped)
 		*unmapped = unmapped_bytes;
 	return rc;

