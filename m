Return-Path: <linux-kselftest+bounces-19781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9599F7B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 22:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C641E283136
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F191F76DF;
	Tue, 15 Oct 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kz3oUPhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D651F818A
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022435; cv=none; b=VNF4CSDu7a61Ea9V1l1U2KP0uhAOsCs/PEIkOJ042EfalOh7ryv62Jd822Utqqx6f72odI27aq7cXk0CRETCdIiuw/mpEFFLER5Cf0zsIVnoWqOO4hXLwpo9ukCP5bbaZAB3USIwd1phXnJn/UmglUsfcXymSeXmdtR153xGwI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022435; c=relaxed/simple;
	bh=cjgf7fZ6fxbCRnIwsq59dZULAtQWYYYJDNg/Y1n8lEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmXNFdXHO2BvzouA3emlXtje1ri6DA6LFxjCLP9PT+93SAlTkAW5RoPgKl3Qn3zSTKjo7xHXwa9k6/sF54tHxYI37BLLHkG6brxJPH+D1N10Ycep/8WFQKt0KFJa24brprWdOsCbVAaET3aVgacGYjC/SXHaeOnlnRgGS3cYW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kz3oUPhA; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-718062c1989so11029a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729022432; x=1729627232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+NFu9pFnYL/Wg5GSs6A+HFmdxihVVocbF37KmhdNV4=;
        b=kz3oUPhAp+dyQ7qGlT28jPfVLKgNINrfkD4DxDh/9zv7PnW12FGOFMQHYNW1sfbp8r
         vSfZSxcU7bqsFFr/RPe9K1PL2ri8FV0am85m4p39Z5VNP7av4A/gKKHOM3bhOMzpkc/v
         ciLCkMgQdka7KmBrJ2q/WUG5sRYVplpyvNK3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729022432; x=1729627232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+NFu9pFnYL/Wg5GSs6A+HFmdxihVVocbF37KmhdNV4=;
        b=hMCsX1TH8O8pZaQZkm4K7xShQsQdjdyasaGrjBFF1C5W0b1RGBEqgkueMIewQZpxIb
         H27wyoJawXIwAgSOMMIzzbzCe0Gig5rRUDqMkDkOhZw9MFwJ2UOpF5J8u40wnLDeYZdC
         vwH+um59NVwMK/WHwzP55lbOm8NkhFV+ZFeFimRS9Pwnew4Dls9Ctp4uJ8OxEtFNLAiJ
         kLCaGP/+DAiW0cEl2I/a7e8m0AwP64j/8q8A4nbmowmtARtBKNeD8iMxeXEsFXBAp+Uh
         mlOzO6QoJTSCcDnQx/+EN3TJniHAxVAqMuFSVUgH7ywaAalZA0/KmlwVq6wEUxCmJVHn
         TpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO2V3KbO+Iicbp4GRzyG9EPrIwtPSKQ0IQ6Rm17R7OVYIKEZF2UFYCi4BtnrCEIYA9Xf4YlTteAVP5wR43Gc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53Z8Lty4NF2rBEI6OHKsgydHG3Lt9A7eucSjIBSKxMX9MgoQ7
	TlDGRaoC7DGZGMja/L4KtCvJdTH8jBEfrqNcqBM3ut77wDps0jAG9nmylnmRZOnMb2s7a/mqJpH
	L+pBKzSC8wYrJ/BruDQEcmZuaMUfXJb/6jcD0
X-Google-Smtp-Source: AGHT+IH1S5utfvwpODzfC9epIfrxTAxik14I4f/mxwMdg+isPf9IbBIwtTXGpJ6BejuAzx97/uTs8jGADawbLpFjPuM=
X-Received: by 2002:a05:6870:b28a:b0:278:8f5:a567 with SMTP id
 586e51a60fabf-288f40219f5mr128308fac.5.1729022432351; Tue, 15 Oct 2024
 13:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008040942.1478931-1-jeffxu@chromium.org> <20241008040942.1478931-2-jeffxu@chromium.org>
