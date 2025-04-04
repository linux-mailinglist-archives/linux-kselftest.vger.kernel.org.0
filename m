Return-Path: <linux-kselftest+bounces-30095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D41A7B802
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 08:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB383B70E6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 06:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84717BB35;
	Fri,  4 Apr 2025 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASbsPWk4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3319013CA9C
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743749624; cv=none; b=Ckh04hCxR/+PhzT41/b/5/xYsucMThyCFQZG7GsJHDuqNNPkRUq9QIjA03G3lrWqwvgFJrMstqLcvy7yqdUoIGYQiQOS+27SLkrjJZoZQFxz0iuW3Rbp1d9F4cLJqEmvO+W9Jzy3j292ExfhOGx+IebE9Vordf/G7PqTgL0Tdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743749624; c=relaxed/simple;
	bh=jntdyArL+cs9hhyZO7zi/KpV+YTai4jm7/eukL/CzBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IV97IEuwtu2t+Oe0b5lV0kFrrwhHWm/5wvg89vwPevT6NB17xwEh7F6+l0j+Q1Z9uUcEBUNHphMs9nVCNPcZmScfPqj6DDgLmRKWcU3WbEAepx6lLga6GCaGh4jTmVJ0M12ybVfDaOXeoSz0Mi/n/1DjaMOETcvadZCokPIdynY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASbsPWk4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e900a7ce55so25030516d6.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Apr 2025 23:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743749622; x=1744354422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qaUrja+0sBN07D5DzTcsvr7yk2ucrHK1pvQs3FVGZTQ=;
        b=ASbsPWk4ksAqDNS9kexSh+pkQjcr1gFn5wYCxUhSpuwMvX+QUNUIppN8UQ88MuJH9f
         8BomonhpsTZXqW6oTwBmquiEIuBOWCxtY4QDJ5s7n7uk+BiR1BNECJmZiRoGb+1XxRzM
         ea8y6A6ywsWT7n5Z1pI9IxUBdfysVkB8fhc/3ucUkn9rZebqofpbx0GuEDYL1qIm4b8j
         eyq4s6dHyg9y5pwiC5elJbCm/lQ7Fc3ZmBdS8l3SgbnvsGfNo2c9OrWLpamEkwoZvOiL
         PKh5JWCQL0KLeoa/GM7R1VYXkaJE9AR1Fb5veSIaVpwmuQbbCSkIfRsFe/fhWs3HSHIR
         iQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743749622; x=1744354422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaUrja+0sBN07D5DzTcsvr7yk2ucrHK1pvQs3FVGZTQ=;
        b=LZpY3dMB0kBEVca5Vgosnyeyx+ZTot6MLB0wN5aeArzPPmz8JPn0lC46PMFvVPqos5
         ABGVRMfY8YAQjsds46ZZ8W95Jw8gonxioj0ge0Np7XAkEe/j/nktEu9NbmRHx+eMJUDf
         ev3yYqv5tPhPODpuMkezhDzRKPN2J2/8dlSaiog+W4yVeOaNEbeyumrxAREfnNkhTsA7
         7xFXDE+VkVDujcFngThC5oqEGfgZ0E9DLmRgDRbUKXMFl0uGDe+YQ6ndE5w7lsVhdQVT
         V8WYo0HybnVbVgMiD0DShZR39G3itwk/floaYRK3WfZcqW1FeYWIOArjOy3diFs6yGsv
         Fdpg==
X-Forwarded-Encrypted: i=1; AJvYcCVmelDk890FwNC8NReK0pDFIfwgzpoMeTZ7wPUZuMp5vSApOFzli641rKvuIu/tm4me7BX8qC3nOT3qhaWdAtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKZkJnchvRgPQhmbE+6lc+GfREmlKX/6OCDwV+tR0gUJTvHaL
	fTGXcBapPZkbcGmQ3uwqnuK0l76OutF/lXcvtBAZcHYOGC7J7K4XkbLeA3YpgWh9ddi72hugn2C
	DyysPYnlciMOx8PEftgUtCydA9iVt7z2hEuxa
X-Gm-Gg: ASbGnctmnRXdPgWqdDto48m1wjwjAg0GvZ7ytptQN49p0s8ofUphY65QPFEQa8hLiXs
	PzXZE8w1kKHvbHDUbHrtOSbvbdaCxM/4dbty1zH8mZMAoOcbVS3jqrt7cI8fm/AlVluapSZqIx0
	sTHmwEhuH49mmLSeHYxIiq/zFdK1Y=
X-Google-Smtp-Source: AGHT+IGHyKvfclgNmziC2uyFqIIxjNJwuRljdYCgCLzfgJu4ij1eHID1QgPfUyTjpOXi8XGN2SyiOfNn6UVXazEIBR4=
X-Received: by 2002:a05:6214:2604:b0:6e8:f99c:7939 with SMTP id
 6a1803df08f44-6f01e7a08abmr33057496d6.44.1743749621916; Thu, 03 Apr 2025
 23:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402103655.3e0c62d7@kernel.org> <a91811dd-6f86-4af1-8d91-02b990ef2fe3@sirena.org.uk>
 <CABVgOSmSU=i9WvUHFERY--Pgqg3Hr_LxgA9HJ_5aG4F-FgKhzA@mail.gmail.com>
 <d9d9fa47-c926-4479-a0c9-fb6c0713b244@sirena.org.uk> <40aae10e-184a-446f-b4fa-09935e25ee21@opensource.cirrus.com>
 <8f2de668-0ee2-4c8f-a26a-1aa77f6a0108@sirena.org.uk>
