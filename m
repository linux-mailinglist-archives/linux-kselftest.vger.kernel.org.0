Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525D57524C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGMOOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGMOOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:14:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61FA226B2;
        Thu, 13 Jul 2023 07:14:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 893AF1570;
        Thu, 13 Jul 2023 07:14:52 -0700 (PDT)
Received: from [10.1.30.48] (C02Z41KALVDN.cambridge.arm.com [10.1.30.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A485A3F73F;
        Thu, 13 Jul 2023 07:14:08 -0700 (PDT)
Message-ID: <556d05f0-7103-1079-fce1-1fb6bd40b17c@arm.com>
Date:   Thu, 13 Jul 2023 15:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-4-ryan.roberts@arm.com>
 <cf3c237e-69c8-dd6e-26fc-fe19de910813@redhat.com>
 <773cc0a8-24b8-7fcb-2980-7676fc772014@arm.com>
 <3c566e28-c7ad-7ba8-4583-619266282387@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3c566e28-c7ad-7ba8-4583-619266282387@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/07/2023 15:09, David Hildenbrand wrote:
> On 13.07.23 16:03, Ryan Roberts wrote:
>> On 13/07/2023 14:56, David Hildenbrand wrote:
>>> On 13.07.23 15:54, Ryan Roberts wrote:
>>>> arm64 does not support the soft-dirty PTE bit. However there are tests
>>>> in `madv_populate` and `soft-dirty` which assume it is supported and
>>>> cause spurious failures to be reported when preferred behaviour would be
>>>> to mark the tests as skipped.
>>>>
>>>> Unfortunately, the only way to determine if the soft-dirty dirty bit is
>>>> supported is to write to a page, then see if the bit is set in
>>>> /proc/self/pagemap. But the tests that we want to conditionally execute
>>>> are testing precicesly this. So if we introduced this feature check, we
>>>> could accedentally turn a real failure (on a system that claims to
>>>> support soft-dirty) into a skip.
>>>>
>>>> So instead, do the check based on architecture; for arm64, we report
>>>> that soft-dirty is not supported. This is wrapped up into a utility
>>>> function `system_has_softdirty()`, which is used to skip the whole
>>>> `soft-dirty` suite, and mark the soft-dirty tests in the `madv_populate`
>>>> suite as skipped.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    tools/testing/selftests/mm/madv_populate.c | 18 +++++++++++++-----
>>>>    tools/testing/selftests/mm/soft-dirty.c    |  3 +++
>>>>    tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
>>>>    tools/testing/selftests/mm/vm_util.h       |  1 +
>>>>    4 files changed, 34 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/madv_populate.c
>>>> b/tools/testing/selftests/mm/madv_populate.c
>>>> index 60547245e479..5a8c176d7fec 100644
>>>> --- a/tools/testing/selftests/mm/madv_populate.c
>>>> +++ b/tools/testing/selftests/mm/madv_populate.c
>>>> @@ -232,6 +232,14 @@ static bool range_is_not_softdirty(char *start, ssize_t
>>>> size)
>>>>        return ret;
>>>>    }
>>>>
>>>> +#define ksft_test_result_if_softdirty(cond, ...)    \
>>>> +do {                            \
>>>> +    if (system_has_softdirty())            \
>>>> +        ksft_test_result(cond, __VA_ARGS__);    \
>>>> +    else                        \
>>>> +        ksft_test_result_skip(__VA_ARGS__);    \
>>>> +} while (0)
>>>> +
>>>>    static void test_softdirty(void)
>>>>    {
>>>>        char *addr;
>>>> @@ -246,19 +254,19 @@ static void test_softdirty(void)
>>>>
>>>>        /* Clear any softdirty bits. */
>>>>        clear_softdirty();
>>>> -    ksft_test_result(range_is_not_softdirty(addr, SIZE),
>>>> +    ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>>>>                 "range is not softdirty\n");
>>>>
>>>>        /* Populating READ should set softdirty. */
>>>>        ret = madvise(addr, SIZE, MADV_POPULATE_READ);
>>>> -    ksft_test_result(!ret, "MADV_POPULATE_READ\n");
>>>> -    ksft_test_result(range_is_not_softdirty(addr, SIZE),
>>>> +    ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_READ\n");
>>>> +    ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>>>>                 "range is not softdirty\n");
>>>>
>>>>        /* Populating WRITE should set softdirty. */
>>>>        ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
>>>> -    ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
>>>> -    ksft_test_result(range_is_softdirty(addr, SIZE),
>>>> +    ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_WRITE\n");
>>>> +    ksft_test_result_if_softdirty(range_is_softdirty(addr, SIZE),
>>>>                 "range is softdirty\n");
>>>
>>> We probably want to skip the whole test_*softdirty* test instead of adding this
>>> (IMHO suboptimal) ksft_test_result_if_softdirty.
>>
>> Yeah I thought about doing it that way, but then the output just looks like
>> there were fewer tests and they all passed. But thinking about it now, I guess
>> the TAP header outputs the number of planned tests and the number of tests
>> executed are fewer, so a machine parser would still notice. I just don't like
>> that it outputs skipped:0.
>>
>> But it a lightly held view. Happy to just do:
>>
>>     if (system_has_softdirty())
>>         test_softdirty()
>>
>> If you insist. ;-)
> 
> diff --git a/tools/testing/selftests/mm/madv_populate.c
> b/tools/testing/selftests/mm/madv_populate.c
> index 60547245e479..33fda0337b32 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -266,12 +266,16 @@ static void test_softdirty(void)
>  
>  int main(int argc, char **argv)
>  {
> +       int nr_tests = 16;
>         int err;
>  
>         pagesize = getpagesize();
>  
> +       if (system_has_softdirty())
> +               nr_tests += 5;

This is the opposite of the point I was trying to make; If there are 21 tests in
a suite, I'd like to know that there are 21 tests, 16 of which passed and 5 of
which were skipped. This will hide the 5 from the test report.

> +
>         ksft_print_header();
> -       ksft_set_plan(21);
> +       ksft_set_plan(nr_tests);
>  
>         sense_support();
>         test_prot_read();
> @@ -279,7 +283,8 @@ int main(int argc, char **argv)
>         test_holes();
>         test_populate_read();
>         test_populate_write();
> -       test_softdirty();
> +       if (system_has_softdirty())
> +               test_softdirty();
>  
>         err = ksft_get_fail_cnt();
>         if (err)
> 
> 

