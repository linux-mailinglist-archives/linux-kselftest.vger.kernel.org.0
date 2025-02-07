Return-Path: <linux-kselftest+bounces-25978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9EEA2BCF5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 08:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F0188B54A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A151A2C25;
	Fri,  7 Feb 2025 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIBUX6d/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FE233D7C
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738914919; cv=none; b=i1e9by2AhoOejklUHR0K2VZtvQVMFhvGe5dXDEefQ89mtM4y5gJPPF6o/16oBLL/q383oXh0QMeD2rASNqGsVWRvm8uh7oqna90Wh7xjs/cGt14UsX4qttUQ8JoDQfBh/eVOOfH/MWpLI0JFrz4PvRfZGUKxyATT1O+dOZsfmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738914919; c=relaxed/simple;
	bh=GUFhr7Zca29CcyhP/s/01gEz8dHT7N67YrKE0c3Uzp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct/D5heCt8jg6Paayk9d2bqeAzXjipKDfaSkv5Smy3HlOM3kb1uL2hQIlXmcnAKp6fz1kBdHpz1FjQ3VDRbOA6Pwm6Od5hqzd/4I3ZfOSM5AerAnyvipFk/Jg45uqj0VAoKdO+bLRqI+fZpixXMnr2I8vdRuwnP1bQRFNDWA/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIBUX6d/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so17770566d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Feb 2025 23:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738914916; x=1739519716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lhiPVH7lOyt+j2ytlGslh9LPz3HKfEJcyfq1oZEx4YI=;
        b=GIBUX6d/+yNc1UBbpQJC+bDsXIkWiYZejQheQP3rK10owbDUqwGFitCeY9TP1Yzdbm
         IXz6q74O4WExu7Fv9gAOY19aVMyCW/ROkgerJ5y4iXOPcJ/jMJEFg9NuUcSRH7WVGR7e
         YMqwX7saJFwMv26Czcy5L+/tsPP1uyOFOncYDEe2jqgXGZTLokVzUt5bSY5mMEV1kYhR
         PgO9YXcTuAmtObNPjYWjCMS4scA0HEK3b4V83a0wwC/uQlV5jh0bowcf/GwP7Z4/TFKV
         Xdh2BrN6xsXKlnDdnPEYoeoqGd3GT0dFXf1V4X4o9k1O9TPcWKd7GjoSh6r1djCoe2wj
         qH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738914916; x=1739519716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhiPVH7lOyt+j2ytlGslh9LPz3HKfEJcyfq1oZEx4YI=;
        b=bH1ccbnkIy6Z5lTfa/n+lC+2JeytJcgT1/V5hiJ9Ag5sljWwJw4+FxQMzZWda/7dqP
         yJdzT2j7FcI2ujTbr/D9LARXoWQ9pRhJVG2sxxpjr8IChDsVt77P2a87FwATX9lWZmz2
         njeEa8P1KBaGhhUHo2A0iH9lHY9ftjnD56E+RKBSfF84HpMEupDOeWBS4ajj0b2etPfO
         5r5/akv0M6uRwOH+Y0Q8A6rN2MdOXn9jVKpPk5ph8fFQBl1dgL6or/PvsBPztnDlxDZk
         bRKjAiM7pUu4paqmVteThB7+U6aVHyLpCFRdliZS3gjjwV8DBBG/g7WHDMTCPAutpuB8
         R37Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdvg5vjTxFBIgq17oXfoZ5rLSZBwcivt7QRLVm0jRkWDLM3rCxJSIN8Cp5+GhS7uHFbvzMflWLSnL12oacJxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZDR9mrQE4N9gd1+nldmETGShr3w/nD+LLUpzEsxDmu2Pqduf
	pdadFzKsZRrS22bL/Oe1TpC9wlm4t0al1BYh/9IurliI/PedyFQqbIm9hWn1CPi3TwclS90Ta/e
	6O0Ks1qYo/u+bKFQ+bGC1fa5qik6wCKGgYS3W6FnzEswxDoEo0rCF/bM=
X-Gm-Gg: ASbGncvqQwFTg9NzzwNFCbmQ/JAS2sKhpsoe7+3T1FmYs/GveTUt8kucu723arHvfUC
	nG8zkk8zADx+wn1fwdWACDoZLzx1wHmBbXx9YMog0gOfBF9BbU5Gwvi/nupPUz3pRDJZZKzN/OQ
	==
