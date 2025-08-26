Return-Path: <linux-kselftest+bounces-40010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D72B37527
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429917A3941
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65071246BC6;
	Tue, 26 Aug 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NloZQs1G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6536D;
	Tue, 26 Aug 2025 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249523; cv=none; b=igu3F7/RBfI7i+tCplSSZ/wj/n1HQH1ao8KjBFx7iM1ygxN2Z7tsSngPF8Yx1F7xLHFjzRQ4X2ycCYu+FbvpBe1tKXoQx8Dbb3JQVDN3dnrgGGcn9n7bQE2/YH4L3IuzZu9vzrWzy/f1AbaGt+MYI5d1vuyP9Bk2T89W234clIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249523; c=relaxed/simple;
	bh=r0bL4IU3jc6IoSlE5j3nFASwoFqKqvZ+bT7o1kXxt2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIXlv6isKH8d+M9pv7420aF+YIN5QWyOh1nulml5vvxjvypJZ/qEK20hDmzKgYfJasn1pSr6rfQAOAiqjJuDADKv1PS4ebuVGPIs0suH8xEYmNlcppmy7REqynNZcT6EEc19eBiA0ngI5Y/BDLSa9yf0XRmnZI/wkzq2UcMg6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NloZQs1G; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4bafe2e538so2743789a12.3;
        Tue, 26 Aug 2025 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756249521; x=1756854321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5/KUWuX3lU7U0e/2Lp4AoOwJkXmPRaZE+ZuGiSyTr4=;
        b=NloZQs1GdxNw4n0YCvJgUafT+j0mAu/KI0js5y1MoZcq8qeD0WXsjOQcJwDSo6ppQE
         gz9/WsxShpcOmiVxWnLqODJHipbH3ZMC1LmDnjE+g4mg5KIBfOq8tZY7PUF++BWHhSy6
         awVm8E4QzdZ0XsdOjLpVvlG/TF7eglGfY4tfxVeq0HC5EqHdkXvJj7cZn92wA4glHcgO
         2ExlVrwaELAuFMX4WLNXe/nXk3bFpdaxMECT6TrRnjzEExraRnCHJ3kqDQBqCkKT5csR
         6FtTz7Eoj6KadkWT5ObDKxtp82u0Lln5tKa65bH7d96MqNQQRU+bapDnZR1Uk/An/1O0
         0aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756249521; x=1756854321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5/KUWuX3lU7U0e/2Lp4AoOwJkXmPRaZE+ZuGiSyTr4=;
        b=eyDO3zhF9kN556gd9cQWOiKWMstEwccxAlsh2SURwJfPcRc1W8R4mRoJeR6rlqWLBE
         KUNDL8UVsjzlMIrd0TKQxH+Nq9g7Y5OM7ijA+VWD6UN7hWS1MYdWYo3YZxXr1Cb2G6Ue
         Jin1vgA1f+3t9zALzy6IkIrZh4XKWWnrSg+N3Tk2tSvDLz2MPMuuTqgdHpdUYTvKLLzs
         Ozij7sioFlI2A08Gp+uGpCUFizvqiW/eGo6cVsdCUWK9+i36kaqf/MXRNKjZ06JTu2KG
         sSP93Ch3Jzw+OLJRSxB/rvUh9GKor/xElW2tty0pmLlGghOzd+hYZq2lOQ/mdgI6pLzL
         Ms1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHykxTnKl/pieI6EMSY47UxQ23dHskAyYjzVsuIxZHg/LJSziQako49r2yim5b7fMVH6ILND8pHgS57p0B@vger.kernel.org, AJvYcCVUanN1GEu/VqhO9HI4YcrefqO3uxH1lojwg0QFa81KvueN6Du2Gd3gS/U7W+vvzVROHMw=@vger.kernel.org, AJvYcCWWVfSCflDRC/3tWZVFQxs8eFHvvbnOBhOiLejvOlkxCZj6B8Cdawmf2w9BAd80pH5ILM8wDkRXcipvD21w0nwb@vger.kernel.org
X-Gm-Message-State: AOJu0YzOT4VPKH9YF1L/yJ7VVphxSFpC+xU8UZYY4s1Lodax8AH0ZaNJ
	PVMvj7h3wkU6uZ1LYxJVx7Srh1syZxzHX0OTjV75Rk/OMT1ykzfXecLQtkTgoJ7UUcifVqe/RS4
	lNubiclnqrErmHBU77+cGUbCQjPUgDcg=
