Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98B94401C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhJ2SV6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2SV5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 14:21:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB7CC061570
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:19:28 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j28so5143199ila.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PKl/teME9E7ldDK1IbEidgw7hYOus61rL2borMcVRE0=;
        b=R/PBEucrRJH7/D2UWFg+7WvnzBfb/8gyzY6ZHAVd2FUL/ZueEynhhJ+B1vlmOTpVUl
         ysWPx/Sk8tJsQtejIBdE94dp77v1qVp7bw3GjT4n6Ts2JHH2wl4Ah7bNVnBephwzwjjS
         a5M0UUcRoWafnHr7fMmbukdNzje+AK2lP7tpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PKl/teME9E7ldDK1IbEidgw7hYOus61rL2borMcVRE0=;
        b=MC0xDs7Uhn96CFqMhIaPO1IDyiNqhgKQJ52cWasu8geAqDx16Q9vTOp8O75TrX2iRU
         onxKFh3yd4kxJLCDcomo3myC74t1PWmG8tRpa+19CTumzoY9+f+CC+UQhEB5UaLDeI2w
         cQlv7Fr4tEsR8bW7dit7pbf4qJwLpRYlb4/xw0fwYDvSxEOr4vDrpMQg2rvTCdhx8CfJ
         ZbYXqw7IJIz7WlzNdeh+rZ54ceVIJOyTrtNTF5nDSZpVlo4xonKww/eu/yZPo0sDsODp
         JC9ClDP1wO6lTl7VFCVue3ZfwEBPIr/oG5wr5zwwgt6R6U/XIw/NeQ5fVeh8pbLPkghu
         fxLw==
X-Gm-Message-State: AOAM5307ZAb3xH48VJo8Vh2dRUiJsVzM4e1KT7/WLf0s9VS1bRZ/Tz7y
        V9xZE6ewRzmlpxBxQ1KuTH91pSAvz5jtSg==
X-Google-Smtp-Source: ABdhPJxeqa5BfULHc0fSZ0/jdCvx2zQe/fLQ0wiFfsYyjhKZ0IeXpZcwvg2jh56WnLlBJsQlhFcqgw==
X-Received: by 2002:a92:c04c:: with SMTP id o12mr8407189ilf.206.1635531567577;
        Fri, 29 Oct 2021 11:19:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e8sm3732277ilu.17.2021.10.29.11.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:19:27 -0700 (PDT)
Subject: Re: [PATCH] selftests: kselftest.h: mark functions with 'noreturn'
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20211029114312.1921603-1-anders.roxell@linaro.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <834d18b6-4106-045f-0264-20e54edf47bc@linuxfoundation.org>
Date:   Fri, 29 Oct 2021 12:19:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211029114312.1921603-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/29/21 5:43 AM, Anders Roxell wrote:
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
> any return from the function. That said, without
> '__attribute__((noreturn))' the compiler warns about the above issue
> since it thinks that it will get back from the ksft_exit_skip()
> function, which it wont.
> Cleaning up the callers that rely on ksft_exit_*() return code, since
> the functions ksft_exit_*() have never returned anything.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Lot of changes to fix this warning. Is this necessary? I would
like to explore if there is an easier and localized change that
can fix the problem.

thanks,
-- Shuah
