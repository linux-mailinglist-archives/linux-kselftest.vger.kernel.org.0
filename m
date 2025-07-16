Return-Path: <linux-kselftest+bounces-37428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBABB077DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804E058417D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89EB230BF8;
	Wed, 16 Jul 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ie2d4wt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D5223DE9
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675634; cv=none; b=mHQiOhyzdmszR9LI1XxfFyn7kg8Vu5aWfxb6JNBqBJ3KDvj9NOmz/p/fqeDYn0ZYP1uwntyCvWAFU2wWLY/188/Vun4/cYwKwuB6cxGRTNvzI6zI+GVjMQNO83nmQsAXV/JRr8JDoqs+929agitz0r0gimhC/fm6QBDBco2HdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675634; c=relaxed/simple;
	bh=ssNd0mJRa1pJHDoPpoaDkjEJBefIzfkR4+Ha3JANNQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sea9+jEKQDgpZlY92+qTVHmRmq+tuTgJJFGpkvDGolotxcQJD0TNXpQ5ilB4k8Nfi49otP2WOVUSBOqN/LkoksjTwvoGPKBOz7ClfXIdvkLla/Qet/igI2dOpg3kCbr7K/GYJBD4VxsCon4TVvah0JMdsJkW0CJRyisxmdvi3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ie2d4wt9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so12318a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752675631; x=1753280431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIOphgqPm5lvaWbkIykektdEvrtd9usWnWnUZ8I8HvY=;
        b=ie2d4wt9HNP9/jNuyvLjMxGIK5vfNJsum1hD3UoasrT6wPV5/l+Il+9AJ87bLfaYD8
         uEq1wr1eMC/GJkBwIARNGZU8cpAG63nngu2POc/9QAq1wQO7lwDio749RZ9zyE1RZvjn
         Ss6Af+sHJvUzXZdvynQr7RFl4ZfoQsYhUbGM+TXbmwvVEzBxK+lc+Qeaw8crlb8cX5pJ
         bYz1b+RagkV62wpXI6uk86SNsmySDMS+B8T9tCWzzfJOcyRAKCmZx/YOOGu2uIoxUXx6
         oa5ZhFwKfKMtXNP0gWZqboEQ4KyqdcjVoS9FFq8x+z3GLVUkDcnUe1wSf0nxzVUl1blo
         PXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675631; x=1753280431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIOphgqPm5lvaWbkIykektdEvrtd9usWnWnUZ8I8HvY=;
        b=mPq3X7z0T4xw2oFcnkjBwvSl4x3FkY9yVdPli5FHxiy8nVY38N99cBH7MAX+2LwQ2/
         IyZ/15QNEjBiJ/XOFHr+CqO+GTqIFa/nYXv3aBm1zBShdx6nO5UtIbK5Fzxvzt6NhZZP
         3AI6ETxMmhkzWIEJnbY4bwSInDlb6zCIvcEIaR/6e39S5xb6Jja2TK+eaGkjHciNLiwM
         r3P8NdVcAvC1wSAehOgzajaUcELznV3nZ2am7tgLd7BmQBnp25zO/DNBxofstbrASyzY
         fqaavx5ryQwzJ1jfwMP7zCH6rKyHrEm8uNi1jOOsEDmtvLph/M8VO+BqFybUXNF6DLNe
         32jA==
X-Forwarded-Encrypted: i=1; AJvYcCWiycpDX2w/SL9lXWAU4TOP4iUUDV8MZvEWbXt//0q1EoEW2okt0dIOuZIcLIq9g6nnufZkfVo3Yzqzni0qF/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlf1Ah0tlFPlX9pAZoDZyfK7Zmj5rWKOwsIIjGQtuHMO1stB/W
	C+iZuAldKJ3RJw0nIMDecQ9Ndok02xeA38Yr9xzSnoQws207hCPD0w1zMrcyJBasj+ZYBfTHmdB
	J1xArmOMQ6/IBuS1Vc4zd8tvwAww8ksTjGslNYkbC
