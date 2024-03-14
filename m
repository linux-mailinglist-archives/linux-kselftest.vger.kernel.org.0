Return-Path: <linux-kselftest+bounces-6338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85C87C67F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 00:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296A9B2309F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 23:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE9AFC09;
	Thu, 14 Mar 2024 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkOkgK4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F717591;
	Thu, 14 Mar 2024 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459487; cv=fail; b=gjUJQw9VsGWO6nffNFvV9SEJGNiYRmPgZK3HP+vaaFbD4zrIHMELV4pHGarulpikTXgPdXVgoFh0XLwWXegMv1dV9l5Q5lSh26fsZzGN7AwXFadadQp6T9SzaBMFd1kCwbp0kD/xHUJYNKTHJNxCEC4pRui8bLs+wHUGs0kFV7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459487; c=relaxed/simple;
	bh=9uNrUPtkkgZWKiC2ziBxl0TO9shN8jNzTlwmjifAYuM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQFcO7vzTWvqEvryt2CDbsm1Rfo1lwKLOAV9g0G0gIpq5J7YiYGLn+CbS2OBynUSkRQz87Y40FZMpGKkM4bXmJcJElYQCMPdE354RXkGMMkpBVPpAqAJfwfI/NaUZzPiyzpIb2jpFkB/JoLBTz5Zuyro0pQJbUsG6Q3kMkylDL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkOkgK4+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710459485; x=1741995485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9uNrUPtkkgZWKiC2ziBxl0TO9shN8jNzTlwmjifAYuM=;
  b=JkOkgK4+uuBS+IPeF6VapVHWhSCo+7m1MPZsg0f/ob7zvyM2wVsOA2Ys
   OqdTM9U3q7mhVK8udUwWzMJv7hn/cDT6/Kde8J6ByidForQrEfm9YNLz8
   7DxJ4mLuF5U3spRLzTPcNS3k0HwgtqZaihWlIe6FZ2zXigZPfaCYW3N8S
   pyf3FzDPeXhzd+iU0Rd6+jJ0yskqs6MpXx/EblRiFm6Q75jetK4bZMPNh
   ACUMLOFBi0TE+ckDgD855SPZZTPkaWunATzEL8XwU9xs3LuvmbNAF04CH
   6w6h6ACnRiuEFP9qJ7S5Ukh3xO0Ao1AMXtVLb6W4SfvZB2CfTTUPpYjWf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22832104"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="22832104"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 16:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="12555914"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 16:38:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 16:38:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 16:38:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 16:38:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfS778/alOYg+kbp/QICB5Q5hIrv1O9lBC7nfvNI5QGjIvLq5cskjPXBbZOpllasJojqLSN/u0WGY0K5e/ai5aV4UwdG1EHUXfjEmFwFKg6n7/0UZsTctsd9tYHHFZddCEG6q7kz0KKa4VzOHEvf90TUz0UmNGqJxznTx8YGI/CBm9CSxHMZ57rOPusXvztpVhTQtC2a7bnr8TFyRy+mapUZk9/fEBPQ7M1nkl6UBWiGFzCXIN0BaNZEx1X3HQ1BKinDrc6pwM96VOEvpW6tQyR/HsVegkh0ETcvBprsyQUiL+mo2gtXD7YOFy22esWBsUQPDqhcmjeRYphIghF5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxGSBWuhJotKWVq/cGQi2BT/qgpFCI84Aqu85bZR/uQ=;
 b=d70DgI3uOX3KfYYwswWHFIwmdxovtHyi0Nh8DIvji8Ch64QrRCvPPD+zMl3x0ZRj9UVzUJmOb7ZhemMm38q8GA6VautokNSr4RhdIGBZOOy2JQU3knsAqhKmP1V+MBx0pN8Z8++wrKZlqVTYC94pAhZBPzJy+wjW4PgMwo9bVXjr4iRvCNsMb6VBXtMoQvNu8H8QvxU4BChF/wT2YJQPC71lmi3AGGuWSYgEvuvxtGpV8ALW4Xcmti8X2qkx1F0C/hG8R5/1Dw8+YhkdxZCBNgVaxKJKPsLT6BtT2gU1yaWlGE8ltUeXhfx62soklMpMzRwhGKnn6Rb5I4uVouP0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 23:37:58 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 23:37:58 +0000
