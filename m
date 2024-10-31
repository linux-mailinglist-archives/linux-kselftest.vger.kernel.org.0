Return-Path: <linux-kselftest+bounces-21212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7639B7B77
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61031F22790
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64BC19DF4D;
	Thu, 31 Oct 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="agAKM4tD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753A19D06A;
	Thu, 31 Oct 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380401; cv=fail; b=Y9NPRnFCcWCmusx/rD9EQbf/aPNl3d0F2pat7dlg3XycspJkRrDk2M163MHOgRDwcBhoxohsNT10pZyRl5BqRmSiW3uedaIGmLI1aGucJv3BBfG3Wg2gW34F/ByJsPVBNHMWj3YuYwV5tUV4bwg1QvmWF7U6kJ1VAoiEROTJEt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380401; c=relaxed/simple;
	bh=VVeIHuIMQo473uUKiLT+CywyFSjKzLoNTn3vDO+KoXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k1b8lEtwdcZ2jv/CB5SUnhgjKdHeHTkmLdnA+088OLZvatuCK/d5KYzGH2sh7Fj5hMWHgPhIOWMun5czTCbBCdX5u/ufdHjTRfD4Tej3VnZgH+b4AM2PmvjOU7gVEjme8AHcz4RGfn158xW4tw40xkg5PVbSMQMYmQ+OEIoWSG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=agAKM4tD; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj+jA6cBdaPWS8E+LAZnfHkSNXfAgEoqPo9PSyYUu4twgyvC6O/eIQJS4KK6E9Pkwmk19X5e3OHkmaNw6oKp9hEUzkAfE0xJaBU5Z8FL0oscay64gwi7d1/1wgsntwm/r0BZlLSE/2fJ2LYpRn8CFH+qfc8ttH8GyWclCuwG7yoKA/azR8qIOq/XjRB0FEk3InfGCHnl/WKqiYaEwLU6eSCz1a9+gl5I72Ui14Y9Oio9UH8j6SCqCU3uwMJO5tCp9/onxhM7+Zh/mfbepk5wtLFdZdiW4BFgUzjchByy2kdNTQ0tbjeeQ4Dr214Gt0dKYAmVPxgNP4RT0r0sRBMd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mwq+TnDh0oBBKiRLdizbxIk8vEI8g/nfFtGTVcmT0s=;
 b=JoItSHwmGUUxRPwZBS3u/mjo7+wa+fdffeYqPtbi+WA9cGr3uzlNPYCBA0OslydoZM8XLgPCKVM5K0T+ClciZQssZhZXy5b5PBMV6ncckYH1jyyM95FYsKjui2j/ecQc2HybZqBPCZohowUXLaFcqQd43rLH95f1sxxq/hSTrCWX1XJ54D7AO3M8CzS/0AMbJ3BMAhc6OC3+EevuRFI8RrPXn6WyLofXJfzQ4bCTxDfUkI/R3oMJCSvWYa/4JBCVYl9rCnFCXGEcPT5mvYbd2FjQ79b7YyLEy7hVeA/IqkB7Cpdod8n5R2Ruek8yCvuQccWZGpMwbvtmfRJ2oFJaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mwq+TnDh0oBBKiRLdizbxIk8vEI8g/nfFtGTVcmT0s=;
 b=agAKM4tDc9tR1bUILbCj9S8qv8vekFGM8MTfxZstyA0f3d41nGm7eKu5RKkozCGwhkKY3uuDjGfjEzoJj9OzaKJePQx6bzu3cLIj0pUNQixG+T7ygJ0mT6bbhuRA/ZG0gq4ke0aEt3Ei5iCLTXFmTm48pQ2bSavmPcej+GUMMilvupfIIrfqm3WT2P6qH/PvvFW7+eLkbCpTgLbzt0ZHTsud0RJoUGeaVJw29iJbIxq+7gRA1nEIQhjDkmkZeLnq7xoHKG674Yyn+5tvXPSbG1Kplm1eLg3Ghh+K6inaBotZSB7U3RiPLrDsAEryb/+EUbYo+DvthtIGMDWQwXrMaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 31 Oct
 2024 13:13:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 13:13:12 +0000
Date: Thu, 31 Oct 2024 10:13:11 -0300
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
Subject: Re: [PATCH v6 04/13] iommufd: Verify object in
 iommufd_object_finalize/abort()
