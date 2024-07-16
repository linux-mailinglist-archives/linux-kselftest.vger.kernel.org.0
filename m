Return-Path: <linux-kselftest+bounces-13820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BFE933414
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 00:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8A01F23F4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A167B13A896;
	Tue, 16 Jul 2024 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="iFYn1rCP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E273478
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721167590; cv=none; b=bJS79K4uPPpGzs/slIiP0J+Py50mQbFRMjcAadRXDqFuKoh8Ku+o2wYgrbTyledVqiJgxOAeGUIo6+a22V8gPfhnWCVJskV/CxYJkXRCkLryGqeLxGU1B2LBDMHOqMRjIsJYmG0MKoqBg+xSPYXVHdBQVvYKvEQIrHWVpiG5mCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721167590; c=relaxed/simple;
	bh=w2aJTmvDOMvn6K+ayRVj7cPeNTzCuJAPOw72W6PM9lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Osq+N6Cqxj6iRmAAKXUXGbl7ZYP1pOigteDMiKMTRe4npoj0HmZbEH22UK+nEPhmlMknRGxQy93xgtsc+lC2dUIZJV1uFCWx+Jmu8WUWwJWF70463KRR+uyJEQG+/9Hi6t6pPh/nM7Li4V84/HOfcYiUScgLWjUQoN6XG9nxCCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=iFYn1rCP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70aec66c936so4449658b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721167588; x=1721772388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2aJTmvDOMvn6K+ayRVj7cPeNTzCuJAPOw72W6PM9lM=;
        b=iFYn1rCPz8Yjz2EqLEmXGiJwH/zAtHBURGmwCoilfR2SeKKpx4O0cDZlR2kk31aShx
         GFn72ubRuT+2Rp7ns/omxxe3uiBjun9JBL+Kb5/ElpuqkjlY3ZCKKl+6zkcLC43yvdq6
         vgenCo2lVDOAIw1tMNUvFiaHR6sKyHFJ/LcgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721167588; x=1721772388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2aJTmvDOMvn6K+ayRVj7cPeNTzCuJAPOw72W6PM9lM=;
        b=vKqsey5z7Xi6SxR5OS3eVE3URq7kRuc8btGR/9OIlH5dbp6/olggnbazR7hF8GsMRA
         NfCd4vjRL5ocG+LJp8ANPTqFmvH+4Xv/ko1TiaaQGGBu4+Ui4jeE6lg94G4y8SdC9xVA
         mTmNLEUKzIzOxoLWgP5aTfV8hYkRp45FN5PYFkt2bdGLcMnoI7TOh9UgKTWbPreATWi9
         /Q4gNDghyJNvqztBBsheM3pQoIsUxLv8k3OTO2JzNx36Ynvv6mOokyQ2B8OpqSS7yzbQ
         3y5BghBw5QD5YZynYSR937v+mzPcRH2tSu7lPBNczztrsaHhHGWoI1Io7J5IbamvrMtp
         EWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIR77PWyFEruaxw6Vbt17sza5m5r0o2ateL4asdnITfIRvNS9EEiIemj7FE8dr2UfT3JJEOM4HlBq8AsFSs/rw0eUEGLvODzF64uSIUsa+
X-Gm-Message-State: AOJu0YxjzDxrZO5N6WP3jVG1mkQcf2wBPwQ4T5VVy+OqfSrDUPvnOW7c
	oEMe7PEzopB3bkm0E9gtPCJ3UsVQI3iattZlVqSfyC27TAXcaUF69SRsev8mydxLjP2plftev4d
	b/fhPbCgjHj6Ih1iHdPjOJiw9qSfpG7yNjkSv4w==
X-Google-Smtp-Source: AGHT+IHa4OUEBjwkyORdqOTlwB6SwJ3UGLm7iossoLCCGBgQW/WBnp341S1YhpWMm7wMFcfIxWpuIGR1HiBOvvInuxU=
X-Received: by 2002:a05:6a20:a123:b0:1c0:7ec3:c7ae with SMTP id
 adf61e73a8af0-1c3f12ac92dmr4304824637.47.1721167588247; Tue, 16 Jul 2024
 15:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka> <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
In-Reply-To: <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 16 Jul 2024 18:06:17 -0400
Message-ID: <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:00=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 16, 2024 at 08:00:52PM +0200, Michal Hocko wrote:
> ...
> > > If we want to allow peak measurement of time periods, I wonder whethe=
r we
> > > could do something similar to pressure triggers - ie. let users regis=
ter
> > > watchers so that each user can define their own watch periods. This i=
s more
> > > involved but more useful and less error-inducing than adding reset to=
 a
> > > single counter.
> >
> > I would rather not get back to that unless we have many more users that
> > really need that. Absolute value of the memory consumption is a long
> > living concept that doesn't make much sense most of the time. People
> > just tend to still use it because it is much simpler to compare two dif=
ferent
> > values rather than something as dynamic as PSI similar metrics.
>
> The initial justification for adding memory.peak was that it's mostly to
> monitor short lived cgroups. Adding reset would make it used more widely,
> which isn't necessarily a bad thing and people most likely will find ways=
 to
> use it creatively. I'm mostly worried that that's going to create a mess
> down the road. Yeah, so, it's not widely useful now but adding reset make=
s
> it more useful and in a way which can potentially paint us into a corner.

This is a pretty low-overhead feature as-is, but we can reduce it further b=
y
changing it so instead of resetting the watermark on any non-empty string,
we reset only on one particular string.

I'm thinking of something like "global_reset\n", so if we do something like=
 the
PSI interface later, users can write "fd_local_reset\n", and get that
nicer behavior.

This also has the benefit of allowing "echo global_reset >
/sys/fs/cgroup/.../memory.peak" to do the right thing.
(better names welcome)

>
> But then again, maybe this is really niche, future usages will still rema=
in
> very restricted, and adding something more akin to PSI triggers is way
> over-engineering it.

Yeah, I think this is niche enough that it isn't worth over-engineering.
There is some value to keeping broad compatibility for things moving
from cgroups v1, too.

>
> Thanks.
>
> --
> tejun


Thanks again,
--=20
David Finkel
Senior Principal Software Engineer, Core Services

