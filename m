Return-Path: <linux-kselftest+bounces-28408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD90A54F7D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67011889641
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D621019A;
	Thu,  6 Mar 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4ztF5JV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BD20D516
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276115; cv=none; b=tJ2nEWnp7ony+sZKPtNNU2I182m4Cv950ep9MXQItym99E0DP5acdT+P3TTee7qQZlq+UbzAtPbcSUaXq0KKPvLhTj94piNU+5tz7q/b23K2GlHTCFdfEOX3eXAhPmeMDzvN69klUSTikwdJgQ11kCfZ0du1Ss0YifelstGqPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276115; c=relaxed/simple;
	bh=9nc+nlHVLzbF+an9SP1BN1fDldEWWVM2GaTD/JHD38Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoNGwsfuutFI6lcIpm4/av0fTq7tomHgwBihYMVcfiQCW0uY+BpfjSVLtbin5FFXrv+m20iJvdmyTCaYI6FAe5nvHwghlmVK4s0rfScZYVQO5sMomayFnhAqLPAPJfbNnaIXZPvsBZni2FrtPDXjwgpPx43ZVKuIQKdgkBojHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4ztF5JV; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd0d09215aso6133456d6.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 07:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741276112; x=1741880912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/vdOVrt2gpTAE6Qt1Fy4CDkFxCZzAdyeoHIg8U7v4Y=;
        b=n4ztF5JVqy+7XL09j0fZ9Tqjp9FyAYVAPUvOXfPXv3dXgY+J38APnM+dwz9r9PquXE
         otBHGyl+iCV/96kY6tudZkY8r7rgf7UY/IAUYN5DyDg0w9VX3axCB5v1XPsRi8nq6M8l
         338stSAUBceEfR498ndsJ4dSwhaEPwYjSbYg0iJp88aeUB8pO5/LzNbPmedQ9n5oYJt4
         jBH+9Fk/LDpNuAyJwZwy+5dlnInGhtXsxdPl5gtNCkhOVMZkjzV2l4YuC6OZNP/foLGh
         Hiwe6ElnaIKkm/F+Hut/+HGYu1oVPL7r/km4VueLyKfAChmWnBqT5qB+gAvNbgNrcxJ7
         Jf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276112; x=1741880912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/vdOVrt2gpTAE6Qt1Fy4CDkFxCZzAdyeoHIg8U7v4Y=;
        b=EV8dsQZkbNfsmMezipDyo5BP5MKq0zpjzaBIJKZGfocfHriVeeINAPfJprb57/QoG9
         3TaHrLgee1dEvrdfM4WIMumiR53ZwM84R7vEgII3/IT/DBxR8s5przzAwF0pOYQhxN/+
         04rgD8H9aSNPMsiDiKJ98VJlDlHahQJYTfyMcopTuPms9YWxfDgjatc3Zd7aqZqXDcOQ
         +yVCH27xa8e5iZLJ/hoOrJYSMj0+/fF4jF3+OwlPBb+p/DA2Bv2aq/tbv9UWxgL2MI7U
         eKX3E9fjMKn1rzgtNT2RgZQIVC8wBHMEnS3bH0s/vj4+kNd4DXF89ixcjgWGYTuOrwIF
         iT2g==
X-Forwarded-Encrypted: i=1; AJvYcCUE5Zki53RzgL2KTI+zRPEZ4cNCUWEBSkebXDZ+Qrow/tKipUWMH+XvVFFGpU73yNiyiM3hoURJIAE+UYztgcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZd5R6A2EkN4JS7chjqLiMAaDNa03dMe+K3YuVk/Zx6ehzaLt/
	51ihPbLnpvHQA94b5w+VZNgyAYRt7s1Ersy9BtwuKr1KJ2CpoDmVwVCepUAZzEl3IIw7xel5rB6
	1PTN00p+pxTJM/s4gZHvtsBiTadsEu4N6KPCw
X-Gm-Gg: ASbGncuGwDGUY/spEN6noIBXSCE74GDDqMERy9gWl0yJlV1sRLc9F0y4m+B0rzyVHFX
	55q9Gl27rM8Lta1NsGRjz+NCktY7eixRo7dy/8UnGK563fjBMcKE/VsA8/qiNjsSJrAvfLRNwPv
	5ZCxzJlYfUYLU/kolyLQXLISvv29ZiIKf5RVKSWVwkwlA3/IAKNTjLCtuT
X-Google-Smtp-Source: AGHT+IG2NjbsvKGXcwADdAlgVYJgxqLNzRndRMUdTycXQdYU++VkUBDx6MSDbLgKNWOXyJqjCBJAmuRGX/H6gseJcss=
X-Received: by 2002:a05:6214:d05:b0:6e6:6699:7e58 with SMTP id
 6a1803df08f44-6e8e6d1551fmr101200616d6.1.1741276112191; Thu, 06 Mar 2025
 07:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306002933.1893355-1-rmoar@google.com> <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
