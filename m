Return-Path: <linux-kselftest+bounces-3877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328E844874
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D771C23703
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E53FB0D;
	Wed, 31 Jan 2024 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ulu6nsF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA203FB06
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731813; cv=none; b=jJNcdii/NTTLAuv/sWQHP2FPsn2d7AnOZdNDoN9nsHocQ2gXhgB5TJWwv40fTGyhqz5UhQAiO+0++d41pyazE2LRHSLWRXcsLmIEfYB0ONaDSnIyC2th8SLKUhwkJmmLg4rdswNAfO+lEmZNOvKSxYZSjPf4XTz1WuAJaeT4WvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731813; c=relaxed/simple;
	bh=lpCcRtIMEusW8xCxbSlET/LKnKX6VC4CkqZ78XCKqLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAvMUS8aIXfYzu9nv8+3BO6zf6nZ+7TntbxnxQA7Rbr7CPxyUdoDgnIfgwU/LJU57cmPb2ehRwnQy7aODtJKCcTtlC/mDOfWypQuzs5ktz+BNGwBzxSfHJ/vH/tIUfwjs+UMlnuOBTNwV0Ux/AiRsz3VivkrkearL8j1/K63sOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ulu6nsF+; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46b3ff62223so860493137.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706731809; x=1707336609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP2UpA68s4FVB2SLFzwDpR8KmTA6wh7vb51mUtrgsWI=;
        b=Ulu6nsF+x15rnzkGsJ5EAb48hm9uQBM3dUFLR8RybkON63xShQn3RC2yL/yKqEnATX
         zN5oAQpFKuzEK3WRPMjHqESWxAdOGDFFK0IpLiz5yxXu7rNa8KOqVoMoFhgnXKGN8Rgv
         gU8bRbGTJZvNZFWob95hdJIRIBEdt6nIvwj3argf2iHp5obKpgwe4knnsLme3m/uF0zA
         LvVFoq1HEY88hcU/CmiSKo6YtuMP9EHXHL5j8ueUmw3YBnjMpcwIfpn8pyS+KV6gFweA
         N+jvjLMpTOtYhdDMqkAdLlXhg3x9LzytOM58Jo5/GoNaKk+Q5f2FZgZHhVtk2naNylRz
         gbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731809; x=1707336609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EP2UpA68s4FVB2SLFzwDpR8KmTA6wh7vb51mUtrgsWI=;
        b=JRaf8JIV24DI4PspGfT9f/AQ2kwvOYzB6M3IpcmiM8FlU8req4eY//AXH+HdxXt7u3
         B0VAyiLdMkYnlm/LQUm+20G77pYk5XxUe2SkJG7lkywRwopev1zO3aPzIgd+cVbH37aP
         2tM0MW+62oiYwFnKAlEY2UZ2M5sdxzK3QyOy8ymHOC3I981O7S5Ezt/Zzi/CzweJm55v
         6hqcPsDHmy2uku47yIAj6Lgf1isr5meltD+Vh2SsyY7v3t4TMCXAAhWEDKi5rk5ZxYok
         DTLHegbhq2oNzXnwZTiIXySWKcvZAp4GTJ8STi7jd/KHNBe59NDm6jiPdSB2yOrqMPL4
         cXUA==
X-Gm-Message-State: AOJu0YyYMB9mO7jcVAvmPBTtTNe305bzmZ6+CrMacwfB+ri/QcW4YfMH
	VnNTNE8lb3pDcS3pRgGCH93ZL7Hk9juYD9uciu8uc5O9DVGftuiigFdR8Pnw6HdfAlqywhZtcYr
	oLia+vz0AXZC5G2AOSzrfQwoencMkbpf745MX
