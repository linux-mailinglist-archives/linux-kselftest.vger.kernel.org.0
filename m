Return-Path: <linux-kselftest+bounces-1152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F5805952
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39C71F21793
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0B60BAB;
	Tue,  5 Dec 2023 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="c9sCvN1V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7D19B
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 08:00:59 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce52d796d2so2111954b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1701792059; x=1702396859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlx3FgdhGHDUnh3L6/3hGq4qNfTS6+do/JBa+IYdpms=;
        b=c9sCvN1VBFYYxeKPaoFf5jzEUVwrhxwQYsy53sfJvM8hX5uOV9sJnra9OS479u/ysk
         N300Dvzzh7prqRsXjqLNisV82OBOqm33SGkRPMs4BZx8krF7z/mnTam5fxwKCh+8l/Nk
         qs6xQAgXUrHfqbA/FQZLTRY6sSzt541OrKAuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792059; x=1702396859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlx3FgdhGHDUnh3L6/3hGq4qNfTS6+do/JBa+IYdpms=;
        b=PYb0Ubua85/ZeP1e/nMm6r9q4KYxiYSD1YxJnv+X6ZZL3nP4XJ6pmPgYZvPV0woOd3
         uHeRsZq5YuPwSfHjKzexLvxVZP3IWKYmRsFOyWQKGGlZg+P0LrXOxw66kR5V5It9BfD4
         HS7K7aQw8QFWtp+NfZCbAoY031NiY6NX2bFinjkbhQ3nZ/fgiyKLnfLmGA1NHkzHpJQw
         x5ptc7T557a9RjXv4mdg1+K0XbARf9FlB8QuWLGYuJBT5qyCju+oHpBAEcYmiDDOv6Bf
         aJISxebBb3xcnFQEJVATKAmkoQTXUVl2iXH2kFsk35ukfDASL14sNF97T2Opfb4YsswE
         85kg==
X-Gm-Message-State: AOJu0YxiOkrKouzjUlG+AKehslviVqbewf416WO3Nzf2aQXx4bRqRm3f
	QnJi2djEk/f/RMEbjZNiNuSbsq4EvXJzIWkH5Wx7hA==
X-Google-Smtp-Source: AGHT+IFecjzlwZCWC9hGQmND+h9du15cUgm27Fh3OgcOXx0irs/362chWEHXRwdyodfBRyRJkY6F7AS9A/nDP477DRs=
X-Received: by 2002:a05:6a00:2d89:b0:6cd:e8c3:f733 with SMTP id
 fb9-20020a056a002d8900b006cde8c3f733mr1974241pfb.3.1701792058636; Tue, 05 Dec
 2023 08:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204194156.2411672-1-davidf@vimeo.com> <ZW7oXalrpQWdWZNJ@tiehlicka>
In-Reply-To: <ZW7oXalrpQWdWZNJ@tiehlicka>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 5 Dec 2023 11:00:47 -0500
Message-ID: <CAFUnj5PqZ5zybYJ4uCiv-8cfdyg3d9NmzMjy=cYB+DkRNEiJug@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 4:07=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:

> > This behavior is particularly useful for work scheduling systems that
> > need to track memory usage of worker processes/cgroups per-work-item.
> > Since memory can't be squeezed like CPU can (the OOM-killer has
> > opinions), these systems need to track the peak memory usage to compute
> > system/container fullness when binpacking workitems.
>
> I do not understand the OOM-killer reference here but I do understand
> that your worker reuses a cgroup and you want a peak memory consumption
> of a single run to better profile/configure the memcg configuration for
> the specific worker type. Correct?

To a certain extent, yes.
At the moment, we're only using the inner memcg cgroups for
accounting/profiling, and using a
larger (k8s container) cgroup for enforcement.

The OOM-killer is involved because we're not configuring any memory limits =
on
these individual "worker" cgroups, so we need to provision for
multiple workloads using
their peak memory at the same time to minimize OOM-killing.

In case you're curious, this is the job/queue-work scheduling system
we wrote in-house
called Quickset that's mentioned in this blog post about our new
transcoder system:
https://medium.com/vimeo-engineering-blog/riding-the-dragon-e328a3dfd39d

>
> > Signed-off-by: David Finkel <davidf@vimeo.com>
>
> Makes sense to me
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!

Thank you!

--=20
David Finkel
Senior Principal Software Engineer, Core Services

