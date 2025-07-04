Return-Path: <linux-kselftest+bounces-36607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E553AF9C1F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 23:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7984A586802
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1B26CE16;
	Fri,  4 Jul 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC+wgm7t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF421DF982;
	Fri,  4 Jul 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751666166; cv=none; b=E5uDpmIxzi+jh97c4Pnfs0c0dHhjHQn6n2iVIdceL7rsD+KRVbnnd8y9JH8pZTvR14f5MhSecAuBnsJOmTdNMCoimIUYfQZ5j2JVXaXLyA7V3JUhG/H6EiiiR+JLo6jShLVPzI66W6+o3UI8d7ZcJNEKNr6PMoWEwBNIJFyQG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751666166; c=relaxed/simple;
	bh=zNXTJS3uBxUmGHsmZ+c3a+AHqDcvl7xs7Dm0qbLfhz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBBU8+gUbYSOZ6c2pq0XnIish1Xx4lNlY6eRrs9vX6FfPEsg9oatjyzlMz4i+xfld72/ZTD3vhVBqTILt8/1Zo7Im3qT79ISo/WChgr6wG8A3kaRicyT1nNv/GoTueNgQjTvAqpXAOirSCNANMhi2Gzh50vd4/jiUC20N8EfOkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YC+wgm7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37087C4CEEF;
	Fri,  4 Jul 2025 21:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751666166;
	bh=zNXTJS3uBxUmGHsmZ+c3a+AHqDcvl7xs7Dm0qbLfhz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YC+wgm7t93zkFNQKybNd7dznFKi6I/yw7Ih2LZ72yFUVhe1S62I+C3pG4eWj7yYLI
	 /51/j0ypwAuoCndfytbr49ZVUSmpsRbqNGS4q6XwJAY0kdrI/0A2TU2wdnevh2jeFG
	 25bAyDJlNFjO8ZfKuzYNIRk/kMXwE/F5+BnskT38qenBGlgXFlROVx6SOQjpjWY1AW
	 8/wb6NQfaCE7WCFOOAnHN5Cqx9a8Qe6x0jxEno0sAXYfLf8XauynkBoZ9FYgME0bIj
	 VmGhgGQqxBVMrD4ubkqHYi8JcyqizG4bTTRi+8Ailzw/5IuXWrcGaR5SJcJmGYsTW3
	 F2mrST0wJjuzg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-555163cd09aso1300602e87.3;
        Fri, 04 Jul 2025 14:56:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnLRR6JlG+lXCf3trjWdAFVeGH7374+XCtYUiOtPQK1DSss7kQo+5WeQT0Iy13Wsd2Um/CLEvvaZE3e+2L@vger.kernel.org, AJvYcCW756Tg70ETAG4f5I6yPlvy8AXRK2XDcBjt+7TDMDP4sHkfV56d9FdKntwmpRBFRu0Cjn/VXLsiD4KOV8hR@vger.kernel.org, AJvYcCWHHUUy1e3x1OezaByBnX4KdK4fVzjZSFibKLdpaPHpZuWTZFnUJd/KVjMClHGJsbBsdF9LkRvr3tsAhnKBx03h@vger.kernel.org, AJvYcCWHw9fzlRKS/dGHE2pMkDf/+OsL3VfFW7yKeVDAJUp/qNORLe8LcuoFuXG1su3Gocbj9EqgYasX1nc=@vger.kernel.org, AJvYcCXFtuIECmwOyXgKlvVrlgWtlm9mTSTxEkIdhAMKx7IlyG01pfAkDtgRE0PzrLwSD3oUmrdf7QWQYYKV@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwrqhQtD3zJ/tXnNNVPZbBAXjlsaDi3CEt2y++PC4cPIWJM+m
	5IzwR1+QaR2lVdYZpGYO5ZxdYJ2XTCn6hkQuRbPXinhnECpXURH33msQFe/0sxHAUwfzXqzmEyT
	5/fHPSK3P6bJUrJDvep+HQ1yE62vytEU=
X-Google-Smtp-Source: AGHT+IFpsE562cO3KwgMvEKFNJ7cG2F8Ww5s7PQMhJBvpzxnFbdqEV3+rqtMX9YLw6c5NtuK02ZV8QcTdBQ+fCDBpd0=
X-Received: by 2002:a05:6512:1324:b0:553:35ad:2f45 with SMTP id
 2adb3069b0e04-557e555e14cmr81761e87.50.1751666164868; Fri, 04 Jul 2025
 14:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de> <20250626-kunit-kselftests-v4-4-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-4-48760534fef5@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 5 Jul 2025 06:55:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNASB9CNPOKS4sTRW85a0_y9EqNADfsNYYLb3Uq40Uth48w@mail.gmail.com>
X-Gm-Features: Ac12FXzBaC_-e5EaBcrc6ZKrKg4LYHnpu9kFi7Jh7W0oLkKvzOgsceVKcs5kJ8E
Message-ID: <CAK7LNASB9CNPOKS4sTRW85a0_y9EqNADfsNYYLb3Uq40Uth48w@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] init: re-add CONFIG_CC_CAN_LINK_STATIC
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 3:10=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> For the kunit UAPI functionality this feature is needed.
>
> This reverts commit d1b99cdf22e0 ("init: remove unused CONFIG_CC_CAN_LINK=
_STATIC")
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  init/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index af4c2f0854554bbcdf193852cf5c1d2c2accc64f..26cafbad4f1560fb56b4bef31=
ae29baf54175661 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -87,6 +87,11 @@ config CC_CAN_LINK
>         default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG=
_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
>         default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG=
_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
>
> +config CC_CAN_LINK_STATIC
> +       bool
> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG=
_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
> +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG=
_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
> +
>  # Fixed in GCC 14, 13.3, 12.4 and 11.5
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D113921
>  config GCC_ASM_GOTO_OUTPUT_BROKEN
>
> --
> 2.50.0
>
>

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



--=20
Best Regards
Masahiro Yamada

