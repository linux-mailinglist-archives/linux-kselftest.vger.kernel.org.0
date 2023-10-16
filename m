Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC67CABAB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjJPOi5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjJPOi4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 10:38:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76DEB
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:38:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so1199763b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467134; x=1698071934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OG3B8TvIG+IjDlegATi+HkokBbcU++AzacD+iwBqjGw=;
        b=XLCypQYzDshaK7W8lkeVjd2GjCscUOT/q2KVS25jvmwe7bFeXvR2KAGXlqx15Urigp
         irxzR/xov0n3BGTsXTGgpY4Q3BgZjgI+lzXpjAxZQ3qH4Za9oe6vDPJIh85zMu/2BbCk
         MITuaFCXv/UxfAZeVC+4IkdSH8nWjxCbAnJmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467134; x=1698071934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OG3B8TvIG+IjDlegATi+HkokBbcU++AzacD+iwBqjGw=;
        b=mpv7QBXVB3Q2/+kKt9Rq/dApKC/2AelVf8CQt2RHAGXJItmSvVpsogR9AWqw9I1JW6
         DPpwcOykY9OohAcgLld3gS0s3DJ40Gb3QMr8W/DMXUm7ZlLuL/a1cnnhwjGEoN4tb2rk
         n6GnMMgiixs2g7t/B/TwJcJYGvDGntkN49YVFwKQpDA+TZo+wKey/d1AgYEfbIfQLAmZ
         upkO7nSfZHRiJj1aw4zio5pm20tGLigr/1fdJlO2YcpijRzINgL8e7whZ/CTKn+5+0H1
         XL0B3p1fPgLF56scGFH32K01outrhXQGLWLqoB813h/s51v9nH8i5EN2/wsF3RT6b79A
         Acdw==
X-Gm-Message-State: AOJu0YzmLjPER+8Ig+O5RFiIuwW0pVamP9wS5QkHYgf/klbi9DldvEy/
        dZ7/t6UHwSFaRMyFej5FMWyGxw==
X-Google-Smtp-Source: AGHT+IH9aWlYzhBaTPVLTRWv5Tf9e7BovSSNCFQrVwMGVHwa/T0CfgnjC+Zci9bojL5+5c4/ATIZOA==
X-Received: by 2002:a05:6a20:4287:b0:16b:aad0:effe with SMTP id o7-20020a056a20428700b0016baad0effemr27827286pzj.62.1697467133493;
        Mon, 16 Oct 2023 07:38:53 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id s20-20020a63af54000000b005b6c1972c99sm2697786pgo.7.2023.10.16.07.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:38:53 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v1 0/8] Introduce mseal() syscall
Date:   Mon, 16 Oct 2023 14:38:19 +0000
Message-ID: <20231016143828.647848-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
else an exception will happen.

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

mseal(void addr, size_t len, unsigned int types, unsigned int flags)

addr/len: memory range.  Must be continuous/allocated memory, or else
mseal() will fail and no VMA is updated. For details on acceptable
arguments, please refer to comments in mseal.c. Those are also fully
covered by the selftest.

types: bit mask to specify which syscall to seal, currently they are:
MM_SEAL_MSEAL 0x1
MM_SEAL_MPROTECT 0x2
MM_SEAL_MUNMAP 0x4
MM_SEAL_MMAP 0x8
MM_SEAL_MREMAP 0x10

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
will be updated. It might be worth noting that this is different from the
rest of mprotect(), where some updates can happen even when mprotect
returns fail. Consider can_modify_mm only checks vm_seals in
vm_area_struct, and it is not going deeper in the page table or updating
any HW, success or none behavior might fit better here. I would like to
listen to the community's feedback on this.

The idea that inspired this patch comes from Stephen Röttger’s work in
V8 CFI [5],  Chrome browser in ChromeOS will be the first user of this API.

In addition, Stephen is working on glibc change to add sealing support
into the dynamic linker to seal all non-writable segments at startup. When
that work is completed, all applications can automatically benefit from
these new protections.

[1] https://kernelnewbies.org/Linux_2_6_8
[2] https://v8.dev/blog/control-flow-integrity
[3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
[4] https://man.openbsd.org/mimmutable.2
[5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc

Jeff Xu (8):
  Add mseal syscall
  Wire up mseal syscall
  mseal: add can_modify_mm and can_modify_vma
  mseal: seal mprotect
  mseal munmap
  mseal mremap
  mseal mmap
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
 include/linux/mm.h                          |   55 +-
 include/linux/mm_types.h                    |    7 +
 include/linux/syscalls.h                    |    2 +
 include/uapi/asm-generic/unistd.h           |    5 +-
 include/uapi/linux/mman.h                   |    6 +
 ipc/shm.c                                   |    3 +-
 kernel/sys_ni.c                             |    1 +
 mm/Kconfig                                  |    8 +
 mm/Makefile                                 |    1 +
 mm/internal.h                               |    4 +-
 mm/mmap.c                                   |   49 +-
 mm/mprotect.c                               |    6 +
 mm/mremap.c                                 |   19 +-
 mm/mseal.c                                  |  328 +++++
 mm/nommu.c                                  |    6 +-
 mm/util.c                                   |    8 +-
 tools/testing/selftests/mm/Makefile         |    1 +
 tools/testing/selftests/mm/mseal_test.c     | 1428 +++++++++++++++++++
 37 files changed, 1934 insertions(+), 28 deletions(-)
 create mode 100644 mm/mseal.c
 create mode 100644 tools/testing/selftests/mm/mseal_test.c

-- 
2.42.0.609.gbb76f46606-goog

