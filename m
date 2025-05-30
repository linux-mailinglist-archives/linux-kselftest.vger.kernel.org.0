Return-Path: <linux-kselftest+bounces-34072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CAAAC93F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9571C20340
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802AD22FDEC;
	Fri, 30 May 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gymxe580"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88691CAA85;
	Fri, 30 May 2025 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623955; cv=fail; b=rKw6Y/+I1xEAQqwIBT+fmR8Tzc5LTwrsFzalSdGY2qSVX/kRurjzWMd0TkpBvNGp7M3tGBCJt+qxPoxjner7oqMkO+pX5iJM5KSc7oNnkNo3uG52GEGV49EqEykmaf3fDtdtzv0sGr8PDEIlAqVsDF5gcTc+CPYBpr9W5d/N5k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623955; c=relaxed/simple;
	bh=gcLZi/bSoVaGxkj562EaP1Grtgy/RlFVkjt98wligQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFrfzSp8KHs7Qt+h8zyOuIj6ktRjRoSb9QUrfXTy06mrf9OB6iKCdGy9vrAkBMzqBPz5WOeXEtl92bOfG5l1M03fCxKUhlEkVVcz007VnBRYDUzPtNwnN49hYp3Bug9tIkh0pp/aefQ4wF+fwDZcuQImkNl3Hr316dYSYLDjJW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gymxe580; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8dQzXrMvmSCrWWbSoRxM0ACVy/ojClfzyURNUQyo4lHASKUo6gmfqcap8j7607jH74aubxoE1Rb1FfOXftMZoZbN1ATBoSzGYnqEc+12ZdH1kSg61HmRiiQxRaJJCaoIWMLGnpdAXVieJkGuroLhw4SFoi/DgeK2oFsINu9uriQTTXEh+9dt7YMrvgzhcCAAhET5CRIZ29wD0uYkiqobMDXginCENPBvbP9Q5c9TM4MsnfiszEsebfHcGNKnCywlGla4ROJUBexjA9j+jfAPPHB2zsCj97ad4FkVXQgYkIQOZFtOIUKr1/wBklWoRFDi/ZiiX2ejQhKhjIVgzRudg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbLi7uaQ5dXtTjLsgSCcqA9Jejf/4vVM2v4iDyiIOtc=;
 b=S2RqnQnFBRPS+Upii3j9+MZTmOt9PVI0yj2+/AhmJgbXeCRTV4kucjfhc7r3TaMj1evjkzBQ2T1/yKu3NjXDV9gLVkWh+suCJSyHmy/8ZZ+njHdy3KD0bcQh/+/m3ZXqSpNGfZRD56oH7bld3uI84eSdHq/Ql9JFThIr3l7s3MJ5xPCiUNyp84GfHyknzDqqKqjBCdSFYatVXtE9OXvQkIyAqN4VerrPHcs13J2vztaznKil5/mAG9KmkLVYcewltAF16rY3tcMZ7BU1qut+ZrLjd43OisAlLRfr4dnz7++u4m+ByqTdnLVEQ23+3GRqDjkVB6lsu/RiE6szGRYX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbLi7uaQ5dXtTjLsgSCcqA9Jejf/4vVM2v4iDyiIOtc=;
 b=Gymxe580ZrxWwA55LJUshrbymOpnr7+pkKrn+K8Nc8+FSZdNBamRFG5JhlEfLLUO3l6WxH9lH6PqDmBh+RhuYstRB1NQpDEJGy3rIpox7UIpiji+KW5+q+sU0pWAPfYbgRNEIAPAd2us7KEU7a9j8LknjB631OZvGfsHD03mETwLIY5EgFF9ZVhdwWB29W/wo0oS03tMDkDA653tA4pw5vj7ivdU06FXV85zl+c9Bb5HzCSZYkqAH67rhsaFGO9Naz6D6p35xp8c2patlVpFhCbqNHaf+U4McKMQE/MHo7ir3Bi6uHBNt2aN6TdZ1RfN0BG8+hCmDPhDt2vrZ5TQ+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 16:52:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 16:52:31 +0000
