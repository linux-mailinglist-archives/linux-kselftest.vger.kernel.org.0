Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A745535438
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 May 2022 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbiEZUEv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 May 2022 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbiEZUEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 May 2022 16:04:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B6372209;
        Thu, 26 May 2022 13:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=S9y6ecfItCHTZPLBWd79nswqv8BapgWNHqq54ASXQBM=; b=QeKozE9pLJjOGGflthiUPaJOya
        6YTba/dwspp8MnH0ZXYR8HQ2U5/GlCom4CBSacka4YggyCFcx3RTaznZR/qX2oEVK1iAY7yNcYLcI
        b55N9QKovEI9OREje0zE1kiVBA8SDTdJIWZXhCvNRXt/8r/CWiCOXBYSE1QIcelik89xYD7QKoKNU
        DKXmOuHox6EHdFImyNFgCDEDFXAPp0zfxbXBO9YsudK1fzgExuCq/NBDk2NZEwIS1pK01lt2mkPsu
        JWn5eixJRcEkF2XSfoMi+EdPR6AdWHYVpeGHxxsRM+n4epdcW0FHUeaezCKa81dsnKF1V2/GAaF6l
        EqICNI2w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJiw-001W4J-54; Thu, 26 May 2022 20:04:46 +0000
Message-ID: <3b7ec693-f4a5-e1aa-3e07-b22a4008d4c9@infradead.org>
Date:   Thu, 26 May 2022 13:04:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in
 drivers/iio/afe/iio-rescale.o
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org>
 <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
 <7a97bac3-6ade-8e1b-cf0c-4a05c83163a3@infradead.org> <Yo+lHSmeIsx144cv@shaak>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yo+lHSmeIsx144cv@shaak>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/26/22 09:04, Liam Beguin wrote:
> Hi Randy,
> 
> On Thu, May 26, 2022 at 08:36:34AM -0700, Randy Dunlap wrote:
>> Liam:
>>
>> Any comment on this?
>> Otherwise I'll just send a formal patch like this (below).
> 
> Apologies for not answering earlier.
> 
> I wanted to look more into Masahiro's comment and try to fix the
> Makefile, but that can be done after.
> 
> IMO your patch improves the current Kconfig, so I'd recommend sending
> the patch. If it can wait a bit, I can look at the Makefile over the
> weekend.
> 

Liam,

I'll wait until next week to see if you come up with anything.

Thanks.

> 
>>
>> Thanks.
>>
>> On 5/20/22 20:51, Randy Dunlap wrote:
>>> Ok, one more.
>>> [also adding Liam here]
>>>
>>> On 5/20/22 20:17, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 5/20/22 20:08, Randy Dunlap wrote:
>>>>>
>>>>>
>>>>> On 5/20/22 19:40, Randy Dunlap wrote:
>>>>>> Hi,
>>>>>>
>>>>>> In March I reported that a randconfig build complained:
>>>>>>
>>>>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
>>>>>>
>>>>>> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
>>>>>>
>>>>>> I am still seeing this problem so I tried to dig into it a bit.
>>>>>> However, I don't see why get_next_modinfo() and friends don't find the
>>>>>> MODULE_LICENSE() since it is in the iio-rescale.o file.
>>>>>>
>>>>>> (BTW, I see this build error on many different $ARCH [around 15 tested]
>>>>>> and with 2 different versions of GCC.)
>>>>>>
>>>>>> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
>>>>>> strings?
>>>>>>
>>>>>> It looks like it is, because it appears (?) that modpost is looking at
>>>>>> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
>>>>>> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
>>>>>> loadable module).
>>>>>>
>>>>>> Is this confusing modpost?
>>>>>> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
>>>>>> Makefile entry accordingly and the MODULE_LICENSE error goes away.
>>>>>
>>>>> Oh well. This rename causes drivers/iio/test/iio-test-rescale.c to have
>>>>> build errors, so that's not a solution, just some info...
>>>>
>>>> and that was due to not updating drivers/iio/test/Makefile.
>>>> When that is done, the missing MODULE_LICENSE() is back in afe-rescale.o.
>>>>
>>>>>
>>>>>> Is this a modpost error or is kunit messing things up?
>>>>>>
>>>>>> thanks for looking.
>>>
>>> Does this look OK? It allows afe/iio-rescale.o to build XOR
>>> test/iio-rescale.o (not both of them).
>>>
>>> --- a/drivers/iio/test/Kconfig
>>> +++ b/drivers/iio/test/Kconfig
>>> @@ -6,7 +6,7 @@
>>>  # Keep in alphabetical order
>>>  config IIO_RESCALE_KUNIT_TEST
>>>         bool "Test IIO rescale conversion functions"
>>> -       depends on KUNIT=y && !IIO_RESCALE
>>> +       depends on KUNIT=y && IIO_RESCALE=n
>>>         default KUNIT_ALL_TESTS
>>>         help
>>>           If you want to run tests on the iio-rescale code say Y here.
>>>
>>>
>>
>> -- 
>> ~Randy

-- 
~Randy
