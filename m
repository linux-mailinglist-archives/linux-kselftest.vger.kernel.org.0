Return-Path: <linux-kselftest+bounces-21225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ACE9B7E97
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB4A1F2205B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109C1A00D2;
	Thu, 31 Oct 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fqqLTmY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624019E7EB;
	Thu, 31 Oct 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388852; cv=fail; b=gjID/r0AXV3f2QWGAvm19JFirAti5QWMPRfxkl/mnAg8YwQxRX+cvYC/BxH7J+1v1W/9Zu7VSbU4Rj/lMMKbP4wgST3vnjZ2NlJWG8rNuz9LTWWkCzIWqUEGARbnclT2x5RUiMYR7Y81XtKN8Lz1UucXN6OXTS6DqE4rSVBvTLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388852; c=relaxed/simple;
	bh=lr5u76eX21sqkxxyvB7WhN5m9V36h8WdHinjg6EM+hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+YJ3E8jop301o5HRGYhcqX3+izIhs7BK4nnjIOKch54LwXGI3lM1lWsbyv1RwoMzCxx6vnrhEMVTRSKtMwgfV3t8N9U5CH5gIvYyQM/9iKXZjs3uPQPXSTZxJ2zERGTQMrt9EnPmBjCIcxbPT/Gwvw+Qxf6n89rU7aPcpCzc/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fqqLTmY4; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFDo0WY9mEnsinPXLUd8/wYpvKIa80jGvjFm/MiGMqLjiT2NXyZnTzbV0V37mOO1kzvPcPaFC0effh4jFrI3+8q9uzyhc7O+4VIjCVCbo57zWe2xfe2ZKtJs6BaigsvBUYpYxy3gQL8tMNEEsC2RqJXOHDmKDAvr/QXzFgkIi81NiGbs3qUyWOXXsDsslbIm6VOfsfhqsfoyEDF4Ody34wPpQ7flRzQ1adD+sPjNBl5eskcX+FtK1F7RMHXVjivcGrOGDEJT+GwqQ/MvUtMURMCPutA/1nBYjeg8l/kQBHCVubs3ZvMYD2Y+fe8Uu9HeVoEUP/X4dR1fBwkdAmqu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqEOrOsVsfOcRl/5GyDFjn2zm0rzOxPsn6Poxp1FGlA=;
 b=NV0Doc5svE3x9hArmJfQ7SRgUmvJGk0sKGAN50sbGT7X1whbZZC5uddv+KW9B+MA4VJaVn5Aw1211oaiESkHvpwLjEXIzBOXe/+A02aUQYJDZTpo5DOiBIUIMLB6vfAfmX/Lw9Ax/gGijCJ+j0HobvIp9tVoHKvANKKf9pCQu40jbUOpfhnDL7uw1pJULqdxadXKqEpHShFOx659yNlXbjCFhd/rr3gb/JtzLkGewstBU01KNPSGViHhyUpgJGB+z57+l/dLDtrhmrxk3CGa6ob6cySrO9d/zmjnPlO0olaR1ngrFUzL54QTJvJmCBLdJLWdjctFU/q4LjZIKjEGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqEOrOsVsfOcRl/5GyDFjn2zm0rzOxPsn6Poxp1FGlA=;
 b=fqqLTmY4XO4l+mzrFnoSwtNHEyXNJ0SdSoGhC4NnPxa28x6p5+c3QVzDAjtNpBvLlrYNP2R9GJFna+rMnbpQIDtR8EELQf/VzIIbH0FkQ+SHRiHZlydQis2d5Lg9529Aai7gOe5wliKvqqixRNw+/DWHR4ohKHroZWQ7EJd5TdhntDnupHlYm7nrEiN3hsJ5RmGzM3VwoTjJwkwvTCpp7PKyiBdqXpu22nN/KJ8IhZWmjwMd/NaExvmlYo4TqVMKMEWEEm/+xrXXBBnN8XQtkZbZQ2IHK2SdXeGrIYTk0miAl/gTn2GIABLgvjq+56e+54tVy0VelsMA8gRaDYp9Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 15:34:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 15:34:02 +0000
Date: Thu, 31 Oct 2024 12:34:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 08/10] iommufd/selftest: Add
 IOMMU_TEST_OP_DEV_CHECK_CACHE test command
