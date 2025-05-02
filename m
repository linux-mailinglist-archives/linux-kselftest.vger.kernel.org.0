Return-Path: <linux-kselftest+bounces-32203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF43AA75BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099501BA501F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745EC257455;
	Fri,  2 May 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ajkja3WU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758962571C7
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198705; cv=none; b=NXSjcMZ/R+jkTnPi/hr3W0e3gv+dgSqbdkp8GmpjUhxhaXQmQbMXvMXRPCET5xUWqaPWS+6+QOskywT++huAJRPaW7+DZOomlS82fUWI8P+o+9i0O2SVfd9t0SyoTAFSncIUkR6xSU1KiQbd+wg1RArv0sA2MHMfL9k5xGmAZFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198705; c=relaxed/simple;
	bh=FKlZk6KjghNkNzFfe2VS93WmUZ24CsLkd431OYU93qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0OqetAUODuM3LLSfzhLdITbY1xXyLgttB5nYEKUsefO9Jtcv9Yv5QQ5YbhHf+C7Hf+9VXN8G6Nw/DnqVe4TSEQCz8SHycBdEnIlb9Wv8Pma28jpSaV7YXy58rpmSo9YE3dWy7kiAchYt6vR1E2547mevNFNbrsSCYZpmTewsno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ajkja3WU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso9187a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746198700; x=1746803500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKlZk6KjghNkNzFfe2VS93WmUZ24CsLkd431OYU93qY=;
        b=Ajkja3WUo0rxHuf2/tgJlAngX37r2hJMRaaecRC4TysL+C3Y2sFzkbexKIsAkBFG/W
         JGz3EOJzl22JWyAVISNZq/OL7nVL5ayV/HToFFUIlyJboKCz4vOKuBPqwN8OlVme634p
         WTxJPF/xEuURWyGHk459ZMLbV7cL3W/OE9/mFw4u1uOcbo7q+WsGGMcHYU0PEzvmJl8h
         8AuAtW7n+mxztXw5RefMYDzAhWsLiWUZCU9Gn5miHzpsW+bNfmn/azmi+eKQ3/IF/uwS
         QVmi4P2FcaoCI0efpDbf0f1S2y9ymkBwq4iocbOhVuoWT52yJ4Rab7JLk2podlWfTlkI
         rDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198700; x=1746803500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKlZk6KjghNkNzFfe2VS93WmUZ24CsLkd431OYU93qY=;
        b=aR9mxEzMGmMDAmujB7mIrfhTGc7ACIvpbIku49fXbAbxvITtNROFQyncZnrri3KgXw
         JsXkCeY0GgJppYbwn+yAnxC69XfQXDFF79nz343wTPNeQTOGUtOqkurOhpmQcCMYljjS
         kG4ocr/p4SlzXAAcfgKbm/mid3oNBJBWJsmeh42VXSBfNLRBCodb3b2yODll8pAUw3j6
         RrnNqtKvgfGavmnWw2a180ybzqJ87AagXypCcSVc/O2tnPqp/yM57gOreIj9LiMimH1u
         jzNFBqtRR5fHdh1U8g6tbj7/lTWSG7HBmabU87YTrq02BQpW1MQfKYXRAKhmVPuirAAF
         1gkA==
X-Forwarded-Encrypted: i=1; AJvYcCUxnBnq7R7EibkY/uCI4/s5iwF07PnyRvMJMUpbdInsA+neaH87TF6KhScc5gZ4B/aGoiyUabJA2U+dCM+awNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgXF6qRCkPB307/9yB+r+mekQeTfyc1X2gqSQyMn4anXzxDOP
	TMP+bU8HNH9hqfdT3Jv8NaSjpMVgBO//7vy9L2gwk6T/ReaD4k9XL7YsXjd8izskW8WGczNZjdq
	MwR22Yj+4HcgkFV74i3g9U1EuIBZzCbrYRA75
