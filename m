Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2249564E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jan 2022 23:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378062AbiATWVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 17:21:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:47045 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238984AbiATWVE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 17:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642717264; x=1674253264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=438dHuENi8j+9xe6HmDO93zON2rXVS/dLu3WontH3E0=;
  b=E8JRI9DN8wFTm7aCViRmznC24hk0E4liV1knmvm3nUuKeuTMF5nxfT/h
   bazSTeIvQcSqSYVH3fLYONg81NiSNUrT+V6mwg6/qLN3sPXZaybrdNQw1
   A73I07A8gX0uqWiayM+lEZpK0CUbLePjb7aQuyN9ybs4KMo+pIgex5s2C
   MUujhJkkIz/2jPDxCvmDKKOPWYIhAZhWlGh6M4fgf15JWoG0qaOUsVDfG
   k+uUw0wMnXzdxDLZytH8V1Kkd/GUzS/gI4BsYiNeO4blfv5UgzMIG3WHV
   SkPqJfgchShSBmSwWpF6LVPuZcPxzTdxdcPXxKmwXWUBs3TxwsQ2CiA0x
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="243073555"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="243073555"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 14:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="561634402"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2022 14:21:02 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 14:21:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 20 Jan 2022 14:21:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 20 Jan 2022 14:21:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nylv0Mqh2pOvP+g+gd7z4YBOGBeuasx5KtWBF9mXsFrYqG362RFiB8RPhAMdIlrIh7G6PezbZay8OUAyYN1R/wEVQe1IQXKBG+MP51arnvZGLd6xppedEGGPmRkSS5f6dYDMTw1G2kK9ngqATD1WV5iKrHfhZBZVjdxC712mzgVME2FApIaZae8iIlrZpOlcMenZA8o70VLqCQ9kcqJe9/Y/PtYyiMrwR7QTJ6zHqIgZHtfO35Y1KvmYCeHDMjwV3TPKOc+kMiPSS3k6qy3FL07+mJOG1/l9bhTzmdFSWlm+tKx9wnxfaZnwx6+1iae4oKt6vsF0gzJlb8zfaEjuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlsmgq4WWY8hdESVWwAQYUX5o0CtvjgVV90RX2H+L88=;
 b=Yt2g1neX8FUuVv18g+WoQSQ93eBRhtWP2Xm9tFfktBCn+7yslW5Pgf7J8Bi+Nr4uut1SmjdC+AH+ZpWO3w7S1zoiYiCs7SmUJ1ARtp2Wdm+maFW9ObwcA2FwT66auYjSM1w1dal6lZacBV+mBwZ/aCMjU67BoTnHw3GQ7KgM6e7igJIzE6+DvS/Zoi+3M08oANbwSObRdVCRtIFVa4jpcGSk3wNxmQeFuxwbnoeAMiGO39fqzxbWoXuJaEpw0eSqT3UeY1mgbXnjzVwxd8E85Elvu3NurKTQkyhdq1VRExh0Qjv67Z8iLKKppCHMwyL002R5QvpkZ/SzAjjbVdTrQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 22:20:57 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::fc15:bd26:128a:f5f5%8]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 22:20:57 +0000
Message-ID: <d27cf495-c88f-d5f5-e68c-3dc03eff7a73@intel.com>
Date:   Thu, 20 Jan 2022 23:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [RFC 00/10] drm: selftests: Convert to KUnit
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petri Latvala <petri.latvala@intel.com>,
        Arkadiusz Hiler <arek@hiler.eu>
References: <20220117232259.180459-1-michal.winiarski@intel.com>
 <CAGS_qxrL8Ey8sq3Mk586dBQtdkAMK9WbeTKC3OGL6r09uEwEKA@mail.gmail.com>
