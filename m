Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBEC712350
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjEZJUp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEZJUm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 05:20:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AC712C;
        Fri, 26 May 2023 02:20:37 -0700 (PDT)
X-QQ-mid: bizesmtp86t1685092831tk05nm7x
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 26 May 2023 17:20:29 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: zT6n3Y95oi0OOe4oJd0XTOvYouL6ztJewAQudbeCnuvGUqGMwtkEls6aRow1/
        ms+/LDOG+HSUkm3CofTvcxZW9agcv2QpPYkesok5ytX+mMkzTNYOWph+Tug9f5Ve/1vMj6B
        lCeGH3TiqlibPxr1zZ1T3DKMMGunN4gb7kzyeS/j++fdcIdWcklxYQYDsI0m/evq1R3yWPg
        bggTVATzd91+1w+JIhvouBDtJkIZk1DaqenI6vR0ceth2IszRufH1fKmNSrAx9DSusew1z/
        fSc8UzNLK3OvoImtSJi6gir1cH/KtJk3R1ghbaqeBGAW+6DZZjwzmBoq/UJCrIQWl7LOutI
        DAoea1W7yHgSLY5tVI3bemgDZklKWHKGlMLcdlR3ZciTI9ovPw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13601143619123755579
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, w@1wt.eu
Subject: Re: [PATCH 05/13] selftests/nolibc: riscv: customize makefile for rv32
Date:   Fri, 26 May 2023 17:20:29 +0800
Message-Id: <20230526092029.149351-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4a3b1cdf-91d5-4668-925e-21f8f5c64a92@t-8ch.de>
References: <4a3b1cdf-91d5-4668-925e-21f8f5c64a92@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-05-25 01:50:57+0800, Zhangjin Wu wrote:
> > both riscv64 and riscv32 have the same ARCH value, it is riscv, the
> > default defconfig enables 64bit, to support riscv32, let's allow pass
> > "ARCH=riscv32" or "ARCH=riscv CONFIG_32BIT=1" to customize riscv32
> > setting.
> 
> What's the advantage of doing CONFIG_32BIT? For i386/x86_64, arm/arm64
> it's not necessary either.
> (Let's ignore the "x86" case)
>

Very good question, thanks.

This requirement may happen on mips, loongarch and even powerpc too, both x86
and arm are just the 'exception'.

It is 'designed' as a temp flag/variable to specifiy that current arch is
riscv32, not riscv64, of course, we can use something like this or even
use a meaningless 't' variable:

    # Allow pass ARCH=riscv|riscv32|riscv64, riscv implies riscv64
    ifneq ($(findstring xriscv,x$(ARCH)),)
      riscv32 := $(if $(findstring riscv32x,$(ARCH)x),1)
      override ARCH := riscv
    endif

Using CONFIG_32BIT instead of riscv32 has some extra considerations:

* Using it in command line is a 'side effect', if it is a meaningless
  variable, we will not use it for we can not remember it, here use it as a
  choice, riscv32 is enough, we can simply remove this comment from the
  commit message.

* The architectures like riscv, mips, loongarch share the same source code tree
  between 32bit and 64bit and even 128bit in the future, x86 and arm just not
  do so.

  The ARCH specified here differs from the one to kernel make, we should
  provide a flag/variable or anther ARCH variant to show the
  difference, _ARCH or XARCH have been used in my local patch.

  CONFIG_32BIT is meaningful to reflect the difference, even for future,
  we can use the same thing CONFIG_64BIT, CONFIG_128BIT, so simply
  BITS=32, BITS=64, BITS=128, but that is hard to be used as a oneline
  condition statement (although we can use something like findstring).

      $(if $(findstring x32y,x$(BITS)y),something whatevever)

      v.s.

      $(if $(CONFIG_32BIT),something whatevever)

  If not use a tmp flag/variable, this works too, but duplicated :-)

      $(if $(findstring xriscv32y,x$(ARCH)y),something whatevever)

* We are able to auto detect this config from include/config/auto.conf,
  there will be something like CONFIG_32BIT=y there.

  we did use such auto detect logic in my local patch, but it has some
  issues if we want a riscv64 build after we did a riscv32 config if we
  only pass ARCH=riscv, so, I just removed that logic but reserved the
  pontential for future.

> If for riscv the "normal" version is riscv64 then adding a new "riscv32" that
> works the same as the other architectures seems nicer and easier.
> 

The complexity here is what just explained above: The ARCH specified
here differs from the one to kernel make.

It is ok to add riscv32 like the other architectures as following:

    ifeq ($(ARCH),riscv32)
      _ARCH := riscv
    else
      _ARCH := $(ARCH)
    endif

    IMAGE_riscv32 = arch/riscv/boot/Image
    DEFCONFIG_riscv32 = rv32_defconfig
    QEMU_ARCH_riscv32 = riscv32
    QEMU_ARGS_riscv32 = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
    CFLAGS_riscv32 = -march=rv32im -mabi=ilp32

And all of the other 'ARCH' variables passed to kernel 'make' should be
changed to $(_ARCH), include most of the core targets, like:

    sysroot/$(ARCH)/include:
	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
	$(QUIET_MKDIR)mkdir -p sysroot
	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(_ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
	$(Q)mv sysroot/sysroot sysroot/$(ARCH)

    defconfig:
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(_ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
    
    kernel: initramfs
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(_ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
    
It is not that easier, it touched more source code and make things a
little complex, we must mixes the using of ARCH and _ARCH in the whole
Makefile and that is not comfortable and may introduce more complexity,
for example, we may be worry about if the directories should be named
with the new $(_ARCH) ;-)

And CONFIG_32BIT variable is better than riscv32, because, we can share this
meaningful variable among mips, loongarch in the future if their maintainers
want to add more variants support for such platforms, they will meet the same
requirement.

Thanks very much.

Best regards,
Zhangjin
