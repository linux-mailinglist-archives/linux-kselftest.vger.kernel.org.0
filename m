Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240702B34DB
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 13:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgKOMSz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 07:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgKOMSy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 07:18:54 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A49C0613D1;
        Sun, 15 Nov 2020 04:18:54 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id j19so3571931pgg.5;
        Sun, 15 Nov 2020 04:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmC+NTyOPG9xsbPPE7ybYs8sf4wxZzFo3eoABOkQDn0=;
        b=lfAq5dfTWSoXBCb4zCc6T/HTod4y6FrmmlU4Ds4wY1frDrS5S7nAi8cW1oa9nr1Ohs
         12PCzcDjNX89b8f1XfYJonbCg+zWRnZWVvUJ9OuithLy4uBG2aV6P/3fqH82Qmcdvuqv
         nKsEk9HdDWyfdSKHSKiRfrfoiXcPdXNHVFlKyBQkHdL19v5tRYeJE8Retk2I70DViAk1
         HimYTaZgnf6kwbaQ0oXVvPjlkeOOTaHlvsQvQQw3sEf1Z6VY/7SUce6qyyFS0Rq4wicM
         jafi3WPhBdQLAy6HnpxfRijcfAHgc2T0LVDaPFAoMvkw8hRKeY0lnOGcMi/R2M2YteYj
         GYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmC+NTyOPG9xsbPPE7ybYs8sf4wxZzFo3eoABOkQDn0=;
        b=qqTwvPlH3kcUMfJXiC3yVQHM6s9Vyx7gIH8hpjwAJDlDSTFEYUdo0eSQ3acmrUzeax
         ifRLSm0mM4eFpYvBDbkgOqjhkKXkdwMNoEEc5Ob4UpcKaIIIYlZVj3A6pBV/1P51V0Fx
         iWqRVZ8j7zi0IOuIn7FwZ8Tb+4OSJeEUzdx6jcFfWYslm+kVrBR9bo/Pj1NB2YUtpIkb
         GUmtLQ/U0g8fb/RCzVzjKZYMnavZKACXlTn5TADeWpUKx5/1vRpeVupXdPvJlT53RT+5
         jppjfTjddifasILgGtkBmt2Jh00GkVHE34LFMynrtYRsk+WTZu7EB62nxW1jUvtHpoQ/
         QvTw==
X-Gm-Message-State: AOAM532q9oAghgM4p9kj6ssJS0j4qbhsRTNNO3wgSCX6Z7h5SNir24LT
        IYFl9mNVNphKT0FFUfoixork2EI5zYp6MA==
X-Google-Smtp-Source: ABdhPJxoOacgNUAW/J/izVEdb9wykDwXs8uaMg89IrVXfrjlA9O5iwFxY6MWRJaPDKezyFHTuCQWVw==
X-Received: by 2002:a05:6a00:c:b029:18b:eae3:bff0 with SMTP id h12-20020a056a00000cb029018beae3bff0mr9883589pfk.9.1605442733773;
        Sun, 15 Nov 2020 04:18:53 -0800 (PST)
Received: from [192.168.86.81] ([106.51.140.48])
        by smtp.gmail.com with ESMTPSA id f4sm15511310pjs.8.2020.11.15.04.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 04:18:53 -0800 (PST)
Subject: Re: [PATCH v7 1/2] kunit: Support for Parameterized Testing
To:     Marco Elver <elver@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Tim Bird <Tim.Bird@sony.com>, David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
References: <20201114123648.97857-1-98.arpi@gmail.com>
 <CANpmjNNsVxGiGWeij-EsDUpc_fBBYg7iBynis1tQKwh8ks5jQw@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <3c0eb37e-aa9b-876c-6635-1f32181f4e5d@gmail.com>
