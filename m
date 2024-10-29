Return-Path: <linux-kselftest+bounces-20981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E239B4EC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 17:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BAE289A00
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974A192597;
	Tue, 29 Oct 2024 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHCqLlce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BD802;
	Tue, 29 Oct 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217725; cv=fail; b=hF7DbabDoAciYfU8AnD/JsxgBZ0mfr2kshAD/BgWIsD/8oZq1cKuLtc9+gZLqy/4EIdMCy1kI9pe8OhH9OGd50rzGawwZeVEer4Khuiyr1DhA4BapVcAIqU9uth//P6SIYVrV2Y1Fp0OQm6jYKXY5DghPXmbyZdkUwLOk6fw5/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217725; c=relaxed/simple;
	bh=v2CYPMaunlMl9WqqwUbu1IxqWMmtQOmvXKDO9/DBAv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EYWTqXaZ5yU0OE/drU+ZK8OdezJsU1PEyrvUYEdjXtR6hsstDVwW6GIf+p8oL57r80fz8zHrNHZHXWlsOAgh5qORZcXUsvK/0sMNclVxWgVvwG1AzNG5dYfIVv3encUfvTCPR7+Jdw6plU7j7u6p67oMawa3pKE4ywmoj1RLiiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jHCqLlce; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaLBoHND2hRWh7l8TFkEtvQaEluCIClZWqd8eyYwNPxK5UBHxmzwAD6glyCVoDgeylZCtbZbmxwIXua4l/AMNO/Bjrxd9Ozic4u+VA7VDMKTkXFEyyhTrkNOeEAjriIciMUQj3k2dUfuxOx78U6i7hUe34zFmhJlzS4uaS+VWfShN54aimWlM3EDcf0jmSROUseHW/ZyW6hCuE4fycaqZbEpA76bArFFbai/7iQiwh4PgQrxvbxdjgzo1OypVCYuLB4m77UgnG2FB7XB+nr8SJF4OZvPQxoxboIeCWgfMsPQTrj1Fi6qXrhNb6qu1+0axw8khGVVMRn6FPbTMeT9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3AxQxv5SkLtT2gOQf8ObkHTck3aHAAhzITMEYPLGeE=;
 b=mnTVb2cfceD87D/u4Z43XaS2xTdRcu64tvLYftChnA5CyrdBTO1ODcCRZDua4HzRmKITC/9WCD0huflug8rIOKfPAo2ID/NlehpOxM6EMmD/+TFawl/8XUSCtf7Mec7BD4RJQe+0uwy1zc2VG4CfnKL7Rw17b55ntUW7oyzSwYSi8rxW/jIV+I4lkdQlA0MZOlKK39pANMvU9SMQJvk9QZJt9x3V9U4vfcsUeJ8P9CsAWjunNGx3tu26NdszNGthCeoyDOVyiF5f05MOeodhHV4T64QwzAhKfBUODrBe+khm0dnVwlrlxrnmqTQSFTwXz0kOiV3W33Khk/VIudNBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3AxQxv5SkLtT2gOQf8ObkHTck3aHAAhzITMEYPLGeE=;
 b=jHCqLlceXWL8yo/N4FPoKf6YqLwthaQEKvAc4CWtTiLqr68q/lSoiJrXOXDHmxFJsxTuIKOHbr1I0StbcSlxOyIJOBRxCoQxxyvblBo6nKoC2pq7CRgDYQzoP1L1wkNu+P6zbj1QboOlOfcqBW8tKSCQzwJ5ZyzX7P/GKvLZ5q82j7l8c28BggIMFO06fNPXjawPQHocj6e/Ld0GUuldAtJLrbXFve3VMC7Tk9x5r31i8riSumF4YLCP66/Nksk6bEqgMlDyLk4qSQVTBNId1cAInZ7sp0VB+jBgfrMmhlG1U95NnbSK5R5wquORbrITuWCafaKeEIDLMIGZxEFN9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:01:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 16:01:58 +0000
Date: Tue, 29 Oct 2024 13:01:57 -0300
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
Subject: Re: [PATCH v5 04/13] iommufd/hw_pagetable: Enforce invalidation op
 on vIOMMU-based hwpt_nested
