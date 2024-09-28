Return-Path: <linux-kselftest+bounces-18532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18398910A
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E8F1F2193C
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2024 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8F14F135;
	Sat, 28 Sep 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UNsLitGK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19BC2AEEE;
	Sat, 28 Sep 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727548116; cv=none; b=TZC9k0GPJlD5wgK8r9DFxlYR1OlcCjyuWurHiPzCut9BCbXIz1QhzvcaFNIHVIGeKvFseSpRbrnMIY4lYU0BTVNNZIMmdvjIv3H4rlw5TPsE5V+Hv1fV04QuLRPb9FJcaoesA+ffK9xV61mQJi6FmX2cu+m1ZUD4Qi8hbo6n9sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727548116; c=relaxed/simple;
	bh=3fpdki5/ICS1qNzg5oA8KwiZpQoL0BQCLzpnw1ITvsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOFs0gdRvpx0enPnAiihY+eZfiKj8zcm5zaT0e68uEkt8FUm3JKX96g2A/yrKQ7GI1g0QSC6S9j38KvwC41f3MdySEh5QpZbDM8St2c+rTEM5FMkzuV+T6MaY3lmIHED9ID8Mt8DRzAzHOfW3pZBj3HoI8z2ywtYZULFaAvEdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UNsLitGK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=V+9LfybIwIck4AhikQa6dEmZGnSm3uZ83KznMUGroo8=; b=UNsLitGKp/pQ1/xxaZpIZO0FUN
	jD0Ol6wAoGd1v0c2uQe+I0sqmrbYYnodPbcL+rP/WUs9pFCFWLqp/hw+/F4gqLQoppwwnWehinu25
	ql1nwPXp6lwcmBj1CBQHUyahHRykL2MwvGbYj/zwK1FQUMbO4jK1r/T2ONYphJTubxXOi8h7BMD6n
	e1LoONQhLB/kEO5dNsg3hw4PwyX0O9h9hb4zyOXX7yaGAYykufFZreKVckbJ43BG5gvS/zt7aaW4E
	YcR51xjg+ye/PmHBdqevSLiMuw2zegNoqy0sDkI6f8LigMUk1h7FUCoCj+PaPzit/x/9U48HqHw+G
	NiGQrfqw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sucB1-00000002XxV-3koC;
	Sat, 28 Sep 2024 18:28:20 +0000
Message-ID: <b7864e63-bb74-4ab2-a7ae-48662b27e234@infradead.org>
Date: Sat, 28 Sep 2024 11:28:10 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 corbet@lwn.net
Cc: jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, jannh@google.com, sroettger@google.com,
 pedro.falcato@gmail.com, linux-hardening@vger.kernel.org,
 willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, deraadt@openbsd.org,
 usama.anjum@collabora.com, surenb@google.com, merimus@google.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, enh@google.com
References: <20240927185211.729207-1-jeffxu@chromium.org>
 <20240927185211.729207-2-jeffxu@chromium.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240927185211.729207-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/27/24 11:52 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Update doc after in-loop change: mprotect/madvise can have
