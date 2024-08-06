Return-Path: <linux-kselftest+bounces-14892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F9949BB8
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 01:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A381F2261E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363F2171E5F;
	Tue,  6 Aug 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="mBjtzr0/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B61509A5
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985267; cv=none; b=g1zFo+5Q6FVKPK7UHIaLSXt0sJBE+laWBN4I1OvPztE+jRqxP4AZzvo/Kg6+lCmUUIMH8o11HRhhGuYU2p+dTaB4sACJ7iLmU9YiKje/0cQN3HgnIWvCX9+O9ajagckB09xqWqzRPr9KquH1cls18LpCxPEfUK7bC8QhbWM/q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985267; c=relaxed/simple;
	bh=3QmhHNzLVdqCL3bdWzZ7LYa+8zX30H7zX+17oS8ce28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+cVvGokQrdyY+cD0Gcrb3vDUH+G3AGyjE0AteszH4a7T5rYIVZv75vF6lc+S25uReeQe3pRaye8e8fD52dHqwJ40ZK9BCoCx6bs+2fnHR+uaeNPgqsWcuLLo5jxAnVxj4sxC6lEUfm34ImpyPJlXXzZsDEyUAFhHsLEZDT3A+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=mBjtzr0/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cf213128a1so792424a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2024 16:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722985263; x=1723590063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPNbLMtMlLLk3ef/8hupZv2oNZsASyGwoL+TsrWxtR8=;
        b=mBjtzr0/RxfPzjs2Bgs1nhEuDYQskqEo0v34J+6sEsDvKgOQtxPhWCdTf1GLTH1Lr1
         Z2BUTcKyY29KHw1XCW0o83i2a4iLlo8/y3nTD7mzXxHJKGXjjVulZK2X8DwzvfdfPvMi
         xAFiCv/SIEldY+m390cUivxYtihx5/sawTDqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722985263; x=1723590063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPNbLMtMlLLk3ef/8hupZv2oNZsASyGwoL+TsrWxtR8=;
        b=dwBB60Eei8Yy1uf/YON+mkDk9vtshJsML0JFdsqbSopUIuEZiTKc08gBrGRf4/7R6H
         9TL25fghJY9xTJht0xB0r5dfDqUBaHSCC76YC4avq2uYsia/qrLvuYNdeExos5QQMOdT
         HfXyq59rprqsVFGLr4SQGsTMWo5XHboYRTVY4Nd68jmEb+tVx/zXfGQPRhlk2JqW65ZX
         dEuZ69raqOuILCNdKY6NrrBJZIzZcj8VzBVbT1LxgmAxJOKHccAntFMffi73EYhWRlm4
         syedL4uzPqjpu62cM3GhX1SdzVc1IH74yrg8i15eOCnQkPE2v3gZjEkXFPVYJDgZLC8i
         04Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWhtEBmgDzXNgW9ZE+A/KX4Ua9en1K5heNTWlJ6zxppPcW0eTp6ZoSZhXGPSRyoEesKNwWnqt+IW+eU/RFaIV0G7YeXyourvcN/0DSgzwLC
X-Gm-Message-State: AOJu0YyxggCDuuF9CjelGWOXbmawNQMev9Nf3MtzzQP0ZtTEuXDk6ncb
	D308ss3Wgch32e1xbl2Q95aCG7Nfg1tja9AuVuHSFL41xx6hZ4W5lO3zzvVwtwY4hS3DTW0LOoe
	nEGHksIhz5PBx+VkE9eBzW7HX5pLjB7Wyow6t4g==
X-Google-Smtp-Source: AGHT+IEN2odX5l/+pi6H8JnpGZi2+DwjbVmGTdY2gmufUn0E5fEtEbcCHGIJv7xFQvKm5zmLKFlcZB0qzECMPqVeKCc=
X-Received: by 2002:a17:90a:788a:b0:2cb:51e4:3ed3 with SMTP id
 98e67ed59e1d1-2cff9432e02mr16249465a91.18.1722985263381; Tue, 06 Aug 2024
 16:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730231304.761942-1-davidf@vimeo.com> <CAFUnj5Nq_UwZUy9+i-Mp+TDghQWUX7MHpmh8uDTH790HAH2ZNA@mail.gmail.com>
 <ZrKFJyADBI_cLdX4@slm.duckdns.org> <20240806153637.4549ee6c1d1300042dd01c4c@linux-foundation.org>
In-Reply-To: <20240806153637.4549ee6c1d1300042dd01c4c@linux-foundation.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 6 Aug 2024 19:00:52 -0400
Message-ID: <CAFUnj5Nq74s4TVP=Ljmu4L5zUo+eqswfM0y57G5L6wD8wCdZAw@mail.gmail.com>
Subject: Re: [PATCH v7] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:36=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Tue, 6 Aug 2024 10:18:47 -1000 Tejun Heo <tj@kernel.org> wrote:
>
> > On Tue, Aug 06, 2024 at 04:16:30PM -0400, David Finkel wrote:
> > > On Tue, Jul 30, 2024 at 7:13=E2=80=AFPM David Finkel <davidf@vimeo.co=
m> wrote:
> > > >
> > > > This revision only updates the tests from the previous revision[1],=
 and
> > > > integrates an Acked-by[2] and a Reviewed-By[3] into the first commi=
t
> > > > message.
> > > >
> > > >
> > > > Documentation/admin-guide/cgroup-v2.rst          |  22 ++-
> > > > include/linux/cgroup-defs.h                      |   5 +
> > > > include/linux/cgroup.h                           |   3 +
> > > > include/linux/memcontrol.h                       |   5 +
> > > > include/linux/page_counter.h                     |  11 +-
> > > > kernel/cgroup/cgroup-internal.h                  |   2 +
> > > > kernel/cgroup/cgroup.c                           |   7 +
> > > > mm/memcontrol.c                                  | 116 ++++++++++++=
+--
> > > > mm/page_counter.c                                |  30 +++-
> > > > tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
> > > > tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
> > > > tools/testing/selftests/cgroup/test_memcontrol.c | 264 ++++++++++++=
++++++++++++++++++++-
> > > > 12 files changed, 454 insertions(+), 35 deletions(-)
> > ...
> > > Tejun or Andrew,
> > >
> > > This change seems to have stalled a bit.
> > > Are there any further changes necessary to get this patch merged into
> > > a staging branch so it's ready for 6.12?
> >
> > Oh, it sits between cgroup core and memcg, so I guess it wasn't clear w=
ho
> > should take it. Given that the crux of the change is in memcg, I think =
-mm
> > would be a better fit. Andrew, can you please take these patches? FWIW,
>
> I took 'em on Aug 4.

Great!

David, your spam folder beckons?

Oddly, I don't see any email from you on the 4th.
I do see my patches in mm-unstable now.
(I didn't see them there when I looked over the weekend)

With that said, I had a message go similarly mysteriously missing yesterday=
,
so it's possible something's wrong with our mail system.

>
> >  Acked-by: Tejun Heo <tj@kernel.org>
>
> Added, thanks.

Thanks again!

--=20
David Finkel
Senior Principal Software Engineer, Core Services

