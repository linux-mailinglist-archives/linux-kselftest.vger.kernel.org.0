Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE173C72E
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFXGxO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Jun 2023 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFXGxN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Jun 2023 02:53:13 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481B271F;
        Fri, 23 Jun 2023 23:53:08 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:52:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687589575; bh=bm8xCN082F4FVfHB/SdddAgV5v8yg9Co7cfhUtYhAqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRU02govrj+vUJQAP7xNmZFNFTQte7llehMXmzVZqu9SxYPijGfd2DBpYAslJyzVP
         IpHNd/pfSp+ycnIBs2XzZY+r472BnDkhRorD6n3cmq+IjNHZ9HYm679fzkxhUcte56
         HPxqA9R8PJIb6/u6SCSW0/JcUytfBqdHfjWOebc0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 00/17] selftests/nolibc: allow run with minimal kernel
 config
Message-ID: <0322e204-f3ea-4af2-a3eb-f23506b2d779@t-8ch.de>
References: <bc635c4f-67fe-4e86-bfdf-bcb4879b928d@t-8ch.de>
 <20230622184559.1188894-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622184559.1188894-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-23 02:45:59+0800, Zhangjin Wu wrote:
> > some general comments for the whole series.
> > 
> > On 2023-06-21 20:52:30+0800, Zhangjin Wu wrote:
> > > Hi, Willy
> > > 
> > > This patchset mainly allows speed up the nolibc test with a minimal
> > > kernel config.
> > > 
> > > As the nolibc supported architectures become more and more, the 'run'
> > > test with DEFCONFIG may cost several hours, which is not friendly to
> > > develop testing and even for release testing, so, smaller kernel configs
> > > may be required, and firstly, we should let nolibc-test work with less
> > > kernel config options, this patchset aims to this goal.
> > > 
> > > This patchset mainly remove the dependency from procfs, tmpfs, net and
> > > memfd_create, many failures have been fixed up.
> > > 
> > > When CONFIG_TMPFS and CONFIG_SHMEM are disabled, kernel will provide a
> > > ramfs based tmpfs (mm/shmem.c), it will be used as a choice to fix up
> > > some failures and also allow skip less tests.
> > 
> > Did you look into how much this duplicates from the kernels already
> > existing "tinyconfig" and "kvm_guest.config" functionality?
> >
> 
> Very good question and suggestion, thanks. it is just between tinyconfig
> and kvm_guest.config, the former is not enough, the later provides more.
> tinyconfig may be a very good base for us.
> 
> Just tested some architectures, based on tinyconfig, seems we only need
> to enable very few options, for example, TTY, PRINTK, CONSOLE related
> and target virtual board related options, but it requires more time to
> just list the required options.
> 
> The 'minimal' ones I have prepared were shrunk from the 'defconfig', now
> we need to add options from 'tinyconfig', with allnoconfig, it should be
> smaller and therefore faster ;-)
> 
> Based on my local powerpc porting, I have prepared some changes like
> this:
> 
>     # extra kernel configs by architecture
>     EXTCONFIG_powerpc    = --enable SERIAL_PMACZILOG --enable CONFIG_SERIAL_PMACZILOG_CONSOLE
>     EXTCONFIG            = --set-str CONFIG_INITRAMFS_SOURCE $(CURDIR)/initramfs $(EXTCONFIG_$(ARCH))
> 
>     ...
>also  
>     menuconfig:
>             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig
>     
>     extconfig:
>             $(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
>             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig
>     
>     kernel: initramfs extconfig
>             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
> 
> 
> 'menuconfig' is added for development, for example, find why something not work
> and add the missing options.
> 
> 'extconfig' is added to enable additional options (before, based on
> defconfig) to let nolibc-test happy (for powerpc, add missing console
> options which has been added as modules in default config).
> 
> Based on your suggestion, this may be a good new target:
> 
>     tinyconfig:
>             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper tinyconfig prepare
> 
> And this one, use 'allnoconfig' instead of 'olddefconfig':
> 
>     extconfig:
>             $(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
>             $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG=$(srctree)/.config allnoconfig
> 
> So, the new 'tinyconfig' may function as the smallest test environment,
> for faster compile and as a boundary test of nolibc-test itself.
> 
> But again, still need time to list the minimally required options, if they are
> few, listing them in the EXTCONFIG_<ARCH> line may be acceptable, but if the
> options are 'huge', standalone nolibc.config may be required, let's wait for
> one or two days.

FYI there are many more tests in tools/testing/selftests/ that need
custom configs to run. Maybe we can reuse some of their configuration
machinery.
(And qemu machinery maybe)

> > And it would be interesting how much impact the enablement of procfs,
> > tmpfs, net and memfd_create has in constrast to the minimal
> > configuration.
> 
> For the test speed (mainly kernel compile) itself, when for one architecture on
> a very good test host, the time cost increment is very little (see below), but it
> does save some, especially when for lots of architectures ;-)
> 
> Comparing the rv64 testing speed on a Ubuntu 20.04 over '4G Mem + 4 Cores of
> i7-8550U CPU @ 1.80GHz' Virtual Machne, this time include:
> 
> * nolibc-test sysroot install + build
> * kernel config + build
> * qemu boot with opensbi + u-boot + kernel v6.4-rcx
> 
> Testing results:
> 
>   'minimal':
> 
>       arch/board | result
>      ------------|------------
>     riscv64/virt | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
>     
>     LOG: see all results for all boards in /labs/linux-lab/logging/nolibc/nolibc-test.log
>     
>     
>     real	1m57.395s
>     user	4m50.002s
>     sys	1m0.866s
> 
>   'minimal' + procfs, net, shmem/tmpfs, devtmpfs/devmtmpfs_mount ...:
> 
>       arch/board | result
>      ------------|------------
>     riscv64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
>     
>     LOG: see all results for all boards in /labs/linux-lab/logging/nolibc/nolibc-test.log
>     
>     
>     real	2m17.812s
>     user	6m4.695s
>     sys	1m7.061s
> 
> It did save 20s (~17.1%) for us, not too much, but really faster. 
> 
> > It seems unfortunate to me to complicate the testsuite to handle such
> > uncommon scenarios.
> 
> Yeah, such a config is not common, but as explained above, beside the compile
> speedup improvement, it is really a good boundary test environment for
> nolibc-test itself to make sure it work (no failure, less skips) at an
> extremely worst-case scene, although our changes looks many, but every one is
> as simple as CLOC ;-)
> 
> And that also means, nolibc is able to run with a very 'tiny' kernel
> config and users could reuse our config fragments and add their own for
> their embedded devices.

