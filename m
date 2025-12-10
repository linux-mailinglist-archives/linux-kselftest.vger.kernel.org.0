Return-Path: <linux-kselftest+bounces-47358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C0CB2608
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6AA3310775E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EB52F6929;
	Wed, 10 Dec 2025 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ub0yfOCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC71CAA79
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354604; cv=none; b=gkWXJKTd0nUPFRbnTQb9ZH7aYX7qtnCRUB9TByeP2aax9tL3o6z3tNBe3Ul2XNNJevz9eYmXGYilM6gIVmQlC7UoOFUGBpRcsD3xfPXjp1m4PIqwOkpxOOe71VG4BHgRKHZMFM9xv/F5eJ+/gjljcjxAfNnbernrcAffTfdXpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354604; c=relaxed/simple;
	bh=V2//ytG3Cwp2ls9ZjuwE2VtSd21LkdDgwsTl1xUbM0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAa8JA8ChaB3nWkIg2dlnlcLQngdrczO83kLKzw/NG6K/g7e3ikidBHfjFNwrMXJTr0JQBeNCXuo9pO+4qiAZVPBG+Ddr8W2oA5oi0rcVZvi48+aO6XIo6SWV9msk+G3w3bDr2bmSn9hCR0GJBA3LvVsNVoExlC1R9TsdXWDdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ub0yfOCZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso2727044f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Dec 2025 00:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765354600; x=1765959400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ/m3BJUKbHBBuxsoCxrEjyrPjXuXZ4jT+lwzS9/qfk=;
        b=Ub0yfOCZT2g6kCgzP2pqyG5/56HVCF1zZt9dwA/JW8jC2DPSpvjG5pai0BO1OEhvqp
         4urD2N+T3ZdXDjXaxUh4A5FdG2NQUGQtG6yS1bHFpfL3PDCnBT1r6BnD80pGv23WgLwQ
         br1HXBs7tIB0x8rup5RxDLMMWq0270zimyvtNgSkCBwt2BZ016PFCL2ikwJCt6n0rxI3
         FZTbS4ocyQbMYondfRtIGwIenyumDQUWr0HHNtGxGztIN3F9CqQjQHDNW0KcHsc8gu26
         XCd3UEMKNbV2tad+tfPOKZEo5xmyrun5xn1rFMqUyX8sIbC5Xf85AMBI/wuG+QH2F80w
         vqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765354600; x=1765959400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ/m3BJUKbHBBuxsoCxrEjyrPjXuXZ4jT+lwzS9/qfk=;
        b=vYKYe1Q/ZnMmgkwtLjqC5j6VvQaqNcK5Ijn16GofFWtqHESonRrM9eGUBqya06YRh9
         7QKUdFcVHVMc0M5hTxk494/ATGYr+4Pd9vprcMuFIatFMrwxwxhmR/gPJcXYYMnnaV38
         +RnSdB9Ha5nmc1sVJmVKCoQTaqzM6dSz9dthiaEQx89x5ooBcJGIHdRsed9/tnFSxdg5
         L7Rexn7wkSVcnFIbvTVaUjR6J9MtfQci22Um4fDVmbgVDTendWmxksiKdKtDiVEVklvy
         2y9X35/VL1g7X9Jq4dQTkkNVb4/HneZODYbKMvUq+CouSgyQWjMK7N4lKvpW+0F74xK7
         CdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ9MRWL//xYGQF2TscZLbfjdOxvyegMQy5XBeiDA5uUDi5A+yBes6gNyrGioPOj392+UoMRQ4CHBcDz+cCl8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/64a2MaLKvI86iIpidHBLkpyDUkj/awyd3PfvmKMNC9GL0NJ
	DCO5xFuiMrB3zoXnPc+D/a8gTeDAUA+Uvgjp0QUEiu4B4W8+PuH+acRNPnVjdns2rTYwDXSMwCp
	Vx3xQPXpa7zhTzEDKskUTnL/29CxheBR7qZQECb3G
