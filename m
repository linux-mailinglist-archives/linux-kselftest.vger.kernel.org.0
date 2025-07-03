Return-Path: <linux-kselftest+bounces-36455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D2AF7C69
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F76189E87F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE91A2545;
	Thu,  3 Jul 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7KIdsqE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FP9UlKGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD529827E;
	Thu,  3 Jul 2025 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556606; cv=none; b=qIjqClWEevTFlDPiiMLwP8l2lpX7zj/L9lyUlvT7SuIf8h4eIU1nMzUVTOAl1K8QHEjEExqL/l8qwOYwXp4EG6SOkBK/h544YGoouCXJaF4n/HoGLF/85uRF2w8b9pk3Q0hD1pcByeYlu28dKxoKO4NzaZDFLtg1x1egAXYOrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556606; c=relaxed/simple;
	bh=8wqrij/Q6ZjbLCjBATPTbvk2Hc6VwWSecx213vuUWpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIlKqXqbb9zQh7Ol6ZISz0L1TeOkcIDMFkC03Z9Urw5xd20eCkxG5kamCNmyDYHwrq38OQDI4PS6RrUNqmYJ08/YfNb/7JpXI4DhC4DmFKp48WbGWs1bW81R7U0BRgCy2z7XfYbZu/XA+IRSvNZWvwD8WznCfLudOWmTkRdkB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c7KIdsqE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FP9UlKGI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 3 Jul 2025 17:29:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751556602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q98/x4tL/TymfrpONP3RgYZjTEFmRIOSSIZVzyH5YIY=;
	b=c7KIdsqE0nYXCz4g2rzOTNAcFL+SVPgtE03WyPjGcHcvO9eCTJwiStu7DlMv89jfXsNemK
	mSPoDbGgBvFnQnxx9JC+1MpnssxYdZxmPa0+6/ZaMw4SNp4H7yILyLbv0IVoztpOD1wAVi
	kjTKOzXwUB6YZsSdj3EZbGp9XMNjOaGhI8aja2GXGb8ETCW31T+UKzg3yVr3odn3Pj+aR6
	ckxUuI8H+QHvjWcbuH8zvrF/vtxErQt8Tpf+/urxgG+XQaffvlF3fwFh8xU40d2C05N78I
	d7KRBT32CWQ9CciQtG/Ej80kTUSCoz/UEsDU7rmADaYQnjMHWUaZ+GwqKvrMdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751556602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q98/x4tL/TymfrpONP3RgYZjTEFmRIOSSIZVzyH5YIY=;
	b=FP9UlKGItlYBuwqSVIAWGNDwWLSH15HNMLN5tkla3tHgyvULPdQx2zCBrABIcwGXpzOj28
	8g8xArfV5LgYLxDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Rae Moar <rmoar@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	workflows@vger.kernel.org
Subject: Re: [PATCH v4 08/15] kunit: tool: Don't overwrite test status based
 on subtest counts
Message-ID: <20250703170653-0747ad3a-ee33-4ce9-9f69-1118b0d8260a@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-8-48760534fef5@linutronix.de>
 <CA+GJov45CF67nKJ7AC=g0fPL68pLdJbvJBwG8ecn9OUZ7hCewA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+GJov45CF67nKJ7AC=g0fPL68pLdJbvJBwG8ecn9OUZ7hCewA@mail.gmail.com>

On Tue, Jul 01, 2025 at 05:11:59PM -0400, Rae Moar wrote:
> On Thu, Jun 26, 2025 at 2:10 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > If a subtest itself reports success, but the outer testcase fails,
> > the whole testcase should be reported as a failure.
> > However the status is recalculated based on the test counts,
> > overwriting the outer test result.
> > Synthesize a failed test in this case to make sure the failure is not
> > swallowed.
> 
> This is a very exciting patch series! However, I have a few concerns
> with this patch.

Thanks for the review!

