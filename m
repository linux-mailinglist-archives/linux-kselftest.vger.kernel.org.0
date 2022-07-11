Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C28570DEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 01:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGKXIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 19:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKXII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 19:08:08 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9548721F
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 16:08:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id m20so3532928ili.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Jul 2022 16:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pxJlETCPEHBQbahGOg/NSMRU0LrVE7hOLMj3y7kzK9w=;
        b=X7RGik/jDCOr5Fa+lHlfeG1T2hU9is8O8+tN+LPm4MrRRxsXbb/HJ8jS2ZeFTRlL8d
         +hMiVojqvGP/3PkP4oqYlWwht1Vkm3nmYFbhncFJONOGdm7taV/GWN7IIfELEU+ZICeV
         0/Vayy4Y/IV0hsPxo2ms8svdM4BMqceANMYPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pxJlETCPEHBQbahGOg/NSMRU0LrVE7hOLMj3y7kzK9w=;
        b=Y/1WUw0LF3XNpGtUlJ+SPeI1AnDmdzkJIN8VefVE2ZKlaGQ2iUIDo+oDe0n8OdbtEw
         TfSEV8Qvl+fn+EJSEpvtizeXiXWKTTV55Uy3rWHvc4+iMZQ/VtlaRK2Pyon2MbiyhgPh
         sVIVWoTNMVaa6P7fTwWR8U7aH0KjnjXq4e8ZXUylatT23GwbjujuFmHPYs4N+ZHwiH5K
         7i5oFM/zRk9imOwQh7NvpybPbwpp9vKaL+GfLrji9nRxwU6PP0ZOp23arOPHZCzplAU6
         B55UTmnwLl+iNPNDNOt+ZHYUem2aRDoa47Jiknrn3DCp46qhrmvGXPQGKubHPpY64+p2
         pZ5Q==
X-Gm-Message-State: AJIora/HVCN0jUyJTlqFA7fW7ibmq72rjUy5GG9+O0FaHgWv/6pVqmdH
        GOyhjP12aFA1B/HwXh2OKjYhrQ==
X-Google-Smtp-Source: AGRyM1ssd95vtTolGyGBr/dfUJKcR2zMP3hv867l9YAKzLPw+Ul9hCxFMfdhF5VDALH3Niydpu7D6g==
X-Received: by 2002:a92:c26b:0:b0:2dc:8bee:cade with SMTP id h11-20020a92c26b000000b002dc8beecademr885531ild.160.1657580886020;
        Mon, 11 Jul 2022 16:08:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s3-20020a056602168300b00678b7e2e040sm4180260iow.7.2022.07.11.16.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 16:08:05 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix kselftest build with sub-directory
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel@collabora.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1657296695.git.guillaume.tucker@collabora.com>
 <b39b9e0b-45f3-1818-39fe-58921182d957@linuxfoundation.org>
 <CADYN=9JncW4XKk8zVAuiux4R+FF2Z=LhBh--ajUqyGMC5yyxLQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fab2e2e1-311f-6e61-2ba7-0119b8281524@linuxfoundation.org>
Date:   Mon, 11 Jul 2022 17:08:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADYN=9JncW4XKk8zVAuiux4R+FF2Z=LhBh--ajUqyGMC5yyxLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/11/22 6:13 AM, Anders Roxell wrote:
> On Fri, 8 Jul 2022 at 19:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/8/22 10:23 AM, Guillaume Tucker wrote:
>>> Earlier attempts to get "make O=build kselftest-all" to work were
>>> not successful as they made undesirable changes to some functions
>>> in the top-level Makefile.  This series takes a different
>>> approach by removing the root cause of the problem within
>>> kselftest, which is when the sub-Makefile tries to install kernel
>>> headers "backwards" by calling make with the top-level Makefile.
>>> The actual issue comes from the fact that $(srctree) is ".." when
>>> building in a sub-directory with "O=build" which then obviously
>>> makes "-C $(top_srcdir)" point outside of the real source tree.
>>>
>>> With this series, the generic kselftest targets work as expected
>>> from the top level with or without a build directory e.g.:
>>>
>>>     $ make kselftest-all
>>>
>>>     $ make O=build kselftest-all
>>>
>>> Then in order to build using the sub-Makefile explicitly, the
>>> headers have to be installed first.  This is arguably a valid
>>> requirement to have when building a tool from a sub-Makefile.
>>> For example, "make -C tools/testing/nvdimm/" fails in a similar
>>> way until <asm/rwonce.h> has been generated by a kernel build.
>>>
>>> Guillaume Tucker (4):
>>>     selftests: drop khdr make target
>>>     selftests: stop using KSFT_KHDR_INSTALL
>>>     selftests: drop KSFT_KHDR_INSTALL make target
>>>     Makefile: add headers_install to kselftest targets
>>>
>>
>> This takes us to back to the state before b2d35fa5fc80 added
>> khdr support. I reluctantly agreed to the change and it has
>> proven to be a problematic change. I would rather have had the
>> dependency stated that headers should be installed prior to
>> building tests - test build depends on kernel build anyway and
>> having dependency on headers having build isn't a huge deal.
> 
> I agree that it's not a huge deal.
> 
>>
>> So I am in favor of getting rid of khdr support. However, this
>> khdr support was a change originated from Linaro test ring. Undoing
>> this might have implication on their workflow.
> 
> It shouldn't be a problem.
> I've been running these patches through a smoke test and it looks
> good.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> 
> 

Thank you Anders for confirming this isn't a problem for Linaro workflow
and testing.

Than you Guillaume for fixing the problem. I will apply these for 5.20-rc1.

thanks,
-- Shuah
