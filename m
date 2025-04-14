Return-Path: <linux-kselftest+bounces-30661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D3A87B55
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 11:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E8618835CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B3825D20F;
	Mon, 14 Apr 2025 09:02:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1702AD02;
	Mon, 14 Apr 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621379; cv=none; b=VKfUw2bM+iPaqUlVphuYjSJfCqjhKTX1Bb8RLOQYx2L5K6I6J9qCVOKJCKTtVaJYkxX4HyDjbV9G9BTR1t7acdmN92tMHF1WhL2ncJtFWJnGN5xW8IXJGBYYWu+xMvtqvAIeaKwqH5PuvrOc0iL8WJo9KE9H/VF0YdULkdHhAtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621379; c=relaxed/simple;
	bh=B7NPX7dSdVmfij1Vlp8f4hBOjQNJM1EHU8u9k+ZG1zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeTJd12elMEZ32tdsQTSVhx7dLVJcPntXndBmXYUgJ9jaJCKguxqLgOL0aoSsoT2gF5rElnYJGg4fyLenTqFxzKveEfRxWiRbBYoAyocwXzCvGocddmxGQXEz18Q/SL1oop32zxF5fON+H/M1kN19nc6P/n9ycu6TWTEsb9nU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d75f4e9a1so1588921241.3;
        Mon, 14 Apr 2025 02:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744621376; x=1745226176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ijbe/qapYJC6Co04avwF6OEp1LaifYgLoE6xzwFCrg0=;
        b=szPgTjvwapTU51m23mrk9gFIGf4BmXjDcQY9szh/h5JxDlRC73S4DmcacaCdI8cTyQ
         yn4dflR85zsHvGzOj3dtNWJJq5VtB9GbCCtWc/MNUEqbNNAvC59JBF5qNgo7JBqzmbVm
         53XVB48rMqTp/7jkw6fYa3bHF2XUhi7b0fv8oSt8muWydS4lf8aPazw0UXTb0punjQgA
         QU0bDmPA6NMLALrAetoh84DHngjD8PDpfKm1dj1FVdszszQSTi5S4YPnDyGMGqN8pjGp
         RJtNEDj5khj9a+Hmq7AyhEX34W6tAkkd4lE9FPWCZzUpCstxaETJFtdkSbwPuVmuPpyg
         5U9g==
X-Forwarded-Encrypted: i=1; AJvYcCVI4Lux+FaANHw34TwKDiogbydTrR1bcEco+5jX75CRHe6HqbanugvJjcq1ABq+rKA9T4Ztl8gFr9M8g8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSAJ5Mqm+60MDMTx+MIzfzWblCogxuGy78sOxgd8iuydM/hBv
	biLKpUhwli8aY+diFEMLT2kMrbgqEKmsXkZsksk7kxdRMxf2BIgiFdYdbp/p
X-Gm-Gg: ASbGncv5NN/BsJX27SbY4ZOZ9HamIAYxabsgnamPZnyzTbGpgLtU91g2JMNWtrVNBQw
	N6VPaRh6P08bqmZQQAPn8SpSeiWYBvcunIKP3RtYeRjzmTXoiEcX9B4Z3reEz1u/hb5Ksw3JOQd
	ErV4PbpBbDZDXHNe95yM6CBTBrBAsmm/EfoPOwFOUtM6K/EnOI/6ZdXJOXqZFenkqnS8l+3lVX9
	AHFKW0UcyE4nELw6z1zTMfyqsbkOi+udnIhnc3c6JbcCwgZlVmS6tEwswFBAZZa0R6XJyn+BZ7f
	1YnnQwKMObb+GFcCi6Tyr/ks+50gx/MkLxpktk1Ru6Uzloj/Y0tcmxCCdQvd43y/i6OU39F7Z3T
	v0MYMSWBTF2oYeQ==
X-Google-Smtp-Source: AGHT+IGJvUj2rzDXK7LHDqJwjxaFTX9pXZdfZuGv6vXPMWbXyL8OEZdTiqZXVypi/d55IuydmInLlw==
X-Received: by 2002:a05:6102:3053:b0:4c3:c9:c667 with SMTP id ada2fe7eead31-4c9e504bfdbmr7220423137.24.1744621375622;
        Mon, 14 Apr 2025 02:02:55 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c97641c0sm2258257137.7.2025.04.14.02.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 02:02:54 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86d3907524cso1612756241.0;
        Mon, 14 Apr 2025 02:02:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVURVl0Re1T/SCvTWciiIlRuIywajfvanOP4t6GvIMTgvukZsVevaRfp9bonrcp3UGLml+5mB5c2Li5oRA=@vger.kernel.org
X-Received: by 2002:a05:6102:1512:b0:4bb:cf34:374d with SMTP id
 ada2fe7eead31-4c9e4fff4f3mr7453688137.20.1744621374120; Mon, 14 Apr 2025
 02:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6c3889e81d7396886b91120ba7871b2bffd6d934.1744615218.git.geert@linux-m68k.org>
In-Reply-To: <6c3889e81d7396886b91120ba7871b2bffd6d934.1744615218.git.geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2025 11:02:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxg-05x4g2hFL9f3MnmWiZ2AjM3mPp8Bc1V1wH2xhSwg@mail.gmail.com>
X-Gm-Features: ATxdqUFIx6CDyVulUqsXZ4lZxUQ03LDyZ6a4pzVpuvQxdL3nJocri2MxNPp-CWk
Message-ID: <CAMuHMdXxg-05x4g2hFL9f3MnmWiZ2AjM3mPp8Bc1V1wH2xhSwg@mail.gmail.com>
Subject: Re: [PATCH] lib: PRIME_NUMBERS_KUNIT_TEST should not select PRIME_NUMBERS
To: Tamir Duberstein <tamird@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <kees@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 10:50, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Enabling a (modular) test should not silently enable additional kernel
> functionality, as that may increase the attack vector of a product.
>
> Fix this by making PRIME_NUMBERS_KUNIT_TEST depend on PRIME_NUMBERS
> instead of selecting it.
>
> After this, one can safely enable CONFIG_KUNIT_ALL_TESTS=m to build
> modules for all appropriate tests for ones system, without pulling in
> extra unwanted functionality, while still allowing a tester to manually
> enable PRIME_NUMBERS and this test suite on a system where PRIME_NUMBERS
> is not enabled by default.
>
> Fixes: 313b38a6ecb46db4 ("lib/prime_numbers: convert self-test to KUnit")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4060a89866626c0a..51722f5d041970aa 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3326,7 +3326,7 @@ config GCD_KUNIT_TEST
>  config PRIME_NUMBERS_KUNIT_TEST
>         tristate "Prime number generator test" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> -       select PRIME_NUMBERS
> +       depends on PRIME_NUMBERS
>         default KUNIT_ALL_TESTS
>         help
>           This option enables the KUnit test suite for the {is,next}_prime_number

Oops, I forgot to resurrect CONFIG_PRIME_NUMBERS=m in
tools/testing/selftests/lib/config.  Will fix in v2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

