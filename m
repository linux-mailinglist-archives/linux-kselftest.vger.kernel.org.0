Return-Path: <linux-kselftest+bounces-39412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A31B2E85E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 00:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDF23B00B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 22:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB412D979F;
	Wed, 20 Aug 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl4lgZFL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF12BE7B4;
	Wed, 20 Aug 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730454; cv=none; b=GGGvQrvuw28SOWYkv3kssEii58/61csq+NctZNDpDretb6HtgkN1+638eg3Tp98yl9mlFTUSqq8QusJm8l3MSj7ZgF1Xl26vVQtB6ISTVYRZjcprm+6Rj7nyc8obXXFgKgXwwKHZO7D0GVhI6WZ1c/4FV7ueawejpsGeP2Df0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730454; c=relaxed/simple;
	bh=nxwUi+vma0gxF8jaxzpDP96ejlHXfqlhgoCKUq98E+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cefHX90kP48RIkfLOofVXu8f3C9yWI37PLNwEmkbXTeoxTMc0/tAoWb5ks8qRAifLIQQAA1vA5cCbDpjzCkOch+BYIDrNVHYnBC1w7FTOwjHFkVHnTw5tXaGVHp8PBPKVSMJVgmgXSEcIiygUwFvi1qBb63pLDdR9ZUAIJ6Nb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl4lgZFL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458195495so2347255ad.2;
        Wed, 20 Aug 2025 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730452; x=1756335252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v+ZtPegRwXYIddqayc8WLX+z8QS5ISVjLMRUJjSTvY=;
        b=Gl4lgZFLd8UZJLLzdgsc7Lm9oSD9cB2Nq1TMfGgf0VYsDli+ioPZ9GePdnkzgxpYN+
         KQpPsTM24kviqo2lWZnnvw6djFl6914vsnZ6ibNjHJBv4K5+3JdF2bT9ebwBpuYvJ8DL
         luCJ7tM+otHos3/ZIYzOljeex3CCHEX7ta/ypp+cTQeDc81LF8br6x3jw9GqjUTPsdbW
         UarDWnCxU+XWoNq+9/UO/1pcq2UzJPSTJyt2K8OQzeLZ+zqDoIPq1iixoDf/kWjD42Hm
         q4n3c0uV0JmcYaSf4A3lO19QriqqGjc3HN8APeaXq6gijOHkdLlk47xRYUeTyF7so2Vt
         VEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730452; x=1756335252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+v+ZtPegRwXYIddqayc8WLX+z8QS5ISVjLMRUJjSTvY=;
        b=dJ8Z5rmLeq9ggBLEcslqPB2uRCdlMpp5ElgVE/XmzkWryyUuvWCTjTn4MFzM1MsY2N
         bcwvttNzcWLjw8rCmSBQnH5XQ+a0utu2a49FyKsuFYecWBEzXHaYzszisj0ItVG+JwTE
         OlJ7VYQYcIPhcUeRVTeZ9lzwnB1vahXN04GKflCUGgmNENyJFtIq6wIARMHuNCvnd+ck
         afasYG/oAZu9d/RN7mt80XnwBeLWjNUpdvYrqiiOjJOc4HG3+C6yAw8FBQAF6QLQcv47
         KlPaGfIIYyn/TNeOywicQx4CMcUJh6rBAyM4xBS6+pE1/kQ/hNajDovsFHtv+x2rRkLK
         01Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUdO2mwOfxkfgOmOoAafvQeQRk6sq2BC3pzaXsuf1/8BkSty5x/TUzgzMZ/7w69GgwMmBlcoQLmGcEelyOCpNVi@vger.kernel.org, AJvYcCUyFEWEHFs5mFaQHFlKgcrIrnYFUrkkHwCcwOKJW0krhvOBCPl/TWE4TVENUFKB0iNTKie9Bz3a@vger.kernel.org, AJvYcCWU1VBGOd42PwdN97lA1ZCiZAi+bCTj1x6T0MIAedFDfP6J7WqntDnCsg5dJR/c0CRDu4PgU1J/M2NmBHG2@vger.kernel.org, AJvYcCX++T3zdAyDA8fI0oqldnw+eyLsZcNE2nviMY8WXChY+iApo9WNkTIi2tIRW3E2ExBGvok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBmo9drmYq2F3dNnJxXEypGSQf7HQOjFbDELuHU1SDerAX853
	Xsv2d35qBYF1Qpkx6mtolb0E03eIkVaOIbTT3OCVgWG6HtXxZ0s8OhiFImTph0LvlVsplsaykgJ
	WwvO3OJp4VsSiWqC3e30uNq2oBdN9Pq4=
