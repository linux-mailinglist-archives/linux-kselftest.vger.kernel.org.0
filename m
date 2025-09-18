Return-Path: <linux-kselftest+bounces-41862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E4B85B64
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 17:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DC916474D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 15:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377C30F939;
	Thu, 18 Sep 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naTsBYL8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E62930F7ED
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210230; cv=none; b=BcVawSBcjZTQCKnASJMcNGg8EnCS9lQ3Y8q23O36bSVjbqk8Gc9B5fnfMsZNo55FrrdKBv/HlJ0adGffaNFEyokKE3zLFmUNESwFNd72e9Txo19wfdcLz5H03Jk/oHzg1C9mpo3PYG1RQHX19ZRdbKs0YWCYCl8o14YnBt22Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210230; c=relaxed/simple;
	bh=m9N23N4+LnhmVdeXsGPLxVwRL63rCVTKrV19dZwXBH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVea4jQ7z0tBFUnvIcLqx8Cu79FInuzsJOQoqiZlbtEtGAltjJuvMutO4ZaFokmCxHWNPpJXcMlEQlcp+jY8j4RJ9L1yytn0sVD86dJ1Yd4H32U28QSP/73Tu3opH0XXeVS1Hd2iJFcjuhW4yCBIUncI7syOtl+SmQywCAPKEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naTsBYL8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2681645b7b6so190455ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210227; x=1758815027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUuz8CD3HO9jmYGP3x/Qi9AVUuWVNLWtlJSdhydOUbQ=;
        b=naTsBYL8MnJ7nVBgKChpDFUhdEBayhJf3oa1HdvNZiR9gbZZot/iNm7h8ilzGMTh3G
         SQrqSySNx9WVE2+/pmwCRHLMplJhFDGeJdkLhIY6CHP0zv+DfWJ7NM2NbEpM2MXSLKj1
         FddbVRDx4WngwVOaxFX0C8oNHkBRH0wbC3CJloaLu7ueeBZA1lHCLPGxhz9BYcuEax4+
         NmL8///U6XFbwPA3ruWJhZPy4pZdxAYv0Qkd2xH+sV78otmDBULvdeBQ/3WZ70fqQSTR
         /5TvrK0wWtyUyOWfkY86UthGT4s8lyEbVlv7EjNGzjRxCrmg7H2MmKburLM4WiWTLz3x
         LqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210227; x=1758815027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUuz8CD3HO9jmYGP3x/Qi9AVUuWVNLWtlJSdhydOUbQ=;
        b=sZPkiDbGOUM88hNNJ5fjbvRZoX7xIEWnkaHRWbIUkBdSsOGhQD+FrDOHuRU6z05C8V
         f9iqOV5f5CNoPmKS6dqq6agzem29sA0hX0neEfPr9ktFl6TxeaocsPblObDL9V6gfqDV
         MtLQjc9Nyw0hKf7EBzGvnmdWnYocVPeoDOFaE1jKz1akrakh2FfZMSmimn+KLvYdTW8o
         3EVwA6OGem3NFmQowdoSbWOyhIKlEzGIeoHXABz2DYWzYq3S0h5SEsdsvFFjgRyv7iS8
         8B9jVwplGDmTuRVabIQ7jgM10MZZRHt4GdFNoRpqN1q54puky4Noup+PPreh+5yNJXZW
         CcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsnkcTjmZCv790lgV804vJTysbijXaUluuEaV18KNnm8LiHcFgwRLDVWokUdA5hm5r5B5sJk7MQvXGmDa/xTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPs9Rh1zM8t0SDD+CpkksPbzzZahqEGi5iHPEakfsGs1hUORs2
	4yqQYLxufVeewLnUvLvvIUx/BAchn2kBJ0fwPrtyX0Knb1cRB4zW/BrbYkbCmFT/bT+8MZfwwYY
	jqZzAXSUrmiZZSTAlLnkl9+ZNfnmuVxvB9OyIA/Bl
X-Gm-Gg: ASbGncvymHHIMD3OKlr91aOALz1Znwjl5chYINCOMjdzzCo2L1nOSsIRZfzNo8iJ+7x
	h8rDlt6ijdXzAS2ZxbZbAAjfl0wIcSyW1yxppIOiwUJhf+oYoFjFM1K5YVBNNy3DJr34ZOnFEFQ
	iIYFJFFx92W4O6pybmMm4ivtxcgGumqyf9jDh8uf/j3D4zTDBJ/T3MipNdKZdwTokYMbKaZiwLU
	ecWnw8sLQvM+DSj1kWJ8S0lL2BavfOo36pijL/ZsrHvppuB/Q21z9BDfbsYEEo=
