Return-Path: <linux-kselftest+bounces-28873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB1A5E7B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 23:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950761899A78
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC521F0E56;
	Wed, 12 Mar 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="topcg582"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D771F0E45
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819937; cv=none; b=L9VGyraMqCEpq+4uRJC/uH7I+m+0L8F6yANmr2pRScGcNMwjLQIE8x3hKIdD5cBZyzj7sRpyn/U5BjrsUlNJkcCirajePG3yEgp+f0FkGbr9REOEy42NHCyS8dEVXqNMcOWZDf6Z3owzC22eu2xdvitkPLhq4wDDEcTFj1k/Dag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819937; c=relaxed/simple;
	bh=TGo0vjkXndNXuIixiV5kM6OgALcrS0Dle/B1wThlpWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCPVoiOlzglLYKeOe7XewzbL3aRklPmnPTtwjuTKZygNZkYyDtSApOZiRbwwVSTwYhs2amNKi4IFBeCC/J5LPFue5ora4Q7R77YDzb5VL+RH5NSXicVUFtaILhTPyywaMIxtnjyCcHfvvm0K9giSahyB9PGULc79xV8NxFN10uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=topcg582; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e904f53151so3163906d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741819935; x=1742424735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGo0vjkXndNXuIixiV5kM6OgALcrS0Dle/B1wThlpWk=;
        b=topcg582IF/J13NStziUhaQ9D/WjfiJyj8oega6xolYsXJ1JbNlRa0UdmTmI52u9tS
         cR2O0Xp78F3DQDDueDTNQpRrG8G4hb+KTnLKP5G+x+nsEciTW2AknCMs6BmjUlhspTlc
         t48f8jsNocGjCD3KW5tcNLJEg1vc1cm02+l8cetBA9v9aHaC912MJSmCoWGnUZdjZTdu
         W64Qs+IrYI+QDWe3cF6OZZITz9r0meP1lpHmgPip5x2NpDwSjSA8Lf3v/TaB0jkrtfV9
         u/bcyVTfMy5FF/aSVNFv79/oYYkF8rFDtOrY/+l6Nc5ldKBL28U/Q0rksVSeqagQrcWF
         uPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741819935; x=1742424735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGo0vjkXndNXuIixiV5kM6OgALcrS0Dle/B1wThlpWk=;
        b=OC6nN9WXwVU9AbdTxSuOhHmzyktFR/hoSSxs2GOkpBeJeA8+EBoTVRFRYafcbbCCks
         x/JEIP5b9sIEbASBIzE4lnDkdlN3XehyM6o4Wrm7dyaRC6dlK2NEOsk9OwOWmBlM7C7J
         4YznsyVAqGMbWUFWWQaRqTX2F6UgdEEn8Hfswyejlpw9na1o7r3bYSwGRjCT5KHkQfeG
         b4+NSkDvq7gsIlcnB98OxLWAg58Q8pKBIC5adR7aqBPsuYHepNM2ozgGTlDJCyfWqsPm
         2+Nld1kw+Wqa+TWNFTwVl7zJy7cZu9mvAkWvrYYFEwiAddE/2YH3jrb8zarHKFYsQef+
         9Y5w==
X-Forwarded-Encrypted: i=1; AJvYcCV+9236iyQb1dIjmsBYVstvjbGhc/TV5eaWb17/mrvCNWkcsKPGgpZxjKCL5OOebjzcy9q/YVxLwBbvzZ91TTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHO5hJ82O5UKIMiuOqx+wXY1h8lHnGkwV86fPhJiqv9VTxFNZ5
	9BYMV14BQ/6+u5GJSpalNIfQ4KQMph0IoxuDcTYs1FafKYeXVLFfxgkkUX6gtv5xfVYSC3sWx3x
	ZUUpasoMRa55ielFlf8aTtp+TxHCK3o6RIsph
X-Gm-Gg: ASbGncuy9IOWiGF8BiwYqhIGMNbuJqwUd3BtkweiJIKQY2yEMjCDn1NJ+ukPvhyBD0X
	Jb92t0OjtiP7+iq4dW62bn17hzw+6amMz/4S8O3KqvhDOxTv6I67qiaFjIrYheklJkhlKzRoPMM
	A5Jnyy49z3Tw5QwqgZCfygguiddrV/AWlsMFEoZw==
