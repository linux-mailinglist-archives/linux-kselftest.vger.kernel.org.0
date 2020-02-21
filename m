Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB9168156
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2020 16:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBUPT6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Feb 2020 10:19:58 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33020 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgBUPT6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Feb 2020 10:19:58 -0500
Received: by mail-il1-f194.google.com with SMTP id s18so1931509iln.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2020 07:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SX7k/vfQV/dhyQP7ClRzTcNKQX94s9izZKM/kr6C8dY=;
        b=d2szQq4psDdAZ2NrsbGdyppq9zPx9TfbathddBEW7BQkNKcY7+Nvti9PY6H2821yOG
         dCjWcr4TmsHXmCLUbLo8aqbuy9nCnYtsxul9U/skDECmY3z+3uqOQi4BGvIMCrzTWiS6
         mbl0POX5r94ZmNzClM/MaiQ/akzYT1i+qTjNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SX7k/vfQV/dhyQP7ClRzTcNKQX94s9izZKM/kr6C8dY=;
        b=L0+65Uz4SzxzbTCAl14rjtJgIPIXRfZRf3dvLS6eEn70fMs+JBovtmRqE3H5R6TwrN
         B2K4OLUX3GaT0OVfxY4f6rEeiJFbvfFmfBonqKNaAt3CIFUeM1aK8bfrl3xBlJc2PmB3
         5BmLR/usZRoEm0iQYj6ciUkiu4gcHPACJhDkWl5ZE+pwpsS7PEoX9SdoM3JgZtwr5wCF
         hvurbSj4xyW+rcOWz+QaGLVjUxjsFm/fKGEOZPCawnw514jzwBmcW2sbNmxGwaKoE7Ei
         ieJVEbh9oHsYt7cAoCL0aDK14gZQqMugADhdPR0sb9fbU5L2jy9PjKGFm+hQoXUDfIxS
         twaw==
X-Gm-Message-State: APjAAAUTky7f6tP4bgSmSIpJsHez1ZzJwOxcLPqXha+BUoNqCiNLKVMb
        Q6s5br+ixPZI8X2wc0LEnoIpkg==
X-Google-Smtp-Source: APXvYqx/6YGxRHrzHVGYrP6xZGdO28R/mr4KeY/jym1F67fUOQ88DE/jgI3Pg0Z9rtXPhWyPBCPAgA==
X-Received: by 2002:a92:8307:: with SMTP id f7mr38094818ild.73.1582298397884;
        Fri, 21 Feb 2020 07:19:57 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r10sm771889iot.28.2020.02.21.07.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 07:19:57 -0800 (PST)
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200220044241.2878-1-mpe@ellerman.id.au>
 <202002201450.A4BB99421@keescook>
 <fccfcd8b-628b-9b3d-13b1-6dcda49b4df9@linuxfoundation.org>
 <87o8tsed6s.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cc3be4bc-52a2-a6a1-2a66-66706f62cd32@linuxfoundation.org>
Date:   Fri, 21 Feb 2020 08:19:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87o8tsed6s.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/20/20 10:12 PM, Michael Ellerman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
>> On 2/20/20 3:51 PM, Kees Cook wrote:
>>> On Thu, Feb 20, 2020 at 03:42:41PM +1100, Michael Ellerman wrote:
>>>> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>>>> timeout per test") added a 45 second timeout for tests, and also added
>>>> a way for tests to customise the timeout via a settings file.
>>>>
>>>> For example the ftrace tests take multiple minutes to run, so they
>>>> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
>>>> timeout setting").
>>>>
>>>> This works when the tests are run from the source tree. However if the
>>>> tests are installed with "make -C tools/testing/selftests install",
>>>> the settings files are not copied into the install directory. When the
>>>> tests are then run from the install directory the longer timeouts are
>>>> not applied and the tests timeout incorrectly.
>>>
>>> Eek, yes, nice catch.
>>>
>>>> So add the settings files to TEST_FILES of the appropriate Makefiles
>>>> to cause the settings files to be installed using the existing install
>>>> logic.
>>>
>>> Instead, shouldn't lib.mk "notice" the settings file and automatically
>>> include it in TEST_FILES instead of having to do this in each separate
>>> Makefile?
>>>
>>
>> Let's keep it custom per test for now.
> 
> Yeah that seems less magical.
> 
> FWIW the patch below does work, so it's a small patch, but I'm not sure
> it's worth the added complexity vs just listing the file in the few
> tests that need it.

I am not seeing a whole lot of benefit in doing this in lib.mk
Test authors have to think about which files to include in
TEST_FILES and add it to Makefile anyway.

My second reason is I would like authors to think about the settings
as opposed to just duplicate from another test. This timeout changes
the kselftest run-time and behavior.

I am also finding making features generic has downsides to it unless
we are smart about it. We have several overrides already for things
that made perfect sense to make generic.

> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 1c8a1963d03f..82086c6ad5e7 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -20,6 +20,10 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>   TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>   TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>   
> +ifeq ($(wildcard settings),settings)
> +       TEST_FILES += settings
> +endif
> +
>   ifdef KSFT_KHDR_INSTALL
>   top_srcdir ?= ../../../..
>   include $(top_srcdir)/scripts/subarch.include
> 

Thanks for the patch though. We can consider adding it a later time, if
we see value in making this generic.

thanks,
-- Shuah
