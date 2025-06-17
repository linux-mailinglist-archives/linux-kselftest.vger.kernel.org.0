Return-Path: <linux-kselftest+bounces-35204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90950ADCA10
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50CCC7AA138
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC52E06E8;
	Tue, 17 Jun 2025 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRAGe6Sy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEDE2E06D6;
	Tue, 17 Jun 2025 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161321; cv=fail; b=OOk3WjKqN1NNTx/6FMyRNroQHpNEC9r0Ujt+OGF/Nywm2AIs1Dso5WnLlno0JiVysRVPE5cON1Ffy8UkvLc7TMhC1EapqEsHGZd02yxpitcHCIAZF7VtDL7TUV/XXb9RlPkTlAwTN4Q8GRs2zhfBrTCKFwUDnAw7Hny4rix/EuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161321; c=relaxed/simple;
	bh=8lvXJ2XOimTfo3OzzhenSrG9hL7QwQHXk9OIKm4o3DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kLmYuHgYkp4deFgrh7Wskx9scY3WrmUfaFUx1AgS64sKZZPn0K7LgTMxwDPXfizdBdjrbabcvVdy0pfaPMOL26hZDV5KDn9Y+7qt7EYHD+9/O25sp+YF0dIfilSu9Y0Hr6OGtEPKbHJmPPT+vzqLLI0LCk2bzc6LbTQCjNP89GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRAGe6Sy; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg/lNEcJnR5mklRfrf8GhUhYETcM8ZRFOqcpatNG+dZmOtr6z5l9L0aDvAPjPo8xhHXR40oB9AZ09KlSTucf0HwwMsadqEoSKhvTzET6khmwb44pl2JOuF3xnDf2Y0qkUPPUlRljT/23IjcWIs97zFIOKGJl5yOTEf1r5WF6MV/+NB61qljrRwLLrXYrIW88AYwh6mEIFz3AORHL30XJRKHeSqzWPfCeqReak+7FRBrWDJXKoWRpt+XTLIf4UYNGfsUiwbtQzeyIfArp0iD471CcyMTelxjSHmkR9bCXFlrX8Ghn47ImkKhI1nleXAYH3JtdpPzD9AckQmTHeW4fEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4L0wrXd1+kos8fqkAcKtNV3cV/s6K8YU9ceeN8uX30=;
 b=biR5pLI4yKwY+YdOLyJg25UUWVXKGiH2me3vnQP6DwlMYSsz1clUFcFll/uH0PpvQG0c3/u5jxopNNwVaSAXBMNPUtkCrQStzK/w5eNSUx5+hbVSCcz1Qu1SVbi42qQW/Nj/q2V2O7SfnElQSq0wuehOqQSoE0Bk6UcAK9kmkyMFslpJeco9VP11iUt44K5uXpQ4FJi9SsP05x/r87r6WQVjwLFlt46fO5q8O+z6nykh/BYemMZkMYIww2BiR4SuMsszPR6yM35VrKtKtBGbAN2QS2TD3hYRmDrdM0ItUkfS4qMmN+ypZZN9SqrZcnUfCWZfobWstb03Yy3B6UFizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4L0wrXd1+kos8fqkAcKtNV3cV/s6K8YU9ceeN8uX30=;
 b=GRAGe6SyPouIbUORZ6NwOCoXlHcau9N1q/Cpe+lQeseJBPeyVLeg/geIYr3OmOfoA8BwsPOP8DG64j2012AX+gLrjvPGkzfZg3MmiKuFPYjwNE/pFCooOVCWd2uulU7wtY2gupdV7cD2g4lFBTWKBTsXZ5MMDdN+t20yGYqATA3F2dYPUEx8jPTWZFaT+mgVI8RbUQ0P29NvydFrbXTvRKviOVzBg6imw3bC/y9Z+4AV/js9Zf+w3VPVHUkXOrR5tkZx8OEkhS4ldbPe4ve7z4iKCOrXhd8nD1hdqGpkon80LMUkJs30OuI90rAG5Ru5oFiRpzRlqZlfCic2NAsjNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 11:55:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 11:55:16 +0000
