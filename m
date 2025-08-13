Return-Path: <linux-kselftest+bounces-38917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3255B257DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 01:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792FA9A414F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FDB2FC866;
	Wed, 13 Aug 2025 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFlgr3ew"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AC2F60A9;
	Wed, 13 Aug 2025 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129184; cv=none; b=FEEovxzdvznxEvfFSHnBcxkwaGtwdCHTDj0VK1XjAwQgVH+we+rGOZFZONku2yNTJEujIECyU5MD71gZfReAcK9boQvKhWy3UuYlAxacgje9wx5F/kR6aQkWUY02s5/5R5/OyvY2KFFPpZ996CzhOMOqrmvgecKEnMWTpEs+l+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129184; c=relaxed/simple;
	bh=ptSZAwPL2sgYyeOLgmE6vLPRwFuh8EaCAiNWFH99voo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSRSHTrdcn88PNQb96UpS+spdKK8Sicy9F+fXxNfEXv4wMu2yuGLv2eDzsxprCh+M1ykF3v+81O6GgCjiRvKMCc0Jl6vaJ1IiuyHXKTCvn5HXOOTZXXxJ+RTBxftUIWal6EZKezGHjn+HR7SdnbLFeqgfMBnD1In8Vr8H1IVW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFlgr3ew; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445806df50so2403455ad.1;
        Wed, 13 Aug 2025 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755129182; x=1755733982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yibfqhr60YQhJ0vMmSX+PE0La1PBsoeXQ5fzoaqLw9w=;
        b=HFlgr3ew8UBhINKcg6m2JqCB0jsRk5/8O9fUHai838q/9yZNAsPpR70V4tfOkP+rif
         vVMNxGOqFsaYeMF0/+VOx+W8aax/eiXIQ4Ifu3CnDSlEbCB1lH/nhWvGRZhEvqODMMvt
         LeGp1caEp6p6r3hjH3ypW4iZMMjxyGtmt1sr8IWkjNqeQDATgMj19OPx2GMtgS45qI/t
         Q6ercop3SvXTlQYwTXLN1Qr0Zfv2xedPC1ZjxbDbKVyLufwgpSL4Y1MW1sGLkmsTksQW
         RFucSIaxphGWEEkcpSrDNs07y1FBdACXZJBHsFgvl02RKq8lXAz4xpevOwAn6d/rVB93
         lq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755129182; x=1755733982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yibfqhr60YQhJ0vMmSX+PE0La1PBsoeXQ5fzoaqLw9w=;
        b=WYCYdZIiATrldzqOXauHzcHmFj9pUhG9FO/g92gVAS5qOAnHb6E4K1Lq6ttn8OWTDF
         Y962jxk0k+pxDjHE6ilfDRuMSkYcnNRNxmXz2J6P+mQCpN7hoZ+5IiXWxmvaJ9gbYxzz
         Un2Prl3B4j2YskrUHdqsWunb3N5JQigGpuziFcr/HNzMdGdU6vbqvOJzESb1Fw+TKB/a
         S4aAikFuQr2ydn8UrLJ/ARTGZwKxPraT6uMJvx3jBJ0tHFemxsum+H74sAhK51YsDB55
         eG9c+NaUCN7/XirIkjODgrREiZvMdFnqyfgRpujT7J0iDrogx5m2d0xLVxBTYV55w7jc
         j7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjE+yMAlcDSk/RLb7HRJ2juXnFKz+LUn5vEuzEp5SpI4YwYGviH+3SCoNsUMKrYVkUEgVfQ6ZcTfpowcOj@vger.kernel.org, AJvYcCWwPHQaWv47Y9hwXDebtJqrS6VNbspiamVJCtrwvCeg2f1jB0Cb9xcrYZo1lrnRUT8Kxs4=@vger.kernel.org, AJvYcCXxC03+RGBz9efkHfvyRynI6W0G9hmEhaAMqQ9eaOSUegrvYTB4d7x8BBrZFP9HELKV0Dr4ubsmB+IOlRM1bktH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UgW5ThFeztdSvBmIzIbOPacKEWba/uZCUi81E6V0AVXa51FS
	5rZiQkAd1DZ8cHTFNZJEu4eiXHkPI7cF5WpLagmriX/NZFCVS5+iVC0hCvUHrze4uw77/iVy+7N
	gJ1HxPtrzFG54WiN2Ix0xE2+wRxij3T0=
X-Gm-Gg: ASbGncuQFfk6WbU3ccK+1AItRV0d4NWA4TFTpaP9XVD7GlpqNoeig0+XN2XKvMwofPv
	8PzBRgghzboot6BYYECdxqIdFlqupLPITluq+Ywae+SOsGlMcUqP9365+hz236/n1CxtXP2USv3
	504XxFvJ0LKvd01sK2wVw91LvuIFGEqGKRPCc+AOyGYWR8cq5fdjto6RHV0HCBhflUCFrRV17ge
	om6oDDP3K1IA99H8zNxA85MhqJF4yVWjQ==
