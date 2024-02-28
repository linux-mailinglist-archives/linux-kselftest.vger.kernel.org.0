Return-Path: <linux-kselftest+bounces-5548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D386B7B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 19:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E8A1C260D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98BB74429;
	Wed, 28 Feb 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sj0jFErc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AD71ED1
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146294; cv=none; b=LmkNym/wDSLsW91N0ETusxTuBVLFTdqOjwZUZ8B1mKwQuQ/XprgT/wXzLICe04rLyS3TyXPs51ac1iQnySVyAits9hEyOGWFQEUjmYlKaj9IipAO3TjEQi7R5b5OYvFuMzPUfhOSWot/BQ3w7S4zUzTCoToe3B6B093MEtRJY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146294; c=relaxed/simple;
	bh=Mq1bVqEtjPOg/Kna3gKNt4IIhWPXvmOY4nxHMzFfQfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Un3/mcmoXm3AnZ5AyjCD30wk9gIerGjES0tb1+u78ZNKCYVzMGVdnl4nc+Wk9wCACflvKL5WACG5szs/QMbFsRFyVwtDrblNFvzfPk2GfXQZV5cORHgf9BOSy8jtPVDF4Nl8rCquB7bvzaXGRUSY2QA30dTLnnyC450bNbwGTeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sj0jFErc; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so130094276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Feb 2024 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709146291; x=1709751091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc1MEpNuIldDqUUrPWh59DW10XrYCCeg/GGoCtFBKzk=;
        b=Sj0jFErc+d/4+rtntAWTEQYz+X/qMohJzHeDZnVf9ACdXjLLxYM7yOXwyMM1kEGW2y
         owOWCt3wkZ+NShtLKrWoc0/wnk7REns+IYG7n+nYgI5vKfgWJOlV0fe1B2jCq8U5ZCr7
         WMLRdwYrycIDu9A/NpPiAz7GSXRYijlapb3PzNtM5uJYEj2EfK6FAw4JFUT5ApbHzSQR
         NzIvUSV3R+y90bAXJiibVmnJI7D5oX83PvHinrT9FcAUv0KyrEBqcINC74CxyFA0RMBd
         rVPGv9krWChaBSwV5Z+6n/bUQx/4jR+OAn0ATbG0HaFh+Mw97c4Ntv3+cVxPtl6zux9n
         Mdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146291; x=1709751091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc1MEpNuIldDqUUrPWh59DW10XrYCCeg/GGoCtFBKzk=;
        b=ntGYLjOadiH35J7fyE1j64QucKh8Iig/VPgBiyyiO+WBaub6/XwWmZsfDRBampioM5
         1sCDyeAGizmYUrC2By7NGn1eQqtiZukRq+TVN/zn99zbjMmVhYL4mDw4dHRDM7v1JOvj
         qNekRQqDivrHt0aucrgAfKGIejOqBrHnRuyFfGb9QaF8g/JMvFze+LVJmmwe1KeiJXLZ
         meDKsAqgB5R5gRbkBVFR5ETyG4WM1U4IalUNQ/9UBw8tNEXtH5vJ44ZppE5k8RTjnSsP
         iUhLtTJXszYSlGB4zw/Xb68mMn8v8gT/yDQX2At/aS6ZMfUg9KhALkXcZJDWqRL/Q5to
         QqIg==
X-Forwarded-Encrypted: i=1; AJvYcCX+DHU7hjjJphznlI844mP6bkBlRxhJnHiDNIOuPby1r+iocCakL97jdcatEtWMsFavEaLcqZ2dRECAz6wBvW33tO3puKk1RkwI9H3C5dwc
X-Gm-Message-State: AOJu0YyEO/2xPuY10fHOwc6liguJwfOp7xJ+d+5NF5K4/3EnR1uldtNY
	DySHw46ZkAJM6qEDrI1+8yw8DmnOp/xUGp6pCFAOfL4dyHnYAx90CRmtcvCENASkJJPoNpHHIfO
	IwYj8FqTvQVakLByRklsbHEy7AuiQ4A9ZWZu5
X-Google-Smtp-Source: AGHT+IE93V5If5jMYmyQci0CSi6Y0fx9W5ZkQQZDDbWyFX2r0N/841GeJrhUHsCATGXd5L1RDfgqvDUsXprfXPfdIjE=
X-Received: by 2002:a5b:74a:0:b0:dcb:f7b0:4788 with SMTP id
 s10-20020a5b074a000000b00dcbf7b04788mr49790ybq.60.1709146290715; Wed, 28 Feb
 2024 10:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
In-Reply-To: <20240227121920.1905095-1-usama.anjum@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 28 Feb 2024 10:51:19 -0800
Message-ID: <CABdmKX39M6e7o_Ossyy_Yg-CYQd-7piT6DmJk8ffEU9pPpP-8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:21=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:

...

> +static int numer_of_heaps(void)
> +{
> +       DIR *d =3D opendir(DEVPATH);
> +       struct dirent *dir;
> +       int heaps =3D 0;
> +
> +       while ((dir =3D readdir(d))) {
> +               if (!strncmp(dir->d_name, ".", 2))
> +                       continue;
> +               if (!strncmp(dir->d_name, "..", 3))
> +                       continue;
> +               heaps++;
> +       }
> +
> +       return heaps;
>  }
>
>  int main(void)
>  {
> -       DIR *d;
>         struct dirent *dir;
> -       int ret =3D -1;
> +       DIR *d;
> +
> +       ksft_print_header();
>
>         d =3D opendir(DEVPATH);
>         if (!d) {
> -               printf("No %s directory?\n", DEVPATH);
> -               return -1;
> +               ksft_print_msg("No %s directory?\n", DEVPATH);
> +               return KSFT_SKIP;
>         }
>
> -       while ((dir =3D readdir(d)) !=3D NULL) {
> +       ksft_set_plan(9 * numer_of_heaps());

Shouldn't this be 5 (one for each test_alloc_* below) instead of 9?

> +
> +       while ((dir =3D readdir(d))) {
>                 if (!strncmp(dir->d_name, ".", 2))
>                         continue;
>                 if (!strncmp(dir->d_name, "..", 3))
>                         continue;
>
> -               printf("Testing heap: %s\n", dir->d_name);
> -               printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -               ret =3D test_alloc_and_import(dir->d_name);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_zeroed(dir->d_name, 4 * 1024);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_zeroed(dir->d_name, ONE_MEG);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_compat(dir->d_name);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_errors(dir->d_name);
> -               if (ret)
> -                       break;
> +               ksft_print_msg("Testing heap: %s\n", dir->d_name);
> +               ksft_print_msg("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
> +               test_alloc_and_import(dir->d_name);
> +               test_alloc_zeroed(dir->d_name, 4 * 1024);
> +               test_alloc_zeroed(dir->d_name, ONE_MEG);
> +               test_alloc_compat(dir->d_name);
> +               test_alloc_errors(dir->d_name);
>         }
>         closedir(d);
>
> -       return ret;
> +       ksft_finished();
>  }
> --
> 2.42.0
>
>

