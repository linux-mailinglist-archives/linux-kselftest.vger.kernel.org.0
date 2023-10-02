Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA07B5428
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 15:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjJBNmV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjJBNmU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 09:42:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F679E
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254137; x=1727790137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v0C5TFqVmlQGsUGZ0xiQfJExrGjw/FZYNiNVhaBlQqo=;
  b=hmOkFjOYpLCBBjkeWL83OJk7e9e+Wbn7kvqfeunTnybnQB5oz4UIvFFc
   Tn54Yzsxc9YR4yJsOXQTe9qrD8AgtaQf4BLq9J5iEvSJyHhihKik5QDUv
   +A34GjRmiD3zOEig15SYAQqmwNTN9ofpSu+mEi2N9hdAAEj/54IyL0+iI
   6Ljspv7hIZUeGPvsDbX7sO5vyzuxWAAW3CbOcZ42AOq7ZXfs5//MdqaSL
   n2u2ojj1sLhBCP4YLkohkltSg8etGCUqSBtlQ9fFKLiuL0U2vKzLwJM6+
   U7EyK3OAodz3N8vZ+MNwFBJcCe55AEWQguJiQt6pXcOowwjLgEx4uF4Og
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="449135396"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="449135396"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700350168"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="700350168"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2023 06:42:15 -0700
Received: from [10.249.132.112] (mwajdecz-MOBL.ger.corp.intel.com [10.249.132.112])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id ED17543C23;
        Mon,  2 Oct 2023 14:42:11 +0100 (IST)
Message-ID: <120ba1d4-b64b-21ea-1fb3-49d5fcb5127a@intel.com>
Date:   Mon, 2 Oct 2023 15:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] kunit: Fix indentation level of suite messages
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
References: <20230925175733.1379-1-michal.wajdeczko@intel.com>
 <20230925175733.1379-3-michal.wajdeczko@intel.com>
 <CA+GJov4tUcq5_JTm2yON1LZwMyP89_x=EbiqBqYpbVi=Vf9CCw@mail.gmail.com>
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CA+GJov4tUcq5_JTm2yON1LZwMyP89_x=EbiqBqYpbVi=Vf9CCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 28.09.2023 22:52, Rae Moar wrote:
> On Mon, Sep 25, 2023 at 1:58 PM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> A kunit suite is a top level test from the KTAP point of view but
>> all suite diagnostic messages are printed at the subtest level:
>>
>>     $ ./tools/testing/kunit/kunit.py run --raw_output \
>>         --kunitconfig ./lib/kunit/.kunitconfig "example.*simple*"
>>
>>     KTAP version 1
>>     1..1
>>         # example: initializing suite
>>         # example: failed to initialize (-ENODEV)
>>     not ok 1 example
>>
>>     KTAP version 1
>>     1..1
>>         # example: initializing suite
>>         KTAP version 1
>>         # Subtest: example
>>         # module: kunit_example_test
>>         1..1
>>         # example_simple_test: initializing
>>         # example_simple_test: cleaning up
>>         ok 1 example_simple_test
>>         # example: exiting suite
>>     ok 1 example
>>
>> Replace hardcoded indent in kunit_printk() with flexible
>> indentation based on the argument type (test or suite):
>>
>>     KTAP version 1
>>     1..1
>>     # example: initializing suite
>>     # example: failed to initialize (-ENODEV)
>>     not ok 1 example
>>
>>     KTAP version 1
>>     1..1
>>     # example: initializing suite
>>         KTAP version 1
>>         # Subtest: example
>>         # module: kunit_example_test
>>         1..1
>>         # example_simple_test: initializing
>>         # example_simple_test: cleaning up
>>         ok 1 example_simple_test
>>     # example: exiting suite
>>     ok 1 example
> 
> Hi!
> 
> I am happy to see this change to improve the indentation of
> parameterized tests. It has been bugging me for a bit. This seems to
> be working well but I just had a few comments to potentially discuss.
> 
> Thanks!
> 
> -Rae
> 
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Rae Moar <rmoar@google.com>
>> ---
>>  include/kunit/test.h | 24 ++++++++++++++++++++++--
>>  lib/kunit/test.c     |  7 -------
>>  2 files changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index 20ed9f9275c9..158876c4cb43 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -509,6 +509,21 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
>>                 kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
>>         } while (0)
>>
>> +/* Currently supported test levels */
>> +enum {
>> +       KUNIT_LEVEL_SUITE = 0,
>> +       KUNIT_LEVEL_CASE,
>> +       KUNIT_LEVEL_CASE_PARAM,
>> +};
> 
> I do find this slightly confusing to have a KUNIT_LEVEL_SUITE as the
> suite output occurs on multiple levels. Plus, I also don't see any
> uses of the SUITE level or the PARAM level anymore. Do you have any
> ideas on this?

This enum was just promoted as-is from the test.c as I didn't want to
use magic 0 or 1 in below kunit_level() macro.

Note that the KUNIT_LEVEL_SUITE is now used indirectly whenever you call
any of kunit_printk() with suite param like here:

./kunit-example-test.c:60:  kunit_info(suite, "initializing suite\n");
./kunit-example-test.c:71:  kunit_info(suite, "exiting suite\n");

as this will result in calls to kunit_indent_level(suite) and
kunit_level(suite) macro.

And KUNIT_LEVEL_CASE_PARAM is maybe a leftover, as now we change test
levels using direct increase/decrease statements, but still IMO this
enum nicely reflects what kind of levels we currently do support at this
point. But could be dropped if needed.

