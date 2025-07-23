Return-Path: <linux-kselftest+bounces-37876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E0B0F164
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F4B7A934A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3ED2E0924;
	Wed, 23 Jul 2025 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8nScVSA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A119230268;
	Wed, 23 Jul 2025 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270714; cv=none; b=Qlk2r/+0XJlrn/tGlupUI/jSwybGI2oYHfQHe0CkV5/LhVZWbXXGl3yl9dYmzMWE7m63kQ67qHOYyaYNBf4+dj4eQFv9lQAA616g+/dJFxWDZtp4+J7HuGE5dpabi4RzOU90FeSqul7vKL3cHsCfkkX2+deN4JaDbfX6ucF1KZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270714; c=relaxed/simple;
	bh=3xNIgfbZkuKToBVIaIN0T6qtZj1CAu2xNWY1oErB7vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsVGl/ahge8Y7PTfHE1AvmDEd1iY1ZlFgJ9JIwIZ6O8/LaziAr096OnwB8ECqa6j2z6JNeKjlDfBFJ99Iv7bbnSdRCmTz8QU9ut+ppTClQBiKfJCPW3cnaBHJu9RB2iIq7Agbf/rx4aoZ2HA67i4OupnYFw/7uNizII7m2u/yDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8nScVSA; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fa980d05a8so44396746d6.2;
        Wed, 23 Jul 2025 04:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753270711; x=1753875511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW8o4VpBFB3CJWAxgh6hNHP7douwh8bC//NQp5568N4=;
        b=I8nScVSAy0AMeq43njTSqQJXOfYNxyLJ5a+IkhOhifKEByjgoNLfP8ea+9NL9YeLAu
         5ulkjqE4eBmflI9ayvm9Q6fiXcVShriMYpkx5datKfqlAn6XTcA1c3H5bN/mY/cOhaZz
         OOXQ9d2eVPwNMWe0CMB67DROtTjPbAzTMkcUk27XNJJ8zDev5ui3gFnE0ywcru8OjjHV
         6jeA7TW/u/nCcxX/N9ANhxJGR1lHTTrlJsc1a+94OZJVpDv9PgikyTSvfza7RKzYRJ34
         Qrg1Rm53hncJgrFRvtuWFgqwWMRzvH72EoEM0HI+uLF7wJziJ7E3m0FY3tlejOFGkif+
         edew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270711; x=1753875511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW8o4VpBFB3CJWAxgh6hNHP7douwh8bC//NQp5568N4=;
        b=DpDq64y87otuH+hV9/Del8XUrFnB0+CFx1zPi92Kqo+i193ZELjpHZZFamdgNof+67
         KrYzVqw3ImbBKpjMUzSGT0EgriJ6sVucE19z5GLCryOvDbON4zsZFfeO3pVDfsoCC+Y5
         4GinYseF7Q8Kcu0POv6y02u1OkHVogwMMceCyL47wg1k8qDnh5RptrWHg8VMPdUuYsE8
         Iwqj6mfK3qneIkBVjbz45cfXx/1+vbePmYZGMK90rFt3gkOiEHIiNO2LSMuAibwAcjMq
         VAPaR2PVmZs7Q06apBA1/qecoeBcRLi3gPVCkI4tB3xfpr0Kyo/wJuxAAOUnZctLw/+Z
         e/SA==
X-Forwarded-Encrypted: i=1; AJvYcCUUUL+ewwGqtM4rVd7rOVHLwEU0+Hmlmq15BTc9bb2Q3YpzyjWa6JBGGCeR2mAzm1QlJZSPh4v0Wt7/RnboO0Kh@vger.kernel.org, AJvYcCV7QbutCXUgWTRooar29VagJrQyvfAhzCdvHY+I60yZDLwqN6+iMVszc1SfEx5Ov+AjPEsJNUlwLNHFZWG9@vger.kernel.org, AJvYcCVro313zHL4BFESIffZjB9riO49Hh1l3lnKb4H55afyG/g3Gpx2ZaLw4iQ82etTvtJkQhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XMN7pmRx4smdpV6/RHO0Vhpcm1WrT6dX+vs/6XJPDKlEwjK1
	QYuxNsjeAYYuph34bKh1aDdW4g0q/MKQgfPOjWQZzkIKvx9atlhx6xC1a7ElkZWhKWMiRFYxPiT
	8OTSar5AhSUd3cXQACMi7339piZHrabQ=
X-Gm-Gg: ASbGncslPWnNsXD7qshd2IHRR0sME3KLCiZ1u4tqs9Yhkz+ZdpHgfDiap8MB4q6kfaM
	BQWxoOKjs7Bc2eNrnHiomDttkWyAeGCkmvV87FhXIrAUvjIVEvR4SEo1QFfA2FrJfSmhrFMnvT7
	kD7UpoOtpR8xk60VDen65ENq8Ha0PNUos5W11UmjlkDMo90lR3jDRD+OdVWzXpBP91Whfa0UN8z
	ZFHiANF
X-Google-Smtp-Source: AGHT+IEjlRHPDytTHYrrd955Vf1ODftEruHfWOsFzh9HDDs6+tB8jBjR8Lw+tapL9nDRT/0PVtC+I5YRsiTIzT6WO0s=
X-Received: by 2002:a05:6214:f08:b0:6fd:5cf4:cbb0 with SMTP id
 6a1803df08f44-70700651e04mr33085726d6.25.1753270711509; Wed, 23 Jul 2025
 04:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722153434.20571-1-kafai.wan@linux.dev> <20250722153434.20571-3-kafai.wan@linux.dev>
In-Reply-To: <20250722153434.20571-3-kafai.wan@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Jul 2025 19:37:55 +0800
X-Gm-Features: Ac12FXyoLyhROuZ3og-7LF8VQDwAYshHthJdDYvrXEO7gAj--0Brx3rF8n6nXvU
Message-ID: <CALOAHbCtiBFZP8GF63g1HmKWko_35uj34+wx5K3QU95QDLaedg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Add log for attaching tracing
 programs to functions in deny list
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:35=E2=80=AFPM KaFai Wan <kafai.wan@linux.dev> wr=
ote:
>
> Show the rejected function name when attaching tracing programs to
> functions in deny list.
>
> With this change, we know why tracing programs can't attach to functions
> like migrate_disable() from log.
>
> $ ./fentry
> libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
> libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
> Attaching tracing programs to function 'migrate_disable' is rejected.
>
> Suggested-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/bpf/verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 00d287814f12..c24c0d57e595 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23942,6 +23942,8 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>                         return ret;
>         } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
>                    btf_id_set_contains(&btf_id_deny, btf_id)) {
> +               verbose(env, "Attaching tracing programs to function '%s'=
 is rejected.\n",
> +                       tgt_info.tgt_name);
>                 return -EINVAL;
>         } else if ((prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT ||
>                    prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN) &=
&
> --
> 2.43.0
>


--=20
Regards
Yafang

