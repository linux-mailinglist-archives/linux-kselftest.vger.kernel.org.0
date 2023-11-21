Return-Path: <linux-kselftest+bounces-364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644FA7F259E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 07:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AB51C21930
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED531A5AE;
	Tue, 21 Nov 2023 06:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lc0EUC/6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA452CA
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 22:05:29 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-82-21.bstnma.fios.verizon.net [173.48.82.21])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AL64o6L016805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 01:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1700546694; bh=YzevXqXUpMqRMD/ZnDIZC1f6cVkzH1dUVy+KDqZTPFQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lc0EUC/62fTDcfy3tluLJp++BIZAt62K+ERWM2CQFx3MevJbA7Kw/YbV+cEshGUsW
	 kpvnWdDXULG3clbzhTuLaqqMsc8umzRXKpJEGFwSExJ/w0Fg0GxhjvUXumSVUyKS5G
	 GbDykyAHLWdSGQYFw2K+wsLsTmO/vORBQ41Lo2N/Yf1BDpaFecKrE+UWqZfSW8gMUl
	 U/feSR1/wq6mfiy3/eRxYKglziiJrwKP+IZRDBjmwjJBCc5CNgzr3rbKrOoBi/T4VP
	 j+okSU8CITBs3avwm8tecckqsmDPMd0Knaxsg6sprwGKpxR4BE+HjEAQhdECRcA9qe
	 AdfGuHiFEnJhA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2669715C02B0; Tue, 21 Nov 2023 01:04:50 -0500 (EST)
Date: Tue, 21 Nov 2023 01:04:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mark Brown <broonie@kernel.org>
Cc: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>,
        Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
        workflows@vger.kernel.org, joe@perches.com, apw@canonical.com,
        davidgow@google.com, rostedt@goodmis.org, skhan@linuxfoundation.org,
        djwong@kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, vkabatov@redhat.com,
        cki-project@redhat.com, kernelci@lists.linux.dev
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Message-ID: <20231121060450.GB335601@mit.edu>
References: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <87sf50imba.fsf@collabora.com>
 <20231120205131.GA291888@mit.edu>
 <92c2f89d-f8a6-4260-b10d-671011cf1f70@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c2f89d-f8a6-4260-b10d-671011cf1f70@sirena.org.uk>

On Mon, Nov 20, 2023 at 10:27:33PM +0000, Mark Brown wrote:
> This is the sort of thing that kcidb (which Nikolai works on) is good at
> ingesting, I actually do push all my CI's test results into there
> already:
> 
>    https://github.com/kernelci/kcidb/
> 
> (the dashboard is down currently.)  A few other projects including the
> current KernelCI and RedHat's CKI push their data in there too, I'm sure
> Nikolai would be delighted to get more people pushing data in.  The goal
> is to merge this with the main KernelCI infrastructure, it's currently
> separate while people figure out the whole big data thing.

Looking at the kernelci, it appears that it's using a JSON submission
format.  Is there conversion scripts that take a KTAP test report, or
a Junit XML test report?

> The KernelCI LF project is funding kcidb with precisely this goal for
> the reasons you outline, the data collection part seems to be relatively
> mature at this point but AIUI there's a bunch of open questions with the
> analysis and usage side, partly due to needing to find people to work on
> it.

Indeed, this is the super hard part.  Having looked at the kernelci
web site, its dashboard isn't particularly useful for what I'm trying
to do with it.  For my part, when analyizing a single test run, the
kernelci dashboard isn't particularly helpful.  What I need is
something more like this:

ext4/4k: 554 tests, 48 skipped, 4301 seconds
ext4/1k: 550 tests, 3 failures, 51 skipped, 6739 seconds
  Failures: generic/051 generic/475 generic/476
ext4/ext3: 546 tests, 138 skipped, 4239 seconds
ext4/encrypt: 532 tests, 3 failures, 159 skipped, 3218 seconds
  Failures: generic/681 generic/682 generic/691
ext4/nojournal: 549 tests, 3 failures, 118 skipped, 4477 seconds
  Failures: ext4/301 ext4/304 generic/455
ext4/ext3conv: 551 tests, 49 skipped, 4655 seconds
ext4/adv: 551 tests, 4 failures, 56 skipped, 4987 seconds
  Failures: generic/477 generic/506
  Flaky: generic/269: 40% (2/5)   generic/455: 40% (2/5)
ext4/dioread_nolock: 552 tests, 48 skipped, 4538 seconds
ext4/data_journal: 550 tests, 2 failures, 120 skipped, 4401 seconds
  Failures: generic/455 generic/484
ext4/bigalloc_4k: 526 tests, 53 skipped, 4537 seconds
ext4/bigalloc_1k: 526 tests, 61 skipped, 4847 seconds
ext4/dax: 541 tests, 1 failures, 152 skipped, 3069 seconds
  Flaky: generic/269: 60% (3/5)
Totals: 6592 tests, 1053 skipped, 72 failures, 0 errors, 50577s

... which summarizes 6,592 tests in 20 lines, and for any test that
has failed, we rerun it four more times, so we can get an indication
of whether a test is a hard failure, or a flaky failure.

(I don't need to see all of the tests that passes; it's the test
failures or the test flakes that are significant.)

And then when comparing between multiple test runs, that's when I'm
interesting in see which tests may have regressed, or which tests may
have been fixed when going in between version A and version B.

And right now, kernelci doesn't have any of that.  So it might be hard
to convinced overloaded maintainers to upload test runs to kernelci,
when they don't see any immediate benefit of uploading the kernelci db.

There is a bit of a chicken-and-egg problem, since without the test
results getting uploaded, it's hard to get the analysis functionality
implemented, and without the analysis features, it's hard to get
developers to upload the data.

That being said, a number of file system developers probably have
several years worth of test results that we could probably give you.
I have hundreds of junit.xml files, with information about how kernel
version, what version of xfstesets, etc, that was used.  I'm happy to
make samples of it available for anyone who is interested.

Cheers,

						- Ted

