Return-Path: <linux-kselftest+bounces-9367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C488BAB66
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4848A1F22C93
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6CC152190;
	Fri,  3 May 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVhKZ+do"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8611848A;
	Fri,  3 May 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734650; cv=none; b=B5YwxtisOQ1tuOjlCbBy9IKISUE5v7H1VCJFBXm0bDHFOcZHI0Ak1lHW+vOl/CfvUUzeV+X1a1nQvh8JYCszpRbS5VIhiHTItFV8PK98uH8EojaPB76+M1E2l9in76E5a+pdUgrsrn5VfHJHsJ8Khta954P3CEXMCtAatFKLE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734650; c=relaxed/simple;
	bh=TlIfdLNfrl6S15S1xPq+YPnboh0F6e9w1+8fGBpRdfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcLSqyEw8IDnm49Q6JU8XlYQZObrgZ34cxGyaWhHD7w8xi1q1ppN32KK2DggyU8qqW9ky08bMD7k9IlbFrh2oUBUv4PefKRwmXsvJ158fKLsTaWWmBw7yFnuVsXzhCH3mzPIbNWQoBC+2LQ17HDx4sMJgxLxk/HHNkmNDDOSs5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVhKZ+do; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34e6aaa4f51so56020f8f.1;
        Fri, 03 May 2024 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714734647; x=1715339447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ka6AVY/QvAbP4Jr2/+E9fOFPedvIqHwOK3bw2kggB1I=;
        b=dVhKZ+dolz9vOb9rGp9oBj/5FB5rec49DaZY0dnd6KJnbR70uTBEJ77rcywgGJShj/
         fuKdDFxjmban2S5f6OSGOmQmwGWeQoWvkQ+Plc4Del2LNPnhO3IVfsDAzRVHtXADFwsu
         eVxFO9FXyBJVZwdsqaZN+YPWGvZ6sebVFZNefjdbPE3eKdDNB4q8Ozjmcg5TDJJFEdW/
         gWadLBudUInVyyZeHNNOxLl47K3vZtOdMdTqnoOdceytQrKMNf/7eW38xRtNtgeUqXHP
         JF/vOmQc1Wea++vzYPRQyTtfBYQms0IKSNAC/j+SZqd/ACTPIK6AA6qcuxAiO5z7nsGb
         fNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734647; x=1715339447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ka6AVY/QvAbP4Jr2/+E9fOFPedvIqHwOK3bw2kggB1I=;
        b=iF18dZ19ylD04AIXBSkzkhw0DghGeVRHMAufc6uaTsVyaRI4zD/KPeGeJ1zgjE/pTT
         9tENx2fDpXWNf3tzxRGdf5DWnbDF73s3Zyj03Be2F8UGCZteHLGem2kO5kedCKfaNu8+
         Na/AruaE2PheXrD0wDLuZAoWh5NwTH4AQEDBlqslmxgKMG67ssT5aUlhCYKTHQY2cCyO
         +fpJgmC2HXw61vTdAsZxW+fBMAmwZeeIg/0t54O395E+0VDurGmt5sBEtrl/F1tRT5iC
         HVkDcSqN21Y2zmFO8gTJfWrBis7DoG16isaesjH1yf+T74aeN9ys+Fp0rd8C1EVIAR2J
         +qzw==
X-Forwarded-Encrypted: i=1; AJvYcCXTZpq12RAC84XqmbFmeAXVISUqsfPFmtkTKnmmEEB6ZnbRnyAIl6RmRRILjnDpObHNIo2YnWlN834fjC/skmctSuTu7V8p3AQj4OjI82pyWeonQk4r3XmzfwDkT9u4A+GZvxthoxmlpqm2L57Z
X-Gm-Message-State: AOJu0YyhrmN6+xap4RemUVj6+MQFAdwWCJB2InqoyiTcycE4UnAZe6Ij
	c8o8dzGL/ITBCkiZfqCUYhC5+CcstgOa8+LnZkHEa5t5+ad1hMjQ
X-Google-Smtp-Source: AGHT+IGKYu5fG95LNdPp8paAjk3Fd7Om9Jadv7sj8N16eYeLHWUk7YU+Eq9wc9fExEYk1ONHVthLWw==
X-Received: by 2002:a05:600c:358e:b0:41a:3150:cc83 with SMTP id p14-20020a05600c358e00b0041a3150cc83mr1663244wmq.2.1714734646928;
        Fri, 03 May 2024 04:10:46 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm5279881wmq.35.2024.05.03.04.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 04:10:45 -0700 (PDT)
Message-ID: <89c0f7c2-145c-4d4c-a330-f0fff5bb4098@gmail.com>
Date: Fri, 3 May 2024 12:10:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: Cover 'assert.c' with tests
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240427220447.231475-1-ivan.orlov0322@gmail.com>
 <CA+GJov45uEfrXVWSUxvzOLYKPCnTeYeGqHvk=W4n-W_TLYyRuQ@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov45uEfrXVWSUxvzOLYKPCnTeYeGqHvk=W4n-W_TLYyRuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/2/24 00:20, Rae Moar wrote:
> On Sat, Apr 27, 2024 at 6:04 PM Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> There are multiple assertion formatting functions in the `assert.c`
>> file, which are not covered with tests yet. Implement the KUnit test
>> for these functions.
>>
>> The test consists of 11 test cases for the following functions:
>>
>> 1) 'is_literal'
>> 2) 'is_str_literal'
>> 3) 'kunit_assert_prologue', test case for multiple assert types
>> 4) 'kunit_assert_print_msg'
>> 5) 'kunit_unary_assert_format'
>> 6) 'kunit_ptr_not_err_assert_format'
>> 7) 'kunit_binary_assert_format'
>> 8) 'kunit_binary_ptr_assert_format'
>> 9) 'kunit_binary_str_assert_format'
>> 10) 'kunit_assert_hexdump'
>> 11) 'kunit_mem_assert_format'
>>
>> The test aims at maximizing the branch coverage for the assertion
>> formatting functions. As you can see, it covers some of the static
>> helper functions as well, so we have to import the test source in the
>> `assert.c` file in order to be able to call and validate them.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Hello!
> 
> This is a great patch and addition of KUnit tests. Happy to see it.
> Thank you very much!
> 
> I do have a few comments below. But none of them are deal breakers.


Hi Rae,

Thank you so much for the detailed review.

> 
>> ---
>>   lib/kunit/assert.c      |   4 +
>>   lib/kunit/assert_test.c | 416 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 420 insertions(+)
>>   create mode 100644 lib/kunit/assert_test.c
>>
>> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
>> index dd1d633d0fe2..ab68c6daf546 100644
>> --- a/lib/kunit/assert.c
>> +++ b/lib/kunit/assert.c
>> @@ -270,3 +270,7 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
>>          }
>>   }
>>   EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
>> +
>> +#if IS_ENABLED(CONFIG_KUNIT_TEST)
>> +#include "assert_test.c"
>> +#endif
> 
> I might consider using the macro VISIBLE_IF_KUNIT macro, found in
> include/kunit/visibility.h, to make the static functions in assert.c
> visible only if KUnit is enabled. To avoid having to add the include
> here. What do you think?
> 

Wow, I haven't seen this macro before, thank you for the suggestion! 
I'll use it in the V2 of the patch.

I assume we need to use it in combination with EXPORT_SYMBOL_IF_KUNIT, 
otherwise GCC will complain on use of functions without definitions, right?

Also, should the assertion test be in a different file in such a case, 
or we could merge it with one of the existing test files, for instance 
`kunit_test.c`? Having these static functions exported would allow us to 
do that.

>> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
>> new file mode 100644
>> index 000000000000..d54841740761
>> --- /dev/null
>> +++ b/lib/kunit/assert_test.c
>> @@ -0,0 +1,416 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * KUnit test for the assertion formatting functions.
>> + * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
>> + */
>> +#include <kunit/test.h>
>> +
>> +#define TEST_PTR_EXPECTED_BUF_SIZE 128
>> +
>> +static void kunit_test_is_literal(struct kunit *test)
>> +{
>> +       KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
>> +       KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
>> +       KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
>> +       KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
>> +       KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
>> +       KUNIT_EXPECT_FALSE(test, is_literal("", 0));
>> +       KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
>> +       KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
>> +}
>> +
>> +static void kunit_test_is_str_literal(struct kunit *test)
>> +{
>> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hello, World!"));
>> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
>> +       KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
>> +       KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
>> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
>> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
>> +       KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
>> +       KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba\""));
>> +}
>> +
>> +KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>> +
>> +/* this function is used to get a "char *" string from the string stream and defer its cleanup  */
>> +static char *get_str_from_stream(struct kunit *test, struct string_stream *stream)
>> +{
>> +       char *str = string_stream_get_string(stream);
>> +
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
>> +       kunit_add_action(test, kfree_wrapper, (void *)str);
>> +
>> +       return str;
>> +}
>> +
>> +static void kunit_test_assert_prologue(struct kunit *test)
>> +{
>> +       struct string_stream *stream;
>> +       const struct kunit_loc location = {
>> +               .file = "testfile.c",
>> +               .line = 1337,
>> +       };
>> +
>> +       stream = kunit_alloc_string_stream(test, GFP_KERNEL);
>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stream);
>> +
>> +       /* Test an expectation fail prologue */
>> +       kunit_assert_prologue(&location, KUNIT_EXPECTATION, stream);
>> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
>> +                          "EXPECTATION FAILED at testfile.c:1337\n");
>> +
>> +       /* Test an assertion fail prologue */
>> +       string_stream_clear(stream);
>> +       kunit_assert_prologue(&location, KUNIT_ASSERTION, stream);
>> +       KUNIT_EXPECT_STREQ(test, get_str_from_stream(test, stream),
>> +                          "ASSERTION FAILED at testfile.c:1337\n");
> 
> My one main concern with some of these tests is that they test for
> exact matches to string error messages. I worry that these error
> messages are likely to change over time, especially the indentation
> and spacing of the messages. This applies more to some of the tests
> below that check for the indentation.
> 
> I think it is most important that we test for the message containing
> the correct information. Is there a way to instead check if the stream
> contains each of a list of important information. So for example in
> the test above, I think it is important to check the stream contains
> the following strings: "ASSERTION" (maybe even not check for case),
> "testfile.c",  "1337", and "\n" at the end of the stream.
> 
> This applies to the tests below as well. Although, I do see how it may
> be difficult to change this. If there is a way to at least remove the
> checks for indentation and any filler words that would be great.
> 

Yes, I fully agree, checking for the important information would be a 
better way of testing these functions.

My initial intention was to check for the format and indentation as well 
to be sure that some change won't break any of existing parsers (I 
assume there are some parsers for KUnit test output :) ), but in fact 
this approach just bloats the test and makes it less readable. I will 
fix it in the V2, thanks!
-- 
Kind regards,
Ivan Orlov