From:   =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>
In-Reply-To: <CAGS_qxrL8Ey8sq3Mk586dBQtdkAMK9WbeTKC3OGL6r09uEwEKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae15bb5-c670-4418-686a-08d9dc6321af
X-MS-TrafficTypeDiagnostic: SA1PR11MB5921:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA1PR11MB59219B5B05210EE5A321C36B985A9@SA1PR11MB5921.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVG1sMgalx4KKax3KLtan0Pn9pxkpNan2SeMWov0p9tPdU/68B5EijptLnCWOaUr/Q+nwA/xux8n60I23vxnGF7Hu4OoQ9NmmAaAZmwVb4HEmkrXZ2G5JUUx2ozG/xGJpkTmQrZUhlPdCLxlhwSwRpHbQHcgd9BPX3ubZb6neTJwP9KBJS1kJDuuoefaPqSHlrM0yKK3v6SvrrevK7mDwbwzjZYK5RlSvamja/VIO5r7CbFzk4hFSs7Zt4MnrCguZuL8YqxqbXCdLwgZLFZBohm9VsaqiFAmXY4AW7Kp1vK98mlVFIul/V/Oua3WH1fyrwRIFWSWgaqql4UirF+3WHfWTKisNr0JSDIAREe2miVRV1/wkowPrQincz/sqtpEQNfCNpTOoMO0XQcRNUpAhS+JcDP192uAD9jqW54F0piFR5XjHd61UXFz8rY7Yf38YSqDH3xXUIVUp9odD6boVHrXl+OAziSH7q2Ru+E1FkX4q0c63cw6sygHH59XZKhc4isCsmaepkQlyHzJMviVE17r+MmNdi7XGgb8z4pfBv1+7daQ626RTvKmbU8dSRE2v9VSzej9q90/9CRofb/WMIzLjV+mS7CL4fBVRHf0J2fGECJLPLRx2BbsRv4/X+C0d3JBMkkSqmZ9pr/6o4Iy8GfWPLDaUToZMUh0txhGFZ0x+TsKHEve2cvfTXFNUjnQR9gUMmx71gJ/XYZiP46Y4W0Sj9z9J4+l6xbhiAXxFplTA9FlCLt/W1iUctHzwWrOt2UHvOK+eS29VHUZ5gogP9qsFyb1IaOQOKrRkZaJviHklZNn9ZOi7MXwmQRn+e8E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(82960400001)(66946007)(7416002)(31686004)(66556008)(66476007)(4326008)(83380400001)(5660300002)(54906003)(6486002)(53546011)(508600001)(6512007)(6666004)(86362001)(186003)(6506007)(2906002)(8676002)(6916009)(8936002)(2616005)(36756003)(966005)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZlYmNhWHB0TnVOUjlMQW5VZjVDNklhM0FBcFRNSno3cmY1cXFJOUpwZ214?=
 =?utf-8?B?NkZKa2FCc0ZRSDFBbnZMejZtRzRjN0EwaTYya2FxZE4wQVNTQTZqWm5iN3pH?=
 =?utf-8?B?Uzd1RzJVRHJiTmJ0emhOMDdQYmNJSDBuTmpuRWFQakxqZEtZSHcyR29QdFc5?=
 =?utf-8?B?VkE4SXdFcGZUb2I1YitkOEJWeTNMeEV3cnZ6NWhEN0R2MlQ3MXRvY3Nab2Yw?=
 =?utf-8?B?OGFWYVl6c3NRY0VjQjNLa3BhUVU0UWlhUU5kT2h6bmVDamsxcnArRlNXbmZt?=
 =?utf-8?B?Q0M5bWRYZ0ZZb2VFZnR0TnZaNW5WcUJwSHB2ZlBCbjFvNGNmUWdxYkVCTFVD?=
 =?utf-8?B?VmJJS0FnNlI0YVRlRlVyN25KVG03VmZ3MTUzbDE1cVBIRWJKUUlMUTl4VFJU?=
 =?utf-8?B?Nzl2SUdCSG5JZWRKRTRicDh4cm92K2UzcUczR0xSdWwrKzRybm9ZaFBkVEJy?=
 =?utf-8?B?Z01NNmxlMHFrL1RvMlU2RUdFU2g5MSt0T1hLRnpPdExHb3BMNzkxSW9QdkVx?=
 =?utf-8?B?Rk1JYW41V3dZWHpSaDloMEJzRmpDc3V5UnZCemRZNy9udUNHT2ZYa1VxR2FT?=
 =?utf-8?B?ZXg4bE9MUUJieFc5QXF0SHFaVTJSQ2wyNXNkbUpNL29oTk9rbHVSNVM5dWl3?=
 =?utf-8?B?ZWExWUtXV3ZuODdCeEV4S090K05wUUlyQ3ZtZXNydk1VQWt1WDRQcjhUc3Yz?=
 =?utf-8?B?MUFuam9adUYzb3Fnci9PZjlYbzhYTmtkcC9rbmNpWk8wamhkU3pzL3FtdEVj?=
 =?utf-8?B?S3VKMk9JdEVJNFpPUzZuK254TlN6KzRjbENML1lxeHd6TGNwYUJVeG1JTHpC?=
 =?utf-8?B?aXQ2SFJ5b0VoUkdpdEc3U1c0R2FQalQvL3NraEZWWUZWTytDdFVOMjVVZ0dv?=
 =?utf-8?B?NG41M21TeVV2Z2VWV05PdGFYUnJEZVNjRDUyMmp5RkN2enZvTmdlam14NU9w?=
 =?utf-8?B?ZjJlWE5WcGFLNUFmWVlGNC9qQXFkRFMxM3ZQaG5VeFA1cmxrVC9ST1RpV3BV?=
 =?utf-8?B?ZDZxWHNOWHR2TDBuQ3FnWStKV1lsalM2Lys4MTI3UTNiOVF4K0FEcnB4V2FT?=
 =?utf-8?B?L1Y0SEs1MzRocUJuY2FhQ1U2cVZPaGtKUjQybmZnRzVLRnpsRDROQXByamNq?=
 =?utf-8?B?c2xmQWtJWmdKWjBtNFZEOFJHcU4vRUJwd216MU5UVUJpcFBRcWJDUk53bzgx?=
 =?utf-8?B?K1VsTUNOWWhPSWJLQ1hJdlB0ZkNpcHQ3NVlDSnd6NUZONm5FNmY4b0JOdlZP?=
 =?utf-8?B?cVZObktBUUpaby9KT1ZNUFY4T2Z0QldMSS9LRmVDd1RVbkpMeXpUK21iZVRk?=
 =?utf-8?B?MkhtNUJPV1VXck9pK01PRkIyR1hxa1BTdnJHMlQ5SDNLc1B0T3d4ZHBKMGU0?=
 =?utf-8?B?Nkt0eDJYcjZIamM2Q29McVgyZmtINFp1MWQxNmp3RVhyUWQ3aGhSRWE0QVRi?=
 =?utf-8?B?bnZUQ0ZkcWVUc21qYzdyeWdqY3pHTWR6aFdpOUhVZ1dIbGZ2QWpLelo2Q3c0?=
 =?utf-8?B?aTZQckt1TFFDVCs2Umo2YlFCeG9MeFJkVGJYS0hUcEtNNjdqYUdSVWViYUhK?=
 =?utf-8?B?b3hOTmJxc0piRTEzQ2Q0SDlaMHdvMkl1Y093Z1I0RVlIU0ZhcmRJRW1QcDU5?=
 =?utf-8?B?UFN6R3dhZ2FkaTJ0V2VGU2pHSXVIaGdzL24zSlFyNy9CTThqRXdCd2c4aXkz?=
 =?utf-8?B?SStxYS9ZM2xIK3psWm1BMERFTXJucU1QcG5PTVVwRUdWRld1QTRaMWkyWU1W?=
 =?utf-8?B?MHBFdU1GYjlNQzJiMzV6d0hTMDBPV01YZ1RmUlAzeWMwNVZpUXNHWWhmYWZ5?=
 =?utf-8?B?enBRWi9UYTBmS2poNTlSV0VtR01adWpLUjhjeG9CdlNLa2w1WGVrTWJseUMy?=
 =?utf-8?B?bHZGai9MRDJWL3lVMy9MZnNwL1lxU3hiVnZvNXpQdzVQVXhibGhNTTFBRHNh?=
 =?utf-8?B?aWpPKzNoaFkvY01STFFrVm5vNmJ3Q3U5d3dtdzVHTnF2TG9pdE5PWWYrMnd4?=
 =?utf-8?B?bkE4NndvMFRMcm5JT2hGOWRiYVRlc3dGQVZIUU45cS9UVnJzcWhoUmU4NlYw?=
 =?utf-8?B?RkxzTE5lcVJndm9JRFVCMXVZdG1sSGlhdE51R2VtMTBxenV2bm5FWXhEMGRC?=
 =?utf-8?B?Z3FHQzNzRnl5ODN1Y0ExQ2xJTWw4Tlc5VHpjdjlCZ2t0b3R2QmhjVEYyOC9N?=
 =?utf-8?B?ek9ubkRLbE56RVNxV2NIN1M4UEZFaWpnUGZmNllUUUEycjF5STd6TWxJalZ6?=
 =?utf-8?B?OTFPaklGQkN6OWM2U1BTV3F1a1k5WmFkVDN3UVBnMHlOUHRHYUhlc3ZwbzNR?=
 =?utf-8?Q?hCKE4xN50ahjSI4tkA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae15bb5-c670-4418-686a-08d9dc6321af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 22:20:57.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpTUTXo4V5dtka3BAh9m8ZebQk3mURism8GsKJiI5f86Edfq0F6Cyz/A5AL0+6Zo+QbdI/oncYq9B3//s/YIUYyGkpWRRsfPbHbnZa6VoSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.01.2022 00:58, Daniel Latypov wrote:
