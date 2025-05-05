Return-Path: <linux-kselftest+bounces-32314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE9AA8C04
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 08:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85D83B53BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 06:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9FC1DDA00;
	Mon,  5 May 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPo/QyFG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B091DB951
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425007; cv=none; b=do3J2rkEBwhSULzLC7jnQQ5NFUFnPapXzUt9/RJj2n6R+YH6WQvGcUC1zWEjAUllDo21DF4Ky59MwxNvK/BLRZ6ZiF0/wEY8iIpvSUtG6tmUZkRtGRFpoGJJyXIqSmgAfIIP6vFaRUluO3E2kdHJ2kxwiUYeozNWp4nOITZFyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425007; c=relaxed/simple;
	bh=x4+V9YzwwUuakzsgsymU4ycA7pKVekG4hN/SM3mDaoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKbvpPyd1/QCtOQBiVE5lfaDOUZ766SmbvgcZll6tpMciM4p9fDMBXjefos6DVf8TMltSshaAAQ8SquFT48fyDNs+NNCvwMOTvFuga08VujatPayStqZfLFojuda23sHw5vMYXiPBEHl53NR9h24Nmqs9ZWPPW6jX+DzDpKpfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPo/QyFG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f521957182so21819816d6.0
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 23:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746425005; x=1747029805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x4+V9YzwwUuakzsgsymU4ycA7pKVekG4hN/SM3mDaoY=;
        b=LPo/QyFGDso7GGJsMLPjdXgUB9ewglOjwJR+9aEXtF/35KvT/HmVQlPD+eqXfA3M0Z
         HPxM/ZAOy3DqmDs3Q7fXqwoF/Xy7xOgTcjZD6BWJKRqoB9pyj3KVUEcyxV3YOS7PdCUL
         CWJ/8FLd0rrDR+DuDhlQPDHh5VTl8Zt/mZ+kZAyXZMwMP+nkkzQUAoajaAh7zBOWjJrw
         PiluN+I3QHxlRVo27KAqg7Vf6bUa+lDiqzk+PlprQclWDKUbQ4husZq+JW76KkAbig1+
         3CXvKyjFWUIVFwx+dopiaIFKiPlchPbo34YUA81tfA4AS7OBQcgj4N+bHlf5KQUPKgMk
         a4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746425005; x=1747029805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4+V9YzwwUuakzsgsymU4ycA7pKVekG4hN/SM3mDaoY=;
        b=ATBPZWHUiJaEzfKxxN6ts1oUHF0GjT8NDjcMNvdD848/ro0iv33omMJF2enUaj+gjh
         RrH1+bA8NjcFqkDdyquZCM1eR0CUM99MRA/a3hL243eywxPOEi8VcjnEV2/5DA/dDwOL
         0ubS8ZWwAsANlMCMDW57juVlxNPRIz2R9qtm0Z+zrMyRM4Gn/no/UrFeiUnzHp3LbCov
         0ZvlMOESs5Bk3Mo+g2qMQjFTFxOHFeJ5oWPbcUY1oF9QcqibGJbghIbOExVT+GzFb3OZ
         VhSvPeMFnzinblkmzakyfw+6EXHAIBc977aN3OeJunLnao60thCXYZDqh+rgWyoTw3JP
         ullA==
X-Forwarded-Encrypted: i=1; AJvYcCUpDbROxnQQUteSyvPEtArHEJr8SWMANs3rrk6/bSyefSRuC7/nCOPsuwlYurlpvaiZ18ID1MlXRMI4e0hrNmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnfYRwyrTjJpRN7FFcqysc5NifBVixYCk3agB1EAHEyd6qKlK
	IplLL3SHSjvHJETzlng9XdMQRK4YLKbsMKSz1nZcJwCRiP7O03mjO/bqp2i40bPVBE3eBxNpllb
	QGXD075LwKsD9r7SYMURGluu6867/qBtI0D9/
X-Gm-Gg: ASbGnctDr3f1LniOqRK2LcUOOvMIIqFYMvpqCuDMd2EN/bqhPTnkcUwVCDOtFRAjYzD
	IO8OS9zs9C6Zsp32vOvX+Ws9lYSC/klE2L5LiaaPSfPVz/5JlgiNU9MwutIUqQkgjxf+3Snyjtl
	okuoLcQnikQbZi2Erjujmpc9lEyFWsgP3mOA==
