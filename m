Return-Path: <linux-kselftest+bounces-3495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D983B4FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 23:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1B31C245C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D6F137C31;
	Wed, 24 Jan 2024 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fhowKHEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B2136654
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136561; cv=none; b=eSba2PWr7VZ+0Ry8l5AeWn3qnOHn87Om9TCoHfkYvaQo9wHhtUSwaTKE5PwUv9rGvdxX4XCMFqM71mmfNQV1e0O1LTxVt9tbKCxHxS1lHvHTT3mfAsH8fCFf8JoUp/taNSvqyYnifwK4O4JT3bt/E9LWTnKkqMoLVJk2O1V3lKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136561; c=relaxed/simple;
	bh=w/MFEGQPmLGusvdLPhMDXdszGIbyMFVod2oaGyP2PFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sYzTDgXwK0Uu1AlbXU5i6/Pv1qA267QHytWEj4DpK9B/JLCGR78omjWAP5RimZ4dQ570qX6uoMgglMkBd3kbrktAx5iDUobP1guLYUtLvtdkTEV6YliB1uilUhKnRfsIqwwAas2PYeY+iMBBOK3YzhbFAMsrnYwdhD/dE18LaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fhowKHEq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd6581bc66so4399239b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706136558; x=1706741358; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWhDv7gfrXtDczX/zXMuIZzHBsfAPIZuIHA9npMD0oo=;
        b=fhowKHEqxSNFGie6gt0fJSjWKOX3qgEG88AR3A3w4RtAhpi88ZXsXVo0baeBZBf+lT
         MGYC3Fvr+SSbh63ojLzDW2yiUSK7OEcxXW2Ha4H6SaRx7Cm/se/BlEfrgkS+I+pzP6Ca
         fqGmF6193pCLfJ6P8MEtKNh5VCQAQxfCwjAEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136558; x=1706741358;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWhDv7gfrXtDczX/zXMuIZzHBsfAPIZuIHA9npMD0oo=;
        b=F4SjMjWmNxkAUOQkAv1PzDhtQuD7uyGIss8Kn/4fqhQMB6DdAyT5f1TVo4LmAVLZcG
         CfopZrQo8wPciHM63Wu5FXlXMMBHmjaWxYjwvn4ap2AwgbmFjUTKPYlIsiDyp8ltJg+b
         yIXkeQdZ0U1w2goXt+mpzKHkAehtbv/Bvs6rY9Od0gUS9ZlRMFQrHN78f3SpMhjTK3kR
         y2+KXTkjouTgz+JMlzqvsovMZjyoS6+sktDpa8qdBaksOvsrbsr3SdcbjDz/Mbt+uXTx
         K3+oreNX25GJ2vWUtTfrQZGjrqYc+TCJuA+q7pT0wzToiOOSqYVJpKploM8BKsB7HCmn
         3Tfw==
X-Gm-Message-State: AOJu0Yzewi3akPe9vnbptWDNZrioBotleiqkzM+CMGJ5PnpRmUjhZndt
	aRZJDutPQesI/H3da4596+BW5aSmHeOHuIHdoLf7vuc+e012i6NonEEuFihyEDhvLePPLHM8/OR
	WfkbprbEFOFNUDB5WeWc3SHzFXoNTWfV2MJnQ
X-Google-Smtp-Source: AGHT+IEQFJ7EAAk7SGrnPV0CRUpPC3nyUnaqVN3Yt8MBZmid6H/lU3I2wOQj5BY80LdAEE6emFgbyHVrO0MinrKngHA=
X-Received: by 2002:a05:6871:7b09:b0:205:c4d8:155a with SMTP id
 pf9-20020a0568717b0900b00205c4d8155amr27478oac.62.1706136557589; Wed, 24 Jan
 2024 14:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <20240122152905.2220849-3-jeffxu@chromium.org>
 <20240123181457.idckaydk7dt7q2qy@revolver> <CABi2SkX=wKnHmooxXzBnJxxmtfSjvfgYabN1Wh1LxFYjtFoFaQ@mail.gmail.com>
 <20240124200628.ti327diy7arb7byb@revolver>
