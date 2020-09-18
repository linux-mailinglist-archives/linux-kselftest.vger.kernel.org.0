Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C901426FFEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Sep 2020 16:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIROcR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Sep 2020 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIROcR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Sep 2020 10:32:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE82C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 07:32:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e23so5549700otk.7
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Sep 2020 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sYJpr/JTfAc7wYRPBb4gv+TaUOt5dcnyH7jSr7tuCpM=;
        b=OizUltZ1LFId+L2XPadEiLoGsJia3Vb4yFpDK5KEcNWLrJW6Aem2AEybtF8cy3U+QY
         eoMGUf6mI0+wEijASIk6eboEjhmANetheAdBPBnm6rd+VaguUpkAbTzIdq2VelitR6BK
         syRnG+eDr/eNUK7FH0sWgDhnT/m+Rg3Nl1p4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYJpr/JTfAc7wYRPBb4gv+TaUOt5dcnyH7jSr7tuCpM=;
        b=OdgXj/rB9hVfNBZzZTGtg5V+Ubho06Ntjs7eKlqldaTH3Sy7nrt8xNJ/Z1u+CXfW0q
         r5d/SDxKFoLLrc+rMMgdmq7aX1g4nfLyUmiOQXq25sCyNYFovDZPPfqzT6wAnvceZaln
         Xd0EoDzzD1ZsKF+viBNH67nKnt/x+oWo3KZAzKJh91zXajMfW2Gzud/gTlIdpDfA3TEM
         /7NNR2SAhHchJHuDymtFk65ydy7WIVla+xJQ8gxvOqZqoRiA7r6EEwlAo5K2DYmg/GNc
         tEiVfUMNJq9Ci2jsQ3GbF0Y/f9qTfEPvvU4G1Sg0K1fJtfRLanMn+At+9vbn9LzuXupP
         /nJQ==
X-Gm-Message-State: AOAM532bQeYpeqykkAYs8gqbf9RdhYv7tnf0mPUPgmOaDWeRk2UWuHZ0
        1tR3VMfyw5ZhPq4SDUFqrT9niA==
X-Google-Smtp-Source: ABdhPJwswgZZxJoiRvH2rrmYQ1+FhmfcvUHyo8hVgSClH0jsk2AP5r/jo1ZLkWNCjw6q/XZ7vxlnEg==
X-Received: by 2002:a05:6830:118b:: with SMTP id u11mr23775978otq.261.1600439535424;
        Fri, 18 Sep 2020 07:32:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q14sm2347601ota.41.2020.09.18.07.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 07:32:14 -0700 (PDT)
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200917041519.3284582-1-mpe@ellerman.id.au>
 <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com>
 <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
 <87o8m3oiv6.fsf@mpe.ellerman.id.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b610e625-159d-cdf8-373e-47f0b56412a3@linuxfoundation.org>
Date:   Fri, 18 Sep 2020 08:32:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8m3oiv6.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/17/20 9:37 PM, Michael Ellerman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
>> On 9/16/20 10:53 PM, Max Filippov wrote:
>>> On Wed, Sep 16, 2020 at 9:16 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>>
>>>> The test harness forks() a child to run each test. Both the parent and
>>>> the child print to stdout using libc functions. That can lead to
>>>> duplicated (or more) output if the libc buffers are not flushed before
>>>> forking.
>>>>
>>>> It's generally not seen when running programs directly, because stdout
>>>> will usually be line buffered when it's pointing to a terminal.
>>>>
>>>> This was noticed when running the seccomp_bpf test, eg:
>>>>
>>>>     $ ./seccomp_bpf | tee test.log
>>>>     $ grep -c "TAP version 13" test.log
>>>>     2
>>>>
>>>> But we only expect the TAP header to appear once.
>>>>
>>>> It can be exacerbated using stdbuf to increase the buffer size:
>>>>
>>>>     $ stdbuf -o 1MB ./seccomp_bpf > test.log
>>>>     $ grep -c "TAP version 13" test.log
>>>>     13
>>>>
>>>> The fix is simple, we just flush stdout & stderr before fork. Usually
>>>> stderr is unbuffered, but that can be changed, so flush it as well
>>>> just to be safe.
>>>>
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>>    tools/testing/selftests/kselftest_harness.h | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>
>>> Tested-by: Max Filippov <jcmvbkbc@gmail.com>
>>
>> Thank you both. Applying to linux-kselftest fixes for 5.9-rc7
> 
> It can wait for v5.10 IMHO, but up to you.
> 

Good to know. I will send this for 5.10-rc1 then.

thanks,
-- Shuah

