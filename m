Return-Path: <linux-kselftest+bounces-3468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A783B075
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F561F22DF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C060E12AAD6;
	Wed, 24 Jan 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltFl18wO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7B12AAD2
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118637; cv=none; b=Qql9XKp31mEyAHkTsKrGayV3nEykUy7EMjAHLVemISZS52Y0MEMNkIAAUxThviHN191Jw87hyC7ROhn4UFSVp6Nj5Yx/5AJkvlqkcE75T+cSoQtEuzwF+oP9ygS+rOaSVRL4OTTLjbLZk00k4ZKP9eEWVgtNLCPyLhjW3JOAwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118637; c=relaxed/simple;
	bh=JJaz8r/0X8W2+MkkJDyvvIaVTF45Y5YdzaEjuKRmooc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cVPNNZyr/mszEqPwFrI3u6/aQNJUCRIzIga2uavMIJgsYmjiIIP+YutgOwAOYDjuN6+9pEdstXmbAxpqQop0oyDPebz35Delpb4p2nnncDIu51YGCe0e0HulVDLkfCX5zVvdAF6y723JIzueG2fZtdSwovIl8gxIqZ1C8v4hRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ltFl18wO; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bb9b28acb4so4623773b6e.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 09:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706118634; x=1706723434; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXliMpUVVLpPMwAwAK5NHNeS9a/fEsbcLMPhxm3iSMc=;
        b=ltFl18wOgvTmtpn50pEYYFcsB2oYIHlg2IuTrj5Z3k8PTnZhPYCmHwEYAXGYL4Q3vf
         J9uYKWi3QmLebqB7ar5UW8Ahe80xZhraonrdEqjQvAwmLOAzKldP2V8JzZQieT3T2PQd
         vYyB4wZqtjDC5XCMNQcy7rYqBhZnH2j0d4y2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118634; x=1706723434;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXliMpUVVLpPMwAwAK5NHNeS9a/fEsbcLMPhxm3iSMc=;
        b=LEDMCkXlurXmVTYk+uLnyygBXgGWDUsZ2V9jg8Rto86t0zFi6M9SWmu7W2HAoMnjKO
         ZBawnEJsS8kLdJPnWb8fFgjDC7Cr1rE8RU6doDQtisFKXTKWuj6fSLLLWYvMlJe/5sw2
         9AS2k9bBQtybjBEtewvaupCNa58c6/bMVF7SjfAWxM3wawwj3BgrNMjua2pQ9Mt1cYJx
         QHpB0aHtWvSknEoVlrMT0zMzwNXDUeTwMghiHA5wjFLGJXFmgLQ8FcMXCoTzsHMH+x6i
         puqKcDj0Yu3+pA0rs7HRkpbZotmhOF+YiDTHxhcGpJ4llzSewS6h+rDQxAFnmded7woW
         ln0w==
X-Gm-Message-State: AOJu0Yz+FWPU1oKP83R0wtfq9C/9VIMLU2uC/0/0hrNN9RTvKSkcPkq1
	w/iZfqzRlon2/tp+nWhXSRM/dbvASIteFS18K1Z1RlMtCuotWp2GmlryQyDiOhAOpEhtjEU24re
	/Nb1f/0wJcA3okCsvOD4BDqFfUMN0geweX7LH
X-Google-Smtp-Source: AGHT+IGqxaA56MQ4tJcTCEXhg3MuQ/DKXFhS18yDbSQfmJrGba57NKdufzkeYxCu/RNVJErBy0G1Nhmu0IOMW2X6HVo=
X-Received: by 2002:a05:6870:d1c8:b0:214:84f5:e7f6 with SMTP id
 b8-20020a056870d1c800b0021484f5e7f6mr3133017oac.66.1706118634319; Wed, 24 Jan
 2024 09:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <20240122152905.2220849-3-jeffxu@chromium.org>
 <20240123181457.idckaydk7dt7q2qy@revolver>
In-Reply-To: <20240123181457.idckaydk7dt7q2qy@revolver>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 24 Jan 2024 09:50:22 -0800
Message-ID: <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 10:15=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [240122 10:29]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > The new mseal() is an syscall on 64 bit CPU, and with
> > following signature:
> >
> > int mseal(void addr, size_t len, unsigned long flags)
> > addr/len: memory range.
> > flags: reserved.
> >
> > mseal() blocks following operations for the given memory range.
> >
> > 1> Unmapping, moving to another location, and shrinking the size,
> >    via munmap() and mremap(), can leave an empty space, therefore can
> >    be replaced with a VMA with a new set of attributes.
> >
> > 2> Moving or expanding a different VMA into the current location,
> >    via mremap().
> >
> > 3> Modifying a VMA via mmap(MAP_FIXED).
> >
> > 4> Size expansion, via mremap(), does not appear to pose any specific
> >    risks to sealed VMAs. It is included anyway because the use case is
> >    unclear. In any case, users can rely on merging to expand a sealed V=
MA.
> >
> > 5> mprotect() and pkey_mprotect().
> >
> > 6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for anonym=
ous
> >    memory, when users don't have write permission to the memory. Those
> >    behaviors can alter region contents by discarding pages, effectively=
 a
