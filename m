Return-Path: <linux-kselftest+bounces-36605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBAAF9C15
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 23:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20234580C73
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF3227B8E;
	Fri,  4 Jul 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOmXWdAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA92E370A;
	Fri,  4 Jul 2025 21:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751665912; cv=none; b=F4fuWwmf1YRUJGs+1hifqLIS9WgmSZPjjN07haBoy3aSzeZg7S1kJ9Z3LhQ/RSuO/lvP1X3xIMA+h8ECOUCY2bAPCF8PL443OBMwFg7w9Jva1SxrcVMnqtK/TE/r7P2AL15Y7brcFJ6FdVx5fCJZv7364ChiTovsUrJ2PuRrTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751665912; c=relaxed/simple;
	bh=t9flg7u82clPx3gawCNQFga3j2hrwuKYVb7q0KayW2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MySQnUND9p9W1H6JtFSEHo5EjbQFTbaf9affhEHONs7rvVMA6hYboeGXtkcj5GxgSZmlIkoJtGcW8TgeercNegrkEFj7VN9bvw6GpSOsQ6YypAsF7AYW1EiluZ6sbz9o5BshUSinEtrqXfpQbffl3L4Hxnu8bdNcl7TydTqprsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOmXWdAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4685C4CEEF;
	Fri,  4 Jul 2025 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751665911;
	bh=t9flg7u82clPx3gawCNQFga3j2hrwuKYVb7q0KayW2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YOmXWdAbGI3BIHxJCDGKkS90GNv6sQOTf6r/yS5nqa0oepLo/aLYyZUosYAJgAbdV
	 GjY+5gKzqY1yrV1o0Yq8Q+EXigbxB5Ko+l8CRqmXxxJV7uf8m7M+LHOItBW+jhFnvI
	 Lcg8UYVHQQk/8x4joDBwr0MamdaU9NQuyZ/96jrlwFGabjuPBMf6fKq/aw/52LjPMT
	 jy0mLjO5Qy9m15EztWTl3YD61rEfEpIVjHhAAoIV8bfbIuiirLPLRWZa/gw0Q3NmNQ
	 NIPi5/iqqrzM3a1FaLausMoiOvDbr+bO99pOrSDKcXsdpB4s0/pr/RKirZnn2Q3UfK
	 qgtL5ZJ7hU1Cg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32add56e9ddso11747661fa.2;
        Fri, 04 Jul 2025 14:51:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdx+VLfjRj7E+HDux/ItjO46PfOLFZDHVfnAkqwjq10b6eaItD3QZ7xcpSNaHe0i4izcid1oBkMXRk@vger.kernel.org, AJvYcCWBShLgCacRQxHxFuPegxPGAn4ygyv+x1VFsGCgMxPpfiDutjcvtzLKlDowS/AofKvtSBJ/VyEp65x2l1E+@vger.kernel.org, AJvYcCWbbBab4y6+FMrBRwwvTHxlUeD5NxR+9MC/bvX7Eq3b0p7DymU1sUSL7Ljb1rrNF/dOcjuO0ZCxauI=@vger.kernel.org, AJvYcCXFDFhgCz4jvYDcIW4mYi9s/+o4mSdh6G+pVPFI5IB4AsfrrsJa4LqD7oSAAW1LlvFluRjJMsfC5JEWMZj+@vger.kernel.org, AJvYcCXjc7Sfjo5CSrDz4AKaJJoBhAa8/7KnqsLTrcdiulg6VJagxzE3y3jiLGHoFcKJgtI3xbGUnhcmaFoJgnrhOJep@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDYra94wwBVCDogn2nBitMoEq7FKa8K0CEUKi/s12uBSjhGyW
	BvgavkSUnhdyDdU8weittgyUO/Qmrx+4h7nN2GKPqzcFcrvfZnjLOk79pTVZzUzQ5eIcEw/+uXk
	FzPKnDG/mO6TScj+zn2FTPoHuMZXEiE8=
X-Google-Smtp-Source: AGHT+IGD64LdVimTYrrEYHkksyjH05eDJjNW+f6BrZ6aIKjkeqUVvDAGeO5hcdPg3i9qqFh8j8tgTZHqhiEP50d7qdg=
X-Received: by 2002:a2e:9181:0:b0:32a:de79:2ca with SMTP id
 38308e7fff4ca-32e5f57ca68mr8591381fa.11.1751665910378; Fri, 04 Jul 2025
 14:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de> <20250626-kunit-kselftests-v4-1-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-1-48760534fef5@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 5 Jul 2025 06:51:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVLGD6FMqyFd_Siy_JuRZX-TMAZ5TVH8+kN1Bwjwx5eg@mail.gmail.com>
X-Gm-Features: Ac12FXxpmIgKwjbffGSAIIbb0apS3wkBzhbD7god4vAMeUYGlKwgJvbMYebnzVM
Message-ID: <CAK7LNASVLGD6FMqyFd_Siy_JuRZX-TMAZ5TVH8+kN1Bwjwx5eg@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] kbuild: userprogs: avoid duplication of flags
 inherited from kernel
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
> The duplication makes maintenance harder. Changes need to be done in two
> places and the lines will grow overly long.
>
> Use an intermediary variable instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 35e6e5240c61a8a329011929fcd0352b881dccdc..c4293cf91e968ca8ee6445284=
1fb266e24df63f6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1130,8 +1130,9 @@ LDFLAGS_vmlinux   +=3D --emit-relocs --discard-none
>  endif
>
>  # Align the bit size of userspace programs with the kernel
> -KBUILD_USERCFLAGS  +=3D $(filter -m32 -m64 --target=3D%, $(KBUILD_CPPFLA=
GS) $(KBUILD_CFLAGS))
> -KBUILD_USERLDFLAGS +=3D $(filter -m32 -m64 --target=3D%, $(KBUILD_CPPFLA=
GS) $(KBUILD_CFLAGS))
> +USERFLAGS_FROM_KERNEL :=3D -m32 -m64 --target=3D%
> +KBUILD_USERCFLAGS  +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPF=
LAGS) $(KBUILD_CFLAGS))
> +KBUILD_USERLDFLAGS +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPF=
LAGS) $(KBUILD_CFLAGS))
>

Acked-by: Masahiro Yamada <masahiroy@kernel.org>

However, as I mentioned before, the following code is shorter.

USERFLAGS_FROM_KERNEL :=3D $(filter -m32 -m64 --target=3D%,
$(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
KBUILD_USERCFLAGS  +=3D $(USERFLAGS_FROM_KERNEL)
KBUILD_USERLDFLAGS +=3D $(USERFLAGS_FROM_KERNEL)



--=20
Best Regards
Masahiro Yamada

