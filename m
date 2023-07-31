Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81730769ACC
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 17:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGaPad (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGaPac (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 11:30:32 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DCA10E3;
        Mon, 31 Jul 2023 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690817424;
        bh=7PwxTw3aSVah1GIOmec1TC/G/sFMEfwrvAppv6sZQi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdHvZIMW32fYbk3AZr/ZfaIzQBJP11N0nSWLA8+ZD1VT4NwIM9VGY8OSZ241nEbR8
         PHowpI/lpl0aoDNKEK7mZUf7zxky7FZiU/ZR2KGri/DYL39Ab0t55lwKdQije/3VwT
         PV/DPzVJlpe/egcdVNw4DDTfwtLugcXpJB+NWK+A=
Date:   Mon, 31 Jul 2023 17:30:23 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org
Subject: Re: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Message-ID: <e7ec15d7-0152-4e69-920f-ffb1983e1011@t-8ch.de>
References: <20230731073243.21265-1-falcon@tinylab.org>
 <20230731110226.115351-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731110226.115351-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-31 19:02:26+0800, Zhangjin Wu wrote:
> Hi, Willy

Thomas here :-)

> > > > > Why not a simple 'static __attribute__((unused))' line, then, no need to
> > > > > add them again next time.
> > > > > 
> > > > >     -static int expect_zr(int expr, int llen)
> > > > >     +static __attribute__((unused))
> > > > >     +int expect_zr(int expr, int llen)
> > > > >      {
> > > > 
> > > > Personally I don't like having dead code lying around that needs to be
> > > > maintained and skipped over while reading.
> > > > It's not a given that we will need those helpers in the future at all.
> > > >
> > > 
> > > It is reasonable in some degree from current status, especially for
> > > these ones are newly added, but let us think about these scenes: when we
> > > would drop or change some test cases in the future and the helpers may
> > > would be not referenced by any test cases in a short time, and warnings
> > > there, but some other cases may be added later to use them again ...
> > 
> > That doesn't seem very likely.
> > Did it happen recently?
> >
> 
> Yeah, it did happen, but I can not remember which one, a simple statistic
> does show it may be likely:

I can't find it.

>     $ grep EXPECT_ -ur tools/testing/selftests/nolibc/nolibc-test.c | grep -v define | sed -e 's/.*\(EXPECT_[A-Z0-9]*\).*/\1/g' | sort | uniq -c | sort -k 1 -g -r
>          55 EXPECT_EQ
>          37 EXPECT_SYSER
>          21 EXPECT_SYSZR
>          11 EXPECT_SYSNE
>           9 EXPECT_VFPRINTF
>           4 EXPECT_PTRGT
>           4 EXPECT_GE
>           3 EXPECT_STRZR
>           3 EXPECT_NE
>           3 EXPECT_LT
>           3 EXPECT_GT
>           2 EXPECT_STRNZ
>           2 EXPECT_STREQ
>           2 EXPECT_PTRLT
>           1 EXPECT_SYSER2
>           1 EXPECT_SYSEQ
>           1 EXPECT_PTRNZ
>           1 EXPECT_PTRNE
>           1 EXPECT_PTRER2
>           1 EXPECT_PTRER
>           1 EXPECT_PTREQ
> 
> 7 helpers are only used by once, another 3 helpers are used twice, and
> another 4 are only used by three times.

Why can't we just drop them when they are not used anymore?

> > > I'm ok to drop these ones, but another patch may be required to add
> > > 'static __attribute__((unused))' for all of the currently used ones,
> > > otherwise, there will be warnings randomly by a test case change or
> > > drop.
> > 
> > Then we just drop the helper when we don't need it anymore.
> > 
> > I also dislike the __attribute__ spam to be honest.
> >
> 
> Me too, but it does help sometimes ;-)
> 
> > > Or even further, is it possible to merge some of them to some more
> > > generic helpers like the ones used from the selftest.h in your last RFC
> > > patchset?
> > 
> > Something like this will indeed be part of the KTAP rework.
> > But it's a change for another time.
> 
> Yes, this may be a better solution to such warnings.
> 
> Btw, just thought about gc-section, do we need to further remove dead code/data
> in the binary? I don't think it is necessary for nolibc-test itself, but with
> '-Wl,--gc-sections -Wl,--print-gc-sections' may be a good helper to show us
> which ones should be dropped or which ones are wrongly declared as public?
> 
> Just found '-O3 + -Wl,--gc-section + -Wl,--print-gc-sections' did tell
> us something as below:
> 
>     removing unused section '.text.nolibc_raise'
>     removing unused section '.text.nolibc_memmove'
>     removing unused section '.text.nolibc_abort'
>     removing unused section '.text.nolibc_memcpy'
>     removing unused section '.text.__stack_chk_init'
>     removing unused section '.text.is_setting_valid'
> 
> These info may help us further add missing 'static' keyword or find
> another method to to drop the wrongly used status of some functions from
> the code side.
> 
> It is very easy to add the missing 'static' keyword for is_setting_valid(), but
> for __stack_chk_init(), is it ok for us to convert it to 'static' and remove
> the 'weak' attrbute and even the 'section' attribute? seems it is only used by
> our _start_c() currently.

Making is_setting_valid(), __stack_chk_init() seems indeed useful.
Also all the run_foo() test functions.

> For the left ones, some are related to libgcc for divide by zero or the other
> divide functions, which may be not possible to drop in code side, but for
> memmove/memset, it is able to add -ffreestanding in our nolibc-test like -Wall
> and only wrap the 'weak' attribute with '#if __STDC_HOSTED__ == 1', for the ARM
> specific one, '#ifdef __ARM_EABI__'.

That seems very excessive.

> And even further, the '_start_c()' should be 'static' too, perhaps the above
> issues are worth a new patchset, If you agree, will send a new patchset to fix
> up them.

_start_c(), too.
