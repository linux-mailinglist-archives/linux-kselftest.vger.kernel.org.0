Return-Path: <linux-kselftest+bounces-32313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8FAA8C01
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 08:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D59B3B52DF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 06:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFDE1DA31F;
	Mon,  5 May 2025 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDzFmJNO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9B1D5CD1
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425003; cv=none; b=gHvwI6c0igjMGIYMpLhGm51uCd8KsqK2XF5iAw2PRzTawjje6q+zqfs8e7eDCrV3V1ETM8TGvfW/jpqnP/TxiVqz92lNiHbfectOkIyD8fNq5gWwk/xlXM4xCME4JGy73mO/akLiH3qCcueeho8hFyoSFzELqq3bSVsHbdq6lI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425003; c=relaxed/simple;
	bh=+LdzW//0vlpxo+25ba47emXlFFm7coYUByB4MEC+nUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiOOdZsvS7B0NjRPmedDYUgQsLCzrzm4WDz2IeI4OENnEPkw9e/O+A/Jx0TM7s6oRbmNDmMn4ZJNkNCnJ04Z/of12NAYaV1uXT5J0APcX3l+fEX9Zp4remfOGzJNI8G3agQQ+pPmQIg+yeVak/C/E6Zo43GM9aAYTU1m5WYPhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDzFmJNO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0ad74483fso50550666d6.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746425000; x=1747029800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+LdzW//0vlpxo+25ba47emXlFFm7coYUByB4MEC+nUo=;
        b=IDzFmJNO+qMAuGKVYuBxol5g2MSqTTqClg+pE/fX9PEWsDPpiywJmqxVnUV2UbKqY/
         xijxi9F3LIMiVGWlHXmQTWQ2rQjcuEKDfe2kvpBebVamcEVwNkWOI0A0wReAV5rBdIUX
         jXFQFa5vaCDtCEDEwF5KRw4xWnyozHtfokrJE6vNHwbV8p64fBfHjzNhU0x42ceB6gYx
         QeQSR7q8/5oRKys9sivyU1UdCF6CV+iGEtmmgXmU5MUsm38Fk6Hb+S3755SWsPY6AZo5
         d+sLi/ENYjTd7hF8Hh0ppwGe6wHSB1AwhTBVD4q1aBuSLG4zQBXiKWmm0fSZgdhwmlW4
         UBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746425000; x=1747029800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LdzW//0vlpxo+25ba47emXlFFm7coYUByB4MEC+nUo=;
        b=l1efuH6T28Avg2vLSs9fAdQX3hoCSVVQ3Ben6SbieTDWKVpeRJKKXZKzjCYXT7/6wO
         hS+l4M4ObsZ5wUsmmpBm+0p83nHlrWT/8D9KWOhDjPjyfGPJJE3fRwtMKiX/3GaZysfs
         o63oJjt7QzvzQI1RbHzOgA4AKXqOKqWDdKN0bUVhTivknj/cvEmRSmfCXys1kVf1p/Oq
         N91Hj+wU1ZjZlcAFvYj+PoBSQDQnLoGvH+XQoDkeg8WuARQvr7n/a/e79JsInH18yYk+
         ZR7NjZlmHeCNZCAMkjYjVQsZnyge30Ay+Ha5lOg53Zqr7s5xaBQqgeOa+zf0ofPFhMM/
         9P5w==
X-Forwarded-Encrypted: i=1; AJvYcCWQNjv2stXuD3/1K2imk4u/DwI77WnAsN12qS6HeTzjoBK1BrWFTza4lsd6mnscO7EOB6/KKgMUJ4UYB120AvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAfa5uaTzfHWhb4jSYXFANNzc2EIdTIniV+T+QlOubZFOXABh
	8Jtm1L2UVEw/yNLuCjZgLn3wpwVcANhAlPnFwKdaF9LLa+PeKU6EVfNWK6tSosiEC87TeLsdowa
	9ICYspKdC0RirL834KAvYI1aad9AFYuo3WOZ6
X-Gm-Gg: ASbGnctSY47Vjxh48vd56Wh+K15610XYzSwlU/3Lp5puchI+uDBuZkTed6qP4xVw+Am
	/RRLogf2dP4exwTonsXyc3rD4rZzvpZRkBwHwC/ib6rKwHVHWyyU75bo2k5e+oYy50q3SztkyUm
	EyV2swpQi91nDc6eMReGiiuWw=
X-Google-Smtp-Source: AGHT+IEFhuCK3QMY81WgIBNq2v94m6B/GUEkcprbog846BVrP+ZTLHFzHeexoEtrNM0L1/E/MZ4o+ontDNfR5zaxFhE=
X-Received: by 2002:a05:6214:5084:b0:6f5:e0c:b21e with SMTP id
 6a1803df08f44-6f52374e3a7mr102534226d6.11.1746425000411; Sun, 04 May 2025
 23:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-5-ojeda@kernel.org>
 <CAJ-ks9k=uxxumgEU84-54u8OxxJVBsUprGk7Ht31ndoumHB95w@mail.gmail.com>
 <CANiq72=Q_Vbfh6YhDsNeCBDPZ-q1d2HNfaTj4azAsd2Q-zPfEw@mail.gmail.com>
 <CAJ-ks9mAgR3N+cxL6H5XhAN-iWM=T66vuWr=LEozj8bqofBf6g@mail.gmail.com> <CANiq72nQeHpZFk3KYGsgGO0Sh2TgV8T2z7Pahkijrgd=T64KYQ@mail.gmail.com>
In-Reply-To: <CANiq72nQeHpZFk3KYGsgGO0Sh2TgV8T2z7Pahkijrgd=T64KYQ@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Mon, 5 May 2025 14:03:09 +0800
X-Gm-Features: ATxdqUEHy61kWwVB9hppFrYxZgxEdcBoiUigAmWGVOo_uWsssjD5qb5pD1-N68Y
Message-ID: <CABVgOS=AKHSfifp0S68K3jgNZAkALBr=7iFb=niryG5WDxjSrg@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: str: convert `rusttest` tests into KUnit
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
	boundary="000000000000cec1b306345d4143"

--000000000000cec1b306345d4143
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 at 03:02, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sun, May 4, 2025 at 8:39=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > One example is https://github.com/torvalds/linux/blob/59c9ab3e8cc7f56cd=
65608f6e938b5ae96eb9cd2/tools/testing/radix-tree/xarray.c.
> >
> > It might be that these are necessary because the xarray tests don't
> > use kunit, and so are pretty inconvenient to run. As you might have
> > guessed, I discovered these host tests when my patch porting the
> > xarray tests to kunit broke the host-side build :(
>
> It can be useful to have some tests as independent userspace things
> (i.e. outside KUnit-UML) to use other tooling on it, but I think for
> such cases we would want to have a way to use the tests from userspace
> without having to remove them from being KUnit tests too, since we
> definitely want to test them in the actual kernel too.
>
> David et al. can probably tell us more context, e.g. I may be missing
> some plans on their side here. For instance, for Rust, we wanted to
> eventually have a way to tag stuff as kernel vs. host etc., but that
> is longer term.

Yeah, this ultimately boils down to a combination of which tradeoffs
are best for a given test, and personal preference.

KUnit definitely has the advantage of being more a more "accurate"
test in a kernel environment =E2=80=94 particularly if you're cross-compili=
ng
=E2=80=94 but is a bit slower and more bloated (due to having the whole
kernel), and therefore a bit more difficult to debug.

In an ideal world, most tests would be able to be compiled either as a
host-side, standalone test or as a KUnit test. There are some (sadly
lower-priority) plans to support this more with C code by having a
standalone implementation of the KUnit API, and things like the
automatic conversion of, e.g., assert!() macros into their KUnit
equivalent could help if we wanted to try something similar on the
Rust side.

But, as you point out, that sort of tagging of tests is really a
longer-term goal.

In the meantime, my strategy has been to encourage KUnit for new
tests, or ports where it's not going to break existing workflows too
much, but ultimately to defer to the maintainer of the tests / code
being tested if they've got strong opinions. (Of course, I am biased
in KUnit's favour. :-))



-- David

--000000000000cec1b306345d4143
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
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAHAzCnLVtRkCgyqhFEoeKYw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTAxMTAxODI1
MTFaFw0yNTA3MDkxODI1MTFaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCoH0MspP58MiGTPha+mn1WzCI23OgX5wLB
sXU0Br/FkQPM9EXOhArvxMOyFi0Sfz0HX20qlaIHxviaVNYpVMgmQO8x3Ww9zBVF9wpTnF6HSZ8s
ZK7KHZhg43rwOEmRoA+3JXcgbmZqmZvLQwkGMld+HnQzJrvuFwXPlQt38yzNtRjWR2JmNn19OnEH
uBaFE7b0Pl93kJE60o561TAoFS8AoP4rZFUSqtCL7LD2JseW1+SaJcUhJzLxStodIIc6hQbzOQ/f
EvWDWbXF7nZWcQ5RDe7KgHIqwT8/8zsdCNiB2WW7SyjRRVL1CuoqCbhtervvgZmB3EXbLpXyNsoW
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg9VCo9AkDzqcO4qtNrYuHU6sfXVr0
chWM2JzFvG8yav4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTA1MDYwMzIwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAgYaeFnOuL2Chg3MMB1Hpg+mzz8/ldCMFcnoVtM4EWho3j5W8WcsskgRAMP69Ohn0
VhQvqJ1oJo7NfsdbM+GIQZMrg07FjOeIBp0v8gz0B/z4Qz8CLtz622wmPruB7gRZioTybkgS/fNH
1RVdIfNEBhZrEfBvZy52EuhGMye4UdH53TOIxaxp9LwWB77bdEo7So9WIKzzOVMXfveiTJQ7XUDg
5vZJ1eaSrcyVqy/00/9IkSDaYA1Q430uLMv+dGvldx5HSYhCwXWIDc1qJPgOUeuIDYE5Q3eH6Ira
dl2ELvB27043cWnfo4mxqqOPRi+uvSuhfV8qNtoicxNUr7N/rg==
--000000000000cec1b306345d4143--

