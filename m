Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA694F139A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357275AbiDDLMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243187AbiDDLME (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 07:12:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569DC3AA50;
        Mon,  4 Apr 2022 04:10:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 231F71F44F1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649070605;
        bh=uJM/eBYziCRkGOrHOqJSiL8T5PL06TZOxD1+cp1k4lI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=WcxVAn7bem/ad7tCGkNyhTYZGuTiG9TbACZ2HKZn3kk0abKkB6mCKQ86B5fNfagf8
         2cogEYTERRbxiCrtblpFqezTh9SfWlVYOj2qhYrEpyvvRPuSQEI6MV/AnUNc8Zv2ER
         l2BywD1pTw1bzWtfKqPRbvgRGO2cL4ctwqk8QjbmBnMD5xp8/YneID54IGN4bWto2R
         oI1hwKhzaCBut0lQ6kP08E+JitpPC1bi8S9xnWNAUl4NjcIHQdGmT1OHyEzjDLeIAB
         BOzJFo317z0D7tOS7JnJOwgQAt5mAzGU8Cw2NHny8n+YXErlUq8/j7KgEdQwfJ2EcH
         71dHdcJuu36Mg==
Message-ID: <d10a70cf-24a5-997a-09df-0bb2f4146b86@collabora.com>
Date:   Mon, 4 Apr 2022 16:09:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     usama.anjum@collabora.com, Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel@collabora.com, kernelci@groups.io,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Makefile: Fix separate output directory build of
 kselftests
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20220223191016.1658728-1-usama.anjum@collabora.com>
 <63c5d7ad-b0b2-9b37-16c3-354ac10858b6@collabora.com>
 <CAK7LNATkTPEBPWBSv6Rum0siHiHcJ0Q7VvPVoUQFH=S0M1fqow@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAK7LNATkTPEBPWBSv6Rum0siHiHcJ0Q7VvPVoUQFH=S0M1fqow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From [Makefile](https://elixir.bootlin.com/linux/latest/source/Makefile):
```
ifeq ($(abs_srctree),$(abs_objtree))
        # building in the source tree
        srctree := .
	building_out_of_srctree :=
else
        ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))
                # building in a subdirectory of the source tree
                srctree := ..
        else
                srctree := $(abs_srctree)
        endif
	building_out_of_srctree := 1
endif
```
`ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))` condition is setting
`srctree` to `..`. This is wrong. This condition isn't considering that
`header_install` doesn't depend on `abs_srctree and abs_objtree`. This
condition needs to be tweaked or removed for the `install_headers` to
work fine and fix this issue. I've added `KBUILD_ABS_SRCTREE=1` to the
kselftest target which sets the `srctree` to `abs_srctree` and thus
forcefully affecting only kselftest targets. This seems like the clean
fix. Alternatively we should remove this condition `ifeq
($(abs_srctree)/,$(dir $(abs_objtree)))` but it'll affect other targets
as well.

Complete details of investigation can be found here:
https://github.com/kernelci/kernelci-project/issues/92#issuecomment-1087406222

On 3/17/22 11:08 PM, Masahiro Yamada wrote:
> On Thu, Mar 17, 2022 at 7:49 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Reminder. Shuah is okay with this patch. Any thoughts?
> 
> I do not think this is the right fix,
> but something you just happen to find working.
> 
> 
> The Make is working in a wrong directory, that is why
> the relative path does not work
> (and you use the absolute path to work around it)
> 
`ifeq ($(abs_srctree)/,$(dir $(abs_objtree))) \ srctree := ..` has
broken the `make headers_install` when called through
selftests/Makefile. We can remove it or use the absolute path each time.

-- 
Muhammad Usama Anjum
