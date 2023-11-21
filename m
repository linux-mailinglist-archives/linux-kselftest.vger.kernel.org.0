Return-Path: <linux-kselftest+bounces-372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D37F2AAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDA2B21467
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D81862A;
	Tue, 21 Nov 2023 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywwRlQ0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E110D7
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 02:37:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so11486a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Nov 2023 02:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700563044; x=1701167844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gQlvZV25U99d3u7eHZETKYs9F6K5fc2AAy4cilcwwg=;
        b=ywwRlQ0fw+DbKG0H08WT73V8IIZIDZLkayh+Z/UXrAnB1CP7x5b3VbSja4105rwEjp
         yJmfvxv1RvrPMvk/204fDKXh3GHbYJv/hss/YmUlRkgeesvFxS6mYuJwDn9G/FqdBmOe
         l6wwivyuJAL0VofGpGMkMgsESIjVpQRbj4pY1mAupsD5SkkzajIGDUIv3HwoZz/7of8B
         o2doB0rOXPH3+KrtFy0FHJIpk28RSKnWtkMD/2b29SiKYv+0077yhiH9dKjxbAtKbuMI
         6UVmfh0uuBR8AWmZHAGcgbwm3J1/lZBiTWGhzyHFDtUFj8BcfHha1Ce6rcxH+AhwLuab
         1J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700563044; x=1701167844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gQlvZV25U99d3u7eHZETKYs9F6K5fc2AAy4cilcwwg=;
        b=Rlk7yWk358V/WGwabqYxw4nktLzbAZZnEsQMH2n+Cm7QL/zrFsRstg7gMoiNqkkWKl
         QWvKNiIUQWJIXwpYa+QxAL9n6k1XYUJ4/SUlJhNvAJZ+sP+0mJIlBcHXsqtyvrfvU/EB
         htoHQoX6bU3yHWa+ie9s82bunRhbOKLYAw6gXaQ2qMD1AA+pa6HjSeAH2u3EQM8fJ47u
         EANieGIRsUHgxlOjbGlru1UuLP3iCwFGAZXiRwCYBAErRPI17Z+t2L+2HQdr1Ltt7w7A
         xE7z6ws/pnbbf1/2bxytswvqjGffssfFUDrJsr6WFk9JSxbWXklvYGgn+s2Wk+Ta/1Fo
         r+sw==
X-Gm-Message-State: AOJu0YypexeqpK4lodKt8rJ6cgxgySkX0wg/+BK3X0X1uRRSN0SAloJ5
	giXdWUQzzpYZeckL1euIG50Gv4W9RflVTtrHOhapTg==
X-Google-Smtp-Source: AGHT+IFPrpwxx4kFbn4LuB+9FjU0DiFk3Bf4M0rdi40zLOimdIwdUcE8NqvY2kMPdZxBaB7xZsOr8794lXDIjWssTkQ=
X-Received: by 2002:a05:6402:4414:b0:544:e2b8:ba6a with SMTP id
 y20-20020a056402441400b00544e2b8ba6amr481119eda.3.1700563044041; Tue, 21 Nov
 2023 02:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <87sf50imba.fsf@collabora.com> <20231120205131.GA291888@mit.edu>
 <92c2f89d-f8a6-4260-b10d-671011cf1f70@sirena.org.uk> <20231121060450.GB335601@mit.edu>
In-Reply-To: <20231121060450.GB335601@mit.edu>
From: David Gow <davidgow@google.com>
Date: Tue, 21 Nov 2023 18:37:12 +0800
Message-ID: <CABVgOSmw6pn5eRg6Z+4am=OJ9E4RN30Zsfaci6DE+dRKA+-4iw@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>, 
	Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, workflows@vger.kernel.org, joe@perches.com, 
	apw@canonical.com, rostedt@goodmis.org, skhan@linuxfoundation.org, 
	djwong@kernel.org, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, vkabatov@redhat.com, cki-project@redhat.com, 
	kernelci@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002f26de060aa730e3"

--0000000000002f26de060aa730e3
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Nov 2023 at 14:05, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Nov 20, 2023 at 10:27:33PM +0000, Mark Brown wrote:
> > This is the sort of thing that kcidb (which Nikolai works on) is good at
> > ingesting, I actually do push all my CI's test results into there
> > already:
> >
> >    https://github.com/kernelci/kcidb/
> >
> > (the dashboard is down currently.)  A few other projects including the
> > current KernelCI and RedHat's CKI push their data in there too, I'm sure
> > Nikolai would be delighted to get more people pushing data in.  The goal
> > is to merge this with the main KernelCI infrastructure, it's currently
> > separate while people figure out the whole big data thing.
>
> Looking at the kernelci, it appears that it's using a JSON submission
> format.  Is there conversion scripts that take a KTAP test report, or
> a Junit XML test report?

The kunit.py script has a very basic KCIDB JSON exporter, via the
--json option. This can be used as a generic KTAP -> KCIDB converter
with
kunit.py parse --json

It definitely still needs some work (there are a bunch of bugs,
hardcoded fields for things KTAP doesn't expose, some other output may
get mixed in, etc), but does exist as a starting point.

-- David

--0000000000002f26de060aa730e3
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCa
x2irT4JHJO0tc3XLpY+oJq6b72CB9v2T9Dpy96GlmzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzExMjExMDM3MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYJ3C9MYbbCKiYz9JxP5d
MqrDRVmauLzz8OT/A9/WkGsiLj9o7TFhsbd4b6d7l3ds5bOTFoDTRK+wwY0/OJXMXa7WVhGPPwo9
zZtUSJ8C1EfA1ZxBw1QVlVKT6gcTZWo3lxOsbFcdKzofcktm7zRrqmCEncH6U3y3fj9EOdA7PcTt
N/qjKAh44d2/NFi2e1Zuf1o5PucPcJ4qaOq/wIj5z8Wf4enbkf8yZOCzkqx5UatZoDbSsF82AHOc
S1yUOjo+SswHohogPLVDF6xhJIpDiZx2TTHF3Utt9S2Le0kT7z7XtLy98c+bIPumt/M6TJkVBYpf
YDpp8UvX9NbFWGIK8g==
--0000000000002f26de060aa730e3--

