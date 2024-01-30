Return-Path: <linux-kselftest+bounces-3753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6055E842C22
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850081C23F16
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D42879926;
	Tue, 30 Jan 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEucG/Bl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655F79929
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640876; cv=none; b=dm2CGVxHTiVTNS5Yq9HOp9s/tA0S1rq4Ii3VkZSzP+Jv2QTlpWiFqmXsiN3rEi6yE4ADE6iE3Djm38ZzXzWxlFaiSl1LQqVT57yKlO+o+r4KUaVszLAQ7uSqj7MnG4j/D4nqrlpsR5ELuVl5UqOrbOwLhrsa5AR8NLb+dDsUFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640876; c=relaxed/simple;
	bh=KaYqtwvhZkPpAlQK4G8JayCcItXB2wokKct2Y23TGIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=psgwTawZjUtz2BoJoEqa75NHjg7Sb4mKaYNZ+T55VStJtp/3kDHXnXVHhoDeoyZWGdie5jbC2VC/pRAEBfQtAK+IrBDNVhYXruYqSgpMGXn7YyghYwD7uZrCL33w0QTLQh10/7ZknmBUS4MW33L98X967v4zA/wNzOv6VN9wX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEucG/Bl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eed12so323972276.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706640873; x=1707245673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hlck0SDOI53RH9ro1d/oaoEWA7eb7Oo/rrMeo05lWA=;
        b=pEucG/Bl6H/Xyn2Ts31jZRtLam8Gj0DZUmsO3NJjMRR/ibABUu8Ns7HYeh89rhyCqj
         CgyLDul2P0L/V9FtUGrl3H3a5fgbZBXczZbaNcFkbKWYS3tVZwm531Ho4O1E3Swk/C49
         DZUrpUzWijwSZVnAsrEIgkyEeOumVVVJfxQ42/2wFxon9I7gnIaglOy2+Jjcrtukh1U+
         dEmTNz3t0QY6wbRbRge1A5+ZjunGuuLErwUoM2wfqC/S0B41AFKJFWWfisg4WN0/1De8
         EyfeJeHnhCraecEeNbFZXP6jCvSyn6JFKq9p9huibgJNQCvYGjedwgHIyTXS1bzC70K6
         zkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706640873; x=1707245673;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1hlck0SDOI53RH9ro1d/oaoEWA7eb7Oo/rrMeo05lWA=;
        b=YoEqkgWP9mZpkLSkZr9gZV6t79+EC8YE8z1ID/78Od9+MzggkGSFZnLYUbaCa6cthS
         XZbGQWKDgYeUduDyMW8soK/14ASSUpVpR30IzOcfLqmbxdG/9BFhF0BI9KplaJk8TQko
         rS+ifU4he50KoHY56j10ec8wUCJWm1FdPPlCc78jE/mJQ6nwpXqNhH36XIJ+5snj/+j+
         +ryeLCgZm+dLnM3IoPsBNkAyMEgwiSTDRCzVAxdh3DIfTYr6EkX+G/0xvqBL0vpPuJWq
         r/eobL4FrKABzzZywhkGIyfrUchPvCZKe7+fUQMwUbaTZTFq6L59nTtj8A/IJweO5Z6U
         Mb0g==
X-Gm-Message-State: AOJu0Yyhw1SqCjpTxSqpR6rJvp0mhfpohahFoOhpzNVGp9OdrEmI3Vs1
	752CRU8OR+GXOQVaRAUHgTJq87OKii06wVWXpXvb743C5i56OqGOULx8k3Wsbe8SbZjhDDI41MT
	8njGr132K684ktgqDBg==
X-Google-Smtp-Source: AGHT+IGkAvVn8Mmr3dy++eKOOGQiEGQjnS5RHrgdsd6QmPtWfbsuMCKcf4YEWnY1RKKIg+sA0Vjc2FJQc9D75VEc
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2191:b0:dc2:6605:f6ba with
 SMTP id dl17-20020a056902219100b00dc26605f6bamr606ybb.2.1706640873582; Tue,
 30 Jan 2024 10:54:33 -0800 (PST)
