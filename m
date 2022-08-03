Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13745894AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 01:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiHCXMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 19:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbiHCXMe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 19:12:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685E55B04A
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Aug 2022 16:12:33 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id g14so4573797ile.11
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Aug 2022 16:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Yh1GeaOYFjJIe9+oI56LqaRda7Oz6X4Jb6/nxg3/9U=;
        b=N5uVyzQvv03TkDg8UyAd605uXTbQuazjvAkrI6JQpMVGUkEKHR4rKR8FxI6dTgw8vI
         k1pPzVDnRQKYW9RNFv9ZR+4mBg5Jc0BlRRnPtZiwWgBE4TQH2GcNScnkW8F3kCKwYljF
         bQzOld/VoOaupxxTHsqSwzGmB9ETtTpbsGMwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Yh1GeaOYFjJIe9+oI56LqaRda7Oz6X4Jb6/nxg3/9U=;
        b=EdcJtwlpcQS5a8sBntCmlofWoXkqXp5mksQwkcIpZk/ZvpXwn67ORoYrcBXNBA8IbA
         l37tecrVScn3G8/p8Bj/NqpPc0V9q8eXncDrHHcBhqtRZpWg1FboXtTns/3rON7FJi8d
         UO93eUBeI0fdYbeHPjve5TvmUklpI8wXQtL9P+yudoZ1y92aAasoIa+5vC6fesYQFjgO
         w3H80+ISq0TV2U6NB6g4Wd5Ub10GPGA7U3XvP2ufOxQNjXuhX/WeJSpvDzWqRdLQT/Qv
         LYtVTiufBl8LHaFurpakcVq6M7rdyUS5gScBy3w+eLi30JbebSxa0F/fbb2rn4VXlRGU
         nw1g==
X-Gm-Message-State: AJIora/2CwGN99YgDzpE82zdsUHZSY0BrRrsQzBzNzOuGItUR2nF3RHg
        EPU8A91+R8EiaoATkc0DOu33wg==
X-Google-Smtp-Source: AGRyM1vs1lsRZKuWF7cjOzHXC4X4N1DpumplKPDthw5AOMD4g9p5AQ1gT2p3Es01r6dY4WUaSPOhiA==
X-Received: by 2002:a05:6e02:194f:b0:2dc:7d9d:3b06 with SMTP id x15-20020a056e02194f00b002dc7d9d3b06mr11515873ilu.242.1659568352770;
        Wed, 03 Aug 2022 16:12:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cx10-20020a056638490a00b0034142dad202sm1088057jab.31.2022.08.03.16.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 16:12:32 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.20-rc1
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
 <2838c247-0648-3828-efb3-e11d7a0616b2@digikod.net>
 <84560b65-12ed-da24-3698-45484f80802a@linuxfoundation.org>
 <fa7fb9b3-169a-199f-22da-006777a14e03@collabora.com>
 <15a23d4b-ee26-a6a1-a785-b640c550bfb8@linuxfoundation.org>
 <7a412c45-4536-1f0b-d04e-24b2063ac034@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c227526a-6cf6-247a-df8f-6574e3c748ad@linuxfoundation.org>
Date:   Wed, 3 Aug 2022 17:12:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7a412c45-4536-1f0b-d04e-24b2063ac034@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/22 2:22 PM, Guillaume Tucker wrote:
> On 03/08/2022 16:32, Shuah Khan wrote:
>> On 8/2/22 10:44 PM, Guillaume Tucker wrote:
>>> On 02/08/2022 15:29, Shuah Khan wrote:
>>>> On 8/2/22 3:51 AM, Mickaël Salaün wrote:
>>>>> Hi,
>>>>>
>>>>> This change breaks the Landlock test build when performed on the tools/testing/selftests/landlock directory because the (non-system/up-to-date) kernel headers aren't found. Looking at the use of top_srcdir and HDR_PATH, it seems that multiple subsystems are using this feature. I consider this change a regression.
>>>>>
>>>>
>>>> I did a build test from the top level before sending the pull request
>>>> and didn't catch this breakage as a result. This breaks when build is
>>>> run from the test directory.
>>>>
>>>> We have had several problems related to khdr_dir and target and decided
>>>> to move away from it with this change.
>>>>
>>>>> It also removes the check on up-to-date kernel headers (thanks to the Makefile's target timestamp).
>>>>>
>>>>> I wasn't CCed for this change impacting Landlock [1]. Please keep in mind to add at least maintainers and related mailing-lists for changes on related subsystems.
>>>>>
>>>>
>>>> That is the usual practice and if I notice missing maintainers, I add
>>>> them. We missed this one.
>>>>
>>>>> The following patch almost revert commit a917dd94b832 ("selftests/landlock: drop deprecated headers dependency") and partially fixes commit 49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target"):
>>>>>
>>>>
>>>> Guillaume,
>>>>
>>>> Will you be able to look at this and send a patch on top? I will
>>>> send another pull request before merge window closes?
>>>
>>> Sure, I'll take a look today.
>>>
>>
>> Thank you.
> 
> OK I just sent "selftests/landlock: fix broken include of linux/landlock.h"
> 
> This does fix the build when doing:
> 
>    make -C tools/testing/selftests/landlock
> 

Thank you for fixing this quickly.

> However I've also noticed the landlock test is failing to build
> when make is invoked from the top-level directory and using a
> sub-directory for the build output, in other words my earlier
> patches didn't fix the build for this test, but that's not a
> regression.
> 

Okay.

> I'll see if that can be fixed too while also not breaking
> the "-C" sub-make build.
> 

Sounds good. Supporting all these use-cases makes it a bit hard.

>>> Also I'll see if we can add some extra build tests in KernelCI
>>> for the kselftest tree to catch issues like these automatically.
>>>
>>

> Great.  Well I shall try and get that set up before making further changes ;)
> 

Thanks.

> 
> P.S. The output of gen_tar is showing "-ne " on every line, is that expected?
>       For example: -ne Emit Tests for alsa
> 

Hmm. I will try and let you. I haven't used this one in a bit.

thanks,
-- Shuah