Message-ID: <20241029160157.GL209124@nvidia.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <d0cae90d891d93f4fb45731a23697c06581fe434.1729897278.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0cae90d891d93f4fb45731a23697c06581fe434.1729897278.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: dee7f5ef-bf68-474b-ae36-08dcf8330437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bIHHOhyObYpq9xLPb6RUOcwbVwpO+0sS7h7smfRcT/rstva9xg4U9Jx7MxGw?=
 =?us-ascii?Q?Eup3nEQY78vksJUgmaEQf1kfYQHEjbv7bY0pObi14VV9yxWhuKkpaU/NCudI?=
 =?us-ascii?Q?vH3dnnv/OZp0oF72qB395HcHgW4tT3wlSYDEEmmIh7tkeHUr7DCOrN33OB3o?=
 =?us-ascii?Q?zsVMS6e6CMo7SkNWTQOrzNLKBNCbGBiloMuQtlHNpVpaPW7zbKto7Z+XlW3L?=
 =?us-ascii?Q?9p5l96uDWH6/gWJZ9OSynFU3fMXSGTKobMjWeUnzmUzaTc0qw/p59hMvTegt?=
 =?us-ascii?Q?VeZix2uuqP4msuh1h3YJj1aT/V4KNnGyNHVCZjvJXIJdV1RE9+wS4CNTvA58?=
 =?us-ascii?Q?PlUxEeKzImZ2Ery77uCpWd1Iv76phMyUsYQL529ITH4oE4XHW6fQdfgIdWu7?=
 =?us-ascii?Q?wHBU18V6rzC5sJzZmljXRgNgPAjgvDn4Wj8fQ5UKCrjeI0nM1CwBg9z64O7E?=
 =?us-ascii?Q?3j+fTFsSsu+fxZfRhI64rg5DcqjnX9m+vY8p1FKn7G4avfk42/JSymMUcmMH?=
 =?us-ascii?Q?JcmF/fMx6XummpfYh3OpnfEI1E1NQO+5w0SkeI3Jm2YYWsMg2hY91rUPDBLm?=
 =?us-ascii?Q?DECFHlO6tOQC7rTkFV8GGDuGlS9DBtu2qu5htRZRtRKgpbGK0qIdkmWVyNwA?=
 =?us-ascii?Q?nMPLiAiaNEMhz/s4Zjf2bgvQAFPM6ZBaoMWZfrDSy9TiPlQrULpxrc5GFwvH?=
 =?us-ascii?Q?sjiwtzMxt/tMSjuoakpI+QOGwL8oASaTPi8X9fAwSS72+gkGxK9YvYOUqory?=
 =?us-ascii?Q?VZDTTDdmMJBanyRbxfSqW11Vx3Gk+cEr1VGEZ5c13a5D5Ly3WKLdRXvcXzIV?=
 =?us-ascii?Q?2ZJAmdCEBoB8AppcPW4CuqF0+vC086LWMtz6P1yfGy8a4l5SqjuxhBETE/0j?=
 =?us-ascii?Q?gNEYLrJ9ZdvWFaQN4/VpH99H0l0EYXVKvJjn1/hzF67hWnGLbVget/R2mP5V?=
 =?us-ascii?Q?rK+djhiZmnszwHk93rMzX/pEwy9kIQXshDFGhA7AOyxNv3RrVmloB2pv3Bi0?=
 =?us-ascii?Q?QPVeiOBJuFPGgWYZKJvh8PNpk/3/VvvS05BCQsHBapiLqMq0b819xlDFn57J?=
 =?us-ascii?Q?r9anViC4fNULlFXjieuUyztsKwwjjShLOq8FziyQ1UW5uqYNX9KybafKQB4U?=
 =?us-ascii?Q?+dw1SMT3afQK1BQHCof0LCs6k59z7mSG4orjpY4bl51lgFugHxf/bsO8Y4jB?=
 =?us-ascii?Q?zzQhH2qHmI3WlxJuF7vE4gfq0yQvk523hynphxWXNCjx5BqflolFGTcvSBWf?=
 =?us-ascii?Q?0MBiXtK4M6mOxp/n/OMtgQ+YOIdFxHQWCwAtCYTabk7QfYBqmR56WJmMYiRW?=
 =?us-ascii?Q?bKf9dIGb+1HDL5XCByM3hMo2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2SMGM/aA9eV/UFSCYU31O/dWV08mEgAqbDBVjZk3CZIo9vAddq6YATD92DsI?=
 =?us-ascii?Q?9YFERlSOP7Q0YWtMhy46utXp+4W9Uz3iN1Wg6/h1hQGqpiaG6oB4Z38odIT/?=
 =?us-ascii?Q?vUUYNMi2NrY8nO9sNTvCnI9LVeudCT/W/YuSGdWpr1qT2bWo8VwPCajMOVNs?=
 =?us-ascii?Q?Psng56u8QlxPPq9SoCLs64x80iCRiyZgelCWmcKnWbxhVISxNxHH7ToRRCNW?=
 =?us-ascii?Q?Q8towU4DKmAKxf6VCp6TmdEUYsUsCt4fH30Nz9jKNQOoJ9C/MhUbbY0vToYp?=
 =?us-ascii?Q?O2Lf856gVzqKOCcy+Shiy+7B4kf6mHPUh8CiGH4DyQaaTkJ2RMu4mlIiPV3b?=
 =?us-ascii?Q?u1AdJq/IyWhX0qndd686VjFJ9r5Jy9gjLemRMpdZcGmQBjNVdNscnz6CV2zg?=
 =?us-ascii?Q?B5Bvq32EvgkQ7/oi4V1BS51t50ooDqnNkN695XeUlxahsLILPJAiGDxYQGud?=
 =?us-ascii?Q?hgftgoVFIz7hE9ZaxECn09IKZ5iRnVMmh7qpt5STRllVlPbXedx4Uwve/m70?=
 =?us-ascii?Q?tX8NqIdueMg/5xy6Yr5FIM4Hv5zsxifNi1R54SKmy6IGO5UR4BUVbusT586K?=
 =?us-ascii?Q?b/H+34CooLqaD7ZwnnkLtv00Nlhi/yLvXfI7mq8jY3nbJ+Bu8lhjbgVyLUMf?=
 =?us-ascii?Q?eN1Mr7tV2j3+m3yPw3gnsHwF7E1KfzVY3PS4TuhNFMB7aAI36HeXTXn6U8bD?=
 =?us-ascii?Q?gTSNgbk/E530GYhpKtyHFpk3yol+XQh+1+sgg6ov0CDFrux2IX5NyWIwaJzR?=
 =?us-ascii?Q?fKYGUUy78MqokuYXO0asiMJEV1RuqlG9z5bn3G6hccVdRT25dCp4YqD+KckY?=
 =?us-ascii?Q?WkXn6cTokExVJz0jwXrBa/9g0t1iKh+71rba2D62DzTHpG2o8eOhFLUy0wT2?=
 =?us-ascii?Q?Ge4eVabZs2ojeeUq4a0c9lIj6PXmrOEm3+TKG9rHHL9sYZohaiZFS6cbyZDo?=
 =?us-ascii?Q?PoncDZL7PvdkNl2nTbn3VYFI6d5ViaehVwVmYlktfW5LfgtiXSeMO8uVVUDC?=
 =?us-ascii?Q?qt/YxR6mvfdrFdrIgRg30SyFWz5JPjravB9lGUvCAOMSIPblV3FdBXjQ9dXl?=
 =?us-ascii?Q?espnHTCWyay3hbJcaooVLXIA9YDqLdcjcnCRdsWPVkhXw4+R/0jGsMhm/BQe?=
 =?us-ascii?Q?MDqmBylKAeHvwD8booV2/k6UPMem5AOOQuT9Ruia6CELikNqm0FICGi/UACK?=
 =?us-ascii?Q?UGhPGGLKcxW9UgzBKQUTNqJ2wJLa3GYTkiXTbuV7arTTfy2rCRH3EtT4K3/B?=
 =?us-ascii?Q?BMPd72GMB0R8qFbt7BSP5ysCLs5LsYs1CECQeWkR+WcTP0pW0g1RGzDkdMUj?=
 =?us-ascii?Q?AQmsFPqG8AG/coUfNhbO9z0TUquOG9Q5uNLo28US6hSZUvQqlvrNWmX1bbdm?=
 =?us-ascii?Q?dte3wKuIGDLjT5X4DdRIr/wgBYTSfNgxbeuBHYp6PRYEcx2AvAzuJh9wvTDw?=
 =?us-ascii?Q?sY6ftL6qVp1hilvPOyIrGSPYjzk1ZnJAi/sDFueS0WMGxG1hAuNKDBn3ez+Y?=
 =?us-ascii?Q?b2fOLodMCZOk1hQM1zYXF0IFLiXe4wVzMGV4tIJIpB+JZcOZy7R8bh6rs62U?=
 =?us-ascii?Q?QL4kGO9ZcMiTLyGqq5M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee7f5ef-bf68-474b-ae36-08dcf8330437
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:01:57.9685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94RW1DOYW/i7MGUjCFmlDzFW2RmF7bSma0aRfqt/EDBp3VZd2OU/sE7gUHSiKIun
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

On Fri, Oct 25, 2024 at 04:50:33PM -0700, Nicolin Chen wrote:
> A vIOMMU-based hwpt_nested requires a cache invalidation op too, either
> using the one in iommu_domain_ops or the one in viommu_ops. Enforce that
> upon the allocated hwpt_nested.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

