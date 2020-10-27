Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4C29B250
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 15:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761391AbgJ0OjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 10:39:23 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55793 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899174AbgJ0OjX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 10:39:23 -0400
Received: by mail-pj1-f67.google.com with SMTP id c17so881772pjo.5;
        Tue, 27 Oct 2020 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jq4p9ZOCOpULvr9rjXRr1hfcbCktqSPvgN26N3fDMKI=;
        b=P2rHbNkCxVqv3VzLZrI9pRiekGKij2jCTuLBGnFuzNzKo232QsfG5w1r/Ncmxekom+
         FFG8bIkBe7md8JwLjdqcGVeZGkV7Pq3nVV3VLIKFTdh1WdUEpKSE0MwJM29wEhJUo0de
         Z2hg45xbwDwnBTwgLx9hQPLCm7zrVUlcqZ3TrnhSs8xQ18hW0zm+PZSXAyG3okq7iQgD
         pZzm37irrPmVMmjxbC9qrynZkt1FrCY60Hb18mZrpzAqWvD0lSZKFPVP6OnSI8dQKPUE
         +3T0Ne7Ji1MMYO4ddfIrx8kQHzrz5SopDaNxWAsZI369AADhnGxRRnt6jFNNcJxkWFKP
         K0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jq4p9ZOCOpULvr9rjXRr1hfcbCktqSPvgN26N3fDMKI=;
        b=Q11zpA2Jsh3x93AFopGaxv7k3uGkMoWyeSQ9TJaIUqlpmRfHV2BjPTNsI41CumDl0w
         PG0sC7ygTSuddbpX5ZNOjOZg3HJBcfnGwcV0j2KBkORxwUGPd5FyFatLItP3vOfti+k9
         pwQWal7UYJPgsfJSG85x6yNSfnOHHMfne7XgCtaP/UeOz3VxvJ7jbN59EnRAl6A1G/pR
         EN5+tpKTNM2dn7fQfazfU8dAxKCeVbH33sdrnU7xaI0O0K6gIiLqwmUldRtoeYMant9l
         G/m94Wmyr/JG4xf3wZYSgecdCKgdluLg0RXpggi2fwvVeoAUwEy03HSesbbL+qsTrs1d
         m4Kg==
X-Gm-Message-State: AOAM530pH/+nfC2p0a7qMhIdZQqX3qoBkzrW/Eag6S/Yqx8lJcQwTgXl
        eFWEP6pHP9mQQYbQMV/Cq/E4jltruJQph+SY
X-Google-Smtp-Source: ABdhPJzXa1Xh/0Y5jrlOMXl+jhRdt0b7jdQnNTre8jc74QTXFQrzuJKmJJtiY0V93QdH6AsI1Bpjgg==
X-Received: by 2002:a17:902:b78c:b029:d4:da94:8766 with SMTP id e12-20020a170902b78cb02900d4da948766mr2632161pls.31.1603809561465;
        Tue, 27 Oct 2020 07:39:21 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.240.100])
        by smtp.gmail.com with ESMTPSA id x16sm2554341pff.14.2020.10.27.07.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 07:39:20 -0700 (PDT)
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
 <CANpmjNMnkXLFeQU6xZNwj3bWqE4Ap47wQKkL3-0ENX+R1YoLOg@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <5c38ba07-f910-ed0a-1a75-85240effaea7@gmail.com>
Date:   Tue, 27 Oct 2020 20:09:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNMnkXLFeQU6xZNwj3bWqE4Ap47wQKkL3-0ENX+R1YoLOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27/10/20 2:33 pm, Marco Elver wrote:
> I just tried to give this a spin on some of my tests and noticed some
> more things (apologies for the multiple rounds of comments):
> 
> On Mon, 26 Oct 2020 at 19:36, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> [...]
>>  /**
>>   * struct kunit_suite - describes a related collection of &struct kunit_case
>> @@ -208,6 +217,15 @@ struct kunit {
>>         const char *name; /* Read only after initialization! */
>>         char *log; /* Points at case log after initialization */
>>         struct kunit_try_catch try_catch;
>> +       /* param_values points to test case parameters in parameterized tests */
>> +       void *param_values;
> 
> This should be singular, i.e. "param_value", since the generator only
> generates 1 value for each test. Whether or not that value is a
> pointer that points to more than 1 value or is an integer etc. is
> entirely test-dependent.
> 
>> +       /*
>> +        * current_param stores the index of the parameter in
>> +        * the array of parameters in parameterized tests.
>> +        * current_param + 1 is printed to indicate the parameter
>> +        * that causes the test to fail in case of test failure.
>> +        */
>> +       int current_param;
> 
> I think, per your comment above, this should be named "param_index".
> Also, I would suggest removing the mention of "array" in the comment,
> because the parameters aren't dependent on use of an array.
> 
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
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 750704abe89a..b70ab9b12f3b 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -127,6 +127,11 @@ unsigned int kunit_test_case_num(struct kunit_suite *suite,
>>  }
>>  EXPORT_SYMBOL_GPL(kunit_test_case_num);
>>
>> +static void kunit_print_failed_param(struct kunit *test)
>> +{
>> +       kunit_err(test, "\n\tTest failed at parameter: %d\n", test->current_param + 1);
>> +}
> 
> Is this the only place where the param index is used? It might be
> helpful to show the index together with the test-case name, otherwise
> we get a series of test cases in the output which are all named the
> same which can be confusing.
> 

Yes, this is the only place param index is used.

>>  static void kunit_print_string_stream(struct kunit *test,
>>                                       struct string_stream *stream)
>>  {
>> @@ -168,6 +173,8 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
>>         assert->format(assert, stream);
>>
>>         kunit_print_string_stream(test, stream);
>> +       if (test->param_values)
>> +               kunit_print_failed_param(test);
>>
>>         WARN_ON(string_stream_destroy(stream));
>>  }
>> @@ -239,7 +246,18 @@ static void kunit_run_case_internal(struct kunit *test,
>>                 }
>>         }
>>
>> -       test_case->run_case(test);
>> +       if (!test_case->generate_params) {
>> +               test_case->run_case(test);
>> +       } else {
>> +               test->param_values = test_case->generate_params(NULL);
>> +               test->current_param = 0;
>> +
>> +               while (test->param_values) {
>> +                       test_case->run_case(test);
>> +                       test->param_values = test_case->generate_params(test->param_values);
>> +                       test->current_param++;
>> +               }
>> +       }
>>  }
> 
> Looking forward to v4. :-)
> 
> Thanks,
> -- Marco
> 

I will make all the suggested changes.
Thanks!
