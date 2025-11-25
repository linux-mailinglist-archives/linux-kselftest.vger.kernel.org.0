Return-Path: <linux-kselftest+bounces-46468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97067C87748
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 00:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC9E3B3036
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 23:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CAB2F12A7;
	Tue, 25 Nov 2025 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv6va8Sv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ECC2EBBA4
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112880; cv=none; b=bc/3v5vMOghTiknIrPTaZfXxpinM4xMrvHwlod+KDcVoqm0gRKRGh6v68gIY/+kQbH3t5LrlZ2bVJc8DgbvkygFxsXNpBBRRq9opBGR/ehCcTj4FdJLkcMneShkuEtUP01ID4sXjcjWFVOdAmM12f9oJ2Id0BzHv7olaL2uyGKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112880; c=relaxed/simple;
	bh=ixdjz/lGdTrJVZQtJSefqkGpGRZIOsnVcZFxk7Y/X+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8tQY+v37RcA1JEqjv1cImDPhh9cXLDrYRNfmwCxQ1J7eMjIRXHOtHRzbBxX8Sbq2q5ecmMEi10ew7rsnt4sTbuo42BV4EfTenwPkeSK7qYGpxPSVxj945hMAUs9cvjPU0bRKK1UQi1ZOKxKaW8WNRPEXJx8AJMKre4Z/kFSROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv6va8Sv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so180312f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 15:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764112876; x=1764717676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkxQBqbD1/JuOSygAWMRrM27Y5Xe0IPLQCwbELxwSlQ=;
        b=cv6va8SvnhQhxAs50bsqj0OHeotKcLvxDzFvyDxBcFolbeuXHSXOOXsSyW0wcK5oKO
         RYJ4QBtWum6XpfMEcSmyOCsAkwuWPbiTDFfuE6bdWX82cEThoug7xB6lGX5LRKpzZeZc
         bnXkO4tyoVygnFa29rObk6IP/VtYA+KYYpdb+TI9jWFvI09hd6RH0yFkmY9iQfVqpie5
         +6UcuB6dPzftcVBMQlD9Afak1DcnSPUqfDIfiRSMBfWr6kvSQAGNaJp34Ec9I4ijXBCX
         bLtv+KWugdM1MOhB1rUF6JUCBEX51JFTtU1weT9At1waMLktVh/rwXeGHOD/jAiyViLZ
         Hujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764112876; x=1764717676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkxQBqbD1/JuOSygAWMRrM27Y5Xe0IPLQCwbELxwSlQ=;
        b=Jwmfot84swSmvCEEam+pV/iZA79V0RNLbHLkNWibgVRKM1lk7DuJ7ojqcsFthRG2Mz
         guWB78vJFhpRtkFipRHfjunoL2iGvSFNwFX+Dge7bwlwcnU7MTKNrta2wVXhqDZjnbwG
         /vJ2RPTLuVNg6FSrtO+z4zs6f6mMIAXw5TcGdm64wEVaJFnAvYoet6kt5aRZS9Jygmta
         MsasjoeHS/hDdJwFA9PjRy9nCcOijksLt59dAKHJs78CkZYz+yHVha+RTYkTiIJpAspb
         dop4ELf4fsleCX8mKXzEb7fevJc25TLwmO00ogVYuZzjkSWfxC/Mso2iPHcG3mkoPnv5
         hXpg==
X-Forwarded-Encrypted: i=1; AJvYcCUn85btaRKcu02HtNf/bMIp8svPi4j+iM1NJpSuddh7xbK1nbQbomjcXIM843o3RoVYOZR3ze4L3IFmPDZ18Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAZwnIggouM/TWtTDCvwQmdktblVGfAeuuwOGGrX4JN3G9oMK
	gApuTez/P16Kee2klVYOgvnE6T5zjzyUc5sF+DIdfcdjrmeowfvf1vSwywfVOI6l9rc+/ww/FnU
	dbgXQ7kg2NR1LVVk0NDVHRdg+nwY1tLQ=
X-Gm-Gg: ASbGnctO4x/oF2WHFnf1r5khOEPyp7YCzf5EvfVATENvxVpM5r4QCOxaaNEOTCCdIJB
	de3EDAblSFYyFEN0qK6MG7qlgoNX+riI3h7M8dEe+mHafZ7BdPgrvVW5aN1MR/ZKHQtmtR9rPSX
	Rbp0JktiqdmuMyPC2vUj9LXOG6d0AydU3G8fdOxQMGO419hfzCyY3lqVqFokDLorVdBqe9r+qot
	jXEVkqGAUjTLQ1szIvV1951rFjWcOxfJe1pTwiPhPYmvOKxTz/DJGXUw70/wi0emcuDAYC2H1BU
	MiagUZDSETO2jPYEhYi6FDc0BFMb
X-Google-Smtp-Source: AGHT+IHpsa6m5s+OcFlKFSEdPJn+Zr1doCCS5y/jRcYPMbR2ruY/x2rwTEg2Gp9lw28vekpJgO5KF4Y4qqmH4kVNTRA=
X-Received: by 2002:a5d:5d88:0:b0:3e7:428f:d33 with SMTP id
 ffacd0b85a97d-42cc135db29mr18718124f8f.16.1764112875269; Tue, 25 Nov 2025
 15:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125145857.98134-1-leon.hwang@linux.dev> <20251125145857.98134-3-leon.hwang@linux.dev>
