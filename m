Return-Path: <linux-kselftest+bounces-2638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC49E824862
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 19:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F421F23071
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 18:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511A28E27;
	Thu,  4 Jan 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iYF+AHN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A732528E14
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Jan 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so579331a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Jan 2024 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704394306; x=1704999106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXcAixOgj5wC6KzcQWhj3DdvTpZWvVXGr41CZAGmtyc=;
        b=iYF+AHN1BmR4GEG3XyjJPLMW6brIbLOta6YzKvy8ifpUGAondiu8OZ6oenZqGXBb9R
         Dvtsge2D9/ccEYz5NjEr3X9AYyI+vhEUSqv3G2CNrGdM/em5v66VtA+S70SdRQ0Ufs1S
         9rKPW08Meq7pkDdd9SPKKg582Q6iTpsjhFDLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704394306; x=1704999106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXcAixOgj5wC6KzcQWhj3DdvTpZWvVXGr41CZAGmtyc=;
        b=B0r0bt+hgX+WwUZ81+aSQoZ9atuZwYEtdXdMr3zwACaeFk7N5oz5VYC4fK59rV+/aY
         t9PqOg/y9EJ5aToWCGGkWyCx+nlZgRoEeNdWLXEc7h7u6owvIO2qWZUId/sXANq0c4dO
         b6iZODHV3IDgvK8EWyBzruYsTL1SQ97AAyXjrEtcncUlM1gjMsogQ5oX8ZuAO3GjMrfC
         k0MqbOIsLBeUcXsTfYN6WAgpF5NfLjm6RlPIySkaL1oqohFwBjTsSp58s779zm8QPgdu
         izaPO9nL+pah6+NW4riJ4l/T7bmsi7+tUquFMyolf15B2FVn5oba7CFkD4Pn/NhcTV6n
         mJGw==
X-Gm-Message-State: AOJu0Yy3h5ufl6yCDfvuyVJ2N+ho8tbDuttj0Ed92UInAmnKGGS+gSLa
	3j8zlY6m8VBepNZC5DcSjwPWh2l2CFHr
X-Google-Smtp-Source: AGHT+IFwExAyWQESGL8nxH3IbtD5xl/544q4DUNQhpF6xFlhqlALjkjYBABWn4o5fppBtda9VLD1uQ==
X-Received: by 2002:a05:6a20:2584:b0:197:5779:4d26 with SMTP id k4-20020a056a20258400b0019757794d26mr1066925pzd.64.1704394305805;
        Thu, 04 Jan 2024 10:51:45 -0800 (PST)
Received: from localhost (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.gmail.com with UTF8SMTPSA id u7-20020a056a00124700b006d96d034befsm24782446pfi.30.2024.01.04.10.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 10:51:45 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pedro.falcato@gmail.com,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	deraadt@openbsd.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v4 0/4] Introduce mseal()
Date: Thu,  4 Jan 2024 18:51:33 +0000
Message-ID: <20240104185138.169307-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is V4 of the patch, the patch has improved significantly since V1,
thanks to diverse inputs, a few discussions remain, please read those
in the open discussion section of v4 of change history.

-----------------------------------------------------------------
This patchset proposes a new mseal() syscall for the Linux kernel.

In a nutshell, mseal() protects the VMAs of a given virtual memory
range against modifications, such as changes to their permission bits.

Modern CPUs support memory permissions, such as the read/write (RW)
and no-execute (NX) bits. Linux has supported NX since the release of
kernel version 2.6.8 in August 2004 [1]. The memory permission feature
improves the security stance on memory corruption bugs, as an attacker
cannot simply write to arbitrary memory and point the code to it. The
memory must be marked with the X bit, or else an exception will occur.
Internally, the kernel maintains the memory permissions in a data
structure called VMA (vm_area_struct). mseal() additionally protects
the VMA itself against modifications of the selected seal type.

Memory sealing is useful to mitigate memory corruption issues where a
corrupted pointer is passed to a memory management system. For
example, such an attacker primitive can break control-flow integrity
guarantees since read-only memory that is supposed to be trusted can
become writable or .text pages can get remapped. Memory sealing can
automatically be applied by the runtime loader to seal .text and
.rodata pages and applications can additionally seal security critical
data at runtime. A similar feature already exists in the XNU kernel
with the VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the
mimmutable syscall [4]. Also, Chrome wants to adopt this feature for
their CFI work [2] and this patchset has been designed to be
compatible with the Chrome use case.

Two system calls are involved in sealing the map:  mmap() and mseal().

The new mseal() is an syscall on 64 bit CPU, and with
following signature:

int mseal(void addr, size_t len, unsigned long flags)
addr/len: memory range.
flags: reserved.

mseal() blocks following operations for the given memory range.

