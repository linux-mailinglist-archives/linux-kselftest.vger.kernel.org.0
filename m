Return-Path: <linux-kselftest+bounces-33952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F464AC6E7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8421BC7458
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28D28DF17;
	Wed, 28 May 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="komuO31N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051F28DF02;
	Wed, 28 May 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451399; cv=fail; b=m/y6e9Ka8mq4RYEock/mrxWG+VM+6BuAj+7O9cWLLyYxASZTj8P8b4UipcwuaWsOiqHev9FPk1C7467xYgXtUSYkkJlBQYnH7+Ac57WZyY9OERageUSZo1CeE7sfvxE8uaWcbkr1nI/Y3O3vfyf2ls6Nau6pvUfyQ9ltOKeihSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451399; c=relaxed/simple;
	bh=UiUgZEh+fa5eWYk5KPbcsZlGcA4TnDhpX/3YzklQKIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b3xA/sE4Gz7T6kK0cpCeR4cuytUbibBb13YwemUcwJBlHJ8KPPEosvSOdqB260EVUduByl2eKEEvSwo5zRGg9bJxqpulzQkAVLoBpcSFHLds70X0gSPuMlOWLcGDprTXGOgk04Yj/dh/YeV46h3ddpoPNa2+CT1RvH/RSj8w7S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=komuO31N; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVppH8huWMYn6HylT/KYxNyjM9oHREaS842pcz/Nfgb2kg/L5+winccbNk5+oZM+HetYOQEIPhpdjU5SuWQuVCXvp8YCsDcguOuus9GZsfCtryc7wB6AH5+5ngvmisPIAA3faRGCyReWsssc9m+F1sivVvZNZ1tIgNkVbb1Bzk8PoM/p9v4g252RI1MBWO+IySjkLQyHZdnh0VoAQXIYtgNAYA1TAx2NMS0LbHy88W+bh7cbf8Gnw15/56A3JglniZr1hr3DECxsExDIWLMuX/4BBPG1/rOGDMP3Kri2qJx84lz7vrE0xgnIhe5GQsWKuLfcpbLXloGLOk8T8qywSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZIWhq1y+lz5I9mobMgE/Ob3WfGmAyhHItG2DpdC1qI=;
 b=tL2gAmMIrhWcfRGBCfF5jewpJnbIsbzY/kFS4E0D+4DCNPh90Snto3ZQ/7UUshgBGm5/5k3MmfE6nxom6L0oN3GaQ5iIm8EbgNwmS6XO2zz99qF8nqRAgkSty3h3MCDwVpICvvrdc9zJGgB3iHBc8LJAS3OlOjAhn4lZG43umliipOsawBDLKJahb/t5+W5rAwPgqABI7wpSsakl8qiG455CDGWoqYEXb6P4XXDdUMeLARLbddCZdiOov9nwb+dnZLW/yxBIhtnCx55xX2gBdFK+F0gqYAnhZh3q554RdaLBbA4+l/N5ZoF67Z6ZXnLR4eANwp3E6oRFeyDBH60bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZIWhq1y+lz5I9mobMgE/Ob3WfGmAyhHItG2DpdC1qI=;
 b=komuO31NKsNSYqhEb6uaqm6imhl1Xt5pdHDbx0EVcJ5uCBALJr1YUpbCZOyhfiGK+pgIqPbcOn45rPYCexY7WHWAIU2FfUqrtMstlFW2+mSPVwdPWGRYQzhWt74fimjx6sqRVFeyLD/6Y7JDFYLmwV9jbUSk/yELSzfDZTCcD9Kxifs1niWZfLYCeROcmokXyOrGfKV7Yh3hrkbBXtQT0RMU6V8G7lOVYp61+ksy09F4DICjPklhCtKPtHrZyubFZm8yW7EAJNhJIlm+0XlEPetAMubLY/6DcSZ+oVhBetHPQntL/uACxX+BqB/zXbxfcd4kRbBZQ+gLlJzcqLMuIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 28 May
 2025 16:56:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:56:31 +0000
Date: Wed, 28 May 2025 13:56:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 02/29] iommufd: Introduce iommufd_object_alloc_ucmd
 helper
