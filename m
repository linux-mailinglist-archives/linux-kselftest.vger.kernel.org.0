Return-Path: <linux-kselftest+bounces-26366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1364A30F54
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 16:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CB616245C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5B2512D5;
	Tue, 11 Feb 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSoKeFfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47F250C14;
	Tue, 11 Feb 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286756; cv=none; b=BF4V6V9KKC+ZG/MntkqLAGQPSVw0mmeuXesnk0KbS/VR/Dtz2v2RP3RtvxB2q2N7IEdxpT3BL8Q4iHmUDLZYJ2FxynzkZoxczmk9yUEoGuMI4whEO6MCHQL6tzwwOUQSkXFxIMnABJaBlh6mSctrFsMgyhDUIF/Ge+SLou3fJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286756; c=relaxed/simple;
	bh=kStyXu+JAL5fqswhBvR/ZBUU7ksA+1afXCkbE4Bp/+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qankMCOhqKGxA9Jpri8SXhYNViy/zXSFoOaQyalZvBBSlte5RmPI00BbBxteO5eSLpGNZHPrg//wW+Lj52Ejl0GhoQPkX+TuBAVlwLprLC46ahAAJTmvjXStq5+DTbYFatn0VV1WsEkfKTF8XWswq9Rau/tCcAZqwDIDhMs4wfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSoKeFfO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fcfso57855401fa.0;
        Tue, 11 Feb 2025 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739286752; x=1739891552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkaYdzmlPvQZC5F1bwM3/AMmG5xntcIf+kgxreyOBKI=;
        b=aSoKeFfOMcNgq6wA2SUhXzy6DiGaC2Jz/9nBni4vbdaDvW1CLfhohXwwaDqshndWLU
         XHfuHV5aS7Bstk1xxRCsLE5JpaMyyvObX9ZZrMHeHY6v7NchupeiMlcCBp21Vroo7Kg5
         xrhezxkSa8DKLCiaiE/oKz0OcD3dP0V/eoRF/cm/s6/bIUNyBd2jf5BKbvu/xwehrfaX
         TMLFIYSd8gC5g4vSJIkzXcz/sBVdo5OTSgjDT4Pa5cIHf4T9H0a5/8cRe1W7xwncEYnS
         7CqN+c4e0PJCstfkzPWKaGFOnYxq/3Ku4IULoyQrd1MlprNSlYsT+CkLZ3dTeBZObk1y
         MfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739286752; x=1739891552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkaYdzmlPvQZC5F1bwM3/AMmG5xntcIf+kgxreyOBKI=;
        b=ncGZJR2RHl4/djoYbeBbc+6xhnLpQs+qYwx2L9RXdmIK79RJK7UxSCKYjU5TRNR2wV
         NH8XqCCDTSR8Iz9UJlYgA0eiAgY1p+4XOIkFp/cS0zZcOEkGxSueAzXJvIHcYj6IqEXS
         RekZC7obTXpp/keXu+wL48FpdbxNd/QzdtNY7SqTepqqYOkWVJs1F2YC5+xD7vRT/tYT
         AZxFX84uX/W8Wqz7wbIAKLYNR7gPyFvCb8/gZUTm+cBZ98vVA56HqylvF2C/bYBMGOoI
         49V+cRi885CdkUi7YPMq1PU3UJkPg0MFuV7Uuqapk/8EF+LmLKNxJdEyHa/LSwZsOG2N
         hibg==
X-Forwarded-Encrypted: i=1; AJvYcCWf+WF6jYeGX9xclKbA03Ze9tMvQ29qtU9nyqKt5U6lXnb9UuCvcXXmTRtxmsJ3mxwLj9Adh4vlxu2gWyQ=@vger.kernel.org, AJvYcCXIrLofj9i9lTv7ktQFcscppyZsx+Z489prZTBuW0+0aQ5eLK8EwQ3gmHWErt3CCvRlMSwPS/+Uo23D2zgk/bMS@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnVUDvjvbqovSCnU0iiFPKvK6qpE4Wte0QBmLQldi85lwJNe4
	vzESxYW3pQEpMetaMCGULRCWI8CvWyKGLYhiD+yGavUsyLFRaEArl+SCMyH8k/hfFJfhHIkmU9r
	EwU/ZCItgEqWGbHyLt/GArnqBiU8=