In-Reply-To: <CABVgOSkwrb36rrhH3H17fhYOnywhTgTh06aDaKXT4jZp474sRQ@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 6 Mar 2025 10:48:20 -0500
X-Gm-Features: AQ5f1JoJuxVIlo73mw7OMRvVa5L4ygXshyFART2BLs53CpfZgjhb5b6nVql4vZQ
Message-ID: <CA+GJov6A1dr4PHkV3jSyptKc6PvhA4Zx7=jjFBVOa08=PwKRMQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Fix bug in parsing test plan
To: David Gow <davidgow@google.com>
Cc: shuah@kernel.org, jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:00=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Thu, 6 Mar 2025 at 08:29, Rae Moar <rmoar@google.com> wrote:
> >
> > A bug was identified where the KTAP below caused an infinite loop:
> >
> >  TAP version 13
> >  ok 4 test_case
> >  1..4
> >
> > The infinite loop was caused by the parser not parsing a test plan
> > if following a test result line.
> >
> > Fix bug to correctly parse test plan and add error if test plan is
> > missing.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> Thanks for looking into this: I don't think we want to unconditionally
> error if there's no test plan, though. Pretty much no parameterised
> tests include one -- it's not always possible to know how many tests
> there'll be in advance -- so this triggers all of the time.
>
> Maybe we can only include an error if we find a test plan line after
> an existing result, or something?

Hi David!

I thought I'd include the error in the first version but I figured it
might not be accepted. Technically it is improper KTAP for the test
plan to be missing so the error would be correct but because it fires
on parameterized tests which is not ideal.

I wonder for parameterized tests if we could output a test plan:
"1..X" indicating an unknown number of tests or something similar. I'd
be happy to implement this. However, I am happy to remove the error
for the second version.

Thanks!
-Rae

>
> -- David
>
> >  tools/testing/kunit/kunit_parser.py    | 12 +++++++-----
> >  tools/testing/kunit/kunit_tool_test.py |  5 ++---
> >  2 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/=
kunit_parser.py
> > index 29fc27e8949b..5dcbc670e1dc 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -761,20 +761,22 @@ def parse_test(lines: LineStream, expected_num: i=
nt, log: List[str], is_subtest:
> >                 test.name =3D "main"
> >                 ktap_line =3D parse_ktap_header(lines, test, printer)
> >                 test.log.extend(parse_diagnostic(lines))
> > -               parse_test_plan(lines, test)
> > +               plan_line =3D parse_test_plan(lines, test)
> >                 parent_test =3D True
> >         else:
> >                 # If not the main test, attempt to parse a test header =
containing
> >                 # the KTAP version line and/or subtest header line
> >                 ktap_line =3D parse_ktap_header(lines, test, printer)
> >                 subtest_line =3D parse_test_header(lines, test)
> > +               test.log.extend(parse_diagnostic(lines))
> > +               plan_line =3D parse_test_plan(lines, test)
> >                 parent_test =3D (ktap_line or subtest_line)
> >                 if parent_test:
> > -                       # If KTAP version line and/or subtest header is=
 found, attempt
> > -                       # to parse test plan and print test header
> > -                       test.log.extend(parse_diagnostic(lines))
> > -                       parse_test_plan(lines, test)
> >                         print_test_header(test, printer)
> > +
> > +       if parent_test and not plan_line:
> > +                       test.add_error(printer, 'missing test plan!')
> > +
> >         expected_count =3D test.expected_count
> >         subtests =3D []
> >         test_num =3D 1
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kun=
it/kunit_tool_test.py
> > index 0bcb0cc002f8..e1e142c1a850 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -181,8 +181,7 @@ class KUnitParserTest(unittest.TestCase):
> >                         result =3D kunit_parser.parse_run_tests(
> >                                 kunit_parser.extract_tap_lines(
> >                                 file.readlines()), stdout)
> > -               # A missing test plan is not an error.
> > -               self.assertEqual(result.counts, kunit_parser.TestCounts=
(passed=3D10, errors=3D0))
> > +               self.assertEqual(result.counts, kunit_parser.TestCounts=
(passed=3D10, errors=3D2))
> >                 self.assertEqual(kunit_parser.TestStatus.SUCCESS, resul=
t.status)
> >
> >         def test_no_tests(self):
> > @@ -203,7 +202,7 @@ class KUnitParserTest(unittest.TestCase):
> >                 self.assertEqual(
> >                         kunit_parser.TestStatus.NO_TESTS,
> >                         result.subtests[0].subtests[0].status)
> > -               self.assertEqual(result.counts, kunit_parser.TestCounts=
(passed=3D1, errors=3D1))
> > +               self.assertEqual(result.counts, kunit_parser.TestCounts=
(passed=3D1, errors=3D2))
> >
> >
> >         def test_no_kunit_output(self):
> >
> > base-commit: 0619a4868fc1b32b07fb9ed6c69adc5e5cf4e4b2
> > --
> > 2.48.1.711.g2feabab25a-goog
> >

