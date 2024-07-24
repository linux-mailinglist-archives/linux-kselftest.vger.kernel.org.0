Return-Path: <linux-kselftest+bounces-14135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F9893AC25
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 07:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D1282CE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 05:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4602D030;
	Wed, 24 Jul 2024 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgGp/iwE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640B22067
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 05:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797495; cv=none; b=pEEnVUu6gfcNfSVBzF4NfQlpcj7OiTfY3AGBs8cDyrCgxEZGDTPrdpwXShU+gttbAzbhMiIYCdah5gtrzIlIXik96zLicIgAPHny8EcKoyT24wRPJ2GIUNfemslz8Neda0CbRcShyT7A8Vy4fXL+e1q2qmdc3zyIq4mYrmzcDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797495; c=relaxed/simple;
	bh=KAZPcZiXJ58Bv/OkwVx+lm+dGiBZ9TJX82ZNicr1sOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZi0lSNpFkci58ye/ib5XcETr8zpwSue4qRz8+OVerygd4yTWDY0FNXVgjEQItiESZrtJqf42zmAc5n9mYSrQAxajN046UWgH65bBEK5p8bwitAxu5kfdsR4RwbhVsC8dR6kz6Bgo5iFvhd4adGQrO44jg3q1jENVluu5i5C6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgGp/iwE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44e534a1fbeso131011cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721797492; x=1722402292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dXN7dObyCWIbOAsOpyP4QURY7TiwqfZoTobhmQ5piMI=;
        b=TgGp/iwE1m5t4s9mfqLnIcbEdXrFWMs4n9uT8LXf+Sjp+60heufNjI76u4q27IFyqW
         ENpEcSJM/wa9vqdG3d55XndJiGjQRbfLfvSI06JmPZCqSLk3xxvtiGa++2eNoe2+PGG3
         sE35/i8XRVdmb4bbe30WBwM/fpvO3EnXl8KT6It3uX6+U4I+m1Sq7inJFftAmDLIpY/F
         Qu4823VocvdyNbFw9iiiQOyG/zym7/0KGB3xvEWGJ1OlAWHgJHHjEZ4w3V/VM2eJItiT
         2NUY8AIAVdyHUNPptcnQh2u9i36MsiSCNJxv5//HLoEFFZG1mBwbyylU1H6RnlFp8F8c
         VxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721797492; x=1722402292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXN7dObyCWIbOAsOpyP4QURY7TiwqfZoTobhmQ5piMI=;
        b=LuHWzW40I+VGyFEw7oQ2AulLbBuCHMIjxii7sjiP7m918RvQ630XmV0xQ45574wK36
         YZCN3BccG56L+/Qw19L4xJyTgITYix5D4wkx21TUw0DVdm5A82/ATIN0BDVDsLoN+uPr
         D1CWK1sHmOWHQgLtFX7wO/jUcFiUWvaW59Bz00GfZyZTYho07/6M0RPPi12ANi93zuYq
         GNMw1NCRV+wYaeC3D5JHUvYaXD03DPzoxu4hqpZbin+tq/dPecmVTP8RrmZALCcvcSAw
         nhCwTcHP/73trHcmzrUG9X2C+pYmKcqUmYoXuI1H4CP8H62hOzucKnrNAh2er5e7PP6V
         xEvw==
X-Forwarded-Encrypted: i=1; AJvYcCXpGlF31ttTmYDLEJQS6yCpMrhO8anf5LdC3cnjddCDEygxxEsXNsUOCfE+5XiZe7VifSwd5txA7krSVPDXzM09xSBWorPKe3j7Kv4Fw2y/
X-Gm-Message-State: AOJu0YyqkeJ1P99BSitFZg2lj+SwEikle97KK8MEYRRHuK7qxO15eAm5
	7CzB3X2FsbmScl/xK309Lisr9fz0pJfa2+TG0Gd4/LTjKanoBfQX+VqNTwg3PKwLT1tNQsa5BKi
	UCseiY5n1lP1DAjqCS1+3gxytDg9fxFZAKGPK
