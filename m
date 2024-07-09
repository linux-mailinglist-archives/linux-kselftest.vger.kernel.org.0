Return-Path: <linux-kselftest+bounces-13415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4791F92C6CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 01:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1F6282346
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A7189F4E;
	Tue,  9 Jul 2024 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AupPn7Sw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0F1474BE;
	Tue,  9 Jul 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569345; cv=none; b=bBHyYh1HKiVHNpIVxIgo8P16LI0pRAo0JFK9jBZfKhNjtOR2EE/+HBMuNt0V3m/CJluLwKg89xjX0vpm9sgC7q6Y9+nWi6jZShwwNPsbhBjZJtBAyNZk6xfX8MdMOFgB6Pk1sFoplWHIob3lDRhl8mYcEN/nQSMAIjVYjruYmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569345; c=relaxed/simple;
	bh=/dIqGJHEmP9PlKvKZMoDzFDoLSE4bSZOgbfmkLTxb9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meVTcZ73v10aEEpoeC5HcFY5AhI7gVdjMYa3fjFSy6TeDA6HMUzkVXjCwKN06Ym6seZtFbb6sHlXy2LusTqrT3O5C1PMXkPfgyNxjCRKqikI7M3fC3ZsP5htuDiA4isYqFX65DUNRo8e6EF+mkaENy1xSMug0ehHKEUoJ/ZvARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AupPn7Sw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c7fa0c9a8cso3424987a91.1;
        Tue, 09 Jul 2024 16:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720569343; x=1721174143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fZNeIHzdmh4+7HMyMU6YPTZUzH6nI9xv/tzO/kNJwE=;
        b=AupPn7SwhgQbttJI5rdT2qsRlZLp1iDihHJ7v3J+osaGsnC3bR84RYACTqv897Yk/r
         eKXrpk3CZoRcHkpVjUkffu/JrbYarO7Nufsaq9if2lhuUFPC17e4arbf06U78vyTFlnq
         Pzwor2bMdNEbLGyltYveWJ1Eq+MKo3AbxMOZV6YK5tleelHl/RV01ZdgcYFDnR+ivAHm
         kC9As2Es+1vrhOt82ynrCOCFANxYlIEeby0mrrVNepgaLd+Xte2pBH2dpecOER/FcUBg
         cazo326ytsR2cNhAKDN69mokfIBIxcFaSH+mIn/kx4ntVQqqHIpCgrXBCO0if7apNHof
         05qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720569343; x=1721174143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fZNeIHzdmh4+7HMyMU6YPTZUzH6nI9xv/tzO/kNJwE=;
        b=B4tPFYnQdrWKeEoAnP9awYNzriusquoRIHuZYAiMd+RES4t/qlfBKm8cws0P+lJege
         tnYGlu5/jFqjHqXAXnVIKAqkCkeh1/7jpOXVNwnq7YNI0ePCOQLSecuxxm3NG/vTFd8O
         Ina5vryrrgTdv4YCQIprcu4okHeADwWQa3CyepJJ9JtMmiBd8vdgaEryL2woIUhzv6M3
         HoAro/9UU2sUg6FXztOLG6JZr38KthzKjvTd03KlhJsV/dZd7KYAwfF1asHyU/FM4hFq
         hflVxtNtPWEhTTF/InpabdVr/8HCXgzp1IbgbXLf7NlEVSNYfvS0aAhUV3Jvc/P/UBN5
         BJPw==
X-Forwarded-Encrypted: i=1; AJvYcCUgo90JjdkuPTJ+ABxTqlkN5EUX5zdMQjLyYcmQz8kQDONPnXli2pEkP8ovlB+mxNGiXNbOi25XugPOXucO3C8ix1/JoDH5CwwkHx7o9tKjhQDvKQWQxKdiLytWVPW3Xrv82ShXx8++F9ZXY+rCJK9ByE7CAzK28WV8lSI1+5yFALZAgl2jAHySwfrizTnFvl1fkzuWklkJtjCrS+Af6aKiDRxhJA==
X-Gm-Message-State: AOJu0Yz/XaQvcGY4O6ynYNeR4QlhIAMp2CISCAWv30Mvv+vRjLz9yqGf
	8qfa0fgJlWyoRc/ynMGBeGgJ4UwaNCpIHR/o6S95Fhb2hUrDsvkHBQ4nST0CoAE5GdEYBj0DVpd
	Khr7b071HvniG2478CAFeNxz4BNoSbSti
