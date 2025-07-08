Return-Path: <linux-kselftest+bounces-36733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1AAFBE82
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E794A4989
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 23:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C6274FD7;
	Mon,  7 Jul 2025 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxWXNVl+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C212641D8
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929844; cv=none; b=IBAqpURNN3Hx3E9wYIhQhIdy9uh0KGFf+aWZxN5ZaokfxS8o1e7lPAtlLX0gWIkrwgC05mU19TGYHz0anV5S/uYfSuQZBTQzxwJFQw1LZ4v9OuGPTDh92p12Y9S4LKLTLRZNWY0LkvSbGBH8HJ29EZTgMs/RymeRbF3ic1WzYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929844; c=relaxed/simple;
	bh=tZhkFHPBvMJnEsFOjAK+ZV5wqZ32TWviRMo8q29pWyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oko02sXrhW1WFcshZSowg+jzcKNYRxCSuFcqR+5pukrYmM3UCav/vpe99BozAEH/WWRAahGvcrVcgGdFDM+WHx2v1hUDfoqXQNQdh1MKoiiuNGmFId2dknfJcq6TtF45crYN+wdlb6yCSJKNbjqaQMUYjcyUEHsMQMS9Dq1lbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxWXNVl+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso81881cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jul 2025 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751929841; x=1752534641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMzk80ClTctU/s8e5bWFAbhEvF0TgBGkeznaLWKRXFk=;
        b=LxWXNVl+Hn6K4JNYISK+YTgc2EP3GyTUqsDPHfkHks4xFYVxKxcTiZ7wQeFeqacqGC
         VOnKAfK4gXberXP1Cjb8hIyeVkc4EIbjdjPo6lS31XRkSp1mgiiVgnmeY/R4GUUxqLXO
         3ztTfbHQNdlBdyMsBCtW5KCiU9D5Qt1yoj6OEJ9froUHLBUxjDifBwLmtd7Zq1S1PGeC
         tw1ldL4hIZVJIgZUwTA8ZCikd8YRZM5Qm6K2kz2VkX73U/mi4MITe2sMt70XZzZ2Ij1h
         d24pjHymTI2WY0mFMt8zdsawiGwKmr+6ZwK/zpPVJtSx59AxIn4pEq6IdLevw0xA03Qv
         vphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751929841; x=1752534641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMzk80ClTctU/s8e5bWFAbhEvF0TgBGkeznaLWKRXFk=;
        b=VkoRmvk30IwTU4Kh7vDYN7wjyzyk7sMQhwZp1b2m69XVJJZHShU0ZUeCl1/tYaCMLu
         1MXpmjbROFNB1OEEREyPIA9vmghApv2OmHauI0TUhiT3eEPAbhLP/PKMmU02T6sFv0Xp
         cJzcx4qEl1tFalfFhL34vAX3PEqR3FS/br7K50mcu1fV9h014ZDVL6jSDOMweP8NTLz+
         +zZknVNH/6DTh0G39oSur/xKr2J/vSB7pCZrjGUhft1GhEeJpNc10afiYl1sA3CeUaXB
         PB6ZIJiVDkdIDpxUlkb54h6viOis2MtihH+irWFmn0j7+GW/7aC0FZ2fNF76ExoZvASy
         Nj/g==
X-Forwarded-Encrypted: i=1; AJvYcCUnYbfHgG30WVZ8Fv2g1lrhJqUPA+9aJn9Sh9at2Hzf0T0DuNYR4H0ntPaieaIxWWLY+Q7dMP7EipS1kPmyW2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoQwccUC9vPR7PZVw9AvnqlKgwrMoCQN8Lb/JcMYb+g5tmPID
	lzOz3ZqPNy3i65wsjSQQu+RuySxjcOPYARYS8AnxZ5MssnDJ4J54fecJm/lDDOiYkHAbMv7z6oe
	kHPXJOtbhb05GBBykWSf0KcT9X0z1bwmpsilr3B68
