Return-Path: <linux-kselftest+bounces-30982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D5A90DC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DE444B42
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E52231C9C;
	Wed, 16 Apr 2025 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCkZ8aMI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8BC214235;
	Wed, 16 Apr 2025 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838679; cv=none; b=FSHsfy8VU6U1DX6lNUl0mmzHBgQfJwDZUbtxylxbky/waclaID1akKBvD0/VfmGecrKeDYacHSx7p1ALa8IXRs0CYr/leGkiEv/EAF3iIfQYM38jD+vaCHhP2h9RCvgNM9xOM4BP8awFk+1oM+mfzpELYOTE7HOH0Kspq90mua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838679; c=relaxed/simple;
	bh=ZbU5fzt0/AJB5zorsnKBlFwoeqC1M5ychog/yn4bL34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF92PBdaYziRjVhD5jpNOM6VNSNVrzKb9cBl2We3sCK6zSRIcAnx0IgoSgXW9ciSf5i0pWwMIkQkAZKhi6DJ/kRLjJX2YuEPfX5/ALhblkbI+msB4L49oH0Y8KnBIubRG2MtC73o620PrS5XDVzbRRCpT8wVU4YRX7A5IMcSFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCkZ8aMI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso67675b3a.2;
        Wed, 16 Apr 2025 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744838676; x=1745443476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jVAyA2MpizhxtQwsOdID7gg2xhGq08cVN7SZQ9jXqk=;
        b=CCkZ8aMIhpyAG7jLKCxaF7MEutEYVNIRj7Lr2FXP4SgQs5mOfO5OBo+R2vJgj1UfWC
         G2sN6t5XYIqa48J2SR7ssTvIUoCGlF0by6sN9Bhwi2oONvl5mlmaoK9c/iDsuznRBHaR
         kuaFLC0z7K0xiXkD4uYswTG1GotKNV0GPGVov8CU32lzt7E4SMjQbzVGLwHuC96ZY0Ka
         dLKKW6uzLdiRRj/Vdk57EakObcDI1ZUF93UlxTq2A/KpiOoZhs/j20vrzWCgrUAgBsKk
         ArTrbczVLVIsNbyBwAilMrVp0rKXwJGRmEM6bnT/QPRXCfLnYClt37pRHI9Oand8OpwJ
         MpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744838676; x=1745443476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jVAyA2MpizhxtQwsOdID7gg2xhGq08cVN7SZQ9jXqk=;
        b=tR3ijv+7ta3hmXZzyfp5t47NcUepfaeBbc9/MySJBfZKpFzzGf8IZouCfM7wbSKrFc
         lc62dhtUDOP184q/IN6eLwordZMyQlxgCS2p0D7mSPBgbJiCh0qqOxR/rhifN0mftSwp
         M3emehvwK8vRFU4mGuZ888lFdTceqUf/LwqOy1Qi6qsZJcmpsNf6Hz0mzxIOokxzx/Dg
         8XJ//XWbASUSQuWWPV4PqJRMCoghuhwzUnxzzzT4ZwBdakhYWxYTugEgtHTbUEmVcoO8
         KnUXBArfTJu+ZshVlQ1EFO9SThiSel5u8M+vmaC3+dqGZr5fU3AvwfrZcwGy1dJHD3vm
         2dCg==
X-Forwarded-Encrypted: i=1; AJvYcCUMB3fFq6CgteFNDRI8REVmyYMzDEFNEjt9AJb0uFOj+jDqikcpbnP5wQ0z5uknpJWAL/5RA/XwYpmh2SBIJugx@vger.kernel.org, AJvYcCV9Oa9S0Wkx8hoVOk+bTNG+i6jfn6HN1ydV+OUwTBn3uZPxxnJsuaMtaj4gUSJsfdP+f0KrN1oq557U39Cd@vger.kernel.org, AJvYcCXEawT4tO723illNgVbhUOof70OVg2F71j+k6VCWmRB7lYjNWx0Q9imZ0kP89hECQ+EL3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JuWmx1nfP+vOEncUwq8ef06tsynbT6UAuLZZkJcR6dm9Z0e2
	5kbVCIyzPnWyi3l17N/MOvuayy8l2OHnuRJsXiJv2Pn7IHX/OayNkVwZfmgWIljDFDGtJzdex3Y
	X9ZoRtial2rSKW2P33oH3gG7MIoc=
