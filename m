Return-Path: <linux-kselftest+bounces-41450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4CB56DA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 02:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FD91773E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC91D86FF;
	Mon, 15 Sep 2025 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezRECmN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B711C5F2C
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757897049; cv=none; b=Edg2QY2U+hMYXDmgxGJNNC7MDRE40M6a+89skmk+WIwJ6AT3cg/2W0hHkUznexgL8YVF4w9aUB8v2oaKLr6XskQrTvDQQ6iYzxZuDmc/Aery8pTgYYnqoEZGjxh8545Qiq5J2tSqo7lEtErlH5lr3puodcBhFvvtMewcRC1Tfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757897049; c=relaxed/simple;
	bh=aA8qj6lRb3xePM94d10e4Y4cI1pxwAPWJSkyEKnf/Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAMHZ47Tl5QcqL6P1Sa+70VnlrZ+X4BdUo1ZGzc30/f1BisfPnVXj/aDBiUEDGYWZm+murY85WVnO3jLNFPPB4cGI+QMoVKDgCVZ3eSmA6bwXII//nJeeryJ0tN5M7Z+TnJufHB+d2kXIwkBE+bAbYh6luJQN0tfuBhWJvHIhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezRECmN0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b796ff6d45so358881cf.1
        for <linux-kselftest@vger.kernel.org>; Sun, 14 Sep 2025 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757897045; x=1758501845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9JaDewgxuozpkxda6xKseXUycmdfaWorgRDXhlzyRo=;
        b=ezRECmN0a4nK9kCzUpB+/lYvlQSMQlQCpSdX9Jpjx4TgeBsPGrEehTdeIAV4GK2qwx
         Qs22HVTDByhu5MHfg3o34iBVzCTP31hl8p7tS9Xy4y4bcH4k5K2xGschCXCOcwlyTCGC
         PTmBzeIMiRfULtg0Qx3I5BgslLQM2vwQNhEDNCwuDq61XrXIsOrpVGwTXlFyCNSAQScb
         NBA4b5JDyCXfzSkFeo+weMPaCwpJezPgya0aun9F8jXyhc4YTQljzW2Y3f7KKSJ5ur+G
         xfmnc94RaGISrlA+nG0HXS0h4gblzLwhnGPEmfwux3feD+8sohwY1A443F34F9A1kSYl
         LRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757897045; x=1758501845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9JaDewgxuozpkxda6xKseXUycmdfaWorgRDXhlzyRo=;
        b=nwLGwPAUbEPyr0Lvo62IajjRKQZ9kNktHk1rCGM8K7gNTmm6uVYh3IJ66wQbtIseBg
         nMXJsTXhxEtndu10RSViWrNoOEne+3x/g9rHYDoJ75gJ1DuCRQARriT33h7h/zGnkhCt
         DkbnHgroAQqoB3DVVpltl4D7L+Xu8jBwrrtKdls5gmJzpz8AOencr1lZ9pcTKdbKiEJN
         bgCdS4YZggqGKbjvs/jHTevLWsT5MulqPCOrf3OcTNIm79p5PwNSu58N/8WCfOOk/mDp
         Hqn010hc4XSoHEZssgtTxN77IilFMtx9CQP6jNh3l45pl6F1ZBA09n7wPx2v4UfMMbN6
         7hCA==
X-Forwarded-Encrypted: i=1; AJvYcCULOFbl3itnEw6JKNgidDz9U4zBXtbmEE9MnFfq9ipNpCRJ7gsoaiqfyyRapafRFEC7Gq0vKxnsipk7CZM2QQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrL2j4JsSgge4p//7PLLmspK0DhVcY45C45y9ZnWtNPWM7YN+F
	KvhCq5gog5fpI3k869Zo8JF+hTjpFS3DE2z+z0+TmcAB2UgJkIo3DV00/ZWdbxEeXoJZBSIGBk4
	/VjUTw5OSpN3eDq3WfPE97ayz8mduGIgZA40T4b/L
X-Gm-Gg: ASbGncsSTJqTa6Z0YyDokIbWYD1cuRgN59jxeLGJo1cQJX1A93yGemnVgXCpZFL6xir
	7PGaBhM1KUwTsi7lsi7hCc4PDsec/W3+Xd5uksZXVeejT8EvCcn6WUb4bLh+lodX9h1/mUgAJPj
	GyJKyO1DX1wwoMr1WjqRhVBUZHzTXN/CfvmdsDtXiTf3KAdjp92EWfZmTsEbidcmjHOXM8TBXyK
	7QnTY/1Fj3/ngZkukciWXU=
X-Google-Smtp-Source: AGHT+IEezB3iSLbeJTHsIwywK29EKKbUJtnk62B10GeCdyT9bGxf+jf23KN9V20U3FFXbSgM6H7iFnxQMLHkzklqJuw=
X-Received: by 2002:a05:622a:900f:b0:4b3:7533:c1dd with SMTP id
 d75a77b69052e-4b78b98e1ecmr8313771cf.1.1757897045275; Sun, 14 Sep 2025
 17:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808152850.2580887-4-surenb@google.com> <20250914114308.3024033-1-clm@meta.com>
In-Reply-To: <20250914114308.3024033-1-clm@meta.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Sep 2025 17:43:54 -0700
X-Gm-Features: AS18NWCmk4aMAnU5waOHNrHwd6qTif_tgIS8NTe99BvH87FvfzNuXoMxBTE1cSY
Message-ID: <CAJuCfpGuvyRj6zxPuJDzCcGz_-x7feycsCkNQT0+Nzn4oUYcSA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
To: Chris Mason <clm@meta.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 6:24=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
>
> On Fri,  8 Aug 2025 08:28:49 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
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
> > Acked-by: SeongJae Park <sj@kernel.org>
> > ---
> >  fs/proc/task_mmu.c | 103 +++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 85 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index c0968d293b61..e64cf40ce9c4 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -132,6 +132,12 @@ static void release_task_mempolicy(struct proc_map=
s_private *priv)
>
> [ ... ]
>
> > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_=
locking_ctx *lock_ctx,
> > +                                                  unsigned long addr)
> > +{
> > +     struct mm_struct *mm =3D lock_ctx->mm;
> > +     struct vm_area_struct *vma;
> > +     struct vma_iterator vmi;
> > +
> > +     if (lock_ctx->mmap_locked)
> > +             return find_vma(mm, addr);
> > +
> > +     /* Unlock previously locked VMA and find the next one under RCU *=
/
> > +     unlock_ctx_vma(lock_ctx);
> > +     rcu_read_lock();
> > +     vma_iter_init(&vmi, mm, addr);
> > +     vma =3D lock_next_vma(mm, &vmi, addr);
> > +     rcu_read_unlock();
> > +
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     if (!IS_ERR(vma)) {
> > +             lock_ctx->locked_vma =3D vma;
> > +             return vma;
> > +     }
> > +
> > +     if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +             /* Fallback to mmap_lock on vma->vm_refcnt overflow */
> > +             mmap_read_lock(mm);
>
> I know it's just a (very rare) fallback, but should we be using
> mmap_read_lock_killable() for consistency?  I can see this impacting oom
> kills or other times we really want to be able to get rid of procs.

That's a good idea. From a quick look it seems safe to fail with
-EINTR here, which will propagate all the way to do_procmap_query().
Do you want to post a fixup patch?
Thanks,
Suren.

>
> -chris