X-Google-Smtp-Source: AGHT+IEHrmQNFCwiPtCaTM7Xr/qRIRFmBmSeZWyeY0h9tjlBancDW+n2wS1a/IV1UHv+knjDQVkFCXSWellZNLr5WQ8=
X-Received: by 2002:a67:e3b0:0:b0:46c:9cac:4147 with SMTP id
 j16-20020a67e3b0000000b0046c9cac4147mr1076516vsm.17.1706731809168; Wed, 31
 Jan 2024 12:10:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131141858.1149719-1-elver@google.com> <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
In-Reply-To: <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
From: Marco Elver <elver@google.com>
Date: Wed, 31 Jan 2024 21:09:30 +0100
Message-ID: <CANpmjNOrPRwyoMdcBEKz5JJWo9a-C+gcNg+oQ7ZjUfOSCype1w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow paths
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 20:52, Martin KaFai Lau <martin.lau@linux.dev> wrote=
:
>
> On 1/31/24 6:18 AM, Marco Elver wrote:
> > To allow the compiler to inline the bpf_local_storage_lookup() fast-
> > path, factor it out by making bpf_local_storage_lookup() a static inlin=
e
> > function and move the slow-path to bpf_local_storage_lookup_slowpath().
> >
> > Base on results from './benchs/run_bench_local_storage.sh' this produce=
s
> > improvements in throughput and latency in the majority of cases:
> >
> > | Hashmap Control
> > | =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > | num keys: 10
> > |  hashmap (control) sequential get:
> > |                              <before>                | <after>
> > |   hits throughput:           13.895 =C2=B1 0.024 M ops/s  | 14.022 =
=C2=B1 0.095 M ops/s       (+0.9%)
> > |   hits latency:              71.968 ns/op            | 71.318 ns/op  =
       (-0.9%)
> > |   important_hits throughput: 13.895 =C2=B1 0.024 M ops/s  | 14.022 =
=C2=B1 0.095 M ops/s       (+0.9%)
> > |
> > | num keys: 1000
> > |  hashmap (control) sequential get:
> > |                              <before>                | <after>
> > |   hits throughput:           11.793 =C2=B1 0.018 M ops/s  | 11.645 =
=C2=B1 0.370 M ops/s       (-1.3%)
> > |   hits latency:              84.794 ns/op            | 85.874 ns/op  =
       (+1.3%)
> > |   important_hits throughput: 11.793 =C2=B1 0.018 M ops/s  | 11.645 =
=C2=B1 0.370 M ops/s       (-1.3%)
> > |
> > | num keys: 10000
> > |  hashmap (control) sequential get:
> > |                              <before>                | <after>
> > |   hits throughput:           7.113 =C2=B1 0.012 M ops/s   | 7.037 =C2=
=B1 0.051 M ops/s        (-1.1%)
> > |   hits latency:              140.581 ns/op           | 142.113 ns/op =
               (+1.1%)
> > |   important_hits throughput: 7.113 =C2=B1 0.012 M ops/s   | 7.037 =C2=
=B1 0.051 M ops/s        (-1.1%)
>
> My understanding is the change in this patch should not affect the hashma=
p
> control result, so the above +/- ~1% change could be mostly noise.

Yes, I think they are noise.

> > |
> > | num keys: 100000
> > |  hashmap (control) sequential get:
> > |                              <before>                | <after>
> > |   hits throughput:           4.793 =C2=B1 0.034 M ops/s   | 4.990 =C2=
=B1 0.025 M ops/s        (+4.1%)
> > |   hits latency:              208.623 ns/op           | 200.401 ns/op =
               (-3.9%)
> > |   important_hits throughput: 4.793 =C2=B1 0.034 M ops/s   | 4.990 =C2=
=B1 0.025 M ops/s        (+4.1%)
> > |
> > | num keys: 4194304
> > |  hashmap (control) sequential get:
> > |                              <before>                | <after>
> > |   hits throughput:           2.088 =C2=B1 0.008 M ops/s   | 2.962 =C2=
=B1 0.004 M ops/s        (+41.9%)
> > |   hits latency:              478.851 ns/op           | 337.648 ns/op =
               (-29.5%)
