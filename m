Return-Path: <linux-kselftest+bounces-40115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F82B38EBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E243A91C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A82F0693;
	Wed, 27 Aug 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeIf4OrQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005828DF36;
	Wed, 27 Aug 2025 22:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335055; cv=none; b=l2/0EnSm1+po6Is9LPHxv4YlluQfoM7vVyyHW6myMb4wIXGIrQsb7giUE6eWpec1gFpSvTbzjIzXYmnnNy6+DicXwmTf2lcwCuE4NJKVa7CAvLzw+NVwJdPd/RyFKNlIM3Rc2bg7YvrdEMYWUOtFaiNaJv+AsPH1mFpPOyk7BWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335055; c=relaxed/simple;
	bh=vUmX/vn+a+wEwje5Gerz8t/4Z2TFr0ZQg1+1xDnuO1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUsTI7PMvkE4hWRuWydRAZBn5adAKQSONIAs0QYVkMFmdypcyNLep7HOIdRWsxlnR8jj/8yLXwObcgpGY3wL0m2LNgQw1DnwHOPKRBVzuxEHpXLEKo5oBds03sx6nXGjZOL3wGRBmYE4Z0QeUz1UZ3EdCN4IrqaVKtopKzycB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeIf4OrQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471756592cso282973a12.3;
        Wed, 27 Aug 2025 15:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756335053; x=1756939853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH0ZMkQTqJgFF4M3Hiif3RHQ1h70wIdVN+DAVcLv5fM=;
        b=YeIf4OrQr76lvdpQENWlWQvqtHbfdjVosMsvhSvUx3P41H4DVEkd02gnX0aiocZO44
         k+w2cVlHe/w+q/RsOgjWcOnBiZ3y0rteDZCKSC24fikaXQa1VJSNEUPNu0G4xcp8cr7A
         XK11e05ymP6tr7XzN9vWYNnGYH33AIwMAd5WxFWPpG5jbFGRPhlcRVE2wTPvT4AW/ExE
         EcWV/dYRyOioGqY688anfG+TgmYUG42WqM7bzTSARYhl6CLBsS540IgkbG/uIsQYYVIh
         4Z15cvtlUtns0jvysLtvyKLVg3lcdS3ToyrI7eG7ucLQiefuAMolEFTFgCs/30OEk7gO
         M6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756335053; x=1756939853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH0ZMkQTqJgFF4M3Hiif3RHQ1h70wIdVN+DAVcLv5fM=;
        b=CjaPavV3nsIZpy3NA2MlT9NpIvXWgMOtqYjQ9O8VWbLpwApXEgeVot2yTD6bhcbKEV
         nrLqrWsAH5Zl8I4N1fwta0PYTihCc1TF5ssI0CmURR3cAgpjYRcYZr9mqcPl3VFNrn+8
         VSmd5NUiWqvM7wgi1Pbt5MXWTf+5DpbS7f7V9JGe/QOdsSVg4iuZddi7+p/Q25r/m/Vu
         /Qzd+3+zsxT4wkMrHwo9uPV1ljusJG/va+d5mfhmV+0Qa8QhIsApndTci+w+Gt++3HxK
         ATEwZhFAL99F8wZml01QFxm3inAvSH2TCoG0j4aZOWG+AfFaL5Q0K50l7s8O73Gox2ww
         4GiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAF9pz0lMDfL3wxt77Fv7OcCDo9ffhvPjNV2N+BoyXekugEnfBd4A7IL+y16EZPi+AlLk=@vger.kernel.org, AJvYcCVtjPo9af1Fb0RQSDJxWSJXQq7sUehFHICbV1UhAl+YPGeCgGjFLxopGCCp19o7TVJBnlPehYZaNwvOGtEuj84y@vger.kernel.org, AJvYcCWYQm1gMTM19RlS5BS34rxqtAmoHDZN00t+RRCoHlAeEdNQ9HMRzX4meZwoTSihk2eYkX5FAEZeUWbh18/O@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjvfcTH4S+00N/B3dLmsQURwHkB6dtFlUdq9irOuYyCkwMD4W
	6XnGNhyWVC2wsUEk51kJK/y6g1BSYkWEKJ4YSejDOxBe4rQMUhmaWA33Z6CcBOBl6Blis6VuyM1
	SNzikCOXIMDxSMFy219TahL/YDSkBozelgw==
