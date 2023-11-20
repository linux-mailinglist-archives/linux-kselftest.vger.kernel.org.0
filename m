Return-Path: <linux-kselftest+bounces-339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E07F1E32
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 21:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF57B281C01
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123DE208D0;
	Mon, 20 Nov 2023 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="FeS+4Q71"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67FCD
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 12:51:57 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-82-21.bstnma.fios.verizon.net [173.48.82.21])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AKKpVHE031574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 15:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1700513494; bh=Qhra/PeadF+kxbhZQdWkm4KjSgZyzyt74oOIJ4DgkH4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=FeS+4Q71mi0SljGJGvZds2wEUXSIMXqejzcia7Ms7oY6UKeyeuQjQ/mZKfRxqU7BE
	 RoXIEs4X8FSNKE8FJtYbXdNks0Hlc9uCGeQmofrG1mIZvxOac0mkOnGcZAEqU8louQ
	 1VT67MKG61XIPamVBtaLLvjqOzWeGDpbiBExz9DaLDoj1vOlWCtPshUEbUSPucX0mz
	 Xi+d+Um2Ft5zLv01aURrVORoOYHFFSQ2N7rjLs8qIkx1wG4rzMZ0w9qeju/3SJ7XL7
	 oK4Vbhgzl50cG9cNefjUY9Cm64/bcDdPGcpznWiy7pRM1qjRcannRD3EuZ7bDv9DMN
	 tF0vic9HTaCIg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 43EB615C02B0; Mon, 20 Nov 2023 15:51:31 -0500 (EST)
Date: Mon, 20 Nov 2023 15:51:31 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
        workflows@vger.kernel.org, joe@perches.com, apw@canonical.com,
        davidgow@google.com, rostedt@goodmis.org, broonie@kernel.org,
        skhan@linuxfoundation.org, djwong@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        vkabatov@redhat.com, cki-project@redhat.com, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <20231120205131.GA291888@mit.edu>
References: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <87sf50imba.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf50imba.fsf@collabora.com>

On Mon, Nov 20, 2023 at 02:30:49PM +0100, Ricardo Cañuelo wrote:
> 
> This is not trivial because tests vary a lot and we'd first need to
> define which artifacts to link to, and because whatever is linked (test
> commands, output log, results summary) would need to be stored
> forever. But since we're doing that already for basically all kernel
> mailing lists, I wonder if something like "public-inbox for test
> results" could be possible some day.

What we have at work is a way to upload the test results summary
(e.g., just KTAP result lines, or the xfstests junit XML) along with
test run metadata (e.g., what was the kernel commit on which the test
was run, and the test hardware), and this would be stored permanently.
Test artifacts is also preserved but for a limited amount of time
(e.g., some number of months or a year).

The difference in storage lifetimes is because the junit XML file
might be a few kilobytes to tens of kilobytes. but the test artifacts
might be a few megabytes to tens of megabytes.

Of course once you have this data, it becomes possible to detect when
a test may have regressed, or to detect flaky tests, and perhaps to
figure out if certain hardware configurations or kernel configurations
are more likely to trigger a particular test to fail.  So having all
of this data stored centrally would be really cool.  The only question
is who might be able to create such an infrastructure, and be able to
pay for the ongoing development and operational costs....

    	    	    		    		- Ted

