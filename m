Return-Path: <linux-kselftest+bounces-8844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 233CC8B19F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 06:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6271F219B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 04:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EED39847;
	Thu, 25 Apr 2024 04:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw/a8Ha/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BB3838F;
	Thu, 25 Apr 2024 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019932; cv=fail; b=l6KeNqgzfPm3JDU+7Ugj7VJBwEo4zZ/JpLzwRcz1ZERH4ZjSdMEeVaFrunmezKf6pkJtL+DktYFx14rMfXYApxTyIGUobaoghVGQo7mkOmdnrHQiy0Y+WwpPyvQLJTHQdm9UkRxUykhppCmU6cUbiF8jTgMl5Uozdojp1H8coPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019932; c=relaxed/simple;
	bh=s1QZUcCgdkAI8a7yrvs/W9H00JlJUJvCy4Tl+QX2XYQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/GHU1a7OOYCbmo1Wh5KYXSAjYpb/w4ZsHOXqCUoUZClUyb8aPVxilQIXCfXWiB+htFWD+0Okp/H2d+tjP1eCjH+e9QQaFmpkAEtgNogm+6Wrlw28y5/AtR+k1LqflEpFkU0CDsC/+7jB+z4XMClV0FdO1G3cHBcdtLFPVnL1Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw/a8Ha/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714019931; x=1745555931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s1QZUcCgdkAI8a7yrvs/W9H00JlJUJvCy4Tl+QX2XYQ=;
  b=Iw/a8Ha/wbL9lojPALSue0V2BkGkzbFpf1GXBQ775oWzkRr6bIsliEsy
   o9udxvR9XrgDt+OLHL5utNrfRrSxfUM/5iqw3sX9824HiFKTfUIQkd8Rw
   /zbO/7K/Lh+IHEkAvxicL41nUtPdWk2J3qi/7fZJe2r7F/sWrAelbsRvh
   4lXLmIcKjMWXC1OvNP3czwlirPEQW8AMLskeEvtKHqs9cEUQsOajzBqlh
   tywDcxl+YaR70lHDphQyiWJt/wogiXU9uelhWq1dB5ludwU3OmFtExIeT
   Sm7V4mf6uiJEWKB1972WxHlzNogNz/WslzPdaJmrfJ80ZCA81QED8R+mW
   w==;
