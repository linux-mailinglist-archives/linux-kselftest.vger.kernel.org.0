Return-Path: <linux-kselftest+bounces-6241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A09878C99
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CC51C210E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283EC186A;
	Tue, 12 Mar 2024 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUhqZm9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8215BF;
	Tue, 12 Mar 2024 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208547; cv=none; b=RTtF7QFrsxIi34zqmdAwM5iw6niv5MhhshqeCYuvOEEYAaA5yzOvbeYK2Ctt1BqML15fVZaWsnrctAK3moM2mIXOlRhEJ0zpfPM/lI3KPZRe7fj2ebmRpOi9+61TsL6sJZeG0V0uQ/lhSXaI44VYeq5OTCvtSa4Ldt/CPRzxUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208547; c=relaxed/simple;
	bh=zshZgIMKPMwYAHrRgT1ICEsjyoVZMcPQc3ur1N+Oe4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qz8M+N0mklDlU9KkAQ98LT4iuzyMhXVetSNt3jbUxYiQFvTISwdNi7aPmHVmAODUSJZGcrQar4bWwQKDM6w9zggw12brNDxprWc4vTOQhX5HOwGyhf0FsfVYa7aiDLUEXyLbADI6g1Pc/FyVAO8ouhvzBILtrdPU0BGzQvJ2jas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUhqZm9T; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e959d8bc0so1541033f8f.1;
        Mon, 11 Mar 2024 18:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710208543; x=1710813343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUQTgV/c1LY6TxFowY3rUQdPlQN/M6/pFPRnz+ClL7I=;
        b=XUhqZm9TlkZPioqABRqiq039TeH1jzD3vYOdz1n0kYugPuTlsMQ2J4mPd1oOcKvQgA
         Iy1Ta6Wejb1yIxbVOtqiyvyRg5v3lSUShVjYcKz48BDR5urY0AG/CoUVzGfPOePnKQoQ
         pJ0UzOjcBqv4wRnwyrJRius+tjaBydacWFvw2dYdp2gXx8XrD/YWSo+rPMlMT9DC5/0j
         cwqpqavJohYoF4xGXbUWGvTALrUIx2zceA5ctfO/wKj9mloyZLot12+cPp0iLm0KONx9
         tWGupsb23beyQgARD0oY85c+pJcNHJNfBqkZRKCe318n5Inyx942F99YuzGTa1eHhjHP
         ymUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208543; x=1710813343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUQTgV/c1LY6TxFowY3rUQdPlQN/M6/pFPRnz+ClL7I=;
        b=bC/755AlKCrcGKXTfwntJdvqB5kbWk7+vcVjzxypn8JwE5oHkaXzO9RjJnexjfgrgR
         3c14VJL+Xq6o+bOFWdngOqkQLJzMepX7JllBCifX1PPAen1cz12Q+b45JvIW59cGwf7v
         eb2VmTKWaDqEmXjVtZy0f4CqANO5j9SALmmDZoFMBlsLQaaVYezPmRUYM0r4PAsLGOKr
         ltHGZVOOKE9N9sb0CApMqudF/LQZ3BOirfLRupSVLJaNMp+n7zrcg7qTUhioZvlWkxmr
         uxgDxRYhhU4kS6ADRcmsJE6ghUGvX2RAJRTRb3+O1WnbE6/Emm5/UlARaVc29FPJiz+H
         IO1w==
X-Forwarded-Encrypted: i=1; AJvYcCUP9C+Dq5rVZtfw5eOZm4zC6gZc+Yy1oEzFXMFgfb7V95vyVjFrOGSVlNCCMOegOqCv6PEvDQafR31jleqq7/ntZV12ah6XvtNFvlix4zqeJj4I3RT3ljhexi//uUvF4MSJEy5jQ+zysdfjJhpeE73JVgYBsvWuBnHOt9TqqYn3rxg3zhplaTH9mBQ6uflaB+jCUoQu7xVyBcTGshum8moLxnwSeQkJev/qImNWjDiBEqSQ11enKWse/zG9hsx8b1GolmMupcFZh+UJxICu/6GeuvKqlqcYg70dYg==
X-Gm-Message-State: AOJu0Yyq04wMSJHx7NBO0FtZ2ytz837FXkSsxMl/QsCukO+GT/D+WOZs
	MFH4f5WXelTVfO7hWbqSSohVWadkwwEIJhdCJ+vo4NLq3DB7GaZqYizRmkdK4rrNekGU77sF6YU
	4cfLjLfKipJaub1eAdifJvs5io8E=
