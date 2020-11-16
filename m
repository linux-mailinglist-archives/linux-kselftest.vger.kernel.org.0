Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234E52B3C41
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 05:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKPEzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 23:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKPEzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 23:55:03 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00468C0613CF;
        Sun, 15 Nov 2020 20:55:02 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so13019985pfu.1;
        Sun, 15 Nov 2020 20:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8y8EzNwAbA7Mk6zHCNBMz+8QqO4AkN7jfQ83GAtzKaw=;
        b=JgXdNauNUS4omz7BJcV5u4oNPci5St150RSWKlbzPC67rcAoTFCDpyCPfn969zHHKq
         br3c0R9j32AZyLzt/737eYU6x9YfHFlR4C/0Hf19aKKHDDJ4o1Uqvkv0+WiKWG4GYtvI
         MHmLQkUq7GCOCzzsnPFxph29nTB3vG4RMXlp5XTU+H5f/Zy9+f3h/qZQyCJOB76l8J3G
         4ZUDHNdIa+0Czki/65jxn1BxBuIDFLi9gEI8NqtPGc1hsAqlRp1k5b3ogLBKCcot2hM7
         aXLLEBeN0WGLYrz/+rgENN2HpWaJBb+Sfb7dj1ZbfSZmqk9TDSxGGQLRylMrtznOcRUk
         ckKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8y8EzNwAbA7Mk6zHCNBMz+8QqO4AkN7jfQ83GAtzKaw=;
        b=i2lNF5YEKu9EFvXJisD1C2ileqLLIKh8W9eS0KGaEmT4YKsvQPGYsahvQOw/Ed17GF
         wPXwizzVnFP2yQswbZgErGaNVMQqWQEzs28De5PWBIMWDjM4tclZ4VQC3LbcLLN2oQj5
         58kZjgRAO/zNvrZFdjVBiKLl5QxEhuu175aelpT4nA31ZMkfO72HCPk8X1NzMpXV8yxH
         xhrGpfxGEAZc67zr52lK69+x1o7yh0oNMMOSFDnwCsFEs3LfInHoGItmzkc1bWs8O4Jw
         Z/T1g86WCD8iSUODjNLvdSeuHLEd2cY7F4V7SWrI3jH4dYwl7E0VKp+A6P9+d4csDmq0
         dXuw==
X-Gm-Message-State: AOAM532ZbOMaf43X8/qkWKzi03wmLZFCnmniX8nwi/nopWbiLWFjCr7O
        MLZdNQJ7t5m1DecidRP0qGSIzE2d/jRKUQ==
X-Google-Smtp-Source: ABdhPJzm9+O7++vo06zq3bbBabM8q2zCStmcQUezajR8hzGM3/m3V9f5M5CiE9CGkndjZ3OhwgL7ww==
X-Received: by 2002:a05:6a00:80e:b029:196:1cad:b64 with SMTP id m14-20020a056a00080eb02901961cad0b64mr10545502pfk.5.1605502502059;
        Sun, 15 Nov 2020 20:55:02 -0800 (PST)
Received: from [192.168.86.81] ([106.51.140.48])
        by smtp.gmail.com with ESMTPSA id x12sm15818385pjr.51.2020.11.15.20.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 20:55:01 -0800 (PST)
