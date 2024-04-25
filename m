Return-Path: <linux-kselftest+bounces-8898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74328B2DBB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E788284DA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA2F15687B;
	Thu, 25 Apr 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey2xjvet"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE3155A5B;
	Thu, 25 Apr 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088517; cv=none; b=EWiorQDCjgaL4b945ZTqPUBL/q3rgGdEPgBpknR6vwQwSKd+hayT3Ew6Tz9q2ElpkU8f3CuEuc70Q2ISKCCjhtVcmt9uMYYwfQgqoT28hmTACyrStGjaSr/1vKpPWYLTW6ZmPRurpuXkUbY5fp8nS9sgBBEXiAeNFEYjl0sUCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088517; c=relaxed/simple;
	bh=NAiTkuxkkbD9c8rW3xN70apchxD6pvW0WOTm6raiqic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYEXxDhLkuz9GXnfVNeHPJj7hxOYqvW5VGVNHn46nKUHEuhlc10grErw3QfdpoiOK5+wp3ScGF3jPohCnAZr47IBtyRqWdI3isG6099dIoJovAOzmSUU/KkeptumTL57gVMuFFK5o9IszZFDw4Sh0DItuxW5hVgqyXRhWgaaPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey2xjvet; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1156760a12.0;
        Thu, 25 Apr 2024 16:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714088515; x=1714693315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=El8x76wHRKxE4HCz50ygDSth4MBQSoUziJmNW74eGEU=;
        b=Ey2xjvetCj6sLix75xfEJs9hBzCj8SVnc8gRxp64rSvgsCfa5VqAWwEgP8EOGPcVAr
         1FT8IVptEBrUI/BTC+cH70Y8+T2VBp5QderBpEGnwjA1PWchEYURtB4J2+78WAKK2NKX
         InQEf3BGL7YL0zhCPF1oUXO3yFOeY3884ENRd3ojUlWVslY22WZhUMLB8Qqrw2vFrBpc
         wxgWUdwihJJqPgJaA8ETk8bDcauSqvQqXsn35Dap2bycheuMQWDMJNfvLPY9cLEhbWK4
         9vQLa0/T2pxo9Ka7y6+RhFbexWeA6gKJFnj01T4b5YdXMKjsK43PagerMAKAteW075Md
         poIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088515; x=1714693315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=El8x76wHRKxE4HCz50ygDSth4MBQSoUziJmNW74eGEU=;
        b=GbEcuLXjB4FjD1b2rdW/hfHxV+qE8+82GTKS7/cF8Jbn594qlCIvpj6hOww7UQdOfN
         xD+Jh1vtyW0Bgnu6/u+YTS7Ch5aoKzwn3Ax8/l7ghta2JgnK1t8WNBYwUrRlW/HkOVv9
         srbRXAR/tg11Lb2hJhMW99OJvQiFYL7YL3N66oXAygwP7qM21tmzJt3rJDRd0TnhBjb7
         mJhCgD+g67iTgy++0j41BDwHwsiOh5kkMayYUsi354WHxk0l8Zu0HDcx7B0mj3sM0dt8
         JqFrSjAcFEcCiNCaZ2la01MXkZQz51lcp+XA9veDsG45/QRiLO1ZbWQNYR4O609bMpDV
         7aNw==
X-Forwarded-Encrypted: i=1; AJvYcCWOoYrLPIKDvgU+loSHHbgBf1JC051hprIZo4rlWfoCzw7YTVvT5PXX5/74QfjGGPw2xMEWWmXxH1ivnycppGfYvgKld6h2UyewNJHe8v6RvwbFZLMfrugnf8vYOLOUej9Pnf0PjgCZD/mrdfeqySGh61J/JgCFxMYLgRFEfk4zktYJjeDDUDNOYvJGigX3
X-Gm-Message-State: AOJu0YxYjpYTCH6w/W175GyC7AB9McvAfbpLAZor+d1fuTzuuBjwYNaN
	uC8b27d3bobs/M2WoDGtJp9YS0GUfankU5BUT3g9mDz9LND6OmHi2DkZEKA7KcHv/kUQvPIA0W1
	GzgCVqzRRfWuEaeX1mH2bSHsrdf8=
X-Google-Smtp-Source: AGHT+IGFxPiq/FD/XFTLk5//+ARqz6WwnTsxIeUmYAp8pLMd8o9lt4NpjR0CMLYvzmnNMOz8CHc3IBNYkQ4OG5qH8GI=
X-Received: by 2002:a17:90a:e2d1:b0:2af:2be3:89c5 with SMTP id
 fr17-20020a17090ae2d100b002af2be389c5mr1108922pjb.29.1714088515317; Thu, 25
 Apr 2024 16:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com> <20240411122752.2873562-7-xukuohai@huaweicloud.com>
In-Reply-To: <20240411122752.2873562-7-xukuohai@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 16:41:42 -0700
Message-ID: <CAEf4BzapNjmhBYC1YsmwBFNP7rdans9X2StkQ3uQDhAyf7Py7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/11] bpf: Fix compare error in function retval_range_within
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Khadija Kamran <kamrankhadijadj@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:24=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> After checking lsm hook return range in verifier, the test case
> "test_progs -t test_lsm" failed, and the failure log says:
>
> libbpf: prog 'test_int_hook': BPF program load failed: Invalid argument
> libbpf: prog 'test_int_hook': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
> 0: (79) r0 =3D *(u64 *)(r1 +24)         ; R0_w=3Dscalar(smin=3Dsmin32=3D-=
4095,smax=3Dsmax32=3D0) R1=3Dctx()
>
> [...]
>
> 24: (b4) w0 =3D -1                      ; R0_w=3D0xffffffff
> ; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
> 25: (95) exit
> At program exit the register R0 has smin=3D4294967295 smax=3D4294967295 s=
hould have been in [-4095, 0]
>
> It can be seen that instruction "w0 =3D -1" zero extended -1 to 64-bit
> register r0, setting both smin and smax values of r0 to 4294967295.
> This resulted in a false reject when r0 was checked with range [-4095, 0]=
.
>
> Given bpf_retval_range is a 32-bit range, this patch fixes it by
> changing the compare between r0 and return range from 64-bit
> operation to 32-bit operation.
>
> Fixes: 8fa4ecd49b81 ("bpf: enforce exact retval range on subprog/callback=
 exit")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 05c7c5f2bec0..5393d576c76f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9879,7 +9879,7 @@ static bool in_rbtree_lock_required_cb(struct bpf_v=
erifier_env *env)
>
>  static bool retval_range_within(struct bpf_retval_range range, const str=
uct bpf_reg_state *reg)
>  {
> -       return range.minval <=3D reg->smin_value && reg->smax_value <=3D =
range.maxval;
> +       return range.minval <=3D reg->s32_min_value && reg->s32_max_value=
 <=3D range.maxval;

are all BPF programs treated as if they return int instead of long? If
not, we probably should have a bool flag in bpf_retval_range whether
comparison should be 32-bit or 64-bit?

>  }
>
>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
> --
> 2.30.2
>

