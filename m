Return-Path: <linux-kselftest+bounces-17364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B262496EBDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 09:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C75B23C07
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 07:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A71494AC;
	Fri,  6 Sep 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUl0LgPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5017C9B
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Sep 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607315; cv=none; b=XSDcxUbhaPoJSyQ+g6QeoUZLIxVShua1MGdV/xCCLAOWtXuR6FPwIvkqo1mMulEWfSj7nvuVSqVxDBeHRGNJhzjKZWC3+ucAyi4JfML4NfH0rZZmgyw3ACQDwjODEz4RC1B2T2dteit9fkZjAZgP7ittwC8VRpq9dHjDjhTZj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607315; c=relaxed/simple;
	bh=buFOcruXFKbZD7lXSTH0BzTOUuIpZl+mr+cba6zf5bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1eiSjxFuieJPAxgjJpF/wK9FqG9ODgpgFJCq9kUuN+E4HS8om5USvZ/DOjG6yV07DtrgGQNuPGtpOi6IBSres//43GnYPzU/M70MVUjJbGQIwdeJzKidYWWRf/TbIR1Liv6DVFHGezOGh0zxxR7I/Tc4Y9qX5NejkNKI0Pb6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kUl0LgPw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-45812fdcd0aso882141cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2024 00:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725607313; x=1726212113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/t48qXnFKotkgk/2imeBGtwcBPhCMTK5rgtxkPb8bds=;
        b=kUl0LgPwmEWut0wp5cl4OLX7aski4jChM3f4Ww2d93xTzHWTzJQLZGHiC13LNHf451
         QLhKSEF45A9ssfh/QXqJ8f8RQku5kqP0j51wmvbe0/Bf7NThXYX5xWrh1ofltOz8cuyu
         tgyX/1yPBna5ZBlILg5djLfhIc88LF6qmrY2ZpYcx70yhIKz1G/Ur+NUiP1uFkrxfv1D
         vrtABaD7TMflZv31opDAC7WUUbK0h9DrZI3M7PqXmubkGXdkuSXzfDY67OeXg6ZsnOOI
         43T+LkGGdse3Ekh5vjx/qvS7eYnM+BMRmwDsX7yVK/srRQ515o/uc9BLw1LEMmMKekMx
         1+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607313; x=1726212113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/t48qXnFKotkgk/2imeBGtwcBPhCMTK5rgtxkPb8bds=;
        b=WQqH1W9ZSD1krjvRajnE1KaNkrAJGmhFyCj12cJqFaIoEr1cOXj5isPaQuWesL7tvv
         3r7iY3cY/FggMXWtWj+fWzR9wkvKWyRx5hgb/jJENu9uzQsYoY4Hl2XB/Z/oPKxa61Mi
         L7nNkbHET0BHW2EB95FA3+ASl0ezGd+gQ5By79kUM5+rq/8Sl1/6P1qQ80g7H6d0G0ln
         gHNX0ty4ggdWUTyGzs1DFY3KVcxPV4uCwyQ7TSaNuogsgVo4sfgkqa+iCaArHVd9FuvQ
         /+AxT5qNlvmXdCI/Ny1yufyD6j3xDPZIlJfsZw++PHmKBk5UbHgPzduImfcTrnPrVNN3
         Ieyg==
X-Forwarded-Encrypted: i=1; AJvYcCWh0ZIs6JS3MzE7zEQFslygFCYPN+UoZEamedYLETwfwtN3LZNBJO9Jr194a2lILOQQXiEcWFpniYECPo1qeDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/DqmCa8nEjgSgovlwMdHWzMXvWLh/zCaz2mNSzaESzgnKMDm
	G6SsUgQ0G6Nn/ZIuYon3JVnZfaBKNconDZ0oEVrVA+KFY7lVQXkTE4eI1taifXY9TseImU2rH1D
	M5BIy5k/kockmw+S964oXCTqJi6hygG1IBYSh
X-Google-Smtp-Source: AGHT+IFBV8Yd2nT2AulbkO08HT/QnTTbmT0TS7vdBab/jbxAz/kQc+/8UUhhPkOdHofIV0oqnC52EL3cU+282BCHg2Y=
X-Received: by 2002:a05:622a:1496:b0:447:f6c7:65ee with SMTP id
 d75a77b69052e-457f8b96f9emr160689031cf.10.1725607312354; Fri, 06 Sep 2024
 00:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820010353.7533-1-luis.hernandez093@gmail.com>
In-Reply-To: <20240820010353.7533-1-luis.hernandez093@gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 6 Sep 2024 15:21:39 +0800
Message-ID: <CABVgOSnkTchMaJunwKO_BYutYVHYbFSUOCdVQQrYLrzu4sOjUQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/math: Add int_pow test suite
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ecd63906216e42c4"

--000000000000ecd63906216e42c4
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 09:04, Luis Felipe Hernandez
<luis.hernandez093@gmail.com> wrote:
>
> Adds test suite for integer based power function.
>
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
> Changes in v3:
> - Fix compiler warning: explicitly define constant as unsigned int
> - Add changes in patch revisions
> Changes in v2:
> - Address review feedback
>   - Add kconfig entry
>   - Use correct dir and file convention for KUnit
>   - Fix typo
>   - Remove unused static_stub header
>   - Refactor test suite to use paramerterized test cases
>   - Add close to max allowable value to in large_result test case
>   - Add test case with non-power of two exponent
>   - Fix module license
> ---