Message-ID: <1c0b80ed-f56f-4840-b5ca-54840b1b60a3@intel.com>
Date: Thu, 14 Mar 2024 16:37:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Binbin Wu
	<binbin.wu@linux.intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Weihong Zhang <weihong.zhang@intel.com>, angquan yu <angquan21@gmail.com>
CC: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240314114502.466806-1-usama.anjum@collabora.com>
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240314114502.466806-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6f3287-7217-4651-a7b6-08dc447fc7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cg2XcDsSBts7JABsuMf2//OU/g5QbIhFWHNe0XyMOXFfIrhh3CGOpsmKqx9vJsTxw8mmiOd3xkera+mVXWu+5YvZf004q5ulPfndBEPxd/8oNNhj6lTp9mntfhb5C3fEbE49/wC7xFtpNfQ8XTBoxeCQqF1IUOQwWIuwmpFhRGFKxW9hoGEoROc7FYnsUvqxFQYt/k4YwCiLEEc7z9zrC89yKFLri8YdFPYJ3eY1b2VVcKOZ+MCmt/ms00APC8FBewbE7L/CMdnQE2U2nKS7UoHQO1dLN5xp/ihPrtFi/3cOOSEfDujgPh5g9AMZWUItDZPmTUMs1OCm7O4mkr+Q7U1fpYFaositikXy1i6U8185SulIpiXbrHwOcwCTxNuXGLkZK1KNXGwtmjkwgK4b86NK7zZb8kOdeDD2Z5ZQvSHncSF+q9zsPlk26RsW6KuLw0aESfniOR55hR16rVZVQVJkrJnyR96vW+hGeV9zzRGJa83MCdkbuJppTAhDfEyHuGAAz+WwBJ7layotHDjZCc2g9564g7t3PNuSnzrpPyoQI3il9V9H+Hj7QYoFgZ5bvQuQpTEKv75hn28E2zxugpNp0c8CKX3pAnP51Jc1iNlvCuCgBYruu7vP6mU1r2doSgEgh5vQ7eJYqfXGPtZMJpA/DoXz9NSK1q8VgcFzdJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRSZWpJM0hZOEZ5OVZIMjRaK2YzQW9xZDZtZk11U1dUTHpnYURCdTArQWNY?=
 =?utf-8?B?T3NGbHM2RGxmK2NBWFlPM0RjaGxrd1ZzekNXYlZlcFh3UWl6bjVqMXBXQmMw?=
 =?utf-8?B?dTYzdUh0WjJBamRqeVppcnN0RlgzSUFidnZ2bm56eUYxVUNCSGZUVURpWURU?=
 =?utf-8?B?blBxRnl4K0xad09KV2IrSENsbnFDT3VMbE1XM1NHSEZwaXNORDR0SXRIQlVL?=
 =?utf-8?B?NFkrc29UMHBrMEdOYTluQmZ0QTdMN2tnZzNNcE94bXRtSE1LMWk3a3BHNFJG?=
 =?utf-8?B?dlQ2b0tzUmRWWUplWS9FZmIxb1pXSXdsL0RvNWZ3Y1ZxUHk4UWs4SkM1ZjJt?=
 =?utf-8?B?bmJiMXhCdlczWENoMXVMUjRZbDJxOUtySUhZOEp1WFg5d3h3MmloYVhRL25t?=
 =?utf-8?B?ZHRDUUU2c1hNc3krVzdyT2VhTVphL0s3dUM2bnBXTmU1WlZUK1BqNllNRGdC?=
 =?utf-8?B?U0w2SndiVUNKRGg1VGdCQ1FsUGpNNkxHT1QzV28zNUdXTnlINE95RVkzb3Va?=
 =?utf-8?B?TnlvK0xxeDA2bHpNaytWUHBGaXEreFBNdkJCdkNzRmRvZlVKUFhHSFhKQ0ov?=
 =?utf-8?B?Q0s5R2FtQ3NIdGk1bXBYUExLeWhhSWt1cU84VndUU2dWSFVrU25BQ2ZMelZ4?=
 =?utf-8?B?cDVHOXFKUTFLejlrV3R2MDJYU3JFYWJMb0ViUXljRDYzNjc0UW9jb01WSVZj?=
 =?utf-8?B?MkxOMnZMMDZVamgwa2x0Ty9VZXRWb0cvN2loNk1LajkrWWtwVVk4czZSSUVJ?=
 =?utf-8?B?KzZxcEdidnY0NGtQTnBXb2Q3SUNBVUlhN01lSUJ4Q2h2WVR5N212bzhLSWVN?=
 =?utf-8?B?Tm44bFlnSkptZ1VuYldBRVJqbGdUY09aanJYRTRjdUo1clBZQnVYRVBnZ0cr?=
 =?utf-8?B?SHJHWU9TeVdmYlhrNFBGQmUxRUlnYzhUdVdZVEtvaFNQTG1zeFpzbUhJMUNK?=
 =?utf-8?B?L1dUNjBkbHhPWXB1VFExWUh0dk95OHVsZU9ETHBXMlpQOExOc3VKblM1RGMz?=
 =?utf-8?B?WUZPNVJmem1qZWNOWXo1UWtlSlBZckgyRURyN2x3WmlnRDNRN0hPbGoyM29Z?=
 =?utf-8?B?Y1AzdjRXQjhTcFp6c21VWGdnZkhjNTE4WnVYNnFHbmRRejIwcHR0c2ZWVFBJ?=
 =?utf-8?B?ZC9XdjI5WVNiSmZuUUJyUm5oSGlmSEFHZzFTZ3VWTTEyKzJXWGRtcWcvK1d2?=
 =?utf-8?B?T1FWVnRIUS9TR1FDUXcrUFU0bUZ5ZzFVQTlvYXpZKysyMTBISlVIR0xRSlN1?=
 =?utf-8?B?QXpJQlRjeDFXdFB6MkIvOCtjRDlsbk9hUHA4WkIvQ3pLU0VhL3lXejNUb2lT?=
 =?utf-8?B?ajZhbEJRSFpDMFdSYStWcjJnM0tUd1BRZld6OHpETzVoeGZQRU04L3pGbDRD?=
 =?utf-8?B?MjVIRGFCQ0N4RERmRERDZHpxd0YvQmFaTTJFRnhtZGVhbEVOc3pqOUFNSHJ4?=
 =?utf-8?B?RlZKNXoxYzAwcTRvVGZoVm80Wk05N3JWS3ZROUFmR2M2WkEycU9KMDVjSXRy?=
 =?utf-8?B?Nno3aXZRTzZjTEJSaVgrUGVFOE14bWxLYmYrMWpuU2M0TkxiOEhuY2FiMzJm?=
 =?utf-8?B?NE0yeE1CZ293SWFuNjdpMEJSMkxic0FOVGxZU2x1ZGpLb2R6SWFyVk5rUm4r?=
 =?utf-8?B?alp1b05IL2dJY1RQN2NOZkdRbmdyei9CM2VsMllkdEJ3SC9MTG1qak1adlhx?=
 =?utf-8?B?YW5vdVRCb05vZ2xYY3ZrWUQ3cll1blNaT2w2Z3FoUmlJK25PZE9JWDY5RUFV?=
 =?utf-8?B?YVJDTUtJUStkbkVTRnpiVmxjdllDdGt0WjlNczI4S1BlZ2tqa2x2VEhaYlor?=
 =?utf-8?B?WXBmamFwRFVkNlVzS0xTMzRpWTVRU2RIMWxSTVZYT1BCNW5Vek44NmxCYXNB?=
 =?utf-8?B?OWkzdlFkOGI5WjFuT3kwUDFyNU9QUG9mMzN6Mm1DMENkamxkT21OaGtiYUha?=
 =?utf-8?B?a2k1QUlxRk9KOUllQ2NjbDZWRlBmb0p2amlPcU9WRUEycTRFZjc3TkdlWTUx?=
 =?utf-8?B?djh6ZmJ3YkU3SGNmNGVVWERmKzk1ckZLbUprNTl2U2xIZFF5UlF4Q0d0ek5t?=
 =?utf-8?B?N1VHaDRmdUZvUTVUOHk4WUhLM0czUC9OME5WR0pJN2FLQUs3Q3RFTmxOMW1V?=
 =?utf-8?B?RlVXYXNGUXRMUVpMS29wQlk0SGoyVGVZbEpXWW8zWER3dkNYMjAyNUNJek1Y?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6f3287-7217-4651-a7b6-08dc447fc7c6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 23:37:58.6968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXdVOd93Hvi1WDaZmLdN1dwxXuTve+ekGzSURA7FYX0nvCOzfWa6p716X8kHWCCOaItJtVJGP6S9+uArXqXMPIe006C/yBQknPWhIqX45w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-OriginatorOrg: intel.com

