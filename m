Return-Path: <linux-kselftest+bounces-39769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C89B32521
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BEAB05A5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5782D322F;
	Fri, 22 Aug 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbuAsOE8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAC8248B;
	Fri, 22 Aug 2025 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755902602; cv=none; b=qaRkO5U3J1Q9PjfTGjPSWe+Xh7wifwYX2h4Kg/Hd9cTMiqZ9jnGp6EwA3KGgt9JkV+mWtJuA2N2pKI2h01RRugMySwWjERipYSCvcuHnj1ERz2tzxe2JWSbjlpLQDZRz9gLMW4Bglz9M7x2WkcVvxkhRWN6f9dss57aZxCUlD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755902602; c=relaxed/simple;
	bh=vMzq3+B9ubZ2mmOZzZaAGpF5kBREOwvbnK1Avyf3pgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsreWG8C2c9B4MhALUrGYw/GeH8ppENGUYa6+9EiX6VHF25qZYdkZVp2sAanunpo/Spm+E7USkCJj5Rpu/5L5SAtDZ1ZZPlXNERMODVr7nqCJ/lAOX3j0bUGw2ohniONYkZqH/y9LMOxz9Kb/XVxgODZ53xYx+7BrLt/HX89Q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbuAsOE8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so1723462a12.0;
        Fri, 22 Aug 2025 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755902600; x=1756507400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK1lbya6KoH6V7JAq8ojM6FRGpePfBbrYyV4HKtjK8o=;
        b=nbuAsOE8WphHva85H6sHvhufElYSgeiJ+6xsuXiGhZ3wrsisrRcdO4HD8C1+GrIJ11
         zOlEAMgHj/GuMAzEuRz+PhjlA/ZUKpjHJIN/ZqmC7XCaw4/lwj/kg94axBLMhLcTAMwB
         sPPb/p8afG1ITx3iyMN3ap+sugk8Omw+oxfEPjtiG0nxkvPVUiWUXZmPUbhMjRiq5G31
         m8Oz3IMdzD/88dYaKRAHkhcQ+UdsF6+n7NLL/RR1zmlvvjLEOuuVF4YPmZKgP180vFfc
         J55WDn+TBQZyzZQOWYWFvPwZTDzIMOGBsQ4sSX31erXMCpoBFAm+JzD7OXgTsc8GrfcU
         ZSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755902600; x=1756507400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK1lbya6KoH6V7JAq8ojM6FRGpePfBbrYyV4HKtjK8o=;
        b=aswdlHCdiONqjOFLXZXuQe+fMVLuWvvuoH0qCpB4nX8YAbZ8QONJ9lgLa7sFzGDdge
         mqjrSo42c2xhRuz0HwY93mlrzG4IDCpnRjZVeVzDZTPQW9gJv9oP6SEL+LamVPfdgQZj
         rBntQ5M31v2T7W8WtUSmWEbKAfQBzqLbEnLUqMJ0tQmQoX+Gk9VLBOmOws0zpWhyjbyN
         e7Jxcszz1ffF5M0+XH3dglWRlHaKOIlME+Ybfek9LOLTRL1QoWMSqNC4mWSTO438SgYJ
         qZx+xEGkwQqknRKTRdKQkH4LpGJYs+MnqpoFLTezaaO4S4FpDzJJiupv7DghCgkauVjt
         rhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm9KUyMivd3VPUrozt0o7Nv+kNNlKqyydHluojlqNqCZrB3YigUTvpf1d+vwALFvpTMP4=@vger.kernel.org, AJvYcCWOQqRGaPCI4KzSOIKzyrk6peeoIH1srskHRqaLn8BRgSm1UNhuG2YmsaXq+4NZlqXQZS39wUMAmjKVfDWc@vger.kernel.org, AJvYcCX4jvjsLjXLB5Gs3Xp9nmXCbKtuUHbK23vxjEzGBZYMLF8BZstJITLfLixTWzqifN8M6DrYlL1ryec2oXpeLbLw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpbtzj+to5Z7SOhIDpWHrh9dWIVTHpJIIVZJn+3kZ3GBTgbv3C
	JK/LDroocrTyrQbazR84iUXu5gLjs+RdcPiDbVsxMASABb1HJKzEa3plcUjTzXU9sLmQs+O2cg3
	c2RyQZhaqD1EoOZDwKOBRGuVplTpSrws=
