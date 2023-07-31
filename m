Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5F769416
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 13:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGaLCl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 07:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGaLCk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 07:02:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE383;
        Mon, 31 Jul 2023 04:02:36 -0700 (PDT)
X-QQ-mid: bizesmtp65t1690801351tfb3p73d
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 19:02:30 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: dKvkn8qoLrEyhx+Jaw+d5WyNz/uHfgPB0Gk1tEnCKLhQBPkGXhtME1hizAwuQ
        0fSskWl/dyNYdWLh+DI/YCgbdQp3Rh78MvTpqAqpsiolKVne0Wigdcz2Dy4HvRMWXmHBTMj
        GtuYqP/cF/p+54GMKUS5Fuq4skMqbXPowPZf0H3ol8fRISZOEIx//enDBvbUAUfaCj3JudC
        v55oGOKLaG08DZTrYKAqv9IW5eL20GSCFopyjyfszdECNrPyR3l2fvWoxE7ZnIYVc+ySbNv
        yDZyQqx1BSZkexiU1C7Myttv9qQq/UZEOFgZ1oXeC1FMjKu7ixHPQtj2zMOhWXvEjmDsQTz
        i2u8kNdqpJ1R60zSVBnWDnMYtOPwspGknAwaEi/tGA6pDW+FU4WLPdfMcNwr3FMMsW6+bJw
        Z6NMAzib9dk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16609348120013740945
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux@weissschuh.net, shuah@kernel.org, tanyuan@tinylab.org
Subject: Re: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Date:   Mon, 31 Jul 2023 19:02:26 +0800
Message-Id: <20230731110226.115351-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731073243.21265-1-falcon@tinylab.org>
References: <20230731073243.21265-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> On 2023-07-31 15:32:43+0800, Zhangjin Wu wrote:
> > Hi, Thomas
> > 
> > > Note:
> > > 
> > > It seems your mail client does not add the prefix "Re: " to responses.
> > > Is that intentional?
> > >
> > 
> > I use a lightweight 'b4 + git send-email' method to reply emails,
> > sometimes, I forgot manually adding the 'Re: ' prefix, perhaps I should
> > write a simple script to do that or carefully check the Subject title
> > everytime, Thanks!
> 
> Now there are two "Re: " prefixes :-)
> 
> My understanding is that there is exactly one "Re: " prefix iff the
> message is any response at all.
>

Get it, some clients always add another 'Re: ' for a new response, only
one is better, thanks ;-)

