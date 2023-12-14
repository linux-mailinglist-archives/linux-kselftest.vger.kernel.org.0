Return-Path: <linux-kselftest+bounces-1958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0053813981
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7509E1F21784
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C2967E89;
	Thu, 14 Dec 2023 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLJAX3bT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459F10A;
	Thu, 14 Dec 2023 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702577435; x=1734113435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nB7nLWMR5p+HRt93Q032dS9r2/+5HQeoHmEbFlkahiQ=;
  b=nLJAX3bTCsqppEfIItNcu6NkSKOcKVUUkFvvteg5ozM+gPY/Dgiv4E8i
   5VoSMTbXis59jnlNVvDP7jXCCHxnZqJ8MPAZSg+HcxUL2eGfuFg2xkypd
   z2U9V4xQ62K8rw1BvKlAtgvsPJBT3k8Tom+HCjtGRgz8prAf7TvZpvUd9
   tHwg1ca/l+OhI78tQoFY82L0A6H+8cMDh3nYSux2ENsrpgOKrWfQHihUA
   zJBtduwL55KpbGdh370lxC4Dy7e174AsZy3xQ9l3G8PiQKU/jVBUXU4cd
   kMKnpEu1g0oFCPkFja+CeNeBR5hZyGS21u1ojDfS8i14rYjckEStq8nQp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392337521"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="392337521"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 10:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840368699"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="840368699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 10:10:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 10:10:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 10:10:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 10:10:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 10:10:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coRLgMGthwYRwW8lJmOjJC0LE4B1VCWzulY9VlR68u6z/11Y6JUBvj1+/cijdsIZa/86193GQ1yuPjqJ2ajoXPdHCtWLtTp+rg5ZIrJO5ELwFUpcdXSAEUWSLpUA01p1aFlOwt+f0ueopuk7+QVrynDsN0hwbvnKkI1TNRkQ/x6DJBAUAn3jf+nFF49qKTLgZThfmPjaodIPUyVLLnaGQfH2TkYO36Cdsj3UGmukeot8tWX/Edv4NIAO1YyROJnjDuNceNzVo9613gdprGJykCZ2uwtXjw8l2exbcXI67ujL9hSxjiDilaHNT5Ykmd/CT0eTurhJhyr8ZLGouMB5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+YyzEwzZwrlcA07agVfrO4FMkDuLfok0b4kAj8K/h8=;
 b=kF3Lvas9kq3d9YFyfjXvU5vNU1/pBjxil5TG507QmIohD+1RAEcqrl+6Askj2gJEcGUk8unQq22MvqQeKvGXaFQ4XTzKRXKcf7xYR0gZxGKFDbEtssr9APHtI+xVdh3c6T50E7SnfFlBHhWKmG19zok81iADhnZ7uhXIpRRk61IDkWP2rhCQxiZL02E2hiGvs64dAmfBVPlTYzGHci0BbysDfiH+iuDpuEIWBTB1UmxgxCq9sIYQyIOMLPbGiMCTZq4nxMv0ALLvCeZp5M6yGtz0K18q8jk2bLiZIl+vD4pYE1M92/1uNbMVdWcwDIPE0Zj22WN4DOHiHWRo29k+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 18:10:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 18:10:31 +0000
