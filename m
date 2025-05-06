Return-Path: <linux-kselftest+bounces-32487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EC4AABC3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6167E3BA3A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC42580E0;
	Tue,  6 May 2025 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3yVQ1kKe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BA257AD7
	for <linux-kselftest@vger.kernel.org>; Tue,  6 May 2025 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513181; cv=none; b=SfUh6YortgMDRoHu0fZUpq1Sbs9PG44moUeAeDwdasp12AvUADRGGHoikexEpTU5rQ4U/5Jis38ZFEoQQ1nuk0KgxqtPqmXwjh4ogyvaxOFkWCJ/bBN5kHjwSdSL/kErt5rVCpDSiI36L04W6oPHWcR2/6LGle/jgWjnIzRlcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513181; c=relaxed/simple;
	bh=hAA9a+A+2x6D9HDRhglABnbAbLO1JDioy9BOqhMxfMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djccLiPjKOKU0PqZPdV65z2tSCTyGvImg2rC8VzG2sctNRasloa4po+lA1oPpNdojdI/yaKalG2SzNSERCaqTEt8zNYRCEnGQ47BjJ3+schjJZQu/YQSUTRYkk+Ai9LC1+Z+zz1jUNxjN4zTx950zPh5mcvAthGkD62V1VDkWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3yVQ1kKe; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so69041136d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746513177; x=1747117977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TVfAMF0TTjU1OMk1MEQRLWqBzHoCXXuNMTNQenlqmTI=;
        b=3yVQ1kKeqgX2KV/uBskIqJunFVDm7bztf4lxCKLEh+rEpibeSDEkuSWNWshxH7xtYU
         ZKP4Hkn5yd9MPITJNcNCWgjRDGAJ6+doMrYKRJ4rpuy18NCXemuiVEtS0jlmyOXnqra3
         cRZ1a23Lf5asZ4PJHAVrCJMzLJ8ukcRIpjoGznehNV48Q98kwsshJXrZjag61OqYGwri
         RrBixV1Nk7YOD9fpqPI7edmLZzukJ5TAgMoCAJqnaIPNgcw88fLYXPBIBZwPuZIOHMU1
         3d44rrB1PDqUzJ8JfUUCCoO3ASZY5nmczjA4XTu97uikXFYATUYJt5wZCzUCwkTeHUiU
         aG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746513177; x=1747117977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVfAMF0TTjU1OMk1MEQRLWqBzHoCXXuNMTNQenlqmTI=;
        b=EcMIJChfiJaKqch3klsOA3nURkg9FBTq5b77UmS14G6zmx+w95qw1eoRVCCUv9+rBM
         k2Nq7CmPZfuT6OpLJu1h4eBXY73kWkxDWsn8dIfwxL2y6DZ0kI+Q4RfXUy0n+DSJoD1B
         zM0WBg8N5bpGijIY92yO3Yo6e6lJJ59a4orXEAeAd2AibnsxmkopIAfA46r9JcejmbVa
         sbfkk4LmbYHiIUxeiT2jWRdINuOP5aAUUhiBuZJBNVof5UvxaUNyAV8qmbfEl5UgOOVq
         IBVVnugWSkGkOqRiOABoZJjdF/qdVuNp7lnngk4tpxmdD1TgLegOk9Z0tGN2f4lHO1Wb
         ssxA==
X-Forwarded-Encrypted: i=1; AJvYcCUKE6M63W5zAj8K+/aGGTdwSfYsvrEiREJRvwv3afOfwildcjxcWil5qahMa2md2G10S3en7YwR98T21CB1w7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUQUFYRnpYvmz8icRx18fEyD7NHr5rTDD/DIX4AWMOLGe59pb
	PYm7cMqjcYYC+vJmCqWdeTzdCw/Ktp0S09BbWBUV6O6wQxk9UiTXR5j/GnnSK8MhNWy8WMyxJ4Y
	t0Wrt6pHnLfVo8uwiCTvUcy2NIhbd851FxB6E
X-Gm-Gg: ASbGncvzn6vOgxph2hLJ0stAepw+DMJ5B3fpkd99IjNY7+0yDeZgl8iEiTkVZTtv+8A
	35GJNeygNClVYn9VmsXitOl5AYcoJnSBPzWxwYwhdQHsJ1XpS4WDWEakhugIZbpcizTOekp4VMQ
	kYYa/43/LWDvocy6+cNdBIK/U=
X-Google-Smtp-Source: AGHT+IHmXB/cKgFL6nNzt+WRsUf7MU0M8pDV/7/x1FX+60+c46wo4YqV3iuu4VbjaOKZK01pck0OeA2bhk94rgg5Sc0=
X-Received: by 2002:a05:6214:2426:b0:6e4:4adb:8c29 with SMTP id
 6a1803df08f44-6f5353561bemr37943116d6.12.1746513177383; Mon, 05 May 2025
 23:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-3-ojeda@kernel.org>
 <CABVgOSm8T+_kXY78sioUHEcG7rYApfWK2Gfxkrvw94Dz57G0oQ@mail.gmail.com> <681912de.050a0220.383f17.18c4@mx.google.com>
