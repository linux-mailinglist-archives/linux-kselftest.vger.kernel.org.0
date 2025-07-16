Return-Path: <linux-kselftest+bounces-37444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81376B07B6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 18:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22E77A44C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C282F5493;
	Wed, 16 Jul 2025 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHQ6Y515"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD882F5484
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684285; cv=none; b=AF6Twtn3sIsg9N4BDuAhN++iCTjvpiXRgzGSTt9fBzx2oqBJjxxqBK28oFspIfSaBkMMo/gvzE/E8AJkrq6bgZr4YA4GhHH7TQ0/ZvWCKrn2RI4bntSBZWf5opBJoJZ+W1AevosUgfl31Mn7oPUO67iAgnKtgu32yfYfI7I3+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684285; c=relaxed/simple;
	bh=om9te+97F76PGNBhbFcuJXmcwMoZvSGcYcM1x3bmX70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kr2p3ELJW2uwsEeq7WUXYJjJ3swFnPjMJ+3qoDwyVx/l6QClU1WQ+UHTH5tAx9yR2IqBPyBY/XRdxOlZOjSeimQtZ/r8VEzpAKMSNkiuLyQnV4jcHYqMkHsPbjZG//I0j+qtcTUpfeAm5+Xsu59ptJaE2LFlK/gKQwzVYxN2hvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHQ6Y515; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab86a29c98so9341cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752684279; x=1753289079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr8a/nJOVFR57sghJCiLBSkmwBnZhxckE8XZH1omS8M=;
        b=fHQ6Y5157xD0wxpr686hYE8yTu0t+esN/CUvuJ6OVtzvxUQEcWmBZPw7Yc5Vyel9j4
         hmLioYJf93F5P52/1Ccqj6CxT2uuOPA0fFV+783WEvxPCsw+kqEffPxZifpxzDPocdye
         uHckitaeOUT2+Lb4N1L8enqVi4Y4JqnXIhhlxrUjO0X11XBRXDdAWelrQipvBsdxAbKk
         yp5ikSMcraf0uqwz9goQ5gROJ5LF+TbeCsZJwfONk33tqItMXxTADS6dlUGFZGG9S1ZB
         P+1OH6D9eUNIbraRh75eoTHpGeFPy7M+jjV316stjkqakX65S1SsW/u0ty9KDwuH8lpE
         M3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752684279; x=1753289079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr8a/nJOVFR57sghJCiLBSkmwBnZhxckE8XZH1omS8M=;
        b=d+kKCqganMlqO2C77C6K7JIhgnhMIEGPRvqbglpm9GiDqOezSq/WNEO36Dxu12LWtE
         c4Hnhf/XIsFpgqT4VRrXiOpLxJy3A65+Sn1r7ASG9Abx7v/1TiNwcFcMAHp7Zz1c1htx
         5G2AZ+EcGZ+UkoE/krfHfaNdWDL5bf9gbFslvDY5uGx5JQXMZl0GraN/V3JYO2naljAh
         moBtoMUlLVWd2OrQntdjia5zZ90NhoFty3Avhf5Yfx9wBAZbtqWO1mqgqqDOiqjP6d3+
         HfKi3bkhoswZ1zlfweGbD+hI93Q4eXZal2qpjWi2hPwuGeBC1LmuOKLri2LiXmURP1xG
         hUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdM0zWWg2TeqLGLIdJ5ErNhhKAU4qKlUBdxFAOILe3Gilkpz5IGN/5/AJSYwMifTqJtDECb2sWJUJx0nZ4qBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6DjF7vd8OgX4a0kyR6Xg5CIy8wldqF8/l9GViLxGoR0XVFli
	Jk7or7FQ21s3xgcSyDxS8Wtx/dJEMtq9FJq8q/u+AcAao9YLTb2n60VfXzZtGZc5SzCkYfcwh7d
	Ufy2KqedT5Khskkkc3Ob1/uyuyFr6OdtrEduMBfH8
