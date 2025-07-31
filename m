Return-Path: <linux-kselftest+bounces-38115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25FB17664
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 21:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B35D567C1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 19:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE523C8CE;
	Thu, 31 Jul 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDtgMzPA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BF23B61E
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988650; cv=none; b=OtDYeT4i23/V+hgLC6sxh0wLoERPH1kLm2NqQDO3T0xTcG8/KXp/0kLOYtlctQPF9HLLDCi18fla/nH3i6U42XeT+jStYEWZdF4refo7JQvIWA8LhrJw+c3gHhYDnu1b/bLXpZWB15c5v4Mms8TFzeODQAMoJZb12W0QEWd3hcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988650; c=relaxed/simple;
	bh=173rFFhLa/OnlYlgXY0qu0rl5EpYwN3Ri319nR2Dtbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gF4awDMgxa+cecsn4yB2IY2CxomaPSlsgeTG+AvBj7W0NtgWyV7+V3H+/4JFeSdYlR1QZIXDgR4OE9rw6Cq0SpqK+xGP7v/uTzxd6ARASpdj8pFM/ekI8rES8EIuuZXxqpwASE3Tn76za5OOI6A0MK8Pzg3psDuJSi3A+Qd/ECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDtgMzPA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7074bad03ceso8001606d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753988647; x=1754593447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj/7Gsrvh9XPHuAkUidAPLI16es4G/O+kKjv0mm7Cl4=;
        b=FDtgMzPAsLxs9EDUG6P+xNoIXInRefKdMdI+koiGvuZpktcXT71GkLKQ322w9K+rlr
         iprtvBfGi0znsTC5r5bOrKq7b88RGBSpbovdKQCTH7T+Wj8/qrUSyrEdufUzAKtrwBCE
         yA7DCH7wXhGQJQpUbMXobUVTNqdhYu+tqA0/lmo3IdEphJ/vsznAGAu0COPZeXxxplM7
         /S6WpoNRczpuc//EuWpFH72zOIyXU8bWNckuSh9euE2if1v/pXh7yON4BFRLZay51fo9
         3vItItONkpU6+L1ViR+0oSYUYXf6AAITn/pctO1D8dViAkdJetLHN4ufg5SITZBovE8h
         UYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753988647; x=1754593447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj/7Gsrvh9XPHuAkUidAPLI16es4G/O+kKjv0mm7Cl4=;
        b=AuaYbsLvhW0X//ZSD555gl5tJ9AeBO5ED4mvOh1vEyJ0Kuf7bkJa1aD8HvAiWPmgOV
         vadluM20d1ERMS2zmkbeFufhuPaUJhtWJedfuZtvi75mlVfUfjr5te7YR/01Et91HUBF
         dTGJ/I4L6xbGaLAZRz7rwnS9BHAx9Ax9DUwCsZqkFqk5s0lWB9EaMtbsG0mogYJLd59n
         mpcrsu2aAGYWHTiwfm97HLepPri3NUI4mCue3T/4zSPKg4k+OaGmD1p7d/lpxQDMM3yh
         PHwGv2HtA23X00r5ayYYLuRBzxx3vOg2w5ejmNFk8TnfO4pqVFUBt+iQ5aPKwt87xeO2
         vOUA==
X-Forwarded-Encrypted: i=1; AJvYcCWCAcyaYLFej4la2+YTr/vEKjonxDRu22NX2qAi+sGEnlaLPxK91ottrogKc8qdMgqcH+FTAB8eCkgCWWGaTUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuj7TXQy5c/rJo+0ocritoTmRG6heOJl+GZZeAhMTfxF12ccyZ
	FiKyoOePpUiv9d3HauwKg8t+2ZseDelKrtymiGxmr7jEpLUellndI3rYYbEM/i4gQxxYulgz6pU
	nuAmVY4mGy0MAFgA4lH6uEezHJ7bbpNMGijNrkLEk
X-Gm-Gg: ASbGncvnnZzmGCdAgLM6GTRMRC5Bvk+hsOE/rFUsx84wSN95pVBkb8SVuLUiLosS1xC
	XjfQVjbz0vKHU52xBDZB8SnUPqrUVF5Gm02TLV6fpGw9h7zFoYmj1oCWyo3ijZkJWO7zPT2N8VL
	S6tUBwNLMs1/wwY7Ec+w8Z2dfU0SUcRNfLLHWeOekuD/SojCDdu79qAUAKJfqAIYJZ3ELYIzdy+
	cunO/QwvPxiEdMBtW/HsuaiviOQVUGFtlzIL6/45L4bZXvi
X-Google-Smtp-Source: AGHT+IFKS2GeUVe6FWBJVJU6SOTZLx4X2NE0Kzqy0x5kMMXSkS9rNfTmSV21NQ16rogLb7+sEFXLHVy3p8jipDdFZk0=
X-Received: by 2002:ad4:5aaf:0:b0:707:62c5:975b with SMTP id
 6a1803df08f44-70766e312d7mr98014696d6.15.1753988647091; Thu, 31 Jul 2025
 12:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730031624.1911689-1-davidgow@google.com>
In-Reply-To: <20250730031624.1911689-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 31 Jul 2025 15:03:55 -0400
X-Gm-Features: Ac12FXyzGTyDZsjXhNlZ9t5Yhlq75GG_emhxAeVKyOddKo_zXsUrHdrlu6KKoE0
Message-ID: <CA+GJov76O5e31p05W0HNUAaXLfz2DhgAsKHtuWpPMCC=PFf1mg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Accept --raw_output=full as an alias of 'all'
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:16=E2=80=AFPM David Gow <davidgow@google.com> wr=
ote:
>
> I can never remember whether --raw_output takes 'all' or 'full'. No
> reason we can't support both.
>
> For the record, 'all' is the recommended, documented option.
>
> Signed-off-by: David Gow <davidgow@google.com>

Hello!

Happy to add the ability to use 'full'. Thanks!

Reviewed-by: Rae Moar <rmoar@google.com>

> ---
>  tools/testing/kunit/kunit.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 7f9ae55fd6d5..cd99c1956331 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -228,7 +228,7 @@ def parse_tests(request: KunitParseRequest, metadata:=
 kunit_json.Metadata, input
>                 fake_test.counts.passed =3D 1
>
>                 output: Iterable[str] =3D input_data
> -               if request.raw_output =3D=3D 'all':
> +               if request.raw_output =3D=3D 'all' or request.raw_output =
=3D=3D 'full':
>                         pass
>                 elif request.raw_output =3D=3D 'kunit':
>                         output =3D kunit_parser.extract_tap_lines(output)
> @@ -425,7 +425,7 @@ def add_parse_opts(parser: argparse.ArgumentParser) -=
> None:
>         parser.add_argument('--raw_output', help=3D'If set don\'t parse o=
utput from kernel. '
>                             'By default, filters to just KUnit output. Us=
e '
>                             '--raw_output=3Dall to show everything',
> -                            type=3Dstr, nargs=3D'?', const=3D'all', defa=
ult=3DNone, choices=3D['all', 'kunit'])
> +                            type=3Dstr, nargs=3D'?', const=3D'all', defa=
ult=3DNone, choices=3D['all', 'full', 'kunit'])
>         parser.add_argument('--json',
>                             nargs=3D'?',
>                             help=3D'Prints parsed test results as JSON to=
 stdout or a file if '
> --
> 2.50.1.552.g942d659e1b-goog
>