Regarding _"suite output occurs on multiple levels"_ I found that also
confusing, but IMO this is due to the kunit implementation details
and/or KTAP design decisions as it looks that "suite" is treated
sometimes as "subtest" and sometimes as a top level "test".

That makes a little trouble while trying to implement printing in a
consistent manner.  Maybe we should consider introducing concept of the
"executor" with its own level attribute? Then mapping will be like this:

KTAP version 1				<- kunit executor (level=0)
1..1					<- kunit executor (level=0)
# Test: example				<- kunit executor (level=0) ??
# module: kunit_example_test		<- kunit executor (level=0) ??
# example: initializing suite		<- suite (test level=0)
    KTAP version 1			<- suite executor (level=1)
    # Subtest: example			<- suite executor (level=1)
    # module: kunit_example_test	<- suite executor (level=1)
    1..2				<- suite executor (level=1)
    # test_1: initializing		<- test_case (test level=1)
    # test_1: cleaning up		<- test_case (test level=1)
    # test_1: pass:1 fail:0 skip:0 tota <- suite executor (level=1)
    ok 1 test_1				<- suite executor (level=1)
        KTAP version 1			<- params executor (level=2)
        # Subtest: test_2		<- params executor (level=2)
        1..2				<- params executor (level=2)
        # test_2: initializing		<- test_case (test level=2)
        # test_2: cleaning up		<- test_case (test level=2)
        ok 1 example value 1		<- params executor (level=2)
        # test_2: initializing		<- test_case (test level=2)
        # test_2: cleaning up		<- test_case (test level=2)
        ok 2 example value 0		<- params executor (level=2)
    # test_2: pass:2 fail:0 skip:0 tota <- suite executor (level=1)
    ok 2 test_2				<- suite executor (level=1)
# example: exiting suite		<- suite (test level=0)
# example: pass:2 fail:0 skip:0 total:2	<- kunit executor (level=0)
# Totals: pass:3 fail:0 skip:0 total:3	<- kunit executor (level=0)
ok 1 example				<- kunit executor (level=0)

Then any suite and/or test level will be just based on executor.level
This could be done as follow-up improvement.

> 
> We could consider just using the test->level field introduced in the
> next patch to manage the levels. Or I wouldn't mind keeping this just
> for clarity?

We still need some definition for initial level, no?
And at this point in series, we still need at least two defs.

> 
>> +
>> +#define kunit_level(test_or_suite)                                     \
>> +       _Generic((test_or_suite),                                       \
>> +                struct kunit_suite * : KUNIT_LEVEL_SUITE,              \
>> +                struct kunit * : KUNIT_LEVEL_CASE)
>> +
> 
> I am not super familiar with using _Generic so I would want David's opinion.
> 
> Also I can think of cases where it would be helpful to add an option
> for struct kunit_case *, however, that may be an addition for the
> future.

I had entry for struct kunit_test_case* but removed that as it was never
used in current code (no calls to kunit_log() with test_case)

> 
> And then additionally, this macro seems to be only used for the struct
> kunit * case. Will we plan to use this in the future for suites?

As pointed above we already use it for test and suite:

./kunit-example-test.c:60:  kunit_info(suite, "initializing suite\n");
./kunit-example-test.c:71:  kunit_info(suite, "exiting suite\n");

> 
>> +#define kunit_indent_level(test_or_suite)                              \
>> +       (KUNIT_INDENT_LEN * kunit_level(test_or_suite))
>> +
>>  /*
>>   * printk and log to per-test or per-suite log buffer.  Logging only done
>>   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
>> @@ -520,9 +535,14 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
>>                                  ##__VA_ARGS__);                        \
>>         } while (0)
>>
>> +#define kunit_log_indent(lvl, test_or_suite, fmt, ...)                 \
>> +       kunit_log(lvl, test_or_suite, "%*s" fmt,                        \
>> +                 kunit_indent_level(test_or_suite), "",                \
>> +                 ##__VA_ARGS__)
>> +
>>  #define kunit_printk(lvl, test, fmt, ...)                              \
>> -       kunit_log(lvl, test, KUNIT_SUBTEST_INDENT "# %s: " fmt,         \
>> -                 (test)->name, ##__VA_ARGS__)
>> +       kunit_log_indent(lvl, test, "# %s: " fmt,                       \
>> +                        (test)->name, ##__VA_ARGS__)
>>
> 
> I wonder if we could consider removing the need to use
> KUNIT_SUBTEST_INDENT in all locations. I am primarily thinking about
> its uses in debugfs.c and test.c.
> 
> For example in debugfs.c:
> pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
> 
> Although, as this is a suite object that is printing at the test case
> level, I am not quite sure how to use the existing macros.

We could add some wrapper like kunit_pr() that takes suite/test/executor
from which we can derive right indent level, but that would be another
follow up task once we agree on location and use of .level attribute.

Michal

> 
> 
>>  /**
>>   * kunit_info() - Prints an INFO level message associated with @test.
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index fb5981ce578d..d10e6d610e20 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -135,13 +135,6 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
>>  }
>>  EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
>>
>> -/* Currently supported test levels */
>> -enum {
>> -       KUNIT_LEVEL_SUITE = 0,
>> -       KUNIT_LEVEL_CASE,
>> -       KUNIT_LEVEL_CASE_PARAM,
>> -};
>> -
>>  static void kunit_print_suite_start(struct kunit_suite *suite)
>>  {
>>         /*
>> --
>> 2.25.1
>>
