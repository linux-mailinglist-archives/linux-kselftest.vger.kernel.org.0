Return-Path: <linux-kselftest+bounces-3641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2A83E3A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 22:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5893AB211C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766F24219;
	Fri, 26 Jan 2024 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIcR37B8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C4249E4;
	Fri, 26 Jan 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303341; cv=fail; b=ToWFYuPOHUHzxHzlpgQ1UGo0XtMVqzwjduToLuj7Spi7NUFx+fy/PgJ9QDhhcgcjU6BJH/STTPvD6cODWIGF736Zy4wQhi9Xku9Tt4Hs0jyVylH8LMDLaWuuJXuP5d6ivyxM4S/+1rv6RGvRYmfOklVOTJy62OQ90afNuPxnx4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303341; c=relaxed/simple;
	bh=sZaIoBiO772mtvlrc5BkuDRNj1SSDhNyIHPsF37HP+o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OWvrmZ4UjCmck2JNUeOvikmnstPpjPwl/1HmzuicCXocBhr/s3Y9m/Ll7Ke5hVLbIvHDHhwlrOZgD9jyj3EMGv4gQqQYvmpRbVJrK1PZr+7Mh26OM4H89evVm++r3KIlPXC520TvivroKl88PeUYRBozCgGjl7G/WQ0inRNMx8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIcR37B8; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706303335; x=1737839335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZaIoBiO772mtvlrc5BkuDRNj1SSDhNyIHPsF37HP+o=;
  b=kIcR37B8QIxhTjFxI/0eK9zQcS38VIxEuHodqhh0cNcUYGMydVxe7P/N
   9AslZbp+SCUshH6QosfvuqGHdII2BfgWaWnFUuf7RsAvze9kstqb94NfE
   /E+wVkly2Lag7mL0cILn5okIRjftZqpEmugqWsWp1GC7PKeAzsazQ37FW
   WTBZ91f2PoglTF0i6P8ywG6sYyNLHIdNOU37d04YyZu8/UTRUjtvG56pZ
   HYA9U4OHmP77i5JpYxtTmMU2iBfdgc+BxupAX2WTRLD6wTRkU2ygb5J1A
   Z2U+D1GbzHkXwBURB9uTE6DA7Fnv86H2ZliPkXUY+Rcv2lBY4fa0IGy6E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466852267"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466852267"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910442511"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910442511"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 13:08:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 13:08:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 13:08:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 13:08:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 13:08:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE96k02dovaLysXnkzemgEKLLOFGW3tPCwvZtPdWC6mkiOZU0s3A2Jnp0Hu1VQl0qK01yqngggZltQ2mrnaOioFRq+YfkcbMndMyArK0hVehqPnU9ejoSTSTVGvbJe5RqCOi0KHLqWDZVhlQqwAT6XehbNT/LMXM4RqHPouZe96uMUhxc/CGUDw/U3uvmHJxXLlChid9W3SNJwlGdRaUwLg0C4ZrctnminG0LZN6Mkc9pM5EIDkuFbC+NxBiVnmLybI5xUIBXtpEoQvUuZ0cctLmppiZaig9paG09HgGw1kYAE1xYn0dIuQ71ahu8PU4PpJ2Ai2kuafRREJztUOgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvoNr9evGrePXjbXhxhzXmXbZS+YcdDpQ97jMkmduDY=;
 b=PkE9WTGBGKjpIrSQSVcLrmsn7ljryFF6N/m943x2w80HliNPx+3gp6yUJEQdp+nExN+kieOIBBlDPdE2VX9adYHR2XRCkTwaqng0ceh+C43DrwX1n+ZTc9heu2jNV2pai5XV/yBHwLWi3XPuN11T7ibFrRwNBaU4hQEGM2fd667QGyLqUQYQhXNW0NnitsTSE5+8MGXRrRpADNcNmpk0IEuz0wz75BWVUecxNKlmJLsbaPR3RhRW4L0E9EEorsDoEq9UbEqeltT5YYDaVOGEy3zz8c0+A9VEjrfz7f45V1DCMJYkNOF3RKfyeWHB83t6pkxiug53ku136aCwH0tyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 21:08:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 21:08:52 +0000