X-Gm-Gg: ASbGnctgd5wI2aPVJpMev+TRx3mSCrOjBI6DJKyR6Fx61ZEpklL6P4LeHKNfbAB5hyn
	rIyB987bdSZ9pI8EFcwATynmkQ8KzJVMAMEz4/ZSPRbnkrS7VM1DNYOONmFyQ8iAZi/bNvRQxxH
	b4A6suNgBXPFL3KgUL3MiPWWKecOYJlEJmA2n3I/UXxOS5v+FsbA==
X-Google-Smtp-Source: AGHT+IERkzDNyTmOeaZwge9izZvT+3a5JL1Pt5BG92diaSrHdsXlC4LhpWG/7aF50+We9CxCzaJagP6DJzyfICQLxvQ=
X-Received: by 2002:a50:d556:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5f918c2a177mr184575a12.7.1746198699387; Fri, 02 May 2025
 08:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-9-surenb@google.com>
 <CAEf4BzabPLJTy1U=aBrGZqKpskNYvj5MYuhPHSh_=hjmVJMvrg@mail.gmail.com>
 <CAG48ez29frEbJG+ySVARX-bO_QWe8eUbZiV8Jq2sqYemfuqP_g@mail.gmail.com>
 <CAJuCfpGxw7L67CvDnTiHN0kdVjFcPoZZ4ZsOHi0=wR7Y2umk0Q@mail.gmail.com>
 <CAG48ez1cR+kXBsvk4murYDBBxSzg9g5FSU--P8-BCrMKV6A+KA@mail.gmail.com> <CAEf4BzarQAmj477Lyp2aS0i2RM4JaxnAVvem6Kz-Eh1a5x-=6A@mail.gmail.com>
In-Reply-To: <CAEf4BzarQAmj477Lyp2aS0i2RM4JaxnAVvem6Kz-Eh1a5x-=6A@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 17:11:03 +0200
X-Gm-Features: ATxdqUFG2iaTkmFhKeQVVpe2LikO_MhFJjHWYrIsMyz9yg82E2DdMFylx1L3_Nc
Message-ID: <CAG48ez2tQsqS3+ZfSus+Wi5ur6HbYuaAhhmOOrkDyrZG+gsvXg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/maps: execute PROCMAP_QUERY ioctl under RCU
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 12:10=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Apr 29, 2025 at 10:25=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > On Tue, Apr 29, 2025 at 7:15=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > On Tue, Apr 29, 2025 at 8:56=E2=80=AFAM Jann Horn <jannh@google.com> =
wrote:
> > > > On Wed, Apr 23, 2025 at 12:54=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <sure=
nb@google.com> wrote:
> > > > > > Utilize speculative vma lookup to find and snapshot a vma witho=
ut
> > > > > > taking mmap_lock during PROCMAP_QUERY ioctl execution. Concurre=
nt
> > > > > > address space modifications are detected and the lookup is retr=
ied.
> > > > > > While we take the mmap_lock for reading during such contention,=
 we