> partially updated and munmap is atomic.
> 
> Fix indentation and clarify some sections to improve readability.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 290 ++++++++++++--------------
>  1 file changed, 136 insertions(+), 154 deletions(-)
> 
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index 4132eec995a3..68986084e191 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -23,177 +23,159 @@ applications can additionally seal security critical data at runtime.
>  A similar feature already exists in the XNU kernel with the
>  VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [2].
>  
> -User API
> -========
> -mseal()
> ------------
> -The mseal() syscall has the following signature:
> -
> -``int mseal(void addr, size_t len, unsigned long flags)``
> -
> -**addr/len**: virtual memory address range.
> -
> -The address range set by ``addr``/``len`` must meet:
> -   - The start address must be in an allocated VMA.
> -   - The start address must be page aligned.
> -   - The end address (``addr`` + ``len``) must be in an allocated VMA.
> -   - no gap (unallocated memory) between start and end address.
> -
> -The ``len`` will be paged aligned implicitly by the kernel.
> -
> -**flags**: reserved for future use.
> -
> -**return values**:
> -
> -- ``0``: Success.
> -
> -- ``-EINVAL``:
> -    - Invalid input ``flags``.
> -    - The start address (``addr``) is not page aligned.
> -    - Address range (``addr`` + ``len``) overflow.
> -
> -- ``-ENOMEM``:
> -    - The start address (``addr``) is not allocated.
> -    - The end address (``addr`` + ``len``) is not allocated.
> -    - A gap (unallocated memory) between start and end address.
> -
> -- ``-EPERM``:
> -    - sealing is supported only on 64-bit CPUs, 32-bit is not supported.
> -
> -- For above error cases, users can expect the given memory range is
> -  unmodified, i.e. no partial update.
> -
> -- There might be other internal errors/cases not listed here, e.g.
> -  error during merging/splitting VMAs, or the process reaching the max
> -  number of supported VMAs. In those cases, partial updates to the given
> -  memory range could happen. However, those cases should be rare.
> -
> -**Blocked operations after sealing**:
> -    Unmapping, moving to another location, and shrinking the size,
> -    via munmap() and mremap(), can leave an empty space, therefore
> -    can be replaced with a VMA with a new set of attributes.
> -
> -    Moving or expanding a different VMA into the current location,
> -    via mremap().
> -
> -    Modifying a VMA via mmap(MAP_FIXED).
> -
> -    Size expansion, via mremap(), does not appear to pose any
> -    specific risks to sealed VMAs. It is included anyway because
> -    the use case is unclear. In any case, users can rely on
> -    merging to expand a sealed VMA.
> -
> -    mprotect() and pkey_mprotect().
> -
> -    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
> -    for anonymous memory, when users don't have write permission to the
> -    memory. Those behaviors can alter region contents by discarding pages,
> -    effectively a memset(0) for anonymous memory.
> -
> -    Kernel will return -EPERM for blocked operations.
> -
> -    For blocked operations, one can expect the given address is unmodified,
> -    i.e. no partial update. Note, this is different from existing mm
> -    system call behaviors, where partial updates are made till an error is
> -    found and returned to userspace. To give an example:
> -
> -    Assume following code sequence:
> -
> -    - ptr = mmap(null, 8192, PROT_NONE);
> -    - munmap(ptr + 4096, 4096);
> -    - ret1 = mprotect(ptr, 8192, PROT_READ);
> -    - mseal(ptr, 4096);
> -    - ret2 = mprotect(ptr, 8192, PROT_NONE);
> -
> -    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
> -
> -    ret2 will be -EPERM, the page remains to be PROT_READ.
> -
> -**Note**:
> -
> -- mseal() only works on 64-bit CPUs, not 32-bit CPU.
> -
> -- users can call mseal() multiple times, mseal() on an already sealed memory
> -  is a no-action (not error).
> -
> -- munseal() is not supported.
> +SYSCALL
> +=======
> +mseal syscall signature
> +-----------------------
> +   **int** mseal(**void \*** addr, **size_t** len, **unsigned long** flags)

ugh. totally unreadable for people who just look at .rst files.

Does other documentation go to this extreme?

> +
> +   **addr**/**len**: virtual memory address range.
> +      The address range set by **addr**/**len** must meet:
> +         - The start address must be in an allocated VMA.
> +         - The start address must be page aligned.
> +         - The end address (**addr** + **len**) must be in an allocated VMA.
> +         - no gap (unallocated memory) between start and end address.
> +
> +      The ``len`` will be paged aligned implicitly by the kernel.
> +
> +   **flags**: reserved for future use.
> +
> +   **Return values**:
> +      - **0**: Success.
> +      - **-EINVAL**:
> +         * Invalid input ``flags``.
> +         * The start address (``addr``) is not page aligned.
> +         * Address range (``addr`` + ``len``) overflow.
> +      - **-ENOMEM**:
> +         * The start address (``addr``) is not allocated.
> +         * The end address (``addr`` + ``len``) is not allocated.
> +         * A gap (unallocated memory) between start and end address.
> +      - **-EPERM**:
> +         * sealing is supported only on 64-bit CPUs, 32-bit is not supported.
> +
> +   **Note about error return**:
> +      - For above error cases, users can expect the given memory range is
> +        unmodified, i.e. no partial update.
> +      - There might be other internal errors/cases not listed here, e.g.
> +        error during merging/splitting VMAs, or the process reaching the max
> +        number of supported VMAs. In those cases, partial updates to the given
> +        memory range could happen. However, those cases should be rare.
> +
> +   **Architecture support**:
> +      mseal only works on 64-bit CPUs, not 32-bit CPU.

	                                             CPUs.

