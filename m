Return-Path: <linux-kselftest+bounces-1372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED4808F4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 19:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B3E1F21137
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C714B15B;
	Thu,  7 Dec 2023 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGXC8fVG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EC510DE;
	Thu,  7 Dec 2023 10:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701972135; x=1733508135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gsPN8DWedt57Iuawpc/HpTZtL04git3SlviAtQp7oq0=;
  b=BGXC8fVGTus7a2PplExeUM9yUNxQSp66BJX14ZxobgspEOnQkDrJc/41
   Pbn74xZDP7TqHNiigJpnqD5ErmWnwCH9YB/xJPi6tlXz6X27pr2KZIKMK
   OBZ/nIDZ40roSu6PSE0U2yQEtjjjb2mXI2lFIdkl/bujzHhIN/WS2f7h2
   TDDxcpWoDnkN6JzYSDp3eD8G6E2eK7pzoqICCSHR8sdeJOiJBf1GkOHqJ
   qUKx1xQhYip4NMjSHBNI3/EHYW82x+iawNeP40dC94Qj3jTm+X2+x1gTv
   fPluZmGnEUwdNt44swV3AZAYj8AK6p3R0qggEDxS2lKka81BvwMC43zgG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7633214"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="7633214"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842294359"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="842294359"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 10:02:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 10:02:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 10:02:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 10:02:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oowr6p1EyRbMAlEk38ouzHqb7CfVzDYaX6PSBvAweGRxOH5fHXl90fxiOoMeF2b2GlSUW+GAlpAEqkMLGZy+AnVdQ9aiX35f8Mwo84eH/kcyNNl1FzKvCafroP6F242uVuPp5usq/Oq9rQmyBmjQnfOxwEcmRqhIU0AHuocMWmvyWk5Tj2+yMgpVJKinr6qtJg9JSv7R4I8U/0dCIx6F/K/4uNis32MZqk8vbZwzL82SUuIqb7tiv0V/Kj738MeTLUVAfwBwyRid78s4+QCnfRTLZpCfxi4s8lCwESsMm1Nc4r1XToYE5Fv8eW8ab7aGisAFIEmvHPQXhSekYa4VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saXjF1yBNKb1r3IqlDUTf+MEmctuLmoCiJ2mdtdZmwE=;
 b=CToOK/UkVkms3kkv/CTTkPbnYQ5iGtahcJK5kg7jqDT8lvGg3cYqucrvRIMmgnthKCc//Sc9Y6657zgMariemXzjoEhU1BhWRQQfgRdd1UmJJzvaJ8FohOhM+t/H7tat80/9rAv4N8QXKekdMSzv4DaPqjC/Y5nu84sfXIcKxNOVUHRA3wc3VctQ01Vw/Az8FKAD/quS34KiV3mP4jEX6fuCVFsa8eF6p7i1vbD3KitMw4nbuzoaCwevrOqJjAaYOokpjJV750EZpkLxcKCeAmAPV0PMqo3xZ4gsmHNwWI4yURRXjLzDt1WSDXNT8SUrnFeVcpVuOWWsXm8KlD0a1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 18:02:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 18:02:04 +0000
