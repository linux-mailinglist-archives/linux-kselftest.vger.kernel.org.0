Return-Path: <linux-kselftest+bounces-5937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D9872484
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 17:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB8E288E17
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9302B8F70;
	Tue,  5 Mar 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="igNnHsgq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7017555
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Mar 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656802; cv=none; b=lL5LU4caG3SsnvEmXhzF/tPU3BOQDXoeGwyDRoSP012e2lpxq56hbJEO0j4PFCixUDCCr/Z0XEYaF54jQ4VwNbaHMVqaustpk9FQ0j/AxJPOv3DxUdO5Txx6qwfTM+Z+lmkUe1BkcdOh44gq1+e/Cf+Wb1Tz45iDn6seeG0BggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656802; c=relaxed/simple;
	bh=gc4Q3iOrHAFdKOGbGBM7S1/lCy9aGir7g3krCSkZWGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJo1fSRlq0jjJcC7SqOnq27mXGGB+jdE1oBQiFTZumorDuSb1XDfthfQvwvdzQV3t++meeY3qi8qcIvQ7dX5SryrljfXivR1I/qECeJzqXJuV0tbEohZtrz6qGfoQil/8FOdsU38XmXejE2s5+hZ9Lme/RqI049EXBq5VzNmXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=igNnHsgq; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tq1WJ213QzdkX;
	Tue,  5 Mar 2024 17:39:56 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tq1WH2gGnzMpnPf;
	Tue,  5 Mar 2024 17:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709656796;
	bh=gc4Q3iOrHAFdKOGbGBM7S1/lCy9aGir7g3krCSkZWGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igNnHsgqEowJBOrTNsY+ydE68SkrUDHOLYhgEDGGVoatyJmOKMt/HhHbzBb1+fYuV
	 mXHVUHxjzWRG0zTJ5tRmmL98gxWdYNjkEGTco3K/AsI0r+5XPyW1LLw4yBQamPXP1a
	 zlovfjSoVfJJsmvhKUnUm/DyoVJU/h+Qtkj59YCg=
Date: Tue, 5 Mar 2024 17:39:44 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
	keescook@chromium.org, davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240305.thuo4ahNaeng@digikod.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
 <7bb3b635-9fed-47ab-a640-ccac6d283b54@intel.com>
 <20240305.hoi8ja1eeg4C@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305.hoi8ja1eeg4C@digikod.net>
X-Infomaniak-Routing: alpha