> > |   important_hits throughput: 2.088 =C2=B1 0.008 M ops/s   | 2.962 =C2=
=B1 0.004 M ops/s        (+41.9%)
>
> The last one has a big difference. Did you run it a couple of times witho=
ut the
> change and check if the result was consistent ?

Based on what you say above this might be noise. I will rerun a few
times (and also rebased against the latest v6.8-rc).

> > |
> > | Local Storage
> > | =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > | num_maps: 1
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           32.598 =C2=B1 0.008 M ops/s  | 38.480 =
=C2=B1 0.054 M ops/s       (+18.0%)
> > |   hits latency:              30.676 ns/op            | 25.988 ns/op  =
       (-15.3%)
> > |   important_hits throughput: 32.598 =C2=B1 0.008 M ops/s  | 38.480 =
=C2=B1 0.054 M ops/s       (+18.0%)
> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           36.963 =C2=B1 0.045 M ops/s  | 43.847 =
=C2=B1 0.037 M ops/s       (+18.6%)
> > |   hits latency:              27.054 ns/op            | 22.807 ns/op  =
       (-15.7%)
> > |   important_hits throughput: 36.963 =C2=B1 0.045 M ops/s  | 43.847 =
=C2=B1 0.037 M ops/s       (+18.6%)
> > |
> > | num_maps: 10
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           32.078 =C2=B1 0.004 M ops/s  | 37.813 =
=C2=B1 0.020 M ops/s       (+17.9%)
> > |   hits latency:              31.174 ns/op            | 26.446 ns/op  =
       (-15.2%)
> > |   important_hits throughput: 3.208 =C2=B1 0.000 M ops/s   | 3.781 =C2=
=B1 0.002 M ops/s        (+17.9%)
> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           34.564 =C2=B1 0.011 M ops/s  | 40.082 =
=C2=B1 0.037 M ops/s       (+16.0%)
> > |   hits latency:              28.932 ns/op            | 24.949 ns/op  =
       (-13.8%)
> > |   important_hits throughput: 12.344 =C2=B1 0.004 M ops/s  | 14.315 =
=C2=B1 0.013 M ops/s       (+16.0%)
> > |
> > | num_maps: 16
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           32.493 =C2=B1 0.023 M ops/s  | 38.147 =
=C2=B1 0.029 M ops/s       (+17.4%)
> > |   hits latency:              30.776 ns/op            | 26.215 ns/op  =
       (-14.8%)
> > |   important_hits throughput: 2.031 =C2=B1 0.001 M ops/s   | 2.384 =C2=
=B1 0.002 M ops/s        (+17.4%)
> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           34.380 =C2=B1 0.521 M ops/s  | 41.605 =
=C2=B1 0.095 M ops/s       (+21.0%)
> > |   hits latency:              29.087 ns/op            | 24.035 ns/op  =
       (-17.4%)
> > |   important_hits throughput: 10.939 =C2=B1 0.166 M ops/s  | 13.238 =
=C2=B1 0.030 M ops/s       (+21.0%)
> > |
> > | num_maps: 17
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           28.748 =C2=B1 0.028 M ops/s  | 32.248 =
=C2=B1 0.080 M ops/s       (+12.2%)
> > |   hits latency:              34.785 ns/op            | 31.009 ns/op  =
       (-10.9%)
> > |   important_hits throughput: 1.693 =C2=B1 0.002 M ops/s   | 1.899 =C2=
=B1 0.005 M ops/s        (+12.2%)
> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           31.313 =C2=B1 0.030 M ops/s  | 35.911 =
=C2=B1 0.020 M ops/s       (+14.7%)
> > |   hits latency:              31.936 ns/op            | 27.847 ns/op  =
       (-12.8%)
