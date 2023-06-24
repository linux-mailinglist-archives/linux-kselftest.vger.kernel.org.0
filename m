Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CC73C9B4
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjFXIkE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Jun 2023 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFXIkD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Jun 2023 04:40:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E829A7;
        Sat, 24 Jun 2023 01:39:58 -0700 (PDT)
X-QQ-mid: bizesmtp78t1687595987tsorhzzw
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 24 Jun 2023 16:39:46 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: TLc+rbMvNaGs9DSb8cvqdCrX++64W7m5DDNn1sIdrs3Qs03fSQ+McuAdtM/sO
        cLayvNg3UlpGYzh6Y4amWW+Z5s3F5eQMZHBkx0ubp4FztwB6525/eGttFZFXJDQJgmAdoe4
        OUmlV/9SBNT+gpDHWEH1EypSs6ZS7BQtcUXC7MkgOO/e5eu+V/R7RZnGKOKmMZgV3WK+lT2
        /SghgtLHeAy4+tK3ueRWUcQ3DCtdkTNWDUgbJZhc0a4LwSFGZntHxpxGhiMzZs8/jjuk5DJ
        gNbJZy+BbHp3lfCMfgLQPFuRaLUAtaMQfT3rOjUigM4EnzBjlIP4YLiXXfDntRO8xsQErNl
        ueNrnRqjus6YMdUfrwiZLC3N+n2jKFjVOJXe4d4dvienfcGlGp6un5STqe8ZUyFGskypAMu
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1365809893335039169
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 00/17] selftests/nolibc: allow run with minimal kernel config
Date:   Sat, 24 Jun 2023 16:39:46 +0800
Message-Id: <20230624083946.587810-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0322e204-f3ea-4af2-a3eb-f23506b2d779@t-8ch.de>
References: <0322e204-f3ea-4af2-a3eb-f23506b2d779@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hi, Thomas
> 
> On 2023-06-23 02:45:59+0800, Zhangjin Wu wrote:
> > > some general comments for the whole series.
> > > 
> > > On 2023-06-21 20:52:30+0800, Zhangjin Wu wrote:
> > > > Hi, Willy
> > > > 
> > > > This patchset mainly allows speed up the nolibc test with a minimal
> > > > kernel config.
> > > > 

(snip)

