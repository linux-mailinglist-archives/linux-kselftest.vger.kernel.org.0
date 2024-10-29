Return-Path: <linux-kselftest+bounces-20970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019089B4E1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843171F235E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0919415D;
	Tue, 29 Oct 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I21rTfnJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA032BAF9;
	Tue, 29 Oct 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216094; cv=fail; b=uib65bA7LOug/Am+0nbmzdlT9lZF6qv/+9DdeNiO6pu8eu8P3XNvmfj6DjaBvvW+FFzQDLIvQkeE9axewh9rIxYirgVZVOVphIyU3BLuLqQDoIbhWme+Xi1IWupqD5I+wCscrFVCcZpcQcA4L+H75WmcBzF2t/roRK5ogXAB0A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216094; c=relaxed/simple;
	bh=Iuu5smZSsnvMMG3aozwdQ1VDqA0X5UQf9WeWo3RUFXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XvDaIhX4caKYHInBezwzuDkCpfujbW7A2iwr4F4VCSSjcjRfTNOVG3uRAPituurowU7tHw3pzq5NniZvSTd1Wpbk8h0v4MSqsE84JfNB15GgIh7OP2TEeZuMTTtLbD3nFY4OjRvAw69ioq2Vq8rXznsOdMtSN61K2/DZLmW/X8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I21rTfnJ; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfh1UT4a20II4p4Pfszs6I9SvXgH61+Ld9FB/YpY2zw/u0mAtr+6n2nTO2EKkBWa7IV0CxLThv1pU+lEFu/fbcPISOT3MzrrzR7zI90RgcPdJhFeyLHxNIktdks6wybsnaB1dgTjdEK6f0K9YgYptYoSg5ow2AfRqxZXvI3O45o1s6cqQ98i/46ozAxwddMd6Wkn6EgBHm1FGzEecLeq7YP2pklAvBcTkTctmcw6xzmlKv9ILJcuC1Bv06QJFdEZhSrQQV/oex02VKxGIXWmQz8Q769cM46IgqZXdyw3aKYGrQFFt2LyIikbWBNJ3ow55yhYvWVzfQXVjAHiuNDt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP34gkxPMMJ3taUGG5F0zZVDGtPB7KyWqytY20AULD8=;
 b=kp3DfspPssw15+fov/HVlgRLDq0WEVtXfwqV1q0NtmKhz5xMg+h8wFW394bjkhx/zsj2I4RSy2Un8iOoD6CDGO7ej1hqRjpnfldHazAxnOQWPw4RiIJ0yIlwvvPzTKjXtK1CCOpOMhR0pSFyXA9L7A7Bg7opAVkZ/OlNAhdPHUf2Ukr3jdfSaExiSFgYysmZldwCkCoHPYWo60Ldns+y6wZOZ4NuCqJ7oLBzDVkNIp8GkHvIplz0WJkDGxW8jVBIEI68jKCRQfEkBxTC2eYt9I20kRx8EgTdEGYszZanDguFaE/MjyF2cbsLM3dTprzQ2hm7hfSI9b4R/RGzrK9n/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP34gkxPMMJ3taUGG5F0zZVDGtPB7KyWqytY20AULD8=;
 b=I21rTfnJYMzCjUm5QMo6YnYdkVne43VEIaYKtZOB2ZFUto5eg7T/ZGhQsXHmt/Oegz7qWYpw0rrpV2PYC3bPA/WT2DNQoy+oTEBlCnvlVdANVy6j0g2qlukIwjH2LNA+sFUZO5W7YZeabvBeQeFajkJtCeeO1lP4wSD8v8Ls74k6LOSqfnZYmmOhMSucdfm7fSIj/8fDA+0eSLGZZFPGJ+hdV8J07mCgJo4z4XJWZRZvumI4HN5hZHwFYja9TeqNKL/XYbAycDaHqSEpY60YKnB+zDHaVOMGvIDNldGaOX96vL76n+5TEilnGS5lL7o2GUhtgk+REOrGRmrhPOl3jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 15:34:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 15:34:40 +0000
Date: Tue, 29 Oct 2024 12:34:38 -0300
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
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 09/13] iommufd/selftest: Add refcount to
 mock_iommu_device
