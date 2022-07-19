Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E33257A562
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 19:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbiGSRby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbiGSRbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 13:31:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984DA5A885;
        Tue, 19 Jul 2022 10:31:49 -0700 (PDT)
Received: from [192.168.1.72] (136.203.115.78.rev.sfr.net [78.115.203.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 329456601955;
        Tue, 19 Jul 2022 18:31:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658251907;
        bh=jIA5oD7gpTgXWAfR2Mm2w19/e/vskjL1LF249/HQPKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XMqXepdPgkUEe+ogPiW5sOOGjTJFuh6/M+BipmxwVp3FCwN7dpsUWnWnAUEhR18Pr
         IEJGPkx05XNPQW+iy+mj455M9z2dBSwFX7gb7RdXIoMZFq4I5/GF4iOpO+NA/pTRvg
         dTgUg+EpRKJVBVj2vfB1PsUzsaIWrAXOvvNx4yFCwnks9erHHkRtGjXCl+RZHcNRE2
         3wZcbfqg4rK1pm26yBuaXP5Mvb4HNbHc1R2xR5n/RHUFUXh8NxRj87oCpkfHf8Kum+
         YCTY/Imwu0T0nLGfwQpxznP8WyhtB1glBCo6LeW3/vkRDwUGYjH2JQPxhWfV3kTrH5
         RBZhOR6FRgaNg==
Message-ID: <81241d70-7952-2f55-9181-d18679068998@collabora.com>
Date:   Tue, 19 Jul 2022 19:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Makefile: replace headers_install with headers for
 kselftest
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Tim Bird <Tim.Bird@sony.com>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <a7af58feaa6ae6d3b0c8c55972a470cec62341e5.1657693952.git.guillaume.tucker@collabora.com>
 <f35a71d6-bd96-7aa9-c143-39ae88bc85d5@linuxfoundation.org>
 <8fc9d169-78ff-0fe4-67c0-784097861f12@collabora.com>
 <CAK7LNAQ4iMBwu4bOmmOrMudNH49ruz-7AK_H3-ceTixd=G+brQ@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <CAK7LNAQ4iMBwu4bOmmOrMudNH49ruz-7AK_H3-ceTixd=G+brQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19/07/2022 17:06, Masahiro Yamada wrote:
> On Tue, Jul 19, 2022 at 9:37 PM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> On 14/07/2022 22:45, Shuah Khan wrote:
>>> On 7/13/22 12:33 AM, Guillaume Tucker wrote:
>>>> Replace headers_install with headers as kselftest uses the header
>>>> files from within the kernel tree rather than from a system-wide
>>>> installation.
>>>>
>>>> We can still run this directly:
>>>>
>>>>    $ make O=build kselftest-all
>>>>
>>>> and when building from the selftests directory:
>>>>
>>>>    $ make O=build headers
>>>>    $ make O=build -C tools/testing/selftests all
>>>>
>>>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>>> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
>>>> ---
>>>>   Makefile | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index fb2f3bb53a6b..5c934d16664c 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -1347,10 +1347,10 @@ tools/%: FORCE
>>>>   # Kernel selftest
>>>>     PHONY += kselftest
>>>> -kselftest: headers_install
>>>> +kselftest: headers
>>>>       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
>>>>   -kselftest-%: headers_install FORCE
>>>> +kselftest-%: headers FORCE
>>>>       $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
>>>>     PHONY += kselftest-merge
>>>>
>>>
>>> Thank you for taking care of this. This will go through kbuild?
>>
>> You're welcome.
>>
>> Masahiro-san,
>>
>> A you OK with applying this in the kbuild tree ahead of the
>> upcoming merge window?
> 
> 
> No.
> 
> This is a fix-up patch on top of the previous one [1],
> which  was applied to the kselftest tree.
> 
> This cannot apply to the kbuild tree.

OK thank you for confirming.

Shuah, I guess you're happy to apply it to the kselftest tree
instead then?

Guillaume

> [1]: https://lore.kernel.org/linux-kbuild/168ede35-12e0-c535-9d94-23b65a1beb28@collabora.com/T/#mb8ec7004f7c9b89fbb50c19022760e19701af7f6
> 
> 
> 
> 
> 
> 
>> Best wishes,
>> Guillaume
>>
>>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> thanks,
>>> -- Shuah
>>>
> 
> 
> 

