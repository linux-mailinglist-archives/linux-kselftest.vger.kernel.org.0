Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D93F6072
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhHXOdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbhHXOdq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 10:33:46 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20264C061764
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:33:02 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v16so20727945ilo.10
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Aug 2021 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WAOiuATXevPHNBvPplmlBHr/FxqYY3GsxpXENpilWKY=;
        b=WOyt9t0ZSbCOg6SIqTfFuAaqsoP+napnQatblZNXOZv389nl83Ysmds3o/R/BCG8CR
         Ggl2Kqha7WNRG8f7ytT0aW2T0c8GwgW6Tz/kJo1FvpLknhg6m4T7xd6dVPsZQaUzP5Fj
         iD48EZsk/WB8RA54gj1+CIxY+j2fscClna/mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WAOiuATXevPHNBvPplmlBHr/FxqYY3GsxpXENpilWKY=;
        b=PyO3M+fg22BkKUEctf4TDIgzRw9z+jhM0IqoZV9UOsbr+2p8W/HfXAiNjUcYsBtDTU
         Wc2Avpb/Bv/8sTWOAQ4geDMS7q7yhjE1+wza8tRLDdRjF9vJMue6ZDOrxsc2HMD+Ka/C
         eLq+5P4XDfW2zXXFlQA5md8sPAd44QUTyTqtcHAQapfc2qN+WNvb3BwXKNGa2QJOl1KS
         wUw5bo8wd8TaVR2cxgcuENnv+90xtW+2gbWK1Kv4ssRFV5UtJcnqxZ57nEzv5wLHOfrL
         XuEWSI4oeru83K/9jVflDpjlv0u9YgtU6IJ1CgnQg9DB0LwiwxHEGXTd//K/tVeyrN4c
         TE9Q==
X-Gm-Message-State: AOAM530hPcHa0gErh5y0XlmjEIyDqbpHbzgTG94fmsNXLWFYRAuWQkgJ
        TC1TX5CX1eMuoroDARvYWqxIOw==
X-Google-Smtp-Source: ABdhPJy7xWOsKHq9uY1p9tQB3YbrrULbZDI49VHGJeQAUgzbZygTm0Qysf9Xuy5NdXX5HfB9vL0Qgw==
X-Received: by 2002:a92:c94e:: with SMTP id i14mr26842749ilq.143.1629815581534;
        Tue, 24 Aug 2021 07:33:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 12sm6128492ilq.37.2021.08.24.07.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 07:33:01 -0700 (PDT)
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
 <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
 <20210824112129.2t6lzqyf2dxllw4a@senku>
 <20210824113619.a3gyxlerst7tumzn@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <11702c81-8b7c-bbe6-705a-f0fed5f10ba5@linuxfoundation.org>
Date:   Tue, 24 Aug 2021 08:33:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210824113619.a3gyxlerst7tumzn@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/24/21 5:36 AM, Christian Brauner wrote:
> On Tue, Aug 24, 2021 at 09:21:29PM +1000, Aleksa Sarai wrote:
>> On 2021-08-23, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>> Hi Baolin,
>>>
>>> On 8/22/21 8:40 PM, Baolin Wang wrote:
>>>> Hi Shuah,
>>>>
>>>> On 2021/7/28 20:32, Baolin Wang wrote:
>>>>> Hi,
>>>>>
>>>>>> When running the openat2 test suite on ARM64 platform, we got below failure,
>>>>>> since the definition of the O_LARGEFILE is different on ARM64. So we can
>>>>>> set the correct O_LARGEFILE definition on ARM64 to fix this issue.
>>>>>
>>>>> Sorry, I forgot to copy the failure log:
>>>>>
>>>
>>> Please cc everybody get_maintainers.pl suggests. You are missing
>>> key reviewers for this change.
>>>
>>> Adding Christian Brauner and Aleksa Sarai to the thread.
>>>
>>>>> # openat2 unexpectedly returned # 3['/lkp/benchmarks/kernel_selftests/tools/testing/selftests/openat2'] with 208000 (!= 208000)
>>>
>>> Not sure I understand this. 208000 (!= 208000) look sthe same to me.
>>>
>>>>> not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails with -22 (Invalid argument)
>>>>>
>>>>>>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>
>>>> Could you apply this patch if no objection from your side? Thanks.
>>>>
>>>
>>> Ideally this define should come from an include file.
>>
>> The issue is that O_LARGEFILE is set to 0 by glibc because glibc appears
>> to hide the nuts and bolts of largefile support from userspace. I
>> couldn't find a nice way of doing a architecture-dependent includes of
>> include/uapi from kselftests, so I just went with this instead -- but I
>> agree that a proper include would be better if someone can figure out
>> how to do it.
> 

 From a quick look, it will take sone work to consolidate multiple
O_LARGEFILE defines.

> I'd just add arch-dependent defines for now and call it good. So seems
> good enough for me:
> 
> Thanks!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
>>
>>> Christian, Aleksa,
>>>
>>> Can you review this patch and let me know if this approach looks right.
>>
>> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thank you for the patch and the reviews. I will apply this for 5.15-rc1

thanks,
-- Shuah
