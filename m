Return-Path: <linux-kselftest+bounces-17287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316996DF6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86581F23106
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927A1A01AD;
	Thu,  5 Sep 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dHL7fxMh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E31A01DB;
	Thu,  5 Sep 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553245; cv=fail; b=kgXdzXr2kKQmOjMBVFkYZWIzIYLrf97GA9u1+NJ9hzLnvhKR2YXb0XnxV7id2GcCmlqbLB8+NPO/pXGaMmD01wlnAY+P1K50dWZZ7C7EXGoAYtlFfbgqMqZA6Cmt7mY1v2EJDPZk6fX5IlOXIiVHi3Nr5XirbKcU8mm7g8XCeJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553245; c=relaxed/simple;
	bh=YRnFl/Dyz3ryxije1WFvOYR5Nf/69bAT/xFxH7v86j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dS6FaL6rOlSfX1uAlgfxITOerBrcSdywvmXgxQHpv/MU/8W5C1qb5J+hL+SP5aJSskhVb7NlVceJaUYe4HWTjUgN3y4yUkApyOxUgr8kkElOcb/11Rz5Eo8mhQbbcEc8aVByufjwlRB9Udc+yp7tARDYpi5NDsmmzEr/oS1tW6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dHL7fxMh; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1Knwf5uwsWz8Sgeu1X+uN+AqP/4lfNK3EnxswyPZH0JIQDrNkk1Q/WpANQd4U3phxSJI9fTDilghqfHyou2O1bKIcVaDlZH5MYzY7UPv8gbfTLW7erBQO4zYlor3v6vBTkH7QnqslQAPlqtSYmjIyQHwr5J3pbx/+P0S6/vODf4jJ8e6FRjcFVT/h8rJOPJdxO+2x6lR8Ml4B6JBg2wrqmcDnb2IKEl1xgNLqoOSajGhgdOLW29E5sWdgre+NGzhh4aRVZ4hwV3RtsvdvaiTNYhNIEFQ5SjcAjlop5Ff7jJjJimoZG5v0tnpZMcaIf3Jo/92hMhFvwRHjs7gI7nmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHzfUL6YLb+XTes3nGsZf6/ew+gQg50UjmmFf2We6+c=;
 b=wBflFazWbCUhUw6af/yuKuOyutKLJHFxzEVpJRAkt1uc9hor+S0OR18TsymzXKn/5KZj53Caq7FSPzZmxPoNHbOCKDJKgAoIVFyTrcbOwAHvqey3kJGVmjXukkn1suMObAew1T5C4thdj8dUxcM4sfsxXGt8bG5y1lqU0MxCt87PheYN31DP/0PimDQEbSUdoF37DLy/WDyIjzUvFKT81ig/FskBPmLMCWPoj2zPMVIaQ70CmpSq7iENs+qDPwSW2rWuGrj2a+SmOewigSePJjt2ATSHWyCzDYvgnaJfDGzopkfAaQUTBbgxk59R1/48aVDrSLi2ORxO1fp0IqdzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHzfUL6YLb+XTes3nGsZf6/ew+gQg50UjmmFf2We6+c=;
 b=dHL7fxMhHWLjJ0tcJv3KOA9xez95gew7PERckM/ZepyjD8xPkW01VUbt75TyMqh7kiygIlr59xbZ3gBo2KDTSjqrw2HIWQwmT44Rm4an0ALZTSoaZzHxMY8HRCJoc2VB4dmeRO47rjZTE17uRdSsOCXd0yJjYPng17CXEfx7CN/35sAHHwBGOfcjI4y/4KqDgMLegAsqBg2ze8ighgGevRk/mtnPxYlFWhQiUaVHvze7hPplu3xHpnck/IRRt7OTUTCP2isyJ/xwJNR8GND6bU158RZ2d7e+4PPXuAqj5U8Nq49LzAcSd7DOYAWWnv1/qIARxPbZgm+SZhKRqRqr0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 16:20:40 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:20:40 +0000