X-Google-Smtp-Source: AGHT+IFCNsumyeOHiqkcOoacGlEik2Lj2uDIMKD80TUQNKeDUM5p7/U2J/eKmUsdladoNscWe3soAuF7sCf9WOmCiE4=
X-Received: by 2002:a05:6214:5098:b0:6d8:aba8:837b with SMTP id
 6a1803df08f44-6e445717b8fmr20625736d6.41.1738914916027; Thu, 06 Feb 2025
 23:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
 <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com> <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
In-Reply-To: <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Fri, 7 Feb 2025 15:55:04 +0800
X-Gm-Features: AWEUYZkkoEwLRUZgbNWNsQJ3KGH60_380LImotgycakidO9ZW74rmCI4GAG9KPo
Message-ID: <CABVgOSnyh__y7W8+txaFQwDKPxA75aCHW1O0TvTxpFojc9pQaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e615fb062d88ada1"

--000000000000e615fb062d88ada1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Feb 2025 at 23:42, Tamir Duberstein <tamird@gmail.com> wrote:
>
> On Thu, Feb 6, 2025 at 4:27=E2=80=AFAM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > On Tue, 4 Feb 2025 at 20:36, Tamir Duberstein <tamird@gmail.com> wrote:
> > >
> > > This is one of just 3 remaining "Test Module" kselftests (the others
> > > being bitmap and scanf), the rest having been converted to KUnit.
> > >
> > > I tested this using:
> > >
> > > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=
=3D1 printf
> > >
> > > I have also sent out a series converting scanf[0].
> > >
> > > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-3=
86d7c3ee714@gmail.com/T/#u [0]
> > >
> >
> > Sorry, but NAK, not in this form.
> >
> > Please read the previous threads to understand what is wrong with this
> > mechanical approach. Not only is it wrong, it also actively makes the
> > test suite much less useful.
> >
> > https://lore.kernel.org/lkml/f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmu=
svillemoes.dk/
> > https://lore.kernel.org/lkml/876cc862-56f1-7330-f988-0248bec2fbad@rasmu=
svillemoes.dk/
> > https://lore.kernel.org/lkml/0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasmu=
svillemoes.dk/
> >
> > I think the previous attempt was close to something acceptable (around
> > https://lore.kernel.org/lkml/57976ff4-7845-d721-ced1-1fe439000a9b@rasmu=
svillemoes.dk/),
> > but I don't know what happened to it.
> >
> > Rasmus
>
> Thanks Rasmus, I wasn't aware of that prior effort. I've gone through
> and adopted your comments - the result is a first patch that is much
> smaller (104 insertions(+), 104 deletions(-)) and failure messages
> that are quite close to what is emitted now. I've taken care to keep
> all the control flow the same, as you requested. The previous
> discussion concluded with a promise to send another patch which didn't
> happen. May I send a v2 with these changes, or are there more
> fundamental objections? I'll also cc Arpitha and Brendan. The new
> failure output:
>
>     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
> vsnprintf(buf, 256, "%piS|%pIS", ...) wrote
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
> vsnprintf(buf, 19, "%piS|%pIS", ...) wrote '127.000.000.001|12',
> expected '127-000.000.001|12'
>     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:131
> kvasprintf(..., "%piS|%pIS", ...) returned
> '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>

This failure message looks good to me. The ones in the current patch
are very verbose, and while the memory comparisons could be useful for
the overflow/buffer size tests, for simple string comparisons, having
the string in a readable format is best.

Rasmus: the KUnit framework has since added a summary line to the
output by default, which should also make this less of a regression
from the existing format:
# printf: pass:28 fail:0 skip:0 total:28

Cheers,
-- David

--000000000000e615fb062d88ada1
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
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgvCt6fweGnir8UW8Bv8uA5cofjZIZ
gzA6RaiYqcrLXFAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjA3MDc1NTE2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAAilMUjkk0UdgcQsfBKE57z2ochZOsHbmMXa1z8+eAavrTUm
LxrAQ7QX7jpC1F+jJGtBq0VGvBOyf7duQTJt3TDIBuh4fwmDny34MatVeP/5WGIQ8MaTsQzTqRoz
sN+wEcM+KpMEWuhI9zP0fyfbiAGJtBtLaibtXWRZfXWvVeY8UABA7wPLc0qp+LhkTKiywqYzP/8y
CXwoqnBWWCtslxGCIMsG2ShWa+ysNDAz6hBRxCZLgN7HCi4r6NtqKkHXjxw86OwM1AMAZnvukXxB
Oq0gG2JUWrwDQdvyeglLXx3npVLcqd/8eN1FFRO+ml3fEPzCJ8DPNR1bd0UjPpVx0lM=
--000000000000e615fb062d88ada1--

