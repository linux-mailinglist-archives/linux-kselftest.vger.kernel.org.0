Return-Path: <linux-kselftest+bounces-26406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EF7A313D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46A43A2216
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9911E32B7;
	Tue, 11 Feb 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jweKcTQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BF261593;
	Tue, 11 Feb 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297788; cv=fail; b=RbyFUaC56wyUrYBxBwFiKaITmyNDorUPJbBrzk9OKaj9h63/GSIZMnqEIalVHA3Q5nTEww98sPpX9WeUy+AZ47dTwsHA3Y1mvBBlT5CLoc1H2BTHlv7VBZebzztQt/CRL4UELsksAUDO3wSub0AQL4E3OFfHaHm6dcZw2eFaKUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297788; c=relaxed/simple;
	bh=UbD1pv9twy2StCGKNQD1ifCPJXIQtWuXXdY/dsjnc+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ebrdmXsIno3XcICBGW4qK7SWzt1ip9oKCLkkBGVP0mP3KZRo0kDKjaK0Q+6JCKzLbUrrSAeeDuWHvK2wm+Xe7Px15tsMvpYdFsBovv36UJgwAilvIAmI8rWGIa4goxPReXukcnIdZHLznKS6D7Lj1L5G3XpOaEQgc8xFmYo0yn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jweKcTQ/; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8gvQJ/35Ax0nGxR/ZMU4uZrivgN3nzpYCsiAApcyuvtxM+cb1FkTD53HgJXLbgMphjN1KTh8XDgQfdbZtMJdSSpKB6ikx4dOSXWCfozj5MWC24mpdrxkhR2GYx/Q1dY8MWKkxqkoSdRcgjEjr/aCW15wfxREcjDF2E6TAcEYjPgzn0nI97/ZdQcD8DAeOVbeClJEUaEefFjr2wi5msdWg98HFpGqTQxzcpQMCyKIGx3QgHOnkSjKr6AGrHIBPfqtKgURFoEfGYgtc+XPHtOkBVvCQJjqa45xVJl27+4qwqNB5GiBbEOdkotqx6D5Z3WliTy5wq0i3XPAj+G2LOOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOyOF20S0mMuIrl/iDCeTLTqZ9AGfL8pYnCszW4g8lg=;
 b=iA63aliJXbX5fYfAsLCERAMQ/nstPsHcL0fAz6Co70RoI+e1yvecwLBXC8ZcEveSY7nUTGKw4ed5oWRtSylRiSD9spyuoSy3BF5ynNRDPRxxM631Mvb3ZiYNzs1TIIGwtmLrT1lVMEBdrMY/Onc0j6+B4sUna0mAO1lKV0oxQChCz6/zIuUnICa8QedHiS3nS0dXC5HRjLE9eS1gR2XDjjA+eKciSGjpFVS6Y6/X0OGCZnKRZmDveZqloOmMguCQZeq3NVpHLJPypr6L9ymrmkCK3T49Wbg+2WkiEqhSBVeiAt2699ltgq1ut9uh4t8mH2tMzb96jOfG+y+qaqdOAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOyOF20S0mMuIrl/iDCeTLTqZ9AGfL8pYnCszW4g8lg=;
 b=jweKcTQ/MnQi4GXGTcO/ZJ3kQo1h8ZOxNLBbJ4aA2L+lg3jEQwSBtRynG3E24/tcO47WfHYoy6atQqXhJLsJKceA77IcSmfrsz3AA3QnooCRKcGwrhpGPQtSlQyaTP3rNB5FZtPnku2yhiHk/LgX98FVeknfEjG6hXZKL2Dgwr5sx4NZnPqgp46xgUsTyjjS1GlNXPR/dC1J30WcML7hiVCnopXmdlborhYoU1HBQV6V8LLhZlYuw1wahjNhegwL+6/qYqUhg5yktyxBwNIF5iXKhv1mOE2wJycqzQgfSLPBmmNre8j7/WXirnYhMdPm8sYNn/zyjTIXCmcRBncNkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 18:16:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 18:16:21 +0000
