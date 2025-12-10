Return-Path: <linux-kselftest+bounces-47359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A348CB26DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A5AB302C6FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1113064BC;
	Wed, 10 Dec 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SResvsgU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A025305E33
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355681; cv=none; b=GruRDINfnLzz4udr5mgipvxivOaCXG+G0lkxz5jiI6pCobm+mQtkH3gSrDAfDpdLTssk7RsHxnmtGz6EXAg45h14vfUQerVMaHV7bg6bK306774D4cEdvZM3H+z9jDILsl2dFbC2++ahRw8wnMXPe3C+F/PYcS30GFkuWedn9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355681; c=relaxed/simple;
	bh=RHvrsrWcyylwe+xLqnVAmjnYchzZgXCNoS2iZU6aQto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDhkJdwGLBW6alrV1HUWdMjo0LsG2NGz9qYMQJlP2UUVGF8r/1FHGYupoP/cVKT7fPg5re78QNTKGjuDzHO4c0sZO7nQsVhN7EktQzq4Am9B/FhFKK73R3vvMYxDu8arD8Y8qYU2SP/a2mdx/o4aDJPa+/KEeogGgXLqouoUPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SResvsgU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so245685f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 00:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765355678; x=1765960478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ecDQP5UFpSNvoyJTbQpPTI2PfL6urIbtvtsJ5wdzHQI=;
        b=SResvsgU5M/qDn6GWbux5FOQ4e6ujb6jXvIrRrEqMea4b6WOJLtzjLA6H9fQugw8/5
         KUvywoyzaLYkQPNjflSUuVSZvGEsNoLny8+MPjakYy3dYSmKhYgGzVRczYDw2vqlgrpO
         FAqQ/a8i8DRbSVQam2lJc97Fdziq5a9u1/h+3wQZTWmSsaI4o0b8u9cs3ABY1flf9X9j
         DJP3CnHymFlkCt3w/9izj7KEL3jsDFfzt+VYp34nPcMGtcfYegnMG/RWql8yrmPf6ZlW
         4SfpzzhsUtS8rJJUVhgynKGLyi6bw0EsBJOZ3xK2ewdbwOnjYC6TbKzJDtlnTPIqP6mW
         CUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765355678; x=1765960478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecDQP5UFpSNvoyJTbQpPTI2PfL6urIbtvtsJ5wdzHQI=;
        b=vWb1F0iInyYWIRvD+o+x0GgW5L4gycrNhA2bfo6KWqm3DveZ+EY2KMypPVYWv0klgZ
         +/d3ZnUhGMA4Q5FVhuMC9EO5SAzpp/d3vno8rAnXErOBQAQP1gnoi0wt7QWZHRxSyUas
         tkrYNaCGCuzZoXBxdGmRvHiXQ3RvTZ2L+qtpDGYTC5maJpyWTRP3PuUEckQaVhYsXjNn
         p0EV67ew5q335grvPyPMldFU1TIjE+CVchkW1MT2Ok++po6FtdvlV04mWW4r2SM2W3Kq
         CmmPseYOkb77qGBqR/Zi+JTqgWOysABnQveMkWqY77tUNv1DL+UGdLdtIeiuIAIrAhQb
         Qxgw==
X-Forwarded-Encrypted: i=1; AJvYcCWpRhfhNAuHXirh+CnWZQalk+eoWNVt+EiU19oxFGJVG4D8pVOjVLMaL+voDI6Ppp/yZ+UMLt4bO0N0niOIssc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0k/fGcVUnJBj3TXGw8kngP1UwujJFgxfIOCyFLFi5AvPCGS6
	1WU9sZGBiGNMLY/qPUGHw8DkucHYOfrCwLY+txSJZ/S0tdXO0JlG2ZLrI+kuXfiOskxEKMUEKJ1
	UbtVrsENL8SQGWsLkdQBt6HD3M29iHnfIxliqvb4Y
X-Gm-Gg: AY/fxX6jGl1ZXivlvRjMuWwpYD0tQhsdewOlwhzYzAAzYoYJzxga7p/MzSiUUhn6iLS
	YM/EjBsNJpVwYZGeiVBknbWb7b2FhS5cp9D4x1v7rU30njcSiUcjA/Rl7Qzq1lYKJqgqBgvI9L4
	LY3mbwlx3HGl9h+ogNSdnZplPi/c5sL26TuDqu2Ttm2Z6WVaAtqV0oN7wcSuuYpmkIVdUlpHVk9
	kMz3C00PKvLq9peF6OPqVXoIu75HAhWbTEu14Krxyj1iZHXxBWDftwxxTzuUTkatcRW9w==
