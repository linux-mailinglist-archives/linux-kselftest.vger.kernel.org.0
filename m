Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA806E0E40
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDMNPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjDMNPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 09:15:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9B69741
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681391715; x=1712927715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P2XW7i3pukGEaSwWiJhzMZ7EBOe3JkL5xtTTokQHFcM=;
  b=Yf7agQNGX0dXoaRV53bmIHPseBCMKJ3InLXD0Zzy2wPw+It3lyS53rez
   A2rC6nWgJDwdZxv20QxeMGfjZbp8uj6GhNCUHHUsZfohq8bPAUyonfiaZ
   YiWpkCF2RCvlJmUvLS8gSl+Y808pVdUwnZxHFbjoyW2BvY5Zvbfrf8j5D
   Jha3zHwDWnFuQCnnm2V/QNHaWEqq/e2zBqEKcYVUKcRf9Nn1mHA+n1wAJ
   I3J8ZKW/KQrWuZgm6M93iLeKKDnMIGw7ZSwajMyAEnoGTf3P9X3S5SpqD
   GGFU5v+1Rz/frPOIjW+sVYJN6ypm+QJwfpTFRYy9CJuRK1K9Qwqp2sbPP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="344173544"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="344173544"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 06:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="691953485"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="691953485"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2023 06:15:07 -0700
Received: from [10.249.156.122] (mwajdecz-MOBL.ger.corp.intel.com [10.249.156.122])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 61B9138196;
        Thu, 13 Apr 2023 14:15:06 +0100 (IST)
Message-ID: <9f6977ec-372e-e2cf-e282-805b444d3ce4@intel.com>
Date:   Thu, 13 Apr 2023 15:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] kunit: Update reporting function to support results
 from subtests
Content-Language: en-US
To:     David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230411160056.1586-1-michal.wajdeczko@intel.com>
 <20230411160056.1586-4-michal.wajdeczko@intel.com>
 <CA+GJov53J4WhXXUSrGDPZ-hqogL0eYOzaf_RgGQ1paj=_EtLUA@mail.gmail.com>
 <CABVgOSnyvEhgNyxqvJtu6ttXSdAB6t1SaN6-4SCmHYW25AKZoA@mail.gmail.com>
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CABVgOSnyvEhgNyxqvJtu6ttXSdAB6t1SaN6-4SCmHYW25AKZoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 13.04.2023 08:31, David Gow wrote:
> On Thu, 13 Apr 2023 at 04:28, Rae Moar <rmoar@google.com> wrote:
>>
>> On Tue, Apr 11, 2023 at 12:01 PM Michal Wajdeczko
>> <michal.wajdeczko@intel.com> wrote:
>>>
>>> There is function to report status of either suite or test, but it
>>> doesn't support parameterized subtests that have to log report on
>>> its own. Extend it to also accept subtest level results to avoid
>>> code duplication.
>>>
>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>> Cc: David Gow <davidgow@google.com>
>>> ---
>>>  lib/kunit/test.c | 28 +++++++++++++++++-----------
>>>  1 file changed, 17 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>>> index 5679197b5f8a..692fce258c5b 100644
>>> --- a/lib/kunit/test.c
>>> +++ b/lib/kunit/test.c
>>> @@ -154,8 +154,14 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
>>>                   kunit_suite_num_test_cases(suite));
>>>  }
>>>
>>> +enum kunit_test_or_suite {
>>> +       KUNIT_SUITE = 0,
>>> +       KUNIT_TEST,
>>> +       KUNIT_SUBTEST,
>>> +};
>>> +
>>
>> Hi Michal!
>>
>> Since KUnit's goal is to progress toward supporting arbitrary levels
>> of testing, I like the idea of starting to adjust these helper
>> functions to allow for greater levels of testing.
>>
>> However, I'm not sure about this kunit_test_or_suite enum. If our goal
>> is to support an arbitrary number of levels of tests then this enum
>> still limits us to a finite number of levels. However, if we only want
>> to focus on supporting parameterized tests (which is our direct goal),
>> this could be the right solution.
>>
>> Maybe instead we could use an integer denoting the test level instead?
>> This would remove the limit but would also remove the nice names of
>> the levels.

we can use integer as param but at the same time we can also have define
or anonymous enum as nice aliases to currently known/used levels:

/* Currently supported test levels */
enum {
	KUNIT_LEVEL_SUITE = 0,
	KUNIT_LEVEL_TEST,
	KUNIT_LEVEL_PARAMTEST,
};

/* Future levels are TBD */
#define KUNIT_LEVEL_SUBTEST(n)	(KUNIT_LEVEL_TEST + (n))

