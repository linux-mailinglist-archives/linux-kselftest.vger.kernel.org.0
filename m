Return-Path: <linux-kselftest+bounces-38296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF43B1B6A8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDED9179417
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BF3278157;
	Tue,  5 Aug 2025 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CwmR5ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38F2777E5
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404688; cv=none; b=ceG9lOpGSvgajbdL2ya5xJd2rDRB2t+9AMMIykXbi4ZiTnzfj66zv/5qRX9dbANvFjul8HBIvRz6aVPbTyjANF/tg0wQ55qw/Jklc7r2Kdh+IJJA9xx3G3AJE93rkDvVAeEJWdzQhpBOZPKimwMv3p5U2BswH6vWKEGX9zmdLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404688; c=relaxed/simple;
	bh=arjCcfwEvuffPrclQ/6w1YywG85PqYHtkxOop0K6FLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkrQ0Z0KtzZw6jcYTwHWxCeP5kqTinzc0aCECGEZTF88VuGXzjAADVtgyf8oMyylYUqUmgIniLOPaXyLDDLLEUW11te8IqTlAsfvuW45JeChsf8KAmbSkPQpcYUrnKafwabyawctzMkNEQprIBe3SCdPJSZGoe6gS7NhV6r2f5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CwmR5ck; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4aef56cea5bso159621cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754404686; x=1755009486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aef8IAvwtLn08IdbykC4EYYFzkMHHIdInKV+pvklfuE=;
        b=1CwmR5ckkPTgkSHhLPBs0Y9Zz9PUv0ECATdi77YkZsMg0bTn0w2csYJv6CwVSmfOz/
         lV2SC5SWwbblyVsG5qzYHAxjKRuHlQJXm85vbbpEUkAKUuxznK2/Ni04hpwNr0cnJhDB
         lkDHSC2s1vtYDvT8W6Q/klC/sFVHoQOju7Vq/iYlder7so4fzlFVN8vBHHh/DRDDHhFQ
         64Qi0Z7JrPe9qmYgJF6M8nnFT70Dxh9QJL/2QjVoQNdeAFwtvLEPB8SXNlyTPQ+gSV6R
         dYvvZ7klvczbOyV1MNXrtf948CcvXDFY7on/k4kYAWbIsgXgNwe2Y1Sj1vtLizkpxe2K
         hnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404686; x=1755009486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aef8IAvwtLn08IdbykC4EYYFzkMHHIdInKV+pvklfuE=;
        b=dxVEvPHyM452PuqkvmjDT0vF3RvLtFKM/26s+4Z+vgb48dlsjhBOXfL+zjzjtsrhcG
         Tk4wiI67MpsSvft3v3Q1IwcCKjxVHQWWTUj8n1SfdPAmUtVTHEE2yRCnOixRF+Kao+uy
         uXpfbAYeO16e4C5Xo9i4DyWDk1nESGz+igOTEsqvEI15mzszLGRMnHo9vmcwU6mqlmeW
         MOzGwHkCyRJWFPIbupW07jbp7nRkW359bMyVMBcPfalqx7wJR4JeywJ1UlxZDGgAQ1B3
         MUNaVjXQnF63wsaOjaitJSCLwj7Q7Tbu2fspouE99MK3srRnaoO0V4NEP8ly4GdnAQ01
         3y6w==
X-Forwarded-Encrypted: i=1; AJvYcCVAuiU4TUKIQiF8x3XX18pHSrBfj5a7MIdHh64Hjug4oTz/zn5QNWvH4OrBfoSGZwRZjExkgcj1KrG24Ave01w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnW74ci6VkFw7M8sy80Ej9EJZvvPgVSddDTNS7etJSARpSGwJ/
	0beQvvhfGrCpaaoy8UnfVYc3PUE5Ex394ERY2tQs5QOr2Mwg93DVs1QnRK68DGJfzXUMdXcrH/+
	Is5b8p5CkhhIERcwfSJVq/jmGyNxy1k+wmygzEaqK
