Return-Path: <linux-kselftest+bounces-25404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CBA226C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 00:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048DF1887614
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 23:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845D1B425D;
	Wed, 29 Jan 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjZNQ/x6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF442A92
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192689; cv=none; b=u8JPDovnqs3ku3eMq7rfSGrSFudZuO7Q6u/Upvc5emKS+9BZfFhYSFrLVZxvevL6KF2iMI8sqlYoeZ06ZwHnxXoVrhu+/E/2ovvIO8U0gzNZ5+q4y/s0Uqd88irWnfqHoVTipxlZcu2N6vfNBV++yV2OwNXPlYH/avzS5cBvN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192689; c=relaxed/simple;
	bh=+B49m9IUkhXD30orNv+/xeTmiSHWH28m+HjpA9vJuRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2CtDJXe/cQNODJtgxnn5dvIo530Z7F/b17CKpCc/uRDhZtfYja1Ce/O7/EyEDAJ3jP+5DNFDXtB/xxnGdfrR9dPV7whNQA5+Aw3+9lSAaQ9I2dkfrFot+qymM3BwYH6taVoKp7yfbhl/yJCzUswPvBIExvSNAXkZisQMqCqLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjZNQ/x6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738192686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbqU+4TJfsH6reEBEqy0eMHPD7dU0gZz4x/iJbG3ats=;
	b=AjZNQ/x61yibOHEJzsyT0CFpfcCevue90SJ0q4pSeTnmuuc8TwzQQUNfKmGtQisCIsbyba
	C0z6OjRM4C2awEED62uqmzAJQo/C+rKmPOYdxff8bgVYb+pwBsAVQsvVwwq0uoB6ZAGuil
	Q7fbwf3DWxxdFC8SQthr6pwu3cj1Xdk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-fQXBh64vNty7kRK_N9uzQw-1; Wed, 29 Jan 2025 18:18:05 -0500
X-MC-Unique: fQXBh64vNty7kRK_N9uzQw-1
X-Mimecast-MFC-AGG-ID: fQXBh64vNty7kRK_N9uzQw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2163d9a730aso2558215ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 15:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738192684; x=1738797484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbqU+4TJfsH6reEBEqy0eMHPD7dU0gZz4x/iJbG3ats=;
        b=qN3mTD+irDAQnMvpTuO9qncThofiTX/Jb3EYGASJy02nPGlJ2OfjhxcqsJ1NNyhXy9
         Fp8la9RepnUuwwhZJ/oc2LZclsr6xzcqpxyHMJAc3gB8C06lkp/1RNmBtJlejueEEZAS
         haSHmhRShzTcbwI38XewZ6/H1MU8rn8FkFv0UDL2HR0bnbyafEvOUYQZ4DcjIW6BzKPi
         ttMEtWBLEedH7L7/m9cZH5hmfU2q4n/Lj05vxmMnQCA/17/IF3UhMIMONolk0DUW38SE
         EaYcKvjqlMOEX+yQVXXj/9LwZt9VUNCDrfwWhulDBDzhK7NlF0Cjv/FKdAMsY6gjNIc4
         B7+A==
X-Forwarded-Encrypted: i=1; AJvYcCXIz/CuODS4Pq3IIMQJo5GqsyZOTMnHm6UDmIsJ1WVfbp3cS0IV1lSQLRl6SwiJk8JulP4YTn5IHYZAKWOf7VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+2BrUrLpDdI4ZtQOjkLiE9V2QM2ZTCmzWywVMy1mJP/b1s+J
	31MLhcyRzuIDYz+GKuyL69uqH9/YZnFK4brOINymFwXWH7TAxgrSECIja6+K146znIMhYBvqB0n
	01GQE0V6DnxDT6BPFkJekALr/Q1hwNEJgRHtnD55mv72YuTMkHbArUP9s00HO8VgTEcpEbnUVZX
	hBCw1DKqVl3SQa9OjBLh+nV78JhdAgwlmcyoZVHeuG
X-Gm-Gg: ASbGncsO3QEPdgcuZ9EM6kLs1FEwoOT/5SRXmk9St320s4n1X89C8u5Y8nPvkNB1mzs
	VLlmMXdjw7kSowSY3R4KNlufpyv04o8U/VrpgVZVsASiaCK1zSlS26VdQ79GR
X-Received: by 2002:a17:902:cecc:b0:215:3998:189f with SMTP id d9443c01a7336-21de19566bemr16077585ad.6.1738192683827;
        Wed, 29 Jan 2025 15:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkJmxG4jPiCULJCmtPlFjZUm44urca4ftNYg6S4q7Zh27QEwohoN1rSLUbKUdoz5/gIVyDg0mQsLTuvG4Kzqg=
