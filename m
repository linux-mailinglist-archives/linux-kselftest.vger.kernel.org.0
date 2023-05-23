Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1870E6D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 May 2023 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjEWUvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 May 2023 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEWUvG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 May 2023 16:51:06 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 548418E;
        Tue, 23 May 2023 13:51:04 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 34NKopcM014914;
        Tue, 23 May 2023 22:50:51 +0200
Date:   Tue, 23 May 2023 22:50:51 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 7/7] tools/nolibc: simplify stackprotector compiler flags
Message-ID: <ZG0nK0cLqAIUlwu8@1wt.eu>
References: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
 <20230521-nolibc-automatic-stack-protector-v1-7-dad6c80c51c1@weissschuh.net>
 <ZG0eNtYH1VvXdLBN@1wt.eu>
 <7126afac-3914-435a-852a-41703bc668ea@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7126afac-3914-435a-852a-41703bc668ea@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 23, 2023 at 10:38:48PM +0200, Thomas Weißschuh wrote:
> On 2023-05-23 22:12:38+0200, Willy Tarreau wrote:
> > Hi Thomas, Zhangjin,
> > 
> > I merged and pushed this series on top of the previous series, it's in
> > branch 20230523-nolibc-rv32+stkp3.
> > 
> > However, Thomas, I found an issue with this last patch that I partially
> > reverted in a last patch I pushed as well so that we can discuss it:
> > 
> > On Sun, May 21, 2023 at 11:36:35AM +0200, Thomas Weißschuh wrote:
> > >  
> > > -CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
> > > -			$(call cc-option,-mstack-protector-guard=global) \
> > > -			$(call cc-option,-fstack-protector-all)
> > > -CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
> > > -CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
> > > -CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
> > > -CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
> > > -CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
> > > -CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
> > > -CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
> > > -CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
> > > +CFLAGS_STACKPROTECTOR = $(call cc-option,-mstack-protector-guard=global -fstack-protector-all)
> > >  CFLAGS_s390 = -m64
> > >  CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
> > >  		$(call cc-option,-fno-stack-protector) \
> > > +		$(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all)) \
> > >  		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
> > 
> > By doing so, we reintroduce the forced stack-protector mechanism
> > that cannot be disabled anymore. The ability to disable it was the
> > main point of the options above. In fact checking __SSP__* was a
> > solution to save the user from having to set -DNOLIBC_STACKPROTECTOR
> > to match their compiler's flags, but here in the nolibc-test we still
> > want to be able to forcefully disable stkp for a run (at least to
> > unbreak gcc-9, and possibly to confirm that non-stkp builds still
> > continue to work when your local toolchain has it by default).
> 
> Wouldn't this work?
> 
> make CFLAGS_x86=-fno-stack-protector nolibc-test

Not that much because as you can see, CFLAGS is more of an
accumulator than an input cflags. Once it starts to accumulate
automatic flags detected for various reasons it becomes a huge
burden for end users to figure what to manually put there.

> Or we do 
> 
> CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
> CFLAGS ?= ... $(CFLAGS_STACKPROTECTOR)

> And then it is always:
> 
> make CFLAGS_STACKPROTECTOR= nolibc-test

This one is more in line with the partial revert. I don't have a
*strong* feeling for the per-arch setting but it did make sense when
not all archs were supporting it, and I've used per-arch setting when
I was having different compiler versions for certain archs (e.g. for
loongarch I used gcc12).

> An alternative would also be to use a GCC 9 compatible mechanism:
> 
> #if __has_attribute(no_stack_protector)
> #define __no_stack_protector __attribute__((no_stack_protector))
> #else
> #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
> #endif

I tried this one but I remember some initial failures and a possible
later success when instrumenting the correct function, so my memory
is not intact on this one. However if we manage to find a working
solution for gcc-9 and it affects the nolibc part (not the test part),
we definitely need to merge it because if some users have working stkp
on gcc-9 and we break it, that will not be cool.

> Or we combine CFLAGS_STACKPROTECTOR and __no_stack_protector.

I think that CFLAGS_STACKPROTECTOR should only be a makefile variable
to forcefully enable/disable that but not separately exposed in the
code.

> > So I reverted that part and only dropped -DNOLIBC_STACKPROTECTOR.
> > This way I could run the test on all archs with gcc-9 by forcing
> > CFLAGS_STACKPROTECTOR= and verified it was still possible to
> > disable it for a specific arch only by setting CFLAGS_STKP_$ARCH.
> > 
> > If you're fine with this we can squash this one into your cleanup
> > patch.
> 
> To be honest I was happy to get rid of all these architecture specific
> variables.

I generally agree with the principle and I think I can live with that.

So let's summarize: how about:
  - we only keep the CFLAGS_STACKPROTECTOR variable that is easy to
    reset from the make command line. Those with multiple compilers
    are free to globally enable/disable or pass that on multiple
    make command lines if needed, but we decide it's the users'
    test instrumentation problem, not the maintainers'.

  - we try our best to make sure that gcc-9 with stkp enabled still
    produces working code (with/without stkp I don't know but not
    something that smashes the stack at least).

IMHO this would be clean enough and sufficiently maintainable for the
long term.

> I trimmed the list a bit.

Thanks for them ;-)

Willy