X-Google-Smtp-Source: AGHT+IGOWncYtcrhMeRNwklhcx/jRPyb4GflMef3jOYgIJD25j97iYY51RH9RwZkkWDzLf+irjpmRR6Jnws4Dzhi7gI=
X-Received: by 2002:a17:903:1a68:b0:269:7410:d780 with SMTP id
 d9443c01a7336-2697410e815mr6509485ad.5.1758210227139; Thu, 18 Sep 2025
 08:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-6-kaleshsingh@google.com> <eb254603-edbd-4bc6-a4bd-57b6a85191b5@lucifer.local>
In-Reply-To: <eb254603-edbd-4bc6-a4bd-57b6a85191b5@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 18 Sep 2025 08:43:35 -0700
X-Gm-Features: AS18NWAMaEgzDOdwxwrnrwKqopVJAdtQ-tQlRuAS1rNhBQel6t9gDKbC_aFTnDw
Message-ID: <CAC_TJvc9HNwBbH9953vnqZQ0zLYvRF4fdZvc1Sp7OYV8bPVOCA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] mm: harden vma_count against direct modification
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Sep 15, 2025 at 09:36:36AM -0700, Kalesh Singh wrote:
> > To make VMA counting more robust, prevent direct modification of the
> > mm->vma_count field. This is achieved by making the public-facing
> > member const via a union and requiring all modifications to go
> > through a new set of helper functions the operate on a private
> > __vma_count.
> >
> > While there are no other invariants tied to vma_count currently, this
> > structural change improves maintainability; as it creates a single,
> > centralized point for any future logic, such as adding debug checks
> > or updating related statistics (in subsequent patches).
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Hmmm I"m not sure about this one.
>
> I think this is a 'we don't need it' situation, and it's making everythin=
g a bit
> uglier.
>
> I especially hate vma_count_add() and vma_count_sub(). You're essentially
> overridding the whole concept in these cases to make stuff that's already=
 in
> place work in those cases
>
> I don't think this really adds much honestly.

Hi Lorenzo,

Thanks for reviewing.

This was done to facilitate adding the assertions. So I'll drop this
along with that in the next version.

Thanks,
Kalesh