Message-ID: <20241031153401.GO10193@nvidia.com>
References: <cover.1730313494.git.nicolinc@nvidia.com>
 <0f24485cbaa1b17335b8a785509c8a14c6f5989d.1730313494.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f24485cbaa1b17335b8a785509c8a14c6f5989d.1730313494.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf49430-da7a-48fe-ebe1-08dcf9c1721e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQEnwDbk+lDI+NseSRrfdgFqqjRgVS3p6WKZdsXGIkeOD+7fghKcYELe1UBe?=
 =?us-ascii?Q?w9YVSgh7Eao6XImK8y++hr+dD1vDUUQgelueCBtHekowoLcxh3oiFTrTAOi/?=
 =?us-ascii?Q?S6bTx726XrKoNbII7cF42fOw2dGNiHbnVM91Jxs9m23qgEW+gqrQR6xCrM0R?=
 =?us-ascii?Q?7Rmfk0wFVCKGqjkz6I1ztupjF+d8we0IoP5J4rhcEhwyoWi2yx1N1JGLdvMi?=
 =?us-ascii?Q?mvzsFO/tsqh/t6gYcYnMV+44W5DM6ZlFL5mEsolgzO4NfeItWKlDn4erwSrX?=
 =?us-ascii?Q?Qu4u7JCSfByjQBm1kBUPpgY0UGWBZkAXbmCqxYpDwwI1VOKJUEWJfDo2rq7L?=
 =?us-ascii?Q?qHGvhU3PlCL1M4SaehZVfNWomsgcDVIKp4v2ivTvWo1EpSMk1aQNPCPA3h7/?=
 =?us-ascii?Q?NTOHHhrybOGJWNFX5+5m10EtDnydK+g/XKhre7fvp0nejOqT+vHoW2Pwc62D?=
 =?us-ascii?Q?rVc3Mme+78oCeo4AgyjJHzzq0GtSgErrl2N/9DExrqtjnwE4krbssLv5ofnH?=
 =?us-ascii?Q?Mw7nxfrGTOKXR+YsxaIVFuR1x2zyxWU2mkKdCbwE4926qJyqCsTlSj+eZk+8?=
 =?us-ascii?Q?xesFzk6TW/yvrbWLvOUW+T1yRTZPhS/9Gi8e7xNeagl1bEnKSyRO1I0epDql?=
 =?us-ascii?Q?zbGn2G1yWPT8TOUWe4n/xJChEI6N0xSBzKjcwUKRIAleH3lOm7fXl+mn7uHv?=
 =?us-ascii?Q?Cb1j7GiEZ58QbR63ZJR/qVcJLos3fCUxvqrV7YmOdYcungly2mmc14lrFeyG?=
 =?us-ascii?Q?rdlLjlANW0SaE32Qb6JaB9W2I1WJeuQnDs/dGJVHe4uvufBKnGbZ6JXP3PPN?=
 =?us-ascii?Q?eyiS80GLup8346XrYnfysCD1Z8a8O5+ojJlSWpzsF6AhqFgv9zHWGv6ljIya?=
 =?us-ascii?Q?8MUKZrvn+vz6cBFnpgxAaqTiJE5XXvamArPibJywU5/E6jDGRfqEXgT5Q3bG?=
 =?us-ascii?Q?fjCCiKT9V4BjBMhPDUStpGpMGEALKElnttXVrhrgnypyKcaJ34uchdvFCmdc?=
 =?us-ascii?Q?LUnwHnHsfuv/DGmywCo7jGFQf8tyBt2NTBdLNvvxltL1YmT5OWDwMAmvY9ZD?=
 =?us-ascii?Q?ptrb+ScZR4WLvoD2KWiTUlfjQZ7mzV8Xq/+AbplSmWXgRVobZbc0djCt/YbQ?=
 =?us-ascii?Q?sVuKf1zxe5rm8kb2ZPWEsvCxN/HLkK+YeHwWlmqXDj+YdRc0nFg9QnjE97Wl?=
 =?us-ascii?Q?ZhLuYLGQjtTEOzG0KYf0MEt6FBX6Vde/hyFJRACYGckkgy7G8emrDMs5o70D?=
 =?us-ascii?Q?KCCm5qnqwuaHZRkjoTMSf/y8mrEdEkxljiOMa6Gp0JlVb/arArfC3IFGzYP7?=
 =?us-ascii?Q?2gwS9eWxz49LvWPiI6GkG8K7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PMVYezPiu8pcJdugNFnCfQgxRjQ257bNn2cZhx3tkO3tlcX5IQN2yPQBt+J0?=
 =?us-ascii?Q?2svH0Koclj6DR34cZX1DlC18YITXR6z1poH3Pnmzw0zDEvvpTiHqSwMu96SI?=
 =?us-ascii?Q?1r7Au0F/86rjQK3HMVDSCMunHf075bL42xNfng6parA4v240AqKhxQYwYVVH?=
 =?us-ascii?Q?IePwkLJjmrjU4ABwrN7pdLY64yWQ/J04rZ/xd+5DhFBbvfxWCjhf8A5WIpXZ?=
 =?us-ascii?Q?pxHbhQahDj2bybXdtPMb5vVSJA68BBeBW5aD8bkAJxS8NEL2CXY5DQKiZhfu?=
 =?us-ascii?Q?OwrYSu7B2RUsV4uKdo7rMXzZC35L28xNIPqvbgi9wrzYfO5y6RRHK4R/SV7g?=
 =?us-ascii?Q?9EMKi1Tmu8+vRSdU9WM4oD3sYFaqcHT0I+fz0yM4sUYUks2TfQz9W++qlEs0?=
 =?us-ascii?Q?L0AHDZfte1aF2jk8YmC+7h/W2v0KIrTQHxWc7rSU21sUgVo+Q6c+oPcCn77u?=
 =?us-ascii?Q?aSZ53qxwgCkD3IvNGrd3bYXAFvEMMPUJG3OhfO/Ih9OPh7AV0gwdUsgV+qY7?=
 =?us-ascii?Q?iD6+32NUDTL4pcrcZkqZ6HTrQGGV+3e/iKKcymiVxL5BUn9dX1g8wqQEUVds?=
 =?us-ascii?Q?PQ4y0sz5TgpeUtXrtHJPiMK2RdIRX0ZePMWRqFBFZbphvnO1PG/s3hSFii5l?=
 =?us-ascii?Q?Q/FcvLCAizuycKiNRxfgOQNGq+q9oo3TcDU7NplKltyT0Q5vSZcvL4C6381I?=
 =?us-ascii?Q?IXzvmxZqHhJhWdvLL2TM0XLQ+0bcWZwBipVu4g2hXqFRoech8PuP4PKXsRES?=
 =?us-ascii?Q?GBF6N7EhCUPU19dd7yLWtBTG3oYGg59blwlmZffsVzCnFdB/kBu9EfWh/SBn?=
 =?us-ascii?Q?nmDjGT/smsYjO7Ruj9fbWTn0ADxtUBvk5RXF9z1f83fnDUTCmDVUPcJ237hB?=
 =?us-ascii?Q?db2EEcFDLx2a9vuNRffmbNvkziuGbaqY3Egf3e6/sYXzm8WoNnAXUi2FgxYD?=
 =?us-ascii?Q?EfrF8Av3TQ2HLYdVKmLp67zpPcX3a88T40auwPVR2G8Fpg6MWn1uJFc3NYfG?=
 =?us-ascii?Q?xy8BBc/Rm71KRuT2q0+vx3TEZf7jp55gpTjDuKvMk9x52md1IsJXECjaFB4C?=
 =?us-ascii?Q?RhAxkQv8OnUN+JOZGDmjbP3QIeJcoTswXQ9t5Gf0Xc3cJEdjgoZuFmKk2nEo?=
 =?us-ascii?Q?+Z/xgAcrN0dnX6kxZmDxT3kqq7HYUlmT0v4fXnYtoJdLTSGhBFrX1MMnnydF?=
 =?us-ascii?Q?GoCthm5aw0nAdoA2npW7qLNsVmg5S2Xxrl5H72uNBIDyVTBx5si3oC5LsU+z?=
 =?us-ascii?Q?evWTAqL62jzBdrpNF1gIlZ8BTy25TGyHsaC/BDvA/3afwXpce6EUZ9YuzLHp?=
 =?us-ascii?Q?0+rj+mmPtTaEllPPqRCduCdgYr2oRbaZR5UvD05r3Z+sPctLck1iVfQ1x0PJ?=
 =?us-ascii?Q?Qk/XVkJOAvSdyIjH6mwJz+4Dte0wpqRclFtHWyWSjIVDOfCzXAYPA6Slq+tU?=
 =?us-ascii?Q?+7VGEmDm+ZWCf/mGHT8IG1V09m/GWjpIl1okuuNB7TCY5gmEdtpDiG/hiz1A?=
 =?us-ascii?Q?d7yMgwe7sdIcTuew/5F4A31X0ESpAlQgUclAsEG3A+0IJ05ObX/uncVn/EGg?=
 =?us-ascii?Q?kIfsSG4ckgSgRpjrTwrzgelcQf7t3qceaeG/wWat?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf49430-da7a-48fe-ebe1-08dcf9c1721e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:34:02.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jGaI58zmMLU5e9J11i8f8eWDAyYHhK6cLEY40Tfp5GvWQIO4C1SJ615PsT9/90L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

On Wed, Oct 30, 2024 at 02:35:34PM -0700, Nicolin Chen wrote:
> Similar to IOMMU_TEST_OP_MD_CHECK_IOTLB verifying a mock_domain's iotlb,
> IOMMU_TEST_OP_DEV_CHECK_CACHE will be used to verify a mock_dev's cache.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h          |  5 ++++
>  tools/testing/selftests/iommu/iommufd_utils.h | 24 +++++++++++++++++++
>  drivers/iommu/iommufd/selftest.c              | 22 +++++++++++++++++
>  tools/testing/selftests/iommu/iommufd.c       |  7 +++++-
>  4 files changed, 57 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

