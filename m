Return-Path: <linux-kselftest+bounces-14881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7BA9498E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EE428525A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B462149DE2;
	Tue,  6 Aug 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="gs72Azaw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF984E0A
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975404; cv=none; b=WwiKPdDqDFMPoqqy+8r+MvoNTI6gO10GLttA3lS+cIwIGiQ83yyR33VPH7uu7O3cuY1uaJ2erudOf+TwuhUS8y5SMhB+j4eeclnuVeudWkksnGDPJF8hlQdNoXBBrwfdJqNVSqoEEC7wjI8MOvV1PvZGpMsnwdDZN936fm6bERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975404; c=relaxed/simple;
	bh=wmNIyw9GfP97kFsvXGRb22gPsp3TKcMyPea6l0UwV1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6Uuqq6wXS3cGcA/7/l1OsikOOmdK0XoeqLGRt9YMwF+WVM5Obkav5fU3AWDfy2/Ly9vpkSwjWVhcnf9a+ilifrZk2kFYJxom3cQhVKegzAqFHGe7tI+hsOIbhVpoaW7J7eKD4WPla7qlfgoRRafvdoh0vZsIZRoDRqXTsIOD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=gs72Azaw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so658962a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2024 13:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722975402; x=1723580202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7ljGM0irjWendNnux5k7jsBLUadWXI+HcIMyBsdx1A=;
        b=gs72AzawManMBskwkstP4Jyz44cru3nxgOL7EmPDQUQskYWC/xptsYs8mplje18ZMs
         ekZLxM87dTcs24SRMAxoVE76UAgwkK2dHnjvAlOLz3ABKlO7qGePEWDOsl256JOpESDT
         Fit6qdxi0TQ5jx/Iv6Z730nTv+NU4ogkMUmmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722975402; x=1723580202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7ljGM0irjWendNnux5k7jsBLUadWXI+HcIMyBsdx1A=;
        b=JGA++vtxJWGqtDqxjy6jo4HUk3dTPQ60dRv4lam4vkH1dpKkperHub1Yn+A48L1iRW
         Px7kJZcjpA76U/73BCEvsQov8Vqa2R7XktpRBmtkA2C9yTSFZCVB6NBIwa3y5bzTX2W9
         FEzobx1ynEh6GOnOg5pKOEdUC9Puu5+MwD0AZz9PJxSA+yJpy5Iia0rlWYDH2FLh8LI6
         ZLOKv/8U0UuK6VzBJWoXgDt/vLz4HaJhCeGPKQHNPqJhoHoNe71TBoYXPQUR9g30sJF5
         yjBD8ZzdVt1arsjJVN2kg8v9ArPSyxnRAnaOH4dkDJcZ8OZ+Vs4TO8jnmSHt+PaAObwg
         f2zw==
X-Forwarded-Encrypted: i=1; AJvYcCWod5SgK/oKhJJiwEjFKRc4615ZbgNSsY4lEkjx5k6KALP1iaSNgRe6dWNw1ve4lj9e5F8f9XL8xjjYquzrm6GYv2lgc7rKoS+foYQeYqfR
X-Gm-Message-State: AOJu0YzQm9Xy4XbSQQ1KNmNAKoGUpRhD4PtukMPs2rxMTbJ48sfLKQSE
	y3p1MBBTlyxxue8if8yJ6S3mguG4GdytEBeGFMJwrWh+z8l7H2mF5VmjCB6U+LkYuOVAcSEtYXe
	Vywx4bP9unBkhOWyYP09DDrFeL929ZVh0jvazfA==
X-Google-Smtp-Source: AGHT+IHv0AN++1OdFYFThfaFBPC/QvFLeShPR/7012JBfWJkUQxlr8Fi2xoKQeWo0FlTjWcTIHRMaayWlN1DRcfdEII=
X-Received: by 2002:a05:6a20:438d:b0:1c4:c160:2859 with SMTP id
 adf61e73a8af0-1c6995d4947mr23275824637.31.1722975401973; Tue, 06 Aug 2024
 13:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730231304.761942-1-davidf@vimeo.com>
In-Reply-To: <20240730231304.761942-1-davidf@vimeo.com>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 6 Aug 2024 16:16:30 -0400
Message-ID: <CAFUnj5Nq_UwZUy9+i-Mp+TDghQWUX7MHpmh8uDTH790HAH2ZNA@mail.gmail.com>
Subject: Re: [PATCH v7] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:13=E2=80=AFPM David Finkel <davidf@vimeo.com> wro=
te:
>
> This revision only updates the tests from the previous revision[1], and
> integrates an Acked-by[2] and a Reviewed-By[3] into the first commit
> message.
>
>
> Documentation/admin-guide/cgroup-v2.rst          |  22 ++-
> include/linux/cgroup-defs.h                      |   5 +
> include/linux/cgroup.h                           |   3 +
> include/linux/memcontrol.h                       |   5 +
> include/linux/page_counter.h                     |  11 +-
> kernel/cgroup/cgroup-internal.h                  |   2 +
> kernel/cgroup/cgroup.c                           |   7 +
> mm/memcontrol.c                                  | 116 +++++++++++++--
> mm/page_counter.c                                |  30 +++-
> tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
> tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
> tools/testing/selftests/cgroup/test_memcontrol.c | 264 ++++++++++++++++++=
++++++++++++++-
> 12 files changed, 454 insertions(+), 35 deletions(-)
>
> [1]: https://lore.kernel.org/cgroups/20240729143743.34236-1-davidf@vimeo.=
com/T/
> [2]: https://lore.kernel.org/cgroups/20240729143743.34236-1-davidf@vimeo.=
com/T/#m807225dd0944b0bf78419639272bf6602fe053fc
> [3]: https://lore.kernel.org/cgroups/20240729143743.34236-1-davidf@vimeo.=
com/T/#meac510a72b4a282fe1e5edec3323c2204d46cf11
>
>
> Thank you all for the support and reviews so far!
>
> David Finkel
> Senior Principal Software Engineer
> Vimeo Inc.
>
>
>

Tejun or Andrew,

This change seems to have stalled a bit.
Are there any further changes necessary to get this patch merged into
a staging branch so it's ready for 6.12?

Thanks,
--=20
David Finkel
Senior Principal Software Engineer, Core Services

