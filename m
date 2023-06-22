Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE973A880
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjFVSqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 14:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVSqQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 14:46:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED391FF5;
        Thu, 22 Jun 2023 11:46:12 -0700 (PDT)
X-QQ-mid: bizesmtp81t1687459560tkxr47g0
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 23 Jun 2023 02:45:59 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: +ynUkgUhZJmISFXXJgcf6R+393RzHCLVVKOkJCS7I7lHjUOEdKVMF2qBTLvE4
        cN5jcvG7Ic9CiEUFav2g3sY9SECkMQl9MZNYrlj7MF5Gxvr2rVnkauYY45HCKsU3uRNvN5K
        j1bLTGUGTNPIKY4BMZy0qUcpp0GuOQlRBB137jcpAyiIUCjeFw0UyeGZFBsbhIvXnvDO3NX
        o5sVfUNIPlv8/gWzdwvU2sbhrrUSs87A+eGyQwDxDKwqtwDQSJkZvustB33McuWf0rD0Edl
        KiD/3EfQfdOgbsSzCPd0bhm50DMHVcHr4b4LLrK2HjgDISay6VDO7d/6Xbj4009Ya4OSL9F
        mkEj5/4XIlDoZai0qXbPqO3u+a/kVvrLBfeiXAU
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 128294126882192213
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 00/17] selftests/nolibc: allow run with minimal kernel config
Date:   Fri, 23 Jun 2023 02:45:59 +0800
Message-Id: <20230622184559.1188894-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <bc635c4f-67fe-4e86-bfdf-bcb4879b928d@t-8ch.de>
References: <bc635c4f-67fe-4e86-bfdf-bcb4879b928d@t-8ch.de>
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

> Hi Zhangjin,
> 
> some general comments for the whole series.
> 
> On 2023-06-21 20:52:30+0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > This patchset mainly allows speed up the nolibc test with a minimal
> > kernel config.
> > 
> > As the nolibc supported architectures become more and more, the 'run'
> > test with DEFCONFIG may cost several hours, which is not friendly to
> > develop testing and even for release testing, so, smaller kernel configs
> > may be required, and firstly, we should let nolibc-test work with less
> > kernel config options, this patchset aims to this goal.
> > 
> > This patchset mainly remove the dependency from procfs, tmpfs, net and
> > memfd_create, many failures have been fixed up.
> > 
> > When CONFIG_TMPFS and CONFIG_SHMEM are disabled, kernel will provide a
> > ramfs based tmpfs (mm/shmem.c), it will be used as a choice to fix up
> > some failures and also allow skip less tests.
> 
> Did you look into how much this duplicates from the kernels already
> existing "tinyconfig" and "kvm_guest.config" functionality?
>

Very good question and suggestion, thanks. it is just between tinyconfig
and kvm_guest.config, the former is not enough, the later provides more.
tinyconfig may be a very good base for us.

Just tested some architectures, based on tinyconfig, seems we only need
to enable very few options, for example, TTY, PRINTK, CONSOLE related
and target virtual board related options, but it requires more time to
just list the required options.

The 'minimal' ones I have prepared were shrunk from the 'defconfig', now
we need to add options from 'tinyconfig', with allnoconfig, it should be
smaller and therefore faster ;-)

Based on my local powerpc porting, I have prepared some changes like
this:

    # extra kernel configs by architecture
    EXTCONFIG_powerpc    = --enable SERIAL_PMACZILOG --enable CONFIG_SERIAL_PMACZILOG_CONSOLE
    EXTCONFIG            = --set-str CONFIG_INITRAMFS_SOURCE $(CURDIR)/initramfs $(EXTCONFIG_$(ARCH))

    ...

    menuconfig:
            $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig
    
    extconfig:
            $(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
            $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig
    
    kernel: initramfs extconfig
            $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)


'menuconfig' is added for development, for example, find why something not work
and add the missing options.

'extconfig' is added to enable additional options (before, based on
defconfig) to let nolibc-test happy (for powerpc, add missing console
options which has been added as modules in default config).

Based on your suggestion, this may be a good new target:

    tinyconfig:
            $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper tinyconfig prepare

