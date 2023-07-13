Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDF75244D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGMNyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGMNyx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:54:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C16881BF4;
        Thu, 13 Jul 2023 06:54:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F00CC1570;
        Thu, 13 Jul 2023 06:55:32 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C92D23F73F;
        Thu, 13 Jul 2023 06:54:48 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 0/9] selftests/mm fixes for arm64
Date:   Thu, 13 Jul 2023 14:54:31 +0100
Message-Id: <20230713135440.3651409-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

Given my on-going work on large anon folios and contpte mappings, I decided it
would be a good idea to start running mm selftests to help guard against
regressions. However, it soon became clear that I couldn't get the suite to run
cleanly on arm64 with a vanilla v6.5-rc1 kernel (perhaps I'm just doing it
wrong??), so got stuck in a rabbit hole trying to debug and fix all the issues.
Some were down to misconfigurations, but I also found a number of issues with
the tests and even a couple of issues with the kernel.

This series aims to fix (most of) the test issues. It applies on top of
v6.5-rc1.


Reproducing
-----------

What follows is a write up of how I'm running the tests and the results I see
with this series applied. I don't yet have a concrete understanding of all of
the remaining failures. So if anyone has any comments on my setup or reasons for
the test failures it would be great to hear.

Source: v6.5-rc1 + this series + [1] + [2]. [1] is a patch from Florent Revest to
fix mdwe mmap_FIXED tests. [2] is a fix for a regression in the kernel that I
found by running `mlock-random-test` and `mlock2-tests`.

Compile the kernel (on arm64 system):

$ make defconfig
$ ./scripts/config --enable CONFIG_SQUASHFS_LZ4
$ ./scripts/config --enable CONFIG_SQUASHFS_LZO
$ ./scripts/config --enable CONFIG_SQUASHFS_XZ
$ ./scripts/config --enable CONFIG_SQUASHFS_ZSTD
$ ./scripts/config --enable CONFIG_XFS_FS
$ ./scripts/config --enable CONFIG_SYSVIPC
$ ./scripts/config --enable CONFIG_USERFAULTFD
$ ./scripts/config --enable CONFIG_TEST_VMALLOC
$ ./scripts/config --enable CONFIG_GUP_TEST
$ ./scripts/config --enable CONFIG_TRANSPARENT_HUGEPAGE
$ ./scripts/config --enable CONFIG_MEM_SOFT_DIRTY
$ make olddefconfig
$ make -s -j`nproc` Image