X-Google-Smtp-Source: AGHT+IHG1GLklcVngaU9qlQXqz0M5cGGN5p3IePoCqy+9brfwmo1IfweQEukdUN7/60gv68it2PhsuycMa83eFV5pXw=
X-Received: by 2002:a17:903:acb:b0:23d:dd04:28e2 with SMTP id
 d9443c01a7336-2445868a8e2mr12595995ad.35.1755129182347; Wed, 13 Aug 2025
 16:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807023430.4566-1-phoenix500526@163.com> <20250807023430.4566-2-phoenix500526@163.com>
In-Reply-To: <20250807023430.4566-2-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Aug 2025 16:52:47 -0700
X-Gm-Features: Ac12FXwjAUH5NapzbRp3zxp00pi90baz3EHSoXXRah97NUC2vemMm_Ypx0Iwwvc
Message-ID: <CAEf4BzaWtO4-JE=++_64y01aWGGBnUSpw_pbQf79rFz_oVhU-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/2] libbpf: fix USDT SIB argument handling
 causing unrecognized register error
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 7:35=E2=80=AFPM Jiawei Zhao <phoenix500526@163.com> =
wrote:
>
> On x86-64, USDT arguments can be specified using Scale-Index-Base (SIB)
> addressing, e.g. "1@-96(%rbp,%rax,8)". The current USDT implementation
> in libbpf cannot parse this format, causing `bpf_program__attach_usdt()`
> to fail with -ENOENT (unrecognized register).
>
> This patch fixes this by implementing the necessary changes:
> - add correct handling for SIB-addressed arguments in `bpf_usdt_arg`.
> - add adaptive support to `__bpf_usdt_arg_type` and
>   `__bpf_usdt_arg_spec` to represent SIB addressing parameters.
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  tools/lib/bpf/usdt.bpf.h | 33 +++++++++++++++++++++++++++++-
>  tools/lib/bpf/usdt.c     | 43 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 69 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 2a7865c8e3fe..246513088c3a 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -34,6 +34,7 @@ enum __bpf_usdt_arg_type {
>         BPF_USDT_ARG_CONST,
>         BPF_USDT_ARG_REG,
>         BPF_USDT_ARG_REG_DEREF,
> +       BPF_USDT_ARG_SIB,
>  };
>
>  struct __bpf_usdt_arg_spec {
> @@ -43,6 +44,10 @@ struct __bpf_usdt_arg_spec {
>         enum __bpf_usdt_arg_type arg_type;
>         /* offset of referenced register within struct pt_regs */
>         short reg_off;
> +       /* offset of index register in pt_regs, only used in SIB mode */
> +       short idx_reg_off;
> +       /* scale factor for index register, only used in SIB mode */
> +       short scale;

I'd really prefer not to increase the size of __bpf_usdt_arg_spec and
not change its layout for all existing BPF_USDT_ARG_* modes just to
not have to worry about any backwards/forward compatibility issues.

Scale can be 1, 2,4, 8, is that right? Instead of using 2 bytes for
it, we should be able to use just 2 bits to represent bit shift (0, 1,
2, 3 should be enough).

We can carve out at least 3 bytes by making arg_type field into packed
single-byte enum (we'd need to be careful with big endian).

Then we can add idx_reg_off:12 and idx_scale_shift:4 somewhere between
arg_type and reg_off, taking 2 bytes in total.

We'll still be left with one byte to spare for the future (and there
are tricks we can do with arg_signed and arg_bitshift, but I'd not
touch them yet).

WDYT?

pw-bot: cr


>         /* whether arg should be interpreted as signed value */
>         bool arg_signed;
>         /* number of bits that need to be cleared and, optionally,
> @@ -149,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, =
long *res)
>  {
>         struct __bpf_usdt_spec *spec;
>         struct __bpf_usdt_arg_spec *arg_spec;
> -       unsigned long val;
> +       unsigned long val, idx;
>         int err, spec_id;
>
>         *res =3D 0;
> @@ -202,6 +207,32 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num,=
 long *res)
>                         return err;
>  #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
>                 val >>=3D arg_spec->arg_bitshift;
> +#endif
> +               break;
> +       case BPF_USDT_ARG_SIB:
> +               /* Arg is in memory addressed by SIB (Scale-Index-Base) m=
ode
> +                * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). Regist=
er
> +                * is identified like with BPF_USDT_ARG_SIB case, the off=
set
> +                * is in arg_spec->val_off, the scale factor is in arg_sp=
ec->scale.
> +                * Firstly, we fetch the base register contents and the i=
ndex
> +                * register contents from pt_regs. Secondly, we multiply =
the
> +                * index register contents by the scale factor, then add =
the
> +                * base address and the offset to get the final address. =
Finally,
> +                * we do another user-space probe read to fetch argument =
value
> +                * itself.
> +                */
> +               err =3D bpf_probe_read_kernel(&val, sizeof(val), (void *)=
ctx + arg_spec->reg_off);
> +               if (err)
> +                       return err;
> +               err =3D bpf_probe_read_kernel(&idx, sizeof(idx), (void *)=
ctx + arg_spec->idx_reg_off);
> +               if (err)
> +                       return err;
> +               err =3D bpf_probe_read_user(&val, sizeof(val),
> +                               (void *)val + idx * arg_spec->scale + arg=
_spec->val_off);

it might be just how gmail renders it, but please make sure that
wrapped argument is aligned with first argument on the previous line

> +               if (err)
> +                       return err;
> +#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> +               val >>=3D arg_spec->arg_bitshift;
>  #endif
>                 break;
>         default:
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 4e4a52742b01..1f8b9e1c9819 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -200,6 +200,7 @@ enum usdt_arg_type {
>         USDT_ARG_CONST,
>         USDT_ARG_REG,
>         USDT_ARG_REG_DEREF,
> +       USDT_ARG_SIB,
>  };
>
>  /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
> @@ -207,6 +208,8 @@ struct usdt_arg_spec {
>         __u64 val_off;
>         enum usdt_arg_type arg_type;
>         short reg_off;
> +       short idx_reg_off;
> +       short scale;
>         bool arg_signed;
>         char arg_bitshift;
>  };
> @@ -1283,11 +1286,39 @@ static int calc_pt_regs_off(const char *reg_name)
>
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_=
arg_spec *arg, int *arg_sz)
>  {
> -       char reg_name[16];
> -       int len, reg_off;
> -       long off;
> +       char reg_name[16] =3D {0}, idx_reg_name[16] =3D {0};
> +       int len, reg_off, idx_reg_off, scale =3D 1;
> +       long off =3D 0;
> +
> +       if (sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^,] , %d ) %n"=
,
> +                               arg_sz, &off, reg_name, idx_reg_name, &sc=
ale, &len) =3D=3D 5 ||

