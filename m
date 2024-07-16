Return-Path: <linux-kselftest+bounces-13815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42229332D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 22:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214F71C22223
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF571448ED;
	Tue, 16 Jul 2024 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="YnX1VKh5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA5182B9
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721161116; cv=none; b=BHG4I7fODpzPygFT+OppRJQOTRPwaxMdZfBIXrIR5svFcZSKdSstWH4gu9I7hXCYY1//J5/i+MIEwu0tsxk32XMLbbLs8naVmVbURzdRM5WEfsCZSWr4RMXWxAnBQ4B8V2WHwI2h0PkfVI90ctgqpreemCER9ywqdPbzGo+zkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721161116; c=relaxed/simple;
	bh=FyC5BZh6YjG7u8zcZ2c65+wWIIwNIpHTlJEujslh7io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf0HzPZiLcbXv5kYyg37PnbefmI3FHNrfSHvNYBBlXMFsmXhqspKtKndvOhhVcSZ8LiVjk77LSj3BtUjERdf5IAr/J9DQY1AAKOk3CC9oGjXE6GJFy7Nfih/M8NFH+szI3+NSy7durxWLAuQMisOwOuW+w11L+T1HHiYyrX2DY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=YnX1VKh5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af4868d3dso4569198b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721161114; x=1721765914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyC5BZh6YjG7u8zcZ2c65+wWIIwNIpHTlJEujslh7io=;
        b=YnX1VKh5XW5EboJ4GQIWXyXWyCxnZh1UkXSIxYaZEChmU/Mz/epz1v3t32+Toido5N
         5UJCaREKfzelTtZO/Fvn01A3zLAyGSPQHW8srIYwKa0byygpww3sKTj2csnxjW1WgEoV
         mIKTNvzsYOcRbaxULhi1blI9eTkwCTqjdnNpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721161114; x=1721765914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyC5BZh6YjG7u8zcZ2c65+wWIIwNIpHTlJEujslh7io=;
        b=MiZzCt8xiKhcmNSpXFhkWzu0RB8nZeXjygsSNMqoE8XRe6zDwS9qLzpapXNheo7zbb
         aj2EtSwp19NwZIMWPxLh++rp6Z4ZeSz00FK6Q48/c9dlNrR/7IK5K0QAowP4sbINpBxD
         9U0brIZGTPyuADZfL0/jauqgh5cqFtRtWYYMIKs+1AZgqKzrj4KzggCSIvWpc0Ve7u3H
         fwaR1MDCNuemYa5zX0MQMoMjp77AWnuTxf6SGTZ2NNToKRmoqLG7GkaRyOBBWxx7tyfz
         cisgbqO3iJatO3Elv1fRXlu7FfIm7MZPNYtgHxnfN5x0vrX3TB8ALNQJIHgrDYIjBt/W
         UgNA==
X-Forwarded-Encrypted: i=1; AJvYcCUbKqme6Mlsa6Cb3XcNWTRqJRB8RylGKC61Ubedb8jz4lIQddgKbjJ19Z7vJPowJx7U2P6PGE/K1Iy/MhZ/HeyUBldhxEbeMSlmRN4Kj0VG
X-Gm-Message-State: AOJu0YxQsDwp0/ydYepplI0Kyi5uahTQ6sfJoBrBoXshluxFwP3xsMcP
	qwypcySMGVSlbWH4cOFxKB4vmGxIO/fbwM0tH6IgffTYFTtvWtxXDBecrXpZJuc3MnOOdC/vrJh
	hfJwX/zdbAyGnab7fVGCjQdMd5XUKmgEEY1qzwg==
X-Google-Smtp-Source: AGHT+IEFgQRryyYjffP1tMyu+yRGi+Lu74CsJaCnG4LnNTpPp6GXalOUh/HXJ0e/K/ocxUbYqr7+Or8rdlcaOJ96Yo4=
X-Received: by 2002:a05:6a00:1491:b0:70b:23d9:98ae with SMTP id
 d2e1a72fcca58-70c2e9d2173mr3909520b3a.28.1721161114136; Tue, 16 Jul 2024
 13:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <CAFUnj5M9CTYPcEM3=4i4rTfiU4sY4Qq8V1DXHJ00YYD2xFBvew@mail.gmail.com> <ZpbOezMVYkYdQV_s@slm.duckdns.org>