> When I parse the following KTAP with this change:
> 
> KTAP version 1
> 1..2
>     KTAP version 1
>     1..2
>         ok 1 test 1
>         not ok 2 test 2
> not ok 1 subtest 1
>     KTAP version 1
>     1..1
>         not ok 1 subsubtest 1
> not ok 2 subtest 2
> 
> The output is:
> 
> [20:54:12] ============================================================
> [20:54:12] ======================= (2 subtests) =======================
> [20:54:12] [PASSED] test 1
> [20:54:12] [FAILED] test 2
> [20:54:12] ==================== [FAILED] subtest 1 ====================
> [20:54:12] ======================= (1 subtest) ========================
> [20:54:12] [FAILED] subsubtest 1
> [20:54:12] ==================== [FAILED] subtest 2 ====================
> [20:54:12] ============================================================
> [20:54:12] Testing complete. Ran 6 tests: passed: 1, failed: 5
> 
> This reports a total of 6 tests, which is not equivalent to the three
> subtests plus the two suites. I believe this is because the change to
> bubble_up_test_results below double counts the failed test case.
> 
> Historically, the KUnit parser only counts the results of test cases,
> not the suites. I would like to stay as close to this as possible so
> as to not inflate existing testing numbers. However, I believe the
> main concern here is the case where if there is a suite reporting
> failure but all subtests pass, it will not appear in the summary line.
> For example,
> 
> KTAP version 1
> 1..1
>     KTAP version 1
>     1..1
>         ok 1 test 1
> not ok 1 subtest 1
> 
> Reporting: All passing: Tests run: 1, passed: 1
> 
> This is absolutely an important edge case to cover. Therefore, we
> should add 1 failure count to the suite count if the bubbled up
> results indicate it should instead pass.

Makes sense.

> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > Reviewed-by: David Gow <davidgow@google.com>
> > ---
> >  tools/testing/kunit/kunit_parser.py                                  | 5 +++++
> >  tools/testing/kunit/kunit_tool_test.py                               | 3 ++-
> >  tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3 +++
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > index c176487356e6c94882046b19ea696d750905b8d5..2478beb28fc3db825855ad46200340e884da7df1 100644
> > --- a/tools/testing/kunit/kunit_parser.py
> > +++ b/tools/testing/kunit/kunit_parser.py
> > @@ -686,6 +686,11 @@ def bubble_up_test_results(test: Test) -> None:
> >                 counts.add_status(status)
> >         elif test.counts.get_status() == TestStatus.TEST_CRASHED:
> >                 test.status = TestStatus.TEST_CRASHED
> > +       if not test.ok_status():
> > +               for t in subtests:
> > +                       if not t.ok_status():
> > +                               counts.add_status(t.status)
> > +                               break
> 
> Here instead I recommend checking if not test.ok_status() and
> test.counts.get_status() == TestStatus.SUCCESS and if so
> counts.add_status(status)

Thanks for the recommendation. I tried this and it works well for this specific
testcase, but unfortunately all kinds of othes tests are now broken.
I'll look into it some more, but any hints are highly appreciated.
It has been a while since I looked at the code.

> >  def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool, printer: Printer) -> Test:
> >         """
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index b74dc05fc2fe5b3ff629172fc7aafeb5c3d29fb3..48a0dd0f9c87caf9f018aade161db90a613fc407 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -170,8 +170,9 @@ class KUnitParserTest(unittest.TestCase):
> >                 with open(nested_log) as file:
> >                         result = kunit_parser.parse_run_tests(file.readlines(), stdout)
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
> > -               self.assertEqual(result.counts.failed, 2)
> > +               self.assertEqual(result.counts.failed, 3)
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
> > +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.subtests[0].subtests[0].status)
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].subtests[0].status)
> >
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
> > index 2e528da39ab5b2be0fca6cf9160c10929fba3c9e..5498dfd0b0db24663e1a1e9bf78c587de6746522 100644
> > --- a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
> > +++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
> > @@ -1,5 +1,8 @@
> >  KTAP version 1
> >  1..2
> > +    KTAP version 1
> > +    1..1
> > +        ok 1 test 1
> >  not ok 1 subtest 1
> >      KTAP version 1
> >      1..1
> >
> > --
> > 2.50.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion visit https://groups.google.com/d/msgid/kunit-dev/20250626-kunit-kselftests-v4-8-48760534fef5%40linutronix.de.

