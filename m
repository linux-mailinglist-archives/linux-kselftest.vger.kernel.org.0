Return-Path: <linux-kselftest+bounces-49081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13623D297CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 02:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7163B300E17F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0D311C21;
	Fri, 16 Jan 2026 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+/ocZAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AE13A3ED
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525442; cv=pass; b=HjitTegDm1nql5nuqIwO7JidgM3fJ4MH1XLU/SdUIgiPR2GitmhMmousTPProMAoxpDzSscTLCVxz8a2IN6CTfDhguRNOKXXXCs1k3BPzrsoC2oLg8wy9dDFU+UpcKweJkdHS4gXdIexGELHjJRC3nWGF9hmvYb0VOFsuszz8JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525442; c=relaxed/simple;
	bh=/nDSPEoleac2+xpkTHnFfZtCQkeyZqRXyawQC6wb4aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZEwfkusadLvkIIJ7T+l7C9fnL17jA0NjpTBhOPguEPlO7ECkrNYZNe4wUSV9DWR9KORlEmMrPPMHd0vDfW15AxDan7Fc/kA7KCLKZKQQMlSBquLaNHa22DCQ52LeHNPUpv1tj9X9+uepR4t01WjM4uYBeLVREg7pJTMzH/z/mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+/ocZAo; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34abc7da414so1069172a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 17:04:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768525441; cv=none;
        d=google.com; s=arc-20240605;
        b=QYkxwZHuHd4C7d+4F9U8+k1Wta2PJXN7rCWYdqp+ye8YXB+VRZKi1xBTwxgTqHm5Th
         lb4SCaGxLbfQk5pi+CQtzyKOC9MSy+JWm/l2CnFRy3T1iL5y741DNmhKsVdijqD1aHyq
         s0vPVu3v+++oYqpp31m5g2OJ/+Z45aRwVIhHRL8M4HA39jgwuReULFvEUuW230zJLFEL
         QFDXRcG3CGnOGZEJBaGd97jg357Q0HudJNlx8Xye6WOMevbPB5uoqzlaqSwZS0+tHRUK
         60xngVbvF5zssmlZfcPmQU2s2EggFh8wnVTlvFbIoqbahx/CoVUG9rKU/Pe7tanMHolo
         z3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AtgvNqeSdjk7ZoyeHzTO1+o4oj79gdVlzDQPPfdYyu0=;
        fh=o88qU6dSPOadNsImCH4YH5Ls1m9kUTwaqnvaPUk/qVw=;
        b=d4nyVOO5RXg9JaLjI1PLsvykE0rNzCLK+HVPsDcQP4ly7oVR0ZG+w6EFYOMCH57qKQ
         wqeWV4FWilk2Pt4tBRk96K0SrNJdIXmCj724Luv+zBckFuMoSG7Kyb/BCd/bq2ckj6uW
         43dD9/nATu9/KjpGFS4pBwuTYLyximbskn/+V8HLJTEWyPpIxbFUnz7YW3rP961xt/lU
         z8QxmRsQlaPrG2vKJt/R4cqylTtP2eibNiEdaC1MS6LBWo02SX1P/XMJNYdaP6b/3Qu2
         WriuyBQlJXJlNZPKRiG4dGQExjYjy1o8cop09x5MWCrQ6axjF1OF+Y7JZRu7xjKmnw5g
         9nYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525441; x=1769130241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtgvNqeSdjk7ZoyeHzTO1+o4oj79gdVlzDQPPfdYyu0=;
        b=P+/ocZAoMIK+62cVb3xUHpGTQitTmI0Ik1vpn4w9m+o7qpJdeNrgZe2Iqdn9IZL/Yi
         +3Ghy3blb9MNiG7PQyOteapCZsj+0sGe5uag9SfvGm1yieVb/EVnGY+lKs6XaXFBVEag
         +ENXf++TL39Gnn3Y/A50Qs9i02H6QzGSzvPQAIN0V5hnByZFZJ8T6x9KVFdjdJJ8TJAY
         41Nx+MepPHtPM+t8Z0dtWskgQs4llrKFaKxglPUAAANbYXpRgTeukmJIjbdL0mTFsBuQ
         CF1HIg0clr4CIUbW/8+RLobMeOrI9XvqntB2f926Feupfm1V55KgUY7OPU2VnD8PrX3t
         nrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525441; x=1769130241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AtgvNqeSdjk7ZoyeHzTO1+o4oj79gdVlzDQPPfdYyu0=;
        b=tYId2eBMwvXSnPEZM5bVqwWL0FtZGgblTZjowB00pJn65uViKxvzZMJSWrazsmV612
         eDCyI8LtDLL0tXVFBq4TtAiXND2z72UFuH7/qo0fWaf9drQqhHXUirw13y4dID2MhjKX
         UPWDltVp+SdCnG3yrb1xL4YPJRKAvkfjkCS3gWt9aKbO7HMOz5qSlKFP3iq6h7+3vdBK
         r7TbdaoZUVeo5TX0CwkTDMyJ8hPr/27LP3QJyACACJhW+yDIKw8RZTXhQdAHTrJaEh+Z
         NiM5pgahBwNqRiRP73sEottp9PyZmXkDQnqzMUpwrtvGRNK2PC/wn8tZnXBMcznln4V3
         tKmw==
