Return-Path: <linux-kselftest+bounces-21081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358269B5AFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 06:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76AE285654
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DC182899;
	Wed, 30 Oct 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVGDSFkE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15993192D69
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264410; cv=none; b=FwOOtpv3GpW3eJBm9fp6l35yBY1khYJLRj9GCaOtoKK+MFOSnG+g2NLPslJ6char8QB/QScn0DRF28Eu1c1HnwXRbZzLhMeabNaQZTJV9Y6Q3eHvvGMLCnhc6BO7fwVrI9viskZ5jZiv7zoe0ewR6iKaEIQF+nYI7u9VGYzNd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264410; c=relaxed/simple;
	bh=DpT9JBeChlLzObTI287V1W95SDFJ1PtArZfyEVgwgYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtTh76RUi/Ia7btV54XrIG8vgyGe1Y6nBqnwZ9rHET1A+34Tk/+hyjxA5MqkNvrNGMb0eKvsJ/bWWOz5xmfvuW1Wx+lrm9y+CLphunEi3WcVP8/+E7xU12rTXWLrJAsvRW6c4eWO+kgNrzObuId2qgS2OQArSYKy62bUnx8VglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVGDSFkE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbceb321b3so43904526d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730264407; x=1730869207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=18KcmeZin9FPseXM/aloc5uVz3p9ZxRU2sXpzTtq4NE=;
        b=gVGDSFkE9mZaZzRjBx74we/Vb/3cr/szyyGBZtrz31A9Hx2VtbZW4OzV8TxhE1sZpE
         mZKtI7aVraR5d8/hKgkbTFukzVzRb5ji7d+5EDLUxQIGw047lCVlzrS3o9IWHNqMTTX8
         e79ZFonmK3GXHWgdRqOJaSemsnh7q8g3bpHguxRCpQI2LjfoWC1oCkIZ7dnIvaTvxtuL
         jcdSuSo+JZfrpWwtxSrLLR67Mnliy1O5sZpsJMQdCzmQ6jMSQR8xUNJBswUSbua2Sogc
         CqEtXDDx7axy3aSDgqW6ez06ySitxgWQvmyDep00uh67Uun1YOj1Isk9fyLGhi8RL/Vy
         daeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730264407; x=1730869207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18KcmeZin9FPseXM/aloc5uVz3p9ZxRU2sXpzTtq4NE=;
        b=Sy1ToSxYICs6dhiq9akGuR2t0GDlNG+NiNZABpx3+qm6TfZMy3utdL4UIoca0/Jrxk
         TBztze3vze35PnAvR/MNGSFozLqmjGL+aemx9PR70smRWWAXvQIFJgO/IGelzHetrDjB
         dglo5FZHFy86iTDLbCSivqQnW5BpfrWiNYPPuTAK42cS/qkLxsO71WZpZDW2cogkY+NJ
         O3HKP9e6REmShQ4oh4PGNAqguOS4e4vnGMzbfGcvRctTK7OVvdmjO8K+hEqKr0C6spcL
         DTwI6o77m0d4ArlCy6fSmljzvvBUJm0mNzt/LZ4Ld3s7+17G+V72UfVmk2b1Q9rpbzEH
         wpqA==
X-Forwarded-Encrypted: i=1; AJvYcCW/VV15e7p9R6BeEGJDo/3kUpXYAD6JlX4JDYkXgmlUtwt/9M+Bv5J/IYsXFcx+oRX9TVR2xEdl1NnPC6e6trw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+PSu14mLElKF7dsgeLbDUHmtZ1djqhsCEf8/FJeAE9IEbM6Tb
	ABBbh91lyOiKqL6QUYuCFMgfN1bkYiGTzg94sSmrdplcwRvFOAUsoKYXoBApFIn9ZSBUn3jzU41
	U/WaMK3KXbolAiPIuP1+ila9xihEBwGmNE8id