Date: Tue, 11 Feb 2025 14:16:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v1 06/13] iommufd: Implement sw_msi support natively
Message-ID: <20250211181620.GK3754072@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <98233d5817e66bb7363090526b53422436894051.1739005085.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98233d5817e66bb7363090526b53422436894051.1739005085.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcfba72-81f7-4ee7-6b96-08dd4ac82fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SDVkHH9AB+T4xBPk3mq8tx6Cn2xZjdeZBpbndY/FmjGyvT/ltgXzsrq017dw?=
 =?us-ascii?Q?H4htBytmEUwetkc6ZnhiDM/UjfwMV+7c4qp2xd/MoZZckNnyGQc9NBTycrFs?=
 =?us-ascii?Q?3yFlcPNr19lc/9l1xj+c0FZPvH9QuScGYXGpblxuzzmDPgvvEhe7amfIskIO?=
 =?us-ascii?Q?X+OG1rkCPxAJwlGGF1jDrBCHt7Z5TVStMFpbm2HQEwKEXmHMe9btJ8ZALiIz?=
 =?us-ascii?Q?2M01fu8slrkI3g8BFsam8gLgMa4lzoyRinDdpdW/nLSk3h2/J3126cOAQJAt?=
 =?us-ascii?Q?l9oL5JQfYdDU4qIdrtgRGB1mI6tvvjAV7i3kjVDAzzOlWXb84iMrgykUaaSV?=
 =?us-ascii?Q?AIVTwxMHy7lLRUfVuK6slYdLUREWm+N99qaZpZAhxVPHA13jMM3bFTZzatk1?=
 =?us-ascii?Q?Q278EsYrIeOmSS3y0M2NF9DoyIPxHUhyOks/TELkHhFrbUBh8ZWqvn0wESU+?=
 =?us-ascii?Q?cRc8W81lVHgbY0kgf+exsXxtj3cVZGUBs+3UZd4XfuVTZP2hV6gngrkrTtXt?=
 =?us-ascii?Q?JPuYtJ/TEKUjF+Bs7J7bm0EPROZvKqdrwMe9kHNyAI1EnVnX5l3vaB77noC9?=
 =?us-ascii?Q?+DZ3DW1mUqv4McbC59NVQloz1M0k+UHpWSNBul/YujU2videtrB7JmTRmn79?=
 =?us-ascii?Q?RBlxUJ4CoHNbG1Od6hfI5j+mr3T23wZsSifCjt9wkYCfFVECQs/9qNk3mqDM?=
 =?us-ascii?Q?RRCpabnE5BUlulDTN+zb52gMoU4DnaDevoSE547Vx8NFLcDZpHlMNLmQlYGK?=
 =?us-ascii?Q?7FC2PPJuFDvp4GYgchXyfYmRTOLZ/P7RV6FyZGoszJEgrtY2EE49wwymqo7U?=
 =?us-ascii?Q?bxgCPb+xbmzVg82qkw/TrOBoDmYoieLwAkivEgwDO/1EMD1R9ArlvyhZmuAE?=
 =?us-ascii?Q?ggodZ8SdXjot5waaFM+65BCdPV2epdJO96pKFdNs1oWZr4gMga19fyEiUnHg?=
 =?us-ascii?Q?SdEzJbsg35kDDwJrG+GCuJ1v0s9+ByyhzxkJ3/JHqAbcrKcbgJuEtOFjVW00?=
 =?us-ascii?Q?Nn+dC66a9DAURZLng1vgkFeO8/lsYE+zziW9SqcRNGtJF7LTxhu2PQmQ0hwe?=
 =?us-ascii?Q?GpDa/kHr2lqau20OhxXjx1ZUAtPfrOaTUgJ8+oJBVe4WiPpxxcPhGj9Ut6yP?=
 =?us-ascii?Q?DPLueFzMYuzaZ9aJ+u8obbxDAun1nJv2c3Wz/GUTCxeWoeMoKjedK1vercJA?=
 =?us-ascii?Q?pj2Jld31jDwHNu3+fQ9bDSouVOg1S239dnPE7zeTPQJUOfEcAzqsIYbeIU7n?=
 =?us-ascii?Q?yTQ+h/YyJT0Xq0jO48OasUUvoNoSaVUJZLI21MXYHDiI7dzFJ+pgQelHVhSD?=
 =?us-ascii?Q?/FirTgN9ZAiK7xJuF5MTy8Vl75TXzkawqjdKOu581tLQ8plb7+tWPtAD1q3e?=
 =?us-ascii?Q?jzDNWVFOT4dxpCsEtgPdbeMrTyD/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tn91aT5hvS6yAYFAEW/7DwI3dwrZFH3DzodoP/uJV8Qk39qpHRcR65PRj/Y?=
 =?us-ascii?Q?oGXLowcrb9jbm20ycFNnUJlv0Z71V2rt6JwnyP1T6PwMl6x89SBiXr/UtaaB?=
 =?us-ascii?Q?8FYnpYbdx/76yhvCM+sNcbC3bsHPz58WVEngDNEKj+KXCu9o/SpN4h1ufkEi?=
 =?us-ascii?Q?Ymlc5skEfVvL1I/jJNdLSE6ytLnjS9Yw1uNtv3CYxwWImZNRwWCV/W1ug7q/?=
 =?us-ascii?Q?eYh1tHhOJs8itjrXYqkMUyyIft+1pbzceX5Bw4ioPZW/lXvuyLk5lQrqjxuC?=
 =?us-ascii?Q?lWViUoBnb2fiGhlUijK7hLUtwS4ds9RameRcBfmpxMefffLpIMuTNC3Ky+Q2?=
 =?us-ascii?Q?HjoxMfpoXZ0X9soW+H2Jz1bvCtckUgeKP04/3NgB4CU5vUyKxFoNdGLDdOji?=
 =?us-ascii?Q?2pijOFBS5XFP0rpwhrFuF/14tqnOoWpqSlalZh3V4tjlAGCaIjoL0U9NFvnW?=
 =?us-ascii?Q?ocHogMyPdFzH7kxAPC4/u7+jOxx/F1W7+IjGQX7n9LSvkhL7lUiQJETl0w7k?=
 =?us-ascii?Q?SAdf/KB00AENatjUVKb+jBIcbHk/gjinz+2y2Bz6qqqRGP4ob4GIqiK/Tytv?=
 =?us-ascii?Q?FW1f0CfN0vsy91gsEydLR3WMFgJH+uoE/kD0Qbz/as5YY1XwyhL9pPiljzuw?=
 =?us-ascii?Q?h5kmofwhoVafBgzMypZZEjye5IgjpbwNGrymhk3joO99z6sZwEXJkUfEiAI9?=
 =?us-ascii?Q?tPyEyhPIVcx3lkP3nonw9h3pDRUWSRrjQZR4JURkK4sJzGuSAdhaQV/dBYwu?=
 =?us-ascii?Q?lXeLbHSSX3x5uTU+CTM0lR7J8j33NmoXIrgsyJZX6Oj+UGiiYT5MxFIEXN0l?=
 =?us-ascii?Q?VDGQH0pxYk/aLVa6shq2VUHygQixMnzeAZhqlfsCrKLNNQqeX8YrRabeXXuE?=
 =?us-ascii?Q?mxqBg7tmGlQjiZrnesZX/87e0hj7FZtLw56yxwiW/CosNnbg34YWvq86dPbZ?=
 =?us-ascii?Q?Dpah/LtK2PLrkBimZPHsDEbXChNS8eVWIXvmJrXq34ZVKNcfkMtOjZ1ZROAR?=
 =?us-ascii?Q?tOlcpu3SNItGuQzRiCNDcSeiGopkKM0QREOFSJ4lSvoOsGr1VjY10xmWeL9N?=
 =?us-ascii?Q?q4GBb/X4xsf4XTUrVjz88ZS69mpfAUcDY4grBL2496MoqFZogWV4cbpSslKe?=
 =?us-ascii?Q?F/pJkvNj6swaT6QPixzccaCAxLwnVGXLKO7TOY/6TzlpWkS+AblFXlT8n/fN?=
 =?us-ascii?Q?j0NwN/VtvO3N+qkbXSRRfwUhkCNKz5exPmGGVMclxpMN6FA//pQQl51iIDSd?=
 =?us-ascii?Q?vv1Fc3JS7eGvfgsYfcdi5xmzhCX9JOBpMQFH/+4tGcAx/Rq0XpxViAAxfP7S?=
 =?us-ascii?Q?awfMrOvylp6luxaLIT6c3rswZZJk0wzwJtgNx1eFsa5QHM6F0H7HbC0eab9F?=
 =?us-ascii?Q?1yv4lUVd01+DR4t7reobPLpVZ1H2YJFPPznrb37EO+nVuh30O3SoqDSuhJRw?=
 =?us-ascii?Q?odDon8l7YyGiV8f6zYLpMMTCCLDTzDdFJcdk+eXIKe7noO73cucRq7dD8ytX?=
 =?us-ascii?Q?zS1rmfbz2zu0/UlSNsoZgBAayGGuzqnbtK70fsIGdxlYvk4FfvD4k4WvTMGt?=
 =?us-ascii?Q?v6xcesuJTSp7/nce/Falt+NrYoDXCju+K5i8vgfZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcfba72-81f7-4ee7-6b96-08dd4ac82fea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 18:16:21.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfOUCywDjeX7oN9/uOdbhqW5UUhXw94cqdILdoaEIQjRMK17c1WT0XDG0OOUTw9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195