X-Gm-Gg: ASbGnctnuOcShmp0XDpdt5Bj+wjE0A3pKJg20rbL0c1Dy978qkG+qaOj2RDd9jh4uAl
	UvrVrXxgbvxClhd0Im3yxCIKFUUyWFgVU6p5kQdo5Tk5aF8iy72RWhx2Mqj6qevj5eM4iIN6n47
	jAg3gsKlfM3pmWBUy1wVdXW+gWeGhrh09VEq2kirohWIVPYRQFhHnqtEeZtYdCluwMGtmftvdsO
	CBwtwPp5E+XcQJmSMRMrAK94lX7FkBcxxY=
X-Google-Smtp-Source: AGHT+IG+ehUHUArWfJVHAp+OzP5yI34RIUIkLr/x2rq0UCqLebrEaMpW3c9cNGLeH/AY19CGqIu0yi2B1KpZNp4PSHU=
X-Received: by 2002:a05:622a:a38d:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4ab953aab8amr3489301cf.6.1752684278667; Wed, 16 Jul 2025
 09:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-2-surenb@google.com>
 <f041e611-9d28-4a30-8515-97080f742360@redhat.com> <ac9c5912-e19e-4653-9b6c-e68ca3a058f7@lucifer.local>
 <CAJuCfpE+Nj9rQL=_pOtnAXSDnd9xEZt=r-j7guJnkXSy8wFNrw@mail.gmail.com>
In-Reply-To: <CAJuCfpE+Nj9rQL=_pOtnAXSDnd9xEZt=r-j7guJnkXSy8wFNrw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 09:44:27 -0700
X-Gm-Features: Ac12FXwMqgI_Oz3q7ppzUAq9TXL2qBpNKmPsgpp-I-Bf07X3_mrNGzIRSlP7_bg
Message-ID: <CAJuCfpHQf6oVx44VaiyVOb4ABAkhGe8NAN+juU-q99OhJCFhUQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] selftests/proc: add /proc/pid/maps tearing from
 vma split test
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
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

On Wed, Jul 16, 2025 at 7:20=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 16, 2025 at 3:50=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Jul 16, 2025 at 12:44:23PM +0200, David Hildenbrand wrote:
> > > On 16.07.25 05:05, Suren Baghdasaryan wrote:
> > > > The /proc/pid/maps file is generated page by page, with the mmap_lo=
ck
> > > > released between pages.  This can lead to inconsistent reads if the
> > > > underlying vmas are concurrently modified. For instance, if a vma s=
plit
> > > > or merge occurs at a page boundary while /proc/pid/maps is being re=
ad,
> > > > the same vma might be seen twice: once before and once after the ch=
ange.
> > > > This duplication is considered acceptable for userspace handling.
> > > > However, observing a "hole" where a vma should be (e.g., due to a v=
ma
> > > > being replaced and the space temporarily being empty) is unacceptab=
le.
> > > >
> > > > Implement a test that:
> > > > 1. Forks a child process which continuously modifies its address sp=
ace,
> > > > specifically targeting a vma at the boundary between two pages.
> > > > 2. The parent process repeatedly reads the child's /proc/pid/maps.
> > > > 3. The parent process checks the last vma of the first page and
> > > > the first vma of the second page for consistency, looking for the
> > > > effects of vma splits or merges.
> > > >
> > > > The test duration is configurable via the -d command-line parameter
> > > > in seconds to increase the likelihood of catching the race conditio=
n.
> > > > The default test duration is 5 seconds.
> > > >
> > > > Example Command: proc-maps-race -d 10
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Why is this selftest not making use of any kselftest framework?
> > >
> > > I'm sure there is a very good reason :)
>
> It used to be a part of proc-pid-vm.c and after the split I kept its
> overall structure. I'll look into using the kselftest framework.
> Thanks!
>
> > >
> > > Reading assert() feels very weird compared to other selftests.
> >
> > Sorry to meta-review via your review again David :P
> >
> > But just to say tools/testing/selftests/kselftest_harness.h is really g=
ood, and
> > makes life simple. See tools/testing/selftests/mm/guard-regions.c for a=
n example
> > of how they can be used - pretty straightforward and avoids a lot of ks=
elftest
> > boilerplate.
>
> Thanks for the pointers. I need to figure out a way to pass
> command-line parameters to my test. Maybe I can use fixtures for
> that... Let me read more about it.

Ok, I think I'll use environment variables to set verbosity and test
duration. That seems like the cleanest approach.

>
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> > >

