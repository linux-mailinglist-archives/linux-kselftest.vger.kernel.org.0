Return-Path: <linux-kselftest+bounces-31921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A5AA1910
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED7B460D18
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEB224397A;
	Tue, 29 Apr 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gb5mgiqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984F2451C8
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949871; cv=none; b=AJm2qCiBUN0CvRXiu+0MGOGAeWKoERapuSR6OTvNUg/cFJ+HsLn6l3u/qLxnKXwleJFCJheqZXDxFszCHuAJNRgzXqQrdEStqMROvl8p2VzXESATG8jxYXfdkXgzRRML3uO5x1Emn1io7aFiNHBWAgBKdgtGGZncAhy01VFT5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949871; c=relaxed/simple;
	bh=0+Jt6wnHoPe3/Gkun9y2Xjhz+Air4hf4yJp89So0d10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cpi7oBFW8awwAh5wPeoC97yIhKPzF/V7qZh28Xvy4fpEUPCkrCuOnnBvaO6ZXH3E3asW70X8hnVeOgwLqCe1Fd8klVmm7Xja+yREoE5SmmfinIZlg4e5AZ63OzW69H4pNtdteYQ99SERwmwz0mqA1FC3q6GzRxYwkLHDJrsHDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gb5mgiqP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47666573242so381291cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745949869; x=1746554669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGFBOIYiVFMA2gosF4fAzdDOnh60Gs1cEA/UxI1BGcI=;
        b=Gb5mgiqP4+8F2I/gxzXjkmR31CUbqviLeocNN7oubhvWNamm8PNIHXehAl7zPqMiX/
         3GwzpwURSoUi6RaNUwyfk1kWOeJ82eolM37z67lDIGAOc48k92NyIfqRgub5RWJmviPu
         xXDDgBiwaPrf0htRRtv8YOHxQy4OeOMIGXjaTt4NnpShd75Bl65skYamDCVUdaUU/1iM
         ym/lsEf1DW6K51r97wG9uPXfeMmSfSkgStSiZw+wsw88e2ONOz3vaSkZQnN+lYd4TuDG
         Bl+K/DvaO7d1+J7mNPG1os2V3Aawvhzf316oIma8ZK3D8gIBhh6+ffFT+y7Q5e78E7yk
         IKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949869; x=1746554669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGFBOIYiVFMA2gosF4fAzdDOnh60Gs1cEA/UxI1BGcI=;
        b=q0sRlzmny3Fx5gyd6HIU6eHHvLyn3k7UChJvfGwK0UBz7v/XcbO2h4qP0C6FzMgi/m
         kuX0FnLAWDXXEkcpjBLeqKWnMlM/DZUTCZVhAlnxt4aAFyXSp8y2qIGcqJJyB7zgjWVw
         7tJd5cnMU2HbBsim0WIgUaOLeYFOOwJ6JLQsIzFbARVUXjeYPY9wIhuL7IhDbFM6HE9W
         fc5aZajnAByC0musSZ6bwE04Uz2WzkG+CkOztsKcqacBTwHA5DsFxbvPokxQNVnu4wKh
         WpIvlr2qgn8IG4Sy/InS6YsGape+gcZdkS+d5MRkIRmkP1qbu06xTmhrbgSEhAoknK3a
         FkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxMeoNVv9QXivm/VLxCVJvboY+Dz5OgnMFBZulQQCsDPwkEA3iyIWKafwcMjjnr4waLE8ruVwAX5AiA4/JRPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOCPJBNg3XISUd3pSYht98wAJ6d1EzUkguLZMaynvakjNI2kq
	xeFRwXq+uw7fRNMbHIdETrDu0mZCzyLr89Ytgv1FOLMV4QXPrQTCt+WXHe0XEsSufAaDqOAiG64
	An916mE2Zao/p5TkhjS8tJ/H4FWvp+noZpuZH
X-Gm-Gg: ASbGnctZzgWQL12a99m6HhrRW4wqWkwFhNn/oPCJnXP1FPY0in2VEv/wkuFyVu+yx0V
	LseNco6HePgWtLTLDgh3ziP7nC6h3AIo6+UzWLVgHozSayfUA+Y9oTouSmIB9skDXTUfXjUB4Hu
	7ncXoSmoRPWbgSooPK2T8Ea0UxEGaMCM+L17oScW+oxXQ94+4wEY23
X-Google-Smtp-Source: AGHT+IGTHdof2vv8tE6oOakqNkRD6qkaYwcU2GMDuR1dry0vZWexciL9KgeFFNdap4sTR6sGZPImbJQwIIPq3LvxJ3k=
X-Received: by 2002:a05:622a:8e:b0:472:538:b795 with SMTP id
 d75a77b69052e-489bb19045fmr245541cf.22.1745949868234; Tue, 29 Apr 2025
 11:04:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
 <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com> <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com>
In-Reply-To: <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Apr 2025 11:04:15 -0700
X-Gm-Features: ATxdqUEFK_c8BfZNtNDlAtU3sfwm14-hJ5pe2ZNDycq9_J7ILXRelmx3Box4ufQ
Message-ID: <CAJuCfpG+YjyVE-6TaAQEjwc0iixqN8Epf25jo2awtL=gqY=afA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:21=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> Hi!
>
> (I just noticed that I incorrectly assumed that VMAs use kfree_rcu
> (not SLAB_TYPESAFE_BY_RCU) when I wrote my review of this, somehow I
> forgot all about that...)

