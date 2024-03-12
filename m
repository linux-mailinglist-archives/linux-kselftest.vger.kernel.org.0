Return-Path: <linux-kselftest+bounces-6239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0433878C8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 02:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48598B21799
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 01:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715F61877;
	Tue, 12 Mar 2024 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+aNpiql"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF11842;
	Tue, 12 Mar 2024 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208305; cv=none; b=NCleHHT8yM8RMALE1pxk2D1d2uYWv5cMhIt2rmGhbkZooBw4+JDbG+7CtrBr+ZDXH6O3NE9bQmCAcsYcgk5sj8MtTIdMVeEp8d9pArZytWrUA8FxyVPtAgdIagkO1eBTBiyBZWYQMCFDi+lIYocRRQ7dQWeCL2AFujEJzmBhVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208305; c=relaxed/simple;
	bh=ArRWAWBpJ3etLudFkCPT+4Xfr92xcoH1FAZA3SWgHRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsQuyO5noBeFxxbL54bbWASVq4KfQ6afIIHyEqRNB/b21oPRAdPopmPVGEJ3ezXzW8wc3ENEJz7aTGXxEETnLpLLaW/zj/UvwkOpibbVIho/hCxdo9+AL+2j0MoPbYuvrGLhHPw9TY1ixpPoGQJ/4S+zeusju4wA9I+DApvpkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+aNpiql; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e6aca1ca9so4852836f8f.2;
        Mon, 11 Mar 2024 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710208302; x=1710813102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKvBVych6YCWus4gRNHRR8iBtRNOaryODuyFk+IiwIg=;
        b=X+aNpiqlfNLa15xtiizq7yUkjhhQo4D8wSaenGLmpd+ev87vyCI2kxuCeMDYdoKRVe
         KPchzNkC3myzkZfIm3FIpxZokp4q0ReLKupbcTDHrSzZfByzl/2APvc+ZCDjLiKZiKWp
         214mT4iWxeNyqlbfzs7a1JZk/ONNApUzoSDABYHiRbz0HIutVwGzwizR5u43ue+VBdnO
         pJSWmoTSAdQyvPuelIac5XIc6gD3DWX4XsKzk3vDySlQXro6f4spNtn2Raa4UUBRBze8
         Uv/X7n37vtP+njUwtIwKY5g3xxthPLYmTAnbyv7w5rBFVoDFfxvkuZY84iIWw6o5pLIo
         SGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208302; x=1710813102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKvBVych6YCWus4gRNHRR8iBtRNOaryODuyFk+IiwIg=;
        b=u8ASxJILzAqdp1WWcwvux3KMCm8wF6l0mKskSDnFYwPEpg8rXntAEalwve3M0LW5xd
         FFrDBdWmtIDESRRS2ojQQvR8qLiJ/ozDMIYYXaTr9Dy4uC3d4rdclt/bsEwXmIeJRC88
         g7jvO+1wfRx9ouhH4vRULl1++GpjsaJ8nNpsTAc4So9WQzLU7TwRVD+5Iyjq3+nRiMcn
         O+dwMl0l5BysXqihIbmD5sIyXFdaE6lo7hDbD6vYiWL3Ltt1BJF2lFUqk3nNRVkgF/Pq
         bap0S6UMh2LuYCh6xE+27JcliUPgEv9zg8wnF6J9zahSLSmfdl4u8C7v7vzRqKvfLLAd
         d8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWha1hYlnBiTgL6iFwhKHpP+CutqMxriFR0fkFo5XC8edxEaH3I06Dd/LkhT3mE3qVQa7C+0LHvNkp6iU3wkizRmJkz3Nu6uNQJFSu9mUW9qIb9qZAdxzS0+0Bzcm3T2YF3nenIVroAPsDElOoF/51Hh/rF1AT8ImYTwD1718xJDKUs1ESPv+T5gokiNf8JHhjC8AwsZbrcP1u2dCnrfup2aIPGBq2QaG+J/dR8WBh2UW9TpU0SuTcEWvikKooJNpslCKOFfYiHbO1sr5yit5Crh+rWLuj6jp1E/g==
X-Gm-Message-State: AOJu0YxtVb9s8WT3ZS+6mtGJUhht/J1hrYJ1V1uRl1Mf0ipmIa/jX1jk
	V2gXL8s8ENYLDpiI3t3maZvRU+sV7ijSlZjuHZFL9PxVDqxmRCqba5CvQjddjq4G/ej/hBN4lX7
	tXHrPVxEfg6m7NupwLtC6wncljXQ=
X-Google-Smtp-Source: AGHT+IEB/YPizRPdSM8g0e75qq4Trwgwdg1LF6SZVgxJUmKpI+Q9QIjihr7HmFgR5GDbRJDy4Pav6rzymzHVBMyXxJg=
X-Received: by 2002:adf:ea06:0:b0:33e:48f9:169d with SMTP id
 q6-20020adfea06000000b0033e48f9169dmr403840wrm.31.1710208301974; Mon, 11 Mar
 2024 18:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com> <20240311093526.1010158-6-dongmenglong.8@bytedance.com>
In-Reply-To: <20240311093526.1010158-6-dongmenglong.8@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 18:51:30 -0700
Message-ID: <CAADnVQKw4HUbwvivysVBQPpA2MC2e56MwrvJy89qs8rx_ixOnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf: verifier: add btf to the function
 args of bpf_check_attach_target
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
> Add target btf to the function args of bpf_check_attach_target(), then
> the caller can specify the btf to check.
>
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> ---
>  include/linux/bpf_verifier.h | 1 +
>  kernel/bpf/syscall.c         | 6 ++++--
>  kernel/bpf/trampoline.c      | 1 +
>  kernel/bpf/verifier.c        | 8 +++++---
>  4 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4b0f6600e499..6cb20efcfac3 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -811,6 +811,7 @@ static inline void bpf_trampoline_unpack_key(u64 key,=
 u32 *obj_id, u32 *btf_id)
>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>                             const struct bpf_prog *prog,
>                             const struct bpf_prog *tgt_prog,
> +                           struct btf *btf,
>                             u32 btf_id,
>                             struct bpf_attach_target_info *tgt_info);
>  void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d1cd645ef9ac..6128c3131141 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3401,9 +3401,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog=
 *prog,
>                  * need a new trampoline and a check for compatibility
>                  */
>                 struct bpf_attach_target_info tgt_info =3D {};
> +               struct btf *btf;
>
> -               err =3D bpf_check_attach_target(NULL, prog, tgt_prog, btf=
_id,
> -                                             &tgt_info);
> +               btf =3D tgt_prog ? tgt_prog->aux->btf : prog->aux->attach=
_btf;

I think it's better to keep this bit inside bpf_check_attach_target(),
since a lot of other code in there is working with if (tgt_prog) ...
so if the caller messes up passing tgt_prog->aux->btf with tgt_prog
the bug will be difficult to debug.

> +               err =3D bpf_check_attach_target(NULL, prog, tgt_prog, btf=
,
> +                                             btf_id, &tgt_info);

