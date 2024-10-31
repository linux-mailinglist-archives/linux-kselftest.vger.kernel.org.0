Return-Path: <linux-kselftest+bounces-21210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D739B7B6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9024E1F21E63
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCF119E7D0;
	Thu, 31 Oct 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YA9lGHOn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82613A869;
	Thu, 31 Oct 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380330; cv=fail; b=GcvTyIDMM9EyINY/fO58UAfe5YQdw4aUAztCrs03kEBJjOrzZWW7bc5LgNxGrsdUCKHp0j3EcXSc/xz65KfSE2M1yvf6sv66IbN0b7qsdhyOuMTOzhoJQWmhPB1j/x0PcBn0PC9zY66nl3ReTb7j2BpGyrHJpCSr3CWyEsweXmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380330; c=relaxed/simple;
	bh=tDrIk7KvH0bPYzQG61efQjx2hAhSIIHlJXu2WC59UTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ssaycNsqwWEtPL9+4sg6ycQmBAqlrZoBGhM4LdK7tHNPdZHhj70aDPWf9h1WjXw3VmDKecPjmXAIPMKnkeJsynJHzxOKFdQiUyWfyiEeCo3dBALcWYeOLTPVvQZ7q6WN0f5dX++HJsNSi86ioiaYih7pmZS+AjaCaKbVyT1TgYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YA9lGHOn; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJPiLEMlNbvTO4B+t6nZBQwvSkEOp476Ma3e9g3yDejzF37XfjGtzLX7+TwUagUJH5N3lLDPJMRNHBMHdnRSWjRhI201tAJ93nPLHdvgDO/0GH39NOXSK2xNzfco3rtQCSTjvjpyvEpqx0KWz+BlL7ZbIGSSrYYxhtYLlsYANYDCV+DUXvj0L1nKnaqgtK8awB8LW38gQi/HVo0ZyJcP9sxjKNd13o/1UsbhLQZCTf1LxnOJNf6jWFSX2mUK8CySxeO5tqopJc8JGvHmsShoe8hyyzBnhKiYsYkui9zpkJxNzuEO7rfdVOkWSl8n5ignM5H2vDO/NNMYiCS+SG297Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYT++5TrMUSTDSarr4q2vGrKIvKPdXkJ7jAVZP1fR9s=;
 b=QWyHYhNunFyumvew8CM4bfRhfPoWheSpoH/r2RFXa34eXiBJz4a58sajVdHnRl74qrpd0PuIWr1+wfbrRM7rL8QmwPuxEe/fdFKnohjNEVDcKV5hAlNCo55txCsErjmHSIX5zzSsQayH2J4diskHOLlr3FUMUAXXSMKhbCUTP6ZkOZQ5IRmyplQvY/HO8AZHXiCpgWHohK5eG8TEWe5mQ9gyBFKQLIqtB3hA20+nwQLaYDkiWbyeoeyPQxjVDIO+DXwwSAK3UO5l19IIFCR40dFPIQeWXhTG4MAoXqWhGV0lnk/nKppm6XTXANC7gU611HibadmNFDtUrVBt7wvURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYT++5TrMUSTDSarr4q2vGrKIvKPdXkJ7jAVZP1fR9s=;
 b=YA9lGHOniyWaFPFo3agtz2D/htK5dvUy3TopSnT5Co2qY9Xgfq2d1xO09+9mipcaxENr9cYMSlIopu4YF+FXqlI6VMc96PvfQR5wAEBJSdzl2lWR5tiUm1AqhJOM8qUqfcoITF4Z97/rovxF5UbjZwuSh6+1nMouA43vXhv5djvt2J4eyMjadOoGQejIL3KEmkv64iWniLv52qDHwX6TE9/+yniI0mEf00htE1MMm229AUpq1CCp/NHzL5BJTPNiCJ9d6j5/D8apIhBiP6fVpJlw7q4n92dX1DaBOio8vxSTqviRjzUQrPfR8H9yVdCC13x0IPPqAr9dfU90r4UcdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 31 Oct
 2024 13:12:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 13:12:02 +0000
Date: Thu, 31 Oct 2024 10:12:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 02/13] iommufd: Move _iommufd_object_alloc helper to a
 sharable file