It would mean that nolibc-test is able to run on *really* trimmed down
systems, which seems of limited use.
If the testsuite has more dependencies it would not stop nolibc itself
to run on them.

As for the CONFIG_NET dependency, which I would guess is one of the more
expensive configs to enable:

link_cross can be easily adapted to instead use /proc/self.

chmod_net relies on /proc/$PID/net accepting chmod().
It is the only file in /proc/$PID/ that works that way.

Maybe its a kernel bug anyways and we shouldn't rely on it anyways?
I'm taking a look.

> > > Besides, it also adds musl support, improves glibc support and fixes up
> > > a kernel cmdline passing use case.
> > > 
> > > This is based on the dev.2023.06.14a branch of linux-rcu [1], all of the
> > > supported architectures are tested (with local minimal configs, [5]
> > > pasted the one for i386) without failures:
> > > 
> > >            arch/board | result
> > >           ------------|------------
> > >       arm/vexpress-a9 | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log
> > >          aarch64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/aarch64-virt-nolibc-test.log
> > >           ppc/g3beige | not supported
> > >               i386/pc | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/i386-pc-nolibc-test.log
> > >             x86_64/pc | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/x86_64-pc-nolibc-test.log
> > >          mipsel/malta | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/mipsel-malta-nolibc-test.log
> > >      loongarch64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/loongarch64-virt-nolibc-test.log
> > >          riscv64/virt | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
> > >          riscv32/virt | no test log found
> > > s390x/s390-ccw-virtio | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/s390x-s390-ccw-virtio-nolibc-test.log
> > > 
> 
> (snipped)
> 
> > >   It is able to build and run nolibc-test with musl libc now, but there
> > >   are some failures/skips due to the musl its own issues/requirements:
> > > 
> > >     $ sudo ./nolibc-test  | grep -E 'FAIL|SKIP'
> > >     8 sbrk = 1 ENOMEM                                               [FAIL]
> > >     9 brk = -1 ENOMEM                                               [FAIL]
> > >     46 limit_int_fast16_min = -2147483648                           [FAIL]
> > >     47 limit_int_fast16_max = 2147483647                            [FAIL]
> > >     49 limit_int_fast32_min = -2147483648                           [FAIL]
> > >     50 limit_int_fast32_max = 2147483647                            [FAIL]
> > >     0 -fstackprotector not supported                                [SKIPPED]
> > > 
> > >   musl disabled sbrk and brk for some conflicts with its malloc and the
> > >   fast version of int types are defined in 32bit, which differs from nolibc
> > >   and glibc. musl reserved the sbrk(0) to allow get current brk, we
> > >   added a test for this in the v4 __sysret() helper series [2].
> > 
> > We could add new macros
> > 
> > #define UINT_MAX(t) (~(t)0)
> > #define SINT_MAX(t) (((t)1 << (sizeof(t) * 8 - 2)) - (t)1 + ((t)1 << (sizeof(t) * 8 - 2)))
> > 
> > to get whatever is appropriate for the respective type.
> >
> 
> They work perfectly, thanks:
> 
>     /* for fast int test cases in stdlib test, musl use 32bit fast int */
>     #undef UINT_MAX
>     #define UINT_MAX(t)    (~(t)0)
>     #undef SINT_MAX
>     #define SINT_MAX(t)    (((t)1 << (sizeof(t) * 8 - 2)) - (t)1 + ((t)1 << (sizeof(t) * 8 - 2)))
>     #undef SINT_MIN
>     #define SINT_MIN(t)    (-SINT_MAX(t) - 1)
> 
>     ...
> 
>     CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,   (int_fast16_t)    SINT_MIN(int_fast16_t)); break;
>     CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,   (int_fast16_t)    SINT_MAX(int_fast16_t)); break;
>     CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX,  (uint_fast16_t)   UINT_MAX(uint_fast16_t)); break;
>     CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    SINT_MIN(int_fast32_t)); break;
>     CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    SINT_MAX(int_fast32_t)); break;
>     CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINT_MAX(uint_fast32_t)); break;
> 
> To avoid overriding the existing macros, perhaps we should add something
> like UINT_TYPE_MAX(t), SINT_TYPE_MAX(t) and SINT_TYPE_MIN(t) ?