X-Google-Smtp-Source: AGHT+IEvNx9w2Oh02Epe1Pwn86vcDnrcBZegsBJHVcO3cLI1U9rMJATARVb4WRSTMnn6wFceyDxpG1H07rMGJ3kI+Fc=
X-Received: by 2002:ac8:5949:0:b0:44f:9e0f:bc41 with SMTP id
 d75a77b69052e-44fd4c99663mr2484291cf.27.1721797492227; Tue, 23 Jul 2024
 22:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720165441.it.320-kees@kernel.org> <Zp4spjsaqQ85fVuk@elver.google.com>
In-Reply-To: <Zp4spjsaqQ85fVuk@elver.google.com>
From: David Gow <davidgow@google.com>
Date: Wed, 24 Jul 2024 13:04:39 +0800
Message-ID: <CABVgOSkp0tyQN7NRd=Tpss33xSnBb5vzuvz952rGaA0UAS0UBg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: KUnit: Update filename best practices
To: Marco Elver <elver@google.com>
Cc: Kees Cook <kees@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, John Hubbard <jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ee4c6c061df73756"

--000000000000ee4c6c061df73756
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 17:56, Marco Elver <elver@google.com> wrote:
>
> On Sat, Jul 20, 2024 at 09:54AM -0700, Kees Cook wrote:
> > Based on feedback from Linus[1] and follow-up discussions, change the
> > suggested file naming for KUnit tests.
> >
> > Link: https://lore.kernel.org/lkml/CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com/ [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> [...]
> >  Documentation/dev-tools/kunit/style.rst | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/style.rst b/Documentation/dev-tools/kunit/style.rst
> > index b6d0d7359f00..1538835cd0e2 100644
> > --- a/Documentation/dev-tools/kunit/style.rst
> > +++ b/Documentation/dev-tools/kunit/style.rst
> > @@ -188,15 +188,20 @@ For example, a Kconfig entry might look like:
> >  Test File and Module Names
> >  ==========================
> >
> > -KUnit tests can often be compiled as a module. These modules should be named
> > -after the test suite, followed by ``_test``. If this is likely to conflict with
> > -non-KUnit tests, the suffix ``_kunit`` can also be used.
> > -
> > -The easiest way of achieving this is to name the file containing the test suite
> > -``<suite>_test.c`` (or, as above, ``<suite>_kunit.c``). This file should be
> > -placed next to the code under test.
> > +Whether a KUnit test is compiled as a separate module or via an
> > +``#include`` in a core kernel source file, the file should be named
> > +after the test suite, followed by ``_kunit``, and live in a ``tests``
> > +subdirectory to avoid conflicting with regular modules (e.g. if "foobar"
> > +is the core module, then "foobar_kunit" is the KUnit test module) or the
> > +core kernel source file names (e.g. for tab-completion). Many existing
> > +tests use a ``_test`` suffix, but this is considered deprecated.
>
> What's wrong with the `_test` suffix (if inside a "tests" subdir)?
>
> Rules are good, but please can we retain some common sense?
>
> I understand the requirement for adding things to a "tests" subdir, so
> that $foo.c is not right next to a $foo_test.c or $foo_kunit.c.
>
> There are exception, however, if there is no $foo.c. For example:
>
>         - mm/kfence/kfence_test.c
>         - kernel/kcsan/kcsan_test.c
>         - mm/kmsan/kmsan_test.c
>
> In all these cases it'd be very annoying to move things into a "tests"
> subdir, because there's only 1 test, and there isn't even a $foo.c file.
> While there's a $foo.h file, I consider deeper directory nesting with 1
> file in the subdir to be more annoying.
>
> The rules should emphasize some basic guidelines, as they have until
> now, and maybe add some additional suggestions to avoid the problem that
> Linus mentioned. But _overfitting_ the new rules to avoid that single
> problem is just adding more friction elsewhere if followed blindly.
>

I agree in principle here: the purpose of these is very much to be
"guidelines" rather than "rules". Certainly the idea was that
individual maintainers could interpret and/or override these to best
fit their subsystem. (But, obviously, it's best if there's a reason to
do so.)

Ultimately, we have one major new guideline:
- Avoid having multiple files in the same directory with the same
prefix, probably by placing test files in a tests/ subdirectory.

And one revised guideline:
- Test modules should be named with a suffix to distinguish them from
the code being tested. Using the "_kunit" suffix makes it easier to
search for KUnit tests, and clarifies that these are KUnit tests.