On 3/14/2024 4:44 AM, Muhammad Usama Anjum wrote:
> Skip instead of failing when prerequisite conditions aren't fulfilled,
> such as invalid xstate values etc. This patch would make the tests show
> as skip when run by:
>    make -C tools/testing/selftests/ TARGETS=x86 run_tests
> 
>    ...
>    # timeout set to 45
>    # selftests: x86: amx_64
>    # # xstate cpuid: invalid tile data size/offset: 0/0
>    ok 42 selftests: x86: amx_64 # SKIP
>    # timeout set to 45
>    # selftests: x86: lam_64
>    # # Unsupported LAM feature!
>    ok 43 selftests: x86: lam_64 # SKIP
>    ...
> 
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use arch_prctl to check if amx is supported
> ---
>   tools/testing/selftests/x86/amx.c | 27 ++++++++++-----------------
>   tools/testing/selftests/x86/lam.c |  2 +-
>   2 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
> index d884fd69dd510..95aad6d8849be 100644
> --- a/tools/testing/selftests/x86/amx.c
> +++ b/tools/testing/selftests/x86/amx.c
> @@ -103,21 +103,6 @@ static void clearhandler(int sig)
>   
>   #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
>   #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
> -static inline void check_cpuid_xsave(void)
> -{
> -	uint32_t eax, ebx, ecx, edx;
> -
> -	/*
> -	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> -	 * support for the XSAVE feature set, including
> -	 * XGETBV.
> -	 */
> -	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> -	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> -		fatal_error("cpuid: no CPU xsave support");
> -	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> -		fatal_error("cpuid: no OS xsave support");
> -}
>   
>   static uint32_t xbuf_size;
>   
> @@ -350,6 +335,7 @@ enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
>   
>   /* arch_prctl() and sigaltstack() test */
>   
> +#define ARCH_GET_XCOMP_SUPP	0x1021
>   #define ARCH_GET_XCOMP_PERM	0x1022
>   #define ARCH_REQ_XCOMP_PERM	0x1023
>   
> @@ -928,8 +914,15 @@ static void test_ptrace(void)
>   
>   int main(void)
>   {
> -	/* Check hardware availability at first */
> -	check_cpuid_xsave();
> +	unsigned long features;
> +	long rc;
> +
> +	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
> +	if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
> +		ksft_print_msg("no AMX support\n");
> +		return KSFT_SKIP;
> +	}
> +

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

Thanks,
Chang

