Return-Path: <linux-kselftest+bounces-30045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA216A79BDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 08:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2983B36D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 06:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC0199EB0;
	Thu,  3 Apr 2025 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="29uPP6ia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09219F471
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743661198; cv=none; b=FkXOheUGKOhis3bB1C18b304UQ2JHESk4QwA3nG0T+htX0kHZon1T9IOkqpHzSPc2T0lwmqkKYxM1jr1+9nvSEFB27h6sD5jvYW7c2vDXtU6czLWbD+XXU/T4+JSE3v70SmVDnAknds3uQ4KVlESBl5qPq/hFU24U9TsGox8Ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743661198; c=relaxed/simple;
	bh=+mRLTJOkQztTIcHgWecr31G0+WIdVz54hVpLPXl6wuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZmOD/WLLWD7cn42SokAe+TXNsBeOtRlMrCJBLCW4mwcDQAuNVdyZt1Tbz+UKXhrP4GjS1/G/HPX6ggkWa+tT7cpKDe0KP0F9Kyfsdw+mGkpzPqvghyXZhNvyo1qJiUobz0Azi0vioMa4ndIzF/KPTe8ou1+wh4etEanFxIgC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=29uPP6ia; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c59e7039eeso80169585a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Apr 2025 23:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743661196; x=1744265996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O1gRXvYClco4LGL4KDbG1lK6UBVbenqXAb3t2UXMW54=;
        b=29uPP6iaqdRg51EyJ47R+tRksi/ROcFxbe0MPnazKl34gnVVFQ73pZtS6RYsaLAChr
         DXusLM5FEalB/wHFnU8RfiV3x4GqzxEzI8oKmmhFrhEDtvUcf69j9oduRyrcIU5nvkCK
         xBxVzyKYueQRHTcz3m+E/gwi2aI+Lm/oODq6MJUL9cJvS15egqF+rGXr5HBa/IN+RQ7d
         iEloU3KzcjuBV4Oc6zRwblJ38xUO0qlUOlVRFUGisKKaoTbPZVph393o1DPV/A8DYeaP
         ftkXnsfAshD2hdWMWJTpEgX4oRPWx9GR/lZ+H8AZEfNEZ4uoTcx96W2GR1/vjkRWNoIu
         oiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743661196; x=1744265996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O1gRXvYClco4LGL4KDbG1lK6UBVbenqXAb3t2UXMW54=;
        b=PeJe8LhYT8vOJtN0ZhJvDKGXERQHHNN2WMUR9z9R258/tIDIMYo/XHrShJIvlVswAk
         SjAeb2F6w+9orepmnSVS7Y+kTmYjV4/U905XIQFg8zsrQELZw9iFo/gncpqtN5HgmJv0
         4mPFFEDa5NZa77TJRWPo2LTyavDFNr2JiR4L4gYfI4hO3R7iyGbAFPyXSRRKSkW43um/
         6eHMefVoQWOcCs6V4C3DjmkK46Z1qnSFCf0wg8ZvY79KNUV3t5HtBxzy9tIPb3xIydVr
         b9RMyxFWZuisTk1wwOVxWoYbmpJnn/pYTuVDR0PO2AVUJFPmUkhB9qHP08LpU8LAJXNq
         fGCA==
X-Forwarded-Encrypted: i=1; AJvYcCVMtVec/6iW96JhM8zc0jpyWVt51CGfKWTE7gbSfHmAuWKJkSoEzA6gF7MpKbrts2Uv93zaLnhHoxNzyYWQR30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxztq1G5AomDpCoBAT45Ofbeh9z5epSw4OH8ag/bgWfb8qxa1ZU
	MSvmknOGOmn7h1ZuKIdIlaAJ8MSka+AyfBXEdz/0cPqPqoTZtnhqSpZoB9IubMyHLMnxG2iYoHx
	rUgvNryBML1c0NZoY7N8Kp1qAXI45e2dVgt/S