X-Gm-Gg: ASbGnctenCypYglXvIBLM9TjVQ/QyGKnCAEN2dHHw8LeWxn0lTqHAVke9h51LN2q2Fg
	GdR2ZnvAz6uxq5dRPi/xMC9ZyKysEWn8an2e8BkLMylW48yx+JkVGUhXE9NcQHWMV3kPhB+f4cG
	PWCsbEc57zMuPZGh/sjsZ/m4ak0zu1zrZllQ6dBNXDtAiWT6fE2dGNWqVfPGIOiG6rLrevl8slG
	asU/bgA7rOtUYpnxHwDUK9kdRpT1m1/80cCQowSKfDc
X-Google-Smtp-Source: AGHT+IHsYq1/G3bkWo2LTB+Wjq6BjQc3MS0ahLPsXURmjYsCiKDmAvwNrGYkktwC5RFWrRVV25fqel2mh6B7rbrx6mk=
X-Received: by 2002:a17:902:f68b:b0:240:2145:e51f with SMTP id
 d9443c01a7336-245febe11dcmr6286575ad.3.1755730452431; Wed, 20 Aug 2025
 15:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819033956.59164-1-dongml2@chinatelecom.cn> <20250819033956.59164-4-dongml2@chinatelecom.cn>
In-Reply-To: <20250819033956.59164-4-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 15:53:56 -0700
X-Gm-Features: Ac12FXx-fO5PKvBgzD_sLr5b2q6BW5ewlWVsvn9PgVglGjlHt1qy_PlT4iHOnWc
Message-ID: <CAEf4BzZOC6Zyo9sikPJH+0Xz=aCbx=dBM_RksYZMaZM4ndR+OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add benchmark testing for kprobe-multi-all
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 8:40=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, the benchmark for kprobe-multi is single, which means there is
> only 1 function is hooked during testing. Add the testing
> "kprobe-multi-all", which will hook all the kernel functions during
> the benchmark. And the "kretprobe-multi-all" is added too.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/testing/selftests/bpf/bench.c           |  4 ++
>  .../selftests/bpf/benchs/bench_trigger.c      | 54 +++++++++++++++++++
>  .../selftests/bpf/benchs/run_bench_trigger.sh |  4 +-
>  .../selftests/bpf/progs/trigger_bench.c       | 12 +++++
>  tools/testing/selftests/bpf/trace_helpers.c   |  3 ++
>  5 files changed, 75 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index ddd73d06a1eb..29dbf937818a 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -510,6 +510,8 @@ extern const struct bench bench_trig_kretprobe;
>  extern const struct bench bench_trig_kprobe_multi;
>  extern const struct bench bench_trig_kretprobe_multi;
>  extern const struct bench bench_trig_fentry;
> +extern const struct bench bench_trig_kprobe_multi_all;
> +extern const struct bench bench_trig_kretprobe_multi_all;
>  extern const struct bench bench_trig_fexit;
>  extern const struct bench bench_trig_fmodret;
>  extern const struct bench bench_trig_tp;
> @@ -578,6 +580,8 @@ static const struct bench *benchs[] =3D {
>         &bench_trig_kprobe_multi,
>         &bench_trig_kretprobe_multi,
>         &bench_trig_fentry,
> +       &bench_trig_kprobe_multi_all,
> +       &bench_trig_kretprobe_multi_all,
>         &bench_trig_fexit,
>         &bench_trig_fmodret,
>         &bench_trig_tp,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 82327657846e..c6634a64a7c0 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -226,6 +226,58 @@ static void trigger_fentry_setup(void)
>         attach_bpf(ctx.skel->progs.bench_trigger_fentry);
>  }
>
> +static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
> +{
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       char **syms =3D NULL;
> +       size_t cnt =3D 0;
> +
> +       if (bpf_get_ksyms(&syms, &cnt, true)) {
> +               printf("failed to get ksyms\n");

we seem to be using fprintf(stderr, "...") for emitting errors like
this (at least in some benchmarks, and it makes sense to me). Do the
same?

> +               exit(1);
> +       }
> +
> +       printf("found %zu ksyms\n", cnt);

stray debug output?

> +       opts.syms =3D (const char **) syms;
> +       opts.cnt =3D cnt;
> +       opts.retprobe =3D kretprobe;
> +       /* attach empty to all the kernel functions except bpf_get_numa_n=
ode_id. */
> +       if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {
> +               printf("failed to attach bpf_program__attach_kprobe_multi=
_opts to all\n");
> +               exit(1);
> +       }
> +}
> +

[...]

