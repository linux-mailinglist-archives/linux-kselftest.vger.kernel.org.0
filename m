Return-Path: <linux-kselftest+bounces-32402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CEFAA994A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38083AB58B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686141A255C;
	Mon,  5 May 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAgz60rR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81860224D7
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463122; cv=none; b=tFHmEMdlyP5fHu4hnj04k+Vv2MilPJwUezI8efg/FRPZtbMYjqRDTlq5R5WZatu7is9BIMyVZMdO053GJTn+HCqtudsx73fytWdU04d1LB7n3HSlquEgR7rE4P8pDBg8jzZlNfawp4kU/04nNaFw+OPSH8oWd/xlWr2WMd0mtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463122; c=relaxed/simple;
	bh=GeoqyUZ96ZhiA4JfLEQL3jDROUwM0rclHT0XNphb5Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSOooyhFM+h1d+JA1PW9tUfzrxLXQOopju75VKdrqsgjFxOC8sGa6bTLimacgSk/03+siSGajCO51rcr/SIhrXLp8ZcCo3vklNCsCVv+M2cNrKF433hK3pYQxHJMQqGMj+xHsO+1wZDez2j7yFW1xkYHXpxr6yXGn/50H4BPmhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAgz60rR; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-48b7747f881so555351cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746463119; x=1747067919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8cGfqMPxInbFVttVOXD20cN2ryppIoxJ2ihtNYujm8=;
        b=HAgz60rReJj+O96uR9Ae/uyjdiYC30LHKP39xrUunt/f9pDJLZidsyI365/6dzYhnn
         yRyDf5RGWMsiuwAhdh+OBZ96uWXrAwsLc/oen42vyWas8iRryJqyl1Vura4aO4cQP8Ax
         9u+R2WioKr1LRa5fv5j6fRYSdsnrRcC4R3yv2JZA5fWETxrV3M0Zy72pn0S2Ml0OnjOv
         f8c/7oFFGxu2z08AvnaMTvFSUru7mGeCDCLhHPIM8gfsns68Cpp8Lfz3Hy2ReiP+uXsQ
         ON6Z+IXRP6vIOoNYUM4OMB5nrEeM1J5+blfH4XVTf3AjbZq7z7So/HTma/BvYQpR7flF
         UAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746463119; x=1747067919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8cGfqMPxInbFVttVOXD20cN2ryppIoxJ2ihtNYujm8=;
        b=qAlng5gYEduaPG0+dWq+O97+4YFTMBry3FBONTPNPYVDk4Sv6qJY8C361sYytqpB7+
         I+R8eovpox6mGhyha5kcLl9nQIEHyUMcon2sNTw6is6XdzB7DqP9QrmjHGqsPIwZFGmD
         zzHm/rsHq17GVfooJcdF0Z+DrnJk/xtIlxXEGoPQWvisQPTWQ5oR6uHRQ8ITbMP1MoZg
         fs/khBiLv0xCpdlsfQFbISzS22cYg6EKv5uk/6xhzNN2SWlEqkx+z3T7guqn8aqRQawN
         2i3kL6/f024Rm/tjKqfbIfAYf/ZCO65JK2QRV18Ga4Toyd+QSNZt2BZESPQSAoDyYnBj
         25pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbNLLDk51WM2rJcJALWZO91D2vJewNebHSW9I999God5wGdLLzHn2oMLW+2YsPY8jW0SN3vOWvGvqwkUOJGG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iIHGNx9lRnSnALb6bpNq4//0X2CDdA69dCXQ6szqbesBIY+n
	+l/ovOOJKVX+lXxpOBX8MF7bBFb++2ZeE+jNKm0w339lFBeitYfuVsbVwkBeR88IuFsv6iIvA5G
	0Hihv/SrJyscfvAoh64DMopOcvBQn1LKT0CDv
X-Gm-Gg: ASbGncuUIO6FEZapKGNQYQ8LHEnhp3BXJD74v0EozXm8jpPAzqNvDs78dlFrya3MU5J
	g4dEAiX69/7xjjUQeBf5xbNCXec3w/RWE3kGC6cVOq+8686kfK3PcLH2PY/GLs6+cD4SJ8GafRo
	a67kDFxP3hxIJaOda58K2j
X-Google-Smtp-Source: AGHT+IFWiSPtprBCFhUiQJ87HBkeklAt1J+ZsCn+rVHWym0jK4XLeniq9xKP5/CRbfUkWSCmfruKW7KYmB/qC+RSHJY=
X-Received: by 2002:a05:622a:15d1:b0:486:a185:3136 with SMTP id
 d75a77b69052e-490cc658b8bmr651011cf.14.1746463118837; Mon, 05 May 2025
 09:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
 <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
 <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com>
 <CAJuCfpG+YjyVE-6TaAQEjwc0iixqN8Epf25jo2awtL=gqY=afA@mail.gmail.com>
 <CAG48ez0ntTH_sOaPiqML715jyTCujwyh3Og1wBq9RNLbu55C5Q@mail.gmail.com> <20250505-wachen-konform-3fe08f1b3214@brauner>