Message-ID: <a8fa9a13-d49f-4f16-b99e-a128a5feedb2@intel.com>
Date: Thu, 14 Dec 2023 10:10:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] selftests/resctrl: Convert perror() to
 ksft_perror() or ksft_print_msg()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Shaopeng
 Tan <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, LKML
	<linux-kernel@vger.kernel.org>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
 <20231211121826.14392-2-ilpo.jarvinen@linux.intel.com>
 <1e7ede83-ac80-43aa-a452-0f95b32d849c@intel.com>
 <c82b5c4-72e-c1ad-dce9-e5adf5d4a9b@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c82b5c4-72e-c1ad-dce9-e5adf5d4a9b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4558c76c-75ee-4793-19df-08dbfccff58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2oaQLb+cbv7NbjOrnalkL9whFlD+z+sXu8g8kYsEVQCci4I8fNkJgs+q1jtDvEW3mx/d6Fy6Hjt93Xs8vbFzhebQpOXaxGkHT0jrfHm+kJWpMI8MoVo7JxIUXfTpPNjZqjimdDyrfBjE5qeGTOlRJUII8s4T+MMzFmo+Yqa3uI7ERZFCr58w6EQ1Lc7lfeEsjyldCS1S3aswiQ/v+64buHZZ6mktrhRrjpQxd9qfgItl5q71FVCUingwVM7LtpMvnnYVMvIhn5FLq5xKLhu5dzsG+DUOeoTi1j5bLfPnZ8oitKNBFuAJjQZ517Hm7n/uNsQxAVLFrzl5M7Lf2FYRXzgmjfdtW83yqUQA8i6yhMeDil38nSUP4QKT+D6/vRhIcHafb/oSr9y0wedPOy4743J1vnu3ycU5DfztjnJWjUegWsq9R5mZFYTP4a4g84/sTgsKVfSm65lp5hEXUyDPnIyT0CHqBIWynczfS65UKRPIaJJcrgU3eT4VEPtrgr+C3eGxsUhyh9MdbKrBSxY1Cai2Qk05EABpITsDp1xLs03uSVgXrjUbAoXSBs7/TiTcDk+YE9CjBST16bdTl5ExtHVZb7XuaEBdXxDymHbyE4bmvXc/YUiJLDYtFxUDNBEeqiP/cYj+Ax3mNZYifGaoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(5660300002)(478600001)(31696002)(6486002)(6506007)(6512007)(6916009)(66476007)(66556008)(54906003)(316002)(82960400001)(53546011)(2906002)(2616005)(26005)(86362001)(36756003)(44832011)(66946007)(31686004)(4326008)(8676002)(8936002)(41300700001)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJCZElITWxUbjNyQlJMN2VwUndyWHQ3QzNRbTdOZW0rT1htWldOc25CbjRB?=
 =?utf-8?B?Y3kyMXp1R1lVcmgxOWExZDRJOEVvWU5CTTluU3RvZlJ0dnFmRjczc3NuQStY?=
 =?utf-8?B?TE5zbkpnZmo5LzVWSG9Ec1d6NnMyVStRVWI3ZVh6bHVERFlKcU1VK3RjbWxl?=
 =?utf-8?B?VWgwS2k3QURsd005bHVPOG5pbW1oZEduOUU5dUVSU083VEVYZDdUS250VGY2?=
 =?utf-8?B?eGtMOVZneENhSmFEOVovY3ZqQTV5eEhJaitxSE5ma1lNaGdJTmdhVW5QbkZM?=
 =?utf-8?B?UVJNbDdqZzJBbFBtdkxvNnhiRmN2eDI5Q2ZzODBnb2VPZEI3Mm56a25GckFN?=
 =?utf-8?B?SUt2enNDTjk5aG5FRDZ6YzJCZ2MxZ0ZzeDhjdlRObXhyOUtQZExTTmRrYVFx?=
 =?utf-8?B?NlR6amg0cTBiRUdHWnVvb0ZLRk9LSkVEYStJODJjbDIrcy9MWGgwdnYzY3F6?=
 =?utf-8?B?NWM4UmFaK1BOWVNseUpoSzZ1T2o4MnhJaUFHUTdjZ25WNTVKOUNVSkZnUWRT?=
 =?utf-8?B?ZzRLTm1Ga0pLUDExb0xSQTFyL2tCMkY4VllURFRqYzIrWjF4a2hTWnlNbGpx?=
 =?utf-8?B?SW9JY1I4WktjZ1ovWW9laUNtUWw3UzU1SWlBeTRveXFKaE9BZVA2aSt0R0x3?=
 =?utf-8?B?VGhIdkl6M2ErV1hsZTIwVTNuQUljUmdTZy8vK1M2R21OSFlBWXFpOUFoNmdu?=
 =?utf-8?B?STNpak43NlFqVjdYL3JuK3JUR2JURUdHQU9OYVUyNkh1alc3dVNqcHl5MmFX?=
 =?utf-8?B?K3dHU01XWE1zSXloV2YrZjlXMlQ5YXRQMTJheG1QZThOQWZOK2s4c2diYTVM?=
 =?utf-8?B?cVdDeWpqN0NxUnY2UGs5ZEhvQ0ZEUHlMeXgyK2g2Q3dGV0lxblduYlBMV3kz?=
 =?utf-8?B?WWJPU3g4aVlheTlyQTdJUUtmUHJzeWIrVS9JSTlKWUJ4ZXRuTzR0eENFY1cx?=
 =?utf-8?B?VGVYMkNqNnh5THl4WjF3QzM1am9lTXRLdm5CendkZjZnT2dqNlV6bURuakda?=
 =?utf-8?B?a0U1cVp5RnY1T01tcHZhcmhidEIvaTlhYTFINmN5RmZtYkxMWURBQytQd1ND?=
 =?utf-8?B?aFFGbHN4Sk1URXkwaEhudTMralc0eXV3cXN3WEt0Qzd0NTU2MVFGQ1dSc3RX?=
 =?utf-8?B?bnluRzNrMExwL0k5aTBuS25Vem5lWTlmUUwxbE9KSnZybnhCbjg2ekxDd1Av?=
 =?utf-8?B?OG9mNWxRc3FyclBHLzViWm9aMko0Y2ZLWnc4MWFrSzVNeCsxV2hkUGtKOWFD?=
 =?utf-8?B?SkNuRnN3U0ZaSEd1V2w4bzFqYlU2eHlMTmh3bFdRVEM1Z29kT3VrK2cva2lh?=
 =?utf-8?B?WHVFSjV6V29QS2RVVzB1ZlZ2S0EweFNwRC9YZm5BYUVOYVpNYzZtQ3ljT0dJ?=
 =?utf-8?B?K1BrME9RSXhjWWFaSWhVNXlYRnB5ZkRGVW5aRndETWR4MnJMeDlNSlM3ZXZ1?=
 =?utf-8?B?YUhaMkx2RDd2RlB0Z0hIYWtIekNpazZPVUZ5ZUFacU5TMVNJZU5xZmlmUm9M?=
 =?utf-8?B?cHJkSWhNNGh5U2toK3UxclBld2VZWExCTHk0V3YyQ0plTVZENUdFZ0paNUJj?=
 =?utf-8?B?MVc2UFpOUjBLbFp6VEJ0eUMySnZadjRMSjZFV29zUHlwZEZOSUV5MDIzcE96?=
 =?utf-8?B?RU5DT3FCTHFDeTIzQVRIOW1tVHZWUHZMekxUdHpvbm9Vam5Kckp2NnJQM3hk?=
 =?utf-8?B?LytMbUpib2RrWGRWUnF0L213eCtxSDM0dEVXanUyWjZLNnUzREJjaHRDa29S?=
 =?utf-8?B?dVZaQjFZUkRRdXVCaWJPRkQrRXZiNlp3T1daY3Z0UDYzUTVzcXJobjdQem9R?=
 =?utf-8?B?bnpSNmtKWXNIcTkzcjdSM08vR3FPdTlDMCtrekpyRkpNSDV4cll5QUtpMVlZ?=
 =?utf-8?B?bVVtT3pIZk15NkRSb3JxTW80aElvOHlRd1RXeEZwaVRjaG1POTlKUFViYklx?=
 =?utf-8?B?V3hDUzBzRkxmOUZPcEY3VHRmeGMyNUhjQm9PcG5OQUFkMDRlakFYQXZRSzhQ?=
 =?utf-8?B?SlEvNUxWbzlVUFRLd1JpOS9oSjd3OTg4L0IwdlZSQmczR0lKdytqblNXUGtz?=
 =?utf-8?B?UXJPc1J5UlFSMnVGUGRaSDJiMDlHZ3JBUUg3Q1RhQ1ppaGpaVU1Pc0h4am0y?=
 =?utf-8?B?KzMwd3NxOTVPakR2YkczelhkRmw4UmV4SitmRnJybXRGVU1IM1FLcVk0SG5i?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4558c76c-75ee-4793-19df-08dbfccff58b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 18:10:31.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmfDF4GPHHvd0miL3wnQzEDnRe8XuAuwg7Z6VE0wTbbaLNUBWc6R8Q+ejDJCNv+e1L9dt2xv563ViswNOnvaEicudOfPdomdi0pNbLPqeFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/14/2023 2:12 AM, Ilpo Järvinen wrote:
