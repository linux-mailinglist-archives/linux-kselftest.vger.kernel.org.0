Return-Path: <linux-kselftest+bounces-20414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B659AB670
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83892833A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105B1CB316;
	Tue, 22 Oct 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cT3PdKAC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785D1CB304
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624174; cv=none; b=kaBiNu7XdKnhjr91TDcu+ydXFbrPkljA6hvyL2gQFysflJhFUqj4IbL4OYThcynxcJevCGv+zZGR5aKG3yJaAZZs2pWBaqpUcEV9A5RUQuWReNTSWnZwLwVVdGe+B+aT4HkucQ6Sx7SreMxA+lU7GgibmV56QwM1VOr6X4UVfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624174; c=relaxed/simple;
	bh=81gvCdvEgpB04Nn2JKObvXqoAtKSBk/mWn/H596JZbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnLtQenySu67J0rpBY8UdRqhyjd9jSw8OHI6wUpMj7e6YekGKv8oeFLwbxyRaGEibbLGKT9Q+pbUlSGkdVmNSpugsU9v4tyZrbxnUtogtlcM0YoiEaRiU/+UjzO1MN+8nL0Sls3TizYp2ZO3G4gGIp3x49lAeuq4jb5QGDozuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cT3PdKAC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso45495e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 12:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729624171; x=1730228971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq7vYlKYjVUJ2Hf6UjPLePUAsgsPK2CPSZGZYNK3ODQ=;
        b=cT3PdKAC9zr7KhODAieNwfi1GsU1GaLjVuEDvtqZRytv1glu3lU4RXsOt2X4qNhR2r
         nNcIv208OnoUIcxQB8CuGhDUAaBfyv6wT+TNtRhoKVR3CKKS0RljahwhBdSiR/mqDkiV
         5BwRPsUBFnDjt9gfVfetUjjo5/e+GUlLypFF3DIn1UBTX9p4twDG24peMq9FOFioUKEG
         2UCrVGRQJPgDNgFFaj1TCbVJhdbZELl3K6at2cvfYQwKUkDCOlAJhANJx2jirXPneKh3
         lbWJuoelrNVcisv4nodkxXpV+foJPUqa5B5QZb+F5X5O3C7q2UCUCPDo3O9W48fBzVwu
         uZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624171; x=1730228971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq7vYlKYjVUJ2Hf6UjPLePUAsgsPK2CPSZGZYNK3ODQ=;
        b=m2Xd4NRa5I3IN2KfDb+wgmXxGqp+xBFYig3T+/n66qZPu7qtXSaD4fCcUJHwZw48bH
         eH1REF8YcF9KfPt06hHoqDT5lqUYAJz1vp5uBP5P8OrIpMcrHxN2M5b9xktVgorkK4qb
         T0r33b7DH80cf2hwvSLvulddi6xLv78bF1wi4DvvjgubcYiDld4ihbrxr0LvwI2m2WnR
         gUsZTt+4oB1Q7F7lqMC/5Iq6t8y/tgZfrbNGYgTWP8JGJc7yZ+rZnGV+Rgy/IgfFmppW
         pQ9in9/2eERgw+Ym/KVICvRJXN/J4k04UUS+vD82EunYuD+2rGkR3ttYtaj9Kp8g1V7r
         zs5g==
X-Forwarded-Encrypted: i=1; AJvYcCV86QsRawpI4vER/L0VrW68oXIolVdJQLUJ1CRFG5ZqJn6OYaAtv+JH9wzLrTN1kT6BgkPXPzNitDknqU++2Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOTqaXGETluMJ+jrsRPO4WnYg5e4wgrvt7YfIIxGw54EHk8LG
	wxlqg54EVz3PqdeSGLtxwkOWq4cwF2KMGW2g4hera1Sn6Qhoy0NVeBgRntC88QAW2KzhsWBAP5j
	gvFK+GHXI9ziYTatx0+kd/8/rAtNlRJeRfsgf