And this one, use 'allnoconfig' instead of 'olddefconfig':

    extconfig:
            $(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
            $(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG=$(srctree)/.config allnoconfig

So, the new 'tinyconfig' may function as the smallest test environment,
for faster compile and as a boundary test of nolibc-test itself.

But again, still need time to list the minimally required options, if they are
few, listing them in the EXTCONFIG_<ARCH> line may be acceptable, but if the
options are 'huge', standalone nolibc.config may be required, let's wait for
one or two days.

> And it would be interesting how much impact the enablement of procfs,
> tmpfs, net and memfd_create has in constrast to the minimal
> configuration.

For the test speed (mainly kernel compile) itself, when for one architecture on
a very good test host, the time cost increment is very little (see below), but it
does save some, especially when for lots of architectures ;-)

Comparing the rv64 testing speed on a Ubuntu 20.04 over '4G Mem + 4 Cores of
i7-8550U CPU @ 1.80GHz' Virtual Machne, this time include:

* nolibc-test sysroot install + build
* kernel config + build
* qemu boot with opensbi + u-boot + kernel v6.4-rcx

Testing results:

  'minimal':

      arch/board | result
     ------------|------------
    riscv64/virt | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
    
    LOG: see all results for all boards in /labs/linux-lab/logging/nolibc/nolibc-test.log
    
    
    real	1m57.395s
    user	4m50.002s
    sys	1m0.866s

  'minimal' + procfs, net, shmem/tmpfs, devtmpfs/devmtmpfs_mount ...:

      arch/board | result
     ------------|------------
    riscv64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
    
    LOG: see all results for all boards in /labs/linux-lab/logging/nolibc/nolibc-test.log
    
    
    real	2m17.812s
    user	6m4.695s
    sys	1m7.061s

It did save 20s (~17.1%) for us, not too much, but really faster. 

> It seems unfortunate to me to complicate the testsuite to handle such
> uncommon scenarios.

Yeah, such a config is not common, but as explained above, beside the compile
speedup improvement, it is really a good boundary test environment for
nolibc-test itself to make sure it work (no failure, less skips) at an
extremely worst-case scene, although our changes looks many, but every one is
as simple as CLOC ;-)

And that also means, nolibc is able to run with a very 'tiny' kernel
config and users could reuse our config fragments and add their own for
their embedded devices.

> 
> > Besides, it also adds musl support, improves glibc support and fixes up
> > a kernel cmdline passing use case.
> > 
> > This is based on the dev.2023.06.14a branch of linux-rcu [1], all of the
> > supported architectures are tested (with local minimal configs, [5]
> > pasted the one for i386) without failures:
> > 
> >            arch/board | result
> >           ------------|------------
> >       arm/vexpress-a9 | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log
> >          aarch64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/aarch64-virt-nolibc-test.log
> >           ppc/g3beige | not supported
> >               i386/pc | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/i386-pc-nolibc-test.log
> >             x86_64/pc | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/x86_64-pc-nolibc-test.log
> >          mipsel/malta | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/mipsel-malta-nolibc-test.log
> >      loongarch64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/loongarch64-virt-nolibc-test.log
> >          riscv64/virt | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
> >          riscv32/virt | no test log found
> > s390x/s390-ccw-virtio | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/s390x-s390-ccw-virtio-nolibc-test.log
> > 

(snipped)

> >   It is able to build and run nolibc-test with musl libc now, but there
> >   are some failures/skips due to the musl its own issues/requirements:
> > 
> >     $ sudo ./nolibc-test  | grep -E 'FAIL|SKIP'
> >     8 sbrk = 1 ENOMEM                                               [FAIL]
> >     9 brk = -1 ENOMEM                                               [FAIL]
> >     46 limit_int_fast16_min = -2147483648                           [FAIL]
> >     47 limit_int_fast16_max = 2147483647                            [FAIL]
> >     49 limit_int_fast32_min = -2147483648                           [FAIL]
> >     50 limit_int_fast32_max = 2147483647                            [FAIL]
> >     0 -fstackprotector not supported                                [SKIPPED]
> > 
> >   musl disabled sbrk and brk for some conflicts with its malloc and the
> >   fast version of int types are defined in 32bit, which differs from nolibc
> >   and glibc. musl reserved the sbrk(0) to allow get current brk, we
> >   added a test for this in the v4 __sysret() helper series [2].
> 
> We could add new macros
> 
> #define UINT_MAX(t) (~(t)0)
> #define SINT_MAX(t) (((t)1 << (sizeof(t) * 8 - 2)) - (t)1 + ((t)1 << (sizeof(t) * 8 - 2)))
> 
> to get whatever is appropriate for the respective type.
>