X-Gm-Gg: ASbGncsdqPVByjLUVPSQMBjgEBcoP8DAIHvMEd232vvuWhSW4iW0JLZbYa3NR9XzlSE
	fMZqrC6ffGSYfQrAO1e3ByLEBSpQ2g1dbaUPA23+1d8pdY7SHjriKZGevuL9VeVfFd5p1ekI7DQ
	geI2TQbSyFHhMBEyTZ1QTCWE+qq/zV3edIPLbVSEl284D7Vjn4hAUAIgSOy1CCibbR5M1sxnA1U
	yF8bbkAW85BrUVjXuMvgk695miQWY9dF86k
X-Google-Smtp-Source: AGHT+IF0KH9bDS2sqMIF1uloGs4FGACZhag7lE+PKo4FcniegeHB52YqSj5sS2l+sL+kSLOceI4mVmdKMq1e0f4po2w=
X-Received: by 2002:a05:6402:b04:b0:611:ff6c:50de with SMTP id
 4fb4d7f45d1cf-61287aba924mr66193a12.4.1752675630924; Wed, 16 Jul 2025
 07:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-2-surenb@google.com>
 <f041e611-9d28-4a30-8515-97080f742360@redhat.com> <ac9c5912-e19e-4653-9b6c-e68ca3a058f7@lucifer.local>
In-Reply-To: <ac9c5912-e19e-4653-9b6c-e68ca3a058f7@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 07:20:16 -0700
X-Gm-Features: Ac12FXwnoUYNXMD4XFIyUdZfEVH6BNOuC4bDqEgFyq4aGoHDoTIObxbq-deP8uQ
Message-ID: <CAJuCfpE+Nj9rQL=_pOtnAXSDnd9xEZt=r-j7guJnkXSy8wFNrw@mail.gmail.com>
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

On Wed, Jul 16, 2025 at 3:50=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Jul 16, 2025 at 12:44:23PM +0200, David Hildenbrand wrote:
> > On 16.07.25 05:05, Suren Baghdasaryan wrote:
> > > The /proc/pid/maps file is generated page by page, with the mmap_lock
> > > released between pages.  This can lead to inconsistent reads if the
> > > underlying vmas are concurrently modified. For instance, if a vma spl=
it
> > > or merge occurs at a page boundary while /proc/pid/maps is being read=
,
> > > the same vma might be seen twice: once before and once after the chan=
ge.
> > > This duplication is considered acceptable for userspace handling.
> > > However, observing a "hole" where a vma should be (e.g., due to a vma
> > > being replaced and the space temporarily being empty) is unacceptable=
.
> > >
> > > Implement a test that:
> > > 1. Forks a child process which continuously modifies its address spac=
e,
> > > specifically targeting a vma at the boundary between two pages.
> > > 2. The parent process repeatedly reads the child's /proc/pid/maps.
> > > 3. The parent process checks the last vma of the first page and
> > > the first vma of the second page for consistency, looking for the
> > > effects of vma splits or merges.
> > >
> > > The test duration is configurable via the -d command-line parameter
> > > in seconds to increase the likelihood of catching the race condition.
> > > The default test duration is 5 seconds.
> > >
> > > Example Command: proc-maps-race -d 10
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Why is this selftest not making use of any kselftest framework?
> >
> > I'm sure there is a very good reason :)

It used to be a part of proc-pid-vm.c and after the split I kept its
overall structure. I'll look into using the kselftest framework.
Thanks!

> >
> > Reading assert() feels very weird compared to other selftests.
>
> Sorry to meta-review via your review again David :P
>
> But just to say tools/testing/selftests/kselftest_harness.h is really goo=
d, and
> makes life simple. See tools/testing/selftests/mm/guard-regions.c for an =
example
> of how they can be used - pretty straightforward and avoids a lot of ksel=
ftest
> boilerplate.

Thanks for the pointers. I need to figure out a way to pass
command-line parameters to my test. Maybe I can use fixtures for
that... Let me read more about it.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
> >

