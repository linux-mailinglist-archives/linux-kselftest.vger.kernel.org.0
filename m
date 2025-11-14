Return-Path: <linux-kselftest+bounces-45603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF8C5B0E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 04:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AFB3A3F68
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 03:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8690225A38;
	Fri, 14 Nov 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3y1FdhG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E623D7C4
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089340; cv=none; b=d4P7MOtKrrVh0ZYqAsRtOzlLdHhlEVpg27Z+StqEo9iTGPnNBBiqP562DwToZUpHBEUkUpE/w2VIEwWXHMa/Wcn6iY4x2ng/uv1IZqrSx/tJFMG6n0peS2X7j+cSkgRyngxuLpYxDZfgT1ZkO/YzGWWT4QzOWwlbCCnCMHaBoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089340; c=relaxed/simple;
	bh=vJeehSBHuz6A8C1ZUxbAu9WXDe8+OD8Re77G68OIBbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PapZyCl15CYvZU4+0dmXKiAJCruVJXbC+MOiR4HixWIXvOEs4TkeoVi1zhIoM24OLA4KPubbTC6zCcxJv06uCYxhrqmTbKls8WdRZQcrvJCVZMsZttkkmfee2Sj1B8ySsIRGIMrdNcDS0L0QNnUEx158/SBujpGqEgB+Dr7JysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3y1FdhG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8823e39c581so18803496d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 19:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763089338; x=1763694138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIO2cS4o+tQCkNiY+vNeI0z+NxcLRk0oVZpiye9XTWU=;
        b=M3y1FdhGfg8X4aQg6gMFEU41JzWzzBd1V3TkFZMPVyeWfUfUYhf7R+iUCuMOqaW8GY
         e0FlzwDSH7RVNyXrVL/zT3mOj5q4K9MYDydMKzHvlsCkY4QAqCCZXlYbALNsz12vqSMi
         8YAzcS9L6N7l15Gb56ko2pHlds603X/G6hJwPBlncWoxEXe7ZR/vylAc5erdml5qavUr
         tkmBnldl9zrwoT09j9lPV1SpZSEbcw89OyKyqSQoVI5HrA5pR+r5pGThwtnd0oHGbRiz
         CzRcH5YrWLU6NuneEmEqRJ+BGnFptQ45z2/Yg4nf6X9CEMiPNceXmTRfUlg08+3y8c0E
         /dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763089338; x=1763694138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIO2cS4o+tQCkNiY+vNeI0z+NxcLRk0oVZpiye9XTWU=;
        b=k0kw5ipzNwx3p0Za8IEunx+yKfwfeS7VDoh//xOo+8tlIUPyCJLoqXQUd8lcUcAbm+
         /mtA/4fhdUaA69PT194ZZKASHh8GZu5hHRxvo7TM4xo2+hQI642jb4vvhw+fHIsS7SAo
         04b4AB4cGLYOTfokLftYqvGSXW+NRpG5GjP6W76gI2sOsiCBPubR8vXe/zw5/ZHWkhB9
         cNpqjfOGgufqIER6Tu7r2qCeBQ0QZQhpEO+Wd5RWqaCZSdWuOhWiG3u70wp7EHbAq0fd
         7fWPLN1/3h1FM9uusXDrOo5XIoIG03WD8IQB+W1e6PEVDv/TvzNaFLAg2pqc39GaBex3
         HAiw==
X-Forwarded-Encrypted: i=1; AJvYcCUHcrade2l/G2deZZAW7upNHf/cshJN35gT3DoUjtGYalyv6SBquc3CWH1mimEgqS/czUCJgSm5iU2dx//Qwcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00GWnd7kZ8TKNuzgGPHqm0fvmU+A8ckS+qzVY9B1HqQuG4N4+
	rW6Xf17WK0xXhLqJAxme4dm/vSP44oUtKFgLQEE2pAQWUBtsszCus+wOTKpCjTgSafe7LzOu+wP
	KuC877P+jBD/jRHHgzaWUPE5OqObcVJWWcxY+STqb+p8/FBCzlCxzDxGO
X-Gm-Gg: ASbGncvm75fhiXaro0HBJUPWpGtc1pPD1qxh9KreCnSfROATuiV0gQz9AJOLzjY8b5D
	0ChvDXJsszM3t1r6LydvMeiA2ldyEbKed288M0Qw3fQadBJ8GhqCpi8QDoeWhQHTJiWitqIQKFa
	AsjaMXXYTLdPBQkzYYmqGK+gnQGFdw1w3Zu38Jipg/4K+Tf7oNmLlZPaSrSP4Uob8xzlnHZeTU4
	sU0INCHA5cZwl1mVC4SISpE/NptyahWCtWdfNklgBaKkU8bXNJE1wg5yuQJoqhTTBLSFg==
X-Google-Smtp-Source: AGHT+IFvp1AKDv+CGISWS67MhHbkV7Pl2rdoGvfF5NJEasYAxV/vxP2gbJpYWb+f/rBFL2WdCQaKcvqVex6R292KstM=
X-Received: by 2002:a05:6214:ccd:b0:87c:836:8f21 with SMTP id
 6a1803df08f44-882926012c6mr22780256d6.21.1763089337440; Thu, 13 Nov 2025
 19:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-kunit-filter-kconfig-v1-1-d723fb7ac221@linutronix.de>
