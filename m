Return-Path: <linux-kselftest+bounces-9645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C968BEDFA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 22:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD1E1C23BE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE118733F;
	Tue,  7 May 2024 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBf6lg/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDC187330;
	Tue,  7 May 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113207; cv=none; b=COa3RQZdyEK19+p1WNWNznp/U25ZXmbwbZd4ucKXn0uOdoAb9PJkvt+3xu7xLm0yszASKCY2F3IYMGdA4b5bDsQUJZvGf8fXSk2WVOj4l78FDKv67lEV72tDrNIs4LIBZMEYtnim2w8VNGLbvyzprpBv5mafPH5j3DLYUgL1Eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113207; c=relaxed/simple;
	bh=1WgW6mD2uzRFCDe53uN5b1jmdo1xPM2JOfOuoFEvBF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8fqx5VeUmcRw3euQ2Vr0EuXBagNd5iSc7h8Y7OsOQ5my0BgZR7ThvRp3kmIFWwt3HS1ZOFEjQmKr8CnClFM4P06ayYx/Ftbs2a5e2che6WoHSTljjfiVbwa58DlD9mJv3CXG9rNbGlkblc70D3auFkHxkSrsswV5B2dAQKuNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBf6lg/2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so2340942a12.0;
        Tue, 07 May 2024 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715113205; x=1715718005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOS+DwiwThAh+JeyziX6fFDWuUeHtd9N1ebV4bxlAQU=;
        b=kBf6lg/2Ea0PnnDny0Z/pyDFT2zmWH/nhsFfI/kK1tkVeTzxVJO0EL1ZaAKmLNQC9Q
         RIko9cnaRQtfEUD/0pblVN6wG803/9xOFHbzT3pplKJhkMKik+nHxfvVZ2lrX0IsxpGT
         ExMKHOca6zHwgHMuon8+xqKOGpidC1x/8SIvaIJmxTz2/oB+CbCUgJRbvugfSh6U12q+
         dO8rBwXOPSKOJJdM9qmjbavsKxeClV4MbcntHGvlhtCJaD1rOzP6P9k3jE0TMyr8dIWI
         O44bmiXKGsCljDhjdEgA+W4RYx/74n2140CipMpJvpTi9rXWKZ9GVd2alPHhsg4qU5WB
         Y8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715113205; x=1715718005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOS+DwiwThAh+JeyziX6fFDWuUeHtd9N1ebV4bxlAQU=;
        b=WvCCMiaoBafBDqDdH1eWPaYCwmPln/6tQ9nx+5KmBiQnkgxGCw5SkriqN8mfGE1USY
         5lMmNQzGz8F9aEJZ1ldxm3n8MJ6F/C+wEGytLlXOPx/LKBqejbUuESpuac72Ncu5sufx
         FQGSZHWQ4gwJluZJDUK+WHImlAPhHyKOc3zDv0OrBgvadv39ll0lb+NSsCaan//C5vtf
         oE3hFLrgUwIAM1wqAdCoaSxR1JZbfG44Z+GJoCb3x2zGypuDAQEDvVrS8ZRPPLwmprbJ
         Qy1oZa8jw37+hFVUL/hKZJz2dsxfSCoEYzL7d+8jwJ9AiOujNSz2I7gSsHAuCMjzzNBa
         YGbw==
X-Forwarded-Encrypted: i=1; AJvYcCXK/sdfZmC4aW7MVB1c6tlTCU1Wtx0M8HDD/4wsE3hlVmJ/Z864PENQn5wsz86AKTTMp6m3/ZjzmiQPjKJ/+wkLnL3xjuw2dPaAIKISvkOY4WYU1y6fxesqXuOxsVpyNd+o52L7AvJ9KcGASjZM9pDxoHbPcaT0j5D+zU9v4ejHioitCLqWmjVyv+YpPa5bkvwgAbF8qJMYL7110Wx8ewA5IZVn
X-Gm-Message-State: AOJu0Yxx3aTTKBvKdHfUN69nSXkQC+h7RvOGWxdOElsfdhOcdJ4goiV2
	qzBcwwGef+h+x0QgiFKHo7tKu1/9LFZaFjMOwc8AKBAqXcle54RdCtVUbJlg6Q6GiZa3uUMDdR0
	s2oGsdJ90yvQGSx5qaZHnXA9nbgE=
X-Google-Smtp-Source: AGHT+IGL2NXuNpuHrUZFX7GDbjtT+8cU3XmhVi6XIF5jF0zB73opX7J/BblIEVFRD3f3D/FEeJvYXk2tDmmfeYy6mUU=
X-Received: by 2002:a17:90a:f014:b0:2b5:258c:5f10 with SMTP id
 98e67ed59e1d1-2b616be1e5fmr656512a91.30.1715113205407; Tue, 07 May 2024
 13:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501112059.1348423-1-colin.i.king@gmail.com>
In-Reply-To: <20240501112059.1348423-1-colin.i.king@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 13:19:53 -0700
Message-ID: <CAEf4BzZ98z5eQmE42RKn2=TdVTqVjxkOehc-OydPd2PQ+fgmvw@mail.gmail.com>
Subject: Re: [PATCH][next] selftests/bpf: Fix spelling mistake
 "{GET|SET}SOCKOP" -> "{GET|SET}SOCKOPT"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 4:21=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> There are two spelling mistakes in .descr literal strings. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockopt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

This doesn't apply cleanly onto bpf-next/master, unfortunately. Can
you please rebase and resend?

pw-bot: cr


> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/tes=
ting/selftests/bpf/prog_tests/sockopt.c
> index eaac83a7f388..ecf5a7a047a4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> @@ -933,7 +933,7 @@ static struct sockopt_test {
>         /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D p=
rog_type =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  */
>
>         {
> -               .descr =3D "can attach only BPF_CGROUP_SETSOCKOP",
> +               .descr =3D "can attach only BPF_CGROUP_SETSOCKOPT",
>                 .insns =3D {
>                         /* return 1 */
>                         BPF_MOV64_IMM(BPF_REG_0, 1),
> @@ -947,7 +947,7 @@ static struct sockopt_test {
>         },
>
>         {
> -               .descr =3D "can attach only BPF_CGROUP_GETSOCKOP",
> +               .descr =3D "can attach only BPF_CGROUP_GETSOCKOPT",
>                 .insns =3D {
>                         /* return 1 */
>                         BPF_MOV64_IMM(BPF_REG_0, 1),
> --
> 2.39.2
>