X-Google-Smtp-Source: AGHT+IGPMxqd0sS97U++gnBsqEZPVrUZfRwIlskJo59E9ztn9Pt0KLJkD6dhH3UrFgDvnNH+4Hs2QD2Lsv0U6k41ak8=
X-Received: by 2002:ad4:5f08:0:b0:6eb:28e4:8518 with SMTP id
 6a1803df08f44-6f528cf30eemr87945456d6.34.1746425004509; Sun, 04 May 2025
 23:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-6-ojeda@kernel.org>
 <CAJ-ks9n7u3WkYmJCVc18c_cKod6DaB7KrA7NXbOuD3E3TYbvpQ@mail.gmail.com>
 <CANiq72nEHy5wvOyPzW4DLu9aE_MxTx1gq7AJ-f_Ny4E6bbOJ5g@mail.gmail.com>
 <CAJ-ks9krSxo_DWFJdccP+SYJhX4WF0hXdq-20Rtf3doMp_2zDw@mail.gmail.com> <CANiq72kLz7nXOKR+f=pNCu=hEEs6XQV_oDr9-xB_sq7N+svQ3A@mail.gmail.com>
In-Reply-To: <CANiq72kLz7nXOKR+f=pNCu=hEEs6XQV_oDr9-xB_sq7N+svQ3A@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Mon, 5 May 2025 14:03:13 +0800
X-Gm-Features: ATxdqUGTECUSW1WA8h9_OcBfkVaUpBooGoacLVYmuAnyAtfvJWLDiRDFFUC3cJE
Message-ID: <CABVgOSkctH7wnNm+Dy4=kszzwURmV0Ac8CXcKwJjv9-iSLo2Jw@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: str: take advantage of the `-> Result` support
 in KUnit `#[test]`'s
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000cdc9b06345d42d6"

--0000000000000cdc9b06345d42d6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 at 05:54, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, May 4, 2025 at 8:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > I see. Up to you, obviously, but ISTM that this degree of freedom is
> > unnecessary, but perhaps there's a benefit I'm underappreciating?
>
> Well, having this allows one to write code like the rest of the kernel
> code, instead of, say, `.unwrap()`ing or `assert!`ing everywhere.
>
> So easier to read, easier to copy-paste from normal code, and people
> (especially those learning) wouldn't get accustomed to seeing
> `.unwrap()`s etc. everywhere.
>
> Having said that, C KUnit uses the macros for things that require
> stopping the test, even if "unrelated" to the actual test, and it does
> not look like normal code, of course. They do have `->init()` which
> can return a failure, but not the test cases themselves.
>
> David perhaps has some advice here. Perhaps test functions being
> fallible (like returning `int`) were considered (or asserts for
> "unrelated" things) for C at some point and discarded.

The decision to not have a return value for tests predates me (if
Brendan's around, maybe he recalls the original reason here), but I
suspect it was mostly in order to encourage explicit assertions, which
could then contain the line number of the failure.

We use the KUnit assertions for "unrelated" failures as well mainly as
that's the only way to end a test early if it's not entirely contained
in one function. But it's not _wrong_ for a test to mark itself as
failed (or skipped) and then return early if that makes more sense.

> The custom `?` is quite tempting, to get the best of both worlds,
> assuming we could make it work well.

I'm definitely a fan of using '?' over unwrap() here, if only because
it won't trigger an actual panic. That being said, if it turns out to
be easier to have a variant of unwrap(), that'd work, too.

The fact that not all Result Errs implement Debug makes having a nice
way of printing it a bit more fun, too.


-- David

--0000000000000cdc9b06345d42d6
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgA75bZsLzg0/8leRZj5UMhDCE2jBc
86F9akUla2WfkXowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTA1MDYwMzI1WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEASdrJmLUwSIrsP68YbzxPLjsPwK9qg1NqUKYdzo+NdsTN+0WBJRkCyJIN3c4Sf8Bi
sJWQSpMrzkKiOu9sPlJvyf6p72poloDKAgChnM6dVOvMc2AAoPw0aTpiq7NCoVf4IC5KxC1EXKmm
nrHB5F8rKBRCODXjrdA448zXyYyHg4Bcm1xdh0PyuJslBzCSRrrC6HanL6iyFoIJ7j4pT5BhpSnE
LMBenPDouXAUGPsNePAwpxw61VasCdDDfkCry13U84dVUmef5UidIwqzXQAIOidOps3CYdhZobqf
g9RWLRjeT8Zh4+rA2CU1Hjc3p4E4k70+H3jlhZjAlPtnP6Yfig==
--0000000000000cdc9b06345d42d6--