> > |   important_hits throughput: 9.533 =C2=B1 0.009 M ops/s   | 10.933 =
=C2=B1 0.006 M ops/s       (+14.7%)
> > |
> > | num_maps: 24
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           18.475 =C2=B1 0.027 M ops/s  | 19.000 =
=C2=B1 0.006 M ops/s       (+2.8%)
> > |   hits latency:              54.127 ns/op            | 52.632 ns/op  =
       (-2.8%)
> > |   important_hits throughput: 0.770 =C2=B1 0.001 M ops/s   | 0.792 =C2=
=B1 0.000 M ops/s        (+2.9%)
> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           21.361 =C2=B1 0.028 M ops/s  | 22.388 =
=C2=B1 0.099 M ops/s       (+4.8%)
> > |   hits latency:              46.814 ns/op            | 44.667 ns/op  =
       (-4.6%)
> > |   important_hits throughput: 6.009 =C2=B1 0.008 M ops/s   | 6.298 =C2=
=B1 0.028 M ops/s        (+4.8%)
> > |
> > | num_maps: 32
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           14.220 =C2=B1 0.006 M ops/s  | 14.168 =
=C2=B1 0.020 M ops/s       (-0.4%)
> > |   hits latency:              70.323 ns/op            | 70.580 ns/op  =
       (+0.4%)
> > |   important_hits throughput: 0.445 =C2=B1 0.000 M ops/s   | 0.443 =C2=
=B1 0.001 M ops/s        (-0.4%)
> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           17.250 =C2=B1 0.011 M ops/s  | 16.650 =
=C2=B1 0.021 M ops/s       (-3.5%)
> > |   hits latency:              57.971 ns/op            | 60.061 ns/op  =
       (+3.6%)
> > |   important_hits throughput: 4.815 =C2=B1 0.003 M ops/s   | 4.647 =C2=
=B1 0.006 M ops/s        (-3.5%)
> > |
> > | num_maps: 100
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           5.212 =C2=B1 0.012 M ops/s   | 5.878 =C2=
=B1 0.004 M ops/s        (+12.8%)
> > |   hits latency:              191.877 ns/op           | 170.116 ns/op =
               (-11.3%)
> > |   important_hits throughput: 0.052 =C2=B1 0.000 M ops/s   | 0.059 =C2=
=B1 0.000 M ops/s        (+13.5%)
> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           6.521 =C2=B1 0.053 M ops/s   | 7.086 =C2=
=B1 0.010 M ops/s        (+8.7%)
> > |   hits latency:              153.343 ns/op           | 141.116 ns/op =
               (-8.0%)
> > |   important_hits throughput: 1.703 =C2=B1 0.014 M ops/s   | 1.851 =C2=
=B1 0.003 M ops/s        (+8.7%)
> > |
> > | num_maps: 1000
> > |  local_storage cache sequential  get:
> > |                              <before>                | <after>
> > |   hits throughput:           0.357 =C2=B1 0.005 M ops/s   | 0.325 =C2=
=B1 0.005 M ops/s        (-9.0%)
> > |   hits latency:              2803.738 ns/op          | 3076.923 ns/op=
               (+9.7%)
>
> Is it understood why the slow down here? The same goes for the "num_maps:=
 32"
> case above but not as bad as here.

num_maps:32 could be noise.

> > |   important_hits throughput: 0.000 =C2=B1 0.000 M ops/s   | 0.000 =C2=
=B1 0.000 M ops/s
>
> The important_hits is very little in this case?

It seems to be below 0.000M on the test machine.

> > |  local_storage cache interleaved get:
> > |                              <before>                | <after>
> > |   hits throughput:           0.434 =C2=B1 0.007 M ops/s   | 0.447 =C2=
=B1 0.007 M ops/s        (+3.0%)
> > |   hits latency:              2306.539 ns/op          | 2237.687 ns/op=
               (-3.0%)