This looks pretty good to me, thanks!

A few very minor nitpicks below, but nothing serious.

With those fixed, this is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/Kconfig.debug              |  9 ++++++
>  lib/math/Makefile              |  1 +
>  lib/math/tests/Makefile        |  3 ++
>  lib/math/tests/int_pow_kunit.c | 52 ++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+)
>  create mode 100644 lib/math/tests/Makefile
>  create mode 100644 lib/math/tests/int_pow_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a30c03a66172..b0bbd30d4cba 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3051,3 +3051,12 @@ config RUST_KERNEL_DOCTESTS
>  endmenu # "Rust"
>
>  endmenu # Kernel hacking
> +
> +config INT_POW_TEST
> +       tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         Enable this to test the int_pow maths function KUnit test.
> +
> +         If unsure, say N

Hmm... checkpatch is still warning that this is too short a
description. Maybe we could add a sentence about what int_pow actually
does (integer exponentiation?)

> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 91fcdb0c9efe..3c1f92a7459d 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -5,5 +5,6 @@ obj-$(CONFIG_CORDIC)            += cordic.o
>  obj-$(CONFIG_PRIME_NUMBERS)    += prime_numbers.o
>  obj-$(CONFIG_RATIONAL)         += rational.o
>
> +obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
>  obj-$(CONFIG_TEST_DIV64)       += test_div64.o
>  obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> diff --git a/lib/math/tests/Makefile b/lib/math/tests/Makefile
> new file mode 100644
> index 000000000000..6a169123320a
> --- /dev/null
> +++ b/lib/math/tests/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_INT_POW_TEST) += int_pow_kunit.o
> diff --git a/lib/math/tests/int_pow_kunit.c b/lib/math/tests/int_pow_kunit.c
> new file mode 100644
> index 000000000000..e04dd73dabd1
> --- /dev/null
> +++ b/lib/math/tests/int_pow_kunit.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0

Maybe use GPL-2.0-only for consistency with the above? GPL-2.0 is
deprecated, so either GPL-2.0-only or GPL-2.0-or-later should be used
where possible.

> +
> +#include <kunit/test.h>
> +#include <linux/math.h>
> +
> +struct test_case_params {
> +       u64 base;
> +       unsigned int exponent;
> +       u64 expected_result;
> +       const char *name;
> +};
> +
> +static const struct test_case_params params[] = {
> +       { 64, 0, 1, "Power of zero" },
> +       { 64, 1, 64, "Power of one"},
> +       { 0, 5, 0, "Base zero" },
> +       { 1, 64, 1, "Base one" },
> +       { 2, 2, 4, "Two squared"},
> +       { 2, 3, 8, "Two cubed"},
> +       { 5, 5, 3125, "Five raised to the fith power" },

Nit: _fiftth_ power

> +       { U64_MAX, 1, U64_MAX, "Max base" },
> +       { 2, 63, 9223372036854775808ULL, "Large result"},
> +};
> +
> +static void get_desc(const struct test_case_params *tc, char *desc)
> +{
> +       strscpy(desc, tc->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +KUNIT_ARRAY_PARAM(int_pow, params, get_desc);
> +
> +static void int_pow_test(struct kunit *test)
> +{
> +       const struct test_case_params *tc = (const struct test_case_params *)test->param_value;
> +
> +       KUNIT_EXPECT_EQ(test, tc->expected_result, int_pow(tc->base, tc->exponent));
> +}
> +
> +static struct kunit_case math_int_pow_test_cases[] = {
> +       KUNIT_CASE_PARAM(int_pow_test, int_pow_gen_params),
> +       {}
> +};
> +
> +static struct kunit_suite int_pow_test_suite = {
> +       .name = "math-int_pow",
> +       .test_cases = math_int_pow_test_cases,
> +};
> +
> +kunit_test_suites(&int_pow_test_suite);
> +
> +MODULE_DESCRIPTION("math.int_pow KUnit test suite");
> +MODULE_LICENSE("GPL");
> --
> 2.46.0
>

--000000000000ecd63906216e42c4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgi6VayIvwo54jZYkfM0W9flqkgO66
J98xi0/5vuMGPJMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQw
OTA2MDcyMTUzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBACDatE9D326XxBfhHnZkLzCoadSue4o1uRxFw4D76KlikbkK
kK0SUcdC8+UC/LwkYebMd72nuPUSjE87AKMcQgS8zlGL0vHKSSOkDoZBhfNzXCbXj6icYk1GMh/X
/ghgOkFiOVITKzUhfuVYXpKpg66fYPtmNxexoLCQ+vTJWgA1477WpuuK8XQjIFYPUCxYDz+ZWW56
8qInEgK/dKwMRG0q3Rhi8Z3m2OgyOgWkgBIDrBLKRkIaSduZg5NzGj9SHHehEHjiug2qT9BWdQxX
4DoKIiIF/znCy9loHjHmXGrAoQA26rdAXUb5n+lsbRNohxPmqZM/XVpwQ7p/977/tAs=
--000000000000ecd63906216e42c4--

