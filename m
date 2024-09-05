Return-Path: <linux-kselftest+bounces-17319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3113C96E1CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A542A1F269C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079C17C99B;
	Thu,  5 Sep 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lmBFd1A9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA414F125;
	Thu,  5 Sep 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560514; cv=fail; b=dD1Lmdqw5ZFI60PQQxYh1k9ZluLIhtVI+dQ2CntYdAhzB/ortAsUveZaM57RKwvEeld6GxdBjxd0fCz4BqXWoYSl9oNrr4ZDjSO5Lh6NjXsmrJfr2X19cQJLCxuCZJUcgfjwH+qsgDw7DzmeBZcC/stliFeYvyeHLvUcfoI38kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560514; c=relaxed/simple;
	bh=8NvKWW2W7ysiKTQ/9/YaF5HQSHJmA4dimR7OCWnwkx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZsslRzNj/ZeuZ2OouwsFWrHd/sXQ1dkFNOEme/YHMeKJd1McZWJia4gg/hTAedoXc647sGDXInk67dAqpS9xhaXVQGME3FXhANgeIwE0cXHD4mt4FVntu0pVXn4wadsZIrg+9OyUahPfmjRyFgK4b6A3vVYPU3sOYrguNd+n1lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lmBFd1A9; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNiXfb2JLBskYaZ5DuUASXaUgTHd6gEsLgJ0bG9ANC7xFXUDg7knLcQSoeMuLus2uiHKJ6s4atTXYFF1GFpX1P1Z9nTm5D5OC85KV5F5SVSWFQLoy6rx/HeLDBUF6U4q12r9VQOCW3DLlgryi47esGXWKxgR+1nXV+JWm9VQpQKxd2B7hex4T5qPlXPATuzvLjnjm6u909MZj5h33kVUY0VlHTfeDLDAgOuTDIsZYLKMLowpjonJHT+8CA4rCteiwX+tyhLNc2sp2npT1xfNFJSOT1bEElQyKIXdK7nH8BgJBqtjn6hd7zza79lNCzyiwy+WFt7bDR1rivMN2GPA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkbH/xW/9/ExEv0/zVk5vyP6gViaMeMxI4OE++laKv4=;
 b=pjEdukV/iHU8FeL4AwESxydUP1vKcxa2//NKqYGiRtglSdA5jAwr9rPOCvwReyqurgl6JgH/vrQ4lLkOm46GKb6Nm/YusNskuyJST6P4o5nqujBaU/i3tulOt8+qfFwcFAfyA5/NWIqNVt+9yIHJHUjLiVCE1PqjTqR/INZQDRVdHAsTGevSket+5O/Jp9Juba9qqFdgJOvkq13OydqGuX/XgJLc/q61MQpwSzylsc4OyP00/Jk/LDGE76yjlyqfygENGK5jk0lge2QphYfsWnQ+Bl2mMab5P4rsgm+dawOecbWVVvR3sJAh3xBq0Mc6lClbvQQ9ULxrZTvn22i/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkbH/xW/9/ExEv0/zVk5vyP6gViaMeMxI4OE++laKv4=;
 b=lmBFd1A9TiV+y+NBMetElv0lbg8Ckw+sAr4F94dspjK8V6q4Gc39pfYtAe+73/MGzv7mODJL04edKgzGC8SLFDyiK603D2GoHkLXkFwOyJoqJglPyPCsgQcFt8hU0opu/KpRcXH7SXyLheH68/hg/OMfAo8fFy9lfN4IYxQnvzKigE0kwqwKhZB1iK//uvRCtskf+RUEElt1BJbKz7hz3Uj18h5ziK93urgC+sToA1tfB4zD/tHJL50ZO05HTDB/ErsMGzr0UAcYNmxuFXpvksSEKVGBzyVjr29vl54kKpcqYXl8hKJT7jxfcjhHThpHWdzgyv/yRZcH2oKv0ZNhSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 18:21:50 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 18:21:49 +0000