In-Reply-To: <20251125145857.98134-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Nov 2025 15:21:04 -0800
X-Gm-Features: AWmQ_bmB_4Aa-Z_uNUEFFbiGYz-C8c50-S9BMrQhpOQTRRB7ECxDwHkzQdgzuJU
Message-ID: <CAADnVQKuWrS57niXtr-xu4daR=GvnZORa+X2gHkDbsDZ3qyveQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 2/8] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Tobias Klauser <tklauser@distanz.ch>, kernel-patches-bot@fb.com, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and check them for
> following APIs:
>
> * 'map_lookup_elem()'
> * 'map_update_elem()'
> * 'generic_map_lookup_batch()'
> * 'generic_map_update_batch()'
>
> And, get the correct value size for these APIs.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v10 -> v11:
>  - Use '(BPF_F_ALL_CPUS << 1) - 1' as allowed_flags in map_update_elem().
>  - Add BPF_EXIST to allowed_flags in generic_map_update_batch().

It should be mentioned in the commit log.
Lines after --- don't stay in the log.

> ---
>  include/linux/bpf.h            | 23 +++++++++++++++++++++-
>  include/uapi/linux/bpf.h       |  2 ++
>  kernel/bpf/syscall.c           | 36 ++++++++++++++++++++--------------
>  tools/include/uapi/linux/bpf.h |  2 ++
>  4 files changed, 47 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6498be4c44f8..d84af3719b59 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3829,14 +3829,35 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, =
u32 *offsets, void *image)
>  }
>  #endif
>
> +static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type=
)
> +{
> +       return false;
> +}
> +
>  static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags,=
 u64 allowed_flags)
>  {
> -       if (flags & ~allowed_flags)
> +       u32 cpu;
> +
> +       if ((u32)flags & ~allowed_flags)
>                 return -EINVAL;
>
>         if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BP=
F_SPIN_LOCK))
>                 return -EINVAL;
>
> +       if (!(flags & BPF_F_CPU) && flags >> 32)
> +               return -EINVAL;
> +
> +       if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
> +               if (!bpf_map_supports_cpu_flags(map->map_type))
> +                       return -EINVAL;
> +               if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS))
> +                       return -EINVAL;
> +
> +               cpu =3D flags >> 32;
> +               if ((flags & BPF_F_CPU) && cpu >=3D num_possible_cpus())
> +                       return -ERANGE;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f5713f59ac10..8b6279ca6e66 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1373,6 +1373,8 @@ enum {
>         BPF_NOEXIST     =3D 1, /* create new element if it didn't exist *=
/
>         BPF_EXIST       =3D 2, /* update existing element */
>         BPF_F_LOCK      =3D 4, /* spin_lock-ed map_lookup/map_update */
> +       BPF_F_CPU       =3D 8, /* cpu flag for percpu maps, upper 32-bit =
of flags is a cpu number */
> +       BPF_F_ALL_CPUS  =3D 16, /* update value across all CPUs for percp=
u maps */
>  };
>
>  /* flags for BPF_MAP_CREATE command */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index cef8963d69f9..3c3e3b4095b9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -133,12 +133,14 @@ bool bpf_map_write_active(const struct bpf_map *map=
)
>         return atomic64_read(&map->writecnt) !=3D 0;
>  }
>
> -static u32 bpf_map_value_size(const struct bpf_map *map)
> -{
> -       if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> -           map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> +static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
> +{
> +       if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS))
> +               return map->value_size;
> +       else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> +                map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
>                 return round_up(map->value_size, 8) * num_possible_cpus()=
;
>         else if (IS_FD_MAP(map))
>                 return sizeof(u32);
> @@ -1732,7 +1734,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
>                 return -EPERM;
>
> -       err =3D bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
> +       err =3D bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK | BPF=
_F_CPU);
>         if (err)
>                 return err;
>
> @@ -1740,7 +1742,7 @@ static int map_lookup_elem(union bpf_attr *attr)
>         if (IS_ERR(key))
>                 return PTR_ERR(key);
>
> -       value_size =3D bpf_map_value_size(map);
> +       value_size =3D bpf_map_value_size(map, attr->flags);
>
>         err =3D -ENOMEM;
>         value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> @@ -1781,6 +1783,7 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>         bpfptr_t uvalue =3D make_bpfptr(attr->value, uattr.is_kernel);
>         struct bpf_map *map;
>         void *key, *value;
> +       u64 allowed_flags;
>         u32 value_size;
>         int err;
>
> @@ -1797,7 +1800,8 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
>                 goto err_put;
>         }
>
> -       err =3D bpf_map_check_op_flags(map, attr->flags, ~0);
> +       allowed_flags =3D (BPF_F_ALL_CPUS << 1) - 1;

This is cryptic.
Use
allowed_flags =3D BPF_NOEXIST | BPF_EXIST | BPF_F_LOCK | BPF_F_CPU |
BPF_F_ALL_CPUS;