I don't think there's much need to quickly find all KUnit test modules
by looking for _kunit.ko, though. While it could be handy, we already
have mechanisms for configuring KUnit tests (CONFIG_KUNIT_ALL_TESTS)
and detecting if a module contains KUnit tests (look for the
'.kunit_test_suites' section). So the distinction between '_test' and
'_kunit' is really only there for humans, and it doesn't matter one
way or the other if all of a subsystem's tests use KUnit. If there are
a mix of KUnit and non-KUnit tests, then making the KUnit ones end in
_kunit was already suggested, so we're really just changing the
default. It's slightly complicated by the existence of
"non-unit-tests" using KUnit, which may not want to get caught up
automatically in lists of KUnit tests. I think that's a case of
common-sense, but since we're not really using filenames as a way of
listing all tests anyway, using CONFIG_KUNIT_ALL_TESTS and the 'slow'
attribute probably makes more sense from a tooling perspective,
anyway.

> > +So for the common case, name the file containing the test suite
> > +``tests/<suite>_kunit.c``. The ``tests`` directory should be placed at
> > +the same level as the code under test. For example, tests for
> > +``lib/string.c`` live in ``lib/tests/string_kunit.c``.
> >
> >  If the suite name contains some or all of the name of the test's parent
> > -directory, it may make sense to modify the source filename to reduce redundancy.
> > -For example, a ``foo_firmware`` suite could be in the ``foo/firmware_test.c``
> > -file.
> > +directory, it may make sense to modify the source filename to reduce
> > +redundancy. For example, a ``foo_firmware`` suite could be in the
> > +``tests/foo/firmware_kunit.c`` file.
>
> I'm more confused now. This is just moving tests further away from what
> they are testing for no good reason. If there's a directory "foo", then
> moving things to "tests/foo" is unclear. It's unclear if "tests" is
> inside parent of "foo" or actually a subdir of "foo". Per the paragraph
> above, I inferred it's "foo/tests/foo/...", which is horrible. If it's
> "../tests/foo/..." it's also bad because it's just moving tests further
> away from what they are testing.
>
> And keeping tests close to the source files under test is generally
> considered good practice, as it avoids the friction required to discover
> where tests live. Moving tests to "../tests" or "../../*/tests" in the
> majority of cases is counterproductive.
>
> It is more important for people to quickly discover tests nearby and
> actually run them, vs. having them stashed away somewhere so they don't
> bother us.

I definitely agree that we should encourage tests to be alongside the
code being tested (whether in a subdirectory or not), and not in an
ancestor or sibling directory (so, no "../tests" or "../../tests").
Though I can see that making sense for some subsystems which already
have established "tests" directories (e.g. DRM), so it's not a
never-break-this rule.

> While we can apply common sense, all too often someone follows these
> rules blindly and we end up with a mess.

Agreed. The goal here is definitely to describe a 'sensible default'.
Once we're hitting unusual cases, though, this will have to be a
matter of common sense and maintainer discretion. Trying to come up
with an exhaustive list of rules seems a fool's errand to me.

Cheers,
-- David

--000000000000ee4c6c061df73756
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIN+xt8Xyj3HMSVH7II1yhJMuIsqgXYCOQtCg4QJz4VB+MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcyNDA1MDQ1MlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA07oAT
4qUaJeOBaKMV2IJZiaOy5IygAJLRsKczVxIPn5MQbEpLs96wTkNE55P8WF/XH088kP5VNYjze8wt
WVgQRFnRYBibFnzxSRotGzf5eCRTrVF/XIYez/mWWnfA7zgWrmoWLRMZ40iOU9LYb+VUjc+Jw8Fg
6pKvDamKyhjpXcwSxZLnbhU8Uc9SqAVOlrCaqy91+c5Ry7pE8124pP9tQOTVXrUCwSHN+eRHN/Vy
vHaEv69rhislHoG5iv4mLfNddXdwP0fYjp6VDfP4RR/FAHTSJl1Sna8ZP08HRnPCymuShlf63G6/
8mS/KmXOBuvksXNBe3tGokGvOEUuYf0/
--000000000000ee4c6c061df73756--

