Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83AD166A97
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 23:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgBTWy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 17:54:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36772 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgBTWy4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 17:54:56 -0500
Received: by mail-io1-f65.google.com with SMTP id d15so305452iog.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2020 14:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8d8NX9dRtfode/mGrNHy098ugTs2zC3Sx5s6Tu/GUkM=;
        b=hNpGYAbWFp3sVXdY4hkAwcoE/2KV6xNSDcTOyu5XbQ7GsjVzgSJHeG7DrnHLw473fn
         M256n+WkFGqHpTdIhWUyKPYgFszh+2hfSTCn3hN7m4iJrViarzV7f1to2bN0DS5JVj/s
         jFX/8SiFWnKmBLn6iwjtDXsOom4oNDnOZpR1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8d8NX9dRtfode/mGrNHy098ugTs2zC3Sx5s6Tu/GUkM=;
        b=e11zxax7WriQ9aYn69jDYOFPRfHmX1iuHDTn8p9loAn8Vc+V4wj7ujTCMoJjbMr77c
         txL4Hr4hyccpHweyla0PhhYFUsLbHR8GWCAaYATvtR+sMQG2hwsVq9jIgSiVDwTI8DD8
         SGZJwZHbP/rbA4FRAz4/3tW+n4qJgcuObHyJaoBbmEBktUN3M4GIAinIyTNIYxIEyd8V
         Eg1EQy/LpNWkDVvFU/uLBAPqt2EN8te2yIazRnxZApMNJTv9qPluX8fpVeRSfSlDBJFR
         5X8ucJ+MXxlEwzhLJJme+jdkRlOB2LuhaRJNp7T9glBMwwdMmm8o19eXBfFJwt4avyI+
         uuHQ==
X-Gm-Message-State: APjAAAWEXS1TJ4lqaYA7c11klkr34y55a/fz4TrfJ+KMVWL8LLmfrA3b
        pJN4hfBnslzZAY0PKVauDs6YMw==
X-Google-Smtp-Source: APXvYqx3Ebt1RtL10Rom31Fq0WYwR61RFsYQmy4rzWq6ozpl1ChMGoNQJGNALu20q/hmu4lEobIjQQ==
X-Received: by 2002:a02:cd12:: with SMTP id g18mr27785187jaq.76.1582239296119;
        Thu, 20 Feb 2020 14:54:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j26sm194064ioj.69.2020.02.20.14.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:54:55 -0800 (PST)
Subject: Re: [PATCH] selftests: Install settings files to fix TIMEOUT failures
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200220044241.2878-1-mpe@ellerman.id.au>
 <202002201450.A4BB99421@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fccfcd8b-628b-9b3d-13b1-6dcda49b4df9@linuxfoundation.org>
Date:   Thu, 20 Feb 2020 15:54:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002201450.A4BB99421@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/20/20 3:51 PM, Kees Cook wrote:
> On Thu, Feb 20, 2020 at 03:42:41PM +1100, Michael Ellerman wrote:
>> Commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
>> timeout per test") added a 45 second timeout for tests, and also added
>> a way for tests to customise the timeout via a settings file.
>>
>> For example the ftrace tests take multiple minutes to run, so they
>> were given longer in commit b43e78f65b1d ("tracing/selftests: Turn off
>> timeout setting").
>>
>> This works when the tests are run from the source tree. However if the
>> tests are installed with "make -C tools/testing/selftests install",
>> the settings files are not copied into the install directory. When the
>> tests are then run from the install directory the longer timeouts are
>> not applied and the tests timeout incorrectly.
> 
> Eek, yes, nice catch.
> 
>> So add the settings files to TEST_FILES of the appropriate Makefiles
>> to cause the settings files to be installed using the existing install
>> logic.
> 
> Instead, shouldn't lib.mk "notice" the settings file and automatically
> include it in TEST_FILES instead of having to do this in each separate
> Makefile?
> 

Let's keep it custom per test for now.

thanks,
-- Shuah

