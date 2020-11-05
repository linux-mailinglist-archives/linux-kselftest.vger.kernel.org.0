Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC52A7808
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 08:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKEHcB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 02:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEHcA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 02:32:00 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AABBC0613CF;
        Wed,  4 Nov 2020 23:31:59 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r186so786832pgr.0;
        Wed, 04 Nov 2020 23:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KwWJeTM/D9R/VMk0c7O5fyAjSbVgF3hVLEVxJwgSMQY=;
        b=sexoXPsbszdr0SgsYsGtxqMv6PFQgTqBi/LEVgUgPxDd4iD79X2os5HE7jmxar2z/X
         nisx1Z/lb64rBH3tc1VxENz2dGJMORcCyMHfkzELVb0Neqaer50Z9rPzz4821HG7LdL+
         ovitZvy+qpIJaFCfUlUKLiG6cHJK1kJ8rK9Zxqfj0AaubzsM0qDKqA5GhcpQbdTkOaDi
         4oMuV1fFKDOglR5ii2bApfwN8VKA5c5xDdfJo8g0rE6sq/t9mVH9ZiXoAKMSqmaagavU
         8wirjkMmyeA6iywLlASxd+X/4evckAUsUqYkdzz19Di0IQxjw1b+ax5OwNjiEQnAZ+fv
         Ae7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwWJeTM/D9R/VMk0c7O5fyAjSbVgF3hVLEVxJwgSMQY=;
        b=GHlEa0layWq6Ict9nZTU/HlhX5h/lYknVoO+8XPEAnVJiQuOsz+nnMVspTzFXtIU5q
         hjpAa/IGNpTk+TuqOCLbfYzyq4xXh2KMVYskdDGhWuk43F7J/2FLkgEp7+a6OO8kz2K8
         SN6ao/q/2sH7nvUpOzhStecDUmMaEjUVnOjgoULZfwdAYb1ExTH6vDB6l9P2f0+NbLKE
         r24fQ3HEdQVdolj88+f46/vonHMUxa3xkWP1vVFXhP1pu5poMAG9WHnTeCldjg9+1oAA
         nQXp3nKLzabaK9nIxZKqRPc9t/emq37G4DSBzGJuwxAHAf31ubyao+42tVVPW/pD33R4
         ArCA==
X-Gm-Message-State: AOAM530pQRSP60I2FutKjUEWXGw6sWmN5p0E/ERGFb/E52uFXp9egOR6
        GG9K7pGr2JwAq35jWLt1r0NZeDb0qmf4YzOO
X-Google-Smtp-Source: ABdhPJwlJ/wgzWIBgU7sR+pzVdPV6RL+AG7jWIHVkZn+rUGhwXS9Rwon2+gUuIfwa3olj13o/PEw2Q==
X-Received: by 2002:a17:90b:496:: with SMTP id bh22mr1211222pjb.120.1604561518325;
        Wed, 04 Nov 2020 23:31:58 -0800 (PST)
Received: from [192.168.86.81] ([106.51.243.217])
        by smtp.gmail.com with ESMTPSA id m68sm1149343pga.46.2020.11.04.23.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 23:31:57 -0800 (PST)
