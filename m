Return-Path: <linux-kselftest+bounces-13849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55809343B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 23:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96161C220CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5E185E75;
	Wed, 17 Jul 2024 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="ayGYkAje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4001850A0
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250841; cv=none; b=ou051g0PjMx+bypgh6em8eCwR4tmQtw1c4et8xdKKsg9dVBWjYnfKE22sVaMBYrwzgBUFrLiD3sELFneFTyduW7VmqYXDPn7hlCxFOJnevU78vhAvaGG+NZwQ4tZUso6zHM9KcdZOqlp47xNHmpaUDQ2jdcRaq6HpMhVDpJl6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250841; c=relaxed/simple;
	bh=JkU4klHktphurufRlUTdyDTeLTt6/HE8rdePKvAFCqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYyzBqz6pXK/Ek52rexm6ybZHdfkPU8Ongn1ajuLoc7lFDzo5LuV60A+2a3pocV6RbpnqtKi443Gk4dc9GGXXvvvkmQLlw0ksuSZsFZ5Z1OpcWzC72CJrJ34gm89l5SES+6WQN7p2xS3/4LfXW3ZgmS/Jp2eK2ReTe0eFKHRT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=ayGYkAje; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so65778b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721250839; x=1721855639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/0JM5dLFFD4LF1dsWbX1JlSJvSEH5yTSYQQKpq7BAo=;
        b=ayGYkAjeboexBSGku8WC5EwA+F9ihvjQw56tS5O/P0idKuiznok++oNV2Qd6Mhmv3E
         Wi0yfycCc03Xs/EfrtaRYHKTBew4uLnR4FEtWCAh4Ia7QIWbvPCBaLtAfBPRN0zwXpYN
         1ON64vArm2hH7oOnklFC98FS0Y6kSvl3sh9wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250839; x=1721855639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/0JM5dLFFD4LF1dsWbX1JlSJvSEH5yTSYQQKpq7BAo=;
        b=UX/AWj7ulLDQY0ug6KeVGzizQhVPjF6y5dYXejwEbJbMjHxbO2eMvGlliQGsIP7a5Q
         oetrCI9YaT/XHxa0Gv/zA/HeMLfUcDUaBFVFeeQMeETfI3A0ExUCeLckGzhbclz37+sm
         GH7jD/1zYi993+3CZ0d6BCGKQwwqJnzDdhOJObrrgkTG3UYj6hbirUgH2ykfC7iKASCp
         EPuYv/YtZ1N0h9K7KmPScHPLDmlgNu6reD4t8K9lRirmWpzInmvWgJObX3LbVWeefFL4
         cluitobT5wxqzXWEJmASOzsxQMw1oGfCsRkiPbEMSrlNTe0OtRmWYSyQINJe7pPTj5DQ
         IvFw==
X-Forwarded-Encrypted: i=1; AJvYcCUiKNUMeWyQfhrs1Ts8spWOPjhuTqyLaTkVDNytMfJBbiL3J+YTwddd6ZG1d1GK/syjNYimaCaMXRnrKAe9YFUR+p71tliKni4WTa1Ah/gu
X-Gm-Message-State: AOJu0YwdsVi22qyQhSxlQB9XEn9E28pb3pxY91dZkNBmVho3FHw+2aMf
	s/eKcxzBP00LI3uZHbPUK+Q28NooZpF6LI/t4NRi6NIRSXbJ8/wh5ORkbYF+rcUcQmWEAZDianQ
	ZBJaWaV6k4INwAkUwoaAkJkegRCNDnwgFK+7U7odAgSpKMwad4hw=
X-Google-Smtp-Source: AGHT+IGxH/WHmAcJpGEJZcvrvdSJnI8QejnDNGq+5KD9M1pb0aI5cslGuiI7fRDd2gbrzdU64Q7pro0QCqIfKTD9Rd0=
X-Received: by 2002:aa7:9301:0:b0:70b:18f:45dd with SMTP id
 d2e1a72fcca58-70ce4f3ed7amr2644993b3a.32.1721250839049; Wed, 17 Jul 2024
 14:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <20240717170408.GC1321673@cmpxchg.org> <CAFUnj5OA0KaC54M9vd8W+NZJwz5Jw25u-BStO=Bi2An=98Ruwg@mail.gmail.com>
 <20240717204453.GD1321673@cmpxchg.org>
In-Reply-To: <20240717204453.GD1321673@cmpxchg.org>
From: David Finkel <davidf@vimeo.com>
Date: Wed, 17 Jul 2024 17:13:47 -0400
Message-ID: <CAFUnj5OGJtR0wqOZVUh8QQ3gaw4gmatsEN1LcBdcwN_wx-LUug@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:44=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Jul 17, 2024 at 04:14:07PM -0400, David Finkel wrote:
> > On Wed, Jul 17, 2024 at 1:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 06:44:11AM -1000, Tejun Heo wrote:
> > > > Hello,
> > > >
> > > > On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
> > > > ...
> > > > > > This behavior is particularly useful for work scheduling system=
s that
> > > > > > need to track memory usage of worker processes/cgroups per-work=
-item.
> > > > > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > > > > opinions), these systems need to track the peak memory usage to=
 compute
> > > > > > system/container fullness when binpacking workitems.
> > > >
> > > > Swap still has bad reps but there's nothing drastically worse about=
 it than
