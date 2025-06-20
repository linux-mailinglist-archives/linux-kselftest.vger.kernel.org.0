Return-Path: <linux-kselftest+bounces-35433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CEDAE1C01
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77EB1753DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 13:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00D028C2D6;
	Fri, 20 Jun 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EW6K1yK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7TK+VSq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481528C2AF;
	Fri, 20 Jun 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425793; cv=none; b=NY93COuy6esdCNZNyPScCs36VXFcNWq1ftud1b+qt0C3qUg4ZycGN2dB2edsXxEfTqHpIuacv16iYRN/DHFRQABkVT4vBNaMUh4531riU6Pr2pAs3ERHELuWaODXEyw5T4cXsx8XhTPO6fUPiaqeb1wa8fNL9QHB2/Hsjs05nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425793; c=relaxed/simple;
	bh=iqn3ptTe/jaU2WQMuTFkZZtUnW37rgGQnIKOXTI3iBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUJq90rDLcFtcnAhEDHh6S6vBM8LjIhExVl4TCVUag8QXSc13yJcA5J9LNXBlhCsBDlCR/ClkvyvZrLMgQNcR26JdEW9UPpy6k2ZGz9QHuUlvTgsNkFSgT41BQ57JM6WS1CBq1z4hSQC+/vYq3j50mtZ+Aqg53C1jfSX9g1h8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1EW6K1yK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7TK+VSq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 15:23:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxgB6aqVu/pCEcTgKgzzcyt3tkOAQan9YRqfq83vllI=;
	b=1EW6K1yKlrmsw53vXY++fO8q63G0RtB/0QBmXMEOzpah/MThkZXkxFVOAT1p7f+vOWlMNn
	zfyWimzJnGMoup2z4JTD4RZXm0ZFiVRfAxHuPWT/GCrUBLNHT3Sk8XNoNgX7W+HjUTfn/0
	G6luI+oLzADDVJXdmWBoxzlfhsg6+G8zk/WwTRyHkXfhHsAWFkxskKfjo06AfigAVVYeR8
	cz/8M5ddRAYKMNSpE3+F7dJUy4MwvfyMtS1QfNFpexaMQT7HoDVmeR0AUIiTwCMWWPY+0w
	91JnGmG2WsxLZw5JXxE0bjk+xrWUyOQDOpX1BGOmc/joVoiGmvPbYKGZZqbHjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxgB6aqVu/pCEcTgKgzzcyt3tkOAQan9YRqfq83vllI=;
	b=z7TK+VSqwI4ZfA1aH7wEd0ySYQjyZpyxqN/0ry6nvlpQqrpi7zO+oJsJbZq9ZofmFqKoe6
	ZerOnIESUfwqFLDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Gow <davidgow@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH v3 09/16] kunit: tool: Don't overwrite test status based
 on subtest counts
Message-ID: <20250620152016-7f39b3bb-1738-4593-bc59-6ab37f04feee@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-9-55e3d148cbc6@linutronix.de>
 <CABVgOSkG3dY3THo5DQOvWj1xX8XFFnnk7CXvVE2opQJZg4nwXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSkG3dY3THo5DQOvWj1xX8XFFnnk7CXvVE2opQJZg4nwXg@mail.gmail.com>

On Fri, Jun 20, 2025 at 05:37:44PM +0800, David Gow wrote:
> On Wed, 11 Jun 2025 at 15:38, Thomas Weiﬂschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > If a subtest itself reports success, but the outer testcase fails,
> > the whole testcase should be reported as a failure.
> > However the status is recalculated based on the test counts,
> > overwriting the outer test result.
> > Synthesize a failed test in this case to make sure the failure is not
> > swallowed.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> 
> Hmm... this is definitely a nasty edge-case. I don't completely like
> this solution, but none of the other options seem drastically better.
> 
> I think the more obvious options are either to _always_ count tests
> alongside their subtests, or to _never_ do so, but acknowledge that
> "test failed, but failure count is 0" is a valid option. But neither
> of those are especially satisfying, either greatly inflating test
> counts, or creating obvious contradictions.
> 
> So I'm tentatively in favour of this, but if anyone has a nicer way of
> doing it, I'm all ears.

Agreed, it is not great. I'd also be happy for better ideas.

> The implementation looks good. If we can add the explicit checks for
> the sub(sub)test results as mentioned in the previous patch, that'd be
> even better.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> >  tools/testing/kunit/kunit_parser.py                                  | 5 +++++
> >  tools/testing/kunit/kunit_tool_test.py                               | 2 +-
> >  tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3 +++
> >  3 files changed, 9 insertions(+), 1 deletion(-)
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
> >
> >  def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool, printer: Printer) -> Test:
> >         """
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index 691cde9b030f7729128490c1bdb42ccee1967ad6..c25f52650837e83325b06bddd2aa665fd29f91d9 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -170,7 +170,7 @@ class KUnitParserTest(unittest.TestCase):
> >                 with open(nested_log) as file:
> >                         result = kunit_parser.parse_run_tests(file.readlines(), stdout)
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
> > -               self.assertEqual(result.counts.failed, 2)
> > +               self.assertEqual(result.counts.failed, 3)
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
> 
> Could we add:
> self.assertEqual(kunit_parser.TestStatus.SUCCESS,
> result.subtests[0].subtests[0].status)
> 
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)

Ack.

> and
> 
> self.assertEqual(kunit_parser.TestStatus.FAILURE,
> result.subtests[1].subtests[0].status)

This is now already in the previous patch.

> >
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
> > index 835816e0a07715a514f5f5afab1b6250037feaf4..cd9033c464792e6294905a5676346684182874ad 100644
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
> > 2.49.0
> >



