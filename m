Return-Path: <linux-kselftest+bounces-25252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBEA20044
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577C116585B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE831DA63D;
	Mon, 27 Jan 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Tjv6Sp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320621DA60B;
	Mon, 27 Jan 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015704; cv=none; b=mGc6q+zcEy1emqYoFjnUpk7TS/sy0HO4US056kSc/eyg5htvepKgtcnJWu1aNT578/xrF4IcpVOffOoU0SHjCO3s2nAK1yJPnEvyUXovwXuIh+VO4baEdciBNl688UwF7KZDbqqlg/kTPrSRjfcd0B7X1rxTbwLxn2gk8BPIg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015704; c=relaxed/simple;
	bh=oeAdIuUlnPiZX2L1Ak/Nz9A6JdQmU0QMG46KFiIwAno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lq0JtlhmfiMDgwWRPASF3B4Mx5dKw8DA+JYhS01+Ff4crjD8aAFSQQ8FZ4tqrY5GiBxwNX+J1EnZLWs26PvI7KJKthGv6FZ+9v9rzhGTqq2jj2fH8JozProu7Bd2Vysc57zVn1BHIV7Uqm/RDkd85H2660QGW7Em4JVuSFZZ8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Tjv6Sp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21675fd60feso110624295ad.2;
        Mon, 27 Jan 2025 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738015702; x=1738620502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Csu+gFg2IlvYFX1PZXR2hsxzZdCdIwPny3DOBnC5Ggs=;
        b=j8Tjv6SpOMoCNuSGBG8NfsGHHgcdqWWdFwAX+6Iw5LbWxFZZqHXkXiHnmKddgKxdRw
         6ThTpAEo5ZVkrPgR2+K+uKHitXOT/H6yN/h0ztmQ0eFlO9sh5Ii1iAdIu0REMTCL7PyZ
         o/8kE9WfOqJadrIpFVAya9r5xJbwE2AkPLWZAK2W9Terep7muxn/A0O5gBTI4GKwBefE
         qykZyBd0mWfglz6ktyXaZevaiPILknedShEsnuY6ssvttRzzu4Jlwdb/LS4kiGkTitN6
         pmP19iF8HBHjiC/fSTuy8e/uCOfGO35XraHhaGJ0aXxObEJyqRF5qNknziPrxye7yXA5
         Yk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015702; x=1738620502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Csu+gFg2IlvYFX1PZXR2hsxzZdCdIwPny3DOBnC5Ggs=;
        b=kgYqej2vzLhZHvRS4P/PEWtYwp9P1nn5tOcGQzlacwz1Sa8WeZSbq+MAJ//zkTsmRF
         mBQ2AfTAOVVcLbX3ZdIMrh837AvZH5dE8KWWz/2otaVXODuwDb39VMlWerbATSqja3v+
         x8Eg/4zz2ia06vdsInLDXof4bKEIDmkydI50/4u/jku0Ki6RHXcb/G+M2R9eNkBJRdru
         C4/1u1riGlCZ9q0IA4pspRUiLx/WkRZUALqZYKNZESt67QG1BR7WkO9KgO6cjmmQBPcm
         gDB63JhmtgRoh3ZP2q96g8eu6h+kCQ7xxgQ9XF+9H/OAPKoIUvetyNCghHK51q98L2A5
         5K/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlr62veV7sL8/StUfJnmivJVr9EHXa9Wwo0QCBwozFJ1jfTFy0HMTKf8dfE0Cp/I9nY4jtxabIq7ifLu75uVUA@vger.kernel.org, AJvYcCVBfy9Kqqix8IrlvE4tLsVP62jirKI17Vq0eFULExRW///T5al7OZ8fYDJi28PZARtDg0E2FDOAHCkedqygEW0q94lq@vger.kernel.org, AJvYcCWcPJS2qS2z0GcvJgCLLJGBkzA++cbeCel3TzxbjlKxNxg3SJ9A+HVCQPJdlCSdIV777UeA9E/rRsUMZoXT@vger.kernel.org, AJvYcCX4E2hMB45oXs/zFX35bahKZ3K/ZQVbXL0n+yQrg4rg1lAQR2sqVMSHnRtizIvIXvvKQDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZSTBpcjGi5vHxf5mavypnguiYUwOnywHYRdlbxOr9IObvY5N
	Srpp1hDRxiZWNxleLZ+g35t6SHt158TLb50+JOcn4emoIoOFgtoiN3lgzL3BqTRceXQX6bZo+a8
	3y7FTS9u/Wg+ULNg0p/TqnYk0hdY=
X-Gm-Gg: ASbGnctA+MsaDMDgQ1PSATSqyhcAR4Zbfr7IXyNm1ABdeK9wmjtW+EWLas+c9aTtghR
	NNF/CWfPXf4E2zc2Zv355YZJIwJyWjnAyE2tTpjo2RG39+KeOr1vyMePk7d9wXOG0SObZln0sFo
	9BuQ==