X-Google-Smtp-Source: AGHT+IHdTaQMVD7gfS71JCtoKNqFlL+ZH6CTrJ3WUvE3tBmxfLe5eVJcaVuq9zPzDtwFl3aO3H7IuCLtAGxl1WBUDSc=
X-Received: by 2002:a05:600c:3d91:b0:426:7018:2e2f with SMTP id
 5b1f17b1804b1-43184628822mr181375e9.5.1729624170899; Tue, 22 Oct 2024
 12:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz> <393b0932-1c52-4d59-9466-e5e6184a7daf@lucifer.local>
 <f2448c59-0456-49e8-9676-609629227808@suse.cz>
In-Reply-To: <f2448c59-0456-49e8-9676-609629227808@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Tue, 22 Oct 2024 21:08:53 +0200
Message-ID: <CAG48ez3WS3EH9DuhE1b+7AX3+1=dVtd1M7y_5Ev4Shp2YxiYWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page mechanism
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:46=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> On 10/21/24 22:27, Lorenzo Stoakes wrote:
> > On Mon, Oct 21, 2024 at 10:11:29PM +0200, Vlastimil Babka wrote:
> >> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> >> > +  while (true) {
> >> > +          /* Returns < 0 on error, =3D=3D 0 if success, > 0 if zap =
needed. */
> >> > +          err =3D walk_page_range_mm(vma->vm_mm, start, end,
> >> > +                                   &guard_poison_walk_ops, NULL);
> >> > +          if (err <=3D 0)
> >> > +                  return err;
> >> > +
> >> > +          /*
> >> > +           * OK some of the range have non-guard pages mapped, zap
> >> > +           * them. This leaves existing guard pages in place.
> >> > +           */
> >> > +          zap_page_range_single(vma, start, end - start, NULL);
> >>
> >> ... however the potentially endless loop doesn't seem great. Could a
> >> malicious program keep refaulting the range (ignoring any segfaults if=
 it
> >> loses a race) with one thread while failing to make progress here with
> >> another thread? Is that ok because it would only punish itself?
> >
> > Sigh. Again, I don't think you've read the previous series have you? Or
> > even the changelog... I added this as Jann asked for it. Originally we'=
d
> > -EAGAIN if we got raced. See the discussion over in v1 for details.
> >
> > I did it that way specifically to avoid such things, but Jann didn't ap=
pear
> > to think it was a problem.
>
> If Jann is fine with this then it must be secure enough.

My thinking there was:

We can legitimately race with adjacent faults populating the area
we're operating on with THP pages; as long as the zapping and
poison-marker-setting are separate, *someone* will have to do the
retry. Either we do it in the kernel, or we tell userspace to handle
it, but having the kernel take care of it is preferable because it
makes the stable UAPI less messy.

One easy way to do it in the kernel would be to return -ERESTARTNOINTR
after the zap_page_range_single() instead of jumping back up, which in
terms of locking and signal handling and such would be equivalent to
looping in userspace (because really that's what -ERESTARTNOINTR does
- it returns out to userspace and moves the instruction pointer back
to restart the syscall). Though if we do that immediately, it might
make MADV_POISON unnecessarily slow, so we should probably retry once
before doing that. The other easy way is to just loop here.

The cond_resched() and pending fatal signal check mean that (except on
CONFIG_PREEMPT_NONE) the only differences between the current
implementation and looping in userspace are that we don't handle
non-fatal signals in between iterations and that we keep hogging the
mmap_lock in read mode. We do already have a bunch of codepaths that
retry on concurrent page table changes, like when zap_pte_range()
encounters a pte_offset_map_lock() failure; though I guess the
difference is that the retry on those is just a couple instructions,
which would be harder to race consistently, while here we redo walks
across the entire range, which should be fairly easy to race
repeatedly.

So I guess you have a point that this might be the easiest way to
stall other tasks that are trying to take mmap_lock for an extended
amount of time, I did not fully consider that... and then I guess you
could use that to slow down usercopy fault handling (once the lock
switches to handoff mode because of a stalled writer?) or slow down
other processes trying to read /proc/$pid/cmdline?

You can already indefinitely hog the mmap_lock with FUSE, though that
requires that you can mount a FUSE filesystem (which you wouldn't be
able in reasonably sandboxed code) and that you can find something
like a pin_user_pages() call that can't drop the mmap lock in between,
and there aren't actually that many of those...

So I guess you have a point and the -ERESTARTNOINTR approach would be
a little bit nicer, as long as it's easy to implement.

