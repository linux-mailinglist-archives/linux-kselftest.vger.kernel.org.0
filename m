Return-Path: <linux-kselftest+bounces-33244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8070DABA921
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588B39E50C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84371DF97F;
	Sat, 17 May 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bp1a56H1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3851A83F5
	for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747474379; cv=none; b=s8O9gVVYWGsuarGNZ8wDxCbRMVBQmH/2TSvYm5tl+W72hK7C7HlN2V898+/GHLb6aK75IGDkXaJ9Mm3iN4gFW54V+i9vOv04rbzFnUBAQXwFv+zUBFxlIHPIHqmMv1qmB8oPpAtw8Qx2ExhBEi8IC3yHLzUnqYl6Xi5/RmxHJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747474379; c=relaxed/simple;
	bh=DZ5Wze+UcQTPe5dv7U4f0kELD93F5Zfb7nM4dkLfmQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu2+j4CfbpDb0dBR5PBQWliUlIddi3OK2ZiSjmHjUTpSm+OJ6I40xYvOH1nBo4+X5KXF4DXEapw5EGZEKp9ebdE+Jk/sGoliPsONfahki2U1NmbI6QA+7OLk3rdvcQL1scxW19pEIRKAFJtihalwUxpYcoJzI/BpNbXTWOfsVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bp1a56H1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8c0c8da93so15294906d6.0
        for <linux-kselftest@vger.kernel.org>; Sat, 17 May 2025 02:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747474377; x=1748079177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pvS6ulxjab0ZaxU/7WsXSLcN/1jbvyvAGzGKtO1R4xg=;
        b=Bp1a56H1sK6boQMJ4reK+V1MDtMzrTZvTLBSGVnp7yBgQIW+DLbJVJCOZS0Jj8DdgM
         UN3AqnTH5b4p3nUHtDjDEMsV1r5SD4uI9ZjVppJ1XWc+JxITsBIRcvR2Ta/Qwn+tqQ1d
         Cf41YLDmRvJLOcMneg24Ugr7VrTmvBmdwrYfWwkBQI8xJJK9r9jV7ZZWgudAgCrjn3wD
         Mqwez221Pu2C+ra1clH945Ra6x2ubN4sbD9+UlbJOLjNYijdAEUdsaitr9yqDsas3acE
         ZGaftrSfbJSGf7eqOZY+8sEQTSHDC3TX3RXJhwcvVVrA33Ss8mC7UW60eHRYA5N8Gphg
         hj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747474377; x=1748079177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvS6ulxjab0ZaxU/7WsXSLcN/1jbvyvAGzGKtO1R4xg=;
        b=wcCjuU20NJV8VHqhXpgJi6for7ISj8rXcwP83tQiFfRc78Zgph+32fEXxuBW59gRFS
         h4DpIe8dVTFSS7GSV8H0T4xMQupGp2RNYXOSC2QryE1XF1qeEH8BdSzBZh/baCtumcei
         iz91V00IKxA+7y1qN8hNGbbJyK51NdDrQOA1lOptmiaQtzo0MFCwgn053SSwBrsRbkCq
         T/odWaShTLZfcMMeMKZzhKWWTOht3Yc9+zEOGEAU4v1BIuhcxDdeedWNeCTUHO1FnLrf
         Z19WrV+DjIfiTN5dMu22ijM6C0GzdSzWgvHhnnFHtGR1+WltWbjqeqgCuf1XSfJSwF0v
         U2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW2CmaAtuNm1eZygO+pctLsAj0OwboZwF2SICqWbTmEZLhtzIjzie7/sPIxZg5Hruzre3vgg6m4jV6rLo8VrDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjGPUwDv7KPrj/FTHh61F4wCmk86IpvUym+8c33ir1Vieq5JB
	dTS/cWMBqbagR0cHYYIlIcG1k6GPIx9GonpFgL9i8AGW4pKMAydKn5ryHEoKe5D5tGj94yoXnAb
	nLYnpgYSacbdQ4PuBNsePEB3LrkuYc5/VQ0+MkQME
X-Gm-Gg: ASbGncuscwW1KUrNcfh9Cp6DgwRQF4DY4Uh7btmIWPWIgEjkspmZqqkS6GC8rkeH6CR
	+rBnYuhvpSTuRQ2CX7x34zCIYwhDOeJw/KVcCWjRwOoUYnwsP5YV/rJ0E55SXXoQFKZdYWMexJc
	u+/Bbvq3l4m7xvYzeq0/zckt0gKR6WhJyzFQ==