Date: Fri, 30 May 2025 13:52:30 -0300
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
Subject: Re: [PATCH v5 20/29] iommu: Allow an input type in hw_info op
Message-ID: <20250530165230.GH233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <d75b14f77997836603650bb12437ccaf50afd2a6.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75b14f77997836603650bb12437ccaf50afd2a6.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: adc0ba3c-db16-4d1f-a586-08dd9f9a5e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kfqg8j13EhxG7T2O9TJQBB7SfI8nv5NsprrWOoW0ts1EmQxI4Hs/nYSB02Fl?=
 =?us-ascii?Q?bUWQDjNivIG2BzyFDZJMJK4O9QF9BbqYwBtwOPAnTXJII0z7CnVKNCvJcN3j?=
 =?us-ascii?Q?wgCPGJaKCu05CRAjN1B0od4vE2Bz96PJ2c3YM6EYLvuODIc3VudHoRYiQQTO?=
 =?us-ascii?Q?DzAOPkKWhX5efvGHZjgWu2X/BRgaADOSNfv6j5l1sf5PZVHkgwAEPJsBy8qO?=
 =?us-ascii?Q?1yRwynJHaVKR2YR0rO5B9+C9XffHrQQVADmutLvTqngnCzz9mY2rELHfVZzk?=
 =?us-ascii?Q?0oqpTV704n2HG0fb/3f1jdFTPCi+HVdR2q+xO9JorR25nyr/eHcDmuekqq7B?=
 =?us-ascii?Q?QWTE4CQcy2dIagVYy3oNx3FJG9o/TMiuHQlKPqn1XwNMREqortIvg2YpzAlG?=
 =?us-ascii?Q?+sdZAYYOXs/tejigLhuQticBdF1j8HfF/UyDVKl9GxQw0BX9KOZoG+pXc27g?=
 =?us-ascii?Q?IR0dQg/SCgOE7fBgNiPhrYoFF3lpK5BB/YrJDjkTxuc/7k00zZATkl40tlMR?=
 =?us-ascii?Q?YcH1fD6ID7dXFsPeiBkSkcOzEusX6Z40D7Gic2xa4U4t3WwtLURxnPhd0Aeq?=
 =?us-ascii?Q?/OaLAIe3bhFM0GEYD4cotaJ45O46/gnDLj7XWHvqDKcN4O3khEVeSXwYDMh3?=
 =?us-ascii?Q?R7RfPW4R0EtPkVch6fyV+4LlFwQn00VYbbjfi4dxQvoeE79CC+q6KpSAWoRU?=
 =?us-ascii?Q?ZqlWZtJm70jIaASC2V85qr2s/N+nxA+L5LWrECLyFjzYCBVvTVW2lXblJNFu?=
 =?us-ascii?Q?AFi7CdV1/52N93b2uzzhC0rkbJYwIUiMt3UFQOU62p1e9yZf0+ExcXCoEsC0?=
 =?us-ascii?Q?Tq7ApKgf2Ag5O7Od0lcyZ9TWuGGkyG5VHOdVqceCgG6YDaKy8QcbpnSUFYtU?=
 =?us-ascii?Q?nkFejki1Lvf7lQejvpaCNjqFxDG98wDKGOa0QU6lpVx4Rp3YxH2tdf9G9wRW?=
 =?us-ascii?Q?kez6xyOlojTbvViL9dwrvHESAw7Bp5Ar8waDcFzP74cozh1Nydh5sknm58VF?=
 =?us-ascii?Q?mQGT4Sw5GH7eVvp8rAhkbBYo0Zw8n+UtME1HlVacQps51ue/YIU+hhacLpDp?=
 =?us-ascii?Q?QPMvYB+sSinihuOiHPz5ao0Lgwu3IIdgZeiNdWQipvT7phL1jl6xRJes1W0S?=
 =?us-ascii?Q?3Lov8/MQPFHgcCWHMvYGDk4CxCan/YO39YkPuA7vwlOwHF3Ioz90YBPRJpOf?=
 =?us-ascii?Q?r2OkHNR7VrHuNmCpk6OptRH0Wz7MJdn2xs3qOpEno6C1gnhodB45cgmJIKC8?=
 =?us-ascii?Q?1axlSwivRhowE7RMltxUYvKSyFq42pCs4ogcOeJgSI/11pnG788Tk9K2UB3n?=
 =?us-ascii?Q?39EbyHVybUdSS8pGXvwAh1t98tr6is+yEdW8ddw4U+iDt1FdWsJHNnTb1por?=
 =?us-ascii?Q?XUTIHu7PxD2y2NinEAP+/GDaXCVdvxsiGG6eEJh3IWKlPC54K+PD45LnOW++?=
 =?us-ascii?Q?L5ELIv3r3C4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cF7qIbKGetjqq3qHqG4fra24pp8wx/BaqYKgZy6IX2qmDNHrEknhwDDy5mBG?=
 =?us-ascii?Q?xCI/ye/GEkQSuxA27pZBaYOedH73Q3lxbX4sYjAnLyZTZIRelrLc6R4yih8k?=
 =?us-ascii?Q?Pw0v7kGpA8fvQeJq1kgR/cz0nJcjCvlDCRNgDFADQ36+Bb/Z6fgvKW429oQR?=
 =?us-ascii?Q?0BRSe4xj5bbO8zAzcCuTA10ZOEA2MBWTzEwK4eYrr7qSf0znZwsMA37k0ooL?=
 =?us-ascii?Q?1RmXEgYYgn8PUleOj5mWi1z4rESRrr6qadYr4lLYdwxBHkCQUGi+0H5ADLWj?=
 =?us-ascii?Q?214IRw7tJMLTu8+OpRfjW8SrkUk0T5ML8UvLYK94cQodz7rYuB1evDBMc0Il?=
 =?us-ascii?Q?SAAiZ2/LTAnJudtboJ/ATYcDWgfWOliVMu7vtwbEjJzBeApGrTYCycslEkyJ?=
 =?us-ascii?Q?TDViItMmrvarJ3KQW9WPVXaUnU6mQxVqNJ9m+3iHdbLD0TyG1aIuKhWYU3Q6?=
 =?us-ascii?Q?5+8aGwzTG5ZfZ5dB0J3gd461aR11RxUx7AeF8AZuedvTDnXnXYR7RnEVFiEU?=
 =?us-ascii?Q?t12fpDhifqmMNiDw8N8ODwcDrBvLLESl8znLdnmlX9yRJe1z59jsQxhvsPdG?=
 =?us-ascii?Q?34/MTG1Uv0vhl6G7jO9323+Lm2t1Mjk8m1Nu4rrrsjd6Vw8kntXgNU86zGPr?=
 =?us-ascii?Q?6sy3wEijs7dNDlEMFqITg0tEqFuDeTC0rXESMDBkeFzJ06AEtz2kszlpR4Tb?=
 =?us-ascii?Q?OZtItDqeE+Q+b6XzRZTBNo4C+pyr3O1p+jNTbBx9IDds6ds5xMdU8MMrGcDv?=
 =?us-ascii?Q?5DTZI/rmFrGk5qGjdweR0pkqCIF8V2K9jYeGDP0ODF0xveMoEfJJCvDR0Jfp?=
 =?us-ascii?Q?1PPgtEow9krsjxz9VgcYgmqk/8pIXc2BohuWPen9rAyxOtEANrlp/0+druLq?=
 =?us-ascii?Q?8+q50nvvOv8RqfUcT+y56IP6pQZ2750BnoBuSPHKZj1yQKL54WZi5IOZ3Y2K?=
 =?us-ascii?Q?U15BQ2zhkdKiWztwV/gBH7tGKW6uEHCErPg3un7C9hqzjRHk5AyFSK4zgVdF?=
 =?us-ascii?Q?Xy/rMiqg+wI5lAuvALurKD9gGgXRn8cn6g1bmPx6HMqxNAijA5d0O6bB8dtF?=
 =?us-ascii?Q?j5XOHbM1xQ/ENSwOhKMzz8NmCvqFVzwMj+L6awa/t4EdOlJblgt5ng48nrn9?=
 =?us-ascii?Q?5crXh9tJgbluRQe0vOLupLRi412SEhCW8SRAwJnYJNUuNJZc2CF9Wc6teokH?=
 =?us-ascii?Q?ZLLNtiAFiILxnQGE3h8ontov3+rrvHByG/rYS/I5BgjmrNlHWKrpQlS5tmft?=
 =?us-ascii?Q?BFfkbL+3lO8D7nEWSjX73bL0T/9XHzbak4WRkpIiG32WNapuUmBf8TI6yNIl?=
 =?us-ascii?Q?N75nc9FSJDYG0pSq6atRW2XV/xNmZ3PTYYOJFbQ4N8vZvo/JMxWhXtFvKk8r?=
 =?us-ascii?Q?h+rdoRiHqLeS5xq9Z7Sl8wSnwDW0w+MaYrjPh1XngnKPfZ1bgqs8kZGM6Gx+?=
 =?us-ascii?Q?5UGO6bVykRheG0H2MVSTBzfuUbPLwTZ5EFd4+GLj155LX/ZSSQRu+W5c2kMT?=
 =?us-ascii?Q?JbSFcg3QbQyinqxJkOF6Q23b6Sjf3jH3Z+jYWR4/UQ7DUl0GCX1rQudyaqc+?=
 =?us-ascii?Q?Gx8/JL/wodq3skQxrANHRLfpTDVaRloZRAimrLeS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc0ba3c-db16-4d1f-a586-08dd9f9a5e34
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:52:31.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: movJm186q+hZAGRXsDx6leN5qtrI/PnbKYYKnNDRrByR/aHpvwnptBhyNCXEp47+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

On Sat, May 17, 2025 at 08:21:37PM -0700, Nicolin Chen wrote:
> The hw_info uAPI will support a bidirectional data_type field that can be
> used as an input field for user space to request for a specific info data.
> 
> To prepare for the uAPI update, change the iommu layer first:
>  - Add a new IOMMU_HW_INFO_TYPE_DEFAULT as an input, for which driver can
>    output its only (or firstly) supported type
>  - Update the kdoc accordingly
>  - Roll out the type validation in the existing drivers
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                               | 6 ++++--
>  include/uapi/linux/iommufd.h                        | 4 +++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 ++++
>  drivers/iommu/intel/iommu.c                         | 4 ++++
>  drivers/iommu/iommufd/device.c                      | 3 +++
>  drivers/iommu/iommufd/selftest.c                    | 4 ++++
>  6 files changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