>   change
> On Mon, Jan 17, 2022 at 3:24 PM Michał Winiarski
> <michal.winiarski@intel.com> wrote:
>>
>> KUnit unifies the test structure and provides helper tools that simplify
>> the development. Basic use case allows running tests as regular processes,
>> leveraging User Mode Linux.
>> For example, to execute all DRM unit tests:
>> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm
>> (the tool also allows using QEMU instead of UML by adding e.g. --arch=x86_64)
>>
>> For developers - it means that it's easier to run unit tests on the development
>> machine, tightening the feedback loop. When using UML, it also simplifies using
> 
> Nice, it's neat to see --kunitconfig being useful for having
> one-liners for running tests.
> 
>> gdb for debug (since the kernel is just a regular process).
> 
> Anecdotally, I hear from davidgow@google.com that using gdb and UML
> together isn't the nicest experience because of all the SIGSEGV flying
> around when emulating paging.
> So I'm a bit doubtful about this particular statement, but if you have
> tried it out and it works well, then that's good too.
> 
> I just think the primary benefit of UML is faster compilation and it
> being somewhat lighter than bringing up a VM.

It was good enough to debug any problems that I accidentally introduced 
during the conversion, but perhaps that was simple enough usecase to not 
encounter SIGSEGVs.

> 
>> For CI systems - DRM tests can be moved from being executed on device under
>> test (that's also running IGTs and so on) to being executed on buildsystem
>> during build (just like checkpatch.pl).
>>
>> All tests were renamed - IGT prefix is no longer used.
>>
>> Compared to selftests executed by CI using IGT, there's one functional
>> regression - KUnit test runner is not catching WARNs.
>> To solve this, we could either go in the similar direction that UBSAN went in:
>> 1195505 ("kunit: ubsan integration")
> 
> Is the suggestion that all WARN's fail the current KUnit test?
> I don't think we can do that.

Yes - that's the suggestion.
The CI used for DRM has a separate "WARN" test state, even if the test 
is PASSing, any WARNs cause the test to end up in this state.
For example:
https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_11112/bat-adlp-4/igt@kms_addfb_basic@addfb25-framebuffer-vs-set-tiling.html

> 
> Some KUnit tests will explicitly want to trigger error paths, so we
> could have a lot of false positives.
> 
> An alternative is that we can apply the 1195505 to the code paths
> we're interested in, e.g.
> 
> #include <kunit/test-bug.h>
> if (bad_thing()) {
>    kunit_fail_current_test("bad_thing happened");
> }
> 
> 
> I don't have the context to know how cumbersome this would be for the
> DRM tests though.
> If the answer is we want to catch any and all warnings, then we'd
> perhaps want to add something to the tests themselves. And maybe we
> should implement that as a KUnit library helper function so that other
> tests can use it as well.

I don't thing that would work. IIUC, currently the runner is operating 
on taint - there's a subset of taints that it considers "fatal" 
(including TAINT_WARN).

If we have tests that WARN, perhaps we could introduce extra flag to the 
test state on per-test or per-testsuite level, to mark that the test 
wants to fail-on-warn?
Then we would only fail if the test opted in (or other way around? if 
opt-out makes more sense and we have more tests that actually don't WARN 
as part of their normal test logic).

> 
>> Or we could expand the test runner to catch WARN signature in dmesg.
> 
> Ditto from the above, I think we'd wrongly mark some tests as failed
> for intentional warnings.
> 
>>
>> Pastebin to preview the output and execution times:
>> https://gitlab.freedesktop.org/-/snippets/4139
> 
> I see these take 17-18s to exec the tests in the example snippets.
> FYI, if you're not already trying this on top of 5.16, there's recent
> changes to make the parsed output more fully realtime as well.
> So hopefully that should increase the usability of these tests a bit further.
> 
> I only mention that since I wasn't able to apply this series without
> conflicts on top of v5.16.

It's applied on top of DRM subsystem integration tree (drm-tip):
https://cgit.freedesktop.org/drm-tip
At that time it was already based on v5.16.

Most of that 17-18s is taken by two subtest of drm_mm_tests:

[22:17:19] ============================================================
[22:17:19] ================= drm_mm_tests (1 subtest) =================
[22:17:27] [PASSED] test_insert
[22:17:27] ================== [PASSED] drm_mm_tests ===================
[22:17:27] ============================================================
[22:17:27] Testing complete. Passed: 1, Failed: 0, Crashed: 0, Skipped: 
0, Errors: 0
[22:17:27] Elapsed time: 10.400s total, 0.001s configuring, 2.419s 
building, 7.947s running

[22:17:42] ============================================================
[22:17:42] ================= drm_mm_tests (1 subtest) =================
[22:17:50] [PASSED] test_replace
[22:17:50] ================== [PASSED] drm_mm_tests ===================
[22:17:50] ============================================================
[22:17:50] Testing complete. Passed: 1, Failed: 0, Crashed: 0, Skipped: 
0, Errors: 0
[22:17:50] Elapsed time: 10.272s total, 0.001s configuring, 2.492s 
building, 7.776s running

Their runtime can be controlled with max_prime and max_iterations 
modparams - I left the default values intact, but we can tweak them to 
speed things up if needed.

Thanks!
-Michał

> 
>>
>> -Michał
>>
>> Michał Winiarski (10):
>>    drm: test-drm_cmdline_parser: Convert to KUnit
>>    drm: test-drm_plane_helper: Convert to KUnit
>>    drm: test-drm_format: Convert to KUnit
>>    drm: test-drm_framebuffer: Convert to KUnit
>>    drm: test-drm_damage_helper: Convert to KUnit
>>    drm: test-drm_dp_mst_helper: Convert to KUnit
>>    drm: test-drm_rect: Convert to KUnit
>>    drm: test-drm_mm: Convert to KUnit
>>    drm: selftests: Convert to KUnit
>>    drm: test: Simplify testing on UML with kunit.py
>>
>>   drivers/gpu/drm/.kunitconfig                  |    3 +
>>   drivers/gpu/drm/Kconfig                       |   22 +-
>>   drivers/gpu/drm/Makefile                      |    2 +-
>>   drivers/gpu/drm/i915/Kconfig.debug            |    1 -
>>   drivers/gpu/drm/selftests/Makefile            |    7 -
>>   .../gpu/drm/selftests/drm_cmdline_selftests.h |   68 -
>>   drivers/gpu/drm/selftests/drm_mm_selftests.h  |   28 -
>>   .../gpu/drm/selftests/drm_modeset_selftests.h |   40 -
>>   drivers/gpu/drm/selftests/drm_selftest.c      |  109 -
>>   drivers/gpu/drm/selftests/drm_selftest.h      |   41 -
>>   .../drm/selftests/test-drm_cmdline_parser.c   | 1141 --------
>>   .../drm/selftests/test-drm_damage_helper.c    |  667 -----
>>   .../drm/selftests/test-drm_dp_mst_helper.c    |  273 --
>>   drivers/gpu/drm/selftests/test-drm_format.c   |  280 --
>>   drivers/gpu/drm/selftests/test-drm_mm.c       | 2487 -----------------
>>   .../drm/selftests/test-drm_modeset_common.c   |   32 -
>>   .../drm/selftests/test-drm_modeset_common.h   |   52 -
>>   .../gpu/drm/selftests/test-drm_plane_helper.c |  223 --
>>   drivers/gpu/drm/selftests/test-drm_rect.c     |  223 --
>>   drivers/gpu/drm/test/Makefile                 |    7 +
>>   .../gpu/drm/test/test-drm_cmdline_parser.c    | 1027 +++++++
>>   drivers/gpu/drm/test/test-drm_damage_helper.c |  667 +++++
>>   drivers/gpu/drm/test/test-drm_dp_mst_helper.c |  429 +++
>>   drivers/gpu/drm/test/test-drm_format.c        |  356 +++
>>   .../test-drm_framebuffer.c                    |  109 +-
>>   drivers/gpu/drm/test/test-drm_mm.c            | 2426 ++++++++++++++++
>>   drivers/gpu/drm/test/test-drm_plane_helper.c  |  312 +++
>>   drivers/gpu/drm/test/test-drm_rect.c          |  249 ++
>>   drivers/video/Kconfig                         |    4 +
>>   29 files changed, 5558 insertions(+), 5727 deletions(-)
>>   create mode 100644 drivers/gpu/drm/.kunitconfig
>>   delete mode 100644 drivers/gpu/drm/selftests/Makefile
>>   delete mode 100644 drivers/gpu/drm/selftests/drm_cmdline_selftests.h
>>   delete mode 100644 drivers/gpu/drm/selftests/drm_mm_selftests.h
>>   delete mode 100644 drivers/gpu/drm/selftests/drm_modeset_selftests.h
>>   delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.c
>>   delete mode 100644 drivers/gpu/drm/selftests/drm_selftest.h
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_damage_helper.c
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_format.c
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_mm.c
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.c
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_modeset_common.h
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_plane_helper.c
>>   delete mode 100644 drivers/gpu/drm/selftests/test-drm_rect.c
>>   create mode 100644 drivers/gpu/drm/test/Makefile
>>   create mode 100644 drivers/gpu/drm/test/test-drm_cmdline_parser.c
>>   create mode 100644 drivers/gpu/drm/test/test-drm_damage_helper.c
>>   create mode 100644 drivers/gpu/drm/test/test-drm_dp_mst_helper.c
>>   create mode 100644 drivers/gpu/drm/test/test-drm_format.c
>>   rename drivers/gpu/drm/{selftests => test}/test-drm_framebuffer.c (91%)
>>   create mode 100644 drivers/gpu/drm/test/test-drm_mm.c
>>   create mode 100644 drivers/gpu/drm/test/test-drm_plane_helper.c
>>   create mode 100644 drivers/gpu/drm/test/test-drm_rect.c
>>
>> --
>> 2.34.1
>>