X-Forwarded-Encrypted: i=1; AJvYcCUPn3u1Pb/ZxGOllTDrExgXXXLCVaUrqfKbwAgT4igD//jV4we2ZMxWM1yRpoaK8iaFe+Cfa5zranwGf9dI0v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNyMMVX/ZfuC+u5ntP0k+6Wfpfv5bzj5WfJ2PO0HVbQYNBejf
	af8T3WiKM214HadyJ2BtJ71ZUIVXXt0LWc4wO6ENl1Ki7+gNK6d6RFBPyqL2fpXgH3PS+o0gAMX
	XK7qxaN0sx5LpWuhe49XPCF89EDbKrgg=
X-Gm-Gg: AY/fxX5y9SXHmqSLqzhJqWyQAgWTvNkVmkRegOTICWwcMtAcoqQkOoaGtjSjt1gX365
	XYmyR2Zo1Z8Ujm3h2/OVbyRb66vWwKI92L+dgNux+/pBCZppYXMAsuYMOuispib1wf5vubnGzGM
	JUPnyXQqJUYFy0gE21qmGhqf2ISIO2dDdCWCw2gxow/oTQh061BOxcYtxbv9lTpkOl39goEjPK0
	5ZfkWHYNcu3R9pvMRtuoqO7AsP7AzNrbnitCNyF++LVuyRQdqVBriOtLsjt1v77S2ms/OnYzGC3
	uCWXAp8V
X-Received: by 2002:a17:90b:1c0f:b0:340:c060:4d44 with SMTP id
 98e67ed59e1d1-35272edb230mr1051322a91.14.1768525440897; Thu, 15 Jan 2026
 17:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-9-leon.hwang@linux.dev>
In-Reply-To: <20260112145616.44195-9-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 17:03:48 -0800
X-Gm-Features: AZwV_QiwsfiIZXloLgetJdC1SzbljtaOOlNq74X8WhHXjQjo2O1x2f53BHYEByM
Message-ID: <CAEf4BzarSrW1aTRcjrheLWqxFCh1FFd7vwJ4OQup1dbT13EapQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 8/9] libbpf: Add common attr support for map_create
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

On Mon, Jan 12, 2026 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> With the previous commit adding common attribute support for
> BPF_MAP_CREATE, users can now retrieve detailed error messages when map
> creation fails via the log_buf field.
>
> Introduce struct bpf_syscall_common_attr_opts with the following fields:
> log_buf, log_size, log_level, and log_true_size.
>
> Extend bpf_map_create_opts with a new field common_attr_opts, allowing
> users to capture and inspect log messages on map creation failures.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 15 ++++++++++++++-
>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index d44e667aaf02..d65df1b7b2be 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -207,6 +207,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    const struct bpf_map_create_opts *opts)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh_size);
> +       const size_t common_attr_sz =3D sizeof(struct bpf_common_attr);
> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
> +       struct bpf_common_attr common_attr;
>         union bpf_attr attr;
>         int fd;
>
> @@ -240,7 +243,17 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash,=
 NULL));
>         attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, =
0);
>
> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       common_attr_opts =3D OPTS_GET(opts, common_attr_opts, NULL);
> +       if (common_attr_opts && feat_supported(NULL, FEAT_EXTENDED_SYSCAL=
L)) {
> +               memset(&common_attr, 0, common_attr_sz);
> +               common_attr.log_buf =3D ptr_to_u64(OPTS_GET(common_attr_o=
pts, log_buf, NULL));
> +               common_attr.log_size =3D OPTS_GET(common_attr_opts, log_s=
ize, 0);
> +               common_attr.log_level =3D OPTS_GET(common_attr_opts, log_=
level, 0);
> +               fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &co=
mmon_attr, common_attr_sz);
> +               OPTS_SET(common_attr_opts, log_true_size, common_attr.log=
_true_size);
> +       } else {
> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);

OPTS_SET(log_true_size) to zero here, maybe?

> +       }
>         return libbpf_err_errno(fd);
>  }
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 2c8e88ddb674..c4a26e6b71ea 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -37,6 +37,18 @@ extern "C" {
>
>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>
> +struct bpf_syscall_common_attr_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +
> +       char *log_buf;
> +       __u32 log_size;
> +       __u32 log_level;
> +       __u32 log_true_size;
> +
> +       size_t :0;
> +};
> +#define bpf_syscall_common_attr_opts__last_field log_true_size

see below, let's drop this struct and just add these 4 fields directly
to bpf_map_create_opts

> +
>  struct bpf_map_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>
> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
>
>         const void *excl_prog_hash;
>         __u32 excl_prog_hash_size;
> +
> +       struct bpf_syscall_common_attr_opts *common_attr_opts;

maybe let's just add those log_xxx fields here directly? This whole
extra bpf_syscall_common_attr_opts pointer and struct seems like a
cumbersome API.

> +
>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field excl_prog_hash_size
> +#define bpf_map_create_opts__last_field common_attr_opts
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> --
> 2.52.0
>

