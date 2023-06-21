Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92715738FF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 21:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFUTWD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 15:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUTWD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 15:22:03 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCF7199E;
        Wed, 21 Jun 2023 12:22:01 -0700 (PDT)
Date:   Wed, 21 Jun 2023 21:21:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687375319; bh=q5JlFy6Ato9AkhnBC0gE+fyxIZckqNSTZwN+1O+DX+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TymseiNHN2tF41D11zxDlA7HCLy6rQxHXsKrzon2JJSMoJ2NYqYgE5En8aNfv/gnN
         3XLb0Co/TxCykhi86N0v9A/qfSh6WWLr3jeKjrkA1uTdBzKgwIVDcGTjgs8xxGXpRa
         bmcKiVs3gYUrsAnUOd/wc55ABRVvczcdzDUHNv7o=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 00/17] selftests/nolibc: allow run with minimal kernel
 config
Message-ID: <bc635c4f-67fe-4e86-bfdf-bcb4879b928d@t-8ch.de>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

some general comments for the whole series.

On 2023-06-21 20:52:30+0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> This patchset mainly allows speed up the nolibc test with a minimal
> kernel config.
> 
> As the nolibc supported architectures become more and more, the 'run'
> test with DEFCONFIG may cost several hours, which is not friendly to
> develop testing and even for release testing, so, smaller kernel configs
> may be required, and firstly, we should let nolibc-test work with less
> kernel config options, this patchset aims to this goal.
> 
> This patchset mainly remove the dependency from procfs, tmpfs, net and
> memfd_create, many failures have been fixed up.
> 
> When CONFIG_TMPFS and CONFIG_SHMEM are disabled, kernel will provide a
> ramfs based tmpfs (mm/shmem.c), it will be used as a choice to fix up
> some failures and also allow skip less tests.

Did you look into how much this duplicates from the kernels already
existing "tinyconfig" and "kvm_guest.config" functionality?

And it would be interesting how much impact the enablement of procfs,
tmpfs, net and memfd_create has in constrast to the minimal
configuration.
It seems unfortunate to me to complicate the testsuite to handle such
uncommon scenarios.

> Besides, it also adds musl support, improves glibc support and fixes up
> a kernel cmdline passing use case.
> 
> This is based on the dev.2023.06.14a branch of linux-rcu [1], all of the
> supported architectures are tested (with local minimal configs, [5]
> pasted the one for i386) without failures:
> 
>            arch/board | result
>           ------------|------------
>       arm/vexpress-a9 | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/arm-vexpress-a9-nolibc-test.log
>          aarch64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/aarch64-virt-nolibc-test.log
>           ppc/g3beige | not supported
>               i386/pc | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/i386-pc-nolibc-test.log
>             x86_64/pc | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/x86_64-pc-nolibc-test.log
>          mipsel/malta | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/mipsel-malta-nolibc-test.log
>      loongarch64/virt | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/loongarch64-virt-nolibc-test.log
>          riscv64/virt | 136 test(s) passed, 3 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/riscv64-virt-nolibc-test.log
>          riscv32/virt | no test log found
> s390x/s390-ccw-virtio | 138 test(s) passed, 1 skipped, 0 failed. See all results in /labs/linux-lab/logging/nolibc/s390x-s390-ccw-virtio-nolibc-test.log
> 
> Notes:
>   * The skipped ones are -fstackprotector, chmod_self and chown_self
> 
>     The -fstackprotector skip is due to gcc version.
>     chmod_self and chmod_self skips are due to procfs not enabled
> 
>   * ppc/g3beige support is added locally, but not added in this patchset
> 
>     will send ppc support as a new patchset, it depends on v2 test
>     report patchset [3] and the v5 rv32 support, require changes on
>     Makefile
> 
>   * riscv32/virt support is still in review, see v5 rv32 support [4]
> 
> This patchset doesn't depends on any of my other nolibc patch series,
> but the new rmdir() routine added in this patchset may be requird to
> apply the __sysret() from our v4 syscall helper series [2] after that
> series being merged, currently, we use the old method to let it compile
> without any dependency.
> 
> Here explains all of the patches:
> 
> * selftests/nolibc: stat_fault: silence NULL argument warning with glibc
>   selftests/nolibc: gettid: restore for glibc and musl
>   selftests/nolibc: add _LARGEFILE64_SOURCE for musl
> 
>   The above 3 patches adds musl compile support and improve glibc support.
> 
>   It is able to build and run nolibc-test with musl libc now, but there
>   are some failures/skips due to the musl its own issues/requirements:
> 
>     $ sudo ./nolibc-test  | grep -E 'FAIL|SKIP'
>     8 sbrk = 1 ENOMEM                                               [FAIL]
>     9 brk = -1 ENOMEM                                               [FAIL]
>     46 limit_int_fast16_min = -2147483648                           [FAIL]
>     47 limit_int_fast16_max = 2147483647                            [FAIL]
>     49 limit_int_fast32_min = -2147483648                           [FAIL]
>     50 limit_int_fast32_max = 2147483647                            [FAIL]
>     0 -fstackprotector not supported                                [SKIPPED]
> 
>   musl disabled sbrk and brk for some conflicts with its malloc and the
>   fast version of int types are defined in 32bit, which differs from nolibc
>   and glibc. musl reserved the sbrk(0) to allow get current brk, we
>   added a test for this in the v4 __sysret() helper series [2].

We could add new macros

#define UINT_MAX(t) (~(t)0)
#define SINT_MAX(t) (((t)1 << (sizeof(t) * 8 - 2)) - (t)1 + ((t)1 << (sizeof(t) * 8 - 2)))

