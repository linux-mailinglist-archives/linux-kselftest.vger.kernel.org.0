Return-Path: <linux-kselftest+bounces-36355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB24AF60C7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 20:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC971C46D23
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53830E836;
	Wed,  2 Jul 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwUEm20N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431B1C1F12;
	Wed,  2 Jul 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479547; cv=fail; b=qtPz9ggUB1q3VNIwGyETXe2rv6uH/JW5lrfCwRGAhMgxc5N0+KdGFh6JDoIC31Iak3ZlqY7W/qkQxFyv55QycbHIU9y7mPn3U3stdzF89hRiqB4gOS6fEWWM+sfor6hSjifuoYkHMT3iYg42HZe7wucPb21vUAWBMEG04Wa+ypw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479547; c=relaxed/simple;
	bh=MVRJqhHT2Ex0UuNzCksc5xXxck9myJIbnE+b/pCLYFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fdywwVYN7XgVmT7X6UwOxsqKr+tquhSFn9MZPj/Z7RXJOQuQ4oUgQ1xyF2H+o5MJmC5hcv/AoaoMEwPxn7JWQ/v4kksTNKqPGRCv1q4oQoWX0s04ivTR9ELjGFf31g1cBVJpViqVIyikwHbitagvF2y2uZxc1qDvWVrPQmVzZg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwUEm20N; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGWukrE/LO7P2bQQ8P47cxdJY2Zfei9GmLBYHVIWyVHzDb6xkCVN9ShSaDE/NAJQOmbxyIYyylUVSJFNQ8qqfWk34Z2Ki+eG7b5M06bFw6WDnGuSgeftqbux+zLdKrLPE0Imb32NpQxWpusVbyxPM5QCWHj5ZZxT+bPWNR/i5q3leVV4Z+JGkTTQn7qK9WTpihcoIPx1rGT+9XJ1EV1TWZiGPHJkwvIlaqEpc9yMDmVNKb1NZiVhlcEqStvRG9Z/opBnoM5AYmxGMBiYuv1b91JMJOR6iOf0yt7lZlIamBLTwBwzq+Ci9OTith26TnsjtZM8twQIeEg5Xdi0WYrFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2F+Ys0jWVLOAw6t3FV9N4Lxc43aC9NuvQGzceS/NAw=;
 b=YeGawVD47wCzLO7Xi1XLBkgV5cFHqs0hKqMkl6EQHw95IlZUjquCFJZNNwWRyzT/UR54Hc5iib64bN1JRN7meTbS27JPmnQR1MIpBBWWpDLtaHiI0vXMupbcFCW9wsdqL2mWttlx1xFzjd9t9MnyNAkHWiA54IVEpHSsWOZUpSGyuxXZcCiKXb89N7Id91eLCqg1V093if8Y99wm2Ln60cczuANMSwqjcCpszE+m9zxVpkxEeGkxrBVOEuT65F/iXlFedUjg12acb3drVvscchJ2XId+KmcNr66DqZqe95WOWxj5WOlHNIV20YOTBYyOwFFtO6g7wqV6y8syu/wE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2F+Ys0jWVLOAw6t3FV9N4Lxc43aC9NuvQGzceS/NAw=;
 b=MwUEm20N+Q80m+pZQUyumOAyDf7R9TSMx1k7Hxh5JH7VRQll9+LLcKdmPzT4LmBfDRW/v2/UshKwN+MN3awD+HWce04Vqp3CsxkZeXeWn/SDs22xBg6JLjTQzv+QZLD0JdniHMAdD/+HT58hTcpuJbmGg/Lfc2r8yWP6boOMaiXtPQUgNXZpoCwjLLU9Cn9brPbkWsOcwLa2QGjbfd05TegoMxGICcypyTl62qeQ7XhePnOplNIHnIAVS5GMbLaganJASq1KhEM9Lri9Q8r6+TmhnR1YXCKogJepTceOdsJJRzJdF8Vrr/NfC/hd0ugKILwsXd03Esb1HJPWigXD4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Wed, 2 Jul
 2025 18:05:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8880.030; Wed, 2 Jul 2025
 18:05:43 +0000
