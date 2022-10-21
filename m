Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B470D607D61
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJURVN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiJURUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 13:20:50 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B73491FCD5;
        Fri, 21 Oct 2022 10:20:33 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29LHKQIL014148;
        Fri, 21 Oct 2022 19:20:26 +0200
Date:   Fri, 21 Oct 2022 19:20:26 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221021172026.GC8420@1wt.eu>
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 10:07:38AM -0700, Paul E. McKenney wrote:
> > I see. In the worst case, a preliminary "make clean" will do it. We just
> > need to decide what's the best solution for everyone (i.e. not waste too
> > much time between tests while not getting misleading results by accident).
> 
> Maybe just document the careful/slow way, then people doing it more
> frequently can do it the clever/fast way.
> 
> My guess is that the careful/slow is this:
> 
> 	pushd tools/include/nolibc
> 	make clean
> 	make
> 	popd
> 	pushd tools/testing/selftests/nolibc
> 	make clean
> 	make -j32 run
> 
> Or did I miss a turn in there somewhere?

It's even easier, you don't even need the clean phase in include/nolibc.
I'm doing this and it's sufficient:

  make -C tools/testing/selftests/nolibc clean
  make -C tools/testing/selftests/nolibc nolibc-test
  tools/testing/selftests/nolibc/nolibc-test

Or for the test under QEMU, which involves a kernel build:

  make -C tools/testing/selftests/nolibc clean
  make -C tools/testing/selftests/nolibc -j $(nproc) run

Where would you first look for such a hint ? Maybe the help output of
the default "make" command could send as a hint that a clean is needed
after patching nolibc and that could be sufficient ? I just want to make
sure users don't waste their time trying to find what they could be doing
wrong.

Willy