X-Gm-Gg: ASbGncu2sAK+w9q+DoskGH8LUrZhFiN3CkspEwbpvJ59NxAiOHwxYx2B18HQ0A/3el2
	vbUpXUAuivuQYWm18Cr+GdNmQC1kmM6oObeoXN96OccElpOJcP4vgUWwNkqLNIWfMj70AfY3UUp
	Yh+zI1jrMJhlt3XiES8IyD//7TUiHiMo6uilF3dRFjousy40x1mRXG7j15dICwlDVPLKFIEE6Ls
	xsNysjBsjvYWk3DyXj38FsNdbcB8c/VheKJow==
X-Google-Smtp-Source: AGHT+IGNgBN87aq4QIxEol6Iry1WpPeZs6N2msqSePTFM5jWMKBB+kelQvyXcVEXcEbW86sUjLIcplgHgUotOVKwENk=
X-Received: by 2002:ac8:5e4b:0:b0:48a:ba32:370 with SMTP id
 d75a77b69052e-4b084f396fbmr3912431cf.10.1754404685401; Tue, 05 Aug 2025
 07:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804231552.1217132-1-surenb@google.com> <20250804231552.1217132-4-surenb@google.com>
 <a2fca13d-87bd-4eb3-b673-46c538f46e66@suse.cz>
In-Reply-To: <a2fca13d-87bd-4eb3-b673-46c538f46e66@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 5 Aug 2025 07:37:53 -0700
X-Gm-Features: Ac12FXw4MVzzUn2oCKvSzz_8aCVi1Bw7CmRaPzcL7KBJ8BbbbzRtIwg97emJVWA
Message-ID: <CAJuCfpG7_=3cN6VrPmx1qtXq53AptNynTccG5vYUEYdfyQ71DA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:18=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/5/25 1:15 AM, Suren Baghdasaryan wrote:
> > Utilize per-vma locks to stabilize vma after lookup without taking
> > mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> > contended, we fall back to mmap_lock but take it only momentarily
> > to lock the vma and release the mmap_lock. In a very unlikely case
> > of vm_refcnt overflow, this fall back path will fail and ioctl is
> > done under mmap_lock protection.
> >
> > This change is designed to reduce mmap_lock contention and prevent
> > PROCMAP_QUERY ioctl calls from blocking address space updates.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/task_mmu.c | 81 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 65 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 843577aa7a32..1d06ecdbef6f 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -517,28 +517,78 @@ static int pid_maps_open(struct inode *inode, str=
uct file *file)
> >               PROCMAP_QUERY_VMA_FLAGS                         \
> >  )
> >
> > -static int query_vma_setup(struct mm_struct *mm)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     return mmap_read_lock_killable(mm);
> > +     lock_ctx->locked_vma =3D NULL;
> > +     lock_ctx->mmap_locked =3D false;
> > +
> > +     return 0;
> >  }
> >
> > -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_st=
ruct *vma)
> > +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     mmap_read_unlock(mm);
> > +     if (lock_ctx->mmap_locked)
> > +             mmap_read_unlock(lock_ctx->mm);
> > +     else
> > +             unlock_vma(lock_ctx);
> >  }
> >
> > -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct =
*mm, unsigned long addr)
> > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_=
locking_ctx *lock_ctx,
> > +                                                  unsigned long addr)
> >  {
> > -     return find_vma(mm, addr);
> > +     struct vm_area_struct *vma;
> > +     struct vma_iterator vmi;
> >
>
> Hm I think we can reach here with lock_ctx->mmap_locked being true via
> "goto next_vma" in query_matching_vma(). In that case we should just
> "return find_vma()" and doing the below is wrong, no?

Ah, you are quite right. I should handle mmap_locked differently in
query_vma_find_by_addr(). I will post the fix shortly.

>
> > +     unlock_vma(lock_ctx);
> > +     rcu_read_lock();
> > +     vma_iter_init(&vmi, lock_ctx->mm, addr);
> > +     vma =3D lock_next_vma(lock_ctx->mm, &vmi, addr);
> > +     rcu_read_unlock();
> > +
> > +     if (!IS_ERR_OR_NULL(vma)) {
> > +             lock_ctx->locked_vma =3D vma;
> > +     } else if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +             /* Fallback to mmap_lock on vma->vm_refcnt overflow */
> > +             mmap_read_lock(lock_ctx->mm);
> > +             vma =3D find_vma(lock_ctx->mm, addr);
> > +             lock_ctx->mmap_locked =3D true;
> > +     }
> > +
> > +     return vma;
> >  }
> >

