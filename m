Return-Path: <linux-kselftest+bounces-13781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA809327D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77BFFB20BA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91A19B3C4;
	Tue, 16 Jul 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="mTH/vYhB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA461990CF
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138094; cv=none; b=lMVwUb+Rc0gx8KScFTf6LrFcECGXxKaWGkMVnMs5SQbvO0rBPqPKp/wDqRdEWfIBE7ThWsELGT4LHx8dM5D63LAaecOUKeBTkVqFKZ81zTEx9J0d3bUMSvJWwAiUzMewSaYdEkBZ8Qmg20Lk865sno1IRsz9ipwi8zb4TW0nTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138094; c=relaxed/simple;
	bh=Zu3fvk1G4h79WaK3VZko9ulOR3G6zOjFt29jnIvYxyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVGVBeQZ6fKJGgFvcZsPmv1VzkEbJYVvqM0pwXe7gPAH3hCQatsJmrQXAIKQDJA5Er+JC8jqd/Pp+n1/V/4eh5H+rObHkS8o6dHsXTbQsF1HB9UnEMYR5xFq3yc/4KOn1J9QW3ZIzp1ozQDVxrH+sAp0UZH2RlntrmCZLko7J4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=mTH/vYhB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-78512d44a13so3719440a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 06:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721138091; x=1721742891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfYT81X+JbtIPMlAO3YtYDsv4qp4U3lPBqzIZ0idfpM=;
        b=mTH/vYhBYzs07xzKT0l4/aiMNEAS4GnRZGniBEmMF8D8etmZ9sli4afOGQTjCFz/3e
         RW7sIUyzzFkWAholii+0p2c6PECpMrTvV3oGLEubIjQqVZVRRecjXUg8PjQcXFZZj6xx
         dWyUGHz19ayLEI18ZidsumN+BNsmJQmaQrqXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721138091; x=1721742891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfYT81X+JbtIPMlAO3YtYDsv4qp4U3lPBqzIZ0idfpM=;
        b=GS77LGBIMAarBH6BIvKaMj7TS3SERu8f8M2I+vERLwR59IyMl49sbDA2jpQjKMD063
         9thRYLWPFLPRRf65thbGUjzOu+KsHOhRwN41mcCbJNpyAhWmrFd4jB8Bm1XbaCbkyBMH
         ELEZD1Qm+hELgc9bfC20MSlOg1nmulpT0jKHt5mqr0cTQiGYOLAS8z6QF9RnAGHBsObl
         DMAEcJuNDSNzJyovyh7cV7IaOvXU4AUimB/F5r4iwj6N42nCYDGu/Af8asoiRH04rZT/
         OUantqXxjTaTMPX6f266J/LfXCq4AFAas5JVs1vpLP+663i5Qx0L2bjwiJGsp4/7VAve
         jfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNwBCIIszPeVnrSj/ZxlJdeUfs6m75vR61fwxmiS0wfcbXdCjSUbmJMlQF4Tgf/QSwmOpVa6X8It9sTRxsJ7ZeJxfRU/aJJgqQu+rQYX91
X-Gm-Message-State: AOJu0Yz/ZHPgexoeF/tOR6X2MReUJEvV5sG6gyvu0kVwy5PzxOdax5w2
	zdjV2JbASSemMnED2gIHmj3X+rp/QoQ+YYQuvZe0QWhx9w/PHh6rtDe4VUYmi5YgAt2mkrSqUD1
	kGTsvPMmeVG2YHTgTvskT8he5FX3oJQiCmJqF4w==
X-Google-Smtp-Source: AGHT+IGx+cRRXemzKapP9hmTTeHrWTch3dG3LS+Iq9Go5gHj7UbxSEnrer9YRngu4o/b6ia21geBCVOSzUYPjswdzuM=
X-Received: by 2002:a05:6a20:12c7:b0:1c2:74b4:a05d with SMTP id
 adf61e73a8af0-1c3f122d75cmr2556165637.23.1721138090450; Tue, 16 Jul 2024
 06:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
In-Reply-To: <ZpZ6IZL482XZT1fU@tiehlicka>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 16 Jul 2024 09:54:39 -0400
Message-ID: <CAFUnj5MLcL6PtUXVG9Sa_8ovs1HZGzy5AB2FVx+Y+FnDuCP+yg@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 9:48=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 15-07-24 16:36:26, David Finkel wrote:
> > Other mechanisms for querying the peak memory usage of either a process
> > or v1 memory cgroup allow for resetting the high watermark. Restore
> > parity with those mechanisms.
> >
> > For example:
> >  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
> >    the high watermark.
> >  - writing "5" to the clear_refs pseudo-file in a processes's proc
> >    directory resets the peak RSS.
> >
> > This change copies the cgroup v1 behavior so any write to the
> > memory.peak and memory.swap.peak pseudo-files reset the high watermark
> > to the current usage.
> >
> > This behavior is particularly useful for work scheduling systems that
> > need to track memory usage of worker processes/cgroups per-work-item.
> > Since memory can't be squeezed like CPU can (the OOM-killer has
> > opinions), these systems need to track the peak memory usage to compute
> > system/container fullness when binpacking workitems.
> >
> > Signed-off-by: David Finkel <davidf@vimeo.com>
>
> As mentioned down the email thread, I consider usefulness of peak value
> rather limited. It is misleading when memory is reclaimed. But
> fundamentally I do not oppose to unifying the write behavior to reset
> values.
>
> The chnagelog could use some of the clarifications down the thread.

Sure, I can spend some time rewording the changelog this afternoon, and
remail it. in a few hours.

>
> Acked-by: Michal Hocko <mhocko@suse.com>
>

Thank you!
> --
> Michal Hocko
> SUSE Labs



--=20
David Finkel
Senior Principal Software Engineer, Core Services