On Tue, Mar 05, 2024 at 05:00:13PM +0100, Mickaël Salaün wrote:
> On Tue, Mar 05, 2024 at 04:48:06PM +0100, Przemek Kitszel wrote:
> > On 3/5/24 00:04, Jakub Kicinski wrote:
> > > On Mon, 4 Mar 2024 22:20:03 +0000 Mark Brown wrote:
> > > > On Wed, Feb 28, 2024 at 04:59:07PM -0800, Jakub Kicinski wrote:
> > > > 
> > > > > When running selftests for our subsystem in our CI we'd like all
> > > > > tests to pass. Currently some tests use SKIP for cases they
> > > > > expect to fail, because the kselftest_harness limits the return
> > > > > codes to pass/fail/skip. XFAIL which would be a great match
> > > > > here cannot be used.
> > > > > 
> > > > > Remove the no_print handling and use vfork() to run the test in
> > > > > a different process than the setup. This way we don't need to
> > > > > pass "failing step" via the exit code. Further clean up the exit
> > > > > codes so that we can use all KSFT_* values. Rewrite the result
> > > > > printing to make handling XFAIL/XPASS easier. Support tests
> > > > > declaring combinations of fixture + variant they expect to fail.
> > > > 
> > > > This series landed in -next today and has caused breakage on all
> > > > platforms in the ALSA pcmtest-driver test.  When run on systems that
> > > > don't have the driver it needs loaded the test skip but since this
> > > > series was merged skipped tests are logged but then reported back as
> > > > failures:
> > > > 
> > > > # selftests: alsa: test-pcmtest-driver
> > > > # TAP version 13
> > > > # 1..5
> > > > # # Starting 5 tests from 1 test cases.
> > > > # #  RUN           pcmtest.playback ...
> > > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > > # # playback: Test failed
> > > > # #          FAIL  pcmtest.playback
> > > > # not ok 1 pcmtest.playback #  Can't read patterns. Probably, module isn't loaded
> > > > # #  RUN           pcmtest.capture ...
> > > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > > # # capture: Test failed
> > > > # #          FAIL  pcmtest.capture
> > > > # not ok 2 pcmtest.capture #  Can't read patterns. Probably, module isn't loaded
> > > > # #  RUN           pcmtest.ni_capture ...
> > > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > > # # ni_capture: Test failed
> > > > # #          FAIL  pcmtest.ni_capture
> > > > # not ok 3 pcmtest.ni_capture #  Can't read patterns. Probably, module isn't loaded
> > > > # #  RUN           pcmtest.ni_playback ...
> > > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > > # # ni_playback: Test failed
> > > > # #          FAIL  pcmtest.ni_playback
> > > > # not ok 4 pcmtest.ni_playback #  Can't read patterns. Probably, module isn't loaded
> > > > # #  RUN           pcmtest.reset_ioctl ...
> > > > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > > > # # reset_ioctl: Test failed
> > > > # #          FAIL  pcmtest.reset_ioctl
> > > > # not ok 5 pcmtest.reset_ioctl #  Can't read patterns. Probably, module isn't loaded
> > > > # # FAILED: 0 / 5 tests passed.
> > > > # # Totals: pass:0 fail:5 xfail:0 xpass:0 skip:0 error:0
> > > > 
> > > > I haven't completely isolated the issue due to some other breakage
> > > > that's making it harder that it should be to test.
> > > > 
> > > > A sample full log can be seen at:
> > > > 
> > > >     https://lava.sirena.org.uk/scheduler/job/659576#L1349
> > > 
> > > Thanks! the exit() inside the skip evaded my grep, I'm testing this:
> > > 
> > > diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> > > index a52ecd43dbe3..7ab81d6f9e05 100644
> > > --- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
> > > +++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> > > @@ -127,11 +127,11 @@ FIXTURE_SETUP(pcmtest) {
> > >   	int err;
> > >   	if (geteuid())
> > > -		SKIP(exit(-1), "This test needs root to run!");
> > > +		SKIP(exit(KSFT_SKIP), "This test needs root to run!");
> > >   	err = read_patterns();
> > >   	if (err)
> > > -		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
> > > +		SKIP(exit(KSFT_SKIP), "Can't read patterns. Probably, module isn't loaded");
> > >   	card_name = malloc(127);
> > >   	ASSERT_NE(card_name, NULL);
> > > diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> > > index 20294553a5dd..356ba5f3b68c 100644
> > > --- a/tools/testing/selftests/mm/hmm-tests.c
> > > +++ b/tools/testing/selftests/mm/hmm-tests.c
> > > @@ -138,7 +138,7 @@ FIXTURE_SETUP(hmm)
> > >   	self->fd = hmm_open(variant->device_number);
> > >   	if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
> > > -		SKIP(exit(0), "DEVICE_COHERENT not available");
> > > +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
> > >   	ASSERT_GE(self->fd, 0);
> > >   }
> > > @@ -149,7 +149,7 @@ FIXTURE_SETUP(hmm2)
> > >   	self->fd0 = hmm_open(variant->device_number0);
> > >   	if (self->fd0 < 0 && hmm_is_coherent_type(variant->device_number0))
> > > -		SKIP(exit(0), "DEVICE_COHERENT not available");
> > > +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
> > >   	ASSERT_GE(self->fd0, 0);
> > >   	self->fd1 = hmm_open(variant->device_number1);
> > >   	ASSERT_GE(self->fd1, 0);
> > > 
> > > > but there's no more context.  I'm also seeing some breakage in the
> > > > seccomp selftests which also use kselftest-harness:
> > > > 
> > > > # #  RUN           TRAP.dfl ...
> > > > # # dfl: Test exited normally instead of by signal (code: 0)
> > > > # #          FAIL  TRAP.dfl
> > > > # not ok 56 TRAP.dfl
> > > > # #  RUN           TRAP.ign ...
> > > > # # ign: Test exited normally instead of by signal (code: 0)
> > > > # #          FAIL  TRAP.ign
> > > > # not ok 57 TRAP.ign
> > > 
> > > Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> > > child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.
> > > 
> > 
> > Hi, sorry for not trying to reproduce it locally and still commenting,
> > but my vfork() man page says:
> > 
> > | The child must  not  return  from  the current  function  or  call
> > | exit(3) (which would have the effect of calling exit handlers
> > | established by the parent process and flushing the parent's stdio(3)
> > | buffers), but may call _exit(2).
> > 
> > And you still have some exit(3) calls.
> 
> Correct, exit(3) should be replaced with _exit(2).

Well, I think we should be good even if some exit(3) calls remain
because the envirenment in which the vfork() call happen is already
dedicated to the running test (with flushed stdio, setpgrp() call), see
__run_test() and the fork() call just before running the
fixture/test/teardown.  Even if the test configures its own exit
handlers, they will not be run by its parent because it never calls
exit(), and the returned function either ends with a call to _exit() or
a signal.

