Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA93626DC3F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Sep 2020 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgIQM66 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 08:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgIQM61 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 08:58:27 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFADC061788
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 05:58:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 185so2320581oie.11
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Sep 2020 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v+fNl0lP+nDgkIqWYqUCp9ojQxRjrA9fuGvhmoD3cl4=;
        b=Xx9BA4CJAQ+/KNh9Oytu6Cp3JJRd7dZPKb0a9lbgdBNsP4TrCuCoM2hv/MeNZDJOt2
         MIgdbjC+wvFlCsmnuqIU88Zn/DGSfwCm49nVbgVhm4JGYS3rQqQQ8VztYVsEiBaiVSYt
         P3rMGajvrLFM8xPLxVdoUq+XX/LyQQsFsonFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v+fNl0lP+nDgkIqWYqUCp9ojQxRjrA9fuGvhmoD3cl4=;
        b=Gne3pel7igPoXmfvul73ybaeR876QHxqPLdBOmeiD7LxEP+vHUKmQGSzEHLg7Jgcd1
         bVMyLksfZeuzzfBZTPrt9XcSmiAE0QyFt0OmEYGGBD1b+rbI4rUSRkltlS+/jtG2g0qp
         ++FnwcT+LjI9tz9F2M5pl3LY2wvIFJMQung/vtz0o8t7iMcJ4wzQV+1qUaPX+OG8Vfgb
         SRtlUZizQYxsokeVzw8tj1cR4v/qLMyvTK8su/dOigek9vl1nKCZGTTbzoH0wGpdiBwG
         NlVNzPe8L/p5XipdtiF77ZP/CoFHpudfRc/GQVFEZPbZrryUZPBySz29fMXFoNsuHt9G
         KMGg==
X-Gm-Message-State: AOAM531JfSYtm83Ls/zjEkkirTUVGFEWMVvLy72iBc3jxJ3Bi+68euh4
        +cFmpUzAA7LR2vNZktjQad5oKQ==
X-Google-Smtp-Source: ABdhPJxJ+hJC5NgrepAXypYOwEjQMM4lNMMM27TkWxWgD7WozscsKqRmtHl4Tv93I1l3RzjjxNAuQw==
X-Received: by 2002:aca:a88e:: with SMTP id r136mr5904429oie.13.1600347506033;
        Thu, 17 Sep 2020 05:58:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h14sm10380230otr.21.2020.09.17.05.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:58:25 -0700 (PDT)
Subject: Re: [PATCH] selftests/harness: Flush stdout before forking
To:     Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200917041519.3284582-1-mpe@ellerman.id.au>
 <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e24df908-c50d-59ef-563c-9db24c819248@linuxfoundation.org>
Date:   Thu, 17 Sep 2020 06:58:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJ5j4nG0z1Bk00J=3xPM++J68Hp2idJ-D5aHT84-vOzsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/16/20 10:53 PM, Max Filippov wrote:
> On Wed, Sep 16, 2020 at 9:16 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> The test harness forks() a child to run each test. Both the parent and
>> the child print to stdout using libc functions. That can lead to
>> duplicated (or more) output if the libc buffers are not flushed before
>> forking.
>>
>> It's generally not seen when running programs directly, because stdout
>> will usually be line buffered when it's pointing to a terminal.
>>
>> This was noticed when running the seccomp_bpf test, eg:
>>
>>    $ ./seccomp_bpf | tee test.log
>>    $ grep -c "TAP version 13" test.log
>>    2
>>
>> But we only expect the TAP header to appear once.
>>
>> It can be exacerbated using stdbuf to increase the buffer size:
>>
>>    $ stdbuf -o 1MB ./seccomp_bpf > test.log
>>    $ grep -c "TAP version 13" test.log
>>    13
>>
>> The fix is simple, we just flush stdout & stderr before fork. Usually
>> stderr is unbuffered, but that can be changed, so flush it as well
>> just to be safe.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   tools/testing/selftests/kselftest_harness.h | 5 +++++
>>   1 file changed, 5 insertions(+)
> 
> Tested-by: Max Filippov <jcmvbkbc@gmail.com>
> 

Thank you both. Applying to linux-kselftest fixes for 5.9-rc7

thanks,
-- Shuah
