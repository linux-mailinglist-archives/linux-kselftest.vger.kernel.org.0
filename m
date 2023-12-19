Return-Path: <linux-kselftest+bounces-2232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35330818FE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77047B221B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1638F87;
	Tue, 19 Dec 2023 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLMH2mpN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0B38F80;
	Tue, 19 Dec 2023 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553a65b6ad4so1241477a12.0;
        Tue, 19 Dec 2023 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011217; x=1703616017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nO3jI/Q2NQB6uHJqYhQph+tYUiVnTr4VjNw9jhdpkc=;
        b=fLMH2mpNmqCQR14iZnHZScuio0WetMsrbg0xzxosxOvsjRTPb1+cipnfVjAhguNCUK
         7XjO+JKFh2uEijJ1oEBhf09NvkAWnIpJ17go5kMZ+aCnjyHRYfLTj8ecPQy5+vTw7wpw
         Nhsk9n0hSH7Ak1UF0LSE9WE+o/vedNUbxrulkX+YzGaYzP2s2RIr0ZqZODkO78lVPVCx
         5JR9307Ry0M0Upcs7v5z+R4+5KSr3LohDdOmI4EKvBxOXz5E7OZxLUc9qSt2bqhthHGx
         r+Y5EcZP3VE2+OEu2qfgLy8eFqLLk7EwbG6IZnuEC5ZXp/MGd6iuGp8y2Z3b/KmZQReJ
         OAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011217; x=1703616017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nO3jI/Q2NQB6uHJqYhQph+tYUiVnTr4VjNw9jhdpkc=;
        b=mwY2ErzbAFtUUnZIISR2qnjgSJuIczGEDFGxZ2EhiGAWntpwcW/ZpUAOBRIMWwahMq
         R+lxHYi/1U6QWTtoDYBm8uTyaVu69JHuhEJdr1gmQAKoCM8M5nxgPeWaetYsuF9y704F
         pkzmmnE/C6QQ4h7me/ICJpHTw8+NTfNiTsNfHKY6yuiV8Q9BggkjKiE5rbRZqe2N85cH
         Kq6eDqS+EJxDqGHJ1FTqXUNEfrw81ZMXfonDe321MW2IkBdjI6YfrKc7ctOekAbbOGM+
         Hgy1wD+F/+1AXk9ZEkwHMfSBYW27ozWi4sY2En5cx0aqmDg+OXq/GvTnvnwCYCea71Dc
         SVmg==
X-Gm-Message-State: AOJu0Yy64sNrcpoYX2zs89gv/d5u/9Ytr4dEqpM5cDkRRqwOylRAoc9r
	ske/3GWDNBFYJgsKJtGDk+UDelaE7GtYEzICObs=
X-Google-Smtp-Source: AGHT+IGXuXgLHNJ+ysK8SNSr3Gp+3fEesjkoaFgWxZLNu7i0MkCpzznZk9kt8dONH18XSmp1s7M4yxdQotx//ILSzao=
X-Received: by 2002:a50:8d8c:0:b0:54c:4837:a641 with SMTP id
 r12-20020a508d8c000000b0054c4837a641mr10411286edh.46.1703011216566; Tue, 19
 Dec 2023 10:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219134800.1550388-1-menglong8.dong@gmail.com> <20231219134800.1550388-3-menglong8.dong@gmail.com>
In-Reply-To: <20231219134800.1550388-3-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 10:40:04 -0800
Message-ID: <CAEf4BzZQ=qk2Zdu9qT2DdPFc60-8NZbxMN8HXThZqP__X9Js_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/4] selftests/bpf: remove reduplicated s32
 casting in "crafted_cases"
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:50=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The "S32_MIN" is already defined with s32 casting, so there is no need
> to do it again.
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 0c9abd279e18..3bf4ddd720a8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -2097,10 +2097,10 @@ static struct subtest_case crafted_cases[] =3D {
>
>         {U32, S32, {0, U32_MAX}, {U32_MAX, U32_MAX}},
>
> -       {S32, U64, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)-25=
5, 0}},
> -       {S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}=
},
> -       {S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
> -       {S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S32=
_MIN, (u32)(s32)S32_MIN}},
> +       {S32, U64, {(u32)S32_MIN, (u32)S32_MIN}, {(u32)(s32)-255, 0}},
> +       {S32, S64, {(u32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
> +       {S32, S64, {0, 1}, {(u32)S32_MIN, (u32)S32_MIN}},
> +       {S32, U32, {(u32)S32_MIN, (u32)S32_MIN}, {(u32)S32_MIN, (u32)S32_=
MIN}},
>  };
>
>  /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
> --
> 2.39.2
>