X-Gm-Gg: ASbGncvDpf8IE0Sf6QSgTVFEx9E2jX2crmyCPjwNZcssQ+BCbid8ET5SbHsgNkjm09L
	YfNPC/h0wGPZ2Z1T0ThO1zwFo04s6eD4hHwdayIRtN2tX+vxMLr8zJZxUF9RKFPVnuY8L9dkAs/
	o0W7Df6vVTwWyPj4LrgGYMPk841D5JQMvGVSaaWYnKEmTuLE6owmP4qdS1UrPaCpEUFg+VCBpuJ
	275upiPU08nUeVx/TZBIVM=
X-Google-Smtp-Source: AGHT+IE6/vTbooKfLf8kh+m4wm3vpWU0kf++qkaOeIf6RA1rKvHK+PMo1MsRZcM6zftXBaoXzDimbRnf/P/UsUxGlc0=
X-Received: by 2002:a17:90b:2ccd:b0:321:4760:c65a with SMTP id
 98e67ed59e1d1-32517d1e054mr6004941a91.27.1755902600320; Fri, 22 Aug 2025
 15:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822151611.1084244-1-phoenix500526@163.com> <20250822151611.1084244-2-phoenix500526@163.com>
In-Reply-To: <20250822151611.1084244-2-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 15:43:06 -0700
X-Gm-Features: Ac12FXyQNkHYmcbQ-ISYNAS-d6YGlVmunznK9bMY-22ab-q11Un65y8Nrqqva20
Message-ID: <CAEf4BzZWd2zUC=U6uGJFF3EMZ7zWGLweQAG3CJWTeHy-5yFEPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 1/2] libbpf: fix USDT SIB argument handling
 causing unrecognized register error
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 8:16=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com>=
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
>  tools/lib/bpf/usdt.bpf.h | 47 ++++++++++++++++++++++++++++++--
>  tools/lib/bpf/usdt.c     | 58 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 98 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 2a7865c8e3fe..263168d57286 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -4,6 +4,7 @@
>  #define __USDT_BPF_H__
>
>  #include <linux/errno.h>
> +#include <asm/byteorder.h>
>  #include "bpf_helpers.h"
>  #include "bpf_tracing.h"
>
> @@ -34,13 +35,34 @@ enum __bpf_usdt_arg_type {
>         BPF_USDT_ARG_CONST,
>         BPF_USDT_ARG_REG,
>         BPF_USDT_ARG_REG_DEREF,
> +       BPF_USDT_ARG_SIB,
>  };
>
> +/*
> + * This struct layout is designed specifically to be backwards/forward
> + * compatible between libbpf versions for ARG_CONST, ARG_REG, and
> + * ARG_REG_DEREF modes. ARG_SIB requires libbpf v1.7+.
> + */
>  struct __bpf_usdt_arg_spec {
>         /* u64 scalar interpreted depending on arg_type, see below */
>         __u64 val_off;
>         /* arg location case, see bpf_usdt_arg() for details */
> -       enum __bpf_usdt_arg_type arg_type;
> +       enum __bpf_usdt_arg_type arg_type: 8;

this needs to be inside the #if/#elif/#else, I believe. When it
previously was a 4 byte field, BPF_USDT_ARG_REG =3D 1 would be `0x01,
0x00, 0x00, 0x00` in memory on little endian and `0x00, 0x00, 0x00,
0x01` on big endian. So you need to reorder it such that on big endian
it's the last field.

pw-bot: cr


> +#if defined(__LITTLE_ENDIAN_BITFIELD)

I'm not sure whether compiler itself defines __LITTLE_ENDIAN_BITFIELD.
Throughout libbpf we use #if __BYTE_ORDER__ =3D=3D
__ORDER_LITTLE_ENDIAN__, let's do that here as well?

> +       /* index register offset within struct pt_regs (high 12 bits) */
> +       __u16   idx_reg_off: 12,
> +       /* scale factor for index register (1, 2, 4, or 8) (low 4 bits) *=
/
> +               scale: 4;

nit: don't do comma-separated bitfields. compiler will combine them as
necessary, even if they are declared as separate fields. so just:

#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
enum __bpf_usdt_arg_type arg_type: 8;
__u16 idx_reg_off: 12;
__u16 idx_reg_shift: 4;
__u8 __reserved: 8;
#else
__u8 __reserved: 8;
__u16 idx_reg_off: 12;
__u16 idx_reg_shift: 4;
enum __bpf_usdt_arg_type arg_type: 8;
#endif


Note that we don't need to change order of idx_reg_off and
idx_reg_shift, as they are new additions (and they don't have to be
consistent between big and little endian)

> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +       /* scale factor for index register (1, 2, 4, or 8) (high 4 bits) =
*/
> +       __u16   scale: 4,
> +       /* index register offset within struct pt_regs (low 12 bits) */
> +               idx_reg_off: 12;
> +#else
> +#error "Please fix <asm/byteorder.h>"
> +#endif

let's drop the fix suggestion, isn't asm/byteorder.h kernel-specific
header?.. I'm fine assuming only big or little endian system

> +       /* reserved for future use, keeps reg_off offset stable */
> +       __u8 reserved;
>         /* offset of referenced register within struct pt_regs */
>         short reg_off;
>         /* whether arg should be interpreted as signed value */
> @@ -149,7 +171,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, =
long *res)
>  {
>         struct __bpf_usdt_spec *spec;
>         struct __bpf_usdt_arg_spec *arg_spec;
> -       unsigned long val;
> +       unsigned long val, idx;
>         int err, spec_id;
>
>         *res =3D 0;
> @@ -202,6 +224,27 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num,=
 long *res)
