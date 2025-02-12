Return-Path: <linux-kselftest+bounces-26452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA72A3220E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A986D18868FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654872063E5;
	Wed, 12 Feb 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S74DbRTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5C2063CD
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352359; cv=none; b=qV/0SNBJvZj7SmmIFa/J/7sB7yOX5ASj876yObYmNINZeCnxIclrlQr5IYrOJpAJS1/aLDDDRFyTcphxPUKCDq+1eW4ARao/OAZl+FhuOoko+1b92qnUC6cxrvjOY1KT6Owe3xFhQJQyqoqixYQhPum4CdwbsIifBejes1u6CK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352359; c=relaxed/simple;
	bh=2DgsAE/rL/fnlPvwtgF6Aw3bBsrRtbNV6XqO9zykZgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Acs0s673xRuUAXeVDD9p7RxU61IjM0VKnvESS/HXvvYFy1ivE1SmhBVt76yufX8fHPpKwjN77wwGajpVByT3o1jqj02amK4plisl75B3fHJqiFeJwkPJyRL3T7n6hnz8j5K+aZLV9qNnbDkXbBkzh0MMSWL2ZVNB+g7idQaRqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S74DbRTh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e45258610bso5250746d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739352356; x=1739957156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DgsAE/rL/fnlPvwtgF6Aw3bBsrRtbNV6XqO9zykZgM=;
        b=S74DbRThxNnwB5P++24fkd3S8mCHEij/+zsx5kGg7Mf8KyqxZ5MFQeYJ8A/W24aKAt
         aZ7Ezib1wIqP9elrwATJse/HhgYoVXyjaCZgpvfMq4e5ZP47nte0WvWoWahK6bm7LuAF
         ZqJVxHMY5BYXaXpwatDJRsnfU1qOq5KjSjFo6tSIXgIf7M2GflVOQ9LA5/lTWQpo8YVD
         Du7RKqzGEjuR8pAG22GgCiTxOBS93YPaDRreZ8gMs1aWD2rM+uYxF5MqJv0hPRDgCGX7
         uAAZK/WzszN+St7XzVWOW1wBE2ZJWZBmpsDZHTVvMfXLLY28r/p6EERBCOiCXyMDoUA6
         7dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352356; x=1739957156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DgsAE/rL/fnlPvwtgF6Aw3bBsrRtbNV6XqO9zykZgM=;
        b=etrTpJ0PNkL1n2M3fLaqa4YQjefv9CMEjn8dfbJKIuNPrxNFWFRTu5tRI1CDq6SEjZ
         0biMe2skYZKxc6OKswoDQV9gjANMzQdfQySNisubtgfhZfTOiOs3AiMc1K5IYFRFJaKh
         xLU3T/wE7uKewBVslfKuBI4fwer0WWw5Jti5PoL5lZLqjtUCHfg9DdWMeC/0T23hRc2v
         qud7+Hxy4o0o436DKv1bflOpkUXuAguZ+B5vaABLFHjWe0HHDp75SCqb0tZSRxIlsKyN
         TbA1JaCI9azXFlWVWcIO0P/ugSJdsSakHmvoRf8ejiS6ztgP4Sf+AnmbpZ0nLv8vkeJk
         ovYw==
X-Forwarded-Encrypted: i=1; AJvYcCVoZBAsIAf9oZjK/mtYoc95EMpOXV0T+WongkSzr+s+o9jysQCg4DmJoyS3Qbn43UqfYm6OHCLI+Caos4uSvhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0ZpKP6q/9PR3SL5GIBapKxuk9qa3/doaYYDJKFCXupl7qsQe
	1cWhSdKHwE0AcUSAdO91mzweuLY/cuM85ofH9qYqGjX2FrpEOVEQxoxaLmMY2rFui3x2CJPz3Qj
	kGhfc+gwQmXHaD3AxUD1fvlQMVq5L9eXDTBYt
X-Gm-Gg: ASbGncvaabRUk1KIPrKj2oXkO85HxRhezy5T9FyNtlEJJ8x19ezVA1ty0Z7VXVxZyoK
	DRkPZHdra69YMUCuR9GJ+waONxdIrz9i6z33JOctoW9AcBkx2uv/CgU5J8tDeppxP9C5ssPTsWw
	==
