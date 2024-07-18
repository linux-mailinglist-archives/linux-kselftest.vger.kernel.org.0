Return-Path: <linux-kselftest+bounces-13904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614D937044
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 23:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C561C21D23
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B2145B13;
	Thu, 18 Jul 2024 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="n5WF6ICT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB4145B00
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339381; cv=none; b=dbQU3DjdG2R7OYfB4SPnyOCPwGm8xJUJkzsCVMFLp9yMCvsm22uQW8A4fSztwC8YHGlwv69u+e/ZQtd0+gXeosYkGP9fZ/laLtw9PE+CFOeQst77jyamTvu9kc/5yMHyOhkYBCp4AxCKYw5PJ1W9UqJlP5ruNJ3d+ZSo7kqevE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339381; c=relaxed/simple;
	bh=UipBClRhuga+7eGM83ijNAcVasZf8QTyN9VWIlxbtSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMqF41UCQDFlJMaZZkdIGEiwQnMCMFamSteN4q45BMXWnYHucDoFgH7J/dEVqrPZqxcnMbZZrqoEGJcVuS0ny6SJcnGpbMKoTf2eUlv48lGELRO9T0w+6lFhXOEyc+eRqw11+xb6fawTUNvSRR6VjxVfvZkxYAMdr7IiVTXNzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=n5WF6ICT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b3c0a00f2so214799b3a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jul 2024 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721339379; x=1721944179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImNfl0lxisTrDz2TQ4vM0mgYT84J4/46xCk2xuscFRE=;
        b=n5WF6ICT2VTE/LfmoLKPkG98Qw49gKE8dPqGa9UkBasgfx5iIqFjRVI/I7CDZOoTW6
         vr+rARytj3YzVhTSXomq80cuJFb4Uz3evNZnT65oBfhiMPLN+hYNNAisgWYixPl4KZXG
         iCqnRsuqNZVNSdYGMaayQfFdHLxyscj7DoVl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721339379; x=1721944179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImNfl0lxisTrDz2TQ4vM0mgYT84J4/46xCk2xuscFRE=;
        b=MlnQ4fpIuO8tIiwzHlvMkmghD+ReDJXP2uipcmHqicH+qgDmXESwMp2DqPnAHpE3Xs
         iYq8l1wmmZs2DW70SzNE+GNqLS1L5VKWmqBjrWOL6HVxRO2MfzpH/tOj9ihpPBoL+aTP
         weBix1lbqPHMW6Po5mv8pbZ5/YfFUk8Cp+0SerQcdInnB02FfFa75e86mglxZRiKgWNk
         tVuCfWlq80bun4Prgrvs4pB6FZFaY9IKYoLJgdO76EP2gPFcEnjdlddj11iSgRy4tZQv
         VD63nzlqCiSd9RYpI7pnPoMcW6ygy3s1jw7M82c7UlZWuR9gkLJvZf2AVJQkJ6kVyXyZ
         jZow==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5wK8miLWjIo5wjokgn9pcxefIqP33l9P28pGP/uykTnw3HvywYZbMmyElFllUOedJFbPWGZmnCMvTvhco0daLgGCV39+5/wPyFFsRZcB
X-Gm-Message-State: AOJu0YzJhuE2LZ1dJdRS5eT7/XY7e+TtK0PlqFxb7ynw4h+Se9s17uSS
	Dj8T2xqLo3A0n2tyFP38zADaH6FY/eNaijuHmRTNr467iF63iWdPXfkIlRL4k9Jr61+Jhe+SXpe
	z3plDrNwLLMBb1Y1W7IAs/YNFJhCRE0L4T8rFjg==
X-Google-Smtp-Source: AGHT+IHOUHCFW3BqLlA/XU4s+sjNOKmckQbyQ1DXqrZy31IA0S9B3ukOd/g0Ze9UvEkpyp5dZDi44gENSMuTlNUh0f8=
X-Received: by 2002:a05:6a00:a1a:b0:705:c029:c993 with SMTP id
 d2e1a72fcca58-70cfc906b99mr1040207b3a.14.1721339379143; Thu, 18 Jul 2024
 14:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org> <20240717170408.GC1321673@cmpxchg.org>
In-Reply-To: <20240717170408.GC1321673@cmpxchg.org>
From: David Finkel <davidf@vimeo.com>
Date: Thu, 18 Jul 2024 17:49:28 -0400
Message-ID: <CAFUnj5OkHp3fYjByCnXJQ51rog93DsimSoc1qxcU7UyKw-nFrw@mail.gmail.com>
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

