Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C412696AB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 18:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBNRD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 12:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjBNRCw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 12:02:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D5B2E0D0;
        Tue, 14 Feb 2023 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676394139; x=1707930139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CXPu1nR7+jSjC3dTDX7VcMREo+AlV6uS/1WfZFeC/Os=;
  b=Tc5Iu8rlqabB8bT023b7lhYJTneawjzYmFeMQnDhK4dKndKm/k/c9NO+
   hn6whu/ExtjCP2B2ti//nZZpgyuAZHaZpdCsfd+86P46mgG1tyHIucPO7
   F4LdbvsAHi+7ui1DegZix55w4vU0iUVWJnxbrYL4O+2ZcFXyLa7Vy1Ii4
   zkrnoMK+UyIPpZultu0qacNMErQglDqrnuoQWXY/RnGIMW0o3YVYCEH5D
   AgFU9ntUDRrXaBRbQvuRQB3vtXNQEi0ApZWA4sjB8We8fWe1PUFS0zAeW
   k/y4j0hOrzficfoocDa5CSsZlGoZnMnm8di5jtgOSRjdQyFOR5+T8IoCx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="310839924"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="310839924"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 09:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="843223821"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="843223821"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2023 09:02:10 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 09:02:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 09:02:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 09:02:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KD2ZimYDBBxbyk4gzq0lA+LBEBsogYdpZ8Ibb3rVXOTP7Xl3t2kmlR1whnsadZYaLm7iQuxUuFeZyQEAVJGjhHZcDJ6a/yktX6FhoGTPxf1JpgGhKVaSUx6OenekMD+N+46a3Oz7h5bCibcnjtk0hy5GkIFyYVh0tsdW2PY2TIuQcbCdGIxJRe+mZNy6fp6EtwIjnMYKRYrfU9thE93UJN1GLDcKqxwoMN9djZSj254JyNrq+cvcZp0Y+UHQPVDbfYbyZPmUnXZnbtvxoU88S2uOdpSea5saa23WZjtkJ5VSWv8jyntfTWeXOXaYqhXiQgKbFFsyPtNjGlg99kBYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9kP1uz4tP/KJNw/I7rb7FPqZnMi39Nrvgp38t6+8y8=;
 b=JebxBTi5glongAHLObAZUeSdAzMmmNPGgLslx/SEveP7/QD6wsIY6r4144cs8g/M3Af/W2RlAk7kBtQcYgimRgmchRFLTRDb0zzj8NWCpmtXn/N5+2KJ4uA+wCmEz1FIVVyEMDCc9STFTBROYDF0n1mgOeMpLa/BqL0DvMkrqIAjYYiru/fMq/+zDdnruF1PC/ll75YVEda5AKT8548YXv/veZTVSroMaIwIX50JtWTGD7tfvTS3x54irHJv6hLaq/zJ4cxRYsAPNqXPGnJgcG2htP1pv7cjINJtfJnnRZcCmo2oiZqL1vC4Da5ZZjheUvhqJkgMJ/f55TP5Gjzx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 17:02:01 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6086.024; Tue, 14 Feb
 2023 17:02:01 +0000
