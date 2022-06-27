Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2555C1C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 14:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbiF0TvK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbiF0TvJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 15:51:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9971BE83
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 12:51:08 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bd16so14291031oib.6
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lax6tduoacbWOt589nrsDLYbyissFSu1a+cUknCvds8=;
        b=ax0cpW+ZOtWvLU6t2mEu2n0HrO9xigxaL2BEHTp85A0NcXGE8geCFKaZ7h+T/RaFd9
         zu6aOBF9iBKJLwAVY0rUSuVshbvR1ncqQUHevEzI6bMhmISB46cA3nPusoeNZYRtsTcg
         x9tyO/xtFP8zNC7BUrNo41zKHpks/k1kpFKhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lax6tduoacbWOt589nrsDLYbyissFSu1a+cUknCvds8=;
        b=ugXSUudt3DlyhLubWcH/PEOzgWnbarrs3LKN3ctf2WtzDKCjY6X2KcLaEm6ZoBtTYT
         5BS8LDRf0AADiDV9n4g/YP0jhYJHhyX7GG7fQiMFqJDFW9N+AY5Y33IbJsaxj7sWZR+S
         IgZlkhj1w8wsV1l23J6B67r+SPSlGaKHeoCA6rpxZRiAJDal31CLZJnbftFw+ccadTFC
         Cj1sE/t4GHsWBCTUsMhJ7XVsdS2SOaEqRxAxNXBrwTW1bcg1ALhQmYFBKvVxEuXBhs6f
         EMTe2RJd46+OK2El7nYOS5j4hdxC3IHpeEqZhCj0ANi/kwT7BTGqt9FN/2pOnUvrNX/t
         HNsA==
X-Gm-Message-State: AJIora9mHgnFgr5R/U27yGZ4T0j5PEDneb8Oqs867UhxcdBlUKww8cma
        rpbDld22h4/S6P6G3rzXFHaI3g==
X-Google-Smtp-Source: AGRyM1tjAhC8ikc6jKP7CYXJgwqC6e3zpb4n/TsfSmBG4/1/KnwX9y6Hl92eNG8tnpO6+S1ZJPxGIg==
X-Received: by 2002:a05:6808:2113:b0:335:5252:ddf3 with SMTP id r19-20020a056808211300b003355252ddf3mr8707869oiw.94.1656359467466;
        Mon, 27 Jun 2022 12:51:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s7-20020a056870630700b0010830c24aaasm7579135oao.56.2022.06.27.12.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:51:07 -0700 (PDT)
Subject: Re: [PATCH v1] kbuild: fix sub directory output build of kselftests
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kieran Bingham <kbingham@kernel.org>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220627070214.432390-1-usama.anjum@collabora.com>
 <15532d64-6744-c8a5-184b-18358211d345@linuxfoundation.org>
 <CAK7LNARxSFSQgmrZe2CXj+V153kymBVyGkXwOPWLNoybQ8+bfg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <04f168f8-0369-f0f6-8eab-9d384aced2c8@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 13:51:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNARxSFSQgmrZe2CXj+V153kymBVyGkXwOPWLNoybQ8+bfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/27/22 11:45 AM, Masahiro Yamada wrote:
> On Tue, Jun 28, 2022 at 1:54 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 6/27/22 1:02 AM, Muhammad Usama Anjum wrote:
>>> Build of kselftests fail if kernel's top most Makefile is used for
>>> running or building kselftests with separate output directory which is
>>> sub-directory. srctree is set to .. erroneously.
>>>
>>> make kselftest-all O=/linux_mainline/build
>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>
>>> make kselftest-all O=build
>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>
>>> Fix this by comparing abs_srctree with CURDIR instead of abs_objtree.
>>> CURDIR changes based on from where the command has been run and it sets
>>> the srctree correctly.
>>>
>>> Fixes: 25b146c5b8cee("kbuild: allow Kbuild to start from any directory")
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes in V2:
>>> - Correct the bugfix instead of workaround
>>>
>>> V1: https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
>>> ---
>>>    Makefile | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index e66358b64ede..4090d7afcda4 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -238,12 +238,12 @@ ifeq ($(need-sub-make),)
>>>    # so that IDEs/editors are able to understand relative filenames.
>>>    MAKEFLAGS += --no-print-directory
>>>
>>> -ifeq ($(abs_srctree),$(abs_objtree))
>>> +ifeq ($(abs_srctree),$(CURDIR))
>>>            # building in the source tree
>>>            srctree := .
>>>        building_out_of_srctree :=
>>>    else
>>> -        ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))
>>> +        ifeq ($(abs_srctree)/,$(dir $(CURDIR)))
>>>                    # building in a subdirectory of the source tree
>>>                    srctree := ..
>>>            else
>>>
>>
>> Please resend cc'ing linux-kselftest
>>
>> thanks,
>> -- Shuah
> 
> 
> Please do not send this any more.
> This part is good as is.
> 

+ linux-kselftest@vger.kernel.org

The reason I suggested resending cc'ing linux-kselftest is because
this fixes a kselftest problem.

I am assuming this patch will go through kbuild

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