Message-ID: <20241029153438.GH209124@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f91cc278a173a95969af16c46442f18b639d4ea9.1729897352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f91cc278a173a95969af16c46442f18b639d4ea9.1729897352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 218ebc37-49e9-43c3-645b-08dcf82f33d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HInh4ZFHGgbEXbtQGUM3wNGtdqerpoGCbkXeBVqN0VOG708k4UL2Ve5Nm0dG?=
 =?us-ascii?Q?v6S0WZ6lMta8kWDWpxw7sy9vnLrGmYGFBIZoTbQ74vgEzHXSss9KQplW/X1N?=
 =?us-ascii?Q?VQgp+GETGSoX9wZHDEpWty49WI/eLE/H78sUX3uS+1lyQXI1URjPtwe9HWci?=
 =?us-ascii?Q?Q1W8bgNm9x8XUQ5G+6YeF4jF/fyDt6F91+V0oJ389lbaFrbalOFJHy40KzSo?=
 =?us-ascii?Q?RQS0zH2nRRUnEzJo1/5UXpD+EDFhQVxiiEmj6XtoqueRogU3jh1/4kcO2ZId?=
 =?us-ascii?Q?gh3skQFqLxMP4ni2bNbwrJGHnyr5MoROv0+MzNikXiDSpnmvl6K0vaav2Gm2?=
 =?us-ascii?Q?rRhYG7LIQgiD1pdMZ3WezaCc1gjxu+2yjF8J0upzulf0C/PN0DqDjzjAGyur?=
 =?us-ascii?Q?YmET/I6pmz/XpeCYW0RXsACthudWazpmwoRj4H8XOUMqoot77VJNaBkO/znT?=
 =?us-ascii?Q?Xpw2QHXDg8MOh2qIbK5v0t0va+OJF5ef4z1upQhRKjh51S3AtOnsG/2LBJ03?=
 =?us-ascii?Q?qA8xzDsJzdUel4MtIGAMNUPIbxwhwdZnCQuh+QkvulHEmPVDuUQsy9EWDeKK?=
 =?us-ascii?Q?vc2gi3sYlrDqCQTzGozBjigk0KgAwAI4joo+qPekV0FgyvcV+wBpo6KRFjHL?=
 =?us-ascii?Q?hvfgpYJHjO5RwqZL+QrUroyeBHRUFLWJ//sfBKyhbITaLr4gzHqnbT7MlR0u?=
 =?us-ascii?Q?f2iq4f3lSN5WGhDz50iJfNVLBa+272p++OT0ntrqEhPyIbQBnJYZ5RdRDniB?=
 =?us-ascii?Q?i2Rv62g1o7dMqLpb+eHTDHP6YeyVtwr8nHVRXaUdTdM8a9Ok691AlI/SuJfd?=
 =?us-ascii?Q?WeeJSx6EPRnNqbvL3+f3suDx0VNkFPiYzWv+opdIHIgdJSODimHzfamkywsh?=
 =?us-ascii?Q?lDoKjpNaUNBuhjkpeDbV4mPaei4F1zlAle0UOATDJIziWUmSvcOKRx/3ZiFx?=
 =?us-ascii?Q?/BVrOiPVz2hlKliNdGfmj13k5khDqMJIeIj+vurgzviR55nOy8KBqAwJ4KsA?=
 =?us-ascii?Q?SD56kUV5wNUSxkfcsSL5XXNPUf7E35smFgv2PjSq168YKJtVFkKnm/KPYR3F?=
 =?us-ascii?Q?gLHRaRxRmsi5cxSWeUEC6aiqaKYdGExMb+lzkWs4iPyoz0GHmRIAI1p5Ku2q?=
 =?us-ascii?Q?AAraiwbx/r/Vr6debdZyq6tWs30/HBPETQ27M6XbbCOpknqYD+g4LTQoyIVD?=
 =?us-ascii?Q?NjQxxDKgB2rxipCJKGqksNcz7rHWpmaHgdyuNhAo/Za90x/00HnFXDhQARaD?=
 =?us-ascii?Q?tmfL9RZsWO6RTNPCtayftyEB9Aq6jWC4599dDjogBnALHr95eGIPgCWWzKpL?=
 =?us-ascii?Q?X5jofE6wWRMttd1CrTrIYcQ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0bjrD82VuSlzLliLaeiE6ywtnZ7n3x5MDoRASsQ6od0ciZxz9bHX14K7hG/?=
 =?us-ascii?Q?0YWB4x4jn05ajJVvQ/atJzyjlcWu2B5Atk7Uqx8O77rFq8Rj0Fy+iH1RKWnd?=
 =?us-ascii?Q?fFXT2SYHWYSGsBaCXhiQAGzfjKL36PLn29139MnxEAjXd8BZ5PlW4JvlQCVc?=
 =?us-ascii?Q?WfCN4zcR8CLbtfTC9On+BNmSMoIwDs9Iy2EzmU8ztvyc7VdB1OWIld4Ptfmh?=
 =?us-ascii?Q?Ar4fFTpMYEzf+Iqov/CdkmIcUUsRLKx3vnfEZYvpC9NP0r3YszStTFz60dgV?=
 =?us-ascii?Q?EaUyCsCJj/MtRAuCFUhRQZg7mV50lJobm374tATyXWE6pErrNd07dYz/1rsH?=
 =?us-ascii?Q?MxH/FtEOr3vjRA1RhqNiPOgbbV+wBZqhjUeaecUtMcHhhwPjhNcXWxVsSuPi?=
 =?us-ascii?Q?HldG7eiR8p7i+vmbwtMVTIAlbUI0DF4OlRdiyrbZJ0Uhl6Cp4j62TlBieYLO?=
 =?us-ascii?Q?qoiAVobfpKyu/SHjkTGiDTupvx+kKSphDtSliM1g0JpJl2Xj3KUvnY+nWTNS?=
 =?us-ascii?Q?6bG2VfoLBxOirpQiBUrU61m/nRRsy2GyG1vR60fIcZ4dxfmgUwGxAezXt6TE?=
 =?us-ascii?Q?+VKaXvQlTKDmJ0SOw+gAyOegsy1P6wbfFnO/Ia3MufPyGnp8715XR+t4YdiA?=
 =?us-ascii?Q?cFNxeijDDmSipGyMbLc0N5xJUvf+HxGayPPby8/tKcwvNJ+lWTdGslOMBVmT?=
 =?us-ascii?Q?nOHNyX2dO8mhUFxCErFujn8IE4c1wwt3Q7siOwflab+PnJ4Gbk+j44d/QKM/?=
 =?us-ascii?Q?IMAalI77kls6vs7CjFeFtknjsNAjVrFe5XB3xPOEDGjvLroMGusDpaaZP2Gi?=
 =?us-ascii?Q?3X419w2yBdctmDkifdw5g5Ve8cTn2yP38b236YlRD8SogCAw2EiwAZlBHTkO?=
 =?us-ascii?Q?5A8TjvgLK6tR9AICsZsRYpMEiMxQyr4yKRHkKljfKwrE1QuNXv2IpCjIRo73?=
 =?us-ascii?Q?G2RalM6/dMUP81CW91vrZNRzb4UexLvl5QIANHVO1Lf9DnWcr1skrXfBBg87?=
 =?us-ascii?Q?sbuULaRS6l5zk3Y+ylhlpXIiY2Q0MjEEBv6vUfpMiVbW8TtnjTdKWpTa5e4P?=
 =?us-ascii?Q?oSyHOhGZSCTjGLNRZFwgkMzOgLV/yZvsIpHc33ZFJgvpCWZei9I+QfXw0mA9?=
 =?us-ascii?Q?ngOKxoFveWq5F773o9ucFnfqTD4f+yq0ZQPITWLvyJiLAnvm8m71mSH2C6Dr?=
 =?us-ascii?Q?BI9BnnGlke4Eba0JD5v5k9KJsF9NegXdOuzIN+bkMdpZumpF3LSvJiOWS5YS?=
 =?us-ascii?Q?pyGrwmX8f7xATr7/psaRcOdYy0uvTQMs8Ghf0kwgNHYQZQjYtobZHeJXL4PK?=
 =?us-ascii?Q?m1Ld8O8BqjaC5DtbQGtc/7u072kbb46sROdkdqXBO2d44hbWsl9EAXYHaC7b?=
 =?us-ascii?Q?BbmXt34UN3WC6+Y6Mw/Z5dA4cPEThzfHX2cvz0QY1C1L7lSoEsEL0DAec/t3?=
 =?us-ascii?Q?R4IvSuu4H9WLXC+d8nRAwox6daLRRd7/XLTjMYwd43jGq+hwZmBtCNjVkD7N?=
 =?us-ascii?Q?aJHe3RUdCkt0R7Ml08k2QoSnYiAXrYil9FjZpy02eVIIFqVbpUesZy6gfido?=
 =?us-ascii?Q?gZUJZpJTtlFolhUt7/s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218ebc37-49e9-43c3-645b-08dcf82f33d7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:34:39.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGmEV/aawHLfpNvpqdFJT489aHFSVj9ktr4WzXu6r0qfGXH9GqftD7E7vAzXyjtm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

On Fri, Oct 25, 2024 at 04:49:49PM -0700, Nicolin Chen wrote:
> For an iommu_dev that can unplug (so far only this selftest does so), the
> viommu->iommu_dev pointer has no guarantee of its life cycle after it is
> copied from the idev->dev->iommu->iommu_dev.
> 
> Track the user count of the iommu_dev. Postpone the exit routine using a
> completion, if refcount is unbalanced. The refcount inc/dec will be added
> in the following patch.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Since this is built into the iommufd module it can't be unloaded
without also unloading iommufd, which is impossible as long as any
iommufd FDs are open. So I expect that the WARN_ON can never happen.

Jason

