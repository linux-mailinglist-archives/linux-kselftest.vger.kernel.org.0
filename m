Return-Path: <linux-kselftest+bounces-31456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4371DA99AFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C707A918B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 21:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00961F5617;
	Wed, 23 Apr 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSz4BKmf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182D1DE3AD
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745444987; cv=none; b=FLtZ6EfkXxIqVTKupnqz82lSYRWThkB94qw7hZB0Y+sgLqWI5M8u7d7/I5OOFmAz8MvRHeRrwnwVna7P+Tbi4qUExy9Stk3kt3q1uOn4rcFE+yd6WEelGAEO9SqvwBigjeob7outRNUuL8vZVkAC7aKuSlvKcKD3zt0yqfj544E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745444987; c=relaxed/simple;
	bh=psYEn7dEjIzHfh5YIb2BttsfQcmcniB8jfG0+YWBGsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWbXHEgHTMWhgc8S1v3MITSSl8nhTHjpICkJ+pTXWH3j3KP4OB8oGxYPuSWNzCPEBSFOPpZZ40tWAaMYblIhyMK8mWcSaOY7TCjv0ppA67F7AbH1LZACcZNMU7rYqqEh9E9u0mg4m3CBIWBCq25KWeInx89tlKumIPG+ywNWHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSz4BKmf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47666573242so140441cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745444985; x=1746049785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7/wD0XYriNGKp673eGGJ1mXgCpZhTWu5sE1MgjgFPg=;
        b=qSz4BKmfMNv2Lmv7KZnfcVszTwzxJl2iLZDggXOjubDfI+6VrIot9Lr3bYX+nVhX4l
         zMAUid5s2NMRDawAvIFgr6UdkIAjKVD5SEffeN8/xqSkd1Ic+kGAUYQSEcKkKZwcyBlz
         BZdGUESmz0t1e2gOiQEjWwDt/6avWIHiCZ/Wcys+cY4P/IazvL4nJlvpS4XC6cpcy8/F
         aqXVJhmTcY9wIkFcv4p18r86dUOha8dF2hnLx45ua8ok/WPk5+faJLCsUW/BHwpoNOHi
         KjnXiSXC/BgUhJNElsNcUprWySrGUV2zL/ijKqfd/4wu5Yeuxex8Rs9RzauooZJ26LbE
         pgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745444985; x=1746049785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7/wD0XYriNGKp673eGGJ1mXgCpZhTWu5sE1MgjgFPg=;
        b=NN3DBEP0IghBo49PVqKD8k0A2ISrg1dMc1Rhk58iLdWuNP62xfc497jYHNr5Lnr76R
         jToVWRLv3BH1QK6icwgeI6MPHZOBnZJvGJ8aiNmEPe2O1SsBYtCuW9OWkCMyzGdS0XH4
         4ShQIuLxC2xvpAFAQxCLIOsXkSUlSDCSEvubqYQna6ybknNQbmVBYRduepHd3L/KMqdc
         6iGmuI5HQXS/g0/vjGYz7P6Wohez24psRoPw5RptfomEAlzCr3Kh/G3grhgVGIUYVjWJ
         vHKn2HhyDG6E/PAa97htbvvEZr8i9TXz6fW0N+ZJL8sR+lmY8JYy0xRBJyKYLzdlZ1kk
         Bpow==
X-Forwarded-Encrypted: i=1; AJvYcCW4tfvgpjlESU+ggkAlWQaxHkTYfVIXOfZmGwWLqLI9ox1qAbj+EXzJj8kD+oK3UtrHezijnbU+yBWQi7Qfe1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72IUlUabaesUn/pCUtXqNdxIj0RbbgqmHoY315plYvL0LbIvR
	IjPY2yGHeYpFel6Ln2CKKTn4ZIZ+sMo0c3F1RGVzrO1lgnc6tkeEo7R9u5zwqwJjbW2MsgVXopB
	39GlV3pvJYC8wSj4esmqRQAHIkTl7frtx8saQ
