Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F1429A3E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 06:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505755AbgJ0FOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 01:14:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44466 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410224AbgJ0FOO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 01:14:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id 133so211076pfx.11;
        Mon, 26 Oct 2020 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V6b7HwvvFZ2s1xYsjf24gbEkjeQ0R1jZb5gJGqmof84=;
        b=QV32QpdFiFdGKP8KIf3ztwU5B2L+kQ1TISGCOSyRr7wqANt+4iKpSWIDz9FXOVJiNY
         irLnmSzzDG34JYL9ztGPJT7Eu5o9dNRCr+tOE0KqM0LTMF2R1QqmDVmeEQnFLrO+ZweC
         ha3pZVAxePVmy3GHH67EPgBWSFxuJKrHP+97wFhhBV6yhEdvo3FE2bbeikaYjl3tmVF/
         mmwIaskRvfZYnHtO+qHXJ8WhB5NYnRpnt5wwgzEyqcPDWKsgDkrCg5fs4W8g/SDqlGi/
         aYXSL0GyEmyycjfKZOBm5SKJM9vpR9Sx0ZffKH+Pn539f+rUzDYRAOo2ZEPjRTSC9CXn
         DF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V6b7HwvvFZ2s1xYsjf24gbEkjeQ0R1jZb5gJGqmof84=;
        b=JUv4B7shyAacOnifvW/OsjcrsKyX5p9SbdW70EyrweELHAa0iZB3XyHnpSR7sVjacm
         nf1F8qZ/A1Xawnp0kKbt5Nk47TjmOXsPjzicxP+GO1bLvKBX8DiBExz98wy3TqaIet8u
         8JizuSL/Y+fXnFKDU+3lAkn6ritJjSI+UBRWrVpesH5y7vqkhurxZEycqU8N4+AdVy4P
         8A3AJIyMdOLO3YoOi8GgITTzMNH1Yta8vCNHRqjfhInp8tWcS64/S7HlFU4UbdRrYHRz
         Aw3R+uSqo8Za/K4MSu0BJgsRpgKxYYI+9ih1XAFuufQ2mz6efxiP1aIOKoCIHlb/FutK
         40Ag==
X-Gm-Message-State: AOAM530Bgvgs4YydoSp2O5ekUTGqChbDOqXhFGy6U3Xlc1gGN68PWRRA
        MR6sq0sWztnfsrhSEuRCKdY6oKNYET1yIsk6
X-Google-Smtp-Source: ABdhPJwI7iAg84+0QDG22suSqnWNw8moOpZOVmTy5bWa+NEsj3D7XxDRHLUnPHTYynMmO4JLGk72yg==
X-Received: by 2002:a63:af08:: with SMTP id w8mr411863pge.419.1603775651104;
        Mon, 26 Oct 2020 22:14:11 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.240.100])
        by smtp.gmail.com with ESMTPSA id 78sm512426pfz.211.2020.10.26.22.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 22:14:10 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] kunit: Support for Parameterized Testing
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
References: <20201026183523.82749-1-98.arpi@gmail.com>
 <CANpmjNNQtGC_jDp8TSHRHOMXi7aTQgwjtUiCWE+YqBgq-G2z5Q@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <f25c881d-03f9-e246-d8d4-e985d9662d04@gmail.com>
