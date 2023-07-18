Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD39B758335
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjGRREy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 13:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjGRRDk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 13:03:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E531FF5;
        Tue, 18 Jul 2023 10:03:03 -0700 (PDT)
X-QQ-mid: bizesmtp76t1689699719tn30wwui
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 01:01:57 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: TXoNPSSaW4k3TYo/907NMGUmPQ0LS9KHCkNksMrpIgyV+2rw8GfsAWQkEToWA
        KKlNUju2LGCRxLi4wnpIrRzO1C88BKa7K7r9J09BQeDnvWvs9k4yMQNJGYfxm61QOUJUC7a
        hI+2dZIDzE+tF5s7oGLIG4ubOOyIuIYnnwoXb74f4JeafCE2WyJAcH7Eu5v2kmtlYAhCsOH
        uZgZrbkhdJNWkgPiL9QE80BVm1DhF6YuwlLUTqzsioHhhU4mjhPhp7xviP9CcY6HVqiKx6H
        KPfIVxyGlED/UKKv9jXKKLtzkASD8CYgFsGFOnlWw7F/kb6tvr/sr5THgRRaGFUylNyWm1a
        cCuP5RyUPnX1u+2mq60rx6LdEWOwQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4518450584097450988
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 00/22] selftests/nolibc: add minimal kernel config support
Date:   Wed, 19 Jul 2023 01:01:53 +0800
Message-Id: <20230718170153.35765-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de>
References: <67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de>
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

Hi, Thomas

> On 2023-07-18 21:43:23+0800, Zhangjin Wu wrote:
> > Hi, Willy, Thomas
> > 
> > I have prepared the powerpc + powerpc64 support together with the
> > tinyconfig for them, still have some questions for more discussion.
> > 
> > > On Wed, Jul 12, 2023 at 01:18:26AM +0800, Zhangjin Wu wrote:
> > [...]
> > > 
> > > Reading the beginning of the sentence made me immediately think that it's
> > > what doc is for. You know, if you give a fish to a hungry man he eats one
> > > day, if you teach him to fish he eats every day. Knowing what to download
> > > from where is much more instructive than running "make download" or even
> > > worse, "make" and having the downloads secretly succeed (or fail). If you
> > > think the doc is hard to find I'm also fine with a patch for makefile
> > > and/or nolibc-test passing a pointer to its location as a reminding
> > > comment for example.
> > >
> > 
> > The whole tinyconfig support for every architecture is 'huge', I plan to
> > send them one by one, if required, will document them with the required
> > bios and/or toolchain.
> 
> Which part is huge?

Actually, we only need to add ~30 lines for all of them ;-)

But some architectures require extra operations, for example,

- x86 requires extra "tsc=unstable noapic" kernel cmdline to save the
  CONFIG_ACPI options, if we only reserve tinyconfig target, it is ok to
  add it directly to the original QEMU_ARGS_<ARCH>

- x86 and some other architectures may fail to poweroff due to save some
  time-cost options or due to missing kernel poweroff support, they
  require qemu-poweroff timeout support

- some architectures have no built-in firmware for qemu, we need to
  document them carefully

- some architectures have no available toolchain in any Linux
  distributions, we need to document them carefully

...

> This is surprising.
>

For one architecture, it is not that hard, but for all of the supported
architectures, weird bugs came out one by one ;-)

> > The first architectures plan to support are powerpc + powerpc64, powerpc does
> > require extra kernel config options even with defconfig, so, it is a very good
> > first example, and the extconfig target will be added together.
> 
> Are you planning to do powerpc and tinyconfig support in one series?
> Splitting it would be better in my opinion.
>

Ok, as Willy replied in another thread, let's add powerpc support with
defconfig as the first patchset.

Since, even with defconfig, we still need extra console options to make
the test print normally, so, the extra options support code will be
added anyway, adding tinyconfig support is a fastforward step.