X-Gm-Gg: ASbGncuLfjWpTPOpWMw4PYdG8Q3AXTf1YSY+w1nUOmdGRGCjDkS6vOdC9bDZThyaWjp
	Mn+qIn1gxkYLaq8OcebQ79R1wr0T6791VniAWYvJWAc4qXeS537WcNrYR4fpUurzxxDFeWg+KSH
	pSEZW+1v/kENBJ2Atwg0hvE6YfgCP9DPjEw49XAqkgow==
X-Google-Smtp-Source: AGHT+IFRftNclDhDE85C3G5SPBUoKCMbo4YHLh9HFM+jZZdRjQm928+TACGfIiOj7W3GBeUMm23CUPJKD8pKnzNCqs4=
X-Received: by 2002:a05:622a:a6ce:b0:4a6:f9d2:b547 with SMTP id
 d75a77b69052e-4a9ccdfdb23mr1187431cf.20.1751929840730; Mon, 07 Jul 2025
 16:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local>
In-Reply-To: <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 7 Jul 2025 16:10:29 -0700
X-Gm-Features: Ac12FXzCu93dUaa0at0h6Twga81L1k0TZUj6lkiZha60zMyOugUDrIMtP0vghGo
Message-ID: <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Sorry I know it's annoying, but some petty commit msg nits:
>
> On Thu, Jul 03, 2025 at 11:07:25PM -0700, Suren Baghdasaryan wrote:
> > With maple_tree supporting vma tree traversal under RCU and per-vma
> > locks, /proc/pid/maps can be read while holding individual vma locks
> > instead of locking the entire address space.
> > Completely lockless approach (walking vma tree under RCU) would be quit=
e
>
> Completely lockless approach -> A completely lockless approach
>
> > complex with the main issue being get_vma_name() using callbacks which
> > might not work correctly with a stable vma copy, requiring original
> > (unstable) vma - see special_mapping_name() for an example.
>
> NIT: for an example -> for example

Ack.

>
> > When per-vma lock acquisition fails, we take the mmap_lock for reading,
> > lock the vma, release the mmap_lock and continue. This fallback to mmap
> > read lock guarantees the reader to make forward progress even during
> > lock contention. This will interfere with the writer but for a very
> > short time while we are acquiring the per-vma lock and only when there
> > was contention on the vma reader is interested in. We shouldn't see a
>
> Can we separate out into a new paragraph?

Will do.

>
> > repeated fallback to mmap read locks in practice, as this require a
> > very unlikely series of lock contentions (for instance due to repeated
> > vma split operations). However even if this did somehow happen, we woul=
d
> > still progress.
> > One case requiring special handling is when vma changes between the
>
> when vma changes -> when a vma chnages

Ack.

>
> > time it was found and the time it got locked. A problematic case would
> > be if vma got shrunk so that it's start moved higher in the address
>
> vma -> a vma

Ack.

>
> it's start moved higher -> its vm_start moved higher

Ack.

>
> > space and a new vma was installed at the beginning:
> >
> > reader found:               |--------VMA A--------|
> > VMA is modified:            |-VMA B-|----VMA A----|
> > reader locks modified VMA A
> > reader reports VMA A:       |  gap  |----VMA A----|
> >
> > This would result in reporting a gap in the address space that does not
> > exist. To prevent this we retry the lookup after locking the vma, howev=
er
> > we do that only when we identify a gap and detect that the address spac=
e
> > was changed after we found the vma.
>
> Can we separate out into a new paragraph?

Ack.

>
> > This change is designed to reduce mmap_lock contention and prevent a
> > process reading /proc/pid/maps files (often a low priority task, such
> > as monitoring/data collection services) from blocking address space
> > updates. Note that this change has a userspace visible disadvantage:
> > it allows for sub-page data tearing as opposed to the previous mechanis=
m
> > where data tearing could happen only between pages of generated output
> > data. Since current userspace considers data tearing between pages to b=
e
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> OK this is looking pretty great now, I make a bunch of points below, but =
I
> don't think anything is holding this up from being OK, so with those
> addressed:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