>
> (You're also clearly missing cases as the kernel bot has found issues)
>
> > ---
> >  include/linux/mm.h               | 25 +++++++++++++++++++++++++
> >  include/linux/mm_types.h         |  5 ++++-
> >  kernel/fork.c                    |  2 +-
> >  mm/mmap.c                        |  2 +-
> >  mm/vma.c                         | 12 ++++++------
> >  tools/testing/vma/vma.c          |  2 +-
> >  tools/testing/vma/vma_internal.h | 30 +++++++++++++++++++++++++++++-
> >  7 files changed, 67 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 138bab2988f8..8bad1454984c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4219,4 +4219,29 @@ static inline bool snapshot_page_is_faithful(con=
st struct page_snapshot *ps)
> >
> >  void snapshot_page(struct page_snapshot *ps, const struct page *page);
> >
> > +static inline void vma_count_init(struct mm_struct *mm)
> > +{
> > +     ACCESS_PRIVATE(mm, __vma_count) =3D 0;
> > +}
> > +
> > +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> > +{
> > +     ACCESS_PRIVATE(mm, __vma_count) +=3D nr_vmas;
> > +}
> > +
> > +static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
> > +{
> > +     vma_count_add(mm, -nr_vmas);
> > +}
> > +
> > +static inline void vma_count_inc(struct mm_struct *mm)
> > +{
> > +     vma_count_add(mm, 1);
> > +}
> > +
> > +static inline void vma_count_dec(struct mm_struct *mm)
> > +{
> > +     vma_count_sub(mm, 1);
> > +}
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 4343be2f9e85..2ea8fc722aa2 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1020,7 +1020,10 @@ struct mm_struct {
> >  #ifdef CONFIG_MMU
> >               atomic_long_t pgtables_bytes;   /* size of all page table=
s */
> >  #endif
> > -             int vma_count;                  /* number of VMAs */
> > +             union {
> > +                     const int vma_count;            /* number of VMAs=
 */
> > +                     int __private __vma_count;
> > +             };
> >
> >               spinlock_t page_table_lock; /* Protects page tables and s=
ome
> >                                            * counters
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 8fcbbf947579..ea9eff416e51 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1037,7 +1037,7 @@ static struct mm_struct *mm_init(struct mm_struct=
 *mm, struct task_struct *p,
> >       mmap_init_lock(mm);
> >       INIT_LIST_HEAD(&mm->mmlist);
> >       mm_pgtables_bytes_init(mm);
> > -     mm->vma_count =3D 0;
> > +     vma_count_init(mm);
> >       mm->locked_vm =3D 0;
> >       atomic64_set(&mm->pinned_vm, 0);
> >       memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index c6769394a174..30ddd550197e 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1828,7 +1828,7 @@ __latent_entropy int dup_mmap(struct mm_struct *m=
m, struct mm_struct *oldmm)
> >                */
> >               vma_iter_bulk_store(&vmi, tmp);
> >
> > -             mm->vma_count++;
> > +             vma_count_inc(mm);
> >
> >               if (tmp->vm_ops && tmp->vm_ops->open)
> >                       tmp->vm_ops->open(tmp);
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 64f4e7c867c3..0cd3cb472220 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -352,7 +352,7 @@ static void vma_complete(struct vma_prepare *vp, st=
ruct vma_iterator *vmi,
> >                * (it may either follow vma or precede it).
> >                */
> >               vma_iter_store_new(vmi, vp->insert);
> > -             mm->vma_count++;
> > +             vma_count_inc(mm);
> >       }
> >
> >       if (vp->anon_vma) {
> > @@ -383,7 +383,7 @@ static void vma_complete(struct vma_prepare *vp, st=
ruct vma_iterator *vmi,
> >               }
> >               if (vp->remove->anon_vma)
> >                       anon_vma_merge(vp->vma, vp->remove);
> > -             mm->vma_count--;
> > +             vma_count_dec(mm);
> >               mpol_put(vma_policy(vp->remove));
> >               if (!vp->remove2)
> >                       WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end=
);
> > @@ -1266,7 +1266,7 @@ static void vms_complete_munmap_vmas(struct vma_m=
unmap_struct *vms,
> >       struct mm_struct *mm;
> >
> >       mm =3D current->mm;
> > -     mm->vma_count -=3D vms->vma_count;
> > +     vma_count_sub(mm, vms->vma_count);
> >       mm->locked_vm -=3D vms->locked_vm;
> >       if (vms->unlock)
> >               mmap_write_downgrade(mm);
> > @@ -1795,7 +1795,7 @@ int vma_link(struct mm_struct *mm, struct vm_area=
_struct *vma)
> >       vma_start_write(vma);
> >       vma_iter_store_new(&vmi, vma);
> >       vma_link_file(vma);
> > -     mm->vma_count++;
> > +     vma_count_inc(mm);
> >       validate_mm(mm);
> >       return 0;
> >  }
> > @@ -2495,7 +2495,7 @@ static int __mmap_new_vma(struct mmap_state *map,=
 struct vm_area_struct **vmap)
> >       /* Lock the VMA since it is modified after insertion into VMA tre=
e */
> >       vma_start_write(vma);
> >       vma_iter_store_new(vmi, vma);
> > -     map->mm->vma_count++;
> > +     vma_count_inc(map->mm);
> >       vma_link_file(vma);
> >
> >       /*
> > @@ -2810,7 +2810,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >       if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
> >               goto mas_store_fail;
> >
> > -     mm->vma_count++;
> > +     vma_count_inc(mm);
> >       validate_mm(mm);
> >  out:
> >       perf_event_mmap(vma);
> > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > index 69fa7d14a6c2..ee5a1e2365e0 100644
> > --- a/tools/testing/vma/vma.c
> > +++ b/tools/testing/vma/vma.c
> > @@ -261,7 +261,7 @@ static int cleanup_mm(struct mm_struct *mm, struct =
vma_iterator *vmi)
> >       }
> >
> >       mtree_destroy(&mm->mm_mt);
> > -     mm->vma_count =3D 0;
> > +     vma_count_init(mm);
> >       return count;
> >  }
> >
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_i=
nternal.h
> > index 15525b86145d..6e724ba1adf4 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -251,7 +251,10 @@ struct mutex {};
> >
> >  struct mm_struct {
> >       struct maple_tree mm_mt;
> > -     int vma_count;                  /* number of VMAs */
> > +     union {
> > +             const int vma_count;            /* number of VMAs */
> > +             int __vma_count;
> > +     };
> >       unsigned long total_vm;    /* Total pages mapped */
> >       unsigned long locked_vm;   /* Pages that have PG_mlocked set */
> >       unsigned long data_vm;     /* VM_WRITE & ~VM_SHARED & ~VM_STACK *=
/
> > @@ -1526,4 +1529,29 @@ static int vma_count_remaining(const struct mm_s=
truct *mm)
> >       return (max_count > vma_count) ? (max_count - vma_count) : 0;
> >  }
> >
> > +static inline void vma_count_init(struct mm_struct *mm)
> > +{
> > +     mm->__vma_count =3D 0;
> > +}
> > +
> > +static inline void vma_count_add(struct mm_struct *mm, int nr_vmas)
> > +{
> > +     mm->__vma_count +=3D nr_vmas;
> > +}
> > +
> > +static inline void vma_count_sub(struct mm_struct *mm, int nr_vmas)
> > +{
> > +     vma_count_add(mm, -nr_vmas);
> > +}
> > +
> > +static inline void vma_count_inc(struct mm_struct *mm)
> > +{
> > +     vma_count_add(mm, 1);
> > +}
> > +
> > +static inline void vma_count_dec(struct mm_struct *mm)
> > +{
> > +     vma_count_sub(mm, 1);
> > +}
> > +
> >  #endif       /* __MM_VMA_INTERNAL_H */
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >

