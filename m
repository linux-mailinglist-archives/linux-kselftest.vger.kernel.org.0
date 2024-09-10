Return-Path: <linux-kselftest+bounces-17644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDB974249
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 20:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8140C1F2662E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACBB1A4B9A;
	Tue, 10 Sep 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpI0s8HZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0719ABAB;
	Tue, 10 Sep 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993411; cv=none; b=c4pv7kUnHcHT7BbIlgq6Jh3DiJZA/8o85S3w5zz54yB9THHD8y3AIOVSfDIHG/A+uRtsUJpRBDkt+lrQXBR4aiKKtm3qH/ZExnBOKwHoGjXTh75ZIIVeUOSNMZe4+1/z7ktE4kcmC5WJbgArFNz9YthOooXG294afo/TKlH2BRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993411; c=relaxed/simple;
	bh=5arPnfjWXyrdjAiStwnmxxVrYLXAOszSZun7VfbWVkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfpuufD35Y1aLM+vH8KEBdDwHHif9lvIe1Yc+bo0eJ2vW1zVRGKtx7wXUhHK7WUoq5r1G0GIhUAx/YKrSccn5gihv2J010ICtifbc17/I6Nm7QWNB6YAOFrH7eZROWwlwyMEjcFWVVJY9NZ5qvEAC3nbJmVNGpXh7ZrLDk/IFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpI0s8HZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so45494875e9.0;
        Tue, 10 Sep 2024 11:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725993407; x=1726598207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYRpFrjXySEQ18BBsNAf9S1gTbcM24j9KXPIlWQ1vuQ=;
        b=VpI0s8HZ0TFv/ATbPhicbNcBmS0W0Bt388GRvYZct3diCQA7zNkLKa3wlCZXiDKRAM
         3QWRnGqqFjDNYQYUb2m7FzEcwauHEbSNcU7ZyL0JtRKZMyGs6MHvF2m9ujmp8c+JtjRA
         GWi7CWIfYh/XCJgg6gko6GQ/HNUFq+4N6cJg4i1xVSzgr+rCKUFT3Y0K264yeVPjuGlf
         CgQMyZ1GfcvfW5TpfFPz4iF1gAUjJJ8WYAHEJNI8w0SBEN4oxYTsw+rk7iQ5wdCQFCAq
         gWP5P6dXEqtx7eAygUA+q4lIobzQfot+QA3Pq/OKkxk567kYs3apuYeUX+dBTNlzCLM2
         UQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993407; x=1726598207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYRpFrjXySEQ18BBsNAf9S1gTbcM24j9KXPIlWQ1vuQ=;
        b=IgzhQmiU1GlRPtVNh/+PBTH10XxVtAouWaDJfXOBE/IgPjhZF4gX27up4fnrFGO8aZ
         cM1FBUW4WOssVFjl5TnoX10h+Cw5wLG61kj5/HspACnS+WvvWzusZANmhEcpsxxTEVhc
         ihNBkLPN+U63WBTGFRbbLNzj8M/GCcghVPD9VYTJKUxRvbnjy140aRgZcyrkXkgEFguJ
         oEMkDtCNbQ3IXhyNUtbNkbKgfDmZa3PlbGi3iUAlJlVu93aIKMT6Gtmt+5dM55En4M+G
         uO3B6uZjNuv3hB/Upv9ki38f+3kWHNPpcIn7//xM1k+8md0htLHMjhU1iSxooP9/pdDr
         PPCw==
X-Forwarded-Encrypted: i=1; AJvYcCU4464F4gLJlLPIbBK73RaPnYH3A4izfVRbXBjVHajObmmC4OeNnKhOS55nUXsYEO4hX8E=@vger.kernel.org, AJvYcCU6QJXmm+ZPvm124IEJaE6B2ByFu5EHiGXrXo6FfvL8oCmSWyDF6O8QV7/iOR3Q76Q0VQh2RLX+BHGZ7PQX@vger.kernel.org, AJvYcCXJP4ryuZM5b9gYS3ZqdAMUcuz6aGAYrCqWbwQeQHEgjjmj2L/nGpkGTJ67OYR7K4CslwqHvcW/AzdQpcQnw/ub@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3znqWGRsDiEgnbhkRF6hD8yFEPmbz7lQTAsgec4/cN9j8OGu
	mFyPA/r0xMWMde5C4BiG2ZOm1jI+JLeohlrtHf047anDW5zvyUR+v7E6LoqW5am8U6H2QN2dW21
	LLwUju6Qz171ibffqqmK+WtjS15c=
X-Google-Smtp-Source: AGHT+IGRAF8g5vIzk5OEwG2I52Fe8R45W5VN7LuD0YP/b6qKQUcXnfP6Y2kD8iMsVdSn99NR0m2d+eIBmWVKHqdWpAo=
X-Received: by 2002:a5d:4fc4:0:b0:374:c23a:2ce8 with SMTP id
 ffacd0b85a97d-37892727bddmr6460616f8f.52.1725993407426; Tue, 10 Sep 2024
 11:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