>
> > ---
> >  fs/proc/internal.h        |   5 ++
> >  fs/proc/task_mmu.c        | 118 ++++++++++++++++++++++++++++++++++----
> >  include/linux/mmap_lock.h |  11 ++++
> >  mm/madvise.c              |   3 +-
> >  mm/mmap_lock.c            |  88 ++++++++++++++++++++++++++++
> >  5 files changed, 214 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index 3d48ffe72583..7c235451c5ea 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -384,6 +384,11 @@ struct proc_maps_private {
> >       struct task_struct *task;
> >       struct mm_struct *mm;
> >       struct vma_iterator iter;
> > +     loff_t last_pos;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     bool mmap_locked;
> > +     struct vm_area_struct *locked_vma;
> > +#endif
> >  #ifdef CONFIG_NUMA
> >       struct mempolicy *task_mempolicy;
> >  #endif
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index b8bc06d05a72..ff3fe488ce51 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -127,15 +127,107 @@ static void release_task_mempolicy(struct proc_m=
aps_private *priv)
> >  }
> >  #endif
> >
> > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *p=
riv,
> > -                                             loff_t *ppos)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static void unlock_vma(struct proc_maps_private *priv)
> > +{
> > +     if (priv->locked_vma) {
> > +             vma_end_read(priv->locked_vma);
> > +             priv->locked_vma =3D NULL;
> > +     }
> > +}
> > +
> > +static const struct seq_operations proc_pid_maps_op;
> > +
> > +static inline bool lock_vma_range(struct seq_file *m,
> > +                               struct proc_maps_private *priv)
>
> OK this is a nice abstraction.
>
> > +{
> > +     /*
> > +      * smaps and numa_maps perform page table walk, therefore require
> > +      * mmap_lock but maps can be read with locking just the vma.
>
> Probably worth mentioning that you hold the RCU read lock for the operati=
on
> also.

Ack.

>
> > +      */
> > +     if (m->op !=3D &proc_pid_maps_op) {
> > +             if (mmap_read_lock_killable(priv->mm))
> > +                     return false;
> > +
> > +             priv->mmap_locked =3D true;
> > +     } else {
> > +             rcu_read_lock();
> > +             priv->locked_vma =3D NULL;
> > +             priv->mmap_locked =3D false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static inline void unlock_vma_range(struct proc_maps_private *priv)
>
> I guess the 'range' is either - the whole thing in case of mmap read
> locked, or single VMA in case of per-VMA locks.

Correct.

>
> > +{
> > +     if (priv->mmap_locked) {
> > +             mmap_read_unlock(priv->mm);
> > +     } else {
> > +             unlock_vma(priv);
> > +             rcu_read_unlock();
> > +     }
> > +}
> > +
> > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > +                                        loff_t last_pos)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     if (priv->mmap_locked)
> > +             return vma_next(&priv->iter);
> > +
> > +     unlock_vma(priv);
> > +     vma =3D lock_next_vma(priv->mm, &priv->iter, last_pos);
> > +     if (!IS_ERR_OR_NULL(vma))
> > +             priv->locked_vma =3D vma;
> > +
> > +     return vma;
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */
> > +
> > +static inline bool lock_vma_range(struct seq_file *m,
> > +                               struct proc_maps_private *priv)
> >  {
> > -     struct vm_area_struct *vma =3D vma_next(&priv->iter);
> > +     return mmap_read_lock_killable(priv->mm) =3D=3D 0;
> > +}
> > +
> > +static inline void unlock_vma_range(struct proc_maps_private *priv)
> > +{
> > +     mmap_read_unlock(priv->mm);
> > +}
> > +
> > +static struct vm_area_struct *get_next_vma(struct proc_maps_private *p=
riv,
> > +                                        loff_t last_pos)
> > +{
> > +     return vma_next(&priv->iter);
> > +}
> >
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> > +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t =
*ppos)
> > +{
> > +     struct proc_maps_private *priv =3D m->private;
> > +     struct vm_area_struct *vma;
> > +
> > +     vma =3D get_next_vma(priv, *ppos);
> > +     /* EINTR is possible */
> > +     if (IS_ERR(vma))
> > +             return vma;
> > +
> > +     /* Store previous position to be able to restart if needed */
> > +     priv->last_pos =3D *ppos;
> >       if (vma) {
> > -             *ppos =3D vma->vm_start;
> > +             /*
> > +              * Track the end of the reported vma to ensure position c=
hanges
> > +              * even if previous vma was merged with the next vma and =
we
> > +              * found the extended vma with the same vm_start.
> > +              */
> > +             *ppos =3D vma->vm_end;
> >       } else {
> > -             *ppos =3D -2;
> > +             *ppos =3D -2; /* -2 indicates gate vma */
> >               vma =3D get_gate_vma(priv->mm);
> >       }
> >
> > @@ -163,28 +255,34 @@ static void *m_start(struct seq_file *m, loff_t *=
ppos)
> >               return NULL;
> >       }
> >
> > -     if (mmap_read_lock_killable(mm)) {
> > +     if (!lock_vma_range(m, priv)) {
> >               mmput(mm);
> >               put_task_struct(priv->task);
> >               priv->task =3D NULL;
> >               return ERR_PTR(-EINTR);
> >       }
> >
> > +     /*
> > +      * Reset current position if last_addr was set before
> > +      * and it's not a sentinel.
> > +      */
> > +     if (last_addr > 0)
> > +             *ppos =3D last_addr =3D priv->last_pos;
> >       vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
> >       hold_task_mempolicy(priv);
> >       if (last_addr =3D=3D -2)
> >               return get_gate_vma(mm);
> >
> > -     return proc_get_vma(priv, ppos);
> > +     return proc_get_vma(m, ppos);
> >  }
> >
> >  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> >  {
> >       if (*ppos =3D=3D -2) {
> > -             *ppos =3D -1;
> > +             *ppos =3D -1; /* -1 indicates no more vmas */
> >               return NULL;
> >       }
> > -     return proc_get_vma(m->private, ppos);
> > +     return proc_get_vma(m, ppos);
> >  }
> >
> >  static void m_stop(struct seq_file *m, void *v)
> > @@ -196,7 +294,7 @@ static void m_stop(struct seq_file *m, void *v)
> >               return;
> >
> >       release_task_mempolicy(priv);
> > -     mmap_read_unlock(mm);
> > +     unlock_vma_range(priv);
> >       mmput(mm);
> >       put_task_struct(priv->task);
> >       priv->task =3D NULL;
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 5da384bd0a26..1f4f44951abe 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -309,6 +309,17 @@ void vma_mark_detached(struct vm_area_struct *vma)=
;
> >  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
> >                                         unsigned long address);
> >
> > +/*
> > + * Locks next vma pointed by the iterator. Confirms the locked vma has=
 not
> > + * been modified and will retry under mmap_lock protection if modifica=
tion
> > + * was detected. Should be called from read RCU section.
> > + * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR i=
f the
> > + * process was interrupted.
> > + */
> > +struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> > +                                  struct vma_iterator *iter,
> > +                                  unsigned long address);
> > +
> >  #else /* CONFIG_PER_VMA_LOCK */
> >
> >  static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index a34c2c89a53b..e61e32b2cd91 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -108,7 +108,8 @@ void anon_vma_name_free(struct kref *kref)
> >
> >  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
> >  {
> > -     mmap_assert_locked(vma->vm_mm);
> > +     if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> > +             vma_assert_locked(vma);
>
> This looks familiar ;)

