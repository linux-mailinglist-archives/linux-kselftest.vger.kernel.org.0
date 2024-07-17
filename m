Return-Path: <linux-kselftest+bounces-13828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9433B93370A
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 08:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66601C22AAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008612E48;
	Wed, 17 Jul 2024 06:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JasftK70"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA3125DE
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197710; cv=none; b=MGL1VzTcoLN3EIpZcmm9MciMEh0UgVJB5DNFNgGbIz+YNH9xLGBgjbB+I053Wl+p3PqiY4AexeZSKfnRQJmYotX+d9cRgz2CbZwpAwMUMDzTKBSPsnVXUTwsES4vG2wPww/bfW8pmoZWdPiTJ7zuL0Lnmt/YlVJd1/amiw5NYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197710; c=relaxed/simple;
	bh=bZSPnDuUrAMJNknDS04pwIBv5I/QuS1KiyTOjJ4izBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okY9VcfqnVg5n5AL+Gb59LtYUcMQidb5IRutqywdbT+6388BeaWxtMYVM5jSlLc4Sgcs6JI0EhqEJVhJg2W+sgCFuQlZzzFy6DtJP+oVkaogGqm/WzkHgxMt3HAg4oL/awFojKCxvQV0IQcjUQ9svVOD1tnEfskp4p1s+zmjfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JasftK70; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447df43324fso131721cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721197708; x=1721802508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JoQpg0nuM3cfWX3dpQq8kc2hA8CmKTG1xP3RHgE1TcU=;
        b=JasftK70i1PwmfusElkQEnp41UpJ6dhej2dRhB2gXcudEQGH0FWPSa4/TWp+BR/mhJ
         G8sV9vXDaeSJtiMLUAEyt8lA5V6pbGvkZg85ZOtrer1M4Q7TJHrI81paSbpW3gh4r6IJ
         68cquUX8veEPt1MLF5eN6i2Su+A737yttIQXyk17sPdrc1vs9c6q2qqik6vJezVUoD3l
         7tH29THrz1Mev8y9FGgbqHUZMA83u7Wv59S6/XRv2156q8e6T1VEY7twy2B/Xm8B3SMD
         xCabBiqTXdhqV6WbbxMSp0SNxU0Cfwy4bqVfoz3yUu46SRQ3f6EdDMpA8KrNVv73boGn
         pqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721197708; x=1721802508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoQpg0nuM3cfWX3dpQq8kc2hA8CmKTG1xP3RHgE1TcU=;
        b=bcn6Q0oo+rVeKY6B5YS1GNChZa/IKfIokpcsmP3F7pm2d4aeC3ovNONgDjVH+RVOeD
         2b/zhLY2CPCv0s+izQRj3i05UBDS4QScckYxEn1zOy0Tg9BWsDw2ghBj+qcrY9dSqeD6
         gERvFI1HzfJWXWJrICZFNLS2QTUTiJrv0LV4ti2f7PnGvwO7tnVGBDhZWeCe1CZEFzLl
         VBYZLEvHVHehYlz0q3sz8kaUxoxNNVotB+KQ792GAQbUBJKiyjz72nwPwdBfpZ+DbTn8
         2s3hgSgdFzyjer7CmXtLyla+rK8nDWvf7pPLzG6FUVq6+Nkkst8xnJ5ITjXCYS7bXHMV
         AI1A==
X-Forwarded-Encrypted: i=1; AJvYcCV7aAYVi7gQx9aLImrKcytM+Pr5ZhY1fmVOlGN/JlDksAijwc2Vz8r9ynfgrDs1RuQYYz+JnDu6r+zAhkFxjEF7zBgDAS8lAMhJ90+V+1sG
X-Gm-Message-State: AOJu0Yx0tqjlS5cMemf3q7kc8srTIoW0oWgBy2sfOQ/QxB0Th0oqU6cy
	NT7knJ+QBBjznrzXvwTBtkCOX2nZWsFXxtoXbTzuAWVQKt/0r29Cv1gxogkPe5Rgz7Bj6PrJ05f
	pokfeh3vfMmQbljh2AeiqG7ld/wL7MhjrKzeF
X-Google-Smtp-Source: AGHT+IHCKhPGQ+wVmrA11QbsrZCCD+Aq7AuVxY4lUDDfBwTuW07lRaGn3kj9Z7xwT4CfSNT9Wm3pnSaxU71LR4hiRxE=
X-Received: by 2002:a05:622a:a0f:b0:447:eeb1:3d2 with SMTP id
 d75a77b69052e-44f84d48358mr1348481cf.27.1721197707951; Tue, 16 Jul 2024
 23:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407150921.BD2B798C6A@keescook> <CAHk-=wgim6pNiGTBMhP8Kd3tsB7_JTAuvNJ=XYd3wPvvk=OHog@mail.gmail.com>
 <202407161505.A5AE57869@keescook>