> > > > > > do that momentarily only to record new mm_wr_seq counter.
> > > > >
> > > > > PROCMAP_QUERY is an even more obvious candidate for fully lockles=
s
> > > > > speculation, IMO (because it's more obvious that vma's use is
> > > > > localized to do_procmap_query(), instead of being spread across
> > > > > m_start/m_next and m_show as with seq_file approach). We do
> > > > > rcu_read_lock(), mmap_lock_speculate_try_begin(), query for VMA (=
no
> > > > > mmap_read_lock), use that VMA to produce (speculative) output, an=
d
> > > > > then validate that VMA or mm_struct didn't change with
> > > > > mmap_lock_speculate_retry(). If it did - retry, if not - we are d=
one.
> > > > > No need for vma_copy and any gets/puts, no?
> > > >
> > > > I really strongly dislike this "fully lockless" approach because it
> > > > means we get data races all over the place, and it gets hard to rea=
son
> > > > about what happens especially if we do anything other than reading
> > > > plain data from the VMA. When reading the implementation of
> > > > do_procmap_query(), at basically every memory read you'd have to th=
ink
> > > > twice as hard to figure out which fields can be concurrently update=
d
> > > > elsewhere and whether the subsequent sequence count recheck can
> > > > recover from the resulting badness.
> > > >
> > > > Just as one example, I think get_vma_name() could (depending on
> > > > compiler optimizations) crash with a NULL deref if the VMA's ->vm_o=
ps
> > > > pointer is concurrently changed to &vma_dummy_vm_ops by vma_close()
> > > > between "if (vma->vm_ops && vma->vm_ops->name)" and
> > > > "vma->vm_ops->name(vma)". And I think this illustrates how the "ful=
ly
> > > > lockless" approach creates more implicit assumptions about the
> > > > behavior of core MM code, which could be broken by future changes t=
o
> > > > MM code.
> > >
> > > Yeah, I'll need to re-evaluate such an approach after your review. I
> > > like having get_stable_vma() to obtain a completely stable version of
> > > the vma in a localized place and then stop worrying about possible
> > > races. If implemented correctly, would that be enough to address your
> > > concern, Jann?
> >
> > Yes, I think a stable local snapshot of the VMA (where tricky data
> > races are limited to the VMA snapshotting code) is a good tradeoff.
>
> I'm not sure I agree with VMA snapshot being better either, tbh. It is
> error-prone to have a byte-by-byte local copy of VMA (which isn't
> really that VMA anymore), and passing it into ops callbacks (which
> expect "real" VMA)... Who guarantees that this won't backfire,
> depending on vm_ops implementations? And constantly copying 176+ bytes
> just to access a few fields out of it is a bit unfortunate...

Yeah, we shouldn't be passing VMA snapshots into ops callbacks, I
agree that we need to fall back to using proper locking for that.

> Also taking mmap_read_lock() sort of defeats the point of "RCU-only
> access". It's still locking/unlocking and bouncing cache lines between
> writer and reader frequently. How slow is per-VMA formatting?

I think this mainly does two things?

1. It shifts the latency burden of concurrent access toward the reader
a bit, essentially allowing writers to preempt this type of reader to
some extent.
2. It avoids bouncing cache lines between this type of reader and
other *readers*.

> If we
> take mmap_read_lock, format VMA information into a buffer under this
> lock, and drop the mmap_read_lock, would it really be that much slower
> compared to what Suren is doing in this patch set? And if no, that
> would be so much simpler compared to this semi-locked/semi-RCU way
> that is added in this patch set, no?

> But I do agree that vma->vm_ops->name access is hard to do in a
> completely lockless way reliably. But also how frequently VMAs have
> custom names/anon_vma_name?

I think there are typically two VMAs with vm_ops->name per MM, vvar
and vdso. (Since you also asked about anon_vma_name: I think
anon_vma_name is more frequent than that on Android, there seem to be
58 of those VMAs even in a simple "cat" process.)

> What if we detect that VMA has some
> "fancy" functionality (like this custom name thing), and just fallback
> to mmap_read_lock-protected logic, which needs to be supported as a
> fallback even for lockless approach?
>
> This way we can process most (typical) VMAs completely locklessly,
> while not adding any extra assumptions for all the potentially
> complicated data pieces. WDYT?

And then we'd also use the fallback path if karg.build_id_size is set?
And I guess we also need it if the VMA is hugetlb, because of
vma_kernel_pagesize()? And use READ_ONCE() in places like
vma_is_initial_heap()/vma_is_initial_stack()/arch_vma_name() for
accessing both the VMA and the MM?

And on top of that, we'd have to open-code/change anything that
currently uses the ->vm_ops (such as vma_kernel_pagesize()), because
between us checking the type of the VMA and later accessing ->vm_ops,
the VMA object could have been reallocated with different ->vm_ops?

I still don't like the idea of pushing the complexity of "the VMA
contents are unstable, and every read from the VMA object may return
data about a logically different VMA" down into these various helpers.
In my mind, making the API contract "The VMA contents can be an
internally consistent snapshot" to the API contract for these helpers
constrains the weirdness a bit more - though I guess the helpers will
still need READ_ONCE() for accessing properties of the MM either
way...

