Return-Path: <linux-kselftest+bounces-13810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD993326C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 21:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6302844C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9228DBC;
	Tue, 16 Jul 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foyC+9I1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975074687;
	Tue, 16 Jul 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159296; cv=none; b=HOcyLjdMzHQwNMiaMux2f6fQWT3RbWJm7FUoPK4TaRtcI2PZaDUcgDntScAc6y5HhgoUOhPZKe3cXxOWPJtF/s7hHht21hxcSHgynGv23v8PwzH4IrdxRQ9ivPH3eu9nICK00heSnDS41y0F56/+nRyfpYNiz+SuuRsoCKAidds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159296; c=relaxed/simple;
	bh=Q83+376KHj5JmvZQJf4BDt8MUL2fSbIl3w4WSky1kuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4jCc+/k0fUj4mStE9DEcID3Hm9Bpkav5YVqij+n+qsrVjNLG2waB5WB3zprR19hHAa1uto3rY/7QSDfjFsCApEz5bDDDr2MVDWUnsTmWRooBByzWPB6l7PIA/UIiK6jkdBJx0TEUMRsznr/MDOGlcs98eTe4krOqI5Km9XWuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foyC+9I1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so32971925ad.1;
        Tue, 16 Jul 2024 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721159294; x=1721764094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afKFF0MqOKII6px42Zfqj+kP7vnjeE8h4vRzd8rEIWY=;
        b=foyC+9I1DCgMd/nXlO/kJwt/6wus6PcVRzPThyjcBzyKfcQdgP+MW/XHPQCzpPFjAw
         miXAFAskqtifhhxqXwTOa9kjd/2JBhvZ+LvTRix3PQvYrUoMOO7WO74P2GqOpOzBoegJ
         gIiE9Si/W9QxZeFg+MHor3uuBZQA8F12G/A+rKUex+c+pTciUWF6tqBWoZJEFZTDSwQy
         BZ64HNHwYswaNHp2u1y4Jhqlp2ku5Cj1uz7Pc1qqsbTgW/OKQZxgSyV6ilMYVHd9kyPv
         VkdhDIRJZxWij7dROHxP0uWYBGmu4FI/bsLo0OPv2k4KVrHin5XoAdYKim9F2rlN0mTv
         vavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721159294; x=1721764094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afKFF0MqOKII6px42Zfqj+kP7vnjeE8h4vRzd8rEIWY=;
        b=qjz99zS+nuoCwqLriLmwBgqjGLxqLjIsf/69lZy662AQXZSXo7wj83A2cfzYseMOXB
         kisHu29pIiO65QV8voySQ3WOs/wLKc6KdAyqSg6lhotEEFCspI+6AZgH8Kw7boL39mFo
         8PE8hJwxnxJ++orjbRCV1imCSuWkfQOQxY4zo6TNwqsNAeE33dmdB02A7nu9n7Gl8DND
         EHOv6uNVwjOi2LYrkVAsrGokcIA5VQAuokKnnnWnL2vNI4VXI4BvL7qQXuMponuR8kfA
         /+VeUAUQ8MnnhwJv60gMTKlFNvhMa8YLsO1vm+7Kr0vvG3Sscm2j08lGnjaCGdLjy2+J
         j7tg==
X-Forwarded-Encrypted: i=1; AJvYcCVk9gsecUCx5rlP39Xs5ArsONCT0qeYCdxs+qt+qUF7E956WHHUb0BUaCv5/r+VwpgbiyvUxsxt7+NNidwG5KlAQ4eg5eA0mZqATDG1/9SUuqciIt0d4xCwPpI02np8cL2V61OHcTUBHsU2u9G2UmX5obdjR82TWBxyyAPs3znOIQZ5Kg==
X-Gm-Message-State: AOJu0YyLeCiyfZUJr4xTTLbf8uHE3dVP/VcLAm5IZpJqMCFvVtQVyGnh
	3Kb86sfVgvPVSU+hlpLCAj8KJVBfzZgmREymymWoi8He7ldDwMsx
X-Google-Smtp-Source: AGHT+IFZ+3eBSrn8MmZv7XoeGhU1YbpdzqQrQM5X3Nv7c207QpLA42+Ma7V5iHZbJeYh8qf2cFhkhA==
X-Received: by 2002:a17:903:41c3:b0:1fb:9b91:d7db with SMTP id d9443c01a7336-1fc3d941907mr26937265ad.19.1721159293721;
        Tue, 16 Jul 2024 12:48:13 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbbf792sm62127375ad.96.2024.07.16.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:48:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 09:48:11 -1000
From: Tejun Heo <tj@kernel.org>
To: David Finkel <davidf@vimeo.com>
Cc: Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpbOezMVYkYdQV_s@slm.duckdns.org>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <CAFUnj5M9CTYPcEM3=4i4rTfiU4sY4Qq8V1DXHJ00YYD2xFBvew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFUnj5M9CTYPcEM3=4i4rTfiU4sY4Qq8V1DXHJ00YYD2xFBvew@mail.gmail.com>

Hello,

On Tue, Jul 16, 2024 at 01:10:14PM -0400, David Finkel wrote:
> > Swap still has bad reps but there's nothing drastically worse about it than
> > page cache. ie. If you're under memory pressure, you get thrashing one way
> > or another. If there's no swap, the system is just memlocking anon memory
> > even when they are a lot colder than page cache, so I'm skeptical that no
> > swap + mostly anon + kernel OOM kills is a good strategy in general
> > especially given that the system behavior is not very predictable under OOM
> > conditions.
> 
> The reason we need peak memory information is to let us schedule work in a
> way that we generally avoid OOM conditions. For the workloads I work on,
> we generally have very little in the page-cache, since the data isn't
> stored locally most of the time, but streamed from other storage/database
> systems. For those cases, demand-paging will cause large variations in
> servicing time, and we'd rather restart the process than have
> unpredictable latency. The same is true for the batch/queue-work system I
> wrote this patch to support. We keep very little data on the local disk,
> so the page cache is relatively small.

You can detect these conditions more reliably and *earlier* using PSI
triggers with swap enabled than hard allocations and OOM kills. Then, you
can take whatever decision you want to take including killing the job
without worrying about the whole system severely suffering. You can even do
things like freezing the cgroup and taking backtraces and collecting other
debug info to better understand why the memory usage is blowing up.

There are of course multiple ways to go about things but I think it's useful
to note that hard alloc based on peak usage + OOM kills likely isn't the
best way here.

...
> I appreciate the ownership issues with the current resetting interface in
> the other locations. However, this peak RSS data is not used by all that
> many applications (as evidenced by the fact that the memory.peak file was
> only added a bit over a year ago). I think there are enough cases where
> ownership is enforced externally that mirroring the existing interface to
> cgroup2 is sufficient.

It's fairly new addition and its utility is limited, so it's not that widely
used. Adding reset makes it more useful but in a way which can be
deterimental in the long term.

> I do think a more stateful interface would be nice, but I don't know
> whether I have enough knowledge of memcg to implement that in a reasonable
> amount of time.

Right, this probably isn't trivial.

> Ownership aside, I think being able to reset the high watermark of a
> process makes it significantly more useful. Creating new cgroups and
> moving processes around is significantly heavier-weight.

Yeah, the setup / teardown cost can be non-trivial for short lived cgroups.
I agree that having some way of measuring peak in different time intervals
can be useful.

Thanks.

-- 
tejun