Message-ID: <20241031131311.GI10193@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <6c39c8ed60ea015fe2a5ce36b54132507d570ea2.1730313237.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c39c8ed60ea015fe2a5ce36b54132507d570ea2.1730313237.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:408:ee::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cfb565-2c09-4e27-90c3-08dcf9adc602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGNw60k6y+k/b7ugy3ZlBz3cVhBbrOxhGb9y9IkHqhv6bnNh37U3DVzXSTmg?=
 =?us-ascii?Q?N6kVJKC/nua8WHSDv6y0uHzsZXAbJi1QFJZ60eEvruPVbLdxyorP234BTrCC?=
 =?us-ascii?Q?GQa+6jxOl3QU3vk6DksKsQeekq80M2Iyk9R/ZNNWUoDEGatBp4QfPVK6rbZd?=
 =?us-ascii?Q?F51iYaPRkGiNoM9v/EMfXA8VPc1ub3x1hEdxlt0owyfK7bdnQwEFjyOh6o9Y?=
 =?us-ascii?Q?mFArI+C4Kb+3wicAZQxFgqrPyGTteBrO3TzcTc772hrUkykMaC7D3JWUzrL7?=
 =?us-ascii?Q?3yva/23W9zH1/5vpy2YLLzlVYnVh6LChAZQS9ZcrWgJ64HKsgpERkLT8jr9n?=
 =?us-ascii?Q?zzvCHkCcAlkt4iUmtK7X4FCVQYMuYDcRfkYNmZMa6Bo5+opkcm0fwd1oyr15?=
 =?us-ascii?Q?5+dADU8o73OSSEbB1ie5NyHHSZiNL2yh/OKE7ldS+oU4yUhFqyF0z9P86/kX?=
 =?us-ascii?Q?CG+sm/Ej1TXYWyTK/1Yh0B4sWp/o3UKeseAB0nbOvHUk18+fxmco8AdaPc9i?=
 =?us-ascii?Q?iQ/ePSklS2+M6rVJ3tZKWci6OTYfpnwBW05kj2qO9b/n9vsvhXuP2ZpRXjNW?=
 =?us-ascii?Q?2E0VHVYYM4l1UIQKtd4UJ4pmXH9ukgQ4+ylU2QVAWdjz49N7qWapbwGtU36A?=
 =?us-ascii?Q?drp8GRKnc+4G+Sj+Bg/RA7rmAWQLtSL5PSlybMZlP5kq6J3lBu/Hq6CtQEuS?=
 =?us-ascii?Q?UpMjqMctOvPCD5IE4BRtZ7W/dEzBQms+xOC+Ze5B/P3oXwVuTIj7tA2oDRYo?=
 =?us-ascii?Q?LrYIT+ebBy9v2eMlJsvVGXhFed4D+HBBcD7Lx8c7eiYo7LIOHXHxc1bExyvR?=
 =?us-ascii?Q?r0fZ8B4pRHca7rtCSdiyzmKBeSWT3vCnqVzHi51M+nqMsaEz2U0RKskCi90w?=
 =?us-ascii?Q?pZ/31ePr8JUFg3iA/kLJKGEEi/bAf1jYORcSpTgrarSMVgg2j5ihubXQ+XMC?=
 =?us-ascii?Q?onO4G/ggp/oYWA+cQB+R6/v+qD6v49K3Yfi9LEo39HilnFXAv94MwWdnCwDh?=
 =?us-ascii?Q?lCf09ph+5fwrISNzaWOGuCkf33SGqVtMg23+kDHLf8wWclejTy/oWunVAK+Y?=
 =?us-ascii?Q?y7vkGokNn7AGV9oiZlTqDHzsf5Ku6OF1mY2an8T7VkqNWCXIhjz93QQ/4aGZ?=
 =?us-ascii?Q?lahw27O4VE1+OxCUBeSBXrIh7krgFXP9EADAsOtSMRyUUr6P7x+7qPfV17OE?=
 =?us-ascii?Q?FqQ2Zel5r7GCG0nhWYX0tHaf3acgtD53CfTrSjMabXCoJFAcQu/ANXGKPmVS?=
 =?us-ascii?Q?MRbzidvcACwRkjn5UDGWDxmx0a+5YkUGUmeRCWmhSJqowwMFtUjDitcO6p7G?=
 =?us-ascii?Q?M2UzjOZYw5TN6HvxaJxTDpy4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUAzRtsRcBsisAwTxk2ulDDlx7LLml3SVS7VqhrUggjWhIkmr4RpQcrKgRCZ?=
 =?us-ascii?Q?Q2PDBSIYqUjA3ItgBFalLlq2JdXm+v25znS5oUH4/3Q+Hrmk1JqjP1MDFOvb?=
 =?us-ascii?Q?oRPyfIYrsRNfBzMFXvwJ/MDMNdfIQS/NzqToZ1bVnJvlPBHFNzCyh/nhU3/P?=
 =?us-ascii?Q?1WhgROV5haiwKawPO7+gvqpp9FZ3mx1UxjXoi7YD97M3jDSphAemWd14Pisg?=
 =?us-ascii?Q?hkNv7qXcFuP4zzO8O9XTtIweCwKefruLZsJ6aljc707ijXytLBcFF2y7alE3?=
 =?us-ascii?Q?EcmH/3Zl1qeQruK3+q8n7pRnwqRyDKwA6ANnvPilWV2S1MU+0T0LLcdwz5Ul?=
 =?us-ascii?Q?ymGK6U935gLGziWEzxUMxCiwyv/6OuPKb+rB4MizrcrNaFQVhn2lyB0mJVNU?=
 =?us-ascii?Q?eyNgKiqp6KJDJLXqVcpIMQ/1I+tak1BCdPQTVl2ICq1c69KzuUYZdEGY5+Dr?=
 =?us-ascii?Q?ZsYg1kuFKog/JJytv1ov79sBTV+rUbLJK9AotD/7PsD8BHdqcCUWAatWqf/j?=
 =?us-ascii?Q?LcmzW+4a18kMucsKEyoQPLr04QSqJBI6z3Ui4SdDB3xaNdEMgS643daNnJzB?=
 =?us-ascii?Q?o8oqwabAAYkIsytovKSEYHTMUK89vhJ8ajqbc6ZyDAIszkT4q36xlVgNNauO?=
 =?us-ascii?Q?5535T2sZI27n+PiY3fcOZCk8fEteCLDY5PWAz0doiT0+bPNPoY+K5jmfAhp3?=
 =?us-ascii?Q?fzxrNSLtEfpHLSLZEi09XPnc6D2kZZltg66HL8R8Obs3HqRP6MUu1DyT7Hy/?=
 =?us-ascii?Q?7ILnH6bXtz/3OhAlN4eUs531RhM495lPu0PnnzM2KIYc09gAx0FcSXWoDTF3?=
 =?us-ascii?Q?Whphz6ezNLZji60KfVIIwc9A4ZeoQRa1wJE3wuZMdJPC/8QnEsiKxMXeuBfI?=
 =?us-ascii?Q?tECMq55Dm9zua5rm9BE3PCvhNZP9FENqg752p+/usVu/nFp6XZeeaTz0QXgf?=
 =?us-ascii?Q?jFnSenhrVxI4ng8KVViGLXe/E0hgtqoYDrrgn8aKZbi4Cf8rl5FGNGhU+DiY?=
 =?us-ascii?Q?0H62gdhtqUCmHu7FWtHeXzJ10d8TpajV0rRcgnD/xQ5I4wcrta3zNtxVOVrd?=
 =?us-ascii?Q?m1E+UsD8eg62ru099hw3k/tTpKyvRh2BvsWsG/gpz1R89RUphGjE6zaKAC0T?=
 =?us-ascii?Q?60LxRzt5HLd8V/N65XlIQm+eiUBcWosrWMTz9MQ464Rx/Cl96TqhxGiMJDD8?=
 =?us-ascii?Q?Ms5a9BQBkwSbN/iaZup4KkgcCPUsN1ItsEa10Tfw1a9x/cVa8hXsdbTxIQLD?=
 =?us-ascii?Q?lp9F26jfQuTfiSXaXPW21pHwGBkF/ajjHvU+3F6Y4MbP2G84EOl4j7F/PIEw?=
 =?us-ascii?Q?egBQB9A77xbZu9+SiNrARuALFO+bL45YcTbNZ542sSLla1kUwAfKMg6RvFzU?=
 =?us-ascii?Q?UneIW0i5nS6pXiHThe/Y4isy8fNPSJZsnMmF60NSul4L39dyJwN2DxraGtnR?=
 =?us-ascii?Q?CxrwZp3AsxnQaO01luDw8wDTJGt7pkegOh0K+IeM8GnYvfO1kLsezTzmfBAo?=
 =?us-ascii?Q?kdD/GkklgRJdSfg7d7hsZ/njFcktpNKLtGoS7S8ZKJGiQHb8tFpv1OKdo2BO?=
 =?us-ascii?Q?4fiZ7sJCrfDPRPOya5I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cfb565-2c09-4e27-90c3-08dcf9adc602
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:13:12.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/nP0LhxEc6juDJtmOr6G4TGqbg9cjV1/ooyKl7/uwDONQgRCBjlgFjygL+9q1W3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

On Wed, Oct 30, 2024 at 02:34:30PM -0700, Nicolin Chen wrote:
> To support driver-allocated vIOMMU objects, it's required for IOMMU driver
> to call the provided iommufd_viommu_alloc helper to embed the core struct.
> However, there is no guarantee that every driver will call it and allocate
> objects properly.
> 
> Make the iommufd_object_finalize/abort functions more robust to verify if
> the xarray slot indexed by the input obj->id is having an XA_ZERO_ENTRY,
> which is the reserved value stored by xa_alloc via iommufd_object_alloc.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/main.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

