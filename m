Return-Path: <linux-kselftest+bounces-13827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D09336F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 08:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFC81C20B31
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 06:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D9134A8;
	Wed, 17 Jul 2024 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4bTEgSD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742412B6C
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197565; cv=none; b=TE+zZO0j/EA+a7XknRIxeYkDb0+7436JapoWvSsQS9PJAfzEN+tq0SiOmWAEirLOMqvnm6WoB71yWlmdVlZ23tIsXj6Pl107AaA7x5h9fN2Tv51AfXUpHdsFOPXZ915w2yWA9e8rcYNuSnDesTZ1QuzKpZ/kQpFwcXcrHOw/AEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197565; c=relaxed/simple;
	bh=ByuZeLQzwZ5x3nXl8kE+pf2jxHURXs8b01VJ/XfnZeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njBKtvu0lcvMU2i0uoua0k0XuxNCziSLZz0mD3FOe12GZQHfmzDDB3gLSBIQ5wby0/aeRxy+1rr1LJVU1hJL3dze1CwOIb03A8Baqj8zPUPF04OLflCkOkc4sZGiofOpbYlHsPJnj01bCCFt6lXaf1mkJPN75p7f6Pf2xXcJHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4bTEgSD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea2f58448so8653021e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721197562; x=1721802362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kRZCoDkETaEFOBCewGIFpdrgG+eZN4FZNraXMVegoL0=;
        b=e4bTEgSDEfWn7rENkpLoF+hCc9fKY8oY++rP9JBYSRBR7RxLje7itpWbdi3VSGWjIn
         asaYcjERfn+fP3lnAyyXvTbzvs+etHxKUeSntA4XHTyTX+S9OZeiCBxdT45wnXD2lJ6W
         tS9ccv3uPT2fFP9ZIO5EMwGVcnwKvNO09kxXAXmULeZTzcVB74tfbvBXxemzePDl4BJz
         B1GiEYq3ZU+6305EFZUeX6liW5EpBfbK467EgIPNG5AyrEF5vT3byKYjiAhq2FdHpgyS
         qhxVkO8h1V367NglYzcuxBdJpPtYH4VZBF/AlHvAjvdP+hmS2OIenbbumhhI99Znyl/1
         R8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197562; x=1721802362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRZCoDkETaEFOBCewGIFpdrgG+eZN4FZNraXMVegoL0=;
        b=NFtnQrzrG9jmHb8jeB/BulEe8UqGU2ggELAhykvlf3ht4yQLoMKMtk/+MYMY4vgu+7
         wxMUYPjSXS/4BZ+ToqJXZinqWhc2jxh0gU9i5Pz+3zEEYQ2+TFMPfWYPXAFiR4XUY4FQ
         vJi40oFt/wCkNcPda8LiPbBLL+F5FoNelk5JGg1Wam4+3bB6Xfeg48q81YN840UbcU7L
         ec5rwQR/JR/Y3ZMS9GWkd0ort32LY62WliWUEAqbMLSWnTYhgQ4dAmVhYbVyvZ6JJpFR
         nJECTVGfRkSdy3lMaYwyKbnUeLII2fhLAUbCMl/HtAp3Rxqlryd4XydpyMrpu4HkKAbR
         HLtw==
X-Forwarded-Encrypted: i=1; AJvYcCW6H2mcy8u7R5mSh9TIYZME2KwCHB/fvXVWHaZmqGxjnx7GtKrBVQCeKHxU5Z6Te0d92qDcaqdUX5mKIIz655gfj+UybHN7Nq3w4Czyo1qP
X-Gm-Message-State: AOJu0YylQO+1KWQaU/baE1lKgWt2fVF9EhgDeIk2p6wgrDWUqkcEaIxE
	rgWwncT7Sfgu6icRN96yheHndKaoDqcImRtinc3z1zIwgu4/P2gvTsJ55spSAvg=
X-Google-Smtp-Source: AGHT+IGDEwk+nZqPqfNzpH3tY2qHsGGwHFWpWnZPOMmrbDmZO3jaXfhbMrl3VS0/+lWJ0Ywpz+aWEA==
X-Received: by 2002:a05:6512:104a:b0:52e:9ec8:a3fd with SMTP id 2adb3069b0e04-52ee542718dmr459428e87.45.1721197561796;
        Tue, 16 Jul 2024 23:26:01 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b4f87sm406498866b.48.2024.07.16.23.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:26:01 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:26:00 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <Zpdj-DVZ5U5EdvqL@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka>
 <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
 <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>

On Tue 16-07-24 18:06:17, David Finkel wrote:
> On Tue, Jul 16, 2024 at 4:00 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Jul 16, 2024 at 08:00:52PM +0200, Michal Hocko wrote:
> > ...
> > > > If we want to allow peak measurement of time periods, I wonder whether we
> > > > could do something similar to pressure triggers - ie. let users register
> > > > watchers so that each user can define their own watch periods. This is more
> > > > involved but more useful and less error-inducing than adding reset to a
> > > > single counter.
> > >
> > > I would rather not get back to that unless we have many more users that
> > > really need that. Absolute value of the memory consumption is a long
> > > living concept that doesn't make much sense most of the time. People
> > > just tend to still use it because it is much simpler to compare two different
> > > values rather than something as dynamic as PSI similar metrics.
> >
> > The initial justification for adding memory.peak was that it's mostly to
> > monitor short lived cgroups. Adding reset would make it used more widely,
> > which isn't necessarily a bad thing and people most likely will find ways to
> > use it creatively. I'm mostly worried that that's going to create a mess
> > down the road. Yeah, so, it's not widely useful now but adding reset makes
> > it more useful and in a way which can potentially paint us into a corner.
> 
> This is a pretty low-overhead feature as-is, but we can reduce it further by
> changing it so instead of resetting the watermark on any non-empty string,
> we reset only on one particular string.
> 
> I'm thinking of something like "global_reset\n", so if we do something like the
> PSI interface later, users can write "fd_local_reset\n", and get that
> nicer behavior.
> 
> This also has the benefit of allowing "echo global_reset >
> /sys/fs/cgroup/.../memory.peak" to do the right thing.
> (better names welcome)

This would be a different behavior than in v1 and therefore confusing
for those who rely on this in v1 already. So I wouldn't overengineer it
and keep the semantic as simple as possible. If we decide to add PSI
triggers they are completely independent on peak value because that is
reclaim based interface which by definition makes peak value very
dubious.
-- 
Michal Hocko
SUSE Labs