>>
>> I'm curious what others opinions are on these ideas?
>>
>> A bit of a nit: if we do use this enum I wonder if we could clarify
>> the name to be kunit_test_level as the current name of
>> kunit_test_or_suite seems to indicate to me a binary of two options
>> rather than three.
>>
>>>  static void kunit_print_ok_not_ok(void *test_or_suite,
>>> -                                 bool is_test,
>>> +                                 enum kunit_test_or_suite is_test,
>>
>> Similar to above, I think the name of is_test could be clarified. It
>> is currently a bit confusing to me as they are all tests. Maybe
>> test_level?

ok

> 
> I agree with Rae that this is not the ideal long-term solution.
> 
> We're basically encoding two things here:
> - Are we dealing with a 'struct kunit_suite' or a 'struct kunit'?
> - How nested the test is.
> 
> Given KUnit originally only had a 2-level nesting (suite->test), and
> now has 3-level nesting (always suite->test[->param]), this works, but
> the KTAP format permits arbitrary nesting of tests, and we'll want to
> have something like that in KUnit going forward. We don't have a
> design for that yet, but it could conceivably allow nested suites,
> thus breaking the rule that nesting level 0 is always a suite, and the
> rest are all tests.

I guess "We don't have a design for that yet" is a key here

> 
> So there's definitely a part of me that would prefer to pass those two
> pieces of information in separate arguments, rather than relying on an
> enum like this.
> 
> That being said, this is all very fuzzy future plans, rather than
> anything concrete, and this will all likely need reworking if we do
> anything drastic anyway, so I'm not worried if we go with this for
> now, and change it when we need to. I do think it's an improvement
> over what we're doing currently.
> (For example, another possible implementation for nested tests could
> be to get rid of the distinction between tests and suites completely:
> or at least have them share 'struct kunit', so this wouldn't need
> passing in separately.)

maybe the problem will go away once we just replace this untyped param:

	kunit_print_ok_not_ok(void *test_or_suite, ...

with proper type:

	kunit_print_ok_not_ok(struct kunit *test, ...

and treat NULL as indication that we just want to print raw results (as
it looks function is not using any suite attributes directly, all input
is passed explicitly and kunit_log() expects test only)

Thanks,
Michal

> 
> Cheers,
> -- David
> 
> 
>>
>>>                                   enum kunit_status status,
>>>                                   size_t test_number,
>>>                                   const char *description,
>>> @@ -180,7 +186,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>>>                         (status == KUNIT_SKIPPED) ? directive : "");
>>>         else
>>>                 kunit_log(KERN_INFO, test,
>>> -                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
>>> +                         "%.*s%s %zd %s%s%s",
>>> +                         (int) strlen(KUNIT_SUBTEST_INDENT) * is_test,
>>
>> I would consider saving the length of KUNIT_SUBTEST_INDENT as a macro.
>> Maybe KUNIT_INDENT_LEN?
>>
>>> +                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT,
>>>                           kunit_status_to_ok_not_ok(status),
>>>                           test_number, description, directive_header,
>>>                           (status == KUNIT_SKIPPED) ? directive : "");
>>> @@ -209,7 +217,7 @@ static size_t kunit_suite_counter = 1;
>>>
>>>  static void kunit_print_suite_end(struct kunit_suite *suite)
>>>  {
>>> -       kunit_print_ok_not_ok((void *)suite, false,
>>> +       kunit_print_ok_not_ok((void *)suite, KUNIT_SUITE,
>>>                               kunit_suite_has_succeeded(suite),
>>>                               kunit_suite_counter++,
>>>                               suite->name,
>>> @@ -554,13 +562,11 @@ int kunit_run_tests(struct kunit_suite *suite)
>>>                                                  "param-%d", test.param_index);
>>>                                 }
>>>
>>> -                               kunit_log(KERN_INFO, &test,
>>> -                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
>>> -                                         "%s %d %s%s%s",
>>> -                                         kunit_status_to_ok_not_ok(test.status),
>>> -                                         test.param_index + 1, param_desc,
>>> -                                         test.status == KUNIT_SKIPPED ? " # SKIP " : "",
>>> -                                         test.status == KUNIT_SKIPPED ? test.status_comment : "");
>>> +                               kunit_print_ok_not_ok(&test, KUNIT_SUBTEST,
>>> +                                                     test.status,
>>> +                                                     test.param_index + 1,
>>> +                                                     param_desc,
>>> +                                                     test.status_comment);
>>>
>>>                                 /* Get next param. */
>>>                                 param_desc[0] = '\0';
>>> @@ -574,7 +580,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>>>
>>>                 kunit_print_test_stats(&test, param_stats);
>>>
>>> -               kunit_print_ok_not_ok(&test, true, test_case->status,
>>> +               kunit_print_ok_not_ok(&test, KUNIT_TEST, test_case->status,
>>>                                       kunit_test_case_num(suite, test_case),
>>>                                       test_case->name,
>>>                                       test.status_comment);
>>> --
>>> 2.25.1
>>>
>>> --
>>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230411160056.1586-4-michal.wajdeczko%40intel.com.
