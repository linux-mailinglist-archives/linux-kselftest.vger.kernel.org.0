Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FDA542330
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jun 2022 08:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348058AbiFHBIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jun 2022 21:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579260AbiFGXjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jun 2022 19:39:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4D40BA5E
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Jun 2022 14:39:25 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r200so10988482iod.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jun 2022 14:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DMYMqyjnC+Pa1f9t3aRd7d9q29f2hRwNi8wYEpJotmk=;
        b=h4EOnSJW5qlumjyDRpOGgdjQoOyB4Q+O6l59N39UQahjkhxDl4VSySl01hMTwc9zRT
         EfuDzgEVqg/pBp3s4lQPkvko7HQkMiBmLEgZ1AEo0N7Phwb0v+fDY90LCrvAPcCNaH2r
         O3L623yMARWhJhFoBgQ8IewDspFlSDu0Jp5ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMYMqyjnC+Pa1f9t3aRd7d9q29f2hRwNi8wYEpJotmk=;
        b=3cbTEb6e6nFNMkfFlFHRpv18p1qEVSxDvC9+j87wJcGiGCXI1XoIlkxGSFc3oWyl6W
         RjS+UVVVZkQCRsZJXTbptsku8Yktq663DgxRteC8VlO3xsSf0fXF5j4Ovx+dJeFAazrd
         pudFEG+xWnt8AqbpUIRsOQ43jnboMq1LnEsCo6MVaUmGPO4YfhIz+6Qa7aFz5ig8kqcJ
         PnXBupm66DB8pFFmGnimw1rw+Ttnj+GBWsN+uM9H8xHlSADEl1+TqMQ8D2td06ZdEGBO
         Jn5m6YuS3qYSAFA+6oSykEr7LieqElwgNl7JS6cNd5orCW5x82MbN1HyTiKZe8eRu4HY
         ZMww==
X-Gm-Message-State: AOAM532uRzBmGpUboT6yQwm+riLuEAWR4GoJx6SV4Va6sGKILZbNQAEK
        yd5e9wkunpZPxk8HuY2HRKL/Gw==
X-Google-Smtp-Source: ABdhPJx4JWLAS1RWT5TFeTIfGK6vW9bn00rsuVLiTtAdQU1cno64ZEk4yj+YCiecaRL9yWnI7GLMpg==
X-Received: by 2002:a05:6638:1495:b0:331:c58a:301 with SMTP id j21-20020a056638149500b00331c58a0301mr4212898jak.134.1654637962472;
        Tue, 07 Jun 2022 14:39:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e1-20020a022101000000b0032b3a78179csm7086269jaa.96.2022.06.07.14.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 14:39:22 -0700 (PDT)
Subject: Re: [Bug Report] - kselftest build fails if output directory is first
 level sub-directory
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <c25d7ea7-4f72-4a2b-d8c3-d317e64fcbbb@collabora.com>
 <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a9470bfc-bddc-6aa6-0043-d49eb57611fe@linuxfoundation.org>
Date:   Tue, 7 Jun 2022 15:39:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/22/22 11:15 AM, Masahiro Yamada wrote:
> On Sat, May 21, 2022 at 3:44 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hello,
>>
>> kselftest can be built using the kernel's top most Makefile without
>> using kselftest's Makefile directly. But there is bug in the top most
>> Makefile. The build fails if the specified output directory is first
>> level sub-directory. Here is a example to reproduce this bug:
>>
>> make kselftest-all O=build
>>
>> "The Make is working in a wrong directory, that is why the relative path
>> does not work." Masahiro Yamada. Feel free to fix it if someone pin the bug.
>>
>> It should be noted that the build works in some other combinations:
>> make kselftest-all (works)
>> make kselftest-all O=/tmp (works)
>> make kselftest-all O=build/build2 (works)
>>
>> My unsuccessful attempt to fix this bug can be found here:
>> https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
>>
>> Thanks,
>> Muhammad Usama Anjum
> 
> 
> This problem starts from the bad design of the kselftest framework.
> I did some research before. I think I can fix the root cause but
> currently I do not have enough time to do it.
> 
> 
> KBUILD_ABS_SRCTREE is a user-interface to request
> Kbuild to use the absolute path.
> If it is forced in the top Makefile, users have no way to
> negate it.
> It is true that using the absolute path is a quick work-around
> because you do not need to care about the current working directory.
> 
> If you insist on it,  just go ahead.  It is just two line changes.
> Once the issue is fixed in a better way, your patch can be reverted easily.
> 
> 
> 

Why don't we work on fixing it the wright way? I would rather go that
route than using short rem fixes.

Usama, would you be interested in working on a proper fix as recommended
by Masahiro?

thanks,
-- Shuah
