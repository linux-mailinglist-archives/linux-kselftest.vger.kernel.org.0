Return-Path: <linux-kselftest+bounces-13944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7DA937CC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 20:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9349E1F2249A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A012F1487CE;
	Fri, 19 Jul 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTOPhsM2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5514830F;
	Fri, 19 Jul 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415335; cv=none; b=oS/m5t1COEaLo0Vt4C1ZA66KrZwsPUaKXQVNHRhnIwTGT4oA5JfH9Yo0H76h/aWUZCHsjyuMJPPPUojtVg6D2JihFxZB1p/nmF8YEmcsDEvjgObz0XYcJms+DciG5o70LJktKvXtkJ5muGEofMNauUS7Xl9LGbu5RqdxJyZqCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415335; c=relaxed/simple;
	bh=252hIiMFQyNjRymAtvRKZk0dXUoQ/lmkD2ClTFJUt2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyO3irdfMDdL91ni4cq1AT3Hiw55ittHtmmBWsjsKFZDQkAE2oa38mch2xH9mPB75NN7+qgCCYaPGauVCRI+WT4MwQCOEvPxARpOCeorOM5OYGplLR811PUYfdQCkpJmG8GBWIzeHQhinLJDRud/ofnvE+rJNdWvQY4wppTQEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTOPhsM2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-75e15a48d6aso1476828a12.0;
        Fri, 19 Jul 2024 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721415333; x=1722020133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdjMAdiGXFE3E7lg0h/2y80rVQL9E2201XZypo3hCP8=;
        b=UTOPhsM2a31WDvV09MfLkpDjblcDYUTLS9wzjMVq6wSw222dE6+AW2M8lQwi4fe8+r
         DjVjmJRYrPc5XIfujO0ldteOHWqgcm+K9u3qp0iW2dCRdUToFeFPVDVFCwBDBaw0GQ7s
         IccD2AJ3q1m0Y9szhK9p5W/eJa0bNAmKimZ5q/wunw0JX7jN9DnCq5x4bagOOWy1ytiS
         ZMRds3KDvr0YLYUwFBtqRvdqBpjKEgA2OjpcsTBPXnc4CthjhhmRmDrVtF6btB0AGIJd
         uOMNDtZUYJIzKsyY+ktSS/ED4TK2sht1eD4P4Pf5JoEN8KPJto2bZ9lBdECino5DOBDy
         ZK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721415333; x=1722020133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdjMAdiGXFE3E7lg0h/2y80rVQL9E2201XZypo3hCP8=;
        b=lN383UxTDRJp9wFRvHUTxDkEBtbLHCl6Ja4dXkM+arj1fEuAyA6tPfLlEu5sBQVI3p
         M4DgGQHymqZ/wvZML0FpXULCiPYIVIeu08Irkcoi6/vWpNB+Mb0GB3dPbvDK7doyXWqg
         Ggt53dfyweGWyFlJ2pP/j3Zs4VlyXX15vX3zEoaVjklnm8YD5vg9kjQTeBP0RSPzLhXL
         fG6p0KgaxkkO0asUtB4TG0y19JH8nwOAcNS3IvA9NNO96RD3dj3AwSn+UQp7vVybXSJn
         ilJJ0MTLKsF6/B8tLw7oanzhCB/L/zKBnw2OOqD7b8fZOadbPUAPw8v2M7gCfr1dYveD
         OwQw==
X-Forwarded-Encrypted: i=1; AJvYcCXF01m419gyx0LjO0TlsOXK2iNFwaQpRsSRwheleJk9GmVvGMdzbnmcXb9g3Jjijj1MHJzeigS+Ii/wuAhePAWZHbamzZIYLUbyr7XlHLIIcVnpuKysWp7dKKtNWeE/HubDC+DDfVeMAIoQ2nqVrSnEVUItZTLoKnmOyS0i9Z2hLNYODYdsGX5TAmLIzIWZR6MGvqRDuCDmqhhNjOEv5+8OL+uw4S3z
X-Gm-Message-State: AOJu0YykpVokMpAmbSPqfnL91vfCSLbjM2JeI9lDdrmanpVYbiq9c6+a
	8eHBn0+CAmHrjUd7LyTwW9zt99ELHujHGYRJwLv9mPAuZyp2BPQQR1vBxlIiSrWAH4TrASghtmh
	Kq6ftqZ0D2cMUBKbM6fLfIABvz1M=
X-Google-Smtp-Source: AGHT+IF3HI5VDylwXI4gV6jZgA1oH8WgU+S0F7KP1w0qZXi39U0IsU4r43nlYEnu5CLQqFxIQ3L31cXlFLSKrsHjA+8=
X-Received: by 2002:a05:6a20:b598:b0:1c3:3436:a244 with SMTP id
 adf61e73a8af0-1c42285f3b0mr1122705637.1.1721415333107; Fri, 19 Jul 2024
 11:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718115153.1967859-1-yikai.lin@vivo.com> <20240718115153.1967859-2-yikai.lin@vivo.com>
