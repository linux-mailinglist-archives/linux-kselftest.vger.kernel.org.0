Return-Path: <linux-kselftest+bounces-19044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F39909B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 18:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEF928234D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED821CACE8;
	Fri,  4 Oct 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LlMYOvA7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5441C7292
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060789; cv=none; b=S8eYhIHWUMEyy99jhiV/1weFaq00MXUS88DCg0KPv/o7bOw3jkctXdJztmIeNKspCaLx4dqZ5NuHIivrtxmjPttkqr3uMWAWvm8ICwemnLOQjTq1MSQr280D1P1g76sLF8MoAKFyufnbGeKQQSs/iDDPAiiFa4esIc5cYeihxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060789; c=relaxed/simple;
	bh=6CqRXePiiOK5vYdR8gfD7eFS16bqIsceX99R/OKs5aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qx1+CxYeAy0+4SSjWBiQR8PdCacmhr5hngUVapAIOa5Zk3AUqfuDVfws6CTc+T2gorft2zSooNuzhD06PZAiHSuEVBE7eY+AH0nBVkWzFetDHWZUmEBftVzKqqS1h5FLk2KEH0LqA2fxE0iciyeiMAyJetgxaQpkMUdRuWiUg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LlMYOvA7; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e3a993fc03so151174b6e.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2024 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728060786; x=1728665586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VG4tU22P9OLvnUa//YVQefh+PRlm4PGigQOyMuRRcW8=;
        b=LlMYOvA7voTjmojV1Ph+wPrg6rJG5GISPJtaI5Ey9RS66urHDoiiuEfMsrqmrrrFmh
         g93hsq44oF3WcXdtOn1FFXzT99lX2OrIUnJjKEfpjISNs04C70zWl9b+GktOc5mhShsk
         O+d55ABJCOJ9bIOJVvf/lKToHzjJV5N/Zkebk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060786; x=1728665586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VG4tU22P9OLvnUa//YVQefh+PRlm4PGigQOyMuRRcW8=;
        b=xRqFdLOBM8En9Q5E3aVNfIG8krElYWNluwvMjj7tLwt3j4w/T853WMFLZ53iWH3+re
         uFZE901xGIl4bOYu9+bcdQ95fU5DHD/3+rE3gCsTjaFmdGgoB9+gSBMZtSU6y+4Rjw+9
         p8RZS2ACKK7AsK4Kbb/oQvJVZRADpX9lJ1EV/ZSYjDpawUEEgJg5ciqUjZaCg9M1qvYG
         N7Di2akytZxpBTREPqFXGPacc7PqzTbDSRu8z8GMENlA6D6TNj40MMLJbEF+gKsiVp+1
         1HgFLFoPvxdk1wZCz80vi98z/5X0SrbMa+FJVbSFAug+HsyQrauBvji44VcMw6IKgPcY
         ZXSw==
X-Forwarded-Encrypted: i=1; AJvYcCWopWSm7JiLmULuiKiG51RWbdSbgGLQrhWyK/1Piwvg+JL071l0m7ZW3pTrBuBBkre6i3WuEbqW6fvQzw9L92s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwB0tK6t0qKi0wPjvfr+XbvZ5bkdKFIErAl/qJLyCqXX9EwhMc
	IaDLIKwZULXk8e+Sa3H89AV+XGZhRYkAWgMR/L+3LeibZ0ofw3SJii+4fi+s74LFZJ/HcWs6kzd
	UuQAtJk/6GwTP2FmquiZ3mZMrA9zFn3BPTLKg
X-Google-Smtp-Source: AGHT+IFcex8dcjQ7+QuysKWskYPLd1xBJCHVZO/eUpId1xASgiifLi6AKo9e93eC7UHAybJIyYsxoyc1fCpGphEUlZY=
X-Received: by 2002:a05:6870:b526:b0:27b:58d8:c8de with SMTP id
 586e51a60fabf-287c1dadcfbmr728210fac.5.1728060786260; Fri, 04 Oct 2024
 09:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002628.2239032-1-jeffxu@chromium.org> <20241001002628.2239032-2-jeffxu@chromium.org>
 <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org>
