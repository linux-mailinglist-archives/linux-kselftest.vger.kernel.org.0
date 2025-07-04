Return-Path: <linux-kselftest+bounces-36556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA11AF936A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F347A7B77
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F92F94B9;
	Fri,  4 Jul 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZA+uksTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32492F94AA;
	Fri,  4 Jul 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633989; cv=fail; b=pFCXDhHfHlWhmp/6Vpl71E9oEJdWeqe8rLpyItCrcTih8GKSFzbMC5lUcIbtNS0aiV3Kjqr4lZ3C2zX0bxYzJ0pvSqcmc9rWMzG8sLbEpjnb0Gv26Ec/KSv9h1ZVTD6tZfz1Nx70ZZDxbdsXXBBnGqzwc+BLqmWuDCj30/bn1F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633989; c=relaxed/simple;
	bh=0cs5tzMC75gBrN6vL4d8/jOxZP94neOckJsTFHVSoUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YuXL1ouW6GD5psZZ1cHEWSn9h000khfqRH46zWsJ22/VLihlARXb/L+rVwFCWR7rXulSkYYmbbSsipVakOLfM6v5Yn5Mx4PyF456PfKECGslCl41ztaNmmvgv240he3lRyFc1GNYCYEF2iHdMr83t/tDpN1OZlGFca/9EL+qpts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZA+uksTR; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgSSPrHs9c+af33A9wOw0gfnO1AuWFyJOusgv2LZJP0A3rcXD4UQokCQr9Pl8rBF4i2jpD2ZrrcDgzJZlAyULCmK6vjKoAco3Y+9zSAb/rQag6HK5LtQ1ZosXAxI4hr04RKs3JaJeQDzBM9k85IJGypuCxBqcP0VraWPtDIH01sKv+qdR7nO5qDALzB8J/lVB1pwSJCqrx1AKkKWinGJbCAsgUgT+dWewPseAHMvzHQQEUM+ES84w+uPWC3yVqUqi0s72nPbjigYTmoEHyrMOI6L7mLEzoD5fM/UYl1ZOWb5yIEFcfDn+3DBam0klP4gCJtMAhYLSccaHaaG6veSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4RV4nT4XZoPxRLqZK17FZKeXoLUDKvxvLUp/6ymP58=;
 b=x69PcGwXuEKawLq4po4ZwwIxo4oERpdVuHVEmMT/yubfvr8Sjt1YRBjelSo+xZiLo6gnGRJm2TIEeRk0JyPZuct0XY9IbrrOHlGJPHLJAlUweTECGyE3ws5lteLxp7984zCzG1pjiovDxpZewo6wMk9Jxl62xFyA96rbLW8d2ExrTEnmf+wTpP9fwZa0WVUzTlj7FiTM5FA2flKpiTa7/jmjRaQClPN7CqlDR1Q7tDTwlAp3Wc6UJCn/Lpu2udyvSfmrjhIIdyDTJ1S3Kg/nd+moyRuL/ul3bJ0HndES4REBN4zDxq38GV+OYnfu65KkIJj5fe9IaxLr3tNKQK6dkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4RV4nT4XZoPxRLqZK17FZKeXoLUDKvxvLUp/6ymP58=;
 b=ZA+uksTRbH3Cc5l3nEu/56O2T44DkRusVKrMW1WXPGq3OVqsowk7A0jHFffbmgl2QR8LDXihoejHRDyvlq0nQaZuObsB446A78nW/3/2/wpUuKVaeMNZJn1r2BJ6ERMD1/9LOYTwDjYomFyIpvBTETV3LspVI2IaF5FfmosasP2CZ3uRSuUX4SH6yQwI+KDqsaWUKyugK4mZRj9P6Lh6haeR/6vD8KUImI7+8hIyman1fq4Kmt14Oz4TC+QV8l6M3dSby/8xQyR7+1v9vt7Oo6sNKHw1YngCEHvKPXBbR4NLQq0s6JBHib15QjRc85iHkdPqoWUN4OKcq5m84BXz1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 12:59:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Fri, 4 Jul 2025
 12:59:45 +0000
