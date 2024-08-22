Return-Path: <linux-kselftest+bounces-16123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD395C18E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 01:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880A61C21EB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9261183CCE;
	Thu, 22 Aug 2024 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtqtT7pN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF7183CC2;
	Thu, 22 Aug 2024 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369794; cv=none; b=MLGql/x6lONyndDbBENZyo0f8gIL977iKCUMYt3hDjV1xFrniC1c9S5jm01eVE9DH9l88ko6sciSq/dGOj5j7gp0pW17Dpgxt1nqjRcPt5oEqMxvQ9QbzCkRrAibqcdUtvz8WbA4qjL94/ZpndTlZ9nneKKXGtHo2+4FbyrCxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369794; c=relaxed/simple;
	bh=Mh/V2UOwYE1oOdgAmaeSJ7s9xbNF3ia0lxKemfTSKKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKchQEljK+CvgTOkrZ11mWNdbxcj+MJRqKcC5pFoYEH0Mi+nbHWEvHasPW9pNrSOa1kzK+31DLM3mZRL0Ol9uZ0b46fVUF08qipgvVsgPbiLTb05VHuQ1BndnfYjYgkWkfQJZDWIf1v8+wcPyXAWAQz6X1u+i4pVr3nLdatUB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtqtT7pN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed05c0a2fso1864015a12.3;
        Thu, 22 Aug 2024 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724369791; x=1724974591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF+/qLORagGz1oaKY0E2GymWQjhvIxPCMoMfuSH+n30=;
        b=WtqtT7pNAavD244IqMUu+wE84BWdn/KvX6I406XfIfV8lNYzVtAyf5VWIr7Y+qCEEH
         zcGanqh3C6SUrKBUk1pFeScjUPUpkpaIxjU/ghI5uduQhzD5J8zcFqUw5ZyET1fqT1AP
         JVwkWnj28nCgG5sNrPxpQfAz3bcYsO0NqzsIA/viiUQtL8UhJS8LstlO9w4vI2SQJDkf
         CqIdhrxalwv5rOjtufa3m6tEmZEKKwXHzEchVyTlAmrJf12IU0vaCR6cIfOYi0s9oatF
         ZCrmqHuY8PslrBA/4zQTHu3Z0vqtUwj2YPUg7o503kQGUdHQb78TcgWbsANtkkulQf6L
         YJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724369791; x=1724974591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF+/qLORagGz1oaKY0E2GymWQjhvIxPCMoMfuSH+n30=;
        b=pxmgmsG8VE/XFlFezYR6XW/xJOkyP+9q1zSr55+dJlyXJiKSx0I76/vKnecMy56Zxm
         XDbVUtkeSicSMDWhXYOLssd7llZhYPT/oMO1BhZUOso0DPZtfqXRUQwzC5DtQek4VQlZ
         OlsjaPWw/BXA1Nr5mBSZ+2IjThzKEkBECaCY3Bm/bgmNW+f9G6UJnWAClwdnwReg+9Ke
         BvZx1WGCjDraNoU66NK16OLJGDNO9m1JX9M3l/m1XnSvuo4ifwPvsviltvoPkmCGsTxI
         r7XXuRnP83hsJpqDC4pgWitPp6+j7R+lvgR+g03YFinKvELeiL0z6O1gbEYZdVc6Tvwe
         uD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY2a2+ZKP9EJIFl4ZxDC5IF4zxay/7ahW5imtGk4rKm95ut1hCOS6zAb+TR91TGxsZCbDhKLhD+0cng35/+RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqqWJtbAqRuI9PRjil89d1T7bOof21FWPAJA00aUBZQ2CKEfD
	ktGv0FNpme/d6EDokBRcb2yacrGHwzOKg903XqJ6Tc6QlUps6147N6p+onefAgLQCgQpH8j31kq
	80zfK1aY7KeJFxIlaIvMwG7wkrS0=
X-Google-Smtp-Source: AGHT+IFYHOeLzjt4Dn5Vl6AjKwVlSQryGPOqOIsfTIRqD2j6r2MmhTAp4cZuVkeWDFBC4jvXb6mb+SSaPuXTVILP6kA=
X-Received: by 2002:a17:907:3e9e:b0:a83:7ecb:1d1f with SMTP id
 a640c23a62f3a-a86a5489eacmr17881766b.46.1724369791506; Thu, 22 Aug 2024
 16:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724313164.git.tony.ambardar@gmail.com> <884c0e57404f3ad15bb658bc55b7d16928069828.1724313164.git.tony.ambardar@gmail.com>
In-Reply-To: <884c0e57404f3ad15bb658bc55b7d16928069828.1724313164.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Aug 2024 16:36:13 -0700
Message-ID: <CAEf4BzbaZ8QpcEVQNU4+O-07eS6-BdQP9KXaJQysWt1uZPoXTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/8] libbpf: Improve log message formatting
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:24=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> From: Tony Ambardar <tony.ambardar@gmail.com>
>
> Fix missing newlines and extraneous terminal spaces in messages.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/btf.c          | 7 ++++---
>  tools/lib/bpf/btf_dump.c     | 2 +-
>  tools/lib/bpf/btf_relocate.c | 2 +-
>  tools/lib/bpf/libbpf.c       | 4 ++--
>  tools/lib/bpf/relo_core.c    | 2 +-
>  5 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 32c00db3b91b..cf4f7bd7ff5c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -2940,7 +2940,8 @@ static int btf_ext_setup_info(struct btf_ext *btf_e=
xt,
>
>         /* If no records, return failure now so .BTF.ext won't be used. *=
/
>         if (!info_left) {
> -               pr_debug("%s section in .BTF.ext has no records", ext_sec=
->desc);
> +               pr_debug("%s section in .BTF.ext has no records\n",
> +                        ext_sec->desc);

if it fits in 100 characters, it stays in a single line, please don't touch=
 that

>                 return -EINVAL;
>         }
>
> @@ -3028,7 +3029,7 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data=
_size)
>
>         if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
>             data_size < hdr->hdr_len) {
> -               pr_debug("BTF.ext header not found");
> +               pr_debug("BTF.ext header not found\n");
>                 return -EINVAL;
>         }
>
> @@ -3290,7 +3291,7 @@ int btf__dedup(struct btf *btf, const struct btf_de=
dup_opts *opts)
>
>         d =3D btf_dedup_new(btf, opts);
>         if (IS_ERR(d)) {
> -               pr_debug("btf_dedup_new failed: %ld", PTR_ERR(d));
> +               pr_debug("btf_dedup_new failed: %ld\n", PTR_ERR(d));
>                 return libbpf_err(-EINVAL);
>         }
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 894860111ddb..25e7c44d9f95 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1304,7 +1304,7 @@ static void btf_dump_emit_type_decl(struct btf_dump=
 *d, __u32 id,
>                          * chain, restore stack, emit warning, and try to
>                          * proceed nevertheless
>                          */
> -                       pr_warn("not enough memory for decl stack:%d", er=
r);
> +                       pr_warn("not enough memory for decl stack:%d\n", =
err);

nit: add space after ':' while you are at it?

>                         d->decl_stack_cnt =3D stack_start;
>                         return;
>                 }

[...]

