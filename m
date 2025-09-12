Return-Path: <linux-kselftest+bounces-41312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE302B549A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E3AA5F28
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DA2E1F16;
	Fri, 12 Sep 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2A/X3Je"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED5286D73
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672621; cv=none; b=aa3U99lRsZZMfyyX2mgIBDrrD3hPQJhM25YmDbsugNVnKhksQKw415P+4lMk72M9pO6MjHGOyf3P795pPj/SA63WtH4aphexYBV3sBtlrCU/nSBaesRQajhKNbGhP+Ygh7xZA83QoHs+rB+CiCqT3bRIsj9O5tyfPEvBS0yKyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672621; c=relaxed/simple;
	bh=L8+Vfsd5NRO7vLKj/WDn0QKcl6cnx+8yrLmAU9BNATI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQPSJPFrgOsEp1aPqofiWlZ0CVyak2aKCDf5gBxpzr7bXB1X8vmN2re1Q99ziFERT4QAtsTKfUuAviT2WceeRCKRmfgjwBH/FQr/POP23uTLFbeygsrvNzZ1+gdS9dXnmaRDYF6oUy05iMINLC85E+fuCct3+f4jWJpjvJoT3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2A/X3Je; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2570bf605b1so16272475ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757672619; x=1758277419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxaMEqYA6uym+Ir6zcrN22UPH27k/nnjzDJpTYQxN6I=;
        b=b2A/X3JeeiNdU9a6TFOgWkW505F23XXTIo+yGa7or+lZ+5rLICZQmIcLDUU6s4PpsB
         ZA0+I+hhYXVeu5HLA5TYdRc2pAGq/Zdr4xdTuDjwSlF9JhxkUP8aS8hURAxNLHXFuXzn
         jfYhj73nTGIuE6Nen2evckS1aWix1ux42nPwjTPbDr4mPF3wBkEuQ7Yc4CwujcVE7wsR
         4e+zbIP7szNCUEJRZ7qfiXcS26scl5KusgHRWhb0pwfjhJPyI2zl30OaYAsmVYbyd8g7
         wruupgH3GsUzMId5XJS6PklTlJVydzUIXU8iIur36eOp9HuHrzJ9BsYiHX/gT0KiKKRN
         Gwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672619; x=1758277419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxaMEqYA6uym+Ir6zcrN22UPH27k/nnjzDJpTYQxN6I=;
        b=OjBJMIFjl8jq/BjCXLHiGF+6BS+WQ0s2q8VHfZ/mbl4SBiVegEb0YCXrSIyRjJ4VRf
         zaD/AVYndnAk5YKL+qofth3pUmAIyZ5jWl6BcNWYCn668C1pBVEM+zxei8WTqBSh0gqC
         QxP00DhXu7vl1yq5YnexHZv1VmN+y5wmj1TZnJPsGYNFxtUQ+ilJT4KNz5vo/gz5ILgG
         t/lbpJpinjtlTeZLcIg+dgCoZC9HO8urUDt0RonhR6Zb+8S206yeHDON3XPaSSovckEZ
         9VgOAwo8TRFFBE2nzHTTCskTVIPCIqg7WMfNC5kPpL5CJL4XuYullzVy98TFQbotfrGg
         zCUw==
X-Forwarded-Encrypted: i=1; AJvYcCWp2SkgM3eZj1vtq3XQ+rTTAEzuK16wwPYE3f85ySPFYzeBWFGV6bhdAtQplLvyOLSgzo2zcH7bTkFiPnHkx7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yl3JyE6Q3lAq5MrVsc8s6K7q++MfwgfB3hWlljXgBUz4VCpj
	HpwKcfqLZz1oLUm6zxb7R9WX3W4bXI+hQxbNPL1aXnC6yCRkC59tzax6rq368TipyUNV6Jr3PG+
	j+CrscbipVVyCLJ8rWjKOXausPa04aNj9UvHVdHj6GoxVf0TPrR03GL8=
X-Gm-Gg: ASbGncsP3yZUtZ96PW0Nz88Ll2TURgZsXebyhQVsjHI2Flpueme0xyHrRECQuxM5lJ9
	ibpZwRviFSaq4rX/MttpDljPCotGRNK6mqwJrvV1MQZdEivi9XzdvDloL0pJJbknGBAA87kpc+I
	pINYQGq9M2Hn/d5MyomfemfxDTowHYk2YS+Sh2PM4xgEOQ5oTGIr6t3M58bDfP4ExsBCAat1dBh
	9Lmn+WYq1SDB8ADWmvNiqofWOAhgHFv9g569aeTN3sG4mDv+BZniyrneo4VamUCq5ENY/TR/YhV
	hbNpUIM=
X-Google-Smtp-Source: AGHT+IFnlh7Lcvev/z+g8geBZVyzuCDqftK69x/3dM4A4/rPwhVxriJu5LaQAhPmA/dUWQDP37JDEPq7LkU6t/uT414=
X-Received: by 2002:a17:903:2407:b0:240:3c51:1063 with SMTP id
 d9443c01a7336-25d2576f18bmr30549565ad.23.1757672618671; Fri, 12 Sep 2025
 03:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
 <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de>
In-Reply-To: <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Sep 2025 15:53:26 +0530
X-Gm-Features: AS18NWBiNtyoZJdw5AR77Ehen6tmbxWoHZEhVULSIr8zN1kPljDdD8rhs__pSZI
Message-ID: <CA+G9fYvrcRNBbg15UEcaZuYgs1pHU2i7h=zvJ2yHNo5i4fZ_nA@mail.gmail.com>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error: use
 of undeclared identifier 'HWCAP_GCS'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, 12 Sept 2025 at 12:00, Thomas Wei=C3=9Fschuh <linux@weissschuh.net>=
 wrote:
>
> Hi Naresh,
>
> On 2025-09-12 00:48:47+0530, Naresh Kamboju wrote:
> > The following build warnings / errors noticed on arm64 defconfig
> > with clang-20 and gcc-13 toolchains on the Linux next-20250909
> > till next-20250911 tag while building selftests/arm64.
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? yes
> >
> > First seen on  next-20250909
> >  Good: next-20250908
> >  Bad: next-20250909 till next-20250911
> >
> > Test regression: next-20250909:
> > selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
> > identifier 'HWCAP_GCS'
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Build log
> > selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
> > identifier 'HWCAP_GCS'
> >   390 |         if (!(getauxval(AT_HWCAP) & HWCAP_GCS))
> >       |                                     ^
> > 1 error generated.
> >
> > The suspected commit pointing to,
> >   kselftest/arm64/gcs: Use nolibc's getauxval()
> >   a985fe638344492727528e52416211dda1c391d5
>
> That suspicion looks correct. I am wondering a bit how this works for
> the other selftests which use this symbol.
>
> Can you give this one a try:
>

I have applied this patch and tested and reported build regressions
got fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing=
/selftests/arm64/gcs/gcs-util.h
> index c99a6b39ac14..816b497634d6 100644
> --- a/tools/testing/selftests/arm64/gcs/gcs-util.h
> +++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
> @@ -26,6 +26,10 @@ struct user_gcs {
>  };
>  #endif
>
> +#ifndef HWCAP_GCS
> +#define HWCAP_GCS (1UL << 32)
> +#endif
> +
>  /* Shadow Stack/Guarded Control Stack interface */
>  #define PR_GET_SHADOW_STACK_STATUS     74
>  #define PR_SET_SHADOW_STACK_STATUS      75

--
Linaro LKFT