X-Gm-Gg: ASbGncsEA7hAYjg6agMZ0zuwAwM+lP6E/ic2Jx/iUNc0yKRQNc5agclneH/ahX/eOUe
	mqGfNWs3gZYbksE16Y1fxddRm4DmxLw8mzXjAPMMguGau3w5ncFMfNZrNnIIXBzKcPFnSFtkT0W
	/eKhlr0FF8nfFv
X-Google-Smtp-Source: AGHT+IGvmcErikj7jRrY1ScKE50NnjQHAdp11f389G68bLeFDJCyekRxXQ0ojZoHl5gpzfcxIaEd5mJpFAB3kHUFO5I=
X-Received: by 2002:a05:651c:554:b0:307:dc1f:e465 with SMTP id
 38308e7fff4ca-307e57fed4amr60360311fa.22.1739286751366; Tue, 11 Feb 2025
 07:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-scanf-kunit-convert-v6-0-4d583d07f92d@gmail.com>
 <20250210-scanf-kunit-convert-v6-2-4d583d07f92d@gmail.com> <Z6s6WsIw3VCGys6K@pathway.suse.cz>
In-Reply-To: <Z6s6WsIw3VCGys6K@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Feb 2025 10:11:54 -0500
X-Gm-Features: AWEUYZkjGfsZ8ktVKL9hlFP5tOp_PK81S1k3Jl54bfWPJ1djDGGPUgdHIZbpX3E
Message-ID: <CAJ-ks9=sVKZf=Cy9mk+mw2ua_XXwd58kudas4J5krTfPtQyVbA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] scanf: break kunit into test cases
To: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:54=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Mon 2025-02-10 13:13:49, Tamir Duberstein wrote:
> > Use `suite_init` and move some tests into `scanf_test_cases`. This
> > gives us nicer output in the event of a failure.
>
> Hmm, simulate the following failure in the original test module:
>
>
> diff --git a/lib/test_scanf.c b/lib/test_scanf.c
> index 44f8508c9d88..3ec12328cc4c 100644
> --- a/lib/test_scanf.c
> +++ b/lib/test_scanf.c
> @@ -564,7 +564,7 @@ static void __init numbers_list_field_width_val_h(con=
st char *delim)
>         numbers_list_val_width(unsigned short,  "%hu",       delim, "hu",=
 check_ushort);
>         numbers_list_val_width(short,           "%hd",       delim, "hd",=
 check_short);
>         numbers_list_val_width(short,           "%hd",       delim, "hi",=
 check_short);
> -       numbers_list_val_width(unsigned short,  "%hx",       delim, "hx",=
 check_ushort);
> +       numbers_list_val_width(unsigned short,  "%hx",       delim, "hx",=
 check_uint);
>         numbers_list_val_width(unsigned short,  "0x%hx",     delim, "hx",=
 check_ushort);
>         numbers_list_val_width(short,           "0x%hx",     delim, "hi",=
 check_short);