X-Gm-Gg: ASbGncvp60EcE7ypyTjMWjrDPnrq7kVBbM58LbTnhtfWV/Fct0opTQ4PPRmbo3qUPvC
	Qw1f2FZOgr8ew0+s/5ys/tnZYDr/k9Ab9h2ao83QtC/GPBVMBpRdwy5pRJwPDFosOvOYmATRBdQ
	iUSnX5o69cG6Z+GU8JB6I6Tnn7zTxDFthdPmKFLyKW+td9WueVH0s6titU2Ai1OsKwYBHDTDuHC
	rHCRYrhaOWHaWUXZjDf0b4=
X-Google-Smtp-Source: AGHT+IEmk7FqBA4RUKirjXnPXbF/c/e68onqcM7r5p1CfowkHu3C4SRh9nZq/x44vtr13W9E1DgjJz6ht4IdIdzmvgE=
X-Received: by 2002:a17:903:943:b0:242:fbc6:6a83 with SMTP id
 d9443c01a7336-2462eb56b82mr217121215ad.0.1756249520905; Tue, 26 Aug 2025
 16:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823071839.1191350-1-phoenix500526@163.com> <20250823071839.1191350-3-phoenix500526@163.com>
In-Reply-To: <20250823071839.1191350-3-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Aug 2025 16:05:06 -0700
X-Gm-Features: Ac12FXxfBGYfJGsvvz0s-sjRA6oL3UL2MHnFVqQI8b_JJlh_K24Ylprj5rQauU0
Message-ID: <CAEf4BzaHi5kpuJ6OVvDU62LT5g0qHbWYMfb_FBQ3iuvvUF9fag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v15 2/2] selftests/bpf: Enrich subtest_basic_usdt
 case in selftests to cover SIB handling logic
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 12:19=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com=
> wrote:
>
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
>
> In this patch:
> - enrich subtest_basic_usdt test case to cover SIB addressing usdt argume=
nt spec
>   handling logic
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 62 ++++++++++++++++++-
>  tools/testing/selftests/bpf/progs/test_usdt.c | 32 ++++++++++
>  2 files changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 9057e983cc54..4b264f7d3324 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -10,6 +10,26 @@
>
>  int lets_test_this(int);
>
> +#if defined(__x86_64__) || defined(__i386__)
> +/*
> + * SIB (Scale-Index-Base) addressing format:
> + *   "size@(base_reg, index_reg, scale)"
> + * - 'size' is the size in bytes of the array element, and its sign indi=
cates
> + *             whether the type is signed (negative) or unsigned (positi=
ve).
> + * - 'base_reg' is the register holding the base address, normally rdx o=
r edx
> + * - 'index_reg' is the register holding the index, normally rax or eax
> + * - 'scale' is the scaling factor (typically 1, 2, 4, or 8), which matc=
hes the
> + *             size of the element type.
> + *
> + * For example, for an array of 'short' (signed 2-byte elements), the SI=
B spec would be:
> + *     - size: -2 (negative because 'short' is signed)
> + *     - scale: 2 (since sizeof(short) =3D=3D 2)
> + *     The resulting SIB format: "-2@(%%rdx,%%rax,2)"
> + */
> +static volatile short array[] =3D {-1, -2, -3, -4};
> +#define USDT_SIB_ARG_SPEC -2@(%%rdx,%%rax,2)

can you locate this before trigger_sib_spec, inside the same #if/#endif are=
a?

> +#endif
> +
>  static volatile int idx =3D 2;
>  static volatile __u64 bla =3D 0xFEDCBA9876543210ULL;
>  static volatile short nums[] =3D {-1, -2, -3, -4};
> @@ -25,6 +45,10 @@ unsigned short test_usdt0_semaphore SEC(".probes");
>  unsigned short test_usdt3_semaphore SEC(".probes");
>  unsigned short test_usdt12_semaphore SEC(".probes");
>
> +#if defined(__x86_64__) || defined(__i386__)
> +unsigned short test_usdt_sib_semaphore SEC(".probes");

same as above, group all this close to the triggering function inside
single #if/#endif block

