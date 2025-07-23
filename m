Return-Path: <linux-kselftest+bounces-37875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EFAB0F161
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B9B562A28
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B52E49A7;
	Wed, 23 Jul 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0e76lPI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4A2E425F;
	Wed, 23 Jul 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270675; cv=none; b=gn2as6eC8dt6NfU7BvgWiANF4Jc3J8dw+bE9w1putoSTDp0gZi6cIaKyDSh17C5Bw+R8AHZBafejcrzU+AkALq3ARu60r/NIYbGNe8MnR3Z3eQApibTokE2SE+k0jY8awpzxLsr96N3BgquDU2uK5D+JyrywLA5Ngz9W6v1e0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270675; c=relaxed/simple;
	bh=ZkcHNvpotnL38pl0rs1lk6tuyqmjt6tu/+Bvckg+BcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crm6hvNx7HVWPl02E4bRGbGbvxyh0r0SgD6wz5wL/ApwDYXNiILY7bQBb7EvOk1n2X7Itp6iofvqfCUSZyK5SekuC9AMMf6IjFXxXXNy9Jp8gVw/qZzPGBK+Kq/jgLoE9AN9ed+de4lQBdDsPNIcSZDZ3VKJ742jGoR92AidCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0e76lPI; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-706f2d1036eso15806976d6.1;
        Wed, 23 Jul 2025 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753270672; x=1753875472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r0acKUtIgG0BNmeCcBirboiV0YSTk5TYAPhMsLxnHQ=;
        b=K0e76lPIp1IfXFF6x6ABSZncAlbXQd/rdunCu4CraXXLCgkgFG5SgQvv/sImwV0jgM
         iT8XtkmiNItgJgzacADdF9BxlFOlMTkprK+eOz3k3iUzYGajhs6SnlBWTOo9D35xcw1i
         Km9BEgr0XDMf5oFrlevHYBHLXpLi4Znfl961S5leAewjf1632bA5Hk4rCyIUjTw4rDG6
         Kypn8xeK17q2CY7uwkxeFdKtvflZBnoARQUg1b6i8Fo5amPE98r51i1IK5jkcAHNazqr
         uk5U6XjYgSEgbAaid81xbBcDXo/ca0TvarHxSkRPmKfNUl8jI5YxkmG02r2s9hfp/unK
         J5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270672; x=1753875472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r0acKUtIgG0BNmeCcBirboiV0YSTk5TYAPhMsLxnHQ=;
        b=dDqzmJ/Awhv7xovySC1Hug+gpNBAZ0cF2M/9ve7CppOSZWRbAW+UZ4Uz5m7Ti76jSs
         gOouZZjKAYTuzBF0b3Ll76tT03Macw7wgb2Se/yC+qYFnnml4s0LO+O1UzSNLC1UYaNR
         kiZe6dyen7GmGb26+YQ3+i1QtaASReptlVl6lltzQRJjCrg9TXIuO3v1ph0xZddZzkMR
         /zE9dbu/g038487mo8mfoM38unHthRoX0sByHGd/E5t+V+pMuOnr+z+3SjQt2Fv6bxoU
         4J3NhajlngmkhGUJSJcSjTAnoMoEkZ6JQ5XrLzbt2Vu88QJ+00gQ0X93QfG9TT+bBENM
         lWTA==
X-Forwarded-Encrypted: i=1; AJvYcCU9jxsi+qWAn2bICB+6WXHwkbSX4OAwx7OO+0+YiolFRT7q4u25/VyfEoaRo/bpVk9y/FY=@vger.kernel.org, AJvYcCVsSRL81d+HX/cjjnXDYH4zlngD08s/+WmK6+nGH4IL7n9gVQOt4hI5/jC6Q8BdMOI9C0mMZjlI44qznXG2BNZJ@vger.kernel.org, AJvYcCWny7Y21MSiWEhVmDqQNPkY8/jGUEg8bSBM4ANBsYrauX3/+RODbgJNE5S6KucxoWCCA4qgPI6xnmm7FzBr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kxhhH4oWKyrjUwqB+himvjaARfkNQPH9aVePJQqKBmwQ3Ug7
	G1q08XiggD1zrqN3CJ4QAgHUWgKpaAQLTAdnLlQAwaVDebynHitxXv6tH9tzJ8PzOYSXg6AFMyI
	QFaiSPsWGk3MYHKWqvqSG4Qo86NPz2VQ=
X-Gm-Gg: ASbGncvxTPTHSEM9WephLPsjStbOKvAT0lF0WXH2mznfj7iYSozGMEfLrdnusVKLD+q
	9s0ZtOCDtp8H4OOIxFXeG7G4SUHarKpo2VCfynBhodHQymPL9AJLtylKlaoE/oyuayAdvv7JHtQ
	kP46i1+t27OyXhIivscOiQy1WEmEdhbHrPyBA4g9XY1LPHtLjUTAK7gsJG+SWToKFE1t901pj7s
	Zb+YvMK
X-Google-Smtp-Source: AGHT+IHfzrN0XURHsxFE1H5k9Ar5f+CjQwiySYo3EN5+pbFc5mubrHERyBOo+KIqR4Rf80FzdZH5KoEofsAQxFnmGKE=
X-Received: by 2002:a05:6214:5004:b0:706:ee47:5019 with SMTP id
 6a1803df08f44-7070062e5e3mr37107266d6.28.1753270672469; Wed, 23 Jul 2025
 04:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722153434.20571-1-kafai.wan@linux.dev> <20250722153434.20571-2-kafai.wan@linux.dev>
In-Reply-To: <20250722153434.20571-2-kafai.wan@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Jul 2025 19:37:16 +0800
X-Gm-Features: Ac12FXyQmNj6tPmK7LiLXHHUX3s2nC26DXXQfMfSohafTiKKl4f8NYV9ESM-Kck
Message-ID: <CALOAHbAbZtdY8hCbFAjTBDjzCkeNFMd2qWzHBG-fAbOsFpqmpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Show precise rejected function when
 attaching fexit/fmod_ret to __noreturn functions
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
> With this change, we know the precise rejected function name when
> attaching fexit/fmod_ret to __noreturn functions from log.
>
> $ ./fexit
> libbpf: prog 'fexit': BPF program load failed: -EINVAL
> libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
> Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.
>
> Suggested-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/bpf/verifier.c                               | 3 ++-
>  tools/testing/selftests/bpf/progs/fexit_noreturns.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e2fcea860755..00d287814f12 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23946,7 +23946,8 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>         } else if ((prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT ||
>                    prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN) &=
&
>                    btf_id_set_contains(&noreturn_deny, btf_id)) {
> -               verbose(env, "Attaching fexit/fmod_ret to __noreturn func=
tions is rejected.\n");
> +               verbose(env, "Attaching fexit/fmod_ret to __noreturn func=
tion '%s' is rejected.\n",
> +                       tgt_info.tgt_name);
>                 return -EINVAL;
>         }
>
> diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/=
testing/selftests/bpf/progs/fexit_noreturns.c
> index 54654539f550..b1c33d958ae2 100644
> --- a/tools/testing/selftests/bpf/progs/fexit_noreturns.c
> +++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
> @@ -8,7 +8,7 @@
>  char _license[] SEC("license") =3D "GPL";
>
>  SEC("fexit/do_exit")
> -__failure __msg("Attaching fexit/fmod_ret to __noreturn functions is rej=
ected.")
> +__failure __msg("Attaching fexit/fmod_ret to __noreturn function 'do_exi=
t' is rejected.")
>  int BPF_PROG(noreturns)
>  {
>         return 0;
> --
> 2.43.0
>


--=20
Regards
Yafang

