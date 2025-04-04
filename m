Return-Path: <linux-kselftest+bounces-30115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742EA7C0FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA56E189773B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD81F582D;
	Fri,  4 Apr 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCnPm6lT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45371F5408;
	Fri,  4 Apr 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781948; cv=none; b=FWlK6Qz1MZwDrk/fmUm6Jnmnp2F2WugVejCaOf1eqpPl0H8VIEx5P5s7sg1APIyOXeNjKGfDxK4O3GvYfg/Uqbcz9laLpIi/3bKKTuTGw6vd5EHJLgvpOcMq3jGdw0MnHYHbb2UQl7/tJs9jV481RyxtsWLZVEdfgcDA46Qzf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781948; c=relaxed/simple;
	bh=m9gKAxEv8+1se/VyAuR+Yuv/+qsz90ObqP12AabUSZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6jQ8zonFpjGJ2VW9+vlmuVzrNsD8gCVmWQATTTxerc0Njb5JnD4SZNAOGxKXT691qWLdV5A2/74sUzOSy73ssvKXaedftqLTbW35jJbDAd0TzNUAO4dL5bOJvOlhWsIXmbBEAhZ+EXxxZ3TZV/NVrJJtVn4k29polCZtOy11fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCnPm6lT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73712952e1cso2122153b3a.1;
        Fri, 04 Apr 2025 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743781946; x=1744386746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aWTDe+rTzrD+6R9DmIQBtw8FiB3Cn3PFxzKkYh4A0s=;
        b=WCnPm6lTmO/uCyoLABLaMItvwEXWro5Co+kC19ldt7Uh+Q9qrANFwW/y8pxn1NP9jN
         UNT/L3wlolMVFGecSyV6XMq66xWz5L5ok2h0BbGG/VJHLr2TCVC7JiEg7BCYLBABHCLL
         kZJgrGYy6FAq37w3V70i8sx317eP4AWUpGQSxPY/3bEAeBRTJE7skEIV9hLeuEAl1iKv
         tIh4jguRk10+3zZeNRHt1obHhx+5mSfXRjvgwUcIQAPOoaxJrrjoK+P0o2Jk3hB6X67a
         j6ET1xjTAedRfpCgZgp2auKdQ4VqGS6g6OgymS7xsE77/vUa0KXgGjkoXn8wg0VUOAL8
         iFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743781946; x=1744386746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aWTDe+rTzrD+6R9DmIQBtw8FiB3Cn3PFxzKkYh4A0s=;
        b=RcHacwshefqemq7k7v9cTbedBNRiGEcEc9L5QqUlL5L+8L5eeTktqmA57lXFPhoqDy
         FFiVb2VfFWfzczBChGjzgmirllDkghyF+2ESvlX1+nWE+RDRc0Rdjb7lL/ouGz82PQ1Y
         XtJ7ZS2q3LYr8d4VdWJQUT6xGHA9yuwOtnOrcyJ0CR8uhOjmTweMFZIPbIbYeUFFKgxS
         IXtXAK0YERiJStC8rUdY72NQVovoq44zX7hGHnBRCB7FtNcOn+Ibaj+oCTSBQ3klOZoj
         6fdBb6xZ5N7yNmIXRNhdxLI6esGqc3AIJDwN9X8VvtkdjFJqJ1Uq0STj6yyeFOl6GzNB
         UBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUCifk668A+VLDuAV/FUutZ2ojv2r4UdndHjEvDpsybDm4vvf9lnCjeBrbacsflKYJKSMszAbxEdcbtSPY@vger.kernel.org, AJvYcCVmTCI2U/J9yoW+qe3Qsfe+P3pifpcv0a3Vag90f7TaI2IY8odsZBLYdoAKpAVZUm8ob4GKRW+oudp/pxeoch6c@vger.kernel.org, AJvYcCWft+TcLlV1AbKmGHoqKQ1v76h/UDg3dtv13C/GjKAIvodU3IKUviSc2SqEMc832Xf+L+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEc0Qqp8Iblrrw/v/lujQ9Cwy//sf638MbPudS7rprjA2+V+Ee
	nB14z3rIB/VyVjVdzldMtAAru/dYv4iiD35C/KdPLnlIa1iy7GUbhpEv0K+E7ZRZ5/DcLP/O/Xo
	XMba/CLdB/8IW3KEjqh8lUcNGgKY=
X-Gm-Gg: ASbGnctAIiWum94cJUGX8lULwKfcsMUIyA61LvPJuJzvte4cEJIAeiY3M4ntskVjCGy
	xAqkaImEAn51K8VVW3Z1OaY+dr2QBCuoKUaJT742Ui++jdKBtBdtKmgcGp589B4LVPPtOm00a9l
	EgpwGucrbXTp2cTgAx0YwsTAjMjubocUltMSVCsp0FO3ncxQG4qmY8
X-Google-Smtp-Source: AGHT+IEvIVeQZa5TCXYa49bWJYhlsbglGPFTWlTmzAYUiGUKqdhgB3iFQEsIbHaggKb+5mNlOlhexiQxMWXg/N6NSUo=
X-Received: by 2002:a05:6a00:2292:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-739e4855de2mr5463254b3a.12.1743781945762; Fri, 04 Apr 2025
 08:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <malayarout91@gmail.com> <20250324064234.853591-1-malayarout91@gmail.com>
In-Reply-To: <20250324064234.853591-1-malayarout91@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 08:52:13 -0700
X-Gm-Features: AQ5f1Jr6dpg1vkl2088UME8oWw4P2Av0jpCylRO5ZZVK_oKaO02pvSj060D0bCc
Message-ID: <CAEf4BzagSxO-fNeeWfFPu2vpnbEUBnS7Y2P=ODGks_zVEg1mkg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: close the file descriptor to avoid
 resource leaks
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 11:43=E2=80=AFPM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> Static Analyis for bench_htab_mem.c with cppcheck:error
> tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
> error: Resource leak: fd [resourceLeak]
> tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
> error: Resource leak: tc [resourceLeak]
>
> fix the issue  by closing the file descriptor (fd & tc) when
> read & fgets operation fails.
>
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 1 +
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/=
testing/selftests/bpf/benchs/bench_htab_mem.c
> index 926ee822143e..59746fd2c23a 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> @@ -281,6 +281,7 @@ static void htab_mem_read_mem_cgrp_file(const char *n=
ame, unsigned long *value)
>         got =3D read(fd, buf, sizeof(buf) - 1);

It could be a bit cleaner to add close(fd) here and drop the one we
have at the end of the function.

pw-bot: cr

>         if (got <=3D 0) {
>                 *value =3D 0;
> +               close(fd);
>                 return;
>         }
>         buf[got] =3D 0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/t=
esting/selftests/bpf/prog_tests/sk_assign.c
> index 0b9bd1d6f7cc..10a0ab954b8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -37,8 +37,10 @@ configure_stack(void)
>         tc =3D popen("tc -V", "r");
>         if (CHECK_FAIL(!tc))
>                 return false;
> -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> +               pclose(tc);

this one looks good

>                 return false;
> +       }
>         if (strstr(tc_version, ", libbpf "))
>                 prog =3D "test_sk_assign_libbpf.bpf.o";
>         else
> --
> 2.43.0
>

