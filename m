Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D3326E12E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Sep 2020 18:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgIQQw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 12:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgIQQvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 12:51:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B2C06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 09:51:34 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n61so2521127ota.10
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o4EtNq7DyeGyaCTcfrcZu/YzRJzariS8Y96E7qW0PrI=;
        b=Y+GQfQ39bnkj6VnXa/M03RqeBAiDwLC7zseIDxVADyRcOAHj8N4cLAejLQUP8HSeH1
         uo6DqNZgmCRIulGOZwczZruqMPJCQgekDLtD9VsZwrrcTos+rwUcqsFBwSqWklr5HaZ2
         KZ5JL+Qb9VLaySf/HwISQUZ0EpezySg8GW1Zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o4EtNq7DyeGyaCTcfrcZu/YzRJzariS8Y96E7qW0PrI=;
        b=FXkUBp2cSRayQoSZ4ol1KhR6h2YAo4jHeBgc3RLYP18coLfK8+e1ReFUxH6mOtXXzc
         VLva9bT598n0aNZcLk480fIt+IJ0HyT69gbmn2PxFbApTpEeePB6uzbvPB4AJmw/S9kY
         XD+RFejPjkg1q3yFzXppos9rszMrCBSQN89ocKBtkC/ivPBgf8Rrq0Horvby9nL+ncVe
         NZvDWoiKn4KWVELeFV7qoKFwv81MYGLvWSCY/UnHW8QpKL9w8E75ZPp4BDmO6YBHxI7T
         jGlSl2Oxj7AYqy/ykuUuhPYnk7FXAcAA+1Plco9wlAfeBXodMh6pPZ6UUqSOGFwe7RMN
         wE8Q==
X-Gm-Message-State: AOAM533vfM6CgywV82xHctrDcGnUCgORhSHUkjNiYZTmCcT37gzgZUJ8
        cnT0o1agKmrQHkUNTGCGniUA6g==
X-Google-Smtp-Source: ABdhPJwnUUENSuTgrXD2q07P3VS761z7dRJIFzoT9pAk7/FoabmgyszKCLUmCPxq8cLBTh+aRAiNXg==
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr21358539oti.144.1600361493923;
        Thu, 17 Sep 2020 09:51:33 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c12sm204335otm.61.2020.09.17.09.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 09:51:33 -0700 (PDT)
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
To:     Kees Cook <keescook@chromium.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200917041519.3284582-1-mpe@ellerman.id.au>
 <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com>
 <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <99f67c84-4dcd-278a-e7b8-e19054818ecf@linuxfoundation.org>
Date:   Thu, 17 Sep 2020 10:51:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/17/20 6:58 AM, Shuah Khan wrote:
> On 9/16/20 10:53 PM, Max Filippov wrote:
>> On Wed, Sep 16, 2020 at 9:16 PM Michael Ellerman <mpe@ellerman.id.au> 
>> wrote:
>>>
>>> The test harness forks() a child to run each test. Both the parent and
>>> the child print to stdout using libc functions. That can lead to
>>> duplicated (or more) output if the libc buffers are not flushed before
>>> forking.
>>>
>>> It's generally not seen when running programs directly, because stdout
>>> will usually be line buffered when it's pointing to a terminal.
>>>
>>> This was noticed when running the seccomp_bpf test, eg:
>>>
>>>    $ ./seccomp_bpf | tee test.log
>>>    $ grep -c "TAP version 13" test.log
>>>    2
>>>
>>> But we only expect the TAP header to appear once.
>>>
>>> It can be exacerbated using stdbuf to increase the buffer size:
>>>
>>>    $ stdbuf -o 1MB ./seccomp_bpf > test.log
>>>    $ grep -c "TAP version 13" test.log
>>>    13
>>>
>>> The fix is simple, we just flush stdout & stderr before fork. Usually
>>> stderr is unbuffered, but that can be changed, so flush it as well
>>> just to be safe.
>>>
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>   tools/testing/selftests/kselftest_harness.h | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>
>> Tested-by: Max Filippov <jcmvbkbc@gmail.com>
>>
> 
> Thank you both. Applying to linux-kselftest fixes for 5.9-rc7
> 

Kees,

I haven't pulled this in yet. If you want to take this through seccomp
tree for dependencies:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

