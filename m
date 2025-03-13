Return-Path: <linux-kselftest+bounces-28878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95670A5E9E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 03:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC8D1762D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 02:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635DA7081C;
	Thu, 13 Mar 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1GJMe1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212DFC08
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 02:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832484; cv=none; b=C1Va5WEuuXYqe87zGUN401EzZf8bpCbE9d9YFZz7Gg5P+e7nTSBVKboY9dkIESRZrvHSr2OPPbocaDn1VJ/5SPTP6ljgWLu19Erhapi2FNZwScTSHta6ugkTVg8XHaS7IQinroZdvz/HBrCmVNbUkK8eNnDVJs1lFRfZaaceINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832484; c=relaxed/simple;
	bh=r2xBjcgLjpye1odJzmIvz0EEQt9NHoV+oWPK3v7vVgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4cbFW68QSN5W1w+nSxeXegyLTWnB0tu8H3DnikPL9/tivs6XQfFBwr8N4HHiPf72ayClt3Ys1Ym76eNXOv5UUpIgSypbMdTevfo82WwucaiaoawO5WJ4ixQBvotxnJXKb0rXvApRObiOSGmrfCyGnaT6P3aEbis/dS9YW3ItLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1GJMe1C; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e41e17645dso4862636d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 19:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741832481; x=1742437281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r2xBjcgLjpye1odJzmIvz0EEQt9NHoV+oWPK3v7vVgI=;
        b=S1GJMe1CEKE2N/1ivgFGwGFpSQ2EriGj5moYyRAzwgG/+xo5hW0JR5/CbH0VlmXXxK
         HGccta4ooiNi3HmxLNYkJzJlaMBwA3rrhXAyptnDcQllKBTfJ8NNAZC1S+bzJ6InFKfx
         46JjHlzVRPKwGI0uARmZL4K27+CbhprZ5OSA0vOy2kESqeEj9dCDXhz9t44YPnPPn+jy
         9BLoXlQNMD5NZE+WhRxoZCtT4dj4v4cVGuGpBOOHwQNCLnR7Pf2MdqinFyhd0GGHz4gA
         tdvYeI0bbn+BPynH3azD5yps/JBsqAAZTOcYoA6Q49OAkKIUZ6oyVNTbhgw8vr0pnjA4
         qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832481; x=1742437281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2xBjcgLjpye1odJzmIvz0EEQt9NHoV+oWPK3v7vVgI=;
        b=VAeBcBv1hNQ6GHJZDbJ2G2ChY6ZkFDDujD/5/UeBJcu2jLtY22oPLgo/XehS/hqz+4
         e9D0GhQQ2zu0BPxFw+aIjoAmZGMxGc3LZGgfCM2KYX8TdJ6E9CLSnvFVJn9mn/VJCgaX
         toV1+Cj7Lbe8ViaD++79H8iVmnZ5P4+zm9Ac3nSqdm6mv0xK2NTD/U3QzcCaD/cPncNr
         NKDDwKMw/Jo2mb6iiy9vGnq0AgLgzi6tHkEntxAEKR+myRHUyjuHjEInNI18Ztovz49N
         6lcLDIh0WQ/qLKBssefC6CvHfWPzVakFCEhdgcu3TGdlXNmp5gHKFy1Zt23mIZS4gvuf
         CzFg==
X-Forwarded-Encrypted: i=1; AJvYcCUXRq94EsAz1EdHiREna6AfKecJTkOdtrB4mQzASGsvfounXjFEqHZvpeTQyyVD44AOrd4BtBL9Kxyn3klJXqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0I79cnRq1O+3qC1BVc74L+bYk7YoSfJB4fgu4hVQxqJ7ltiLv
	VPch+d5Fu1G3s0JN+2pd9r4ChccZugZkAr4DaoXbefnM05/ypufNF9yhDRIkJoid4O5NGHKEvBy
	NgTqQ3SFVXNTQ0oXqQQ2EGdvIXndUN3t4Kd7t
X-Gm-Gg: ASbGncv+9grBeq0Pq4SL7nhZszs7JIScUeYiuv1tB8H9Vd0gi08BJHKJLgSu4ElKGV6
	/C0fAhVPLmTl/GImrXQaMH0E3s9k6ik7RwBS82q1q9czyw/c43X2wfRGFIwsOf07q2NHG5fHiZZ
	OYqU0r5KA4q0ArUCCLYLY1At6++Oo=
