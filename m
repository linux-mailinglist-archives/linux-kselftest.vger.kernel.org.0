Return-Path: <linux-kselftest+bounces-1904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F78812AC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E07282126
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 08:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733832421D;
	Thu, 14 Dec 2023 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w37N9Hj3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3E10A
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:52:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so9686a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543928; x=1703148728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2Nz8hK92q+uu7uftuQEnxHzIZsMj7o/LdV9r6dhObA=;
        b=w37N9Hj3th81jwkq2EeIfRmnWjFcCNdpmVu+4ancdOkaRbPw/EeOogcrMjMXkdGSpT
         QYedU9C/9F+EU8pdErR0YRl3DGp0XE6EUY//c/zWk/ATXqivPfBslBRT/rb/bL7/HE+b
         Mjs9Gj7A1quGQIiDX6zqov3a8gwmoGq/2cakAR49zTIjp6nRKW89zMD+hSXEtvDcUJsY
         fxQdJihQzLbJbDcSU5F/Br2RG+Ug116C8kDLsnIDHboToPhO9vGwXjlyMrJAaXPxKla5
         Cf8z8LYQWTnRbTT6/QF+JBn2cT1BKAOscttj8r+tszO4ehR/P+steMr6cMs2A6vxQphw
         rMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543928; x=1703148728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2Nz8hK92q+uu7uftuQEnxHzIZsMj7o/LdV9r6dhObA=;
        b=owl1VVOmtpz+QA5dtP945RyEgztFfJJ5ODVMyiTbibmJROSdvTf5aMinOT9X/gNVXV
         8gAIr7lGyigSAjL2eoYf2P2VCerBe62o0BQJkIpspG0tgl/JtQ/L8SCDonN1CVr/EhuC
         1GY/V3JrZbvdW6SLRNUeQDPQNML7oz/N935g7Or56PqibGFK+vnXPTeCZe64GnqQT0kL
         AtLp/qL035QRGfDiRy442pnDJCMYxydSDe+er5fmiSH55ZZStpp9USQ/CQ5My6zE32M7
         ZMHOst5ExBsi3mhC/VAtqC4Do1bzE2EIPb6m7ihc2RfjOd4s/qgycptBU3JKZHs8EBvY
         z5wQ==
X-Gm-Message-State: AOJu0YxeHW4sF5AgFVta53OrEYX14We4JnJ65Bt9BuIU0css3QjmFLQI
	pLxVLTJ8GfgHAY1al5QdVmLRtqhlfB1HX3CWkGSqfQ==
X-Google-Smtp-Source: AGHT+IGr7SURlrVqQjCd6Nbh6tM7k/YJj+gzxCpSmMn1ZluV7ILkdLH+8yeuqAiwZK1QSvDikUGGHogQ3hlOPDeMG/U=
X-Received: by 2002:a50:d7ca:0:b0:54a:ee8b:7a8c with SMTP id
 m10-20020a50d7ca000000b0054aee8b7a8cmr598463edj.0.1702543928070; Thu, 14 Dec
 2023 00:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208-kunit_bus-v2-0-e95905d9b325@google.com> <7rgeotye4grxdtbxip53fykjm4a3sudochsfzdvkmyqltvj7zv@qekkt42x2j25>
In-Reply-To: <7rgeotye4grxdtbxip53fykjm4a3sudochsfzdvkmyqltvj7zv@qekkt42x2j25>
From: David Gow <davidgow@google.com>
Date: Thu, 14 Dec 2023 16:51:54 +0800
Message-ID: <CABVgOSmnf8XbS92f4=-ZX8Of6JUwCy7U2wz2-3udvByDKxXABg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kunit: Add helpers for creating test-managed devices
To: Maxime Ripard <mripard@kernel.org>
Cc: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001374ee060c7466a5"

--0000000000001374ee060c7466a5
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 23:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi David,
>
> On Fri, Dec 08, 2023 at 06:09:28PM +0800, davidgow@google.com wrote:
> > KUnit tests often need to provide a struct device, and thus far have
> > mostly been using root_device_register() or platform devices to create
> > a 'fake device' for use with, e.g., code which uses device-managed
> > resources. This has several disadvantages, including not being designed
> > for test use, scattering files in sysfs, and requiring manual teardown
> > on test exit, which may not always be possible in case of failure.
> >
> > Instead, introduce a set of helper functions which allow devices
> > (internally a struct kunit_device) to be created and managed by KUnit --
> > i.e., they will be automatically unregistered on test exit. These
> > helpers can either use a user-provided struct device_driver, or have one
> > automatically created and managed by KUnit. In both cases, the device
> > lives on a new kunit_bus.
> >
> > This is a follow-up to a previous proposal here:
> > https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@google.com/
> >
> > (The kunit_defer() function in the first patch there has since been
> > merged as the 'deferred actions' feature.)
> >
> > My intention is to take this whole series in via the kselftest/kunit
> > branch, but I'm equally okay with splitting up the later patches which
> > use this to go via the various subsystem trees in case there are merge
> > conflicts.
>
> Could you take (and apply eventually) that patch as part of your series?
> https://lore.kernel.org/linux-kselftest/20231205090405.153140-1-mripard@kernel.org/
>

Thanks -- I've included it in v3 (which fixes a few other issues), and
will take it along with the rest of the series:
https://lore.kernel.org/linux-kselftest/20231214-kunit_bus-v3-0-7e9a287d3048@google.com/T/

Cheers,
-- David

--0000000000001374ee060c7466a5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDm
F4Ic9SffzyaDMQPCLkKQW+taWwYpJm+BECAkfDyJnzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTQwODUyMDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEARS3tFy1kAs0G8X3o4TWH
oEKuwTgMnhZ5fz7z9rQ6YlIk+yhp9dnsyqKFp/VpdGCO5av2Yv834BDTZtRjp3hZFvnI8x6ay5rx
LcSpX/6ebX/U/QLMsyj9+Mx0Vwcu6++9ycv3W2ffL+oRa2kGEIi3bHvi2aLU9ObTJc/pBW6luEVV
1uXNtvMAmpBarA6NQvo38j5dPt5ypLXSJtoIXnVdNqGXqAnqJq1xYxJBTzooY5mQB04E9NKm4dVT
OMz4ot55/KLmY14DLuJBF+8FlqKa48uA4p3nLyOJFC9C0A5G7ejA4TwCOPDc6Hj9KZEqbqPCag+q
ohe82MUWiZzz47sOyA==
--0000000000001374ee060c7466a5--