to get whatever is appropriate for the respective type.

> 
> * selftests/nolibc: fix up kernel parameters support
> 
>   kernel cmdline allows pass two types of parameters, one is without
>   '=', another is with '=', the first one is passed as init arguments,
>   the sencond one is passed as init environment variables.
> 
>   Our nolibc-test prefer arguments to environment variables, this not
>   work when users add such parameters in the kernel cmdline:
> 
>     noapic NOLIBC_TEST=syscall
> 
>   So, this patch will verify the setting from arguments at first, if it
>   is no valid, will try the environment variables instead.

This would be much simpler as:

test = getenv("NOLIBC_TEST");
if (!test)
        test = argv[1];

It changes the semantics a bit, but it doesn't seem to be an issue.
(Maybe gated behind getpid() == 1).

> * selftests/nolibc: stat_timestamps: remove procfs dependency
> 
>   Use '/' instead of /proc/self, or we can add a 'has_proc' condition
>   for this test case, but it is not that necessary to skip the whole
>   stat_timestamps tests for such a subtest binding to /proc/self.
> 
>   Welcome suggestion from Thomas.

As above, I think the impact of depending on CONFIG_PROC_FS is
justifiable.

The usage of /proc/self was actually intentional.
This file has a timestamp of the start of the referenced process.
So each invocation of nolibc-test tests a new timestamp.

In contrast if nolibc-test is invocated from a prebaked filesystem the
timestamp of "/" will always be fixed, reducing the chance to find
errors.

> * tools/nolibc: add rmdir() support
>   selftests/nolibc: add a new rmdir() test case
> 
>   rmdir() routine and test case are added for the coming requirement.
> 
>   Note, if the __sysret() patchset [2] is applied before us, this patch
>   should be rebased on it and apply the __sysret() helper.
> 
> * selftests/nolibc: fix up failures when there is no procfs
> 
>   call rmdir() to remove /proc completely to rework the checking of
>   /proc, before, the existing of /proc not means the procfs is really
>   mounted.
> 
> * selftests/nolibc: rename proc variable to has_proc
>   selftests/nolibc: rename euid0 variable to is_root
> 
>   align with the has_gettid, has_xxx variables.
> 
> * selftests/nolibc: prepare tmpfs and hugetlbfs
>   selftests/nolibc: rename chmod_net to chmod_good
>   selftests/nolibc: link_cross: support tmpfs
>   selftests/nolibc: rename chroot_exe to chroot_file
> 
>   use file from /tmp instead of file from /proc when there is no procfs
>   this avoid skipping the chmod_net, link_cross, chroot_exe tests
> 
> * selftests/nolibc: vfprintf: silence memfd_create() warning
>   selftests/nolibc: vfprintf: skip if neither tmpfs nor hugetlbfs
>   selftests/nolibc: vfprintf: support tmpfs and hugetlbfs
> 
>   memfd_create from kernel >= v6.2 forcely warn on missing
>   MFD_NOEXEC_SEAL flag, the first one silence it with such flag, for
>   older kernels, use 0 flag as before.

Given this is only a problem when nolibc-test is PID1 and printing to
the system console, we could also just disable warnings on the system
console through syscall() or /proc/sys/kernel/printk.

It would also avoid cluttering the tests for limited gain.

>   since memfd_create() depends on TMPFS or HUGETLBFS, the second one
>   skip the whole vfprintf instead of simply fail if memfd_create() not
>   work.
> 
>   the 3rd one futher try the ramfs based tmpfs even when memfd_create()
>   not work.
> 
> At last, let's simply discuss about the configs, I have prepared minimal
> configs for all of the nolibc supported architectures but not sure where
> should we put them, what about tools/testing/selftests/nolibc/configs ?
> 
> Thanks!
> 
> Best regards,
> Zhangjin
> ---
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/
> [2]: https://lore.kernel.org/linux-riscv/cover.1687187451.git.falcon@tinylab.org/
> [3]: https://lore.kernel.org/lkml/cover.1687156559.git.falcon@tinylab.org/
> [4]: https://lore.kernel.org/linux-riscv/cover.1687176996.git.falcon@tinylab.org/
> [5]: https://pastebin.com/5jq0Vxbz 
> 
> Zhangjin Wu (17):
>   selftests/nolibc: stat_fault: silence NULL argument warning with glibc
>   selftests/nolibc: gettid: restore for glibc and musl
>   selftests/nolibc: add _LARGEFILE64_SOURCE for musl
>   selftests/nolibc: fix up kernel parameters support
>   selftests/nolibc: stat_timestamps: remove procfs dependency
>   tools/nolibc: add rmdir() support
>   selftests/nolibc: add a new rmdir() test case
>   selftests/nolibc: fix up failures when there is no procfs
>   selftests/nolibc: rename proc variable to has_proc
>   selftests/nolibc: rename euid0 variable to is_root
>   selftests/nolibc: prepare tmpfs and hugetlbfs
>   selftests/nolibc: rename chmod_net to chmod_good
>   selftests/nolibc: link_cross: support tmpfs
>   selftests/nolibc: rename chroot_exe to chroot_file
>   selftests/nolibc: vfprintf: silence memfd_create() warning
>   selftests/nolibc: vfprintf: skip if neither tmpfs nor hugetlbfs
>   selftests/nolibc: vfprintf: support tmpfs and hugetlbfs
> 
>  tools/include/nolibc/sys.h                   |  28 ++++
>  tools/testing/selftests/nolibc/nolibc-test.c | 132 +++++++++++++++----
>  2 files changed, 138 insertions(+), 22 deletions(-)
> 
> -- 
> 2.25.1
> 
