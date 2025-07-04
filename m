Return-Path: <linux-kselftest+bounces-36561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08348AF93AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5A83A9E29
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518EC2F949F;
	Fri,  4 Jul 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="To/znWeD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D912D9488;
	Fri,  4 Jul 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634527; cv=fail; b=Bz/AMHA8GnqPTnBG24bvg2EM8tzusby8FoXYnb0RcBscOYrVm+OkYluTff+js785y64R0mUJsJ3RQzJNEaNWg+VpSqzaCkGc91V3C0WnTpJGq7istvfm8dmWftA1HqW3iPgoGNit6otxbymMB5CG0KboZILX690OTB15qn2DyZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634527; c=relaxed/simple;
	bh=s++yS0TMf3aC+AbO2nd9S1leXDYRVHJjzuEvdsjvkyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=En/ELAui28ttCBXJn67PLF6WpfUjOm0tI8a7BtgAMUErHamjFSj959KtECjGz31XiNkQP6T7XxwtEogNvWig/yQbLNrf+0wgrm3lfsyT6w/JPp1JZDKVMPLgDczQPwdlOKCgxIARmFSgOfEi4H9IelbGFrMPsDlrBylOXlRWg3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=To/znWeD; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX0XnpoCmXN5s2sKjdEovixpt8MPVyTULSyur6/xAOsJO9LXPllvhMID9YSLXastSvMfx4iAYXcVhNA/OlQh7JKOuhYeptOGuw9qziqKET7ts18H1231jIRc/G8K8QN/i7rYUR+dfvTXoSzBnz6bvDib2ok8Z26nLy9nYT5B0zTPU0LcJcXlDbOPwV/92BX1YGiFreGK7e08oyv0+UjsL8DYpcajMTvK0CSzHMIRVDDvIVcZUPKKSEzzuMiv7KFoTWy6UT0jC3Pid4Yo0EMOBJLsjioeKeizMWjhPdFoMkN24xGW1oalF9VAQwyEuIK3hOgQ0xL8zoiyrJYUfmeoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvGW0hVqpKHJInP5gUo4+p+YB4x0sEAz3okhUKxq1LY=;
 b=PCP8pb/+UV6HM9V2aAeoP1DrjRu6TJzo5vHNma3FgXYIgi3qYJJG6TH0IwEmfsXqQtIcil1SfPm7ztrl52IGVkpiuVvn5lbnMLlutWhU1fkYDwudadRTr7ZlEtUWSSJgFWzE60ZLNVkYCwvGTy00QaxIE0krj26IT31XXApJq1M8yTbU/sSGdHYnZN4NxvOnqa964++sHOf5YAC9LDVHqlzNf8URurX9bbis/V/hHBniM3YVGNDezWlT8ZxWPt3v7iqASeX0w0QyhLpef54mDmyOP4jKw8JE1bKuJWPGx8PPlyYE/vlKY79FrPFWliZ3yhJavQgliphqxkyg5p3J6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvGW0hVqpKHJInP5gUo4+p+YB4x0sEAz3okhUKxq1LY=;
 b=To/znWeDqOpBgJ5R25jLe5Au+T92hyHbBWwhHxUQ8DSrzfbElLSBS1PjQTkZSWHubkfSn5B6QQIyACjHzjpUjhqiISvfLc1Fz4y6TDpRsXQSKjelKbuVJA+iTxDLn+GoLu4KQWoxC0CQkmeRwtX5e43NfpP5dZuKc3xWg4sDFgS0h2rB+ewYoqLZ0Jh5maO52p4jgkVA6x4db9vP8xUIuALokzHWGtPOmGkIucy5Qm79+UXuF4a27uixZL5tI/JFLs91AhdA+/4r/xkX5ZLARErp6QoBnoQxV5uxXMJojFafnNbcuS7w9f4HMBEHzb49XR4kyySfWILEqLerfbepNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 4 Jul
 2025 13:08:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 13:08:41 +0000
Date: Fri, 4 Jul 2025 10:08:39 -0300
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
Subject: Re: [PATCH v7 09/28] iommufd/access: Add internal APIs for HW queue
 to use
