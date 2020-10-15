Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8E28ECA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 07:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgJOF2T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 01:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgJOF2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 01:28:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205A3C061755;
        Wed, 14 Oct 2020 22:28:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f5so1171160pgb.1;
        Wed, 14 Oct 2020 22:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZnGvMLzVP6dq5IKxq/jp1HRHeOdaVbEVOzrBdo7gjh0=;
        b=RV/5yHlDKCTOkYuGWZum0CcbTUqmbHr8MqIaLdb01vqng5byB5UbUqF2u+JDGp2GCo
         ZlGGGV896mkLJTjMEFfzfBBazdO+vG9Dpy+4G6ALt/cP3bi1vrBbdAgDpzAXhtx1f0EB
         hRVjwHBgrXXeXf/8JxG41Q0oTuz9QqFDFdYbTGpKurp48JVgZHKMggiDnMWqhGx4Bo/r
         IGAErJGOA7kYyZcHsrJUd1BRgosw7FjMnCXK5hJAII1harcd6zP0hsMiWXMlMJThVCgo
         ls5hRJHmTBeDaZ4QDprcQJjOEMyd/nAiJPR3O7BKh6JLo+GIsIy7QLrpeYDVrRgmSIIC
         OXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZnGvMLzVP6dq5IKxq/jp1HRHeOdaVbEVOzrBdo7gjh0=;
        b=C17BwH1y86u4UAOKrORA5XM3bZo6h+0JwOUTZ6kWAZvklgRrJL9FcECWRBSkzd1m3+
         mlAWKCKjXCDF24UzFRgeGFPl9ubdhwhbm43nFQuU0gtERLNI44mnlp33lT6aYNp2VJa2
         IuAuy5xCDw3q5M642ukRqxJW+Wp0lL6rzYjChztAXPorxFnM9uzZsXJMGjdwo9X9ifdv
         Dt4aoDOaCt68F0c6Sni8Q6JeQWOLAtP0CLTAUNiEd1GY8HA5yjnTX2OdeTlcAEIQh28X
         UwpR+FYPfpVTSTSk8kJTe0MaiPt6oYKgR/5h0I30SCSASUExAcHZ4o+C14QC3TO7Q9kg
         w7lw==
X-Gm-Message-State: AOAM531pJaLYYun3RpDIQJTqj983aRs0a6t5xcQarl/cpfvcxkKawt7U
        kXoby9Pn/W7TAk2KdKVZSJn4WIjAv8mxaMeD
X-Google-Smtp-Source: ABdhPJwUreTsc+q7k45CdcRaudEVWnyqfN7HLOiVIi8kthztc/VpUSfQpyCP9JxVnV2g8OukfXNswg==
X-Received: by 2002:a05:6a00:134c:b029:156:78e8:144d with SMTP id k12-20020a056a00134cb029015678e8144dmr2633552pfu.77.1602739698208;
        Wed, 14 Oct 2020 22:28:18 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.240.187])
        by smtp.gmail.com with ESMTPSA id x5sm1599083pfr.83.2020.10.14.22.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 22:28:17 -0700 (PDT)