They work perfectly, thanks:

    /* for fast int test cases in stdlib test, musl use 32bit fast int */
    #undef UINT_MAX
    #define UINT_MAX(t)    (~(t)0)
    #undef SINT_MAX
    #define SINT_MAX(t)    (((t)1 << (sizeof(t) * 8 - 2)) - (t)1 + ((t)1 << (sizeof(t) * 8 - 2)))
    #undef SINT_MIN
    #define SINT_MIN(t)    (-SINT_MAX(t) - 1)

    ...

    CASE_TEST(limit_int_fast16_min);    EXPECT_EQ(1, INT_FAST16_MIN,   (int_fast16_t)    SINT_MIN(int_fast16_t)); break;
    CASE_TEST(limit_int_fast16_max);    EXPECT_EQ(1, INT_FAST16_MAX,   (int_fast16_t)    SINT_MAX(int_fast16_t)); break;
    CASE_TEST(limit_uint_fast16_max);   EXPECT_EQ(1, UINT_FAST16_MAX,  (uint_fast16_t)   UINT_MAX(uint_fast16_t)); break;
    CASE_TEST(limit_int_fast32_min);    EXPECT_EQ(1, INT_FAST32_MIN,   (int_fast32_t)    SINT_MIN(int_fast32_t)); break;
    CASE_TEST(limit_int_fast32_max);    EXPECT_EQ(1, INT_FAST32_MAX,   (int_fast32_t)    SINT_MAX(int_fast32_t)); break;
    CASE_TEST(limit_uint_fast32_max);   EXPECT_EQ(1, UINT_FAST32_MAX,  (uint_fast32_t)   UINT_MAX(uint_fast32_t)); break;

To avoid overriding the existing macros, perhaps we should add something
like UINT_TYPE_MAX(t), SINT_TYPE_MAX(t) and SINT_TYPE_MIN(t) ?

> > 
> > * selftests/nolibc: fix up kernel parameters support
> > 
> >   kernel cmdline allows pass two types of parameters, one is without
> >   '=', another is with '=', the first one is passed as init arguments,
> >   the sencond one is passed as init environment variables.
> > 
> >   Our nolibc-test prefer arguments to environment variables, this not
> >   work when users add such parameters in the kernel cmdline:
> > 
> >     noapic NOLIBC_TEST=syscall
> > 
> >   So, this patch will verify the setting from arguments at first, if it
> >   is no valid, will try the environment variables instead.
> 
> This would be much simpler as:
> 
> test = getenv("NOLIBC_TEST");
> if (!test)
>         test = argv[1];
>
> It changes the semantics a bit, but it doesn't seem to be an issue.
> (Maybe gated behind getpid() == 1).

Cool suggestion, it looks really better:

	if (getpid() == 1) {
		prepare();
		
		/* kernel cmdline may pass: "noapic NOLIBC_TEST=syscall",
                 * to init program:
		 *
		 *   "noapic" as arguments,
		 *   "NOLIBC_TEST=syscall" as environment variables,
                 *
		 * to avoid getting null test in this case, parsing
		 * environment variables at first.
		 */
		test = getenv("NOLIBC_TEST");
		if (!test)
			test = argv[1];
	} else {
		/* for normal nolibc-test program, prefer arguments */
		test = argv[1];
		if (!test)
			test = getenv("NOLIBC_TEST");
	}

> 
> > * selftests/nolibc: stat_timestamps: remove procfs dependency
> > 
> >   Use '/' instead of /proc/self, or we can add a 'has_proc' condition
> >   for this test case, but it is not that necessary to skip the whole
> >   stat_timestamps tests for such a subtest binding to /proc/self.
> > 
> >   Welcome suggestion from Thomas.
> 
> As above, I think the impact of depending on CONFIG_PROC_FS is
> justifiable.
> 
> The usage of /proc/self was actually intentional.
> This file has a timestamp of the start of the referenced process.
> So each invocation of nolibc-test tests a new timestamp.
>
> In contrast if nolibc-test is invocated from a prebaked filesystem the
> timestamp of "/" will always be fixed, reducing the chance to find
> errors.

Yeah, it is resonable to reserve this as /proc/self, for a balance, to
avoid failure in the worst-case scene, let's add a 'has_proc' condition
there instead, just like the other /proc/self based test cases do.

