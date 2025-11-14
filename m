Return-Path: <linux-kselftest+bounces-45674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2BC5F443
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 21:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE394202E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A32FB09B;
	Fri, 14 Nov 2025 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QliCtM4G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF926FD9A
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763153192; cv=none; b=f4oF9xH5gAIkpXYPuoQ6UaAqauT1JCjyLSwCEVk7XT9Y52ScmrX27VQ8ZD0sGYeGK9jSjoB17Y5l3eSQLi96gQgpPnCDtci8L0xG9ihXyoU8mGKETsOLGSUbs3Lboi3sj6/9karFLSRgTZ3kbQI7YUCIh7UYZoDbSesOiblwM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763153192; c=relaxed/simple;
	bh=fkJyLxM6G311HUbnd0uOXkIFlsLw30lols6Y8zCLca0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDebC4gO4+jhJnXxuW578qMgfOqb//LXyBKQ8kn7tjwLCXKNyATw0SnxxWcPjGX9ztwNTESxYRuOZjZBxLaR5D4Tn4/DTKBANpF3KJM5VHnIqyHaorSUA9ioPTTCsAYWu4597LKAQt7tvi61YauAm/+ldbyQgGI8DIsHLfI+4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QliCtM4G; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso2118254a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 12:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763153188; x=1763757988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R91BPIHvF+PMEK++tWfFQzcocSH9XXfZoUO7yz1bj9s=;
        b=QliCtM4G0DUk2ndcXx/ZXyACb180hys0FWHgMlEg2O8SkbPt67LBcPFCGWluBdC/Bx
         BcdeGQK+w/JGc9rUS52AykI65HoHc36cihQuKoRBv4oV6luU86uiBSYykumP+0+tQ8mg
         u8NGPhWpihacFrJAbBPo6ldw95+WC6UggSwW9QAYoTaZLhtkn5Tk7Qdt7HoBq0xjOJ46
         Y+vvgHLKYALIbySuwXt841z4YA44lg3+2a06D+c+yj1Ov0o6XLSqcKqcotsgu5scqODb
         PMvQsNcI7JY7bfq9NVSIXnpu8cx8w5P3y9oxPns6wA+FZplnqxsLRo5JQycCKP1bMXwu
         mgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763153188; x=1763757988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R91BPIHvF+PMEK++tWfFQzcocSH9XXfZoUO7yz1bj9s=;
        b=eyAhQdvaSB+GQul9cdXYrDX92ww7zLgj+1wEsLWVmFkxr0fXJm/LfOd1USlT7fa5In
         a4XgKFmKgnsaHMAGSg2X6RmTfUEjwvj86G8/1xO7NCtjVr8/7ZbPoxw7fnd+wxyCBnPm
         yc8jx5wlCdpsweKVhPH3u2uxtIZ1EDsipcYuZQxoYGluo2GEmZPJCTOWPZg3p5I0fT2g
         /FOOcaLLP2IdjuW6FxTbzSjKpbvdZg1m7Ap/g+gsSP827Ga4p+DZ8wo13+bRsOmhkhFf
         M+esEb4eEcvf5fqnGklZ/FIDzYB3sf0CHS7Rz+NDya0UP1ZUhNDMStiWisUwCgH7E6Mq
         OJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXf9Fawu7OiH+5Z7DE7Gjya6/vycLCIshrcbJuWB6OuTsXlvVgg8LlL0kh1cdg8YkSi52Qa7Wuk7xtHfk+fz28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrn/Ql5qvYs7t4YVKbZYC0nEIoMbYAdiXEbqyaGWaGsLaPmzAm
	8/c+AU+K7bEssZoHjKLDcsZBlEm9JhuAMq8dTDTEAxI3kkwLQNkKxelKLCJK1WwoxeFQS+l11wt
	lxH/neyA+wIce9eIz9ITAsZQ6SjUhj9Y=
X-Gm-Gg: ASbGncs8bH2Ji4bPDEDj2yWS7wbZHYjHNC6JRwbv+yLno9bVITyk6jRtcxSTPMknwiD
	7uI48tHEgnTxC6HNwS7udqYVUGebvpKeLw6sHTnYI1EBF9JIkuta3cb+JUtrZvaRVeSxwigbDqb
	bKxF4pVusYAChvrdpCfAtcuanowDSRxxbkTi8JuHYkIgNuR27YM8RLxTHw8KzgRqvk5wxqnx9TE
	1clDUTp5E9BG7UTQuvZKtw0tuguf9rATf3ic3+DMq7nezJ+Y47X6FxGGF/IJYK2wWD5T2hr1ynA