Subject: Re: [PATCH 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        skhan@linuxfoundation.org, yzaikin@google.com,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20201010145357.60886-1-98.arpi@gmail.com>
 <CANpmjNOmbPsx-eEQ+TfC0X5CM-Jgy2NBqpYo=h2L9e33rnajSw@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <943d57b5-03b6-f042-1e5a-27dbde4aa25b@gmail.com>
Date:   Thu, 15 Oct 2020 10:58:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNOmbPsx-eEQ+TfC0X5CM-Jgy2NBqpYo=h2L9e33rnajSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/10/20 4:30 pm, Marco Elver wrote:
> On Sat, 10 Oct 2020 at 16:54, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>> Implementation of support for parameterized testing in KUnit.
>>
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>> ---
>>  include/kunit/test.h | 29 +++++++++++++++++++++++++++++
>>  lib/kunit/test.c     | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index 59f3144f009a..4740d66269b4 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -140,10 +140,14 @@ struct kunit;
>>  struct kunit_case {
>>         void (*run_case)(struct kunit *test);
>>         const char *name;
>> +       void* (*get_params)(void);
>> +       int max_parameters_count;
>> +       int parameter_size;
>>
>>         /* private: internal use only. */
>>         bool success;
>>         char *log;
>> +       bool parameterized;
> 
> Why do you need this bool? Doesn't get_params being non-NULL tell you
> if the test case is parameterized?
>Yeah, this will. 
>>  };
>>
>>  static inline char *kunit_status_to_string(bool status)
>> @@ -162,6 +166,11 @@ static inline char *kunit_status_to_string(bool status)
>>   */
>>  #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
>>
>> +#define KUNIT_CASE_PARAM(test_name, getparams, count, size)                            \
>> +               { .run_case = test_name, .name = #test_name,                            \
>> +                 .parameterized = true, .get_params = (void* (*)(void))getparams,      \
>> +                 .max_parameters_count = count, .parameter_size = size }
>> +
> 
> I think this interface is overly complex. For one, if the only purpose
> of the getparams function is to return a pointer to some array, then
> there are only few cases where I see getparams being a function could
> be useful.
> 
> Instead, could we make the getparams function behave like a generator?
> Because then you do not need count, nor size. Its function signature
> would be:
> 
> void* (*generate_params)(void* prev_param);
> 
> The protocol would be:
> 
> - The first call to generate_params is passed prev_param of NULL, and
> returns a pointer to the first parameter P[0].
> 
> - Every nth successive call to generate_params is passed the previous
> parameter P[n-1].
> 
> - When no more parameters are available, generate_params returns NULL.
> 
> - (generate_params should otherwise be stateless, but this is only
> relevant if concurrent calls are expected.)
> 
> 
>>  /**
>>   * struct kunit_suite - describes a related collection of &struct kunit_case
>>   *
>> @@ -206,6 +215,23 @@ struct kunit {
>>         /* private: internal use only. */
>>         const char *name; /* Read only after initialization! */
>>         char *log; /* Points at case log after initialization */
>> +       bool parameterized; /* True for parameterized tests */
>> +       /* param_values stores the test parameters
>> +        * for parameterized tests.
>> +        */
>> +       void *param_values;
>> +       /* max_parameters_count indicates maximum number of
>> +        * parameters for parameterized tests.
>> +        */
>> +       int max_parameters_count;
>> +       /* iterator_count is used by the iterator method
>> +        * for parameterized tests.
>> +        */
>> +       int iterator_count;
>> +       /* parameter_size indicates size of a single test case
>> +        * for parameterized tests.
>> +        */
>> +       int parameter_size;
> 
> All of this would become much simpler if you used the generator
> approach. Likely only 1 field would be required, which is the current
> param.
> 
>>         struct kunit_try_catch try_catch;
>>         /*
>>          * success starts as true, and may only be set to false during a
>> @@ -225,6 +251,7 @@ struct kunit {
>>  };
>>
>>  void kunit_init_test(struct kunit *test, const char *name, char *log);
>> +void kunit_init_param_test(struct kunit *test, struct kunit_case *test_case);
>>
>>  int kunit_run_tests(struct kunit_suite *suite);
>>
>> @@ -237,6 +264,8 @@ int __kunit_test_suites_init(struct kunit_suite **suites);
>>
>>  void __kunit_test_suites_exit(struct kunit_suite **suites);
>>
>> +void *get_test_case_parameters(struct kunit *test);
>> +
>>  /**
>>   * kunit_test_suites() - used to register one or more &struct kunit_suite
>>   *                      with KUnit.
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index c36037200310..ab9e13c81d4a 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -142,6 +142,11 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
>>  }
>>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
>>
>> +static void kunit_print_failed_param(struct kunit *test)
>> +{
>> +       kunit_err(test, "\n\tTest failed at parameter: %d\n", test->iterator_count);
>> +}
>> +
>>  static void kunit_print_string_stream(struct kunit *test,
>>                                       struct string_stream *stream)
>>  {
>> @@ -182,6 +187,9 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>>
>>         assert->format(assert, stream);
>>
>> +       if (test->parameterized)
>> +               kunit_print_failed_param(test);
>> +
>>         kunit_print_string_stream(test, stream);
>>
>>         WARN_ON(string_stream_destroy(stream));
>> @@ -236,6 +244,18 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
>>  }
>>  EXPORT_SYMBOL_GPL(kunit_init_test);
>>
>> +void kunit_init_param_test(struct kunit *test, struct kunit_case *test_case)
>> +{
>> +       spin_lock_init(&test->lock);
>> +       INIT_LIST_HEAD(&test->resources);
>> +       test->parameterized = true;
>> +       test->param_values = (void *)(test_case->get_params());
>> +       test->max_parameters_count = test_case->max_parameters_count;
>> +       test->parameter_size = test_case->parameter_size;
>> +       test->iterator_count = 0;
>> +}
>> +EXPORT_SYMBOL_GPL(kunit_init_param_test);
>> +
>>  /*
>>   * Initializes and runs test case. Does not clean up or do post validations.
>>   */
>> @@ -254,7 +274,14 @@ static void kunit_run_case_internal(struct kunit *test,
>>                 }
>>         }
>>
>> -       test_case->run_case(test);
>> +       if (!test->parameterized) {
>> +               test_case->run_case(test);
>> +       } else {
>> +               int i;
>> +
>> +               for (i = 0; i < test->max_parameters_count; i++)
>> +                       test_case->run_case(test);
> 
> With a generator approach, here you'd call generate_params. Most
> likely, you'll need to stash its result somewhere, e.g. test->param,
> so it can be retrieved by the test case.
> 
>> +       }
>>  }
>>
>>  static void kunit_case_internal_cleanup(struct kunit *test)
>> @@ -343,6 +370,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>>         struct kunit test;
>>
>>         kunit_init_test(&test, test_case->name, test_case->log);
>> +       if (test_case->parameterized)
>> +               kunit_init_param_test(&test, test_case);
>>         try_catch = &test.try_catch;
>>
>>         kunit_try_catch_init(try_catch,
>> @@ -407,6 +436,19 @@ void __kunit_test_suites_exit(struct kunit_suite **suites)
>>  }
>>  EXPORT_SYMBOL_GPL(__kunit_test_suites_exit);
>>
>> +/*
>> + * Iterator method for the parameterized test cases
>> + */
>> +void *get_test_case_parameters(struct kunit *test)
>> +{
>> +       int index = test->iterator_count * test->parameter_size;
>> +
>> +       if (test->iterator_count != test->max_parameters_count)
>> +               test->iterator_count++;
> 
> This is quite confusing, because if get_test_case_parameters is called
> multiple times within the same test case, we'll iterate through all
> the test case params in the same test case? I think this function
> should not have side-effects (like normal getters).
> 
> But if you use the generator approach, you'll likely not need this
> function anyway.
>
The generator approach sounds good. I will work on it for the next version.
 
>> +       return (test->param_values + index);
> 
> Braces not needed.
> 
I will fix this.
>> +}
>> +EXPORT_SYMBOL_GPL(get_test_case_parameters);
>> +
>>  /*
>>   * Used for static resources and when a kunit_resource * has been created by
>>   * kunit_alloc_resource().  When an init function is supplied, @data is passed
>> --
>> 2.25.1
>>

