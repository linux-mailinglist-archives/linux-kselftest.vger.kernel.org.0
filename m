Return-Path: <linux-kselftest+bounces-43364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51607BE66A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 07:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD4C14F4641
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962EA30DED0;
	Fri, 17 Oct 2025 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2ZqXjgx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626630BBA0
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678933; cv=none; b=jddZW/+HeGSrOhLw/Eb9fr4P7iqlVJvtLNRgqqvawE9le19iE4T3rzOD/Qgo6WxkuMiHbpESTJD1mUL3mcA9drmt0Tir7WhBJCe4y/wDpROJ+O2WyFwnTQePwi06PoAvma1TOAIboN7KyWEtXbs4J5Q/n706BIaYlsZc2FZ1YQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678933; c=relaxed/simple;
	bh=+RP5M6Ofaotr4J/ZBwHDwlhKntASOvBpq8A14vx9WNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrZXM09KNgM5zVkXzdYkbhI+NDv80C7wWep/5e3tE6s+R2+cRYB7PFtJC4Ii8qa/7U6tou7g2SwviGfP7UXmPTh9kgtv92Vp334emoS3tkIGp/bB5WI5VEgJQG0T+guN+KW3I4j5/2kTEtzzYApPYv5oWFooixy7ghQWQkRqnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2ZqXjgx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-79599d65f75so19786926d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760678931; x=1761283731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPgGgwHiZ3frP5HKT72MQAd0DBt2fdga1yg+MkWtD4Y=;
        b=L2ZqXjgxaut59VwkXs+Z72r5jgZHpi2B0MAQHz37aEhckXKx05La5iutI7mhNpfvg7
         ctSc9w2jOBUAeGyd5ULNdGeU1xRrNs+OZqYjuEVSsGuZ4KSUz8hCV5ZRXJF6lSkuN3mh
         tjQ7SYidhPIh/IH6Voa0kHafW7kujW5mZMLr/qynSceCRaz5jLSuqK+iURpjmx7vzV8Q
         t6royD+BRVHWpWhJoa6as8JB/Sx8UJIi5G5Sq6pAvUUIrX6VhLla8WK1QbokUb44Tjgu
         akhSSlP6P4BzI8fMkjAoK6jQgZKuiJXlYTpO3RWNBJBKis/jHesY2MU9YqG1D0ZvjfHd
         ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760678931; x=1761283731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPgGgwHiZ3frP5HKT72MQAd0DBt2fdga1yg+MkWtD4Y=;
        b=WUufy5/c/bobnM9zH/VIH+fPtais6MzvMSPhClqbAl795FW8X2pBoqbEYB4a0R3zp1
         2pq8ksuUahpHglsF/D3TLfB2lbKfzdgc5eXsL1YHYLLaSwmNyMz/mEtwPRCpSvieZp+r
         OOcY+ku/ALfMIm3+HcVO5d885LM80cX96qcuLS93GHhhFpldFdkByvoMQqcpD8F8/b07
         RG0+PpbwTWn9tkqZXbkSteIsk45kEDYOojAouI28Lh0H7lETdXg6dQ6y4UFqFoTK0qPG
         1FTLr2ZK3K448rdNOlEs4sxXX6sLQ/T4d18U07WWupJFohjL3R6ipJoQ2jUUtU2hjgwE
         CCfg==
X-Forwarded-Encrypted: i=1; AJvYcCWWcNBjse9Bds8z6xoyDE7okI3uM7cjxzYhh6ZrTVa0JGQe7he87uIaL6kueNRgwWIHVTIY8v7c/1MI/j1R6ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6XL+4ZOh317f1duxzXF00fQHTSvjKYF4MKilsOO9NUzgoazC
	y5fJ+CdBWP4aZmlVV8iyp7KZBpCugurqzaSSz1oakCMcJo1ebkP3xRSne3F11uYohMo/9CoYYId
	yGS32zHRiiFl4oB9fyfH3cD1bId6ar9UtvV+PoeNI
X-Gm-Gg: ASbGnctmNVk50zaKO4gr+lq/eoO9ZJhZDWEW7iP/co8ti8sJimnHmUMAbguRATwRLq1
	kE3lW0d9u8+G1qEUFINCj9F+YcCXPgV6P9uZ5ztiE9wzr/ze7usXEwafmpq/pHQn9d6TlqiPWZi
	qbajzzLY+ysFCJkoIGCtTtOA/cs2gKeyn+alAA70YkyFEG1m+ssRIwyQrxuQgh+bNX3N7aQeAg6
	4pn0m8GWSnoR572e+NJcwEIc2zEPR4Vw8Fou/D9WCFLXO8ybZ9XDk5nrfN5ZSk9kn+w4w==
