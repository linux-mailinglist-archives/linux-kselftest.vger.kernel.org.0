Return-Path: <linux-kselftest+bounces-40011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C4B3753F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1461B68471
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CC42FD7AA;
	Tue, 26 Aug 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+6utR/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580C26A0C5;
	Tue, 26 Aug 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249739; cv=none; b=rMwJab8GvL6DxXYmGz4/3iToOk649XmbmU9wioZjWi3oYcilE4PHoXMEcH47KLPl1Wk38Co4DRx9I0S24I9vssh6CUxMZ8LmoOwlKBJet4LRrOMEHbn8GEvDybKP233xY3CbvA+WFTjKOzKfBvoahNDiWdvA3FPodgkFnr9MgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249739; c=relaxed/simple;
	bh=eQNge0oBgnqKjHfN/+W75hiMSHdm2jcSAqAv41RLCeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILM8hwKykmulZUc28l2F4nxhH8aIrLSL9sh+rCVgB8FOsDNRP7tvLe0pZC/ODkMtUCmGf4N320LATyyRgG+RyulKfElZGr7HR7QMLVxU2a/3DNFT31KP/DoUeyDQH3wiaptp5AqREZpQZTbBPdIVjRQ2PAo8Jxp1I04r1Gmc4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+6utR/k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2467de5160eso32377945ad.0;
        Tue, 26 Aug 2025 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756249737; x=1756854537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63HTF+b4OECDQd20yfAD8fXTGHyJIIOxjPNFc1FyV4Q=;
        b=Z+6utR/kzANko5P7x0rSAYbTcLPfiYNyFqneQZL4wCb53mXizM+5Ptq0VsK0Bq6zdc
         a1RwSAyg//wHNOIu7Pyn4M1S+h6cmPmCtPGRr85sxmKkOxDtFAxc05eo029Qx21M6nQf
         ffG9XKhNNoU/85OZfSAko9e7WlebdfhTCkTCFLVSQgVAep1qlOewerOE6BKZ1qQ/Zei8
         Qxu7vDDZxGJOFkwjNTt2PXishRDKA0YPfeR+RmBYVDoelLhNzV6za9t+7XfwNXVD+07h
         Rrge5KNFlFWNXuS2164SRCdBA0o4mJfzb6vIiXtDVYTgYzGH6ovaty8svk+mczJvPbXM
         iEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756249737; x=1756854537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63HTF+b4OECDQd20yfAD8fXTGHyJIIOxjPNFc1FyV4Q=;
        b=fjieF2Tw8h27J2GsjY4zD0ncp2oQk5wLd42UGF02Pt8dxmqDHfgqdYPm6zKxzoPOES
         EM/skBqsXuXW2k6YUwi+OWNCDnPle2Y9uVeXJZuTjUuIoWirpArStvJDNeRtAv87QDaQ
         0zCA1PZdEA2xWahZjWM1TC+2/EQPf23xgdO4YG7VT3nE1BEcmOsU62wVmnzPEl9E9g+G
         JfVj8cqUnWG/vjsfkr7vKcivw+Ttk27WJPEfoA5ssUvBjZw8Z/OIxdqsIbV8SqzgUUFC
         epcpl1Ci85/qfNjaaC/tdCT1IKfOrCc78hg9De9iLypWdu2xevEgnw7plFlFtsW8I2uj
         q/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/csm2PI6itvL0eDzaA8xt6QYT7XDLtkR0H+xt2Xz0ujr/HOk8M3L72r9FNyD4gd2g5mE=@vger.kernel.org, AJvYcCWj2LRIsOl0Q9zMFEFpaiHbI2+yuj+7/cZpOEQP+zAUH1e27Xc0PHtkq6V7XI0CW5GBK+gb7+5/Iu2l8fgfj0ui@vger.kernel.org, AJvYcCXwWxkKw5C2bMobei3gzqwL3Jp0bcJuRucpesZhOmWSq/x73IM79pxu1fZEVeX0RxfVc15cZvpfChNocFEK@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSfmWJ9QYq7kztMfHXZgAqhPzllT0oI6x7anvQtpHEfg9K3Tb
	S6hdplTepVAzfGFS3Ap1mOOjtvh9Y81kIZqcjAR7cUiP68v9KjEDDja80tNe++rH6wKxui8fl9s
	oQ/lx7nudy8Po0izZM7j9FQjo94K18QpqWg==
