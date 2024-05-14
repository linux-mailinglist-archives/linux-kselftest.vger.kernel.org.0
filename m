Return-Path: <linux-kselftest+bounces-10178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333038C57F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 16:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF8E1F24AA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878B15B12C;
	Tue, 14 May 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHYfgl6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63C15AAD1;
	Tue, 14 May 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697101; cv=none; b=scv+EEEGBXH1uh6S23NJmT6grhkq7NIQMCeSzwrquAMWigjD6lIxnvNH/7HD+WQw2rdNghuJ4CJOaVYnwkqgdSdwr8tzlZFLZBJrMriH2W+v+eGo96ZltGHN8VjIFXJibcQ6RE3GJJg/nY802zYOpcB4GRdRFXvPtMejFFRf+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697101; c=relaxed/simple;
	bh=jlF/bIe7CN9snURygo8IMALIeLH8XvWGlimge858/UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cI3R5tx3X+/3EE8CgesGpABox0wF9tmDd69PnrhdLO/v34lAYCyrE+IhdEqjMRDy7svMsncaYdnXrvYAUdIwwg28eK3JQ6vmjld0L0BbEGa7d6reSt/4fIm8b925jxh4maR0xVkjPi+nO1AXAsAAyBJ6IclJMjvRE6karDNSPz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHYfgl6F; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e453dc8a31so5328631fa.2;
        Tue, 14 May 2024 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715697098; x=1716301898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lc4MFdELPshu2lsxF3Gx8/NVuPOETuqX5KX3dd0dWsY=;
        b=NHYfgl6FAwtZ04UY1DYTtxQWHuBQcJjwudfNpfiDt9Dswp43C5xnPcSjpMO672HJHc
         PFnvqztvwoP6/KdxB/n/l114etW7yaUS0+kc8bGUbFJMOk+CsjbZcTyMB40MoaScvCUd
         ko1onpZ0pSDU12mvIbFHUb6FT65SZJSBqtuY/nJXw0HUytzfDDPOipOvNy/wXu0eyYfE
         qhyujrf/jyBboKM4MR3Y9lXrxEQ1bh61fdoU6X0uSVuO7QiT3PoeGeOCM77+XHhoy6dI
         xn/voWo5X4HvpSf77abEImCafwrdRvBLyQKoAtgUBUgih8BWbNEYISPCqop4yuDC1R43
         IM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697098; x=1716301898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc4MFdELPshu2lsxF3Gx8/NVuPOETuqX5KX3dd0dWsY=;
        b=ga1QHxxmK0m6MKM3nF+Zns0kwgp2mGC0Py8loz+7wNirvq3VVtLf4Ydk1Pbq7BnMuQ
         STpA3afDKXfdhoPA7azeQkY3ggzoqgNu8MAYH0ajtTEoebQZa1zNYeBmj/qttdnLHbyA
         P5As80nXez1vaWQqwD6RmWLVoQvQO4C2w7A70DBW5X8aDjMC0w61BmxDJ4MZBiSqDIwV
         NtvJJCt6mVl5PaG5HjHXhYqx1NCnfgEEECN7HOKwo5mdAsFoydTeHMs24nMgnEIHrxY6
         MdzLVxVs/4gtExV2lMya2UMwFLzDg88vPrtBiFRnaT6ulHv71qekIKZ8gZzTpsZZgJzp
         gH1w==
X-Forwarded-Encrypted: i=1; AJvYcCV6HmR1dJ/vBT6RgVBr2CRvynjLyya7JGtDpeNPPrZQ51BOUxE6gi2lnmsGX5/t9x6sMoJJDcTSpAB3nzu9uJ4OYdyow5aHZs10287qFB5QEouWl+8BtjNjLehdzXMRftx9SbfSQPjV3qY+93dr
X-Gm-Message-State: AOJu0Yx/gylRNMDonk4Uu2GuiIG7jlegx2JeerzQ9GQgDsHW48jgABVU
	DeNHuq7FDoCSMRtu9hKW/iGrgMV/MifYQWUFQWsvU1PeIzngPxPf
X-Google-Smtp-Source: AGHT+IEJ83tg3YBvUTMgcRym9h6R+AUbvxJrTLbuDHPEzWBByQV1AUWM8rlGXQ6QAoyxntDq3wmMNQ==
X-Received: by 2002:a05:651c:2210:b0:2e4:c5fb:f3ed with SMTP id 38308e7fff4ca-2e5205e8592mr89583301fa.4.1715697097411;
        Tue, 14 May 2024 07:31:37 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff5e3dcfbsm157880655e9.22.2024.05.14.07.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 07:31:36 -0700 (PDT)