X-Gm-Gg: ASbGnctQViZeQsIwpdgpmkjpDIdVNjEqfpivRxo7RSf1gzLj/Nm+faPiRUm24NgdZBH
	p92+LYW+zjKvQxomdDoNhKcgEQcKPRycrsWm56AADl6CGebh+/+TYRj2NV1qpffDrHbux7CK7L/
	6rAo5hbbpQjtE912htuFgermCrC3A=
X-Google-Smtp-Source: AGHT+IHobM30aWGcjRvtl7UtC89bSl417hF95G2Om4qb9WLaEidFDThj70/7nDCcsUme7Y3j27HTppETJkSlogf3qtg=
X-Received: by 2002:a05:6214:2aaf:b0:6ef:cc6:953a with SMTP id
 6a1803df08f44-6ef0dbf5a61mr18857576d6.12.1743661195332; Wed, 02 Apr 2025
 23:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402103655.3e0c62d7@kernel.org> <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
In-Reply-To: <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Apr 2025 14:19:40 +0800
X-Gm-Features: ATxdqUEX00taEYAyphk7FAVOcXDwK2b9YovTUqffLa44phLSOhwqGsLSoFTClYo
Message-ID: <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
To: Mark Brown <broonie@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003443200631d9c2c6"

--0000000000003443200631d9c2c6
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 01:55, 'Mark Brown' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Wed, Apr 02, 2025 at 10:36:55AM -0700, Jakub Kicinski wrote:
>
> > The Cirrus tests keep failing for me when run on x86
>
> >  ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64
>
> > https://netdev-3.bots.linux.dev/kunit/results/60103/stdout
>
> You've not said what tree you're testing there but everything is fine in
> -next AFAICT, and there is one fix for cs_dsp on it's way to Linus at
> the minute specifically for KUnit.
>

FWIW, I can reproduce the issue in the current torvalds/master, but
not in linux-next, so I assume this[1] fixed it. (Which looks at a
glance like it's fixing an uninitialised variable, so that fits.)

That being said, there are a _lot_ of Cirrus FW tests (over 5000 by my
count when all of the parameterised ones are taken into account), so
this can still trigger the default 5-minute kunit.py timeout. And
because its split up over a lot of smaller suites, it doesn't really
make sense to mark all of those tests/suites as slow (though some of
them might merit it). If that's causing issues for people, maybe that
could be a good reason to remove them from KUNIT_ALL_TESTS, though
personally, I suspect the better answer might be to move it behind a
config option which can then be excluded from the default .kunitconfig
if necessary, as in [2]. (Or just increase the default timeut.)

Cheers,
-- David

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2593f7e0dc93a898a84220b3fb180d86f1ca8c60
[2]: https://lore.kernel.org/linux-kselftest/20250319230539.140869-1-npache@redhat.com/

--0000000000003443200631d9c2c6
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg7DfXdNfiBSkp9JI+VPM5sKMsJXyT
L6Fo9D4N08Qz6e8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NDAzMDYxOTU2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAQe0xvVxFsTRvaajsFEi2Tap+HUfK7LR82Eb2zHTD2OMtIa1dcSJ9FEY/nWLzIktE
EhDh4DfBaBA2qeQQOZ96cyYQXtaHdDLnRhKsSfHlwAmt7gYIIGwoDr7nQqn/JgDV0FPfiZiICTlk
V6lmoWqUfOvAt90MQCMcR5UdRtMhuV7QjaP6V8QzecAHK9LaeEEKAy9cfkGHl5sAG82ffVbqf77y
8+kSmf+TXKExBZMKGfWjpblKwaD4ex2K5Vgm9bWgHlaLKhbNQYq5bw6U+Br5AV+cr/k1br9D8AsL
XwKWMf06VbknzjyLjW3a8QkspTSDuf7CqUXpfiJ8Uqj6UyFK4A==
--0000000000003443200631d9c2c6--

