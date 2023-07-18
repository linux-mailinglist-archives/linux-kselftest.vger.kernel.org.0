Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270AF757DFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjGRNnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 09:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGRNnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 09:43:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310FC97;
        Tue, 18 Jul 2023 06:43:37 -0700 (PDT)
X-QQ-mid: bizesmtp81t1689687805tvcj837v
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 18 Jul 2023 21:43:24 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: +ynUkgUhZJmP6GIH9v27vQNi3ywjIdeDMafpl8K3QN7RGXWVJTAKsC1eXCsch
        AYNh5JIRBH8MO+B1KHZiDMCxTughmwEaA0+iD4G1izvnT1paIPx1UktKtAWfWP+Zn1idP5S
        wCIocmEzVtQhE9nl5eBjsn8hGBD2rFcdR1/xdNP9Jf9cHpJ3rACgIrsPS6Q2TaNUaTDgUVf
        FLRMTGLKk/Q70SGWiRM3w7R8z/h6/td/Wmtsz3IpytVB2OWrM3Qz39lCv9ebAQdMlE9USQ6
        96OYuM81rkEmUJUB9d7XDJNr/4CY0vbn4ph5Lrkayx5H59TPxw2OEIaLNdrP/yBiCd7XAvL
        CnPvRZIQvwUGFEVwIlNlGTm265bdswU9SCadutN
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1886380261566681816
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 00/22] selftests/nolibc: add minimal kernel config support
Date:   Tue, 18 Jul 2023 21:43:23 +0800
Message-Id: <20230718134323.14819-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711193608.GD31402@1wt.eu>
References: <20230711193608.GD31402@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

I have prepared the powerpc + powerpc64 support together with the
tinyconfig for them, still have some questions for more discussion.

> On Wed, Jul 12, 2023 at 01:18:26AM +0800, Zhangjin Wu wrote:
[...]
> 
> Reading the beginning of the sentence made me immediately think that it's
> what doc is for. You know, if you give a fish to a hungry man he eats one
> day, if you teach him to fish he eats every day. Knowing what to download
> from where is much more instructive than running "make download" or even
> worse, "make" and having the downloads secretly succeed (or fail). If you
> think the doc is hard to find I'm also fine with a patch for makefile
> and/or nolibc-test passing a pointer to its location as a reminding
> comment for example.
>

The whole tinyconfig support for every architecture is 'huge', I plan to
send them one by one, if required, will document them with the required
bios and/or toolchain.

The first architectures plan to support are powerpc + powerpc64, powerpc does
require extra kernel config options even with defconfig, so, it is a very good
first example, and the extconfig target will be added together.

The left question from me is that if is it ok to just use tinyconfig instead of
defconfig after we enable tinyconfig for a new architecture, I mean just add a
new DEFCONFIG_<ARCH>=tinyconfig line for the new architecture, don't use the
'defconfig' any more, let's take a look at the powerpc/powerpc64 lines below:

    # default kernel configurations that appear to be usable
    DEFCONFIG_i386       = defconfig
    DEFCONFIG_x86_64     = defconfig
    DEFCONFIG_x86        = defconfig
    DEFCONFIG_arm64      = defconfig
    DEFCONFIG_arm        = multi_v7_defconfig
    DEFCONFIG_mips       = malta_defconfig
    DEFCONFIG_powerpc    = tinyconfig
    DEFCONFIG_powerpc64  = tinyconfig
    DEFCONFIG_riscv      = defconfig
    DEFCONFIG_s390       = defconfig
    DEFCONFIG_loongarch  = defconfig
    DEFCONFIG            = $(DEFCONFIG_$(XARCH))

Of course, we need to customize the EXTCONFIG for them (about ~5 options for
all of the architectures):

    # extra kernel configs by architecture
    EXTCONFIG_powerpc    = $(addprefix -e ,COMPAT_32BIT_TIME PPC_PMAC PPC_OF_BOOT_TRAMPOLINE SERIAL_PMACZILOG SERIAL_PMACZILOG_TTYS SERIAL_PMACZILOG_CONSOLE)
    EXTCONFIG_powerpc64  = $(addprefix -e ,PPC64 CPU_LITTLE_ENDIAN PPC_POWERNV HVC_OPAL)
    EXTCONFIG_XARCH      = $(EXTCONFIG_$(XARCH))

