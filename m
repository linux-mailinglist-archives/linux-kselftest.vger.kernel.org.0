Return-Path: <linux-kselftest+bounces-21278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB89B8B44
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 07:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A62F1F22E7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 06:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417F14F9F8;
	Fri,  1 Nov 2024 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXaKFNOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD114E2DA
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443499; cv=none; b=N3iFK5fbVT3R0bHYNJ5t+yvB0dj18vDtxvVxRhxVGRIEPCDpFmQOFio4fFCWLoIkw1bd47/PmGfuY1YigRPL9dBW1QJF52hIRoYNZ9MBv8Oufo3226OkDnGCCT023qYsQSAlmICdxI7B9VJRlNIGTerw79bsZIAwuqTOCqGU0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443499; c=relaxed/simple;
	bh=xTrkWaDI9UlUagFxejHuRO3WtiEuEyp6PpjgB7iS6NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzdGjgyhH4wd3sQOjWdYEPQq7uGzuuhulBJhjWXJzupxIGO4P4tDbP4zsJnt6EDbP6gYEH2uAa59c4EgnYQsiwI41O2HGTZsLyvaFPdfQjNSKlsjHRDZ/rfZ3LmkCq95uGbQQ6CuRTf1hTpbUyWUsDXmLATiRD0YhxBKvNyucS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXaKFNOR; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d5d6f9fdaso569068e0c.2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730443495; x=1731048295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nuk0lRsUgT5b5NRk0wkWy6f3+d6IfHvwQ9tii6yz/sQ=;
        b=WXaKFNORfCzzYsBlwjySltRf6rlSuFB0VZ8561Sg8Hc+Gsls+y42fnoaV1HhJYz0BU
         PvHK4qVXf+RSoafd54c2KZWJemWHuf7TSMFFniIto4njBDOOx7jdQDIaAfKUm5gpk86G
         T7lbG76zPbET82aZLpssdKpeYVn/yENKCN2umAm3yYeUH56yfPAqEDkkPuGYUOhVW/Ui
         WCyyWyjAR9G5oQDS4Cg9fOhk1iw+dXKHi8K+1c8KymL5WtPposCqI2hby/yOO/Sblpt8
         W5hpxJHSyW4gG6YHIQWPlHsypLH9696kRdtmRf8eaWMgctuCr/3e9HivhfrTlcYFQkFX
         2hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443495; x=1731048295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuk0lRsUgT5b5NRk0wkWy6f3+d6IfHvwQ9tii6yz/sQ=;
        b=uB4gvwY0z4gHuTzlNJuUmaU7bGteeDQamMhBlnz4y7Jub7a50m8AwwEZhh+g+tAk4S
         GsO4uvXjvBUHkxguI5VYdxPKysUZNqAKHx/MtxpUue/8ezcmsHX56S3QNsP/sLLKwwgm
         Bp5JQE5kIx2s5vFNfYPceMCg+E+nu5tAJVNIzZpc8gURMObvbd6ZT3sQyDmLuPLvnoDl
         o/nBcuibPGZ5+Ino0iKJBJ49ItYRiDDXxY+INvPDkfLQ31LMuXMlR9I+Sh72s2g1EHIu
         JubOqgUzi954NsMgWrYo8hZgR2e7Rq9uVBdwOGgzpT6yoImu72EbTEraHPmeQAy4uWtW
         zdIg==
X-Forwarded-Encrypted: i=1; AJvYcCWyN/iWgSRrHYoQYoNHdtG+/TIv5u+2ny+bF5Fae+RdxL7IkO9Cb+USxgb+MShuUJpNwzr7cCk40qb8hI3sCXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JNjf5j7Nsd9HcJPAGwKdwXwR+AgwgKZmkcCFsCrg97DChJhX
	/91L1/YvsSEAYyLI3465MmoTZavSgXbqk3e0N8rG9mvsrHZ+vAsQaYHw8NDPDGywW4Oq4qJXO0u
	btVBNlcRqG3vEklmyz2KA8TOq5NrseVBKNZPs
