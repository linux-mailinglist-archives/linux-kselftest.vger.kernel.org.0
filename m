Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0276A458
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 00:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGaWtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 18:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjGaWto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 18:49:44 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 064CD1BD9;
        Mon, 31 Jul 2023 15:49:41 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36VMnTAY018361;
        Tue, 1 Aug 2023 00:49:29 +0200
Date:   Tue, 1 Aug 2023 00:49:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org
Subject: Re: [PATCH 1/4] selftests/nolibc: drop unused test helpers
Message-ID: <20230731224929.GA18296@1wt.eu>
References: <20230731073243.21265-1-falcon@tinylab.org>
 <20230731110226.115351-1-falcon@tinylab.org>
 <e7ec15d7-0152-4e69-920f-ffb1983e1011@t-8ch.de>
 <20230731165334.GA17823@1wt.eu>
 <26fd12c7-3c9c-4e1e-a8bf-9529cd624e81@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26fd12c7-3c9c-4e1e-a8bf-9529cd624e81@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 08:36:05PM +0200, Thomas Weißschuh wrote:
> > > > 7 helpers are only used by once, another 3 helpers are used twice, and
> > > > another 4 are only used by three times.
> > > 
> > > Why can't we just drop them when they are not used anymore?
> > 
> > Actually we don't know if they're used or not given that the purpose of
> > the nolibc-test.c file is for it to be easy to add new tests, and the
> > collection of macros above serves this purpose. It's not just a series
> > of test but rather a small test framework. So the fact that right now
> > no single test uses some of them doesn't mean that someone else will
> > not have to reimplement them in two months.
> 
> Reimplementing them would mean to copy one of the sibling test macros
> and changing the name and the condition operator in one place.

Yes but that's the difference between us providing a basis for others
to easily contribute tests and just saying "you can implement you test
in this directory". Literally adding just one line is simple and
encouraging enough.

> I regarded that as an acceptable effort instead of having to work around
> the warnings.

Warnings must always be addressed, and there are tools for this. One
of them is the inline keyword which makes them go away. It's fine as
long as we expect that functions are worth inlining (size, debuggability).
A second one is the "unused" attribute. I know you said you don't find
it clean but it's the official clean way to shut some specific warnings,
by passing meta-information to the compiler about the intent for certain
things. We can very well have a define saying that __maybe_unused maps
to __attribute__((unused)) as done everywhere else, but it's in the end
it remains the regular way to do it. Finally the third method consists
in removing "static" so that the compiler doesn't know if we're going
to use them elsewhere. My personal preference goes with the unused
attribute because it's well aligned with the spirit of a test framework
providing tools to those who need them.

> The warnings themselves I see as useful as they can give developers
> early feedback on their code. They would have avoided some of the issues
> with the recent pipe() series.

I totally agree with warnings. I compile my code with -W -Wall -Wextra
for this exact reason. Also inside a lib test we must try to trigger
more of them so as to be in the worst user situation, because if users
detect them first, that's painful.

> Do you have a preferred solution for the overall situation?

I'd rather put unused everywhere (possibly with a define to make it
more readable). And if the code is too large and too ugly (too many
utility functions) really moving it into a .h would significantly
help I think.

> > > > It is very easy to add the missing 'static' keyword for is_setting_valid(), but
> > > > for __stack_chk_init(), is it ok for us to convert it to 'static' and remove
> > > > the 'weak' attrbute and even the 'section' attribute? seems it is only used by
> > > > our _start_c() currently.
> > > 
> > > Making is_setting_valid(), __stack_chk_init() seems indeed useful.
> > > Also all the run_foo() test functions.
> > 
> > Most of them could theoretically be turned to static. *But* it causes a
> > problem which is that it will multiply their occurrences in multi-unit
> > programs, and that's in part why we've started to use weak instead. Also
> > if you run through gdb and want to mark a break point, you won't have the
> > symbol when it's static, and the code will appear at multiple locations,
> > which is really painful. I'd instead really prefer to avoid static when
> > we don't strictly want to inline the code, and prefer weak when possible
> > because we know many of them will be dropped at link time (and that's
> > the exact purpose).
> 
> Thanks for the clarification. I forgot about that completely!
> 
> The stuff from nolibc-test.c itself (run_foo() and is_settings_valid())
> should still be done.

Yes, likely. Nolibc-test should be done just like users expect to use
nolibc, and nolibc should be the most flexible possible.

Cheers,
Willy
