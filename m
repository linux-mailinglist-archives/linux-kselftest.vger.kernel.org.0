Return-Path: <linux-kselftest+bounces-20497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A96B9AD20D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC1288E27
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BC81E2830;
	Wed, 23 Oct 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NzixzfcS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0F1CEAD8;
	Wed, 23 Oct 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702757; cv=fail; b=ToVgfwpGFMty8Fa7zke61jNAAa4/Ygk4e03ehxFodhPCHLxQ7hiQQS9J+3oX8ldr8Zq5ay6D7h128LNMAd1PJuLViPgxGfWc+jXnEFJqX8woQDUC8505+K3sHRqjoS8PVzpJaihfYcf7GkTzTU1P5/nnoFZiCOxhh4xGo9eL8ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702757; c=relaxed/simple;
	bh=jRI0bp3DNDGdedo3JhdmoSwKZtXK0CYoLsBjEwWioE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Is4131Sc2X42wtYVo/CeoJjRjjCTSMyRn3CBUvAUhNPF8CagppqN13GHMr72MBHvMaHy3dV8AW5KGc8UNhndc3pPx7IEhvc5DlwlEip6CKAcjCSb20kyAMl3RB70QLqv45GDmO1mHRsaBArTjhQwuVQ0GeTYUmnB6TfHT2Xu624=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NzixzfcS; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0xB9eV1mE2a8NHoL/4zOB3thEenXn4PA7yNSpoqgSO01/AtxQZ5vZEOepJSoxiy3ZLEyf460RE9S3H01Tmh2xA35aqBOJTOim9KtXAun+MsIOMP9FP3IYmQb5j7/nAGIZKb8H5C+E+AHMnpEb+B4oq7EUYF6vn/MucqKmbtk6do4cAjpjrVSHchNl+bz+EBDr3KOmGYfL2j1Rsh22S1pU8eT3inLpBrvnvtqneGKZTMoHbHyy3umC3hwZof/0hCg9pXh0hRqoHqcowsv5VwUKtOi+0L7m0Fti6zVK9wT+5UBHjJh3zY5bXn/sfYeUWBOf+MwsMS2pmloqUZihi7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wlQZvuxNU5KwxTzgqUYun7Y2MJB49uiT/8lDCn4toE=;
 b=yDrQ/uH3d2OE52gbOACMhvISStetKHJDjVdsJzpc3o0f2hS+ZHitEuGvuqTyTJOBcpz3NW3oOiI1hiJVbDFLCDfvZjzCz3zrdT7AkyT7Cj12TDLOtzzKa97hTDdGIemCx7oZLksPKKuRWjVxlUNueiIrkCHaAH+DTpIUju/JVhqTNysZ87iw+OQ0TDTI5/u9nUhWarACu5MR8K8G2qhOR3ZWMhMxMGQc1209jt+13AbCk6oLIoZqLuWxFWQd3BzyyAgBAF1Y0rXrqTVc7a9DS7KL2l62Yo3xY8LJwb66Fb4u+xtHGB5LFSd+bVT4NhP0UN/kuDn9cR6osZcXR4G8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wlQZvuxNU5KwxTzgqUYun7Y2MJB49uiT/8lDCn4toE=;
 b=NzixzfcSxKpPULHVeSB7AW/AJFOpk/Y1JDDBuDFXw9QQp8rhfHAye2SFCV3fbsAbpEmN3Q4uflvfWLRfGcuMXd1WgcjwPV9Uw8FOYkGewf+Qqc8TWlxo+c6Xn8bt5NLSQuBq7pUDoQwIT5prMoULLk4Q16ejT9WlHfF8AahLnR2y53e+eDH9pL+jK2SWprcnQu0fhKnQgPBMTutWRXo+jKA/bnBW79BI/Z3HMf4i2twUDNSxuXHKsw3WCALEadh7HFcLnRtEcdAbF/UZebW5TWWTXwUROeQjg2KJdjONbl3t3zIE6tI2sQUNc15frTwXWuroDh7XBR6MH43L5byZZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 16:59:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 16:59:07 +0000