see comment above about aligning wrapped argument list

> +               sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^,] , %d ) %n"=
,
> +                               arg_sz, reg_name, idx_reg_name, &scale, &=
len) =3D=3D 4 ||
> +               sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^)] ) %n",
> +                               arg_sz, &off, reg_name, idx_reg_name, &le=
n) =3D=3D 4 ||
> +               sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^)] ) %n",
> +                               arg_sz, reg_name, idx_reg_name, &len) =3D=
=3D 3
> +               ) {
> +               /* Scale Index Base case, e.g., 1@-96(%rbp,%rax,8)
> +                * 1@(%rbp,%rax,8)
> +                * 1@-96(%rbp,%rax)
> +                * 1@(%rbp,%rax)

nit: let's list all variants at the same indentation level (and let's
use the more standard multi-level comment format)

/*
 * Scale-Index-Base case:
 * - 1@-96(%rbp,%rax,8)
 * - 1@(%rbp,%rax,8)
 * ...
 */

> +                */
> +               arg->arg_type =3D USDT_ARG_SIB;
> +               arg->val_off =3D off;
> +               arg->scale =3D scale;
> +
> +               reg_off =3D calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off =3D reg_off;
>
> -       if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, r=
eg_name, &len) =3D=3D 3) {
> +               idx_reg_off =3D calc_pt_regs_off(idx_reg_name);
> +               if (idx_reg_off < 0)
> +                       return idx_reg_off;
> +               arg->idx_reg_off =3D idx_reg_off;
> +       } else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
> +                               arg_sz, &off, reg_name, &len) =3D=3D 3) {
>                 /* Memory dereference case, e.g., -4@-20(%rbp) */
>                 arg->arg_type =3D USDT_ARG_REG_DEREF;
>                 arg->val_off =3D off;
> @@ -1298,7 +1329,7 @@ static int parse_usdt_arg(const char *arg_str, int =
arg_num, struct usdt_arg_spec
>         } else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", arg_sz, reg_=
name, &len) =3D=3D 2) {
>                 /* Memory dereference case without offset, e.g., 8@(%rsp)=
 */
>                 arg->arg_type =3D USDT_ARG_REG_DEREF;
> -               arg->val_off =3D 0;
> +               arg->val_off =3D off;
>                 reg_off =3D calc_pt_regs_off(reg_name);
>                 if (reg_off < 0)
>                         return reg_off;
> @@ -1306,7 +1337,7 @@ static int parse_usdt_arg(const char *arg_str, int =
arg_num, struct usdt_arg_spec
>         } else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &=
len) =3D=3D 2) {
>                 /* Register read case, e.g., -4@%eax */
>                 arg->arg_type =3D USDT_ARG_REG;
> -               arg->val_off =3D 0;
> +               arg->val_off =3D off;

why this change? it makes it seem like val_off might not be zero, for
no good reason...

>
>                 reg_off =3D calc_pt_regs_off(reg_name);
>                 if (reg_off < 0)
> --
> 2.43.0
>
>