> > > > page cache. ie. If you're under memory pressure, you get thrashing =
one way
> > > > or another. If there's no swap, the system is just memlocking anon =
memory
> > > > even when they are a lot colder than page cache, so I'm skeptical t=
hat no
> > > > swap + mostly anon + kernel OOM kills is a good strategy in general
> > > > especially given that the system behavior is not very predictable u=
nder OOM
> > > > conditions.
> > > >
> > > > > As mentioned down the email thread, I consider usefulness of peak=
 value
> > > > > rather limited. It is misleading when memory is reclaimed. But
> > > > > fundamentally I do not oppose to unifying the write behavior to r=
eset
> > > > > values.
> > > >
> > > > The removal of resets was intentional. The problem was that it wasn=
't clear
> > > > who owned those counters and there's no way of telling who reset wh=
at when.
> > > > It was easy to accidentally end up with multiple entities that thin=
k they
> > > > can get timed measurement by resetting.
> > > >
> > > > So, in general, I don't think this is a great idea. There are short=
comings
> > > > to how memory.peak behaves in that its meaningfulness quickly decli=
nes over
> > > > time. This is expected and the rationale behind adding memory.peak,=
 IIRC,
> > > > was that it was difficult to tell the memory usage of a short-lived=
 cgroup.
> > > >
> > > > If we want to allow peak measurement of time periods, I wonder whet=
her we
> > > > could do something similar to pressure triggers - ie. let users reg=
ister
> > > > watchers so that each user can define their own watch periods. This=
 is more
> > > > involved but more useful and less error-inducing than adding reset =
to a
> > > > single counter.
> > > >
> > > > Johannes, what do you think?
> > >
> > > I'm also not a fan of the ability to reset globally.
> > >
> > > I seem to remember a scheme we discussed some time ago to do local
> > > state tracking without having the overhead in the page counter
> > > fastpath. The new data that needs to be tracked is a pc->local_peak
> > > (in the page_counter) and an fd->peak (in the watcher's file state).
> > >
> > > 1. Usage peak is tracked in pc->watermark, and now also in pc->local_=
peak.
> > >
> > > 2. Somebody opens the memory.peak. Initialize fd->peak =3D -1.
> > >
> > > 3. If they write, set fd->peak =3D pc->local_peak =3D usage.
> > >
> > > 4. Usage grows.
> > >
> > > 5. They read(). A conventional reader has fd->peak =3D=3D -1, so we r=
eturn
> > >    pc->watermark. If the fd has been written to, return max(fd->peak,=
 pc->local_peak).
> > >
> > > 6. Usage drops.
> > >
> > > 7. New watcher opens and writes. Bring up all existing watchers'
> > >    fd->peak (that aren't -1) to pc->local_peak *iff* latter is bigger=
.
> > >    Then set the new fd->peak =3D pc->local_peak =3D current usage as =
in 3.
> > >
> > > 8. See 5. again for read() from each watcher.
> > >
> > > This way all fd's can arbitrarily start tracking new local peaks with
> > > write(). The operation in the charging fast path is cheap. The write(=
)
> > > is O(existing_watchers), which seems reasonable. It's fully backward
> > > compatible with conventional open() + read() users.
> >
> > That scheme seems viable, but it's a lot more work to implement and mai=
ntain
> > than a simple global reset.
> >
> > Since that scheme maintains a separate pc->local_peak, it's not mutuall=
y
> > exclusive with implementing a global reset now. (as long as we reserve =
a
> > way to distinguish the different kinds of writes).
> >
> > As discussed on other sub-threads, this might be too niche to be worth
> > the significant complexity of avoiding a global reset. (especially when
> > users would likely be moving from cgroups v1 which does have a global r=
eset)
>
> The problem is that once global resetting is allowed, it makes the
> number reported in memory.peak unreliable for everyone. You just don't
> know, and can't tell, if somebody wrote to it recently. It's not too
> much of a leap to say this breaks the existing interface contract.

It does make it hard to tell when it was reset, however, it also allows som=
e
very powerful commandline interactions that aren't possible if you need to
keep a persistent fd open.

I have run things in cgroups to measure peak memory and CPU-time for
things that have subprocesses. If I needed to keep a persistent fd open
in order to reset the high watermark, it would have been far less useful.

Honestly, I don't see a ton of value in tracking the peak memory if I
can't reset it.
It's not my use-case, but, there are a lot of cases where process-startup u=
ses
a lot more memory than the steady-state, so the sysadmin might want to
measure that startup peak and any later peaks separately.

In my use-case, I do have a long-lived process managing the cgroups
for its workers, so I could keep an fd around and reset it as necessary.
However, I do sometimes shell into the relevant k8s container and poke
at the cgroups with a shell, and having to dup that managing processes'
FD somehow to check the high watermark while debugging would be
rather annoying. (although definitely not a dealbreaker)

>
> You have to decide whether the above is worth implementing. But my
> take is that the downsides of the simpler solution outweigh its
> benefits.

There are a few parts to my reticence to implement something
more complicated.
 1) Correctly cleaning up when one of those FDs gets closed can
     be subtle
 2) It's a lot of code, in some very sensitive portions of the kernel,
     so I'd need to test that code a lot more than I do for slapping
     a new entrypoint on the existing watermark reset of the
     page_counter.
 3) For various reasons, the relevant workload runs on
     Google Kubernetes Engine with their Container Optimised OS.
     If the patch is simple enough, I can request that Google
     cherry-pick the relevant commit, so we don't have to wait
     over a year for the next LTS kernel to roll out before we
     can switch to cgroups v2.

It would be a nice personal challenge to implement the solution
you suggest, but it's definitely not something I'd knock out in the
next couple days.

Thanks,
--=20
David Finkel
Senior Principal Software Engineer, Core Services