Date: Wed, 23 Oct 2024 13:59:05 -0300
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
Subject: Re: [PATCH v1 04/10] iommufd/viommu: Allow drivers to control
 vdev_id lifecycle
Message-ID: <20241023165905.GI864191@nvidia.com>
References: <cover.1724777091.git.nicolinc@nvidia.com>
 <3ab48d4978318938911d91833654b296947668ad.1724777091.git.nicolinc@nvidia.com>
 <20240905180119.GY1358970@nvidia.com>
 <ZxikJwzq8rLPgtmS@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxikJwzq8rLPgtmS@Asurada-Nvidia>
X-ClientProxiedBy: BN0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:408:e6::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 9340a6e2-abf8-48b6-79f7-08dcf3840190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1FD2OIOxMGIGU5alGTOTStQ/lLenuAK5FV12nGGiCjLIjXEyLvlNyKEo6VG?=
 =?us-ascii?Q?p1xMrmNl8H0yLUT9QT/Tvmi0ACv5mhkmDul3SvNadsLdyt9iqtZ7sGDVKW9w?=
 =?us-ascii?Q?WAPaRnP8NxUVvuwSh+aN3GAun+I+fyHf9FrySf+TM+dr9/o6xxlQlOY/D8Yb?=
 =?us-ascii?Q?Kt/XrBhMT/6vogPdm7K+2ROp+jJmpDtKk4pmLzDsEznHJRs7p8/oPBFaDmMC?=
 =?us-ascii?Q?Dsj/+uFHRUjjRK+oY3StXeHdU1cRXXn0GhlqICYFdIHJURhayDnjE0UV6Npl?=
 =?us-ascii?Q?8rd3Ma5zlLoT831OIEdBODmAGmfImK8enR5Ypv1Mv85Qszbkv3kgqIlbzc4p?=
 =?us-ascii?Q?75ujPrBAw0dgtSRy2JBRB5dAUncTGt7mj42N5J/OGCg6m5K52O0JLpG+AsE0?=
 =?us-ascii?Q?Og8/IF3K25G14kt9e6dgMt24KEs7BIkY7nhdPOsNHRcT3tXP1+uqgvV5F1ui?=
 =?us-ascii?Q?fqplYi7DFmyx/xgJwQOXEjF8gTyv3nc4kula5VHbkID2C6aJZMIBtVyv6NhJ?=
 =?us-ascii?Q?WncCOBpcoJq5juorz5ty1ZR8EO2RL6K326fBFX+Wj7CErZHicpw3u4kWuE6f?=
 =?us-ascii?Q?JGKB7Eo8f+Lj7qTQW/+mFzDb/paEmwqvItVc4BId8aturOvuzdpUgBydkXiP?=
 =?us-ascii?Q?3VWrm9aHPYifazj7p/O/lCusmgIApLJI2gIi80bZ925J4ET4UhElBFXM/WLw?=
 =?us-ascii?Q?SFU22RTbUkwA0xih7AQOc080oczstULhnCcZ1e8P6CT4WEki7VB9LI5rlkK7?=
 =?us-ascii?Q?F9Rgg7Mea7QFNERQ13PXoDx0a1BRvwoFbliBlDCYyiY9F8zuxREIuwUiJnEQ?=
 =?us-ascii?Q?ia4zHff2yOaan2GZryu4x8YvoqtTTJMxGfMX6nav/xUaCm7y3aksjm/q9xNv?=
 =?us-ascii?Q?A4YgNuAGp2bn6qd4T9r+LfoYLbi4xyomFQGOitlR05aFBDDeE95Mm51CEYyF?=
 =?us-ascii?Q?xa3ijwAmgoXNX1rPytjnZbCtArPzyD6JFMjyfEdjf25ZPyrJfZcLxI4CLCnW?=
 =?us-ascii?Q?nS9E68UbEYfa9vXslj0hlG7RNz6dOKVDEkCZJ+2MrTZNv1LhdsE6GAKZTe3I?=
 =?us-ascii?Q?J5/KdnegjltGHMJqVJytZfqepeiM/1ZLl8sck02O8WNXTL95dHj0Xd5YZsiF?=
 =?us-ascii?Q?zsbuKWc/udYGpb/uXseXJ6G+ZaQ1nr1B2+ss3OSVU4oKtvLjcSI+Bhbaa+FL?=
 =?us-ascii?Q?pB7DgK64OtL2fKYR2SjzldkNQoDmyqdgA4bLnFrz99uu8Ji7XYQn/obaIEgs?=
 =?us-ascii?Q?05ZeCo9qFfDakhj3ISd5j/5oolZiQtcwPhOmvCNjCJ2uek5aY54q2m7n5wB0?=
 =?us-ascii?Q?faptpRSV0ex3ExtvbJzPE6Z4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sl3spLGKf1/E8Zn4hnse84r4D9OOqYQExa5TVBOx/t2KXa07ezv8a7uap+1E?=
 =?us-ascii?Q?V1VhE+RbSOadMrdEf1Jvllzy56NlZIM7tEEZlg3jL2t1bm0PLBV4YgpEhTC8?=
 =?us-ascii?Q?TjDzPy/2mt3cxpsGt7SLeuVyMVmNFq/vlkisgGPXGpTuuOY3ai8rrOcX+qv7?=
 =?us-ascii?Q?JN9agqaVpJoIiHgPkhRf5+4wuxpPHVZ7OHoodsI0/rWJldRusD9XWbyVZ/xk?=
 =?us-ascii?Q?e2KwBPhZDLk1LB+vB0DYsMyWcYVaGRvJo5ZUko+HcJd/eWjN3cecvH/akAix?=
 =?us-ascii?Q?EiVpJuw/8HeauSnMTMZhWU67gB6NjiQpYAc6XUHh59avgkhlkxuRBscgro/7?=
 =?us-ascii?Q?5gn0zg3kQugOkcHujSw/nFkMU/btElw9TNxxjEeis1n8ufEJtCn49QITlgt5?=
 =?us-ascii?Q?x63L/+3K7EBV9COuLFHhTs6nJV+p2tCefsd1h/04XxDHKywyMGJpY0b/wPS9?=
 =?us-ascii?Q?nYE6H9KC5PZ2KRWo7OlOJ/sOAzO9NpRDdgGEJx8txvYI4w+1FdMW0e+c+IG0?=
 =?us-ascii?Q?1lxyPxqj1CmGUSfM7S4rFCXpDnhN2bWkfqW7xe1QZDguzOtOXZ3ldF5kTnlB?=
 =?us-ascii?Q?C+yp9DEgvhQ3K+zdAZCfgroao13sgHLRLnMmMQg96xKXrhjkszKANSvHW+IW?=
 =?us-ascii?Q?EnR+LXEBeFS83tKWkYPOA5XN8wEomq0KB/dj0mAj1HrCtMpCId+Pn+yxSBZH?=
 =?us-ascii?Q?BnrjlJ1hkd/UBAPss9Yo0udoi17un2WgYtVBkE1ugahRWcndhyE1WHikF771?=
 =?us-ascii?Q?XB3CIOAXEeHl3e0zjwdfolnOiRLBze+RAzOKw9UySBfk++EC21MWjBKX+ZqD?=
 =?us-ascii?Q?V4cXNbKlEeovK9I728AB09ZhGlNNj+cUhhNCJo9f+59NgQYNb9jKjaDMNUMF?=
 =?us-ascii?Q?Q6mfEV/s/gOse+Gda02UfL3MVqGHPRVxc6oEpyXj5+J5kUlEWEPjW2K5lbsm?=
 =?us-ascii?Q?xbyOIZXtowIOh2Z0zCl9T70zJzBJUFF4zHfDdDwyl6E0FB1vC9kuxKz8PvD5?=
 =?us-ascii?Q?T1lr2bPis4vK66Dydrr7e1XIGeuJQYbTh1dvYG02Et+5hImb10VyH9yk+1Ag?=
 =?us-ascii?Q?smcyRA75TYVznXmsTv8VGDVTwSOdPLVeiuxI+M2ueTA/PQp4wQsY7gbFnA8O?=
 =?us-ascii?Q?I/srdeGpapbU7aXlIkVyEYPyzBurV5fddkWLH9NrgbzAmgc9uUcEsTJaD9M2?=
 =?us-ascii?Q?/d7SIvSaD97IxRs064uf9grr2ABjFzBuK5WMecJJIk7b7/eey+bkrMK8bbWD?=
 =?us-ascii?Q?xO+X0mY2yqPsS7YkItuy4RbBmZcvL4ekB1qN/0TCHwFtNDZAOE+1n6tPrh24?=
 =?us-ascii?Q?3ICYcYMmp4v/45NT9Lvv3y5xgsdkwu0HubFHdOJiEeUWuMMizG2Xp5cfZcOY?=
 =?us-ascii?Q?AhlHDVRUufcicbgmBO/6z7/m4J+kKUOx8ZAiyWxmOJ6485Plbkyv0QIjAsMW?=
 =?us-ascii?Q?vWAb1WkPyNX1s0W2sQ1GyAGPwJodv5PN+gXLZI3lrojXzYqmk+SeM3laWbka?=
 =?us-ascii?Q?j2u25N+Iwlwsa9R2kY2kn8JpLB8RpTORG1JtW41prEMYnjG0NR90wwAV0XsR?=
 =?us-ascii?Q?U0D3/jfU+XNh3Pdl76zTAE4JlbKMhJJ26jYcbbEO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9340a6e2-abf8-48b6-79f7-08dcf3840190
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:59:07.0206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YikhR4OR3svOLs7s/sVjZH8978acyFDdd10R/H8nFTBQ/CPeLaj+IRrTDT1nCOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096