1> Unmapping, moving to another location, and shrinking the size,
   via munmap() and mremap(), can leave an empty space, therefore can
   be replaced with a VMA with a new set of attributes.

2> Moving or expanding a different VMA into the current location,
   via mremap().

3> Modifying a VMA via mmap(MAP_FIXED).

4> Size expansion, via mremap(), does not appear to pose any specific
   risks to sealed VMAs. It is included anyway because the use case is
   unclear. In any case, users can rely on merging to expand a sealed VMA.

5> mprotect() and pkey_mprotect().

6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonymous
   memory, when users don't have write permission to the memory. Those
   behaviors can alter region contents by discarding pages, effectively a
   memset(0) for anonymous memory.

In addition: mmap() has two related changes.

The PROT_SEAL bit in prot field of mmap(). When present, it marks
the map sealed since creation.

The MAP_SEALABLE bit in the flags field of mmap(). When present, it marks
the map as sealable. A map created without MAP_SEALABLE will not support
sealing, i.e. mseal() will fail.

Applications that don't care about sealing will expect their behavior
unchanged. For those that need sealing support, opt-in by adding
MAP_SEALABLE in mmap().

The idea that inspired this patch comes from Stephen Röttger’s work in
V8 CFI [5]. Chrome browser in ChromeOS will be the first user of this
API.

Indeed, the Chrome browser has very specific requirements for sealing,
which are distinct from those of most applications. For example, in
the case of libc, sealing is only applied to read-only (RO) or
read-execute (RX) memory segments (such as .text and .RELRO) to
prevent them from becoming writable, the lifetime of those mappings
are tied to the lifetime of the process.

Chrome wants to seal two large address space reservations that are
managed by different allocators. The memory is mapped RW- and RWX
respectively but write access to it is restricted using pkeys (or in
the future ARM permission overlay extensions). The lifetime of those
mappings are not tied to the lifetime of the process, therefore, while
the memory is sealed, the allocators still need to free or discard the
unused memory. For example, with madvise(DONTNEED).

However, always allowing madvise(DONTNEED) on this range poses a
security risk. For example if a jump instruction crosses a page
boundary and the second page gets discarded, it will overwrite the
target bytes with zeros and change the control flow. Checking
write-permission before the discard operation allows us to control
when the operation is valid. In this case, the madvise will only
succeed if the executing thread has PKEY write permissions and PKRU
changes are protected in software by control-flow integrity.

Although the initial version of this patch series is targeting the
Chrome browser as its first user, it became evident during upstream
discussions that we would also want to ensure that the patch set
eventually is a complete solution for memory sealing and compatible
with other use cases. The specific scenario currently in mind is
glibc's use case of loading and sealing ELF executables. To this end,
Stephen is working on a change to glibc to add sealing support to the
dynamic linker, which will seal all non-writable segments at startup.
Once this work is completed, all applications will be able to
automatically benefit from these new protections.

--------------------------------------------------------------------
Change history:
===============
V4:
(Suggested by Linus Torvalds)
- new signature: mseal(start,len,flags)
- 32 bit is not supported. vm_seal is removed, use vm_flags instead.
- single bit in vm_flags for sealed state.
- CONFIG_MSEAL kernel config is removed.
- single bit of PROT_SEAL in the "Prot" field of mmap().
Other changes:
- update selftest (Suggested by Muhammad Usama Anjum)
- update documentation.

Open discussions:
=================
Below discussion were brought up in V3, and did not receive any input:
the one important to this patch is MAP_SEALABLE in mmap(), which is in
current version of patch, list here for input/comments.

---------------------------------------------------------------------

During the development of V3, I had new questions and thoughts and
wished to discuss.

1> shm/aio
From reading the code, it seems to me that aio/shm can mmap/munmap
maps on behalf of userspace, e.g. ksys_shmdt() in shm.c. The lifetime
of those mapping are not tied to the lifetime of the process. If those
memories are sealed from userspace, then unmap will fail. This isn’t a
huge problem, since the memory will eventually be freed at exit or
exec. However, it feels like the solution is not complete, because of
the leaks in VMA address space during the lifetime of the process.

2> Brk (heap/stack)
Currently, userspace applications can seal parts of the heap by
calling malloc() and mseal(). This raises the question of what the
expected behavior is when sealing the heap is attempted.

let's assume following calls from user space:

ptr = malloc(size);
mprotect(ptr, size, RO);
mseal(ptr, size, SEAL_PROT_PKEY);
free(ptr);

Technically, before mseal() is added, the user can change the
protection of the heap by calling mprotect(RO). As long as the user
changes the protection back to RW before free(), the memory can be
reused.

Adding mseal() into picture, however, the heap is then sealed
partially, user can still free it, but the memory remains to be RO,
and the result of brk-shrink is nondeterministic, depending on if
munmap() will try to free the sealed memory.(brk uses munmap to shrink
the heap).

