Return-Path: <linux-kselftest+bounces-2088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BE4814EFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3BE2882B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5CB82ECF;
	Fri, 15 Dec 2023 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVSFat7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D830108;
	Fri, 15 Dec 2023 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702662038; x=1734198038;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IoGb1mQ08/98iESaDXzC0gAgwa3PFDHlRSDkzlQmerU=;
  b=mVSFat7QLEpJf6odMQ1MnUxsvbLVZBHsHqleZAX6si7ba0N1eAapmpHZ
   zxbH1/nNQ4l2EOWpyZCbFZwPqFAZf0sGJkzsZOVKWa07mXGzOmWY7vI0X
   LpgbyUn11eFrAdWTrAW1MYu7C1u1DAl2q5z91MudmJjaPocDBDRZsnx5O
   NQpIqk2p3PXjWf/B9tD4igSJtJCBV8jBlEWTJB+3VdU/SsPjr8A76ZvNb
   wEigOTDyIIcjWFl+p3XCVFnaOa/8IpV1h6pJk1KUBr+jUKu0k0lCAL8iD
   qZzk9DOQvBsD/cbkA15CkcrY4IB2J2z+kC00pIX5ekpMcq3J/4SxOB0NO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375454509"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375454509"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="948040643"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="948040643"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:40:20 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:40:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:40:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:40:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6P7EmuOtRdcQDcENiBN4entLD3U/deoM8udjZdCuATdq/RY++2x/9UwigntLtqGitZYDiBIR6nK71So1Dm3m6IFehkA3StpefMdOYXnEPhM6XTkVwfAwS7oENp5g/f04MBmYJAiymGcU4JlH1STVUCcsFRcxaGN7nzwNz7lVMEOuheD83g83jUwoRBeB7tHlVj+cbQ+bVirAPhERtOaQ7v1VYsLx3BqNdGl0mM7/SUk8Wyb8vk5fYjD8KwDGaU1887V2DTF6IF85ouYQLv0bZFHpJBccU3Fd56LlJ88B2hBi2sAbjFBFBmOe7bO724rNh9i16QQ60gdsTPjgFsy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M0Qzq17jJwQSKvdIR01XsE8H3hl1wbD0MUYU49XndI=;
 b=F/TKFXGfsIxtrA8POqgmRYmFgX+g6qOyy5zACFvc+b1F+WAQNlsDZJ1Ks3lD7dtyc0UvZevXvoY47MPATLeoaXmV5t4Xn0b7loqy2aGNBFLywLcjTQr1cv5wbniEhjtiL4mFk53Wkow7yD3uvw/uUmYVYQ8riE50tyrH7ePEezWCDn9Wp59glUZtB5d59qexllwf8kvb9c9cZ4wWWd87KjbvlvMQrgSWDOtPkIVGxvgWqL6yhBLFJlZqhIiyaNw7IBhehnr1xhZXlt+7b/Mqq0yx0NQIwEpxFyV2KANJUugccm7Sa0eK3UqkPUGePV6BA73FTvwMD7+ZzYopiHdrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:40:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:40:12 +0000