> >    memset(0) for anonymous memory.
> >
> > In addition: mmap() has two related changes.
> >
> > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > the map sealed since creation.
> >
> > The MAP_SEALABLE bit in the flags field of mmap(). When present, it mar=
ks
> > the map as sealable. A map created without MAP_SEALABLE will not suppor=
t
> > sealing, i.e. mseal() will fail.
> >
> > Applications that don't care about sealing will expect their behavior
> > unchanged. For those that need sealing support, opt-in by adding
> > MAP_SEALABLE in mmap().
> >
> > I would like to formally acknowledge the valuable contributions
> > received during the RFC process, which were instrumental
> > in shaping this patch:
> >
> > Jann Horn: raising awareness and providing valuable insights on the
> > destructive madvise operations.
> > Linus Torvalds: assisting in defining system call signature and scope.
> > Pedro Falcato: suggesting sealing in the mmap().
> > Theo de Raadt: sharing the experiences and insights gained from
> > implementing mimmutable() in OpenBSD.
> >
> > Finally, the idea that inspired this patch comes from Stephen R=C3=B6tt=
ger=E2=80=99s
> > work in Chrome V8 CFI.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/mm.h                     |  48 ++++
> >  include/linux/syscalls.h               |   1 +
> >  include/uapi/asm-generic/mman-common.h |   8 +
> >  mm/Makefile                            |   4 +
> >  mm/madvise.c                           |  12 +
> >  mm/mmap.c                              |  27 ++
> >  mm/mprotect.c                          |  10 +
> >  mm/mremap.c                            |  31 +++
> >  mm/mseal.c                             | 343 +++++++++++++++++++++++++
> >  9 files changed, 484 insertions(+)
> >  create mode 100644 mm/mseal.c
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index f5a97dec5169..bdd9a53e9291 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
>
> None of this can live in mm/internal.h ?
>
Will move. Thanks.