Date: Wed, 2 Jul 2025 15:05:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <20250702180541.GD1139770@nvidia.com>
References: <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
 <aGSNmf5Q82xEbDpX@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGSNmf5Q82xEbDpX@google.com>
X-ClientProxiedBy: MN2PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:208:23b::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9672915f-5849-4222-ac4c-08ddb9930f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fKRpfLHGGGdE+RtqWKnXVbQV6SSYvz9UDnpICzPD1V2KAJtz8+lY8R34OBBr?=
 =?us-ascii?Q?0N10XXYsEjQ5PP8Kyb3oFBHxVkWgNzbpjNTE7rrTZcx8ShHsNkiAupZbrN9s?=
 =?us-ascii?Q?EqePok+n/+oRpUTNl0KmdLjgHogCEkEpFYHjSQLEiLCWrZ7cl4vHRQci8Xs2?=
 =?us-ascii?Q?OjH5LuijfsU3ovf0Sh2XO0nzXVli899fGNOccFj4DxXCBVuy4LsOndi49OCr?=
 =?us-ascii?Q?/Zu7HJ8caiv2Cy3wuTD3Hu+Zkox1XvDnh7lKQDaZKahoJ2/y7GBGNh28+sh8?=
 =?us-ascii?Q?XMbDb0d3T2S9Y7XPDe8esX0M/CMIPaAGqG1rr4TsndVUTDBRZVtWL5fkAfOA?=
 =?us-ascii?Q?aZocLh5/Lb1XGH36z0BhwMiiP6xTNOr0Ym35FanV2oqycPkkxlhKsGp3fQJ6?=
 =?us-ascii?Q?HpH5nhlyv2VLV2O8DrnE1u+YULi8+LSZLI7epk9IiRRe/82OsHlJg6CoBYdm?=
 =?us-ascii?Q?PGIgw0SmCMdjM5o8IRR7KBFGje9rlTzl8uw+5B+fWszZ2W+DsBdSGWnIRBD4?=
 =?us-ascii?Q?rOdyUU082lOJCSgaUjgt5iHYJp8H8qR0KC4xud5ShjlJLe6zHeDY0bGALxjs?=
 =?us-ascii?Q?R5Pvlz/0LGIojwjxujLH2f+q0Jh1SmXgRatMxW/xKAT46YxGz62fJhx82xNr?=
 =?us-ascii?Q?q0pjfEzTcl6zpIsxvkDhnnnj8QVm1hBbgBQwDOiPrVaWWnThyFUA86w/TWf2?=
 =?us-ascii?Q?KU/G9xQEoNDcEr+Ud40vIg6r4H8YwIcPASmiT0A+wLIk7HZXuH+tRPrKEmw3?=
 =?us-ascii?Q?Mykp5W411OGCVMGObpTzEn17okg9Ch91eoE+a49s+UNC8R/+nFdrAa9aSoYd?=
 =?us-ascii?Q?Xr5+5VzjKhe1czZUHSJlF3nTKDy9hKr+Uo8lOaU2zRutGEFmwmuWreKFv//H?=
 =?us-ascii?Q?xcrcne2QSb8UUC4gbzIEz/Ey8NVJORHoF+Fgo27b95dAX0w/Oa9ikI97PL4e?=
 =?us-ascii?Q?A87BJQkX3u8/GS1u90dclHEifx37L7c3l4yR3sJZ3Q+H8ejCk3TBWxxB5tzE?=
 =?us-ascii?Q?NyVI919NZiG0v8fi0h+TouGvjC6ygwp5vD6wdhCHQLjMMujuUU7DJVK4OnW9?=
 =?us-ascii?Q?EMkO7LfmUXcXFd/tZfjDUd9qi5SmjNnflPTo7Pdm9EC9zDE5v0cTtDmhH0G0?=
 =?us-ascii?Q?zmRTbZ71M5XwU8V7lkKxE5I1DYWOlXIGUihQI2qLw89/SRMFgHMoMZJ+HY7e?=
 =?us-ascii?Q?uBedhEPzkH1sxZqGlUYkfN94l05FzWWdHqXTxOvDinhQknkqQjBLRIFATFNu?=
 =?us-ascii?Q?nupMFCj0kzVa7vgabaLrUKMOJu68sBtsgSOwi6H5meBKkhxXQWI31AQ2tkl8?=
 =?us-ascii?Q?Mz8tw0pT9xFnCUEQ7G5+9e6l86633y0NKgvhwJMkTEGsm8i8siDPw7Ytvtza?=
 =?us-ascii?Q?FwbG5e41b4yLFFN7nZMYEFhc8NTXHTmZHwfdA3GAKJfJ8z0DBDe8XDbPZfTv?=
 =?us-ascii?Q?F6KcIS2wxKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iLBHmw6CecbhbhW/CTjN083jPp8VK7CI00BGQa5qQyzahjpX4QVmf5i+TwVk?=
 =?us-ascii?Q?MYZHYoIBDbS1VVBvH/xlc1M/8gg0T3JnO5ZZaL/22wH9KObQmTthv2zZgrlu?=
 =?us-ascii?Q?j3Pr1H+h9udyuoqHWT2PfjzO/TvhCw6FStNGCVHSPto3dwbSBrjYQPp2oCFs?=
 =?us-ascii?Q?EDRedKiSSvnikvSgDAsCneTApHpVq/dwpaWO8kj5zEe2d7DqogILOgkzpPGX?=
 =?us-ascii?Q?sclecUKXdpX2fxln8fL5KvIfSBRC9yWLOjSrt//MlAw13hfAhnoVbmj40bVD?=
 =?us-ascii?Q?9nVl1uqqLZJ3jVcX9Peelx8yNHBOxacqJp8r5YvKy3TF/HJFAoewE6Bej/Ce?=
 =?us-ascii?Q?ft7kh/EdP7qFl20C+6dGiuRM5RXmUhzH3EHoOO947wBJwbHWB1ngmsQqeMsn?=
 =?us-ascii?Q?Ku4M8ltaZ0mHlMQBFn5PJKNINBVZemeA6d0pdehG+XRYQZM9BXrqFEZ+Lx93?=
 =?us-ascii?Q?FBaFIxrtmm1kECgBVrRQWIGJokpKozNgGPQoOuZCRpx76JRkA5m3M0BAM/Zn?=
 =?us-ascii?Q?b42f5heczpPog82cCWkJP87LnTcYIWF9z/GHe7nVwpPqBoy52oDpoS+oDReQ?=
 =?us-ascii?Q?0PRc3LN9pok/RNlkO5k01h98+a/SF7YuAQBl2jEF268j4OoKwhsstVaueMAA?=
 =?us-ascii?Q?yl3iwRlmyBVoix1sDnd7HnSvFMKABXYcHzOSk/xGYWucihR4Vs9K5+8rRS6f?=
 =?us-ascii?Q?r0Y7+VU7U07fyBDIU9+4VaQy4p+X+yp8hrP+b78d3iVYSCXaaOyVpghBG4ie?=
 =?us-ascii?Q?mhUgW421M93ZccelshNIk5tnniqObnyThQ8r49G+2OFIV95V5YcwhjBDOk8b?=
 =?us-ascii?Q?dbmys80LrnYFQR28JH4H1GIFzxcbEzWgp6gcHcWrc0oZmydbIa8IDIDCmQRQ?=
 =?us-ascii?Q?ZHwSwDPsuSaSkTN6ucDai5nhGAvW9fiKEFRNXVaBwBxRdT6z9XoAE4ZVnStp?=
 =?us-ascii?Q?aH1fNUIAUL1gHv28qjZkRmMGOoj/D5BajQZ55zMeLy3bZXwai3GUuvbJv+7G?=
 =?us-ascii?Q?YCalhU1fh46vJ58unKsFYm2GhiLOZx3nWs6Ck3+vQi+MM4pTEirdAFs5+zvX?=
 =?us-ascii?Q?PFFgMgaClvKTtipu5Ebop9AyD8LtYs4zQAW3LtdxxPIvnEFkm+7qqRK3Tyoz?=
 =?us-ascii?Q?hEAtzLTZ+l5XEp1RJb1V3i1gOJ8y1jSiiB6WG4JGxdT9Trn3GjPCTCAs/XZO?=
 =?us-ascii?Q?eLvwfcfGOSs57/Tqe9dYqDHviELzYHVHGikxL6hP5cfJZDSn2u7HC9vA8LXQ?=
 =?us-ascii?Q?ImxuURunGG9xPfCPwhlHFbfLl416eh3rPZ9vrFPAmJHkn4mRRODMhCRhUBYp?=
 =?us-ascii?Q?9u/g3mjNqbFipUo/yLrUipp1wsm2PCLSd+TiptZoIUyTTGdVWYZaLiLh5R1v?=
 =?us-ascii?Q?iJguPSkrX8bue9trbDjF+/9qf7KVcEjhu2uaR3HxAinkpsROqiXRX7h3lC3Y?=
 =?us-ascii?Q?D3qJNBNydRBDQ1uB0OR9qjy0cjX9+5eCVBIlW3I6XrFkFJGJUk4pjcux9zUc?=
 =?us-ascii?Q?8W5ys40a0VO0aFffng3Rj6lnIWWOwjazxFGqTTm4/7SuzifYVG8rPpCL01R2?=
 =?us-ascii?Q?5y0CsKWDaT0JlQssg8k4LRbhGi13nBAQZZ9WYdUL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9672915f-5849-4222-ac4c-08ddb9930f89
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 18:05:43.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1Akv4CFUQ0QABz6b/8ygyQgfrcQ7JGuIBX4WdhWdgVYvmwy3AxHrvazp9wImarD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232