In-Reply-To: <20240124200628.ti327diy7arb7byb@revolver>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 24 Jan 2024 14:49:05 -0800
Message-ID: <CABi2SkV1MgPZvxdE52VSTGA7yxnv9-fZYfWe76xFd27cDyy_8w@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mseal: add mseal syscall
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:06=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [240124 12:50]:
> > On Tue, Jan 23, 2024 at 10:15=E2=80=AFAM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * jeffxu@chromium.org <jeffxu@chromium.org> [240122 10:29]:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > The new mseal() is an syscall on 64 bit CPU, and with
> > > > following signature:
> > > >
> > > > int mseal(void addr, size_t len, unsigned long flags)
> > > > addr/len: memory range.
> > > > flags: reserved.
> > > >
> > > > mseal() blocks following operations for the given memory range.
> > > >
> > > > 1> Unmapping, moving to another location, and shrinking the size,
> > > >    via munmap() and mremap(), can leave an empty space, therefore c=
an
> > > >    be replaced with a VMA with a new set of attributes.
> > > >
> > > > 2> Moving or expanding a different VMA into the current location,
> > > >    via mremap().
> > > >
> > > > 3> Modifying a VMA via mmap(MAP_FIXED).
> > > >
> > > > 4> Size expansion, via mremap(), does not appear to pose any specif=
ic
> > > >    risks to sealed VMAs. It is included anyway because the use case=
 is
> > > >    unclear. In any case, users can rely on merging to expand a seal=
ed VMA.
> > > >
> > > > 5> mprotect() and pkey_mprotect().
> > > >
> > > > 6> Some destructive madvice() behaviors (e.g. MADV_DONTNEED) for an=
onymous
> > > >    memory, when users don't have write permission to the memory. Th=
ose
> > > >    behaviors can alter region contents by discarding pages, effecti=
vely a
> > > >    memset(0) for anonymous memory.
> > > >
> > > > In addition: mmap() has two related changes.
> > > >
> > > > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > > > the map sealed since creation.
> > > >
> > > > The MAP_SEALABLE bit in the flags field of mmap(). When present, it=
 marks
