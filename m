Return-Path: <linux-kselftest+bounces-36220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E8AF0578
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 23:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30A47AF4D3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB5302066;
	Tue,  1 Jul 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcpR2GyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5072EE5FD
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404334; cv=none; b=PSihkUmq7kiyYjaCvT//QlUy1RHHdRzyQFc1z4u8+AYYNNYGKvdGN8C7IWvmQ8dr6NVLzU9Me4+UinzTsfcTgAxcwyybkjma6UdALZKz3xZzqNJ8urCTpzVqefI26DajZKaK6/wfLheCe+JdWNiLJwPB0a4jNrGabY9m5y4na7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404334; c=relaxed/simple;
	bh=qBtZSmm2R4iCXjvzCaQg+eHFsA8g7clWudabrggPz4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqNcqUIjNEwg6LRR2aODGfRV1Bx6yAihY8hX7Rm8G+55tqwHr/Oe5IVKLJTqYsFtPCgqJ0AhyNPxuYnlnRgiwdV2AqCe8ggjNPjuOMHxOJZJZt0eREeAFlhEbnI2a92foLtsg2B6S0Jei29IgFUY0SsBF5FMe7Vp02c5dVGj46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcpR2GyF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70109af5f70so17438266d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751404331; x=1752009131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjs28VW5+FZErUTPed61OdD+0y2hdWgedPzyPoSbu9Q=;
        b=AcpR2GyF4B1TfsNOcdqbdDzSpFuDSHgo254Y4BMYjwBaK0ZKYDyzAzyWxfvO9Ca+XC
         v2yYMChhmz2HPUWeYtNKz+4DDbubfvQXy61jR5gU9OIbwWlVQSmuV5hiOeRnlnCP0uKU
         ukX7XIhFEllCaGIkAs3FdJtSPgJWMtU6w+1Y9TvY/bch/YIPEcfYg9gzD55ie9Aa/Yp8
         WkL526LRWILl01YCytX8lzTFYkP5Yq3D/A0jaK5wQ/tw4gtEsNP0HdDbtwadNeNQj8ou
         WP+ERx5BciWFhZ5lKwIeVKm1TSRc3jOP37hW37I/DVGN+0nmVVhBmZlvUckBF585yP9t
         I8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751404331; x=1752009131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjs28VW5+FZErUTPed61OdD+0y2hdWgedPzyPoSbu9Q=;
        b=WtxNy/7pIoaId8WHa5+SkaVyT5WN83CFEN35rEfLtOTr8d4oU5tKPDj8/pZF4XCBbz
         LaWhuYRusIS8Odgnr4kuDZX+toKA75WvUdcw7Ykq1wWpLS4Sw05hy8ZBR1oky3RTfxQY
         J3/bGQiRy/LGm4pcr88fGrvZusiNtBFMtf40D4OtJkbj61j/9pm9m8/z6SQMjELhviIW
         6gyhkqZkVGWXQWQ3byTNFv+ooB0aB7Anwb5EsoNLeQDD6zLty1jFlvsP6t/SfoSSmCVb
         caI8vzRm3qR1Nn6ENDa1aRE3OSf2BFpKyrrz9VYTP8tizYzt5P63oartT6IQHUWFjDB0
         9o4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpgB+M+NUm8/4gkZJ3lRqbiZdymOJ/wonam1tyQDreYJpilvsF5eDgot51rMe8cIckEb6KMxpJBmSdy6ghBa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGlLSdg0ZjYyTc9HLzZmXC0af2iweDqGv5KOLAHt2kfEnkCqVb
	m03ckrruqcAkGYnjJG7Orv22hDCOXgCJIpJ9ScFjnUqrrH2YdAverphwHdFPUyPk0+3zS/QVMyc
	UqcNHHKR3Glc8yBUnaAGPLbJ0XTaM5TVnT8G6Fp6y
X-Gm-Gg: ASbGnctOItlZzPQ0J8Cxntc2ROWzAMBczmoMUOW284CxteFgwulfi02FCG1qWmMv6Ok
	vgG1gIdTyO7alBBi0fpmxx+iL2O8N7hVJcNio4QoEoNcwJuzwETlWKy39VuHh7y9sm+nP+soxdB
	W1bPXfXHybmnQOBs/V2AEkbAKVM4tKR8cRkX0Vcl5UU8/riBK2uNJo0owkjry/usNThtkZwJQop
	g==
X-Google-Smtp-Source: AGHT+IGTbnT2z3OUimiYbvvSRJZHyO7+NTUm+CPbvwarqnp3tnVnFXsJiBtY1W/8vqhPCZSa3CP2wtLxEfAWF5KoW3c=
X-Received: by 2002:a05:6214:5f02:b0:6fd:7298:a36f with SMTP id
 6a1803df08f44-702b1b3c530mr1824386d6.21.1751404330971; Tue, 01 Jul 2025
 14:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de> <20250626-kunit-kselftests-v4-8-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-8-48760534fef5@linutronix.de>
