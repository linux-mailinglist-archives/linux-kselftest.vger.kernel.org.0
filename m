Return-Path: <linux-kselftest+bounces-43362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D5BE65ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 07:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A271A61565
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 05:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADFF30C623;
	Fri, 17 Oct 2025 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wq8WGHSI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E23FCC
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760677729; cv=none; b=aAx+LIdtxcsyOQfd9NeQiT52MxPTosuWfCtt81qzHSCMnQ7tQI7/UJOfA3ZA8wbCP2BkiTA8MXJxNteOSYBzsu9ZrSfQmajzhpoLCrxQfVwCSQ2YLpUNowCk0TDleQeIISy/ggFxA3jf5jlOsXPJSFos45yHITnFHJ5uerJfa/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760677729; c=relaxed/simple;
	bh=y59cnQPTRy7bb+pPER5IS/Gj58vBP5lztJ97F7q6zSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLlw/fZ5tt7gI0YDPAs54cLGZ9LfX1T3kQAy+GuEh6jmQxoT8rf2lZ07LiT9Rps1KrCoOtPynUN/y823NeFMkcXOSUykJYQEj9/Kgi/l7EAU4Ec7rI1K1t2NIzTbS0gd9r741reZ3NW4LfynuMU6HPaoAk3Uy2dlH9GvQepcuts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wq8WGHSI; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7946137e7a2so27740676d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760677725; x=1761282525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wW8TQ5LJ4r58AlMlZJVYj7Ohc+3l1zkjbpxgtI/NbG0=;
        b=wq8WGHSII1AeimwxYvWps528aYKQLNd3J6wX3RTnlCexccain/djuofqF+YpboLTY1
         D9p+KDfbJ9BHmxPOU6GIVscebf4zUoIrmZdSofSBXiJzGV1o31jo91Ts9FYAFv0V6ymJ
         W9Tqlh+f1kVOSbYS2w8V8znaw8vKkn107qS17EIlKXOkf3iVOkKxf7nha3lHitFNrOg7
         SrnPgRBH5WkpayyDogviHXX/E9/diA2f9Sci6hQrcgQO1kmOveVGobuNuCCz4dXEsGH8
         sGi0gebuWVyt2NpPlTUaTUn4p1LumdOFz0edDEevqp5TMOSTe1+A/Dj2njVeONVCdl+W
         Puuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760677725; x=1761282525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW8TQ5LJ4r58AlMlZJVYj7Ohc+3l1zkjbpxgtI/NbG0=;
        b=Wlwo5aCVoPLs0z9BLlBtyNAhnqbz/5+0YM2TLR/3tKPIoArVuy/9ZMNNCC5Pfys7F6
         +dDypPLdEvIuimUcLYuyiKcr+iMWyZQnjRiAxP652U7eBboAo10UB3xTMNgqB+6VpcvI
         nyna/lehNCl5wyd3zV1y0FZpjZ0s9E7ORkQlSKKlJKODgvzhWE2YB6jjiYHraIkAdmmy
         npbxW2jiykYEvOvJ1IpO7yRjXKKy5CEuS2pR7W8usYCl02ugDJ+lrSHloK3vOE4gm94N
         +tIkEawCF9iFm1Sad9CHZCXw9X7hd+16rzFFUGlsnBN0jolsRMjFPpDPLI65ryFEPu9H
         vvJg==
X-Forwarded-Encrypted: i=1; AJvYcCVArvwVyxKoUHGfu9KoVb5SmRKcIgxtPeHKRlLur35+eXcuHMhg6xcKc/ydcAWw989LuTbYAO7ibMfvHCVhxI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6I/jpuyejcsTJF5zZy2fbdJ1I2+MUvkGhtDmGlk71LKUZrxwl
	0mQeyi+gRxc8CP2oWNw7S7REV5Z9d6Ye2FupBVRA78MVKQNjUWnaxoNVAraJX5CGFokMZ6w7/iL
	cgtIw+lEVGgyPuXxC2H+n91o3QJ2KyBeAXt2LM/JE
