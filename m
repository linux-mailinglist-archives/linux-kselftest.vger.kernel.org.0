Return-Path: <linux-kselftest+bounces-20003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B409A2A7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5A21F21C38
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2A1DF993;
	Thu, 17 Oct 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYa090XS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221031DF962;
	Thu, 17 Oct 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185307; cv=fail; b=jX+DOfMcuFdLtfigwcznpIWoSKelpsH6KQSD5KLZz+TvrLJgf3L0ZkhAD8dUrT5uW9qFuXIRAUvyWIUvh02uYQkmhX0oWYNFkE77b0FoDDIXczrm8Dverb3nVNVwK6Z824vDvaK7NrRhAo7UwkC1MXCiSZmzFDaPE+FspLTEg50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185307; c=relaxed/simple;
	bh=6Rh2m5EuCyrG1OxeDNr4YQugTHXTjJFFULzPCWXnW5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dvUigbWX3sSpvOwTAqDxY44fOmcga6oU/p6bZsf4hVl+rxxf7TBWDTHGxAC1D/0A/iEqPeFRBTSk3qaNEFBb3yfwjuC06MktMsT8LGaEC4jhoboO16T8PsR3UgYjHIX6sG2FVgmuAoYU/JvTykNZV+q4DHSpNZMxvkYEy6MLW2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QYa090XS; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8lAJzHOKk+vQ0xdpfppv97fa3M4hgukYCMskV0gnOxnf5m+Xz5vqrrQRQvh4QjkpZcQ6kMtGKf//2ln8duYc5xbW56oRRwID6vEzxQnly+KSU6ofxVvj/BlQ4zp/ZN/pmCXI5ro0HEB2OzsJFFXtm7R7/D41daP27E/Fe/6MacdZjbag9DkbaHaaDAcs6dTder+9Te6iTD1GlAF4b0wJu7PgnovlGKMn8zHhwL8HmIQFEmX3PTs31gyEad4feQh17c+cAuSua/ZGZ2dmIi8Cimj6AY/1n7dbyAdFT7q0IbTci61Kes30jrkPy7qBEeAvi9nUTsDyD3m9x6RLFsrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXNysco5h43cnkKND1UK8cAO21f6ey0m8gsts554Yvo=;
 b=UAVSV3GFNEmkq4p2lPQdTF78Gl612j7trXBf+kangYdaEvKjZ7iLLHkLrL7sdLvt9t5SVpGtyP9aqlmWNkVfFKKg403KNPCZI2vvA+fY+e87xkrbYr2J0OLb/Azo5zuKBUuGztuYz9NKLIcFTZ2cuzAVlmSuMvDs1NyFCwTlFnu86Imk1Pa5RJNMjkQYyZjUp9Caxm0JMk/FpN8l8SzF86q2F8GyXZCzr1DUrflJowFFlokYOjx5ZlQNFrAUKjpa6DzE1teL8mm5x2qcvyqdONArPv9XFr4BsFd+oBURn2bakZGY5347cgFVKsC8AuVprlFdNZ4xWM4r+piHOpGueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXNysco5h43cnkKND1UK8cAO21f6ey0m8gsts554Yvo=;
 b=QYa090XS1DZx/qCBJRGri//NQECShS0lKakR0ubSUOhUPXC1foDdDN2K21t3co1g5d2DY6fK4AZ+tp0tqMin7ESyRg21WkIOokDC6TxVQ6bq0JSSL+pqmZA5otblGlFy7o+SeAZcwuyK1kcfYXYiEIhn0XHNc8vHKeCjCwRCrVRDkev3QpiKMehKK77+ThL5AS0f63jZNvnTgXv8I928wVgQtrgNXtjkfRTqOkgZJPzbnXVXmllF8RAozYc+fKH52D/wK/H84GYfTQSL7fL3/Fw9Zc9Hp6DIQzJ7mRIU9s/kABCSLAZ59j9qWsqk42sj4SvUG4sn4A8nn0VlOF/9yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 17:15:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 17:15:01 +0000