In-Reply-To: <4544a4b3-d5b6-4f6b-b3d5-6c309eb8fa9d@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 4 Oct 2024 09:52:43 -0700
Message-ID: <CABi2SkUhcEY7KxuRX3edOHJZbo2kZOZfa0sWrcG2_T0rnvHCWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal: update mseal.rst
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy

On Thu, Oct 3, 2024 at 3:54=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Hi Jeff,
>
> Sorry for the delay.
> Thanks for your v2 updates.
>
I appreciate you spending time proofreading the mseal.rst.

>
> On 9/30/24 5:26 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Update doc after in-loop change: mprotect/madvise can have
> > partially updated and munmap is atomic.
> >
> > Fix indentation and clarify some sections to improve readability.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > Fixes: df2a7df9a9aa ("mm/munmap: replace can_modify_mm with can_modify_=
vma")
> > Fixes: 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with can_modif=
y_vma")
> > Fixes: 38075679b5f1 ("mm/mremap: replace can_modify_mm with can_modify_=
vma")
> > Fixes: 23c57d1fa2b9 ("mseal: replace can_modify_mm_madv with a vma vari=
ant")
> > ---
> >  Documentation/userspace-api/mseal.rst | 304 ++++++++++++--------------
> >  1 file changed, 144 insertions(+), 160 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 4132eec995a3..04d34b5adb8f 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -23,177 +23,161 @@ applications can additionally seal security criti=
cal data at runtime.
> >  A similar feature already exists in the XNU kernel with the
> >  VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall=
 [2].
> >
> > -User API
> > -=3D=3D=3D=3D=3D=3D=3D=3D
> > -mseal()
> > ------------
> > -The mseal() syscall has the following signature:
> > -
> > -``int mseal(void addr, size_t len, unsigned long flags)``
> > -
> > -**addr/len**: virtual memory address range.
> > -
> > -The address range set by ``addr``/``len`` must meet:
> > -   - The start address must be in an allocated VMA.
> > -   - The start address must be page aligned.
> > -   - The end address (``addr`` + ``len``) must be in an allocated VMA.
> > -   - no gap (unallocated memory) between start and end address.
> > -
> > -The ``len`` will be paged aligned implicitly by the kernel.
> > -
> > -**flags**: reserved for future use.
> > -
> > -**return values**:
> > -
> > -- ``0``: Success.
> > -
> > -- ``-EINVAL``:
> > -    - Invalid input ``flags``.
> > -    - The start address (``addr``) is not page aligned.
> > -    - Address range (``addr`` + ``len``) overflow.
> > -
> > -- ``-ENOMEM``:
> > -    - The start address (``addr``) is not allocated.
> > -    - The end address (``addr`` + ``len``) is not allocated.
> > -    - A gap (unallocated memory) between start and end address.
> > -
> > -- ``-EPERM``:
> > -    - sealing is supported only on 64-bit CPUs, 32-bit is not supporte=
d.
> > -
> > -- For above error cases, users can expect the given memory range is
> > -  unmodified, i.e. no partial update.
> > -
> > -- There might be other internal errors/cases not listed here, e.g.
> > -  error during merging/splitting VMAs, or the process reaching the max
> > -  number of supported VMAs. In those cases, partial updates to the giv=
en
> > -  memory range could happen. However, those cases should be rare.
> > -
> > -**Blocked operations after sealing**:
> > -    Unmapping, moving to another location, and shrinking the size,
> > -    via munmap() and mremap(), can leave an empty space, therefore
> > -    can be replaced with a VMA with a new set of attributes.
> > -
> > -    Moving or expanding a different VMA into the current location,
> > -    via mremap().
> > -
> > -    Modifying a VMA via mmap(MAP_FIXED).
> > -
> > -    Size expansion, via mremap(), does not appear to pose any
> > -    specific risks to sealed VMAs. It is included anyway because
> > -    the use case is unclear. In any case, users can rely on
> > -    merging to expand a sealed VMA.
> > -
> > -    mprotect() and pkey_mprotect().
> > -
> > -    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
> > -    for anonymous memory, when users don't have write permission to th=
e
> > -    memory. Those behaviors can alter region contents by discarding pa=
ges,
> > -    effectively a memset(0) for anonymous memory.
> > -
> > -    Kernel will return -EPERM for blocked operations.
> > -
> > -    For blocked operations, one can expect the given address is unmodi=
fied,
> > -    i.e. no partial update. Note, this is different from existing mm
> > -    system call behaviors, where partial updates are made till an erro=
r is
> > -    found and returned to userspace. To give an example:
> > -
> > -    Assume following code sequence:
> > -
> > -    - ptr =3D mmap(null, 8192, PROT_NONE);
> > -    - munmap(ptr + 4096, 4096);
> > -    - ret1 =3D mprotect(ptr, 8192, PROT_READ);
> > -    - mseal(ptr, 4096);
> > -    - ret2 =3D mprotect(ptr, 8192, PROT_NONE);
> > -
> > -    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
> > -
> > -    ret2 will be -EPERM, the page remains to be PROT_READ.
> > -
> > -**Note**:
> > -
> > -- mseal() only works on 64-bit CPUs, not 32-bit CPU.
> > -
> > -- users can call mseal() multiple times, mseal() on an already sealed =
memory
> > -  is a no-action (not error).
> > -
> > -- munseal() is not supported.
> > -
> > -Use cases:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +SYSCALL
> > +=3D=3D=3D=3D=3D=3D=3D
> > +mseal syscall signature
> > +-----------------------
> > +   ``int mseal(void \* addr, size_t len, unsigned long flags)``
> > +
> > +   **addr**/**len**: virtual memory address range.
> > +      The address range set by **addr**/**len** must meet:
> > +         - The start address must be in an allocated VMA.
> > +         - The start address must be page aligned.
> > +         - The end address (**addr** + **len**) must be in an allocate=
d VMA.
> > +         - no gap (unallocated memory) between start and end address.
> > +
> > +      The ``len`` will be paged aligned implicitly by the kernel.
> > +
> > +   **flags**: reserved for future use.
> > +
> > +   **Return values**:
> > +      - **0**: Success.
> > +      - **-EINVAL**:
> > +         * Invalid input ``flags``.
> > +         * The start address (``addr``) is not page aligned.
> > +         * Address range (``addr`` + ``len``) overflow.
> > +      - **-ENOMEM**:
> > +         * The start address (``addr``) is not allocated.
> > +         * The end address (``addr`` + ``len``) is not allocated.
> > +         * A gap (unallocated memory) between start and end address.
> > +      - **-EPERM**:
> > +         * sealing is supported only on 64-bit CPUs, 32-bit is not sup=
ported.
> > +
> > +   **Note about error return**:
> > +      - For above error cases, users can expect the given memory range=
 is
> > +        unmodified, i.e. no partial update.
> > +      - There might be other internal errors/cases not listed here, e.=
g.
> > +        error during merging/splitting VMAs, or the process reaching t=
he max
>
>                                                                          =
   maximum
fixed.

>
> > +        number of supported VMAs. In those cases, partial updates to t=
he given
> > +        memory range could happen. However, those cases should be rare=
.
> > +
> > +   **Architecture support**:
> > +      mseal only works on 64-bit CPUs, not 32-bit CPUs.
> > +
> > +   **Idempotent**:
> > +      users can call mseal multiple times. mseal on an already sealed =
memory
> > +      is a no-action (not error).
> > +
> > +   **no munseal**
> > +      Once mapping is sealed, it can't be unsealed. kernel should neve=
r
>
>                                                        The kernel
Fixed.
>
> > +      have munseal, this is consistent with other sealing feature, e.g=
.
> > +      F_SEAL_SEAL for file.
> > +
> > +Blocked mm syscall for sealed mapping
> > +-------------------------------------
> > +   It might be important to note: **once the mapping is sealed, it wil=
l
> > +   stay in the process's memory until the process terminates**.
> > +
> > +   Example::
> > +
> > +         *ptr =3D mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE=
, 0, 0);
> > +         rc =3D mseal(ptr, 4096, 0);
> > +         /* munmap will fail */
> > +         rc =3D munmap(ptr, 4096);
> > +         assert(rc < 0);
> > +
> > +   Blocked mm syscall:
> > +      - munmap
> > +      - mmap
> > +      - mremap
> > +      - mprotect and pkey_mprotect
> > +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
> > +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFOR=
K
> > +
> > +   The first set of syscall to block is munmap, mremap, mmap. They can
>
>                        syscalls
fixed.
>
> > +   either leave an empty space in the address space, therefore allow
>
>                                                                   allowin=
g
fixed.
>
> > +   replacement with a new mapping with new set of attributes, or can
> > +   overwrite the existing mapping with another mapping.
> > +
> > +   mprotect and pkey_mprotect are blocked because they changes the
> > +   protection bits (RWX) of the mapping.
> > +
> > +   Some destructive madvise behaviors (MADV_DONTNEED, MADV_FREE,> +   =
MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> > +   for anonymous memory, when users don't have write permission to the
> > +   memory. Those behaviors can alter region contents by discarding pag=
es,
>
> above is not a sentence but I don't know how to fix it.
>
Would below work ?

Certain destructive madvise behaviors, specifically MADV_DONTNEED,
MADV_FREE, MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK,
MADV_WIPEONFORK, can pose risks when applied to anonymous memory by
threads without write permissions. These behaviors have the potential
to modify region contents by discarding pages, effectively performing
a memset(0) operation on the anonymous memory.

> > +   effectively a memset(0) for anonymous memory.
> > +
> > +   Kernel will return -EPERM for blocked syscalls.
> > +
> > +   When blocked syscall return -EPERM due to sealing, the memory regio=
ns may or may not be changed, depends on the syscall being blocked:
>
>            a blocked syscall returns                                     =
                              depending on
>
> and split that line into 2 lines.
fixed.

>
> > +      - munmap: munmap is atomic. If one of VMAs in the given range is
> > +        sealed, none of VMAs are updated.
> > +      - mprotect, pkey_mprotect, madvise: partial update might happen,=
 e.g.
> > +        when mprotect over multiple VMAs, mprotect might update the be=
ginning
> > +        VMAs before reaching the sealed VMA and return -EPERM.
> > +      - mmap and mremap: undefined behavior.
> > +
> > +Use cases
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  - glibc:
> >    The dynamic linker, during loading ELF executables, can apply sealin=
g to
> > -  non-writable memory segments.
> > -
> > -- Chrome browser: protect some security sensitive data-structures.
> > +  mapping segments.
> >
> > -Notes on which memory to seal:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +- Chrome browser: protect some security sensitive data structures.
> >
> > -It might be important to note that sealing changes the lifetime of a m=
apping,
> > -i.e. the sealed mapping won=E2=80=99t be unmapped till the process ter=
minates or the
> > -exec system call is invoked. Applications can apply sealing to any vir=
tual
> > -memory region from userspace, but it is crucial to thoroughly analyze =
the
> > -mapping's lifetime prior to apply the sealing.
> > +When not to use mseal
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Applications can apply sealing to any virtual memory region from users=
pace,
> > +but it is *crucial to thoroughly analyze the mapping's lifetime* prior=
 to
> > +apply the sealing. This is because the sealed mapping *won=E2=80=99t b=
e unmapped*
> > +until the process terminates or the exec system call is invoked.
> >
> >  For example:
> > +   - aio/shm
> > +     aio/shm can call mmap and  munmap on behalf of userspace, e.g.
> > +     ksys_shmdt() in shm.c. The lifetimes of those mapping are not tie=
d to
> > +     the lifetime of the process. If those memories are sealed from us=
erspace,
> > +     then munmap will fail, causing leaks in VMA address space during =
the
> > +     lifetime of the process.
> > +
> > +   - ptr allocated by malloc (heap)
> > +     Don't use mseal on the memory ptr return from malloc().
> > +     malloc() is implemented by allocator, e.g. by glibc. Heap manager=
 might
> > +     allocate a ptr from brk or mapping created by mmap.
> > +     If an app calls mseal on a ptr returned from malloc(), this can a=
ffect
> > +     the heap manager's ability to manage the mappings; the outcome is
> > +     non-deterministic.
> > +
> > +     Example::
> > +
> > +        ptr =3D malloc(size);
> > +        /* don't call mseal on ptr return from malloc. */
> > +        mseal(ptr, size);
> > +        /* free will success, allocator can't shrink heap lower than p=
tr */
> > +        free(ptr);
> > +
> > +mseal doesn't block
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +In a nutshell, mseal blocks certain mm syscall from modifying some of =
VMA's
> > +attributes, such as protection bits (RWX). Sealed mappings doesn't mea=
n the
> > +memory is immutable.
> >
> > -- aio/shm
> > -
> > -  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_s=
hmdt() in
> > -  shm.c. The lifetime of those mapping are not tied to the lifetime of=
 the
> > -  process. If those memories are sealed from userspace, then munmap() =
will fail,
> > -  causing leaks in VMA address space during the lifetime of the proces=
s.
> > -
> > -- Brk (heap)
> > -
> > -  Currently, userspace applications can seal parts of the heap by call=
ing
> > -  malloc() and mseal().
> > -  let's assume following calls from user space:
> > -
> > -  - ptr =3D malloc(size);
> > -  - mprotect(ptr, size, RO);
> > -  - mseal(ptr, size);
> > -  - free(ptr);
> > -
> > -  Technically, before mseal() is added, the user can change the protec=
tion of
> > -  the heap by calling mprotect(RO). As long as the user changes the pr=
otection
> > -  back to RW before free(), the memory range can be reused.
> > -
> > -  Adding mseal() into the picture, however, the heap is then sealed pa=
rtially,
> > -  the user can still free it, but the memory remains to be RO. If the =
address
> > -  is re-used by the heap manager for another malloc, the process might=
 crash
> > -  soon after. Therefore, it is important not to apply sealing to any m=
emory
> > -  that might get recycled.
> > -
> > -  Furthermore, even if the application never calls the free() for the =
ptr,
> > -  the heap manager may invoke the brk system call to shrink the size o=
f the
> > -  heap. In the kernel, the brk-shrink will call munmap(). Consequently=
,
> > -  depending on the location of the ptr, the outcome of brk-shrink is
> > -  nondeterministic.
> > -
> > -
> > -Additional notes:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  As Jann Horn pointed out in [3], there are still a few ways to write
> > -to RO memory, which is, in a way, by design. Those cases are not cover=
ed
> > -by mseal(). If applications want to block such cases, sandbox tools (s=
uch as
> > -seccomp, LSM, etc) might be considered.
> > +to RO memory, which is, in a way, by design. And those could be blocke=
d
> > +by different security measures.
> >
> >  Those cases are:
> > -
> > -- Write to read-only memory through /proc/self/mem interface.
> > -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> > -- userfaultfd.
> > +   - Write to read-only memory through /proc/self/mem interface (FOLL_=
FORCE).
> > +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT=
).
> > +   - userfaultfd.
> >
> >  The idea that inspired this patch comes from Stephen R=C3=B6ttger=E2=
=80=99s work in V8
> >  CFI [4]. Chrome browser in ChromeOS will be the first user of this API=
.
> >
> > -Reference:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37a=
ff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> > -
> > -[2] https://man.openbsd.org/mimmutable.2
> > -
> > -[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ=
426FkcgnfUGLvA@mail.gmail.com
> > -
> > -[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmw=
dvxQMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc
> > +Reference
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +- [1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e3=
7aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> > +- [2] https://man.openbsd.org/mimmutable.2
> > +- [3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2h=
zQ426FkcgnfUGLvA@mail.gmail.com
> > +- [4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfb=
mwdvxQMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc
>
> With those few changes:
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
Thanks!
-Jeff

> --
> ~Randy