Date: Tue, 30 Jan 2024 18:54:31 +0000
In-Reply-To: <CAKEwX=Pj+ncE=wZTOBVzT8E-=YVbqr-1CtsMNuZWLAhuaf7wAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129224542.162599-1-nphamcs@gmail.com> <20240129224542.162599-4-nphamcs@gmail.com>
 <ZbhP0JkEe39g3yqk@google.com> <CAKEwX=Pj+ncE=wZTOBVzT8E-=YVbqr-1CtsMNuZWLAhuaf7wAg@mail.gmail.com>
Message-ID: <ZblF54ZpiUzzsbbf@google.com>
Subject: Re: [PATCH 3/3] selftests: add test for zswapin
From: Yosry Ahmed <yosryahmed@google.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, hannes@cmpxchg.org, 
	tj@kernel.org, lizefan.x@bytedance.com, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:31:24AM -0800, Nhat Pham wrote:
> On Mon, Jan 29, 2024 at 5:24=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
[..]
> > > -static int allocate_bytes(const char *cgroup, void *arg)
> > > +static int allocate_bytes_and_read(const char *cgroup, void *arg, bo=
ol read)
> > >  {
> > >       size_t size =3D (size_t)arg;
> > >       char *mem =3D (char *)malloc(size);
> > > +     int ret =3D 0;
> > >
> > >       if (!mem)
> > >               return -1;
> > >       for (int i =3D 0; i < size; i +=3D 4095)
> > >               mem[i] =3D 'a';
> > > +
> > > +     if (read) {
> > > +             /* cycle through the allocated memory to (z)swap in and=
 out pages */
> > > +             for (int t =3D 0; t < 5; t++) {
> >
> > What benefit does the iteration serve here? I would guess one iteration
> > is enough to swap everything in at least once, no?
>=20
> There might be data races etc. that might not appear in one iteration.
> Running multiple iterations increases the probability of these bugs
> cropping up.

Hmm this is a test running in a single process, and I assume the rest of
the system would be idle (at least from a zswap perspective). Did the
iterations actually catch problems in this scenario (not specifically in
this test, but generally in similar testing)?

>=20
> Admittedly, the same effect could, perhaps, also be achieved by
> running the same test multiple times, so this is not a hill I will die
> on :) This is just a bit more convenient - CI infra often runs these
> tests once every time a new kernel is built.
>=20
[..]
> > > +
> > > +static int test_swapin(const char *root)
> > > +{
> > > +     return test_zswapin_size(root, "0");
> > > +}
> >
> > Why are we testing the no zswap case? I am all for testing but it seems
> > out of scope here. It would have been understandable if we are testing
> > memory.zswap.max itself, but we are not doing that.
>=20
> Eh it's just by convenience. We already have the workload - any test
> for zswap can pretty much be turned into a test for swap by disabling
> zswap (and enabling swap), so I was trying to kill two birds with one
> stone and cover a bit more of the codebase.

We can check that no data is actually in zswap after
test_zswapin_size(root, "0"), in which case it becomes more of a zswap
test and we get a sanity check for memory.zswap.max =3D=3D 0. WDYT?

Perhaps we can rename it to test_swpain_nozswap() or so.

>=20
> >
> > FWIW, I think the tests here should really be separated from cgroup
> > tests, but I understand why they were added here. There is a lot of
> > testing for memcg interface and control for zswap, and a lot of nice
> > helpers present.
>=20
> Yeah FWIW, I agree :) I wonder if there's an easy way to inherit
> helpers from one test suite to another. Some sort of kselftest
> dependency? Or maybe move these cgroup helpers up the hierarchy (so
> that it can be shared by multiple selftest suites).

I am not fluent in kselftest so I can't claim to know the answer here.
There are a lot of things to do testing-wise for zswap, but I am not
asking anyone to do it because I don't have the time to do it myself. It
would be nice though :)