On Sat, Feb 08, 2025 at 01:02:39AM -0800, Nicolin Chen wrote:

> +static struct iommufd_attach_handle *
> +iommu_group_get_iommufd_handle(struct iommu_group *group)
> +{
> +	struct iommu_attach_handle *handle;
> +
> +	handle = iommu_attach_handle_get(group, IOMMU_NO_PASID, 0);
> +	if (IS_ERR(handle))
> +		return NULL;
> +	return to_iommufd_handle(handle);
> +}
> +
> +/*
> + * Called by the irq code if the platform translates the MSI address through the
> + * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
> + * allocate a fd global iova for the physical page that is the same on all
> + * domains and devices.
> + */
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		   phys_addr_t msi_addr)
> +{
> +	struct device *dev = msi_desc_to_dev(desc);
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_attach_handle *handle;
> +	struct iommufd_sw_msi_map *msi_map;
> +	struct iommufd_ctx *ictx;
> +	unsigned long iova;
> +	int rc;
> +
> +	handle = iommu_group_get_iommufd_handle(dev->iommu_group);
> +	if (!handle)
> +		return 0;

I think you should open code this and leave the other function
alone. The locking rules are different here.

iommufd_device_get_attach_handle() should be locked under the
igroup->lock

While in this context we are locked under the iommu core group mutex.

A comment will help

/*
 * It is safe to call iommu_attach_handle_get() here because the iommu
 * core code invokes this under the group mutex which also prevents any
 * change of the attach handle for the duration of this function.
 */
 iommu_group_mutex_assert(dev);

Jason

