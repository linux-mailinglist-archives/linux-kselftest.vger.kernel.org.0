Return-Path: <linux-kselftest+bounces-26562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6DA348EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613B7169367
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82741FFC69;
	Thu, 13 Feb 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COjh19Gh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A5E1DE4C1;
	Thu, 13 Feb 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462660; cv=none; b=EC6RAuwDzA1jcD7LUKddr0gInn0LUreVcL0PoeHUYTeLX4LwCQV2o2A2bUo2ZF7tkCGfXBGJCn0XgFZc7GWc3/e6Pc2fWRK7YevySIIFcjdNM7dAjx3EOQcRndIozW/kBd7J4c/FfbdPCK4oJs148cHDh925QfOVJVXtqQgyV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462660; c=relaxed/simple;
	bh=amEVy0abcdKf1C9yzz51yKTZyf5A1NpmPrG6bxM6Xm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nH26SPXfEOqDBNEnQUTnbaM8t1kkY7GL1j/dQKVB/WwhSoQavJzTnkcSXHoY0v85vbgY88urEhX2cEyY42an2jwaxc3OHHgWkG5ZKhlUSChRZ32q6Jqwv/eag7JJLluahhg5mwX0uuNea16GAnoEhsxBb12lyKM+dfM0B2v7T94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COjh19Gh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dc33931d3so575545f8f.1;
        Thu, 13 Feb 2025 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462657; x=1740067457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS48wvhNeDKYDAu31J6hTRnGxVDh0IVBgKjgbTKqfaE=;
        b=COjh19GhhjENGo3rHLVk6kZPh87MD/5a6p9ewK4UnwFn+1AT9PcH6GjzXtRyf7FqdN
         6uLtzmklHpSshtbbDTUdgB7VTzlWYDVRUoITimfCCnvtE5dREo5X4LdLRcZbsdto24aG
         uh7ZqL4bIsSu8vQX+Hp/HnUHFV1HVtT06TpklgBBv9QmZg+kzeGZ3z7VvPKzyHkhpu8D
         6qNuhZWOQdMT68sL/A+83JJMfbzySsuJXDT4zIsLcsOsKCSaahweO3hJ4FKE3SsMGfaq
         efB5P+pAJYwBa2RJNba/19Eng4Hc5RgfaysOsndLj/Lbp6s6LyROH4j6KSSh8jCZmuKP
         HBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462657; x=1740067457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XS48wvhNeDKYDAu31J6hTRnGxVDh0IVBgKjgbTKqfaE=;
        b=Bo5QyDFdlBBDynWzsOhIULex3Qez2iXpE0beAefP6iIA0svk1TRPrku5bX3JyaWVeB
         ayslk7aO77y/rAvtdd9lddhJKbevgreIN8Io8k5tDmOw+5nWZq4qAi8TxQD0OB4tFiwQ
         mwCB7Fptm26rUoyBiZIg6Q0zn/+Aro1jVHPEESjUudr8+ao09xTIv6OpANk/om/SHI6O
         PwTu+pHj5H7caPPBxY6XX3ebk1V6EUNpovc8bKgcMJrC9++seeqBmFxT5rnsaWJwOMX6
         5wSIyOHV3kV/VDHRps+beGd4FaJFWk86vsISGh36/rkSbKH899wt/xtg/rv4KNT4+Vji
         lGng==
X-Forwarded-Encrypted: i=1; AJvYcCUHFNYHYUWaUDP4NY6eDIowqZs6Q6ydynGZ5pAYnEapyRsAwrEb/u5T4M4YxwwOT7S2hqoA8Fii/03h217U/7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaU3DLlI76OrWkB2P6AyLrHyUhzEzaA9fzo/+BOa3Vm2ak6nns
	ouzkZPuqUeIPGy9IuBrBxQQaTMO/CpQVsWGUjaVtkF01SnW8TO4Nhgg/B3q7QuBthu4mGe9lhvx
	od61zEoVYucCYf31x7ji2Cs2pc4wkRg==
