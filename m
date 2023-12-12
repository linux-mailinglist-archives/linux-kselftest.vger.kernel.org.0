Return-Path: <linux-kselftest+bounces-1760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8FE80FB26
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB451F21888
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 23:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5526473B;
	Tue, 12 Dec 2023 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LxeNw/v9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D317AF
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:11 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d03bcf27e9so39463195ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 15:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702423031; x=1703027831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5y8QYr+IjGzmB4C3pqLhk9PERDgJGoGDIvTpTZY5w0=;
        b=LxeNw/v9N0GjG4xjvWxK7YzAVbQFo3UbBajbgqaNcV2hPh2prTwyfxCzr7MxHUjvtA
         EhIzoU2I/h4SoZlUm/74Q3Kd4qSwpzvACFjZjgAL8gI5Ncd15GHNOGtuqYtKGF4UKQct
         Tf+JMU0evDltbrwfr5rx1K8zOtDXplaEUFXt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423031; x=1703027831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5y8QYr+IjGzmB4C3pqLhk9PERDgJGoGDIvTpTZY5w0=;
        b=VtfS7QWjkWbos4oI/sbmK7CCa256tDeSNcMGGbXFd3OspfuXkSXlgeQy8107A3I+NV
         iQmVpKFdYh2b/GWcc/U8gSjnftPwPWwGMdlfxF92qXdflpH5aduDVAIwhgdtOmqyB1se
         NPygldWT7wfnL5Zx3eLGwos8kknO+1WeIuSSo/W30I4Stb329+YBH5X3lE+tjNfMIBTU
         HA004nsGtiKH/v+gfu0rxjTi6WwKYDRSU8/ELaPQIyupCCAjy+TUzRqcWXXTRGJzQz6f
         pFHRdbfAN+hKPWveUR9lx4lZVfXA8MRMP409q50/6VoPt5+iHAuY0iKPIsz6tn6sufqV
         gtbw==
X-Gm-Message-State: AOJu0YxuQyxKuIhrew0CL0GXPv2fVOEcUgoUTeGPwnFsI9K0nxQxwbee
	6a9w3xy4GWtIAzYN4mfzNkMjVQ==
X-Google-Smtp-Source: AGHT+IHrZJZDIxN6AqNI2c5OJ2w1Jjj2qPgLDrNRTuM35VdRqiK0uGNMQLM/+GsfPmMdyAG3Bld6Cg==
X-Received: by 2002:a17:902:d512:b0:1d0:b6ca:e485 with SMTP id b18-20020a170902d51200b001d0b6cae485mr4047648plg.128.1702423030800;
        Tue, 12 Dec 2023 15:17:10 -0800 (PST)
