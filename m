Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A301C3144EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 01:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBIA3j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 19:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBIA3h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 19:29:37 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC466C061786
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 16:28:56 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id u66so15723036oig.9
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 16:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZpMbEDX3+DzRlVVsV7q+65bfuQjGm+Uwg6bFaOfF8IM=;
        b=etZOwpeJxWk51MIwE2B4IMeVrs+MsZeHY5jAI4HQlu7373oSdoyKb13gVSVCqovfAB
         Kw5tw6ZuK3CoGT2HEAqJ3ygDTZHZXCTpr1LP0rvhJ0ol0HMM4OXQRuJVGa35uAjq7Bvm
         Tlbv59YTJCeBP6KDz4xYbx1/XaNnqr3l6mgo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZpMbEDX3+DzRlVVsV7q+65bfuQjGm+Uwg6bFaOfF8IM=;
        b=hN06tZl2sa0/1pPPqOj3j1gFDIGbG0hnIlRemiwyYi7NySYmdGtli8sSv5M1gzHiXo
         SzTpz33rCfk6ugNESsWW7UR+OlCPVRdiMkXjeL7C4n9LSVm7pM9eUYzukO5ayh2lTHsb
         0w69fKr6bnqlT8DktXPY6W2mDLyrj3VqcHgH9GcaQ3K1oQnXQJnlFE7DNPfgK0xqWkEe
         tzRACOHOvjoIFINQvmU9043PBefAvDxNvYkRtphscE9z733V0rDbAb5GusEaDRY+aXfl
         Rhf/tg5Y5cnVLjyLI1ku7EzqaEAkF0W6lVGDElKhKeEC1+C+OUzpf3vrRfJzYI3M1wGe
         vdhQ==
X-Gm-Message-State: AOAM53296CLnlxRm7uUuIEf63SW9ogbeGQo2sZWRiJkbdAbLIfCmd+9r
        Hzlk+5cgEIMoipZik9JQ72EVhg==
X-Google-Smtp-Source: ABdhPJwmT5sFyNRH2pEErPqkjHMdmej0BLafqZFSa6BtIg9dbYNq88U+bg5AHIDKU0nI09CBZ6R66Q==
X-Received: by 2002:a54:460d:: with SMTP id p13mr859370oip.57.1612830536187;
        Mon, 08 Feb 2021 16:28:56 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v6sm540172otk.2.2021.02.08.16.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:28:55 -0800 (PST)
Subject: Re: [PATCH] Correct leftover directories from make kselftest
To:     Erik Hollensbe <erik@hollensbe.org>,
        linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210128033743.77040-1-erik@hollensbe.org>
 <20210128033743.77040-2-erik@hollensbe.org>
 <aadb7d9c-6042-0b4e-9d2a-764432ccf0ef@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <07633e70-16c2-2a24-9160-ce8b3536198f@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:28:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <aadb7d9c-6042-0b4e-9d2a-764432ccf0ef@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/8/21 5:17 PM, Shuah Khan wrote:
> On 1/27/21 8:37 PM, Erik Hollensbe wrote:
>> Here are some directories that are created/filled as a part of the make
>> kselftest process, but not ignored.
>>
>> Signed-off-by: Erik Hollensbe <erik@hollensbe.org>
>> ---
>>   tools/testing/selftests/gpio/.gitignore   | 1 +
>>   tools/testing/selftests/timens/.gitignore | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/gpio/.gitignore 
>> b/tools/testing/selftests/gpio/.gitignore
>> index 4c69408f3e84..640b5cb4ed4e 100644
>> --- a/tools/testing/selftests/gpio/.gitignore
>> +++ b/tools/testing/selftests/gpio/.gitignore
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   gpio-mockup-chardev
>> +tools-gpio
>> diff --git a/tools/testing/selftests/timens/.gitignore 
>> b/tools/testing/selftests/timens/.gitignore
>> index 2e43851b47c1..95e97d7bc336 100644
>> --- a/tools/testing/selftests/timens/.gitignore
>> +++ b/tools/testing/selftests/timens/.gitignore
>> @@ -7,3 +7,4 @@ procfs
>>   timens
>>   timer
>>   timerfd
>> +futex
>>
> 
> Thank you for the patch.
> 
> Can you split these into two patches? make separate patches for gpio
> and timens.
> 

Please send me just the gpio patch. I already applied this patch that
fixes timens .gitignore.

https://patchwork.kernel.org/project/linux-kselftest/patch/20201218165651.4538-1-tklauser@distanz.ch/

thanks,
-- Shuah