Message-ID: <8f6c7b40-5218-4427-865d-55e5f09c594f@intel.com>
Date: Thu, 7 Dec 2023 10:02:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/26] selftests/resctrl: Split measure_cache_vals()
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-9-ilpo.jarvinen@linux.intel.com>
 <c303ba1b-d7bd-47cf-9e81-8ea0c60b973c@intel.com>
 <e87d8ba-141a-5779-fc6-27e4735fc1bf@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e87d8ba-141a-5779-fc6-27e4735fc1bf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7d6b79-a8df-4955-b7f6-08dbf74e9e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Di2P/bVrBtUwCMG4yOq5mj7AbUxQRv5m9UTsGnvFw4xavOMgKogZOOkOxQj07m9VFweQo5/57Diad9cMzrvcXAHpLKyd9DULDob+UOfsH+cqbYWFO9ypOsbqAl3Y69fWeU/SSuXrOPHhWH3O70TaKjAFSqb4g/W5B9dXxPEwbwyx+AK1CaCYESZxABtyznRuOTV/VWNmfw4w5XsGhqn/NtBsJb4UlO3rH1X2a0AcQ/ZiI76Z9x7Ic1pFbxFOlzWdseOR5yR96lCtWf6TtP+r2Ql+W+gRh1MtnXhWKVG1aqWDiu2E9bC/OW7eq05mmABqsR5orojMFxlhmsvp6omhdFWSoZlR2L+Kz9lvZERdVuBTVXau1WS6+08kp4mpqAAauUkytO87EtkTPG4CHI2gEhHSiaoNSYdO7FszXLclXZBfjxgleoJ7NbMY67PlB72BWjRSALZZmoX0DqAxe218AwoMLsHlwC4Pd9yarZLVgROwFmjXe/AsPvwE46HE80mcHuUSYA3RbYoWaGWwFC9jK4FP39C77wNl4j6LQ8WW0jS0Pp8l4kk3XsnQwgW5PMdBv5bC5ZJS/lHJ1EO2YATyXaZm9rc/Yk+c0Xqfh3KHRCbpEJ5sPRJy6AGYtHn5vWYZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(2906002)(8676002)(31696002)(8936002)(44832011)(86362001)(5660300002)(36756003)(41300700001)(66574015)(83380400001)(82960400001)(53546011)(6512007)(6506007)(6666004)(2616005)(26005)(38100700002)(31686004)(66556008)(66476007)(54906003)(6916009)(316002)(66946007)(478600001)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU94bFNOT3VZeFhlWFhQRFR2QVdZbGNPNEZhZGRuQWJXOEtNRXEzeVNJTWtS?=
 =?utf-8?B?a0RyaGRvZlo5WFZoWW9wV3ZhK3ZMKzBJRjFIZFRLMys1eWE3UHlQK1VrMzFa?=
 =?utf-8?B?UnBxYWlod29qRDlQNTFaQ1JmejBST1FtQUJTMFVKQTJVdEFpYXpXNVRBSUhY?=
 =?utf-8?B?VFo3SStiRitJcU4weE03Sk05MlZrOFpjQ1hEMUo5eDZGVlJvLzczeUNiSkx2?=
 =?utf-8?B?WkhKQkI2Y0pBMGtyYjltd1ByeDNyS1VhaW12WDdiekIxZkNQWHMvdlNHU2JF?=
 =?utf-8?B?VDF1eVpIQ1ZFRWZ1bXUrV0ZlYk52b21RMlUxem9Bak9IUGI0V0pMM3VERGp6?=
 =?utf-8?B?eGxkRHlOek4rcFJTUzBveXp6UWRwWDNqbzFyN1c3T2xsYi9CdFNyMUhFVko1?=
 =?utf-8?B?YW1XRXhRZ2oyNEtwWjNzWkczbUNXMERhUForWWh6ZDh0VUNRV2dlMDg2UTg4?=
 =?utf-8?B?M1Y5UGxiVFAxcnRURjdMTmNBQnlNdFhxSVdpaTNhTkxJc2JDT1VIVFVkT0ZQ?=
 =?utf-8?B?ZzMzUjFkWDFDeWI2ZVJON2FYL0prbXlGMGQvNEVtM1FqbEZERmJPRVhRZWZp?=
 =?utf-8?B?dWE5RFMrTlBmU3pLcnJlaDdHR3o1Q1E4YVRWQ0N4emNDNGppTTIrOGR4dHpW?=
 =?utf-8?B?VEY5SGgraTFUUUg2TGFCeUoyekhyVDhneXZadUJkMCtpWUlIV3lIam84WWVw?=
 =?utf-8?B?RnBhc2NYejNZYzlucEpiQXhDNjd3S1hUc216QktqTkpEelRtZE5CTWxQbXJX?=
 =?utf-8?B?U0N4a0REZUpqajRMcmJxR3Uzb00zL2xkSlBWQ3g0Y3pQSUJkd2hZOXJHa3BS?=
 =?utf-8?B?YktVL3BZN0theG9rcW43eFpnMW8zOTZteVdzaDA5WCs2dXJqelUyVTcvSWRw?=
 =?utf-8?B?WnY5YXRlQUNGMUZERE5WbmdtZXpiL3A3OVNvOUJKelU0TmUwMDd3WWtaQjg3?=
 =?utf-8?B?NEVhU0lJUVJyOGdLM3Z4b3FPbVdqdk9GdW55a256S240ZkpCeHd4dWxEOWg0?=
 =?utf-8?B?dnR0eTREOEJSazgyMVhnK0ptang5WHVJYmVxbm9namR1dTBoTHE4NFRIZ2k2?=
 =?utf-8?B?VVAyVFRSRWdPT1hFbDhOS3BCVmZCa1lyUFE3cjY5RjQ4RXVCb1U2b2IwTzJQ?=
 =?utf-8?B?SWJqWGZJeFp5L3pYb0Y2bWRVVlRGVkNUOHpYMk5CeDVNc1N3Uzl6NG9WVDNh?=
 =?utf-8?B?WTBnaEVmcFFJQW5rMkpUVEh4VjZmeXZlTWlQeHlzREtROHdSVjJzRHlpQmxH?=
 =?utf-8?B?REcvWGFjWXhuMTFzZi9tcnpaSTlzSWZtTkdqZG1pczdxNWpYa2dXQUVTczVJ?=
 =?utf-8?B?ai9kYWFTUUd6ZWlUd3lhRFMyOUFWS2xDZmQvbUhXRUlKdllSeVNPcnRPQmNn?=
 =?utf-8?B?cGZpdnBWYzdPZVdYT0V3Wmd6c2VZNGtiTDlRM2pPNk1nSml2ZXpISG45aHg1?=
 =?utf-8?B?dldaWG1sNmFVRGlnV1BBZlNha3JrLzRQWTBWWllOUVRoR0dMTE1CZStEWGtH?=
 =?utf-8?B?QXJmemFhaC9GVWdtYTZQdGl1T2R3b1RzaEMvREJEZVk1RnVNaU1uU2E5K3Zu?=
 =?utf-8?B?bEcxZFFiV2NOVGFkbDlSaDRNK25ZbkFWZkVzdm53K0plL0tiTlRSbFdiNTUx?=
 =?utf-8?B?TUdsRk1KM1VTQkJMTzh4UC9VY3IxSTUzTlBqTkQ0WmdpNkp0dFNQdjR3VzJ0?=
 =?utf-8?B?Qm5qRCt1bnlyR1lXbURWTjFyTkFkM2o0aGszWGs4ZWNnNFg5TVRSM0hjWUd1?=
 =?utf-8?B?bURjbVZXenVUMG40aVJZTHhQaGo5eUxLUzIwL1RUNVJXZFdJUTZxZ2VLQ1BW?=
 =?utf-8?B?bGtYcjFHWmxVOG1uTnFzR3M5dndTamY2TDdPQ1I5MkszRENaS3J0S3JzT3Fo?=
 =?utf-8?B?eUJlZzNqVEUxcTZtbjRIZ0JzcWcxUFBmcndndEpldmUxL1E1dDVvdEtlL0d4?=
 =?utf-8?B?WHVXN2ZyOStZWkZRZzg5ZGJhbWZnWm1hT2F1NklrZ0hkcWxLS3c5VzVQNEdU?=
 =?utf-8?B?R2FZYkJxeWZIdURoNkVzVjhFMkNQSGxrRUFhWlc4RGovUGVWamdya0xWeURO?=
 =?utf-8?B?YzhOUFE4VjNEMksrUUpZSW9YcmpEQnN6ZWFBdVltK1hreWxiSGFRcHJLVGJ6?=
 =?utf-8?B?Ti9KaytPazVpWE1rU0d4NnIzSWhtVWJycGZ6U1paY1lPNzhDTDVhVm5YZVhD?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7d6b79-a8df-4955-b7f6-08dbf74e9e2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 18:02:03.8960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xt54KaOwX7IVdFlL4gyAgK4hJagHdm21r+Ahahu5gF8xEEhHT0e/9nVjY7pJJXb8YWhY+5tPC9Mwjp6ihwmcZqWeZCHD95lNQWEJZRugp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