Message-ID: <20241031131201.GH10193@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <52abef167409b25bfee559a0c03f2607ce77be3c.1730313237.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52abef167409b25bfee559a0c03f2607ce77be3c.1730313237.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0683.namprd03.prod.outlook.com
 (2603:10b6:408:10e::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4fea9f-b76a-4d4c-029a-08dcf9ad9c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/qjcREiaXHms1iO5bDa/fT1mDmOsBJAyF/P+7vLnHUebaBYQH2RHiw5yx0ky?=
 =?us-ascii?Q?a5MzRpNKA6LQ/e45DzsQbBwlAHHwjGS8t/2+leH4IPDJCykr8Y506lV0+ld6?=
 =?us-ascii?Q?7c761gYfDnBMr/Tm2GThlUdi0eKH3S5wchZnWIpkhqcMBIjFCHf95Mo1l4KA?=
 =?us-ascii?Q?HETsNEwE1JTMIVBRhu244WLjBfTFG91HHWwWNT2NHP1qOx9KdOzHXVKR7kC4?=
 =?us-ascii?Q?rEVjj91AZgfJFIKTe1ENTeS13/ZVHjhaULYVZYfwQel6xDK21s28fJXBn05x?=
 =?us-ascii?Q?YMUBw1pRfymk2mei061zX63whHgORDi7icPnQJ4b+LWu2CgL8PdV7w2fOY2f?=
 =?us-ascii?Q?2SS4YkT1IN5HaerFEYVU6nTdPc7DClbsz/OlglEtfdLp1Lhd1kvix81HAWqj?=
 =?us-ascii?Q?XVmp9c2xzWdbgSOIBa3vpfx5aYawwSF2yJifezA5Nl1jku7QbaPWRuYlCgAH?=
 =?us-ascii?Q?dkWNDKrCBUVmxKaPIxJHXXFs/t0OPXI43UadmODMJsuu3VOMyFEEHp4DFQj3?=
 =?us-ascii?Q?V1ho4iD0PKUO36AAxXM47/WjCgMnqbXJjeFB+vM9dMLforfqS9UtQKh2NteB?=
 =?us-ascii?Q?wOAPOurqYTI+1FirwQDgoSKJp2MqeXl9k3bYVUbVcXpnbd6TY3lOs5EW6vzJ?=
 =?us-ascii?Q?qe3o+UiYrwUNTrtp4DI8gNWD4sUPAifTJAAOwshJApRb3zW4pM8jV5764lQb?=
 =?us-ascii?Q?mbw6zdBR+4cUe+aCEqkDS7EUmkaI8TxrjCtm7mbXOL3GGpgkLtsi0oq2j8yu?=
 =?us-ascii?Q?jL1POTWG3riHpqxUp4UCPo1DBqNPhpUgIMVs/iWq6h/1GgUErWpSe8YiwvvH?=
 =?us-ascii?Q?liHM8H8rhQmYR7FAxQDOth8fu39jQsr+weeLs9ZE4XZ8iYU5KQfFx+22KxaX?=
 =?us-ascii?Q?CZ7IzNdHNUKCgkUsttr3qJbB7+tbO2pJi5L8G2RJOWHfSFzaaJ/1FttGY1Ja?=
 =?us-ascii?Q?XlLdHEsY/PQx3EtD5KhnWOYsnOYMXEw3ZUsld/gFloCsqJ0o7UC0JssB3kZU?=
 =?us-ascii?Q?/Sl0/SOl41hXlRwJ/ytCa9/Bnr0OLe4uCDjryDOoVmqhviN664JlTct48wjm?=
 =?us-ascii?Q?nMUtPy7Ug9iLOr18bzT+TyFHHeqDBfGaDNVivXAOENnUionm/wqyOOJSy3ib?=
 =?us-ascii?Q?e2WlLNQWbw2qwfpODOerTGak6pl62OOlCqZqhmnKMlgjNmUzbLXQgrcEPQmB?=
 =?us-ascii?Q?gpGVAPkhw7d+Op4tseDhnJSPR2p1bmk9B4WRTNKlPI9OW97WJFZUJ+clcZCS?=
 =?us-ascii?Q?zRakPRqPpJXPD2arzeB9CEo5j3eT27lfJVD8qWIJVNLvzvaFAUJ3cMTfzvhC?=
 =?us-ascii?Q?NxGZu92fVrInMOAM11lxdo7E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NvaYDQieSNl3V3Emi3XqfJphg1zTDndWFDgu3x2JrbPAcs4C3EwxXukBqkjl?=
 =?us-ascii?Q?OORILrgwyr5fEWhQi54LCfJu78WWKHSuyNbWhvgUMMAt3/fYJ51cA4NihD22?=
 =?us-ascii?Q?Z+Oq5WDa2mp26N/WNAOmUWkX5AeIxRF8tUrfWY1iMzymS+36unPXRG/wFbwb?=
 =?us-ascii?Q?tmdnVIz4SMSWnUk9dCFEdcgy4SwmISYf5c1KlX73gq++bXLoiQ83NuWOIigg?=
 =?us-ascii?Q?rNraTuwC4xQgZlsHx9ih7oH4xAnCIwdnZktHY+dnlht6x+Pox9JfXFsWIGLm?=
 =?us-ascii?Q?la3FfZAU3caK0SP6R+2TsJsvoOyizwl02yEmRSZvXXCWym79Va13gBMxoc1A?=
 =?us-ascii?Q?Jg+OO4uBv+bS6YNNqRqyEFd0g4yvFMs9hKjLS3ZuJsEg6Fjmerl8tOb4UFDB?=
 =?us-ascii?Q?To3RLand5DiWOdDfwHa0isuRHCB6CTzXnowr5quMzAz8dHXY58YmF+RTto54?=
 =?us-ascii?Q?eAyWHyda3LWeITbmAh93ZhNTHiXIboA/6cHF9jgrRZpsncKMspRF8uhBWpIE?=
 =?us-ascii?Q?8vbMZLG1lYszCAQQvRdMriWY9puOM9qabtCj/OZQO9OoxFcPCSz6J2HVg/H0?=
 =?us-ascii?Q?cLMGZHOEx4hNsMXHAHhK/ZLpbeGY+1G94TarvWIkCP9mbW5lstNvz/jA5k9u?=
 =?us-ascii?Q?t3gm96AmIx+rS5ymVgOzJRvGArLeBfJILw19lm5eNuKIX5PJHP3rnAyzmeAp?=
 =?us-ascii?Q?uXKgX25OFk5WcbrbrnQCXdQ6n7b+xCJgo+vqC8KFY39diG9P0kUy5fpEjMc1?=
 =?us-ascii?Q?KhOXCNqRlW2YTb2hKWkGK+CWNyB335Fws1eqoy7w+wW9UDhDPL0RQVLH/p/W?=
 =?us-ascii?Q?wmhGdWyY3VaSQgGc93pUumOUKR23k6UI1AEAj/RQd6F7iZuoP0cm7fTIsLes?=
 =?us-ascii?Q?UQjMJludH+4fZNQjzXRdq0ebwZnzHp4p4Zb2NAf4j/uR74/0mQlX/7yRwti2?=
 =?us-ascii?Q?04QKrJ89jo6ntuT3HVJHxkLB9dgyNk1lnuz6pLphqnC5eZXKZjxTwNpYmsrI?=
 =?us-ascii?Q?wf5tTbZHKyzPT4apMr4IqshujM6cTD3wGKSEX6pDo/LG/2DWt4eilJUuHnc0?=
 =?us-ascii?Q?EprVfo+QzQ4/9K9+PQvGy85Nw3OLliV3lqphV0vUKg+UkE0F4tBSH1uilCS0?=
 =?us-ascii?Q?Pab2QPkyMIeVW/CQYXbiQzhtsl4/R6GliR0mf6dVAlFb825yerjPkoztCH/t?=
 =?us-ascii?Q?YrG1TaMZ9rvioGzRaddvrXVvtpi/WbUQMjK1vaTkCr84iXDb7hotE41E7Hk3?=
 =?us-ascii?Q?5ZPmkfws6/KDSC7lhnjUr/TX2KQxQIlfwOmTbPgxZG6l4fSOl8XDSQ6Q6MJQ?=
 =?us-ascii?Q?lhsoFzlkwSbsgW37YwqmRuTRNnkKH4Bf5JzI9aaprrj84bqiGkgJWDjL/11e?=
 =?us-ascii?Q?SqDa4Dl5RUqo/Dc7KuRPoLsNLCEyhywP4p1u+EBupsPbqBSRJAJvTA9qRrf2?=
 =?us-ascii?Q?9moif5Rc9EMllSeOucvof0pXyUGbhut+qFZHBIkJPcR9jNSeM6UYGCm9Cf02?=
 =?us-ascii?Q?Rcs9NXkS1vpm+b3dEVJqP7HvPAzZI8BTLtwqMuEE4/7J0ZKCJchJxFOGrsvP?=
 =?us-ascii?Q?XDiA32RPfEFisJfMrAc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4fea9f-b76a-4d4c-029a-08dcf9ad9c39
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:12:02.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9OrtMzqvCKWqBZty1C0m2SDxLU3ONqm4cOrCsILFqqmiSubli2y/YlHIAZAIDFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

On Wed, Oct 30, 2024 at 02:34:28PM -0700, Nicolin Chen wrote:
> The following patch will add a new vIOMMU allocator that will require this
> _iommufd_object_alloc to be sharable with IOMMU drivers (and iommufd too).
> 
> Add a new driver.c file that will be built with CONFIG_IOMMUFD_DRIVER_CORE
> selected by CONFIG_IOMMUFD, and put the CONFIG_DRIVER under that remaining
> to be selectable for drivers to build the existing iova_bitmap.c file.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/Kconfig           |  5 ++++
>  drivers/iommu/iommufd/Makefile          |  5 +++-
>  drivers/iommu/iommufd/iommufd_private.h |  4 ---
>  include/linux/iommufd.h                 | 10 +++++++
>  drivers/iommu/iommufd/driver.c          | 40 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/main.c            | 32 --------------------
>  6 files changed, 59 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/iommu/iommufd/driver.c
> 
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> index 76656fe0470d..83addbe2ff7b 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -1,9 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config IOMMUFD_DRIVER_CORE
> +	tristate
> +	default IOMMUFD_DRIVER || IOMMUFD
> +
>  config IOMMUFD
>  	tristate "IOMMU Userspace API"
>  	select INTERVAL_TREE
>  	select INTERVAL_TREE_SPAN_ITER
>  	select IOMMU_API
> +	select IOMMUFD_DRIVER_CORE

Should drop the select

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

