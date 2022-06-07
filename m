Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFC542732
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jun 2022 08:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359379AbiFHBD4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jun 2022 21:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579393AbiFGXkA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jun 2022 19:40:00 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E923282A
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jun 2022 14:41:49 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h72so10386678iof.11
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jun 2022 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zei+rMtXofDNspSEQfHDdxvw6FwTTwwAkNk8PaYH+Vk=;
        b=gM1q3haoZ8xcG2m/1cV4QlglIObFRuaOTqfk3ZWzwKu4lYch/pviT5/sn6YWsi2Ful
         MUyuJNgKwzjHOT4WiD66Cg7h8YfDvPP7TQ5z4caqZ0/iE2nrwwvmyzkjl1ra6qYZwVji
         +jHM75UnnwV5WsODAILvthjF49P4Hna02u2ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zei+rMtXofDNspSEQfHDdxvw6FwTTwwAkNk8PaYH+Vk=;
        b=wZOu+b70ATBiJq6irZz0S2mhUgUqmd26tsbdShrJbIRnvgjjePY4sLBx+FP5hGaW6m
         s9igU5svpXkrVJXwZDlaO43Se+2uVS0ZYw0BaxUq0MdWirQ4PPgtLQmI9e9JktglgyRk
         BscOKqnYNIhKvtwbpvdGFyLLyMcs8uIazK+gGEGUOAhvgRn3EUS4bbOrM3xAIZP7NRFI
         BQ3BiRBKfu7oO3nXU9rIagY8FuyGeiKxljYcZS+5p7xbQ5eCx2RPz5Ssn1DV5tA17Dvy
         k9vTI+y/1M+T1Shve0OhIOVhNdcRQZf+6CIm5Sx79PrAHl+GwucSb6zmL0HIDgCMZA7c
         AlIQ==
X-Gm-Message-State: AOAM531LyZRgoYSwDh/ANIYngrLVhZ2UdxIXr+x3EGKyqXFUA7sPiH7r
        Nz/ET92S16Jdkn5yb4jAuNXiFg==
X-Google-Smtp-Source: ABdhPJx71niVTJbfk9wp/5WJhlD+JuQVs7tZ8hmuK9HPnLiZYXzVppCBWspGOgJX6/6yZCG6NS2ztA==
X-Received: by 2002:a05:6638:2105:b0:331:9c7:4e8b with SMTP id n5-20020a056638210500b0033109c74e8bmr17555779jaj.129.1654638108936;
        Tue, 07 Jun 2022 14:41:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g11-20020a02b70b000000b0033136906e1esm7153212jam.18.2022.06.07.14.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 14:41:48 -0700 (PDT)
Subject: Re: [PATCH v2] docs/kselftest: add more guidelines for adding new
 tests
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@collabora.com, bagasdotme@gmail.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220521073651.4191910-1-usama.anjum@collabora.com>
 <e01f90a0-a3c7-c5fd-ae1f-197c6fec525e@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <63fc263d-c06a-2974-298c-5da80322411a@linuxfoundation.org>
Date:   Tue, 7 Jun 2022 15:41:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e01f90a0-a3c7-c5fd-ae1f-197c6fec525e@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/7/22 6:59 AM, Muhammad Usama Anjum wrote:
> Reminder!
> 

Remember to avoid top posting.

> On 5/21/22 12:36 PM, Muhammad Usama Anjum wrote:
>> Improve and add instructions to add new tests. Add build commands to
>> test before sending the new test patch.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v2:
>> - Updated commit message
>> - Removed dependence of this patch from other patch
>> - Updated instructions
>> ---
>>   Documentation/dev-tools/kselftest.rst | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>> index a833ecf12fbc1..ee6467ca8293f 100644
>> --- a/Documentation/dev-tools/kselftest.rst
>> +++ b/Documentation/dev-tools/kselftest.rst
>> @@ -208,6 +208,14 @@ In general, the rules for selftests are
>>   Contributing new tests (details)
>>   ================================
>>   
>> + * In your Makefile, use facilities from lib.mk by including it instead of
>> +   reinventing the wheel. Specify flags and binaries generation flags on
>> +   need basis before including lib.mk. ::
>> +
>> +    CFLAGS = $(KHDR_INCLUDES)
>> +    TEST_GEN_PROGS := close_range_test
>> +    include ../lib.mk
>> +
>>    * Use TEST_GEN_XXX if such binaries or files are generated during
>>      compiling.
>>   
>> @@ -230,13 +238,30 @@ Contributing new tests (details)
>>    * First use the headers inside the kernel source and/or git repo, and then the
>>      system headers.  Headers for the kernel release as opposed to headers
>>      installed by the distro on the system should be the primary focus to be able
>> -   to find regressions.
>> +   to find regressions. Use KHDR_INCLUDES in Makefile to include headers from
>> +   the kernel source.
>>   
>>    * If a test needs specific kernel config options enabled, add a config file in
>>      the test directory to enable them.
>>   
>>      e.g: tools/testing/selftests/android/config
>>   
>> + * Create a .gitignore file inside test directory and add all generated objects
>> +   in it.
>> +
>> + * Add new test name in TARGETS in selftests/Makefile::
>> +
>> +    TARGETS += android
>> +
>> + * All changes should pass::
>> +
>> +    kselftest-{all,install,clean,gen_tar}
>> +    kselftest-{all,install,clean,gen_tar} O=abo_path
>> +    kselftest-{all,install,clean,gen_tar} O=rel_path
>> +    make -C tools/testing/selftests {all,install,clean,gen_tar}
>> +    make -C tools/testing/selftests {all,install,clean,gen_tar} O=abs_path
>> +    make -C tools/testing/selftests {all,install,clean,gen_tar} O=rel_path
>> +
>>   Test Module
>>   ===========
>>   
> 

The change looks good to me. I am catching up on patch backlog after the
merge window and vacation. I can take this through kselftest or if it
goes through doc tree - here is my

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