Date:   Sun, 15 Nov 2020 17:48:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNNsVxGiGWeij-EsDUpc_fBBYg7iBynis1tQKwh8ks5jQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/11/20 2:28 pm, Marco Elver wrote:
> On Sat, 14 Nov 2020 at 13:38, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>> Implementation of support for parameterized testing in KUnit. This
>> approach requires the creation of a test case using the
>> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>>
>> This generator function should return the next parameter given the
>> previous parameter in parameterized tests. It also provides a macro to
>> generate common-case generators based on arrays. Generators may also
>> optionally provide a human-readable description of parameters, which is
>> displayed where available.
>>
>> Note, currently the result of each parameter run is displayed in
>> diagnostic lines, and only the overall test case output summarizes
>> TAP-compliant success or failure of all parameter runs. In future, when
>> supported by kunit-tool, these can be turned into subsubtest outputs.
>>
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>> Co-developed-by: Marco Elver <elver@google.com>
>> Signed-off-by: Marco Elver <elver@google.com>
>> ---
>> Changes v6->v7:
>> - Clarify commit message.
>> - Introduce ability to optionally generate descriptions for parameters;
>>   if no description is provided, we'll still print 'param-N'.
>> - Change diagnostic line format to:
>>         # <test-case-name>: <ok|not ok> N - [<param description>]
>>
>> Changes v5->v6:
>> - Fix alignment to maintain consistency
>>
>> Changes v4->v5:
>> - Update kernel-doc comments.
>> - Use const void* for generator return and prev value types.
>> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
>> - Rework parameterized test case execution strategy: each parameter is executed
>>   as if it was its own test case, with its own test initialization and cleanup
>>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>>   protocol once we have already started execution. Instead, log the result of
>>   each parameter run as a diagnostic comment.
>>
>> Changes v3->v4:
>> - Rename kunit variables
>> - Rename generator function helper macro
>> - Add documentation for generator approach
>> - Display test case name in case of failure along with param index
>>
>> Changes v2->v3:
>> - Modifictaion of generator macro and method
>>
>> Changes v1->v2:
>> - Use of a generator method to access test case parameters
>> Changes v6->v7:
>> - Clarify commit message.
>> - Introduce ability to optionally generate descriptions for parameters;
>>   if no description is provided, we'll still print 'param-N'.
>> - Change diagnostic line format to:
>>         # <test-case-name>: <ok|not ok> N - [<param description>]
>> - Before execution of parameterized test case, count number of
>>   parameters and display number of parameters. Currently also as a
>>   diagnostic line, but this may be used in future to generate a subsubtest
>>   plan. A requirement of this change is that generators must generate a
>>   deterministic number of parameters.
>>
>> Changes v5->v6:
>> - Fix alignment to maintain consistency
>>
>> Changes v4->v5:
>> - Update kernel-doc comments.
>> - Use const void* for generator return and prev value types.
>> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
>> - Rework parameterized test case execution strategy: each parameter is executed
>>   as if it was its own test case, with its own test initialization and cleanup
>>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>>   protocol once we have already started execution. Instead, log the result of
>>   each parameter run as a diagnostic comment.
>>
>> Changes v3->v4:
>> - Rename kunit variables
>> - Rename generator function helper macro
>> - Add documentation for generator approach
>> - Display test case name in case of failure along with param index
>>
>> Changes v2->v3:
>> - Modifictaion of generator macro and method
>>
>> Changes v1->v2:
>> - Use of a generator method to access test case parameters
>>
>>  include/kunit/test.h | 51 ++++++++++++++++++++++++++++++++++++++
>>  lib/kunit/test.c     | 59 ++++++++++++++++++++++++++++++++++----------
>>  2 files changed, 97 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index db1b0ae666c4..cf5f33b1c890 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -94,6 +94,9 @@ struct kunit;
>>  /* Size of log associated with test. */
>>  #define KUNIT_LOG_SIZE 512
>>
>> +/* Maximum size of parameter description string. */
>> +#define KUNIT_PARAM_DESC_SIZE 64
> 
> I think we need to make this larger, perhaps 128. I just noticed a few
> of the inode-test strings are >64 chars (and it should probably also
> use strncpy() to copy to description, which is my bad).
>

Okay, I will make the description size larger and use strncpy().
 
>>  /*
>>   * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
>>   * sub-subtest.  See the "Subtests" section in
>> @@ -107,6 +110,7 @@ struct kunit;
> [...]
>> +/**
>> + * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
>> + * @name:  prefix for the test parameter generator function.
>> + * @array: array of test parameters.
>> + * @get_desc: function to convert param to description; NULL to use default
>> + *
>> + * Define function @name_gen_params which uses @array to generate parameters.
>> + */
>> +#define KUNIT_ARRAY_PARAM(name, array, get_desc)                                               \
>> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
>> +       {                                                                                       \
>> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \
> 
> Why did you reintroduce a space between * and __next? AFAIK, this
> should follow the same style as the rest of the kernel, and it should
> just be 'thetype *ptr'.
> 

I introduced this space because checkpatch.pl gave an error without the space:
ERROR: need consistent spacing around '*' (ctx:WxV)
#1786: FILE: ./include/kunit/test.h:1786:
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\

But, if this is a mistake as it doesn't recognize __next to be a pointer, I will remove the space.

>> +               if (__next - (array) < ARRAY_SIZE((array))) {                                   \
>> +                       void (*__get_desc)(typeof(__next), char *) = get_desc;                  \
>> +                       if (__get_desc)                                                         \
>> +                               __get_desc(__next, desc);                                       \
>> +                       return __next;                                                          \
>> +               }                                                                               \
>> +               return NULL;                                                                    \
>> +       }
>> +
> 
> Thanks,
> -- Marco
> 

Thanks!