> On Wed, 13 Dec 2023, Reinette Chatre wrote:
> 
>> Hi Ilpo,
>>
>> On 12/11/2023 4:17 AM, Ilpo Järvinen wrote:
>>> The resctrl selftest code contains a number of perror() calls. Some of
>>> them come with hash character and some don't. The kselftest framework
>>> provides ksft_perror() that is compatible with test output formatting
>>> so it should be used instead of adding custom hash signs.
>>>
>>> Some perror() calls are too far away from anything that sets error.
>>> For those call sites, ksft_print_msg() must be used instead.
>>>
>>> Convert perror() to ksft_perror() or ksft_print_msg().
>>>
>>> Other related changes:
>>> - Remove hash signs
>>> - Remove trailing stops & newlines from ksft_perror()
>>> - Add terminating newlines for converted ksft_print_msg()
>>> - Use consistent capitalization
>>>
>>
>> Another great cleanup. Also thanks for fixing some non-sensical messages.
>>
>> ...
>>
>>> @@ -149,7 +149,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>  	param.num_of_runs = 0;
>>>  
>>>  	if (pipe(pipefd)) {
>>> -		perror("# Unable to create pipe");
>>> +		ksft_perror("Unable to create pipe");
>>>  		return errno;
>>>  	}
>>>  
>>> @@ -185,7 +185,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>>>  			 * Just print the error message.
>>>  			 * Let while(1) run and wait for itself to be killed.
>>>  			 */
>>> -			perror("# failed signaling parent process");
>>> +			ksft_perror("Failed signaling parent process");
>>>  
>>
>> Partial writes are not actually errors and it cannot be expected that errno be set
>> in these cases. In these cases I think ksft_print_msg() would be more appropriate.
> 
> I can change those to use print instead although I don't think these will
> fail for other reasons than a real error as the pipe should be empty and 
> only single byte is written to it.
> 

Apologies, I did not pay attention to the actual size of the message. Yes,
leaving it as ksft_perror() is reasonable.

Reinette


