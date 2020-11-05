Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B62A81C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgKEPCf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 10:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgKEPCf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 10:02:35 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823EEC0613D3
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 07:02:34 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c80so1971769oib.2
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cE/I/a+glK1wUH+iTxJhL2yUQISg6MuRdUIRRW+E5aM=;
        b=XWfoih1azO52w8zDO8vLQZaZk7ivT6hGvNeaPjNANFyj50IKJJF8IW7ZkFiY/L1nlY
         WWlOT2qOFphxGQRH7hTc7Z1wJEoNvxVBSvwEPvtkZxkO0W6ZCuHeq8CSY73cqsoFZrfo
         XLYzAdsJzfrS2tmQKkenSNEHSZ+DMD5KeDop+9D8BgJDoe+OaLYZj4W1ByUJ1046ehLM
         X3P/ePaHe97CBFgW9fOb3OTjnqxdVLdnBSNUjcH8l3/MHctXU+QsqBhvf7yqICmCVz3t
         Eeux8T0k0td/dXGkRtGH/qSZVEc3Vg8OGEfqYl4q/yfl/OyDnlaz2zqyP92LG2hqba9K
         EbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cE/I/a+glK1wUH+iTxJhL2yUQISg6MuRdUIRRW+E5aM=;
        b=hCoLrYUMBEKpzrMtsFup15ETwePPJHduvdWBcCkxOd8PM+68VqPo4L7IfxnZuZ6KRF
         t6lgKr0jb+um41ED3b8gIouushWDA+hHtWd9ji3TIwpAD5Ob52Pd5BEUxaVOcX2Yweqq
         FYla02jPbNznUgUArjmhzH0Losd+sx2JhmX3EG8ynOonL2zr+yCbwQTJXHXteWe4vNyN
         kkStssNb0uts1jNuEesw90f6J7duAR7Ajk1SVEM6ZRwK3xi1tsUOtLI8K02wp9BTpBXv
         KqTAK3Uq24hxEBuE8cOs+/udFO/+035DJMwX6IK27Gh8kxN0DKtO3t8mxlOHWobGWQQ0
         ji+w==
X-Gm-Message-State: AOAM532EQYJDjwlvJjK+gn+uHL4BP999ibG52sy0MRcpyleZWjbVHN/u
        f0ZRGE2aCgjQaYVv3qLn43g10oY/xch0vhwRUpLBtg==
X-Google-Smtp-Source: ABdhPJwlDum//2HtQ05yrZR7wh0KZAwhZgTaBZF9xruJBFjtyASBnPmJRL+f0WxhgcHdfPPfsHwrxdJzMnjhyCd7NoY=
X-Received: by 2002:aca:a988:: with SMTP id s130mr1817540oie.172.1604588553492;
 Thu, 05 Nov 2020 07:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20201027174630.85213-1-98.arpi@gmail.com> <CANpmjNOpbXHs4gs9Ro-u7hyN_zZ7s3AqDcdDy1Nqxq4ckThugA@mail.gmail.com>
 <73c4e46c-10f1-9362-b4fb-94ea9d74e9b2@gmail.com> <CANpmjNPxqQM0_f14ZwV3rHZzwhCtqx2fbOhHmXmiJawou6=z6Q@mail.gmail.com>
 <77d6dc66-1086-a9ae-ccbc-bb062ff81437@gmail.com>
