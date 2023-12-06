Return-Path: <linux-kselftest+bounces-1246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C2806913
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 09:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D8E1F213EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7949C18AF0;
	Wed,  6 Dec 2023 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nO9Ti3Bc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BD1B5
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 00:04:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso5517a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 00:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701849838; x=1702454638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yl9Kt910+aZrTuuspQhrim7e+h7G7Y6uAYR69kUlQhE=;
        b=nO9Ti3Bc1TuyhPK520KQpltb2jJhzvlz0fUJXaD/49jGuFyfbBsjVepPOlbLxFoDSB
         hGx9Lp4IIdx1clBQYszQ8WzMmIDLaGiv+Bify2QwmlCX4ewzSpAAlXKlLXbvdTLjymJz
         fcnuXh0i8eo3kpOOKmyQx57POpeAciuwA335Kg9JfiQgouV1auRUB/ElDI77GHTNlCHV
         +9dGRZg//CidP9qljZjHPhvmQsaQ2lYo7pnfURHZ9OKKsjSqZpO43RW9ruo7imSs9mB2
         C9npZeSbev7yiIBTnlWLU6Zd2YOf/f1lHfdKxL0wxpri3+tbl3VSYNPdCLZTa7cLn52E
         JLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849838; x=1702454638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl9Kt910+aZrTuuspQhrim7e+h7G7Y6uAYR69kUlQhE=;
        b=rVT4PoYuf1BMrQvWqFZ26k2H1uyQkM6O4iL1VUMoucP3iCybFbyn1Qxvef8rEcnpHI
         JGKBzzn4VkIvS7yFhmuVIU/xnIikxImgFivGVlnl0I02tdgiSaPjymGUVsLnwpLEi84F
         n0b/4BbjswJteYPK3XWwgSImVHx655HCLXeOrE5H2sd406eTeSoFfz8jOeonzYQqQRzr
         pHgh94SqK8th3RTxCeABj1JV3eDg3YeIzXhW/sgFNbYiJ/HmBWg28GEBojGwK8O9hEgv
         Jw3PhCjY7qN1FgOnNTlfkCylP22TbsWdWkDwLbL22YAFnMA2aVzpUxxlzcpvpCukOmFO
         31Xw==
X-Gm-Message-State: AOJu0YylXJvNWK5lOE4QNWWo6E8H/pFqkd08Ck6V986JS3+l9TpuW0hY
	4qGTTwjHjWo4OdvYfVbRGxlf5STXOhuUq9n0dzftTQ==
X-Google-Smtp-Source: AGHT+IEaO+94iDBEXay94ezSPUxJ91cw5Aey+lBPpm7zInTNoW+eAVYUvOH98LT91lcesH3+n2Wv3kvyGNmnBQEJtFc=
X-Received: by 2002:a50:d744:0:b0:543:fb17:1a8 with SMTP id
 i4-20020a50d744000000b00543fb1701a8mr40204edj.3.1701849838267; Wed, 06 Dec
 2023 00:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com> <20231205184503.79769-7-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231205184503.79769-7-Nikolai.Kondrashov@redhat.com>
From: David Gow <davidgow@google.com>
Date: Wed, 6 Dec 2023 16:03:44 +0800
Message-ID: <CABVgOSnW1Yzz-1Zdr-k-qWL25yUDZo+jbhPwNkK7dG-8-WonFg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/10] MAINTAINERS: Support referencing test docs
 in V:
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Cc: workflows@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	Veronika Kabatova <vkabatov@redhat.com>, CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001ad6ea060bd2cb27"

--0000000000001ad6ea060bd2cb27
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 02:45, Nikolai Kondrashov
<Nikolai.Kondrashov@redhat.com> wrote:
>
> Support referencing test suite documentation in the V: entries of
> MAINTAINERS file. Use the '*<name>' syntax (like C pointer dereference),
> where '<name>' is a second-level heading in the new
> Documentation/process/tests.rst file, with the suite's description.
> This syntax allows distinguishing the references from test commands.
>
> Add a boiler-plate Documentation/process/tests.rst file, describing a
> way to add structured info to the test suites in the form of field
> lists. Apart from a "summary" and "command" fields, they can also
> contain a "superset" field specifying the superset of the test suite,
> helping reuse documentation and express both wider and narrower test
> sets.
>
> Make scripts/checkpatch.pl load the tests from the file, along with the
> structured data, validate the references in MAINTAINERS, dereference
> them, and output the test suite information in the CHECK messages
> whenever the corresponding subsystems are changed. But only if there was
> no corresponding Tested-with: tag in the commit message, certifying it
> was executed successfully already.
>
> This is supposed to help propose executing test suites which cannot be
> executed immediately, and need extra setup, as well as provide a place
> for extra documentation and information on directly-available suites.
>
> Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> ---

I like the idea here, but wonder whether it makes sense to put all of
these tests into a single 'tests.rst' file. There's already lots of
existing documentation scattered around the tree, and while keeping
all of the testing information in one place does have advantages, I
think there's a lot to be said for keeping subsystem-specific test
docs alongside the rest of the documentation for the subsystem itself.
And it'd be less work, as the docs are already there.

So, could we just make this a path under Documentation/ (possibly with
an #anchor if we need to reference just one part of a file)?

e.g., something like these, all of which are existing docs:
V: *Documentation/dev-tools/kasan.rst#Tests
or
V: *Dcoumentation/RCU/torture.rst
or
V: *Documentation/gpu/automated_testing.rst
or
V: *Documentation/process/maintainer-kvm-x86.rst#Testing

(We could even get rid of the '*' and just use 'Documentation/' as a
prefix, or the executable bit on the file, or similar to distinguish
these from scripts.)

If we wanted to be very brave, we could extend this further to
arbitrary webpages, like:
V: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/README

Thoughts?

-- David

--0000000000001ad6ea060bd2cb27
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAi
4zRGZTPrAx8Sdr2fXBo12qgoaqGEkHi0dxeSeXWQZjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMDYwODAzNThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAeC4llIqdeMMwKOLglV8Z
XqGVAdlUjsO+cG8/wUtR0TPh7rkgynB+oBlzgf51JYaDqo2tdBn7AK6ECfBx9Hw+4yyyGMY3hRtG
MdLLgmJlAB4DQtr8DMnsPi9xK1hu+nVkpxCaUzptyCe4FgsBCaXRg4Au7b6z8r7QVSgdcmXcvxxd
vIly5XegcVB2TFX8v3SuDS4rUDyn8iiqpTwZMQoXuZtlYQP0Ay9txaFOs+Bm1puub+1MjRK2tLfH
jvJB9xh71J54wPQklybmW3WnGbUKmW18PIw2p/5cZp2UKoVfQWEGAd2yTSEi62E7pC3bckn4ZP/V
YZMkS2d372hhut0agw==
--0000000000001ad6ea060bd2cb27--

