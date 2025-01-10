Return-Path: <linux-kselftest+bounces-24272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97FA09E2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2565F1882AB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA84213E62;
	Fri, 10 Jan 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdX51MYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80C206F3E;
	Fri, 10 Jan 2025 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736548835; cv=none; b=qUcQaEbwmr8c5rhEfhHUkpNvpd7pjUeyi4OGM//1NBbgaEZ/JKuSFDAmAWvgl3wCiTFC6UV4rAP73XvYvrzVttBDeF17XvlaGR/Jaeg4VQSN0Dt0c9nmvrhK2oWhJR6mfxk9ywAO863ZgT3xpYXYHsBRYWoFOX9LHKC12MOrM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736548835; c=relaxed/simple;
	bh=JjeRsROKTisCANeC3WmgahWZpguueb+BLm9DD+R/ypE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9crNVEAhuQDVbV+USvXjW5JRenD2VdQmJzxCa7gT3xlZJVYoFidOCFIu0elL/5NPZeKK/YSK7UvJhj92IdOkWF910EcNUfiCj1pc8y4mlbOVy0G/ug1alE17WNZ4tmVsDb2IrWvMc5HjbuMfcP43c2dlpssAGRz9Rv6aSrRDFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdX51MYd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-215770613dbso32253275ad.2;
        Fri, 10 Jan 2025 14:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736548833; x=1737153633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Stl6zptucrFsube+R2vDGGu0uPnIP3Cj1IpKXX/q6lI=;
        b=mdX51MYdnNy29OGZ8XHn+6TKrPyd0G05+TbDOstlZ0HpwdRA4fmpaVmi+KUEHEmpX5
         0bUerbhVN2QKHlJ4mRBif2PONBaHdKQr7NIEOsmKC7crIctsu/KZvioaYl301xN/rKxx
         nNYDZXYveh2z3YI9MwTcVSCZEHPpjss7KuJRsWFF0dTvkUD9DS8wuO6/PfkzXi4Jzxwx
         6HfOcgoLZblmCTeE+HohdDcVlJXwDp9+JPbV8yLfUqreJFcnXItxGSZAOuHXpTw+Pl3/
         wW9+5S0Ab2Z4ZSHcuYGE3+9+LQkYB63fAwsZWEbUVstq5Klfkvp4cI5FpnJ8c32KtOJj
         d9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736548833; x=1737153633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Stl6zptucrFsube+R2vDGGu0uPnIP3Cj1IpKXX/q6lI=;
        b=POJwZVu4xrFTyHAnoOHcfY0ee1dSunFPByAeMMzUePjopxruB3RkaiEmtWnOo6m9U0
         O5TqFoUbbrIUR7D5IwSofun111HMJs9sWyHThSMZe4TYVPiKX/QxGxSYKkcP5HljA+WV
         RqN+80f21Vd9vbCOtvN0uHeKdqlEoZoyBtQ4/Vcv3ahAT4w7UXZO3jgwHdim1CjJVsN6
         pu7huurR0xskvjC6/YvnA6PP/YP8DCu+7oiRoPVdVweDZGA3/KgGDmTUSPe0HCRfV/zZ
         /8ZOld4OQDVT1ifHFsLdmJL31I8B8kg3l6+/rzY09UxcV9V4a6+I+RJxI/UPxaomvOYQ
         V9ow==
X-Forwarded-Encrypted: i=1; AJvYcCWGkB3iqb9hwR+kGQyYuL/p8u08IYMPospxsRllP7LkUES2LDgeQ51RpAjqPwd7jDYeFkg=@vger.kernel.org, AJvYcCX2cwg8sBgijcIHK/hAAP6pAIkgwFnrGz5cGgRvJWs606fgySFbWzerpL7ppVpYvcp4xTANWagr+GD2DfB5oFdE@vger.kernel.org, AJvYcCXn9LtH4MPvXyed7BZl0Asw8hjbiq6raogRhAKKz0yzdzkvXIU/US++g+FHYOSuP+av+lsUjEQ4RC8piLRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVVJz6kOIwNtxRyN6ACdsFyYbSRzmXgHSIdxT1p41Z5jOCSfT
	BRgViYLqI6z0GQu92ow3dolXhaglT9AkmFF4K4IwceMkchRYNc+niT3jNayEYnY4UXwHWurL8e2
	xC4Dh4QNinG+lCmzlszK8ekXt7lw=
X-Gm-Gg: ASbGncu6lY8EIJwBS15YKRwBF+FSSgRKxWx/90BNSqg6tNOr9/wEWSvl/H9YN/roWUo
	SUZzb3n1kkuXs1wd8RA6qCXnM/zTsk9fyvgBUANuEcMYstwc4EVBl7g==
X-Google-Smtp-Source: AGHT+IH+B7PpJkHmQoTL4cODRTRf22z0/RumBhMjfrOLfWZZVPKL0EHca26P6QfAAvV0ayPurvn5qXNKIValyOJzjsg=
X-Received: by 2002:a17:90b:4d0d:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f548eb2ec5mr19470796a91.14.1736548833064; Fri, 10 Jan 2025
 14:40:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d57bbcca81e06ae8dcdadaedb99a48dced67e422.1736466129.git.dxu@dxuuu.xyz>
In-Reply-To: <d57bbcca81e06ae8dcdadaedb99a48dced67e422.1736466129.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 14:40:21 -0800
X-Gm-Features: AbW1kvYrIq0VJTEsenltWhYg48TNE71byQwbjQXZbhQUlvAAjBV7U9ZWKxvovJQ
Message-ID: <CAEf4BzZuZu+tnCEE1vmBggJHxO+mF3gTYA0s2+1=SVc_YwZ7=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: veristat: Document verifier log dumping capability
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: eddyz87@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	shuah@kernel.org, ast@kernel.org, mykolal@fb.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 3:42=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> `-l2 -v` is a useful combination of flags to dump the entire
> verification log. This is helpful when making changes to the verifier,
> as you can see what it thinks program one instruction at a time.
>
> This was more or less a hidden feature before. Document it so others can
> discover it.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/veristat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 974c808f9321..7d0a9cb753e3 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -216,7 +216,8 @@ const char argp_program_doc[] =3D
>  "\n"
>  "USAGE: veristat <obj-file> [<obj-file>...]\n"
>  "   OR: veristat -C <baseline.csv> <comparison.csv>\n"
> -"   OR: veristat -R <results.csv>\n";
> +"   OR: veristat -R <results.csv>\n"
> +"   OR: veristat -v -l2 <to_analyze.bpf.o>\n";

let's be cute, '-vl2'? :) I adjusted while applying, but yell if you disagr=
ee

>
>  enum {
>         OPT_LOG_FIXED =3D 1000,
> @@ -228,7 +229,7 @@ static const struct argp_option opts[] =3D {
>         { "version", 'V', NULL, 0, "Print version" },
>         { "verbose", 'v', NULL, 0, "Verbose mode" },
>         { "debug", 'd', NULL, 0, "Debug mode (turns on libbpf debug loggi=
ng)" },
> -       { "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 fo=
r normal mode, 1 for verbose mode)" },
> +       { "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 fo=
r normal mode, 1 for verbose mode, 2 for full verification log)" },
>         { "log-fixed", OPT_LOG_FIXED, NULL, 0, "Disable verifier log rota=
tion" },
>         { "log-size", OPT_LOG_SIZE, "BYTES", 0, "Customize verifier log s=
ize (default to 16MB)" },
>         { "top-n", 'n', "N", 0, "Emit only up to first N results." },
> --
> 2.47.1
>