Date: Thu, 5 Sep 2024 15:21:48 -0300
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
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <20240905182148.GA1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
 <Ztnx0c4BpGt6umrM@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztnx0c4BpGt6umrM@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5122fddb-8ce9-4bac-0776-08dccdd79bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Owcqf48mcWXj+YsgbHgCvl359+sSYMaxdEJpbtIRAjEmJbmXEllJzDOI5uYh?=
 =?us-ascii?Q?nfOqo8CqU+xWhCopgip5IsmChrbuDrGoOEd0m/nuN1/DwE5VVDJ2nA4Ia9sz?=
 =?us-ascii?Q?WkBVGZm1UpAEarO12HL10/h1uBy3YxauUkrFDDBVn6NjJjFk+M3bhOUFSsIq?=
 =?us-ascii?Q?ZDy6mF89cMuAsUvwNjUINJStVgwzxh3j4RhA5PHe4MEuxMbQqRwuUrTrXjej?=
 =?us-ascii?Q?yK4UVGe7IUoWzNJlUqUYFSRPlfp0AB2s0x/u0atGuQiHBasLhqeIjxQ2qhQZ?=
 =?us-ascii?Q?Y6JNwhk2nsGJHdHlIIkkoZcP59oXtwLKX9cO0jwfHyDaeQXXB+mTtBI2Wx1j?=
 =?us-ascii?Q?Q3I1/+CgkjF79UrfYrcIioGZVDMPYkdQfiP9MyS9DhEt2zBk3jYN0Yem1zQ0?=
 =?us-ascii?Q?hyctboBZm8ifjKT0FcdHpZnQKxcLjqE7TjYqHfDQFsX1CfXyGi066PQJ+R4L?=
 =?us-ascii?Q?ek/ex8lAvgavRokzWn+Apdgj/2XMaM7kANI+M9KLzSuaf197CvsC6zEvWBBI?=
 =?us-ascii?Q?hbsLvDwJ1NY1LA1RnPXjLDqJXoMhhiWqLaiEg6LjOF2Dcfg1FdnqnbaDc12v?=
 =?us-ascii?Q?/pim3+AFjGRUwcgxhXVw+Lp0z3xFbpAhS8uF/QfTf6kjtPDMkV7diIHYP0Yp?=
 =?us-ascii?Q?4HgDUu9r4tVgN2pG7Dlbkf9B48oYb7OGjkoYIUryUNUtye3M6Xcjfjxnjl8O?=
 =?us-ascii?Q?+SLFTdMG8qEOSPrAJUNP6oTiY2j53HlpIqZwJwvL76nE2gq+U5C4ds2Nh+wR?=
 =?us-ascii?Q?8s4D7n4SnksOOndk8Cg2Wt9Uc3a1L3m6l8VX52K7xwVrXw9TYqud2n6SsqAI?=
 =?us-ascii?Q?Nyr6zCzZ9tP15TWinZKXrTsRzdLr6kO1aabj5FriS4+opvQWI4MXW79mNklx?=
 =?us-ascii?Q?dPl8BZdHnt6+wGzjVcNUfh7uhApCGDFauy5utbC5z6HtevXPTlvNSUyZwaHP?=
 =?us-ascii?Q?GLk6UZ9R2hj9G9aD4MNDBtgYp842hHZQF1ujjBno7t/Qb3mYIDv/6Kmg863/?=
 =?us-ascii?Q?nojaI2pVWmdZWq9PDBXfCunAbX/9IB7itiMFqXi2Uy+2i7Q5fBNs+g3roLxS?=
 =?us-ascii?Q?YYgYJ3LRlHJvxMuIPMLUTWTLGexLFes0AKFQX+htoJCDJvpqU8bC+IqNfOxs?=
 =?us-ascii?Q?qkNrMYpS9EeLVCX/QZJNNrdO3Icpba/cPtYtxoOWnI/C1GS6UCTV0DS6lvdd?=
 =?us-ascii?Q?7/I0hq/aPCWCPJKAyhU55bQa7UzUVtqOuDZP+WnyZNytwweypf1QhehYjesU?=
 =?us-ascii?Q?YdBOcYflZvHm5VpRD+8GhSd5CcN0qXERJlFGRsUA/5W+q4GfirVGjvyw8FUy?=
 =?us-ascii?Q?4G7I77zk03TP6sBr0jJm49DPpEWeWbSx8S0WKG4Dta4L4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4lSrKytwL70UzYvgFvW/yky+Z2uH9U8dUNRRmt+vZRuxYNKQJGaVZ1TXgLP?=
 =?us-ascii?Q?Lxh9V2s6UnRjzEThsxBIC0BIMCvczsFQp7b+nxMtcHEGHj5UsiPXtlaZKg5j?=
 =?us-ascii?Q?5S+4LvP0TUrkvW6UUNzG8dJQX/t7BJsRwjl2Gw18aP3Zt7Len20pwjxi8DlP?=
 =?us-ascii?Q?yV8Hx4YJbfmS7kiI/GEXimZcc8SMR+7OULb/wt+F54vAtK0yXgmJ4DOJdTdh?=
 =?us-ascii?Q?ir3gNuzds/rliSD9QIqx7zoY9V9RczjSWnjbKGyvnEjzBPA8mD1ibLR8Z96V?=
 =?us-ascii?Q?N5i0XsHPyhlpZVUbH50IaaarYJfQwAo5EP7iB35J4begAeTpzVdaVT0AwvLS?=
 =?us-ascii?Q?6uVKcJO4hWT4Wr8UE/cIXb0HhBgGJsQaTkHQkvOhwLOMoK04s+EhFxe1Ewgc?=
 =?us-ascii?Q?34rJR3n3rMjWuV92bYfMd1TYlbaR/AZrarN7JSLdWlWV8Nv6C54xdNEmdvc3?=
 =?us-ascii?Q?1TzmKKB5+8U94jLJ1qfBbNykiwobELJM2FLrXxhs26l2H0vRIQWnKEGbTh2z?=
 =?us-ascii?Q?qEE+4UdEH4SvQCgTVf9ORO+3Fj5RqixKgU2lPrdhPPEej4S1+ZIjOHBAdw3Z?=
 =?us-ascii?Q?q8rNGGn6aupmqLMNNSfIRcANZIBAblbvvFyi4A+lga2kYBP2menDOwr4lf9+?=
 =?us-ascii?Q?1+8e8el7ittr5zjTZwnGpj3ljiTEpcnRVIQwJTFkW7bseFXyFni481ZOc1mI?=
 =?us-ascii?Q?xxgB0H257VfNQM1f4JHiuFIRBSd3nBmx0R62FqKNMBeFNgRLQ5i6+FQ8dsRt?=
 =?us-ascii?Q?qvI1v6OTqX6TTq1B8C+/3JJyETBXEbTjIw3udYxqkw5ybJsTX0Pf2CqcmFZn?=
 =?us-ascii?Q?XgtXJA/Uu5W843Yaz7BXOKPCFR/dY/alZgHjhp4ANw2CvgrS5a6KPpoNhqQM?=
 =?us-ascii?Q?pHNKis95et2PprGOEUlDxij8qgvlC5y5WxqEL7Vo6v6x7kKxpk2ebkNFVv24?=
 =?us-ascii?Q?rtHG5BdxElMoU82gyQGkL+FDqT1zVL48W5KO8HIFtMsDkLnLd9EDaVuab13J?=
 =?us-ascii?Q?TuA/8R6xXIQmmF6V0LZ/444Y3kjD5PPcV+gakdqOHkBl0JbIFrmqnRb/IEJB?=
 =?us-ascii?Q?tJNW/AXqmE3istjF/bioCoM4t3JRd/d/9CdjcYrb70ECOtE/LJnVzwOEk7vt?=
 =?us-ascii?Q?/Ig5VNska6zsrf9S5MrVE9PI/SR5LgAifwfr/tizDxEUrEU1j30HYqOTvXeW?=
 =?us-ascii?Q?dRBXETpco2IM0bXL59iOHymOyv8g7RJJst6IgJLcoRVVpzUK1eO1PaKUuLLD?=
 =?us-ascii?Q?Th0OdYpKXTPuPX7/yKzaH0/YDe7fv0EYwIjT865636EvFXYKp+mPzE0p/NGT?=
 =?us-ascii?Q?GcLKO9tLNvANxNiAKepIsmY1p/DVl1pwA2LirZryBa6bKUsxuk2ADehhRXGe?=
 =?us-ascii?Q?cIE9CFvd3L6gVom9xNti+ubnIqhInroaCXWUpAkkM4wehxBOxo27XacnZi1g?=
 =?us-ascii?Q?i5kuDEqQuFwTqBGaVJ0rxjDuBfj2M4uBwPiB7QuGfNxKVX4Oq1BrVus0c1hR?=
 =?us-ascii?Q?lrEqlR+W99xcBaCVIQL9Z2nTgY/8xLb+Ho7Zs2d5nhw2UR4YeUcCJbduoAc4?=
 =?us-ascii?Q?2HaUbTMop+8O85/apTfdLdtGEi5Ombksbj1Jtp6M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5122fddb-8ce9-4bac-0776-08dccdd79bd5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:21:49.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 408RZ7i1pMC+HYlEL66AvCCJ10+lRQzS4OSz42SLnKWx4OzaQD/iViu2UaT3dIiw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233