> > @@ -328,6 +328,14 @@ extern unsigned int kobjsize(const void *objp);
> >  #define VM_HIGH_ARCH_5       BIT(VM_HIGH_ARCH_BIT_5)
> >  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
> >
> > +#ifdef CONFIG_64BIT
> > +/* VM is sealable, in vm_flags */
> > +#define VM_SEALABLE  _BITUL(63)
> > +
> > +/* VM is sealed, in vm_flags */
> > +#define VM_SEALED    _BITUL(62)
> > +#endif
> > +
> >  #ifdef CONFIG_ARCH_HAS_PKEYS
> >  # define VM_PKEY_SHIFT       VM_HIGH_ARCH_BIT_0
> >  # define VM_PKEY_BIT0        VM_HIGH_ARCH_0  /* A protection key is a =
4-bit value */
> > @@ -4182,4 +4190,44 @@ static inline bool pfn_is_unaccepted_memory(unsi=
gned long pfn)
> >       return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE)=
;
> >  }
> >
> > +#ifdef CONFIG_64BIT
> > +static inline int can_do_mseal(unsigned long flags)
> > +{
> > +     if (flags)
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> > +bool can_modify_mm(struct mm_struct *mm, unsigned long start,
> > +             unsigned long end);
> > +bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> > +             unsigned long end, int behavior);
> > +unsigned long get_mmap_seals(unsigned long prot,
> > +             unsigned long flags);
> > +#else
> > +static inline int can_do_mseal(unsigned long flags)
> > +{
> > +     return -EPERM;
> > +}
> > +
> > +static inline bool can_modify_mm(struct mm_struct *mm, unsigned long s=
tart,
> > +             unsigned long end)
> > +{
> > +     return true;
> > +}
> > +
> > +static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned l=
ong start,
> > +             unsigned long end, int behavior)
> > +{
> > +     return true;
> > +}
> > +
> > +static inline unsigned long get_mmap_seals(unsigned long prot,
> > +     unsigned long flags)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
>
> ...
>
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b78e83d351d2..32bc2179aed0 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1213,6 +1213,7 @@ unsigned long do_mmap(struct file *file, unsigned=
 long addr,
> >  {
> >       struct mm_struct *mm =3D current->mm;
> >       int pkey =3D 0;
> > +     unsigned long vm_seals;
> >
> >       *populate =3D 0;
> >
> > @@ -1233,6 +1234,8 @@ unsigned long do_mmap(struct file *file, unsigned=
 long addr,
> >       if (flags & MAP_FIXED_NOREPLACE)
> >               flags |=3D MAP_FIXED;
> >
> > +     vm_seals =3D get_mmap_seals(prot, flags);
> > +
> >       if (!(flags & MAP_FIXED))
> >               addr =3D round_hint_to_min(addr);
> >
> > @@ -1261,6 +1264,13 @@ unsigned long do_mmap(struct file *file, unsigne=
d long addr,
> >                       return -EEXIST;
> >       }
> >
> > +     /*
> > +      * Check if the address range is sealed for do_mmap().
> > +      * can_modify_mm assumes we have acquired the lock on MM.
> > +      */
> > +     if (!can_modify_mm(mm, addr, addr + len))
> > +             return -EPERM;
> > +
>
> This is called after get_unmapped_area(), so this area is either going
> to be MAP_FIXED and return the "hint" addr or it's going to be empty.
> You can probably avoid walking the VMAs in the non-FIXED case.  This
> would remove the overhead of your check in the most common case.
>

Thanks for flagging this!

I wasn't entirely sure about get_unmapped_area() after reading the
code,  It calls a few variants of  arch_get_unmapped_area_xxx()
functions.

e.g. it seems like the generic_get_unmapped_area_topdown  is returning
a non-null address even when MAP_FIXED is set to false

 --------------------------------------------------------------------------=
--
generic_get_unmapped_area_topdown (
...
if (flags & MAP_FIXED)  <-- MAP_FIXED case.
return addr;

/* requesting a specific address */
if (addr) {  <--  note not MAP_FIXED
addr =3D PAGE_ALIGN(addr);
vma =3D find_vma_prev(mm, addr, &prev);
if (mmap_end - len >=3D addr && addr >=3D mmap_min_addr &&
(!vma || addr + len <=3D vm_start_gap(vma)) &&
(!prev || addr >=3D vm_end_gap(prev)))
return addr;                         <--- note return not null addr here.
}

---------------------------------------------------------------------------=
-
I thought also about adding a check for addr !=3D null  instead, i.e.
if (addr && !can_modify_mm(mm, addr, addr + len))
    return -EPERM;
}

But using MAP_FIXED to allocate memory at address 0 is legit, e.g.
allocating a PROT_NONE | PROT_SEAL at address 0.

Another factor to consider is: what will be the cost of passing an
empty address into can_modify_mm() ? the search will be 0 to len.

> >       if (prot =3D=3D PROT_EXEC) {
> >               pkey =3D execute_only_pkey(mm);
> >               if (pkey < 0)
> > @@ -1376,6 +1386,7 @@ unsigned long do_mmap(struct file *file, unsigned=
 long addr,
> >                       vm_flags |=3D VM_NORESERVE;
> >       }
> >
> > +     vm_flags |=3D vm_seals;
> >       addr =3D mmap_region(file, addr, len, vm_flags, pgoff, uf);
> >       if (!IS_ERR_VALUE(addr) &&
> >           ((vm_flags & VM_LOCKED) ||
> > @@ -2679,6 +2690,14 @@ int do_vmi_munmap(struct vma_iterator *vmi, stru=
ct mm_struct *mm,
> >       if (end =3D=3D start)
> >               return -EINVAL;
> >
> > +     /*
> > +      * Check if memory is sealed before arch_unmap.
> > +      * Prevent unmapping a sealed VMA.
> > +      * can_modify_mm assumes we have acquired the lock on MM.
> > +      */
> > +     if (!can_modify_mm(mm, start, end))
> > +             return -EPERM;
> > +
>
> This function is currently called from mmap_region(), so we are going to
> run this check twice as you have it; once in do_mmap() then again in
> mma_region() -> do_vmi_munmap().  This effectively doubles your impact
> to MAP_FIXED calls.
>
Yes. To address this would require a new flag in the do_vmi_munmap(),
after passing the first check in mmap(), we could set the flag as false,
so do_vmi_munmap() would not check it again.

However, this approach was attempted in v1 and V2 of the patch [1] [2],
and was strongly opposed by Linus. It was considered as too random and
decreased the readability.

Below is my  text in V2: [3]

"When handing the mmap/munmap/mremap/mmap, once the code passed
can_modify_mm(), it means the memory area is not sealed, if the code
continues to call the other utility functions, we don't need to check
the seal again. This is the case for mremap(), the seal of src address
and dest address (when applicable) are checked first, later when the
code calls  do_vmi_munmap(), it no longer needs to check the seal
again."

Considering this is the MAP_FIXED case, and maybe that is not used
that often in practice, I think this is acceptable performance-wise,
unless you know another solution to help this.

[1] https://lore.kernel.org/lkml/20231016143828.647848-6-jeffxu@chromium.or=
g/
[2] https://lore.kernel.org/lkml/20231017090815.1067790-6-jeffxu@chromium.o=
rg/
[3] https://lore.kernel.org/lkml/CALmYWFux2m=3D9189Gs0o8-xhPNW4dnFvtqj7ptcT=
5QvzxVgfvYQ@mail.gmail.com/


> >        /* arch_unmap() might do unmaps itself.  */
> >       arch_unmap(mm, start, end);
> >
> > @@ -3102,6 +3121,14 @@ int do_vma_munmap(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
> >  {
> >       struct mm_struct *mm =3D vma->vm_mm;
> >
> > +     /*
> > +      * Check if memory is sealed before arch_unmap.
> > +      * Prevent unmapping a sealed VMA.
> > +      * can_modify_mm assumes we have acquired the lock on MM.
> > +      */
> > +     if (!can_modify_mm(mm, start, end))
> > +             return -EPERM;
> > +
>
> I am sure you've looked at the callers, from what I found there are two:
>
> The brk call uses this function, so it may check more than one VMA in
> that path.  Will the brk VMAs potentially be msealed?  I guess someone
> could do that?
>
> The other place this is use is in ipc/shm.c whhere the start/end is just
> the vma start/end, so we only really need to check that one vma.
>
Yes. Those two cases were looked at, and was the main reason that
MAP_SEALABLE is introduced as part of mmap().

As in the open discussion of the V3/V4 patch: [4] [5]

[4] https://lore.kernel.org/linux-mm/20231212231706.2680890-1-jeffxu@chromi=
um.org/T/
[5] https://lore.kernel.org/linux-mm/20240104185138.169307-3-jeffxu@chromiu=
m.org/T/

Copied here for ease of reading:
---------------------------------------------------------------------------=
------------------

During the development of V3, I had new questions and thoughts and
wished to discuss.

1> shm/aio
From reading the code, it seems to me that aio/shm can mmap/munmap
maps on behalf of userspace, e.g. ksys_shmdt() in shm.c. The lifetime
of those mapping are not tied to the lifetime of the process. If those
memories are sealed from userspace, then unmap will fail. This isn=E2=80=99=
t a
huge problem, since the memory will eventually be freed at exit or
exec. However, it feels like the solution is not complete, because of
the leaks in VMA address space during the lifetime of the process.

2> Brk (heap/stack)
Currently, userspace applications can seal parts of the heap by
calling malloc() and mseal(). This raises the question of what the
expected behavior is when sealing the heap is attempted.

let's assume following calls from user space:

ptr =3D malloc(size);
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
Option 1:  A =E2=80=9CMAP_SEALABLE=E2=80=9D flag in mmap().
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
can become executable. To defend against unintented addition of
executable bit to stack, we could let the application to seal it.

Sealing the heap (for adding X) requires special handling, since the
heap can shrink, and shrink is implemented through munmap().

Indeed, it might be possible that all virtual memory accessible to user
space, regardless of its usage pattern, could be sealed. However, this
would require additional research and development work.

---------------------------------------------------------------------------=
--------------------------


> Is there a way to avoid walking the tree for the single known VMA?
Are you thinking about a hash table to record brk VMA ? or a dedicated
tree for sealed VMAs? possible. code will be a lot more though.

> Does
> it make sense to deny mseal writing to brk VMAs?
>
Yes. It makes sense. Since brk memory doesn't have MAP_SEALABLE at
this moment,  mseal will fail even if someone tries to seal it.
Sealing brk memory would require more research and design.

>
> >       arch_unmap(mm, start, end);
> >       return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> >  }
>
> ...
>
>
> Ah, I see them now.  Yes, this is what I expected to see.  Does this not
> have any impact on mmap/munmap benchmarks?
>
Thanks for bringing this topic! I'm kind of hoping for performance related
questions.

I haven't done any benchmarks, due to lack of knowledge on how those
tests are usually performed.

For mseal(), since it will be called only in a few places (libc/elf
loading),  I'm expecting no real world  impact, and that can be
measured when we have implementations in place in libc and
elf-loading.

The hot path could be on mmap() and munmap(), as you pointed out.

mmap() was discussed above (adding a check for FIXED )

munmap(), There is a cost in calling can_modify_mm(). I thought about
calling can_modify_vma in do_vmi_align_munmap, but there are two reasons:

a. it skips arch_unmap, and arch_unmap can unmap the memory.
b. Current logic of checking sealing is: if one of VMAs between start to en=
d is
sealed, mprotect/mmap/munmap will fail without any of VMAs being modified.
This means we will need additional walking over the VMA tree.

> > +bool can_modify_mm(struct mm_struct *mm, unsigned long start, unsigned=
 long end)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     VMA_ITERATOR(vmi, mm, start);
> > +
> > +     /* going through each vma to check. */
> > +     for_each_vma_range(vmi, vma, end) {
> > +             if (!can_modify_vma(vma))
> > +                     return false;
> > +     }
> > +
> > +     /* Allow by default. */
> > +     return true;
> > +}
> > +
> > +/*
> > + * Check if the vmas of a memory range are allowed to be modified by m=
advise.
> > + * the memory ranger can have a gap (unallocated memory).
> > + * return true, if it is allowed.
> > + */
> > +bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, uns=
igned long end,
> > +             int behavior)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     VMA_ITERATOR(vmi, mm, start);
> > +
> > +     if (!is_madv_discard(behavior))
> > +             return true;
> > +
> > +     /* going through each vma to check. */
> > +     for_each_vma_range(vmi, vma, end)
> > +             if (is_ro_anon(vma) && !can_modify_vma(vma))
> > +                     return false;
> > +
> > +     /* Allow by default. */
> > +     return true;
> > +}
> > +
>
> ...
>
> > +static int check_mm_seal(unsigned long start, unsigned long end)
> > +{
> > +     struct vm_area_struct *vma;
> > +     unsigned long nstart =3D start;
> > +
> > +     VMA_ITERATOR(vmi, current->mm, start);
> > +
> > +     /* going through each vma to check. */
> > +     for_each_vma_range(vmi, vma, end) {
> > +             if (vma->vm_start > nstart)
> > +                     /* unallocated memory found. */
> > +                     return -ENOMEM;
>
> Ah, another potential user for a contiguous iterator of VMAs.
>
> > +
> > +             if (!can_add_vma_seal(vma))
> > +                     return -EACCES;
> > +
> > +             if (vma->vm_end >=3D end)
> > +                     return 0;
> > +
> > +             nstart =3D vma->vm_end;
> > +     }
> > +
> > +     return -ENOMEM;
> > +}
> > +
> > +/*
> > + * Apply sealing.
> > + */
> > +static int apply_mm_seal(unsigned long start, unsigned long end)
> > +{
> > +     unsigned long nstart;
> > +     struct vm_area_struct *vma, *prev;
> > +
> > +     VMA_ITERATOR(vmi, current->mm, start);
> > +
> > +     vma =3D vma_iter_load(&vmi);
> > +     /*
> > +      * Note: check_mm_seal should already checked ENOMEM case.
> > +      * so vma should not be null, same for the other ENOMEM cases.
>
> The start to end is contiguous, right?
Yes.  check_mm_seal makes sure the start to end is contiguous.

>
> > +      */
> > +     prev =3D vma_prev(&vmi);
> > +     if (start > vma->vm_start)
> > +             prev =3D vma;
> > +
> > +     nstart =3D start;
> > +     for_each_vma_range(vmi, vma, end) {
> > +             int error;
> > +             unsigned long tmp;
> > +             vm_flags_t newflags;
> > +
> > +             newflags =3D vma->vm_flags | VM_SEALED;
> > +             tmp =3D vma->vm_end;
> > +             if (tmp > end)
> > +                     tmp =3D end;
> > +             error =3D mseal_fixup(&vmi, vma, &prev, nstart, tmp, newf=
lags);
> > +             if (error)
> > +                     return error;
>
> > +             tmp =3D vma_iter_end(&vmi);
> > +             nstart =3D tmp;
>
> You set tmp before using it unconditionally to vma->vm_end above, so you
> can set nstart =3D vma_iter_end(&vmi) here.  But, also we know the
> VMAs are contiguous from your check_mm_seal() call, so we know nstart =3D=
=3D
> vma->vm_start on the next loop.
The code is almost the same as in mlock.c, except that we know the
VMAs are contiguous, so we don't check for some of the ENOMEM cases.
There might be ways to improve this code. For ease of code review, I
choose a consistency (same as mlock)  for now.

>
> ...