> 
> > * tools/nolibc: add rmdir() support
> >   selftests/nolibc: add a new rmdir() test case
> > 
(snipped)
> > 
> > * selftests/nolibc: vfprintf: silence memfd_create() warning
> >   selftests/nolibc: vfprintf: skip if neither tmpfs nor hugetlbfs
> >   selftests/nolibc: vfprintf: support tmpfs and hugetlbfs
> > 
> >   memfd_create from kernel >= v6.2 forcely warn on missing
> >   MFD_NOEXEC_SEAL flag, the first one silence it with such flag, for
> >   older kernels, use 0 flag as before.
> 
> Given this is only a problem when nolibc-test is PID1 and printing to
> the system console, we could also just disable warnings on the system
> console through syscall() or /proc/sys/kernel/printk.

Ok, I did think about disabling console for this call, but I was worried about
the requirement of root (euid0) to do so, limiting it under PID1 may solve the
root permission issue, but still need to find the right syscall to avoid the
dependency of /proc/sys/kernel/printk, otherwise, to avoid failure for !procfs,
the whole vfprintf will be skipped for such a warning, to be honest, it looks
not a good direction.

> 
> It would also avoid cluttering the tests for limited gain.
>

Hmm, if consider the more code lines about disabling/enabling console and the
dependency of /proc/sys/kernel/printk, I do prefer current change.

But I'm also interested in how the other applications developers to treat this
warning, from the new kernel version side, we should use the latest non
executable flags for security, but to let applications work with old kernels,
we must support old flags, checking the kernel versions may be another choice. 

Perhaps it's time for us to add the 'uname()' for nolibc, but the
version comparing may be not that easy when we are in c context ;-)

  https://www.man7.org/linux/man-pages/man2/uname.2.html

So, the current method may be still a 'balanced' solution, it tries supported
flags from new kernel to old kernel to get a better and working memfd_create()
without the version checking, is this cleaner?

	int i;
	/* kernel >= v6.2 require MFD_NOEXEC_SEAL (0x0008U), but older ones not support this flag */
	unsigned int flags[2] = {0x0008U, 0};

	for (i = 0; i < 2; i ++) {
		/* try supported flags from new kernels to old kernels */
		fd = memfd_create("vfprintf", flags[i]);
		if (fd != -1)
			break;
	}

	if (fd == -1) {
		...
	}

Thanks very much.

Best regards,
Zhangjin

> >   since memfd_create() depends on TMPFS or HUGETLBFS, the second one
> >   skip the whole vfprintf instead of simply fail if memfd_create() not
> >   work.
> > 
> >   the 3rd one futher try the ramfs based tmpfs even when memfd_create()
> >   not work.
> > 
> > At last, let's simply discuss about the configs, I have prepared minimal
> > configs for all of the nolibc supported architectures but not sure where
> > should we put them, what about tools/testing/selftests/nolibc/configs ?
> > 
> > Thanks!
> > 
> > Best regards,
> > Zhangjin
> > ---
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/
> > [2]: https://lore.kernel.org/linux-riscv/cover.1687187451.git.falcon@tinylab.org/
> > [3]: https://lore.kernel.org/lkml/cover.1687156559.git.falcon@tinylab.org/
> > [4]: https://lore.kernel.org/linux-riscv/cover.1687176996.git.falcon@tinylab.org/
> > [5]: https://pastebin.com/5jq0Vxbz 
> > 
> > Zhangjin Wu (17):
> >   selftests/nolibc: stat_fault: silence NULL argument warning with glibc
> >   selftests/nolibc: gettid: restore for glibc and musl
> >   selftests/nolibc: add _LARGEFILE64_SOURCE for musl
> >   selftests/nolibc: fix up kernel parameters support
> >   selftests/nolibc: stat_timestamps: remove procfs dependency
> >   tools/nolibc: add rmdir() support
> >   selftests/nolibc: add a new rmdir() test case
> >   selftests/nolibc: fix up failures when there is no procfs
> >   selftests/nolibc: rename proc variable to has_proc
> >   selftests/nolibc: rename euid0 variable to is_root
> >   selftests/nolibc: prepare tmpfs and hugetlbfs
> >   selftests/nolibc: rename chmod_net to chmod_good
> >   selftests/nolibc: link_cross: support tmpfs
> >   selftests/nolibc: rename chroot_exe to chroot_file
> >   selftests/nolibc: vfprintf: silence memfd_create() warning
> >   selftests/nolibc: vfprintf: skip if neither tmpfs nor hugetlbfs
> >   selftests/nolibc: vfprintf: support tmpfs and hugetlbfs
> > 
> >  tools/include/nolibc/sys.h                   |  28 ++++
> >  tools/testing/selftests/nolibc/nolibc-test.c | 132 +++++++++++++++----
> >  2 files changed, 138 insertions(+), 22 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 