X-Google-Smtp-Source: AGHT+IHwlyYpkLe9ATUNIrVIiXtDjbLZXlCidF01eOjhmejKYp9P3pJQXWOCkRuIOLGr2gwpkWp6IlxrmJqHb4EBIUo=
X-Received: by 2002:a05:6214:c8d:b0:6e8:8e10:4243 with SMTP id
 6a1803df08f44-6e9005bc7efmr345040646d6.7.1741819934910; Wed, 12 Mar 2025
 15:52:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0842477c-6063-40f8-8e8e-b9ce98711f80@linuxfoundation.org>
In-Reply-To: <0842477c-6063-40f8-8e8e-b9ce98711f80@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Thu, 13 Mar 2025 06:52:01 +0800
X-Gm-Features: AQ5f1JplOFmwqrnnmalRO-7Paf8cXSsIlboVE33lE90dO-tQKFrKEJGPlkEmMac
Message-ID: <CABVgOSk+xztNcNJ5fQiRSGC3DKHS2H3kN1wHwAO4gCfG7cWY1Q@mail.gmail.com>
Subject: Re: Error during --arch x86_64 kunit test run
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000082ac3d06302d0e12"

--00000000000082ac3d06302d0e12
Content-Type: text/plain; charset="UTF-8"

Hi Shuah,

On Thu, 13 Mar 2025 at 05:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> David, Brendan, Rae,
>
> I am seeing the following error when I run
>
> ./tools/testing/kunit/kunit.py run --arch x86_64
>
> ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `sev_es_trampoline_start' referenced in expression
>
> I isolated it to dependency on CONFIG_AMD_MEM_ENCRYPT
>

That's interesting. I recall seeing this issue briefly about a year
ago on an internal branch, and we worked around it there by enabling
CONFIG_AMD_MEM_ENCRYPT (which worked).

But I've been totally unable to reproduce it this morning: are you
seeing this on any particular branch / config / environment?

Either way, I think KUnit _should_ work with AMD_MEM_ENCRYPT disabled
(and still does for me here), so the correct fix is probably somewhere
in x86-land.

> I added the option using --kconfig_add
>
> ./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_AMD_MEM_ENCRYPT=y
>
> I see the following
>
> RROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> This is probably due to unsatisfied dependencies.
> Missing: CONFIG_AMD_MEM_ENCRYPT=y
>
> Is there a better way to fix the dependencies? Does kunit default config
> need changing for x86_64?

Looks like this requires CONFIG_EFI=y and CONFIG_EFI_STUB=y as well.
I've had success building with:
--kconfig_add CONFIG_AMD_MEM_ENCRYPT=y --kconfig_add CONFIG_EFI_STUB=y
--kconfig_add CONFIG_EFI=y

As for defaults. I'd hope we don't _need_ them, and that the root
cause of the issue can be fixed, but I'm happy to add those to the
defaults in tools/testing/kunit/qemu_configs/x86_64.py if we can't
resolve the underlying issue.

-- David

--00000000000082ac3d06302d0e12
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgzf7/bWSrN4fSGlqHekHTQlcKE4BO
L/QkVqtb1A6IvMgwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzEyMjI1MjE1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAlPPIiMg8m+p8SQC2Ki3bIO3hW4+kMmTI+d4aZcUr9FB11LMsptnKMtM39c2Ihlqc
odXcAQoAmypNyNrKgY0rp09hb1rSTdJCTElfewhYZTmNV/g9CPtaxEBZidK72DU6hrc6tSNjnZRF
sMUktSwK20KDfxzBDcak+FEZm25IqKIbHKrZcgtlVV7wVkwyy4EzVNS5MAKvvKHZbv2xXk1oMjGZ
BIbmKvXYRLhsK7r86TCNT+JPZxojz/e4ngaBLYmdC56RRfAg+gx+qalk+rZvk/aXDg6joN/Mzo+t
t02PpzcaoK/XdZWD3GTOeutV6BOSNmuLdsAVxkdZY+Txx+8zCQ==
--00000000000082ac3d06302d0e12--

