Return-Path: <linux-kselftest+bounces-36606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29BFAF9C18
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 23:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622FF580A34
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE861E51EE;
	Fri,  4 Jul 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN4dbwQy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA752E370A;
	Fri,  4 Jul 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665951; cv=none; b=iAk6EmnGUGyM7edy58B7XNjfJE4pktm3cMQs7ERiwBFbEwZwYN0mjA1BXdIUAWCg5bDLrmKwIhrC1R5hSuV4mOuzJeSh9Y7uVlKQKdASOhvuc3NqrqsP6fre4LwHKCTZW8ucFm2nlZZv76i1hv//Fbb+FoTJuZAGPqWo1+U0QLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665951; c=relaxed/simple;
	bh=k6/4TFceHQy6sWE6+SzawLZ4xB3ffR2Gi1S7m5FKRN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah9adGVJghzbqqGOWiqi3V4fEGegeS9GJlh5Z48e21WYr/H6GS5ztbL6gX7RVWaVguY/+BcoHpjPZwLX5l5ydGnchjQ/2iTCTOQuenofYUZiNmIsyyl+f7wkPHDeoFZGxBqLPkbV70/Fwz9zG8AKTMX/dRQgXWNdISUCgZwJkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN4dbwQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594EBC4AF09;
	Fri,  4 Jul 2025 21:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751665950;
	bh=k6/4TFceHQy6sWE6+SzawLZ4xB3ffR2Gi1S7m5FKRN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sN4dbwQyGyGzl686FYVZ4i1JZI6nR9MwEqrRmAEwAupfNyOjaNfFOXytk69u4wzEc
	 8vAfhxYuQz60etrBBOxXPb4DqKb0AieHX/zc5AzZI6YW6OWOBrAF3ysHpJkDcBca9l
	 2oOQGfiLPJHJEBXHNDSXXRjLMISVPYGFOH478RBZUFZARqnlXDakFksueuM3K7nSvP
	 EgjozpwjiLV1SDOHFhWhVZu9aLfZ07HHATucPMcIhmFtCfeNpCdAA5SXxumd/Vgqw3
	 fPLXo7MnTV70kmZj7XknktQc6UzqLcbXcjp8yHWst5yZImSEQLFFDIb7pwAWw+amgu
	 JrxKFJ6BDgWcQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b7123edb9so15649551fa.2;
        Fri, 04 Jul 2025 14:52:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUa3MFbXnbynb5L6uGzhE6G9S1tvZ9NdqrnMqYQjIAfeBPq25/oXUk8zaK93EP7+sKQwBc+S+7Q74yO@vger.kernel.org, AJvYcCVVIglHy1jii0iXBOWw4TKvgXm6EkOJSpINr9tA9QW0WVHHY+as7H+EteyBrcVl7sws+NAPMVhoetC20lNt@vger.kernel.org, AJvYcCW0OVYVdkbWqP7Z1iD4TTMiM4Q+yJJg7DzrSrCll0J5WhofLDvDJEa3gyw8bnbxIZNPAuw6ytevrVnF+hRY@vger.kernel.org, AJvYcCW7YN8pY1gFnjqydn0XIfviFQO2bar2xhdroZGQCpt3R97PDNOWVHTqqQJyQVsr+qSBz6VtWQJe78o=@vger.kernel.org, AJvYcCWKjSmU3zLPBM2bXMo4zYabw3K7M1Jkd4ph4iIzDYbZQljGBteBeOKLDvNXLU/VCwmXuae/p6S78Tnd3jIpPX9f@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHobTTu7/+Gx9qW9dFpr3rglIXwvh2Z9Ry2eeV6pGMqLnfPwz
	0ANX0MByZhqgE9yIiG2OaMU1i+dXqNXajIHzCnd7UbKN3+9v1dUEPiLLizY4iuQ85mE8bnT9Jq/
	izk+PhQPC61Fr3jir2UuCNGtSJBx5go0=
X-Google-Smtp-Source: AGHT+IEjZlRqX2PB4iXlu4a9JMpjlaUQ1vC27uCqGMq3M3oIVxqm+xXIexyDxapLxYAZ7ry5gMmviCNP5BNb8/UwPKY=
X-Received: by 2002:a05:651c:408b:b0:32a:749a:14d4 with SMTP id
 38308e7fff4ca-32e5f57cd56mr9135181fa.12.1751665949031; Fri, 04 Jul 2025
 14:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de> <20250626-kunit-kselftests-v4-2-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-2-48760534fef5@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 5 Jul 2025 06:51:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYAjBS=7LmfRvi5ytd8b6ciMoq57M7awHYRwoCUL0BwQ@mail.gmail.com>
X-Gm-Features: Ac12FXyTxog7Nk26-bTXwv8VNWi8eyBHX1_ALdps90JOm0syKwUdZhoZy6UHhp0
Message-ID: <CAK7LNAQYAjBS=7LmfRvi5ytd8b6ciMoq57M7awHYRwoCUL0BwQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] kbuild: userprogs: also inherit byte order and
 ABI from kernel
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
> Make sure the byte order and ABI of the userprogs matches the one of the
> kernel, similar to how the bit size is handled.
> Otherwise the userprogs may not be executable.
> This happens for example on powerpc little endian, or riscv32.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c4293cf91e968ca8ee64452841fb266e24df63f6..b9aa1058321dabd3b3dd5610e=
45a2807dfa257f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1129,8 +1129,8 @@ ifneq ($(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),)
>  LDFLAGS_vmlinux        +=3D --emit-relocs --discard-none
>  endif
>
> -# Align the bit size of userspace programs with the kernel
> -USERFLAGS_FROM_KERNEL :=3D -m32 -m64 --target=3D%
> +# Align the bit size, byte order and architecture of userspace programs =
with the kernel
> +USERFLAGS_FROM_KERNEL :=3D -m32 -m64 -mlittle-endian -mbig-endian --targ=
et=3D% -march=3D% -mabi=3D%
>  KBUILD_USERCFLAGS  +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPF=
LAGS) $(KBUILD_CFLAGS))
>  KBUILD_USERLDFLAGS +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPF=
LAGS) $(KBUILD_CFLAGS))


Acked-by: Masahiro Yamada <masahiroy@kernel.org>

--=20
Best Regards
Masahiro Yamada