X-Google-Smtp-Source: AGHT+IGf+gsQTZjM8hRPFlQpqHPtWROw5TObb4gokICJ9VZl9H7hVHs8qzgr9HR0LJhw56gpueyrOzrvgw60PmxkpCE=
X-Received: by 2002:ad4:5d61:0:b0:87c:2847:f7c4 with SMTP id
 6a1803df08f44-87c2847f8bamr3029636d6.23.1760678930338; Thu, 16 Oct 2025
 22:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <766a96de401a2c4361867144567bbc31edcf1a9e.1760535996.git.robin.murphy@arm.com>
 <dbc6ec47-78a7-45bc-8df3-4f009731d302@arm.com>
In-Reply-To: <dbc6ec47-78a7-45bc-8df3-4f009731d302@arm.com>
From: David Gow <davidgow@google.com>
Date: Fri, 17 Oct 2025 13:28:38 +0800
X-Gm-Features: AS18NWCA7Te-p5XqMpA2f9PAKmkYxNk6ZXGjb8B2CJmOqex9hgOGCguGm2_q-Pg
Message-ID: <CABVgOS=NfRcXYzJVMMKqeXP8SyTewffwb7vdGN1D8esO2f0KOA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Fix kunit_device_register() example
To: Robin Murphy <robin.murphy@arm.com>
Cc: brendan.higgins@linux.dev, corbet@lwn.net, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003f3d4e0641540205"

--0000000000003f3d4e0641540205
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Fri, 17 Oct 2025 at 01:45, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2025-10-15 2:46 pm, Robin Murphy wrote:
> > kunit_device_register() only returns error pointers, not NULL.
> > Furthermore for regular users who aren't testing the KUnit API
> > itself, errors most likely represent major system failure (e.g. OOM
> > or sysfs collision) beyond the scope of their own test conditions.
> > Replace the assert with straightforward error handling for clarity.
> >
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > This seemed the logical conclusion by inspection, but please do correct
> > me if I've misunderstood the intent...
> > ---
> >   Documentation/dev-tools/kunit/usage.rst | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 038f480074fd..3452c739dd44 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -873,7 +873,8 @@ For example:
> >
> >               // Create a fake device.
> >               fake_device = kunit_device_register(test, "my_device");
> > -             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fake_device)
> > +             if (IS_ERR(fake_device))
> > +                     return;
>
> On further consideration, I guess kunit_skip() (as used in various other
> places) is actually what I want here?
>
> Basically, as someone looking at KUnit with fresh eyes it seems
> intuitive to me that not being able to run a test case is a not a
> failure of the thing being tested, so shouldn't be reported as such, and
> thus this example stood out. I for one wouldn't want to be getting CI
> notifications to go and debug a "regression" in my code just because a
> runner OOM'd, for example :)

Ultimately, I think this is up to the individual test author -- in
many cases, I think failing to create a device (for any reason) should
be considered a test failure. Certainly this is the pattern which
exists in most tests thus far. In general, KUNIT_ASSERT_* is used to
verify these sorts of failures (after which the test cannot continue).

That being said, I definitely think you'd need to use at least
kunit_skip() -- with a good message -- if you wanted to split
"infrastructure failures" out: having a test marked "success" in
situations where it couldn't run properly (as in the original patch)
would be even more misleading. kunit_skip() is definitely used to skip
tests if prerequisites aren't found, but this tends to be done at the
start of the test with deterministic, known-in-advance requirements
(e.g number of processors available), rather than in response to an
OOM situation. (And, realistically, if the system is so memory
constrained that we're getting OOMs here, chances are you'll want to
know about it and re-run the tests anyway.

Regardless, I'd prefer to keep the example in the documentation as-is:
KUNIT_ASSERT* will correctly exit the test and clean up in this case,
whereas manually writing the IS_ERR/return bit is a bit more
contingent on this not being in an init/helper/etc function.

But separating "test failures" from "infrastructure failures" is a
good idea in general, and our current splitting things up into
"failed", "skipped", and "crashed" (used by the tooling for cases
where the kernel dies without outputting the result) is clearly not
ideal for these OOM-adjacent cases.

Cheers,
-- David

--0000000000003f3d4e0641540205
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg8oKw7HPbLnVNj4Atk8PJANsgMBRq
z3ISPKjgisYFGqUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MDE3MDUyODUxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEABbu/1rjk+szXPC6rL65MIb5bJxqJERzn5+stUjFYv33jCaDsPXBAa0Izi8lCgPO0
5UMSmFVZWEAlMZnbMnAYoxcuF4+EU/oFQr4vHcqfmfbtC/Qx/LWJSrF3fcV9kcwJU1zkraMm8dkm
n7HSJVeCPcOQ/3V92z2imrgBDHhRmO92HD9CvPi+46mNknkg9uLZzyBuqXKpL+E37Fns1mTuN2cR
E50tiFp3HaEZPymwHksJjcg6x5oE/KOrs+JyPs/DmmeCnzIcNWcE6Qr1kg6X8/tJTms+aRcqI5SU
PyaxVZ16DpWBwxaK0ho6Sn5nWlGM8V02grYgc848R/90RnHGSw==
--0000000000003f3d4e0641540205--

