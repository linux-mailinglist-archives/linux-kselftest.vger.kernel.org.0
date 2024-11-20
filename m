Return-Path: <linux-kselftest+bounces-22333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694B9D352D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 09:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C45B24B7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B7E16EB56;
	Wed, 20 Nov 2024 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuKo7P0j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856E16DC36
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090578; cv=none; b=VLFddirw2Yd5uH2QR98aoY4yvrp27WVifyTVa1Sz205P6bXrA/iKgcOmO8q6dtIMFgjFHg/8oMGp1N+ztH0a9RWkWuDb7fvlUWkkBJZh0Mw2hc4fM3Rst+dfuAjXoPuKU00aNTGGiOmqHyP/1UW2IPRT+C3JyMP8w94OOsV0Gc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090578; c=relaxed/simple;
	bh=4sJp/kgZyRAqWWuWQaTa05mojY3F6iGUg6K4/FRXJSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBZOo5av6qystUOSF+wQUMl8O58tJJYhewlHjqzC7aOSqGBD/X6UiWuL+76w2AAVhuxgEwbjtClcm1eL7W0fJoKtYlZcbQjdSzVOcAgHojRtEV1k2XVHqlGyTpHAqjWUt1UC4QWuUR5b6sgGNPIGvjOGPP6qJ0/UkM5TosgByLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FuKo7P0j; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d4035f2d18so11682596d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 00:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732090574; x=1732695374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3YcF7y9bpxxlE28IYaOjDEwc9kuwTYQksYtld/hUTJo=;
        b=FuKo7P0jNvqW2Y/ZQwR09/2Hj/tPEKJXl30K3aN6sOpDo/HMOmScEH1fBOO0lr9MlE
         imCOLiUualw8WGK/4tmSYfiOJHiPri5c6yUsjH8T9drW8BTQPEsxawZbEt/b7CdnWzAs
         3VNaLi6sio29Di69+hZfXRnD1TqUM9L9u9fA3yzQd3906oIID2ve5cYsMKC6GYr2cAej
         1bF9Ar5/Qfv3T0pAJTsA6hNQHBff/b9DKejPZP+S0jKG6n4zCrbCnELMZxqXB7g9VGD+
         epRvsgK+eiREYJqtyHDA+RI+5hpx4hI//MdS7vH6O5N/Gf6ta1Rzm/wPq+Txo3vCqIFd
         HZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732090574; x=1732695374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YcF7y9bpxxlE28IYaOjDEwc9kuwTYQksYtld/hUTJo=;
        b=SH17sdzW3oFZAbRTOepYM50K+z1SotyG+eO056/oTBc70aOAwnoHdm2ck39MduC0nV
         uYg7Dsnb62WyE9jupQviLj/NT5dHBksNzhs2zoEcWTzl1e1E48zXI9Oe0zWKH+ldwnhE
         WJe+mEOmEWpU/bNH+oLLICN0iazX//hhUVzIwuhd+JrsumQX2yMb3+/6l9thdgTDMUca
         OCStjuJ1YGMUQvZgqHE0tG2tfzb73GRl64aXXJseRyE+rWBBPls7mfypCxzB9Epr9bwT
         5UM5xfFdlWXHQXII7WLyQnGjURmDnDqdpwM1awm3V8LF0cb3c0WhylxWpxXednwFS1UH
         S5tg==
X-Forwarded-Encrypted: i=1; AJvYcCXMQW8cncQ0tP0+J9OfsPvSBMqNrLJS8Otf3ObJpjsO4H9sNnC96S8mGSByvZzy6vLKbIsKj2JZYPyPHjJ5Mcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaOdT6HVS8WVBBYU0C5PQy+LiudB9LeFUCPncMlCbTq9LwDG/Q
	k7dKb0787OK5DH9GWo7gQI6Zc2/Z8wEv+qafRxppKDhVqp2xy2nzLwvcdDEv4jIoiqdOga/Ok0t
	Z7qxrZKZzTlHRZsqdYW9/bIP8GzDjLI7MwX0a
X-Google-Smtp-Source: AGHT+IFLvnzVK9N3VLxnsAveuywnx+Rb/GdmLvLQ47PBJl9kv4nuvVzFTIP6lX9TLoBehtWW9+VfMbuYo5oF0a2FAgU=
X-Received: by 2002:ad4:5aec:0:b0:6cb:ee7b:7ac4 with SMTP id
 6a1803df08f44-6d4377b1ec0mr24362626d6.3.1732090574320; Wed, 20 Nov 2024
 00:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK18DXYitS7hL1mA3QsPLmW9-R0q6Kin0C5Uv9fj=uS90WSnxA@mail.gmail.com>
 <CABVgOSk1ng46scbJc-3qPZUhkn+0KrZsFDe-UYnw0q-XksP_2Q@mail.gmail.com>
 <CAK18DXZtBdxQdYY06X+Q=vYybnkCLBQBioCLqvSfkYZ21jBSWg@mail.gmail.com>
 <CABVgOSkBF3fT5JdVCEpBRvO1V8ZgZ-dD7fvxcv7Rxb_XPcFNbg@mail.gmail.com> <CAK18DXZM7sapjOHcsOUAEn_+Q+bvFUtL-CNjEgq373gpWr7r-w@mail.gmail.com>