> > Based on my local powerpc porting, I have prepared some changes like
> > this:
> > 
> >     # extra kernel configs by architecture
> >     EXTCONFIG_powerpc    = --enable SERIAL_PMACZILOG --enable CONFIG_SERIAL_PMACZILOG_CONSOLE
> >     EXTCONFIG            = --set-str CONFIG_INITRAMFS_SOURCE $(CURDIR)/initramfs $(EXTCONFIG_$(ARCH))
> > 
> >     ...
> >also  
> >     menuconfig:
> >             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig
> >     
> >     extconfig:
> >             $(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
> >             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig
> >     
> >     kernel: initramfs extconfig
> >             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
> > 
> > 
> > 'menuconfig' is added for development, for example, find why something not work
> > and add the missing options.
> > 
> > 'extconfig' is added to enable additional options (before, based on
> > defconfig) to let nolibc-test happy (for powerpc, add missing console
> > options which has been added as modules in default config).
> > 
> > Based on your suggestion, this may be a good new target:
> > 
> >     tinyconfig:
> >             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper tinyconfig prepare
> > 
> > And this one, use 'allnoconfig' instead of 'olddefconfig':
> > 
> >     extconfig:
> >             $(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
> >             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG=$(srctree)/.config allnoconfig
> > 
> > So, the new 'tinyconfig' may function as the smallest test environment,
> > for faster compile and as a boundary test of nolibc-test itself.
> > 
> > But again, still need time to list the minimally required options, if they are
> > few, listing them in the EXTCONFIG_<ARCH> line may be acceptable, but if the
> > options are 'huge', standalone nolibc.config may be required, let's wait for
> > one or two days.
> 
> FYI there are many more tests in tools/testing/selftests/ that need
> custom configs to run. Maybe we can reuse some of their configuration
> machinery.
> (And qemu machinery maybe)
>

Yeah, thanks, these files may be very good references:

    $ find tools/testing/selftests/ -name "*config" | grep qemu
    tools/testing/selftests/wireguard/qemu/arch/aarch64.config
    tools/testing/selftests/wireguard/qemu/arch/aarch64_be.config
    tools/testing/selftests/wireguard/qemu/arch/arm.config
    tools/testing/selftests/wireguard/qemu/arch/armeb.config
    tools/testing/selftests/wireguard/qemu/arch/i686.config
    tools/testing/selftests/wireguard/qemu/arch/m68k.config
    tools/testing/selftests/wireguard/qemu/arch/mips.config
    tools/testing/selftests/wireguard/qemu/arch/mips64.config
    tools/testing/selftests/wireguard/qemu/arch/mips64el.config
    tools/testing/selftests/wireguard/qemu/arch/mipsel.config
    tools/testing/selftests/wireguard/qemu/arch/powerpc.config
    tools/testing/selftests/wireguard/qemu/arch/powerpc64.config
    tools/testing/selftests/wireguard/qemu/arch/powerpc64le.config
    tools/testing/selftests/wireguard/qemu/arch/riscv32.config
    tools/testing/selftests/wireguard/qemu/arch/riscv64.config
    tools/testing/selftests/wireguard/qemu/arch/s390x.config
    tools/testing/selftests/wireguard/qemu/arch/um.config
    tools/testing/selftests/wireguard/qemu/arch/x86_64.config
    tools/testing/selftests/wireguard/qemu/debug.config
    tools/testing/selftests/wireguard/qemu/kernel.config

And I have prepared most of them, just left 2-3 architectures.

> > > And it would be interesting how much impact the enablement of procfs,
> > > tmpfs, net and memfd_create has in constrast to the minimal
> > > configuration.
> > 
(snip)
> > 
> > It did save 20s (~17.1%) for us, not too much, but really faster. 
> > 
> > > It seems unfortunate to me to complicate the testsuite to handle such
> > > uncommon scenarios.
> > 
> > Yeah, such a config is not common, but as explained above, beside the compile
> > speedup improvement, it is really a good boundary test environment for
> > nolibc-test itself to make sure it work (no failure, less skips) at an
> > extremely worst-case scene, although our changes looks many, but every one is
> > as simple as CLOC ;-)
> > 
> > And that also means, nolibc is able to run with a very 'tiny' kernel
> > config and users could reuse our config fragments and add their own for
> > their embedded devices.
> 
> It would mean that nolibc-test is able to run on *really* trimmed down
> systems, which seems of limited use.
> If the testsuite has more dependencies it would not stop nolibc itself
> to run on them.
> 
> As for the CONFIG_NET dependency, which I would guess is one of the more
> expensive configs to enable:
> 
> link_cross can be easily adapted to instead use /proc/self.
>

Yes, we can simply use /proc/self or proc/self/cmdline.

> chmod_net relies on /proc/$PID/net accepting chmod().
> It is the only file in /proc/$PID/ that works that way.
>

Something like /tmp/xxx has been used in our patchset, to get a chmodable file,
tmpfs is a good choice, even when the TMPFS (and SHMEM) option is disabled, a
ramfs based tmpfs will be provided by kernel.

> Maybe its a kernel bug anyways and we shouldn't rely on it anyways?
> I'm taking a look.
>

Good catch, I have been also interested in such a curious difference,
because all of the other proc interfaces are not chmodable, not sure if
it is 'intentional', let's discuss in your patch thread, perhaps we
should cc the /proc/self/net maintainers/authors ;-)

> > 
> > (snipped)
> > 
> > > >   It is able to build and run nolibc-test with musl libc now, but there
> > > >   are some failures/skips due to the musl its own issues/requirements:
> > > > 
> > > >     $ sudo ./nolibc-test  | grep -E 'FAIL|SKIP'
> > > >     8 sbrk = 1 ENOMEM                                               [FAIL]
> > > >     9 brk = -1 ENOMEM                                               [FAIL]
> > > >     46 limit_int_fast16_min = -2147483648                           [FAIL]
> > > >     47 limit_int_fast16_max = 2147483647                            [FAIL]
> > > >     49 limit_int_fast32_min = -2147483648                           [FAIL]
> > > >     50 limit_int_fast32_max = 2147483647                            [FAIL]
> > > >     0 -fstackprotector not supported                                [SKIPPED]
> > > > 
> > > >   musl disabled sbrk and brk for some conflicts with its malloc and the
> > > >   fast version of int types are defined in 32bit, which differs from nolibc
> > > >   and glibc. musl reserved the sbrk(0) to allow get current brk, we
> > > >   added a test for this in the v4 __sysret() helper series [2].
> > > 
> > > We could add new macros
> > > 
> > > #define UINT_MAX(t) (~(t)0)
> > > #define SINT_MAX(t) (((t)1 << (sizeof(t) * 8 - 2)) - (t)1 + ((t)1 << (sizeof(t) * 8 - 2)))
> > > 
> > > to get whatever is appropriate for the respective type.
> > >
> > 
> > They work perfectly, thanks:
> > 
> >     /* for fast int test cases in stdlib test, musl use 32bit fast int */
> >     #undef UINT_MAX
> >     #define UINT_MAX(t)    (~(t)0)
> >     #undef SINT_MAX
> >     #define SINT_MAX(t)    (((t)1 << (sizeof(t) * 8 - 2)) - (t)1 + ((t)1 << (sizeof(t) * 8 - 2)))
> >     #undef SINT_MIN
> >     #define SINT_MIN(t)    (-SINT_MAX(t) - 1)
> > 
> >     ...
> > 
> >     CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,   (int_fast16_t)    SINT_MIN(int_fast16_t)); break;
> >     CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,   (int_fast16_t)    SINT_MAX(int_fast16_t)); break;
> >     CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX,  (uint_fast16_t)   UINT_MAX(uint_fast16_t)); break;
> >     CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    SINT_MIN(int_fast32_t)); break;
> >     CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    SINT_MAX(int_fast32_t)); break;
> >     CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINT_MAX(uint_fast32_t)); break;
> > 
> > To avoid overriding the existing macros, perhaps we should add something
> > like UINT_TYPE_MAX(t), SINT_TYPE_MAX(t) and SINT_TYPE_MIN(t) ?
> 
> They should only be visible inside nolibc-test.c I think.