From: Rae Moar <rmoar@google.com>
Date: Tue, 1 Jul 2025 17:11:59 -0400
X-Gm-Features: Ac12FXz7A5rV9E83a27nT7mq-MXVyxBMZkeIzUekc3ETv1a6ZI2Tbu3oWaYgD3I
Message-ID: <CA+GJov45CF67nKJ7AC=g0fPL68pLdJbvJBwG8ecn9OUZ7hCewA@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] kunit: tool: Don't overwrite test status based
 on subtest counts
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 2:10=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> If a subtest itself reports success, but the outer testcase fails,
> the whole testcase should be reported as a failure.
> However the status is recalculated based on the test counts,
> overwriting the outer test result.
> Synthesize a failed test in this case to make sure the failure is not
> swallowed.

Hello!

This is a very exciting patch series! However, I have a few concerns
with this patch.

When I parse the following KTAP with this change:

KTAP version 1
1..2
    KTAP version 1
    1..2
        ok 1 test 1
        not ok 2 test 2
not ok 1 subtest 1
    KTAP version 1
    1..1
        not ok 1 subsubtest 1
not ok 2 subtest 2

The output is:

[20:54:12] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[20:54:12] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[20:54:12] [PASSED] test 1
[20:54:12] [FAILED] test 2
[20:54:12] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FA=
ILED] subtest 1 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[20:54:12] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D (1 subtest) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
[20:54:12] [FAILED] subsubtest 1
[20:54:12] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [FA=
ILED] subtest 2 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[20:54:12] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[20:54:12] Testing complete. Ran 6 tests: passed: 1, failed: 5

This reports a total of 6 tests, which is not equivalent to the three
subtests plus the two suites. I believe this is because the change to
bubble_up_test_results below double counts the failed test case.

Historically, the KUnit parser only counts the results of test cases,
not the suites. I would like to stay as close to this as possible so
as to not inflate existing testing numbers. However, I believe the
main concern here is the case where if there is a suite reporting
failure but all subtests pass, it will not appear in the summary line.
For example,

KTAP version 1
1..1
    KTAP version 1
    1..1
        ok 1 test 1
not ok 1 subtest 1

Reporting: All passing: Tests run: 1, passed: 1

This is absolutely an important edge case to cover. Therefore, we
should add 1 failure count to the suite count if the bubbled up
results indicate it should instead pass.

Thanks!
-Rae

>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>  tools/testing/kunit/kunit_parser.py                                  | 5=
 +++++
>  tools/testing/kunit/kunit_tool_test.py                               | 3=
 ++-
>  tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3=
 +++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/ku=
nit_parser.py
> index c176487356e6c94882046b19ea696d750905b8d5..2478beb28fc3db825855ad462=
00340e884da7df1 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -686,6 +686,11 @@ def bubble_up_test_results(test: Test) -> None:
>                 counts.add_status(status)
>         elif test.counts.get_status() =3D=3D TestStatus.TEST_CRASHED:
>                 test.status =3D TestStatus.TEST_CRASHED
> +       if not test.ok_status():
> +               for t in subtests:
> +                       if not t.ok_status():
> +                               counts.add_status(t.status)
> +                               break

Here instead I recommend checking if not test.ok_status() and
test.counts.get_status() =3D=3D TestStatus.SUCCESS and if so
counts.add_status(status)

>
>  def parse_test(lines: LineStream, expected_num: int, log: List[str], is_=
subtest: bool, printer: Printer) -> Test:
>         """
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index b74dc05fc2fe5b3ff629172fc7aafeb5c3d29fb3..48a0dd0f9c87caf9f018aade1=
61db90a613fc407 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -170,8 +170,9 @@ class KUnitParserTest(unittest.TestCase):
>                 with open(nested_log) as file:
>                         result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
status)
> -               self.assertEqual(result.counts.failed, 2)
> +               self.assertEqual(result.counts.failed, 3)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[0].status)
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.=
subtests[0].subtests[0].status)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[1].status)
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[1].subtests[0].status)
>
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-ne=
sted.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested=
.log
> index 2e528da39ab5b2be0fca6cf9160c10929fba3c9e..5498dfd0b0db24663e1a1e9bf=
78c587de6746522 100644
> --- a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.lo=
g
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.lo=
g
> @@ -1,5 +1,8 @@
>  KTAP version 1
>  1..2
> +    KTAP version 1
> +    1..1
> +        ok 1 test 1
>  not ok 1 subtest 1
>      KTAP version 1
>      1..1
>
> --
> 2.50.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kunit-dev=
/20250626-kunit-kselftests-v4-8-48760534fef5%40linutronix.de.