Message-ID: <20250528165630.GV61950@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <4cc3e95520bbade9004615d04fdf5624e0b2d51d.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc3e95520bbade9004615d04fdf5624e0b2d51d.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d40b41-dd1f-4d68-a44b-08dd9e0898c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AFzWZefCND2dI6DaL5Ujkecvp5QN2YIxPtROO1QEByE4IoaFXbgFcxgFKoSs?=
 =?us-ascii?Q?MG1+RBOittTAOdnmoVUri94F5cg/UcOxf7yvTx+8TK5cEe0zIhVqk13TtC+F?=
 =?us-ascii?Q?SwA3N7aUtv0VEws74eh00b8F7+CbswyKhL44Srnrz/Pkdp1cAHFEfZMiuqHW?=
 =?us-ascii?Q?IwJUxGYqXHgz1nUY9crobKyRK8wAfFYor6LO4o+p8ZcStzM17Xt8F1jUDjQk?=
 =?us-ascii?Q?gDD0oYLuYLc/JK2krCHBRAn+KqU7YLxx8hUFk2K/5LpOKL6DMOeiDWqVsHyj?=
 =?us-ascii?Q?hpvjIE9/HdPKdT5MlyFyGHWtCZveK4b70IBJQOcu6+9GbAn/arj0Vezx1s7V?=
 =?us-ascii?Q?fOH/D9QSFDjh1mY4uIadL6VuU0o7z+trPflY6TVY6mDo9uCgSW67R6tdjmd0?=
 =?us-ascii?Q?LCGrLK23UsBQEEgX5wZZ7lr0pQr7zjQFooGSZCySbETh5exU/irosLxl5bim?=
 =?us-ascii?Q?XQyDmhjxkDdnZiAapcfceK5ReTSObq1SJ1a/ugepDesE7N5EzQteDmh/w2jz?=
 =?us-ascii?Q?jBORI4WNon82lLyihkfVxBEmRUEN/GGTVSsdOyVnooilQITaFHnqShMzbc2b?=
 =?us-ascii?Q?qBpbgPGS0qIuhpKtP/XZeEosdE/X+l6rVgjwjVa49c9Yr8Hgk8ChFcFmxdLu?=
 =?us-ascii?Q?5v312XF4kshYOXd3P3lhBUaqlNU4xX1g2OmTy6TvF9fDnz6dqoZKQZtQPezb?=
 =?us-ascii?Q?t4xKsCZatf79swNYDsmOKNT/x3XteaI9C5ToPdbSJeGNya7KPwtjSyVtGfTh?=
 =?us-ascii?Q?AoYgQdZ0+/NhYvDl8UoSNt3n9inKTjLuZOm3fJ4E6zelsfTNU+3iMh8sdOR5?=
 =?us-ascii?Q?tPBf/zfu/Qa71qdIUxwmqXmGsJ22gIA0qMyVLGN0iSs+VM7frLXyeAfgTgdT?=
 =?us-ascii?Q?OyEFJ2WZ59tVJhO2nnpC36caL66rMXQyF0S/XaVtZZieDbJUMl4g+dfXMiHr?=
 =?us-ascii?Q?73Uj3fQTMjg8cQ0zjORxY/cIx1veJ2qi+MirBNwa/sbNvxhUDyxeos3oCsZf?=
 =?us-ascii?Q?0JX0NoDM8MVyhvv+v9YvJEdtr7mhN8SiFn+tkIEFtyaVlSJ5EN8PDqC3csTW?=
 =?us-ascii?Q?6jPjCPnQJAvCppPpjWvnSLAh0TnqcQEe8DF0li61K5/v1NiEZRnSKvPgA8cb?=
 =?us-ascii?Q?06O3SYQcmPyrVb61mkxl9cFlEFgCLL7WGOINS2oK7qAA3YGxiQIZdU8AWsiL?=
 =?us-ascii?Q?aGeocvJpCQ73xjPlO46CxvbE4drZpkVsoArWsAQNUO3EtBkO9ar6MmHHvQAL?=
 =?us-ascii?Q?69Ix1IhfjCxn7LEToboiNbjYgtx2h9Rbm0CDCb0mw/D8zqTIAHGUav7o7xI3?=
 =?us-ascii?Q?1rdsdiJk3YAuWzGiBOkQJFqdZsFxXV1RnU+zGPcCtVdhMzz43sN3X0DpSodl?=
 =?us-ascii?Q?n8DR3ExgQfhX99rZ4qsl4yaf9rdDd4Bu7qHbxBhdE3Ng/FgqAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YjjS48yu1qXRzTwaVFaPkCOSg6yathI/AIg0LuI37zh1XtdrEBslxV4PcYG4?=
 =?us-ascii?Q?2sVXHnw36XQQulv9yTtYnQZMCGQPAeL6dyiS/6oeIlhVBdPbcpxE3lq7i77R?=
 =?us-ascii?Q?4WfPpzkpex3tg3J4/517y/00pBUZobPB5BcJ+Qg8jCUTeuiB+7PsNUl3h5Dz?=
 =?us-ascii?Q?mYqW8SES/XEkXq4N8TEFnHPx1Oyyhlicpzr2DzY1FsbTbI9PUDwKZ6x6t+FQ?=
 =?us-ascii?Q?O+CQ/4lfaE2QMfDHzu7vXqxLZPLlM0saWn6yHOz2q8X0CSY4XQTdImgNJ3bR?=
 =?us-ascii?Q?MLoNAbJy3maxYtoyIStsPX2vVHl/wGquJWCcDVkZLh7VsWbBlOq+VDMoc2RD?=
 =?us-ascii?Q?ERzh5Myw4wOqmzIR70qMv+ZFFq2t0jsQPQK9CZxlCdrz63GJNzp4WUVWlhKl?=
 =?us-ascii?Q?vs8PsIem5Yqrzsjza8UKr/TmY8H7jPEkwUa6u1DAr2WIhttvHmHL/Y5q79LP?=
 =?us-ascii?Q?oESPhI0FMHzhK0LUPWlpkftPNTHUtC+oI19D/JYIbkUfhrQ5Fx1t+a1HjdOm?=
 =?us-ascii?Q?wM6zbVhhyFRHtJ+gOFtT2q+oKWdOlCvyI3bUow+JrROQhawqfPo2bzzVc1tt?=
 =?us-ascii?Q?CvxxWmJSLyCEkp07Zfy31jdwnbMROyITMy++cYrjku+PqI8wFYT02BV3FknF?=
 =?us-ascii?Q?3p1bajmIGcra0TsFhqeTga6wTMkGlnIvv0j6kZxYgbVe4qPKSnwtcseCK+WT?=
 =?us-ascii?Q?90eNhgio9w2hhXSxhayJ3TOsxboNMotHm9M5A374Lwl3rACjpKney48OFoW0?=
 =?us-ascii?Q?Ws6zYlOR54mRhFf7dc7LhbMkN1X5mDbulwF5Gj4lBDuTSr04/69UeBjxEIJO?=
 =?us-ascii?Q?rrkyLIle6c96rDAz+xAt77u9+izJG1pwPchMJnbhSPi1yRZczvjx6aNfti+5?=
 =?us-ascii?Q?EMvUTaSkXG02G7PlB/XyuqxIpOgfQCDKd0g34Xe9Fegmdmu/1M3Ecaohawdk?=
 =?us-ascii?Q?5rLJE1/Zt7fSstGWs+4dXhZ9Si6CYvrwxKjbM2eMJL9ypTy+kA8gZ3T2LZh/?=
 =?us-ascii?Q?bT2nGRGJdzp88uF6sEQRq41s2IhtT0O9ICPb17WqVw6ul7U1qayJYqtWn/fD?=
 =?us-ascii?Q?fOjuTMrHHPtMd8mvh2egpLLGV7Ymph99Z+PD06rBhQcYEnN9kMPoPI2mIJhw?=
 =?us-ascii?Q?p9oce3Twh4PmaNi7yLp0yTQOX3qRlwxXEPtiQ3AANl47gOQAmq5tbedYl2zp?=
 =?us-ascii?Q?QubWCvq+WCw+6ANSyFI3c0zTyeNmkK+PSFR4H8w+5VyLQKSgzC3q1NkUTemw?=
 =?us-ascii?Q?4XA/T/Qs81TgJSbI8PF2VtgAM27eocgm7J0aOC/Y9s3ZBKNoh7tZYF3G6a8y?=
 =?us-ascii?Q?0q977mgg/OJuvYtmFH90fxpKCJ9JOiO8WjRN/p0X1NeAApwbAn6UviDjP6hq?=
 =?us-ascii?Q?xWN1Xlw2GwyGqSRVJsG5PbT5GyIrZPFQJL06zhejJeyVBJ0y+G9J1WdJGC/R?=
 =?us-ascii?Q?zr7ry93r4QHZqh1fmgODGS5u4ZLMgtCKi0Kw/73yg1xcze+dmdMm9LgLe5jq?=
 =?us-ascii?Q?WflTWwbbdwlG8HuplH7MgPRhUJA/rnDuC+oiatlnSsqD6jkq4wAebDnrO8t6?=
 =?us-ascii?Q?5nXXW3Own6AuwsbuFc9vKPEvKXxXIBOtDrBOgQcs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d40b41-dd1f-4d68-a44b-08dd9e0898c5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:56:31.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAH0kA4wTfNOO9iKVw7oC9vpXskcFvA9uT0KbBNn8A26C9pUESruAbfkRPEope8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

On Sat, May 17, 2025 at 08:21:19PM -0700, Nicolin Chen wrote:
> An object allocator needs to call either iommufd_object_finalize() upon a
> success or iommufd_object_abort_and_destroy() upon an error code.
> 
> To reduce duplication, store a new_obj in the struct iommufd_ucmd and call
> iommufd_object_finalize/iommufd_object_abort_and_destroy() accordingly in
> the main function.
> 
> This will also ease a driver-allocated object so that a driver can simply
> return with an error code to trigger an iommufd_object_abort_and_destroy()
> instead of doing an abort itself.
> 
> Similar to iommufd_object_alloc() and __iommufd_object_alloc(), add a pair
> of helpers: __iommufd_object_alloc_ucmd() and iommufd_object_alloc_ucmd().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  1 +
>  include/linux/iommufd.h                 | 23 +++++++++++++++++++++++
>  drivers/iommu/iommufd/driver.c          | 18 ++++++++++++++++++
>  drivers/iommu/iommufd/main.c            |  7 +++++++
>  4 files changed, 49 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