In-Reply-To: <8f2de668-0ee2-4c8f-a26a-1aa77f6a0108@sirena.org.uk>
From: David Gow <davidgow@google.com>
Date: Fri, 4 Apr 2025 14:53:28 +0800
X-Gm-Features: ATxdqUEKDJf0bkJrBU6ST885rdSWgRaHkIQM9xP3-_602vYWVNkK9FWo5TQUAuU
Message-ID: <CABVgOSmmU4gcRL=4XPp9+CuA8bhJonv=-CXY7gdQc45LDi7Qpg@mail.gmail.com>
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, Jakub Kicinski <kuba@kernel.org>, 
	patches@opensource.cirrus.com, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d129910631ee58a8"

--000000000000d129910631ee58a8
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 01:48, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Apr 03, 2025 at 05:57:51PM +0100, Richard Fitzgerald wrote:
> > On 3/4/25 14:26, Mark Brown wrote:
>
> > > I've not heard anyone mention hitting the timeouts, though now I run
> > > interactively I do see that the Cirrus stuff is a good proportion of the
> > > runtime for --alltests.  We could potentially add a config option,
> > > though it'd need to end up in the config file so it gets turned on and
> > > we'd still run into any timeout issues.  There's a tension with people
> > > expecting --alltests to actually run all the tests as well...
>
> > I don't want to get into the situation where nobody outside of Cirrus
> > is running the tests. One of the main points of converting our tests to
> > kunit was the hope that more people would run them on more
> > configurations.

Yeah, I definitely agree that this should be enabled by --alltests
regardless: we possibly need to adjust the default timeout for
--alltests compared to without --alltests.

Ultimately, this is about balancing a few different usecases:
- I want to check nothing relevant to my config is broken (enable
CONFIG_KUNIT_ALL_TESTS on top of the existing config)
- I want to test everything I can in my tree / CI system / etc (run
with --alltests, possibly several times across different
architectures, or with KASAN, etc)
- I'm developing something specific, and want to run all of the tests
related to that (use a subsystem/driver/feature specific .kunitconfig)
- I want to quickly check if my source tree builds, boots, and is
vaguely sane (run the "default" set of tests)
- I want to run tests on my ancient/slow machine/emulator without
waiting all day (run whichever config makes sense, but filtering out
"slow" tests).

Now, my gut feeling is that we definitely want to run all of these
tests for the --alltests case, and also for the "developing the Cirrus
Logic driver" case, but that only a subset of them need to run in the
"does my tree look vaguely sane" case, and there's limited (but not
zero) use in running them in the "I'm testing my config which doesn't
have any of the Cirrus Logic drivers enabled" case.

If that's the case, I think the ideal solution is to:
- Make sure these tests don't automatically enable themselves if no
driver which depends on the firmware loader is enabled. (e.g. make it
depend on the library, rather than selecting it. If there's an extra
"dummy" option which force-enables it, that's fine, but that shouldn't
be enabled if KUNIT_ALL_TESTS is)
- As a result, make them more explicitly enabled with --alltests, and
probably disabled -- or only run a subset -- in the default. Currently
this is mostly decided by whether CONFIG_REGMAP is enabled, having a
specific item to use for these tests would be less surprising.
- If any of the individual tests are particularly slow (more than a
~second or so on fast hardware), mark them as slow. Most people still
enable slow tests, so they'll still get run most of the time, but they
can be skipped on old m68k machines, or gated behind the quick tests
passing in CI systems, etc)
- Bump up the default timeout ( at least for --alltests), as 5 minutes
clearly isn't enough for, e.g., qemu-based emulation anymore. (I'm
happy to do this: I've got some timeout-related patches I'm working on
anyway.)

Does that seem like a sensible approach?

Cheers,
-- David

--000000000000d129910631ee58a8
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
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgSBETq+SDwRUvHZxlV7tjcmnQoqDF
KhqRnxLw4nRRitMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NDA0MDY1MzQyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAf0/rQtqDbRVbjS5sH6JPgBlcQVXbsVMDzUgWFMRZYGeEl4tm0uRWLcQOtSNjMvao
50o/D4E2DZsU6ep5OHgKmeLb0pl7M+N7Guq09FRTX6Exto/aI0Zsd90B+lXv7E01zlSblwqjoQQW
GFnJOmQz6S7tUE2DpBW7xJhjAUq9giv3QQy/CBWsSNaGTexECSD6NZgxpwNaKAN22fa/jJ6YWZuS
QurcTc8hiIaGJ6oDcWb8G2f2x5dqxE3WDr77rEfmBBvfc7hAeSllgGPYYhyyN01WJ3GzgH1wfDS2
WkfDDZklkXoch55e6P1/fN6ou4O9sq+uv/UMy5yEh14WguTe2w==
--000000000000d129910631ee58a8--

