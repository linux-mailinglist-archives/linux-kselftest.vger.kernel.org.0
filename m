Return-Path: <linux-kselftest+bounces-33951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA6AC6E73
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A1B1BC5695
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9F28DF10;
	Wed, 28 May 2025 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jP5+SbkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325628CF5D;
	Wed, 28 May 2025 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451338; cv=fail; b=Us4vVBszjKO4guY5EwoJHsXQ7S+fZl/dBf2kxRFaiLWyWl822pJhIH9kj0UGFIC+ZdrAiNbCL5G5Ripj4Ji32OkU+iUPcT/EuKFabThyHmlD55TORHjyR+8lqfbVAM+18QS+0a284RqB5N0kITrITjruB037w7NRG17qYfUKQYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451338; c=relaxed/simple;
	bh=taloB9+1OlBlqsdvKhxYejb/2cO8h/14CffAslBujB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BSeGckRWnkMkpMVvsAGaT5g4LICDAsXN0LrQqq1zRZ8QHgM+baqrMBg/n7xP9YYW6WmxlaRFrcjlf+sTp+bM/YDpuNLY59NDBvW3v2gFzV7imBylOGAFETbkYvWYEk+Qh/EosEoQ6iiOxrvkRsQUYUuZe9nOmMoxUwy1pdgBJn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jP5+SbkB; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSEqHU7euMoESY5eY7ATLvM+Uarz/B+XsxBANuIPPvyEsQwaLI60LdIAOhGNxilDY5s/wZmSp7b1sjkhYyw420fFXG7FGrRUQ4vEUv4ERe0UrKavlXK4qcRCwcrwEc1V1vnTXDyJoLQozhTIxa3wsMnkZYy+vtl9L9JVmWITOq0Grhsj9M61PwgOzHtZ2hmsxlmf2DmX+NR9KcMVPooqVbYRgppEbJv2JQyyh0K3OC5CihaJrcAkUkOcwK2fAl9ai746RJ6pn++x5rr+YiF/W7xbcZFzFWSGq3tAuvCLYpWrG937Si4j0NP9lfLB5DhxmAPqK4v1/hVrmpYAzgHFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBHirfjaKA9cKruKobnSbqVA+WyoU+/L6chqAy8M4qs=;
 b=Gxs0uygxMPqO68zEfXGdZd9+zN80u2hTgS5UZnOaGmZm5howSOVyK0RMKpro4lHkWO8C5Fo8aMMPeZ0tJ4IjAuvzVpU4ZsfiTMy4cNS7/wxZaxqZM+heTLbFsJNX4Pf/32OaJG0kDJ6eNEtmyD1KJwHqF/8eTySnN3WVSuMIfCU0h3x51VeLqTbmzy9rKr8r+N84fxmebZhDgEO4Ta2Fnv7yHxRNDV7Y5cTAQ7zxt8+w3cqVf+003ZTyOd7PvXNdkqjGUG8QLGd4vhe+oO58u2rQhc0rnSFIlQiFLLUcl23AZbey+Yd9mR42oBEep/N4Tpbjavv/UdMOCgbAAhgFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBHirfjaKA9cKruKobnSbqVA+WyoU+/L6chqAy8M4qs=;
 b=jP5+SbkB6PWJ9HSFLXBrmNKORbVNhweCMYQWtbMhpUsIwelI5SIm7daPyAYQ6Fv+Y1UmBv0kmOL8EU4g8Ew7OrLHuj5O9ZVfU6dvLMPd3B5ODUUaZ33wtkFmH1J8Yk8/vLtsubz91eDpJoTgKuu3aZGN8mNFxAdz8Na9AzdAxonuaCuGtBN3cPHXxLIyhK4fEwTnBDUr9pwCoIJx88cEciEavUgMbV6JPdw2v5XOmmHNZJm5G/UfY800b637PbkDPcUH23/gJQQov82Ab4A4u9gYsFi7jKafl0/XfDFFBeDB5nTiCaAKF862YA88RbeaU+8ekPza+4mMIwWhZsJ5jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 16:55:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:55:27 +0000
