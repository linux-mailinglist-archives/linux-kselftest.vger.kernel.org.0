Return-Path: <linux-kselftest+bounces-35338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0FADFC97
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 06:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8D87A82B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 04:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D113633F;
	Thu, 19 Jun 2025 04:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+3/19ie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5223CB
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750308359; cv=none; b=bj2VkJsyvfX+DHEXk+fToFbLk98OiUsonqgbrIf9HO3sD1nSKBBvB62TvYWMP/3LlpV0+yju+nMLLXDiIj53fdh66Md5lU9jHVhQxFkZZ3TWZyI3YVHTp9kWfdYbtctLg4PFMXCi77Pat+USgtME44RpsZDqofETV5UVuHmEysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750308359; c=relaxed/simple;
	bh=EQ9umSLWB6F8xmXFzs/zkRjg6wl4pvUBeLZ9gWcnhV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2d5xjjDL+wUzw7rXA0dyMyzksSheUNkS8mJV8TZuFTYUTl9oe0Yjw+jZt2U4Q8BfThAk4paDRS9EeutsJ4LbFBwvqLvzuh+v8Hd4U0AVIYceBmRjxiz8NK1AsIGXE3EfHTd9VYGntJqkWna0q1xT/5qRyMAutV8UrpnvKsiOr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+3/19ie; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d2107eb668so66941385a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Jun 2025 21:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750308356; x=1750913156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EQ9umSLWB6F8xmXFzs/zkRjg6wl4pvUBeLZ9gWcnhV0=;
        b=E+3/19ieAGKkwQbmWuz/zOe+ZQqw9p38bxF6N27PBj3oApyzDhbwB2VpC3ck0EA9fG
         m3dnFsL8svI/C5+O4vbHmNQto+1rW5cpP2VGEfyFqc1Mw42nY3Mqp5ce4fwmsorxcaCW
         hLItKepH3IYMdZoaTHUmtq+KCARygspjEF/BD6cAJ5ROIKCge9U6rdWRdkBPV2Owzzty
         dWfN2SkbRaxh8iR/1Xvs2ApH05BEfG7I+gOPjl2S1tRM4mWLtp9/M5z2fUer0GrvgXPT
         EHnhYkdPbtbtXqmSmHCw2Vd/HlVCiWJINurmNQ2bvWJVoS94jwI1jmJiVQi42UD1wjNL
         +CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750308356; x=1750913156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQ9umSLWB6F8xmXFzs/zkRjg6wl4pvUBeLZ9gWcnhV0=;
        b=as8DZ8PM7m+SoFoUu2S1sqZkOZhuHTqDaCS6RTLAPjNeQQinyAwvZVeJ7AbwJa0a5a
         l1vzeootlKOZJ7t31Q9aXaUBLzTLd7DNazZ+Kp2xYpkOxMPFN/X6xtjBXCZ46Ku25WBO
         0SOnEFuPxF+BZn9elpYHtnvoWtjOy6+GpgCq18EZ+STDY1FZgZqaEy3/21QdRuiUXwtD
         UHu83z1a4vY2v6ty9mXeNWd/gV2jwA7n+NQNdVRjIOqX4d845nXeBFL4PJaDUmxhkvzQ
         hwoUB/NO9MkR+l1fXBzTTEGQt/FCUSiurj1ORWOjS8qUfaqs2mUshJk1F6XKwfTg9NNX
         tEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ylNWalhcE462EOpo1yFyeCO4rYFnLhznx3zYgyrcE6ecbmwRMlMJibCmfB2HXzIP2ghoF34vsa20KOpERWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlNM/WRzyBvhUQLpMpfs4z9XzrE3TeDNQwCWMtSWeBgAnQ5uj3
	5YFQhEpHeh+qKs1nxNDXrMZdTPyjTOPB1snaPfGcDpXWlm0UOImXa/0aH4uL/1z5tIzs2sKc3eO
	kqsAwQy0LjUdzve+i+WTP5NRIu60CC00B1bYuPoMD
X-Gm-Gg: ASbGncsz+Qo9lKqTsLptuyxS2O5ouClozfeQ9tHWJep08mVpU8L7XET1DnqbzSzQawm
	5zNhj2Gvg6LE9vM4vlaSI8xMDjhO0Das5aNQJJZJRcfSO56lHP9tRAAoh3iRIoit+fTUDkT4MYJ
	csWnQaSgjnAytGrtpsHjSdvO2zzpE8GSbZjeaD9srLp+AzEt/+zYzH1y3L6LV34Ui750MczlBmw
	peRmg==