In-Reply-To: <20241008040942.1478931-2-jeffxu@chromium.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 15 Oct 2024 13:00:00 -0700
Message-ID: <CABi2SkW=HSPG4whyZALgXekZJXupe7HP8Guy8kxEGuxVDN+xRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mseal: update mseal.rst
To: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net
Cc: jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

If there is no objection, please pull this v3 patch to mm-unstable.

I believe I already responded to all comments related to this patch.

This will keep mseal.rst up-to-date with current implementation of
memory sealing.

Thanks
-Jeff

On Mon, Oct 7, 2024 at 9:09=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> Update doc after in-loop change: mprotect/madvise can have
> partially updated and munmap is atomic.
>
> Fix indentation and clarify some sections to improve readability.
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Fixes: df2a7df9a9aa ("mm/munmap: replace can_modify_mm with can_modify_vm=
a")
> Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modify_=
vma")
> Fixes: 38075679b5f1 ("mm/mremap: replace can_modify_mm with can_modify_vm=
a")
> Fixes: 23c57d1fa2b9 ("mseal: replace can_modify_mm_madv with a vma varian=
t")
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/userspace-api/mseal.rst | 307 +++++++++++++-------------
>  1 file changed, 148 insertions(+), 159 deletions(-)
>
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/usersp=
ace-api/mseal.rst
> index 4132eec995a3..41102f74c5e2 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -23,177 +23,166 @@ applications can additionally seal security critica=
l data at runtime.
>  A similar feature already exists in the XNU kernel with the
>  VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall [=
2].
>
> -User API
> -=3D=3D=3D=3D=3D=3D=3D=3D
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
> -    memory. Those behaviors can alter region contents by discarding page=
s,
> -    effectively a memset(0) for anonymous memory.
> -
> -    Kernel will return -EPERM for blocked operations.
> -
> -    For blocked operations, one can expect the given address is unmodifi=
ed,
> -    i.e. no partial update. Note, this is different from existing mm
> -    system call behaviors, where partial updates are made till an error =
is
> -    found and returned to userspace. To give an example:
> -
> -    Assume following code sequence:
> -
> -    - ptr =3D mmap(null, 8192, PROT_NONE);
> -    - munmap(ptr + 4096, 4096);
> -    - ret1 =3D mprotect(ptr, 8192, PROT_READ);
> -    - mseal(ptr, 4096);
> -    - ret2 =3D mprotect(ptr, 8192, PROT_NONE);
> -
> -    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
> -
> -    ret2 will be -EPERM, the page remains to be PROT_READ.
> -
> -**Note**:
> -
> -- mseal() only works on 64-bit CPUs, not 32-bit CPU.
> -
> -- users can call mseal() multiple times, mseal() on an already sealed me=
mory
> -  is a no-action (not error).
> -
> -- munseal() is not supported.
> -
> -Use cases:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +SYSCALL
> +=3D=3D=3D=3D=3D=3D=3D
> +mseal syscall signature
> +-----------------------
> +   ``int mseal(void \* addr, size_t len, unsigned long flags)``
> +
> +   **addr**/**len**: virtual memory address range.
> +      The address range set by **addr**/**len** must meet:
> +         - The start address must be in an allocated VMA.
> +         - The start address must be page aligned.
> +         - The end address (**addr** + **len**) must be in an allocated =
VMA.
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
> +         * sealing is supported only on 64-bit CPUs, 32-bit is not suppo=
rted.
> +
> +   **Note about error return**:
> +      - For above error cases, users can expect the given memory range i=
s
> +        unmodified, i.e. no partial update.
> +      - There might be other internal errors/cases not listed here, e.g.
> +        error during merging/splitting VMAs, or the process reaching the=
 maximum
> +        number of supported VMAs. In those cases, partial updates to the=
 given
> +        memory range could happen. However, those cases should be rare.
> +
> +   **Architecture support**:
> +      mseal only works on 64-bit CPUs, not 32-bit CPUs.
> +
> +   **Idempotent**:
> +      users can call mseal multiple times. mseal on an already sealed me=
mory
> +      is a no-action (not error).
> +
> +   **no munseal**
> +      Once mapping is sealed, it can't be unsealed. The kernel should ne=
ver
> +      have munseal, this is consistent with other sealing feature, e.g.
> +      F_SEAL_SEAL for file.
> +
> +Blocked mm syscall for sealed mapping
> +-------------------------------------
> +   It might be important to note: **once the mapping is sealed, it will
> +   stay in the process's memory until the process terminates**.
> +
> +   Example::
> +
> +         *ptr =3D mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, =
0, 0);
> +         rc =3D mseal(ptr, 4096, 0);
> +         /* munmap will fail */
> +         rc =3D munmap(ptr, 4096);
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
> +   The first set of syscalls to block is munmap, mremap, mmap. They can
> +   either leave an empty space in the address space, therefore allowing
> +   replacement with a new mapping with new set of attributes, or can
> +   overwrite the existing mapping with another mapping.
> +
> +   mprotect and pkey_mprotect are blocked because they changes the
> +   protection bits (RWX) of the mapping.
> +
> +   Certain destructive madvise behaviors, specifically MADV_DONTNEED,
> +   MADV_FREE, MADV_DONTNEED_LOCKED, and MADV_WIPEONFORK, can introduce
> +   risks when applied to anonymous memory by threads lacking write
> +   permissions. Consequently, these operations are prohibited under such
> +   conditions. The aforementioned behaviors have the potential to modify
> +   region contents by discarding pages, effectively performing a memset(=
0)
> +   operation on the anonymous memory.
> +
> +   Kernel will return -EPERM for blocked syscalls.
> +
> +   When blocked syscall return -EPERM due to sealing, the memory regions=
 may
> +   or may not be changed, depends on the syscall being blocked:
> +
> +      - munmap: munmap is atomic. If one of VMAs in the given range is
> +        sealed, none of VMAs are updated.
> +      - mprotect, pkey_mprotect, madvise: partial update might happen, e=
.g.
> +        when mprotect over multiple VMAs, mprotect might update the begi=
nning
> +        VMAs before reaching the sealed VMA and return -EPERM.
> +      - mmap and mremap: undefined behavior.
> +
> +Use cases
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  - glibc:
>    The dynamic linker, during loading ELF executables, can apply sealing =
to
> -  non-writable memory segments.
> -
> -- Chrome browser: protect some security sensitive data-structures.
> +  mapping segments.
>
> -Notes on which memory to seal:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +- Chrome browser: protect some security sensitive data structures.
>
> -It might be important to note that sealing changes the lifetime of a map=
ping,
> -i.e. the sealed mapping won=E2=80=99t be unmapped till the process termi=
nates or the
> -exec system call is invoked. Applications can apply sealing to any virtu=
al
> -memory region from userspace, but it is crucial to thoroughly analyze th=
e
> -mapping's lifetime prior to apply the sealing.
> +When not to use mseal
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Applications can apply sealing to any virtual memory region from userspa=
ce,
> +but it is *crucial to thoroughly analyze the mapping's lifetime* prior t=
o
> +apply the sealing. This is because the sealed mapping *won=E2=80=99t be =
unmapped*
> +until the process terminates or the exec system call is invoked.
>
>  For example:
> +   - aio/shm
> +     aio/shm can call mmap and  munmap on behalf of userspace, e.g.
> +     ksys_shmdt() in shm.c. The lifetimes of those mapping are not tied =
to
> +     the lifetime of the process. If those memories are sealed from user=
space,
> +     then munmap will fail, causing leaks in VMA address space during th=
e
> +     lifetime of the process.
> +
> +   - ptr allocated by malloc (heap)
> +     Don't use mseal on the memory ptr return from malloc().
> +     malloc() is implemented by allocator, e.g. by glibc. Heap manager m=
ight
> +     allocate a ptr from brk or mapping created by mmap.
> +     If an app calls mseal on a ptr returned from malloc(), this can aff=
ect
> +     the heap manager's ability to manage the mappings; the outcome is
> +     non-deterministic.
> +
> +     Example::
> +
> +        ptr =3D malloc(size);
> +        /* don't call mseal on ptr return from malloc. */
> +        mseal(ptr, size);
> +        /* free will success, allocator can't shrink heap lower than ptr=
 */
> +        free(ptr);
> +
> +mseal doesn't block
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +In a nutshell, mseal blocks certain mm syscall from modifying some of VM=
A's
> +attributes, such as protection bits (RWX). Sealed mappings doesn't mean =
the
> +memory is immutable.
>
> -- aio/shm
> -
> -  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_shm=
dt() in
> -  shm.c. The lifetime of those mapping are not tied to the lifetime of t=
he
> -  process. If those memories are sealed from userspace, then munmap() wi=
ll fail,
> -  causing leaks in VMA address space during the lifetime of the process.
> -
> -- Brk (heap)
> -
> -  Currently, userspace applications can seal parts of the heap by callin=
g
> -  malloc() and mseal().
> -  let's assume following calls from user space:
> -
> -  - ptr =3D malloc(size);
> -  - mprotect(ptr, size, RO);
> -  - mseal(ptr, size);
> -  - free(ptr);
> -
> -  Technically, before mseal() is added, the user can change the protecti=
on of
> -  the heap by calling mprotect(RO). As long as the user changes the prot=
ection
> -  back to RW before free(), the memory range can be reused.
> -
> -  Adding mseal() into the picture, however, the heap is then sealed part=
ially,
> -  the user can still free it, but the memory remains to be RO. If the ad=
dress
> -  is re-used by the heap manager for another malloc, the process might c=
rash
> -  soon after. Therefore, it is important not to apply sealing to any mem=
ory
> -  that might get recycled.
> -
> -  Furthermore, even if the application never calls the free() for the pt=
r,
> -  the heap manager may invoke the brk system call to shrink the size of =
the
> -  heap. In the kernel, the brk-shrink will call munmap(). Consequently,
> -  depending on the location of the ptr, the outcome of brk-shrink is
> -  nondeterministic.
> -
> -
> -Additional notes:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  As Jann Horn pointed out in [3], there are still a few ways to write
> -to RO memory, which is, in a way, by design. Those cases are not covered
> -by mseal(). If applications want to block such cases, sandbox tools (suc=
h as
> -seccomp, LSM, etc) might be considered.
> +to RO memory, which is, in a way, by design. And those could be blocked
> +by different security measures.
>
>  Those cases are:
>
> -- Write to read-only memory through /proc/self/mem interface.
> -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> -- userfaultfd.
> +   - Write to read-only memory through /proc/self/mem interface (FOLL_FO=
RCE).
> +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> +   - userfaultfd.
>
>  The idea that inspired this patch comes from Stephen R=C3=B6ttger=E2=80=
=99s work in V8
>  CFI [4]. Chrome browser in ChromeOS will be the first user of this API.
>
> -Reference:
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff=
177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> -
> -[2] https://man.openbsd.org/mimmutable.2
> -
> -[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ42=
6FkcgnfUGLvA@mail.gmail.com
> -
> -[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdv=
xQMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc
> +Reference
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +- [1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37a=
ff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> +- [2] https://man.openbsd.org/mimmutable.2
> +- [3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ=
426FkcgnfUGLvA@mail.gmail.com
> +- [4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmw=
dvxQMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc
> --
> 2.47.0.rc0.187.ge670bccf7e-goog
>

