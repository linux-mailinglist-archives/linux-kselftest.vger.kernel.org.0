Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9770E64E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 May 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjEWUNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 May 2023 16:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjEWUNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 May 2023 16:13:48 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D3BB11D;
        Tue, 23 May 2023 13:13:45 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 34NKCcxC014675;
        Tue, 23 May 2023 22:12:38 +0200
Date:   Tue, 23 May 2023 22:12:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Zhangjin Wu <falcon@tinylab.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 7/7] tools/nolibc: simplify stackprotector compiler flags
Message-ID: <ZG0eNtYH1VvXdLBN@1wt.eu>
References: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
 <20230521-nolibc-automatic-stack-protector-v1-7-dad6c80c51c1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230521-nolibc-automatic-stack-protector-v1-7-dad6c80c51c1@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas, Zhangjin,

I merged and pushed this series on top of the previous series, it's in
branch 20230523-nolibc-rv32+stkp3.

However, Thomas, I found an issue with this last patch that I partially
reverted in a last patch I pushed as well so that we can discuss it:

On Sun, May 21, 2023 at 11:36:35AM +0200, Thomas Weißschuh wrote:
>  
> -CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
> -			$(call cc-option,-mstack-protector-guard=global) \
> -			$(call cc-option,-fstack-protector-all)
> -CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_arm64 = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_arm = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_mips = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_riscv = $(CFLAGS_STACKPROTECTOR)
> -CFLAGS_STKP_loongarch = $(CFLAGS_STACKPROTECTOR)
> +CFLAGS_STACKPROTECTOR = $(call cc-option,-mstack-protector-guard=global -fstack-protector-all)
>  CFLAGS_s390 = -m64
>  CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
>  		$(call cc-option,-fno-stack-protector) \
> +		$(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all)) \
>  		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))

By doing so, we reintroduce the forced stack-protector mechanism
that cannot be disabled anymore. The ability to disable it was the
main point of the options above. In fact checking __SSP__* was a
solution to save the user from having to set -DNOLIBC_STACKPROTECTOR
to match their compiler's flags, but here in the nolibc-test we still
want to be able to forcefully disable stkp for a run (at least to
unbreak gcc-9, and possibly to confirm that non-stkp builds still
continue to work when your local toolchain has it by default).

So I reverted that part and only dropped -DNOLIBC_STACKPROTECTOR.
This way I could run the test on all archs with gcc-9 by forcing
CFLAGS_STACKPROTECTOR= and verified it was still possible to
disable it for a specific arch only by setting CFLAGS_STKP_$ARCH.

If you're fine with this we can squash this one into your cleanup
patch.

Zhangjin I think this branch should work well enough for you to
serve as a base for your upcoming series. We'll clean it up later
once we all agree on the stat() replacement for syscall() and on
the various remaining points including your time32 alternatives.

Thanks to you both,
Willy

PS: we're still carrying a long CC list of individuals who are likely
    not that much interested in our discussion, I propose that we trim
    it on next exchanges and only keep us 3 and the lists, in order to
    remove some of their e-mail pollution.

