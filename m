Return-Path: <linux-kselftest+bounces-40203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE369B3A73E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B876808AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 17:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656AA3314DE;
	Thu, 28 Aug 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPAkIzam"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A41E230E;
	Thu, 28 Aug 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400563; cv=none; b=JLyOrmp+5Kme9clI7d/cA9y/qg9w6DqtWjEg9D36+UBrHfHqRLfUZlYIhy66yVnbgfi+UqGO4/2SmnlDz/rFkH1VLzgVeuNvqvOpbZynwE6+lD54Q7VHZ9qMw2SlwyUNis1aMEtGu7jB/CoY1EqQc5piHZIDwTzUr77uHQqZ3Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400563; c=relaxed/simple;
	bh=EJfRKUgvGLPSNp0OfWV+ZTfbV6gOuT39Bb9qfqn2J8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRmopEi6Pf6Y0nvf+EyqkMSaQK3hyu+2lbkN5sbB2zIbzvqtqcRwHSkGyYVCt0n/agg6EZ24uAYtUqpL3Lzs5fTeaxqwxl3I6kEB+sSUISCsw0TinkUoudEItFsow7sqLhGA22Djs6EGxluXYJBGxJ+kCPpTQ6cuOQTZghaOz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPAkIzam; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-323267bc2eeso914075a91.1;
        Thu, 28 Aug 2025 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756400561; x=1757005361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2nUVz8G1arCOueidxvkz6Q/l/3hFWxhgHyhVlr937E=;
        b=hPAkIzamAoio5LL7j2P9MX8mkoE6l6DmpwWEY0AsDgGi+iVB2MzXqoDpKHWIvP19XM
         M25Qj+V3r2pLwspMlTbTq8ZYHoucDDnF0Rm0waG1go4pYoEDu0WrMTkDIlxMJSvlq+Xu
         /EgU1KxP0x6t3eSSidNU+wi5dX1FsfSWmm2IgDLrAXZPZ2PeauhgejDhxsD518ojTkH+
         FlQdLmIfFQOgworfTrNdM9NqF3IhwftJDI8+i9zrRpo/6mSB3B7mNcs0pFkSeyqQFFn7
         M/cyspPPuczMiEn4R2t61DuKxFKx0neMUMxf3CV8oNOO/72WB7lhiUIpyxXMrYY+vpsQ
         ZQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400561; x=1757005361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2nUVz8G1arCOueidxvkz6Q/l/3hFWxhgHyhVlr937E=;
        b=v1pihuG22hGlvoIiP3ure5RsqyO/wE8ZSgmuW8o1nS7iVjs8uCTWQlixJ6ckf67qdK
         +j/P02nhNSWuTnRpwJJQ1pwGQ/C2z4aln15opXdx0DsEPwzePtjhLDnweJGlkCgw90Ge
         Bi5LFDVBllNf96ofZ6D4qYc/3kcqD53l97wuisuoXTvg3yInA2wqsk/CRdN8L9pVvUsC
         KS/RzwWxFdF5QfScP/M5gfdy2gChB2veRra04GZe2Bui8GsGCxi7DaRPp4zJhS5I9FaG
         5YIL+h6+n0YV/41TQrSU2WSNWsiGXbtKFKKGMiyAvvRJJc9Tgpjvu4O7Kfo2xKmEZqMs
         zi8w==
X-Forwarded-Encrypted: i=1; AJvYcCUItGDZVSnR4U47D3tLXhPtb5oGTFFmNuaBITBoa3WDFCDk98NlM+yEbj3xNj6rfSbpW3Y=@vger.kernel.org, AJvYcCV0DzHcnLEPC0A0yOpYklPhSIEqnVvzi0Fz8FaSfI5pagUUnNfpbmqd1p3h1LXs90athkbrBCmxdMnqNo9h@vger.kernel.org, AJvYcCWkub4za1z8N+eYFKkm/3hqCRbPSQqp8PkZOxpaXpcvxWjJ5tT83YUl5SNl6sBdI8Eb+knPLM2euwgzJPkUYmZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJgkntcmGGwYgW0IApWx191BRGMP5jreWOjdK5zumR2ECWoph
	NzBaDY4eVzMKoqZ+Y6t6Qa1RYM6QCr5eU9ry9xdo6/yFLVFbhIv2qoLpIEG5qKeqeh5mgAZ/R48
	YlesI9Na6uW9K9q4iENmPcvSciTq93as=
X-Gm-Gg: ASbGnctZGbaP/krwWjNdzgew1CjraFisvbk75hQ/k4tjqTvhZdfJKRbIEyinkTRgo1k
	YOmiR9czxV1Xd65J7FBB+l5kvTUmBpfB3zbTcnJjQcmBVITptJDWOAZ+SWtwxSVmfKUCMkDF4S6
	48Q+DJb+WrHkkAci7k7/lDrNw578b/U4vkVUSdDRYAsRci5D2n+aPss3xn03o7rRRSJwFGBYkkO
	cGP/NMM70KfzM4j8SYbQAZunAHeH5bxpIq4p5AO4RU=
X-Google-Smtp-Source: AGHT+IH9Pnfp1hJF/NuyGfKEhtpuhN0OI49CJQdBn2/TDfZeldtzPzyiQeOZQBc7fdxMVowqvo/w5wOAMNHZcDnwnXw=
X-Received: by 2002:a17:90b:2d83:b0:327:8c05:f8b0 with SMTP id
 98e67ed59e1d1-3278c060374mr7137226a91.0.1756400560641; Thu, 28 Aug 2025
 10:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756378974.git.rtoax@foxmail.com> <tencent_A842AF5EA32A88970690424E592897FC2A08@qq.com>
In-Reply-To: <tencent_A842AF5EA32A88970690424E592897FC2A08@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 28 Aug 2025 10:02:28 -0700
X-Gm-Features: Ac12FXyNPRU_qoqhYwmgfgC8IvpGXyQw2UDaaIc8g2-dAY_5Rq1HHyksLn7lnCg
Message-ID: <CAEf4Bzb9WE27ngUVsYh0x0O85e891rbuX-YChDkCRm_U27_04Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for bpf_strnstr
To: Rong Tao <rtoax@foxmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, vmalik@redhat.com, 
	Rong Tao <rongtao@cestc.cn>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:08=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Add two tests for bpf_strnstr():
>
>     bpf_strnstr("", "", 0) =3D 0
>     bpf_strnstr("hello world", "hello", 5) =3D 0
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/bpf/progs/string_kfuncs_success.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index 46697f381878..1b56bd5860e9 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -30,7 +30,9 @@ __test(2) int test_strcspn(void *ctx) { return bpf_strc=
spn(str, "lo"); }
>  __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "wor=
ld"); }
>  __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(=
str, "hi"); }
>  __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, "");=
 }
> -__test(0) int test_strnstr_found(void *ctx) { return bpf_strnstr(str, "h=
ello", 6); }
> +__test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", ""=
, 0); }
> +__test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "=
hello", 5); }

add (str, "hello", 4) =3D=3D -ENOENT case?

Also let's add negative ("", "a", 0) =3D=3D -ENOENT case?

pw-bot: cr

> +__test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "=
hello", 6); }
>  __test(-ENOENT) int test_strnstr_notfound(void *ctx) { return bpf_strnst=
r(str, "hi", 10); }
>  __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, ""=
, 1); }
>
> --
> 2.51.0
>