X-Google-Smtp-Source: AGHT+IGonQLSQ7El5G2Eyqdwn9GRI6w19sMs5o+hd2d0mhS2v00lquD7zdm9pZWOXD7cxJ2dWcbWoWRhx5b4Anm1T8Q=
X-Received: by 2002:a17:90b:528a:b0:32e:7270:9499 with SMTP id
 98e67ed59e1d1-343f99d60a6mr4973231a91.0.1763153188434; Fri, 14 Nov 2025
 12:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110134858.1664471-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251110134858.1664471-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Nov 2025 12:46:15 -0800
X-Gm-Features: AWmQ_bnFSn90eGJnYXtk327GJ7mk0u-qVfi-2ZxUYSjHcnGme8GfwxWhZkvS1yk
Message-ID: <CAEf4BzZ3oX-=zX0_HbeUHsPw7AOZVvi_LNkwugQnybpQvZS_Mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: simplify the kernel_count bench trigger
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	mingo@kernel.org, jiang.biao@linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 5:49=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Remove the "trigger_count" in trigger_bench.c and reuse trigger_driver()
> instead for trigger_kernel_count_setup().
>
> With the calling to bpf_get_numa_node_id(), the result for "kernel_count"
> will become a little more accurate.

"more accurate" is a bit misleading here. I think you meant that it
will do same amount of helper calls as fentry and other benchmarks,
and in that sense will be closer as a baseline comparison, is that
right? Can you clarify that in the next revision, please?

>
> It will also easier if we want to test the performance of livepatch, just
> hook the bpf_get_numa_node_id() and run the "kernel_count" bench trigger.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  .../selftests/bpf/benchs/bench_trigger.c        |  5 +----
>  .../testing/selftests/bpf/progs/trigger_bench.c | 17 +++++------------
>  2 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/t=
esting/selftests/bpf/benchs/bench_trigger.c
> index 1e2aff007c2a..34fd8fa3b803 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -179,11 +179,8 @@ static void trigger_syscall_count_setup(void)
>  static void trigger_kernel_count_setup(void)
>  {
>         setup_ctx();
> -       bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
> -       bpf_program__set_autoload(ctx.skel->progs.trigger_count, true);
> +       ctx.skel->rodata->kernel_count =3D 1;
>         load_ctx();
> -       /* override driver program */
> -       ctx.driver_prog_fd =3D bpf_program__fd(ctx.skel->progs.trigger_co=
unt);
>  }
>
>  static void trigger_kprobe_setup(void)
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/te=
sting/selftests/bpf/progs/trigger_bench.c
> index 3d5f30c29ae3..6564d1909c7b 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -39,26 +39,19 @@ int bench_trigger_uprobe_multi(void *ctx)
>         return 0;
>  }
>
> +const volatile int kernel_count =3D 0;

nit: use bool? it's not a counter, no need to use int here

>  const volatile int batch_iters =3D 0;
>
> -SEC("?raw_tp")
> -int trigger_count(void *ctx)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < batch_iters; i++)
> -               inc_counter();
> -
> -       return 0;
> -}
> -
>  SEC("?raw_tp")
>  int trigger_driver(void *ctx)
>  {
>         int i;
>
> -       for (i =3D 0; i < batch_iters; i++)
> +       for (i =3D 0; i < batch_iters; i++) {
>                 (void)bpf_get_numa_node_id(); /* attach point for benchma=
rking */
> +               if (kernel_count)
> +                       inc_counter();
> +       }


tbh, I wouldn't touch trigger_driver() adding unnecessary if
conditions to it. It's fine, IMO, to have bpf_get_numa_node_id() call
in trigger_count() for being closer in terms of actual work being
done, but I'd keep trigger_driver and trigger_count separate (maybe
renaming trigger_count to trigger_kernel_count would help, I don't
know)

pw-bot: cr

>
>         return 0;
>  }
> --
> 2.51.2
>