Yep, that's your fix which I folded in.

>
> >
> >       return vma->anon_name;
> >  }
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 5f725cc67334..ed0e5e2171cd 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -178,6 +178,94 @@ struct vm_area_struct *lock_vma_under_rcu(struct m=
m_struct *mm,
> >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> >       return NULL;
> >  }
> > +
> > +static struct vm_area_struct *lock_vma_under_mmap_lock(struct mm_struc=
t *mm,
> > +                                                    struct vma_iterato=
r *iter,
>
> Nit, but we tend to call this vmi (yes Liam and I are addicted to 3 lette=
r
> abbreviations, we are evil beings)

Ok, I'll rename it.

>
> > +                                                    unsigned long addr=
ess)
>
> I swear we already had a helper for this? Maybe misremembering

I think you might be confusing it with lock_vma_under_rcu()


>
> > +{
> > +     struct vm_area_struct *vma;
> > +     int ret;
> > +
> > +     ret =3D mmap_read_lock_killable(mm);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     /* Lookup the vma at the last position again under mmap_read_lock=
 */
> > +     vma_iter_init(iter, mm, address);
> > +     vma =3D vma_next(iter);
>
> Maybe worth calling this lock_next_under_mmap_lock() as we are grabbing t=
he
> next VMA here??

Sure. lock_next_vma_under_mmap_lock() ?

>
> > +     if (vma)
> > +             vma_start_read_locked(vma);
> > +
> > +     mmap_read_unlock(mm);
> > +
> > +     return vma;
> > +}
> > +
> > +struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> > +                                  struct vma_iterator *iter,
> > +                                  unsigned long address)
>
> Slightly confusing this, I think last_pos would be better? Or last_addres=
s?
>
> Otherwise it's not clear it's the address of the next VMA or the end of t=
he
> previous.