X-CSE-ConnectionGUID: HmBqz8k1TwiB8gSFqIOE0Q==
X-CSE-MsgGUID: 76BUVR8/RzeW5pNuoRQX1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9795572"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9795572"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 21:38:50 -0700
X-CSE-ConnectionGUID: +fM/61DhRR6cQ+YalTjWig==
X-CSE-MsgGUID: dCT8wmr1R9mldpiXsAiAyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="56113811"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 21:38:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:38:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 21:38:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxdmOwVmOYxwVxRgf3rAOI+LeHaLp0cjLdbIcxHK7b0EttKXoKkYdF9JGYEwc5dIK3zdMJVxGiauXJmqfzUqxHgSUVvv8IOyGby6VSAtkUkV2jN+aHrY9onvKO2yZSD8xiaGB03/2K3sOKtQc2XkNQtqn3C3iA02XNI3owEnb6Fd1fZti7NIZ2KolNfj5XVxNTL8nKAa63CZ3UHvuQzliQAAln63l3zoRv0m3Ijd4tHtFL/2sRzfFv0DJU5ifrRD++fVefjHgNzfYmWQp48ExlJpw1mCNE3n4G9OdlH+A2MM0QcHnrMnBH4U+3f1r7JULmNsIwUxRXwZlt0Mca9bOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZpWr///4ouaF6DbBsvupFqPtm6efhOgCWBi1TqWPnM=;
 b=EQuY6UKR46EhVSCF+PCOdgXOT5arv3ig7aUjrnpk/rMAOfH8WKzn/esAyGk2bnVbDDQKclv1JfdLuE+pTw3x12wGcTZgFAguBQQA1bHDWDFUl3G9dulkrfEF9q3IM+8F2YKTgX1IfyXTS+JICdbFLNKBJxMPzVRlN6+wf557AKhydi9aSrIxNrSl+QKgeNHvwQJXejLPEl5vHsBV9xXEf37A8RPyyESPI3xPYlGNQeTRST1yG7wk89DoPPYv1f3KTf2JcjavEukZawfOsqp5AgErSxbVrh6n5Nrh3UrPhpegudFCFGfAhPsEC27JaYBIimz3Zap5EFDVFLcCjUT76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7330.namprd11.prod.outlook.com (2603:10b6:208:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 25 Apr
 2024 04:38:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 04:38:47 +0000
Message-ID: <b6ad043f-a742-46bc-a782-6ab2e1a6257f@intel.com>
Date: Wed, 24 Apr 2024 21:38:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
 <20240408163247.3224-3-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240408163247.3224-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b65c17-825f-4f08-26c3-08dc64e1989c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlR0eVRObkpKcW9QUmp6allweTRuMytNNVlBelE4a3dxejhlc2l5ZEF3L3Zl?=
 =?utf-8?B?REthMHN0amNldkNnUE5HTTNhTlJPZjI1U1RxZlI5azNkVlZXL25rOUZKT1hi?=
 =?utf-8?B?V2ZnZVpTOUwvMFB3dWJYcTNnZzVIWUJZVUlCVDBpRnlkejM1RGhJSitveTEz?=
 =?utf-8?B?V1ZQZjFPcGZab2dxeUJkN1h2WlZXbld3VzVnZm1aSlVnTXJTbmZLVXRrSUJj?=
 =?utf-8?B?eE1QYkI3ZWpBc3FWM1FvV0xGdGhPeDBGWHFaWjR0Y3F1NDU2OEphZ2YwOW5Z?=
 =?utf-8?B?ejFQMU8zT2s0dlMvRGE0Y1dOZE9wc294V3Q4aFluUFdUbU5rMWNGV2dPK3dw?=
 =?utf-8?B?alNYTzVNUGZxRXBKVmk2OEo5eXdHc1lDOUdKSzd3VXMzcEpVMEpjR0VPS2FH?=
 =?utf-8?B?WWtSWnRjQ0Y3T0MyUDVYQzdERlQwTTRRNFNVWGJNWXdVNUY2Z2RhSDQyV1Bu?=
 =?utf-8?B?SGdlUi9Wa2ZadmlrZnhkdkFVVUI2dllqYWY4cHFaU09nM0I3aDRwN042a293?=
 =?utf-8?B?Y05iT2R1b01iZE9ibjJPUDUvd2U5TFl5ZDRZUDM2cnNncW1iSEw4VjkxbjRL?=
 =?utf-8?B?eWtuNlpSOFE1ZXhxNStLZVRSck1NYVEyTHY3eGJESFdwME9LdWlZNVpsN2dY?=
 =?utf-8?B?Zy9VWE8vS09hTm43WksxY2pieVN4M0ozTW1iZ290a3BlZGFTMXhCcm5OOElk?=
 =?utf-8?B?ekxkNmcyMWJJMFRvMFNQLzNRdnZEUDNyejRRR2duRnBzSXB2czE2ZXJWM3Ir?=
 =?utf-8?B?V1RRenkwNGZWWmZjOFdMeWZORERJeXpSVnBXQVJqSC9NQTNST0I5VVNQRktX?=
 =?utf-8?B?U3RPMmZxVTl5elZocFFadDd1cW9hWUYxRmVtMXB2L29qSzBLZS9CbXByUlJw?=
 =?utf-8?B?R0NTeG4wbnBFemd0UFhSTzM1OWJGZFcwdnFVcHRKSHN3NnFQajVVeGlYaXdV?=
 =?utf-8?B?VUV0Wi9ZY29DMURyaEY5emY4Sk05L21QTDNUV3lDMzlYbHRkU1h4c1VMTTlG?=
 =?utf-8?B?M0dEUlVTcWRrQnpvRnkrSTU5YlFMYnVOZnNSbkZPTEdQaE9XTGhuNHNLVXVK?=
 =?utf-8?B?UHlGLzB4Tkg4eE1naCt3eUpzb2RzOXpmKzhQM0k5QU1WdHA2NEZuUjF3WStE?=
 =?utf-8?B?czYrOStuTytzbUxlbjBPV1hzNW1DNHNOVG9kNEFkeWdEREFxUyt2czJmK3A1?=
 =?utf-8?B?bzBnSnBuaGp1ZVBWODZlSi9wdUFCMnFYeGJWT3MwZExYNVZPcXBTaEpWUTVp?=
 =?utf-8?B?VUwzQ0s5eTBKeU4wRHRSaDhFTVZZeERqckNlNlVtc2FsekNiR2RZYWZBaXhL?=
 =?utf-8?B?bTRkS2RGVXcrbXpKV2lqeU85TEUzeC9vWjNUTExOR0dPbm1VSjlSSnRFZjMy?=
 =?utf-8?B?b0pQQ0NmcE4ybVI0NWMwRnRTejROT3JVMDVzVGREbjh0UmtoWWVTWmVOTnJC?=
 =?utf-8?B?ODQwUVlScS8vMEEySnJ3SS9wKzluTDF3ZjlZbldYZmhmQ21keTl6Sk5KME41?=
 =?utf-8?B?M0lhb1lRcTIvRzFkeDVtTFI2ZVZVQVJ5eWF6WG1pcHQ1aVkxbncrTFFYOUxk?=
 =?utf-8?B?NUhSWGsvNW0vWGdKdmxFdGNScGlFVzF4SEdqaldLNmtTTU5mV2YvckxIaTRQ?=
 =?utf-8?B?SXRrei90TkJNV081N2kxNkluZTdvczg4dWVRK08xaHI4S3A4NXFpZXBkVXU3?=
 =?utf-8?B?UW5vOHg5eHJUTDR2NXJmZW1aZTFkQTRVa1VtMzlmNzUvN1VQTXNyTEJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmh3R2tMZHFSdDNIeUZENGZLOVRsQW9OcDFzNXEvd0I3MldnS1dQK0JPYk0v?=
 =?utf-8?B?bnBlVlRxdVl5ZE1zMUxhcCt0L0JVN2dPMlFwUkUyVDBhZWNFL2I4Qmk1TVlx?=
 =?utf-8?B?OUF3VTJqeWNXSnFXWEdESWxqRW8zTHEyWTZYYmpTdUpockpTcnQyaDh2WU5C?=
 =?utf-8?B?MVlqMnhCK25Jb2tMNGg4NTlUVmRpOU5xTnQ5Ykh1VE1iL1lIVzh1T0d5Ty85?=
 =?utf-8?B?KzNJcG1RN3d4Rm9qdUJMaURVdE1PZ3BCNlVReTR4K2doTFNPRzgyeEFrUFdG?=
 =?utf-8?B?VFBoYjF5Z3MvU0JtcTExeFZVZlRKOUhWSFlyUjRCbExQb3hpUWhWY1dJQ0VD?=
 =?utf-8?B?TjlsVE9vRWYyUmkzZmsrekJQaUcxK0xkQm5zMXZpT3RPeDNnNE1XVGpodGtt?=
 =?utf-8?B?OTJjS3NrRUVwR0U3TXRyamZJNkdwc2lJL2xRNGNFbmlKNXpFd0VjL2FVSGtn?=
 =?utf-8?B?a2VOV09URkRRMlAvS3c0elU2Qjc3Z1l2ekZXM0pWck4vd2ZkdGVsakZZL0pN?=
 =?utf-8?B?MGVKRkF1aVJLbmlBNXJvVGNUdTFMc1B5dnVXcnJhYVJGZXdjcjFOblovcEh3?=
 =?utf-8?B?c0ZWY25WMDNaSkVJNGZubVMvOFdleFBBUzI4SVZIMnNHMEJrTVc0SEtUTUtU?=
 =?utf-8?B?bUxOWnh3bGM3dVFWL1VsNFNSdk82Ly9mbDVxYjI0QkhmcmhFM3BGVXJFazBG?=
 =?utf-8?B?bjkyaDFnMTM0ZkpVY2NkblRyR0YwQXovUXUyeWtCNkxqWEFBZ0grVVJXSEgv?=
 =?utf-8?B?L0tJUW1FeWhyL0ZadEVDandaTTR6dnBiMStCQnVVSFhidlJ1cmFORHk0NFcz?=
 =?utf-8?B?U0dWdHRNNzRtWGtZV0RMWTNZY0s2QlBML3NGOXQ2MGNCUnRjUExhaW40Ylli?=
 =?utf-8?B?QVd2UGJEM1RsOENZdGlsL2VVTXlYWURWM05ra21MNVZ0ejdxUzZTWjAzeXRx?=
 =?utf-8?B?UUdrRW5PU000WXpiOG9iWVh0azdsbjBHdHZjUW1rMVBaKzU0aTR3UWRnVlpW?=
 =?utf-8?B?NjZYcmRPQWp5R1BiSWU4Tm1RUHhqOEszVjJ0b3l6UTJqMnRDRitMNGx0L2hR?=
 =?utf-8?B?bzk2K2EzZHVyODh4eUhOazFiZzBmNlpkTXNaTEFhYVcrbFlaS0g3c1kyRjEz?=
 =?utf-8?B?TE5DaVdnbzVXKzBwT1lRWmdHZmE0czEwZjdvUCtSNThWbmFBZkdFUTNlSU5i?=
 =?utf-8?B?Rmt3NTBEdVBiQ1Jqd0JiQ083SlBCSU1qQmZHTEkrVGpuTUtYaE55aENZNkRQ?=
 =?utf-8?B?d2RGMzllMjJjclRwVStvSVBPRnMxZUNaNFNWZmlSaHdXYVl3Q0hGYTI2d0c5?=
 =?utf-8?B?OXQ4dE45c2V2dXdyaXhneGZYanZRQnlMRWR6RW1EeTVGNGh0Um8weStkUXlC?=
 =?utf-8?B?VHpnSVlneUNIT2JDNGd2eVdhMks4bit2UzVtb2ozWldmeXdZbVhKdEw2UnZh?=
 =?utf-8?B?YmE5ZFg1NjdkeUJkUUhzWm8vNWhmZU0xWnVGS0tiRXh2VzRNQU1zRG9haFRB?=
 =?utf-8?B?cE10RTdRb2o0bFN6bDUvdkpCU01QdTE1d24xNWlibG9aWkhVanlVWmUyazRN?=
 =?utf-8?B?Y3dEZCtGVXZmcURadnFPMTJ3T01wMlIrdnNJYkNhNW9jY2NjdFBQdlVqL01h?=
 =?utf-8?B?Ym9BVnpSem1PTHl1V01QUUhNZjRnVTZKYlNvWGlIRFFGZlgxSE1pbUNOcGUv?=
 =?utf-8?B?YXNjTG5BQ0RpTFJGanJQRzUzVFBaR2tZYjAvVTA1WHBkUHI1K3YzZ0IrM29Q?=
 =?utf-8?B?MG1UL0pKdVhmbmhnOEhrcTI4ODJRa01WZjByS01hbHpZYWd0SFRqSHRjNmlY?=
 =?utf-8?B?Wmw5ekF0MWNVR1h4OFZaWFpyU0N2Z0d2bXc5TXMxMHRKNFJCSUIzMnpVSU9F?=
 =?utf-8?B?ZE43Z1lSTG5vTTNaWEJnRk1USXRwd1lSbmxWc1VudlNhT3hMTWhpbzI2NE16?=
 =?utf-8?B?R2NGbFNFdTNSaHBISlh4aTh6bkd1NWNsUnpTT2FMMzRzb0VzTkZCbVM3TXM3?=
 =?utf-8?B?bnNiWnppVGlUdWFJN2JFRjVYM3VYSGl5TnA4SWovRkU1NVcwa21xWGVmNWZK?=
 =?utf-8?B?eXlweCtrVmlVRktEWTlEUEpzZ21KSFJrZmF2MXFJaW5qWUlZdmNTYk5XV3Jm?=
 =?utf-8?B?ejVjRzZ4NWVTUzhlcE9qbEx6TWhnQlpVSmI2Y0FWOGVSRFkzZzViOEg3Yjdh?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b65c17-825f-4f08-26c3-08dc64e1989c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 04:38:47.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCLM6lD06EvaxeMsFbU2dshlMAG27auazTunYk1VgaoutkhOqPsgA5IYRct5R6XyTE1zqzjr0Iygbt+IoTfnTviJZTJNEZi11O+IiE7w67Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7330
X-OriginatorOrg: intel.com

Hi Ilpo,

On 4/8/2024 9:32 AM, Ilpo Järvinen wrote:
> For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> the measurement over a duration of sleep(1) call. The memory bandwidth
> numbers from IMC are derived over this duration. The resctrl FS derived
> memory bandwidth, however, is calculated inside measure_vals() and only
> takes delta between the previous value and the current one which
> besides the actual test, also samples inter-test noise.
> 
> Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> resctrl FS memory bandwidth section covers much shorter duration
> closely matching that of the IMC perf counters to improve measurement
> accuracy.

I do not know how much latency this adds but I think for the resctrl data
to reach this stated goal to closely match the IMC perf counters it
can keep the file descriptor open during the test and only read data
from the appropriate file instead of encurring the fopen()/fclose()
cost at each measurement.

Reinette

