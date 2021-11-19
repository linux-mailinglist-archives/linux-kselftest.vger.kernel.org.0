Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AEE457997
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 00:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhKSXif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 18:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhKSXif (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 18:38:35 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E189C06173E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:35:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bk14so24708971oib.7
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRzO0YvFGAtk5YREG47xrVTYPSFw40hn1uKe/8jJr+k=;
        b=ApZC2sLye9kxqGuPPP3rFlzbGoT4LoJhYKWVJAXC0aFTIRQNWKmpCp/ld3fNP9zQU1
         c/fucWMqyWFKXfXOXrnHk8ML/iSWCIOoDn2OJn9EAHQPdftRyf1EiuM2OKsV7Mzdatm/
         rEWWnx1qUxOgVjteffpcWfHsILng4QueB1tFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRzO0YvFGAtk5YREG47xrVTYPSFw40hn1uKe/8jJr+k=;
        b=bRTok5fKggTwzWXe2vRIYErolNTaaGjXNQrtJJ0oqWZyUbMWybPshYzB8TOcVZ0txe
         S8IxAyQ0kdzEySnEFfAfsWRWoW+XazHtMfvY7x88CB/cdidLDgqizvUACHeCb8+B9rxT
         /i7b5JoogRJRx2prPmBGBz1QcV0HuPpclwDq5RBVjZqOg3ky1frtcz/40CAFTp555Rhp
         OJ52rD1yi/oZ1nMvlDRAUGv9maS+SSxaD4vxhxGgM8+Oa4WEaMWKTilabytXi9M23NMN
         LqnB1GutlsmMgFREmy03bBfoOUvayqBfBecUpGJRsww4dR093aX21g+ih8Wp4KoMMeTu
         jFoQ==
X-Gm-Message-State: AOAM530m/JqCMOKwrRVOFDnQtja0Dv/KxMGdonvaOhKAbh5t2KD+ISSh
        FWUTBcjqfYEkeX/Ylswjm3zigQ==
X-Google-Smtp-Source: ABdhPJw67Npt7XkzT6Hjk/qatZCYLdRp17IOT0NWtd9/vmynrsOX2X4guiM/e1r1V1/iqrkJ5LsODw==
X-Received: by 2002:aca:d05:: with SMTP id 5mr3476846oin.142.1637364931960;
        Fri, 19 Nov 2021 15:35:31 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c9sm271619oog.43.2021.11.19.15.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 15:35:29 -0800 (PST)
Subject: Re: [PATCH v3 1/2] selftests: kselftest.h: mark functions with
 'noreturn'
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, christian@brauner.io,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CADYN=9+_UU9qZX56uahGXxz00iayqJLRAaQrRXh1CMXTvwSbAg@mail.gmail.com>
 <20211118095852.616256-1-anders.roxell@linaro.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <02a096ba-ed6e-4728-c6c1-1b6597ec062f@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 16:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211118095852.616256-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/18/21 2:58 AM, Anders Roxell wrote:
> When building kselftests/capabilities the following warning shows up:
> 
> clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
> test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> test_execve.c:136:9: note: uninitialized use occurs here
>          return have_outer_privilege;
>                 ^~~~~~~~~~~~~~~~~~~~
> test_execve.c:121:9: note: remove the 'if' if its condition is always true
>          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
>          bool have_outer_privilege;
>                                   ^
>                                    = false
> 
> Rework so all the ksft_exit_*() functions have attribue
> '__attribute__((noreturn))' so the compiler knows that there wont be

won't be

> any return from the function. That said, without
> '__attribute__((noreturn))' the compiler warns about the above issue
> since it thinks that it will get back from the ksft_exit_skip()
> function, which it wont.
> Cleaning up the callers that rely on ksft_exit_*() return code, since
> the functions ksft_exit_*() have never returned anything.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

My commit script failed due to checkpatch warns. Run checkpatchp.l --strict
to find the problems and send me v4

thanks,
-- Shuah