X-Gm-Gg: ASbGncvs6Swgeax8xENZnOc+G/gvii8ULznYWMpx6ReFfkcnrcGxFMI281myeTSr1yV
	IhA5njz+yclX7i6YePs4+NehC36AFVO7NsysVWe6X8y5GyZdcWn5/aq4t8u1/DEyQOQevBRCXVc
	pFarP7EWwn4IeuIDCaTVgfZ7w3pLvD6Csu44MPLhRw10a1wtWJpbFDWqGBYdmWMcj4FaVwgoo5q
	9Ici73081nKfLEgz/ODP5peBFoq0SefHA==
X-Google-Smtp-Source: AGHT+IGVIV7J+4a4Xnd12gCnkcvgNt1fnxHOhmTL9SD0LZ9Z8pgnOwTtcfsTTgPSkZuyvI4Ym/xunFvMMIfMPfztQ4E=
X-Received: by 2002:a17:90b:258c:b0:325:11d1:1fb with SMTP id
 98e67ed59e1d1-32515ee12ffmr28430937a91.6.1756335053440; Wed, 27 Aug 2025
 15:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827053128.1301287-1-phoenix500526@163.com> <20250827053128.1301287-2-phoenix500526@163.com>
In-Reply-To: <20250827053128.1301287-2-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 15:50:39 -0700
X-Gm-Features: Ac12FXxwUYLjf3rHV2MZaI4a5t3Rjssw34Xw2vBiTNBUlzUi8dDCFG0J6OMTzio
Message-ID: <CAEf4Bzb0y+HM1-VG-vYEckeE=+gcc2=4TWdW_7hngKxGiHtwNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v16 1/2] libbpf: fix USDT SIB argument handling
 causing unrecognized register error
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:31=E2=80=AFPM Jiawei Zhao <phoenix500526@163.com=
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
>  tools/lib/bpf/usdt.bpf.h | 44 +++++++++++++++++++++++--
>  tools/lib/bpf/usdt.c     | 69 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 106 insertions(+), 7 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 3373b9d45ac4..e5eeac0b0fa4 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -200,12 +200,23 @@ enum usdt_arg_type {
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
> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +       enum usdt_arg_type arg_type: 8;
> +       __u16   idx_reg_off: 12;
> +       __u16   scale_bitshift: 4;
> +       __u8 __reserved: 8;     /* keep reg_off offset stable */
> +#else
> +       __u8 __reserved: 8;     /* keep reg_off offset stable */
> +       __u16   idx_reg_off: 12;
> +       __u16   scale_bitshift: 4;
> +       enum usdt_arg_type arg_type: 8;
> +#endif
>         short reg_off;
>         bool arg_signed;
>         char arg_bitshift;
> @@ -1283,11 +1294,58 @@ static int calc_pt_regs_off(const char *reg_name)
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

formatting here was messed up, I fixed it up

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
> +               /* validate scale factor and set fields directly */
> +               switch (scale) {
> +               case 1:
> +                       arg->scale_bitshift =3D 0;
> +                       break;
> +               case 2:
> +                       arg->scale_bitshift =3D 1;
> +                       break;
> +               case 4:
> +                       arg->scale_bitshift =3D 2;
> +                       break;
> +               case 8:
> +                       arg->scale_bitshift =3D 3;
> +                       break;

I made this more compact as well.

BPF selftest looks great, thanks for all the explanations ("d" and "a"
x86-specific register constraints were new to me).

Applied to bpf-next, thanks.

> +               default:
> +                       pr_warn("usdt: invalid SIB scale %d, expected 1, =
2, 4, 8\n", scale);
> +                       return -EINVAL;
> +               }
> +               arg->idx_reg_off =3D idx_reg_off;
> +       } else if (sscanf(arg_str, " %d @ %ld ( %%%15[^)] ) %n",
> +                               arg_sz, &off, reg_name, &len) =3D=3D 3) {
>                 /* Memory dereference case, e.g., -4@-20(%rbp) */
>                 arg->arg_type =3D USDT_ARG_REG_DEREF;
>                 arg->val_off =3D off;
> @@ -1306,6 +1364,7 @@ static int parse_usdt_arg(const char *arg_str, int =
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

