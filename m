Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6553F4579F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 01:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhKTAKb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 19:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbhKTAKa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 19:10:30 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3503C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 16:07:25 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id n66so24781349oia.9
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 16:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RvyWEdLax12+25Tnfs7BcEBxdL4WVjlZUdT7aE0GddA=;
        b=LBu+jgvmJe89ZGCaOz+Q+2if7rlFVtigKC9FTLl4QZKpQqcyhlMJFWf/8ugKsgE5xa
         81FpIba0C6Nm6mfJ9bcaS2PD9J/8KpWWkoK4svY0xnqGnwdxF/3x2KsDOPiyVO3dNlS8
         V6myj9JMwUkgJzJeP5GQkEwhcoFDG2uzAwV/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RvyWEdLax12+25Tnfs7BcEBxdL4WVjlZUdT7aE0GddA=;
        b=KGiCHsa55hYMj8NatOQuaJTx9I9f+PgucPu6tlpogSzc3wWYq/i8iwzmU7Txj6QR+E
         ToRtuSpTj5ul+ASdUB0NuUKzoKhuU5+sl8LNhb9bm7x3w1Nd+IRhpqm+qd02qB6XP2rU
         VxN/3fRTIJadFhaNYUAdtYKaGImspqLWg7+WC+08+ZqMXmCm3IykU3FMVWIzsZ8ej/Cw
         8bblUNsJYg+MCuojoNa1hNOcOSfzXJ5NPjszK/E0uqYVkyWaGrTIwT8IkFJVHA6FyJQt
         ZPcfH2wUvEix+f8zX5d7oexeoYcHWXrf1M0ZrxKtQ5AqMqDQVME/R2UiN8Id0VJHIbHS
         0Xlw==
X-Gm-Message-State: AOAM533cIlfexECvApkOMfI2LFgjc374XKr/yPqTK1QdfBqirXMAopuF
        918VK2Bymp35fdm7DlEMpwfnRg==
X-Google-Smtp-Source: ABdhPJztKGeV04+obdTEcOPE5iO5kUrpDipowiee/rOrvNzRzKar6xWuiwFlO6Ui4vqOtBg1e2YhSA==
X-Received: by 2002:a05:6808:259:: with SMTP id m25mr3870444oie.40.1637366845298;
        Fri, 19 Nov 2021 16:07:25 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o6sm251911oou.41.2021.11.19.16.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 16:07:24 -0800 (PST)
Subject: Re: [PATCH] selftests: timers: use 'llabs()' over 'abs()'
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, tglx@linutronix.de, john.stultz@linaro.org,
        nathan@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211105163403.3330950-1-anders.roxell@linaro.org>
 <CAKwvOdn0vEyj-EPJG0e39v-Vq+oLFptV0oXYfzfzuy=HPzSzOA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <59bd0880-475e-eb3b-6d2a-25589d5e3a8b@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 17:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn0vEyj-EPJG0e39v-Vq+oLFptV0oXYfzfzuy=HPzSzOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/21 2:44 PM, Nick Desaulniers wrote:
> On Fri, Nov 5, 2021 at 9:34 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>>
>> When building selftests/timers with clang, the compiler warn about the
>> function abs() see below:
>>
>> posix_timers.c:69:6: warning: absolute value function 'abs' given an argument of type 'long long' but has parameter of type 'int' which may cause truncation of value [-Wabsolute-value]
>>          if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
>>              ^
>> posix_timers.c:69:6: note: use function 'llabs' instead
>>          if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
>>              ^~~
>>              llabs
>>
>> The note indicates what to do, Rework to use the function 'llabs()'.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I wonder why tools/testing/selftests/timers/adjtick.c redefines llabs
> when it already includes stdlib.h, and how that doesn't result in some
> kind of compiler diagnostic.
> 

Hmm. The define in /usr/include/stdlib.h is under #ifdef __USE_ISOC99
Maybe be that explains the reason for the definitions in the other two
timers file?

Anders, I would like to understand this before I take this patch. I see
you sent several patches to other tests as well. Would be useful at
least understand why these defines exist.

thanks,
-- Shuah