Date: Tue, 17 Jun 2025 08:55:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org
Subject: Re: [PATCH v6 07/25] iommufd/access: Add internal APIs for HW queue
 to use
Message-ID: <20250617115515.GT1174925@nvidia.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <64145b184a0fa7c9b60532c9b475a51625edb77c.1749884998.git.nicolinc@nvidia.com>
 <20250616133719.GC1174925@nvidia.com>
 <aFDSNYOTToFSbFA2@nvidia.com>
 <c3842cc4-f057-4ab6-b0bd-f7742ca7c645@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3842cc4-f057-4ab6-b0bd-f7742ca7c645@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fdabdb-5080-43f6-2687-08ddad95d353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?toS15LBrcXHxB8PNJpKZyc/Ja6kkn6g9Ma7gJcsAuXlV11W6/DsoMLx4Shnb?=
 =?us-ascii?Q?Frpq/GfbSuzYLl5tnZ3/EiNCznCYRLp1SLNAjNjfgLZC0Z/32SrsSc/HIMuJ?=
 =?us-ascii?Q?+FyNENu10rl3eVWgsOVEPnvqYdGurNtrodv5sZjzny5osWMQio335b7I3yz4?=
 =?us-ascii?Q?k3wUbCAG8jI7KZfbbyF07Gn8XyCu9IpgaYhR8XdVIm5u4mffU7yfLY57/oZP?=
 =?us-ascii?Q?oswUWpMa4DLhwvQPV8RGEvI+5v6TE8kUP4evTKSBhQukTAT9PyASlK6k6mnx?=
 =?us-ascii?Q?q9p7uTzKXQewyWpg+W566rDBlMyX6wuNh3xkk/xFBHpNQAtOy70S36hp2k55?=
 =?us-ascii?Q?56Dsv3qiAu1CfGWnNctB4uOPG3BCVdEkuOp0x7HJmEeWnAusWblSURsjsig5?=
 =?us-ascii?Q?dLYD9jITY6pTv+/h41ava2jIgr0n6vm8GQCqqp5uEOO5mHHRb3Tr0JtL4gra?=
 =?us-ascii?Q?P5TGfJptzp8tiXQ8H0YIibjSnwQHVBy2HJxU6AI1eYw57MrNELvJpKMqpIZ4?=
 =?us-ascii?Q?xVVrKinkM2daCCX6hWLbL6T6tcxiRIRQqDJka8ByHU4bSbWd4QRDL9QOq/hZ?=
 =?us-ascii?Q?4/p6ZEuzJWIDyjv5jytkLq42z4A/cHs5MfHhGO+B+5ZG1pIKsYvBlPCiq4OM?=
 =?us-ascii?Q?bhlYZz7xH2FLCPM9j/RBy85G4qo3N/HF8z6dQ7Va2XEDO7SVUrHmQ7NbcjD8?=
 =?us-ascii?Q?kVMjKjXOYlDn++3U3f28QYxcOPdIVxFx26cRTT6LjIbTGXkoudN3UfJUt6Ep?=
 =?us-ascii?Q?Yl/41hbChoT7Nawik61YXkCLUqv9qkGcaZbyrXmBkD/+Aj5mpZWVCc4+AADC?=
 =?us-ascii?Q?NUoGe85hbRtwXaWBEAYe34kYZo2pEiWjWUpKUtPbtz28yjgua6pWZcMLvRKG?=
 =?us-ascii?Q?KPIusQ/SIxYDeZEsbueuBVuFgpnJPTIz3/Hl2EbAjCCpxVjgiG009VGolIMA?=
 =?us-ascii?Q?p5ldDFWpP+Vo0+IfivqukFxV1hxQsVMYZ51tLyNRCm8tSeW7Zj5+Qn/J6L3F?=
 =?us-ascii?Q?F9q3+VmmeevbFvwEAfVhc7eDqOCCze1zyAsbH202ScEUwTCMFnAk1ecneGGQ?=
 =?us-ascii?Q?Ob1QSMHdwKpklMXMHjLWKtvv0UnPxC3M9QJZdU5v/c8uPZviOOzlmFj97U2G?=
 =?us-ascii?Q?AlTlUJCvkf6y0YthEJHFFaiJy7P2gxZA7e0HNDHe6wjCsG4NY+eE42FIug0n?=
 =?us-ascii?Q?/1Fpx3ICIs1UCt/P0BDEg+EuplFytba4lROfOXtxeZn4DkiFczI1e0m+9uGG?=
 =?us-ascii?Q?pAAGIevA1Bvm8ez9zOclUZzzuF/MZx80ZwoBpN6CPlyA4kuk65Eg/1SfjeHI?=
 =?us-ascii?Q?YVQmkBM2km4SOrrw9wBLmTexKl7j5WC5+HXpUgYcy+rfIUg2rhH3iv93IRG9?=
 =?us-ascii?Q?5+bwZ/1UOxdND7kSOoA1grQ/AZlfy7ibQ12s8vWMwgFvbzelVzvPr7H3FFhr?=
 =?us-ascii?Q?BpTiXnUluhA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tr9yitB71SPQIeVBK0yzVJMuBKNfpiHP7TmfHxQK251aHhGMwtdu38dncnJI?=
 =?us-ascii?Q?ExOEP3vozVdzdVeEL3a/Yg/dUVF949QCxi3j/a3iTLuC3XDucQN4VkCdvVSe?=
 =?us-ascii?Q?nxFLI1vHzd1nbcdvJe2OOrPRpxx1Xq534jFeRz5kakRHYs0oMcg18y1fFmbt?=
 =?us-ascii?Q?NStraAF4ad12QQKwKuAdQCwi0FRp9Osun86uHvbz5PsvMnnVEpwKzEhtEwnD?=
 =?us-ascii?Q?o8wCgz8VDOWR1N/gyJr3sTDIJlnSkBqwf6lWdPdDOyGxs4XzkqWM5hA2xUUt?=
 =?us-ascii?Q?bgXAnUkxjOJP58RTWZjnx/D2yW7tlm5fF9NOGgIVUoV+fi3HxODK6EHAnRjO?=
 =?us-ascii?Q?yNFTa7Sv1+7u9gZ4DMwLfx8YerTfYqSWF0CRROkGXK+z3l6vkjqSzosx738S?=
 =?us-ascii?Q?excPfAASBBN41iyKc6w7g2QPuqLhWXc/pjxPGc/Hrn86np86WU5PU60Jflis?=
 =?us-ascii?Q?UanqgEyu6cfuBxgEe4661MfclxNUlDlSslhO64J3GBk+RGPr6MXoOPTPNQ53?=
 =?us-ascii?Q?oyJe1bwNnLwuNmPgeJ6neH32AyMfxhhOrNmo35sLsbh6Gwidg1/gLORTg2DI?=
 =?us-ascii?Q?/gHFk1n0XfEIt3w7s9l0UcOGsTxvBQdlrwFveJpWprhJmEj/fMI76QFfKVT6?=
 =?us-ascii?Q?9ukffNQ83iPBr76jrog33oFVCIvhqAefoeiMQMcbqklve+VatVp2mKJwl16W?=
 =?us-ascii?Q?Ocl8XSfDbOEXgOtL7NCsW3W+mRrMBuuZNQsNbjG3jFTpHzv5Oa8uqRyy5d42?=
 =?us-ascii?Q?eOg5/hRZkfaDlX6tIIegMfYy6Yh079VrUKh831+uTK1gzIUvBcDUMBYrYmAb?=
 =?us-ascii?Q?5lukykQt5zHxXTUIs8OEZRBeVJ6EsS7Q5lKp05D6B57PsyPwLfonDgXbkAzR?=
 =?us-ascii?Q?BcCjPpglgNox/xmWrbtIEkiaeY3Hp9lHWDUGmMhGnOEFack7LuJiTQZRPlIO?=
 =?us-ascii?Q?IWsGFtMwH2Ym4CFNzw2VfVvkg92ucelgs3jZPfSWd3qoV327/x3sjT/6/bRU?=
 =?us-ascii?Q?czaMj/JzKUJUuFE2XRAbIlWg/JSR5jpZQHwIdTr0a9Ds9z7OA4i5bkHPQAb8?=
 =?us-ascii?Q?HbHLmvg4i8qPuTOZkKoU5fNZjL+QZDMlQdJZci9xrtFNwnbjE6la/KjRgQGg?=
 =?us-ascii?Q?JV65jWMpENtlT6EIId3mTGvdAlfB6CMtlgWzY3jxgMUphTMPqC05udBWaYWn?=
 =?us-ascii?Q?yPQmz1ksr8xxBFDxCg81Du2zNPNa5N/ACKk4ltlU0hbyROa6csSyakgRD6ym?=
 =?us-ascii?Q?zKXFuuLu17hmt5kKXD882mF8/I9QRS0uqVJaq/j3b7EhjAXdTU19YsPxrnSz?=
 =?us-ascii?Q?WJkrHMVvYTeezlhUPFgHngdCIIvk/110K7WekDZkmzYXNqZWuBRGUa3ag9/S?=
 =?us-ascii?Q?3dFQOEGTKEENhyS/uIj7yqpllb8CDzSANrrm7M+eZK8dMs4GmZ+/psR5Y2GQ?=
 =?us-ascii?Q?J2zRIx3k7dc+eRBk+VPkr/YopcpwRL4zLaVAWjYo5b8OiGHXOpfyc7F5NEkj?=
 =?us-ascii?Q?ysX6tiuVcv6CDE/SLLvgTVWDCC8WD07iFszZ1wTsXJ7/OZJjpojTX56KfLsV?=
 =?us-ascii?Q?8GMEOvRB/TsrXq2xwxw8oMCfhlH6+kJ1ihY5HcCK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fdabdb-5080-43f6-2687-08ddad95d353
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 11:55:16.8320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX66gQVFTxQFRPV9BA9aX1L/smSZF6V1UyQqyDtXoc14C1tdOpSDSoUYacEnhxLr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175