In-Reply-To: <681912de.050a0220.383f17.18c4@mx.google.com>
From: David Gow <davidgow@google.com>
Date: Tue, 6 May 2025 14:32:43 +0800
X-Gm-Features: ATxdqUEJy-YpyvvP5U1JCMB6nqHR1GK4Dy7-fxrfVz-rfLQI6xTA5TKAnyHCloE
Message-ID: <CABVgOSnqtxwYQBbed_-TYr6D3BZJ=MT3KVv-eXUFbnRm1UyETw@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: kunit: support checked `-> Result`s in KUnit `#[test]`s
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009055d0063471c961"

--0000000000009055d0063471c961
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 03:34, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Mon, May 05, 2025 at 02:02:09PM +0800, David Gow wrote:
> > On Sat, 3 May 2025 at 05:51, Miguel Ojeda <ojeda@kernel.org> wrote:
> > >
> > > Currently, return values of KUnit `#[test]` functions are ignored.
> > >
> > > Thus introduce support for `-> Result` functions by checking their
> > > returned values.
> > >
> > > At the same time, require that test functions return `()` or `Result<T,
> > > E>`, which should avoid mistakes, especially with non-`#[must_use]`
> > > types. Other types can be supported in the future if needed.
> > >
> > > With this, a failing test like:
> > >
> > >     #[test]
> > >     fn my_test() -> Result {
> > >         f()?;
> > >         Ok(())
> > >     }
> > >
> > > will output:
> > >
> > >     [    3.744214]     KTAP version 1
> > >     [    3.744287]     # Subtest: my_test_suite
> > >     [    3.744378]     # speed: normal
> > >     [    3.744399]     1..1
> > >     [    3.745817]     # my_test: ASSERTION FAILED at rust/kernel/lib.rs:321
> > >     [    3.745817]     Expected is_test_result_ok(my_test()) to be true, but is false
> > >     [    3.747152]     # my_test.speed: normal
> > >     [    3.747199]     not ok 1 my_test
> > >     [    3.747345] not ok 4 my_test_suite
> > >
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > ---
> >
> > This is a neat idea. I think a lot of tests will still want to go with
> > the () return value, but having both as an option seems like a good
> > idea to me.
> >
>
> Handling the return value of a test is definitely a good thing, but I'm
> not sure returning `Err` should be treated as assertion failure
> though. Considering:
>
>     #[test]
>     fn foo() -> Result {
>         let b = KBox::new(...)?; // need to allocate memory for the test
>         use_box(b);
>         assert!(...);
>     }
>
> if the test runs without enough memory, then KBox::new() would return a
> Err(ENOMEM), and technically, it's not a test failure rather the test
> has been skipped because of no enough resource.
>
> I would suggest we handle the `Err` returns specially (mark as "SKIPPED"
> maybe?).
>
> Thoughts?
>
> Regards,
> Boqun
>

FWIW, having out-of-memory situations trigger a test failure is
consistent with what other KUnit tests (written in C) do.

There's both advantages and disadvantages to this: on the one hand,
it's prone to false positives (as you mention), on the other, it
catches cases where the test is using an unusually large amount of
memory (which could indeed be a test issues).

My go-to rule is that tests should fail if small allocations (which,
in the normal course of events, _should_ succeed) fail, but if they
have unusual resource requirements (beyond "enough memory for the
system to run normally") these should be checked separately when the
test starts.

That being said, I definitely think that, by default, an `Err` return
should map to a FAILED test result, as not all Err Results are a
resource exhaustion issue, and we definitely don't want to mark a test
as skipped if there's a real error occurring. If test authors wish to
skip a test when an out-of-memory condition occurs, they probably
should handle that explicitly. (But I'd not be opposed to helpers to
make it easier.)

Cheers,
-- David

--0000000000009055d0063471c961
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgtWZOZdZAuDJGghy98sOge3obIWgb
sZBJP2EJxUeNElcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTA2MDYzMjU3WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAf1UK/9UyQAUjxGkWPZYh4PBL1uU/h+b0nxtlji0QztEM+xzxwSROiRk7bF7JPMnx
ptVEjM3rKVdsuYsi++U5HSycfpRJ9pEDTZNskk0RIa8H1ci2a29BIxPDPY5SUvQqy3Y+r8Cedh5a
+FN3+h+raNiX0B/jD3iCEdt6E8nArrq5dl+zMLZAC1J6wmbWPRiEYQVOvdP3QPZJ4eALSoNYaiFO
BvFuOaAwwDyInUTu1JIs/P/ghQP6E0HvcmQXRnTTA0fNUnpvKqqFwQ4rHNdgYai3DcbMcFE9bcoa
HcwZfdiIYqsFQ3xwS4ImZXhGt2q2BFIBaiUhNyCh8Igc20tgCg==
--0000000000009055d0063471c961--

