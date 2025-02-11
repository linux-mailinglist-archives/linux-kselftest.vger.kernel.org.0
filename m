Return-Path: <linux-kselftest+bounces-26321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD3A301A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3E9167075
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A381B87F3;
	Tue, 11 Feb 2025 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5ohvPSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3AF26BD95;
	Tue, 11 Feb 2025 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242084; cv=none; b=CbdBa8fLYStPP6cd6Yo0BfKUCfXbgNBkgkoCtjSAaxntzhRwldKNpLqyjHxYcEcArUaX6YPjKRhmiiDHgcUzJ2+Qz03Qqk+EF/SejyYLNFIvy/Xg7PNKe64o1NENCYtyz/2LYzuluUtgDdj2yZfiIGE+IkGtJUtMfG4fzUUcXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242084; c=relaxed/simple;
	bh=5OOL+q7crj6C+Y5aqDrG5n7Z52CJTo/s0a5E+RhLox8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIBUeNqBNtBKAieHT4kmpe8b9sW+w7Vmr067Ql2DdaUBAIhhzMVZtiNJjZTtNgbXuPupxk9zO9iJx8qq9bbT7b2Ds6wcK5+c4kya5wSCrjrE6iZ3xVXOy9/vTV1kkzZtIatmllbl/q0d+CIsalnn00NDfprd8Lu7axOov5k4eoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5ohvPSt; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-308f71d5efcso9296031fa.3;
        Mon, 10 Feb 2025 18:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739242080; x=1739846880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn3t1X0OMk9xhbwKXgSgdmPnjMJbdOEb2KTYQMy3qXc=;
        b=E5ohvPSt7qrhkNJQ2dZRI1piOllhxqjcwXZy/8pJ5PvkKeOK0BgPetja98eUkgGW9w
         gbESV+IHFbUO3y0B5fb5xoqzqSt2QnQKTISYmQ22552SvYu22/yfV4qApfBIS5NC5xv+
         7Xe2esmQFrjMRyElaF1ojsT7h/el+LgZHr0CG5l1Gh9orQ01YFk7kNIDacIInVEwwFCB
         G+y7EJwLR19upiEE6GKrTO20iTW8bfL+qkygrUASXid8B/g0AANPaE2IsvqL65lqpF6q
         VJXaok5+pIQKHU87AE0VRCGaetabf37sslw8WYwgZZLoK7cxGzUIGu3bRy8a10Jm8Cny
         S5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739242080; x=1739846880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn3t1X0OMk9xhbwKXgSgdmPnjMJbdOEb2KTYQMy3qXc=;
        b=ZNTiQ+TWAbBdej3V/NzOiPTz4eTmGcels8ysj2sBPAPG3FBX0Ctj9/5bHfy+z4e6D9
         GDbrnt2TOirz2VfwwlL9/YUCPlc9Okchjvhz/XpN3TP2H7/kcS2ZdTPOmdGTT32QEdc+
         mCXjDEvysV5441uMg830freIEWYSlHKcafs1PpNh/RhGShd/8KHYTflqyfO+hNhtbz2g
         aB3j8pN2SfWAlAMcOS82rgmssDEZWyz66zAgtDtNjxV8SI/y3eZBbf/LYmD3Ulruupy6
         1kocvSG+xgxtwkxtkBL/+j7pej1SWl7S+b7nvuA2pQwW5I2Nru88Zkklj8e9nnmzeX0T
         0bmA==
X-Forwarded-Encrypted: i=1; AJvYcCVoHGNEQIPYSBLNuUmWjTgHQ7y3chYOYbWW/OpKxP8anWc8tbIfAJ11NPDfFQz9rOzdpwoNZfjgOzLicMk=@vger.kernel.org, AJvYcCVzKAAGr8nPNQ+RTntsiS4VGcDd1Mtv+xtid/WrdIV0gaI5AZa+DC8U/gTfzVHn2wSosDKku8RhRgljh5lwRwD5@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyO50UEI9u/e4wL7AT5fbPQRYPfXUOOUb2Wh6VGpZzu9m9aG/
	uzs8B3XEJBX2MphBYl2rNMFZFfytl6dvTiUkO8tSecmNEMcmY8lo7YX+q/vuFrnLa8uXSE9yVqB
	xFGfq1qR8pGxyNOq1fJUyBsNXUck=
X-Gm-Gg: ASbGncsHOllvNrx7/RLf2LcvhJw8CFXUwHCOuG+V/hGBfy4x5Z6hIEOEUtiQEoxP4Fm
	gt9hdPa+AdzVfyZjHlN4liA0Y6WR4hPzcadb4wrMlCRCPQWD+yA+xp5HxnwSkphBjXkJcBz0Zvl
	YXOaiCjtFzzvkLbWlSYeW+B1ppGCh3
X-Google-Smtp-Source: AGHT+IFZIkGWLA2ZKDKUhI5865q128jmDXUjWOI34Qtb9k+aP8l3IrsXJBCyVRjwY34me4r64bJw1Q9gAQHDEga7bm4=
X-Received: by 2002:a05:651c:1994:b0:308:f75f:446 with SMTP id
 38308e7fff4ca-308f75f07a4mr11013791fa.31.1739242079858; Mon, 10 Feb 2025
 18:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
 <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com> <202502101836.2B3E7BC4@keescook>
In-Reply-To: <202502101836.2B3E7BC4@keescook>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 21:47:23 -0500
X-Gm-Features: AWEUYZmiPJFFPicq2ZL6yV-FXokW2c26z9jhFLITBm6JYY_fKXQ2--JRmflbSOA
Message-ID: <CAJ-ks9=pU6FsOfMk+fSwG2oLG95L2C-jwBDNad1FTGzQ5seiuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] lib/prime_numbers: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 9:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Feb 08, 2025 at 09:44:39PM -0500, Tamir Duberstein wrote:
> > Extract a private header and convert the prime_numbers self-test to a
> > KUnit test. I considered parameterizing the test using
> > `KUNIT_CASE_PARAM` but didn't see how it was possible since the test
> > logic is entangled with the test parameter generation logic.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  lib/Kconfig.debug                            | 14 +++++
> >  lib/math/prime_numbers.c                     | 87 +++++---------------=
--------
> >  lib/math/prime_numbers_private.h             | 17 ++++++
> >  lib/math/tests/Makefile                      |  1 +
> >  lib/math/tests/prime_numbers_kunit.c         | 59 +++++++++++++++++++
> >  tools/testing/selftests/lib/config           |  1 -
> >  tools/testing/selftests/lib/prime_numbers.sh |  4 --
> >  7 files changed, 106 insertions(+), 77 deletions(-)
>
> Thanks! I've applied this and rebased it onto:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=3Df=
or-next/move-kunit-tests
>
> --
> Kees Cook

Thanks! Could you also take the first patch in the series[0]? The new
test won't build without it because lib/math/tests/Makefile is dead
code.

[0] https://lore.kernel.org/all/20250208-prime_numbers-kunit-convert-v5-1-b=
0cb82ae7c7d@gmail.com/

Cheers.
Tamir