In-Reply-To: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Sep 2024 11:36:36 -0700
Message-ID: <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming
 BPF_MAP_TYPE_RINGBUF from prog
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eddy Z <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Right now there exists prog produce / userspace consume and userspace
> produce / prog consume support. But it is also useful to have prog
> produce / prog consume.
>
> For example, we want to track the latency overhead of cpumap in
> production. Since we need to store enqueue timestamps somewhere and
> cpumap is MPSC, we need an MPSC data structure to shadow cpumap. BPF
> ringbuf is such a data structure. Rather than reimplement (possibly
> poorly) a custom ringbuffer in BPF, extend the existing interface to
> allow the final quadrant of ringbuf usecases to be filled. Note we
> ignore userspace to userspace use case - there is no need to involve
> kernel for that.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  kernel/bpf/verifier.c                         |  6 +-
>  tools/testing/selftests/bpf/Makefile          |  3 +-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 50 +++++++++++++++
>  .../bpf/progs/test_ringbuf_bpf_to_bpf.c       | 64 +++++++++++++++++++
>  4 files changed, 120 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_bpf_to=
_bpf.c
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53d0556fbbf3..56bfe559f228 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9142,7 +9142,8 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
>                     func_id !=3D BPF_FUNC_ringbuf_query &&
>                     func_id !=3D BPF_FUNC_ringbuf_reserve_dynptr &&
>                     func_id !=3D BPF_FUNC_ringbuf_submit_dynptr &&
> -                   func_id !=3D BPF_FUNC_ringbuf_discard_dynptr)
> +                   func_id !=3D BPF_FUNC_ringbuf_discard_dynptr &&
> +                   func_id !=3D BPF_FUNC_user_ringbuf_drain)
>                         goto error;
>                 break;
>         case BPF_MAP_TYPE_USER_RINGBUF:
> @@ -9276,7 +9277,8 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
>                         goto error;
>                 break;
>         case BPF_FUNC_user_ringbuf_drain:
> -               if (map->map_type !=3D BPF_MAP_TYPE_USER_RINGBUF)
> +               if (map->map_type !=3D BPF_MAP_TYPE_USER_RINGBUF &&
> +                   map->map_type !=3D BPF_MAP_TYPE_RINGBUF)
>                         goto error;

I think it should work.

Andrii,

do you see any issues with such use?

>                 break;
>         case BPF_FUNC_get_stackid:
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 9905e3739dd0..233109843d4d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -503,7 +503,8 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_fu=
ncs.skel.h               \
>  LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c atomics.c          =
 \
>         trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
>         core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> -       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
> +       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> +       test_ringbuf_bpf_to_bpf.c

Do you need it to be lskel ?

Regular skels are either to debug.

Also pls split selftest into a separate patch.

>
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index da430df45aa4..3e7955573ac5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -17,6 +17,7 @@
>  #include "test_ringbuf_n.lskel.h"
>  #include "test_ringbuf_map_key.lskel.h"
>  #include "test_ringbuf_write.lskel.h"
> +#include "test_ringbuf_bpf_to_bpf.lskel.h"
>
>  #define EDONE 7777
>
> @@ -497,6 +498,53 @@ static void ringbuf_map_key_subtest(void)
>         test_ringbuf_map_key_lskel__destroy(skel_map_key);
>  }
>
> +static void ringbuf_bpf_to_bpf_subtest(void)
> +{
> +       struct test_ringbuf_bpf_to_bpf_lskel *skel;
> +       int err, i;
> +
> +       skel =3D test_ringbuf_bpf_to_bpf_lskel__open();
> +       if (!ASSERT_OK_PTR(skel, "test_ringbuf_bpf_to_bpf_lskel__open"))
> +               return;
> +
> +       skel->maps.ringbuf.max_entries =3D getpagesize();
> +       skel->bss->pid =3D getpid();
> +
> +       err =3D test_ringbuf_bpf_to_bpf_lskel__load(skel);
> +       if (!ASSERT_OK(err, "test_ringbuf_bpf_to_bpf_lskel__load"))
> +               goto cleanup;
> +
> +       ringbuf =3D ring_buffer__new(skel->maps.ringbuf.map_fd, NULL, NUL=
L, NULL);
> +       if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
> +               goto cleanup;
> +
> +       err =3D test_ringbuf_bpf_to_bpf_lskel__attach(skel);
> +       if (!ASSERT_OK(err, "test_ringbuf_bpf_to_bpf_lskel__attach"))
> +               goto cleanup_ringbuf;
> +
> +       /* Produce N_SAMPLES samples in the ring buffer by calling getpid=
() */
> +       skel->bss->value =3D SAMPLE_VALUE;
> +       for (i =3D 0; i < N_SAMPLES; i++)
> +               syscall(__NR_getpgid);
> +
> +       /* Trigger bpf-side consumption */
> +       syscall(__NR_prctl);

This might conflict with other selftests that run in parallel.

Just load the skel and bpf_prog_run(prog_fd).
No need to attach anywhere in the kernel.

pw-bot: cr

