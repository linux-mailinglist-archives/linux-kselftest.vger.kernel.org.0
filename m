Return-Path: <linux-kselftest+bounces-20023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4D9A2C57
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF8E1F24E70
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B837E2003D4;
	Thu, 17 Oct 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rrd5cCV9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053A20012B;
	Thu, 17 Oct 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190422; cv=fail; b=r3YdV+lYfk1JRLarcZunTNWekVzbxio/9bzaQbG2I3zl6FMsVX9uOIlAKrX2uKyKODWM3muwwVgG4f6KVz9QVfx2JwPrdbwacUNMRB+2Vtl/3a5q5sJhyUTr5hiuS2MzTNMfP1cvgY+lt3T17bm3tOeT80u0ySfARXGtv9CSE0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190422; c=relaxed/simple;
	bh=WXE3vw6w0cNIC2tGGgyJXDlUYw3SlmUMyRI67PfTzXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ErHMrpyBk5IEC60RGQ4NQGBBXom6tz+M3KXEGGfi/ZfzEz7sZPyCir+CpVZ/ahUpZsTnFvsWJUmTeeFHwFm7hzrZHtWNwebpMFxMo5hrfopl5s52ZRFNjwj5ounqG2P4AzX6EJ58sxcpKtMzER6Q08oqPT9IKlV8BYBrdwq9anM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rrd5cCV9; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7m5r2hJqWb59+fLpVBz4MOQy960BKz2EXiB6/z/W4jjH0SYDueP+l51PK3vfBUOBNV9PgP3btho0NShLGA+jtATGBBcWvY6UTn7MvLxFfgf2SVE0dxIo4gLylVMgvl8iyBgsvdtWNNR3WQj7dq/B9b2H/m63PtSxUsH5vwSlaw4LJbpp5d7jXNPwdzQyHNhe5xvWZRHfF1PWTdidXzsF6z6uTfGZ02PNtYarOr2h6a7Qs3d+M2CXYiFmBtWXTK9DWYdJst00RRHfGq8Bt1I1hYYTsm27sRve0fjIaMK8R57O1/KO4PLEcFk27Zoh3gE4GpeBa08Wk3WaHapyrmH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXj00ba8tJE84PPqQUdimb3wxvJKNgliaDKOXU8NHGY=;
 b=yZrkWvOHZTbd7SIV+pWhgU4JzsEYd1vhWA5DTVEY2spoZAecP0kezrBYNWe6SJi1euvuDDld2qx3s3hTnwlwzId1JfC+CuWwjd6n+J2OmsSxc+EO9wGea90WuvRvaHZljMU6yQ0Y5Rw9ljuL/xqM6L0DU4mL3neJol984actM1pnEd5sgckDR64B6LSmzjW92GpWtR91E+TFhN6MYBKorx+WKxNRLgXnlhQpXEHz+ipHYfN2ivuIHqeflwi7tUWTEyKF7HNqxIak6HFgwW8BD1mXi4x7g56H0RLCR1v56e5FtxSEg7oS8RzEy/PrlXpNGWEPjAGsJ3LsqGfDHeEGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXj00ba8tJE84PPqQUdimb3wxvJKNgliaDKOXU8NHGY=;
 b=Rrd5cCV9njrXzlVNrOAiASNFTL/vKfEXNLZr34tRpF8OtdfysjBxSLHX8of7EngNLAdK0RcsQjN2r8BzKQA+dFDUa0LQ0qfI1Yet4ZrdKCOFfVSPxqDNPw0TYOuHbqqvFebUh6He+mnqvEZldHrOgqZDjqBXJiPiHamHiiyY6JxFzxSmOT6400OhH/DOAKexITwRoW/09DxmemlDOuLjb1eUINJX8xaLxjtWfxV6XmUyRJmdHNYZJVZCYkxL3Q7ok4kPRfMF8oice47ZkKx2mA+haJYxY5rLhvrDOqrdbZGHEuhtCcq6QgtSQ3gQCVTb3izPCGfjx8tDDD76IoInvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 18:40:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:40:16 +0000
Date: Thu, 17 Oct 2024 15:40:15 -0300
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
Subject: Re: [PATCH v3 11/11] iommu/arm-smmu-v3: Add
 IOMMU_VIOMMU_TYPE_ARM_SMMUV3 support