X-Google-Smtp-Source: AGHT+IGP98crW5Fhha8uM9r13PhtsmSyTlndImprM3IeeDNzQOYB48dwhLk4K51fN5ikL/6NUct6OtV8Zdk4Z4KWd3M=
X-Received: by 2002:a05:6214:258f:b0:6e8:86d3:be73 with SMTP id
 6a1803df08f44-6e900693295mr404941566d6.37.1741832481435; Wed, 12 Mar 2025
 19:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0842477c-6063-40f8-8e8e-b9ce98711f80@linuxfoundation.org>
 <CABVgOSk+xztNcNJ5fQiRSGC3DKHS2H3kN1wHwAO4gCfG7cWY1Q@mail.gmail.com> <5a1e11fb-4213-45f6-a5ef-636de5e175d8@linuxfoundation.org>
In-Reply-To: <5a1e11fb-4213-45f6-a5ef-636de5e175d8@linuxfoundation.org>
From: David Gow <davidgow@google.com>
Date: Thu, 13 Mar 2025 10:21:08 +0800
X-Gm-Features: AQ5f1JqEFSp6m3zRkGqNU2FcNwccPQSTi5oA-vRJSR-usEC9sCuirt17ENKePOM
Message-ID: <CABVgOSmvKgE6EHcWWR0CnCSjsSkBPsJy_+sDS5thgzuq9=T14A@mail.gmail.com>
Subject: Re: Error during --arch x86_64 kunit test run
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005754d506302ffa9e"

--0000000000005754d506302ffa9e
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 07:51, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 3/12/25 16:52, David Gow wrote:
> > Hi Shuah,
> >
> > On Thu, 13 Mar 2025 at 05:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> David, Brendan, Rae,
> >>
> >> I am seeing the following error when I run
> >>
> >> ./tools/testing/kunit/kunit.py run --arch x86_64
> >>
> >> ERROR:root:ld:arch/x86/realmode/rm/realmode.lds:236: undefined symbol `sev_es_trampoline_start' referenced in expression
> >>
> >> I isolated it to dependency on CONFIG_AMD_MEM_ENCRYPT
> >>
> >
> > That's interesting. I recall seeing this issue briefly about a year
> > ago on an internal branch, and we worked around it there by enabling
> > CONFIG_AMD_MEM_ENCRYPT (which worked).
> >
> > But I've been totally unable to reproduce it this morning: are you
> > seeing this on any particular branch / config / environment?
>
> linux_next - I did allmodconfig build prior to running the tests.
> That means I had to run make ARCH=x86_64 mrproper before running
>
> ./tools/testing/kunit/kunit.py run --arch x86_64
>
> I tried something different checking out a fresh
> linux_next repo and running ./tools/testing/kunit/kunit.py run --arch x86_64
>
> No errors on
>
> ./tools/testing/kunit/kunit.py run --arch x86_64
>
> I will try this again and let you know. Can you try this as well.
>
> - Clean linux_next and run tests
> - Run tests after buidling allmodconfig and mrproper
>

Thanks, Shuah.

Alas, I've tried both on a clean linux-next (next-20250312), and after
doing an allmodconfig build (and make mrproper), and am still unable
to reproduce this here.

I also dug up the old 5.10-based version we saw something similar on,
and wasn't able to reproduce it there, either. (That had been built
with clang, but using clang on upstream doesn't seem to reproduce it
either.)

I'll continue to play around with different setups, but none of the
obvious things seem to work. Worst-case, I don't think it'd be a
_problem_ to make EFI + AMD_MEM_ENCRYPT the default for the
x86_64/qemu KUnit configuration.

-- David

--0000000000005754d506302ffa9e
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgCAK3/4/SoNyL3Z/uINBUe77VHmTl
XsZde7xIw7FGOrcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzEzMDIyMTIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAXWdYMnrkfs6CJSZlJFdve6I3k6i6wZIwjVqB1DZnac9F59ztZnPEON0GS6HaZUMa
fw5HUGxc21PbTtof+/c8sTlKTiD/3Ei9Pew4Sj2/T03Lt50OAQpqX1LhB7yi71oeLT/jQbpGnnhZ
j1PMBRQBLR+ulLlQx3+gyuQEwpcSCwSApMMJWXTE8G8TWILvYx4mXQbGklKzBrylxf6nict3v+BY
J88L9ySrbK3YCIMlpsPAW2xtOQZ93Z8FaHU2nF2lRG/rszsOxunIukdkIXLiD8JzUQF0WLVywGxp
pxw5etSLqY1PT4L9RMxoIxEBP0Zn5I1UvsqXxJ9mmObdyq/RUA==
--0000000000005754d506302ffa9e--

