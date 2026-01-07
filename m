Return-Path: <linux-kselftest+bounces-48383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B5CFC3BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 07:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AECFF3007209
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559842253FC;
	Wed,  7 Jan 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb3aK/Qp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7528E579
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768541; cv=none; b=oY7Bmbl6jWPubH/XvIZEt1diMwffnRaLhrAa20R7EQSh4tEn6omZnZXVOvk/ZgwacSC5byJ9r2ppgIjL5zHM8H8eJV78dKEnH20p0cCMl3bjPOnB2FQ1dib9qIiARnrrVfTejMbAX/VQVtCo9WRuzcDLfNOsqbJhrzByNM4JxZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768541; c=relaxed/simple;
	bh=S6xD0Kn8HIsfxxeCk30mhDmXVRLDmw6dXQGeTnID/Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGlFyeANvA3rnzvSzzEMWeZJG099kJ65B9MZbhLjiBRP8LgNf8t60d8BuHJ/Mtp1KX5FltL+cx6oV1edXC+CFMg+qmzLA97fGtLintjTo5bfZTObI2SmansmrEhyIUYuF+SW5btfm23RPcLSCAFYzZmLGj37TyA3U7qBBx/CZJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb3aK/Qp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso250799866b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 22:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768537; x=1768373337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2dZxNhKtlReqe44kHwkS5EfdRS63SDksuMbrc7UdcM=;
        b=Cb3aK/QpVx3GuwsKPUweC13EFEEbxp3SDF1OkKhQ0DeeejQgeRaYQNfKo4R8NSx9nD
         I1WNUnTfWOdON8PdCxgY+WSUuRy2pLkthdOqc74Basib5O5BIJuULJXLrNdBSAwIm+yv
         nOi1yJ1wFfYCB65UCNZ0LPvpUPOgK6/BHphEky8JKJ0PDAN0jCgdVcbyerhsIt/7zpTq
         PLhZBfNlNiOOCqUwN/1/KTfdGtMU3gtaJ8bHMsf9w8Ri4e73b7xdJWiB0/GzO+Cmwupa
         K613pptU54OoGCHm8pUFDOitiQ1ypMd/pa4Reqf1PjbxaEkoEcnE/OrbKAvZzoTTzThE
         Cl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768537; x=1768373337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2dZxNhKtlReqe44kHwkS5EfdRS63SDksuMbrc7UdcM=;
        b=C/pgm00yYCF1f6dwPe4JWVOQli8fhk8EEK0iuJjKr2YCDgqHMSmwf07hBt4KEr4Bbn
         cVwtmk2hRqhJPJ1c6X6bzus36+svfgfKtpGa+/myW+psAr19fx4pYD+pOdW8T+FqqZcO
         4YY8W3CtWJyahiFK1nqTkezLU7v0PIlvA3BOM9wh0uoaK/de9r/Jfi6qvoVQlw9M6/Ga
         p3QAabmVBMisBUu/FhyCiPYg2f918UONan5kZl/tuBYd3al8f8nJh6clrqil9EKuGW18
         GFkvgLRH1cck+ENYsEv2UsiaqgBq071a/VD5t3Id/PuPlWdE43VKG2NCXMWH+8NKjUUx
         qLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsMwYx66ARzby+29tPO4550LGzoHba9JfiPTW/BHL0jSwh2NOeSBSQpr4ftYO4ZS5PI0BAYQHZTmaxI+fF5Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/rUf01s7CJ48JBO6T1+f078oQ8XWvHfXKoVfNX6lo28wn29ux
	Gxe8epBn1zlFhgj8k8Xm+DqUx9Av64yMa9DD2VQQgSmYdOxRrLrSRLR2S4cdYJRQiDYAnstXauE
	kgp1m4CzdqT44jSjLpSvzj+ZKo483dXk=
