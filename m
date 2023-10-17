Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A57CBE79
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjJQJIW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjJQJIV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:08:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1FF5
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c9de3f66e5so32351575ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697533699; x=1698138499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKe+Swi2W96ZVVpAOWJ7tIG0DZ/U4YWWNdOm8VCrWW4=;
        b=INFvMeNAB6nQBL6mwTFadFs9yikgqLdGi7u4xUHJS2ItGygHbcLLqjw2rlrLR6TXlO
         S9vl3uUwtl29qpp3hnNs7erSjn2ja8UtIQiZkrDYzFYlNEg/jzVzmRXwIa+DKBVp9D+9
         c0v0pOcutih4KA7VhyV5EDT4AVpY7ckvbjygo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533699; x=1698138499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKe+Swi2W96ZVVpAOWJ7tIG0DZ/U4YWWNdOm8VCrWW4=;
        b=M3PyEX70BCnEigdMafiP0IAwx9Qsyd/czihmqz36d3hBypis+Euzy0+9H+6mH13MoW
         LPJjUzO0tuUG5Eu/o1p2uFlabFx73EaJhyRXbM1R5rJHJ9Olwwayp/vbHPMUNljuo4ME
         dPjeIqnMvuAu1jpuHbUc4F8ZRAJYU/mERZlEVauEqznxO8bQYdsSI6wX1eItNpTGIkhi
         4hayZtn1LUGfUDNESmHnKUNDg+CzcwAvV7KrQFnpKPXq/kPTt1VNBIMVfUrePlFUqCne
         ExDXiABV5FO+GMgF3cXafr3Bp8/iPXgwQSEvcMn4V+xhzckvgfY1oKO1hZiycGbitIwr
         WQhA==
X-Gm-Message-State: AOJu0Yx2/dQhlmKTWUIqUs2Cu6W5tGHMsK7IqR6mZoLAvZpqkuv/tGdB
        81+xp05vh6YiQR9MUebDbedErg==
X-Google-Smtp-Source: AGHT+IEPy4Me5e678QQykxBsBj+vOH1BHbZ6OezSWsHSR8bPfqV1m1EDzruY9mDJY9RLscrPzqb29g==
X-Received: by 2002:a17:903:110d:b0:1b9:e972:134d with SMTP id n13-20020a170903110d00b001b9e972134dmr1496389plh.3.1697533698525;
        Tue, 17 Oct 2023 02:08:18 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id m17-20020a170902db1100b001c3e732b8dbsm996886plx.168.2023.10.17.02.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:18 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v2 0/8] Introduce mseal() syscall
Date:   Tue, 17 Oct 2023 09:08:07 +0000
Message-ID: <20231017090815.1067790-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

This patchset proposes a new mseal() syscall for the Linux kernel.

Modern CPUs support memory permissions such as RW and NX bits. Linux has
supported NX since the release of kernel version 2.6.8 in August 2004 [1].
The memory permission feature improves security stance on memory
corruption bugs, i.e. the attacker can’t just write to arbitrary memory
and point the code to it, the memory has to be marked with X bit, or
else an exception will happen. The protection is set by mmap(2),
mprotect(2), mremap(2).

Memory sealing additionally protects the mapping itself against
modifications. This is useful to mitigate memory corruption issues where
a corrupted pointer is passed to a memory management syscall. For example,
such an attacker primitive can break control-flow integrity guarantees
since read-only memory that is supposed to be trusted can become writable
or .text pages can get remapped. Memory sealing can automatically be
applied by the runtime loader to seal .text and .rodata pages and
applications can additionally seal security critical data at runtime.
A similar feature already exists in the XNU kernel with the
VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscall [4].
Also, Chrome wants to adopt this feature for their CFI work [2] and this
patchset has been designed to be compatible with the Chrome use case.

The new mseal() is an architecture independent syscall, and with
following signature:

mseal(void addr, size_t len, unsigned long types, unsigned long flags)

addr/len: memory range.  Must be continuous/allocated memory, or else
mseal() will fail and no VMA is updated. For details on acceptable
arguments, please refer to comments in mseal.c. Those are also fully
covered by the selftest.