Received: from localhost (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.gmail.com with UTF8SMTPSA id c10-20020a170903234a00b001d043588122sm9156891plh.142.2023.12.12.15.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 15:17:10 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
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
Subject: [RFC PATCH v3 00/11] Introduce mseal()
Date: Tue, 12 Dec 2023 23:16:54 +0000
Message-ID: <20231212231706.2680890-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

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

The new mseal() is an architecture independent syscall, and with
following signature:

mseal(void addr, size_t len, unsigned long types, unsigned long flags)

addr/len: memory range.  Must be continuous/allocated memory, or else
mseal() will fail and no VMA is updated. For details on acceptable
arguments, please refer to documentation patch (mseal.rst) of this
patch set. Those are also fully covered by the selftest.

types: bit mask to specify the sealing types.
MM_SEAL_BASE
MM_SEAL_PROT_PKEY
MM_SEAL_DISCARD_RO_ANON
MM_SEAL_SEAL

The MM_SEAL_BASE:
The base package includes the features common to all VMA sealing
types. It prevents sealed VMAs from:
1> Unmapping, moving to another location, and shrinking the size, via
munmap() and mremap(), can leave an empty space, therefore can be
replaced with a VMA with a new set of attributes.
2> Move or expand a different vma into the current location, via mremap().
3> Modifying sealed VMA via mmap(MAP_FIXED).
4> Size expansion, via mremap(), does not appear to pose any specific
risks to sealed VMAs. It is included anyway because the use case is
unclear. In any case, users can rely on merging to expand a sealed
VMA.

We consider the MM_SEAL_BASE feature, on which other sealing features
will depend. For instance, it probably does not make sense to seal
PROT_PKEY without sealing the BASE, and the kernel will implicitly add
SEAL_BASE for SEAL_PROT_PKEY.

The MM_SEAL_PROT_PKEY:
Seal PROT and PKEY of the address range, i.e. mprotect() and
pkey_mprotect() will be denied if the memory is sealed with
MM_SEAL_PROT_PKEY.

The MM_SEAL_DISCARD_RO_ANON
Certain types of madvise() operations are destructive [6], such as
MADV_DONTNEED, which can effectively alter region contents by
discarding pages, especially when memory is anonymous. This blocks
such operations for anonymous memory which is not writable to the
user.

The MM_SEAL_SEAL
MM_SEAL_SEAL denies adding a new seal for an VMA.
This is similar to F_SEAL_SEAL in fcntl.


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
- Add MAP_SEALABLE to mmap() (Detail see new discussions)
- Add documentation - mseal.rst

Work in progress:
=================
- update man page for mseal() and mmap()

Open discussions:
=================
Several open discussions from V1/V2 were not incorporated into V3. I
believe these are worth more discussion for future versions of this
patch series.

1> mseal() vs mimmutable()
mseal(bitmasks for multiple seal types)
	BASE + PROT_PKEY+ MM_SEAL_DISCARD_RO_ANON
        Apply PROT_PKEY implies BASE, same for DISCARD_RO_ANON

mimmutable() (openBSD)
        This is equal to SEAL_BASE + SEAL_PROT_PKEY in mseal()
        Plus allowing downgrade from W=>NW (OpenBSD)
        Doesn’t have MM_SEAL_DISCARD_RO_ANON

mimmutable() is designed for memory sealing in libc, and mseal()
is designed for both Chrome browser and libc.

For the two memory ranges that Chrome browser wants to seal, as
discussed previously, the allocator still needs to free or discard
memory for the sealed memory. For performance reasons, we have
explored two solutions in the past: first, using PKEY-based munmap()
[7], and second, separating SEAL_MPROTECT (v1 of this patch set).
Recently, we have experimented with an alternative approach that
allows us to remove the separation of SEAL_MPROTECT. For those two
memory ranges, Chrome browser will use BASE + PROT_PKEY +
DISCARD_RO_ANON for all its sealing needs.

In the case of libc, the .text segment can be sealed with the BASE and
PROT_PKEY, and the RO data segments can be sealed with the BASE +
PROT_PKEY + DISCARD_RO_ANON.

From a flexibility standpoint, separating BASE out could be beneficial
for future extensions of sealing features. For instance, applications
might desire downgradable "prot" permissions (X=>NX, W=>NW, R=>NR),
which would conflict with SEAL_PROT_PKEY.

The more sealing features integrated into a single sealing type, the
fewer applications can utilize these features. For example, some
applications might programmatically require DISCARD_RO_ANON memory,
which would render such VMA unsuitable for sealing.

I'd like to get the community's input on this. From Chrome's
perspective, the separation isn't as important anymore, at least in
the short term. However, I prefer the multiple bits approach because
it's more extensible in the long term.

2> mseal() vs mprotect() vs madvise() for setting the seal.

mprotect():
Using prot field, but prot supports unset. It's workable, i.e. let
applications carry the sealing type and set in all subsequent calls to
mprotect(), but it feels like this is an extra thing to care about.

madvise():
uses enum, multiple sealing types might require multiple roundtrips.

IMO: sealing is a major departure from other memory syscalls because
it takes away capabilities. The other memory APIs add behaviors or
change attributes, but sealing does the opposite: it reduces
capabilities. The name of the syscall, mseal(), can help emphasize the
"taking away" part.

My second choice would be madvise().

3> Other:

There is also a topic about ptrace/, /proc/self/mem, Userfaultfd,
which I think can be followed up using v1 thread, where it has the
most context.

New discussions topics:
=======================
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
There could be two solutions to address this, which I will discuss
later.

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
There are two options to address the problem mentioned above.
Option 1:  A “MAP_SEALABLE” flag in mmap().
If a map is created without this flag, the mseal() operation will
fail. Applications that are not concerned with sealing will expect
their behavior to be unchanged. For those that are concerned, adding a
flag at mmap time to opt in is not difficult. For the short term, this
solves problems 1 and 2 above. The memory in shm/aio/brk will not have
the MAP_SEALABLE flag at mmap(), and the same is true for the heap.

Option 2: Add MM_SEAL_SEAL during mmap()
It is possible to defensively set MM_SEAL_SEAL for the selected mappings at
creation time. Specifically, we can find all the mmaps that we do not want to
seal, and add the MM_SEAL_SEAL flag in the mmap() call. The difference
between MAP_SEALABLE and MM_SEAL_SEAL is that the first option starts from a
small size and incrementally increases, while the second option is the
opposite.

In my opinion, MAP_SEALABLE is the preferred option. Only a limited set of
mappings need to be sealed, and these are typically created by the runtime. For
the few dedicated applications that manage their own mappings, such as Chrome,
adding an extra flag at mmap() is not a difficult task. It is also a safer
option in terms of regression risk. This is the option included in this
version.

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

------------------------------------------------------------------------
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

Jeff Xu (11):
  mseal: Add mseal syscall.
  mseal: Wire up mseal syscall
  mseal: add can_modify_mm and can_modify_vma
  mseal: add MM_SEAL_BASE
  mseal: add MM_SEAL_PROT_PKEY
  mseal: add sealing support for mmap
  mseal: make sealed VMA mergeable.
  mseal: add MM_SEAL_DISCARD_RO_ANON
  mseal: add MAP_SEALABLE to mmap()
  selftest mm/mseal memory sealing
  mseal:add documentation

 Documentation/userspace-api/mseal.rst       |  189 ++
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
 arch/mips/kernel/vdso.c                     |   10 +-
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
 arch/s390/kernel/syscalls/syscall.tbl       |    1 +
 arch/sh/kernel/syscalls/syscall.tbl         |    1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
 fs/userfaultfd.c                            |    8 +-
 include/linux/mm.h                          |  178 +-
 include/linux/mm_types.h                    |    8 +
 include/linux/syscalls.h                    |    2 +
 include/uapi/asm-generic/mman-common.h      |   16 +
 include/uapi/asm-generic/unistd.h           |    5 +-
 include/uapi/linux/mman.h                   |    5 +
 kernel/sys_ni.c                             |    1 +
 mm/Kconfig                                  |    9 +
 mm/Makefile                                 |    1 +
 mm/madvise.c                                |   14 +-
 mm/mempolicy.c                              |    2 +-
 mm/mlock.c                                  |    2 +-
 mm/mmap.c                                   |   77 +-
 mm/mprotect.c                               |   12 +-
 mm/mremap.c                                 |   44 +-
 mm/mseal.c                                  |  376 ++++
 tools/testing/selftests/mm/.gitignore       |    1 +
 tools/testing/selftests/mm/Makefile         |    1 +
 tools/testing/selftests/mm/config           |    1 +
 tools/testing/selftests/mm/mseal_test.c     | 2141 +++++++++++++++++++
 41 files changed, 3091 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/userspace-api/mseal.rst
 create mode 100644 mm/mseal.c
 create mode 100644 tools/testing/selftests/mm/mseal_test.c

-- 
2.43.0.472.g3155946c3a-goog