Subject: Re: [PATCH v8 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
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
References: <20201115185759.169279-1-98.arpi@gmail.com>
 <20201115185905.169349-1-98.arpi@gmail.com>
 <CANpmjNPKfPeiXUUPwz1aU6iKwOXpSZNV5ZJq22NkZZWEhE9r1w@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <989852ba-2fb3-7570-ce79-a0db6cc7e99e@gmail.com>
Date:   Mon, 16 Nov 2020 10:24:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNPKfPeiXUUPwz1aU6iKwOXpSZNV5ZJq22NkZZWEhE9r1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16/11/20 1:14 am, Marco Elver wrote:
> On Sun, 15 Nov 2020 at 19:59, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>>
>> Modify fs/ext4/inode-test.c to use the parameterized testing
>> feature of KUnit.
>>
>> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
>> Signed-off-by: Marco Elver <elver@google.com>
>> ---
>> Changes v7->v8:
>> - Replace strcpy() with strncpy() in timestamp_expectation_to_desc()
>> Changes v6->v7:
>> - Introduce timestamp_expectation_to_desc() to convert param to
>>   description.
>> Changes v5->v6:
>> - No change to this patch of the patch series
>> Changes v4->v5:
>> - No change to this patch of the patch series
>> Changes v3->v4:
>> - Modification based on latest implementation of KUnit parameterized testing
>> Changes v2->v3:
>> - Marked hardcoded test data const
>> - Modification based on latest implementation of KUnit parameterized testing
>> Changes v1->v2:
>> - Modification based on latest implementation of KUnit parameterized testing
>>
>>  fs/ext4/inode-test.c | 323 ++++++++++++++++++++++---------------------
>>  1 file changed, 167 insertions(+), 156 deletions(-)
>>
>> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
>> index d62d802c9c12..2c0c00c45c6b 100644
>> --- a/fs/ext4/inode-test.c
>> +++ b/fs/ext4/inode-test.c
>> @@ -80,6 +80,148 @@ struct timestamp_expectation {
>>         bool lower_bound;
>>  };
>>
>> +static const struct timestamp_expectation test_data[] = {
>> +       {
>> +               .test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
>> +               .msb_set = true,
>> +               .lower_bound = true,
>> +               .extra_bits = 0,
>> +               .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
>> +               .msb_set = true,
>> +               .lower_bound = false,
>> +               .extra_bits = 0,
>> +               .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = true,
>> +               .extra_bits = 0,
>> +               .expected = {0LL, 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = false,
>> +               .extra_bits = 0,
>> +               .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
>> +               .msb_set = true,
>> +               .lower_bound = true,
>> +               .extra_bits = 1,
>> +               .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
>> +               .msb_set = true,
>> +               .lower_bound = false,
>> +               .extra_bits = 1,
>> +               .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = true,
>> +               .extra_bits = 1,
>> +               .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = false,
>> +               .extra_bits = 1,
>> +               .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
>> +               .msb_set = true,
>> +               .lower_bound = true,
>> +               .extra_bits =  2,
>> +               .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
>> +               .msb_set = true,
>> +               .lower_bound = false,
>> +               .extra_bits = 2,
>> +               .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = true,
>> +               .extra_bits = 2,
>> +               .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = false,
>> +               .extra_bits = 2,
>> +               .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = false,
>> +               .extra_bits = 6,
>> +               .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = true,
>> +               .extra_bits = 0xFFFFFFFF,
>> +               .expected = {.tv_sec = 0x300000000LL,
>> +                            .tv_nsec = MAX_NANOSECONDS},
>> +       },
>> +
>> +       {
>> +               .test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = true,
>> +               .extra_bits = 3,
>> +               .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
>> +       },
>> +
>> +       {
>> +               .test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
>> +               .msb_set = false,
>> +               .lower_bound = false,
>> +               .extra_bits = 3,
>> +               .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
>> +       }
>> +};
>> +
>> +static void timestamp_expectation_to_desc(const struct timestamp_expectation *t,
>> +                                         char *desc)
>> +{
>> +       int desc_length = strlen(t->test_case_name);
>> +
>> +       strncpy(desc, t->test_case_name, desc_length);
>> +       desc[desc_length] = '\0';
>> +}
> 
> This unfortunately won't prevent out-of-bounds accesses if the
> description is longer than KUNIT_PARAM_DESC_SIZE.
> 
> With strncpy() we want to avoid copying more bytes than the
> destination buffer can hold. This can be done by simply a
> strncpy(desc, t->test_case_name, KUNIT_PARAM_DESC_SIZE). But,
> strncpy() is unsafe in certain cases, too, so the kernel introduced
> strscpy() -- see the note about strncpy() in
> Documentation/process/deprecated.rst. Also have a look at the
> documentation about str{n,l,s}cpy() in lib/string.c.
> 
> So, finally, what we want here is just 1 line:
> 
>     strscpy(desc, t->test_case_name, KUNIT_PARAM_DESC_SIZE);
> 

Okay, I'll look this up and make this change for v9.

> Patch 1/2 looks fine though, so hopefully v9 will be final. :-)
> 
> Thanks,
> -- Marco
> 

Thanks!