> +
> +   **Idempotent**:
> +      users can call mseal multiple times, mseal on an already sealed memory

	                               times. mseal

> +      is a no-action (not error).
> +
> +   **no munseal**
> +      Once mapping is sealed, it can't be unsealed. kernel should never
> +      have munseal, this is consistent with other sealing feature, e.g.
> +      F_SEAL_SEAL for file.
> +
> +Blocked mm syscall for sealed mapping
> +-------------------------------------
> +   It might be imporant to note: **once the mapping is sealed, it will

                  important

> +   stay in the process's memory till the process terminates**.
> +
> +   Example::
> +
> +         *ptr = mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> +         rc = mseal(ptr, 4096, 0);
> +         /* munmap will fail */
> +         rc = munmap(ptr, 4096);
> +         assert(rc < 0);
> +
> +   Blocked mm syscall:
> +      - munmap
> +      - mmap
> +      - mremap
> +      - mprotect and pkey_mprotect
> +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
> +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK
> +
> +   The first set of syscall to block is munmap, mremap, mmap. They can
> +   either leave an empty space in the address space, therefore allow
> +   replacement with a new mapping with new set of attributes, or can
> +   overwrite the existing mapping with another mapping.
> +
> +   mprotect and pkey_mprotect are blocked because they changes the
> +   protection bits (rwx) of the mapping.

preferably            (RWX)

> +
> +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,

                       madvise

> +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> +   for anonymous memory, when users don't have write permission to the
> +   memory. Those behaviors can alter region contents by discarding pages,
> +   effectively a memset(0) for anonymous memory.
> +
> +   Kernel will return -EPERM for blocked syscalls.
> +
> +   When blocked syscall return -EPERM due to sealing, the memory regions may or may not be changed, depends on the syscall being blocked:
> +      - munmap: munmap is atomic. If one of VMAs in the given range is
> +        sealed, none of VMAs are updated.
> +      - mprotect, pkey_mprotect, madvise: partial update might happen, e.g.
> +        when mprotect over multiple VMAs, mprotect might update the beginning
> +        VMAs before reaching the sealed VMA and return -EPERM.
> +      - mmap and mremap: undefined behavior.
>  
>  Use cases:
>  ==========
>  - glibc:
>    The dynamic linker, during loading ELF executables, can apply sealing to
> -  non-writable memory segments.
> +  mapping segments.
>  
>  - Chrome browser: protect some security sensitive data-structures.

                                                     data structures.

>  
> -Notes on which memory to seal:
> -==============================
> -
> -It might be important to note that sealing changes the lifetime of a mapping,
> -i.e. the sealed mapping won’t be unmapped till the process terminates or the
> -exec system call is invoked. Applications can apply sealing to any virtual
> -memory region from userspace, but it is crucial to thoroughly analyze the
> -mapping's lifetime prior to apply the sealing.
> +Don't use mseal on:

Drop the ':'. Headings should not uses trailing colons.
(throughout this file)

Maybe change the heading to "When not to use mseal".

> +===================
> +Applications can apply sealing to any virtual memory region from userspace,
> +but it is *crucial to thoroughly analyze the mapping's lifetime* prior to
> +apply the sealing. This is because the sealed mapping *won’t be unmapped*
> +till the process terminates or the exec system call is invoked.