Message-ID: <cbb2d9ab-861c-12ad-3a57-74fb59d08037@intel.com>
Date:   Tue, 14 Feb 2023 09:01:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] selftests/resctrl: Return error if memory is not
 allocated
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
References: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
 <20230208093016.20670-2-ilpo.jarvinen@linux.intel.com>
 <88a819d7-b236-aed5-7cb8-6659e3f9f405@intel.com>
 <a4b44d-23f8-6df1-e494-908fbd43b732@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a4b44d-23f8-6df1-e494-908fbd43b732@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 5267e4ab-84af-4010-81ac-08db0ead3081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Gn8/CY6Oqx9Y2iOyCWBkxByqxyiBC4IbDQbf7TC+ejKKaVJIOeJpHsY1HWcrkVW7KdfVcqqhAUXhn8g+8UNZstIr/aLx0AbF7geIXkBegLhPstmeNAHPkNynd+7bixr+JV+wH9i3jnhk9RlcEoHmzTnuubQ2Uz+Ql1ospsJv+X2D0osdlAQT7Bc0LFw9KobHg/ng8tGOxQRK18Vp7Wla9wqC4w5B1gZRwsNi/5gSH5WUZJU2eFejnePFndOkH3rD8BfWCp9dEVn1hqnXZp8C0VnqZU0nyP5eiiPAtnRTB6k1nnHeHAT1JSdIVbfpM+dQPUlSsHwXZLqBQuLh0i3BAyctNps4DQ0cfVILGXNgWdAdfHA2Hvz7ts4oZoI9sQyHE1+VqVAWOFeRLl8nEXst6EGRsiqGv6XEXt2UvgR+Yg+VOguGtVRLEEFrpA82DqVC76SN0M/F4btmHpVzU7n6YEUlsY31I1tEt7Fzt3IzYNz0CXD8tPrqKnxgo7daagIkieEv7nA1C51+ujCIWZmnSEAgXp/HWXeGMuQJrnU/f7zqM/1tdWqzcWmbkpo9Fw5R0SribjxNPDLTyCOFoTE0+gC5i/lCKp6hy6xdhUpuLe9eRyadJvZdYSfTXavsSQj9mRG1xKdP93OibCRoWR4IZaIFXrIhUsGXxmYtpvqAik4oGot4KolqT/Srtrjh34b47I2nSnZ6yUE4q8eY0fPmGrjxrxe96hBz2f++N9QzXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199018)(8936002)(31686004)(5660300002)(41300700001)(38100700002)(66946007)(44832011)(2906002)(4326008)(82960400001)(66556008)(66476007)(8676002)(6916009)(316002)(478600001)(86362001)(36756003)(186003)(26005)(6486002)(2616005)(54906003)(6666004)(53546011)(6506007)(6512007)(31696002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anR1Qlc3UmZDaVdjTWFndm1jUG91cUlReTZYZlZPMk9mM1dOTlF2NC9SdUQw?=
 =?utf-8?B?T0RtNmhTY21WVlhheVdDcFFHNGY5Y3dTaE13MFY2ZGpvZWZUQnNJNUVEL1Ru?=
 =?utf-8?B?bmd6dVdWREQwTHp2UEdjcE1zaWViK2ZXblN4OHY2VmtsclNJV0JNK25wK0xq?=
 =?utf-8?B?SGl6b0xnNWJCL0k5U1ZOVW9BN2xsM2w5djJ1TmRPUnBvdUhWLy93K2Z3VHFP?=
 =?utf-8?B?cEdvdmFHZXU2dFN0SmVXdk8wUi9ZaldweUJWYitJNVpHWkt4TGdlTGdUTTdK?=
 =?utf-8?B?NUthcWZ5OW51Mm80ckUvMUozaDVkWVlLeTlFRWxuVWNCMUNkTnNIbThJSXNO?=
 =?utf-8?B?SHprYVBRa09Jb0lWM0FUSWlJWnBUUmNhT093ekJHMWF6bzU1TkszZiszU2Ey?=
 =?utf-8?B?SE5ndjVYUEtWTG1jSFFhbDhPY01JRlhRK0o5dGFUZTlOL3lyRk52dHdqMnBz?=
 =?utf-8?B?YnRZM2xpNnZHb0gwb3hjWnFHalNUSXRkWWpvdVJ6Um9lWXB6MTJMSWZZZXV2?=
 =?utf-8?B?YXR2NjNESW5xMlVWMmhlR0l1WE14RGpyWjgwTkcxN253bkxjTjJScmRRMGtF?=
 =?utf-8?B?c0krcW5ZVnpLRSsrSlVBa0grWVliS2EweUJ0TTRWSUtHaUNUbzVGcE5nV3Jx?=
 =?utf-8?B?Yi9CdlZMWm1DUHBDMTVUb0Z4NDBTeVdBQm51TkNYRm5seVQwV3JkcVZQUW5z?=
 =?utf-8?B?WXZXVzMwdzF5ZXJ4SjQrYUVySk9ZeVVkREhzMlB0VE1FcEdvaUgwekNBRVY4?=
 =?utf-8?B?bTN1eXhKK3VjYXhWT1dlMGRiMHV6MnMxcTRGaE1odEhHcEk0Q0NlLzNxbE1B?=
 =?utf-8?B?VjlIMEVWWjZYaHpiY3h5UmVvcHV3bXd5SWtPTWVPeWwxanlFeFFvTG5OK3J3?=
 =?utf-8?B?WFN4Z1NkMHFVT21QNXlzK1FhenE3QU1KRDVlZm5YdURjSWE5VXVlTW1WTWls?=
 =?utf-8?B?dXphTE1tTjZSYnIrakJJaGcxNnRrTktYcDc1ZW9mTmg5NGN0Undpbk1nZjVF?=
 =?utf-8?B?WlB6YVRLNVBMd1lVNTNwNFJMZktVd1h5cTlBRCtmSndTdVJ1T05JOGRKbXVY?=
 =?utf-8?B?RytvVCtYSUdaSkpMZVpPbHRqSDdySWRrZXl5N08xd2lLTWRQRjlXWVNUVGZy?=
 =?utf-8?B?TkRvcGlVNStkdXcvZWN3N1hMMkUvaWVabGEzSzE1bVhzVFJJZ214TG9SUU9E?=
 =?utf-8?B?cnlGaVZ6Unk0aFFXRW1YU284TzNUalQ3UnFYbndML1V1cXM4NjN3cCtJS3dT?=
 =?utf-8?B?Y1NpcjNNc21iWDdqUkpGSHlaakpENTNYWllRdEpDRnJHVlJzR2tCbnlZZmZw?=
 =?utf-8?B?aU1vV3hKc2RWWlVQNDlGTC9OS0FYaVdlN1FFdXFRREVVRmtUMlpnaTBKdlZp?=
 =?utf-8?B?UkZnZUVZb3NMTWNjR2VRK2ZoTlN4MHNaRmFsS3psc1VKOXluOWtxa2YvUCtM?=
 =?utf-8?B?c1dnZlpvVlBnNEc4ejRRVXJpODFTWk1RN24zVUlFMEUwZ2YrRnBNb1JBSTBi?=
 =?utf-8?B?bG9aamtGSFFBd3BkUjJjREQyZm9WOGNsUnpiR1FxNUdnMzdFTG5DdlJWSEZG?=
 =?utf-8?B?VkxwVjM4VXUxYmZaa0toVEU0L0M4QnNacVo5eFZmTVlNUEd5N0t5REZJNExh?=
 =?utf-8?B?YklsVWZmVG5EcW9vK2xzMWlpRGZCMUpaTzhHNkFUNXJVQjBxYjBCbmRQcnZK?=
 =?utf-8?B?UzVHNFhoZmhTOXRiRzZUT044YlJFUUxwZmpBTXg5anpDalF6TXdOdUxWS0do?=
 =?utf-8?B?OWc3TU80UmNkaU5pRVBVSkFQQnovTGNwam92NnkvVFg5bUJtRXZ6UjU2eTJT?=
 =?utf-8?B?TCthVS9LbUhmdFMzVjFVZit5blpMd09mOE12dk1pbVVqZDJOTk9TMFVvMmkz?=
 =?utf-8?B?QW9PMmlXWVNtVXdVQmx5Q2JYRUFhRUdqc0YwZ1ZrVVY2Qi94TU1oMUIreCsx?=
 =?utf-8?B?cnZtTVFpUVhvRndQRWM3K2JDRnEyc2hzUitmamNNNTd0Y3NpcVBhMXRZeDZz?=
 =?utf-8?B?MzNUZWg3L2VwaEluNnVoVm5VR1UrdWhaQUh3bkQ2c1ExV1F0MFUrTS9iaUU3?=
 =?utf-8?B?ODlFZElMRUpmSGNnb3Jmd2M2amJkbmMveHMvVFBzd2E0ZUVDZGZZT0lNYWE3?=
 =?utf-8?B?ejFmbHBoODhpaU1UczZoUzBuTURtaGtQaWhZUTROS1VGcW84aWFlTndaMnVo?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5267e4ab-84af-4010-81ac-08db0ead3081
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 17:02:01.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfqPyd7MGQR+HEH1wjhw9DeLOqLwQKpv7ygoCxozIfs3qFUbxb29hKXJ3IsUvsrKbl4F0kYjPyXkmJtHYGa1gOJj1UWW7o82NkGTNzrVQDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/14/2023 1:32 AM, Ilpo Järvinen wrote:
> On Mon, 13 Feb 2023, Reinette Chatre wrote:

>> Missing your Signed-off-by?
> 
> These were intentionally. When I didn't modify the original patch at 
> all during forward porting it, I just kept the original From and SoB as 
> is. But from the doc you pointed me to, I see now x86 wants also handlers 
> sobs.

I do not think this is x86 specific. 
Documentation/process/submitting-patches.rst states:
"Any further SoBs (Signed-off-by:'s) following the author's SoB are from
people handling and transporting the patch, but were not involved in its
development. SoB chains should reflect the **real** route a patch took
as it was propagated to the maintainers and ultimately to Linus, with
the first SoB entry signalling primary authorship of a single author."


> 
>>> ---
>>>  tools/testing/selftests/resctrl/fill_buf.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
>>> index 56ccbeae0638..f4880c962ec4 100644
>>> --- a/tools/testing/selftests/resctrl/fill_buf.c
>>> +++ b/tools/testing/selftests/resctrl/fill_buf.c
>>> @@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
>>>  	size_t s64;
>>>  
>>>  	void *p = memalign(PAGE_SIZE, s);
>>
>> This may also be a good time to stop using an obsolete call?
> 
> Sure, I can add another patch to change that to posix_memalign().

You can also consider aligned_alloc().

Reinette