On Thu, Sep 05, 2024 at 11:00:49AM -0700, Nicolin Chen wrote:
> On Thu, Sep 05, 2024 at 01:20:39PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:
> > 
> > > +static int arm_smmu_viommu_cache_invalidate(struct iommufd_viommu *viommu,
> > > +					    struct iommu_user_data_array *array)
> > > +{
> > > +	struct iommu_domain *domain = iommufd_viommu_to_parent_domain(viommu);
> > > +
> > > +	return __arm_smmu_cache_invalidate_user(
> > > +			to_smmu_domain(domain), viommu, array);
> > 
> > I'd like to have the viommu struct directly hold the VMID. The nested
> > parent should be sharable between multiple viommus, it doesn't make
> > any sense that it would hold the vmid.
> > 
> > This is struggling because it is trying too hard to not have the
> > driver allocate the viommu, and I think we should just go ahead and do
> > that. Store the vmid, today copied from the nesting parent in the vmid
> > private struct. No need for iommufd_viommu_to_parent_domain(), just
> > rework the APIs to pass the vmid down not a domain.
> 
> OK. When I designed all this stuff, we still haven't made mind
> about sharing the s2 domain, i.e. moving the VMID, which might
> need a couple of more patches to achieve.

Yes, many more patches, and don't try to do it now.. But we can copy
the vmid from the s2 and place it in the viommu struct during
allocation time.

Jason

