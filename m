Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB24BA758
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 18:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbiBQRmB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 12:42:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241845AbiBQRmB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 12:42:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C321819;
        Thu, 17 Feb 2022 09:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9051FB820C2;
        Thu, 17 Feb 2022 17:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467FFC340E8;
        Thu, 17 Feb 2022 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645119703;
        bh=8pbZj/3cVuW2vQLaHmXTlBvSAEOnHZPHPU8EvjwJvmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lICo15JaGIZ/+wRcv2OoGVinuJEdNg3fOgujgAyrExKrBVNZWnseGROU0F8zsi3XY
         SwZR4kNdyhOIKqUv8y+gsMfXk8TBoQPckN91MTym3WTpQB1X7VLe8CL/u5O+Pf9x9a
         UxRJvr1+jg2PvqdiG+nBI0C+x2ZyLUiI3nyUguqk62WvzsT2+H3tL3JabPWuJXf4cU
         AKOkKRnJBf9FTiqOTbx2N6qVW5b2iVuCWLutJcz2kv473EmYc2TlKYMhu4n1/gj0d9
         1TjxBU5O4nVFT1ikddcrYzGZ55h/hVIr4rQws6yNoehya20EIeOGWhPPzUpR1bL+Nv
         XQ6Bz+csenJuw==
Date:   Thu, 17 Feb 2022 10:41:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um: Allow builds with Clang
Message-ID: <Yg6I0YZAh5yWYpT2@dev-arch.archlinux-ax161>
References: <20220217002843.2312603-1-keescook@chromium.org>
 <CAK7LNASMobjuAen+_O4eFOgkOoUwf5ANk6_TjL4SdtT47Jge-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASMobjuAen+_O4eFOgkOoUwf5ANk6_TjL4SdtT47Jge-w@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 17, 2022 at 01:54:58PM +0900, Masahiro Yamada wrote:
> On Thu, Feb 17, 2022 at 9:28 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Add x86-64 target for Clang+um and update user-offsets.c to use
> > Clang-friendly assembler, similar to the fix from commit cf0c3e68aa81
> > ("kbuild: fix asm-offset generation to work with clang").
> >
> > This lets me run KUnit tests with Clang:
> >
> > $ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
> > ...
> > $ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
> > ...
> >
> > Cc: Jeff Dike <jdike@addtoit.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: David Gow <davidgow@google.com>
> > Cc: linux-um@lists.infradead.org
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/um/user-offsets.c | 4 ++--
> >  scripts/Makefile.clang     | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> > index bae61554abcc..d9071827b515 100644
> > --- a/arch/x86/um/user-offsets.c
> > +++ b/arch/x86/um/user-offsets.c
> > @@ -10,10 +10,10 @@
> >  #include <asm/types.h>
> >
> >  #define DEFINE(sym, val) \
> > -       asm volatile("\n->" #sym " %0 " #val : : "i" (val))
> > +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))
> >
> >  #define DEFINE_LONGS(sym, val) \
> > -       asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
> > +       asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
> >
> >  void foo(void)
> >  {
> > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > index 51fc23e2e9e5..857b23de51c6 100644
> > --- a/scripts/Makefile.clang
> > +++ b/scripts/Makefile.clang
> > @@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc    := powerpc64le-linux-gnu
> >  CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
> >  CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
> >  CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
> > +CLANG_TARGET_FLAGS_um          := x86_64-linux-gnu
> 
> 
> Does this work for the i386 host?
> 
> UML supports i386 and x86_64 as the host architecture as of now,
> but this always compiles UML for x86_64?

I think the current code will work because arch/x86/Makefile.um includes
-m32 for CONFIG_X86_32, which will implicitly change x86_64-linux-gnu
into a 32-bit target triple:

$ echo | clang --target=x86_64-linux-gnu -x c -c -o test.o -

$ file test.o
test.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not stripped

$ echo | clang --target=x86_64-linux-gnu -m32 -x c -c -o test.o -

$ file test.o
test.o: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), not stripped

In fact, we rely on this for ARCH=i386 LLVM=1 right now, as it uses
x86_64-linux-gnu for the target flag.

While UML only supports x86, maybe it is worth using SUBARCH instead of
hardcoding the triple? No strong opinion around that though.

diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 51fc23e2e9e5..87285b76adb2 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
+CLANG_TARGET_FLAGS_um		:= $(CLANG_TARGET_FLAGS_$(SUBARCH))
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
 ifeq ($(CROSS_COMPILE),)

> >  CLANG_TARGET_FLAGS             := $(CLANG_TARGET_FLAGS_$(SRCARCH))
> >
> >  ifeq ($(CROSS_COMPILE),)
> > --
> > 2.30.2
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