Message-ID: <20241017184015.GP3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562f2bfae1661e6ff6abdb280faa0dd49df9fbdc.1728491453.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a8c94e-1431-48f5-f86a-08dceedb24fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRzaVxk36FHGntzQGKPs899lfhfqfsXFNmkBMQpN1FNnuO3jt/SB+0UfavXZ?=
 =?us-ascii?Q?eFS1e0Vyke0OZZIpSdxubt3cmhjrAuZILRpLQG9nDs20R/EohU2bm7CbTKcZ?=
 =?us-ascii?Q?bykPW+mL9YcvEEYhQQo+2mO1EzLQXCKZIQl/gPjPwpLldL/0Ix0C69dueE4m?=
 =?us-ascii?Q?TjirjYfc5aztxqOzBAXyKv+yxtpxcda/9uwrQ33At9hIbv2CdRew9edYwqyT?=
 =?us-ascii?Q?P6iqyavsLL7rPetMaIKP1ybYVww0GQkMzAGAaOVm20uJJx/H/0XWsNuzjrA4?=
 =?us-ascii?Q?itY3S3hazFGnsWfWY3zD1b/XPu4/bY8ZvCS1DEw5hifQQ0WZsP1xC4iSsHh2?=
 =?us-ascii?Q?N667pxctWp/1aneA+qeRW6Ztksl4y1evCIhAe1SAnqiYtwv9BI9TegSyFZXA?=
 =?us-ascii?Q?NqNX2QP1/qb68nrk6EmlaVs6XRNbo8bspzvYoEovZ5xE/p864csKEb4llXUs?=
 =?us-ascii?Q?+gmSbfPswcCAN+bWAbWsgQ6eaZ4c9IXjZmzecrXfAgoHEEDxupC9pWKWDDMz?=
 =?us-ascii?Q?sCangdkbaXmRBFtjfkV8Np6Hp9SUXa1qviuCKbB296RG3M7ip/8t8inkUKCq?=
 =?us-ascii?Q?eaeHVvzePS/8yjbmHFjLD0K/Ua/pkp+fjxZsfepXwaE+9fcDJgZqIpg4rymF?=
 =?us-ascii?Q?0S6pMxrc0wyemNkJa1lO3mZBem9TqxFntFoVBRQcQAOzVoE+oPRGMpxaVYbN?=
 =?us-ascii?Q?A3oklifOYnpP5nJEFkvmjQxfjJDQrNIzdSdLnSZVCINn/ANz3MNXAzdoc7/c?=
 =?us-ascii?Q?pu9DCXulUAJXo/waYobp9GYnZ7LVLL+N5QNuj9PdWgTeyWheiDZ1GmGMHg2w?=
 =?us-ascii?Q?EY/fSSAHUpzc5Tx8bVEWA4SRW0+sh/mdL0E+KAIOjy4uPSXaQowOEPEEimvA?=
 =?us-ascii?Q?qXa5KIVwBuLsvpOdnuYoD3peVDuH4TraPhGJvVdBTETIsAXjXGX+qcKF23eM?=
 =?us-ascii?Q?KCMj4oxR1VyE1zEyF3XXNmlEiyjhQGe17ZSex+AMRTrlojKDCkuOy4Z7cRUB?=
 =?us-ascii?Q?SEsOKale2dykZKcnjBtdPdb7JkHV0WlXGKQl0Qf/IAMGScD5+ki288p/zwpf?=
 =?us-ascii?Q?tQAlSEUojOgcZ3icxhfwjEk3LA2reP+1BMHTyy5YkEoxiwBMnjeq9md0wEJn?=
 =?us-ascii?Q?otbuIFi93qdUfd9yAwT1zbGThz/jJkKKlx3KiIaJc0YYy2/qB9dkr8qe4CqR?=
 =?us-ascii?Q?+7Eu9PUdWEFjHJ9xgF8kTHGo70Ps/z8RIWS1lDxk7VLrl26mRSdlsBTv1tDW?=
 =?us-ascii?Q?qqshOXcv8KFY4vGYTZf2GaumT8iZiFkovK2S7gNai+Z8I8ssnXIjEz9QodFe?=
 =?us-ascii?Q?fFo/7Gb6p9yh2PerULH8tH3i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSxYEwVIiE+yzUtBSeAJ59tv7Yu8uwPJ1XBJFXBoEZbX4WdwKPnOi8MsmvQV?=
 =?us-ascii?Q?kXoJKgZGldGJJyx1pifC2TWOs4/OQz3w4CSYQgjifhj49CN/ub3AbBSOEtsu?=
 =?us-ascii?Q?TjNgBOT0T0T77Fr6bMzghyXVdIYrv2CBryj9rHOu3zabaxw78wmJo/hG8aeu?=
 =?us-ascii?Q?bTxpuW82ygOszVWT94ykTnJgUtrg2qkRdHOv3HPhdY+hj0LLU2upLMF22Emy?=
 =?us-ascii?Q?WOnbQkIHGnMDpXqBQwMZ3GJGTpHNSr54KW+sIxH+NS1GRydYcLb+dCvvmMop?=
 =?us-ascii?Q?e327+za/BF0GjL28O0q2hliTi0oQdARX7LAxaAQksNngCfxFw9lbp457HXKf?=
 =?us-ascii?Q?NeNx20oQJOABjsIJ9r0Pi7lH1N1Q9SX7sHyIyIZlIH43sX2ji6Uj4WDrdI21?=
 =?us-ascii?Q?9iMmEYIgUnKsY04Ym3F3Rd0KgKwh8cXI9VXwTvCMusZChaxfZ14td5d+frfC?=
 =?us-ascii?Q?9KzudRX6+ohEPBIWnGzjAYoS1kukWcacvBTN78YMFJR5qZPbM++0qhKP5WPA?=
 =?us-ascii?Q?kW0FrHo+5sjBMwjmXFxQf9U+MWSlMq9f4CseDPHdveVfBNEbZgNGX/1FdwCa?=
 =?us-ascii?Q?sgspRC1NQWhFWeBqWvfEO7FiNmywGOTHYi6frkhH8SMnzC+hCyGF4j4KzzDV?=
 =?us-ascii?Q?XLuvVEJXA5K2lYCtqCtBT6h38z4bJk6dGsAqUzzjfSyfYVlPJJCaJEGoA6Ik?=
 =?us-ascii?Q?9NmtYg2akuxdNoi2tACjBc1pWNCZbtkLIT/Sk4hO1aAdcRt7P0TpGhQhcpSH?=
 =?us-ascii?Q?KfTqs7V3jteUpHj8DNnqdZMqn5JtUvCCE3GGB4rDDqfphP/p3M81YwdfIrS0?=
 =?us-ascii?Q?qqBpyk6U38mJ9UquQ53I2QTrKpT4DyRCSCquymTUA0OT5AYcus4PUH/c9248?=
 =?us-ascii?Q?lnWZdR+Hjkvcv9x2vdLjO5lI71j/rnEYEF0OTpK6ve6bmGae731EWkmrgRyu?=
 =?us-ascii?Q?EnHn0nMR7n8I5EPNMCcxyDyEZev7OHb4SRKx7vsPIJArYcwqVUJfok82oc5S?=
 =?us-ascii?Q?EhuAhjIeqXn3/ya7LLRaCaQdSpaGxq3xa+EltzAh8Mv4CBg8I94A9kjMzNTA?=
 =?us-ascii?Q?T71sVRWaQuUbOqURxYn+VyRVcNyQBRDzzMkTYZ+UkTBtRIZS811505eTL0n/?=
 =?us-ascii?Q?roN4czIeAJEKD16YTp9eGYG0F1ed21w2DjUvxFOSvJQF5uSXLUD/IvkHcLi5?=
 =?us-ascii?Q?rl031zRegZTLF6jCAEZoCw1X2+GFZTBLgvEAEeNIiklE7fxauYeNnHKJtYmH?=
 =?us-ascii?Q?svhB3mMf/4rQbvp2bYp35/RPhp0xaDcrGoe0DvW2cUnFwzGkj5/tSaiSy01z?=
 =?us-ascii?Q?CIIAKJfm8nCmoWRcPMi8UCUFwIoSLgauDLbLC+xVzIW4Vv5m5kwDwj2jG/GE?=
 =?us-ascii?Q?QQJf5XkFeTJK8B7G0TNkqm1UjB6z4S2l9qm8juWMJR6fRjLbgtyQKFutxfe/?=
 =?us-ascii?Q?zSfhBN08x13/McgLQ1l3ps28ycNuPuy4XGMZYvf03/A66JYEkw8nghENcW5F?=
 =?us-ascii?Q?ltjIZufrGiD8ewQL0NyKWhNE+90tkocsNwYl9A7oJ8Im/Rb8Vsjf13GYISXS?=
 =?us-ascii?Q?A/5m1YiuizEXCJvyAWE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a8c94e-1431-48f5-f86a-08dceedb24fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:40:16.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyAVd2SetrqiMfnLADiXDh4O5QzGx5J2Bogw0F1nxsOeRDXvRCYu7OEvAmLyo45+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368

On Wed, Oct 09, 2024 at 09:38:11AM -0700, Nicolin Chen wrote:
> Add a new driver-type for ARM SMMUv3 to enum iommu_viommu_type. Implement
> +static inline struct iommufd_viommu *
> +arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
> +		struct iommufd_ctx *ictx, unsigned int viommu_type)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}

Let's do #define NULL here instead so we don't get an op at all.

> +struct iommufd_viommu *
> +arm_vsmmu_alloc(struct iommu_device *iommu_dev, struct iommu_domain *parent,
> +		struct iommufd_ctx *ictx, unsigned int viommu_type)
> +{
> +	struct arm_smmu_device *smmu =
> +		container_of(iommu_dev, struct arm_smmu_device, iommu);
> +	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
> +	struct arm_vsmmu *vsmmu;
> +
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> +		return ERR_PTR(-EOPNOTSUPP);

So what happens if the user tries to create a default domain?

It skips this and just creates an normal viommu object

But then what? The driver needs to make sure it never casts that to a
arm_vsmmu ? How?

Jason