Does this fact affect your previous comments? Just want to make sure
I'm not missing something...

>
> On Tue, Apr 29, 2025 at 7:09=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > On Tue, Apr 29, 2025 at 8:40=E2=80=AFAM Jann Horn <jannh@google.com> wr=
ote:
> > > On Fri, Apr 18, 2025 at 7:50=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > > With maple_tree supporting vma tree traversal under RCU and vma and
> > > > its important members being RCU-safe, /proc/pid/maps can be read un=
der
> > > > RCU and without the need to read-lock mmap_lock. However vma conten=
t
> > > > can change from under us, therefore we make a copy of the vma and w=
e
> > > > pin pointer fields used when generating the output (currently only
> > > > vm_file and anon_name). Afterwards we check for concurrent address
> > > > space modifications, wait for them to end and retry. While we take
> > > > the mmap_lock for reading during such contention, we do that moment=
arily
> > > > only to record new mm_wr_seq counter. This change is designed to re=
duce
> > > > mmap_lock contention and prevent a process reading /proc/pid/maps f=
iles
> > > > (often a low priority task, such as monitoring/data collection serv=
ices)
> > > > from blocking address space updates.
> > > [...]
> > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > index b9e4fbbdf6e6..f9d50a61167c 100644
> > > > --- a/fs/proc/task_mmu.c
> > > > +++ b/fs/proc/task_mmu.c
> > > [...]
> > > > +/*
> > > > + * Take VMA snapshot and pin vm_file and anon_name as they are use=
d by
> > > > + * show_map_vma.
> > > > + */
> > > > +static int get_vma_snapshot(struct proc_maps_private *priv, struct=
 vm_area_struct *vma)
> > > > +{
> > > > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > > > +       int ret =3D -EAGAIN;
> > > > +
> > > > +       memcpy(copy, vma, sizeof(*vma));
> > > > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > > +               goto out;
> > >
> > > I think this uses get_file_rcu() in a different way than intended.
> > >
> > > As I understand it, get_file_rcu() is supposed to be called on a
> > > pointer which always points to a file with a non-zero refcount (excep=
t
> > > when it is NULL). That's why it takes a file** instead of a file* - i=
f
> > > it observes a zero refcount, it assumes that the pointer must have
> > > been updated in the meantime, and retries. Calling get_file_rcu() on =
a
> > > pointer that points to a file with zero refcount, which I think can
> > > happen with this patch, will cause an endless loop.
> > > (Just as background: For other usecases, get_file_rcu() is supposed t=
o
> > > still behave nicely and not spuriously return NULL when the file* is
> > > concurrently updated to point to another file*; that's what that loop
> > > is for.)
> >
> > Ah, I see. I wasn't aware of this subtlety. I think this is fixable by
> > checking the return value of get_file_rcu() and retrying speculation
> > if it changed.
>
> I think you could probably still end up looping endlessly in get_file_rcu=
().

By "retrying speculation" I meant it in the sense of
get_vma_snapshot() retry when it takes the mmap_read_lock and then
does mmap_lock_speculate_try_begin to restart speculation. I'm also
thinking about Liam's concern of guaranteeing forward progress for the
reader. Thinking maybe I should not drop mmap_read_lock immediately on
contention but generate some output (one vma or one page worth of
vmas) before dropping mmap_read_lock and proceeding with speculation.

>
> > > (If my understanding is correct, maybe we should document that more
> > > explicitly...)
> >
> > Good point. I'll add comments for get_file_rcu() as a separate patch.
> >
> > >
> > > Also, I think you are introducing an implicit assumption that
> > > remove_vma() does not NULL out the ->vm_file pointer (because that
> > > could cause tearing and could theoretically lead to a torn pointer
> > > being accessed here).
> > >
> > > One alternative might be to change the paths that drop references to
> > > vma->vm_file (search for vma_close to find them) such that they first
> > > NULL out ->vm_file with a WRITE_ONCE() and do the fput() after that,
> > > maybe with a new helper like this:
> > >
> > > static void vma_fput(struct vm_area_struct *vma)
> > > {
> > >   struct file *file =3D vma->vm_file;
> > >
> > >   if (file) {
> > >     WRITE_ONCE(vma->vm_file, NULL);
> > >     fput(file);
> > >   }
> > > }
> > >
> > > Then on the lockless lookup path you could use get_file_rcu() on the
> > > ->vm_file pointer _of the original VMA_, and store the returned file*
> > > into copy->vm_file.
> >
> > Ack. Except for storing the return value of get_file_rcu(). I think
> > once we detect that  get_file_rcu() returns a different file we should
> > bail out and retry. The change in file is an indication that the vma
> > got changed from under us, so whatever we have is stale.
>
> What does "different file" mean here - what file* would you compare
> the returned one against?

Inside get_vma_snapshot() I would pass the original vma->vm_file to
get_file_rcu() and check if it returns the same value. If the value
got changed we jump to  /* Address space got modified, vma might be
stale. Re-lock and retry. */ section. That should work, right?