Date: Fri, 4 Jul 2025 09:59:43 -0300
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
Subject: Re: [PATCH v7 02/28] iommufd/viommu: Explicitly define vdev->virt_id
Message-ID: <20250704125943.GN1209783@nvidia.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f3c5db-746c-48c9-b265-08ddbafaa667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4xpu9tvBrLKN0B+3pXjbVqyw8UFLuysoUpw7kBHiYyUL2nPIcOjqwfxV9TQl?=
 =?us-ascii?Q?az/wXHRoYh6FWfhg0Cdh25bJgD8Cm47+l1Gfal/0L/dqHc/qwiDu66NotpTa?=
 =?us-ascii?Q?B0GN+VRJvCEb2q69xhvFZqQmmBGawdN+kdLZqqC3IiISJ/mZelezRgtcmsBz?=
 =?us-ascii?Q?ZLUfyOSskzrIc6idrMjUy9J33uIjwVwWiC76TlFPSthlFwbfrYLMo1l1o+AV?=
 =?us-ascii?Q?WWBsKEMRa6LL2c1U/rTNBNk/RefB0Q+6H7h01zhFUmzrdLEy19/oXrQ4EHU9?=
 =?us-ascii?Q?7lFBSg7KwAECYnruYAT36zPQ86rOiECMF1Sphjw3Ac3HkZUYd0qekCpeAZEQ?=
 =?us-ascii?Q?3cB/oZ9d2y6YqcGY4kzclzC0QUKvwhqeegLfbaI3sSIAw5mMA/IZ285rIzko?=
 =?us-ascii?Q?xVM1M0JDE9LvWE22Cen5cl278K2tK74Z9uZC1JNXQrGIzl9CvKZWeS/Y6rHC?=
 =?us-ascii?Q?OEL/t84TuysKwF+ufndJbAldDP6A0TRgLLUYmFIzOL/WzeKiwT5iPg4gCrOd?=
 =?us-ascii?Q?VNbfOvUnzcKEUxhiqNFoTInUYHKZ3g4ejsbxo1sDDaYeyjezhylvzhrgj28c?=
 =?us-ascii?Q?8yN0lfRKd6M6gGQaeHtfFAF0tmFlmLq8TKlhqYF1olNEnGLzv6A8mG0BXV5c?=
 =?us-ascii?Q?gdEvlKhrcGVB0eV0ObvCN0wRLexLwsIEGDRSTOu4Tvk8GWrl97GuJfKH9uUh?=
 =?us-ascii?Q?X/uNc5cnv+yQXqfv7XMFGjUP7O6Q5wT+x5ATHxBaHoQmFsNP2y4G312X1W9q?=
 =?us-ascii?Q?CAvO9sDDrAk29eeRMFwEXuxWbmaJs1K9/1SRC6TXEM7wmpRzJXLJm7u7uWPM?=
 =?us-ascii?Q?mHae1L++sAFs0IEO+0qFVDnqWDsXvWAnE9yscbfttZo+EYT1Cd3zhwStiBds?=
 =?us-ascii?Q?nQZawK/Sm8qWTdHzTpeGzijOJmNh4iuc29vzdWdKHKPAr/mm++qJC3H8ENhq?=
 =?us-ascii?Q?joDpPO2U6L8iIiBqLBIGpgGzSpL21A97ZKyXhwLrBrW1A7UDrOwgX18GW6mx?=
 =?us-ascii?Q?uxUysG94JK3FsYpjKycoiE+KvxnZl228KpDwVQgBVK3gqFeoz6JN0trHdfiY?=
 =?us-ascii?Q?Mc0orWlsv2Pe3hk73z5mPzY8+7td3zfwDxXmHxuakBfgERVyq06qkz08gGr2?=
 =?us-ascii?Q?/k7EDNFsW1pjrYBolBQb2MIAqurRZTQ1il6kM2/VOGbBGxWaLc+ZjJBJYlmO?=
 =?us-ascii?Q?teXWb6CtD72KbPW98INCId25EUzwY9bileXY5ubuG5N8qdVQ/Stpdb0yZkeg?=
 =?us-ascii?Q?iLWPCGC4DxhutMsYPbmPJ73wTaVPiMReCocQ5nuOeq+8HOcLmGl/oqIQ2nc7?=
 =?us-ascii?Q?MWtDagnaGyT+27so8fGHn87gsJmlgnU3mFdLloBlshi5+Pi9Pc4ZAA1BNq/G?=
 =?us-ascii?Q?GSeJ7tCu7zmM+qfJJoykQSBAAZ31MwLsXDy7fYga4P1KgWFkyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7GeR/iVqRoX5m+8Pw4s4Yq7hJjO86/gNugZ7CiVsYYq+Ss4YOF53h68rxxz?=
 =?us-ascii?Q?OGWU3eynqK6Wl/Joy6qV2b9eM7tMPZYwx5SMUR85JaxOVzwVl2aga63KMGC5?=
 =?us-ascii?Q?r6jwYQENVguVLRAFo+IcFSWDb6AqG+kmwVZJoStZ2NSdv7ixvLWXaKlIWLn6?=
 =?us-ascii?Q?RWSraa3OiRR+zeclcxxCmOM/TVFbvWzhlhlOqiaOrlHhvUl+Dm528DWtRABa?=
 =?us-ascii?Q?J2wzZEDsjO7WdfzJNqpD2HV3c/vBODIdx9ZLL8GyejZibxbdwjObMOQ1btyY?=
 =?us-ascii?Q?n03BQA9HWwNB/A3mjcnWb00/6YPP7/n1oUESo24s+Rq+DLxnDjGcO5tlNQuM?=
 =?us-ascii?Q?cKWg3ZYRGPot4eEg1Po3GyXRldg7yvqeZsSErFdAnoBjl27RKGvnobvwnkrH?=
 =?us-ascii?Q?tP7kEqCOzK9r3NmfARnjwkQzVq7w1+N2OdyPNVMORwTKUympAY0n49VMcumJ?=
 =?us-ascii?Q?v+7nVpUHgivvEkdt5svUfgjWUpbNcaM1llzkZHPrsMG88yWtFigdwXCaYm8F?=
 =?us-ascii?Q?6qjEQqCcD7Y+bSW11Kz1FJC35cYZVih1I6B7mxKarGB3NXoNNy7VxZ1Pjjcs?=
 =?us-ascii?Q?LViQoZjDHgkvoCrE6Yv736wVVNmlEA3jld7MmknhSQ7mPoGNiPT+dpb9iwIr?=
 =?us-ascii?Q?y0rQmeNRiI8EQrv8MOcKvvL8A2QqwsKZAJaxqZU9FyBV8dAxnwWSutFHLmeV?=
 =?us-ascii?Q?EXA8iGUsf5RsWTySGgBTv9cgyYVLVq3im2P3Ikrd1wfgckxuhL/8TKb/+4N4?=
 =?us-ascii?Q?BkW4VzD3kzrqDKjfAYqLB/AtDNVjCocM1h5+qUBz4ZrpimbPTfoOers/a9b5?=
 =?us-ascii?Q?wX7fQgZgANKzR7W5hB9DD9f0ARS36cQA8VAZ8ynjnpoBqKmn5NLy/eBOz0qv?=
 =?us-ascii?Q?blJPH5KbYmZvEOOL6c45x0Ojegz29UZv7ub8n0lUJ00HWwzXE9Txm9Q73Gpi?=
 =?us-ascii?Q?2pyYvocKfYWnS9OGDU6scWs7Bn4PZIYd67tgh+1W9Co/4n6bkfLvcDWvUmjW?=
 =?us-ascii?Q?nhgW9VSW5FPpeWEbvnIarhmQB2wPJ2XgEDTSixB0jbiBwjuhrHnUM6Z5Tyhm?=
 =?us-ascii?Q?Ohf0hh4u+M8lDt3Dv42fKZbzOFcSqs7GFj/84q88kcFbZwEthXPRHdHLAT9E?=
 =?us-ascii?Q?v/MbKghRxuNQnAu1AVY/61i3mTvO2/qbEBhqMibOy6BsGzn5RLUDZHXelKZd?=
 =?us-ascii?Q?5ed17Wh2DCjXUkIXO6VNZVblAVdIpC3KkhgSopWv2hJCN1sPo/ugRpcas3Q5?=
 =?us-ascii?Q?25G5lLw1Js1QXslUxbqx1xJVjrNxjg529sKEVZB506zD0WUuvfKXL4j1N+1/?=
 =?us-ascii?Q?xOZNiLV8Oltxuy4y4vmwPlpf9Y/0jklEQVsX1/xiLLVhJVfcbm3qf/lmD03B?=
 =?us-ascii?Q?3dad1Tp+6ak9qGGGX5Div5XgH0KCwnysO9PuweeTdwaSLwiU7ONGgxdcWXgm?=
 =?us-ascii?Q?EVD++CdqP0lJnexG2HyOrxyUMebwYn+04QEW9NMtc6PFugUkZscJLO6yMqYi?=
 =?us-ascii?Q?AMYzX5XSzPpRGA4jtwD4o9LUawmvtLv2YV2mlqjXQ0b/fOObu+BHkE41fGIR?=
 =?us-ascii?Q?G9NSe4jElIUlJ0SZhjge6l1ffpAKhTcR9QXAxGPy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f3c5db-746c-48c9-b265-08ddbafaa667
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 12:59:45.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok/WOBIy6zcVcVXiqxb6B0twVtkxUBBJgyiOd9PjwAeZd79orSVNlMHiUIcvAVdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077

On Thu, Jun 26, 2025 at 12:34:33PM -0700, Nicolin Chen wrote:
> The "id" is too genernal to get its meaning easily. Rename it explicitly to
> "virt_id" and update the kdocs for readability. No functional changes.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 7 ++++++-
>  drivers/iommu/iommufd/driver.c          | 2 +-
>  drivers/iommu/iommufd/viommu.c          | 4 ++--
>  3 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

