Return-Path: <linux-kselftest+bounces-39415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1092B2E88E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C208A24C98
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 23:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B12DCBEE;
	Wed, 20 Aug 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuUd7Q/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D326280312;
	Wed, 20 Aug 2025 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731944; cv=none; b=dAGlNt++krV3gN87BA/DXsoUvQmIRm2JRb3J306kKi2vLWTggO43UAlydcxhf3fNfciujR9djRfpjZA120rvwamF05VcvFWACIs7I6V95m5B6xaMQlg2S3fnhA9aQAW0j5oJabxEABSKANOaNVpGr8Ex92pepvaDfEG+KVv9oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731944; c=relaxed/simple;
	bh=iqzGAZFjug/w8kNZ+o61epNJLgPNR1xyXsXEPgk/KAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GV1xu/n1ZMAFj22mFskvE1DCum3LK+Yy8Bak+AMtqz9lN9/57JoQgxvUSX15+pCrnNI2+/oqXlzegCKr9DfK3k0NEPQDyZDUPx+4/vx9j8MAYasm6NP/8U6xvBSWSFNvGYBcbiYYQ5yWwx5VexqYzr2NwgqDheRYx2fY0SAactg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuUd7Q/Q; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32326e5f058so336477a91.3;
        Wed, 20 Aug 2025 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755731942; x=1756336742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2DaPT2XOk6D3LcbC4bfetPd3RTUKBXLLxlEtr9B3gs=;
        b=AuUd7Q/Qe9PcITslw1kKo6MX+ERIj6f5h3WwHES9ZJyT37K2UcZuVH6UW60yfG0FTw
         Hz3rOljFcZXbPhBUBDOQQOnQfVUzpvB9WcmAwrlGX7+cNejRBkT2gzJFVcttj6F5OkFm
         KbLh5IHP/H+N32aD7KpdjbuhafzgYB8UoTs5R7XSXro7lQgszioAkXDOvYdsq0xHLXPs
         3YjYxcb2gww/6DL+ztOf3+HSWiMBbkwNL4x660Z2MzBBGRDa9bavsXs8D5lifDgNAFHd
         abNJHMOva9BzJ2rqsG38S9wbQoY3Sf7hv71ReDod6+WkBKQomvATzc2dKhJqY0OnUaJU
         G9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731942; x=1756336742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2DaPT2XOk6D3LcbC4bfetPd3RTUKBXLLxlEtr9B3gs=;
        b=OrzNAIqs7U5SLZsYdBiNoPlGeU+dHkmvCLb1DgV9Bu9bX+gls99M8r31NskaxdcuD5
         FizalYrMclTpp+1vt6fjUoc5osx7uUwdbtT1wMxXn5io47fDUwTG4ElwZ3S7TJx8mDox
         kGr955HcLOMROWbmkbvvqWhCgS9Uk020LvY5FPovcO5YW+1kPAhwIadWUBdZyhhtfVQD
         i/spaizOE6AbOA4eoW6f7i/BSAq7Yu1bPZ0rgL22J7TjbAmhZ/yY0hCVFz9FsiWoRj56
         /SkX4I2gv6jyB5fngWvaCqFdgNJUyY2PNLjP/lAc6++pOmHxp9JWpELsoD+Dfhx+rJhE
         AIew==
X-Forwarded-Encrypted: i=1; AJvYcCU7u4FuUEnxMepp4T0wd1zQoRKSx3INPDwJP+gA1a3D1pKuDD6WX4kzZjkBw1Q+WCZosDqA2ntb6+/tuM/A@vger.kernel.org, AJvYcCUvY/Y4ithYQbN6rs32tnE8knrkpLRybgMO6e7KKvHcMbAU0XCncvyXoJE6s1BAcjiNB2s=@vger.kernel.org, AJvYcCW5Zs9KVTZizhv197obO1zEi89gZvsrhzw+bAKyN8XBriETP6vCVAV3B0OIzcVKgh92QrNyPM1GvAHWvQpnxXtn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+AqL7EJYpNDRhEqmP63R/tlQxy1fp2qy7JL+HbKkbb+9f1itU
	zuPUpVyuMNJKENUWhl7Qq+2pEyfFbmqBCAuJN5gkooObstGPu/PbwReVl6FY+w51tW8MiakNsBA
	0b982WSNbGPIR+LCqJfHEoRBaQztiL9I=