On Tue, Jun 17, 2025 at 12:23:20PM +0800, Baolu Lu wrote:
> On 6/17/25 10:25, Nicolin Chen wrote:
> > > >   struct iommufd_eventq {
> > > >   	struct iommufd_object obj;
> > > >   	struct iommufd_ctx *ictx;
> > > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > > > index 9293722b9cff..ad33f1e41a24 100644
> > > > --- a/drivers/iommu/iommufd/device.c
> > > > +++ b/drivers/iommu/iommufd/device.c
> > > > @@ -1084,7 +1084,39 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
> > > >   	if (access->ioas)
> > > >   		WARN_ON(iommufd_access_change_ioas(access, NULL));
> > > >   	mutex_unlock(&access->ioas_lock);
> > > > -	iommufd_ctx_put(access->ictx);
> > > > +	if (access->ops)
> > > > +		iommufd_ctx_put(access->ictx);
> > > I was hoping we could null the ictx to signal internal? That didn't
> > > work out?
> > access->ictx should be NULL for internal. It should have been:
> > +	if (access->ictx)
> > +		iommufd_ctx_put(access->ictx);
> 
> access->ictx could be treated as user ownership token. If it's NULL,
> there is no user ownership, indicating it's owned by the kernel. This is
> the concept here?

Yes

Jason