Ok, last_address it is then.

>
> > +{
> > +     struct vm_area_struct *vma;
> > +     unsigned int mm_wr_seq;
> > +     bool mmap_unlocked;
> > +
> > +     RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
> > +retry:
> > +     /* Start mmap_lock speculation in case we need to verify the vma =
later */
> > +     mmap_unlocked =3D mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> > +     vma =3D vma_next(iter);
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     vma =3D vma_start_read(mm, vma);
> > +
>
> Nit, but myabe erase this newline.

Ack.

>
> > +     if (IS_ERR_OR_NULL(vma)) {
> > +             /*
> > +              * Retry immediately if the vma gets detached from under =
us.
> > +              * Infinite loop should not happen because the vma we fin=
d will
> > +              * have to be constantly knocked out from under us.
> > +              */
> > +             if (PTR_ERR(vma) =3D=3D -EAGAIN) {
>
> Maybe worth a comment here stating that we intentionally retry getting th=
e
> next VMA, and therefore must reset to the last visited adress each time.

Ack.

>
> > +                     vma_iter_init(iter, mm, address);
>
> Maybe Liam can confirm this is the best approach? Seems correct though.

Liam's Reviewed-by confirms correctness now :)

>
> > +                     goto retry;
> > +             }
> > +
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Verify the vma we locked belongs to the same address space and=
 it's
> > +      * not behind of the last search position.
> > +      */
> > +     if (unlikely(vma->vm_mm !=3D mm || address >=3D vma->vm_end))
> > +             goto out_unlock;
> > +
> > +     /*
> > +      * vma can be ahead of the last search position but we need to ve=
rify
> > +      * it was not shrunk after we found it and another vma has not be=
en
> > +      * installed ahead of it. Otherwise we might observe a gap that s=
hould
> > +      * not be there.
> > +      */
> > +     if (address < vma->vm_start) {
> > +             /* Verify only if the address space might have changed si=
nce vma lookup. */
> > +             if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr=
_seq)) {
> > +                     vma_iter_init(iter, mm, address);
> > +                     if (vma !=3D vma_next(iter))
> > +                             goto out_unlock;
> > +             }
> > +     }
> > +
> > +     return vma;
> > +
> > +out_unlock:
> > +     vma_end_read(vma);
> > +out:
>
> Maybe these labels should reflect the fact this is a fallback case?
>
> Like fallback_unlock + fallback?

Ack.

>
> > +     rcu_read_unlock();
> > +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> > +     rcu_read_lock();
>
> OK I guess we hold the RCU lock _the whole time_ as we traverse except wh=
en
> we lock under mmap lock.

Correct.

>
> > +
> > +     return vma;
> > +}
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> >  #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >

