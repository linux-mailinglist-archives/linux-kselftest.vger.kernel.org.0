Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7585826B066
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 00:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgIOWJd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgIOUSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 16:18:45 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C1AC061788
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Sep 2020 13:18:43 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id g26so1093614ooa.9
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Sep 2020 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Pxy8XuN4H9/39l6P169WyiunvVoa6/MHSiTUzpc2H0=;
        b=StKfSTomujrlgFk7a+XxdsRkBonWZLkkibhHZMq5mmkqzeaXSUoJHCzAwYq+CzHJNp
         UvGlWzUtFUw2x1sb+ZEOxNkUAvZKfMpTdP96SHWdVVg3EBAJA7VV9xG8wkTTJim5TZi3
         Q/NOlPnYgwcNUJUy3Z0G+9jbsSx+wRYV6/aAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Pxy8XuN4H9/39l6P169WyiunvVoa6/MHSiTUzpc2H0=;
        b=scIls9kGK/wnKIJJivpUlEyY1m+pVXhYAViKW7nGeONn6Y2lajFKObwW8mtjnF/Yyx
         V/Mi9WVq4pOXOABgcBDdeqRQ08WTksErTXCA+aKthj5jRWb/Edju2rhiaBou+kBeh8RC
         df4FGjCo2xc5F0SQfncXNmRyOMpseZCYTTMmcfA2jFAic6ac9ShKxrRSKHTIAarm4sS7
         n7LhmLBPMr9901JC0+3UYWYbYGOxvdjA7cAkTzYs2sb0JQvcqd5GGYEez8jE0/wlVqxx
         vwKqPKu8vOGn5Q3goB5rmwDaY0CuF+1wG1xX2Sn9eN0urTqqCrWPq30qzWeI6dADo7ul
         Hi4w==
X-Gm-Message-State: AOAM531gn8ts5C+rXQG8jxhzg9r8YWwuKyri8X1TgRo8lm77S16M1kIo
        CBtO6vUMAV7hUjNwxAm53t/u/A==
X-Google-Smtp-Source: ABdhPJzryCOcoMZBw1SZnsYqoffKa4MsGINM/LYQGkRr4W88hKIyCvYanE+t8tLIvSwSXkBG6dFSNA==
X-Received: by 2002:a4a:81:: with SMTP id 123mr15461886ooh.80.1600201122088;
        Tue, 15 Sep 2020 13:18:42 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u9sm6595084otq.54.2020.09.15.13.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 13:18:41 -0700 (PDT)
Subject: Re: [REGRESSION] kselftest: next-20200915
To:     Justin Cook <justin.cook@linaro.org>, LKFT <lkft@linaro.org>
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au, shuah@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <0100017492de8180-c524cff4-bd4e-4777-9f33-7e1da2c986d2-000000@email.amazonses.com>
 <CANKHsTfyE64ygNB0H0Nx=P63D-kqYa6aGOXS6ZmNUspLJJtS=Q@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f9144c49-d39a-af67-2a5a-3828b86ea86c@linuxfoundation.org>
Date:   Tue, 15 Sep 2020 14:18:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANKHsTfyE64ygNB0H0Nx=P63D-kqYa6aGOXS6ZmNUspLJJtS=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/15/20 11:52 AM, Justin Cook wrote:
> Hello,
> 
> Linaro had previously been sending out a report based on our testing of 
> the linux kernel using kselftest. We paused sending that report to fix a 
> few issues. We are now continuing the process, starting with this report.
> 
> If you have any questions, comments, feedback, or concerns please email 
> lkft@linaro.org <mailto:lkft@linaro.org>.
> 
> Thanks,
> 
> Justin
> 

Hi Justin,

Thanks for the report. It would be nice to see the reports. However, it
is hard for me to determine which tests failed and why.

> On Tue, 15 Sep 2020 at 12:44, LKFT <lkft@linaro.org 
> <mailto:lkft@linaro.org>> wrote:
> 
>     ## Kernel
>     * kernel: 5.9.0-rc5
>     * git repo:
>     ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git',
>     'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
>     * git branch: master
>     * git commit: 6b02addb1d1748d21dd1261e46029b264be4e5a0
>     * git describe: next-20200915
>     * Test details:
>     https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200915
> 
>     ## Regressions (compared to build next-20200914)
> 
>     juno-r2:
>        kselftest:
>          * memfd_memfd_test
> 
>     x86:
>        kselftest-vsyscall-mode-native:
>          * kvm_vmx_preemption_timer_test

I looked for the above two failures to start with since these
are regressions and couldn't find them.

Are the regressions tied to new commits in linux-next from the
mm and kvm trees?

thanks,
-- Shuah