The extra common options (based on default kernel tinyconfig) are also required
to make nolibc-test.c passes without failures (~2 skips are procfs related, so,
procfs is not added) are minimal:

    # extra kernel configs shared among architectures
    EXTCONFIG_COMMON     = -e BLK_DEV_INITRD --set-str INITRAMFS_SOURCE $(CURDIR)/initramfs
    EXTCONFIG_COMMON    += -e BINFMT_ELF
    EXTCONFIG_COMMON    += -e PRINTK -e TTY

Compare to defconfig, tinyconfig not only allows test all of the nolibc
functions, but also is faster (around ~1-2 minutes, defconfig may cost ~30
minutes and even more) and brings us with smaller image size.

To only test nolibc itself, I do think tinyconfig with the above
extconfig support is enough, even if we need more, we can update the
EXTCONFIG_COMMON and EXTCONFIG_<ARCH> in the future.

I have prepared tinyconfig for all of the supported architectures
locally, If you agree with only reserve the DEFCONFIG_<ARCH>=tinyconfig
line, I will send a series of patchset to add tinyconfig for every
architecture with it, at last, it will become:

    # default kernel configurations that appear to be usable
    DEFCONFIG_i386       = tinyconfig
    DEFCONFIG_x86_64     = tinyconfig
    DEFCONFIG_x86        = tinyconfig
    DEFCONFIG_arm64      = tinyconfig
    DEFCONFIG_arm        = tinyconfig
    DEFCONFIG_mips       = tinyconfig
    DEFCONFIG_powerpc    = tinyconfig
    DEFCONFIG_powerpc64  = tinyconfig
    DEFCONFIG_riscv      = tinyconfig
    DEFCONFIG_s390       = tinyconfig
    DEFCONFIG_loongarch  = tinyconfig
    DEFCONFIG            = $(DEFCONFIG_$(XARCH))

So, perhaps it is better to simply use tinyconfig as the default DEFCONFIG, and
therefore there is no need to add powerpc and powerpc64 specific lines:

    # default kernel configurations that appear to be usable
    DEFCONFIG_i386       = defconfig
    DEFCONFIG_x86_64     = defconfig
    DEFCONFIG_x86        = defconfig
    DEFCONFIG_arm64      = defconfig
    DEFCONFIG_arm        = multi_v7_defconfig
    DEFCONFIG_mips       = malta_defconfig
    DEFCONFIG_riscv      = defconfig
    DEFCONFIG_s390       = defconfig
    DEFCONFIG_loongarch  = defconfig
    DEFCONFIG            = $(or $(DEFCONFIG_$(XARCH)),tinyconfig)

To support tinyconfig for a new architecture, we can simply remove the
'DEFCONFIG_<ARCH> = defconfig' line and get the core options from
defconfig to customize the EXTCONFIG_ARCH, with tinyconfig, it is very
fast and easy to verify the run target for a new architecture.

At last, we will have many EXTCONFIG_<ARCH> lines and only a DEFCONFIG line:

    # default kernel configurations that appear to be usable
    DEFCONFIG            = $(or $(DEFCONFIG_$(XARCH)),tinyconfig)

Or at last, we remove the above line and the defconfig target and only reserve
a tinyconfig target:

    tinyconfig:
	$(Q)$(MAKE_KERNEL) tinyconfig prepare

Welcome your suggestion.

> > > And I think that helping the user
> > > prepare certain steps or iterate over architectures *is* useful. When
> > > you do it in two layers (the script replacing the user, the makefile
> > > doing the build job), it remains easy and convenient to use, and you
> > > can pick only what you need (e.g. "please build musl for me"). And if
> > > something goes wrong, it's simple for the user to takeover and complete
> > > that failed task by changing an arch name, a directory or anything, and
> > > have their tools ready. Let's just never make that automatic for the
> > > sake of everyone's health!
> > 
> > Ok, the revision will align with the original Makefile and remove the automatic
> > parts and no change about the OUTPUT.
> 
> Just check that you can force it from your script on the make command
> line. If you see that it's not possible, we should do something because
> I don't want to force you to make distclean all the time if not needed.
> But if you find that passing certain options (O=, OUTPUT= or anything
> else) does the job, it only needs to be documented.

Yeah, I have used objtree intead of srctree to fix up the O= argument
support, it fills my requirement to build kernel for every architecture
in their own output directory.

Best regards,
Zhangjin

> 
> Thanks,
> Willy