On Wed, Oct 23, 2024 at 12:22:15AM -0700, Nicolin Chen wrote:
> On Thu, Sep 05, 2024 at 03:01:19PM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2024 at 10:02:06AM -0700, Nicolin Chen wrote:
> > > The iommufd core provides a lookup helper for an IOMMU driver to find a
> > > device pointer by device's per-viommu virtual ID. Yet a driver may need
> > > an inverted lookup to find a device's per-viommu virtual ID by a device
> > > pointer, e.g. when reporting virtual IRQs/events back to the user space.
> > > In this case, it'd be unsafe for iommufd core to do an inverted lookup,
> > > as the driver can't track the lifecycle of a viommu object or a vdev_id
> > > object.
> > > 
> > > Meanwhile, some HW can even support virtual device ID lookup by its HW-
> > > accelerated virtualization feature. E.g. Tegra241 CMDQV HW supports to
> > > execute vanilla guest-issued SMMU commands containing virtual Stream ID
> > > but requires software to configure a link between virtual Stream ID and
> > > physical Stream ID via HW registers. So not only the iommufd core needs
> > > a vdev_id lookup table, drivers will want one too.
> > > 
> > > Given the two justifications above, it's the best practice to provide a
> > > a pair of set_vdev_id/unset_vdev_id ops in the viommu ops, so a driver
> > > can implement them to control a vdev_id's lifecycle, and configure the
> > > HW properly if required.
> > 
> > I think the lifecycle rules should be much simpler.
> > 
> > If a nested domain is attached to a STE/RID/device then the vIOMMU
> > affiliated with that nested domain is pinned while the STE is in place
> > 
> > So the driver only need to provide locking around attach changing the
> > STE's vIOMMU vs async operations translating from a STE to a
> > vIOMMU. This can be a simple driver lock of some kind, ie a rwlock
> > across the STE table.
> > 
> > Generally that is how all the async events should work, go from the
> > STE to the VIOMMU to a iommufd callback to the iommufd event
> > queue. iommufd will translate the struct device from the driver to an
> > idev_id (or maybe even a vdevid) the same basic way the PRI code works
> 
> I am trying to draft something following this, and here is what
> it would look like:
> 
> ------------------------draft---------------------------
> struct arm_smmu_master {
> 	....
> +	struct rw_semaphore lock;

It would be called vsmmu_lock

> +	struct arm_vsmmu *vsmmu;
> 	....
> };
> 
> ->attach_dev() {
> 	down_write(&master->lock);
> 	if (domain->type == IOMMU_DOMAIN_NESTED)
> 		master->vsmmu = to_smmu_domain(domain)->vsmmu;
> 	else
> 		master->vsmmu = NULL;
> 	up_write(&master->lock);
> }
> 
> isr() {
> 	down_read(&master->lock);
> 	if (master->vsmmu) {
> 		xa_lock(&master->vsmmu->core.vdevs);
> 		vdev = iommufd_viommu_dev_to_vdev(&master->vsmmu->core,
> 						  master->dev);
> 		if (vdev) {
> 			struct iommu_virq_arm_smmuv3 virq_data = evt;
> 
> 			virq_data.evt[0] &= ~EVTQ_0_SID;
> 			virq_data.evt[0] |= FIELD_PREP(EVTQ_0_SID, vdev->id);
> 			return iommufd_viommu_report_irq(
> 					vdev->viommu,
> 					IOMMU_VIRQ_TYPE_ARM_SMMUV3, &virq_data,
> 					sizeof(virq_data));
> 		} else {
> 			rc = -ENOENT;
> 		}
> 		xa_unlock(&master->vsmmu->core.vdevs);
> 	}
> 	up_read(&master->lock);
> }
> --------------------------------------------------------

