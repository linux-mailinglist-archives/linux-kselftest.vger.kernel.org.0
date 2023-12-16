Return-Path: <linux-kselftest+bounces-2102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B46815C2C
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 23:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BE21C215E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 22:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF936B02;
	Sat, 16 Dec 2023 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwyGaVcj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035E36AEA;
	Sat, 16 Dec 2023 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso21086205e9.1;
        Sat, 16 Dec 2023 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702766865; x=1703371665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ks0TZfvA9r0e4SlJoFIjoCo3olYVenfAjk3AapK29U=;
        b=VwyGaVcjkwvuYi66Z3o8hUQwUvuUHCbZF5owRHX0r0yTmuZAhIo81GNXAuDJMCB26o
         Kw5wMBOfR/uWXbw4OCe6Q8gGfhodYlHPjwpOP9s1lpz2BZy/tnAFOR5B0GZSanR7Clss
         P6w3H+L75VUsUOqQh3SmXNa70CPy1cnMf0ecdLTe6/ErZfY1Rg6S90atjChE9D0gKTyG
         TsTYMDqCugNMMJ9Ovw3HCHGgqR3UG0TgZgC526REMNT50d4uW48ezMLBBwyLZfvUCZQx
         EnIHLlq/5Idwkq4mhehOGdxJAZTueZCuMq4bkfGaBgGTG/sUV4KQaU5poYkxpkA6qyDZ
         SOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702766865; x=1703371665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ks0TZfvA9r0e4SlJoFIjoCo3olYVenfAjk3AapK29U=;
        b=OHTjK4cbv2UpFJTFPZhgSVVnWHn1ZEJ+IIR7RpNQ+zJx+gDzx/e4p7cfK2pMcRAUlG
         Nfbue+e+haG/38CdYyuxsnF6J44UcrRRZ5GU/xxT0RzDqsj6xpBIBS16PfEBYsbQJ/Qn
         62ISGpDHlMFVkbQLDsZevTiSvAyW5pTOpSrHf+C0pXMaITnYIC0R9usUAt1mSaPu+1bj
         1HDA9E7A1bUudh0WN9V+/0J7pomFfyf5nZ1q19EdcNKPHo2Ll+E3CV3afpmqYxUCv+tV
         GiSzpuZFlvU7a7OKFwTuNXLw5xTiukXTYcedeP4oh9B8prR019pS3lLCNNwG6gnXAtYj
         NPeA==
X-Gm-Message-State: AOJu0Yw2v8IOH8NBZDKMV8mkN/t8tPg/FGRBISstbIAtmXbBgvsd9X4w
	7olhEjJTBoHtG33eS5XGlka8ILuBVF0doMzOYIo=
X-Google-Smtp-Source: AGHT+IHyjGEmIC6eDf1kCPaeRQkg0Ls6qHzcZG9BPt+nW2VAdRQXAGiUeL29k+1w3+kZV6Sk2zpay07VadT6LoCoCZc=
X-Received: by 2002:a05:600c:4897:b0:40b:5e21:c5d6 with SMTP id
 j23-20020a05600c489700b0040b5e21c5d6mr4713226wmp.164.1702766864676; Sat, 16
 Dec 2023 14:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702594357.git.dxu@dxuuu.xyz> <97ada80f3aaaeb16bf97e31a8fc204513b4fb6a9.1702594357.git.dxu@dxuuu.xyz>
 <CAADnVQ+j80DCDHsqJZVmBOohFzOT01Ofdi3TbFEuV2xJ4+A=tA@mail.gmail.com> <CAADnVQLtQ3Qcv3Fp9iNVCXY-_2zTP9hEFqccKLxjgUZNs_uWjw@mail.gmail.com>
In-Reply-To: <CAADnVQLtQ3Qcv3Fp9iNVCXY-_2zTP9hEFqccKLxjgUZNs_uWjw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Dec 2023 14:47:33 -0800
Message-ID: <CAADnVQ+E2jdjV8=jy9ZktFT8Jvt=0_yKEoU6v9zqC52+prxPhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: selftests: Add bpf_assert_if() and
 bpf_assert_with_if() macros
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Just realized that we can go the other way instead.
>
> We can get rid of bpf_assert_eq/ne/... and replace with:
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> b/tools/testing/selftests/bpf/bpf_experimental.h
> index 1386baf9ae4a..1c500287766d 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -254,6 +254,15 @@ extern void bpf_throw(u64 cookie) __ksym;
>                 }
>                  \
>          })
>
> +#define _EQ(LHS, RHS) \
> +       ({ int var =3D 1;\
> +               asm volatile goto("if %[lhs] =3D=3D %[rhs] goto %l[l_yes]=
" \
> +               :: [lhs] "r"(LHS), [rhs] "i"(RHS) :: l_yes);\
> +       var =3D 0;\
> +l_yes:\
> +       var;\
> +       })

Realized we can do much better.
We can take advantage that bpf assembly syntax resembles C and do:

bpf_assert(CMP(cookie, "!=3D", 0);

and use it as generic "volatile compare" that compiler cannot optimize out:

Replacing:
if (foo < bar) ...
with
if (CMP(foo, "<", bar)) ...
when the compare operator should be preserved.
I'll try to prototype it soon.

Might go further and use C++ for bpf programs :)
Override operator<, opreator=3D=3D, ...
then if (foo < bar) will be in asm code as written in C++ bpf prog.

