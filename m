Return-Path: <linux-kselftest+bounces-31915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63189AA1534
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADDA1BC30C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 17:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918E24C077;
	Tue, 29 Apr 2025 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtw2Tt3q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0A82C60
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947267; cv=none; b=tb1YJt3HZ9wfK0itbNYL3OPDchRxxxaicPG88ZD91DucDDfD48y+amwWHHNRFsPvwWKu8BQNTJWPuqzC0s91sKHtKQ/oaJ+BWUklhcKd6w7d/zhiNCtgvTjzBMNaXncvHh5xd82MexpCMshqYdcBNjokTLicODltXcjs/ev0a2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947267; c=relaxed/simple;
	bh=FO5xuLVqESfn84O6kGw14/Rak7rJcd6U3uie2v7TBAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNEZ9/vDm3aVPUiIfUAU3QFU6ceE4R8ljEFojM9MJvpzLo4qoWTimwxqpG8clWAVOusEXOlSM844KQZDiSBYp6AA40p8noHz05wim30XOfJTK6T6GP+Y+AYrDlOW2SENWRTKZf1GnoKakga0YdMYM5dnnnNKRTujBzj/UZk/Ehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtw2Tt3q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso3427a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 10:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745947263; x=1746552063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZzRObcdHr7PQq7bfSd5UhNrj/W+U/lLynlTJ+ckjFI=;
        b=jtw2Tt3qn+fsC4aYoAADgP/HOAJR+jgnU0pCojsuitryans01B8lljrfiX9co08NFf
         Ughn+1Qle4pfyJwwOqfqI/Q465S5M3mPwCGnLb2pmPR+vG9d45t5UMnLymTw29GrlFM0
         XY+pXuzKtmQ9sC0QIkOY6iIsZQV9+OxaKAzmKCrb1PNUAv2lwc9wrVElU+4bdXkat6In
         vuYxuM+xcmLcU4wSHyPwkUZc90wNN+1TaSoHaqn5CteFIAKTpNSmhAt+DmR+RlTVeu9e
         7dCwUWH7ALoWnE9hKLAj/ik0LeTtI210ONroYQywYXmkCfm43fx8iTaV/G5R260DjKoV
         cQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947263; x=1746552063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZzRObcdHr7PQq7bfSd5UhNrj/W+U/lLynlTJ+ckjFI=;
        b=Zwa1MFD2k9fJjFpX/2oCUKJ5jofNh1aIdAlBqo5A8+A60ZqkfSd6EmJ6HQqQ0Bv4F9
         UZiwr3pud9khAE1gf2zqx4WWJ7w48dPpsk4coljgrFxE+N/3/442g/uWhrpCmtauzl8r
         FYW9WmQcQkDB7z3QBivtEbH6jjPgtskU1bNrGOaQLA3/MiLzJeRROpmyHULNeGo2kw4C
         b6TQHQDPt1X+CR/D5OZhaVqhuEgPsEJiq86C+7eInagC7CEXjKexauE+lwiGm6ZMCJ1D
         owq/3OgnsNmYQ9PvFfM/yM+/rq6pKrbwSn4UI0ziP6fEJHNcluNj3qUN5Zo6768DlCZ0
         SreQ==
X-Forwarded-Encrypted: i=1; AJvYcCXozDBlCwTtP/PJlCMHRMUtDAi0wJp5GNOm/aK7cKhEge7LQPSqgdHuLTpVx5DkTz/djCf6anziVxfUomnShfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0DBw7dYr7jsPkr5qrhC3gQYJjJtAXx9EFsDz9TYlt1R7yPBW
	eobEGdReBag4lfhDE6k89Thr9aMCr0CV2iZuvfZZzSDALtGD5m7qHAFQEWiq9XmlRo7QUgZD8fz
	dizdMWGeelMNvhHQ4eUvFqr1oBTDsLvaw4dfG
X-Gm-Gg: ASbGnctTjUt786sVwe2ilZUGhgDRH2fnl6a1uM4poMxq33gSPOPpf7kCCL9EYrgMjgu
	UYpK72OeQ863toNEPq+T/6JNhcxBPsfX29/RvFDUaqoEghlSw92DiPxy7ny0g+E65Kd5FYIH90E
	THIRYzWHS9djcRqqKQ+eYGaXQlnQ6NxwtgbJlQdRYak/s9NgJC0A==
