Return-Path: <linux-kselftest+bounces-47863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9BFCD6F8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9088A303BE34
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375D336EC5;
	Mon, 22 Dec 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAvcvXGg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3933B6FC
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431777; cv=none; b=urqz1WBIOr+zOkT/+A9fGn76fc6S4vpS7XXfEyNyIVNtoMYsodHi+IUXfgAxDzDW8FmihMKDHz0F9UjgK+5/2La7cT/nXXevrxK+LoKu+Ytf46nnfjSi8+qoplhAAyNgmf04FWQEX6FgNKlsaWt7FLffpvhthiTKaMgxjzxNpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431777; c=relaxed/simple;
	bh=Is9aSf/556bxuYegPxbnD7uS9JeESwjbDVKpFVqADsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5hWo0Ve7YgWNimHJdmCgBxcz0CfD7y5b5akXfJ+aqVIiJJutriilSXKKBQ2ne1P2JDDtMszuW3IPVx/Th/isb8vPvhTwT1cEwj0J3MUVIHkJhlokm1UvNZnviq5n57k8PBWFY+VHBZ3Fsiz7ahfIGTtObqxAMzQSA9Fcjqy2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAvcvXGg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787eb2d8663so53934227b3.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 11:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766431774; x=1767036574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqJ3vVbWHzFYZqmxVIV93Fa7xe1lg+sgSuO3WlwgABY=;
        b=iAvcvXGg2H9rivpKHem3r0p1kXijGk3A9PDSo+o9fe5SjWLHUiquZCbbGAIB2HZ5I8
         JFSrKb0SEGgH7xpZoCHxEI7XbQSYkHGxJagSVeYkJ7THgQBPQllnXQtu/SOK5q2SMubp
         8q6K1QQ/LWYFkNtqb8ni2Ib6wjTjJOxSVngeg3GYacC0XaJumrJUwdJEZbF0hfSHuDpp
         GfFXiS04j6WI7jmVUAw7hqnISc+FbOsJolCTgIVkE1rhivdA170H9gAHyWTbLBX+S7NP
         K4dbn1w9wQVuF8aL4AaVjnmuCJDhxIOsLIPR2gWiAv83dbTtdjE5OZhgUPBk0rnGROC/
         tiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766431774; x=1767036574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqJ3vVbWHzFYZqmxVIV93Fa7xe1lg+sgSuO3WlwgABY=;
        b=tUqpmDAlYJFAb6/0trBiXlGAAZVW6TT7AvBpB5LUXxoEdmMeVkhTVFmK4jabXacGj9
         XYbXObbtDbmQeHrT+yCdyY+2Vh7AmzN4MK4/me5ZavEAgBfqXGah4pdK1CkOnih5aGK3
         q+P1bCclI8gfp1NsX1cEPBt7BFlwhoVCJ+nVxCcqDmOpFQGgWi3X4xH+IlcxyGYLT98R
         yCvFY8eeyIlqx2a95cpG9ymCNUnwKVwBJCjf/RkGLvZqkZpftrKazfwU/eyhp1ec/bXD
         hzozxKISEXDvmRQ4/FRcC71+iM4wUYjZpV3HxnFDz30NvyAzeOz5jEwJw9g/GJIMZ+Mv
         PviA==
X-Forwarded-Encrypted: i=1; AJvYcCW9S+jPUpGJuX1BLB2rK7fHJh0uwzvcCbCgC9aFvUpU0ytcjFHijJ9jQb3E7I7SJ823l1kvyO0hREnt78TDi+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2Yaexc71xqJWcbS4RO7Rt6lxvRi+ecHDJITwh+r8ReJ1Qug3
	1o8LKZIA1d5KeplP6GXMkS8lkg2zZacuQfECNRr2rFTQP5YK4j/GnzsyJmW4ZUUcurWqM6rXJqQ
	0l2u5lF0lzcjMmQivpzJUSawMM0vNqCM=
X-Gm-Gg: AY/fxX55Zs6gqh4edYhsiIyPGDErNWmaH7/LF9e7+ujwRMDY17vKe4q1kkT4Wwi+iHe
	DH/xgXbuBn5DH/Pzny5zm4fdsC+Z1I5czCjp0xvtZzaKZnurSERnhvAu/exEYqVA2axijR68CkR
	GWFbn+9mCGCONCdHuhzvpXquWmISgOkovGMMK2rr/XGB0p5adzex9/USlHOw3iQyOFlGHutmtFa
	tQr5SOtLjQi+PhVoMPcAocQlkqp+eNThmBnVO23+mCER2BovXhD8P5+yFIYND7dL9UA7/k=
X-Google-Smtp-Source: AGHT+IGfJ1R+UhaNH+BChkiIplciIHenxvpUV2olWqYwJU4lw3QKMILZdvQq85AWhawDfzzu+vZNVwSHrL8y7hLR1Pg=
X-Received: by 2002:a05:690c:a0a2:10b0:786:8abd:bbcf with SMTP id
 00721157ae682-78fa5b58cbamr104575537b3.31.1766431774246; Mon, 22 Dec 2025
 11:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com> <20251220-helper_proto-v1-1-2206e0d9422d@gmail.com>