Message-ID: <51821c81-82ef-4b39-a8c5-660a8ee355f0@intel.com>
Date: Fri, 15 Dec 2023 09:40:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/29] selftests/resctrl: Refactor get_cbm_mask() and
 rename to get_full_cbm()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
 <20231215150515.36983-8-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215150515.36983-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0374.namprd04.prod.outlook.com
 (2603:10b6:303:81::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: a6985b44-23d9-482f-d0b7-08dbfd94e423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTGf01jgTU16paiwAYTQs999RND22/F0lLQgkAft4mxKQmG/hQfuQB68tv+f4niCsp3dKWOdajHAw4m0Qpnjg9bf9v6TE9da9eOcibNkSpNQY9jImi3BSFix8/vCTsjIk+8fYmolOMWvbLL90TgEchEPr/ZDhu54u71hstr3CmMV9KUAZDf7tpSltcUPF+wnOifBVqSoCzOEL+NEiXRsKAJz3yhX6XOmiCNTq4QZYCLwA0oARb19QZ5Vmv2zh+wkwBFmDRhyIIgoWA7+wAFR+H+yLvX63ELFEoUBWDVjBOAG778fg9ROMKpY1Ibja2HqPSoQklan0wEY86febjFUUvXEMipVvSAVkvOJX4Gptd0I0bw1ROTFshxK9jlarF1s/6/vzioog9pyZYy5QBBS8Behflbs0TtZZDD2frXRnri3Nfs3cYKtdVLhj6wRPw62Q+sM0DcE4eqkmWw966rfN70+MGHaRuB+TRMoTimSkQ2xc7x6xJV2rndx5aDBbaVE37AtOmHdHgc5tyhSx5frCDhmYIZbHIWLCVgWT2+wGD66j0sCwjVZL/P8qRurRdSFcXF6FMI6MyUv0CKgip7k85/LL34Q2Nqh0YPNp13KahCAPCTi+6Sr40cB4sNRdq784Vz51zy22muBpYLBCgf/SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(6506007)(2616005)(82960400001)(86362001)(31696002)(36756003)(38100700002)(83380400001)(5660300002)(4326008)(44832011)(6512007)(53546011)(6636002)(316002)(66946007)(110136005)(8676002)(6486002)(8936002)(66556008)(66476007)(2906002)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEFIUEVPcW96SnFnSlZBamRDc0hUcWYwYXhGVkJZNVUrY2VycEFkWDBhZkFN?=
 =?utf-8?B?dnQvSUwyMmZwdjgyeHJVeDhEaFRSYjVjWHh0M2hlWDFlajVUNjZ3QkhKcmZE?=
 =?utf-8?B?cEFKN1UvUVhaTlVlY2F3V29OUUZWTFQ3WkxPaUkrY0c5NTVsZ1RQbzF6VmdP?=
 =?utf-8?B?dVN1MEFWNUJRMWh4aU5kc3pyQXN0OFhNbU82Mm50d2paYUs5RVUyNEhyTndF?=
 =?utf-8?B?V2loSjFvMHlwSEtDdFZVQ3R0WTd2aW1pRStOUmNGSWg4L29tSzFNdFpPRzhy?=
 =?utf-8?B?c1NxTzh2cThTU1I3c3VJeHlseW9Ga3VmRXlOVEpVRFFmeDZlTFZrM3V5ZlJm?=
 =?utf-8?B?dDJMQmN4NDR2TnF0R25EeFh0M1ozSmsvbVlFOVhLRWw0aUdyamNnNjBBbXc3?=
 =?utf-8?B?eUVhSmpkelljeEJUczY2ZU50dlk0Um5pTVk1TnZRNVRmZCtPQWJtVWJuQTJr?=
 =?utf-8?B?VWtBTjZCTHhaMXJKTG1qU3I5bUFldFBRUTZaYXoxYi9Xa3lJK1dFa3ZmSkhY?=
 =?utf-8?B?TG1vSkNyK2IxNWxHdGF1R2paN05lTXVnV2piWlYwdEh1RjVMOTA1TlF6OStu?=
 =?utf-8?B?RU5YdVRQVk4wa3Q5NnFNSWdGejl5OGR3c1p2MkJZMm0wTkRWNHJZQkppRjRO?=
 =?utf-8?B?UHZnaC85UjNvdjhJK0lhcC9KWjV5b2RhYm1XVXNuZ1ZIQ1MxSno0Q3ZDcUNw?=
 =?utf-8?B?NTV2VWlET1B4cFo0NEhGb1Bqb2tpVkx5Q0NQc2Q3VDVMOW51QUh3TTRTQTR1?=
 =?utf-8?B?YXVXRGI0TTRZN0gxNW9xLzFYVUZlTW5ncDZGb1hYVGplWGNkd0tLcjhzblV3?=
 =?utf-8?B?TjBrOWpYcGdtNlpyYThLck8rNkIzNFNTeVdUbElQQWMrZDRuMjhXYmZaTFdz?=
 =?utf-8?B?NEJMM2dJdDVhMDA3YUZTcWNwRDBXTE1mUnFnSndUeDBkNGxvaXprZTBJd3ZK?=
 =?utf-8?B?bWp4cGpBQWhFRHVQSUZ2eU5MZHgweE50MVMzT3V3MWFFdVRlUjA0dVBLRDJ2?=
 =?utf-8?B?dFFNWjNVN29FMGxoT3FsQkdYdGJ2T0xDSzB3VnJwSE16Y3MrMW5rbVMyTjRH?=
 =?utf-8?B?eWxodWdTVER1QVpId3h6Y3VraUpiaTI1ZS82UGdVdHM3NUJGVTVlaWtKdGJ6?=
 =?utf-8?B?bnFDT3llUURBUEllNVZ4ems3MDk3bVF0Y1ZSM0o3NTV1a3dTU0dKRmZXR0FY?=
 =?utf-8?B?RmhZT2FlUmtIUThoOVFrUlBaazZoWEJPZU9kK1QwNlRrc1ZJUmFsMG1oQnRn?=
 =?utf-8?B?em9hbGNrNWErbFpYcXNPMnBmbkU3YVcyOVJJcDlWLy9SckFDbUU0WEVYS1hG?=
 =?utf-8?B?Z3pvSVkzZE84VVVPOXZZeTJjbGR6TGpIZW8yamJJRGkyNkJsU0QxaU94a1hD?=
 =?utf-8?B?RUZuTHlHZnlwSXlJZ1krV0NBZFdxRGFCcDU4d1VZaldhUDd1a1VVQkNFMWg4?=
 =?utf-8?B?azRLZVFqejRBZ2RlN0JnTGhGL1hrTFFmYVhGS1lOR1lGR0dlTmlvbS9DNnBJ?=
 =?utf-8?B?dnNoS1c2Nkl2c0lJRkptckU5MjFmZkgrRWIvMW9lblA0dUdmMHRaNXZwOElQ?=
 =?utf-8?B?N2IyMjE0VDJGWi9UNFM4VjI4MXIxQmk5VmozRnJTRnd6Y29sR3RLNkE5dFlV?=
 =?utf-8?B?bDRwTjB1TDBVcVlGL05kZDhMZ1ljSVVJd0U2SENSUWZaUUpLVlZPYTE4YU81?=
 =?utf-8?B?Q2xiWnUwOXAyM0FhMzhJWFV6K1pSQ3NtLytwU2JUTnVEMzN6c043QXEzNTZq?=
 =?utf-8?B?d2xiZkxhaCs4bTRKWjMvS3NkR2xxc0dkSmxPWVZZVk1senRSalVyeVZ1bEVk?=
 =?utf-8?B?V3RnVklWbHRmSGNiNVFJbWpvMG1UVnoxdDVLazk1RVFlbWExQTAwT1JTT0hz?=
 =?utf-8?B?ZWMwejJ6Y1ZHRTRPMUdoY3Jjd0RTa0J4aXpBdWkvYTNNckszbDIrbTFQMXpI?=
 =?utf-8?B?SVhUUk14YWdOK1NsNGhGdmsvcGNzSEoyeGxyWE9Cb1NFUXdtVkxDdXdkVVlS?=
 =?utf-8?B?NDBQd3NXVnlvVDc4aVgyOVZzaDFocFZtdldubHRrdFBvQ04vYlI5aXYxZjZB?=
 =?utf-8?B?UUltalgxY1o0dk5SNXJOUi9MbjcvUnFpTExna20yUGlGSmlTYWV5K1NpMjRK?=
 =?utf-8?B?RjAyVUFsd0oxdk9OZXFOSC9YVWFnNWNFRnByZlJTckl2M3RQaDNCY0xrYTIy?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6985b44-23d9-482f-d0b7-08dbfd94e423
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:40:12.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpygzJBy4unvQObs7uHP3k3wTnoVeCUBbITaDXXNbwOaD8hiwBiyMIXceW01PCYO1p4O1R8tTWgXtq+ICHhDIQQQ1Nsw1NTqz22wvxJLoqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6722
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/15/2023 7:04 AM, Ilpo Järvinen wrote:
> Callers of get_cbm_mask() are required to pass a string into which the
> capacity bitmask (CBM) is read. Neither CAT nor CMT tests need the
> bitmask as string but just convert it into an unsigned long value.
> 
> Another limitation is that the bit mask reader can only read
> .../cbm_mask files.
> 
> Generalize the bit mask reading function into get_bit_mask() such that
> it can be used to handle other files besides the .../cbm_mask and
> handles the unsigned long conversion within get_bit_mask() using
> fscanf(). Change get_cbm_mask() to use get_bit_mask() and rename it to
> get_full_cbm() to better indicate what the function does.
> 
> Return error from get_full_cbm() if the bitmask is zero for some reason
> because it makes the code more robust as the selftests naturally assume
> the bitmask has some bits.
> 
> Also mark cache_type const while at it and remove useless comments that
> are related to processing of CBM bits.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