X-Gm-Gg: AY/fxX7yySpWkUrcbbizPyUMIifAVbMAlkuNsNMc1KXV6elvvUtGFlfOgwMUxg8mkvR
	3W5BBHh3jtPlu67qFXkOetR49KKZY7ZmwDZKdtBYNw3dhDEXld60xpZVz6auuMW0C/N4zmas4Ax
	icsVCKwvJ+fJY7jZsFAyiAhaXzzNHIQvQqHvqcx4NXotSq5z8ImQzR7Veik+mFMPHVv4Sdfj2Zb
	cEYP10ZCNaGE+X4dpz4l5a4YnwmUPxtWo1OhTTWzZDDfmFS+T+rNGKBQLNomrhQ+GiA
X-Google-Smtp-Source: AGHT+IHlHl6F+1PesRMRom/n6+M4H0wkWSAQIgWCSn+zd87MZSmdpIsPdYLUIFQ6/Yimgy7vWNmJx0VSiDGxGvsoJj0=
X-Received: by 2002:a17:907:9614:b0:b73:398c:c5a7 with SMTP id
 a640c23a62f3a-b844532ae73mr128020566b.41.1767768536654; Tue, 06 Jan 2026
 22:48:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251214163537.1054292-1-geomatsi@gmail.com> <20251214163537.1054292-2-geomatsi@gmail.com>
In-Reply-To: <20251214163537.1054292-2-geomatsi@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 7 Jan 2026 00:48:45 -0600
X-Gm-Features: AQt7F2ofn7FJ7QlpZbnv9-A0r7YP0WHl3m9bO2687jsPenlET5_mYG982nUv5JE
Message-ID: <CAFTtA3Os3P9OC6yxBD6EO5e=FqmQq5dCYQVPXfs9Gpkix26bhA@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] riscv: ptrace: return ENODATA for inactive vector extension
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Thomas Huth <thuth@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Joel Granados <joel.granados@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, 
	Ilya Mamay <mmamayka01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 10:35=E2=80=AFAM Sergey Matyukevich <geomatsi@gmail=
.com> wrote:
>
> From: Ilya Mamay <mmamayka01@gmail.com>
>
> Currently, ptrace returns EINVAL when the vector extension is supported
> but not yet activated for the traced process. This error code is not
> always appropriate since the ptrace arguments may be valid.
>
> Debug tools like gdbserver expect ENODATA when the requested register
> set is not active, e.g. see [1]. This expectation seems to be more
> appropriate, so modify the vector ptrace implementation to return:
> - EINVAL when V extension is not supported
> - ENODATA when V extension is supported but not active
>
> [1] https://github.com/bminor/binutils-gdb/blob/637f25e88675fa47e47f9cc5e=
2cf37384836b8a2/gdbserver/linux-low.cc#L5020
>
> Signed-off-by: Ilya Mamay <mmamayka01@gmail.com>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/kernel/ptrace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index e6272d74572f..9d203fb84f5e 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -95,9 +95,12 @@ static int riscv_vr_get(struct task_struct *target,
>         struct __riscv_v_ext_state *vstate =3D &target->thread.vstate;
>         struct __riscv_v_regset_state ptrace_vstate;
>
> -       if (!riscv_v_vstate_query(task_pt_regs(target)))
> +       if (!(has_vector() || has_xtheadvector()))
>                 return -EINVAL;
>
> +       if (!riscv_v_vstate_query(task_pt_regs(target)))
> +               return -ENODATA;
> +
>         /*
>          * Ensure the vector registers have been saved to the memory befo=
re
>          * copying them to membuf.
> @@ -130,9 +133,12 @@ static int riscv_vr_set(struct task_struct *target,
>         struct __riscv_v_ext_state *vstate =3D &target->thread.vstate;
>         struct __riscv_v_regset_state ptrace_vstate;
>
> -       if (!riscv_v_vstate_query(task_pt_regs(target)))
> +       if (!(has_vector() || has_xtheadvector()))
>                 return -EINVAL;
>
> +       if (!riscv_v_vstate_query(task_pt_regs(target)))
> +               return -ENODATA;
> +
>         /* Copy rest of the vstate except datap */
>         ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ptrace_vs=
tate, 0,
>                                  sizeof(struct __riscv_v_regset_state));
> --
> 2.52.0
>