In-Reply-To: <20251220-helper_proto-v1-1-2206e0d9422d@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Dec 2025 11:29:23 -0800
X-Gm-Features: AQt7F2pDTOhbo20J9mti2Iv2uBWiCpet64TbGM459wgMokEFKr31y9F3TMfRC0w
Message-ID: <CAMB2axPcJ=U69xyyyY_7og8OALRCbOgeppQv416k9yvMiD9CvQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf 1/2] bpf: Fix memory access tags in helper prototypes
To: Zesen Liu <ftyghome@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Shuran Liu <electronlsr@gmail.com>, 
	Peili Gao <gplhust955@gmail.com>, Haoran Ni <haoran.ni.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 3:35=E2=80=AFAM Zesen Liu <ftyghome@gmail.com> wrot=
e:
>
> After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type tr=
acking"),
> the verifier started relying on the access type tags in helper
> function prototypes to perform memory access optimizations.
>
> Currently, several helper functions utilizing ARG_PTR_TO_MEM lack the
> corresponding MEM_RDONLY or MEM_WRITE tags. This omission causes the
> verifier to incorrectly assume that the buffer contents are unchanged
> across the helper call. Consequently, the verifier may optimize away
> subsequent reads based on this wrong assumption, leading to correctness
> issues.
>
> Similar issues were recently addressed for specific helpers in commit
> ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's output buffe=
r")
> and commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name=
 args").
>
> Fix these prototypes by adding the correct memory access tags.
>
> Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking=
")
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---
>  kernel/bpf/helpers.c     | 2 +-
>  kernel/trace/bpf_trace.c | 6 +++---
>  net/core/filter.c        | 8 ++++----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index db72b96f9c8c..f66284f8ec2c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1077,7 +1077,7 @@ const struct bpf_func_proto bpf_snprintf_proto =3D =
{
>         .func           =3D bpf_snprintf,
>         .gpl_only       =3D true,
>         .ret_type       =3D RET_INTEGER,
> -       .arg1_type      =3D ARG_PTR_TO_MEM_OR_NULL,
> +       .arg1_type      =3D ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
>         .arg2_type      =3D ARG_CONST_SIZE_OR_ZERO,
>         .arg3_type      =3D ARG_PTR_TO_CONST_STR,
>         .arg4_type      =3D ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index fe28d86f7c35..59c2394981c7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1022,7 +1022,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto =
=3D {
>         .func           =3D bpf_snprintf_btf,
>         .gpl_only       =3D false,
>         .ret_type       =3D RET_INTEGER,
> -       .arg1_type      =3D ARG_PTR_TO_MEM,
> +       .arg1_type      =3D ARG_PTR_TO_MEM | MEM_WRITE,
>         .arg2_type      =3D ARG_CONST_SIZE,
>         .arg3_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg4_type      =3D ARG_CONST_SIZE,
> @@ -1526,7 +1526,7 @@ static const struct bpf_func_proto bpf_read_branch_=
records_proto =3D {
>         .gpl_only       =3D true,
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
> -       .arg2_type      =3D ARG_PTR_TO_MEM_OR_NULL,
> +       .arg2_type      =3D ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
>         .arg3_type      =3D ARG_CONST_SIZE_OR_ZERO,
>         .arg4_type      =3D ARG_ANYTHING,
>  };
> @@ -1661,7 +1661,7 @@ static const struct bpf_func_proto bpf_get_stack_pr=
oto_raw_tp =3D {
>         .gpl_only       =3D true,
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
> -       .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> +       .arg2_type      =3D ARG_PTR_TO_UNINIT_MEM,
>         .arg3_type      =3D ARG_CONST_SIZE_OR_ZERO,
>         .arg4_type      =3D ARG_ANYTHING,
>  };
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 616e0520a0bb..6e07bb994aa7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6399,7 +6399,7 @@ static const struct bpf_func_proto bpf_xdp_fib_look=
up_proto =3D {
>         .gpl_only       =3D true,
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
> -       .arg2_type      =3D ARG_PTR_TO_MEM,
> +       .arg2_type      =3D ARG_PTR_TO_MEM | MEM_WRITE,
>         .arg3_type      =3D ARG_CONST_SIZE,
>         .arg4_type      =3D ARG_ANYTHING,
>  };
> @@ -6454,7 +6454,7 @@ static const struct bpf_func_proto bpf_skb_fib_look=
up_proto =3D {
>         .gpl_only       =3D true,
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_CTX,
> -       .arg2_type      =3D ARG_PTR_TO_MEM,
> +       .arg2_type      =3D ARG_PTR_TO_MEM | MEM_WRITE,
>         .arg3_type      =3D ARG_CONST_SIZE,
>         .arg4_type      =3D ARG_ANYTHING,
>  };
> @@ -8010,7 +8010,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_=
syncookie_ipv4_proto =3D {
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM,
>         .arg1_size      =3D sizeof(struct iphdr),
> -       .arg2_type      =3D ARG_PTR_TO_MEM,
> +       .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg3_type      =3D ARG_CONST_SIZE_OR_ZERO,
>  };
>
> @@ -8042,7 +8042,7 @@ static const struct bpf_func_proto bpf_tcp_raw_gen_=
syncookie_ipv6_proto =3D {
>         .ret_type       =3D RET_INTEGER,
>         .arg1_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM,
>         .arg1_size      =3D sizeof(struct ipv6hdr),
> -       .arg2_type      =3D ARG_PTR_TO_MEM,
> +       .arg2_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg3_type      =3D ARG_CONST_SIZE_OR_ZERO,
>  };
>

I did a quick search and there is one helper slipping. We should also
annotate arg1_type of bpf_kallsyms_lookup_name with MEM_RDONLY.


>
> --
> 2.43.0
>
>