Yeah, I did so.

> But yes the UINT_MAX naming is bad.
>
> Also when going away from testing constants maybe we can get back some
> test strength by validating the sizeof() of the datatypes.
>

It seems easier.

> <snip>
> 
> > > > 
> > > > * selftests/nolibc: vfprintf: silence memfd_create() warning
> > > >   selftests/nolibc: vfprintf: skip if neither tmpfs nor hugetlbfs
> > > >   selftests/nolibc: vfprintf: support tmpfs and hugetlbfs
> > > > 
> > > >   memfd_create from kernel >= v6.2 forcely warn on missing
> > > >   MFD_NOEXEC_SEAL flag, the first one silence it with such flag, for
> > > >   older kernels, use 0 flag as before.
> > > 
> > > Given this is only a problem when nolibc-test is PID1 and printing to
> > > the system console, we could also just disable warnings on the system
> > > console through syscall() or /proc/sys/kernel/printk.
> > 
> > Ok, I did think about disabling console for this call, but I was worried about
> > the requirement of root (euid0) to do so, limiting it under PID1 may solve the
> > root permission issue, but still need to find the right syscall to avoid the
> > dependency of /proc/sys/kernel/printk, otherwise, to avoid failure for !procfs,
> > the whole vfprintf will be skipped for such a warning, to be honest, it looks
> > not a good direction.
> 
> This should work:
> 
> syslog(__NR_syslog, 6 /* SYSLOG_ACTION_CONSOLE_OFF */);
>

Thanks, will try it like this:

    syslog(__NR_syslog, 6 /* SYSLOG_ACTION_CONSOLE_OFF */);
    memfd_create()
    syslog(__NR_syslog, 7 /* SYSLOG_ACTION_CONSOLE_ON */);

Putting it in prepare() may hide potential issues reported by kernel.

> > > 
> > > It would also avoid cluttering the tests for limited gain.
> > >
> > 
> > Hmm, if consider the more code lines about disabling/enabling console and the
> > dependency of /proc/sys/kernel/printk, I do prefer current change.
> 
> It should really only be the single line above.
> 
> > But I'm also interested in how the other applications developers to treat this
> > warning, from the new kernel version side, we should use the latest non
> > executable flags for security, but to let applications work with old kernels,
> > we must support old flags, checking the kernel versions may be another choice. 
> 
> I know that systemd does it the same way as you proposed it, with
> non-negligible code overhead.
> 
> But for nolibc-test I really don't see any security issue.
>

Yes, but at least as a good reference when people want to reuse some
codes from nolibc-test.c ;-)

> > Perhaps it's time for us to add the 'uname()' for nolibc, but the
> > version comparing may be not that easy when we are in c context ;-)
> > 
> >   https://www.man7.org/linux/man-pages/man2/uname.2.html
> 
> Please no :-)
> 
> > So, the current method may be still a 'balanced' solution, it tries supported
> > flags from new kernel to old kernel to get a better and working memfd_create()
> > without the version checking, is this cleaner?
> > 
> > 	int i;
> > 	/* kernel >= v6.2 require MFD_NOEXEC_SEAL (0x0008U), but older ones not support this flag */
> 
> It is not required, only desired. The functionality still works as
> expected. I don't think the "old" way can ever stop working as it would
> break userspace ABI.
> 
> > 	unsigned int flags[2] = {0x0008U, 0};
> > 
> > 	for (i = 0; i < 2; i ++) {
> 
> Loops like this should use ARRAY_SIZE() to calculate the termination
> condition.

Yeah, it should be:

    unsigned int flags[] = {0x0008U, 0};
   
    for (i = 0; i < sizeof(flags)/sizeof(flags[0]); i ++)
	    ...

Best regards,
Zhangjin

> 
> > 		/* try supported flags from new kernels to old kernels */
> > 		fd = memfd_create("vfprintf", flags[i]);
> > 		if (fd != -1)
> > 			break;
> > 	}
> > 
> > 	if (fd == -1) {
> > 		...
> > 	}
> 
> <snip>
> 
> 
> Thomas