> > The left question from me is that if is it ok to just use tinyconfig instead of
> > defconfig after we enable tinyconfig for a new architecture, I mean just add a
> > new DEFCONFIG_<ARCH>=tinyconfig line for the new architecture, don't use the
> > 'defconfig' any more, let's take a look at the powerpc/powerpc64 lines below:
> > 
> >     # default kernel configurations that appear to be usable
> >     DEFCONFIG_i386       = defconfig
> >     DEFCONFIG_x86_64     = defconfig
> >     DEFCONFIG_x86        = defconfig
> >     DEFCONFIG_arm64      = defconfig
> >     DEFCONFIG_arm        = multi_v7_defconfig
> >     DEFCONFIG_mips       = malta_defconfig
> >     DEFCONFIG_powerpc    = tinyconfig
> >     DEFCONFIG_powerpc64  = tinyconfig
> >     DEFCONFIG_riscv      = defconfig
> >     DEFCONFIG_s390       = defconfig
> >     DEFCONFIG_loongarch  = defconfig
> >     DEFCONFIG            = $(DEFCONFIG_$(XARCH))
> > 
> > Of course, we need to customize the EXTCONFIG for them (about ~5 options for
> > all of the architectures):
> > 
> >     # extra kernel configs by architecture
> >     EXTCONFIG_powerpc    = $(addprefix -e ,COMPAT_32BIT_TIME PPC_PMAC PPC_OF_BOOT_TRAMPOLINE SERIAL_PMACZILOG SERIAL_PMACZILOG_TTYS SERIAL_PMACZILOG_CONSOLE)
> >     EXTCONFIG_powerpc64  = $(addprefix -e ,PPC64 CPU_LITTLE_ENDIAN PPC_POWERNV HVC_OPAL)
> >     EXTCONFIG_XARCH      = $(EXTCONFIG_$(XARCH))
> 
> These could also be put into dedicated config files. Then they don't
> clutter the makefile and it's easier to maintain.
> 
> nolibc.config:       Generic configs on top of tinyconfig
> nolibc.arm64.config: Arch-specific configs for arm64
>

Thanks, xxx.config files should work well with the merge tool:
scripts/kconfig/merge_config.sh.

Since in all of the supported architectures, the maximum extra options
required by tinyconfig is 8, the others is around 5 options (some even
less), all of them can be put in one line, at the same time, the
initramfs source can use the same EXTCONFIG_COMMON logic, so, the
oneline EXTCONFIG_<ARCH> is used without any new files.

Will take a look at the xxx.config files method.

But unfortunately, powerpc defconfig doesn't print by default, it also
require extra console options, to apply the xxx.config files method, we
need wait more time to restruct the powerpc support.

> Also the extra parameter could also be passed via command line arguments to make.
> This way we don't have to modify the configuration options at all.
> The user can provide a config (or we use a tinyconfig) and everything
> required by nolibc-test is enabled on top when building.
> 
> make CONFIG_COMPAT_32BIT_TIME=y ...
>

This doesn't work sometimes especially when we want to disable an
option, that's why we eventually use scripts/config instead.

> tools/testing/selftests/wireguard/qemu/ seems to be doing something
> similar as nolibc-test.
> 
> > The extra common options (based on default kernel tinyconfig) are also required
> > to make nolibc-test.c passes without failures (~2 skips are procfs related, so,
> > procfs is not added) are minimal:
> > 
> >     # extra kernel configs shared among architectures
> >     EXTCONFIG_COMMON     = -e BLK_DEV_INITRD --set-str INITRAMFS_SOURCE $(CURDIR)/initramfs
> >     EXTCONFIG_COMMON    += -e BINFMT_ELF
> >     EXTCONFIG_COMMON    += -e PRINTK -e TTY
> > 
> > Compare to defconfig, tinyconfig not only allows test all of the nolibc
> > functions, but also is faster (around ~1-2 minutes, defconfig may cost ~30
> > minutes and even more) and brings us with smaller image size.
> > 
> > To only test nolibc itself, I do think tinyconfig with the above
> > extconfig support is enough, even if we need more, we can update the
> > EXTCONFIG_COMMON and EXTCONFIG_<ARCH> in the future.
> 
> IMO tinyconfig is enough, defconfig doesn't seem to be necessary then.
>

