Return-Path: <linux-kselftest+bounces-20010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4369A2B1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAB71F2116D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4171DF97B;
	Thu, 17 Oct 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LfR4PrUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA815B12F;
	Thu, 17 Oct 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186746; cv=fail; b=RylxF4sMMShCsLZgk98lTtFJNmAbx0L08ri1U9JO7iVkK5GQwQtKY0QqCK7HJZibKrlSwdeWohjjrkRIIXPXyao4JvSz+u+Ht9VM5oqs5HLJ+97LhDBUaaWRhJont6Juf9UM5KCzPLLLznj+BuGHpzA6Bk+OFhxQld9ZUKPxmrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186746; c=relaxed/simple;
	bh=NACh4vvGDFqWGQnyOzBvilNcxqnL2EPxGVZplcWvQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oi7aEjes0W0Oad/6wAeVmBzGuhglq5MyROHHOT9TU89+85EuEYUc7PeDG254OF1+M/ultj7rsv0EAkH8i3I7oguQXtO+fdqFmSLxYbu60Lf6rpBd3xdPu4cXAJH5XBYex+CumRRSeBjjbKMSA2TRWJQLIWWQjBstz5JK8Sg5SHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LfR4PrUO; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWBHvPwW+K531lnLWgXfG5jEEgWEhWysEoNqk0RidZffPiaPIZz+/5zIfpzRiuhLE/yUniMsaOf80g6R28oPkyu8PoNo6L8HTWWGSdleeB5auzcqBdiB58Ytlv3cm7VpYBScHyq9TSOGfptZctEAkEwO2jcIH++Luetvjv8knLHul8eA9GQqq7jWkeqU9RXy7rbTCKS8R4++MGVDVLoQ7jgs9u1NoR7f7PU3ezmB5kwRVEBn46YRPHC9T1UhEV/+euy2LG4WzLOPpegC2THV8a4JO5WNznJFCnf84yzbrdjfrxjfNqtKHIErlpALXLRCYUfB5qC02apINalloczl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VzzuDquUC9n2+LWszjNthEYICWY9bZ4BzppP6eOTcY=;
 b=C0G4YnRyd/MNWwSs3BEnAwSfMHXhlbqJ3F1A1o2YihWHVIpp8kYrjTM1C+5p1egJQmGtoGeq8p57N4SlEqpFtysYDOSgeQnp0wXKjDMZ0Fb+dLCwO46xvYjlfKVcHrs7jMJtyB4DNBFb8oE8WGTDW1AMiTqxPb3zLbcFn8tcsktKdOe4BwyQ/q6E8uo2yVdxmQZrEvikwpR/W8Y4qnUSGbCFTqz5yK8zVY/NRelMGmug5irc+CaAH1jV5PvmVVL5i5HubigbFEeCoRfC1UZuL28C2+uoAU6aQwFQqE1p0XjZRPue/EsnUBP//Kn4UdhRk2+Jm1M2WyFnc4RJ3jCFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VzzuDquUC9n2+LWszjNthEYICWY9bZ4BzppP6eOTcY=;
 b=LfR4PrUO8UAPdsluuOrIIIesL1SWwLgebbIjzHTZ92iKSnLMYl3LU5jsHV8sxIPpAaGDGf2dV3HzrDDtOE5cUTk9ztnpOYMNQolwLQRFCsfOSViydn5VqRD8NwtBJvaniQcFwIFGuGp5/rvsXNYUCrutstIRqRNyPZDmY/qIqLZNdxQKezPoJ1H5RD9cyOzOHXobwUAlMIuhTZPumz1vvxWFUWMRI2gG/GO5QYWCe5Tp9DeZbnAPYVwIXj6A1qWCO4sruy38PA5UPZ9hY0WbUaZvd/4ZjlJ0bLU+0FT9SGvcV3Blc/0qoonXY4Dzbg6WBeG4pc1t1UBOGg5HyCuwtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 17:38:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:38:56 +0000
Date: Thu, 17 Oct 2024 14:38:55 -0300
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
Subject: Re: [PATCH v3 05/11] iommu: Pass in a viommu pointer to
 domain_alloc_user op
Message-ID: <20241017173855.GO3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <781b5bddb195bffa2ba80e5a04cb10336db74c03.1728491453.git.nicolinc@nvidia.com>
 <20241017165151.GH3559746@nvidia.com>
 <ZxFHmyxflzO2cyB6@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxFHmyxflzO2cyB6@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:208:329::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: b21aa816-7b42-4fd6-7bc9-08dceed2939d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNxD4E27xyejgmN0aaPS8L1v24rRGNtjrSh+KLHOXVrdtp44exo0cC1zJMDH?=
 =?us-ascii?Q?zKjiInDHEjWgCxo69v+oSdNdqYziBJF9026bB5F9Vq1dwDF/z2aCbZl1m7Pj?=
 =?us-ascii?Q?X9q1EJS4eVVrdPXOmPVf45HK1IHniBLjfwd5i/AWnnH920uGOPj8FWrSh+rB?=
 =?us-ascii?Q?2QLOjpWEB+bZ4nGXkbQf4oKDuTLRHKPPTe/5AUO4PONyRaxNItPPXw3xNYAw?=
 =?us-ascii?Q?74qm7UPJyEB1vJFIdBCiX9QcgFGAoceDrs5kQxRMRC2vHNZOjPxXYc9P+aod?=
 =?us-ascii?Q?bS7QffYhxF72Xu63Mcakya7ctMdi77lG5jywIA6DfWUtGLwD/E7x5/ZtkEmf?=
 =?us-ascii?Q?hRk2pp47sadIpM6aEDIoygJd2QIdYfpkBqr+yOQW6vspks/0PmdWw+0kdNcM?=
 =?us-ascii?Q?Ja7VanDgyk3moggMFyNOFWiCf1/4NVcM9cr4PpmpGlNkTnKRm478pDUNHvk+?=
 =?us-ascii?Q?C7sJYQMRjg1sh8KUUzQdUGl1FcVTEwqQxzIqWabXsmMRHla6NFQZ3TABXvRW?=
 =?us-ascii?Q?XT4CspRV6Tc+ea3i8g+ssQoG83T0jT4I3cMW4JoJ7dDGiEvWf/QqdA9r15tN?=
 =?us-ascii?Q?hY/mdvzS0V3NI9itxNiiUIfCWT7/b6lIg1s8czJbj2fAKLMpyionSn/VglrO?=
 =?us-ascii?Q?Y38abnHwQOiTK+K9DJnFpHE+neHHmIfFNIpb/mFP+q7Ipu1/yVaY7EjLmh0o?=
 =?us-ascii?Q?MbXlMDGmDkx8PxZGWx3utTUbkwU6RUEXXSspobICp5dLoDLpx4GeyMW+qhfJ?=
 =?us-ascii?Q?YJztf+S03DI51EgWJ0z71vhCMmUiV8ELI2jpoBWnwFBUXfy6oTzfqS5ecEHm?=
 =?us-ascii?Q?yReBWaHiB5yegxNP8bzYpq8S3Jc+SjTP3LSq7RpuPeDx2u3YtzFHL6wpzjfd?=
 =?us-ascii?Q?YxyMTdSCuAUGzC1BmU4OLmNjwFei1Getk+uioy4VA6ON5HP8jNOqqrr7GseK?=
 =?us-ascii?Q?T+5n2vFjPvwYwtxLflWpLjgj9mjehY5z6tavq20izn5L9aTOTzH2k2NRrBzL?=
 =?us-ascii?Q?x6y1zC1X2owGhIca9GJ/rUCp72VNhKbcWhvh65fGad6NXF21Tn0UTFCDb+Y5?=
 =?us-ascii?Q?wwjmSNylntraOK/7ujMw9RM33+BCPcN2qc9UQhNpJxoP7UW3R0QZSuOtHsdZ?=
 =?us-ascii?Q?sB2mwGqskhgc/Ms6cupZTs6lLNPi1w2ZNOrK7UJTQX3NBM9PD0ZRc7dfcoQ8?=
 =?us-ascii?Q?amUjZCPH+58xwTWCYzlHgs9L26ySUPAYpdro9zkmCPU9nH5/cuKCjIOWaGOr?=
 =?us-ascii?Q?rnnlW/85J0Aa/xJTE3Tt2vEb8JFMJIiHHm3xP0ElendVOEDHQCIBBy5bBly1?=
 =?us-ascii?Q?kYR3zLE2aJ2DjuNpsvE5qlon?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dbMGMtABWdj1BGAawm76bR/BagnosIbKpVeQVWDiZLj+5rMhTPoWLoitaqpb?=
 =?us-ascii?Q?J+dlqCcc7sWnECKzTen3+3lrk732wfHsRcOx+UPWOfR279vw4VPbE4KB7MKr?=
 =?us-ascii?Q?NKKF2xd2ZNhHo98IkU5Em64yl/xEgG5ow9XznJktbgRi+0RYZWjXbQ4W6Koy?=
 =?us-ascii?Q?E5mu84Zr5WhRpfAW9QsBeLiam7XtHXsLo62XnhEE1SLzutA2NHYaJuhzkNL/?=
 =?us-ascii?Q?f+g9nuDWmn6mPrelo2+Zet1z6pF/8H6J0x31mQr4SlpbhYEzeopxePC27hCu?=
 =?us-ascii?Q?vOXaDU0VK8KMyn/8EadOSsWWnUU0YUiPdgrWhNDDapQ4vdQeKaaLg5b9vf8k?=
 =?us-ascii?Q?C14/ngUz+sF6/d5oY4QP+MyxOchj6D4C78DyDucQDp0O7Uyonu+qUsEeRSq4?=
 =?us-ascii?Q?UQTn75ghECD6/l10Jm9QozfRddljmivNttvk+PUmo+f6wI91hqxWtZ1m69Ds?=
 =?us-ascii?Q?wwhfx+FVDmoiljcHk/VJ4k3xZNafSfBEKJ0c2jaNkq+jOnfBEVpF2bqk0P8l?=
 =?us-ascii?Q?5DIf1gNlp+Jp60k2PmshKZTT514hZcqvjBU2D4kuDDbZiAu1NF+DUhdc6g3T?=
 =?us-ascii?Q?ra+TMvsedDVguUrCElX1zspFiPnWaesIItZy6ciw3olSbQO2VbF/lwSPgueP?=
 =?us-ascii?Q?2yDxaSawrC5e6NsmcbGLDDyDgINjIGfLOzSl6Ix6W3KVdlxlJKxRb6dAaGhy?=
 =?us-ascii?Q?shnuSa6RXRhr8P71k8RRy5mS6TX+zpwlO89c5f6WlabIU9QAB51KazGg6iNF?=
 =?us-ascii?Q?6BDx6nCnbBLx208dBK0DMYrkZ6E/THMg9blvmeCZgZ/KLuvGO2dku1h3KDJI?=
 =?us-ascii?Q?BFD/WpiXD/80AZR0beMSIN6QtcCZtL8lrvd/bMJ5u5tByYKwwcq4hHDasFVl?=
 =?us-ascii?Q?DUhB5yiLJd7cGp6gEpB9Po/waa+Olz5e0VKEgg+rTwjdC1FsGAi9+PPDJR3k?=
 =?us-ascii?Q?TrIeON5XIqhgzQjqO+6tlWV+A6aNMfjhhkRMkKVZGc5r1dDZb7ECUM7A4ML0?=
 =?us-ascii?Q?aZNJllI/+Q5VhU76OliSDg51mYi5xcmm6zmsK7HJ0O26F7yj4loDg68fAmih?=
 =?us-ascii?Q?6LVF/jHZ0P4MKBY0ornHqIxznJpuLeES55/Rfxp04meqASXzgYZv3QRuyPRg?=
 =?us-ascii?Q?qwFVwvPbxTSiEINrpTR1G2pUCfuxKqFkOkC/u7d2FPcyoet2fxn+JqcUeBff?=
 =?us-ascii?Q?CCaFz0c6AqTTJUl86QYB0MaWuD0GH9VLdb2a5VwKH1I76wG+rx/0cDLJ+eAv?=
 =?us-ascii?Q?RvL8JLPfkSLMPWA8d0MYdB5vFUyDZZQOaZjWlXzRwTbYDHxaIiSXtqRPrd+u?=
 =?us-ascii?Q?DWiFxHApXNQ94pACupfzVsecJuGdnLJ1JR+vnWudm5gTKTqSh9KUu52MaHIA?=
 =?us-ascii?Q?GZDVfQ7PQULj4Qo+YIs2RF2YaVv2/9hXneIChjxSYZXLfvalsb0fmA9tGQHP?=
 =?us-ascii?Q?/vNh05SYTVYwa08uN11qqldyedmwmHeiN37de7RW3GwVNp7DAR06rnW7ZkxL?=
 =?us-ascii?Q?mPAXX28X/V+pSI33yCF9KlYYIO9TLSvRIDh2F1jJ2vc2Df2R/0+vPYbSx4PF?=
 =?us-ascii?Q?weo8THt80zpjMUyvVEs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21aa816-7b42-4fd6-7bc9-08dceed2939d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:38:56.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PZpWgssHoA1dMoL5SI6gTAn0ixK0lOLqV+WvQXhiR70Ju+EMzYa1ABc8wMCwIzz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540

On Thu, Oct 17, 2024 at 10:21:31AM -0700, Nicolin Chen wrote:
> On Thu, Oct 17, 2024 at 01:51:51PM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 09, 2024 at 09:38:05AM -0700, Nicolin Chen wrote:
> > > With a viommu object wrapping a potentially shareable S2 domain, a nested
> > > domain should be allocated by associating to a viommu instead.
> > > 
> > > For drivers without a viommu support, keep the parent domain input, which
> > > should be just viommu->hwpt->common.domain otherwise.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  include/linux/iommu.h                       | 1 +
> > >  drivers/iommu/amd/iommu.c                   | 1 +
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
> > >  drivers/iommu/intel/iommu.c                 | 1 +
> > >  drivers/iommu/iommufd/hw_pagetable.c        | 5 +++--
> > >  drivers/iommu/iommufd/selftest.c            | 1 +
> > >  6 files changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index 3a50f57b0861..9105478bdbcd 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -573,6 +573,7 @@ struct iommu_ops {
> > >  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> > >  	struct iommu_domain *(*domain_alloc_user)(
> > >  		struct device *dev, u32 flags, struct iommu_domain *parent,
> > > +		struct iommufd_viommu *viommu,
> > >  		const struct iommu_user_data *user_data);
> > 
> > This re-enforces my feeling we should have made a
> > domain_alloc_nested()..
> 
> That could make these changes slightly cleaner. Maybe adding a
> small series prior to your initial nesting, and get it merged
> quickly?

Maybe we should put an op on the viommu_ops to allocate a nested
domain?

It make some sense and resolves my worries about checking for
driver ownership.

Jason

