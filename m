Return-Path: <linux-kselftest+bounces-13789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDB1932EE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8297B222BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82AC19F48E;
	Tue, 16 Jul 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="cDIVqv+i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3D19E809
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149827; cv=none; b=H30j7kpAcyQbK6WBZwowWv/FE74Q+qDyu6dTVQcI0TASR2LOkOI7XxrfiyJVeLtuk5jZx/KdfHMaBtk6sNf3OJclllngB/sjlVnAdAJUz5uKZxIBmfYs2V0miOrf0Oc7QRcRoc6W+amyuUovdDyRt6v1ceeifSrBEDlyoEGbDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149827; c=relaxed/simple;
	bh=/1c3365id7LMdS2yg0ILYdAqscK4GzKxY0IS4H4GUy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z67ul/0RFvvzlnPl0hyquoi6GMOm8lVczphMqhacXHNNyXrZ4VwSciL34riCcu3WCl4ANk7M3WqnhpM/G479UYE/UBB/k+OJr5qP887QcZXutGxO8Cr7Bn627VtnTMkSgrlpL6GIIp/P9j7hwwBbEo1wtmbL43Jfy3nxD5fjaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=cDIVqv+i; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b1808dee9so3932364b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721149825; x=1721754625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1c3365id7LMdS2yg0ILYdAqscK4GzKxY0IS4H4GUy4=;
        b=cDIVqv+iM/AnXJILCmq8Yxd7QWlwoAgm1dCouMbj+cLW/yTXHbV1U7DGrXaec7lbf6
         0fGrPY1JF89fxxPPdqx9qjAWyCyBeIaOCcsU8pjSSuaN191XdkSOYsbmlkMTlEnlvTbm
         uvUk66BzJu2XEWsjkHELtq0Px5RhEnUXBa3Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721149825; x=1721754625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1c3365id7LMdS2yg0ILYdAqscK4GzKxY0IS4H4GUy4=;
        b=mfzP9BFQm9aL6WUHpY6HF4aRb8f//6Os/uJcdNeyapTZ9vkjIZQTPAziqgTGSLPL73
         rjdcTkdkj5KXXJCBgFlYdA14SuVS7BhuWb/elbdxdNn+V3TFDS5f2VJel/lW92C6O9xt
         fGASiOtEgj+oX4G4vxntH+LCT2YGTWz5Bq7yTCLj1rngUvVzkSFev+x3a+ltSTSjYDel
         TlYLCUATOCm1rKSM5W6oU41ek7rLsP28Z+hOOg8FqNCSPpV3UdNs7YP7BmXz/6+BLX0W
         oIoeA47/VGvdrZqjMjzYZCIeYhSGYHJtqYFHWTCkL810xU/SAufOPd6Th1yAX0gXCU/v
         IpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUllvIBVdXGuJG1NcYDEMmtXKjchjZUSSYzBsihLOG/m2Xs+136Tsj7p4+c36E8A7b9yltf8im7gUFQHqjAoLGj31VCVU30vZOU+iThv/M0
X-Gm-Message-State: AOJu0YyT44xdD7sJS+efJ+J9Xl31sEpdRqVF/4Q4XjCta/zNUPtC4qJJ
	YQHU5uSRCuGVaHqKlq0xp06/JWKrwLVDpco/MnBSPLTmBCWb4oZhZGFSfVUSrVxD8jWDVYcsZjI
	1uzLG/wW5kiQbZwVgKJsZdmgnuFuO+rhB0xcsLg==
X-Google-Smtp-Source: AGHT+IGxrFhf+t9CbrOmTbCaTrzVOqPOdzLWgYcjX29oem9uwcU5xToAeNAhBIZrmTimW7gqvO45de+d88JBZoYD3qY=
X-Received: by 2002:a05:6a21:32a7:b0:1c3:18f8:ebc9 with SMTP id
 adf61e73a8af0-1c3f1271886mr3158626637.41.1721149825418; Tue, 16 Jul 2024
 10:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203625.1462309-1-davidf@vimeo.com> <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka> <ZpajW9BKCFcCCTr-@slm.duckdns.org>
In-Reply-To: <ZpajW9BKCFcCCTr-@slm.duckdns.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 16 Jul 2024 13:10:14 -0400
Message-ID: <CAFUnj5M9CTYPcEM3=4i4rTfiU4sY4Qq8V1DXHJ00YYD2xFBvew@mail.gmail.com>
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

On Tue, Jul 16, 2024 at 12:44=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
> ...
> > > This behavior is particularly useful for work scheduling systems that
> > > need to track memory usage of worker processes/cgroups per-work-item.
> > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > opinions), these systems need to track the peak memory usage to compu=
te
> > > system/container fullness when binpacking workitems.
>
> Swap still has bad reps but there's nothing drastically worse about it th=
an
> page cache. ie. If you're under memory pressure, you get thrashing one wa=
y
> or another. If there's no swap, the system is just memlocking anon memory
> even when they are a lot colder than page cache, so I'm skeptical that no
> swap + mostly anon + kernel OOM kills is a good strategy in general
> especially given that the system behavior is not very predictable under O=
OM
> conditions.

The reason we need peak memory information is to let us schedule work in a =
way
that we generally avoid OOM conditions.
For the workloads I work on, we generally have very little in the
page-cache, since
the data isn't stored locally most of the time, but streamed from
other storage/database
systems. For those cases, demand-paging will cause large variations in
servicing time,
and we'd rather restart the process than have unpredictable latency.
The same is true for the batch/queue-work system I wrote this patch to supp=
ort.
We keep very little data on the local disk, so the page cache is
relatively small.


>
> > As mentioned down the email thread, I consider usefulness of peak value
> > rather limited. It is misleading when memory is reclaimed. But
> > fundamentally I do not oppose to unifying the write behavior to reset
> > values.
>
> The removal of resets was intentional. The problem was that it wasn't cle=
ar
> who owned those counters and there's no way of telling who reset what whe=
n.
> It was easy to accidentally end up with multiple entities that think they
> can get timed measurement by resetting.
>
> So, in general, I don't think this is a great idea. There are shortcoming=
s
> to how memory.peak behaves in that its meaningfulness quickly declines ov=
er
> time. This is expected and the rationale behind adding memory.peak, IIRC,
> was that it was difficult to tell the memory usage of a short-lived cgrou=
p.
>
> If we want to allow peak measurement of time periods, I wonder whether we
> could do something similar to pressure triggers - ie. let users register
> watchers so that each user can define their own watch periods. This is mo=
re
> involved but more useful and less error-inducing than adding reset to a
> single counter.

I appreciate the ownership issues with the current resetting interface
in the other locations.
However, this peak RSS data is not used by all that many applications
(as evidenced by
the fact that the memory.peak file was only added a bit over a year ago).
I think there are enough cases where ownership is enforced externally
that mirroring the
existing interface to cgroup2 is sufficient.

I do think a more stateful interface would be nice, but I don't know
whether I have enough
knowledge of memcg to implement that in a reasonable amount of time.

Ownership aside, I think being able to reset the high watermark of a
process makes it
significantly more useful. Creating new cgroups and moving processes
around is significantly
heavier-weight.

Thanks,

>
> Johannes, what do you think?
>
> Thanks.
>
> --
> tejun



--=20
David Finkel
Senior Principal Software Engineer, Core Services