X-Google-Smtp-Source: AGHT+IF9WvwCtzNHUsfNfLjeVXn5IKrULfW4spgTCxiFBM0s3KVbOpftBxulltD2FNgWguOKkvH7qH1ag5mO6L5+G/8=
X-Received: by 2002:adf:ec8c:0:b0:33e:1ee1:ef92 with SMTP id
 z12-20020adfec8c000000b0033e1ee1ef92mr6682508wrn.67.1710208543538; Mon, 11
 Mar 2024 18:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com> <20240311093526.1010158-8-dongmenglong.8@bytedance.com>
In-Reply-To: <20240311093526.1010158-8-dongmenglong.8@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 18:55:32 -0700
Message-ID: <CAADnVQK4tdefa3s=sim69Sc+ztd-hHohPEDXaUNVTU-mLNYUiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/9] libbpf: don't free btf if program of
 multi-link tracing existing
To: Menglong Dong <dongmenglong.8@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
<dongmenglong.8@bytedance.com> wrote:
>
> By default, the kernel btf that we load during loading program will be
> freed after the programs are loaded in bpf_object_load(). However, we
> still need to use these btf for tracing of multi-link during attaching.
> Therefore, we don't free the btfs until the bpf object is closed if any
> bpf programs of the type multi-link tracing exist.
>
> Meanwhile, introduce the new api bpf_object__free_btf() to manually free
> the btfs after attaching.
>
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> ---
>  tools/lib/bpf/libbpf.c   | 47 ++++++++++++++++++++++++++++++----------
>  tools/lib/bpf/libbpf.h   |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 567ad367e7aa..fd5428494a7e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8267,6 +8267,39 @@ static int bpf_object_prepare_struct_ops(struct bp=
f_object *obj)
>         return 0;
>  }
>
> +void bpf_object__free_btfs(struct bpf_object *obj)
> +{
> +       int i;
> +
> +       /* clean up module BTFs */
> +       for (i =3D 0; i < obj->btf_module_cnt; i++) {
> +               close(obj->btf_modules[i].fd);
> +               btf__free(obj->btf_modules[i].btf);
> +               free(obj->btf_modules[i].name);
> +       }
> +       free(obj->btf_modules);
> +       obj->btf_modules =3D NULL;
> +       obj->btf_module_cnt =3D 0;
> +
> +       /* clean up vmlinux BTF */
> +       btf__free(obj->btf_vmlinux);
> +       obj->btf_vmlinux =3D NULL;
> +}
> +
> +static void bpf_object_early_free_btf(struct bpf_object *obj)
> +{
> +       struct bpf_program *prog;
> +
> +       bpf_object__for_each_program(prog, obj) {
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY_MU=
LTI ||
> +                   prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT_MUL=
TI ||
> +                   prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN_M=
ULTI)
> +                       return;
> +       }
> +
> +       bpf_object__free_btfs(obj);
> +}
> +
>  static int bpf_object_load(struct bpf_object *obj, int extra_log_level, =
const char *target_btf_path)
>  {
>         int err, i;
> @@ -8307,18 +8340,7 @@ static int bpf_object_load(struct bpf_object *obj,=
 int extra_log_level, const ch
>         /* clean up fd_array */
>         zfree(&obj->fd_array);
>
> -       /* clean up module BTFs */
> -       for (i =3D 0; i < obj->btf_module_cnt; i++) {
> -               close(obj->btf_modules[i].fd);
> -               btf__free(obj->btf_modules[i].btf);
> -               free(obj->btf_modules[i].name);
> -       }
> -       free(obj->btf_modules);
> -
> -       /* clean up vmlinux BTF */
> -       btf__free(obj->btf_vmlinux);
> -       obj->btf_vmlinux =3D NULL;
> -
> +       bpf_object_early_free_btf(obj);
>         obj->loaded =3D true; /* doesn't matter if successfully or not */
>
>         if (err)
> @@ -8791,6 +8813,7 @@ void bpf_object__close(struct bpf_object *obj)
>         usdt_manager_free(obj->usdt_man);
>         obj->usdt_man =3D NULL;
>
> +       bpf_object__free_btfs(obj);
>         bpf_gen__free(obj->gen_loader);
>         bpf_object__elf_finish(obj);
>         bpf_object_unload(obj);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5723cbbfcc41..c41a909ea4c1 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -299,6 +299,8 @@ LIBBPF_API struct bpf_program *
>  bpf_object__find_program_by_name(const struct bpf_object *obj,
>                                  const char *name);
>
> +LIBBPF_API void bpf_object__free_btfs(struct bpf_object *obj);
> +

It shouldn't be exported.
libbpf should clean it up when bpf_object is freed.

