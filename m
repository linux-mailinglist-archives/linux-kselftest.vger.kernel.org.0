Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA42535186
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 May 2022 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiEZPgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 May 2022 11:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiEZPgv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 May 2022 11:36:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB2BDA3A;
        Thu, 26 May 2022 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cz2tBlHujupjVKE2JuyYre4LY/Jweg2bry3B8ZlajT4=; b=ALDJYJMy6GstbzTOeqw3GSAx3x
        EyusWqWlv8+IL9jMBmp9ma04RBhiT1tSpcdmavPfHCCVdYw10lEYgdr8z8fV5NKWEjFmorZSXM1VM
        o1BfLSrfsjC8rg7srg96SErGKFCUi+TjZo0dw6ByYcTbdqE0KNkpMOwbtt5Qna8TsG7NpCb0hsM9o
        rPU6ifHlVXzwqDayoGEOQb++vZB2MFTcR6uHpztqatBpZk6TT9PmMHKyfUJj2a9q2lkD4MbUzjFvA
        WblB7AccPHNZJ22HUzkQr3mSjL1195tzgHL2sKbvEzA7dIZ+6jSvfq4BFWnVkFGBE6TZDQ2g0+qT4
        STk7kffw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuFXT-001vPs-KS; Thu, 26 May 2022 15:36:41 +0000
Message-ID: <7a97bac3-6ade-8e1b-cf0c-4a05c83163a3@infradead.org>
Date:   Thu, 26 May 2022 08:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in
 drivers/iio/afe/iio-rescale.o
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org>
 <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
In-Reply-To: <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
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

Liam:

Any comment on this?
Otherwise I'll just send a formal patch like this (below).

Thanks.

On 5/20/22 20:51, Randy Dunlap wrote:
> Ok, one more.
> [also adding Liam here]
> 
> On 5/20/22 20:17, Randy Dunlap wrote:
>>
>>
>> On 5/20/22 20:08, Randy Dunlap wrote:
>>>
>>>
>>> On 5/20/22 19:40, Randy Dunlap wrote:
>>>> Hi,
>>>>
>>>> In March I reported that a randconfig build complained:
>>>>
>>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
>>>>
>>>> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
>>>>
>>>> I am still seeing this problem so I tried to dig into it a bit.
>>>> However, I don't see why get_next_modinfo() and friends don't find the
>>>> MODULE_LICENSE() since it is in the iio-rescale.o file.
>>>>
>>>> (BTW, I see this build error on many different $ARCH [around 15 tested]
>>>> and with 2 different versions of GCC.)
>>>>
>>>> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
>>>> strings?
>>>>
>>>> It looks like it is, because it appears (?) that modpost is looking at
>>>> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
>>>> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
>>>> loadable module).
>>>>
>>>> Is this confusing modpost?
>>>> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
>>>> Makefile entry accordingly and the MODULE_LICENSE error goes away.
>>>
>>> Oh well. This rename causes drivers/iio/test/iio-test-rescale.c to have
>>> build errors, so that's not a solution, just some info...
>>
>> and that was due to not updating drivers/iio/test/Makefile.
>> When that is done, the missing MODULE_LICENSE() is back in afe-rescale.o.
>>
>>>
>>>> Is this a modpost error or is kunit messing things up?
>>>>
>>>> thanks for looking.
> 
> Does this look OK? It allows afe/iio-rescale.o to build XOR
> test/iio-rescale.o (not both of them).
> 
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -6,7 +6,7 @@
>  # Keep in alphabetical order
>  config IIO_RESCALE_KUNIT_TEST
>         bool "Test IIO rescale conversion functions"
> -       depends on KUNIT=y && !IIO_RESCALE
> +       depends on KUNIT=y && IIO_RESCALE=n
>         default KUNIT_ALL_TESTS
>         help
>           If you want to run tests on the iio-rescale code say Y here.
> 
> 

-- 
~Randy