In-Reply-To: <202407161505.A5AE57869@keescook>
From: David Gow <davidgow@google.com>
Date: Wed, 17 Jul 2024 14:28:15 +0800
Message-ID: <CABVgOS=pUdWb6NDHszuwb1HYws4a1-b1UmN=i8U_ED7HbDT0mg@mail.gmail.com>
Subject: Re: KUnit file naming conventions (was Re: [GIT PULL] execve updates
 for v6.11-rc1)
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000000de83061d6b9214"

--00000000000000de83061d6b9214
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 11:53, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jul 16, 2024 at 01:10:41PM -0700, Linus Torvalds wrote:
> > On Mon, 15 Jul 2024 at 09:21, Kees Cook <kees@kernel.org> wrote:
> > >
> > >  fs/exec.c                                   |  49 ++++++++--
> > >  fs/exec_test.c                              | 141 ++++++++++++++++++++++++++++
> >
> > I've pulled this, but *PLEASE* don't do this.
> >
> > This screws up my workflow of just using tab-completion for filenames.
> > As a result, I absolutely abhor anybody who uses the same base-name
> > for different things.
> >
> > No, this is not the first time it happens, and it won't be the last.
> > And we had that same horrific pattern for fs/binfmt_elf_test.c from
> > before, and I didn't notice because it's not a core file to me, and I
> > seldom actually edit it.
> >
> > I would suggest that people use the patterns from lib/, which is
> > admittedly a bit schizophrenic in that you can either use
> > "lib/kunit/*.c" (probably preferred) or "lib/test_xyz.c".
> >
> > (Other subsystems use a "tests" subdirectory, so we do have a lot of
> > different ways to deal with this).
> >
> > Any of those models will keep the unit testing parts clearly separate,
> > and not mess up basic command line workflows.
> >
> > But do *not* use this "*_test.c" naming model. It's the worst of all
> > possible worlds.
> >
> > Please?
>
> Oh, sure, no problem! I have no attachment to this convention at all;
> I was trying to follow the Kunit docs:
> https://docs.kernel.org/dev-tools/kunit/style.html#test-file-and-module-names
>
> If I look at the existing naming, it's pretty scattered:
>
> $ git grep '^static struct kunit_suite\b' | cut -d: -f1 | sort -u
>
> /test/*          7
> /tests/*        47
> *-test.[ch]     27
> *_test.[ch]     27
> test-*.c         1
> test_*.c        10
> *-kunit.c        1
> *_kunit.c       17
> kunit-*.c        2
> kunit_*.c        1
>
> Should we go with "put it all under a 'tests' subdirectory" ?

I think that's probably best overall. I still think it isn't quite as
elegant as the suffix, but I'm happy to sacrifice theoretical elegance
for a practical reason like this.

> So for fs/exec_test.c and fs/binfmt_elf_test.c, perhaps fs/tests/exec.c
> and fs/tests/binfmt_elf.c respectively?

We might want to use both the directory and the suffix, e.g.
fs/tests/exec_test.c, because:
- it makes sure the module name contains 'test', so it's obvious that
it's a test and it is less likely to conflict.
- this matches what drm is doing, and they've got the most tests thus far; and
- we won't be renaming the file, just moving it, so it's less likely
to cause friction with workflows, etc.

On the other hand, it has few disadvantages:
- we end up with the same prefix issue with module names (e.g., for
those who have tab completion for modprobe);
- the module name can be changed in the Makefile anyway; and
- it's ugly.

I'm leaning towards tolerating the ugliness and keeping _test suffixes
on the files, at least for existing tests, but could be persuaded
otherwise. I'd even grow to accept a test_ prefix if I had to, though
that'd make my tab completion terribly boring.

> And for the lib/*_kunit.c files, use lib/tests/*.c ?

Sounds good to me. I'd rather not put them in lib/kunit unless they're
actively testing KUnit itself (which, under this scheme, would want to
be in lib/kunit/tests).

> Then we can update the docs, etc.

Even if we don't rename existing tests, we'll probably want to update
these just to avoid making the problem worse.

Thoughts?
-- David

--00000000000000de83061d6b9214
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
hvcNAQkEMSIEILYyPfQogIEhDXqBzbyLG4C+yVCpalw8J1jZ+T7Dd7njMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcxNzA2MjgyOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB0Fgw3
AJaww5tot4doqAQrqw632xTVkXfPrG3S7Y0YyFd7Hn7UgAXqKP9YXw0XLVlliBLlVQA2+d8OeN0t
otTPkGKo40MiRvtPzLpCjrSchGPL33N0TlFnKKTea9phPwfnokRQHQsX67cwe4CJLb5GWlG2UujM
vqQrdfXY23CSq0rXcD/tM7ifbxqDV0eKTqahukaUMK8ELiJBb3ui5JaFRi8PQ2ZSe0xzdJVMO98A
P6R9UJbvkodD9pZl3y3v1JSK496XXNQQvn7wOqLV9jeaSwX7ZUja2alflWKtSx28vNIOsqKtNNED
Nk9VuiXaHHPezVpfRI2N6zIueOQngrti
--00000000000000de83061d6b9214--