> +#endif
> +
>  static void __always_inline trigger_func(int x) {
>         long y =3D 42;
>
> @@ -40,12 +64,27 @@ static void __always_inline trigger_func(int x) {
>         }
>  }
>
> +#if defined(__x86_64__) || defined(__i386__)
> +static void trigger_sib_spec(void)
> +{
> +       /* Base address + offset + (index * scale) */
> +       /* Force SIB addressing with inline assembly */
> +       asm volatile(
> +               STAP_PROBE_ASM(test, usdt_sib, USDT_SIB_ARG_SPEC)
> +               :
> +               : "d"(array), "a"(0)
> +               : "memory"
> +       );
> +}
> +#endif
> +
>  static void subtest_basic_usdt(void)
>  {
>         LIBBPF_OPTS(bpf_usdt_opts, opts);
>         struct test_usdt *skel;
>         struct test_usdt__bss *bss;
>         int err, i;
> +       const __u64 expected_cookie =3D 0xcafedeadbeeffeed;
>
>         skel =3D test_usdt__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "skel_open"))
> @@ -59,20 +98,29 @@ static void subtest_basic_usdt(void)
>                 goto cleanup;
>
>         /* usdt0 won't be auto-attached */
> -       opts.usdt_cookie =3D 0xcafedeadbeeffeed;
> +       opts.usdt_cookie =3D expected_cookie;
>         skel->links.usdt0 =3D bpf_program__attach_usdt(skel->progs.usdt0,
>                                                      0 /*self*/, "/proc/s=
elf/exe",
>                                                      "test", "usdt0", &op=
ts);
>         if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
>                 goto cleanup;
>
> +#if defined(__x86_64__) || defined(__i386__)
> +       opts.usdt_cookie =3D expected_cookie;
> +       skel->links.usdt_sib =3D bpf_program__attach_usdt(skel->progs.usd=
t_sib,
> +                                                               0 /*self*=
/, "/proc/self/exe",
> +                                                               "test", "=
usdt_sib", &opts);
> +       if (!ASSERT_OK_PTR(skel->links.usdt_sib, "usdt_sib_link"))
> +               goto cleanup;
> +#endif
> +
>         trigger_func(1);
>
>         ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
>         ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
>         ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
>
> -       ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
> +       ASSERT_EQ(bss->usdt0_cookie, expected_cookie, "usdt0_cookie");
>         ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
>         ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
>         ASSERT_EQ(bss->usdt0_arg_size, -ENOENT, "usdt0_arg_size");
> @@ -156,6 +204,16 @@ static void subtest_basic_usdt(void)
>         ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
>         ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
>
> +#if defined(__x86_64__) || defined(__i386__)
> +       trigger_sib_spec();
> +       ASSERT_EQ(bss->usdt_sib_called, 1, "usdt_sib_called");
> +       ASSERT_EQ(bss->usdt_sib_cookie, expected_cookie, "usdt_sib_cookie=
");
> +       ASSERT_EQ(bss->usdt_sib_arg_cnt, 1, "usdt_sib_arg_cnt");
> +       ASSERT_EQ(bss->usdt_sib_arg, nums[0], "usdt_sib_arg");
> +       ASSERT_EQ(bss->usdt_sib_arg_ret, 0, "usdt_sib_arg_ret");
> +       ASSERT_EQ(bss->usdt_sib_arg_size, sizeof(nums[0]), "usdt_sib_arg_=
size");
> +#endif
> +
>  cleanup:
>         test_usdt__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testin=
g/selftests/bpf/progs/test_usdt.c
> index 096488f47fbc..63db72253316 100644
> --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> @@ -107,4 +107,36 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a=
4, unsigned a5,
>         return 0;
>  }
>
> +

nit: extra empty line for no good reason

> +int usdt_sib_called;
> +u64 usdt_sib_cookie;
> +int usdt_sib_arg_cnt;
> +int usdt_sib_arg_ret;
> +u64 usdt_sib_arg;
> +int usdt_sib_arg_size;
> +
> +/*
> + * usdt_sib is only tested on x86-related architectures, so it requires
> + * manual attach since auto-attach will panic tests under other architec=
tures
> + */
> +SEC("usdt")
> +int usdt_sib(struct pt_regs *ctx)
> +{
> +       long tmp;
> +
> +       if (my_pid !=3D (bpf_get_current_pid_tgid() >> 32))
> +               return 0;
> +
> +       __sync_fetch_and_add(&usdt_sib_called, 1);
> +
> +       usdt_sib_cookie =3D bpf_usdt_cookie(ctx);
> +       usdt_sib_arg_cnt =3D bpf_usdt_arg_cnt(ctx);
> +
> +       usdt_sib_arg_ret =3D bpf_usdt_arg(ctx, 0, &tmp);
> +       usdt_sib_arg =3D (short)tmp;
> +       usdt_sib_arg_size =3D bpf_usdt_arg_size(ctx, 0);
> +
> +       return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>

