Return-Path: <linux-kselftest+bounces-2236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FDC8191DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 22:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4C01C21078
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7439AEF;
	Tue, 19 Dec 2023 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIimDqd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FF3D0A3
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso1025e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703019826; x=1703624626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPrvLQ9nSKbJaWthUQcTRxDkRs0WKc5wjPuSEHtrSQU=;
        b=bIimDqd10RwEYvM9QoCk2rqaL3wQIdapP2ZHHCZE9cyCRns7JkyNRbTDibQMqm+xFj
         z/T/Z1LzfVz3Vfznjn93gWC36dujDyqhyri3yL68eVVYRVt5Iklg+9Xmf4A2az/KMr0Z
         vsL99WFj16MozYaSUAgGHuAV8fomq1tw4KP+M5qfOJJB5ZQOlojimn9xVgsJlzMil2yj
         +8CJ3xNd/Kb1b6cvlq4h0kd/rg2fZutXgQcCUl1x7iTl30FFT51D9GQMGG+UK1ho1bFY
         cwH25KRLEXQljsnzGFlzZcTh7BjyILs3UBI40yP3BdtWoEsf+EbqvI2CfWSKr8MV4ige
         pYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019826; x=1703624626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPrvLQ9nSKbJaWthUQcTRxDkRs0WKc5wjPuSEHtrSQU=;
        b=ur9/w4ka2KzXW1oNlFIolq+QGQV3USbZrFuOINxPVhc2M1JSOX3iHQFi+Iql/o5bFI
         gjR+tpIUfkcvEzQ+7pawyBG8b0X/saq86ssAh0ESZGOoYwpjOacfNB6VnolaroTgCK0F
         vZVA6aTVKO8UMy7Q4N8YJGV9Su6eR+G13Zp3xTi1JpUOneK0lH7rKMwHFwfqBvPkADNX
         iQIhjR85BZdH9IGU9rYqzdYNxFfwFgr55rOyRpiAankhhoowZilQV9A21TWABuz09OEO
         fjMqsfsVAV0SZx8+f7+7QM3tuLwEmAe7Hrl11SErhyDXdkJqFBtxpHetVI3hnkS5riVj
         bvZA==
X-Gm-Message-State: AOJu0Yyi3+GJxV81AojL4dR6cLhu8IlR99pFoUKrTOyHieEnBg69v7GE
	a00Mx9Xg+pUFRf6JaTwgE0fvjrpbKp3T5wYBh2ugqM+QBIDQ
X-Google-Smtp-Source: AGHT+IHtD2MzC0bAMHU9JfIRyz/yKwwNR6wfMtooBCTEUtmv9pzbQuKVvvdK8AUOCzhz/wGTTVopE1cFAEdvXzDJTJs=
X-Received: by 2002:a7b:c8c6:0:b0:40b:5972:f56b with SMTP id
 f6-20020a7bc8c6000000b0040b5972f56bmr6502wml.3.1703019825979; Tue, 19 Dec
 2023 13:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218151729.210027-1-rf@opensource.cirrus.com>
In-Reply-To: <20231218151729.210027-1-rf@opensource.cirrus.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 19 Dec 2023 16:03:34 -0500
Message-ID: <CA+GJov5MrgGO1bo8Zr=_E8h4beB7mkZdpODc=i_m7o5Sff6iLQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix NULL-dereference in kunit_init_suite() if
 suite->log is NULL
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:17=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> suite->log must be checked for NULL before passing it to
> string_stream_clear(). This was done in kunit_init_test() but was missing
> from kunit_init_suite().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 6d696c4695c5 ("kunit: add ability to run tests after boot using de=
bugfs")

Hello!

This looks good! Thanks! Sorry I did not catch this earlier.

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  lib/kunit/test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e803d998e855..ea7f0913e55a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -658,7 +658,9 @@ static void kunit_init_suite(struct kunit_suite *suit=
e)
>         kunit_debugfs_create_suite(suite);
>         suite->status_comment[0] =3D '\0';
>         suite->suite_init_err =3D 0;
> -       string_stream_clear(suite->log);
> +
> +       if (suite->log)
> +               string_stream_clear(suite->log);
>  }
>
>  bool kunit_enabled(void)
> --
> 2.30.2
>