X-Google-Smtp-Source: AGHT+IGPnCjgUlSUSVFTyqvj23OqOfsm6WT+NtcKqtAXKlXxOR0kV7W5zfkTcHu/JZmp+56NdVX+0khJ7VPUsYIABlA=
X-Received: by 2002:a5d:5885:0:b0:42b:48bc:498f with SMTP id
 ffacd0b85a97d-42fa39d88c6mr1398358f8f.14.1765355677549; Wed, 10 Dec 2025
 00:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210065839.482608-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20251210065839.482608-2-u.kleine-koenig@baylibre.com>
From: David Gow <davidgow@google.com>
Date: Wed, 10 Dec 2025 16:34:25 +0800
X-Gm-Features: AQt7F2ooG0JQlzhD3AAcO5ZOQr8VcHPRywPf3z9GphVo6rwB3e8xgP2zsPTpn-I
Message-ID: <CABVgOSkvCHAGUoU1EuT+_v=cjGkb22nqNrPbZ2a8EyUGePbVvQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Drop unused parameter from kunit_device_register_internal
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000018ed6c064594e6fa"

--00000000000018ed6c064594e6fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Dec 2025 at 14:58, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> The passed driver isn't used, so just drop this parameter.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Nice catch, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/device.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 520c1fccee8a..f201aaacd4cf 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -106,8 +106,7 @@ EXPORT_SYMBOL_GPL(kunit_driver_create);
>
>  /* Helper which creates a kunit_device, attaches it to the kunit_bus*/
>  static struct kunit_device *kunit_device_register_internal(struct kunit =
*test,
> -                                                          const char *na=
me,
> -                                                          const struct d=
evice_driver *drv)
> +                                                          const char *na=
me)
>  {
>         struct kunit_device *kunit_dev;
>         int err =3D -ENOMEM;
> @@ -150,7 +149,7 @@ struct device *kunit_device_register_with_driver(stru=
ct kunit *test,
>                                                  const char *name,
>                                                  const struct device_driv=
er *drv)
>  {
> -       struct kunit_device *kunit_dev =3D kunit_device_register_internal=
(test, name, drv);
> +       struct kunit_device *kunit_dev =3D kunit_device_register_internal=
(test, name);
>
>         if (IS_ERR_OR_NULL(kunit_dev))
>                 return ERR_CAST(kunit_dev);
> @@ -172,7 +171,7 @@ struct device *kunit_device_register(struct kunit *te=
st, const char *name)
>         if (IS_ERR(drv))
>                 return ERR_CAST(drv);
>
> -       dev =3D kunit_device_register_internal(test, name, drv);
> +       dev =3D kunit_device_register_internal(test, name);
>         if (IS_ERR(dev)) {
>                 kunit_release_action(test, driver_unregister_wrapper, (vo=
id *)drv);
>                 return ERR_CAST(dev);
>
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> --
> 2.47.3
>

--00000000000018ed6c064594e6fa
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgHRMWskDMZWWRAkPVzjQCb54TfhWS
WK8KPoqgIGwpMfQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjEwMDgzNDM4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAPAf7HZ7dwCq+u2gnOGNddVhBQMT/kIOvwgTjYXZE8tCFFGnb+AxVNddoxi6bcFDR
0ChhXU5ZYnuKDNUqtw8b5ggcZ5gKMIvZ0tPzwPgufRrWlcnPowGRRdWasMyMXFmAhO3FsKIuxuMr
uPTJ7tLuF0RT0HJ+ASfGAGkX/9R1mwhv2mXMZVw9cKtdmpWknw0ATkq0EFYIDQmb0XQsyo1vJm2g
qo3vaD1hcwnFkoHrStR8snxeJo+Y+S8XZjqN5orRglpdleftaIoZZ4IujpQnVwmPTUyZcYsw3suv
Fo9iX34AoImpydGfc6nmt107IFyw7KZazN4rd9RfUvTGRM77fg==
--00000000000018ed6c064594e6fa--