Date: Thu, 5 Sep 2024 13:20:39 -0300
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
Message-ID: <20240905162039.GT1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN6PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:405:75::35) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b736118-8798-4cfe-8916-08dccdc6af33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pyxnvIWZDmK57Y6EwxQgYiPLuBpK6dJlg56zeGzbJd+T9Ban2mQdQI/Ml0+e?=
 =?us-ascii?Q?HSeBPazdFK2vBkqpiWHG3RacfaFkvXG8UZygs21bDiUKWjKaA/JZHEViNsaZ?=
 =?us-ascii?Q?KyR6A49ALzX/RNoKngj/HaoyFuWXqf4gkGiRyNI+NCZDeVKZLhwvthv6aMV1?=
 =?us-ascii?Q?KEZ5TMM3CwG6HGnCkOM9QulRxNvK/I1x2W8lwynn4SUV4s1Qq5tzjOiBPDP7?=
 =?us-ascii?Q?kQgnQhx4On1ZXKgHd1+yUtwISipwxibaP5sLeApfOYcVxNzVl6l8OyWJTdNC?=
 =?us-ascii?Q?HhLX1Ybr73RHkzqWMsOcdmIqxkdD3X8bgdVGaTW5GkPwbgrYyNW6jX3IQHUO?=
 =?us-ascii?Q?a1pcQi8EP8SRd0YWlkoCGZfJj82KCIy2dyVk0GNRhp/TIxw/Q5JoTFjlhzWJ?=
 =?us-ascii?Q?PzxVyK/kRegPb/klSu7wuRIiW55dOEn3LL/qv/i1Syfr8EwPzovpZIiUAhcm?=
 =?us-ascii?Q?wBjbCqGyBALYGEaXAGpodDL3iuu1P3JQJSGC11IdUHuX23+q4ZCbApjqWlB0?=
 =?us-ascii?Q?RzAEd5RFQ9PCXMZ10KYS2orxaaDLy9TcC0bffxaoRyrHR7x//YAmC0xlBhD6?=
 =?us-ascii?Q?1zCVzuhzZDHMvnz4JUQQzylzverDwiSGK+FqYXc3q0PTt5YCuoNJJhdy89nG?=
 =?us-ascii?Q?XWw4j+d162illy02CC6r2XjXjS4Lxgxa7p0bo6PAWvKDqE+a0Rv5ho4g5w3/?=
 =?us-ascii?Q?JJdza8yIlaKlYaBoVBTJcspgx/sy5Pd610rJt8FZYmYMITFJSTh82fJTZGE0?=
 =?us-ascii?Q?drVEy28bhMvo+Za0clTaPF/d9E9IeWxP4wN/Qf80Y0jAa1xr9mBSks0P/rHN?=
 =?us-ascii?Q?BMF6+vHtNLJunS8VXQlPNC5LTz1r/AcV6GY15UeECCBFi1HjBHNDtYONYErE?=
 =?us-ascii?Q?kiFyUN93wDW8u5tXdQ7FOuCuI5oQDC8QjDTCrpwbAI7xH2lpFDtBUlpYgckX?=
 =?us-ascii?Q?k93g6WKTgZkxRg+Sj9yT3RBbm1QdaoWN+yjUVw94eJCfjB3tqjThyQgctZji?=
 =?us-ascii?Q?x5r8SfJDRyjr2OQwRfbDRg/DW+VRE5KZaYcQ9zXsSDT2MWEXaQt1sazz+wNU?=
 =?us-ascii?Q?qnvw9tfBR4F11DtE9VVT/fsijvnch8OrrRTfQEvUbRMoV5ThxigMcVizO1//?=
 =?us-ascii?Q?YMUGSuUwsb2XVzzHkCA651eevcSZ5cNscQ0DptlYXcx1gi9ar2LmXvjo+C4D?=
 =?us-ascii?Q?IcoAIOFf09Dl41AuEJFRFlTKJ1c5K4BmTSu8aXXez3wunNyKLk1WPA4tC0SY?=
 =?us-ascii?Q?wAIpDqyowlHd658S+BdPlZFwNs4S5ZHPulDm34TV8DDdBpwrAf1Pa5AgpzQC?=
 =?us-ascii?Q?L8Ta1Ezs0+92GoQ5RvuM+j2lcBmAt2LgH3CgogXvEmOzJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0aXpsNOGo+fXY+6pdyLHTSIAf98fRv58V+hO9DDzx4BvFPjXu6BzSnv4nHbQ?=
 =?us-ascii?Q?JDWPQv9ZZuvtlkk/BJ+RM+m0kRIx9y3PLrR1dknfO/twbqgn6eV8nNwVoOtG?=
 =?us-ascii?Q?vpM2j/d9yLt4lG6RJTUAnHiqI53iPM8Fk9pEC9c9zftKyS40gesYgFG7aqYP?=
 =?us-ascii?Q?GuMjynZHK0epE0e3DP5dCD6ltJzlNaDsHueg/rt2d/B5qy5QN5vwo+KCeHyw?=
 =?us-ascii?Q?kzTwu8Vr8IeQal1K1iZaat9doLqI6u682TPRB2FOGmGiTuFFoTkMICLczPPa?=
 =?us-ascii?Q?gE+cSMyCgG9w74MT7iCPRxEB22rW6e7s/c93xrL5Fv8JgiiKN9zgjeFg17Di?=
 =?us-ascii?Q?ETHoLr7D8CiaW1AC7i06HSlwF9mb+yq7+1OGLRnO5yRXJVohwE46YfBc0Bup?=
 =?us-ascii?Q?3LfA7aAMBATZTzXaByy6Sgu2/65PiMdFJ9dmObzRtSgHWmnz/n+U583kwF+k?=
 =?us-ascii?Q?GeLjca2VEfcvCGthq6XF8ZRI48BNNcalUjVvKdAg62KV8+Gps/TMkR3I3E+I?=
 =?us-ascii?Q?rOoUYu/Q4iTFnet/tx9EM/j8UOqYxKjgyhjQItWm/84RnLNfvzO1/YNBL8sZ?=
 =?us-ascii?Q?54DQ1sizAp1OfA0ymRpyf9rCB5Xq9R+meps7+r1NC7PqrSXSGUSZWkyqmQsQ?=
 =?us-ascii?Q?YnY6mCcgbFznzbAwkqITJ4GQHpX2OQ3FHrqrSXwwbK+D0wHaGyxOEQ+Kghab?=
 =?us-ascii?Q?cZQ0Au05ahGXxdru9OwMUFupoSsa3+MoO4nSG7ca6vsY4CXMOzWqc3D1vXPh?=
 =?us-ascii?Q?c3Ys/FhFdt0Nl8KqSj4rwUVN/VnQsDqI1SfVohGrIyQ1ZiKJk6L9NbaQvT5Y?=
 =?us-ascii?Q?4Za4zxqaUkAWftz3ZqF2XZbCV9uOHkYXC+LYztZ8/E0Caa2hiWwZXZHVSOrf?=
 =?us-ascii?Q?fT+lbAOvVJVhhZWkxLuKhTcWwnR34LamWP6ZOWxMnyWucBFPKIDCgikKFXmV?=
 =?us-ascii?Q?9t5BEsISWvO4lL3XPSqsFbFq0pgtsX/PnMUq/bsS51x4MasHKxgvC7YaBcnP?=
 =?us-ascii?Q?R3tviNkDMKpLm3PchtrkFIMTYzcBOCX+3lMvKjaG/7/ThAHUgC39yNyUB6pL?=
 =?us-ascii?Q?/q3zsdY0XjNub47BiIjM3C5us3A442H3VWLgp0NmTguPnz5pdtLrY0zz3Wfb?=
 =?us-ascii?Q?2VYoWysXnO1JbBsRZk5BihmJZzRCJg4p53Mku1wer7TgOX3Nbv3ZCKECYl4c?=
 =?us-ascii?Q?JrFxZlAc2f9v43JI9dp+zMDwyk/ieFcKI2K4jMIkS5G3wZBWEg/HFWTrCoiF?=
 =?us-ascii?Q?r7VrV0lqU3RvoMTd1IGBsllu2PJkWPY1ItLKQnaTjqJLvxwDAypX6TT+KOeh?=
 =?us-ascii?Q?1xV129iSRKKWi9jm6ymlJQhkJhKQEoe4VeVnPDtEbRZAYUHiNP3JeTDJVEHp?=
 =?us-ascii?Q?TjeJfMROTJVDUfgQx3niyaGVAFzD0uhYJmVC/ad8YiJ44GtNKy2claYSzpEC?=
 =?us-ascii?Q?J0JruVFn44AjiANscmgxXasixa7kFrXz1qVNyd2jroQleAN0+YROrIFMYrLR?=
 =?us-ascii?Q?PtvOkMFeS2KtRkaKLa1Syr0ErEKCq/1w5gkb6UKFB+OcIDJ9pxtLzkBwwKjn?=
 =?us-ascii?Q?OOiJ16ALZ7LwD050g5EPIMXifT9IojN4E2MoM7uL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b736118-8798-4cfe-8916-08dccdc6af33
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:20:40.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4blJk/FSgu3xrrIgk8g+jNFzp6OTYju8EMTiMNfDfQn9CgHkGliQg7GaVEwC1bw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:

> +static int arm_smmu_viommu_cache_invalidate(struct iommufd_viommu *viommu,
> +					    struct iommu_user_data_array *array)
> +{
> +	struct iommu_domain *domain = iommufd_viommu_to_parent_domain(viommu);
> +
> +	return __arm_smmu_cache_invalidate_user(
> +			to_smmu_domain(domain), viommu, array);

I'd like to have the viommu struct directly hold the VMID. The nested
parent should be sharable between multiple viommus, it doesn't make
any sense that it would hold the vmid.

This is struggling because it is trying too hard to not have the
driver allocate the viommu, and I think we should just go ahead and do
that. Store the vmid, today copied from the nesting parent in the vmid
private struct. No need for iommufd_viommu_to_parent_domain(), just
rework the APIs to pass the vmid down not a domain.

Jason