Message-ID: <9f8f1f00-f8a8-4c40-90ab-fd3357ab3b6e@intel.com>
Date: Fri, 26 Jan 2024 13:08:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] selftests/resctrl: Add resource_info_file_exists()
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <e73a79210076d6b1b7b584b12d0499e2f2e5f4fe.1706180726.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e73a79210076d6b1b7b584b12d0499e2f2e5f4fe.1706180726.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0800927a-7f7e-4116-962d-08dc1eb2ffd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBE4rGUPy5v8uVcOMK7Eu382+fSInOda9UKx9HWSWP05jaPiqo/ckgBLoNXfJ2f2Qqwrcs0Ej6dWPzhj5BKCmyMFxcWoEi7S+ybSePE3pOEX1/YiCsRXejmJeakd2CTRA66giG0FhAkGFnOBe/Fu+EmcKXX2lxYkWe0Zfl81V6LVLjOtSAKIyiFDo7TepnX1QvrMtvoUgfta2Tf05e5yzOr2u2AYAsx+VkyYCZr8nVqva959saB+NcRC7wOngn0puEMrk7wCAyArABm2n8jrA5bxh8XDNyY2j3eB4Rnz4+6SSSMRjFf3gyrgbdZCBeyyzHjA6jevX5A1gGp5ks4HgPh0n/YxThnnm7LELiA7DTpDheAsJ79aB6UvvzF2odBvfI3Seh89RiaLCvi8eWCZk823W4zPBi9vvLhVgFxbRo1CqxzonbfakNjWXYjP1F0Vpp0o5boZVlLeOLkxAr2fiY/SnWN9xs8IYr6iFwffRmkFLLHMI/YR3lh/1W5LgOdndarUkGHVJipzzKPBebZ+7SiE6vs8INqrjJbmuXa7kKoX6tEL+dJsTw1mBj/hhvvSS/n0M0br46IbkNaUVu3ow5VjpzMFRAAvwJMkAodeIdXzXMRMfE1hybxsXTQF5fOTxd/qoiriMHbVUBO+RjEAEPrhVvsNjPEc9wWwKnXbERXCa6QRD40o1XvBorsvDJEH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82960400001)(86362001)(66946007)(316002)(6486002)(6636002)(66476007)(31696002)(66556008)(478600001)(38100700002)(44832011)(26005)(2616005)(6506007)(4326008)(8676002)(5660300002)(53546011)(83380400001)(6512007)(8936002)(36756003)(2906002)(31686004)(41300700001)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0FzNVA2aW9Td29kZnNpc3g0S3hHUHRXRkppYnlXN004TzRBZzVKTFFjNGhO?=
 =?utf-8?B?Tmt6NXQ5U0hHYk14ZUoxSjJEa3dPSmorZmpoWUVpSm5lSzBjYnplb3VSQmpk?=
 =?utf-8?B?Z2FrZmx3Mm01eGdaOUVIbExwZnkxeUwvbzBYUzZYbndxMDFqNVJYaGhTcUJx?=
 =?utf-8?B?MEJpdE1SSnFXWW95SUxJU0VveVVtODR3eUxlQ3YzZ1p4RkpFTFFKOEhLK002?=
 =?utf-8?B?clVBZjdVOHYrUUJ0bmpSRzhmNjE3WHlJQ3BIcExtNTdXT3NLR29ib3hvdmh6?=
 =?utf-8?B?Y2VRM2EzUzU2ajNCd3RkWGJzZFZseDY0Y3B0OHFRbzBla3dzV1Z5ZjhZYkp1?=
 =?utf-8?B?dWFPZm1BZHZEOXVENmJpZXVnd3FKRTdsdlBsaFNxREloaXk1NFI3MmZiRXQ4?=
 =?utf-8?B?azBWYTlsT2EzcWZ0bW5EemxzUm8zL1p5SkhIY2hzT0dmS2RpRnNLTTVzUXVI?=
 =?utf-8?B?VkZWQUtZc3Q2eDV2elp6aGxOMlUrcWxRSEZIY05FYkFzT0NQT0JtbVY2UENE?=
 =?utf-8?B?MGpTM3ZZNU03dUhpS0p0RiswNUlEMGFseE9vcWdySFg0OHZHZHRoeDBRSlBI?=
 =?utf-8?B?ek5tV0grSDlidnlNQUQyTXFibEJZU0p0Zm9KSEtHOWhEYko1aHQzeWhYT0ht?=
 =?utf-8?B?dFpOQUo3dlRnbG91RFBSSE56cXpqbVVuam0wTncvZHlzaWxZTDhuRi9PcjRu?=
 =?utf-8?B?bG4rc1REYkNQdlhOeEM5YjlUZTVkS3JEVjQrVTl5NHlOazdZWS83OVdMeVpj?=
 =?utf-8?B?RWdVMG1TL0twcWVVanFhQ1lxdVpZTHBEVXJLS2ZiSVMyRVl2YXZzVE1FT2Zw?=
 =?utf-8?B?QUFtV0RXRTJDelBBSVlEYVAwaU02U2h0dWJhc1ZiaUpHcWhVcGZKdFJBaGp5?=
 =?utf-8?B?eHk4QnpwWnEyZC9Tam5vdVRhVXZqS0lkSlFjWG5VSCtMYmRTcVJScStHM0pa?=
 =?utf-8?B?VkJqekFEaE5ZV1JWWUxtbDdkaFZKYTNZanBDSE1JaEFUNitDRXozU283UW5u?=
 =?utf-8?B?cDV0ejlvM3YrelUvQ3kwYkFGdGFkVk44MXhDMFAvTmdBQ1Y5YWVRNkhYZnRT?=
 =?utf-8?B?anFKMTlZV0laYnRYM29jODh5RDdUVGRneFllSFhrWC9WMEc1SE1EYThZRU8w?=
 =?utf-8?B?M2NkUHNNcjhRQkxtRjVBUXBVRVB0YnVIK00rbzNwNlN3czROTkUyQytUdkxE?=
 =?utf-8?B?UkV6TnAwOXBDWXdFNWRTRE5DNjd3M2k5L0hxQXU0a29UZ2xlWW81NytoNm1h?=
 =?utf-8?B?QVk2RzdWZmNkeHFIbWdsVVhQak0valI0SFhrZEhrRUNZQjliSytITGQzT29t?=
 =?utf-8?B?SjM5cjFIbFZBTUJLNTRaTStXd1NxTWNHZkRkbit6bVpzdFVTNVpPQ0lUeStD?=
 =?utf-8?B?WDlYcXY4TUxvbWpRcGRRcjVnVG5zNVVwZm5DSVBkQjdHT1ZyYUlnQUorQk9L?=
 =?utf-8?B?d1ovanM1R20vUGdJVHdzNWtUakxSd3kxQ1NEVXVjTGNvWHMxNkVTbnJpQ1JI?=
 =?utf-8?B?OU1sU0t2R0dNTDhjbVR4YkR0NFV1b3dOSWd4SUY0WGljd0pMeFNybHpkUE55?=
 =?utf-8?B?UW5ORFJzVmFpK3Z3WXhBT3R0SXFtUk9MRTJ5MUdpam9lVEdGemNKV1Bla2xi?=
 =?utf-8?B?TDMyVFNqck4wZVZ1M0FPbGNUTHhqQmJOYlgxdE9rcVU2L3FYZjlqb2tzaU5s?=
 =?utf-8?B?STlJNS9Md1FkSGxnTUR4cFU5MUF1QmZYTG1ZT3VuSGRLUkphVkNVbklLK0ND?=
 =?utf-8?B?MzYzc2YzL3RrMjhCSFl1UUtacVVBWUtQOFB2QnRhOG5jMk51Ym8wZ1NmZzJO?=
 =?utf-8?B?SXNSbWxtWlFKQjJ3bnNGNXNPdzBueGdaSmVkRW1OZlMzbXltc1lYMk1ML0t1?=
 =?utf-8?B?N29PQmxxUklxViticm53dTBZdG14K3A3Tjd6dmoyV3NNb3V1c2xZaC82b0ha?=
 =?utf-8?B?M0Q2bk0xclZLM2xCVW81c1J2TWxRS1hjTjk0TXFibXpKNGZaUG5CbzZJYUhh?=
 =?utf-8?B?SjJNaDBQazd3TUhUazBKM2M0ak5wNXBOaGhSRUtCTGJrdDA3NHpGOG9jVzZC?=
 =?utf-8?B?STBOcDhiaE9Nc3czaksyLzZ6S3BEM1dGMVdSU3JPZGFVdjBwbjQ1SkRQK0ph?=
 =?utf-8?B?d1dNV2gzV0xNRTZHM0I5cCtaS2czSlp0ZURmaFdvT3QrSGhIdUZ3NTdoMkp1?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0800927a-7f7e-4116-962d-08dc1eb2ffd7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 21:08:52.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zl9d9+zpFUxxAnwW5eYacE7GU+BBzFpvb4T/H6lGqkMjLRtu88YHT6oCFoVJQW6OXsxJifsnHymiG0M5oousKj7/Uq7UXVzkmHW/lRTolDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/25/2024 3:12 AM, Maciej Wieczor-Retman wrote:
> Feature checking done by resctrl_mon_feature_exists() covers features
> represented by the feature name presence inside the 'mon_features' file
> in /sys/fs/resctrl/info/L3_MON directory. There exists a different way
> to represent feature support and that is by the presence of 0 or 1 in a
> single file in the info/resource directory. In this case the filename
> represents what feature support is being indicated.
> 
> Add a generic function to check file presence in the
> /sys/fs/resctrl/info/<RESOURCE> directory.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Split off the new function into this patch. (Reinette)
> 
> Changelog v2:
> - Add this patch.
> 
>  tools/testing/selftests/resctrl/resctrl.h   |  2 ++
>  tools/testing/selftests/resctrl/resctrlfs.c | 26 +++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 4603b215b97e..c39105f46da9 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -138,6 +138,8 @@ int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
>  bool resctrl_resource_exists(const char *resource);
>  bool resctrl_mon_feature_exists(const char *feature);
> +bool resource_info_file_exists(const char *resource,
> +			       const char *feature);

In addition what Ilpo commented about other line, this too can be
on one line.

>  bool test_resource_feature_check(const struct resctrl_test *test);
>  char *fgrep(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index e4ba8614fb7b..a6427732e0ad 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -763,6 +763,32 @@ bool resctrl_mon_feature_exists(const char *feature)
>  	return !!res;
>  }
>  
> +/*
> + * resource_info_file_exists - Check if a file is present inside
> + * /sys/fs/resctrl/info/RESOURCE.

As confirmed in the changelog this is intended to be a generic function that
tests if a file exists ...

> + * @resource:	Required resource (Eg: MB, L3, L2, etc.)
> + * @feature:	Required feature.

... so assuming a use of this by referring to the file as "feature" is unexpected.

This function jumps between "file" and "feature" in comments and code, please
just stick to goal of making it a generic utility that checks for a file and
refer to it consistently so.

Reinette