Message-ID: <44b5b31f-ac98-4c5c-8bc4-ebff9579b4d7@gmail.com>
Date: Tue, 14 May 2024 15:31:33 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kunit: Cover 'assert.c' with tests
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kunit-dev@googlegroups.com, skhan@linuxfoundation.org
References: <20240509090546.944808-1-ivan.orlov0322@gmail.com>
 <CA+GJov6hq0WsjqX1LrC2m7YS1nD37+zGmO+i1R1OajwYQZXY8w@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CA+GJov6hq0WsjqX1LrC2m7YS1nD37+zGmO+i1R1OajwYQZXY8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/14/24 01:17, Rae Moar wrote:
> On Thu, May 9, 2024 at 5:05 AM Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
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
>> formatting functions.
>>
>> As you can see, it covers some of the static helper functions as
>> well, so mark the static functions in `assert.c` as 'VISIBLE_IF_KUNIT'
>> and conditionally export them with EXPORT_SYMBOL_IF_KUNIT. Add the
>> corresponding definitions to `assert.h`.
>>
>> Build the assert test when CONFIG_KUNIT_TEST is enabled, similar to
>> how it is done for the string stream test.
> 
> Hello!
> 
> This looks great to me! Thanks for all your work on this! There is
> just one comment I have below. Once that is fixed up, I am happy to
> add a reviewed-by.
> 
> Thanks!
> -Rae
> 
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>> V1 -> V2:
>> - Check the output from the string stream for containing the key parts
>> instead of comparing the results with expected strings char by char, as
>> it was suggested by Rae Moar <rmoar@google.com>. Define two macros to
>> make it possible (ASSERT_TEST_EXPECT_CONTAIN and
>> ASSERT_TEST_EXPECT_NCONTAIN).
>> - Mark the static functions in `assert.c` as VISIBLE_IF_KUNIT and export
>> them conditionally if kunit is enabled instead of including the
>> `assert_test.c` file in the end of `assert.c`. This way we will decouple
>> the test from the implementation (SUT).
>> - Update the kunit_assert_hexdump test: now it checks for presense of
>> the brackets '<>' around the non-matching bytes, instead of comparing
>> the kunit_assert_hexdump output char by char.
>> V2 -> V3:
>> - Make test case array and test suite definitions static
>> - Change the condition in `assert.h`: we should declare VISIBLE_IF_KUNIT
>> functions in the header file when CONFIG_KUNIT is enabled, not
>> CONFIG_KUNIT_TEST. Otherwise, if CONFIG_KUNIT_TEST is disabled,
>> VISIBLE_IF_KUNIT functions in the `assert.c` are not static, and
>> prototypes for them can't be found.
>> - Add MODULE_LICENSE and MODULE_DESCRIPTION macros
>>
>>   include/kunit/assert.h  |  11 ++
>>   lib/kunit/Makefile      |   1 +
>>   lib/kunit/assert.c      |  24 ++-
>>   lib/kunit/assert_test.c | 391 ++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 419 insertions(+), 8 deletions(-)
>>   create mode 100644 lib/kunit/assert_test.c
>>
>> diff --git a/include/kunit/assert.h b/include/kunit/assert.h
>> index 24c2b9fa61e8..7e7490a74b13 100644
>> --- a/include/kunit/assert.h
>> +++ b/include/kunit/assert.h
>> @@ -218,4 +218,15 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
>>                               const struct va_format *message,
>>                               struct string_stream *stream);
>>
>> +#if IS_ENABLED(CONFIG_KUNIT)
>> +void kunit_assert_print_msg(const struct va_format *message,
>> +                           struct string_stream *stream);
>> +bool is_literal(const char *text, long long value);
>> +bool is_str_literal(const char *text, const char *value);
>> +void kunit_assert_hexdump(struct string_stream *stream,
>> +                         const void *buf,
>> +                         const void *compared_buf,
>> +                         const size_t len);
>> +#endif
>> +
>>   #endif /*  _KUNIT_ASSERT_H */
>> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
>> index 309659a32a78..be7c9903936f 100644
>> --- a/lib/kunit/Makefile
>> +++ b/lib/kunit/Makefile
>> @@ -18,6 +18,7 @@ endif
>>   obj-y +=                               hooks.o
>>
>>   obj-$(CONFIG_KUNIT_TEST) +=            kunit-test.o
>> +obj-$(CONFIG_KUNIT_TEST) +=            assert_test.o
>>
>>   # string-stream-test compiles built-in only.
>>   ifeq ($(CONFIG_KUNIT_TEST),y)
>> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
>> index dd1d633d0fe2..382eb409d34b 100644
>> --- a/lib/kunit/assert.c
>> +++ b/lib/kunit/assert.c
>> @@ -7,6 +7,7 @@
>>    */
>>   #include <kunit/assert.h>
>>   #include <kunit/test.h>
>> +#include <kunit/visibility.h>
>>
>>   #include "string-stream.h"
>>
>> @@ -30,12 +31,14 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
>>   }
>>   EXPORT_SYMBOL_GPL(kunit_assert_prologue);
>>
>> -static void kunit_assert_print_msg(const struct va_format *message,
>> -                                  struct string_stream *stream)
>> +VISIBLE_IF_KUNIT
>> +void kunit_assert_print_msg(const struct va_format *message,
>> +                           struct string_stream *stream)
>>   {
>>          if (message->fmt)
>>                  string_stream_add(stream, "\n%pV", message);
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
>>
>>   void kunit_fail_assert_format(const struct kunit_assert *assert,
>>                                const struct va_format *message,
>> @@ -89,7 +92,7 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
>>   EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
>>
>>   /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
>> -static bool is_literal(const char *text, long long value)
>> +VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
>>   {
>>          char *buffer;
>>          int len;
>> @@ -110,6 +113,7 @@ static bool is_literal(const char *text, long long value)
>>
>>          return ret;
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(is_literal);
>>
>>   void kunit_binary_assert_format(const struct kunit_assert *assert,
>>                                  const struct va_format *message,
>> @@ -166,7 +170,7 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
>>   /* Checks if KUNIT_EXPECT_STREQ() args were string literals.
>>    * Note: `text` will have ""s where as `value` will not.
>>    */
>> -static bool is_str_literal(const char *text, const char *value)
>> +VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
>>   {
>>          int len;
>>
>> @@ -178,6 +182,7 @@ static bool is_str_literal(const char *text, const char *value)
>>
>>          return strncmp(text + 1, value, len - 2) == 0;
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(is_str_literal);
>>
>>   void kunit_binary_str_assert_format(const struct kunit_assert *assert,
>>                                      const struct va_format *message,
>> @@ -208,10 +213,11 @@ EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
>>   /* Adds a hexdump of a buffer to a string_stream comparing it with
>>    * a second buffer. The different bytes are marked with <>.
>>    */
>> -static void kunit_assert_hexdump(struct string_stream *stream,
>> -                                const void *buf,
>> -                                const void *compared_buf,
>> -                                const size_t len)
>> +VISIBLE_IF_KUNIT
>> +void kunit_assert_hexdump(struct string_stream *stream,
>> +                         const void *buf,
>> +                         const void *compared_buf,
>> +                         const size_t len)
>>   {
>>          size_t i;
>>          const u8 *buf1 = buf;
>> @@ -229,6 +235,7 @@ static void kunit_assert_hexdump(struct string_stream *stream,
>>                          string_stream_add(stream, " %02x ", buf1[i]);
>>          }
>>   }
>> +EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
>>
>>   void kunit_mem_assert_format(const struct kunit_assert *assert,
>>                               const struct va_format *message,
>> @@ -269,4 +276,5 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
>>                  kunit_assert_print_msg(message, stream);
>>          }
>>   }
>> +
>>   EXPORT_SYMBOL_GPL(kunit_mem_assert_format);
>> diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
>> new file mode 100644
>> index 000000000000..1347a964204b
>> --- /dev/null
>> +++ b/lib/kunit/assert_test.c
>> @@ -0,0 +1,391 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * KUnit test for the assertion formatting functions.
>> + * Author: Ivan Orlov <ivan.orlov0322@gmail.com>
>> + */
>> +#include <kunit/test.h>
>> +#include "string-stream.h"
>> +
>> +#define TEST_PTR_EXPECTED_BUF_SIZE 32
>> +#define HEXDUMP_TEST_BUF_LEN 5
>> +#define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(test, strstr(str, substr))
>> +#define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALSE(test, strstr(str, substr))
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
> 
> When trying to make the kernel with this test loaded in, I am getting
> an error that string_stream_get_string, string_stream_clear, and
> kunit_alloc_string_stream are undefined.
> 
> So either these three methods will have to be exported using
> EXPORT_SYMBOL_KUNIT or this test cannot be loaded and run as a module.
> 
> But once this is fixed up this should be good to go.

Hi Rae,

Thank you so much for the review.

At the moment, I believe the best approach would be to make this test 
depend on CONFIG_KUNIT_TEST=y (as it is done for string-stream-test).

However, I assume that every (standalone) test should be able to run as 
a module, and I'd like to add EXPORT_SYMBOL_IF_KUNIT to all of the 
non-static string-stream functions in a separate patch series. It will 
require updating string-stream-test.c as well (adding MODULE_IMPORT_NS). 
What do you think?

Thank you once again,
-- 
Kind regards,
Ivan Orlov