In-Reply-To: <20251106-kunit-filter-kconfig-v1-1-d723fb7ac221@linutronix.de>
From: David Gow <davidgow@google.com>
Date: Fri, 14 Nov 2025 11:02:06 +0800
X-Gm-Features: AWmQ_bksRYvCZCDPnDL7gXx9x2gwvGVw9iF29YxGSHLoUKgpQCGyn7ltSjKWPSc
Message-ID: <CABVgOSnSGkkcWJVS3t8=Tp1UbtpqdVV1LDvZczWUrneVCtja-g@mail.gmail.com>
Subject: Re: [PATCH] kunit: Make filter parameters configurable via Kconfig
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b40aa706438539a2"

--000000000000b40aa706438539a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Nov 2025 at 18:32, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Enable the preset of filter parameters from kconfig options, similar to
> how other KUnit configuration parameters are handled already.
> This is useful to run a subset of tests even if the cmdline is not
> readily modifyable.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Thanks. Do you think it'd make sense to also add one of these for
kunit.action (i.e., support for listing tests/test attributes)?

Otherwise, other than maybe the possibility of adding some detail to
the help texts (though that'd just duplicate what's in the
documentation for those module parameters), this looks good. We can
always add more in a follow-up if it's useful.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/Kconfig    | 24 ++++++++++++++++++++++++
>  lib/kunit/executor.c |  8 +++++---
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 7a6af361d2fc6276b9667be8c694b0c80e33c1e8..50ecf55d2b9c8a82f2aff7a0b=
4156bd6179b0a2f 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -93,6 +93,30 @@ config KUNIT_AUTORUN_ENABLED
>           In most cases this should be left as Y. Only if additional opt-=
in
>           behavior is needed should this be set to N.
>
> +config KUNIT_DEFAULT_FILTER_GLOB
> +       string "Default value of the filter_glob module parameter"
> +       help
> +         Sets the default value of kunit.filter_glob. If set to a non-em=
pty
> +         string only matching tests are executed.
> +
> +         If unsure, leave empty so all tests are executed.
> +
> +config KUNIT_DEFAULT_FILTER
> +       string "Default value of the filter module parameter"
> +       help
> +         Sets the default value of kunit.filter. If set to a non-empty
> +         string only matching tests are executed.
> +
> +         If unsure, leave empty so all tests are executed.
> +
> +config KUNIT_DEFAULT_FILTER_ACTION
> +       string "Default value of the filter_action module parameter"
> +       help
> +         Sets the default value of kunit.filter_action. If set to a non-=
empty
> +         string only matching tests are executed.
> +
> +         If unsure, leave empty so all tests are executed.
> +
>  config KUNIT_DEFAULT_TIMEOUT
>         int "Default value of the timeout module parameter"
>         default 300
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 0061d4c7e35170634a3c1d1cff7179037fb8ba07..02ff380ab7938cfac2be3f8c0=
e7630a78961cc3d 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -45,9 +45,11 @@ bool kunit_autorun(void)
>         return autorun_param;
>  }
>
> -static char *filter_glob_param;
> -static char *filter_param;
> -static char *filter_action_param;
> +#define PARAM_FROM_CONFIG(config) (config[0] ? config : NULL)
> +
> +static char *filter_glob_param =3D PARAM_FROM_CONFIG(CONFIG_KUNIT_DEFAUL=
T_FILTER_GLOB);
> +static char *filter_param =3D PARAM_FROM_CONFIG(CONFIG_KUNIT_DEFAULT_FIL=
TER);
> +static char *filter_action_param =3D PARAM_FROM_CONFIG(CONFIG_KUNIT_DEFA=
ULT_FILTER_ACTION);
>
>  module_param_named(filter_glob, filter_glob_param, charp, 0600);
>  MODULE_PARM_DESC(filter_glob,
>
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251106-kunit-filter-kconfig-f08998936fc6
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

--000000000000b40aa706438539a2
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg6eh90FRDSDDmxpgS4D+ZaqZBaKl3
ArVGKXCX1cP9v5wwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MTE0MDMwMjE4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAKIEVV1Dcw5l3F/OTmhhXzhDPaHwoSvF0Bvq5Rr47TSISy/XI/GQeRLye/cesl5Kf
JKgtTwb9Czh2CXvApjTLZG/Yvn2LUHxcYwcbUrjI98WGPoDgW/K2Obq53ojpma9vrk45HTgv/a3T
/++Zpo0r4TchSy+e02SugSGBdmDRv3x6sPuDiuTXRiEDVqMxCBNgnBUW532CAoi7/DHYZokR1vW8
ZfUP4E/azhkIFA7fwCIZMYOgD3WUpQj+NqQqv4LFf/tSPwT3a812793y++Vr8imFfDFNTxSzwdYF
g8J5GXBVHF2p5VQGfQfNNf7AwVFXyFl7WlbDTBDjb25qrhPj6A==
--000000000000b40aa706438539a2--