In-Reply-To: <20240718115153.1967859-2-yikai.lin@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:55:20 -0700
Message-ID: <CAEf4BzZsqcnn8cWSig6Yu-RHvpsFVmJfeNT8CmHuHpN_rTrCwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add bpf_file_d_path helper
To: Lin Yikai <yikai.lin@vivo.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:53=E2=80=AFAM Lin Yikai <yikai.lin@vivo.com> wrot=
e:
>
> Add the "bpf_file_d_path" helper function
> to retrieve the path from a struct file object.
> But there is no need to include vmlinux.h
> or reference the definition of struct file.
>
> Additionally, update the bpf.h tools uapi header.
>
> Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
> ---
>  include/uapi/linux/bpf.h       | 20 ++++++++++++++++++++
>  kernel/trace/bpf_trace.c       | 34 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++++
>  3 files changed, 74 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 35bcf52dbc65..7e5cec61a877 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5792,6 +5792,25 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_file_d_path(void *file, char *dst, u32 size)
> + *     Description
> + *             Return full path for the given *file* object.
> + *
> + *             In order to solve issues where certain eBPF programs can =
not include
> + *             the definition of struct file or vmlinux.h
> + *             due to their complexity and conflicts on some operating s=
ystem,
> + *             the variable *file* here is declared as type void*
> + *             instead of the traditional struct file*.
> + *             It will be forcibly converted into type struct file* late=
r.
> + *
> + *             If the path is larger than *size*, then only *size*
> + *             bytes will be copied to *dst*
> + *
> + *     Return
> + *             On success, the strictly positive length of the string,
> + *             including the trailing NULL character. On error, a negati=
ve
> + *             value.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -6006,6 +6025,7 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(file_d_path, 212, ##ctx)                     \
>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cd098846e251..70fde7f20e97 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1257,6 +1257,38 @@ static const struct bpf_func_proto bpf_get_func_ar=
g_cnt_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>  };
>
> +BPF_CALL_3(bpf_file_d_path, void *, file, char*, dst, u32, size)
> +{
> +       long len;
> +       struct file copy;
> +       char *ptr;
> +
> +       if (!size)
> +               return 0;
> +
> +       len =3D copy_from_kernel_nofault(&copy, (struct file *)file, size=
of(struct file));
> +       if (len < 0)
> +               return len;
> +
> +       ptr =3D d_path(&(copy.f_path), dst, size);
> +       if (IS_ERR(ptr)) {
> +               len =3D PTR_ERR(ptr);
> +       } else {
> +               len =3D dst + size - ptr;
> +               memmove(dst, ptr, len);
> +       }
> +       return len;
> +}
> +
> +const struct bpf_func_proto bpf_file_d_path_proto =3D {
> +       .func           =3D bpf_file_d_path,
> +       .gpl_only       =3D false,
> +       .ret_type       =3D RET_INTEGER,
> +       .arg1_type      =3D ARG_ANYTHING,

you can't just accept any random value as `struct file *`, this is a
complete no-go. It will have to accept some sort of PTR_TRUSTED
argument, be added as kfunc, etc, etc. We had earlier discussion
around this, I don't remember all the details, but this is definitely
not the way forward.

> +       .arg2_type      =3D ARG_PTR_TO_MEM,
> +       .arg3_type      =3D ARG_CONST_SIZE_OR_ZERO,
> +};
> +
>  #ifdef CONFIG_KEYS
>  __bpf_kfunc_start_defs();
>
> @@ -1629,6 +1661,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
>                 return &bpf_find_vma_proto;
>         case BPF_FUNC_trace_vprintk:
>                 return bpf_get_trace_vprintk_proto();
> +       case BPF_FUNC_file_d_path:
> +               return &bpf_file_d_path_proto;
>         default:
>                 return bpf_base_func_proto(func_id, prog);
>         }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 35bcf52dbc65..7e5cec61a877 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5792,6 +5792,25 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_file_d_path(void *file, char *dst, u32 size)
> + *     Description
> + *             Return full path for the given *file* object.
> + *
> + *             In order to solve issues where certain eBPF programs can =
not include
> + *             the definition of struct file or vmlinux.h
> + *             due to their complexity and conflicts on some operating s=
ystem,
> + *             the variable *file* here is declared as type void*
> + *             instead of the traditional struct file*.
> + *             It will be forcibly converted into type struct file* late=
r.
> + *
> + *             If the path is larger than *size*, then only *size*
> + *             bytes will be copied to *dst*
> + *
> + *     Return
> + *             On success, the strictly positive length of the string,
> + *             including the trailing NULL character. On error, a negati=
ve
> + *             value.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -6006,6 +6025,7 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \
> +       FN(file_d_path, 212, ##ctx)                     \
>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
> --
> 2.34.1
>