X-OriginatorOrg: intel.com

Hi Ilpo,

On 12/7/2023 6:32 AM, Ilpo Järvinen wrote:
> On Tue, 28 Nov 2023, Reinette Chatre wrote:
>> On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:

...
>>> -	/*
>>> -	 * Measure llc occupancy from resctrl.
>>> -	 */
>>> -	if (!strncmp(param->resctrl_val, CMT_STR, sizeof(CMT_STR))) {
>>> -		ret = get_llc_occu_resctrl(&llc_occu_resc);
>>> -		if (ret < 0)
>>> -			return ret;
>>> -		llc_value = llc_occu_resc;
>>> -	}
>>> -	ret = print_results_cache(param->filename, bm_pid, llc_value);
>>> -	if (ret)
>>> +	ret = print_results_cache(filename, bm_pid, llc_perf_miss);
>>> +	return ret;
>>> +}
>>
>> Perhaps print_results_cache() can be made to return negative error
>> and this just be "return print_results_cache(...)" and the function
>> comment be accurate?
> 
> I think, I'll just change all "return errno;" to "return -1" before this,
> however, one open question which impacts whether this is actually Fixes 
> class issue:
> 
> It seems that perror()'s manpage doesn't answer one important question, 
> whether it ifself can alter errno or not. The resctrl selftest code 
> assumes it doesn't but some evidence I came across says otherwise so doing 
> return errno; after calling perror() might not even be valid at all.
> 
> So I'm tempted to create an additional Fixes patch about the return change 
> into the front of the series.
> 

I would not trust errno to contain code of earlier calls after a call to perror().
If errno is needed I think it should be saved before calling perror(). Looking
at perror() at [1] I do not see an effort to restore errno before it returns,
and looking at the implementation of perror() there appears to be many
opportunities for errno to change.

Reinette

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=stdio-common/perror.c;h=51e621e332a5e2aa76ecefb3bcf325efb43b345f;hb=HEAD#l47

