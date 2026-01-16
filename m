Return-Path: <linux-kselftest+bounces-49079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9CD296F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 01:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7390C3008C79
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5D305047;
	Fri, 16 Jan 2026 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVkJRyv4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A4302140
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524157; cv=pass; b=Hs2dJ8AuJDv3S6iF44hCLp4LZ9GGdteFBjjae0wX+Otmt47iP2F/uVGwYJh8IQNle9Sse580MWSpif1ELKGYbnIOfeMgtfySI3jNj0WQavha21Ku3zJfoRSQ/8jKWyVonjDvuwZDwNWLci59C+UoT9WOOacnzbQgxtuFxWT+E00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524157; c=relaxed/simple;
	bh=Cg06FeML/T7hypkXS7qHos2NFAbpK6c7/UMKz+ylJjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB2iYca/43sBCm44YFDiM08sK3VDMGwY8NUMOy26pIwJSJ83FrZjttL61SMBYC/ZkAgojrrO+hQE3BkiSHe3Ic53i69zgbkaXpKTi9nZg4kI23TGmaOeFZDaERK3nvLZ34PQSB1JYWroZBmtYo0zQiorWC8GzuUlZhAaAPgKQcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVkJRyv4; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so1105594a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 16:42:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768524155; cv=none;
        d=google.com; s=arc-20240605;
        b=AG0Xs7GCKozqlu3H3ji3CsTO5QgITqlaXmQL4VaxQVabVSZl32sTtfcIYvQnDIa8ZU
         aNEgX7LzvzD6J7mUzw963SevPOpZOA4oyUlS03q2QEhGvm05RtppGNx5u1AKSe0RYFYn
         PUgM0r2eLWP0UK7Lb/6DVcWVNdounfm5F1+iEnBKbWZ3KJzjwfnqEhVs2J+BS1MfMSCQ
         US0N0jtmYKMmSs+DLN8V8s0llXDBcExLVIqWB8r5GEoAAZpd6dE+rndSEfrnV2wT1P0J
         ebUDKbxUI+bVKC8VVFE/6sOWpGmEBMfOx57EJ0jF571BH6GgjxWgn/kNNRa/AfurEAiY
         7tSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5didJoF5BdyOHZEdMd//tIhEBHGWfShDkE5NMN7SDPc=;
        fh=CySJoesdGast/fYIpovkv6G3pO3w6X4qMC8RYffBAnY=;
        b=a8yIJvMdV6aoYs/QMWkQMVhNYgygzDv7CwYyqaEr3dAhM8HQRSADWSosLBhpiL0ilT
         z0Q0qmL8/1vnhJ4ScPVGyySq0HAjAMMVerzfDRZYqPPQfWgRpUkK5C94nsORq0h0E68l
         IEOuhL0KZ1iZVDB8sQwSWrD9QWq2AWvVQDXHxwEfbmwp+xnUBVakEX7Adgth1FRRl3Hb
         r7ouqrPM7RtHlz17dMcY1ILFx49gGmfdQznE8BkiqZVVYJNVAZR9PbMwtt5Blt707f1d
         eYCPv1z/fWHdGtWLUzOEwnAfx1IhsM0QIrNttmcik+GAMJFto3/jwpbvSFdwlC0Bkagt
         h04Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768524155; x=1769128955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5didJoF5BdyOHZEdMd//tIhEBHGWfShDkE5NMN7SDPc=;
        b=PVkJRyv4wcnQphsJYUL9o+JzgLoVMiUaRtV1XYHCiQgvWERdKmnH+IJ0l/ns9nc3C+
         yqbgSF8fifVtaxTxA2mF1alosvTWSeRHW7jEaQPYr/M4gd9AMwbYsuBYLqH3ShzfZRj4
         dxnlt82E+EcPPtWxvOisW5JYtgGBAPqaHTWRNwM68PgkDPox7o3A0duq9+Svc6b1ThD/
         I+Wn4l083lP2unDG2era2RfqUGiJrqaxO3mZ88oAIdDOTsP+nFeu5zdCyT+m+XcubMSo
         p/ZoEVheCrKjOWQv8h6sU+Zre1pM0Qf2P4pg8/j5MpO0Peu4E1w7NVjHuz/vmxD4hiuE
         FNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524155; x=1769128955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5didJoF5BdyOHZEdMd//tIhEBHGWfShDkE5NMN7SDPc=;
        b=XAP6N0bdmEPC0AlYSh1KBlqS1IFO819lEfZmTlSSyjTuJ/FO55dcxx+hhg8FOue1a0
         RyEbrsJ07sukhe8zKhnX7hrB/VF/E1aQS2ieZquISOzTcf+JF1aYK/SjBLC9c0bRG+tu
         GUN5ZjriSJt2KGK0LXDxlJZKR1VPqhIu4Ia+RxnJCY0plAHqdJ7K4+f2rCRaLqYSEPM9
         qsQX+qGwCjSsCxkUOulVf0JexdIuRCNpGhy1vvXpS6kW/8HGx/wC3TJmMhcMF7A/XU0a
         PKRDGmBLg95NbK1xLQoppOkruN6+p/aFfdJvXxyWRxHJTYhTsvk2LwKJGEZ3iqPi7K5n
         r6og==
