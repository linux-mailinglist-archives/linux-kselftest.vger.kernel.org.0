Return-Path: <linux-kselftest+bounces-34755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B370AD5F7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 21:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E101882847
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C52BD01E;
	Wed, 11 Jun 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrXTWMuN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95D221F1C;
	Wed, 11 Jun 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671495; cv=none; b=KEZNVumRuFDbFszZ51AVzC1IJuut1AH0xipC/IlMXcueYBxob2q4aOeSvygTqdXqPyeHm6BOn7qftDahuzE42DJlY2jpAUN6Vy1Nmm5m5RvdHOUc0x5KYoso5dLA+x2VPSJQ1bNwfn3nnV4Pk4ulHPpOALGVEkYAfKV8HdUUBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671495; c=relaxed/simple;
	bh=X/OA1aXD+x1kt5nNgWcOiOS8Y92tVVSfC0Xz93AMSXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGtIYJBQELJMVB3HW74mK6FwczlrMq40e63u+DIRN/QW7X0iYWQ3pNGcHOOYH3E/qUlp8Bk/NMWy6LR0PpNqmN6dxo0rvTKpCHG6nkWUxhJH0V+P8AuAcgMddhS7L9f3jn20YB3EQjyopPEssySgEnZ0pk+H9b5FRjq2QRzu9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrXTWMuN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a54700a46eso253470f8f.1;
        Wed, 11 Jun 2025 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749671492; x=1750276292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQzMghNz4SMc/jj8ZNDpIvLoMQsd+F/Mm9SKGgQM0Dg=;
        b=SrXTWMuNKADkbaTmDXEOzjg3hBT3owisiPs58b3332j9ikLYYthd0Jpo3V2/3G89Pb
         8GSxsv9S+SnCTMfcuilkHJdzOIli1xS9/r9ZhvLEVE+DTCPAANyBuCOr8MEmVhfJTi/n
         t7fO9SybEoTTNh9qjCHj/oNGcT8KBiEnzpQNjms18ops0f5RFYvNVMYIJUVnD69kLTza
         Ag1KMWIzs4qF4kxOhZEepCUESklrtWZQgr6oTJOYfg9KnNT5Hx6Pl6CNHVWI+qabX0Hj
         zDAdDu1omNz1AjYpp24bIWYpMsHLjk/b8kO/SksDH6yPDev84lT264cPdGese7yMaJYG
         fo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749671492; x=1750276292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQzMghNz4SMc/jj8ZNDpIvLoMQsd+F/Mm9SKGgQM0Dg=;
        b=EsTiJbh33ycicovKW+uneABEbOCEcNFRKkXFldCkjlFF0ubcunYw8eS1PsWhXwKpNn
         8rJoQAVx7TyKie+G71b42YO6TanZbTI48UQy3lAKy60GpQRnfO605bV0xETASpHKnWuh
         Pe9a/DKGDMjJtxhMzoCqPn8VSxq3LCZn1lEH+jnCRIqZKrVNAgvuuELg5NuofMCVPS/N
         HQjAbE0reiq8LIuwsCDhwx06dw3dpkdA7FodfhMf5bLztyl1jxFN8A5aUCoPYvthOstW
         dEr74olygQVgr20gakjtxr007sMz7PQmr+3fjyS+g2D9HhBewwe1cBrasZIZs/t/wnEU
         +5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVVxIcjAC5K8EXlC1+3T6TkkNYUrKNJBKansWhIROjv3suLO9glMg1ypNXF+GtRFLKeHltyl/dz5InjYRy3k4JS@vger.kernel.org, AJvYcCWUkXQLRCQfTFqtm5xz7UMaFgbLgqVkCCHLSCAxrywRlPc2eV4Bn2Cp0p1Alu6W4dfWxARliP7DrQ5MfICU@vger.kernel.org, AJvYcCX5K1RlWzuUglHbOKXAO3Vlm50OP78qLFs2FD/d2N2TYyB6q4D7aji9E6UyNLXcvXPuMn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBP08Nxc2jtPRX6gD71n3srFWhhTYmpKLeUmiLpFVcT1TDMLL3
	r/11upLfepHn3ggNeJVzKx1p8i4XqoC9uvCa8H0dLqvT3NyPgMrDqk5VPIhrIc264AC6DMfl6wH
	fwNpQgFdRiG0DA1FYOL7bQsQqK1eQAoM=
X-Gm-Gg: ASbGncuVb+8YJptp5+0TekWxz7gB6feAualKjULSLJHoeVKHmqXsQpEu78q15EEeQfl
	ByFukQrY+dLDUU3DwB9g0lCc6ADyKNG/5Gw0VPxDqHlBvEPFKRfE0YqU8C1+Jh4XfJ6e22K1Bf6
	bKDmQY4KRYGP0VkLtXOwR2rocS6Y/N6KyvcKSKmvr2gZE1wD++QjyQ+wF0ZeTWQdkADBvOy+Uz
X-Google-Smtp-Source: AGHT+IHsMOspB6UuSIxOVa8i+vzccdKZaI+htNn9UjH3qwVgBZvxXthrfaJmH1ZHicGFh3pG6c73MfkN8aXZP5JK+T4=
X-Received: by 2002:a05:6000:310a:b0:3a4:d53d:be20 with SMTP id
 ffacd0b85a97d-3a558695d45mr3327455f8f.18.1749671492015; Wed, 11 Jun 2025
 12:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608143623.25242-1-wangfushuai@baidu.com>
In-Reply-To: <20250608143623.25242-1-wangfushuai@baidu.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 12:51:21 -0700
X-Gm-Features: AX0GCFv7vXXDLbAwxkRk67UWzs3RvlU2LBWLjvW30iGM-xMtg-Wi-MUDz_hGEmI
Message-ID: <CAADnVQ+SSPhZNN05F2-MS_79Vhp+mSTWF3Ss1rcoWRnaDjFx+A@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix signedness bug in redir_partial()
To: wangfushuai <wangfushuai@baidu.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Shuah Khan <shuah@kernel.org>, Michal Luczaj <mhal@rbox.co>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 7:38=E2=80=AFAM wangfushuai <wangfushuai@baidu.com> =
wrote:
>
> When xsend() returns -1 (error), the check 'n < sizeof(buf)' incorrectly
> treats it as success due to unsigned promotion. Explicitly check for -1
> first.
>
> Fixes: a4b7193d8efd ("selftests/bpf: Add sockmap test for redirecting par=
tial skb data")
> Signed-off-by: wangfushuai <wangfushuai@baidu.com>

Looks good, but please spell out your name as First Last
in both From and Signed-off

Also use [PATCH bpf-next] in subject

pw-bot: cr

> ---
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 1d98eee7a2c3..f1bdccc7e4e7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -924,6 +924,8 @@ static void redir_partial(int family, int sotype, int=
 sock_map, int parser_map)
>                 goto close;
>
>         n =3D xsend(c1, buf, sizeof(buf), 0);
> +       if (n =3D=3D -1)
> +               goto close;
>         if (n < sizeof(buf))
>                 FAIL("incomplete write");
>
> --
> 2.36.1
>