Date:   Tue, 27 Oct 2020 10:44:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNNQtGC_jDp8TSHRHOMXi7aTQgwjtUiCWE+YqBgq-G2z5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27/10/20 4:44 am, Marco Elver wrote:
> On Mon, 26 Oct 2020 at 19:36, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
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
>> Changes v2->v3:
>> - Modifictaion of generator macro and method
> 
> Great to see it worked as expected!
> 
>> Changes v1->v2:
>> - Use of a generator method to access test case parameters
>>
>>  include/kunit/test.h | 32 ++++++++++++++++++++++++++++++++
>>  lib/kunit/test.c     | 20 +++++++++++++++++++-
>>  2 files changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index a423fffefea0..16bf9f334e2c 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -142,6 +142,12 @@ struct kunit_case {
>>         void (*run_case)(struct kunit *test);
>>         const char *name;
>>
>> +       /*
>> +        * Pointer to test parameter generator function.
>> +        * Used only for parameterized tests.
> 
> What I meant was to give a description of the protocol, so that if
> somebody wanted, they could (without reading the implementation)
> implement their own custom generator without the helper macro.
> 
> E.g. something like: "The generator function is used to lazily
> generate a series of arbitrarily typed values that fit into a void*.
> The argument @prev is the previously returned value, which should be
> used to derive the next value; @prev is set to NULL on the initial
> generator call. When no more values are available, the generator must
> return NULL."
>

Oh okay. I am not sure if this is the best place to add documentation for this.
 
>> +        */
>> +       void* (*generate_params)(void *prev);
>> +
>>         /* private: internal use only. */
>>         bool success;
>>         char *log;
>> @@ -162,6 +168,9 @@ static inline char *kunit_status_to_string(bool status)
>>   * &struct kunit_case for an example on how to use it.
>>   */
>>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>> +#define KUNIT_CASE_PARAM(test_name, gen_params)                        \
>> +               { .run_case = test_name, .name = #test_name,    \
>> +                 .generate_params = gen_params }
>>
>>  /**
>>   * struct kunit_suite - describes a related collection of &struct kunit_case
>> @@ -208,6 +217,15 @@ struct kunit {
>>         const char *name; /* Read only after initialization! */
>>         char *log; /* Points at case log after initialization */
>>         struct kunit_try_catch try_catch;
>> +       /* param_values points to test case parameters in parameterized tests */
>> +       void *param_values;
>> +       /*
>> +        * current_param stores the index of the parameter in
>> +        * the array of parameters in parameterized tests.
>> +        * current_param + 1 is printed to indicate the parameter
>> +        * that causes the test to fail in case of test failure.
>> +        */
>> +       int current_param;
>>         /*
>>          * success starts as true, and may only be set to false during a
>>          * test case; thus, it is safe to update this across multiple
>> @@ -1742,4 +1760,18 @@ do {                                                                            \
>>                                                 fmt,                           \
>>                                                 ##__VA_ARGS__)
>>
>> +/**
>> + * KUNIT_PARAM_GENERATOR() - Helper method for test parameter generators
>> + *                          required in parameterized tests.
> 
> This is only for arrays, which is why I suggested KUNIT_ARRAY_PARAM()
> as the name.
> 
> A generator can very well be implemented without an array, so this
> macro name is confusing. In future somebody might want to provide a
> macro that takes a start + end value (and maybe a step value) to
> generate a series of values. That generator could be named
> KUNIT_RANGE_PARAM(name, start, end, step) and gives us a generator
> that is also named name##_gen_params. (If you want to try implementing
> that macro, I'd suggest doing it as a separate patch.)
> 
> And I don't think we need to put "GENERATOR" into the name of these
> macros, because the generators are now the fundamental method with
> which to get parameterized tests. We don't need to state the obvious,
> in favor of some brevity.
>

Okay, makes sense. I will change it to KUNIT_ARRAY_PARAM() for the next version.
 
>> + * @name:  prefix of the name for the test parameter generator function.
>> + * @prev: a pointer to the previous test parameter, NULL for first parameter.
>> + * @array: a user-supplied pointer to an array of test parameters.
>> + */
>> +#define KUNIT_PARAM_GENERATOR(name, array)                                                     \
>> +       static void *name##_gen_params(void *prev)                                              \
>> +       {                                                                                       \
>> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
>> +               return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;                  \
>> +       }
>> +
>>  #endif /* _KUNIT_TEST_H */
> 
> Thanks,
> -- Marco
> 

Thanks!