On Wed, Jul 02, 2025 at 01:38:33AM +0000, Pranjal Shrivastava wrote:
> On Tue, Jul 01, 2025 at 05:46:06PM -0700, Nicolin Chen wrote:
> > On Wed, Jul 02, 2025 at 12:14:28AM +0000, Pranjal Shrivastava wrote:
> > > Thus, coming back to the two initial points:
> > > 
> > > 1) Issuing "non-invalidation" commands through .cache_invalidate could
> > >    be confusing, I'm not asking to change the op name here, but if we
> > >    plan to label it, let's label them as "Trapped commands" OR
> > >    "non-accelerated" commands as you suggested.
> > 
> > VCMDQ only accelerates limited invalidation commands, not all of
> > them: STE cache invalidation and CD cache invalidation commands
> > still go down to that op.
> > 
> 
> Right, I'm just saying the "other" non-accelerated commands that are
> NOT invalidations also go down that op. So, if we add a comment, let's 
> not call them "non-invalidation" commands.

There are no non-invalidation commands:

static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
				      struct arm_vsmmu_invalidation_cmd *cmd)
{
	switch (cmd->cmd[0] & CMDQ_0_OP) {
	case CMDQ_OP_TLBI_NSNH_ALL:
	case CMDQ_OP_TLBI_NH_VA:
	case CMDQ_OP_TLBI_NH_VAA:
	case CMDQ_OP_TLBI_NH_ALL:
	case CMDQ_OP_TLBI_NH_ASID:
	case CMDQ_OP_ATC_INV:
	case CMDQ_OP_CFGI_CD:
	case CMDQ_OP_CFGI_CD_ALL:

Those are only invalidations.

CD invalidation can't go through the vCMDQ path.

> > > 2) The "FIXME" confusion: The comment in arm_vsmmu_cache_invalidate
> > >    mentions we'd like to "fix" the issuing of commands through the main
> > >    cmdq and instead like to group by "type", if that "type" is the queue
> > >    type (which I assume it is because IOMMU_TYPE has to be arm-smmu-v3),
> > 
> > I recall that FIXME is noted by Jason at that time. And it should
> > be interpreted as "group by opcode", IIUIC.
> 
> I see.. I misunderstood that..

Yes, we could use the vCMDQ in the SMMU driver for invalidations which
would give some minor locking advantage. But it is not really
important to anyone.
 
> > The thing is that for a host kernel that enabled in-kernel VCMDQs,
> > those trapped user commands can be just issued to the smmu->cmdq
> > or a vcmdq (picked via the get_secondary_cmdq impl_op).
> 
> Ohh.. so maybe some sort of a load balancing thing?

The goal of the SMMU driver when it detects CMDQV support is to route
all supported invalidations to CMDQV queues and then balance those
queues across CPUs to reduce lock contention.

Jason

