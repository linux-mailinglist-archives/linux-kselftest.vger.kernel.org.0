Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30958769D32
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjGaQyF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjGaQyE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 12:54:04 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 825341728;
        Mon, 31 Jul 2023 09:53:59 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36VGrYmN017834;
        Mon, 31 Jul 2023 18:53:34 +0200
Date:   Mon, 31 Jul 2023 18:53:34 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org
Subject: Re: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Message-ID: <20230731165334.GA17823@1wt.eu>
References: <20230731073243.21265-1-falcon@tinylab.org>
 <20230731110226.115351-1-falcon@tinylab.org>
 <e7ec15d7-0152-4e69-920f-ffb1983e1011@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7ec15d7-0152-4e69-920f-ffb1983e1011@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi guys,

On Mon, Jul 31, 2023 at 05:30:23PM +0200, Thomas Weißschuh wrote:

> > > > > > Why not a simple 'static __attribute__((unused))' line, then, no need to
> > > > > > add them again next time.
> > > > > > 
> > > > > >     -static int expect_zr(int expr, int llen)
> > > > > >     +static __attribute__((unused))
> > > > > >     +int expect_zr(int expr, int llen)
> > > > > >      {
> > > > > 
> > > > > Personally I don't like having dead code lying around that needs to be
> > > > > maintained and skipped over while reading.
> > > > > It's not a given that we will need those helpers in the future at all.
> > > > >
> > > > 
> > > > It is reasonable in some degree from current status, especially for
> > > > these ones are newly added, but let us think about these scenes: when we
> > > > would drop or change some test cases in the future and the helpers may
> > > > would be not referenced by any test cases in a short time, and warnings
> > > > there, but some other cases may be added later to use them again ...
> > > 
> > > That doesn't seem very likely.
> > > Did it happen recently?
> > >
> > 
> > Yeah, it did happen, but I can not remember which one, a simple statistic
> > does show it may be likely:
> 
> I can't find it.
> 
> >     $ grep EXPECT_ -ur tools/testing/selftests/nolibc/nolibc-test.c | grep -v define | sed -e 's/.*\(EXPECT_[A-Z0-9]*\).*/\1/g' | sort | uniq -c | sort -k 1 -g -r
> >          55 EXPECT_EQ
> >          37 EXPECT_SYSER
> >          21 EXPECT_SYSZR
> >          11 EXPECT_SYSNE
> >           9 EXPECT_VFPRINTF
> >           4 EXPECT_PTRGT
> >           4 EXPECT_GE
> >           3 EXPECT_STRZR
> >           3 EXPECT_NE
> >           3 EXPECT_LT
> >           3 EXPECT_GT
> >           2 EXPECT_STRNZ
> >           2 EXPECT_STREQ
> >           2 EXPECT_PTRLT
> >           1 EXPECT_SYSER2
> >           1 EXPECT_SYSEQ
> >           1 EXPECT_PTRNZ
> >           1 EXPECT_PTRNE
> >           1 EXPECT_PTRER2
> >           1 EXPECT_PTRER
> >           1 EXPECT_PTREQ
> > 
> > 7 helpers are only used by once, another 3 helpers are used twice, and
> > another 4 are only used by three times.
> 
> Why can't we just drop them when they are not used anymore?

Actually we don't know if they're used or not given that the purpose of
the nolibc-test.c file is for it to be easy to add new tests, and the
collection of macros above serves this purpose. It's not just a series
of test but rather a small test framework. So the fact that right now
no single test uses some of them doesn't mean that someone else will
not have to reimplement them in two months.

However I share your concern that the file has become ugly over time.
I've recently been wondering why we wouldn't move all that to an external
include file. It could also encourage us to differentiate between the
macros used to only evaluate a result, and the tests themselves, as
we'd be certain that none of them could call a test function directly.

> > Btw, just thought about gc-section, do we need to further remove dead code/data
> > in the binary? I don't think it is necessary for nolibc-test itself, but with
> > '-Wl,--gc-sections -Wl,--print-gc-sections' may be a good helper to show us
> > which ones should be dropped or which ones are wrongly declared as public?
> > 
> > Just found '-O3 + -Wl,--gc-section + -Wl,--print-gc-sections' did tell
> > us something as below:
> > 
> >     removing unused section '.text.nolibc_raise'
> >     removing unused section '.text.nolibc_memmove'
> >     removing unused section '.text.nolibc_abort'
> >     removing unused section '.text.nolibc_memcpy'
> >     removing unused section '.text.__stack_chk_init'
> >     removing unused section '.text.is_setting_valid'

Just a note Zhangjin, it would really help if you wouldn't mix different
topics in mails. It's easy enough to start a separate thread since it's
a completely separate one here.

> > These info may help us further add missing 'static' keyword or find
> > another method to to drop the wrongly used status of some functions from
> > the code side.
> > 
> > It is very easy to add the missing 'static' keyword for is_setting_valid(), but
> > for __stack_chk_init(), is it ok for us to convert it to 'static' and remove
> > the 'weak' attrbute and even the 'section' attribute? seems it is only used by
> > our _start_c() currently.
> 
> Making is_setting_valid(), __stack_chk_init() seems indeed useful.
> Also all the run_foo() test functions.

Most of them could theoretically be turned to static. *But* it causes a
problem which is that it will multiply their occurrences in multi-unit
programs, and that's in part why we've started to use weak instead. Also
if you run through gdb and want to mark a break point, you won't have the
symbol when it's static, and the code will appear at multiple locations,
which is really painful. I'd instead really prefer to avoid static when
we don't strictly want to inline the code, and prefer weak when possible
because we know many of them will be dropped at link time (and that's
the exact purpose).

Thanks,
Willy