X-Gm-Gg: ASbGncs+Dqk0RGoJeyjhGG0pk2r1u4tgd0OsxhuGD2NDiuM7E2Tm+si09zMQLl4cmWB
	rdJiSAi1XUhaHuf0zhSGnOoRmxd6mqCGws8jH9M/V+wsL3TocoVT0rwczG+Y2cXiDrSHLih8RIL
	4i4DlfomhLmhycwYxOeyYeWngZaPO8qOJLoR4UbeAqFYlmNkt5DnZ822lMMYy3yHI8auEoWv+23
	uU8Btpzw9Y+ADke2T6/xPU=
X-Google-Smtp-Source: AGHT+IGICIrok0wT9w96gzyLr9/4F1ryBXZUaWGqESSwI0ufWXKCZ98Tvy2GRwgxQTcpvDVt/UHvX5Rpz9+jmn3U/u4=
X-Received: by 2002:a17:903:1986:b0:240:9ff:d546 with SMTP id
 d9443c01a7336-2462edecb1cmr255887195ad.6.1756249736759; Tue, 26 Aug 2025
 16:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823071839.1191350-1-phoenix500526@163.com> <20250823071839.1191350-2-phoenix500526@163.com>
In-Reply-To: <20250823071839.1191350-2-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Aug 2025 16:08:41 -0700
X-Gm-Features: Ac12FXxKfYwP1XEYR7VzIK629v0rIgXdAdIquPTgehYX9H275WR-MjTLnq_9rEg
Message-ID: <CAEf4BzaxuYijEfQMDFZ+CQdjxLuDZiesUXNA-SiopS+5+VxRaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v15 1/2] libbpf: fix USDT SIB argument handling
 causing unrecognized register error
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 12:19=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com=
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
>  tools/lib/bpf/usdt.bpf.h | 44 +++++++++++++++++++++++++++++--
>  tools/lib/bpf/usdt.c     | 57 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 94 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 2a7865c8e3fe..2000b0aead75 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -34,13 +34,32 @@ enum __bpf_usdt_arg_type {
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
> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
>         /* arg location case, see bpf_usdt_arg() for details */
> -       enum __bpf_usdt_arg_type arg_type;
> +       enum __bpf_usdt_arg_type arg_type: 8;
> +       /* index register offset within struct pt_regs */
> +       __u16 idx_reg_off: 12;
> +       /* scale factor for index register (1, 2, 4, or 8) */
> +       __u16 scale: 4;
> +       /* reserved for future use, keeps reg_off offset stable */
> +       __u8 __reserved: 8;
> +#else
> +       __u8 __reserved: 8;
> +       __u16 idx_reg_off: 12;
> +       __u16 scale: 4;
> +       enum __bpf_usdt_arg_type arg_type: 8;
> +#endif
>         /* offset of referenced register within struct pt_regs */
>         short reg_off;
>         /* whether arg should be interpreted as signed value */
> @@ -149,7 +168,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, =
long *res)
>  {
>         struct __bpf_usdt_spec *spec;
>         struct __bpf_usdt_arg_spec *arg_spec;
> -       unsigned long val;
> +       unsigned long val, idx;
>         int err, spec_id;
>
>         *res =3D 0;
> @@ -202,6 +221,27 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num,=
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

I still have a mild preference for bitshift just because it's a tiny
bit more efficient in terms of CPU cycles and needs one bit less in
arg_spec representation. I just don't see why not stick to bit shift,
that scale factor has to be a power of 2 always, so it's natural to
use bit shift.

But overall looks good now, thanks.

> +               if (err)
> +                       return err;
> +#if __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> +               val >>=3D arg_spec->arg_bitshift;
>  #endif
>                 break;
>         default:

[...]

