Return-Path: <linux-kselftest+bounces-5861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248AA8710F9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 00:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DC282414
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 23:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E517C6CA;
	Mon,  4 Mar 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="brpdGM0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA287C0BA
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709594047; cv=none; b=oWopLkwKTu2/v2kc+gfCD7/9KW8c8k0Um90M1YGgB7xpg7Khyx1S+jjBLhykBnCqTSvwlSmKG9vgscJ6i7BjxMzRPi/+9xB56Pb9wJSxpmf9SnXcXr69okOjvzvX2eg9LsrelPSPS0zBNbHd6s2Adly3pJA049UjVpchhUzEbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709594047; c=relaxed/simple;
	bh=YgHvzG2YsuwOX+H4OM5wHIBL3t1Fu2VTvc5UwmX/WFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTJUG6P0V8QrgElKCzjQh/PdspvZ8BcSAgvUyNcMW/jOSPKMm0kw5lQB3U8lG7xKtr09E8WwMDWkbPiWPqnOP3tALik30dK3UmQoNDumCjFHwwzkREvQDkEGeyLB9IkmvsDMeIfWhCh8ASVtg0oLUckoZauCJGxwOFds4UMtJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=brpdGM0V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so44139895ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 15:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709594045; x=1710198845; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J3EgHjH2JNsseA6FAjk1feBOG2LU8+6I/O2cbzeZS3Q=;
        b=brpdGM0VFif/mxcoqXClhD1lmFNth2Jdn3+QpsoxHrOiesrgyN4zmbdTa9VUuyJ4L2
         fRtT7LSAIy3tECGrYM8NgXSuHWuq94tWJPDk1H/j3TpRa3vdjU69RZmxQQJP9E+sGVKl
         0OxhAFEohnk3+Q/OKJX6YBP101DqO8W3QQqks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709594045; x=1710198845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3EgHjH2JNsseA6FAjk1feBOG2LU8+6I/O2cbzeZS3Q=;
        b=cK9zYKi4OEjdr5wCV+/k3HDY7Pp/37LQqHhyVdw9JmQGG7ZPQIpVRWI8cx+/dWfsuC
         0W5u3IooSVuHlOF9xaS5jwZhtn2U+5dBA83KFUHdp8JlMiggVHvjmP962cI4Yc/Uo12n
         LCwWE57WUPTxNIaH0y1jvdUqHtS4KzOZolN7ozE+/zEZ/5TezR/4exkUEtualbQjV5FY
         szNWECw3mraVu4UWchFU1V08n2YDXJXWrTyuJ9ykW7b2AarA/pqkLso3uVeSgixBy18D
         iuA+m/WnunjB8OQGrUkvyIUBBFQpl9H6zYM7r0CKwIq1VkEJQaRAeKXcqA6JbDmj1p76
         T0qA==
X-Forwarded-Encrypted: i=1; AJvYcCWKAyBhPjzWK9YH8ig441HsAD2LAkMw4FuyG6PEoIJJTLo4qAg0APUb321D2a9m9STG6D31txf4UlsPlogYpGqmWMfUY5TobP+UnU/merAf
X-Gm-Message-State: AOJu0Yzv0YwIv2qj/im3DekSoVFtiSudR17xpXFbaZQzKH7fjE20MqDk
	gxa2/FM1TR9ftwxWX7ER9vn+hjE2V9p3MPNtimCOBi1weyNOfnBFQQFrCgmNL8Ymcbu+7xbvJwM
	=
X-Google-Smtp-Source: AGHT+IG7XPQsnAFSZMY5j0anMhySKhtTqlARSj3sOzf2b9SG5IcPV0+NgM9EPq9wk9ezZTshVimSFQ==
X-Received: by 2002:a17:902:ce90:b0:1dc:fc84:edaa with SMTP id f16-20020a170902ce9000b001dcfc84edaamr310704plg.29.1709594045316;
        Mon, 04 Mar 2024 15:14:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kv14-20020a17090328ce00b001dcad9cbf8bsm9076462plb.239.2024.03.04.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 15:14:04 -0800 (PST)
Date: Mon, 4 Mar 2024 15:14:04 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org, mic@digikod.net,
	linux-security-module@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <202403041512.402C08D@keescook>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
 <20240304150411.6a9bd50b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304150411.6a9bd50b@kernel.org>