>                         return err;
>  #if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
>                 val >>=3D arg_spec->arg_bitshift;
> +#endif
> +               break;
> +       case BPF_USDT_ARG_SIB:
> +               /* Arg is in memory addressed by SIB (Scale-Index-Base) m=
ode
> +                * (e.g., "-1@-96(%rbp,%rax,8)" in USDT arg spec). We fir=
st
> +                * fetch the base register contents and the index registe=
r
> +                * contents from pt_regs. Then we calculate the final add=
ress
> +                * as base + (index * scale) + offset, and do a user-spac=
e
> +                * probe read to fetch the argument value.
> +                */
> +               err =3D bpf_probe_read_kernel(&val, sizeof(val), (void *)=
ctx + arg_spec->reg_off);
> +               if (err)
> +                       return err;
> +               err =3D bpf_probe_read_kernel(&idx, sizeof(idx), (void *)=
ctx + arg_spec->idx_reg_off);
> +               if (err)
> +                       return err;
> +               err =3D bpf_probe_read_user(&val, sizeof(val), (void *)(v=
al + (idx * arg_spec->scale) + arg_spec->val_off));

hm.. I thought we discussed recording the number of bits to shift by,
no? It's not too big of a deal, we can afford 4 bits (instead of 2
that would be enough for bit shift), but any specific reason you
prefer multiplication here?

> +               if (err)
> +                       return err;
> +#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> +               val >>=3D arg_spec->arg_bitshift;
>  #endif
>                 break;
>         default:

[...]

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
> +               /* validate scale factor and set fields directly */
> +               if (scale !=3D 1 && scale !=3D 2 && scale !=3D 4 && scale=
 !=3D 8) {
> +                       pr_warn("usdt: invalid SIB scale %d, expected 1,2=
,4,8; defaulting to 1\n", scale);

"defaulting to 1" is very confusing, why? (and please use spaces after comm=
a)

> +                       return -EINVAL;
> +               }
> +               arg->idx_reg_off =3D idx_reg_off;
> +               arg->scale =3D scale;
> +       } else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
> +                               arg_sz, &off, reg_name, &len) =3D=3D 3) {
>                 /* Memory dereference case, e.g., -4@-20(%rbp) */
>                 arg->arg_type =3D USDT_ARG_REG_DEREF;
>                 arg->val_off =3D off;
> @@ -1306,6 +1353,7 @@ static int parse_usdt_arg(const char *arg_str, int =
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