X-Google-Smtp-Source: AGHT+IFuzre3mf7nVG8U/X6HB+JVtxpeXm16YH4dCG1QoXGDrimyyHvmpYaRtO7dWqHDVpViH2I4BpnGGAYWzJ57yZ4=
X-Received: by 2002:a05:6214:f2d:b0:6fa:b03f:8a39 with SMTP id
 6a1803df08f44-6fb477eccc2mr324220596d6.35.1750308356371; Wed, 18 Jun 2025
 21:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614084711.2654593-2-davidgow@google.com> <CA+GJov7j6hxp=FfupAwZZDGCXE2j3L_87D2MOCK8po5QCW83uw@mail.gmail.com>
In-Reply-To: <CA+GJov7j6hxp=FfupAwZZDGCXE2j3L_87D2MOCK8po5QCW83uw@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 19 Jun 2025 12:45:41 +0800
X-Gm-Features: Ac12FXx54SwfeQOKdd4jFRc15_d8-tEk5lULD6DtAnlnxQqW3UvzGsOhOvYEUq4
Message-ID: <CABVgOSm-ycyarsUZOkjt+O67GWJNv8qeTKOEDaBFsNA2_pqHRg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Adjust kunit_test timeout based on
 test_{suite,case} speed
To: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Ujwal Jain <ujwaljain@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dcdb770637e56be1"

--000000000000dcdb770637e56be1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2025 at 05:37, Rae Moar <rmoar@google.com> wrote:
>
> On Sat, Jun 14, 2025 at 4:47=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > From: Ujwal Jain <ujwaljain@google.com>
> >
> > Currently, the in-kernel kunit test case timeout is 300 seconds. (There
> > is a separate timeout mechanism for the whole test execution in
> > kunit.py, but that's unrelated.) However, tests marked 'slow' or 'very
> > slow' may timeout, particularly on slower machines.
> >
> > Implement a multiplier to the test-case timeout, so that slower tests
> > have longer to complete:
> > - DEFAULT -> 1x default timeout
> > - KUNIT_SPEED_SLOW -> 3x default timeout
> > - KUNIT_SPEED_VERY_SLOW -> 12x default timeout
>
> Hello!
>
> This change is looking great to me. No major concerns with the code
> and the tests are all passing.
>
> Just a few thoughts: I am wondering where the multipliers of 3 and 12
> came from? Are there specific tests that need those timeout amounts?
> And then given this changes the behavior of tests marked as slow and
> very_slow, we should update the documentation. And if possible, we
> should also add tests to check this feature.

The multipliers are pretty arbitrary, they're loosely based on the values i=
n:
https://testing.googleblog.com/2010/12/test-sizes.html

There aren't any _specific_ tests which need these values, though, so
if there's another value which would be better, I'm all ears.
Regardless, the plan is to make the base timeout also configurable,
which should solve most machine/setup-specific, rather than
test-specific, issues.

For better documentation, that's a great idea. The in-kernel timeout
doesn't appear to be mentioned anywhere in the documentation.
So I'll see if we can add more complete documentation for this when we
make the default timeout configurable.

As for tests, I don't think we want to test the exact timeout values,
as that'd just make the test brittle. But testing that timeouts work
at all might work reliably. I'll have a play with them.

Cheers,
-- David

--000000000000dcdb770637e56be1
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgIu2/7m4AYOP+300BWXQEtEpfv6Ng
ABjhXcJFsHNSAx0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NjE5MDQ0NTU2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAMUe4f51bpStIfGzI1suieNQkDQN4EzyRhGi352/hW2X7zxO2UBO06mElWQ1gvh2z
oCq1F800DPvNV8qZYBx/XEU6E+mz/SQnyZz7x05sMV22cYiS+l2V/LMgGrxEvjCXnlK+yC+oaegp
oMfFKN+w7ig27BmWDlu3xshCuY5yUgwj+YJVxHMDvDnE8DFMbumac645q+o3lmcLAv0whOJYM6Yp
H/eix1BdE9zD+17DQQHW2Yad/x9EfFlJgs//wEAyyzeIzScO/cShteMPPBUmVbnyYBlsgHbGjxld
GjWNR5kTfh4IPZ3NKSSIYYhktIXzAn/nVsWcUV6XHzCs0BVwDg==
--000000000000dcdb770637e56be1--