X-Google-Smtp-Source: AGHT+IFh9/JQ0lKrbUIFNjMNedaOuYVW9WmyjPOF+xxFaKPBtP7wsRmUjtFIPT1ySP/9qLACn350gFn/fvKMF+0Phlc=
X-Received: by 2002:a05:6a00:340c:b0:728:e906:e446 with SMTP id
 d2e1a72fcca58-72dafbda6ddmr69437397b3a.24.1738015702377; Mon, 27 Jan 2025
 14:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com> <20250125-bpf_dynptr_probe-v2-4-c42c87f97afe@outlook.com>
In-Reply-To: <20250125-bpf_dynptr_probe-v2-4-c42c87f97afe@outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 14:08:10 -0800
X-Gm-Features: AWEUYZlH8D96fLMcLFSIE_kAZ8HJRXEyIi3XFDYekgrO2dc_F2L_lpepp1P1YaE
Message-ID: <CAEf4BzZvQF+QQ=oip4vdz5A=9bd+OmN-CXk5YARYieaipK9s+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/7] tools headers UAPI: Update tools's copy
 of bpf.h header
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 12:30=E2=80=AFAM Levi Zim via B4 Relay
<devnull+rsworktech.outlook.com@kernel.org> wrote:
>
> From: Levi Zim <rsworktech@outlook.com>
>
> This update brings the new bpf_probe_read_{kernel,user} helpers
>
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---
>  tools/include/uapi/linux/bpf.h | 49 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 2acf9b33637174bd16b1d12ccc6410c5f55a7ea9..f92cf809b50bc393d54eb0e8d=
e2e1ce2a39e95d0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5805,6 +5805,52 @@ union bpf_attr {
>   *             0 on success.
>   *
>   *             **-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst, u32 o=
ffset, u32 size, const void *unsafe_ptr, u64 flags)
> + *     Description
> + *             Safely attempt to read *size* bytes from kernel space add=
ress
> + *             *unsafe_ptr* and store the data in *dst* starting from *o=
ffset*.
> + *             *flags* is currently unused.
> + *     Return
> + *             0 on success.
> + *
> + *             **-E2BIG** if *offset* + *len* exceeds the length of *src=
*'s data
> + *
> + *             **-EINVAL** if *src* is an invalid dynptr or doesn't supp=
ort this
> + *             support this helper, or if *flags* is not 0.
> + *
> + *             Or other negative errors on failure reading kernel memory=
.
> + *
> + * long bpf_probe_read_user_dynptr(const struct bpf_dynptr *dst, u32 off=
set, u32 size, const void *unsafe_ptr, u64 flags)
> + *     Description
> + *             Safely attempt to read *size* bytes from user space addre=
ss
> + *             *unsafe_ptr* and store the data in *dst* starting from *o=
ffset*.
> + *             *flags* is currently unused.
> + *     Return
> + *             0 on success.
> + *
> + *             **-E2BIG** if *offset* + *len* exceeds the length of *src=
*'s data
> + *
> + *             **-EINVAL** if *src* is an invalid dynptr or doesn't supp=
ort this
> + *             support this helper, or if *flags* is not 0.
> + *
> + *             Or other negative errors on failure reading user space me=
mory.
> + *
> + * long bpf_copy_from_user_dynptr(const struct bpf_dynptr *dst, u32 offs=
et, u32 size, const void *user_ptr, u64 flags)
> + *     Description
> + *             Read *size* bytes from user space address *user_ptr* and =
store
> + *             the data in *dst* starting from *offset*.
> + *             This is a wrapper of **copy_from_user**\ ().
> + *             *flags* is currently unused.
> + *     Return
> + *             0 on success.
> + *
> + *             **-E2BIG** if *offset* + *len* exceeds the length of *src=
*'s data
> + *
> + *             **-EINVAL** if *src* is an invalid dynptr or doesn't supp=
ort this
> + *             support this helper, or if *flags* is not 0.
> + *
> + *             Or other negative errors on failure reading user space me=
mory.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>         FN(unspec, 0, ##ctx)                            \
> @@ -6019,6 +6065,9 @@ union bpf_attr {
>         FN(user_ringbuf_drain, 209, ##ctx)              \
>         FN(cgrp_storage_get, 210, ##ctx)                \
>         FN(cgrp_storage_delete, 211, ##ctx)             \

we probably want to add some big and very noticeable comment here
suggesting kfunc route, to save people time next time. Please consider
adding it as a separate patch for v2.

> +       FN(probe_read_kernel_dynptr, 212, ##ctx)                \
> +       FN(probe_read_user_dynptr, 213, ##ctx)          \
> +       FN(copy_from_user_dynptr, 214, ##ctx)           \
>         /* */
>
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that do=
n't
>
> --
> 2.48.1
>
>