> > |   important_hits throughput: 0.109 =C2=B1 0.002 M ops/s   | 0.112 =C2=
=B1 0.002 M ops/s        (+2.8%)
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >   include/linux/bpf_local_storage.h               | 17 ++++++++++++++++=
-
> >   kernel/bpf/bpf_local_storage.c                  | 14 ++++----------
> >   .../selftests/bpf/progs/cgrp_ls_recursion.c     |  2 +-
> >   .../selftests/bpf/progs/task_ls_recursion.c     |  2 +-
> >   4 files changed, 22 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loca=
l_storage.h
> > index 173ec7f43ed1..c8cecf7fff87 100644
> > --- a/include/linux/bpf_local_storage.h
> > +++ b/include/linux/bpf_local_storage.h
> > @@ -130,9 +130,24 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
> >                           bool bpf_ma);
> >
> >   struct bpf_local_storage_data *
> > +bpf_local_storage_lookup_slowpath(struct bpf_local_storage *local_stor=
age,
> > +                               struct bpf_local_storage_map *smap,
> > +                               bool cacheit_lockit);
> > +static inline struct bpf_local_storage_data *
> >   bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> >                        struct bpf_local_storage_map *smap,
> > -                      bool cacheit_lockit);
> > +                      bool cacheit_lockit)
> > +{
> > +     struct bpf_local_storage_data *sdata;
> > +
> > +     /* Fast path (cache hit) */
> > +     sdata =3D rcu_dereference_check(local_storage->cache[smap->cache_=
idx],
> > +                                   bpf_rcu_lock_held());
> > +     if (likely(sdata && rcu_access_pointer(sdata->smap) =3D=3D smap))
> > +             return sdata;
> > +
> > +     return bpf_local_storage_lookup_slowpath(local_storage, smap, cac=
heit_lockit);
> > +}
> >
> >   void bpf_local_storage_destroy(struct bpf_local_storage *local_storag=
e);
> >
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > index 146824cc9689..2ef782a1bd6f 100644
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -415,20 +415,14 @@ void bpf_selem_unlink(struct bpf_local_storage_el=
em *selem, bool reuse_now)
> >   }
> >
> >   /* If cacheit_lockit is false, this lookup function is lockless */
> > -struct bpf_local_storage_data *
> > -bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
> > -                      struct bpf_local_storage_map *smap,
> > -                      bool cacheit_lockit)
> > +noinline struct bpf_local_storage_data *
>
> Is noinline needed ?

Yes, so that this TU or LTO kernels do not inline the slowpath, which
would cause worse codegen in the caller.

> > +bpf_local_storage_lookup_slowpath(struct bpf_local_storage *local_stor=
age,
> > +                               struct bpf_local_storage_map *smap,
> > +                               bool cacheit_lockit)
> >   {
> >       struct bpf_local_storage_data *sdata;
> >       struct bpf_local_storage_elem *selem;
> >
> > -     /* Fast path (cache hit) */
> > -     sdata =3D rcu_dereference_check(local_storage->cache[smap->cache_=
idx],
> > -                                   bpf_rcu_lock_held());
> > -     if (sdata && rcu_access_pointer(sdata->smap) =3D=3D smap)
> > -             return sdata;
> > -
> >       /* Slow path (cache miss) */
> >       hlist_for_each_entry_rcu(selem, &local_storage->list, snode,
> >                                 rcu_read_lock_trace_held())
> > diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/to=
ols/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > index a043d8fefdac..9895087a9235 100644
> > --- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
> > @@ -21,7 +21,7 @@ struct {
> >       __type(value, long);
> >   } map_b SEC(".maps");
> >
> > -SEC("fentry/bpf_local_storage_lookup")
> > +SEC("fentry/bpf_local_storage_lookup_slowpath")
>
> The selftest is trying to catch recursion. The change here cannot test th=
e same
> thing because the slowpath will never be hit in the test_progs.  I don't =
have a
> better idea for now also.
>
> It has a conflict with the bpf-next tree also. Was the patch created agai=
nst an
> internal tree?

Base was v6.7. I will do a rebase and rerun benchmarks.

