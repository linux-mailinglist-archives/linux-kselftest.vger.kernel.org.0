Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA86FA47
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfD3NZT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 09:25:19 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:45822 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfD3NZS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 09:25:18 -0400
Received: by mail-ua1-f74.google.com with SMTP id s9so1904923uao.12
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UkvcQR44s0K+X/Jr3Zaeq3MZKuHg/qEMr5Ui4t9NDYw=;
        b=G2qg1Kl3sLAZB3loJ9pUPAiAmC1ary5Doy/w5PD+Zmuenzwp1y7qLbl9eQyEqg4i2e
         IH96c3nkDpmAUbvaXr8xgF6JGDKu9BxDsc6RRP3qmn1+raV9+2Eu0R1eIZJn5Tc4gymp
         zcdgdd9RsMnFfNqQr1FGf/ydu/D0Bb8ku9GUT6o95HgkAElp2R3mKcPuuCaYDBwgy3TV
         8UibpBwH++mRm6OMCEqU6q1ecKRzXrBb+8UzHqX8eKfJwIzHJ2u8OT6/7m1tktKAzn9T
         akWaa7z3/sYn6iBJtYp3U4nYj/r67ZsZV50oWRy2GlbB356ubCVdDkZ/e0ehF/7kUNt7
         MNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UkvcQR44s0K+X/Jr3Zaeq3MZKuHg/qEMr5Ui4t9NDYw=;
        b=KMuRt7M9pHE7tVZeFiuMEUfA4svuYIzS6Q6DkitkMyGXpCNh3EBNXw5JzZDINr6Hze
         mreaaqii6Ufplus59sTingbyQEpr+MXQ0RH3+0oWCh4g40Ualw8jxTfrpYcpADnIqKp2
         SPOu4W+Jss159rzToV2zOmgJOFJu1pBrSMKqnm3msDrw+zbXs/6TuM/wgmsueFCvqkgI
         NyCVAP4sUoCPogiQbtQcK0M+WcC0rNPPc/F99bYkz/MnbmYXSDrcE6FpUZYaw5WoTAur
         KN8hnVMPaRU/ZAFjgXcc2/qnrjDdJTIt7U5nmJ+xaMnEGlsoTBL09I6fHMlu6ArBnRBK
         QHaQ==
X-Gm-Message-State: APjAAAVRiB6S0fjIpPrnXRGRNUwn1vRWVPjenYUv5GhXsBYm9BnSd4ft
        Ur+LDnM3oG6skn53lrd0yCDQ9ID6PxwgkMNl
X-Google-Smtp-Source: APXvYqy2s4q/NAuxHa5mXOAkO1LFtyotOktrYSKtCMyKjB+T66xUOQKMsI+6Xz1tA3j9vH5U3IzM1vjvjobmi1sD
X-Received: by 2002:a67:14c6:: with SMTP id 189mr11443553vsu.203.1556630717016;
 Tue, 30 Apr 2019 06:25:17 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:24:56 +0200
Message-Id: <cover.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 00/17] arm64: untag user pointers passed to the kernel
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

=== Overview

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [1]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

Right now the kernel is already able to handle user faults with tagged
pointers, due to these patches:

1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
             tagged pointer")
2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
	      pointers")