X-Google-Smtp-Source: AGHT+IHH0QHGaX+GSj34u1/5JgSJF7GwsrOiWP8LwULydSGQYhOVTcYwvsHeAZeMo9Bg3CIRBsKZz3j1MzXVoaT2iPE=
X-Received: by 2002:a05:6214:320b:b0:6cd:fa19:2b64 with SMTP id
 6a1803df08f44-6d18583747bmr189033556d6.39.1730264406939; Tue, 29 Oct 2024
 22:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029092422.2884505-1-davidgow@google.com> <20241029092422.2884505-3-davidgow@google.com>
 <ZyDUsFaZt2WViQL8@boqun-archlinux>
In-Reply-To: <ZyDUsFaZt2WViQL8@boqun-archlinux>
From: David Gow <davidgow@google.com>
Date: Wed, 30 Oct 2024 12:59:55 +0800
Message-ID: <CABVgOSnMNAVJaC70yDB6cJa-Mm7c9EoPNtYTQp3aybqd3cobpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: macros: add macro to easily run KUnit tests
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005ea18a0625aa93f5"

--0000000000005ea18a0625aa93f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 at 20:28, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi David,
>
> On Tue, Oct 29, 2024 at 05:24:18PM +0800, David Gow wrote:
> > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> >
> > Add a new procedural macro (`#[kunit_tests(kunit_test_suit_name)]`) to
> > run KUnit tests using a user-space like syntax.
> >
> > The macro, that should be used on modules, transforms every `#[test]`
> > in a `kunit_case!` and adds a `kunit_unsafe_test_suite!` registering
> > all of them.
> >
> > The only difference with user-space tests is that instead of using
> > `#[cfg(test)]`, `#[kunit_tests(kunit_test_suit_name)]` is used.
> >
> > Note that `#[cfg(CONFIG_KUNIT)]` is added so the test module is not
> > compiled when `CONFIG_KUNIT` is set to `n`.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > [Updated to use new const fn.]
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Changes since v1:
> > https://lore.kernel.org/lkml/20230720-rustbind-v1-2-c80db349e3b5@google=
.com/
> > - Rebased on top of rust-next
> > - Make use of the new const functions, rather than the kunit_case!()
> >   macro.
> >
> > ---
> >  MAINTAINERS          |  1 +
> >  rust/kernel/kunit.rs | 11 +++++++++++
> >  rust/macros/lib.rs   | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 41 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b77f4495dcf4..b65035ede675 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12433,6 +12433,7 @@ F:    Documentation/dev-tools/kunit/
> >  F:   include/kunit/
> >  F:   lib/kunit/
> >  F:   rust/kernel/kunit.rs
> > +F:   rust/macros/kunit.rs
>
> I cannot find this file in this series, and it's not in the current
> rust-next either.
>
> (Did you do the same thing as I sometimes did: forget to `git add` a new
> file?)
>

Whoops! Thanks for catching this: I somehow managed to unstage it
while editing things. Fixed in v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-6-davidgow@g=
oogle.com/

Cheers,
-- David

--0000000000005ea18a0625aa93f5
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgPAyP4AAnd7JAtu8c+z0YthIQ8LZ5
cKUw+WB7cRJ1BTUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDMwMDUwMDA3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAA7X0oZhc9WuVvjL68/zSllhDrdDMOzOh5J/WdmKeNMEWR9F
I/GdovrWx+sSR9JvFumhDOwB5a9PPPvBR6Qhl4souYiKbFps3Q0RwhulX/acNlzxgONETWlU0JB1
nl/pnflUwiTwW8X+jPO+fw3Q64qAk4S2IAiWhEPbYBFcHto1dC9kfNRxOfH9j05ctnSCAhYW8wCm
UaixS59HphPLFP4PzuF5Mq3qUdeCdfO3kBroHPMzB+ACAuQhVkYTFF2GdFjNA/LKodtaDbHe6JDb
6tQWSs6qScCwNTC23YKUXqM156Ew0Czz1sXSNJmylw/rk4P6eSYXM5yEGCjm3gAkXvo=
--0000000000005ea18a0625aa93f5--