> > > On 2023-07-31 14:48:26+0800, Zhangjin Wu wrote:
> > > > Hi, Thomas
> > > > 
> > > > > As we want to enable compiler warnings in the future these would be
> > > > > reported as unused functions.
> > > > > 
> > > > > If we need them in the future they are easy to recreate from their still
> > > > > existing siblings.
> > > > > 
> > > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > > ---
> > > > >  tools/testing/selftests/nolibc/nolibc-test.c | 99 ----------------------------
> > > > >  1 file changed, 99 deletions(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > > index 03b1d30f5507..53e2d448eded 100644
> > > > > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > > > > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > > > > @@ -161,31 +161,6 @@ static void result(int llen, enum RESULT r)
> > > > >   * of failures, thus either 0 or 1.
> > > > >   */
> > > > >  
> > > > > -#define EXPECT_ZR(cond, expr)				\
> > > > > -	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_zr(expr, llen); } while (0)
> > > > > -
> > > > > -static int expect_zr(int expr, int llen)
> > > > > -{
> > > > 
> > > > Why not a simple 'static __attribute__((unused))' line, then, no need to
> > > > add them again next time.
> > > > 
> > > >     -static int expect_zr(int expr, int llen)
> > > >     +static __attribute__((unused))
> > > >     +int expect_zr(int expr, int llen)
> > > >      {
> > > 
> > > Personally I don't like having dead code lying around that needs to be
> > > maintained and skipped over while reading.
> > > It's not a given that we will need those helpers in the future at all.
> > >
> > 
> > It is reasonable in some degree from current status, especially for
> > these ones are newly added, but let us think about these scenes: when we
> > would drop or change some test cases in the future and the helpers may
> > would be not referenced by any test cases in a short time, and warnings
> > there, but some other cases may be added later to use them again ...
> 
> That doesn't seem very likely.
> Did it happen recently?
>

Yeah, it did happen, but I can not remember which one, a simple statistic
does show it may be likely:

    $ grep EXPECT_ -ur tools/testing/selftests/nolibc/nolibc-test.c | grep -v define | sed -e 's/.*\(EXPECT_[A-Z0-9]*\).*/\1/g' | sort | uniq -c | sort -k 1 -g -r
         55 EXPECT_EQ
         37 EXPECT_SYSER
         21 EXPECT_SYSZR
         11 EXPECT_SYSNE
          9 EXPECT_VFPRINTF
          4 EXPECT_PTRGT
          4 EXPECT_GE
          3 EXPECT_STRZR
          3 EXPECT_NE
          3 EXPECT_LT
          3 EXPECT_GT
          2 EXPECT_STRNZ
          2 EXPECT_STREQ
          2 EXPECT_PTRLT
          1 EXPECT_SYSER2
          1 EXPECT_SYSEQ
          1 EXPECT_PTRNZ
          1 EXPECT_PTRNE
          1 EXPECT_PTRER2
          1 EXPECT_PTRER
          1 EXPECT_PTREQ

7 helpers are only used by once, another 3 helpers are used twice, and
another 4 are only used by three times.

> > I'm ok to drop these ones, but another patch may be required to add
> > 'static __attribute__((unused))' for all of the currently used ones,
> > otherwise, there will be warnings randomly by a test case change or
> > drop.
> 
> Then we just drop the helper when we don't need it anymore.
> 
> I also dislike the __attribute__ spam to be honest.
>

Me too, but it does help sometimes ;-)

> > Or even further, is it possible to merge some of them to some more
> > generic helpers like the ones used from the selftest.h in your last RFC
> > patchset?
> 
> Something like this will indeed be part of the KTAP rework.
> But it's a change for another time.

Yes, this may be a better solution to such warnings.

Btw, just thought about gc-section, do we need to further remove dead code/data
in the binary? I don't think it is necessary for nolibc-test itself, but with
'-Wl,--gc-sections -Wl,--print-gc-sections' may be a good helper to show us
which ones should be dropped or which ones are wrongly declared as public?

Just found '-O3 + -Wl,--gc-section + -Wl,--print-gc-sections' did tell
us something as below:

    removing unused section '.text.nolibc_raise'
    removing unused section '.text.nolibc_memmove'
    removing unused section '.text.nolibc_abort'
    removing unused section '.text.nolibc_memcpy'
    removing unused section '.text.__stack_chk_init'
    removing unused section '.text.is_setting_valid'

These info may help us further add missing 'static' keyword or find
another method to to drop the wrongly used status of some functions from
the code side.

It is very easy to add the missing 'static' keyword for is_setting_valid(), but
for __stack_chk_init(), is it ok for us to convert it to 'static' and remove
the 'weak' attrbute and even the 'section' attribute? seems it is only used by
our _start_c() currently.

For the left ones, some are related to libgcc for divide by zero or the other
divide functions, which may be not possible to drop in code side, but for
memmove/memset, it is able to add -ffreestanding in our nolibc-test like -Wall
and only wrap the 'weak' attribute with '#if __STDC_HOSTED__ == 1', for the ARM
specific one, '#ifdef __ARM_EABI__'.

And even further, the '_start_c()' should be 'static' too, perhaps the above
issues are worth a new patchset, If you agree, will send a new patchset to fix
up them.

Thanks,
Zhangjin

> 
> Thomas