X-Received: by 2002:a17:902:cecc:b0:215:3998:189f with SMTP id
 d9443c01a7336-21de19566bemr16077335ad.6.1738192683440; Wed, 29 Jan 2025
 15:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128163859.1883260-1-agruenba@redhat.com> <20250128163859.1883260-12-agruenba@redhat.com>
 <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
 <CAHc6FU6Yzk1Si37nRji-5uDZF9uaYo=G5tbtuS_5FiW6BDVTAg@mail.gmail.com>
 <rddasfmbw3ul2iezec7rgit2vxnv4p53uvoydck4b5jxuo44kq@7qlk5cru6w7r>
 <CAHc6FU7oZxP1cy6uihH=m9i=0z8PmCtozwQs2HgnqvbTDhAd_g@mail.gmail.com> <nxabgljkslxwr27wrzgjxao2nr3jh5leytj7f3pjir3t27uf5w@zcdmd4phur2m>
In-Reply-To: <nxabgljkslxwr27wrzgjxao2nr3jh5leytj7f3pjir3t27uf5w@zcdmd4phur2m>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 30 Jan 2025 00:17:51 +0100
X-Gm-Features: AWEUYZnuEtXexgZDdfLWcZJGiewhsvfqT4ZybhlOzAvks9ehbvkhLjS3Pvmq8jg
Message-ID: <CAHc6FU7x8MbRLA9ELYiDM+Srz2FNzOzr28yztBA=CrPsj8X43A@mail.gmail.com>
Subject: Re: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 10:30=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Wed, Jan 29, 2025 at 10:21:31PM +0100, Andreas Gruenbacher wrote:
> > On Wed, Jan 29, 2025 at 9:28=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > On Wed, Jan 29, 2025 at 07:21:49PM +0100, Andreas Gruenbacher wrote:
> > > > On Wed, Jan 29, 2025 at 7:04=E2=80=AFPM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > > On Tue, Jan 28, 2025 at 05:38:48PM +0100, Andreas Gruenbacher wro=
te:
> > > > > > Rename eytzinger0_find_test_val() to eytzinger0_find_test_le() =
and add a
> > > > > > new eytzinger0_find_test_val() wrapper that calls it.
> > > > > >
> > > > > > We have already established that the array is sorted in eytzing=
er order,
> > > > > > so we can use the eytzinger iterator functions and check the bo=
undary
> > > > > > conditions to verify the result of eytzinger0_find_le().
> > > > > >
> > > > > > Only scan the entire array if we get an incorrect result.  When=
 we need
> > > > > > to scan, use eytzinger0_for_each_prev() so that we'll stop at t=
he
> > > > > > highest matching element in the array in case there are duplica=
tes;
> > > > > > going through the array linearly wouldn't give us that.
> > > > >
> > > > > For test code, wouldn't it be simpler to iterate over the test ar=
ray,
> > > > > testing with every element as a search value? There's enough corn=
er
> > > > > cases in lookup that I think it'd be worthwhile (and probably add=
 some
> > > > > extra test values, e.g. first/last elements +1/-1).
> > > >
> > > > If you expect to get the same index back, that won't work when ther=
e
> > > > are duplicates.
> > >
> > > No, but we wouldn't expect to get the same index back if we're testin=
g
> > > every combination of elements (+0, -1, +1) x (le, ge, gt) - and it
> > > sounds like perhaps we should, if you've been finding bugs. Thoughts?
> >
> > I don't really know what you're after here. Function
> > eytzinger0_find_test() already tests every combination of elements
> > (+0, -1, +1) x (le, ge, gt).
>
> Ok - it can be hard to tell looking at isolated patches vs. being able
> to fetch a git repo. Do you have it in a branch I can fetch from?
>
> > The full scans of the array in eytzinger0_find_test_{le,gt,ge}() are
> > not there to verify correctness; they're only there to produce
> > slightly nicer debug output. I'm perfectly happy with removing that if
> > you prefer.
>
> No, not at all
>
> > > I think the test code would have to do short linear searches from the
> > > test element, and then verify the search functions against that.
> >
> > What for? We already know from the eytzinger0_for_each loop in
> > eytzinger0_find_test() that the array is in eytzinger sort order, and
> > we also know from eytzinger{0,1}_test() that the _prev() and _next()
> > functions are doing "the right thing". So the one thing left to verify
> > in eytzinger0_find_test_{le,gt,ge}() is that all the search functions
> > always return the boundary element. That's done by going to the next
> > element in search order and by verifying that it no longer fulfils the
> > search criterion.
> >
> > > Have you spotted any issues with searching over arrays with duplicate
> > > elements?
> >
> > Only that eytzinger0_find_ge() didn't always find the first matching
> > element in the array; see patches 17 and 18.
>
> Gotcha
>
> Ok, it sounds like everything I'm after is there - give me a git branch
> so I can read through it that way and I'll be happy to merge when you
> say it's ready

Sure, I've pushed the patches here:

  https://git.kernel.org/pub/scm/linux/kernel/git/agruen/linux.git/log/?h=
=3Dbcachefs

Note that you don't want to merge the following patch:

  bcachefs: Run the eytzinger tests on modprobe

And this minor one should probably be changed to use __maybe_unused or
dropped; not sure which of the two options you prefer:

  bcachefs: remove dead code in is_aligned

I've only run the self tests. They seem to provide good coverage and I
don't expect any trouble, but some real filesystem testing would be
great.

Thanks,
Andreas