X-Gm-Gg: ASbGnctZPPj3isoIEtneukNK2+laj99fhHpGJd0rhMZuW++sjteNUikaw3nh+LgyUXh
	VfQohgBLENwYC7u0VHSsTP2QbND1qUjEZaNwRIvaJmd1Z8caGaTBMF17HRhCGTH28VXUQV4V7RS
	l1u2EBpT9/6+D/LrXcNyrHksz+KBLp0wq1DECFU7+YeF3HiQk/1XhJN+XlwYZUHxaSEAQsh0unX
	+S/Dc+HZf1V7fNhXGTmJt5w+jX6xwnxpZLxXKjXj2hFdESa3WX05fMwm7G97vaBREsHWQ==
X-Google-Smtp-Source: AGHT+IH6vQqYt44bSxBxmYZfhlQmqGOrwd0vVEKhCgYdSQmmoAQYeY6NBZZttnTdblWSnj7PPcdZ2efTpRMMfXnWxm4=
X-Received: by 2002:a05:6214:4010:b0:87c:19fa:b083 with SMTP id
 6a1803df08f44-87c2056a832mr45758046d6.8.1760677725028; Thu, 16 Oct 2025
 22:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015072303.81266-1-florian.schmaus@codasip.com>
In-Reply-To: <20251015072303.81266-1-florian.schmaus@codasip.com>
From: David Gow <davidgow@google.com>
Date: Fri, 17 Oct 2025 13:08:32 +0800
X-Gm-Features: AS18NWAgHYL-DGdIe1-BOLOairJlilmnnAdW5eA8TN9bz-NddRGgwa1jN_2xPRM
Message-ID: <CABVgOSmpBnHLjmkhnnBoM9OJrexTs9Lhe-bkspu+vj1NYMUNLQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: test_dev_action: Correctly cast 'priv' pointer to long*
To: Florian Schmaus <florian.schmaus@codasip.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000065e3ea064153baca"

--00000000000065e3ea064153baca
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 15:23, Florian Schmaus
<florian.schmaus@codasip.com> wrote:
>
> The previous implementation incorrectly assumed the original type of
> 'priv' was void**, leading to an unnecessary and misleading
> cast. Correct the cast of the 'priv' pointer in test_dev_action() to
> its actual type, long*, removing an unnecessary cast.
>
> As an additional benefit, this fixes an out-of-bounds CHERI fault on
> hardware with architectural capabilities. The original implementation
> tried to store a capability-sized pointer using the 'priv'
> pointer. However, the 'priv' pointer's capability only granted access
> to the memory region of its original long type, leading to a bounds
> violation since the size of a long is smaller than the size of a
> capability. This change ensures that the pointer usage respects the
> capabilities' bounds.
>
> Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
> ---

Thanks for this.

One simple formatting issue below, otherwise this is fine.

Also, it'd be good to add a 'Fixes' tag:
Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/kunit-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 8c01eabd4eaf..957b67818489 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -739,7 +739,7 @@ static struct kunit_case kunit_current_test_cases[] = {
>
>  static void test_dev_action(void *priv)
>  {
> -       *(void **)priv = (void *)1;
> +       *(long*)priv = 1;

checkpatch whinges here:
ERROR: "(foo*)" should be "(foo *)"
#39: FILE: lib/kunit/kunit-test.c:742:
+       *(long*)priv = 1;


>  }
>
>  static void kunit_device_test(struct kunit *test)
> --
> 2.51.0
>

--00000000000065e3ea064153baca
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
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgORsYRllpy8TAQ0GE0Fec4iKS63Id
3hd5uA4l1qtEH3wwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MDE3MDUwODQ1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAhefg4Jq/n1rnZOvegpgJSfgLrwDkOuFt6/vWl4cX0y4EopWKEH9Rgf2t9CAW6OcC
ccMfuoncP4+qLHrfkfOZjyMIqHFFYqg8eRm0JDXWmaxWVpn8cmOwXME+X9diLbIvlgCbno5S90c2
QccScVVzKP6Vntvd8WPR1CfhbuCZXZkP1dKt8O/gJgEjDYLOgLXT9/E6bdyyZ+V7KUNlgr/SzErQ
AlkI3n/fLL21yOhocBmoGV+YfszVV1etfBellaRJeDVT0NNJOOVyOh5nsna3KNjl1gdSGXPVa2rL
cwiPQQGGKBkZvaWnvL1+F0HFNkzMhAOCk6ZvSOJm5KYUf1aTTg==
--00000000000065e3ea064153baca--

