Return-Path: <linux-kselftest+bounces-26122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA0A2DA00
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 01:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3532165861
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23031FAA;
	Sun,  9 Feb 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk32usf2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0E819;
	Sun,  9 Feb 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739061695; cv=none; b=p2roi86Al58cVUf8Wt39Q6H5ZH6crYzShHDruIOrzs5vY4biL2iuMx8oDbw0a2xQiO5gAJA+7baCPW3hfl5o1R2OjF32qiAF8iTuTJ3ZWsmt8fNT8FRQDE4DNaD+SkrBwR7R2DEZvNA+kgQ1FwbFDeum4dO9WJaNdbOG2ZveS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739061695; c=relaxed/simple;
	bh=pJkVawll+jFQLJwiz7kgbhu4j48ahpfGfg7kZC/J21g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+gbOMccvRrSPQPA6NKE7rrWSZb7TVKXhjNJsdD1TG5L421UEc5JfjYT82xH4KEio96NvzLPiJovwYaz6LMoqHhGuiMBZ9gnW69nvq+lHUDl/gAwv0VyM3SaEqv6pObS2e2PcIr0m/dxyKCrxo7ULCBQ3QFsguOSfpLAZQlepj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk32usf2; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308e3bd8286so5467061fa.1;
        Sat, 08 Feb 2025 16:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739061692; x=1739666492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/ZcRnXrYUGxD+ZNDpRg7eY/D9hsmFgKf495VVMJ85g=;
        b=Sk32usf2o3+MEQe92fVeA+1HhCe1La9az1f1jBLGbeVJuWYXkrfUBWNen4LhuWidiT
         7pFvLilokZG9MKEzNKuBITkInWH+E6c8neC0yhHwkvwKgLDEnKIPlNPIAp6czpbRMDGQ
         70L7y5YEla/dx7Gb10MvnXlBgsSmq3FHLvBFSdpy9xnmju2M7aiTHX/Ti/ZoDr5KV0Y9
         sCl/Ufj7KvfPqX2W0Qb5j3DM1AZVMVf7PSs7NN8PM+NQCEPhTAWoAfySBcIPPSwsVGQU
         ipFb3FSxYsfuc/wHgcCDxroFiPcgeg9wa5PLgXmUVAHTTuhkqTn6qMoU4bLHFI7WX/O9
         qqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739061692; x=1739666492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/ZcRnXrYUGxD+ZNDpRg7eY/D9hsmFgKf495VVMJ85g=;
        b=C4yHrlWsjeake72nT8lmA0F/Rv4DITQ9Va1eT2F2OPUuuLjOvDprOmD5xcyoNdcrJ7
         a9Lu12G0WP2rgd1gtGd2KSQ0I8mubSZGGpuiUGTlv4xr9fnl9SenycPVvQy0k4gmSq3h
         uanZCLrI2eEl3nv9zyi4uxN8oaoLjIzfSFf3UuoULKg+ZWydmdLcvMLkqT9EROaw1jTE
         LEXy5GbWPV5xuGSLO/g5uPdvQxLY3jIC2UA7ofqGclXUaiPMSWiis91qnef4rAArNHLk
         BKG+lVWHSWrpCjjqYPsEWxezPuotuwqSUiQF4GRj1gBvvHpKVJqxNjT54dNiXK62r1ko
         RWkg==
X-Forwarded-Encrypted: i=1; AJvYcCVcBhe5yUItbMhkIkq6mdOKbgeyBNeHb3+JXJs2CYFUMGRQ5+5TY+XyMAYPAUv0P9jV5u6UpWwyWrGZrF4=@vger.kernel.org, AJvYcCXHnSJyyxQC0u+08f8EzCw2n25RHYR3hnEJX2iLTrLwPl+kclPiHsxQt7AjSBEE/L2UHf6NkDcA0GUhxUq74rDY@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQxaJbowPJm4PdruxOGcg7oRoDEU2mcVmwQpdVZCjI+db62Be
	mvFJkXbpYkGUP9KDj9bW+lgQZ2gNMj2tDooXHvkFpHmhtg6EdD5+lcAm5Wypm854kGUvDm+2dj4
	wSfv69CTl3QnvsOS8G+vHRoiPBtg=
X-Gm-Gg: ASbGnctgbNBejef9SbzhWMf7mHwm9yj7txGHCYY+ufTiQRDyaefgO+l0uvPrMAZArWS
	NdJE85vlYDCwmUsVLmNyToyN+jUJOuPLzvnyS/zxp9QTLVQAsGXsJETR1gOWuygUfSWrQ2hvGRj
	6CE9sIVhT4oKx/SwH6xOC48Hrl0288Izk=