X-Google-Smtp-Source: AGHT+IELM8KwZg9bPa6ApIbCrsuxGiv4sqNaeocApE+U5glfWR9qu3Scox2u1ntzGs9gZiEQj1tJDoc7YBA8OJymPQI=
X-Received: by 2002:a05:6214:20eb:b0:6e4:4582:4760 with SMTP id
 6a1803df08f44-6e4680808f0mr96565326d6.21.1739352356421; Wed, 12 Feb 2025
 01:25:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com>
 <Z6vRIZk7DsSNooFZ@boqun-archlinux> <CAJ-ks9=EfdCenpTjSdsaGhbUyJ99JYEL_nY0Y8RqzOxXKYWY5A@mail.gmail.com>
In-Reply-To: <CAJ-ks9=EfdCenpTjSdsaGhbUyJ99JYEL_nY0Y8RqzOxXKYWY5A@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Wed, 12 Feb 2025 17:25:44 +0800
X-Gm-Features: AWEUYZkV2OS39zkWusmNz-gAmfnypsKurOAydIIqeSOxeLA_3B7gbiADav21Pbg
Message-ID: <CABVgOS=jS6Sgbffrx18eHnO=0LnFsvgxO0_pnpD6HCgH646Ndw@mail.gmail.com>
Subject: Re: [PATCH] ww_mutex: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f6df6062dee8739"

--0000000000005f6df6062dee8739
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2025 at 06:43, Tamir Duberstein <tamird@gmail.com> wrote:
>
> On Tue, Feb 11, 2025 at 5:38=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > Hi Tamir,
>
> Hi Boqun, thanks for taking a look.
>
> > On Mon, Feb 10, 2025 at 10:59:12AM -0500, Tamir Duberstein wrote:
> > > Convert this unit test to a KUnit test.
> > >
> >
> > I would like to know the pros and cons between kunit tests and
> > kselftests, maybe someone Cced can answer that? It'll be good to put
> > these in the commit log as well.
>
> David Gow gave a pretty detailed answer in
> https://lore.kernel.org/all/CABVgOS=3DKZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti53DQ=
ADrW+sJg@mail.gmail.com/
> for a similar patch.

That previous answer covers a lot, but while I think the advantages
(better tooling, easy architecture emulation, etc) are covered, I'll
add a few extra caveats specific to this test here.

KUnit is really better suited to "unit tests" rather than "stress
tests", and does have some limits when tests span multiple threads
(assertions cannot kill other threads, the test context is not
automatically applied, etc).

I don't think these would preclude you from using KUnit for ww_mutex
testing -- and people have done multithreaded stress tests in KUnit in
the past if they really want to, it's definitely a trade-off rather
than a strict win, so it may make sense if as maintainers you are
already familiar with or want to use KUnit, but definitely is up to
you.

> David, what do you think about enumerating these reasons in the KUnit
> documentation? This is the 3rd of these patches that has received this
> question. It'd be a shame to have every commit enumerate KUnit's
> reasons for being.

We have some existing documentation as to when KUnit and kselftest are
more appropriate as a part of the 'Kernel Testing Guide' in
Documentation/testing-overview.rst (though it focuses on the
underlying differences in goals, rather than 'look at all of these
useful features'), as well as an overview of why KUnit is useful on
the KUnit webpage at http://kunit.dev/ (though without the direct
kselftest comparison).

My hope was that porting tests from one framework to the other should
be a rare, probably one-off occurrence, so the focus should be more on
writing new tests, but clearly what we have is insufficient. And
ideally some of the advantages of KUnit, particularly in the
standardisation and tooling support, will continue to make their way
to kselftest, so hopefully some of the advantages of KUnit will
disappear.

Nevertheless, I'll see if there's anything specific we want to add
about test porting.

Cheers,
-- David

--0000000000005f6df6062dee8739
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
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgLbzrIV77LyqdEK2YDK+XFSIuEB0U
xeELQgoo7zrfnKUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjEyMDkyNTU2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAF0EDNR2bNy1fAs6oS/buG2srS7mlAv85Y+TJOVtx6ITTdwl
6Vv6os+Nedt0qwX3a0Z4qXnrNkAUqvGEDM0RKoseqfKyscNTI5LbPUniJwnHatEEFG1rW8vd+moJ
4jNBkHGXBDyMT2g6WWIpWnS0meJbqHHgyuS9O29AWt0Ww6UFg0KpH5tOsC3ko9ZSPh4Et2P1q1Ad
i6twvruu3o77XadRIzgM1QhPOUtFyjc5/th0iA6cHDcLbUntCkO7gfdnQ3MT4PC4tq1JppWTFnrM
qFwD/VJxR+tJOf5/0Yc5eDvPDDNq8EHn4oFcQKyglbQs5JF2Rk6A3TC+nASuXKtH0Jk=
--0000000000005f6df6062dee8739--