On Wed, Jul 17, 2024 at 1:04=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Jul 16, 2024 at 06:44:11AM -1000, Tejun Heo wrote:
> > Hello,
> >
> > On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
> > ...
> > > > This behavior is particularly useful for work scheduling systems th=
at
> > > > need to track memory usage of worker processes/cgroups per-work-ite=
m.
> > > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > > opinions), these systems need to track the peak memory usage to com=
pute
> > > > system/container fullness when binpacking workitems.
> >
> > Swap still has bad reps but there's nothing drastically worse about it =
than
> > page cache. ie. If you're under memory pressure, you get thrashing one =
way
> > or another. If there's no swap, the system is just memlocking anon memo=
ry
> > even when they are a lot colder than page cache, so I'm skeptical that =
no
> > swap + mostly anon + kernel OOM kills is a good strategy in general
> > especially given that the system behavior is not very predictable under=
 OOM
> > conditions.
> >
> > > As mentioned down the email thread, I consider usefulness of peak val=
ue
> > > rather limited. It is misleading when memory is reclaimed. But
> > > fundamentally I do not oppose to unifying the write behavior to reset
> > > values.
> >
> > The removal of resets was intentional. The problem was that it wasn't c=
lear
> > who owned those counters and there's no way of telling who reset what w=
hen.
> > It was easy to accidentally end up with multiple entities that think th=
ey
> > can get timed measurement by resetting.
> >
> > So, in general, I don't think this is a great idea. There are shortcomi=
ngs
> > to how memory.peak behaves in that its meaningfulness quickly declines =
over
> > time. This is expected and the rationale behind adding memory.peak, IIR=
C,
> > was that it was difficult to tell the memory usage of a short-lived cgr=
oup.
> >
> > If we want to allow peak measurement of time periods, I wonder whether =
we
> > could do something similar to pressure triggers - ie. let users registe=
r
> > watchers so that each user can define their own watch periods. This is =
more
> > involved but more useful and less error-inducing than adding reset to a
> > single counter.
> >
> > Johannes, what do you think?
>
> I'm also not a fan of the ability to reset globally.
>
> I seem to remember a scheme we discussed some time ago to do local
> state tracking without having the overhead in the page counter
> fastpath. The new data that needs to be tracked is a pc->local_peak
> (in the page_counter) and an fd->peak (in the watcher's file state).
>
> 1. Usage peak is tracked in pc->watermark, and now also in pc->local_peak=
.
>
> 2. Somebody opens the memory.peak. Initialize fd->peak =3D -1.
>
> 3. If they write, set fd->peak =3D pc->local_peak =3D usage.
>
> 4. Usage grows.
>
> 5. They read(). A conventional reader has fd->peak =3D=3D -1, so we retur=
n
>    pc->watermark. If the fd has been written to, return max(fd->peak, pc-=
>local_peak).
>
> 6. Usage drops.
>
> 7. New watcher opens and writes. Bring up all existing watchers'
>    fd->peak (that aren't -1) to pc->local_peak *iff* latter is bigger.
>    Then set the new fd->peak =3D pc->local_peak =3D current usage as in 3=
.
>
> 8. See 5. again for read() from each watcher.
>
> This way all fd's can arbitrarily start tracking new local peaks with
> write(). The operation in the charging fast path is cheap. The write()
> is O(existing_watchers), which seems reasonable. It's fully backward
> compatible with conventional open() + read() users.

I spent some time today attempting to implement this.
Here's a branch on github that compiles, and I think is close to what you
described, but is definitely still a WIP:

https://github.com/torvalds/linux/compare/master...dfinkel:linux:memcg2_mem=
ory_peak_fd_session

Since there seems to be significant agreement that this approach is better
long-term as a kernel interface, if that continues, I can factor out some o=
f
the changes so it supports both memory.peak and memory.swap.peak,
fix the tests, and clean up any style issues tomorrow.

Also, If there are opinions on whether the cgroup_lock is a reasonable way
of handling this synchronization, or if I should add a more appropriate spi=
nlock
or mutex onto either the pagecounter or the memcg, I'm all ears.

(I can mail the WIP change as-is if that's prefered to github)

--=20
David Finkel
Senior Principal Software Engineer, Core Services