Date: Wed, 28 May 2025 13:55:26 -0300
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
Subject: Re: [PATCH v5 01/29] iommufd: Apply obvious cosmetic fixes
Message-ID: <20250528165526.GU61950@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <af4d5f74f9e4f1298624f230a7f6e430a9866acd.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4d5f74f9e4f1298624f230a7f6e430a9866acd.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d761a8-0831-441b-7b68-08dd9e087262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ELlo+gbP3Grw5TFXtStZTt+o8qse7HbRJILhRXEKmy6a31fTkMuxDML1n08?=
 =?us-ascii?Q?4+/Ms1XqjRGAVbBavOnry3svxh0cmmiBM1RiOBvysN+pNjWT82yLDvYIXTth?=
 =?us-ascii?Q?9q+KOk1At9P7y4Ae7qZnxllEaeffj39yaiKuFU5vsNOIQW6twrqLyAMOXVeH?=
 =?us-ascii?Q?Hs6Y9e8kDu5p7KjKcOlJ0pev3nxFuxHJk56/lTUWfzpzFRcfwjWap7GOAfYT?=
 =?us-ascii?Q?QWJV6USWIMoSLlaESr9WHZxIoCYeL6A++clfzzxUJHNldlxnp/cMAPYLVWNh?=
 =?us-ascii?Q?bTeoiONV5V9FxRFZaJ0eAUlxlhUKc8FX67x6QTgetpD22+yXcBXOfRNx5EwE?=
 =?us-ascii?Q?xj9qJFZ2j58JeqJn6s+d+XABwYDtujhsNVU9Oc/lHwVPHKFpV8T/A+awE0aB?=
 =?us-ascii?Q?DJj3LMUdZRWL0QCDqfwXD7ZCeaFyzIv5BNsHFYHUkc7I4V5fG3GKxGhq+O9N?=
 =?us-ascii?Q?ZcY6j1m358HAxKKlcPqnE2nBUhIrgqM0YuLHNvaT9/B9D05scxm60+GnV2ej?=
 =?us-ascii?Q?elfxhO1LGz/YlurmUSlLIhG/+gLg6dxSBb2wra339jNIUzxnrVTwZ3UlPj/E?=
 =?us-ascii?Q?Ui09T6LVtTKwwZ3gUf0+af4Ly0F9IRX19e6L10ZbOfTb3ZG+jRwiEPXphUE3?=
 =?us-ascii?Q?SCYlRi8RgyMjZ90NJtUne2uXEacWoJU6D1PGZ/PXoWtAQkO69myEdxjvwiY5?=
 =?us-ascii?Q?OpOwueRYI5McGCQd6YoZJN+kcZbNA5FoIIl76C5tZwmFM6YW69a/6H8uG91v?=
 =?us-ascii?Q?/WUYOosdmS0iy1t7uco39cZ0BotEyaMlN4x+Soc/sOM0brFOPOSAGgYMREeD?=
 =?us-ascii?Q?wK17c1cLindwTvci1hPYVw7yblMxsAspEEJ5jY4qqSpRUB/NfDCVRCfP+mL4?=
 =?us-ascii?Q?0YKsrYksoPvweDEM4oLXHziuR6c6CHEIITghup742x6v1dS8FvYmEldbxaq9?=
 =?us-ascii?Q?ZLc12DlDXgrU+N+4JfVSIc881e9PXGmqBY79H1M0L4sZnbbF0LQuSeAkEKJ3?=
 =?us-ascii?Q?yPlsb26h8qiG1GRZodsYx1Dv0igwJ0uyWrhr2WQsnMUU1aq+MSbvtgP8uuPA?=
 =?us-ascii?Q?bbVauMJ7JfKouizj9HYipjYRBHaNF3ldaYvmmGUyWSROACOESLsRRhgufqei?=
 =?us-ascii?Q?oZc1gryAA0zngEGCXDyOwJXtFk4wOlEQ156e9qwI+aXttn7B4xjp3oyk0Xb7?=
 =?us-ascii?Q?fgYfnjq6zYB2n2jUnCK3jUc6c7hl4FAhjVckULlV/z7uL0UCpyJGpKq/Qdsg?=
 =?us-ascii?Q?eYWFZLBmOqKMYNMPhjsOVa6RBT2IaJi76NYuIZtrO0k78cIKJD7INGF5NWBS?=
 =?us-ascii?Q?nM8Xmjr+/tl9HjvVIhw7fHE9NQLLJ4BYfcrf5hw5YUO1sexMApUEJQNoniHm?=
 =?us-ascii?Q?Yv6rQhK7eEBcptx+t9ECtZAyZmdQKsnq67Cv3AFlhCH4/lPwpacM0DsyJ3ah?=
 =?us-ascii?Q?d9mtw1sjOzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sCTYxjp7ybZ2CmT4sEEqOV741h1utl/YHymJ6q94+L7sgD9O/6FiOJ0I6A6L?=
 =?us-ascii?Q?k3UBgu86j/W73QNDAoGrM8AP3B18D9uSV6yYO7xZlz7TpbdTbk7g+cxuJTyk?=
 =?us-ascii?Q?dLAsc1w5+85f39K8e8lQtxslDeKmaqELyj0Znz7O6GSZtS807PODzn3S5SsM?=
 =?us-ascii?Q?IOsCeSAWAFndJVrtPPhgjCx9zta2vDCMETB5VRWUbMhkqSJyUd0og7YnkqWo?=
 =?us-ascii?Q?FPbQiSHDoFQudqW4+wQNgoviSB/nxH+5FTQfQzo+I0ASLx3wXL6BYtYGh0mf?=
 =?us-ascii?Q?66AJTZcZtqPfD3m807IsnNHuH1P3vWgrKJeDRh74C16ywXy7PV0tzBcVPNsc?=
 =?us-ascii?Q?ND9vMC1zz+hy5GwUuYOEFjpo2/LBWw2/Kw01cH6CXS6F+ZjYoAPlw/o+zhYp?=
 =?us-ascii?Q?VlZhaUyeuDqpVEQuKmy8ZUVFckaV+HLLgtTTtu5bIHmwJrROoVAYC8/hxUAD?=
 =?us-ascii?Q?4d1qYNA5/FjOsZBWcFG/fiXdD46mGxcslJb5F8DBq4+fM+TJCG2eyZX8XXNK?=
 =?us-ascii?Q?kguxVr9dxR4OiOTEUmMeb8rEm9f24rixKGqxbk+dH6HFbTu71d18kGEeNLS7?=
 =?us-ascii?Q?LY05mD/FAf+KNUa3zzBduUKEwxL5Q8RLR6MJip4sEIsrw5mejnyva2UtcKpm?=
 =?us-ascii?Q?9ZsGEYtZRyiIhZoom+QZnYpPmIlM4xQXbmVfCjTf8DCZ3PxtdOBs37OLrOI/?=
 =?us-ascii?Q?yWVcw9hPkJN6OUMXukmnlxvTjUvzCFAXJr4/NCM5+5QoL2z1tIJPM0aNW0Wy?=
 =?us-ascii?Q?Ynvcb+nR8KwJR2PWCpeJDfiH7tVTX1F5kyaSeU8hyDRQ0Hs3jvMsi7+e46A2?=
 =?us-ascii?Q?dn74B03Z3MwdClIqv1byfr+J3mSJuDVAa1BLP8TxSGkaGX/ofSDOxfLz3NlM?=
 =?us-ascii?Q?GypqqHzJMpMn9LEDrtRcwpyQIeE4um2Ul0JLP9JYd1aOfUZ0kyM2JBdC+2uG?=
 =?us-ascii?Q?7O4ACBz0y3nZW5vDV/79ts4wY9FLqCFOPcFGQPCSHxZeTCfJkAcoy6BJszNj?=
 =?us-ascii?Q?bO80bJUNfPnq/a0oXVmkpedx9Xha/Jtv/wbJ8kIlCAuX8N+AQrW2OrfEsvCA?=
 =?us-ascii?Q?39xJ7gqsH4Zt7w3OZtkKa/CHbffjcd/yKIjHalcKEnSdMr+/NBoftv3JPFj3?=
 =?us-ascii?Q?YKXSSEwVIbgdzWcYXmCIjuTwfcOHjCGC6ssQvG4lrzrv2zFvxJexwsnfuOj2?=
 =?us-ascii?Q?CLBfhgs661gvO0fY90PbfnSIxx8LVY9Gtu41N/4Bt67Z6Y4ZhGfj9zDuPb24?=
 =?us-ascii?Q?g5foe9zNWxDeSCA9+M6D8f44Iw5irdSp6jC+PEnTDo6WgD8PfZLFJdGyyY4J?=
 =?us-ascii?Q?zAHft4H/T+ls2HSGT0RuhChBZTQ9M+FWgzJvUSOeC5Wkgpe8VUH4biwxAhxy?=
 =?us-ascii?Q?c/dVqhy724zbHcpWmbNKt9NgDiPTSL3rJ4MIuiKqiuNKpuYEMdA69a2s8gTz?=
 =?us-ascii?Q?iPlXvyU8jBe+GnaVh4/lHDVEq/cqndYd1QxjMFDbzKpxpS6z4hfuca+0L2Ih?=
 =?us-ascii?Q?zQsKTH+OoMBBPLXEW72q1b92QGSZ6Zmk4AfdDxbKg2OvRuJRCxg1J9weIhL6?=
 =?us-ascii?Q?uQgtl4Fa52vW/menWVpl8nFmIEnkX/WIeTTsIkTT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d761a8-0831-441b-7b68-08dd9e087262
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:55:27.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTk16A9hR5OCNwfkgHyCVYIlVq4W6b029Azha3C7B5TnsmrQCwh7nBKlCvE3RVpc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

On Sat, May 17, 2025 at 08:21:18PM -0700, Nicolin Chen wrote:
> Run clang-format but exclude those not so obvious ones, which leaves us:
>  - Align indentations
>  - Add missing spaces
>  - Remove unnecessary spaces
>  - Remove unnecessary line wrappings
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.h    |  2 +-
>  drivers/iommu/iommufd/iommufd_private.h |  6 ++----
>  include/linux/iommufd.h                 |  5 +++--
>  drivers/iommu/iommufd/device.c          |  3 +--
>  drivers/iommu/iommufd/hw_pagetable.c    |  6 ++----
>  drivers/iommu/iommufd/io_pagetable.c    |  3 +--
>  drivers/iommu/iommufd/iova_bitmap.c     |  1 -
>  drivers/iommu/iommufd/main.c            |  6 ++----
>  drivers/iommu/iommufd/pages.c           |  9 ++++-----
>  drivers/iommu/iommufd/selftest.c        | 24 +++++++++++-------------
>  10 files changed, 27 insertions(+), 38 deletions(-)

I have mixed feelings, I know people don't like churn, but it doesn't
seem so bad..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