X-Gm-Gg: ASbGnct/lxepI40/yvTY55Nz7vDdkiOBAubabAZArRKERzj/gLwNvM36nkWNlCCi3np
	G2aPvoU6RJ47XpFRdJa67dB+abkMY2JLbP++bOfAlhLD3Qv0NqaLHMLlnymTEvcMwntQbuctH04
	NyHcyvS6d9/x9/vnKhI1Vd1NkjLbGqiPsJz0HoLo8pLUuE5JN4X6uo
X-Google-Smtp-Source: AGHT+IFQfVsUfGLvaOpqsQMsbqmuN8itGhxrZwwZ0MFIqvRyvcpvtZya/7FsimV2oONrYFkrBH9PEKrdK8GJwxZvGa0=
X-Received: by 2002:a05:622a:4105:b0:47a:ed97:373e with SMTP id
 d75a77b69052e-47e79facab0mr1370541cf.10.1745444984405; Wed, 23 Apr 2025
 14:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAEf4BzYuA3ZRCwPsAxhQZDOOpjSTrphKEsgPAqgRP8Ly7+fTWw@mail.gmail.com>
In-Reply-To: <CAEf4BzYuA3ZRCwPsAxhQZDOOpjSTrphKEsgPAqgRP8Ly7+fTWw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Apr 2025 14:49:33 -0700
X-Gm-Features: ATxdqUHhpsoXV5fOytdwpz53cjD4EaJekweJa9XT6PbfPehhPHjBovEw6rKpEEE
Message-ID: <CAJuCfpE_jJ0Xq5T0HcLpquRzO+NdvN3T3_JXEwSjt2NG9Ryy5g@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 3:49=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >
> > With maple_tree supporting vma tree traversal under RCU and vma and
> > its important members being RCU-safe, /proc/pid/maps can be read under
> > RCU and without the need to read-lock mmap_lock. However vma content
> > can change from under us, therefore we make a copy of the vma and we
> > pin pointer fields used when generating the output (currently only
> > vm_file and anon_name). Afterwards we check for concurrent address
> > space modifications, wait for them to end and retry. While we take
> > the mmap_lock for reading during such contention, we do that momentaril=
y
> > only to record new mm_wr_seq counter. This change is designed to reduce
>
> This is probably a stupid question, but why do we need to take a lock
> just to record this counter? uprobes get away without taking mmap_lock
> even for reads, and still record this seq counter. And then detect
> whether there were any modifications in between. Why does this change
> need more heavy-weight mmap_read_lock to do speculative reads?

Not a stupid question. mmap_read_lock() is used to wait for the writer
to finish what it's doing and then we continue by recording a new
sequence counter value and call mmap_read_unlock. This is what
get_vma_snapshot() does. But your question made me realize that we can
optimize m_start() further by not taking mmap_read_lock at all.
Instead of taking mmap_read_lock then doing drop_mmap_lock() we can
try mmap_lock_speculate_try_begin() and only if it fails do the same
dance we do in the get_vma_snapshot(). I think that should work.