Date: Thu, 17 Oct 2024 14:15:00 -0300
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
Subject: Re: [PATCH v3 08/11] iommufd/selftest: Add IOMMU_VIOMMU_TYPE_SELFTEST
Message-ID: <20241017171500.GM3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <240dbfe0bec59b39e759d610485ff062054c370f.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240dbfe0bec59b39e759d610485ff062054c370f.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: dab0b523-ed12-41c0-b532-08dceecf3c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?suQxRtCKtoo7gNDaMcFf3eb4+9TZGjtwQ6j0oqVuGJNBpair7mCKufpQfdUo?=
 =?us-ascii?Q?6l5M8ozKTS2w56QcJLmf0h37PpRnKCe344LU1LU5UPMXEmWHGRNGwP/6Mi0L?=
 =?us-ascii?Q?fQsz0ETDDVHMg5UoMTXLk779tAU4FrxfjoYCNtc1z2GqkG4WIu2KWcuqBVMx?=
 =?us-ascii?Q?5BDjFGr0BwOUxYEItczBhkY2Q+QJLH5hT4wCs8yq905AchWRn6nSZf6Bewjo?=
 =?us-ascii?Q?1PvxK2lSeWIPhdsKYNERErZrSuET8bjth/YTWyzwZCpIXf8866O1kEayCuHt?=
 =?us-ascii?Q?w6PtyApd3/9fqio7/w9spiYS/zLL/lEBKFIZ60MCdICH6OdbY87OJV0yBdSB?=
 =?us-ascii?Q?cwbwuYk1Gz8fAE2P/TTsdSTCrm1IUPriFmmlwKZsYCmallAsknzCvxspImsC?=
 =?us-ascii?Q?uo85lyhRj2Q0bZhH1YChhb7T3ha7T3nPBUbpFkoGNh7nYS1dOR5mrdFdt+vp?=
 =?us-ascii?Q?CnQniDJu2JOo76y02mz41ErInxFjIQScGncm+f5IKZFYxfzidR2PPDMq1Jrc?=
 =?us-ascii?Q?pMkrgp1+QjLlQUiBLJgoX0v5/ZeySTYIj2TOAoUIG8i1MeuAAZknhwz5sX9b?=
 =?us-ascii?Q?4s6vYg22lLMwTLSWNagsgEihropYFR3vSU8I/B9KA4gSi7T4U4TZXYvSl3CW?=
 =?us-ascii?Q?GJ/7pm9t7Na902cXTaS2D6Ib/GxyUwQRx8JfConAi9JOTWn5TJY7uiXsbinM?=
 =?us-ascii?Q?DaWRpwwnB5SrDVp4Mwefj+JVH2U4JHIhGz38ldSo0Wq2io4rP9k4UEdxQOxE?=
 =?us-ascii?Q?343HIFnz1A9SmkCC2WMmfxvpzwICdVjV7WjqG/Bo41l/znA9IS51SRlVMrPt?=
 =?us-ascii?Q?LJCnskg72aqImeAT6wPMXoifjWQTT0POOEjBQgEulq6V8LtKzsiXanKPeEdh?=
 =?us-ascii?Q?MVYse71wPsbBwWU8V1KopgHXQn0SoAbicnR6qvrbRMNR8Dn7gExjLPCSZdAT?=
 =?us-ascii?Q?uBoXmTbXqtzKDatxBLz7qPx6r8PVAiFcApPFONEOjkbBO+rIOGIJ4mB1CgMa?=
 =?us-ascii?Q?p3IRkHJVfbDqejY05vFwyjW0XaDHX5I3POqCvR6ZQEmQoDS8jEtK/wEYm0qy?=
 =?us-ascii?Q?XnUh6ru3XapDWtPGAupqaJiBisa9WKIAZHWcPbEuYC9lSUQMkE+DanKNOFM4?=
 =?us-ascii?Q?ODbezvYiRzT+pokbOLfDAVE8dsyHaOeluG+Go6Yjh/Z9hnNn3DltMsMrjjFT?=
 =?us-ascii?Q?Ne2UlLc5zdiAvlKLUcYUh7RvX1iP2ldKJS+xuthZXoecp2sEK98hgkI1RspL?=
 =?us-ascii?Q?qZcqC4wg9cErZiiD2bc8+w17TxNNQZihB4wURGxzSjH4QVIecr3dBk5GJG77?=
 =?us-ascii?Q?qsBNip6/TrQNddvd3RdOMiIl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vhs+97vdQFhDCHmqUiAsrZrYWeq7YzRIUEWB50B1vGH8ShZI35tZKqO0sGSg?=
 =?us-ascii?Q?Vja8JD89AsByLqx/wB2sa6McOCIx3+AExAy33OI4bdkFKY+ivXE1DdzaJzmJ?=
 =?us-ascii?Q?SY0LVRc15GcKgN8ht0FOzYrVwLkssTtZnMT9xpsDebQfBTN+010OzZ60Iu0J?=
 =?us-ascii?Q?JYySJzWUxtkiuCgxMeIDaXnGZdQi40hUiRqgfIMOIEgbLJ7M5BtGhFxmlzG0?=
 =?us-ascii?Q?kN8nq1sVx7SxP8fGDxtkM6mAx7PrJQIXjnVpooXFyzSqx8OGOlXmHcf+l4ZH?=
 =?us-ascii?Q?5MtKu1tnsi04QFjtLqWvTlaBSVFP8TqvP8uUFx56JmZp9uHydhn9U3aQwYra?=
 =?us-ascii?Q?lVIbW42L01FBC2PcPgRJnKEITv9ZPnRdIl4hV+rOQYzdzqDOuJt1NWDAgE5C?=
 =?us-ascii?Q?P3pH/twgUeFonQyWilvRbapyr96CP87NpcfjxSWF+wG0aoHoaXREZKsMBqW0?=
 =?us-ascii?Q?tqDwU5V9ZJTBebTTJW+V6v8fHcCIU9Cxv7eAhrlC22X/22OaHIVi3srRpvjB?=
 =?us-ascii?Q?125R/hd8Fum3+czroltD89Y5zz6aTbQYe0rbRLTRfQVDSPlXAopJyaLQm+nu?=
 =?us-ascii?Q?1g8cD2TNTdu0TSLXmyloww1B5WrrnLWxgrPIU50+MoG1zRaCHVLjhkQN0jWW?=
 =?us-ascii?Q?jKTeSn2EEb7YOffeolqkoCaWXAdMpx++GFjm5MIvnK83oSvaowxi3SmRTBCF?=
 =?us-ascii?Q?3FSDXdJJbnsJ0f+deDbt9QpNM/pB5QZGW3X8EYay9LR5OEJZRO6z8kT6NPsJ?=
 =?us-ascii?Q?PbTFA8y8mSocDM1OfnIo91S0ZxPwP7DMMEFB6vrMpXipsC1RNiiMQTl/WC6e?=
 =?us-ascii?Q?eNljZYPe4qNCrczz8EAHufhvJupyJMo6p1wmTUHOWz6YFZyuJgGw69E4OEe/?=
 =?us-ascii?Q?RNReizZJzPXfAQTC9jQGBLkyzCWzvyQJZWfFdNulKogDIDPmMS8vTZw78iJb?=
 =?us-ascii?Q?z5LooCifsHNiwcKIrxfFGncm1PVcsR0M3fouuvYxvpCLQeh+9cqvtS7leWju?=
 =?us-ascii?Q?Ty1HZnn2iMoRmsrg8Ak5DV8OamqFAfAGsaMojFtK4StW5PFmYzPVB2DlkYHs?=
 =?us-ascii?Q?9RR+K4VlXcKiLk5AZeU97xRdaVv6LmQND/Ex8MCcfgSZhcoirY7vW3IWQOOm?=
 =?us-ascii?Q?G7O2tmt7lKY2a7KtCpBxPXXkuyn43d4CLxTSiR4l0rbS6/roCCzIqgIgjmmV?=
 =?us-ascii?Q?SGXSyo+LKATHTOs0n1tCnr2hAJPW641qxfE6BsY74aD5aQkl7BRKAL1O/ZSx?=
 =?us-ascii?Q?2OrpsANxstVwq0ZbSfYuGzp6ghuw9zeyybAnPgCtiR/qRcEtsgXQFV3uzoTb?=
 =?us-ascii?Q?fbQTIFKwkyFtZ2ofvERBrPhovdDoXKfQ39ZlliFMMR1BW1vd4Pn37ehDL2d8?=
 =?us-ascii?Q?mmvwTrsVp2YzKBnnt3TtaRtzfX17cxl2J5poCffoG/NrmgdAACE/J9k6B6jP?=
 =?us-ascii?Q?ihup/sSWKiQGHB7ZCJE8IbdY0WtqS0Ttz90xzwE7zZkGIY3qICFOpitVJaop?=
 =?us-ascii?Q?7j9SZ055KJi3ExXgjm1Y7L92SZEjbOQcvzDou6EKuRrXgLmeItlQ9DP3vy+o?=
 =?us-ascii?Q?zVABnFS8WrzrWV8iRPM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab0b523-ed12-41c0-b532-08dceecf3c27
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:15:01.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9onitGrJyrfq0F0Wh6VJoeOCAkH9csKaQwwIOXd1bS0mMV28dghe8fO0tE+Qypr9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

On Wed, Oct 09, 2024 at 09:38:08AM -0700, Nicolin Chen wrote:

> +static struct iommufd_viommu *
> +mock_viommu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *domain,
> +		  struct iommufd_ctx *ictx, unsigned int viommu_type)
> +{
> +	struct mock_iommu_device *mock_iommu =
> +		container_of(iommu_dev, struct mock_iommu_device, iommu_dev);
> +	struct mock_viommu *mock_viommu;
> +
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
> +		return ERR_PTR(-EOPNOTSUPP);

What about the default viommu? What happens then?

> +	mock_viommu = iommufd_viommu_alloc(ictx, mock_viommu, core,
> +					   &mock_viommu_ops);
> +	if (IS_ERR(mock_viommu))
> +		return ERR_CAST(mock_viommu);
> +
> +	if (!refcount_inc_not_zero(&mock_iommu->users)) {

It would be a bug if the iommu_dev being passed in was somehow
released while iommufd had hold of it through vfio. So just use
refcount_inc()

Jason