X-Google-Smtp-Source: AGHT+IGKEH0qbP0pqItWHnoLxpFRdre+rzDAc2hGtprvrPc2rCt/sYGW1bRV9AA8f/OJxj63588tUIw+BujWHL/MACU=
X-Received: by 2002:ad4:5941:0:b0:6e6:646e:a0f0 with SMTP id
 6a1803df08f44-6f8b07f3177mr92768776d6.12.1747474376584; Sat, 17 May 2025
 02:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516190631.1214081-1-rmoar@google.com>
In-Reply-To: <20250516190631.1214081-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 17 May 2025 17:32:42 +0800
X-Gm-Features: AX0GCFvcQPxSpA-Log_OfA3_WtgU6RmyiSaFNEhUIKbtXuY16QbAyvTiCFcB3XU
Message-ID: <CABVgOSnFhWaFmWF19pX4nWng-P3+urYu1OZwnng5z8sdX1rHQw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: improve example on testing static functions
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, skhan@linuxfoundation.org, dlatypov@google.com, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000080768206355195dc"

--00000000000080768206355195dc
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 May 2025 at 03:06, Rae Moar <rmoar@google.com> wrote:
>
> The documentation on testing static functions using the KUnit macros
> VISIBLE_IF_KUNIT and EXPORT_SYMBOL_IF_KUNIT is lacking clarity and
> missing key steps in the example. This has caused bugs and confusion
> among developers.
>
> Improve wording of description and add missing steps to the example.
> This entails adding the "#include <kunit/visibility.h>" line and the
> "MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);" line. Both of which were
> missing from the original example and key to exposing static functions.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

It's always great to have better documentation!

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David

>  Documentation/dev-tools/kunit/usage.rst | 38 +++++++++++++++++++------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 22955d56b379..038f480074fd 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -670,28 +670,50 @@ with ``kunit_remove_action``.
>  Testing Static Functions
>  ------------------------
>
> -If we do not want to expose functions or variables for testing, one option is to
> -conditionally export the used symbol. For example:
> +If you want to test static functions without exposing those functions outside of
> +testing, one option is conditionally export the symbol. When KUnit is enabled,
> +the symbol is exposed but remains static otherwise. To use this method, follow
> +the template below.
>
>  .. code-block:: c
>
> -       /* In my_file.c */
> +       /* In the file containing functions to test "my_file.c" */
>
> -       VISIBLE_IF_KUNIT int do_interesting_thing();
> +       #include <kunit/visibility.h>
> +       #include <my_file.h>
> +       ...
> +       VISIBLE_IF_KUNIT int do_interesting_thing()
> +       {
> +       ...
> +       }
>         EXPORT_SYMBOL_IF_KUNIT(do_interesting_thing);
>
> -       /* In my_file.h */
> +       /* In the header file "my_file.h" */
>
>         #if IS_ENABLED(CONFIG_KUNIT)
>                 int do_interesting_thing(void);
>         #endif
>
> -Alternatively, you could conditionally ``#include`` the test file at the end of
> -your .c file. For example:
> +       /* In the KUnit test file "my_file_test.c" */
> +
> +       #include <kunit/visibility.h>
> +       #include <my_file.h>
> +       ...
> +       MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
> +       ...
> +       // Use do_interesting_thing() in tests
> +
> +For a full example, see this `patch <https://lore.kernel.org/all/20221207014024.340230-3-rmoar@google.com/>`_
> +where a test is modified to conditionally expose static functions for testing
> +using the macros above.
> +
> +As an **alternative** to the method above, you could conditionally ``#include``
> +the test file at the end of your .c file. This is not recommended but works
> +if needed. For example:
>
>  .. code-block:: c
>
> -       /* In my_file.c */
> +       /* In "my_file.c" */
>
>         static int do_interesting_thing();
>
>
> base-commit: c2493384e8110d5a4792fff4b9d46e47b78ea10a
> --
> 2.49.0.1101.gccaa498523-goog
>

--00000000000080768206355195dc
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgqpW4CBuOqcu4+H1EHHNAut5gEOdw
3xcfgV0+MAZjaoQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTE3MDkzMjU3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEATNei9ImqELP+s9pWtj7EJwPR4Ds46W44b5v200hssGTLMKMc8dYjT+cgT6d0nakd
7T9pHvevmkY8z15qr6eql2LfQsTDuvW0bs4K3qFyfFR8wt7vPQ/fBU381Q5O2JfSSkpQsmOMoPkI
mAVhJXwJN5RgXYbiMsRTmyZBa5CQEO7aRetzSJVRiyU4BGH/FodNRuC5Wamji2TcStUFRRrvHPUg
LWYkkS6/fUW6vQ+Nwx03sGA1UURvQWAhc2Y3eIPjuPqfe5VwTlhNbR4skR/ljVcYxsqKhZyHTRcP
Uk2KBD46kYb7ibgFNH8N3rVvb0Cv2yaygSvi5WXdc3OJCyVweg==
--00000000000080768206355195dc--