In-Reply-To: <20250505-wachen-konform-3fe08f1b3214@brauner>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 5 May 2025 09:38:27 -0700
X-Gm-Features: ATxdqUExh_T1r-sy8rTeLU-t84R_-ihK_Dse0jJQ6kQZSv2WSV8VGLRmcYSeIkA
Message-ID: <CAJuCfpHYYGa4R11xJwZACNeXDxVroh-gUxHepdc2FfmgP_qBaA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
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

On Mon, May 5, 2025 at 6:50=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Apr 29, 2025 at 08:54:58PM +0200, Jann Horn wrote:
> > On Tue, Apr 29, 2025 at 8:04=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > On Tue, Apr 29, 2025 at 10:21=E2=80=AFAM Jann Horn <jannh@google.com>=
 wrote:
> > > >
> > > > Hi!
> > > >
> > > > (I just noticed that I incorrectly assumed that VMAs use kfree_rcu
> > > > (not SLAB_TYPESAFE_BY_RCU) when I wrote my review of this, somehow =
I
> > > > forgot all about that...)
> > >
> > > Does this fact affect your previous comments? Just want to make sure
> > > I'm not missing something...
> >
> > When I suggested using "WRITE_ONCE(vma->vm_file, NULL)" when tearing
> > down a VMA, and using get_file_rcu() for the lockless lookup, I did
> > not realize that you could actually also race with all the other
> > places that set ->vm_file, like __mmap_new_file_vma() and so on; and I
> > did not think about whether any of those code paths might leave a VMA
> > with a dangling ->vm_file pointer.
> >
> > I guess maybe that means you really do need to do the lookup from the
> > copied data, as you did in your patch; and that might require calling
> > get_file_active() on the copied ->vm_file pointer (instead of
> > get_file_rcu()), even though I think that is not really how
> > get_file_active() is supposed to be used (it's supposed to be used
> > when you know the original file hasn't been freed yet). Really what
>
> I think it's fine for get_file_active() to be used in this way. That
> ->vm_file pointer usage should get a fat comment above it explaining how
> what you're doing is safe.

Got it. Will use it in my next version. Thanks!

>
> > you'd want for that is basically a raw __get_file_rcu(), but that is
> > static and I think Christian wouldn't want to expose more of these
> > internals outside VFS...
>
> Yeah, no. I don't want that to be usable outside of that file.
>
> > (In that case, all the stuff below about get_file_rcu() would be moot.)
> >
> > Or you could pepper WRITE_ONCE() over all the places that write
> > ->vm_file, and ensure that ->vm_file is always NULLed before its
> > reference is dropped... but that seems a bit more ugly to me.
> >
> > > > On Tue, Apr 29, 2025 at 7:09=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > > On Tue, Apr 29, 2025 at 8:40=E2=80=AFAM Jann Horn <jannh@google.c=
om> wrote:
> > > > > > On Fri, Apr 18, 2025 at 7:50=E2=80=AFPM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > > > > > With maple_tree supporting vma tree traversal under RCU and v=
ma and
> > > > > > > its important members being RCU-safe, /proc/pid/maps can be r=
ead under
> > > > > > > RCU and without the need to read-lock mmap_lock. However vma =
content
> > > > > > > can change from under us, therefore we make a copy of the vma=
 and we
> > > > > > > pin pointer fields used when generating the output (currently=
 only
> > > > > > > vm_file and anon_name). Afterwards we check for concurrent ad=
dress
> > > > > > > space modifications, wait for them to end and retry. While we=
 take
> > > > > > > the mmap_lock for reading during such contention, we do that =
momentarily
> > > > > > > only to record new mm_wr_seq counter. This change is designed=
 to reduce
> > > > > > > mmap_lock contention and prevent a process reading /proc/pid/=
maps files
> > > > > > > (often a low priority task, such as monitoring/data collectio=
n services)
> > > > > > > from blocking address space updates.
> > > > > > [...]
> > > > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > > > index b9e4fbbdf6e6..f9d50a61167c 100644
> > > > > > > --- a/fs/proc/task_mmu.c
> > > > > > > +++ b/fs/proc/task_mmu.c
> > > > > > [...]
> > > > > > > +/*
> > > > > > > + * Take VMA snapshot and pin vm_file and anon_name as they a=
re used by
> > > > > > > + * show_map_vma.
> > > > > > > + */
> > > > > > > +static int get_vma_snapshot(struct proc_maps_private *priv, =
struct vm_area_struct *vma)
> > > > > > > +{
> > > > > > > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > > > > > > +       int ret =3D -EAGAIN;
> > > > > > > +
> > > > > > > +       memcpy(copy, vma, sizeof(*vma));
> > > > > > > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > > > > > +               goto out;
> > > > > >
> > > > > > I think this uses get_file_rcu() in a different way than intend=
ed.
> > > > > >
> > > > > > As I understand it, get_file_rcu() is supposed to be called on =
a
> > > > > > pointer which always points to a file with a non-zero refcount =
(except
> > > > > > when it is NULL). That's why it takes a file** instead of a fil=
e* - if
> > > > > > it observes a zero refcount, it assumes that the pointer must h=
ave
> > > > > > been updated in the meantime, and retries. Calling get_file_rcu=
() on a
> > > > > > pointer that points to a file with zero refcount, which I think=
 can
> > > > > > happen with this patch, will cause an endless loop.
> > > > > > (Just as background: For other usecases, get_file_rcu() is supp=
osed to
> > > > > > still behave nicely and not spuriously return NULL when the fil=
e* is
> > > > > > concurrently updated to point to another file*; that's what tha=
t loop
> > > > > > is for.)
> > > > >
> > > > > Ah, I see. I wasn't aware of this subtlety. I think this is fixab=
le by
> > > > > checking the return value of get_file_rcu() and retrying speculat=
ion
> > > > > if it changed.
> > > >
> > > > I think you could probably still end up looping endlessly in get_fi=
le_rcu().
> >
> > (Just to be clear: What I meant here is that get_file_rcu() loops
> > *internally*; get_file_rcu() is not guaranteed to ever return if the
> > pointed-to file has a zero refcount.)
> >
> > > By "retrying speculation" I meant it in the sense of
> > > get_vma_snapshot() retry when it takes the mmap_read_lock and then
> > > does mmap_lock_speculate_try_begin to restart speculation. I'm also
> > > thinking about Liam's concern of guaranteeing forward progress for th=
e
> > > reader. Thinking maybe I should not drop mmap_read_lock immediately o=
n
> > > contention but generate some output (one vma or one page worth of
> > > vmas) before dropping mmap_read_lock and proceeding with speculation.
> >
> > Hm, yeah, I guess you need that for forward progress...
> >
> > > > > > (If my understanding is correct, maybe we should document that =
more
> > > > > > explicitly...)
> > > > >
> > > > > Good point. I'll add comments for get_file_rcu() as a separate pa=
tch.
> > > > >
> > > > > >
> > > > > > Also, I think you are introducing an implicit assumption that
> > > > > > remove_vma() does not NULL out the ->vm_file pointer (because t=
hat
> > > > > > could cause tearing and could theoretically lead to a torn poin=
ter
> > > > > > being accessed here).
> > > > > >
> > > > > > One alternative might be to change the paths that drop referenc=
es to
> > > > > > vma->vm_file (search for vma_close to find them) such that they=
 first
> > > > > > NULL out ->vm_file with a WRITE_ONCE() and do the fput() after =
that,
> > > > > > maybe with a new helper like this:
> > > > > >
> > > > > > static void vma_fput(struct vm_area_struct *vma)
> > > > > > {
> > > > > >   struct file *file =3D vma->vm_file;
> > > > > >
> > > > > >   if (file) {
> > > > > >     WRITE_ONCE(vma->vm_file, NULL);
> > > > > >     fput(file);
> > > > > >   }
> > > > > > }
> > > > > >
> > > > > > Then on the lockless lookup path you could use get_file_rcu() o=
n the
> > > > > > ->vm_file pointer _of the original VMA_, and store the returned=
 file*
> > > > > > into copy->vm_file.
> > > > >
> > > > > Ack. Except for storing the return value of get_file_rcu(). I thi=
nk
> > > > > once we detect that  get_file_rcu() returns a different file we s=
hould
> > > > > bail out and retry. The change in file is an indication that the =
vma
> > > > > got changed from under us, so whatever we have is stale.
> > > >
> > > > What does "different file" mean here - what file* would you compare
> > > > the returned one against?
> > >
> > > Inside get_vma_snapshot() I would pass the original vma->vm_file to
> > > get_file_rcu() and check if it returns the same value. If the value
> > > got changed we jump to  /* Address space got modified, vma might be
> > > stale. Re-lock and retry. */ section. That should work, right?
> >
> > Where do you get an "original vma->vm_file" from?
> >
> > To be clear, get_file_rcu(p) returns one of the values that *p had
> > while get_file_rcu(p) is running.

