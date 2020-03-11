Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83218233D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 21:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgCKUWE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 16:22:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:58449 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387399AbgCKUWE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 16:22:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 13:22:03 -0700
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="277507925"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.23.31]) ([10.251.23.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Mar 2020 13:22:02 -0700
Subject: Re: [PATCH V1 10/13] selftests/resctrl: Change Cache Allocation
 Technology (CAT) test
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <51d0f3c928fbc310c85bac6de20745f69cbc423e.1583657204.git.sai.praneeth.prakhya@intel.com>
 <4ac6fd87-1393-f247-40ae-5d6e34403e0f@intel.com>
 <8645c93547ae6c4e35633dbb09d9355219d9e3b2.camel@intel.com>
 <e22014e5-8ffc-7966-b260-a0665f771ee2@intel.com>
 <38e679141c12108749a402fa60ef1810ef054bc8.camel@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cfae253b-9df2-8e5c-7b87-d5b8c6ef594b@intel.com>
Date:   Wed, 11 Mar 2020 13:22:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <38e679141c12108749a402fa60ef1810ef054bc8.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/11/2020 12:14 PM, Sai Praneeth Prakhya wrote:
> On Wed, 2020-03-11 at 10:03 -0700, Reinette Chatre wrote:
>> On 3/10/2020 6:59 PM, Sai Praneeth Prakhya wrote:
>>> On Tue, 2020-03-10 at 15:14 -0700, Reinette Chatre wrote:
>>>> Hi Sai,
>>>>
>>>> Not just specific to this patch but I think the prevalent use of global
>>>> variables that are initialized/used or allocated/released from a variety
>>>> of places within the code is creating traps. I seemed to have stumbled
>>>> on a few during this review so far but it is hard to keep track of and I
>>>> am not confident that I caught them all. Having the code be symmetrical
>>>> (allocate and free from same area or initialize and use from same area)
>>>> does help to avoid such complexity.
>>>
>>> Sure! makes sense. I will try to wrap them up in some meaningful
>>> structures to
>>> pass around functions and will see if everything still works as expected.
>>> If
>>> not, I will comment why a particular variable needs to be global.
>>>
>>>> This patch and the patch that follows are both quite large and difficult
>>>> to keep track of all the collected changes. There seems to be
>>>> opportunity for separating it into logical changes. Some of my comments
>>>> may be just because I could not keep track of all that is changed at the
>>>> same time.
>>>
>>> Ok.. makes sense. The main reason this patch and the next patch are large 
>>> because they do two things
>>> 1. Remove previous CAT/CQM test case
>>> 2. Add new CAT/CQM test cases
>>>
>>> Since the new test cases are not just logical extensions or fixing some
>>> bugs
>>> in previous test cases, the patch might not be readable. I am thinking to
>>> split this at-least like this
>>> 1. A patch to remove CAT test case
>>> 2. A patch to remove CQM test case
>>> 3. Patches that just add CAT and CQM (without other changes)
>>>
>>> Please let me know if you think otherwise
>>
>> I think this patch can be split up into logical changes without breaking
>> the tests along the way. In my original review I identified two changes
>> that can be split out. Other things that can be split out:
>> - have CAT test take shareable bits into account
>> - enable measurement of cache references (addition of this new perf
>> event attribute, hooks to get measurements, etc.)
>> - transition CAT test to use "perf rate" measurement instead of "perf count"
>> - etc.
> 
> I think we could split the patch like this but I am unable to see the benefit
> of doing so.. (Sorry! if I misunderstood what you meant).

Separating patches into logical changes facilitates review. Please
consider this huge patch from the reviewer's perspective - it consists
out of many different changes and is hard to review. If instead this
patch was split into logical changes it would make it easier to
understand what it is trying to do/change.

This is not a request that I invent but part of the established kernel
development process. Please see
Documentation/process/submitting-patches.rst (section is titled "Separate
 your changes").


> As CAT and CQM test cases are buggy (CAT is not testing CAT at all) and we are
> not attempting to fix them by incremental changes but completely changing the
> test plan itself (i.e. the way the test works), so why not just remove older
> test cases and add new test? I thought this might be more easier for review
> i.e. to see the new test case all at once. Don't you think so?

From what I understand the new test continues to use many parts of the
original test. Completely removing the original test would thus end up
needing to add back a lot of code that was removed. Incremental changes
do seem appropriate to me. The logical changes I listed above actually
has nothing to do with "the way the test works". When those building
blocks are in place the test can be changed in one patch and it would be
much more obvious how the new test is different from the original.

>>>> On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
>>
>> [SNIP]
>>
>>>>> -static struct perf_event_attr pea_llc_miss;
>>>>> +static struct perf_event_attr pea_llc_miss, pea_llc_access;
>>>>>  static struct read_format rf_cqm;
>>>>> -static int fd_lm;
>>>>> +static int fd_lm, fd_la;
>>>>>  char llc_occup_path[1024];
>>>>>  
>>>>>  static void initialize_perf_event_attr(void)
>>>>> @@ -27,15 +27,30 @@ static void initialize_perf_event_attr(void)
>>>>>  	pea_llc_miss.inherit = 1;
>>>>>  	pea_llc_miss.exclude_guest = 1;
>>>>>  	pea_llc_miss.disabled = 1;
>>>>> +
>>>>> +	pea_llc_access.type = PERF_TYPE_HARDWARE;
>>>>> +	pea_llc_access.size = sizeof(struct perf_event_attr);
>>>>> +	pea_llc_access.read_format = PERF_FORMAT_GROUP;
>>>>> +	pea_llc_access.exclude_kernel = 1;
>>>>> +	pea_llc_access.exclude_hv = 1;
>>>>> +	pea_llc_access.exclude_idle = 1;
>>>>> +	pea_llc_access.exclude_callchain_kernel = 1;
>>>>> +	pea_llc_access.inherit = 1;
>>>>> +	pea_llc_access.exclude_guest = 1;
>>>>> +	pea_llc_access.disabled = 1;
>>>>> +
>>>>
>>>> This initialization appears to duplicate the initialization done above.
>>>> Perhaps this function could be a wrapper that calls an initialization
>>>> function with pointer to perf_event_attr that initializes structure the
>>>> same?
>>>
>>> I did think about a wrapper but since pea_llc_access and pea_llc_miss are
>>> global variables, I thought passing them as variables might not look good
>>> (why
>>> do we want to pass a global variable?). I will try and see if I can make
>>> these
>>> local variables.
>>
>> My goal was to avoid the duplicated code to initialize them identically.
> 
> I agree that duplicate should always be avoided.
> 
>> It is not clear to me why you think that would not look good.
> 
> I didn't mean that avoiding duplicate code doesn't look good.. what I meant
> was passing global variables around will not look good.
> 
>> Perhaps I have not thought it through correctly ...
> 
> No.. I think the right thing to do here is not use global variable and hence
> avoid duplicate code.

ok.

Thank you

Reinette