X-Gm-Gg: ASbGncs0r17upWMdml+i8NIw7jI7nlNrTAhqiXFN/M3P6i1WV4rC6lNaV+R7RmUPVfP
	VbwOaiEsYykGPfArz8inwhGtXyt/N3aFfEORG44X5QLg+fxjy8U059ELKuW1yD6UZ/sFx0cFMC8
	qbWHcgFEBbgPrW8SoChONZElilCWFr8ceXd830sEYvP5IT8St4DXU0sj3skwiwtL3if67HWuKS2
	8DKi7jaVLiJFol1O/DDqpWHl9O858IIWg==
X-Google-Smtp-Source: AGHT+IFvvQUGBpLi+WnC3exdzAHWSXP5mT4GDkmWFI5OLcisVu98DbxBJYAFhTnhqN+svB8OIfwvSn5mLK16IE6g9BY=
X-Received: by 2002:a17:90b:3802:b0:324:efb4:4634 with SMTP id
 98e67ed59e1d1-324efb455e7mr273905a91.21.1755731941428; Wed, 20 Aug 2025
 16:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074632.433008-1-phoenix500526@163.com> <20250818074632.433008-2-phoenix500526@163.com>
In-Reply-To: <20250818074632.433008-2-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 16:18:47 -0700
X-Gm-Features: Ac12FXwAESWByNFpujbpSmcwI65LrNpPdEGZCZyKNdasULLq7YQiaJgsD83wIuE
Message-ID: <CAEf4BzaRip7ghZ2Z_1yF_OXkno6Na-wcrM5522fDV1c1mLGLpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 1/3] libbpf: fix USDT SIB argument handling
 causing unrecognized register error
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:47=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com=
> wrote:
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
>  tools/lib/bpf/usdt.bpf.h | 54 +++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/usdt.c     | 61 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 108 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 2a7865c8e3fe..1e6de0afe65d 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -34,13 +34,31 @@ enum __bpf_usdt_arg_type {
>         BPF_USDT_ARG_CONST,
>         BPF_USDT_ARG_REG,
>         BPF_USDT_ARG_REG_DEREF,
> +       BPF_USDT_ARG_SIB,
>  };
>
> +/*
> + * To preserve overall layout and avoid growing this struct while adding=
 SIB
> + * extras, we keep 4 bytes worth of space after val_off:
> + *
> + *  - arg_type is stored as a single byte (values from enum below)

this is cleaner expressed with

enum __bpf_usdt_arg_type arg_type: 8;

in code

> + *  - idx_packed is a 16-bit field packing idx_reg_off (high 12 bits)

again, using bitfields make this obvious from code without verbose comment

> + *    and scale shift (low 4 bits, i.e., scale =3D 1 << shift)
> + *  - reserved is one spare byte for future use

this is obvious and doesn't require a comment

> + *
> + * This keeps the offset of reg_off identical to the historical layout

Not just ref_off, but arg_type as well. I'd keep it a bit more generic:

"This struct layout is designed specifically to be backwards/forward
compatible between libbpf versions for ARG_CONST, ARG_REG, and
ARG_REG_DEREF modes. ARG_SIB requires libbpf v1.7+."

> + * (val_off:8 + 4 bytes here), ensuring backwards/forwards compatibility=
 for
> + * non-SIB modes that only rely on val_off/arg_type/reg_off/... offsets.
> + */
>  struct __bpf_usdt_arg_spec {
>         /* u64 scalar interpreted depending on arg_type, see below */
>         __u64 val_off;
>         /* arg location case, see bpf_usdt_arg() for details */
> -       enum __bpf_usdt_arg_type arg_type;
> +       __u8 arg_type;
> +       /* packed: [15:4] idx_reg_off, [3:0] scale_shift */
> +       __u16 idx_packed;
> +       /* reserved for future use, keeps reg_off offset stable */
> +       __u8 reserved;

See above about bitfields. It's cleaner approach and won't need
"idx_packed", it would be just two fields.

We only need to be careful about big-endian, so doing an
#ifdef/#else/#endif and defining different order of bitfields would be
necessary. See how struct iphdr in kernel does this for ihl and
version fields.

>         /* offset of referenced register within struct pt_regs */
>         short reg_off;
>         /* whether arg should be interpreted as signed value */
> @@ -52,6 +70,10 @@ struct __bpf_usdt_arg_spec {
>         char arg_bitshift;
>  };
>
> +/* Helpers to (un)pack SIB extras from idx_packed without relying on bit=
fields. */
> +#define USDT_IDX_OFF(packed)         ((packed) >> 4)
> +#define USDT_IDX_SCALE_SHIFT(packed) ((packed) & 0x000f)

no need for this when using bitfields either

> +
>  /* should match USDT_MAX_ARG_CNT in usdt.c exactly */
>  #define BPF_USDT_MAX_ARG_CNT 12
>  struct __bpf_usdt_spec {
> @@ -149,8 +171,9 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, =
long *res)
>  {
>         struct __bpf_usdt_spec *spec;
>         struct __bpf_usdt_arg_spec *arg_spec;
> -       unsigned long val;
> +       unsigned long val, idx;
>         int err, spec_id;
> +       int idx_off =3D 0, scale =3D 0;
>
>         *res =3D 0;
>
> @@ -202,6 +225,33 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num,=
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
> +               idx_off =3D USDT_IDX_OFF(arg_spec->idx_packed);
> +               scale =3D 1UL << USDT_IDX_SCALE_SHIFT(arg_spec->idx_packe=
d);
> +               err =3D bpf_probe_read_kernel(&val, sizeof(val), (void *)=
ctx + arg_spec->reg_off);
> +               if (err)
> +                       return err;
> +               err =3D bpf_probe_read_kernel(&idx, sizeof(idx), (void *)=
ctx + idx_off);
> +               if (err)
> +                       return err;
> +               err =3D bpf_probe_read_user(&val, sizeof(val), (void *)va=
l + idx * scale + arg_spec->val_off);

you have scale_shift, just (idx << scale_shift) and avoid unnecessary
multiplication and transformations

> +               if (err)
> +                       return err;
> +#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> +               val >>=3D arg_spec->arg_bitshift;
>  #endif
>                 break;
>         default:
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 3373b9d45ac4..0a6499f654fc 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -200,12 +200,15 @@ enum usdt_arg_type {
>         USDT_ARG_CONST,
>         USDT_ARG_REG,
>         USDT_ARG_REG_DEREF,
> +       USDT_ARG_SIB,
>  };
>
>  /* should match exactly struct __bpf_usdt_arg_spec from usdt.bpf.h */
>  struct usdt_arg_spec {
>         __u64 val_off;
> -       enum usdt_arg_type arg_type;
> +       __u8 arg_type;     /* enum value stored as u8 */
> +       __u16 idx_packed;  /* [15:4]=3Didx_reg_off, [3:0]=3Dscale_shift *=
/
> +       __u8 reserved;     /* keep reg_off offset stable */
>         short reg_off;
>         bool arg_signed;
>         char arg_bitshift;
> @@ -214,6 +217,10 @@ struct usdt_arg_spec {
>  /* should match BPF_USDT_MAX_ARG_CNT in usdt.bpf.h */
>  #define USDT_MAX_ARG_CNT 12
>
> +/* Helpers to (un)pack SIB extras from idx_packed without relying on bit=
fields. */
> +#define BPF_USDT_IDX_PACK(idx_off, scale_shift) \
> +       ((__u16)(((__u16)((idx_off) & 0x0fff)) << 4) | (__u16)((scale_shi=
ft) & 0x000f))
> +
>  /* should match struct __bpf_usdt_spec from usdt.bpf.h */
>  struct usdt_spec {
>         struct usdt_arg_spec args[USDT_MAX_ARG_CNT];
> @@ -1283,11 +1290,54 @@ static int calc_pt_regs_off(const char *reg_name)
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
> +       __u16 scale_shift;
> +
> +       if (sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^,] , %d ) %n"=
,
> +                          arg_sz, &off, reg_name, idx_reg_name, &scale, =
&len) =3D=3D 5 ||
> +               sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^,] , %d ) %n"=
,
> +                          arg_sz, reg_name, idx_reg_name, &scale, &len) =
=3D=3D 4 ||
> +               sscanf(arg_str, " %d @ %ld ( %%%15[^,] , %%%15[^)] ) %n",
> +                          arg_sz, &off, reg_name, idx_reg_name, &len) =
=3D=3D 4 ||
> +               sscanf(arg_str, " %d @ ( %%%15[^,] , %%%15[^)] ) %n",
> +                          arg_sz, reg_name, idx_reg_name, &len) =3D=3D 3
> +               ) {
> +               /*
> +                * Scale Index Base case:
> +                * 1@-96(%rbp,%rax,8)
> +                * 1@(%rbp,%rax,8)
> +                * 1@-96(%rbp,%rax)
> +                * 1@(%rbp,%rax)
> +                */
> +               arg->arg_type =3D USDT_ARG_SIB;
> +               arg->val_off =3D off;
>
> -       if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n", arg_sz, &off, r=
eg_name, &len) =3D=3D 3) {
> +               reg_off =3D calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off =3D reg_off;
> +
> +               idx_reg_off =3D calc_pt_regs_off(idx_reg_name);
> +               if (idx_reg_off < 0)
> +                       return idx_reg_off;
> +               /* pack idx_reg_off and scale shift (scale in {1,2,4,8}) =
*/
> +               if (scale =3D=3D 1)
> +                       scale_shift =3D 0;
> +               else if (scale =3D=3D 2)
> +                       scale_shift =3D 1;
> +               else if (scale =3D=3D 4)
> +                       scale_shift =3D 2;
> +               else if (scale =3D=3D 8)
> +                       scale_shift =3D 3;
> +               else {
> +                       pr_warn("usdt: invalid SIB scale %d, expected 1,2=
,4,8; defaulting to 1\n", scale);
> +                       return -EINVAL;
> +               }

keep {} usage consistent within same if/else if/else block (even
though most of branches are single-line, they need {} due to the last
else clause having {})

pw-bot: cr

> +               arg->idx_packed =3D BPF_USDT_IDX_PACK(idx_reg_off, scale_=
shift);
> +       } else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
> +                               arg_sz, &off, reg_name, &len) =3D=3D 3) {
>                 /* Memory dereference case, e.g., -4@-20(%rbp) */
>                 arg->arg_type =3D USDT_ARG_REG_DEREF;
>                 arg->val_off =3D off;
> @@ -1306,6 +1356,7 @@ static int parse_usdt_arg(const char *arg_str, int =
arg_num, struct usdt_arg_spec
>         } else if (sscanf(arg_str, " %d @ %%%15s %n", arg_sz, reg_name, &=
len) =3D=3D 2) {
>                 /* Register read case, e.g., -4@%eax */
>                 arg->arg_type =3D USDT_ARG_REG;
> +               /* register read has no memory offset */
>                 arg->val_off =3D 0;
>
>                 reg_off =3D calc_pt_regs_off(reg_name);
> --
> 2.43.0
>

