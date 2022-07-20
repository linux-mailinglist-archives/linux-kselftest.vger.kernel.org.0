Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337F057BB4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jul 2022 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiGTQVO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiGTQVO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 12:21:14 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 356A8491E9;
        Wed, 20 Jul 2022 09:21:10 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26KGKsKX004192;
        Wed, 20 Jul 2022 18:20:54 +0200
Date:   Wed, 20 Jul 2022 18:20:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Fernanda Ma'rouf" <fernandafmr12@gnuweeb.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [PATCH 00/17] nolibc: add preliminary self tests
Message-ID: <20220720162054.GB4159@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
 <67a92005-4e13-909a-1693-dfb86d8114c0@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a92005-4e13-909a-1693-dfb86d8114c0@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 20, 2022 at 11:03:58PM +0700, Ammar Faizi wrote:
> On 7/20/22 4:44 AM, Willy Tarreau wrote:
> > I'm obviously interested in comments, but really, I don't want to
> > overdesign something for a first step, it remains a very modest test
> > program and I'd like that it remains easy to hack on it and to contribute
> > new tests that are deemed useful.
> 
> I personally hate how the test framework mandates:
> 
>   "There must be exactly one test per line."

I know, that's a design choice that makes them trivial to add, because
it's the compiler that assigns the test IDs, and it comes with a non
negligible benefit.

> which makes the test case, for example, one long liner like this:
> 
>   if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
> 
> that's ugly and hard to read. Can we get rid of this "one test per line" rule?

If you find a better solution, I'm open. What I certainly don't want
to do is to have to cross-reference IDs with arrays, nor start to stack
endless if/else that are even more painful to deal with, or have to
renumber everything by hand once in a while.

> It would be great if we followed the documented coding style that says:
> 
>    "Statements longer than 80 columns should be broken into sensible chunks,
>     unless exceeding 80 columns significantly increases readability and does
>     not hide information." [1]

Admittedly this is not core code but debugging code running in userland
to help developers spot bugs in their code which is somewhere else and
well maintained. I personally think that the tradeoff is positive here,
i.e. non-pretty but easily hackable short tests that encourage additions
and variations. The ease of adding tests allowed me to create 71 of them
in a single afternoon and two of them brought me bugs in existing code,
which I think is efficient. But I'm not fond of the approach either, I
just couldn't produce anything as efficient that was prettier, but I'm
quite open to being proven wrong by an alternate proposal.

> What we have here doesn't really increase the readability at all. Maybe
> it's too late for 5.20, just for next in case we want to fix it.

The goal was not to increase *readability* but *writability*. We're
still missing test for most syscalls and I would like them to be added
quickly so that we can continue to add tested code. The readability I
care about is understanding the output. When I'm seeing:

  ...
  29 execve_root = -1 EACCES               [OK]
  30 getdents64_root = -1 EBADF           [FAIL]
  31 getdents64_null = -1 EBADF  != (-1 ENOTDIR) [FAIL]
  32 gettimeofday_null = 0                 [OK]
  ...

on riscv64, I don't have to search long to figure that we did something
wrong with getdents64() on this arch and that the error path works
differently. Similarly, this on mips:

  8 kill_CONT = 0                          [OK]
  9 kill_BADPID = -1 ESRCH                 [OK]
  10 sbrkdo_page_fault(): sending SIGSEGV to init for invalid read access from 0000000a
  epc = 0000000a in init[400000+4000]
  ra  = 0000000a in init[400000+4000]
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

tells me that sbrk() definitely doesn't work there.

In both cases I know what and where to look without even having to *read*
that test. This does matter to me, as a developer of the component subject
to the test.

But again, I'm open to better proposals. I reached the limits of my
imagination there, but I do value the ability to "yyp" one line, change
two arguments and gain one extra test for a different combination, and
I really do not want to lose that simplicity. Note that for more complex
tests, it's trivial to add a dedicated function and that's what was done
for getdents64() which also serves as an example.

Willy