X-Forwarded-Encrypted: i=1; AJvYcCXo9ajSfDElwJfhdgVEflTfyylTPN3OsHMB0UCa7HuYjfhDzSOuyQbx/ZR3nJOMkdrC5KDzbyoptroJsYuUHPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJaz9Rq+WKgJUA2FpiP9jEdB2uUZH/2tSNBw6rQ9/etQVH6xq
	PnMh1JsPxvzDwhu0Op4w1XHdqdlDqPRbD4NlymBn84qwoKDhlZ09nHSeYWrzN4VsFBG8T84h2wR
	MoQifePQaWlWeaaBZtPN31ygS9Tqgavg=
X-Gm-Gg: AY/fxX6f78GHOlxpF2isC4eWMc19blncIDedtqMeC98todJgO8YftBZnBHyEaBBBPB9
	xQ1mUZkqxzqSnhsFJT4y72oeMnB2tA1CUnwz0xO83tEwlFSkz5hvHUmynRr9HWUcCkcVr5gPnLX
	gcUKqCOs+MFWaDuAodRtNh5arrSQ30Ua/sJxaOm8Udwd7M42FGOdQV6FyDJahjaT5hH82AiUk0p
	WVANETlmMGtjY2VAI52dpf1oamszkunjDrRc8PL+uW8VEI8lEXFOgDVReR7Kome9qwc/xtAVfLv
	a9uD+nG3
X-Received: by 2002:a17:90b:56c4:b0:32e:7bbc:bf13 with SMTP id
 98e67ed59e1d1-35273298fdbmr910991a91.34.1768524155197; Thu, 15 Jan 2026
 16:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-3-leon.hwang@linux.dev>
In-Reply-To: <20260112145616.44195-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 16:42:22 -0800
X-Gm-Features: AZwV_QhNdxDJ6NlutrW9Xm3USMSfS1qX1NT2r_W00q3idFFQYx4FVRRsA0D_Y9s
Message-ID: <CAEf4BzYRC+=J05C6QDwgzbJ7gO7gZD4xcEcj9ixCaJ=xaRuSsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 6:58=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> To support the extended BPF syscall introduced in the previous commit,
> introduce the following internal APIs:
>
> * 'sys_bpf_ext()'
> * 'sys_bpf_ext_fd()'
>   They wrap the raw 'syscall()' interface to support passing extended
>   attributes.
> * 'probe_sys_bpf_ext()'
>   Check whether current kernel supports the extended attributes.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 34 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/features.c        |  8 ++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  3 files changed, 45 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 21b57a629916..d44e667aaf02 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -69,6 +69,40 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> +                             unsigned int size,
> +                             struct bpf_common_attr *common_attr,

nit: kernel uses consistent attr_common/size_common pattern, but here
you are inverting attr_common -> common_attr, let's not?

> +                             unsigned int size_common)
> +{
> +       cmd =3D common_attr ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMM=
ON_ATTRS);
> +       return syscall(__NR_bpf, cmd, attr, size, common_attr, size_commo=
n);
> +}
> +
> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
> +                                unsigned int size,
> +                                struct bpf_common_attr *common_attr,
> +                                unsigned int size_common)
> +{
> +       int fd;
> +
> +       fd =3D sys_bpf_ext(cmd, attr, size, common_attr, size_common);
> +       return ensure_good_fd(fd);
> +}
> +
> +int probe_sys_bpf_ext(void)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       union bpf_attr attr;
> +       int fd;
> +
> +       memset(&attr, 0, attr_sz);
> +       fd =3D syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr,=
 attr_sz, NULL,
> +                    sizeof(struct bpf_common_attr));
> +       if (fd >=3D 0)
> +               close(fd);

hm... close can change errno, this is fragile. If fd >=3D 0, something
is wrong with our detection, just return error right away?

> +       return errno =3D=3D EFAULT;
> +}
> +
>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..d786a815f1ae 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +static int probe_kern_extended_syscall(int token_fd)
> +{
> +       return probe_sys_bpf_ext();
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +586,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_EXTENDED_SYSCALL] =3D {
> +               "Kernel supports extended syscall", probe_kern_extended_s=
yscall,

"extended syscall" is a bit vague... We specifically detect common
attrs support, maybe say that?

> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..e2a6ef4b45ae 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports extended syscall */
> +       FEAT_EXTENDED_SYSCALL,

FEAT_BPF_COMMON_ATTRS ?

>         __FEAT_CNT,
>  };
>
> @@ -757,4 +759,5 @@ int probe_fd(int fd);
>  #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
>
>  void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_=
LENGTH]);
> +int probe_sys_bpf_ext(void);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.52.0
>