In-Reply-To: <77d6dc66-1086-a9ae-ccbc-bb062ff81437@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 5 Nov 2020 16:02:21 +0100
Message-ID: <CANpmjNORLJ4b_uwBB8v2h5cxoZF2SMTaz5K6QP37PxdUJDZUDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 5 Nov 2020 at 15:30, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 05/11/20 2:00 pm, Marco Elver wrote:
> > On Thu, 5 Nov 2020 at 08:32, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >>
> >> On 28/10/20 12:51 am, Marco Elver wrote:
> >>> On Tue, 27 Oct 2020 at 18:47, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >>>>
> >>>> Implementation of support for parameterized testing in KUnit.
> >>>> This approach requires the creation of a test case using the
> >>>> KUNIT_CASE_PARAM macro that accepts a generator function as input.
> >>>> This generator function should return the next parameter given the
> >>>> previous parameter in parameterized tests. It also provides
> >>>> a macro to generate common-case generators.
> >>>>
> >>>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >>>> Co-developed-by: Marco Elver <elver@google.com>
> >>>> Signed-off-by: Marco Elver <elver@google.com>
> >>>> ---
> >>>> Changes v3->v4:
> >>>> - Rename kunit variables
> >>>> - Rename generator function helper macro
> >>>> - Add documentation for generator approach
> >>>> - Display test case name in case of failure along with param index
> >>>> Changes v2->v3:
> >>>> - Modifictaion of generator macro and method
> >>>> Changes v1->v2:
> >>>> - Use of a generator method to access test case parameters
> >>>>
> >>>>  include/kunit/test.h | 34 ++++++++++++++++++++++++++++++++++
> >>>>  lib/kunit/test.c     | 21 ++++++++++++++++++++-
> >>>>  2 files changed, 54 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >>>> index 9197da792336..ec2307ee9bb0 100644
> >>>> --- a/include/kunit/test.h
> >>>> +++ b/include/kunit/test.h
> >>>> @@ -107,6 +107,13 @@ struct kunit;
> >>>>   *
> >>>>   * @run_case: the function representing the actual test case.
> >>>>   * @name:     the name of the test case.
> >>>> + * @generate_params: the generator function for parameterized tests.
> >>>> + *
> >>>> + * The generator function is used to lazily generate a series of
> >>>> + * arbitrarily typed values that fit into a void*. The argument @prev
> >>>> + * is the previously returned value, which should be used to derive the
> >>>> + * next value; @prev is set to NULL on the initial generator call.
> >>>> + * When no more values are available, the generator must return NULL.
> >>>>   *
> >>>
> >>> Hmm, should this really be the first paragraph? I think it should be
> >>> the paragraph before "Example:" maybe. But then that paragraph should
> >>> refer to generate_params e.g. "The generator function @generate_params
> >>> is used to ........".
> >>>
> >>> The other option you have is to move this paragraph to the kernel-doc
> >>> comment for KUNIT_CASE_PARAM, which seems to be missing a kernel-doc
> >>> comment.
> >>>
> >>>>   * A test case is a function with the signature,
> >>>>   * ``void (*)(struct kunit *)``
> >>>> @@ -141,6 +148,7 @@ struct kunit;
> >>>>  struct kunit_case {
> >>>>         void (*run_case)(struct kunit *test);
> >>>>         const char *name;
> >>>> +       void* (*generate_params)(void *prev);
> >>>>
> >>>>         /* private: internal use only. */
> >>>>         bool success;
> >>>> @@ -162,6 +170,9 @@ static inline char *kunit_status_to_string(bool status)
> >>>>   * &struct kunit_case for an example on how to use it.
> >>>>   */
> >>>>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
> >>>
> >>> I.e. create a new kernel-doc comment for KUNIT_CASE_PARAM here, and
> >>> simply move the paragraph describing the generator protocol into that
> >>> comment.
> >>>
> >>>> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
> >>>> +               { .run_case = test_name, .name = #test_name,    \
> >>>> +                 .generate_params = gen_params }
> >>>>
> >>>>  /**
> >>>>   * struct kunit_suite - describes a related collection of &struct kunit_case
> >>>> @@ -208,6 +219,15 @@ struct kunit {
> >>>>         const char *name; /* Read only after initialization! */
> >>>>         char *log; /* Points at case log after initialization */
> >>>>         struct kunit_try_catch try_catch;
> >>>> +       /* param_value points to test case parameters in parameterized tests */
> >>>
> >>> Hmm, not quite: param_value is the current parameter value for a test
> >>> case. Most likely it's a pointer, but it doesn't need to be.
> >>>
> >>>> +       void *param_value;
> >>>> +       /*
> >>>> +        * param_index stores the index of the parameter in
> >>>> +        * parameterized tests. param_index + 1 is printed
> >>>> +        * to indicate the parameter that causes the test
> >>>> +        * to fail in case of test failure.
> >>>> +        */
> >>>
> >>> I think this comment needs to be reformatted, because you can use at
> >>> the very least use 80 cols per line. (If you use vim, visual select
> >>> and do 'gq'.)
> >>>
> >>>> +       int param_index;
> >>>>         /*
> >>>>          * success starts as true, and may only be set to false during a
> >>>>          * test case; thus, it is safe to update this across multiple
> >>>> @@ -1742,4 +1762,18 @@ do {                                                                            \
> >>>>                                                 fmt,                           \
> >>>>                                                 ##__VA_ARGS__)
> >>>>
> >>>> +/**
> >>>> + * KUNIT_ARRAY_PARAM() - Helper method for test parameter generators
> >>>> + *                      required in parameterized tests.
> >>>> + * @name:  prefix of the name for the test parameter generator function.
> >>>> + *        It will be suffixed by "_gen_params".
> >>>> + * @array: a user-supplied pointer to an array of test parameters.
> >>>> + */
> >>>> +#define KUNIT_ARRAY_PARAM(name, array)                                                         \
> >>>> +       static void *name##_gen_params(void *prev)                                              \
> >>>> +       {                                                                                       \
> >>>> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
> >>>> +               return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;                  \
> >>>> +       }
> >>>> +
> >>>>  #endif /* _KUNIT_TEST_H */
> >>>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> >>>> index 750704abe89a..8ad908b61494 100644
> >>>> --- a/lib/kunit/test.c
> >>>> +++ b/lib/kunit/test.c
> >>>> @@ -127,6 +127,12 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
> >>>>
> >>>> +static void kunit_print_failed_param(struct kunit *test)
> >>>> +{
> >>>> +       kunit_err(test, "\n\tTest failed at:\n\ttest case: %s\n\tparameter: %d\n",
> >>>> +                                               test->name, test->param_index + 1);
> >>>> +}
> >>>
> >>> Hmm, perhaps I wasn't clear, but I think I also misunderstood how the
> >>> test case successes are presented: they are not, and it's all bunched
> >>> into a single test case.
> >>>
> >>> Firstly, kunit_err() already prints the test name, so if we want
> >>> something like "  # : the_test_case_name: failed at parameter #X",
> >>> simply having
> >>>
> >>>     kunit_err(test, "failed at parameter #%d\n", test->param_index + 1)
> >>>
> >>> would be what you want.
> >>>
> >>> But I think I missed that parameters do not actually produce a set of
> >>> test cases (sorry for noticing late). I think in their current form,
> >>> the parameterized tests would not be useful for my tests, because each
> >>> of my tests have test cases that have specific init and exit
> >>> functions. For each parameter, these would also need to run.
> >>>
> >>> Ideally, each parameter produces its own independent test case
> >>> "test_case#param_index". That way, CI systems will also be able to
> >>> logically separate different test case params, simply because each
> >>> param produced its own distinct test case.
> >>>
> >>> So, for example, we would get a series of test cases from something
> >>> like KUNIT_CASE_PARAM(test_case, foo_gen_params), and in the output
> >>> we'd see:
> >>>
> >>>     ok X - test_case#1
> >>>     ok X - test_case#2
> >>>     ok X - test_case#3
> >>>     ok X - test_case#4
> >>>     ....
> >>>
> >>> Would that make more sense?
> >>>
> >>> That way we'd ensure that test-case specific initialization and
> >>> cleanup done in init and exit functions is properly taken care of, and
> >>> you wouldn't need kunit_print_failed_param().
> >>>
> >>> AFAIK, for what I propose you'd have to modify kunit_print_ok_not_ok()
> >>> (show param_index if parameterized test) and probably
> >>> kunit_run_case_catch_errors() (generate params and set
> >>> test->param_value and param_index).
> >>>
> >>> Was there a reason why each param cannot be a distinct test case? If
> >>> not, I think this would be more useful.
> >>>
> >>
> >> I tried adding support to run each parameter as a distinct test case by
> >> making changes to kunit_run_case_catch_errors(). The issue here is that
> >> since the results are displayed in KTAP format, this change will result in
> >> each parameter being considered a subtest of another subtest (test case
> >> in KUnit).
> >
> > Do you have example output? That might help understand what's going on.
> >
>
> The change that I tried can be seen here (based on the v4 patch):
> https://gist.github.com/arpi-r/4822899087ca4cc34572ed9e45cc5fee.
>
> Using the kunit tool, I get this error:
>
> [19:20:41] [ERROR]  expected 7 test suites, but got -1
> [ERROR] no tests run!
> [19:20:41] ============================================================
> [19:20:41] Testing complete. 0 tests run. 0 failed. 0 crashed.
>
> But this error is only because of how the tool displays the results.
> The test actually does run, as can be seen in the dmesg output:
>
> TAP version 14
> 1..7
>     # Subtest: ext4_inode_test
>     1..1
>     ok 1 - inode_test_xtimestamp_decoding 1
>     ok 1 - inode_test_xtimestamp_decoding 2
>     ok 1 - inode_test_xtimestamp_decoding 3
>     ok 1 - inode_test_xtimestamp_decoding 4
>     ok 1 - inode_test_xtimestamp_decoding 5
>     ok 1 - inode_test_xtimestamp_decoding 6
>     ok 1 - inode_test_xtimestamp_decoding 7
>     ok 1 - inode_test_xtimestamp_decoding 8
>     ok 1 - inode_test_xtimestamp_decoding 9
>     ok 1 - inode_test_xtimestamp_decoding 10
>     ok 1 - inode_test_xtimestamp_decoding 11
>     ok 1 - inode_test_xtimestamp_decoding 12
>     ok 1 - inode_test_xtimestamp_decoding 13
>     ok 1 - inode_test_xtimestamp_decoding 14
>     ok 1 - inode_test_xtimestamp_decoding 15
>     ok 1 - inode_test_xtimestamp_decoding 16
> ok 1 - ext4_inode_test
> (followed by other kunit test outputs)

Hmm, interesting. Let me play with your patch a bit.

One option is to just have the test case number increment as well,
i.e. have this:
|    ok 1 - inode_test_xtimestamp_decoding#1
|    ok 2 - inode_test_xtimestamp_decoding#2
|    ok 3 - inode_test_xtimestamp_decoding#3
|    ok 4 - inode_test_xtimestamp_decoding#4
|    ok 5 - inode_test_xtimestamp_decoding#5
...

Or is there something else I missed?

Thanks,
-- Marco