As Willy replied in another thread, tinyconfig may fail sometimes
because many developers only use defconfig for tests, I did find
tinyconfig fail on powerpc [1] and riscv64 [2], although later, both of
them have been fixed.

I reported the 2nd one, the 1st one has just been fixed up by somebody
else before I plan to send the patch, so, our nolibc tinyconfig support
may function as a very good coverage test for kernel ;-)

[1]: https://lore.kernel.org/lkml/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid/
[2]: https://lore.kernel.org/linux-riscv/20230716001506.3506041-1-guoren@kernel.org/

> > I have prepared tinyconfig for all of the supported architectures
> > locally, If you agree with only reserve the DEFCONFIG_<ARCH>=tinyconfig
> > line, I will send a series of patchset to add tinyconfig for every
> > architecture with it, at last, it will become:
> > 
> >     # default kernel configurations that appear to be usable
> >     DEFCONFIG_i386       = tinyconfig
> >     DEFCONFIG_x86_64     = tinyconfig
> >     DEFCONFIG_x86        = tinyconfig
> >     DEFCONFIG_arm64      = tinyconfig
> >     DEFCONFIG_arm        = tinyconfig
> >     DEFCONFIG_mips       = tinyconfig
> >     DEFCONFIG_powerpc    = tinyconfig
> >     DEFCONFIG_powerpc64  = tinyconfig
> >     DEFCONFIG_riscv      = tinyconfig
> >     DEFCONFIG_s390       = tinyconfig
> >     DEFCONFIG_loongarch  = tinyconfig
> >     DEFCONFIG            = $(DEFCONFIG_$(XARCH))
> > 
> > So, perhaps it is better to simply use tinyconfig as the default DEFCONFIG, and
> > therefore there is no need to add powerpc and powerpc64 specific lines:
> > 
> >     # default kernel configurations that appear to be usable
> >     DEFCONFIG_i386       = defconfig
> >     DEFCONFIG_x86_64     = defconfig
> >     DEFCONFIG_x86        = defconfig
> >     DEFCONFIG_arm64      = defconfig
> >     DEFCONFIG_arm        = multi_v7_defconfig
> >     DEFCONFIG_mips       = malta_defconfig
> >     DEFCONFIG_riscv      = defconfig
> >     DEFCONFIG_s390       = defconfig
> >     DEFCONFIG_loongarch  = defconfig
> >     DEFCONFIG            = $(or $(DEFCONFIG_$(XARCH)),tinyconfig)
> > 
> > To support tinyconfig for a new architecture, we can simply remove the
> > 'DEFCONFIG_<ARCH> = defconfig' line and get the core options from
> > defconfig to customize the EXTCONFIG_ARCH, with tinyconfig, it is very
> > fast and easy to verify the run target for a new architecture.
> > 
> > At last, we will have many EXTCONFIG_<ARCH> lines and only a DEFCONFIG line:
> > 
> >     # default kernel configurations that appear to be usable
> >     DEFCONFIG            = $(or $(DEFCONFIG_$(XARCH)),tinyconfig)
> > 
> > Or at last, we remove the above line and the defconfig target and only reserve
> > a tinyconfig target:
> > 
> >     tinyconfig:
> > 	$(Q)$(MAKE_KERNEL) tinyconfig prepare
> > 
> > Welcome your suggestion.
> 
> Looks fine to me either way.

Ok, so, let's reserve defconfig as a backup although tinyconfig should
work at most of the time.

Best regards,
Zhangjin