X-Gm-Gg: AY/fxX7i85Clnek5zBYRtlIfpopSKaq4axesLofS7tkSyxSCwFhdsPu1SZ8J6Sus38R
	+NkFu6Nkkdg7Bpd7DmFJOLhECTyogtzlEwWkrI/gysjmVxc9Cdkk4KQ450TOUN/IpDhGwGZ2rSN
	+xE2Zzxrj13It46fxuewqwhdKEny8OBwF+DR1qbJgooaaY7fn7xTz96i6/AnzSi1P6SHufmtHvF
	d3R8er8nli7RahIm8zvTn2Bxu1twga0zOstvmCpCNo8WAm7ONqyZ+P+uGaRey5Rv6VnGw==
X-Google-Smtp-Source: AGHT+IGHTfR6FJzxh4u1KiikW2gylhAqcPko2jrRdkbVRz0rvoIeLXPXOnXPm4MF/urTeZLPFpZFndb9zCgKv6wkv38=
X-Received: by 2002:a05:6000:4282:b0:42b:47da:c318 with SMTP id
 ffacd0b85a97d-42fa3b18a0fmr1448855f8f.52.1765354599388; Wed, 10 Dec 2025
 00:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207-kunit-fault-no-panic-v1-1-2ac932f26864@google.com>
In-Reply-To: <20251207-kunit-fault-no-panic-v1-1-2ac932f26864@google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 10 Dec 2025 16:16:26 +0800
X-Gm-Features: AQt7F2owZGiC2ba9U6BEily85xRK6mWJ01rUgF8Ya6xSZV9hbWuIbKvBfYUCQm8
Message-ID: <CABVgOSk4bBLXsB455u-2gBhDKuU=czVNLax0ep2gHw_ajVbE=Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: make FAULT_TEST default to n when PANIC_ON_OOPS
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d6a217064594a5b0"

--000000000000d6a217064594a5b0
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Dec 2025 at 10:17, Brendan Jackman <jackmanb@google.com> wrote:
>
> As describe in the help string, the user might want to disable these
> tests if they don't like to see stacktraces/BUG etc in their kernel log.
>
> However, if they enable PANIC_ON_OOPS, these tests also crash the
> machine, which it's safe to assume _almost_ nobody wants.
>
> One might argue that _absolutely_ nobody ever wants their kernel to
> crash so this should just be a hard dependency instead of a default.
> However, since this is rather special code that's anyway concerned with
> deliberately doing "bad" things, the normal rules don't seem to apply,
> hence prefer flexibility and allow users to set up a crashing Kconfig if
> they so choose.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

I like this compromise: I think there are still some cases where we
would want PANIC_ON_OOPS + faulting tests, particularly if you're
splitting the test execution over several boots (e.g. --run_isolated),
but it's got to be vanishingly rare.

So this is an excellent default.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 50ecf55d2b9c8a82f2aff7a0b4156bd6179b0a2f..498cc51e493dc9a819e012b8082fb765f25512b9 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -28,7 +28,7 @@ config KUNIT_FAULT_TEST
>         bool "Enable KUnit tests which print BUG stacktraces"
>         depends on KUNIT_TEST
>         depends on !UML
> -       default y
> +       default !PANIC_ON_OOPS
>         help
>           Enables fault handling tests for the KUnit framework. These tests may
>           trigger a kernel BUG(), and the associated stack trace, even when they
>
> ---
> base-commit: 7bc16e72ddb993d706f698c2f6cee694e485f557
> change-id: 20251207-kunit-fault-no-panic-e9bdce848031
>
> Best regards,
> --
> Brendan Jackman <jackmanb@google.com>
>

--000000000000d6a217064594a5b0
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgrFSa18vg/9gRKbnMYpKRJ5/CHM/Q
g+xRmig4N1FitfQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MjEwMDgxNjQwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAVOXwzlxmGZkOSwjjV465xVsjpM8lGhUhcjs8CNVHR5hXo7NqEVzYtEMnvhn6wtD3
ItvgAK2HwABH2MXYy41AY9NMM9eprvijZJ7xgBXbQtmGbCzpueMIhJjwdC/OTlHHncoOy+5wiMBp
7ralPXA2RTOo/6R7pWIk0Q7PXuB5U6fAHvKAuJ/FvQlC3adSlDPpsmJeApgF2eyPuZoW5kCB8EQK
gPbBTnW20l1BfCmdxqeOhhDXtak3704pXYxvCgcN3OZItckgnaVapis+07Lvo/doZS8T3AhBwlCw
BQu99TE3jmxSwNvAauoH/15YTinLPlnBHtan7lz8h1bp628evQ==
--000000000000d6a217064594a5b0--

