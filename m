Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332D16E0C63
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 13:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDMLZY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 07:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjDMLZY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 07:25:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101A693EA
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681385123; x=1712921123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nq9Lw0G4bjpwgJFAIajPzHwn008D2wG0qa0Bi5yhc5w=;
  b=knnhxAVa9qJH6ODtGsqaPbylSuS1nj4cbMRi6qlN/TNFgGrOIabvDWp8
   bPlr+QfDont2c69g/KVV4MCnm5jggcRY3aTytAfARk5LPwycmwYBs8iWm
   9Irn15g2w6X/xA8zbfR0WD0Wy4UJm6LZUrbgbBUuJyx4Cfx3JGITd2g++
   ekuGsrDD2cLU12zIN5TnDqsjQN/aNxtSiMBr89GwVFwK/DP5plJmz6Nss
   UmKeAmr/EaqkXqiWYsVXfxF3QBqIpFH7HFnFr+E6h8p7hA1xLlKX5p6QF
   8DOUprY1s1T6di1tI+WQbn3+Wt5d4tAOgIYoG/svlet6At/NJ3VLGsCLW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="342901286"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="342901286"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 04:25:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682928292"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="682928292"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2023 04:25:20 -0700
Received: from [10.249.156.122] (mwajdecz-MOBL.ger.corp.intel.com [10.249.156.122])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id BC9AB38189;
        Thu, 13 Apr 2023 12:25:19 +0100 (IST)
Message-ID: <91c026be-ad88-de22-d500-4fff1815f8a5@intel.com>
Date:   Thu, 13 Apr 2023 13:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] kunit: Update reporting function to support results
 from subtests
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20230411160056.1586-1-michal.wajdeczko@intel.com>
 <20230411160056.1586-4-michal.wajdeczko@intel.com>
 <CABVgOSk3K08W8E5gdycVFJRqo4NdxQvHpxS2OwMEZ48GZVrTUA@mail.gmail.com>
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CABVgOSk3K08W8E5gdycVFJRqo4NdxQvHpxS2OwMEZ48GZVrTUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 13.04.2023 08:38, David Gow wrote:
> On Wed, 12 Apr 2023 at 00:01, Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> There is function to report status of either suite or test, but it
>> doesn't support parameterized subtests that have to log report on
>> its own. Extend it to also accept subtest level results to avoid
>> code duplication.
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Cc: David Gow <davidgow@google.com>
>> ---
> 
> Thanks: this is definitely an improvement on how we handle this.
> 
> There's definitely more we can do, particularly looking forward to
> supporting more complex test hierarchies in the future, but getting
> everything under kunit_print_ok_not_ok is an improvement regardless of
> when happens down the line.
> 
> My only real concern is that the way the indent is printed is a bit
> subtle and difficult to understand fully on first glance. I've added
> some notes below.
> 
>>  lib/kunit/test.c | 28 +++++++++++++++++-----------
>>  1 file changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 5679197b5f8a..692fce258c5b 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -154,8 +154,14 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
>>                   kunit_suite_num_test_cases(suite));
>>  }
>>
>> +enum kunit_test_or_suite {
>> +       KUNIT_SUITE = 0,
>> +       KUNIT_TEST,
>> +       KUNIT_SUBTEST,
>> +};
>> +
> 
> As Rae notes, this probably won't be how this code eventually evolves.
> I don't think it's a problem to have it now, though.
> 
>>  static void kunit_print_ok_not_ok(void *test_or_suite,
>> -                                 bool is_test,
>> +                                 enum kunit_test_or_suite is_test,
>>                                   enum kunit_status status,
>>                                   size_t test_number,
>>                                   const char *description,
>> @@ -180,7 +186,9 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>>                         (status == KUNIT_SKIPPED) ? directive : "");
>>         else
>>                 kunit_log(KERN_INFO, test,
>> -                         KUNIT_SUBTEST_INDENT "%s %zd %s%s%s",
>> +                         "%.*s%s %zd %s%s%s",
>> +                         (int) strlen(KUNIT_SUBTEST_INDENT) * is_test,
>> +                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT,
> 
> This feels a little bit _too_ clever here: I feel it at the very least
> needs a comment, and maybe it'd make more sense to either:
> - Make is_test explicitly a "nesting depth" integer, and calculate the
> indent based on that.
> - Have is_test as an enum, and then just explicitly handle each value
> separately. (Like we do with suite vs test).
> 
> I think that the former is probably the right long-term solution (it's
> much more extensible to more levels of nesting), but the latter is
> definitely easier given the differences between suites and tests at
> the moment.
> 
> If we do continue to share a codepath between tests and subtests, I'd
> prefer it if we either didn't use strlen(), or went to some greater

Rae suggested to define KUNIT_INDENT_LEN 4 and I will put it in test.h

> effort to document how that works (hopefully we can guarantee that the
> compiler will treat this as a constant). Equally, a comment or
> something noting that this will read invalid memory if is_test > 2,
> due to the hardcoded two KUNIT_SUBTEST_INDENT, would be nice.

that shouldn't happen as %.*s specifies precision and it's used here to
clamp string with more than needed indents, it will not try to read
beyond terminating \0

but since you plan for arbitrary level of testing I could change that to
a little simpler variant %*s which should always with any level:

		kunit_log(KERN_INFO, test,
			  "%*s%s %zd %s%s%s",
			  KUNIT_INDENT_LEN * test_level, "",

will that be _simple_ enough ?

Thanks,
Michal

> 
> 
>>                           kunit_status_to_ok_not_ok(status),
>>                           test_number, description, directive_header,
>>                           (status == KUNIT_SKIPPED) ? directive : "");
>> @@ -209,7 +217,7 @@ static size_t kunit_suite_counter = 1;
>>
>>  static void kunit_print_suite_end(struct kunit_suite *suite)
>>  {
>> -       kunit_print_ok_not_ok((void *)suite, false,
>> +       kunit_print_ok_not_ok((void *)suite, KUNIT_SUITE,
>>                               kunit_suite_has_succeeded(suite),
>>                               kunit_suite_counter++,
>>                               suite->name,
>> @@ -554,13 +562,11 @@ int kunit_run_tests(struct kunit_suite *suite)
>>                                                  "param-%d", test.param_index);
>>                                 }
>>
>> -                               kunit_log(KERN_INFO, &test,
>> -                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
>> -                                         "%s %d %s%s%s",
>> -                                         kunit_status_to_ok_not_ok(test.status),
>> -                                         test.param_index + 1, param_desc,
>> -                                         test.status == KUNIT_SKIPPED ? " # SKIP " : "",
>> -                                         test.status == KUNIT_SKIPPED ? test.status_comment : "");
>> +                               kunit_print_ok_not_ok(&test, KUNIT_SUBTEST,
>> +                                                     test.status,
>> +                                                     test.param_index + 1,
>> +                                                     param_desc,
>> +                                                     test.status_comment);
>>
>>                                 /* Get next param. */
>>                                 param_desc[0] = '\0';
>> @@ -574,7 +580,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>>
>>                 kunit_print_test_stats(&test, param_stats);
>>
>> -               kunit_print_ok_not_ok(&test, true, test_case->status,
>> +               kunit_print_ok_not_ok(&test, KUNIT_TEST, test_case->status,
>>                                       kunit_test_case_num(suite, test_case),
>>                                       test_case->name,
>>                                       test.status_comment);
>> --
>> 2.25.1
>>
> 
> Otherwise, this all looks good to me. Thanks very much!
> 
> Cheers,
> -- David