X-Google-Smtp-Source: AGHT+IHXiqqyy83qaPZfB+md16M9rNTjn8jbT8RqafBiRfGVmWl6YPMy5nKNP8fe8EziQdI0GNykmhELD881HGMp61Y=
X-Received: by 2002:a05:6402:4008:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5f839346e96mr181777a12.2.1745947263207; Tue, 29 Apr 2025
 10:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com> <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
In-Reply-To: <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Apr 2025 19:20:26 +0200
X-Gm-Features: ATxdqUFzen8Bz6q3XA569qY44VOL0_qRNo7JRo7XEkTEhlP9Kc_3Dw1bzLR5XTc
Message-ID: <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Suren Baghdasaryan <surenb@google.com>
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

Hi!

(I just noticed that I incorrectly assumed that VMAs use kfree_rcu
(not SLAB_TYPESAFE_BY_RCU) when I wrote my review of this, somehow I
forgot all about that...)

On Tue, Apr 29, 2025 at 7:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Tue, Apr 29, 2025 at 8:40=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Fri, Apr 18, 2025 at 7:50=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > With maple_tree supporting vma tree traversal under RCU and vma and
> > > its important members being RCU-safe, /proc/pid/maps can be read unde=
r
> > > RCU and without the need to read-lock mmap_lock. However vma content
> > > can change from under us, therefore we make a copy of the vma and we
> > > pin pointer fields used when generating the output (currently only
> > > vm_file and anon_name). Afterwards we check for concurrent address
> > > space modifications, wait for them to end and retry. While we take
> > > the mmap_lock for reading during such contention, we do that momentar=
ily
> > > only to record new mm_wr_seq counter. This change is designed to redu=
ce
> > > mmap_lock contention and prevent a process reading /proc/pid/maps fil=
es
> > > (often a low priority task, such as monitoring/data collection servic=
es)
> > > from blocking address space updates.
> > [...]
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index b9e4fbbdf6e6..f9d50a61167c 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > [...]
> > > +/*
> > > + * Take VMA snapshot and pin vm_file and anon_name as they are used =
by
> > > + * show_map_vma.
> > > + */
> > > +static int get_vma_snapshot(struct proc_maps_private *priv, struct v=
m_area_struct *vma)
> > > +{
> > > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > > +       int ret =3D -EAGAIN;
> > > +
> > > +       memcpy(copy, vma, sizeof(*vma));
> > > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > +               goto out;
> >
> > I think this uses get_file_rcu() in a different way than intended.
> >
> > As I understand it, get_file_rcu() is supposed to be called on a
> > pointer which always points to a file with a non-zero refcount (except
> > when it is NULL). That's why it takes a file** instead of a file* - if
> > it observes a zero refcount, it assumes that the pointer must have
> > been updated in the meantime, and retries. Calling get_file_rcu() on a
> > pointer that points to a file with zero refcount, which I think can
> > happen with this patch, will cause an endless loop.
> > (Just as background: For other usecases, get_file_rcu() is supposed to
> > still behave nicely and not spuriously return NULL when the file* is
> > concurrently updated to point to another file*; that's what that loop
> > is for.)
>
> Ah, I see. I wasn't aware of this subtlety. I think this is fixable by
> checking the return value of get_file_rcu() and retrying speculation
> if it changed.

I think you could probably still end up looping endlessly in get_file_rcu()=
.

> > (If my understanding is correct, maybe we should document that more
> > explicitly...)
>
> Good point. I'll add comments for get_file_rcu() as a separate patch.
>
> >
> > Also, I think you are introducing an implicit assumption that
> > remove_vma() does not NULL out the ->vm_file pointer (because that
> > could cause tearing and could theoretically lead to a torn pointer
> > being accessed here).
> >
> > One alternative might be to change the paths that drop references to
> > vma->vm_file (search for vma_close to find them) such that they first
> > NULL out ->vm_file with a WRITE_ONCE() and do the fput() after that,
> > maybe with a new helper like this:
> >
> > static void vma_fput(struct vm_area_struct *vma)
> > {
> >   struct file *file =3D vma->vm_file;
> >
> >   if (file) {
> >     WRITE_ONCE(vma->vm_file, NULL);
> >     fput(file);
> >   }
> > }
> >
> > Then on the lockless lookup path you could use get_file_rcu() on the
> > ->vm_file pointer _of the original VMA_, and store the returned file*
> > into copy->vm_file.
>
> Ack. Except for storing the return value of get_file_rcu(). I think
> once we detect that  get_file_rcu() returns a different file we should
> bail out and retry. The change in file is an indication that the vma
> got changed from under us, so whatever we have is stale.

What does "different file" mean here - what file* would you compare
the returned one against?