(In the above case, I'm building/testing a 4K kernel).

Note that it turns out that arm64 doesn't really support ZONE_DEVICE; Although
it defines ARCH_HAS_PTE_DEVMAP, it can't allocate `struct page`s for arbitrary
physical addresses. This means that the TEST_HMM module causes warnings to be
emitted when initializing because it tries to reserve arbitrary PA range then
requests struct page's for them. I haven't fully investigated this yet, but for
now, I'm just deliverately excluding ZONE_DEVICE, (which TEST_HMM depends upon).
This means that the `hmm-tests` selftest gets skipped at runtime.

Compile the tests:

$ make -j`nproc` headers_install
$ make -C tools/testing/selftests TARGETS=mm install INSTALL_PATH=<path/to/install>

Start a VM running the kernel we just compiled:

$ taskset -c 8-15 qemu-system-aarch64							\
	-object memory-backend-file,id=mem0,size=6G,mem-path=/hugetlbfs,merge=off,prealloc=on,host-nodes=0,policy=bind,align=1G \
	-object memory-backend-file,id=mem1,size=6G,mem-path=/hugetlbfs,merge=off,prealloc=on,host-nodes=0,policy=bind,align=1G \
	-nographic -enable-kvm -machine virt,gic-version=3 -cpu max			\
	-smp 8 -m 12G									\
	-numa node,memdev=mem0,cpus=0-3,nodeid=0					\
	-numa node,memdev=mem1,cpus=4-7,nodeid=1					\
	-drive if=virtio,format=raw,file=ubuntu-22.04.xfs				\
	-object rng-random,filename=/dev/urandom,id=rng0				\
	-device virtio-scsi-pci,id=scsi0						\
	-netdev user,id=net0,hostfwd=tcp::8022-:22					\
	-device virtio-rng-pci,rng=rng0							\
	-device virtio-net-pci,netdev=net0						\
	-kernel arch/arm64/boot/Image							\
	-append "earlycon root=/dev/vda2 secretmem.enable hugepagesz=1G hugepages=0:2,1:2 hugepagesz=32M hugepages=0:2,1:2 default_hugepagesz=2M hugepages=0:64,1:64 hugepagesz=64K hugepages=0:2,1:2"

This starts a VM with 2 numa nodes (needed by ksm and migration tests), with 6G
of memory and 4 CPUs on each node. The kernel command line enables secretmem
(needed for `memfd_secret` test), and preallocates a bunch of huge pages
(divined by reading the comments and source for a bunch of tests that require
huge pages). 128M of the default huge page size, and 4 pages of each of the
other sizes appear to be sufficient. I'm allocating half on each numa node.

Once booted, copy the selftests we just compiled onto it.

On the VM, run the tests:

$ cd path/to/selftests
$ sudo ./run_kselftest.sh

or alternatively:

$ cd path/to/selftests/mm
$ sudo ./run_vmtests.sh


Test Results
------------

TOP-LEVEL SUMMARY: PASS=42 SKIP=4 FAIL=2

Only showing nested tests if they are skipped or failed.

[PASS] hugepage-mmap
[PASS] hugepage-shm
[PASS] map_hugetlb
[PASS] hugepage-mremap
[PASS] hugepage-vmemmap
[PASS] hugetlb-madvise
[PASS] map_fixed_noreplace
[PASS] gup_test -u
[PASS] gup_test -a
[PASS] gup_test -ct -F 0x1 0 19 0x1000
[PASS] gup_longterm
[PASS] uffd-unit-tests
[PASS] uffd-stress anon 20 16
[PASS] uffd-stress hugetlb 128 32
[PASS] uffd-stress hugetlb-private 128 32
[PASS] uffd-stress shmem 20 16
[PASS] uffd-stress shmem-private 20 16
[PASS] compaction_test
[PASS] on-fault-limit
[PASS] map_populate
[PASS] mlock-random-test
[PASS] mlock2-tests
[PASS] mrelease_test
[PASS] mremap_test
[PASS] thuge-gen
[PASS] virtual_address_range
[SKIP] va_high_addr_switch.sh
	# 4K kernel does not support big enough VA space for test
[SKIP] test_vmalloc.sh smoke
	# Test requires test_vmalloc kernel module which isn't present
[PASS] mremap_dontunmap
[SKIP] test_hmm.sh smoke
	# Test requires test_hmm kernel module - see ZONE_DEVICE issue above
[PASS] madv_populate
	[PASS] test_softdirty
		[SKIP] range is not softdirty
		[SKIP] MADV_POPULATE_READ
		[SKIP] range is not softdirty
		[SKIP] MADV_POPULATE_WRITE
		[SKIP] range is softdirty
		# All skipped because arm64 does not support soft-dirty
[PASS] memfd_secret
[PASS] ksm_tests -M -p 10
[PASS] ksm_tests -U
[PASS] ksm_tests -Z -p 10 -z 0
[PASS] ksm_tests -Z -p 10 -z 1
[PASS] ksm_tests -N -m 1
[PASS] ksm_tests -N -m 0
[PASS] ksm_functional_tests
	[SKIP] test_unmerge_uffd_wp
		# UFFD_FEATURE_PAGEFAULT_FLAG_WP not available on arm64
[PASS] ksm_functional_tests
	[SKIP] test_unmerge_uffd_wp
		# UFFD_FEATURE_PAGEFAULT_FLAG_WP not available on arm64
[SKIP] soft-dirty
	# Skipped because arm64 does not support soft-dirty
[FAIL] cow
	[FAIL] vmsplice() + unmap in child ... with hugetlb
	[FAIL] vmsplice() + unmap in child with mprotect() optimization ... with hugetlb
	[FAIL] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb
	[FAIL] vmsplice() + unmap in parent after fork() ... with hugetlb
		# Above are known issues for vmsplice + hugetlb
		# Reproduces on x86
	[SKIP] Basic COW after fork() ... with swapped-out, PTE-mapped THP
	[SKIP] Basic COW after fork() with mprotect() optimization ... with swapped-out, PTE-mapped THP
	[SKIP] vmsplice() + unmap in child ... with swapped-out, PTE-mapped THP
	[SKIP] vmsplice() + unmap in child with mprotect() optimization ... with swapped-out, PTE-mapped THP
	[SKIP] vmsplice() before fork(), unmap in parent after fork() ... with swapped-out, PTE-mapped THP
	[SKIP] vmsplice() + unmap in parent after fork() ... with swapped-out, PTE-mapped THP
	[SKIP] R/O-mapping a page registered as iouring fixed buffer ... with swapped-out, PTE-mapped THP
	[SKIP] fork() with an iouring fixed buffer ... with swapped-out, PTE-mapped THP
	[SKIP] R/O GUP pin on R/O-mapped shared page ... with swapped-out, PTE-mapped THP
	[SKIP] R/O GUP-fast pin on R/O-mapped shared page ... with swapped-out, PTE-mapped THP
	[SKIP] R/O GUP pin on R/O-mapped previously-shared page ... with swapped-out, PTE-mapped THP
	[SKIP] R/O GUP-fast pin on R/O-mapped previously-shared page ... with swapped-out, PTE-mapped THP
	[SKIP] R/O GUP pin on R/O-mapped exclusive page ... with swapped-out, PTE-mapped THP
	[SKIP] R/O GUP-fast pin on R/O-mapped exclusive page ... with swapped-out, PTE-mapped THP
		# Above all skipped due to "MADV_PAGEOUT did not work, is swap enabled?"
		# swap is enabled though
		# Reproduces on x86
	[SKIP] Basic COW after fork() when collapsing after fork() (fully shared)
		# MADV_COLLAPSE failed: Invalid argument
[PASS] khugepaged
[PASS] transhuge-stress -d 20
[PASS] split_huge_page_test
[FAIL] migration
	[FAIL] migration.shared_anon
		# move_pages() reports that the requested page was not migrated
		# after a few iterations.
[PASS] mkdirty
[PASS] mdwe_test


[1] https://lore.kernel.org/lkml/20230704153630.1591122-3-revest@chromium.org/
[2] https://lore.kernel.org/linux-mm/20230711175020.4091336-1-Liam.Howlett@oracle.com/

Thanks,
Ryan


Ryan Roberts (9):
  selftests: Line buffer test program's stdout
  selftests/mm: Give scripts execute permission
  selftests/mm: Skip soft-dirty tests on arm64
  selftests/mm: Enable mrelease_test for arm64
  selftests/mm: Fix thuge-gen test bugs
  selftests/mm: va_high_addr_switch should skip unsupported arm64
    configs
  selftests/mm: Make migration test robust to failure
  selftests/mm: Optionally pass duration to transhuge-stress
  selftests/mm: Run all tests from run_vmtests.sh

 tools/testing/selftests/kselftest/runner.sh   |  5 +-
 tools/testing/selftests/mm/Makefile           | 79 ++++++++++---------
 .../selftests/mm/charge_reserved_hugetlb.sh   |  0
 tools/testing/selftests/mm/check_config.sh    |  0
 .../selftests/mm/hugetlb_reparenting_test.sh  |  0
 tools/testing/selftests/mm/madv_populate.c    | 18 +++--
 tools/testing/selftests/mm/migration.c        | 14 +++-
 tools/testing/selftests/mm/mrelease_test.c    |  1 +
 tools/testing/selftests/mm/run_vmtests.sh     | 23 ++++++
 tools/testing/selftests/mm/settings           |  2 +-
 tools/testing/selftests/mm/soft-dirty.c       |  3 +
 tools/testing/selftests/mm/test_hmm.sh        |  0
 tools/testing/selftests/mm/test_vmalloc.sh    |  0
 tools/testing/selftests/mm/thuge-gen.c        |  4 +-
 tools/testing/selftests/mm/transhuge-stress.c | 12 ++-
 .../selftests/mm/va_high_addr_switch.c        |  3 +-
 .../selftests/mm/va_high_addr_switch.sh       |  0
 tools/testing/selftests/mm/vm_util.c          | 17 ++++
 tools/testing/selftests/mm/vm_util.h          |  1 +
 .../selftests/mm/write_hugetlb_memory.sh      |  0
 20 files changed, 127 insertions(+), 55 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/mm/charge_reserved_hugetlb.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/check_config.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/hugetlb_reparenting_test.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/run_vmtests.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/test_hmm.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/test_vmalloc.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/va_high_addr_switch.sh
 mode change 100644 => 100755 tools/testing/selftests/mm/write_hugetlb_memory.sh

--
2.25.1