X-Google-Smtp-Source: AGHT+IFgnerXF1rpKy3OWibi3DTuoiRwqzNxvbuHariwFHiHe/NkICs34kLZl5BrQEUA9GjjlMF/qCNX2tVUb8pBojo=
X-Received: by 2002:a17:90a:7e18:b0:2c9:888a:7a7b with SMTP id
 98e67ed59e1d1-2ca35c735d4mr3150623a91.25.1720569343014; Tue, 09 Jul 2024
 16:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709005142.4044530-1-liaochang1@huawei.com> <20240709005142.4044530-2-liaochang1@huawei.com>
In-Reply-To: <20240709005142.4044530-2-liaochang1@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 16:55:31 -0700
Message-ID: <CAEf4BzYDrVJXnAruko-h5-oXCGuZ92x4KnY-2cD=XXBp1U_kBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] uprobes: Optimize the return_instance related routines
To: Liao Chang <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, mykolal@fb.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:00=E2=80=AFPM Liao Chang <liaochang1@huawei.com> w=
rote:
>
> Reduce the runtime overhead for struct return_instance data managed by
> uretprobe. This patch replaces the dynamic allocation with statically
> allocated array, leverage two facts that are limited nesting depth of
> uretprobe (max 64) and the function call style of return_instance usage
> (create at entry, free at exit).
>
> This patch has been tested on Kunpeng916 (Hi1616), 4 NUMA nodes, 64
> cores @ 2.4GHz. Redis benchmarks show a throughput gain by 2% for Redis
> GET and SET commands:
>
> ------------------------------------------------------------------
> Test case       | No uretprobes | uretprobes     | uretprobes
>                 |               | (current)      | (optimized)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Redis SET (RPS) | 47025         | 40619 (-13.6%) | 41529 (-11.6%)
> ------------------------------------------------------------------
> Redis GET (RPS) | 46715         | 41426 (-11.3%) | 42306 (-9.4%)
> ------------------------------------------------------------------
>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  include/linux/uprobes.h |  10 ++-
>  kernel/events/uprobes.c | 162 ++++++++++++++++++++++++----------------
>  2 files changed, 105 insertions(+), 67 deletions(-)
>

[...]

> +static void cleanup_return_instances(struct uprobe_task *utask, bool cha=
ined,
> +                                    struct pt_regs *regs)
> +{
> +       struct return_frame *frame =3D &utask->frame;
> +       struct return_instance *ri =3D frame->return_instance;
> +       enum rp_check ctx =3D chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CA=
LL;
> +
> +       while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
> +               ri =3D next_ret_instance(frame, ri);
> +               utask->depth--;
> +       }
> +       frame->return_instance =3D ri;
> +}
> +
> +static struct return_instance *alloc_return_instance(struct uprobe_task =
*task)
> +{
> +       struct return_frame *frame =3D &task->frame;
> +
> +       if (!frame->vaddr) {
> +               frame->vaddr =3D kcalloc(MAX_URETPROBE_DEPTH,
> +                               sizeof(struct return_instance), GFP_KERNE=
L);

Are you just pre-allocating MAX_URETPROBE_DEPTH instances always?
I.e., even if we need just one (because there is no recursion), you'd
still waste memory for all 64 ones?

That seems rather wasteful.

Have you considered using objpool for fast reuse across multiple CPUs?
Check lib/objpool.c.

> +               if (!frame->vaddr)
> +                       return NULL;
> +       }
> +
> +       if (!frame->return_instance) {
> +               frame->return_instance =3D frame->vaddr;
> +               return frame->return_instance;
> +       }
> +
> +       return ++frame->return_instance;
> +}
> +
> +static inline bool return_frame_empty(struct uprobe_task *task)
> +{
> +       return !task->frame.return_instance;
>  }
>
>  /*

[...]

