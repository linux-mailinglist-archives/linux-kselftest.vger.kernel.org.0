Return-Path: <linux-kselftest+bounces-36554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE10AF933B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A242817A0D0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5682F3C3C;
	Fri,  4 Jul 2025 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Trik42J8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3NQGlFpi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11A28C2A4;
	Fri,  4 Jul 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633741; cv=none; b=HFHovYSaZyqg5grvA+U3e+fQjMrxPzfzG4HprNI7y6a/awziD6KibweqIOBPp8b0ivxb3t8Qp/rEMQFURQUp78pbMa+ASmpaOWWHty4A1dzX2ORYDj/rBOvui0cKTzl5ILMJoMn2zU4yAvWrDeWmlN5IDlaBb8lVYAvd0EqQmj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633741; c=relaxed/simple;
	bh=QNqx/Wlj9nCWIT8fMgfwx3NmivnXDqJI/W6mFi+gCRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOwAIot2gPvsDU+rGhz9GMRSSBL5Rc3D8l7oqkxEfQ9ohbPMA39L0rwwRaokt0mZu+i/4PhPfv06dRleq5Fh6NogKdwydYoniYdP1omp2TGaxkWJ5MM3RTRNeIGE99AXNMGNs4WYYHliDvKWfvZVwvKulkxYr5cEIkvzWBST4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Trik42J8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3NQGlFpi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 4 Jul 2025 14:55:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751633737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siSheAnqTz9/4N7NpEjvCWRV6o0nWfZMJg4SzJ4Lsro=;
	b=Trik42J8gxVN7HCZYZgBXLMap/JtEPimOltNmk1ZIFK6WWs0t024+y5ByCmthWGF0CyCn/
	gNjxaBm9UBjbA+321JYdP5NmtbVYz5BWnjxrdZy3j4xTpF0gmtjm7XtwPsbPuAg8Q2le2O
	hqEewnnvI/rrgeomydG9pZSzPjrpXQXVu77AZIbBCQ3UnygB6JETA16kVPie9Z6vHGMI1N
	hjYg+SMhvuiGUW0lIOezLPPkXW5Rg5TlfxI9YkrpdUh7GLF02h6scu4aca46TDrVP0D6Hn
	yJCUemFvQG/3I88x+LyKTY1Jpud+Zfc9GalFrY+ajnyW35Uk13oQUrdgOphs9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751633737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siSheAnqTz9/4N7NpEjvCWRV6o0nWfZMJg4SzJ4Lsro=;
	b=3NQGlFpij+1fr3PrzxZLqo1wM5XOQqaq53IJg6c+2TeIRgDlaEpQXKAUC0YWpDpUUO2MQ5
	NABcMwboGoBCODCQ==
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
Message-ID: <20250704145203-1dbf1c70-5ce9-4654-9995-4b794a8ee96e@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-8-48760534fef5@linutronix.de>
 <CA+GJov45CF67nKJ7AC=g0fPL68pLdJbvJBwG8ecn9OUZ7hCewA@mail.gmail.com>
 <20250703170653-0747ad3a-ee33-4ce9-9f69-1118b0d8260a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703170653-0747ad3a-ee33-4ce9-9f69-1118b0d8260a@linutronix.de>

Hi Rae,

On Thu, Jul 03, 2025 at 05:30:02PM +0200, Thomas Weiﬂschuh wrote:
> On Tue, Jul 01, 2025 at 05:11:59PM -0400, Rae Moar wrote:

<snip>

> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > Reviewed-by: David Gow <davidgow@google.com>
> > > ---
> > >  tools/testing/kunit/kunit_parser.py                                  | 5 +++++
> > >  tools/testing/kunit/kunit_tool_test.py                               | 3 ++-
> > >  tools/testing/kunit/test_data/test_is_test_passed-failure-nested.log | 3 +++
> > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > > index c176487356e6c94882046b19ea696d750905b8d5..2478beb28fc3db825855ad46200340e884da7df1 100644
> > > --- a/tools/testing/kunit/kunit_parser.py
> > > +++ b/tools/testing/kunit/kunit_parser.py
> > > @@ -686,6 +686,11 @@ def bubble_up_test_results(test: Test) -> None:
> > >                 counts.add_status(status)
> > >         elif test.counts.get_status() == TestStatus.TEST_CRASHED:
> > >                 test.status = TestStatus.TEST_CRASHED
> > > +       if not test.ok_status():
> > > +               for t in subtests:
> > > +                       if not t.ok_status():
> > > +                               counts.add_status(t.status)
> > > +                               break
> > 
> > Here instead I recommend checking if not test.ok_status() and
> > test.counts.get_status() == TestStatus.SUCCESS and if so
> > counts.add_status(status)
> 
> Thanks for the recommendation. I tried this and it works well for this specific
> testcase, but unfortunately all kinds of othes tests are now broken.
> I'll look into it some more, but any hints are highly appreciated.
> It has been a while since I looked at the code.

The following variant passes all tests. What do you think?

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 333cd3a4a56b..5338489dcbe4 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -689,6 +689,9 @@ def bubble_up_test_results(test: Test) -> None:
        elif test.counts.get_status() == TestStatus.TEST_CRASHED:
                test.status = TestStatus.TEST_CRASHED
 
+       if status == TestStatus.FAILURE and test.counts.get_status() == TestStatus.SUCCESS:
+               counts.add_status(status)
+