X-Gm-Gg: ASbGncsGkkxZTiO3E1UpQdf6MvM+Pytf4jAB9APTLJsZkHNrCdQ3fVTocTjZcShKVKv
	T6dXvEAgI7ub/Lfq44+w6rAWCLDsI0qOYEnj9noDqHJDJLA98wZrtYvo0l9CiEm5TuuNu6j/Nis
	swXQfJAxpUu7Hd9UZLjbg5v7S4enCv
X-Google-Smtp-Source: AGHT+IFGjykZ4SdDgEKZoUI/RUHHbbSXJpxq52m6VI8lsQsM6mIzwIDYjXTz0LAKRnOM0sqIV3S6VNm3MTEg3SMsOMI=
X-Received: by 2002:a05:6000:188b:b0:38f:22ed:f9e9 with SMTP id
 ffacd0b85a97d-38f244dfdf8mr4990973f8f.21.1739462656741; Thu, 13 Feb 2025
 08:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213131214.164982-1-mrpre@163.com> <20250213131214.164982-4-mrpre@163.com>
In-Reply-To: <20250213131214.164982-4-mrpre@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 08:04:05 -0800
X-Gm-Features: AWEUYZnuKWbfVmEvZKQ-j1Kj8x4U7PcvzbuRKZExmXNfrnez826JkBMEaX5JdPQ
Message-ID: <CAADnVQKRKD1hxZ+rXQk5Af2my8vK_2OvQ7x6Xn58edYVkOpDxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add selftest for may_goto
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:13=E2=80=AFAM Jiayuan Chen <mrpre@163.com> wrote:
>
> Add test cases to ensure the maximum stack size can be properly limited t=
o
> 512.
>
> Test result:
> echo "0" > /proc/sys/net/core/bpf_jit_enable
> ./test_progs -t verifier_stack_ptr
> verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit:SKI=
P
> verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without jit:=
OK
>
> echo "1" > /proc/sys/net/core/bpf_jit_enable
> verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto with jit:OK
> verifier_stack_ptr/PTR_TO_STACK stack size 512 with may_goto without jit:=
SKIP

echo '0|1' is not longer necessary ?
The commit log seems obsolete?

pw-bot: cr

> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>  .../selftests/bpf/progs/verifier_stack_ptr.c  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_ptr.c
> index 417c61cd4b19..8ffe5a01d140 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
> @@ -481,4 +481,54 @@ l1_%=3D:     r0 =3D 42;                             =
           \
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("PTR_TO_STACK stack size > 512")
> +__failure __msg("invalid write to stack R1 off=3D-520 size=3D8")
> +__naked void stack_check_size_gt_512(void)
> +{
> +       asm volatile (
> +       "r1 =3D r10;"
> +       "r1 +=3D -520;"
> +       "r0 =3D 42;"
> +       "*(u64*)(r1 + 0) =3D r0;"
> +       "exit;"
> +       ::: __clobber_all);
> +}
> +
> +#ifdef __BPF_FEATURE_MAY_GOTO
> +SEC("socket")
> +__description("PTR_TO_STACK stack size 512 with may_goto with jit")
> +__use_jit()
> +__success __retval(42)
> +__naked void stack_check_size_512_with_may_goto_jit(void)
> +{
> +       asm volatile (
> +       "r1 =3D r10;"
> +       "r1 +=3D -512;"
> +       "r0 =3D 42;"
> +       "*(u32*)(r1 + 0) =3D r0;"
> +       "may_goto l0_%=3D;"
> +       "r2 =3D 100;"
> +"l0_%=3D:        exit;"
> +       ::: __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("PTR_TO_STACK stack size 512 with may_goto without jit")
> +__use_interp()
> +__failure __msg("stack size 520(extra 8) is too large")
> +__naked void stack_check_size_512_with_may_goto(void)
> +{
> +       asm volatile (
> +       "r1 =3D r10;"
> +       "r1 +=3D -512;"
> +       "r0 =3D 42;"
> +       "*(u32*)(r1 + 0) =3D r0;"
> +       "may_goto l0_%=3D;"
> +       "r2 =3D 100;"
> +"l0_%=3D:        exit;"
> +       ::: __clobber_all);
> +}
> +#endif
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.47.1
>