>
> > mmap_lock contention and prevent a process reading /proc/pid/maps files
> > (often a low priority task, such as monitoring/data collection services=
)
> > from blocking address space updates.
> > Note that this change has a userspace visible disadvantage: it allows
> > for sub-page data tearing as opposed to the previous mechanism where
> > data tearing could happen only between pages of generated output data.
> > Since current userspace considers data tearing between pages to be
> > acceptable, we assume is will be able to handle sub-page data tearing
> > as well.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  fs/proc/internal.h        |   6 ++
> >  fs/proc/task_mmu.c        | 170 ++++++++++++++++++++++++++++++++++----
> >  include/linux/mm_inline.h |  18 ++++
> >  3 files changed, 177 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > index 96122e91c645..6e1169c1f4df 100644
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -379,6 +379,12 @@ struct proc_maps_private {
> >         struct task_struct *task;
> >         struct mm_struct *mm;
> >         struct vma_iterator iter;
> > +       bool mmap_locked;
> > +       loff_t last_pos;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +       unsigned int mm_wr_seq;
> > +       struct vm_area_struct vma_copy;
> > +#endif
> >  #ifdef CONFIG_NUMA
> >         struct mempolicy *task_mempolicy;
> >  #endif
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index b9e4fbbdf6e6..f9d50a61167c 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -127,13 +127,130 @@ static void release_task_mempolicy(struct proc_m=
aps_private *priv)
> >  }
> >  #endif
> >
> > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *p=
riv,
> > -                                               loff_t *ppos)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static const struct seq_operations proc_pid_maps_op;
> > +
> > +/*
> > + * Take VMA snapshot and pin vm_file and anon_name as they are used by
> > + * show_map_vma.
> > + */
> > +static int get_vma_snapshot(struct proc_maps_private *priv, struct vm_=
area_struct *vma)
> > +{
> > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > +       int ret =3D -EAGAIN;
> > +
> > +       memcpy(copy, vma, sizeof(*vma));
> > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > +               goto out;
> > +
> > +       if (!anon_vma_name_get_if_valid(copy))
> > +               goto put_file;
>
> Given vm_file and anon_vma_name are both RCU-protected, if we take
> rcu_read_lock() at m_start/m_next before fetching VMA, we shouldn't
> even need getting/putting them, no?

Yeah, anon_vma_name indeed looks safe without pinning but vm_file is
using SLAB_TYPESAFE_BY_RCU cache, so it might still be a valid pointer
but pointing to a wrong object even if the rcu grace period did not
pass. With my assumption that seq_file can't rollback once show_map()
is done, I would need a completely stable vma at the time show_map()
is executed so that it does not change from under us while we are
generating the output.
OTOH, if we indeed can rollback while generating seq_file output then
show_map() could output potentially invalid vma, then check for vma
changes and when detected, rollback seq_file and retry again.

>
> I feel like I'm missing some important limitations, but I don't think
> they are spelled out explicitly...
>
> > +
> > +       if (!mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq))
> > +               return 0;
> > +
> > +       /* Address space got modified, vma might be stale. Re-lock and =
retry. */
> > +       rcu_read_unlock();
>
> Another question I have is whether we really need to copy vma into
> priv->vma_copy to have a stable snapshot? Can't we just speculate like
> with uprobes under assumption that data doesn't change. And once we
> are done producing text output, confirm that speculation was
> successful, and if not - retry?
>
> We'd need an API for seq_file to rollback to previous good known
> location for that, but that seems straightforward enough to do, no?
> Just remember buffer position before speculation, write data, check
> for no mm modifications, and if something changed, rollback seq file
> to last position.

From looking at seq_read_iter() I think for a rollback we would have
to reset seq_file.count and seq_file.index to their previous states.
At this location:
https://elixir.bootlin.com/linux/v6.14.3/source/fs/seq_file.c#L272 if
show_map() returns negative value m->count will indeed be rolled back
but not seq_file.index. Also returning negative value at
https://elixir.bootlin.com/linux/v6.14.3/source/fs/seq_file.c#L230
would be interpreted as a hard error... So, I'll need to spend some
time in this code to get the answer about rollback.
Thanks for the review!

>
>
> > +       ret =3D mmap_read_lock_killable(priv->mm);
> > +       if (!ret) {
> > +               /* mmap_lock_speculate_try_begin() succeeds when holdin=
g mmap_read_lock */
> > +               mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_se=
q);
> > +               mmap_read_unlock(priv->mm);
> > +               ret =3D -EAGAIN;
> > +       }
> > +
> > +       rcu_read_lock();
> > +
> > +       anon_vma_name_put_if_valid(copy);
> > +put_file:
> > +       if (copy->vm_file)
> > +               fput(copy->vm_file);
> > +out:
> > +       return ret;
> > +}
> > +
> > +static void put_vma_snapshot(struct proc_maps_private *priv)
> > +{
> > +       struct vm_area_struct *vma =3D &priv->vma_copy;
> > +
> > +       anon_vma_name_put_if_valid(vma);
> > +       if (vma->vm_file)
> > +               fput(vma->vm_file);
> > +}
> > +
>
> [...]

