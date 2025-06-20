Return-Path: <linux-kselftest+bounces-35432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3366AE1BF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 15:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDACB7AE2EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BA28D8E8;
	Fri, 20 Jun 2025 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xbpk1Gcv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSETFzgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87E28A702;
	Fri, 20 Jun 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425615; cv=none; b=S9g3NEbTndWPQCrqRmxSTNj3GQ4gouX5aWBrf4cVDjTGDlBEC7AOPTXGFnSvE55htNG4r2dzeNIuyu7ZHFTa/ayvm4Asv9A7NVNZ/BRznCsWerp614iGUFU3sbECzvk19NQaYk964TX9n9ee8RjDKckFd5NdLARq89tVXoJQzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425615; c=relaxed/simple;
	bh=3vPdSbxRbyaoVOn3PcDa5iy1hPOieg/lPxOkMCMwclY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqF8uXqleGTNAKE8iqDEEA9NlLssFrXi17y0kNsXkqjXcY2Jf/3n7zE1tjbFzK/uOCAWO9wqwhxbqJl69nny/iwR5DJQ2r5Fgfx6ZNSiJKMB+b+bS9h5jhq52hFH0f0npgW6C4sYgUzKpVnI1r7QoVZqT0JB9gWAFc1SJQHVLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xbpk1Gcv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSETFzgg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 15:20:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wtKTkQ0DJEvdIq2uKb64fr5/HkxwWYfnbB81VGsqgQ=;
	b=xbpk1GcvM2CXI7N+DS6uqb548rLThLHg/zqPom8QVEOT5a/F66PvrvtRfsQsj06JgllVrN
	cxVqhsouaY7hRE/8702pTpFKqf19ByPCB/Se+NqvTUziRwYMndFAJYn1AJ/e2+QYjInlnl
	QlFn4C+i4aON3q32OHt2+FiEAUnXlnJTeLFhSf8aWted+OZzjUIM4YP5M4m5lEhadIJlj5
	68yuQbDlQI8clAyATZE9bkeYahAlnNHeyTIRLlGVQO59ReNhRdfeAEbQ8uW1r6G6KwpUoW
	HWIgt14WEuN/AZVgEQogB0xD0a+OKnv83IceXbXM/7PDWrpQ/SW8js51gSeNiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wtKTkQ0DJEvdIq2uKb64fr5/HkxwWYfnbB81VGsqgQ=;
	b=dSETFzgg52sTw+31LwsX+wqORY9FaScJ2yCaW+8TvpLO5n2KBPBHCHdH46BRV6EWHtb8tR
	kBZZlj4ovuzufjBw==
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
Subject: Re: [PATCH v3 08/16] kunit: tool: Add test for nested test result
 reporting
Message-ID: <20250620151847-953c56f6-5a20-4e46-82ce-8b58fd409250@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-8-55e3d148cbc6@linutronix.de>
 <CABVgOSmTXj_t0_nJyjhc=mvpPkGGW5D4qGd0WajmVgVyMgd_Hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSmTXj_t0_nJyjhc=mvpPkGGW5D4qGd0WajmVgVyMgd_Hg@mail.gmail.com>

On Fri, Jun 20, 2025 at 05:37:39PM +0800, David Gow wrote:
> On Wed, 11 Jun 2025 at 15:38, Thomas Weiﬂschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Currently there is no test validating the result reporting from nested
> > tests. Add one, it will also be used to validate upcoming changes to the
> > nested test parsing.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> 
> This looks good, modulo a couple of minor suggestions below.
> 
> Regardless,
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
> >  tools/testing/kunit/kunit_tool_test.py                           | 9 +++++++++
> >  .../kunit/test_data/test_is_test_passed-failure-nested.log       | 7 +++++++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index bbba921e0eacb18663abfcabb2bccf330d8666f5..691cde9b030f7729128490c1bdb42ccee1967ad6 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -165,6 +165,15 @@ class KUnitParserTest(unittest.TestCase):
> >                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
> >                 self.assertEqual(result.counts.errors, 0)
> >
> > +       def test_parse_failed_nested_tests_log(self):
> > +               nested_log = test_data_path('test_is_test_passed-failure-nested.log')
> > +               with open(nested_log) as file:
> > +                       result = kunit_parser.parse_run_tests(file.readlines(), stdout)
> > +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
> > +               self.assertEqual(result.counts.failed, 2)
> > +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[0].status)
> 
> Is it worth also testing the value of the nested test's result here? i.e.,
> self.assertEqual(kunit_parser.TestStatus.FAILURE,
> result.subtests[0].subtests[0].status)

This should be result.subtests[1].subtests[0].status.
But Ack and done.

> > +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].status)
> > +
> >         def test_no_header(self):
> >                 empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
> >                 with open(empty_log) as file:
> > diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..835816e0a07715a514f5f5afab1b6250037feaf4
> > --- /dev/null
> > +++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log
> > @@ -0,0 +1,7 @@
> > +KTAP version 1
> > +1..2
> > +not ok 1 subtest 1
> > +    KTAP version 1
> > +    1..1
> > +        not ok 1 test 1
> > +not ok 2 subtest 2
> 
> Having these named 'subtest 1' and 'test 1' is a bit confusing to me
> (as it implies the outer tests are subtests of the inner ones, which
> isn't right).
> 
> Could we either swap 'subtest' and 'test' here, or -- if we want to
> preserve the match between 'subtest' here and the subtest in the
> python code -- label the inner one something like 'subsubtest'?

Ack.