s/till/until/ preferably.

>  
>  For example:
> +   - aio/shm
> +     aio/shm can call mmap and  munmap on behalf of userspace, e.g.
> +     ksys_shmdt() in shm.c. The lifetime of those mapping are not tied to
> +     the lifetime of the process. If those memories are sealed from userspace,
> +     then munmap will fail, causing leaks in VMA address space during the
> +     lifetime of the process.
> +
> +   - ptr allocated by malloc (heap)
> +     Don't use mseal on the memory ptr return from malloc().
> +     malloc() is implemented by allocator, e.g. by glibc. Heap manager might
> +     allocate a ptr from brk or mapping created by mmap.
> +     If app calls mseal on ptr returned from malloc(), this can affect the heap

	If an app calls mseal on a ptr


> +     manager's ability to manage the mappings, the outcome is non-deterministic.

	                                mappings; the outcome

> +     Example::
> +
> +        ptr = malloc(size);
> +        /* don't call mseal on ptr return from malloc. */
> +        mseal(ptr, size);
> +        /* free will success, allocator can't shrink heap lower than ptr */
> +        free(ptr);
> +
> +mseal doesn't block:
> +====================
> +In a nutshell, mseal blocks certain mm syscall from modifying some of VMA's
> +attributes, such as protection bits (rwx). Sealed mappings doesn't mean the

preferably                             (RWX).

> +memory is immutable.
>  
> -- aio/shm
> -
> -  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_shmdt() in
> -  shm.c. The lifetime of those mapping are not tied to the lifetime of the

                lifetimes
?

> -  process. If those memories are sealed from userspace, then munmap() will fail,
> -  causing leaks in VMA address space during the lifetime of the process.
> -
> -- Brk (heap)
> -
> -  Currently, userspace applications can seal parts of the heap by calling
> -  malloc() and mseal().
> -  let's assume following calls from user space:
> -
> -  - ptr = malloc(size);
> -  - mprotect(ptr, size, RO);
> -  - mseal(ptr, size);
> -  - free(ptr);
> -
> -  Technically, before mseal() is added, the user can change the protection of
> -  the heap by calling mprotect(RO). As long as the user changes the protection
> -  back to RW before free(), the memory range can be reused.
> -
> -  Adding mseal() into the picture, however, the heap is then sealed partially,
> -  the user can still free it, but the memory remains to be RO. If the address
> -  is re-used by the heap manager for another malloc, the process might crash
> -  soon after. Therefore, it is important not to apply sealing to any memory
> -  that might get recycled.
> -
> -  Furthermore, even if the application never calls the free() for the ptr,
> -  the heap manager may invoke the brk system call to shrink the size of the
> -  heap. In the kernel, the brk-shrink will call munmap(). Consequently,
> -  depending on the location of the ptr, the outcome of brk-shrink is
> -  nondeterministic.
> -
> -
> -Additional notes:
> -=================
>  As Jann Horn pointed out in [3], there are still a few ways to write
> -to RO memory, which is, in a way, by design. Those cases are not covered
> -by mseal(). If applications want to block such cases, sandbox tools (such as
> -seccomp, LSM, etc) might be considered.
> +to RO memory, which is, in a way, by design. And those could be blocked
> +by different security measures.
>  
>  Those cases are:
> -
> -- Write to read-only memory through /proc/self/mem interface.
> -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> -- userfaultfd.
> +   - Write to read-only memory through /proc/self/mem interface (FOLL_FORCE).
> +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> +   - userfaultfd.
>  
>  The idea that inspired this patch comes from Stephen Röttger’s work in V8
>  CFI [4]. Chrome browser in ChromeOS will be the first user of this API.
>  
>  Reference:
>  ==========
> -[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> -
> -[2] https://man.openbsd.org/mimmutable.2
> -
> -[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
> -
> -[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc
> +- [1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> +- [2] https://man.openbsd.org/mimmutable.2
> +- [3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com
> +- [4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit#heading=h.bvaojj9fu6hc