On Mon, Mar 04, 2024 at 03:04:11PM -0800, Jakub Kicinski wrote:
> On Mon, 4 Mar 2024 22:20:03 +0000 Mark Brown wrote:
> > On Wed, Feb 28, 2024 at 04:59:07PM -0800, Jakub Kicinski wrote:
> > 
> > > When running selftests for our subsystem in our CI we'd like all
> > > tests to pass. Currently some tests use SKIP for cases they
> > > expect to fail, because the kselftest_harness limits the return
> > > codes to pass/fail/skip. XFAIL which would be a great match
> > > here cannot be used.
> > > 
> > > Remove the no_print handling and use vfork() to run the test in
> > > a different process than the setup. This way we don't need to
> > > pass "failing step" via the exit code. Further clean up the exit
> > > codes so that we can use all KSFT_* values. Rewrite the result
> > > printing to make handling XFAIL/XPASS easier. Support tests
> > > declaring combinations of fixture + variant they expect to fail.  
> > 
> > This series landed in -next today and has caused breakage on all
> > platforms in the ALSA pcmtest-driver test.  When run on systems that
> > don't have the driver it needs loaded the test skip but since this
> > series was merged skipped tests are logged but then reported back as
> > failures:
> > 
> > # selftests: alsa: test-pcmtest-driver
> > # TAP version 13
> > # 1..5
> > # # Starting 5 tests from 1 test cases.
> > # #  RUN           pcmtest.playback ...
> > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > # # playback: Test failed
> > # #          FAIL  pcmtest.playback
> > # not ok 1 pcmtest.playback #  Can't read patterns. Probably, module isn't loaded
> > # #  RUN           pcmtest.capture ...
> > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > # # capture: Test failed
> > # #          FAIL  pcmtest.capture
> > # not ok 2 pcmtest.capture #  Can't read patterns. Probably, module isn't loaded
> > # #  RUN           pcmtest.ni_capture ...
> > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > # # ni_capture: Test failed
> > # #          FAIL  pcmtest.ni_capture
> > # not ok 3 pcmtest.ni_capture #  Can't read patterns. Probably, module isn't loaded
> > # #  RUN           pcmtest.ni_playback ...
> > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > # # ni_playback: Test failed
> > # #          FAIL  pcmtest.ni_playback
> > # not ok 4 pcmtest.ni_playback #  Can't read patterns. Probably, module isn't loaded
> > # #  RUN           pcmtest.reset_ioctl ...
> > # #      SKIP      Can't read patterns. Probably, module isn't loaded
> > # # reset_ioctl: Test failed
> > # #          FAIL  pcmtest.reset_ioctl
> > # not ok 5 pcmtest.reset_ioctl #  Can't read patterns. Probably, module isn't loaded
> > # # FAILED: 0 / 5 tests passed.
> > # # Totals: pass:0 fail:5 xfail:0 xpass:0 skip:0 error:0
> > 
> > I haven't completely isolated the issue due to some other breakage
> > that's making it harder that it should be to test.  
> > 
> > A sample full log can be seen at:
> > 
> >    https://lava.sirena.org.uk/scheduler/job/659576#L1349
> 
> Thanks! the exit() inside the skip evaded my grep, I'm testing this:
> 
> diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> index a52ecd43dbe3..7ab81d6f9e05 100644
> --- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
> +++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
> @@ -127,11 +127,11 @@ FIXTURE_SETUP(pcmtest) {
>  	int err;
>  
>  	if (geteuid())
> -		SKIP(exit(-1), "This test needs root to run!");
> +		SKIP(exit(KSFT_SKIP), "This test needs root to run!");
>  
>  	err = read_patterns();
>  	if (err)
> -		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
> +		SKIP(exit(KSFT_SKIP), "Can't read patterns. Probably, module isn't loaded");
>  
>  	card_name = malloc(127);
>  	ASSERT_NE(card_name, NULL);
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index 20294553a5dd..356ba5f3b68c 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -138,7 +138,7 @@ FIXTURE_SETUP(hmm)
>  
>  	self->fd = hmm_open(variant->device_number);
>  	if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
> -		SKIP(exit(0), "DEVICE_COHERENT not available");
> +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
>  	ASSERT_GE(self->fd, 0);
>  }
>  
> @@ -149,7 +149,7 @@ FIXTURE_SETUP(hmm2)
>  
>  	self->fd0 = hmm_open(variant->device_number0);
>  	if (self->fd0 < 0 && hmm_is_coherent_type(variant->device_number0))
> -		SKIP(exit(0), "DEVICE_COHERENT not available");
> +		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
>  	ASSERT_GE(self->fd0, 0);
>  	self->fd1 = hmm_open(variant->device_number1);
>  	ASSERT_GE(self->fd1, 0);
> 
> > but there's no more context.  I'm also seeing some breakage in the
> > seccomp selftests which also use kselftest-harness:
> > 
> > # #  RUN           TRAP.dfl ...
> > # # dfl: Test exited normally instead of by signal (code: 0)
> > # #          FAIL  TRAP.dfl
> > # not ok 56 TRAP.dfl
> > # #  RUN           TRAP.ign ...
> > # # ign: Test exited normally instead of by signal (code: 0)
> > # #          FAIL  TRAP.ign
> > # not ok 57 TRAP.ign
> 
> Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
> child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.

Oh no, that does seem bad. Since Mickaël is also seeing weird issues,
can we drop the vfork changes for now?

-- 
Kees Cook