> > > > the map as sealable. A map created without MAP_SEALABLE will not su=
pport
> > > > sealing, i.e. mseal() will fail.
> > > >
> > > > Applications that don't care about sealing will expect their behavi=
or
> > > > unchanged. For those that need sealing support, opt-in by adding
> > > > MAP_SEALABLE in mmap().
> > > >
> > > > I would like to formally acknowledge the valuable contributions
> > > > received during the RFC process, which were instrumental
> > > > in shaping this patch:
> > > >
> > > > Jann Horn: raising awareness and providing valuable insights on the
> > > > destructive madvise operations.
> > > > Linus Torvalds: assisting in defining system call signature and sco=
pe.
> > > > Pedro Falcato: suggesting sealing in the mmap().
> > > > Theo de Raadt: sharing the experiences and insights gained from
> > > > implementing mimmutable() in OpenBSD.
> > > >
> > > > Finally, the idea that inspired this patch comes from Stephen R=C3=
=B6ttger=E2=80=99s
> > > > work in Chrome V8 CFI.
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > > ---
> > > >  include/linux/mm.h                     |  48 ++++
> > > >  include/linux/syscalls.h               |   1 +
> > > >  include/uapi/asm-generic/mman-common.h |   8 +
> > > >  mm/Makefile                            |   4 +
> > > >  mm/madvise.c                           |  12 +
> > > >  mm/mmap.c                              |  27 ++
> > > >  mm/mprotect.c                          |  10 +
> > > >  mm/mremap.c                            |  31 +++
> > > >  mm/mseal.c                             | 343 +++++++++++++++++++++=
++++
> > > >  9 files changed, 484 insertions(+)
> > > >  create mode 100644 mm/mseal.c
> > > >
>
> ...
>
> > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index b78e83d351d2..32bc2179aed0 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1213,6 +1213,7 @@ unsigned long do_mmap(struct file *file, unsi=
gned long addr,
> > > >  {
> > > >       struct mm_struct *mm =3D current->mm;
> > > >       int pkey =3D 0;
> > > > +     unsigned long vm_seals;
> > > >
> > > >       *populate =3D 0;
> > > >
> > > > @@ -1233,6 +1234,8 @@ unsigned long do_mmap(struct file *file, unsi=
gned long addr,
> > > >       if (flags & MAP_FIXED_NOREPLACE)
> > > >               flags |=3D MAP_FIXED;
> > > >
> > > > +     vm_seals =3D get_mmap_seals(prot, flags);
> > > > +
> > > >       if (!(flags & MAP_FIXED))
> > > >               addr =3D round_hint_to_min(addr);
> > > >
> > > > @@ -1261,6 +1264,13 @@ unsigned long do_mmap(struct file *file, uns=
igned long addr,
> > > >                       return -EEXIST;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Check if the address range is sealed for do_mmap().
> > > > +      * can_modify_mm assumes we have acquired the lock on MM.
> > > > +      */
> > > > +     if (!can_modify_mm(mm, addr, addr + len))
> > > > +             return -EPERM;
> > > > +
> > >
> > > This is called after get_unmapped_area(), so this area is either goin=
g
> > > to be MAP_FIXED and return the "hint" addr or it's going to be empty.
> > > You can probably avoid walking the VMAs in the non-FIXED case.  This
> > > would remove the overhead of your check in the most common case.
> > >
> >
> > Thanks for flagging this!
> >
> > I wasn't entirely sure about get_unmapped_area() after reading the
> > code,  It calls a few variants of  arch_get_unmapped_area_xxx()
> > functions.
> >
> > e.g. it seems like the generic_get_unmapped_area_topdown  is returning
> > a non-null address even when MAP_FIXED is set to false
> >
> >  ----------------------------------------------------------------------=
------
> > generic_get_unmapped_area_topdown (
> > ...
> > if (flags & MAP_FIXED)  <-- MAP_FIXED case.
> > return addr;
> >
> > /* requesting a specific address */
> > if (addr) {  <--  note not MAP_FIXED
> > addr =3D PAGE_ALIGN(addr);
> > vma =3D find_vma_prev(mm, addr, &prev);
> > if (mmap_end - len >=3D addr && addr >=3D mmap_min_addr &&
> > (!vma || addr + len <=3D vm_start_gap(vma)) &&
> > (!prev || addr >=3D vm_end_gap(prev)))
> > return addr;                         <--- note return not null addr her=
e.
> > }
>
> Sorry, I was not clear.  Either MAP_FIXED will just return the addr, or
> the addr that is returned has no VMA (the memory area is empty).  This
> function finds a gap to place your data and the gap is (at least) as big
> as you want (usually oversized, but that doesn't matter here).  The
> mmap_lock is held, so we know it's going to remain empty.
>
> So there are two scenarios:
> 1. MAP_FIXED which may or may not have a VMA over the range
> 2. An address which has no VMA over the range
>
> Anyways, this is probably not needed, because of what I say later.
>
> >
> > -----------------------------------------------------------------------=
-----
> > I thought also about adding a check for addr !=3D null  instead, i.e.
> > if (addr && !can_modify_mm(mm, addr, addr + len))
> >     return -EPERM;
> > }
> >
> > But using MAP_FIXED to allocate memory at address 0 is legit, e.g.
> > allocating a PROT_NONE | PROT_SEAL at address 0.
> >
> > Another factor to consider is: what will be the cost of passing an
> > empty address into can_modify_mm() ? the search will be 0 to len.
>
> Almost always zero VMAs to check, it's not worth optimising.  The maple
> tree will walk to the first range and it'll be 0 to some very large
> number, most likely.
>
Got you.

> >
> > > >       if (prot =3D=3D PROT_EXEC) {
> > > >               pkey =3D execute_only_pkey(mm);
> > > >               if (pkey < 0)
> > > > @@ -1376,6 +1386,7 @@ unsigned long do_mmap(struct file *file, unsi=
gned long addr,
> > > >                       vm_flags |=3D VM_NORESERVE;
> > > >       }
> > > >
> > > > +     vm_flags |=3D vm_seals;
> > > >       addr =3D mmap_region(file, addr, len, vm_flags, pgoff, uf);
> > > >       if (!IS_ERR_VALUE(addr) &&
> > > >           ((vm_flags & VM_LOCKED) ||
> > > > @@ -2679,6 +2690,14 @@ int do_vmi_munmap(struct vma_iterator *vmi, =
struct mm_struct *mm,
> > > >       if (end =3D=3D start)
> > > >               return -EINVAL;
> > > >
> > > > +     /*
> > > > +      * Check if memory is sealed before arch_unmap.
> > > > +      * Prevent unmapping a sealed VMA.
> > > > +      * can_modify_mm assumes we have acquired the lock on MM.
> > > > +      */
> > > > +     if (!can_modify_mm(mm, start, end))
> > > > +             return -EPERM;
> > > > +
> > >
> > > This function is currently called from mmap_region(), so we are going=
 to
> > > run this check twice as you have it; once in do_mmap() then again in
> > > mma_region() -> do_vmi_munmap().  This effectively doubles your impac=
t
> > > to MAP_FIXED calls.
> > >
> > Yes. To address this would require a new flag in the do_vmi_munmap(),
> > after passing the first check in mmap(), we could set the flag as false=
,
> > so do_vmi_munmap() would not check it again.
> >
> > However, this approach was attempted in v1 and V2 of the patch [1] [2],
> > and was strongly opposed by Linus. It was considered as too random and
> > decreased the readability.
>
> Oh yes, I recall that now.  He was not pleased.
>
> >
> > Below is my  text in V2: [3]
> >
> > "When handing the mmap/munmap/mremap/mmap, once the code passed
> > can_modify_mm(), it means the memory area is not sealed, if the code
> > continues to call the other utility functions, we don't need to check
> > the seal again. This is the case for mremap(), the seal of src address
> > and dest address (when applicable) are checked first, later when the
> > code calls  do_vmi_munmap(), it no longer needs to check the seal
> > again."
> >
> > Considering this is the MAP_FIXED case, and maybe that is not used
> > that often in practice, I think this is acceptable performance-wise,
> > unless you know another solution to help this.
>
> Okay, sure, I haven't been yelled at on the ML for a few weeks.  Here
> goes:
>
> do_mmap() will call get_unmapped_area(), which will return an empty area
> (no need to check mseal, I hope - or we have larger issues here) or a
> MAP_FIXED address.
>
> do_mmap() will pass the address along to mmap_region()
>
> mmap_region() will then call do_vmi_munmap() - which will either remove
> the VMA(s) in the way, or do nothing... or error.
>
> mmap_region() will return -ENOMEM in the case of an error returned from
> do_vmi_munmap() today.  Change that to return the error code, and let
> do_vmi_munmap() do the mseal check.  If mseal check fails then the error
> is propagated the same way -ENOMEM is propagated today.
>
> This relies on the fact that we only really need to check the mseal
> status of existing VMAs and we can only really map over existing VMAs by
> first munmapping them.
>
> It does move your error return to much later in the call stack, but it
> removes duplicate work and less code.  Considering this should be a rare
> event, I don't think that's of concern.
>
I think that is a great idea, I will try to implement it and get back
to you on this.

> >
> > [1] https://lore.kernel.org/lkml/20231016143828.647848-6-jeffxu@chromiu=
m.org/
> > [2] https://lore.kernel.org/lkml/20231017090815.1067790-6-jeffxu@chromi=
um.org/
> > [3] https://lore.kernel.org/lkml/CALmYWFux2m=3D9189Gs0o8-xhPNW4dnFvtqj7=
ptcT5QvzxVgfvYQ@mail.gmail.com/
> >
> >
> > > >        /* arch_unmap() might do unmaps itself.  */
> > > >       arch_unmap(mm, start, end);
> > > >
> > > > @@ -3102,6 +3121,14 @@ int do_vma_munmap(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> > > >  {
> > > >       struct mm_struct *mm =3D vma->vm_mm;
> > > >
> > > > +     /*
> > > > +      * Check if memory is sealed before arch_unmap.
> > > > +      * Prevent unmapping a sealed VMA.
> > > > +      * can_modify_mm assumes we have acquired the lock on MM.
> > > > +      */
> > > > +     if (!can_modify_mm(mm, start, end))
> > > > +             return -EPERM;
> > > > +
> > >
> > > I am sure you've looked at the callers, from what I found there are t=
wo:
> > >
> > > The brk call uses this function, so it may check more than one VMA in
> > > that path.  Will the brk VMAs potentially be msealed?  I guess someon=
e
> > > could do that?
> > >
> > > The other place this is use is in ipc/shm.c whhere the start/end is j=
ust
> > > the vma start/end, so we only really need to check that one vma.
> > >
> > Yes. Those two cases were looked at, and was the main reason that
> > MAP_SEALABLE is introduced as part of mmap().
> >
> > As in the open discussion of the V3/V4 patch: [4] [5]
> >
> > [4] https://lore.kernel.org/linux-mm/20231212231706.2680890-1-jeffxu@ch=
romium.org/T/
> > [5] https://lore.kernel.org/linux-mm/20240104185138.169307-3-jeffxu@chr=
omium.org/T/
> >
> > Copied here for ease of reading:
> > -----------------------------------------------------------------------=
----------------------
> >
> > During the development of V3, I had new questions and thoughts and
> > wished to discuss.
> >
> > 1> shm/aio
> > From reading the code, it seems to me that aio/shm can mmap/munmap
> > maps on behalf of userspace, e.g. ksys_shmdt() in shm.c. The lifetime
> > of those mapping are not tied to the lifetime of the process. If those
> > memories are sealed from userspace, then unmap will fail. This isn=E2=
=80=99t a
> > huge problem, since the memory will eventually be freed at exit or
> > exec. However, it feels like the solution is not complete, because of
> > the leaks in VMA address space during the lifetime of the process.
> >
> > 2> Brk (heap/stack)
> > Currently, userspace applications can seal parts of the heap by
> > calling malloc() and mseal(). This raises the question of what the
> > expected behavior is when sealing the heap is attempted.
> >
> > let's assume following calls from user space:
> >
> > ptr =3D malloc(size);
> > mprotect(ptr, size, RO);
> > mseal(ptr, size, SEAL_PROT_PKEY);
> > free(ptr);
> >
> > Technically, before mseal() is added, the user can change the
> > protection of the heap by calling mprotect(RO). As long as the user
> > changes the protection back to RW before free(), the memory can be
> > reused.
> >
> > Adding mseal() into picture, however, the heap is then sealed
> > partially, user can still free it, but the memory remains to be RO,
> > and the result of brk-shrink is nondeterministic, depending on if
> > munmap() will try to free the sealed memory.(brk uses munmap to shrink
> > the heap).
> >
> > 3> Above two cases led to the third topic:
> > There one option to address the problem mentioned above.
> > Option 1:  A =E2=80=9CMAP_SEALABLE=E2=80=9D flag in mmap().
> > If a map is created without this flag, the mseal() operation will
> > fail. Applications that are not concerned with sealing will expect
> > their behavior to be unchanged. For those that are concerned, adding a
> > flag at mmap time to opt in is not difficult. For the short term, this
> > solves problems 1 and 2 above. The memory in shm/aio/brk will not have
> > the MAP_SEALABLE flag at mmap(), and the same is true for the heap.
> >
> > If we choose not to go with path, all mapping will by default
> > sealable. We could document above mentioned limitations so devs are
> > more careful at the time to choose what memory to seal. I think
> > deny of service through mseal() by attacker is probably not a concern,
> > if attackers have access to mseal() and unsealed memory, then they can
> > also do other harmful thing to the memory, such as munmap, etc.
> >
> > 4>
> > I think it might be possible to seal the stack or other special
> > mappings created at runtime (vdso, vsyscall, vvar). This means we can
> > enforce and seal W^X for certain types of application. For instance,
> > the stack is typically used in read-write mode, but in some cases, it
> > can become executable. To defend against unintented addition of
> > executable bit to stack, we could let the application to seal it.
> >
> > Sealing the heap (for adding X) requires special handling, since the
> > heap can shrink, and shrink is implemented through munmap().
> >
> > Indeed, it might be possible that all virtual memory accessible to user
> > space, regardless of its usage pattern, could be sealed. However, this
> > would require additional research and development work.
> >
> > -----------------------------------------------------------------------=
------------------------------
> >
> >
> > > Is there a way to avoid walking the tree for the single known VMA?
> > Are you thinking about a hash table to record brk VMA ? or a dedicated
> > tree for sealed VMAs? possible. code will be a lot more though.
>
> No, instead of calling a loop to walk the tree to find the same VMA,
> just check the single VMA.
>
> ipc/shm.c: do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end...
>
> So if you just check the single VMA then we don't need to worry about
> re-walking.
>
If you meant:
have a new function  do_single_vma_munmap() which checks sealing flag
and munmap for one VMA, and is used by ipc/shm.c
Yes, we can have that.

> I think this is a moot point if my outline above works.
>
Yes, I agree. that  has performance impact only for shm. We can do
this optimationzation as a follow-up patch set.

> >
> > > Does
> > > it make sense to deny mseal writing to brk VMAs?
> > >
> > Yes. It makes sense. Since brk memory doesn't have MAP_SEALABLE at
> > this moment,  mseal will fail even if someone tries to seal it.
> > Sealing brk memory would require more research and design.
> >
> > >
> > > >       arch_unmap(mm, start, end);
> > > >       return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlo=
ck);
> > > >  }
> > >
> > > ...
> > >
> > >
> > > Ah, I see them now.  Yes, this is what I expected to see.  Does this =
not
> > > have any impact on mmap/munmap benchmarks?
> > >
> > Thanks for bringing this topic! I'm kind of hoping for performance rela=
ted
> > questions.
> >
> > I haven't done any benchmarks, due to lack of knowledge on how those
> > tests are usually performed.
> >
> > For mseal(), since it will be called only in a few places (libc/elf
> > loading),  I'm expecting no real world  impact, and that can be
> > measured when we have implementations in place in libc and
> > elf-loading.
> >
> > The hot path could be on mmap() and munmap(), as you pointed out.
> >
> > mmap() was discussed above (adding a check for FIXED )
>
> That can probably be dropped as discussed above.
>
Ok.

> >
> > munmap(), There is a cost in calling can_modify_mm(). I thought about
> > calling can_modify_vma in do_vmi_align_munmap, but there are two reason=
s:
> >
> > a. it skips arch_unmap, and arch_unmap can unmap the memory.
> > b. Current logic of checking sealing is: if one of VMAs between start t=
o end is
> > sealed, mprotect/mmap/munmap will fail without any of VMAs being modifi=
ed.
> > This means we will need additional walking over the VMA tree.
>
> Certainly, but it comes at a cost.  I was just surprised with the
> statement that there is no negative from the previous discussion, as I
> replied to the cover letter.
>
Ah, the context of  my "no downside" comment is specifically to
"having the PROT_SEAL  flag in mmap()", i.e. combine mmap() and
mseal() in one call.


> > > > +/*
> > > > + * Apply sealing.
> > > > + */
> > > > +static int apply_mm_seal(unsigned long start, unsigned long end)
> > > > +{
> > > > +     unsigned long nstart;
> > > > +     struct vm_area_struct *vma, *prev;
> > > > +
> > > > +     VMA_ITERATOR(vmi, current->mm, start);
> > > > +
> > > > +     vma =3D vma_iter_load(&vmi);
> > > > +     /*
> > > > +      * Note: check_mm_seal should already checked ENOMEM case.
> > > > +      * so vma should not be null, same for the other ENOMEM cases=
.
> > >
> > > The start to end is contiguous, right?
> > Yes.  check_mm_seal makes sure the start to end is contiguous.
> >
> > >
> > > > +      */
> > > > +     prev =3D vma_prev(&vmi);
> > > > +     if (start > vma->vm_start)
> > > > +             prev =3D vma;
> > > > +
> > > > +     nstart =3D start;
> > > > +     for_each_vma_range(vmi, vma, end) {
> > > > +             int error;
> > > > +             unsigned long tmp;
> > > > +             vm_flags_t newflags;
> > > > +
> > > > +             newflags =3D vma->vm_flags | VM_SEALED;
> > > > +             tmp =3D vma->vm_end;
> > > > +             if (tmp > end)
> > > > +                     tmp =3D end;
> > > > +             error =3D mseal_fixup(&vmi, vma, &prev, nstart, tmp, =
newflags);
> > > > +             if (error)
> > > > +                     return error;
> > >
> > > > +             tmp =3D vma_iter_end(&vmi);
> > > > +             nstart =3D tmp;
> > >
> > > You set tmp before using it unconditionally to vma->vm_end above, so =
you
> > > can set nstart =3D vma_iter_end(&vmi) here.  But, also we know the
> > > VMAs are contiguous from your check_mm_seal() call, so we know nstart=
 =3D=3D
> > > vma->vm_start on the next loop.
> > The code is almost the same as in mlock.c, except that we know the
> > VMAs are contiguous, so we don't check for some of the ENOMEM cases.
> > There might be ways to improve this code. For ease of code review, I
> > choose a consistency (same as mlock)  for now.
>
> Yes, I thought that was the case.  tmp is updated in that code to ensure
> we have reached the end of the range without a gap at the end.  Since
> you already checked that the VMAs are contiguous, the last tmp update in
> your loop is not needed.
>
> Thanks,
> Liam

