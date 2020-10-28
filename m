Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C729D59B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 23:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgJ1WFf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgJ1WFe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:34 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6DFC0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:05:34 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id b34so156218uab.8
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B1ciQs0tIUrzamgMFIiR9+0gbuBBSi5PbiyG4MiAZuo=;
        b=fmJX2ejnDVI8dcSjhMLymoA7Z2Eqy+pQYeWFz5jhy63fgQy2ttCBz1h6z0zaM6SjnA
         IXAwdr5gcrzyxaftD/b6bXEPCqeuu1x+S1NelVa/5nT9g8XINQaL4+rxRAyy7wvdjAa6
         /BIGiYKHme6ALbRPbCAzPK72rEhO74wu+a6ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B1ciQs0tIUrzamgMFIiR9+0gbuBBSi5PbiyG4MiAZuo=;
        b=qOacEM2piWV6oQomNpZR681mR9Y36MbsrYStQrMKZifSXWaHwJFeBX3kqOlHqsbr3A
         qMeE7NYX0Ha/412wO1DHXdcK869TcEZmAVvZfHojl9NTUqf51y8bG6MOE2GFTLLrCxlS
         tAKeRWQYI1P0CeIvtpMgVkq61lGPO0K9dJpyn5fQ3dNpCcI/g6PFs970NP9wvDVYDMyW
         JHcFbYd4e0D0GJlhz7Zb0+i3JXFr1Byf4TFKfwHt+17TDIUyTS47AErTpGXhoNeBwgoM
         CHhOFxGTRiEzJSE2whvg9NrsWS1gAILv1Yq+6p+NI1OBObMw8ZfF9JwTrEnPjLuhwOrQ
         6aWw==
X-Gm-Message-State: AOAM533VkuDXMTt6TP4hEvX3xZB/0h1qy6XR1eXK/LkvAZiziVyIdq5F
        0Ri7TA217V+ZN9j5Tx1wc8NVgjUHw1nyOg==
X-Google-Smtp-Source: ABdhPJxIhDXad77eNUS6JVTDUuoz5BPKcp8l4YkIqQuFS+EEs1MCsoLBv8wRS1ctm7FG86BaJHPlkQ==
X-Received: by 2002:a9d:1ee5:: with SMTP id n92mr5985068otn.152.1603898453779;
        Wed, 28 Oct 2020 08:20:53 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d11sm2221331oti.69.2020.10.28.08.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:20:52 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] kselftest: Extend vDSO tests
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201026114945.48532-1-vincenzo.frascino@arm.com>
 <87y2js1tic.fsf@nanos.tec.linutronix.de>
 <127f025c-1ce5-0dcb-30a2-a26b4a8e5b35@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c7f84f84-7e76-05ee-9fc6-915dec1d51f0@linuxfoundation.org>
Date:   Wed, 28 Oct 2020 09:20:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <127f025c-1ce5-0dcb-30a2-a26b4a8e5b35@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/26/20 6:50 PM, Shuah Khan wrote:
> On 10/26/20 5:01 PM, Thomas Gleixner wrote:
>> On Mon, Oct 26 2020 at 11:49, Vincenzo Frascino wrote:
>>> This series extends the kselftests for the vDSO library making sure: 
>>> that
>>> they compile correctly on non x86 platforms, that they can be cross
>>> compiled and introducing new tests that verify the correctness of the
>>> library.
>>>
>>> The so extended vDSO kselftests have been verified on all the platforms
>>> supported by the unified vDSO library [1].
>>>
>>> The only new patch that this series introduces is the first one, 
>>> patch 2 and
>>> patch 3 have already been reviewed in past as part of other series 
>>> [2] [3].
>>>
>>> [1] 
>>> https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com 
>>>
>>> [2] 
>>> https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com 
>>>
>>> [3] 
>>> https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com 
>>>
>>>
>>> It is possible to build the series using the command below:
>>>
>>> make -C tools/testing/selftests/ ARCH=<arch> TARGETS=vDSO CC=<compiler>
>>>
>>> A version of the series rebased on 5.10-rc1 to simplify the testing 
>>> can be found
>>> at [4].
>>>
>>> [4] https://git.gitlab.arm.com/linux-arm/linux-vf.git vdso/v4.tests
>>
>> Assuming Shuah will pick them up:
>>
>>    Acked-by: Thomas Gleixner <tglx@linutronix.de>
>>
> 
> 
> Thanks. I will pick these up.


Applied to linux-kselftest next

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

thanks,
-- Shuah