types: bit mask to specify which syscall to seal.

Five syscalls can be sealed, as specified by bitmasks:
MM_SEAL_MPROTECT: Deny mprotect(2)/pkey_mprotect(2).
MM_SEAL_MUNMAP: Deny munmap(2).
MM_SEAL_MMAP: Deny mmap(2).
MM_SEAL_MREMAP: Deny mremap(2).
MM_SEAL_MSEAL: Deny adding a new seal type.

Each bit represents sealing for one specific syscall type, e.g.
MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitmask
is that the API is extendable, i.e. when needed, the sealing can be
extended to madvise, mlock, etc. Backward compatibility is also easy.

The kernel will remember which seal types are applied, and the application
doesn’t need to repeat all existing seal types in the next mseal().  Once
a seal type is applied, it can’t be unsealed. Call mseal() on an existing
seal type is a no-action, not a failure.

MM_SEAL_MSEAL will deny mseal() calls that try to add a new seal type.

Internally, vm_area_struct adds a new field vm_seals, to store the bit
masks.

For the affected syscalls, such as mprotect, a check(can_modify_mm) for
sealing is added, this usually happens at the early point of the syscall,
before any update is made to VMAs. The effect of that is: if any of the
VMAs in the given address range fails the sealing check, none of the VMA
will be updated.

The idea that inspired this patch comes from Stephen Röttger’s work in
V8 CFI [5],  Chrome browser in ChromeOS will be the first user of this API.

[1] https://kernelnewbies.org/Linux_2_6_8 
[2] https://v8.dev/blog/control-flow-integrity 
[3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274 
[4] https://man.openbsd.org/mimmutable.2 
[5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc 
 
PATCH history:

v1:
Use _BITUL to define MM_SEAL_XX type.
Use unsigned long for seal type in sys_mseal() and other functions.
Remove internal VM_SEAL_XX type and convert_user_seal_type().
Remove MM_ACTION_XX type.
Remove caller_origin(ON_BEHALF_OF_XX) and replace with sealing bitmask.
Add more comments in code.
Add detailed commit message.

v0:
https://lore.kernel.org/lkml/20231016143828.647848-1-jeffxu@chromium.org/

Jeff Xu (8):
  mseal: Add mseal(2) syscall.
  mseal: Wire up mseal syscall
  mseal: add can_modify_mm and can_modify_vma
  mseal: Check seal flag for mprotect(2)
  mseal: Check seal flag for munmap(2)
  mseal: Check seal flag for mremap(2)
  mseal:Check seal flag for mmap(2)
  selftest mm/mseal mprotect/munmap/mremap/mmap

 arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
 arch/arm/tools/syscall.tbl                  |    1 +
 arch/arm64/include/asm/unistd.h             |    2 +-
 arch/arm64/include/asm/unistd32.h           |    2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
 arch/s390/kernel/syscalls/syscall.tbl       |    1 +
 arch/sh/kernel/syscalls/syscall.tbl         |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
 fs/aio.c                                    |    5 +-
 include/linux/mm.h                          |   44 +-
 include/linux/mm_types.h                    |    7 +
 include/linux/syscalls.h                    |    2 +
 include/uapi/asm-generic/unistd.h           |    5 +-
 include/uapi/linux/mman.h                   |    6 +
 ipc/shm.c                                   |    3 +-
 kernel/sys_ni.c                             |    1 +
 mm/Kconfig                                  |    8 +
 mm/Makefile                                 |    1 +
 mm/internal.h                               |    4 +-
 mm/mmap.c                                   |   57 +-
 mm/mprotect.c                               |   15 +
 mm/mremap.c                                 |   30 +-
 mm/mseal.c                                  |  268 ++++
 mm/nommu.c                                  |    6 +-
 mm/util.c                                   |    8 +-
 tools/testing/selftests/mm/Makefile         |    1 +
 tools/testing/selftests/mm/mseal_test.c     | 1428 +++++++++++++++++++
 37 files changed, 1891 insertions(+), 28 deletions(-)
 create mode 100644 mm/mseal.c
 create mode 100644 tools/testing/selftests/mm/mseal_test.c

-- 
2.42.0.655.g421f12c284-goog

