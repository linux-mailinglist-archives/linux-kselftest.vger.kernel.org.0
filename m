Return-Path: <linux-kselftest+bounces-17718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98BB974B21
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9211C247B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5262B136341;
	Wed, 11 Sep 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FUro9zom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E57E583;
	Wed, 11 Sep 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039269; cv=fail; b=i3Jv21yg6eiHRoNoS0S/jgDE++42k1H6ld5SlYPJfNojj6ZMe3qOeNhFcP80uXwTAdab1LjJUrgy4jzNrkp6gVdhznzHmODDsbsSOsrZmtYhG6rWVvqmfxuf2UZYnIoc4PBbmgHCMCa/Spj8fKoPD0781+CxHNdSqq2q3tfgrOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039269; c=relaxed/simple;
	bh=Dnhz2lrB+iTGparpKDT9+ETfQOhApB0Jj2WRzVZcLwE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9+kZR1HpWghHXOz5D2CJSARf8nTMk7PGvvMpJoBPTmzn+n/7cGp1jw9gZhmwkEornTYAuis9OhNScl/ZnzBvvtiOlxZHZgAoQn4cwM8ZDUSZS3nnGOZpb89jKggo/bW74xCrjpj0SlqDMtvkzBTYkZWY+Vio/nhryMiG3ZVH6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FUro9zom; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEZMc1TzGvUldBwRvUqzJ73xSjMxNvrilcmbnVrsj+1nnjcwWd9VAXZkuaVhiXZn2K5ds/RTKWqruLFD4AQaxAEFAFlfTHTCWIGkCTwheik2F6HwgbKJl0mbkZqU/UEDXsFVsW9biN69PhXZg395vjxknOokdibfz/7GCbNm1p03ZeNaBv6EllMExETs1xb2ANuv1zA9kSHzNHtdoQOcLFuKdghln2sI+r5YDaZYyuAtZO54LdvkwiTsu6oHDwaQ7NWJ5SvQnuLGBr4fqk2Kuw9GD4A9W4dkQyfyeBY49PByafVzU26csIUXf9RgJFNJ7cyzzfQp2WZbCNT/ItMynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCGmhnZIPVpUEwnOIig9aNS9l9XjrvXzSlMh7qcGAUE=;
 b=N/0piJzbuSmbZJF6yk0LHPViul4Xfx5CF+CM/fWYZsrDxSULj6CC6GowiZ062f8yQuPJ5WWdtvCpCXLZK1Xim0RUxQ4jD6zS1dgz5Y3ymjbVuWK+ya7R3YVP4Jnb4uGXp1222gdeNURLJiJHsf11JR7rOloAsid/uY1e19mkJLCLg+UwLkyrRL4uVX6HMRW5wzeh8SoueeqCpz9hv7ihGnVMlsMG6ZGG5pub0hr6b9+fKehgf1dHbdTjJHYRe3/FCdCHxLeg/LHd8np48puoUMJ0yB121DVGed7YVMS0rrinp9JOC/xQVikKAVapyaUTrawTFLrs7GiV++MoMwiXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCGmhnZIPVpUEwnOIig9aNS9l9XjrvXzSlMh7qcGAUE=;
 b=FUro9zomdFdY4NYRXg62GBn5AtZwzehiHd8Amu0z+QE4NQ2xt25ktUjQZTYBLCz1qsRL2G6TYmd8mk0OlJVZIzhLQGTCDz3tzc0O1GdZHy1ftXwQsjCCa/ohQbhwwh5slMUzi9ZZFPumXFc9SAvBDbLD8A8RYS64H1MQjrSiraITJHCxt9sPjY2JhmIHwl0ze+gN4moluY++oWw7Q7FMXoAzScp2aa60m6SMMrMukwPXvuwT6tGQc4XAMZvZjcZpbaG/Fc+MMzi2iINdwo/x3cLlClrZanvdE0gIj32pMsiPxLgAeatGn6CMWFs2tD9u8hRVSPn/M+G3kBzvBBpcfw==