>  }
>
> and I got:
>
>
> [  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4h=
x %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959=
881
> [  383.102843] test_scanf: vsscanf("f12:2:d:2:c166:1:36b:1906", "%3hx:%1h=
x:%1hx:%1hx:%4hx:%1hx:%3hx:%4hx", ...) expected 131085 got 851970
> [  383.105376] test_scanf: vsscanf("4,b2fe,3,593,6,0,3bde,0", "%1hx,%4hx,=
%1hx,%3hx,%1hx,%1hx,%4hx,%1hx", ...) expected 93519875 got 242430
> [  383.105659] test_scanf: vsscanf("6-1-2-1-d9e6-f-93e-e567", "%1hx-%1hx-=
%1hx-%1hx-%4hx-%1hx-%3hx-%4hx", ...) expected 65538 got 131073
> [  383.106127] test_scanf: vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2h=
x/%4hx/%1hx/%1hx/%4hx/%1hx/%1hx", ...) expected 125069 got 3901554741
> [  383.106235] test_scanf: vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx=
%1hx%4hx%4hx%1hx%4hx%3hx", ...) expected 571539457 got 106936
> [  383.106398] test_scanf: failed 6 out of 2545 tests
>
>
> When I tried to do the same in the new module:
>
> diff --git a/lib/scanf_kunit.c b/lib/scanf_kunit.c
> index e45f3c4f0437..692eb8cbbeab 100644
> --- a/lib/scanf_kunit.c
> +++ b/lib/scanf_kunit.c
> @@ -546,7 +546,7 @@ static void numbers_list_field_width_val_h(struct kun=
it *test, const char *delim
>         numbers_list_val_width(unsigned short,  "%hu",       delim, "hu",=
 check_ushort);
>         numbers_list_val_width(short,           "%hd",       delim, "hd",=
 check_short);
>         numbers_list_val_width(short,           "%hd",       delim, "hi",=
 check_short);
> -       numbers_list_val_width(unsigned short,  "%hx",       delim, "hx",=
 check_ushort);
> +       numbers_list_val_width(unsigned short,  "%hx",       delim, "hx",=
 check_uint);
>         numbers_list_val_width(unsigned short,  "0x%hx",     delim, "hx",=
 check_ushort);
>         numbers_list_val_width(short,           "0x%hx",     delim, "hi",=
 check_short);
>  }
>
> then I got:
>
> [ 6625.895391] KTAP version 1
> [ 6625.895928] 1..1
> [ 6625.896494]     KTAP version 1
> [ 6625.896852]     # Subtest: scanf
> [ 6625.897191]     # module: scanf_kunit
> [ 6625.897198]     1..10
> [ 6625.903479]     ok 1 numbers_simple
> [ 6625.903490]         KTAP version 1
> [ 6625.904352]         # Subtest: numbers_list
> [ 6625.905623]         ok 1 " "
> [ 6625.907654]         ok 2 ":"
> [ 6625.909654]         ok 3 ","
> [ 6625.911564]         ok 4 "-"
> [ 6625.913632]         ok 5 "/"
> [ 6625.914020]     # numbers_list: pass:5 fail:0 skip:0 total:5
> [ 6625.914370]     ok 2 numbers_list
> [ 6625.914964]         KTAP version 1
> [ 6625.915871]         # Subtest: numbers_list_field_width_typemax
> [ 6625.917527]         ok 1 " "
> [ 6625.919366]         ok 2 ":"
> [ 6625.921586]         ok 3 ","
> [ 6625.923240]         ok 4 "-"
> [ 6625.925226]         ok 5 "/"
> [ 6625.925622]     # numbers_list_field_width_typemax: pass:5 fail:0 skip=
:0 total:5
> [ 6625.925973]     ok 3 numbers_list_field_width_typemax
> [ 6625.926709]         KTAP version 1
> [ 6625.927613]         # Subtest: numbers_list_field_width_val_width
> [ 6625.928546]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1044578334 (0x3e43001e)
>                        *pval =3D=3D 837828163 (0x31f03e43)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
> [ 6625.929225]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 837828163 (0x31f03e43)
>                        *pval =3D=3D 0 (0x0)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
> [ 6625.932202]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 12784 (0x31f0)
>                        *pval =3D=3D 2624608151 (0x9c705797)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
> [ 6625.934982]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 0 (0x0)
>                        *pval =3D=3D 1966080 (0x1e0000)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
> [ 6625.935004]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1469513728 (0x57970000)
>                        *pval =3D=3D 837828163 (0x31f03e43)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
> [ 6625.935025]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 2624608151 (0x9c705797)
>                        *pval =3D=3D 0 (0x0)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
> [ 6625.935046]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 469802096 (0x1c009c70)
>                        *pval =3D=3D 2624608151 (0x9c705797)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
> [ 6625.938161]         not ok 1 " "
> [ 6625.952074]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 131073 (0x20001)
>                        *pval =3D=3D 65538 (0x10002)
>                vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4=
hx:%1hx:%3hx:%4hx", ...)
> [ 6625.952098]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 65538 (0x10002)
>                        *pval =3D=3D 1038822 (0xfd9e6)
>                vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4=
hx:%1hx:%3hx:%4hx", ...)
> [ 6625.952121]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3655729153 (0xd9e60001)
>                        *pval =3D=3D 3848735038 (0xe567093e)
>                vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4=
hx:%1hx:%3hx:%4hx", ...)
> [ 6625.952143]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1038822 (0xfd9e6)
>                        *pval =3D=3D 65542 (0x10006)
>                vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4=
hx:%1hx:%3hx:%4hx", ...)
> [ 6625.960548]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 155058191 (0x93e000f)
>                        *pval =3D=3D 65538 (0x10002)
>                vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4=
hx:%1hx:%3hx:%4hx", ...)
> [ 6625.960579]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3848735038 (0xe567093e)
>                        *pval =3D=3D 1038822 (0xfd9e6)
>                vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4=
hx:%1hx:%3hx:%4hx", ...)
> [ 6625.960604]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 50390375 (0x300e567)
>                        *pval =3D=3D 3848735038 (0xe567093e)
>                vsscanf("6:1:2:1:d9e6:f:93e:e567", "%1hx:%1hx:%1hx:%1hx:%4=
hx:%1hx:%3hx:%4hx", ...)
> [ 6625.969351]         not ok 2 ":"
> [ 6625.969860]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3589275648 (0xd5f00000)
>                        *pval =3D=3D 3768047088 (0xe097d5f0)
>                vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%=
4hx,%1hx,%4hx,%3hx,%4hx", ...)
> [ 6625.972121]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3768047088 (0xe097d5f0)
>                        *pval =3D=3D 878575619 (0x345e0003)
>                vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%=
4hx,%1hx,%4hx,%3hx,%4hx", ...)
> [ 6625.972139]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 254103 (0x3e097)
>                        *pval =3D=3D 2832859455 (0xa8da013f)
>                vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%=
4hx,%1hx,%4hx,%3hx,%4hx", ...)
> [ 6625.976800]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 878575619 (0x345e0003)
>                        *pval =3D=3D 0 (0x0)
>                vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%=
4hx,%1hx,%4hx,%3hx,%4hx", ...)
> [ 6625.976819]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 20919390 (0x13f345e)
>                        *pval =3D=3D 3768047088 (0xe097d5f0)
>                vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%=
4hx,%1hx,%4hx,%3hx,%4hx", ...)
> [ 6625.976836]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 2832859455 (0xa8da013f)
>                        *pval =3D=3D 878575619 (0x345e0003)
>                vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%=
4hx,%1hx,%4hx,%3hx,%4hx", ...)
> [ 6625.976853]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3691030746 (0xdc00a8da)
>                        *pval =3D=3D 2832859455 (0xa8da013f)
>                vsscanf("0,0,d5f0,e097,3,345e,13f,a8da", "%1hx,%1hx,%4hx,%=
4hx,%1hx,%4hx,%3hx,%4hx", ...)
> [ 6625.979505]         not ok 3 ","
> [ 6625.989303]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1475084289 (0x57ec0001)
>                        *pval =3D=3D 3243268076 (0xc15057ec)
>                vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2h=
x-%1hx-%1hx-%1hx", ...)
> [ 6625.989324]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3243268076 (0xc15057ec)
>                        *pval =3D=3D 21 (0x15)
>                vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2h=
x-%1hx-%1hx-%1hx", ...)
> [ 6625.989343]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1425744 (0x15c150)
>                        *pval =3D=3D 786439 (0xc0007)
>                vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2h=
x-%1hx-%1hx-%1hx", ...)
> [ 6625.994177]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 21 (0x15)
>                        *pval =3D=3D 65537 (0x10001)
>                vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2h=
x-%1hx-%1hx-%1hx", ...)
> [ 6625.994196]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 458752 (0x70000)
>                        *pval =3D=3D 3243268076 (0xc15057ec)
>                vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2h=
x-%1hx-%1hx-%1hx", ...)
> [ 6625.994214]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 786439 (0xc0007)
>                        *pval =3D=3D 21 (0x15)
>                vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2h=
x-%1hx-%1hx-%1hx", ...)
> [ 6625.994232]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3858759692 (0xe600000c)
>                        *pval =3D=3D 786439 (0xc0007)
>                vsscanf("1-1-57ec-c150-15-0-7-c", "%1hx-%1hx-%4hx-%4hx-%2h=
x-%1hx-%1hx-%1hx", ...)
> [ 6626.003487]         not ok 4 "-"
> [ 6626.004021]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 3901554741 (0xe88d0035)
>                        *pval =3D=3D 125069 (0x1e88d)
>                vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/=
%1hx/%4hx/%1hx/%1hx", ...)
> [ 6626.006206]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 125069 (0x1e88d)
>                        *pval =3D=3D 1821114368 (0x6c8c0000)
>                vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/=
%1hx/%4hx/%1hx/%1hx", ...)
> [ 6626.006226]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1 (0x1)
>                        *pval =3D=3D 65543 (0x10007)
>                vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/=
%1hx/%4hx/%1hx/%1hx", ...)
> [ 6626.006243]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1821114368 (0x6c8c0000)
>                        *pval =3D=3D 3502806 (0x3572d6)
>                vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/=
%1hx/%4hx/%1hx/%1hx", ...)
> [ 6626.006261]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 486540 (0x76c8c)
>                        *pval =3D=3D 125069 (0x1e88d)
>                vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/=
%1hx/%4hx/%1hx/%1hx", ...)
> [ 6626.015404]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 65543 (0x10007)
>                        *pval =3D=3D 1821114368 (0x6c8c0000)
>                vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/=
%1hx/%4hx/%1hx/%1hx", ...)
> [ 6626.015423]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1828716545 (0x6d000001)
>                        *pval =3D=3D 65543 (0x10007)
>                vsscanf("72d6/35/e88d/1/0/6c8c/7/1", "%4hx/%2hx/%4hx/%1hx/=
%1hx/%4hx/%1hx/%1hx", ...)
> [ 6626.018041]         not ok 5 "/"
> [ 6626.022529]     # numbers_list_field_width_val_width: pass:0 fail:5 sk=
ip:0 total:5
> [ 6626.022535]     not ok 4 numbers_list_field_width_val_width
> [ 6626.023220]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit=
.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 106936 (0x1a1b8)
>                        *pval =3D=3D 571539457 (0x22110001)
>                vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx=
%1hx%4hx%3hx", ...)
> [ 6626.024017]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit=
.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 571539457 (0x22110001)
>                        *pval =3D=3D 81562 (0x13e9a)
>                vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx=
%1hx%4hx%3hx", ...)
> [ 6626.024035]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit=
.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1050288657 (0x3e9a2211)
>                        *pval =3D=3D 91449567 (0x57368df)
>                vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx=
%1hx%4hx%3hx", ...)
> [ 6626.024053]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit=
.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 81562 (0x13e9a)
>                        *pval =3D=3D 2713242046 (0xa1b8c9be)
>                vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx=
%1hx%4hx%3hx", ...)
> [ 6626.024073]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit=
.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1759444993 (0x68df0001)
>                        *pval =3D=3D 571539457 (0x22110001)
>                vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx=
%1hx%4hx%3hx", ...)
> [ 6626.024091]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit=
.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 91449567 (0x57368df)
>                        *pval =3D=3D 81562 (0x13e9a)
>                vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx=
%1hx%4hx%3hx", ...)
> [ 6626.024108]     # numbers_slice: EXPECTATION FAILED at lib/scanf_kunit=
.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1107297651 (0x42000573)
>                        *pval =3D=3D 91449567 (0x57368df)
>                vsscanf("c9bea1b8122113e9a168df573", "%4hx%4hx%1hx%4hx%4hx=
%1hx%4hx%3hx", ...)
> [ 6626.026607]     not ok 5 numbers_slice
> [ 6626.039801]     ok 6 numbers_prefix_overflow
> [ 6626.040522]     ok 7 test_simple_strtoull
> [ 6626.041433]     ok 8 test_simple_strtoll
> [ 6626.042409]     ok 9 test_simple_strtoul
> [ 6626.043153]     ok 10 test_simple_strtol
> [ 6626.043161] # scanf: pass:8 fail:2 skip:0 total:10
> [ 6626.043166] # Totals: pass:16 fail:6 skip:0 total:22
> [ 6626.043170] not ok 1 scanf
>
>
> I like that the log better points to the test:
>
> [ 6625.927613]         # Subtest: numbers_list_field_width_val_width
>
> But
>
> [ 6625.928546]     # numbers_list_field_width_val_width: EXPECTATION FAIL=
ED at lib/scanf_kunit.c:91
>                    Expected got =3D=3D *pval, but
>                        got =3D=3D 1044578334 (0x3e43001e)
>                        *pval =3D=3D 837828163 (0x31f03e43)
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
>
> is much harder to parse than the original

Yeah, I find that hard to look at as well. I'll revert this to the
original format.

> [  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4h=
x %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959=
881
>
>
> Also I wonder why the scanned string is different:
>
>                vsscanf("0 1e 3e43 31f0 0 0 5797 9c70", "%1hx %2hx %4hx %4=
hx %1hx %1hx %4hx %4hx", ...)
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> vs.
>
> [  383.100048] test_scanf: vsscanf("1574 9 64ca 935b 7 142d ff58 0", "%4h=
x %1hx %4hx %4hx %1hx %4hx %4hx %1hx", ...) expected 2472240330 got 1690959=
881
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> I would expect that the 1st error would be on the same string
> in both tests. I wonder why it differs.

This is just because the order in which the tests run has changed.
These strings come from a PRNG. Before the last patch the tests did
(pseudocode):

for (delim : delims) {
  for (test : tests) {
    test(delim)
  }
}

After the last patch the inner and outer loops have traded places.

>
> Best Regards,
> Petr