They should only be visible inside nolibc-test.c I think.
But yes the UINT_MAX naming is bad.

Also when going away from testing constants maybe we can get back some
test strength by validating the sizeof() of the datatypes.

<snip>

> > > 
> > > * selftests/nolibc: vfprintf: silence memfd_create() warning
> > >   selftests/nolibc: vfprintf: skip if neither tmpfs nor hugetlbfs
> > >   selftests/nolibc: vfprintf: support tmpfs and hugetlbfs
> > > 
> > >   memfd_create from kernel >= v6.2 forcely warn on missing
> > >   MFD_NOEXEC_SEAL flag, the first one silence it with such flag, for
> > >   older kernels, use 0 flag as before.
> > 
> > Given this is only a problem when nolibc-test is PID1 and printing to
> > the system console, we could also just disable warnings on the system
> > console through syscall() or /proc/sys/kernel/printk.
> 
> Ok, I did think about disabling console for this call, but I was worried about
> the requirement of root (euid0) to do so, limiting it under PID1 may solve the
> root permission issue, but still need to find the right syscall to avoid the
> dependency of /proc/sys/kernel/printk, otherwise, to avoid failure for !procfs,
> the whole vfprintf will be skipped for such a warning, to be honest, it looks
> not a good direction.

This should work:

syslog(__NR_syslog, 6 /* SYSLOG_ACTION_CONSOLE_OFF */);

> > 
> > It would also avoid cluttering the tests for limited gain.
> >
> 
> Hmm, if consider the more code lines about disabling/enabling console and the
> dependency of /proc/sys/kernel/printk, I do prefer current change.

It should really only be the single line above.

> But I'm also interested in how the other applications developers to treat this
> warning, from the new kernel version side, we should use the latest non
> executable flags for security, but to let applications work with old kernels,
> we must support old flags, checking the kernel versions may be another choice. 

I know that systemd does it the same way as you proposed it, with
non-negligible code overhead.

But for nolibc-test I really don't see any security issue.

> Perhaps it's time for us to add the 'uname()' for nolibc, but the
> version comparing may be not that easy when we are in c context ;-)
> 
>   https://www.man7.org/linux/man-pages/man2/uname.2.html

Please no :-)

> So, the current method may be still a 'balanced' solution, it tries supported
> flags from new kernel to old kernel to get a better and working memfd_create()
> without the version checking, is this cleaner?
> 
> 	int i;
> 	/* kernel >= v6.2 require MFD_NOEXEC_SEAL (0x0008U), but older ones not support this flag */

It is not required, only desired. The functionality still works as
expected. I don't think the "old" way can ever stop working as it would
break userspace ABI.

> 	unsigned int flags[2] = {0x0008U, 0};
> 
> 	for (i = 0; i < 2; i ++) {

Loops like this should use ARRAY_SIZE() to calculate the termination
condition.

> 		/* try supported flags from new kernels to old kernels */
> 		fd = memfd_create("vfprintf", flags[i]);
> 		if (fd != -1)
> 			break;
> 	}
> 
> 	if (fd == -1) {
> 		...
> 	}

<snip>


Thomas