In-Reply-To: <ZpbOezMVYkYdQV_s@slm.duckdns.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 16 Jul 2024 16:18:23 -0400
Message-ID: <CAFUnj5NLTz4yQHpucvwgWqKgC2oeotHMC3h6QyS_XHD2O7wJTA@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 3:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 16, 2024 at 01:10:14PM -0400, David Finkel wrote:
> > > Swap still has bad reps but there's nothing drastically worse about i=
t than
> > > page cache. ie. If you're under memory pressure, you get thrashing on=
e way
> > > or another. If there's no swap, the system is just memlocking anon me=
mory
> > > even when they are a lot colder than page cache, so I'm skeptical tha=
t no
> > > swap + mostly anon + kernel OOM kills is a good strategy in general
> > > especially given that the system behavior is not very predictable und=
er OOM
> > > conditions.
> >
> > The reason we need peak memory information is to let us schedule work i=
n a
> > way that we generally avoid OOM conditions. For the workloads I work on=
,
> > we generally have very little in the page-cache, since the data isn't
> > stored locally most of the time, but streamed from other storage/databa=
se
> > systems. For those cases, demand-paging will cause large variations in
> > servicing time, and we'd rather restart the process than have
> > unpredictable latency. The same is true for the batch/queue-work system=
 I
> > wrote this patch to support. We keep very little data on the local disk=
,
> > so the page cache is relatively small.
>
> You can detect these conditions more reliably and *earlier* using PSI
> triggers with swap enabled than hard allocations and OOM kills. Then, you
> can take whatever decision you want to take including killing the job
> without worrying about the whole system severely suffering. You can even =
do
> things like freezing the cgroup and taking backtraces and collecting othe=
r
> debug info to better understand why the memory usage is blowing up.
>
> There are of course multiple ways to go about things but I think it's use=
ful
> to note that hard alloc based on peak usage + OOM kills likely isn't the
> best way here.

To be clear, my goal with peak memory tracking is to bin-pack in a way
that I don't encounter OOMs. I'd prefer to have a bit of headroom and
avoid OOMs if I can.

PSI does seem like a wonderful tool, and I do intend to use it, but
since it's a reactive
signal and doesn't provide absolute values for the total memory usage
that we'd need to
figure out in our central scheduler which work can cohabitate (and how
many instances),
it complements memory.peak rather than replacing my need for it.

FWIW, at the moment, we have some (partially broken) OOM-detection,
which does make
sense to swap out for PSI tracking/trigger-watching that takes care of
scaling down workers
when there's resource-pressure.
(Thanks for pointing out that PSI is generally a better signal than
OOMs for memory pressure)


Thanks again,

>
> ...
> > I appreciate the ownership issues with the current resetting interface =
in
> > the other locations. However, this peak RSS data is not used by all tha=
t
> > many applications (as evidenced by the fact that the memory.peak file w=
as
> > only added a bit over a year ago). I think there are enough cases where
> > ownership is enforced externally that mirroring the existing interface =
to
> > cgroup2 is sufficient.
>
> It's fairly new addition and its utility is limited, so it's not that wid=
ely
> used. Adding reset makes it more useful but in a way which can be
> deterimental in the long term.
>
> > I do think a more stateful interface would be nice, but I don't know
> > whether I have enough knowledge of memcg to implement that in a reasona=
ble
> > amount of time.
>
> Right, this probably isn't trivial.
>
> > Ownership aside, I think being able to reset the high watermark of a
> > process makes it significantly more useful. Creating new cgroups and
> > moving processes around is significantly heavier-weight.
>
> Yeah, the setup / teardown cost can be non-trivial for short lived cgroup=
s.
> I agree that having some way of measuring peak in different time interval=
s
> can be useful.
>
> Thanks.
>
> --
> tejun



--=20
David Finkel
Senior Principal Software Engineer, Core Services

