Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9D4D4FE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiCJRHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 12:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiCJRHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 12:07:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE71520D7;
        Thu, 10 Mar 2022 09:06:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 6BE891F45B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646931972;
        bh=iPK6QF0y/6zlgq+bwwi+2moLzboKZdCts+SbXnScr6c=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=dAeAJ3eKo2T57kTi7993ivxvMMFuRq3vBvy1NjXT1qMCLIRZ1OruYTGtFTsAnagSY
         wsoCWIPZF3EAuCoDjx3VlfhA+mkBHKVjXYSSrvfy/itE5JEBAqwyvgF96v0ZWUaGv4
         gI5/4fJFLnXrVLQ0WWvJIvFTCSdtZg05jnIPY27YRX/nSom1ELYvdN2wmAQdQncyFA
         o6oSFMqkCOStk6GvntaG0Yffvup7gVsSQa4in2U1YxQDnmygDnkAo94tYZnLRU+MBM
         SX6qU3FLezKiMUs8QTG6F88j9gwvj451Jph00jFgbt/cV9Ug24jIF1FprLmXs98pvb
         B8WJ26PRWcnvg==
Message-ID: <2e1a658f-de97-c099-f3ef-948bc56df514@collabora.com>
Date:   Thu, 10 Mar 2022 22:06:04 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Makefile: Fix separate output directory build of
 kselftests
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220223191016.1658728-1-usama.anjum@collabora.com>
 <6e954470-f593-e27a-d15c-ecd5c28f4dca@linuxfoundation.org>
 <2ac8cecb-5e14-a8b2-7629-a9ab9d474585@collabora.com>
 <65c11aba-bcab-28f4-a016-8cad128809ad@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <65c11aba-bcab-28f4-a016-8cad128809ad@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/9/22 2:19 AM, Shuah Khan wrote:
> On 3/8/22 1:11 AM, Muhammad Usama Anjum wrote:
>> On 3/4/22 2:32 AM, Shuah Khan wrote:
>>> On 2/23/22 12:10 PM, Muhammad Usama Anjum wrote:
>>>> Build of kselftests fail if kernel's top most Makefile is used for
>>>> running or building kselftests with separate output directory. The
>>>> absolute path is needed to reference other files during this kind of
>>>> build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
>>>> fixes the following different types of errors:
>>>>
>>>> make kselftest-all O=/linux_mainline/build
>>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>>
>>>> make kselftest-all O=build
>>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>> I've tested this patch on top of next-20220217. The latest
>>>> next-20220222
>>>> have missing patches.
>>>
>>> Can you give more details on the use-cases you tested? Did you test all
>>> the ways kselftest are built?
>>>
>> Yeah, I've tried to test all the ways. Here are the different ways I've
>> used to test it:
>> 1) Same directory build of kselftest (this is already working)
>> make kselftest
>> make kselftest-all
>> make kselftest-install
>> make kselftest-clean
>> make kselftest-gen_tar
>>
>> 2) These were failing when separate output directory is specified either
>> as relative or absolute path. After adding this patch, these are also
>> working. kselfetst.rst mentions separate output directory build in
>> this way.
>> make kselftest O=build
>> make kselftest-all O=build
>> make kselftest-install O=build
>> make kselftest-clean O=build
>> make kselftest-gen_tar O=build
>>
>> make kselftest O=/build
>> make kselftest-all O=/build
>> make kselftest-install O=/build
>> make kselftest-clean O=/build
>> make kselftest-gen_tar O=/build
>>
>> Tested on top of next-20220307 after applying this patch.
>>
> 
> Thank you for testing all these use-cases. This is a good comprehensive
> list. Do you mind sending a doc patch for
> 
> Documentation/dev-tools/kselftest.rst
> 
> The text here could almost as is as a new section after
> 
> Contributing new tests (details) with a new section that outlines
> the tests to run when adding a new test to selftests/Makefile
> and making changes to kselftest common frameowork: selftests/Makefile,
> selftests/lib.mk
Hi Shuah,

Yeah, definitely I can write and contribute it. I've noted this. This is
the last patch I want to get accepted, then I plan to update the
kselftest documentation (with the things you have mentioned and a few
more things) and write a blog about how KernelCI has helped in all this.
> 
> Let me know if you are unable to, I will send a patch in.
> 
> thanks,
> -- Shuah

-- 
Muhammad Usama Anjum
