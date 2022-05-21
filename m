Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155E52F825
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 05:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354482AbiEUDvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 23:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiEUDvP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 23:51:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D3DF41;
        Fri, 20 May 2022 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=4WwopnVdiZchgwgyYgiOR5oYH5rI/26dfgb7iblNhk0=; b=IWc3nqi4c5ufGx+0zpQ3nEFFKl
        4trofu8qu12i5wvDEhin7ta6+7OkCxakqrp4LNtnQ0yZllkPdAlxzlvR9ecDQ27MkTPKxGAuh4g/g
        PzvakYn065Z/qEILQAb8ou518LJAXH5S/sYVzCY//Wwl2huSamsieZlK5TzdyzXu7ymuCiFxfLkVG
        y60l1BrwB46WxHKYCRy9lRxvsyxMdoYBcwv0+luCZwji+kkiQmjTCCMPy6S/UghV8EwD2yEDE0oEa
        QJGta8hoV1OVcSH93QOjsf1PpaLPuspGOwMCVzBzimaK0R2B/gN3v9ucIP0SUldWXNDqJKqv8DTxb
        9tD4g3WQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsG8z-00ELwI-CT; Sat, 21 May 2022 03:51:09 +0000
Message-ID: <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
Date:   Fri, 20 May 2022 20:51:05 -0700
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
In-Reply-To: <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
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

Ok, one more.
[also adding Liam here]

On 5/20/22 20:17, Randy Dunlap wrote:
> 
> 
> On 5/20/22 20:08, Randy Dunlap wrote:
>>
>>
>> On 5/20/22 19:40, Randy Dunlap wrote:
>>> Hi,
>>>
>>> In March I reported that a randconfig build complained:
>>>
>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
>>>
>>> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
>>>
>>> I am still seeing this problem so I tried to dig into it a bit.
>>> However, I don't see why get_next_modinfo() and friends don't find the
>>> MODULE_LICENSE() since it is in the iio-rescale.o file.
>>>
>>> (BTW, I see this build error on many different $ARCH [around 15 tested]
>>> and with 2 different versions of GCC.)
>>>
>>> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
>>> strings?
>>>
>>> It looks like it is, because it appears (?) that modpost is looking at
>>> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
>>> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
>>> loadable module).
>>>
>>> Is this confusing modpost?
>>> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
>>> Makefile entry accordingly and the MODULE_LICENSE error goes away.
>>
>> Oh well. This rename causes drivers/iio/test/iio-test-rescale.c to have
>> build errors, so that's not a solution, just some info...
> 
> and that was due to not updating drivers/iio/test/Makefile.
> When that is done, the missing MODULE_LICENSE() is back in afe-rescale.o.
> 
>>
>>> Is this a modpost error or is kunit messing things up?
>>>
>>> thanks for looking.

Does this look OK? It allows afe/iio-rescale.o to build XOR
test/iio-rescale.o (not both of them).

--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -6,7 +6,7 @@
 # Keep in alphabetical order
 config IIO_RESCALE_KUNIT_TEST
        bool "Test IIO rescale conversion functions"
-       depends on KUNIT=y && !IIO_RESCALE
+       depends on KUNIT=y && IIO_RESCALE=n
        default KUNIT_ALL_TESTS
        help
          If you want to run tests on the iio-rescale code say Y here.


-- 
~Randy
