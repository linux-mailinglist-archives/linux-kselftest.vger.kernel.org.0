Return-Path: <linux-kselftest+bounces-38773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 415F9B226F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2B0188857E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 12:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5DA78F2B;
	Tue, 12 Aug 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI0MtiKa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D124311C26;
	Tue, 12 Aug 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001976; cv=none; b=cSAscJ6tTkbzmo+q3WKnvyDYCEq/3dEwQTmiUwqUM8N15FWzhv/mS5cuyOEr8CXB5tw+OQMEIeMhhr1BVX04VIkPCq0dk/6EbWlc1re/Ap5sv8PJWWfS/hwVM0uiTo1KWzQ/W5ydb6/s+mD5AIHdvxk4g/zvlfKUp0TsCLDeNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001976; c=relaxed/simple;
	bh=4rgOB75uHJhQ9FKGjjwyzR4VYHrWoTncP8I0hzQ36Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6uDrCRRCoyEcQ7+v5ZoJVJGLxhapeQsudCOrcMkahyKIqLIJj5CMeEW7Q7SqQErFTFw3FcaZTxWPVwfMqdMYZZKDTwsshSkKT8RV7qWUTYIUkQ8X6sFBOpc9viDnWaIsOaBri6/EXHlR24C24FxM1jCejSeP1wa15Mv6i/SRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI0MtiKa; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61b932f2c0eso395868eaf.3;
        Tue, 12 Aug 2025 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755001973; x=1755606773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJbVEsQJVCjelejxZubJqTtynOwasKvIUa9eAU0KJJo=;
        b=PI0MtiKabbFDU+7SgIlArGvmyRyrtvR6SwsZ3awpVsQWTadDOThMMmrcw0oIQtTVNI
         uej8Y++CtmrOJaqPP5r3gV3xI1M4U679REtXqtdh6jXWe0KM0EAS3d58QPni87GFpt41
         Xzs65WsudRf3x6MDUWSFktLYGkIflUuOqeHqPXIe9y0AofofpylhFbNqp44ndngUwPvO
         Pkd1vwZ+LYKQ4A9FUBTbuSi1U+AmOsRSlhv69PfHH65M2Ih+V7PmpPXFZ1fYypUqsVpG
         uWKnJ/WT0dRDpBBG0RB5tRQoPHvCWGCxtGCqYGTPDtk9fQAs/yGahUcg3j91zMnzTRcT
         VIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755001973; x=1755606773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJbVEsQJVCjelejxZubJqTtynOwasKvIUa9eAU0KJJo=;
        b=YAzU7/EmqdzISaRXCPhPKGCZYYUnxLT0pJAr5ssKGIxwaPz7AeCQ/VqkXJNN7nM4Jc
         113Ir6A66gLw1fcnd1o0prAqbF7uxNWPxgguL5gmFDVk0wpKC0KYK6pGXJzyg2BGFGTU
         cgTbbDtzFQJuTQ/wz3jufbp/lFCKlVgS7MLDHimyHtsSJfegDp0JxG9gtA/bd+uBhck5
         hNxzzJ1HJgIPp/3p2fETYXAHqu1nPhJp0PPzz9gbvbTNmKA9pFwAr5olixo7uS1e1l0X
         AlwkRWqEkVw4759GKsnkfG+iO4KaQ+iCjWFMkS6BhbrTENAMZfKGn2u5pO5azSX9zKFu
         Bxnw==
X-Forwarded-Encrypted: i=1; AJvYcCWFsmc0voKjt0st3jU57o67XoWvm1bhkxT6UMQX5UjnnxzXhKJhtJ4D1yf9bihyGzXke9PBxR+73Y2rcmp9c6fO@vger.kernel.org, AJvYcCWOHTJsdd0APxg6z0CQW7DVHGFUt+9N3VR08RG0HB2fTwbOAhPhXzFQdsRimJ3BuO3XMe6TZV7J8qfa++M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1aWfrUG7tPMNyQrFJhsbonXuhbpVWTdkKp/Kr4qbI1IeEcBk
	Coo7mFPFliF7wqh8hj045ReamyUr8ZHsZ54nWku/JHAyUqoxMWRrsMNrq0vNO+2UTsG4vj4ZsM2
	pkkRRNf/Mh33T2IxVeP47mc6xFWF+WuA=
X-Gm-Gg: ASbGncuguOieAPQkQEFvs5Va1TQa+c1N8tJUI8yZ8c/8+MnITpaNbMAIdjYkcPP/wMr
	Z0dnbJySA+6D/BXut4L65h7NJpttSoM8CUgFo+n5rElpYm3vTbcQFqph0jnV0//5sXIQlXFmFGj
	RwBsIFsKrkUwnjvEF5rFG0LOfWS7RsEbDBY9L8vSwwwk6P4TMQRrPhxX0afH/WeZk1qNx1SDKF2
	R40
X-Google-Smtp-Source: AGHT+IFLY+ky7e3BroIIydWjoY0aabZimRGPv+KZv2ff2sfoqaC+0xQ4C7oeRILPEIRw/Fmk+/4AWjzm7pUMRn5Tgvs=
X-Received: by 2002:a05:6870:169b:b0:30b:9750:3085 with SMTP id
 586e51a60fabf-30c94ed0290mr2350864fac.10.1755001973402; Tue, 12 Aug 2025
 05:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
In-Reply-To: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 12 Aug 2025 21:32:41 +0900
X-Gm-Features: Ac12FXzk5--95ren1VR6OqqAUzs5yqbnOkCJYlLg7DPyV4KuIMBIBIZHxZk8QM4
Message-ID: <CABFDxMGPS6LE=A25VjXEpfKuzVfgxfgu=_uhkWXc3D+xuq-B6w@mail.gmail.com>
Subject: Re: [PATCH] selftests/damon: fix damon selftests by installing _common.sh
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Alexandre

On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> _common.sh was recently introduced but is not installed and then
> triggers an error when trying to run the damon selftests:
>
> selftests: damon: sysfs.sh
> ./sysfs.sh: line 4: _common.sh: No such file or directory
>
> Install this file to avoid this error.

I tried to reproduce those error with my vm environment but I failed;
with my workaround test method, it doesn't exist.
If you're okay, could you please tell me line by line how you execute
tests in what environment?
I'm also struggling with the test environment, as well.

> Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host share=
d function")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  tools/testing/selftests/damon/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selft=
ests/damon/Makefile
> index 5b230deb19e8ee6cee56eb8f18c35e12f331e8b7..ddc69e8bde2905ff1c461a08f=
2ad008e6b28ac87 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -4,6 +4,7 @@
>  TEST_GEN_FILES +=3D access_memory access_memory_even
>
>  TEST_FILES =3D _damon_sysfs.py
> +TEST_FILES +=3D _common.sh
>
>  # functionality tests
>  TEST_PROGS +=3D sysfs.sh
>
> ---
> base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d

Does this commit exist in `mm-new` or `damon-next`?  I failed to setup
the same base-commit environment.

> change-id: 20250812-alex-fixes_manual-aed3ef75dd83
>
> Best regards,
> --
> Alexandre Ghiti <alexghiti@rivosinc.com>
>
>

Thank you for great work!

Best Regards.
Sang-Heon Jeon

