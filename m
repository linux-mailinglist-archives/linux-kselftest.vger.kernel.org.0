Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841FD4D232C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiCHVUh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 16:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiCHVUg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 16:20:36 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C12D1F4
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 13:19:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h7so132072ile.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 13:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QLkteIHRhUSwMXJUDME8Lv3LFalvJ1bqMQRnTxAe590=;
        b=HPHLxDYxsD2+TZ97by9ltALMf5ZHAJRHroJziBzdFwPuSJCKFZe4Yg027YVsTH6yCw
         i3KnR6zXLuQMsYM4TizAFnN6ywf0cp6as6NL0rWeD34y0dg06ufDv99CZ6frUbi4E0uE
         ISz7vzV+iA8emrmC8AR103T/jvoipxfWillrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QLkteIHRhUSwMXJUDME8Lv3LFalvJ1bqMQRnTxAe590=;
        b=KfVUmv6FkqKH/9KDTpnVEMJW1K2V/Fbp9bEAjMMKOcJ8L3qNe8940YAUmsSmyR4gcZ
         Ghb2hy7t9KOXrG1LDSulfEaxVcmZtFMsg6vq9+dV/9aAJdVjSe3raXY73Fbcg+CN+XZc
         RM2SxrJ7bhphfh+k14BHO5l19XSoYTC6yuixioFNotaU+oVLsbxeTQq0JJ2SlDVLhEBc
         7rwMppZ3Z7jV8HQknHuyVNC8T69tqJxxR9SOaeka6vnpy99gYcrL5tsG4viSCSJ2WNcb
         0046MBg/uOhnVo2/tmasYKYum5rzm63sV9DjxOZWYN6Ui9Z/gGoAkvnMlj40ZBtncn21
         gBvw==
X-Gm-Message-State: AOAM530AwXM5yW6Nbh7ulM1AY1LHaW3nTGWGLKPjFnMWb5gs+4pXreH3
        niioWbTF1eBee1Wy0PX8PiwRlA==
X-Google-Smtp-Source: ABdhPJyv+OH6SuRIzmqviaFC/odZEMdUR/TmLwGhSf+amvFfnigvBORf3Lp73Pst8YT7Bsp/7ZB+pA==
X-Received: by 2002:a05:6e02:5b1:b0:2c6:218d:fb38 with SMTP id k17-20020a056e0205b100b002c6218dfb38mr17562252ils.266.1646774377886;
        Tue, 08 Mar 2022 13:19:37 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d9647000000b00638d53cd21esm11212583ios.26.2022.03.08.13.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 13:19:37 -0800 (PST)
Subject: Re: [PATCH] Makefile: Fix separate output directory build of
 kselftests
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel@collabora.com, kernelci@groups.io, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220223191016.1658728-1-usama.anjum@collabora.com>
 <6e954470-f593-e27a-d15c-ecd5c28f4dca@linuxfoundation.org>
 <2ac8cecb-5e14-a8b2-7629-a9ab9d474585@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <65c11aba-bcab-28f4-a016-8cad128809ad@linuxfoundation.org>
Date:   Tue, 8 Mar 2022 14:19:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2ac8cecb-5e14-a8b2-7629-a9ab9d474585@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/22 1:11 AM, Muhammad Usama Anjum wrote:
> On 3/4/22 2:32 AM, Shuah Khan wrote:
>> On 2/23/22 12:10 PM, Muhammad Usama Anjum wrote:
>>> Build of kselftests fail if kernel's top most Makefile is used for
>>> running or building kselftests with separate output directory. The
>>> absolute path is needed to reference other files during this kind of
>>> build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
>>> fixes the following different types of errors:
>>>
>>> make kselftest-all O=/linux_mainline/build
>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>
>>> make kselftest-all O=build
>>> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> I've tested this patch on top of next-20220217. The latest next-20220222
>>> have missing patches.
>>
>> Can you give more details on the use-cases you tested? Did you test all
>> the ways kselftest are built?
>>
> Yeah, I've tried to test all the ways. Here are the different ways I've
> used to test it:
> 1) Same directory build of kselftest (this is already working)
> make kselftest
> make kselftest-all
> make kselftest-install
> make kselftest-clean
> make kselftest-gen_tar
> 
> 2) These were failing when separate output directory is specified either
> as relative or absolute path. After adding this patch, these are also
> working. kselfetst.rst mentions separate output directory build in this way.
> make kselftest O=build
> make kselftest-all O=build
> make kselftest-install O=build
> make kselftest-clean O=build
> make kselftest-gen_tar O=build
> 
> make kselftest O=/build
> make kselftest-all O=/build
> make kselftest-install O=/build
> make kselftest-clean O=/build
> make kselftest-gen_tar O=/build
> 
> Tested on top of next-20220307 after applying this patch.
> 

Thank you for testing all these use-cases. This is a good comprehensive
list. Do you mind sending a doc patch for

Documentation/dev-tools/kselftest.rst

The text here could almost as is as a new section after

Contributing new tests (details) with a new section that outlines
the tests to run when adding a new test to selftests/Makefile
and making changes to kselftest common frameowork: selftests/Makefile,
selftests/lib.mk

Let me know if you are unable to, I will send a patch in.

thanks,
-- Shuah