X-Gm-Gg: ASbGncuY27lckYoDuvcWhVNG2WVjuZ2189atKplirWfdwvxyNziqKC+gLLEiHMpXtjg
	TMBwuDUDDfGYF5RkVZdUKMMjVlaTMA929vEzDqEwJ1c8jUW1XfVWR6mmjj++dITXBGJQkY4yVZZ
	UWl0N5x0SWY9ME5nAVDj1cBcGWYh/kcxKdeA3d5w==
X-Google-Smtp-Source: AGHT+IGP0KP8Iix57A7pNCwQp1k9B+JFkxfWiQwRVI0u7EuoGlinHX/1dVpIRADFn6P7r1WHtj3Ss+TZRQvR2I4Bbg8=
X-Received: by 2002:a05:6a00:aa8d:b0:736:a973:748 with SMTP id
 d2e1a72fcca58-73c267f8ba4mr4955120b3a.22.1744838675753; Wed, 16 Apr 2025
 14:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com> <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
In-Reply-To: <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Apr 2025 14:24:23 -0700
X-Gm-Features: ATxdqUE6pVn0ZTMRWW3NJojzYizvIX7ZuQkUbJrKxsRI8DDdQqgnpzQYLgypGws
Message-ID: <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Florent Revest <revest@chromium.org>, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 1:32=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> In order to properly JIT the trampolines needed to attach BPF programs
> to functions, some architectures like ARM64 need to know about the
> alignment needed for the function arguments. Such alignment can
> generally be deduced from the argument size, but that's not completely
> true for composite types. In the specific case of ARM64, the AAPCS64 ABI
> defines that a composite type which needs to be passed through stack
> must be aligned on the maximum between 8 and the largest alignment
> constraint of its first-level members. So the JIT compiler needs more
> information about the arguments to make sure to generate code that
> respects those alignment constraints.
>
> For struct arguments, add information about the size of the largest
> first-level member in the struct btf_func_model to allow the JIT
> compiler to guess the needed alignment. The information is quite

I might be missing something, but how can the *size* of the field be
used to calculate that argument's *alignment*? i.e., I don't
understand why arg_largest_member_size needs to be calculated instead
of arg_largest_member_alignment...

> specific, but it allows to keep arch-specific concerns (ie: guessing the
> final needed alignment for an argument) isolated in each JIT compiler.

couldn't all this information be calculated in the JIT compiler (if
JIT needs that) from BTF?

>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
>  include/linux/bpf.h |  1 +
>  kernel/bpf/btf.c    | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622cb1a097999afb78c17102593b6bb..8b34dcf60a0ce09228ff761b9=
62ab67b6a3e2263 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1106,6 +1106,7 @@ struct btf_func_model {
>         u8 nr_args;
>         u8 arg_size[MAX_BPF_FUNC_ARGS];
>         u8 arg_flags[MAX_BPF_FUNC_ARGS];
> +       u8 arg_largest_member_size[MAX_BPF_FUNC_ARGS];
>  };
>
>  /* Restore arguments before returning from trampoline to let original fu=
nction
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16ba36f34dfab7531babf5753cab9f368cddefa3..5d40911ec90210086a6175d56=
9abb6e52d75ad17 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7318,6 +7318,29 @@ static int __get_type_size(struct btf *btf, u32 bt=
f_id,
>         return -EINVAL;
>  }
>
> +static u8 __get_largest_member_size(struct btf *btf, const struct btf_ty=
pe *t)
> +{
> +       const struct btf_member *member;
> +       const struct btf_type *mtype;
> +       u8 largest_member_size =3D 0;
> +       int i;
> +
> +       if (!__btf_type_is_struct(t))
> +               return largest_member_size;
> +
> +       for_each_member(i, t, member) {
> +               mtype =3D btf_type_by_id(btf, member->type);
> +               while (mtype && btf_type_is_modifier(mtype))
> +                       mtype =3D btf_type_by_id(btf, mtype->type);
> +               if (!mtype)
> +                       return -EINVAL;
> +               if (mtype->size > largest_member_size)
> +                       largest_member_size =3D mtype->size;
> +       }
> +
> +       return largest_member_size;
> +}
> +
>  static u8 __get_type_fmodel_flags(const struct btf_type *t)
>  {
>         u8 flags =3D 0;
> @@ -7396,6 +7419,8 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
>                 }
>                 m->arg_size[i] =3D ret;
>                 m->arg_flags[i] =3D __get_type_fmodel_flags(t);
> +               m->arg_largest_member_size[i] =3D
> +                       __get_largest_member_size(btf, t);
>         }
>         m->nr_args =3D nargs;
>         return 0;
>
> --
> 2.49.0
>