3> Above two cases led to the third topic:
There one option to address the problem mentioned above.
Option 1:  A “MAP_SEALABLE” flag in mmap().
If a map is created without this flag, the mseal() operation will
fail. Applications that are not concerned with sealing will expect
their behavior to be unchanged. For those that are concerned, adding a
flag at mmap time to opt in is not difficult. For the short term, this
solves problems 1 and 2 above. The memory in shm/aio/brk will not have
the MAP_SEALABLE flag at mmap(), and the same is true for the heap.

If we choose not to go with path, all mapping will by default
sealable. We could document above mentioned limitations so devs are
more careful at the time to choose what memory to seal. I think
deny of service through mseal() by attacker is probably not a concern,
if attackers have access to mseal() and unsealed memory, then they can 
also do other harmful thing to the memory, such as munmap, etc.

4>
I think it might be possible to seal the stack or other special
mappings created at runtime (vdso, vsyscall, vvar). This means we can
enforce and seal W^X for certain types of application. For instance,
the stack is typically used in read-write mode, but in some cases, it
can become executable. To defend against unintented addition of executable
bit to stack, we could let the application to seal it. 

Sealing the heap (for adding X) requires special handling, since the
heap can shrink, and shrink is implemented through munmap().

Indeed, it might be possible that all virtual memory accessible to user
space, regardless of its usage pattern, could be sealed. However, this
would require additional research and development work.

=====================================================================

V3:
- Abandon per-syscall approach, (Suggested by Linus Torvalds).
- Organize sealing types around their functionality, such as
  MM_SEAL_BASE, MM_SEAL_PROT_PKEY.
- Extend the scope of sealing from calls originated in userspace to
  both kernel and userspace. (Suggested by Linus Torvalds)
- Add seal type support in mmap(). (Suggested by Pedro Falcato)
- Add a new sealing type: MM_SEAL_DISCARD_RO_ANON to prevent
  destructive operations of madvise. (Suggested by Jann Horn and
  Stephen Röttger)
- Make sealed VMAs mergeable. (Suggested by Jann Horn)
- Add MAP_SEALABLE to mmap()
- Add documentation - mseal.rst
https://lore.kernel.org/linux-mm/20231212231706.2680890-2-jeffxu@chromium.org/

v2:
Use _BITUL to define MM_SEAL_XX type.
Use unsigned long for seal type in sys_mseal() and other functions.
Remove internal VM_SEAL_XX type and convert_user_seal_type().
Remove MM_ACTION_XX type.
Remove caller_origin(ON_BEHALF_OF_XX) and replace with sealing bitmask.
Add more comments in code.
Add a detailed commit message.
https://lore.kernel.org/lkml/20231017090815.1067790-1-jeffxu@chromium.org/

v1:
https://lore.kernel.org/lkml/20231016143828.647848-1-jeffxu@chromium.org/

----------------------------------------------------------------
[1] https://kernelnewbies.org/Linux_2_6_8
[2] https://v8.dev/blog/control-flow-integrity
[3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
[4] https://man.openbsd.org/mimmutable.2
[5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
[6] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com/
[7] https://lore.kernel.org/lkml/20230515130553.2311248-1-jeffxu@chromium.org/

Jeff Xu (4):
  mseal: Wire up mseal syscall
  mseal: add mseal syscall
  selftest mm/mseal memory sealing
  mseal:add documentation

 Documentation/userspace-api/mseal.rst       |  181 ++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
 arch/arm/tools/syscall.tbl                  |    1 +
 arch/arm64/include/asm/unistd.h             |    2 +-
 arch/arm64/include/asm/unistd32.h           |    2 +
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
 include/linux/mm.h                          |   60 +
 include/linux/syscalls.h                    |    1 +
 include/uapi/asm-generic/mman-common.h      |    7 +
 include/uapi/asm-generic/unistd.h           |    5 +-
 kernel/sys_ni.c                             |    1 +
 mm/Makefile                                 |    4 +
 mm/madvise.c                                |   12 +
 mm/mmap.c                                   |   27 +
 mm/mprotect.c                               |   10 +
 mm/mremap.c                                 |   31 +
 mm/mseal.c                                  |  330 ++++
 tools/testing/selftests/mm/.gitignore       |    1 +
 tools/testing/selftests/mm/Makefile         |    1 +
 tools/testing/selftests/mm/mseal_test.c     | 1971 +++++++++++++++++++
 32 files changed, 2659 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/userspace-api/mseal.rst
 create mode 100644 mm/mseal.c
 create mode 100644 tools/testing/selftests/mm/mseal_test.c

-- 
2.43.0.195.gebba966016-goog