Received: from BYAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:c0::16)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 07:21:01 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::fd) by BYAPR05CA0003.outlook.office365.com
 (2603:10b6:a03:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 07:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:21:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:20:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:20:46 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 00:20:42 -0700
Date: Wed, 11 Sep 2024 00:20:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <ZuFEx7mp3v0/lY/g@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
 <Ztnx0c4BpGt6umrM@nvidia.com>
 <20240905182148.GA1358970@nvidia.com>
 <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52712F4AAF7D1388A080A49E8C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b299f7-3f38-458c-1947-08dcd23249f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gQoAFPMBpSp4/VW0C8ymDPBRjl+wuLccrYg1ueQ8VUYStelNeBF0vXqdvnh7?=
 =?us-ascii?Q?e4ies2ES57cLt+zJ34nwq9gchCZWqhgENtDRELwCMbL7exGW/qMlaZ147N9i?=
 =?us-ascii?Q?1hErXdsQLemEesXwG/bTQwPwV/axCbFB1RoDcYo+iYukqm2Ppq6nmFjp4tah?=
 =?us-ascii?Q?dKvvMlOd/HehjaG6EnQIUTzgexzecAUXzbjHcxSYT1/lwj0IDDu3ITA2cGKR?=
 =?us-ascii?Q?SWNVC5ruiniJzHU97SsETX/RpQ/bpZhG3UxZjM669+6Ctgv2YwqDkN80BuhX?=
 =?us-ascii?Q?2rTN8cfJK33MXDIX9lqMC3FsAMTe/8alGp8jHoS1rFd7KNLyGgSBgCeMAACT?=
 =?us-ascii?Q?obscKhL+CxNHdN9gi6XaZkrv9JXCQqSL9R0tEWdX+eUynanWe/qRMEKlB79a?=
 =?us-ascii?Q?hrm08Zt0wrFuJX64cyY1IsNdW4/n0wdvx9GqipzvLQ079ORxSAlPK2bwG9d0?=
 =?us-ascii?Q?KxTLcucsRpihF3aNr7/rR8PCyRJxjlFX9vayrd0pvUpHDi2Tcsr9HJE2QG3E?=
 =?us-ascii?Q?KQkXMFl1Iz3zeEsvwKQiyRfGe6hKcvf88H3fF9aOxyqO+Y5icOwS9Y3i1ph4?=
 =?us-ascii?Q?6L1Br3frMjkvy0p798Jhj0EQ9d/0hSIqaY+mF3TckZmTUXbDKaLMY5u4T0TP?=
 =?us-ascii?Q?jYQ5yipwvzYVhTWETtL7SBB4NSAkcilBM3qOyX1KHt8A5u4mMHrcFR6MscBw?=
 =?us-ascii?Q?UfVUzNGCN6hP49qgf70dn19yV3qJ9L0C2JYixiNsp0itpCddKKMGPj1l/3rN?=
 =?us-ascii?Q?uFr6iouvwkpCR/IJnf3yrYo/R4rW3GuRghcJseNjpDRmWeQKmdMXDByDMXg2?=
 =?us-ascii?Q?HFMboOSY3uBt2g3mnTORqVQ+HGdS2bHHp0FseO8bHHgRaD8sTd2A/h+ZeEcj?=
 =?us-ascii?Q?ipcw4Nrf6veSDV83q+0oU0fXjh5SzWKQCOYN29Q2hUwdkmQHy+o8sjG4L4yb?=
 =?us-ascii?Q?KDfCjtHe5vLLjuFI/yAysDqEcdBmuqSeAIyITGm1NHu1Vmy2ppB5PJRFqc9V?=
 =?us-ascii?Q?uHHRpHxP9xIB90z0dq87TLkX56ni7qVj6HR9hejucC4cCeVLHs8pe31PoecQ?=
 =?us-ascii?Q?utQPUy8qZlHegNaHIgu2UGaZQSKfYfNUiHaxJdLJg7TR4aj6pbTONQAGKHAU?=
 =?us-ascii?Q?bTYuGPHZ/+z9+QsACsd5tOu2jBFsDNxrHHxpKE/a2euFA/sZMkp50lEU3nby?=
 =?us-ascii?Q?PDibB2CTIoGT/+H+ZnM5ekqC2BXitJevscShZf6XFe5jo7wdcG+yULzI6xjz?=
 =?us-ascii?Q?ziy81NGmbo/VIQWDdh19PED8BRcXEOdrShvN+XZpbl3dR8741bcCEQEfY5Ld?=
 =?us-ascii?Q?XYabkvAIEG68roy9C2iC5Wh9BYs7chseaUr9svJaB3bJdjfySBqrKwPLyYux?=
 =?us-ascii?Q?whCkQgseV2sah0r17o/YFmzUHXfDqEv+Kc+gQi3UxwzxZ2RYKalP7nlq5rKv?=
 =?us-ascii?Q?6y9xSfa9RWcI1dmuV+a70fE/mxelxRWs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:21:01.0257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b299f7-3f38-458c-1947-08dcd23249f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463

On Wed, Sep 11, 2024 at 06:25:16AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, September 6, 2024 2:22 AM
> >
> > On Thu, Sep 05, 2024 at 11:00:49AM -0700, Nicolin Chen wrote:
> > > On Thu, Sep 05, 2024 at 01:20:39PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:
> > > >
> > > > > +static int arm_smmu_viommu_cache_invalidate(struct
> > iommufd_viommu *viommu,
> > > > > +                                           struct iommu_user_data_array
> > *array)
> > > > > +{
> > > > > +       struct iommu_domain *domain =
> > iommufd_viommu_to_parent_domain(viommu);
> > > > > +
> > > > > +       return __arm_smmu_cache_invalidate_user(
> > > > > +                       to_smmu_domain(domain), viommu, array);
> > > >
> > > > I'd like to have the viommu struct directly hold the VMID. The nested
> > > > parent should be sharable between multiple viommus, it doesn't make
> > > > any sense that it would hold the vmid.
> > > >
> > > > This is struggling because it is trying too hard to not have the
> > > > driver allocate the viommu, and I think we should just go ahead and do
> > > > that. Store the vmid, today copied from the nesting parent in the vmid
> > > > private struct. No need for iommufd_viommu_to_parent_domain(), just
> > > > rework the APIs to pass the vmid down not a domain.
> > >
> > > OK. When I designed all this stuff, we still haven't made mind
> > > about sharing the s2 domain, i.e. moving the VMID, which might
> > > need a couple of more patches to achieve.
> >
> > Yes, many more patches, and don't try to do it now.. But we can copy
> > the vmid from the s2 and place it in the viommu struct during
> > allocation time.
> >
> 
> does it assume that a viommu object cannot span multiple physical
> IOMMUs so there is only one vmid per viommu?

I think so. One the reasons of introducing vIOMMU is to maintain
the shareability across physical IOMMUs at the s2 HWPT_PAGING.

Thanks
Nicolin