3. 276e9327 ("arm64: entry: improve data abort handling of tagged
	      pointers")

This patchset extends tagged pointer support to syscall arguments.

As per the proposed ABI change [3], tagged pointers are only allowed to be
passed to syscalls when they point to memory ranges obtained by anonymous
mmap() or sbrk() (see the patchset [3] for more details).

For non-memory syscalls this is done by untaging user pointers when the
kernel performs pointer checking to find out whether the pointer comes
from userspace (most notably in access_ok). The untagging is done only
when the pointer is being checked, the tag is preserved as the pointer
makes its way through the kernel and stays tagged when the kernel
dereferences the pointer when perfoming user memory accesses.

Memory syscalls (mmap, mprotect, etc.) don't do user memory accesses but
rather deal with memory ranges, and untagged pointers are better suited to
describe memory ranges internally. Thus for memory syscalls we untag
pointers completely when they enter the kernel.

=== Other approaches

One of the alternative approaches to untagging that was considered is to
completely strip the pointer tag as the pointer enters the kernel with
some kind of a syscall wrapper, but that won't work with the countless
number of different ioctl calls. With this approach we would need a custom
wrapper for each ioctl variation, which doesn't seem practical.

An alternative approach to untagging pointers in memory syscalls prologues
is to inspead allow tagged pointers to be passed to find_vma() (and other
vma related functions) and untag them there. Unfortunately, a lot of
find_vma() callers then compare or subtract the returned vma start and end
fields against the pointer that was being searched. Thus this approach
would still require changing all find_vma() callers.

=== Testing

The following testing approaches has been taken to find potential issues
with user pointer untagging:

1. Static testing (with sparse [2] and separately with a custom static
   analyzer based on Clang) to track casts of __user pointers to integer
   types to find places where untagging needs to be done.

2. Static testing with grep to find parts of the kernel that call
   find_vma() (and other similar functions) or directly compare against
   vm_start/vm_end fields of vma.

3. Static testing with grep to find parts of the kernel that compare
   user pointers with TASK_SIZE or other similar consts and macros.

4. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
   a modified syzkaller version that passes tagged pointers to the kernel.

Based on the results of the testing the requried patches have been added
to the patchset.

=== Notes

This patchset is meant to be merged together with "arm64 relaxed ABI" [3].

This patchset is a prerequisite for ARM's memory tagging hardware feature
support [4].

This patchset has been merged into the Pixel 2 & 3 kernel trees and is
now being used to enable testing of Pixel phones with HWASan.

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

[2] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292

[3] https://lkml.org/lkml/2019/3/18/819

[4] https://community.arm.com/processors/b/blog/posts/arm-a-profile-architecture-2018-developments-armv85a

Changes in v14:
- Moved untagging for most memory syscalls to an arm64 specific
  implementation, instead of doing that in the common code.
- Dropped "net, arm64: untag user pointers in tcp_zerocopy_receive", since
  the provided user pointers don't come from an anonymous map and thus are
  not covered by this ABI relaxation.
- Dropped "kernel, arm64: untag user pointers in prctl_set_mm*".
- Moved untagging from __check_mem_type() to tee_shm_register().
- Updated untagging for the amdgpu and radeon drivers to cover the MMU
  notifier, as suggested by Felix.
- Since this ABI relaxation doesn't actually allow tagged instruction
  pointers, dropped the following patches:
- Dropped "tracing, arm64: untag user pointers in seq_print_user_ip".
- Dropped "uprobes, arm64: untag user pointers in find_active_uprobe".
- Dropped "bpf, arm64: untag user pointers in stack_map_get_build_id_offset".
- Rebased onto 5.1-rc7 (37624b58).

Changes in v13:
- Simplified untagging in tcp_zerocopy_receive().
- Looked at find_vma() callers in drivers/, which allowed to identify a
  few other places where untagging is needed.
- Added patch "mm, arm64: untag user pointers in get_vaddr_frames".
- Added patch "drm/amdgpu, arm64: untag user pointers in
  amdgpu_ttm_tt_get_user_pages".
- Added patch "drm/radeon, arm64: untag user pointers in
  radeon_ttm_tt_pin_userptr".
- Added patch "IB/mlx4, arm64: untag user pointers in mlx4_get_umem_mr".
- Added patch "media/v4l2-core, arm64: untag user pointers in
  videobuf_dma_contig_user_get".
- Added patch "tee/optee, arm64: untag user pointers in check_mem_type".
- Added patch "vfio/type1, arm64: untag user pointers".

Changes in v12:
- Changed untagging in tcp_zerocopy_receive() to also untag zc->address.
- Fixed untagging in prctl_set_mm* to only untag pointers for vma lookups
  and validity checks, but leave them as is for actual user space accesses.
- Updated the link to the v2 of the "arm64 relaxed ABI" patchset [3].
- Dropped the documentation patch, as the "arm64 relaxed ABI" patchset [3]
  handles that.

Changes in v11:
- Added "uprobes, arm64: untag user pointers in find_active_uprobe" patch.
- Added "bpf, arm64: untag user pointers in stack_map_get_build_id_offset"
  patch.
- Fixed "tracing, arm64: untag user pointers in seq_print_user_ip" to
  correctly perform subtration with a tagged addr.
- Moved untagged_addr() from SYSCALL_DEFINE3(mprotect) and
  SYSCALL_DEFINE4(pkey_mprotect) to do_mprotect_pkey().
- Moved untagged_addr() definition for other arches from
  include/linux/memory.h to include/linux/mm.h.
- Changed untagging in strn*_user() to perform userspace accesses through
  tagged pointers.
- Updated the documentation to mention that passing tagged pointers to
  memory syscalls is allowed.
- Updated the test to use malloc'ed memory instead of stack memory.

Changes in v10:
- Added "mm, arm64: untag user pointers passed to memory syscalls" back.
- New patch "fs, arm64: untag user pointers in fs/userfaultfd.c".
- New patch "net, arm64: untag user pointers in tcp_zerocopy_receive".
- New patch "kernel, arm64: untag user pointers in prctl_set_mm*".
- New patch "tracing, arm64: untag user pointers in seq_print_user_ip".

Changes in v9:
- Rebased onto 4.20-rc6.
- Used u64 instead of __u64 in type casts in the untagged_addr macro for
  arm64.
- Added braces around (addr) in the untagged_addr macro for other arches.

Changes in v8:
- Rebased onto 65102238 (4.20-rc1).
- Added a note to the cover letter on why syscall wrappers/shims that untag
  user pointers won't work.
- Added a note to the cover letter that this patchset has been merged into
  the Pixel 2 kernel tree.
- Documentation fixes, in particular added a list of syscalls that don't
  support tagged user pointers.

Changes in v7:
- Rebased onto 17b57b18 (4.19-rc6).
- Dropped the "arm64: untag user address in __do_user_fault" patch, since
  the existing patches already handle user faults properly.
- Dropped the "usb, arm64: untag user addresses in devio" patch, since the
  passed pointer must come from a vma and therefore be untagged.
- Dropped the "arm64: annotate user pointers casts detected by sparse"
  patch (see the discussion to the replies of the v6 of this patchset).
- Added more context to the cover letter.
- Updated Documentation/arm64/tagged-pointers.txt.

Changes in v6:
- Added annotations for user pointer casts found by sparse.
- Rebased onto 050cdc6c (4.19-rc1+).

Changes in v5:
- Added 3 new patches that add untagging to places found with static
  analysis.
- Rebased onto 44c929e1 (4.18-rc8).

Changes in v4:
- Added a selftest for checking that passing tagged pointers to the
  kernel succeeds.
- Rebased onto 81e97f013 (4.18-rc1+).

Changes in v3:
- Rebased onto e5c51f30 (4.17-rc6+).
- Added linux-arch@ to the list of recipients.

Changes in v2:
- Rebased onto 2d618bdf (4.17-rc3+).
- Removed excessive untagging in gup.c.
- Removed untagging pointers returned from __uaccess_mask_ptr.

Changes in v1:
- Rebased onto 4.17-rc1.

Changes in RFC v2:
- Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
  defining it for each arch individually.
- Updated Documentation/arm64/tagged-pointers.txt.
- Dropped "mm, arm64: untag user addresses in memory syscalls".
- Rebased onto 3eb2ce82 (4.16-rc7).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Andrey Konovalov (17):
  uaccess: add untagged_addr definition for other arches
  arm64: untag user pointers in access_ok and __uaccess_mask_ptr
  lib, arm64: untag user pointers in strn*_user
  mm: add ksys_ wrappers to memory syscalls
  arms64: untag user pointers passed to memory syscalls
  mm: untag user pointers in do_pages_move
  mm, arm64: untag user pointers in mm/gup.c
  mm, arm64: untag user pointers in get_vaddr_frames
  fs, arm64: untag user pointers in copy_mount_options
  fs, arm64: untag user pointers in fs/userfaultfd.c
  drm/amdgpu, arm64: untag user pointers
  drm/radeon, arm64: untag user pointers
  IB/mlx4, arm64: untag user pointers in mlx4_get_umem_mr
  media/v4l2-core, arm64: untag user pointers in
    videobuf_dma_contig_user_get
  tee, arm64: untag user pointers in tee_shm_register
  vfio/type1, arm64: untag user pointers in vaddr_get_pfn
  selftests, arm64: add a selftest for passing tagged pointers to kernel

 arch/arm64/include/asm/uaccess.h              |  10 +-
 arch/arm64/kernel/sys.c                       | 128 ++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   2 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |   2 +
 drivers/gpu/drm/radeon/radeon_ttm.c           |   2 +-
 drivers/infiniband/hw/mlx4/mr.c               |   7 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |   9 +-
 drivers/tee/tee_shm.c                         |   1 +
 drivers/vfio/vfio_iommu_type1.c               |   2 +
 fs/namespace.c                                |   2 +-
 fs/userfaultfd.c                              |   5 +
 include/linux/mm.h                            |   4 +
 include/linux/syscalls.h                      |  22 +++
 ipc/shm.c                                     |   7 +-
 lib/strncpy_from_user.c                       |   3 +-
 lib/strnlen_user.c                            |   3 +-
 mm/frame_vector.c                             |   2 +
 mm/gup.c                                      |   4 +
 mm/madvise.c                                  | 129 +++++++++---------
 mm/mempolicy.c                                |  21 ++-
 mm/migrate.c                                  |   1 +
 mm/mincore.c                                  |  57 ++++----
 mm/mlock.c                                    |  20 ++-
 mm/mmap.c                                     |  30 +++-
 mm/mprotect.c                                 |   6 +-
 mm/mremap.c                                   |  27 ++--
 mm/msync.c                                    |  35 +++--
 tools/testing/selftests/arm64/.gitignore      |   1 +
 tools/testing/selftests/arm64/Makefile        |  11 ++
 .../testing/selftests/arm64/run_tags_test.sh  |  12 ++
 tools/testing/selftests/arm64/tags_test.c     |  21 +++
 33 files changed, 431 insertions(+), 159 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

-- 
2.21.0.593.g511ec345e18-goog

