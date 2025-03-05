Return-Path: <linux-kselftest+bounces-28305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB3A4FDC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 12:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78461892DB5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 11:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34072417FB;
	Wed,  5 Mar 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+wTceM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B83241C87;
	Wed,  5 Mar 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174541; cv=none; b=n+eKdqmiZSce7CVOYtgtGCvjZr1D7J/EH3feF/kYjO926+zU/eKSuzekigDUgiAGSPKCI3n/mutxLIYEFBIIOUxRzHuD50Y5LH2lbXW5HqSiZBZ+5MyF75SuEElMxybTz7jYYdE1l/9FgSHTbbXfBdCkGg/WBkYtqlen3fQa19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174541; c=relaxed/simple;
	bh=qwopS4a6AUpBAWY4wViPaDXCC4bhryjADZfuqpcpo3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzkJjzVZLxeBm5JwoYUJkeWmKMJzZxkaTfPJRUAoN2uPIP1Fy/0RvHgCPd2/OiJElvhTV8H8GgQC82gTyZU8u0mopNvC1D//28A8IzauseXdOJy5NV5sKaRfqUSb7jaFbIVD5zvopsrSOE8c91YGcoHupft9JVZu9VWCGgpiBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+wTceM/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549490e290dso5277827e87.2;
        Wed, 05 Mar 2025 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741174538; x=1741779338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQjCJAWWqkAUcjYYgR8Ex2nz8hO/x4lAohvkos16b8E=;
        b=N+wTceM/Tn8f1/ad1ztR/u23KAnIkNLn+6FIX3mU8qvJpTVxHhUn/dxTnW6ZWfQCJH
         eNsAGyDNaGAvwSxmZeJoYCZ2PkU2cpSV6jUvBQDz6KJnjJceOCxSmaJLv9pJGnLXzCeu
         R6c1iEFRpzL8OAP1bmOzER0v4bNrBO7ZtdBtS/iMSurO5XSdtVrRZvqjz76fmj+zMO6E
         cM/Q5RHOXVO8StKaQWDys72mst7UKLRpj9eJV4O804IFXo6EDTTY/Iqhdorq8eTxrqPg
         x744Z72r438YX3XjnvAgfrPMdgazDWsidfwFMDOJDOImcb6Q9qx+mwsTYDmkTK9VjK9H
         tHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741174538; x=1741779338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQjCJAWWqkAUcjYYgR8Ex2nz8hO/x4lAohvkos16b8E=;
        b=kN8Z0wEOeyVctY9eJDdvgOxMjxDpJi4CZvoYh96x7/C3BNB6j19eNfrsqPLwSA4ksB
         d+P7vvS3ZmdAzGiTWC2llaC+KqKReCfVnNnWlLuzkpdUPnwqu7NbKER6lNBeAJzBBNzF
         RTvOuBS/yskMM6oTChJCo4+2UbG3bFJ39lkoJFbibrMLlsryXoB1Y8XwWIzLoroJFZ31
         YLtKLgrKziEhdDDo6Zy/OMssf8KScTb2Tl9sY9b5Mlcg6LGaJN57IAu2TnkwEURUcR/G
         vA1qUv8HJhkeDuXmBHcQEC0oTfFisC43KSKIxKqgbAc5MY23BJyQB0G99WZQPeo+gjv8
         g9dA==
X-Forwarded-Encrypted: i=1; AJvYcCUUQKQ0JVXgnmuH9clGlgsANiKINEViZ5idDrFtNrueinnMYsgCjkz0YIgmsdazVlgYxTzkLZ5KDKKOgoS6DnSE@vger.kernel.org, AJvYcCV9Hk0JJW4w+ZOs8he161c4d0YI8KloTnIUc9H8HcKAdXOVEd9g/Zany6cgWrQnxVJ3tKHucLXa/8/OnRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi282VFwX37kS4Fz7ZvFbXGJXP1z3sYVFKA0q1LKL9XGjecPNU
	ZoZoXHuxVP42m5DKLR9YOX2f59xd8zzia9SmL9k/wvIszebafVqEqZg4RHxjJJrEa753EQQTd5q
	0syoRKNHp9WFL0iajZGWlK2GC6OE=
X-Gm-Gg: ASbGncsPU8gwSdr8lBvZodR+QXCWEeUj7T6uDA2IQniZIO0h2WlqAVGXLOe4EuCdAH0
	t6TbGdLfEa8AQurdldQfzDO7C06fZSJd0nfU+Svk8yM33gTEzO75yAcpHtEQKU1ex4zI890VnTm
	Ko8HBQ7AxhLj++RBfibzsoHO5jSpk9tc9wdigr7NKhLzifSiTfqrc/DnM+Az6b
X-Google-Smtp-Source: AGHT+IE7ybsJw30eQldLIuRlyYc2TNW0oVcckLG0r77gXOjbSuKh4AD0gnef3xGyEl0eu2j8/V0f1EfU/WZtdIdLaec=
X-Received: by 2002:a2e:be91:0:b0:30b:badf:75ee with SMTP id
 38308e7fff4ca-30bd7a1e168mr8894531fa.7.1741174537682; Wed, 05 Mar 2025
 03:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com> <Z8gfsd5V9wrPKkiA@pathway.suse.cz>
In-Reply-To: <Z8gfsd5V9wrPKkiA@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 5 Mar 2025 06:35:01 -0500
X-Gm-Features: AQ5f1JprwBuCn92D2t-WJR_RsVK9zF9GVQwqc4riLjDfAJlrnyUXehNeN7Dw2go
Message-ID: <CAJ-ks9kXetd0wfy44T0g2r6Jx5eKSXr6N8Zk8wpAWj=5SKwHog@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] scanf: implicate test line in failure messages
To: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 4:56=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> On Fri 2025-02-14 11:19:58, Tamir Duberstein wrote:
> > This improves the failure output by pointing to the failing line at the
> > top level of the test.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  lib/test_scanf.c | 66 ++++++++++++++++++++++++++++--------------------=
--------
> >  1 file changed, 33 insertions(+), 33 deletions(-)
> >
> > diff --git a/lib/test_scanf.c b/lib/test_scanf.c
> > index 44f8508c9d88..d1664e0d0138 100644
> > --- a/lib/test_scanf.c
> > +++ b/lib/test_scanf.c
> > @@ -24,12 +24,12 @@ static char *test_buffer __initdata;
> >  static char *fmt_buffer __initdata;
> >  static struct rnd_state rnd_state __initdata;
> >
> > -typedef int (*check_fn)(const void *check_data, const char *string,
> > -                     const char *fmt, int n_args, va_list ap);
> > +typedef int (*check_fn)(const char *file, const int line, const void *=
check_data,
> > +                     const char *string, const char *fmt, int n_args, =
va_list ap);
> >
> > -static void __scanf(4, 6) __init
> > -_test(check_fn fn, const void *check_data, const char *string, const c=
har *fmt,
> > -     int n_args, ...)
> > +static void __scanf(6, 0) __init
>
> This should be:
>
> static void __scanf(6, 8) __init
>
> The zero (0) is used when the parameters are passed via the va_list.
> The value must be the position of the first parameter when they are passe=
d
> via the variable list of parameters, aka (...).
>
> Otherwise, it triggers the warnings reported by the lkp@intel.com
> kernel test robot, see
> https://lore.kernel.org/r/202502160245.KUrryBJR-lkp@intel.com
>
> Best Regards,
> Petr

Thanks for explaining!

