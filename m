Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0772C52F8EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 07:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiEUFjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 01:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiEUFjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 01:39:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6F17EC28;
        Fri, 20 May 2022 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FLFe3GohEWKBhG78tZp73MhkabMfxSWSPxhcTqaSvE4=; b=YojUZnpfEW7pmWM4ukpYO6Hwxf
        Bcd2/zNxywrOj/RN4RJLuUfRSQiQBYXZ9UuSQG+bLHmKl2ZugMvxVWXAID0nb3IAIZPdxf8/sGpHr
        ODMWi25za2Fr8EzabzlZpCoQ0ueKyBBgzbQDSNd5rg4OBp6M7VYr0GsmKri8hwYl4R6mgvUYSvZVG
        +UFySYLRaDmaqsyOmYr9CLx3++F+PGIYMf60HNu++AX9e/o27JDdxYios5y07LtcoD9iIY26JRH9T
        jDt8+HPAe4jHrpfbYbnGON1R6G9gqwq5cAUuVaW9VTjoWg7kr9m/vIhDO6gJFHYqJhRtBJEIHUcMf
        MpwvHWDg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsHpw-00EP3i-M8; Sat, 21 May 2022 05:39:36 +0000
Message-ID: <fbaf6d8e-eb69-8b3e-b2b8-8c50384ac417@infradead.org>
Date:   Fri, 20 May 2022 22:39:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in
 drivers/iio/afe/iio-rescale.o
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Liam Beguin <liambeguin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org>
 <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
 <CAK7LNASMOqfjHsE82ErjeYOJjxHgD_HZcm1VUcESORS6UridWw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNASMOqfjHsE82ErjeYOJjxHgD_HZcm1VUcESORS6UridWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/20/22 21:14, Masahiro Yamada wrote:
> On Sat, May 21, 2022 at 12:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Ok, one more.
>> [also adding Liam here]
>>
>> On 5/20/22 20:17, Randy Dunlap wrote:
>>>
>>>
>>> On 5/20/22 20:08, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 5/20/22 19:40, Randy Dunlap wrote:
>>>>> Hi,
>>>>>
>>>>> In March I reported that a randconfig build complained:
>>>>>
>>>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
>>>>>
>>>>> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
>>>>>
>>>>> I am still seeing this problem so I tried to dig into it a bit.
>>>>> However, I don't see why get_next_modinfo() and friends don't find the
>>>>> MODULE_LICENSE() since it is in the iio-rescale.o file.
>>>>>
>>>>> (BTW, I see this build error on many different $ARCH [around 15 tested]
>>>>> and with 2 different versions of GCC.)
>>>>>
>>>>> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
>>>>> strings?
>>>>>
>>>>> It looks like it is, because it appears (?) that modpost is looking at
>>>>> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
>>>>> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
>>>>> loadable module).
>>>>>
>>>>> Is this confusing modpost?
>>>>> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
>>>>> Makefile entry accordingly and the MODULE_LICENSE error goes away.
>>>>
>>>> Oh well. This rename causes drivers/iio/test/iio-test-rescale.c to have
>>>> build errors, so that's not a solution, just some info...
>>>
>>> and that was due to not updating drivers/iio/test/Makefile.
>>> When that is done, the missing MODULE_LICENSE() is back in afe-rescale.o.
>>>
>>>>
>>>>> Is this a modpost error or is kunit messing things up?
>>>>>
>>>>> thanks for looking.
>>
>> Does this look OK? It allows afe/iio-rescale.o to build XOR
>> test/iio-rescale.o (not both of them).
>>
>> --- a/drivers/iio/test/Kconfig
>> +++ b/drivers/iio/test/Kconfig
>> @@ -6,7 +6,7 @@
>>  # Keep in alphabetical order
>>  config IIO_RESCALE_KUNIT_TEST
>>         bool "Test IIO rescale conversion functions"
>> -       depends on KUNIT=y && !IIO_RESCALE
>> +       depends on KUNIT=y && IIO_RESCALE=n
>>         default KUNIT_ALL_TESTS
>>         help
>>           If you want to run tests on the iio-rescale code say Y here.
>>
>>
>> --
>> ~Randy
> 
> 
> 
> As you may have already noticed,
> the root cause is drivers/iio/test/Makefile
> 
> obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
> 
> 
> 
> For the combination of
> CONFIG_IIO_RESCALE=m
> CONFIG_IIO_RESCALE_KUNIT_TEST=y,
> 
> drivers/iio/afe/iio-rescale.o is built twice;
> as modular by drivers/iio/afe/Makefile, and
> as built-in by drivers/iio/test/Makefile.
> 
> That's why MODULE_LICENSE() is lost.
> 
> 
> I think your solution will work
> although this Makefile is not recommended.

Yeah, I don't care for how that is done either.

-- 
~Randy
