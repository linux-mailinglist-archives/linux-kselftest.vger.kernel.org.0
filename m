Return-Path: <linux-kselftest+bounces-13994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D6293919F
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A611C20E47
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316B16DECF;
	Mon, 22 Jul 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="GFMYAJJL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6216D4EF
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661541; cv=none; b=rhGbm6aSTXjunYoMf/eBBz/kxtHXrS2W+0V2Z+DNyDBacXpA2rOsrzJHakz4cuMDDl4WQQ8lWaY3WPpSZZoglBJuT7rM5ERoUzb4644gPGDDpMwQQy/vtey4LMS0ZukUu/TFK66otmQOdP8KblOgE4FsCccX711rGtGls9bRjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661541; c=relaxed/simple;
	bh=tKK9/3I13MvhyzlrlIeNEK5w1H/w6SfkKGofIH4mavE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkXpmstFnJO4pRSOnW00VGH4adn3y8XI99wBLWBKJurNEGE3qwjTm7jIyUPZPYuPIUtnDUKJg6pLnJfAx9HdP/4sn8K6DmDHXdfqVirX7fKHlcG4GmKjxMCt10LQIy/9Bo9SDdLDOYH6HnehBu7mSnvEvhINe+ZoC3OmNgSRKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=GFMYAJJL; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ce74defe41so2377410eaf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721661538; x=1722266338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKK9/3I13MvhyzlrlIeNEK5w1H/w6SfkKGofIH4mavE=;
        b=GFMYAJJLKx1eyRTdfIm/1R0tSHAaQCvQ6HNwwKm+0gbeaCYa56vrIVm2bh6X0nmPzY
         MaR3kLjNepI6MXD3ONsPhE/bZyLrYxCeEkf2MJ1yOe3ZRkwTQnKyy3I4atydNdhTfdDZ
         aWKNv5LZWcxV/gC8Z/5+GksMiIBlI8KiY/Y5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721661538; x=1722266338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKK9/3I13MvhyzlrlIeNEK5w1H/w6SfkKGofIH4mavE=;
        b=cnae/ZOjz688phQm5bMeUx9xS40OEioV3U/No18xq3w0y4xE0HWexUK8w5+Mnvqz9E
         tKrch/7lYgy8roKUfySuuchqXaepDLEmYQAY1UWUSEVMSVXJCZJwby4QAN3sf72kNtAu
         bdknNgqMOUGYAEBas0e0/o9hQC5Ld9MyhkcRCRvcS2aFjAa3HNHU0J6jxyD+mAmlXY5W
         iT4ecWR9ApkpX7O+hPo9nsckx0Aa752NEvgubrOdel5Qv9XZRmuQ2UQbvViJJ6EuCRbg
         dbKmh7Bv+qKaK9XBb0GQmOkTcyVzoJMy/vsJRpt16/hLiS7Oj5GbFETdBfZBP7Ihadqu
         BAvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJmh5jEwlVSZlD2XKP1BUs6RqOIx12h05i75jKTRuNShpgne91jJjhpWNmGHIaK68p2O7PdeZfbL+7tIJ5nNXvhxH3BcybRtKIUOxjQAqc
X-Gm-Message-State: AOJu0Yx9z9zj89wOvJ0yun/8wPUsf4to0jdg42IdIC9IVxbEIWZDP1zf
	ZLZS6KltGysRmm+GDVYGcJs3ijflXdMRstx7O4ziuIPP5K/FXA4EgHn+2SRqQhmIBiGMyHe2TX8
	/2vBpfpeFlvduBhzI6JbYAAGKzemGzRb3CJklrg==
X-Google-Smtp-Source: AGHT+IH5LDxowoDamLUYoLl291IngnNdCcTq6/3wHFVuWdTaH42FkypxLhePVVQznXZrboSlC/zmNdEhr4+x0rPlRJ0=
X-Received: by 2002:a05:6870:1715:b0:25e:1ced:744 with SMTP id
 586e51a60fabf-263c7612bb6mr6127529fac.47.1721661538646; Mon, 22 Jul 2024
 08:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <20240717170408.GC1321673@cmpxchg.org> <CAFUnj5OkHp3fYjByCnXJQ51rog93DsimSoc1qxcU7UyKw-nFrw@mail.gmail.com>
 <fcb8f0ec-59ff-4f79-82dd-7eaf2530aef3@redhat.com>
In-Reply-To: <fcb8f0ec-59ff-4f79-82dd-7eaf2530aef3@redhat.com>
From: David Finkel <davidf@vimeo.com>
Date: Mon, 22 Jul 2024 11:18:47 -0400
Message-ID: <CAFUnj5MsGdswXbvy6neGzDsD=9=CuTCcezrkz0ofFsJedydUag@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:23=E2=80=AFPM Waiman Long <longman@redhat.com> w=
rote:
>
>
> On 7/18/24 17:49, David Finkel wrote:
> > I spent some time today attempting to implement this.
> > Here's a branch on github that compiles, and I think is close to what y=
ou
> > described, but is definitely still a WIP:
> >
> > https://github.com/torvalds/linux/compare/master...dfinkel:linux:memcg2=
_memory_peak_fd_session
> >
> > Since there seems to be significant agreement that this approach is bet=
ter
> > long-term as a kernel interface, if that continues, I can factor out so=
me of
> > the changes so it supports both memory.peak and memory.swap.peak,
> > fix the tests, and clean up any style issues tomorrow.
> >
> > Also, If there are opinions on whether the cgroup_lock is a reasonable =
way
> > of handling this synchronization, or if I should add a more appropriate=
 spinlock
> > or mutex onto either the pagecounter or the memcg, I'm all ears.
>
> cgroup_lock() should only be used by the cgroup core code, though there
> are exceptions.
>
> You may or may not need lock protection depending on what data you want
> to protect and if there is any chance that concurrent race may screw
> thing up. If lock protection is really needed, add your own lock to
> protect the data. Since your critical sections seem to be pretty short,
> a regular spinlock will be enough.

Thanks, using cgroup_lock() created a deadlock, and using a spinlock
resolved that.

>
> Cheers,
> Longman
>


--=20
David Finkel
Senior Principal Software Engineer, Core Services