Subject: Re: [PATCH v4 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
References: <20201027174630.85213-1-98.arpi@gmail.com>
 <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com>
Date:   Thu, 5 Nov 2020 13:01:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28/10/20 12:51 am, Marco Elver wrote:
> On Tue, 27 Oct 2020 at 18:47, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>>
>> Implementation of support for parameterized testing in KUnit.
>> This approach requires the creation of a test case using the
>> KUNIT_CASE_PARAM macro that accepts a generator function as input.
>> This generator function should return the next parameter given the
>> previous parameter in parameterized tests. It also provides
>> a macro to generate common-case generators.
>>
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>> Co-developed-by: Marco Elver <elver@google.com>
>> Signed-off-by: Marco Elver <elver@google.com>
>> ---
>> Changes v3->v4:
>> - Rename kunit variables
>> - Rename generator function helper macro
>> - Add documentation for generator approach
>> - Display test case name in case of failure along with param index
>> Changes v2->v3:
>> - Modifictaion of generator macro and method
>> Changes v1->v2:
>> - Use of a generator method to access test case parameters
>>
>>  include/kunit/test.h | 34 ++++++++++++++++++++++++++++++++++
>>  lib/kunit/test.c     | 21 ++++++++++++++++++++-
>>  2 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index 9197da792336..ec2307ee9bb0 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -107,6 +107,13 @@ struct kunit;
>>   *
>>   * @run_case: the function representing the actual test case.
>>   * @name:     the name of the test case.
>> + * @generate_params: the generator function for parameterized tests.
>> + *
>> + * The generator function is used to lazily generate a series of
>> + * arbitrarily typed values that fit into a void*. The argument @prev
>> + * is the previously returned value, which should be used to derive the
>> + * next value; @prev is set to NULL on the initial generator call.
>> + * When no more values are available, the generator must return NULL.
>>   *
> 
> Hmm, should this really be the first paragraph? I think it should be
> the paragraph before "Example:" maybe. But then that paragraph should
> refer to generate_params e.g. "The generator function @generate_params
> is used to ........".
> 
> The other option you have is to move this paragraph to the kernel-doc
> comment for KUNIT_CASE_PARAM, which seems to be missing a kernel-doc
> comment.
> 
>>   * A test case is a function with the signature,
>>   * ``void (*)(struct kunit *)``
>> @@ -141,6 +148,7 @@ struct kunit;
>>  struct kunit_case {
>>         void (*run_case)(struct kunit *test);
>>         const char *name;
>> +       void* (*generate_params)(void *prev);
>>
>>         /* private: internal use only. */
>>         bool success;
>> @@ -162,6 +170,9 @@ static inline char *kunit_status_to_string(bool status)
>>   * &struct kunit_case for an example on how to use it.
>>   */
>>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> 
> I.e. create a new kernel-doc comment for KUNIT_CASE_PARAM here, and
> simply move the paragraph describing the generator protocol into that
> comment.
> 
>> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
>> +               { .run_case = test_name, .name = #test_name,    \
>> +                 .generate_params = gen_params }
>>
>>  /**
>>   * struct kunit_suite - describes a related collection of &struct kunit_case
>> @@ -208,6 +219,15 @@ struct kunit {
>>         const char *name; /* Read only after initialization! */
>>         char *log; /* Points at case log after initialization */
>>         struct kunit_try_catch try_catch;
>> +       /* param_value points to test case parameters in parameterized tests */
> 
> Hmm, not quite: param_value is the current parameter value for a test
> case. Most likely it's a pointer, but it doesn't need to be.
> 
>> +       void *param_value;
>> +       /*
>> +        * param_index stores the index of the parameter in
>> +        * parameterized tests. param_index + 1 is printed
>> +        * to indicate the parameter that causes the test
>> +        * to fail in case of test failure.
>> +        */
> 
> I think this comment needs to be reformatted, because you can use at
> the very least use 80 cols per line. (If you use vim, visual select
> and do 'gq'.)
> 
>> +       int param_index;
>>         /*
>>          * success starts as true, and may only be set to false during a
>>          * test case; thus, it is safe to update this across multiple
>> @@ -1742,4 +1762,18 @@ do {                                                                            \
>>                                                 fmt,                           \
>>                                                 ##__VA_ARGS__)
>>
>> +/**
>> + * KUNIT_ARRAY_PARAM() - Helper method for test parameter generators
>> + *                      required in parameterized tests.
>> + * @name:  prefix of the name for the test parameter generator function.
>> + *        It will be suffixed by "_gen_params".
>> + * @array: a user-supplied pointer to an array of test parameters.
>> + */
>> +#define KUNIT_ARRAY_PARAM(name, array)                                                         \
>> +       static void *name##_gen_params(void *prev)                                              \
>> +       {                                                                                       \
>> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
>> +               return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;                  \
>> +       }
>> +
>>  #endif /* _KUNIT_TEST_H */
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 750704abe89a..8ad908b61494 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -127,6 +127,12 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
>>  }
>>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
>>
>> +static void kunit_print_failed_param(struct kunit *test)
>> +{
>> +       kunit_err(test, "\n\tTest failed at:\n\ttest case: %s\n\tparameter: %d\n",
>> +                                               test->name, test->param_index + 1);
>> +}
> 
> Hmm, perhaps I wasn't clear, but I think I also misunderstood how the
> test case successes are presented: they are not, and it's all bunched
> into a single test case.
> 
> Firstly, kunit_err() already prints the test name, so if we want
> something like "  # : the_test_case_name: failed at parameter #X",
> simply having
> 
>     kunit_err(test, "failed at parameter #%d\n", test->param_index + 1)
> 
> would be what you want.
> 
> But I think I missed that parameters do not actually produce a set of
> test cases (sorry for noticing late). I think in their current form,
> the parameterized tests would not be useful for my tests, because each
> of my tests have test cases that have specific init and exit
> functions. For each parameter, these would also need to run.
> 
> Ideally, each parameter produces its own independent test case
> "test_case#param_index". That way, CI systems will also be able to
> logically separate different test case params, simply because each
> param produced its own distinct test case.
> 
> So, for example, we would get a series of test cases from something
> like KUNIT_CASE_PARAM(test_case, foo_gen_params), and in the output
> we'd see:
> 
>     ok X - test_case#1
>     ok X - test_case#2
>     ok X - test_case#3
>     ok X - test_case#4
>     ....
> 
> Would that make more sense?
> 
> That way we'd ensure that test-case specific initialization and
> cleanup done in init and exit functions is properly taken care of, and
> you wouldn't need kunit_print_failed_param().
> 
> AFAIK, for what I propose you'd have to modify kunit_print_ok_not_ok()
> (show param_index if parameterized test) and probably
> kunit_run_case_catch_errors() (generate params and set
> test->param_value and param_index).
> 
> Was there a reason why each param cannot be a distinct test case? If
> not, I think this would be more useful.
> 

I tried adding support to run each parameter as a distinct test case by
making changes to kunit_run_case_catch_errors(). The issue here is that
since the results are displayed in KTAP format, this change will result in
each parameter being considered a subtest of another subtest (test case
in KUnit). To make this work, a lot of changes in other parts will be required,
and it will get complicated. Running all parameters as one test case seems
to be a better option right now. So for now, I will modify what is displayed
by kunit_err() in case of test failure.

>>  static void kunit_print_string_stream(struct kunit *test,
>>                                       struct string_stream *stream)
>>  {
>> @@ -168,6 +174,8 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>>         assert->format(assert, stream);
>>
>>         kunit_print_string_stream(test, stream);
>> +       if (test->param_value)
>> +               kunit_print_failed_param(test);
>>
>>         WARN_ON(string_stream_destroy(stream));
>>  }
>> @@ -239,7 +247,18 @@ static void kunit_run_case_internal(struct kunit *test,
>>                 }
>>         }
>>
>> -       test_case->run_case(test);
>> +       if (!test_case->generate_params) {
>> +               test_case->run_case(test);
>> +       } else {
>> +               test->param_value = test_case->generate_params(NULL);
>> +               test->param_index = 0;
>> +
>> +               while (test->param_value) {
>> +                       test_case->run_case(test);
>> +                       test->param_value = test_case->generate_params(test->param_value);
>> +                       test->param_index++;
>> +               }
>> +       }
> 
> Thanks,
> -- Marco
> 