X-Google-Smtp-Source: AGHT+IE6QSLeeS25BjxALtdn9mpV49Jf+K/eK2V/hn8cJwE6/yZj3cln5i3RQiehMM4EsQnWUDCg8U3WLDjvc8szko8=
X-Received: by 2002:a05:6122:d9a:b0:50d:5654:951 with SMTP id
 71dfb90a1353d-5101502d012mr19255268e0c.5.1730443495347; Thu, 31 Oct 2024
 23:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030045719.3085147-2-davidgow@google.com> <20241030045719.3085147-6-davidgow@google.com>
 <ZyHACjac2gk4M5MX@Boquns-Mac-mini.local>
In-Reply-To: <ZyHACjac2gk4M5MX@Boquns-Mac-mini.local>
From: David Gow <davidgow@google.com>
Date: Fri, 1 Nov 2024 14:44:42 +0800
Message-ID: <CABVgOS==nuX4RUv8XHoexxwo9bJr28OSDZLJzFjXtCNh7ew94w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] rust: macros: add macro to easily run KUnit tests
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e08c420625d4457a"

--000000000000e08c420625d4457a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2024 at 13:11, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Wed, Oct 30, 2024 at 12:57:14PM +0800, David Gow wrote:
> > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
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
> > Changes since v2:
> > https://lore.kernel.org/linux-kselftest/20241029092422.2884505-3-davidg=
ow@google.com/
> > - Include missing rust/macros/kunit.rs file from v2. (Thanks Boqun!)
> > - The proc macro now emits an error if the suite name is too long.
> >
> > Changes since v1:
> > https://lore.kernel.org/lkml/20230720-rustbind-v1-2-c80db349e3b5@google=
.com/
> > - Rebased on top of rust-next
> > - Make use of the new const functions, rather than the kunit_case!()
> >   macro.
> >
> > ---
> >  MAINTAINERS          |   1 +
> >  rust/kernel/kunit.rs |  11 ++++
> >  rust/macros/kunit.rs | 153 +++++++++++++++++++++++++++++++++++++++++++
> >  rust/macros/lib.rs   |  29 ++++++++
> >  4 files changed, 194 insertions(+)
> >  create mode 100644 rust/macros/kunit.rs
> >

(...snip...)

> > +    let new_body: TokenStream =3D vec![body.stream(), kunit_macros.par=
se().unwrap()]
> > +        .into_iter()
> > +        .collect();
> > +
> > +    // Remove the `#[test]` macros.
> > +    let new_body =3D new_body.to_string().replace("#[test]", "");
>
> Yeah, I want to see how you do it this time ;-) So if you do a
> `.to_string()` on a `TokenStream`, you lose all the span [1] information
> ("span information" is a term invited by me, hope I get it right ;-))
> e.g. if there is a compile error in the test code, the compiler cannot
> report the exact line of the error, it can only report there is an
> error.
>
> Last time I find how to preserve the Span:
>
>         https://lore.kernel.org/rust-for-linux/ZMba0_XXZuTgWyWY@boqun-arc=
hlinux/
>
> Hope it helps!
>
> [1]: https://doc.rust-lang.org/proc_macro/struct.Span.html
>
> Regards,
> Boqun

Thanks. I managed to get this working, but just ended up with an
uglier version of your change, so I've copied it in and added you as a
co-developer for this patch in v4.

It made clippy catch a couple of warnings in the example tests, too,
so it's clearly working well.

Cheers,
-- David

--000000000000e08c420625d4457a
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQguOlSbSYWsz+H9P1aupmpTgesWb0G
rvfIzLFJnPqcF6owGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTAxMDY0NDU1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAHOrbyBbMnsnbVX9UnJUt+yHxgLXFV8OybvHjaBzVf1g+koh
laW2/e0qLG6lX5xqqFx6HBtuseX567IKw8JzK5iRoRpIrKV3vnqs8tJ9Y/e5mWVppe9aHsW6wWSj
FIDuMIX3IJO4kKsVbFr8Fajfa3daUjPoi9OEzU+cMjnjODXy2hZ7Ey5P7U9K2YbOYHKgVVPcwm51
k15aIpAS4lx1jW8Q1rqUDAk9/BZS2TNxygf7xfKkhwTQ8YoP0dQfrBWU+G6FlksETFY1OLamczCs
tutMRBwhlUEMK4bapkD4VZQ5U+yILyddskjYPKrJNn1d7Lrty2fJGhehuL72vaRCaTI=
--000000000000e08c420625d4457a--