Message-ID: <20250704130839.GP1209783@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <77c6f6ddbcb32c83487d0ee58993726bb92671ed.1750966133.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c6f6ddbcb32c83487d0ee58993726bb92671ed.1750966133.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SA1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d83eae-8853-4ada-df0c-08ddbafbe5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ulXCDmneomPPVJM1UzQBoowviUQiPplkOlIcnMdc8ZxIZ4BfFzf+Lo+B7h08?=
 =?us-ascii?Q?+J6/bQKlBj2wccvWFOuzn0N8WCZiNorIUGp4xOfXKKgbzJ+hIev00Plcky9B?=
 =?us-ascii?Q?7MjHmehqjpVGPnpqQr4ifBSgMabC0TemyBlqdEUWuFaY24Z+SDwvp7yOspoi?=
 =?us-ascii?Q?6SjOiTTrV5yAui3VydJO7/pfoaFpC8cE9T3Bj9Xhx3RE0z4P9gMiUYgA+u2u?=
 =?us-ascii?Q?lNANJHdEzkFbLR+eJqPIwEHox1DbGpHHGsq1D88yDYkwP8eY/ctQJhQK7gtE?=
 =?us-ascii?Q?l6NuOdMSPRpMdofk4hJkZPPh8Yhj3mdO93fRyyo12bR/KNsOEB6u5iyGGZTK?=
 =?us-ascii?Q?23mCYmGAnWb5YMOrEwtJc5r1r5IIq6s7T414SddWKmVG6d8RdKfZ87vb+kzs?=
 =?us-ascii?Q?0E8rwzD9/JgYq6MVCbGeK4nXjcQdNe+B37MfTCzNlCxekEusLm/tYYIXBBpK?=
 =?us-ascii?Q?hYTaH7qLVilGSgYlSCtv+ECIsxhkpWTzrJgg8LAS7AVqhuYpDy8eG6k9Z3/5?=
 =?us-ascii?Q?ZEMRjAwAM7JE+nFh6HbV8uqcK9Q/+i0H19VagXdB/5JMVQTktj2hDNLrzbgs?=
 =?us-ascii?Q?yCbgTzYrMyZUhSQTuXHdLMPijkZezh66qPAqthP5ssD6i6LU45d9aDKerDWh?=
 =?us-ascii?Q?T3qa3iN0AvO9RlqZmL647MSTX8OqkgWmUlXpccaIEtSO0uMIuNwQh80te4om?=
 =?us-ascii?Q?fZ1dR26pMxI0hCy97I/wToN7vVACZQtcnA0wYG202zAmuu123x11q+y0XYbz?=
 =?us-ascii?Q?Lf4tNSCTzyvQoU+5XnL7b4Eb/5vczAyjmeisbzORYHm6A6UadUW85PjgrsE1?=
 =?us-ascii?Q?j9Ox0zdLasBIqQ129ZhQcxKMjCTkGpx4bzpppKHCpjd8iOi9bsDQ+34iqiUo?=
 =?us-ascii?Q?gfULhF+ZKQ9GSrMGd1fzNJVa2/Qt6gm7TDeGJ/L64v32kRgkXOzVYiKrWXd2?=
 =?us-ascii?Q?bb8KtM6pWe+dvJH/N/5v3AgOHmfGo5dgrS31xvjnqtcv4xhcickmDW1TCa3z?=
 =?us-ascii?Q?G7wnnMHk1iQoPk7PtqpNjK8mHdVCKECW9mRltY5zuYS77mVtILhvWCKiVSin?=
 =?us-ascii?Q?VG2pE3B0Jag87nC8tWVZA+lqAm3rRNlSmHRQPfXTnf4G9/NVXHUHWnegj0wZ?=
 =?us-ascii?Q?mW5aEbMYhUTLJbIeIaSYnVOiz2GvaiKbCHYJFfdZCtVM6iywPmDnm2WYGyQI?=
 =?us-ascii?Q?ZXtmOF4IfYgKiOZ6nUum9nJpIzNmn5ZE746xZwDTLbyZy+GZRArKqvQl99yI?=
 =?us-ascii?Q?N+xqcemQblcDS63bOfReYQ9vmFqIQzHIlncL0cXch3aXTcsyQd6ar3Df10ZT?=
 =?us-ascii?Q?yhC4C7tgs17dY12v7XwewoMYSRKCCNrePGKYN7YwzuL/ClbamlL58zevvfaH?=
 =?us-ascii?Q?StexaQDvFTmi/YbecqAHPOqDaUb4M39/20oRSq2Q+AAfrWNNPYwOdebFUcCY?=
 =?us-ascii?Q?y++1BCMtV5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iDi7srQryTdPVtdriGdO5l0C+XTZmkbXrwLbpDXs1aOyxOJmMBYRBcajeyO2?=
 =?us-ascii?Q?yaoeThY225KfIpRkhvPd2stMqr+QQdlvS6xssUPaWYOQMo9YIHR29VpVJ6HS?=
 =?us-ascii?Q?aS57BRIhqHa8vDqa0grftRjkGfkSBOQv3I56K0CM6Ll6/qsqRe7cgoSmECjW?=
 =?us-ascii?Q?usg2DpYXTkL26IZJ9wmV+4SPSOCRd+LoLsrD9hXK+NYZj8MAHtj/raiHAiyn?=
 =?us-ascii?Q?212iygTywJdb1lBLuU+HnXKmnOUhi1cDJhecafGt/6Fx+1AQnbvz5W34BO/e?=
 =?us-ascii?Q?QwFtqoxZQZVaJXP/QmwkTU5iL5LC7fN530CsOJatl5PLABuHH8XRczqYwHQG?=
 =?us-ascii?Q?Km1Jni79LhVzokjpKHBel6tVtoQH3VcieDUOvdBH6MytIGt79KWKJGhGL1k9?=
 =?us-ascii?Q?JUkQA6CgfyM+qkNTe/sgOEhdQDHzD33U0g5ZRQiXFrD+aSUFikSwNC2F30Ut?=
 =?us-ascii?Q?O8wFw5X0jpafqwFy7kXcLjCh06RNfc4UZ7c68GsVGA5fdj1v5dunX/T8O6VL?=
 =?us-ascii?Q?KOzODipElITSrIkp6jDqAQP4WHYXb0nr7Banu2WNvWt/Y0lXpWGxsSst3+fc?=
 =?us-ascii?Q?Dj7pRpVzsxOmpw5Jy+vT8FrSomkpjZM26c9WCKA2FDHfeqLB0vVvYOP7Hgow?=
 =?us-ascii?Q?RdGoBE/fiWpsbJwGTvgKKZOAYAdG+yyde2a0uhqvPeXPULTFILDQmzyvieED?=
 =?us-ascii?Q?nYEPdyqJyMFhNK1PChCJcNnPngEr5YKUVvEXgvhdPvGVZvszpYyEWjy37ypE?=
 =?us-ascii?Q?RY94gYzutI3I3U7ox8dClob7Lh5vfuQz1KM/l3KT8pYa3ClrsBo1fhR1VnNa?=
 =?us-ascii?Q?tll9PCrt5IcXT/ginGnvvMDI1iEwjxdTzlZTUIA8icZ4SSY8JaZIGw16qOMW?=
 =?us-ascii?Q?AsQFdpPiRwbpftmnPW86b2xc0qwPAFvl4assqmiNYlvGR1aBh28tywW4V/hi?=
 =?us-ascii?Q?64771+fkViF9HKY74KixUIROVlBlaHE41fU+btqGCtJ+lSXOraxNrcB7dO9a?=
 =?us-ascii?Q?dQv/BWMTcYL+aoJWHhik0+rCKDu2AqhvZLCVa/IFcCZk+moo9RnAl5tveLsZ?=
 =?us-ascii?Q?Tim6Uj5dOgL64egOiNwP4R4gNzxFhe6uuqpz4UemcYHBwnspEEOUXhav3/t6?=
 =?us-ascii?Q?XhG0SGgnvaFxqSF+fzW4BVPxbT6pEUYl3cknRwycli3ZaskPeNs0DkXQ4r1N?=
 =?us-ascii?Q?H6Tl3/aNVQNKATBhbB7BdfRJnalnlvOSW17R//7ySeFvT28MziR4mmfKcJQf?=
 =?us-ascii?Q?WbWIOak7cEcRYr0yuqnYd+aUKKSNnNYD58mr2kfoCZ/d91QXrhEgZ2CqDZaN?=
 =?us-ascii?Q?R81NFXtabfJP497hSmAJ9Il5UDp3vptApCokJS6nY9bx3vyN2U+9tzh9PE2R?=
 =?us-ascii?Q?EdZVV2fF012ti9VQAatZjw3blhK/Cx3iWWF2UPDUXpjzpaEbLvMMl9VaKyjt?=
 =?us-ascii?Q?PkOKL2lCx8lFfHI4zt1L49lUDmYZKSJPu2ZPtVeg6k7PSrvcnTWJb4wrzKX/?=
 =?us-ascii?Q?mva5xf+qF2QWPk3oxdp6PYAhTZrxdhSFXiaTq13z41u3ve4btIzt5NAmkLWF?=
 =?us-ascii?Q?7DFpaXuMIeASdTgUtyiMdFjFEis07izAevylEqNw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d83eae-8853-4ada-df0c-08ddbafbe5d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 13:08:41.6115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJgwPfA7cxbOK/YUzbDaCQYSRlkigNnQfpqlF/BYzTv3paQA2oUyLZRJ8wWUwvar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689

On Thu, Jun 26, 2025 at 12:34:40PM -0700, Nicolin Chen wrote:
> The new HW queue object, as an internal iommufd object, wants to reuse the
> struct iommufd_access to pin some iova range in the iopt.
> 
> However, an access generally takes the refcount of an ictx. So, in such an
> internal case, a deadlock could happen when the release of the ictx has to
> wait for the release of the access first when releasing a hw_queue object,
> which could wait for the release of the ictx that is refcounted:
>     ictx --releases--> hw_queue --releases--> access
>       ^                                         |
>       |_________________releases________________v
> 
> To address this, add a set of lightweight internal APIs to unlink the ictx
> and the access, i.e. no ictx refcounting by the access:
>     ictx --releases--> hw_queue --releases--> access
> 
> Then, there's no point in setting the access->ictx. So simply define !ictx
> as an flag for an internal use and add an inline helper.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++
>  drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++++++----
>  2 files changed, 73 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

