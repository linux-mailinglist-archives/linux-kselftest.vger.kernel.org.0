Return-Path: <linux-kselftest+bounces-1994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2C814030
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CF01C221BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC410E1;
	Fri, 15 Dec 2023 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLRQyiEc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9D46B1;
	Fri, 15 Dec 2023 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336447f240cso99222f8f.3;
        Thu, 14 Dec 2023 18:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702608390; x=1703213190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQP9MgK72ktKydhJ4Sd86nQLKYkKX/b8wJIAMimh76Y=;
        b=jLRQyiEcYOSpj71XPYjhxFzsjPDrP7E+C9ph8KPlBJ3avkoc282jh/NqykQdWNikN1
         DiFsGCSHn7ObMmiuY4STXY8y0WuC4jICrKEXLKmjpbEiXJO6evGY0enJ8ymbS/E0T+eA
         /YdhB487RXeqzp4TcOYjuarVf7OBe9CZYXuWpidRVfORydRS4QLww0YM/7m3ePUBdNSb
         ZYlN01tRrXdI7eK24Qch0/eN1WOaX/8oCK5fNVcLJfeZC96HtmOeNgiUBeyKlOLg1M3T
         mE1laPSeEO10FswUo0PLiZmGU+plkq8qO9kRdWZpXYntzRLN8AhrvoSG732F2TPraN/X
         NbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702608390; x=1703213190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQP9MgK72ktKydhJ4Sd86nQLKYkKX/b8wJIAMimh76Y=;
        b=Te7THDOxWJU0LuEh9Y51peWlnA0P3QGDX49q3LejqFKrFAofUudbMurYSVTHccyH8t
         35CgdxfUwozi1j+Iqy4k6ZX189IPkJKNNwwE/85WndnvAjsxYzGmbHjw3Sf0A0kKnwC7
         EaOUY5pEcfsMEE7FGg9NB2K+QBR2ghJYO02iXMl/VfSmUABZbl90C4g+6Zghj41wNR9y
         Hx9+9xLF4dHUKM4Qmvcc1/P74RFHfP2rt10xPUgmv4wXXQuWzCOyoOemI3kQ+awBKUDt
         by2hhi2vYOq0mtuv7yodSao121wugnvC+TUmQDdppiv9dCOcfi9GuA0VXn3/n0duiqs5
         4yGw==
X-Gm-Message-State: AOJu0YzzyNWlepPS5JRuwDr/1QEB6pa/0BwU7OYIgsbxWIkoEKeHdknR
	kkm6QS3F7yxrUNduYCP2+aqdPlBDYzUYBSAsghc=
X-Google-Smtp-Source: AGHT+IET6mk/5KdP95zibr3c9wPK3ZnXhMahqd+rDVI4co35xqUOEuC0bTo3empnf6uNK/k9YOZM4Ik2o/fuAUskq3w=
X-Received: by 2002:a5d:4cd2:0:b0:336:42ff:6924 with SMTP id
 c18-20020a5d4cd2000000b0033642ff6924mr1654975wrt.56.1702608390344; Thu, 14
 Dec 2023 18:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702594357.git.dxu@dxuuu.xyz> <97ada80f3aaaeb16bf97e31a8fc204513b4fb6a9.1702594357.git.dxu@dxuuu.xyz>
In-Reply-To: <97ada80f3aaaeb16bf97e31a8fc204513b4fb6a9.1702594357.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 18:46:19 -0800
Message-ID: <CAADnVQ+j80DCDHsqJZVmBOohFzOT01Ofdi3TbFEuV2xJ4+A=tA@mail.gmail.com>
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

On Thu, Dec 14, 2023 at 2:56=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> These macros are a temporary stop-gap until bpf exceptions support
> unwinding acquired entities. Basically these macros act as if they take
> a callback which only get executed if the assertion fails.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  .../testing/selftests/bpf/bpf_experimental.h  | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 1386baf9ae4a..d63f415bef26 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -263,6 +263,17 @@ extern void bpf_throw(u64 cookie) __ksym;
>   */
>  #define bpf_assert(cond) if (!(cond)) bpf_throw(0);
>
> +/* Description
> + *     Assert that a conditional expression is true. If false, runs code=
 in the
> + *     body before throwing.
> + * Returns
> + *     Void.
> + * Throws
> + *     An exception with the value zero when the assertion fails.
> + */
> +#define bpf_assert_if(cond) \
> +       for (int ___i =3D 0, ___j =3D !!(cond); !(___j) && !___i; bpf_thr=
ow(0), ___i++)

Kumar,

Is this approach reliable?
I suspect the compiler can still optimize it.
I feel it will be annoying to clean up if folks start using it now,
since there won't be a drop in replacement.
Every such bpf_assert_if() would need to be manually patched.

If 2nd part of exception is far, how about we add an equivalent
of __bpf_assert() macroses with conditional ops in asm,
but with extra 'asm volatile goto' that can be used to construct
release of resources.

bpf_do_assert_eq(var1, 0) { bpf_spin_unlock(...); }
bpf_do_assert_lt(var2, 0) { bpf_spin_unlock(...); }