In-Reply-To: <CAK18DXZM7sapjOHcsOUAEn_+Q+bvFUtL-CNjEgq373gpWr7r-w@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Wed, 20 Nov 2024 16:16:01 +0800
Message-ID: <CABVgOS=ccEK2+ighe=7K3Ja-vH0=fthK4LgV0kHTuNCgO9JzzQ@mail.gmail.com>
Subject: Re: [RFC] Test catalog template
To: Donald Zickus <dzickus@redhat.com>
Cc: workflows@vger.kernel.org, automated-testing@lists.yoctoproject.org, 
	linux-kselftest@vger.kernel.org, kernelci <kernelci@lists.linux.dev>, 
	Nikolai Kondrashov <nkondras@redhat.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, 
	kernelci-members <kernelci-members@groups.io>, laura.nao@collabora.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006d81fd062753c313"

--0000000000006d81fd062753c313
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 at 01:01, Donald Zickus <dzickus@redhat.com> wrote:
>
> Hi,
>
> Thanks for the feedback. I created a more realistic test.yaml file to
> start (we can split it when more tests are added) and a parser.  I was
> going to add patch support as input to mimic get_maintainers.pl
> output, but that might take some time.  For now, you have to manually
> select a subsystem.  I will try to find space on kernelci.org to grow
> this work but you can find a git tree here[0].
>
> From the README.md
> """
> An attempt to map kernel subsystems to kernel tests that should be run
> on patches or code by humans and CI systems.
>
> Examples:
>
> Find test info for a subsystem
>
> ./get_tests.py -s 'KUNIT TEST' --info
>
> Subsystem:    KUNIT TEST
> Maintainer:
>   David Gow <davidgow@google.com>
> Mailing List: None
> Version:      None
> Dependency:   ['python3-mypy']
> Test:
>   smoke:
>     Url: None
>     Working Directory: None
>     Cmd: ./tools/testing/kunit/kunit.py
>     Env: None
>     Param: run --kunitconfig lib/kunit
> Hardware:     arm64, x86_64
>
> Find copy-n-pastable tests for a subsystem
>
> ./get_tests.py -s 'KUNIT TEST'
>
> ./tools/testing/kunit/kunit.pyrun --kunitconfig lib/kunit
> """
>
> Is this aligning with what people were expecting?
>


Awesome! I've been playing around a bit with this, and I think it's an
excellent start.

There are definitely some more features I'd want in an ideal world
(e.g., configuration matrices, etc), but this works well enough.

I've been playing around with a branch which adds the ability to
actually run these tests, based on the 'run_checks.py' script we use
for KUnit:
https://github.com/sulix/test-catalog/tree/runtest-wip

In particular, this adds a '-r' option which runs the tests for the
subsystem in parallel. This largely matches what I was doing manually
=E2=80=94 for instance, the KUnit section in test.yaml now has three differ=
ent
tests, and running it gives me this result:
../test-catalog/get_tests.py -r -s 'KUNIT TEST'
Waiting on 3 checks (kunit-tool-test, uml, x86_64)...
kunit-tool-test: PASSED
x86_64: PASSED
uml: PASSED

(Obviously, in the real world, I'd have more checks, including other
architectures, checkpatch, etc, but this works as a proof-of-concept
for me.)

I think the most interesting questions will be:
- How do we make this work with more complicated dependencies
(containers, special hardware, etc)?
- How do we integrate it with CI systems =E2=80=94 can we pull the subsyste=
m
name for a patch from MAINTAINERS and look it up here?
- What about things like checkpatch, or general defconfig build tests
which aren't subsystem-specific?
- How can we support more complicated configurations or groups of
configurations?
- Do we add support for specific tools and/or parsing/combining output?

But I'm content to keep playing around with this a bit more for now.

Thanks,
-- David

--0000000000006d81fd062753c313
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgQC79FiOyddUHKApNAvZHrCcQGLcy
4QWS4RB9XnNQraIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTIwMDgxNjE0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAD7HB017c7DzgoffH8+P79cMav3ipFY/GoadqSD0lJhEzh5Q
vHz5QedhXdK/97yQoFgL0blkg8w8x0+aUsRPzZl+YwhM3fSfFDTLFaBUOdlFqhRAVfmw8brkqBoT
WPkW+7/Ff4jhcLHqdeLgjPTNkVysw3OU8R0RKwTV8pM0nlS+f4E9oRjGCOEOzjVSZGk1wm26hw9h
0i28MYGg/jIKKtV2FrMKFBpIPsCpR01XvF70Zmd41wZcrG43IEXDe+lQZ3k9vsAugtxNX58QUnls
iyc7iEbsjhnzWf1gde78ohkkfsgBAx2LTLDo7YpEq6TYJo/f0D3ZP8Xs31U1KmW3xaQ=
--0000000000006d81fd062753c313--