This looks reasonable

> [Comparison]      | This v1                 | Draft
> 1. Adds to master | A lock and vdev ptr     | A lock and viommu ptr
> 2. Set/unset ptr  | In ->vdevice_alloc/free | In all ->attach_dev
> 3. Do dev_to_vdev | master->vdev->id        | attach_handle?

The set/unset ops have the major issue that they can get out of sync
with the domain. The only time things should be routed to the viommu
is when a viommu related domain is attached.

The lock on attach can be reduced:

  iommu_group_mutex_assert(dev)
  if (domain->type == IOMMU_DOMAIN_NESTED)
 		new_vsmmu = to_smmu_domain(domain)->vsmmu;
  else
 		new_vsmmu = NULL;
  if (new_vsmmu != master->vsmmu) {
 	down_write(&master->lock);
	master->vsmmu = new_vsmmu;
	up_write(&master->lock);
  }

And you'd stick this in prepare or commit..

> Both solutions needs a driver-level lock and an extra pointer in
> the master structure. And both ISR routines require that driver-
> level lock to avoid race against attach_dev v.s. vdev alloc/free.
> Overall, taking step.3 into consideration, it seems that letting
> master lock&hold the vdev pointer (i.e. this v1) is simpler?

I'm not sure the vdev pointer should even be visible to the drivers..

> As for the implementation of iommufd_viommu_dev_to_vdev(), I read
> the attach_handle part in the PRI code, yet I don't see the lock
> that protects the handle returned by iommu_attach_handle_get() in
> iommu_report_device_fault/find_fault_handler().

It is the xa_lock and some rules about flushing irqs and work queues
before allowing the dev to disappear:

>   "Callers are required to synchronize the call of
>    iommu_attach_handle_get() with domain attachment
>    and detachment. The attach handle can only be used
>    during its life cycle."

> But the caller iommu_report_device_fault() is an async event that
> cannot guarantee the lifecycle. Would you please shed some light?

The iopf detatch function will act as a barrirer to ensure that all
the async work has completed, sort of like how RCU works.

But here, I think it is pretty simple, isn't it?

When you update the master->vsmmu you can query the vsmmu to get the
vdev id of that master, then store it in the master struct and forward
it to the iommufd_viommu_report_irq(). That could even search the
xarray since attach is not a performance path.

Then it is locked under the master->lock

Jason