X-Google-Smtp-Source: AGHT+IF4mJm0LaQNYFPpcwHT8SEMgtThbTYzymOw78o1HCEEpejRWAM1A4ucGPQHSuDGMMXdg6ikO7w9POeS5NwFtTo=
X-Received: by 2002:a2e:be1e:0:b0:300:42ad:f284 with SMTP id
 38308e7fff4ca-307e57bed2dmr26315681fa.7.1739061691579; Sat, 08 Feb 2025
 16:41:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-prime_numbers-kunit-convert-v3-0-8ffd5816d8dc@gmail.com> <20250208162542.fba2bdb0051eeab5344d3f82@linux-foundation.org>
In-Reply-To: <20250208162542.fba2bdb0051eeab5344d3f82@linux-foundation.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 8 Feb 2025 19:40:55 -0500
X-Gm-Features: AWEUYZnsc-5g3i0cdmoODF8gul5Yc3KLHG0Z80DZXbpR61Vv1LJVJFv6R0nn41M
Message-ID: <CAJ-ks9=fBN8b==JZ4KMMJujcH3q-NuOA3Y1o8NqvQE+U_voMcw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] lib/prime_numbers: convert self-test to KUnit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yu-Chun Lin <eleanor15x@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 7:25=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Sat, 08 Feb 2025 17:52:28 -0500 Tamir Duberstein <tamird@gmail.com> wr=
ote:
>
> > This is a clear example of a unit test.
> >
> > I tested this using:
> >
> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1=
 math-prime_numbers
> >
> > On success:
> > ; [08:51:41] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D math-prime_numb=
ers (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ; [08:51:41] [PASSED] prime_numbers_test
> > ; [08:51:41] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] mat=
h-prime_numbers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ; [08:51:41] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ; [08:51:41] Testing complete. Ran 1 tests: passed: 1
> >
> > On failure:
> > ; [08:50:19] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D math-prime_numb=
ers (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ; [08:50:19]     # prime_numbers_test: ASSERTION FAILED at lib/math/tes=
ts/prime_numbers_kunit.c:28
> > ; [08:50:19]     Expected slow =3D=3D fast, but
> > ; [08:50:19]         slow =3D=3D 0 (0x0)
> > ; [08:50:19]         fast =3D=3D 1 (0x1)
> > ; [08:50:19] is-prime(2)
> > ; [08:50:19] [FAILED] prime_numbers_test
> > ; [08:50:19] # module: prime_numbers_kunit
> > ; [08:50:19] # math-prime_numbers: primes.{last=3D61, .sz=3D64, .primes=
[]=3D...x28208a20a08a28ac} =3D 2-3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,=
59,61
> > ; [08:50:19] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FAILED] mat=
h-prime_numbers =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ; [08:50:19] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > ; [08:50:19] Testing complete. Ran 1 tests: failed: 1
> >
>
> I resolved this against "lib/math: add Kunit test suite for gcd()"
> (https://lkml.kernel.org/r/20250203075400.3431330-1-eleanor15x@gmail.com)
> in the obvious fashion then added this fixup:
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: lib-math-hook-up-tests-makefile-fix
> Date: Sat Feb  8 03:33:59 PM PST 2025
>
> don't link gcd_kunit.o twice
>
> Cc: David Gow <davidgow@google.com>
> Cc: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  lib/math/Makefile |    1 -
>  1 file changed, 1 deletion(-)
>
> --- a/lib/math/Makefile~lib-math-hook-up-tests-makefile-fix
> +++ a/lib/math/Makefile
> @@ -8,5 +8,4 @@ obj-$(CONFIG_RATIONAL)          +=3D rational.o
>  obj-$(CONFIG_TEST_DIV64)       +=3D test_div64.o
>  obj-$(CONFIG_TEST_MULDIV64)    +=3D test_mul_u64_u64_div_u64.o
>  obj-$(CONFIG_RATIONAL_KUNIT_TEST) +=3D rational-test.o
> -obj-$(CONFIG_GCD_KUNIT_TEST) +=3D tests/gcd_kunit.o
>  obj-y +=3D tests/
> _
>
> and the x86_64 allmodconfig build failed thusly:
>
> lib/math/tests/prime_numbers_kunit.c: In function 'prime_numbers_test':
> lib/math/tests/prime_numbers_kunit.c:25:35: error: implicit declaration o=
f function 'slow_is_prime_number'; did you mean 'is_prime_number'? [-Werror=
=3Dimplicit-function-declaration]
>    25 |                 const bool slow =3D slow_is_prime_number(x);
>       |                                   ^~~~~~~~~~~~~~~~~~~~
>       |                                   is_prime_number
>
>
> So, please redo against mm.git's mm-everything branch or its
> mm-nonmm-unstable branch and retest carefully.

Thanks for the clear instructions. I was able to reproduce. v4 is on its wa=
y.

