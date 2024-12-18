Return-Path: <linux-kselftest+bounces-23518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C49F6B35
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624831889D7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E321F37B5;
	Wed, 18 Dec 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOW0hYRl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BC1C5CD5;
	Wed, 18 Dec 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539620; cv=none; b=nSEkf8KN4c3l3ueY28fAFHMnpkSA53cX0+a8SAx01tSVcOLpSNHjvle/DASiScSlNiXSC6jlOgt6UOqrvCOEDGDOWuMOieNNoHxlnBBKAYCdko5NwZah1ypbpA+CTF69wdez4QqTWTnvb2sYgDXnOLWYDMI+C0jRv7R4BjknEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539620; c=relaxed/simple;
	bh=E4ZBjEUJHtxCpmt5X86esKMhM8vOYCzwvAzcaplotAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMOgMAMG4RSZqmdAemhT3rX0KuAj0u3uh1qbi66hXFZDpdEc02Rwx0IGfxVqh1s4FYkxijMzmKtctB1eIaaIscMoTiNZlfzVL2Y+JwMPAI7q3LOw6B/PaklKiEo8GdGOdOGHM1ldbRXzV58FCNFQYr2JaGwBTfkzbWYZmF+3IQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOW0hYRl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30167f4c1deso58097391fa.1;
        Wed, 18 Dec 2024 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734539617; x=1735144417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IruIFtHxI8jSv4Af8V/+k6/exVX+Qk2gPDq/o3hSlag=;
        b=IOW0hYRlBxMGuYJMVm1caKz42VWBPEiFENpUXJy76taT3hMOt9B+ziDII6tDlQs6IB
         7bdsMcVu8w8wvw41FEcfAELLtydhVc4bCcIW9NmSPDQcbQLdIVmKQA2Ha+BbVr96gd4i
         yzwbYeefnGV63UFjE61WgFkmOp2K71K2PaLumZRlHr+Or5Rfk9ZQn0ZzWg7qaKBYOpH6
         a3qajnnRmiUbJyEjaWJ2ksh1Jd5Iu3eJ9Ysuad0aV8rlLgHTJkSfdz1+xCepCnSASx1s
         xWJfc/cQs/KEPiPC+0PQ73schypOsJHDCX6IfaN6Y3b8neqYKz7NoVvwyxHQbiDboUhK
         dsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734539617; x=1735144417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IruIFtHxI8jSv4Af8V/+k6/exVX+Qk2gPDq/o3hSlag=;
        b=txhhidk/Nx30NCyNNjeN2ELKRZDME3LXbNOeFoeymnteSqpPwTvhQfA0MhlFSKkLSS
         TyVHZ0CFRCcWBxDpsQl+UolASJzL88HTBjjPdfezdCClujcUgJuwzRPzWsdXUzWX8rSz
         CCYNqHmAaaFkFgjpZGQqll3y3QtvyvsOVNxFBUsQquiyo7WsuEZc1Ad17e89e6Ceb9m7
         SRvwmjAOKEB8PgAwpECR2n5ye1DGcaOS5b+l7emPe/DpojaYMLZS9/nyDdPceotQV42F
         NeOB1g2EkhI89W3fltXnvas80T0ZO0SbuicB2znbGLjaOCJE9XbUrzApMRcsskqedcCS
         o7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/93CP9c8pxA4xQPHTbUPtOK3Iu4+ovxqJt0RiW8nM7mnOGGpm2RtfqvJXpy5KT8mvSDNJWmGHog6Q/nNMxxrT@vger.kernel.org, AJvYcCWwoqS8G9yDoM813EN7v9SJ8QRVCjYfZd3vCb1DxgHmXOZK1DN22BuBM42nJb27v7GQ0EtasObvfJ3Ayzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz974bEXdFoTmMAD+C98PKt9bEWXNw8w81wxgUsMzoI0TRsBR3
	51CUGEBWO0SV0z9ntI5DxEFOkfF2Mg4FMQ6tGDcaapLfCRFpX/PmNqopcch6l46f4b1WuyoHgov
	ixDpdVqpTZa/zPkiFtsmleb10M9MrJwuA6cM=
X-Gm-Gg: ASbGncsHjbQvkHjvqkF1gTQHbLH2tJT/NnmCTkC6C/XzVAtASwO6hYtJ9h7mJgBs7Bn
	XbEe7KcWeaPLiqsZwRoTlm7qE5K6ZByYaEPzoyA==
X-Google-Smtp-Source: AGHT+IFHYHv0kRfbh/o+Sz8J8twVgEHFA/42a2xcd8GiLf5M1jdAKV9qMET/hYT0kGO9LN5MaLCEdmc/YRnhmqsuo7M=
X-Received: by 2002:a2e:b8c8:0:b0:302:29a5:6ded with SMTP id
 38308e7fff4ca-3044db0202amr14183641fa.17.1734539616683; Wed, 18 Dec 2024
 08:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuP2bHnDvJwfMm6+8Y8UYk74qCw-2HsFyRzJDFiQ5dbpQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuP2bHnDvJwfMm6+8Y8UYk74qCw-2HsFyRzJDFiQ5dbpQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 18 Dec 2024 17:33:24 +0100
Message-ID: <CAFULd4Yw2RWVmQQ5tMy_DfY+9aPoEYBsGDBMXdP3HDcGH6dgsA@mail.gmail.com>
Subject: Re: arch/x86/include/asm/current.h:49:9: error: call to undeclared
 function '__typeof_unqual__'; ISO C99 and later do not support implicit
 function declarations [-Wimplicit-function-declaration]
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: rust-for-linux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 5:08=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> The Rust gcc builds failed due to following build warnings / errors on th=
e
> x86_64 and arm64 architectures with selftests/rust/config on the Linux
> next-20241216...next-20241218.
>
> First seen on the next-20241216 tag.
> Good: next-20241213
> Bad: next-20241216
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Anders bisected this regressions and found,
> # first bad commit:
>   [20b3c3eccd9361c9976af640be280526bef72248]
>   percpu: use TYPEOF_UNQUAL() in variable declarations
>
> Build log:
> -------
> arch/x86/include/asm/current.h:49:9: error: call to undeclared
> function '__typeof_unqual__'; ISO C99 and later do not support
> implicit function declarations [-Wimplicit-function-declaration]
> arch/x86/include/asm/current.h:49:9: error: expected ';' after expression
> arch/x86/include/asm/current.h:49:9: error: use of undeclared
> identifier 'pscr_ret__'

__typeof_unqual__ is a keyword in c23 (and an extension in gcc-14+ and
clang-19+).

https://en.cppreference.com/w/c/language/typeof
https://learn.microsoft.com/en-us/cpp/c-language/typeof-unqual-c?view=3Dmsv=
c-170

The compiler support is detected in init/Kconfig:

config CC_HAS_TYPEOF_UNQUAL
    def_bool $(success,echo 'int foo (int a) { __typeof_unqual__(a) b
=3D a; return b; }' | $(CC) -x c - -S -o /dev/null)

so, if your compiler doesn't support this keyword,
CC_HAS_TYPEOF_UNQUAL should not be enabled and
include/linux/compiler.h should disable usage of __typeof_unqual__:

#if defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)
# define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
#else
# define TYPEOF_UNQUAL(exp) __typeof__(exp)
#endif

Can you please investigate what happens here for your build?

Thanks,
Uros.

