Return-Path: <linux-kselftest+bounces-32344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18A1AA9512
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE11791C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C9125A2BF;
	Mon,  5 May 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xux8umCH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HtB6vEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB9191F95;
	Mon,  5 May 2025 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454077; cv=none; b=MLkwpu935LsjnOcI7DtvGxm5oOot3ACo4Wn1hmsvUaG8BQlQJUMKl4ab16ChZpd5OTkNvPBhfRHgf156ZF7pEqjUmJenBP0HfSjBZxCKhfsCLdIrr648jnNux1uh0Q0vVbhSIsC1Qwu3qrV2YL7wt/orcNBsTuMeLx+CxA/P09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454077; c=relaxed/simple;
	bh=dBHOdSlk8wyfl9FGEHxh3KIZk4ZO6ZyyP8CPkgF7dZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwN7y5DPO0mzYDIs/XRNbWDK9ktxHib9lhFN4kmWjypbcMZH60886+k0uDnZBMlif2ek2352ExNZn2gXq4xqTL2ABtiOp3UR95RnyyNgmJ4cNGcjwUkcI6C2pmlWaNSd5L82gJikzarVxxfJpKhPK4EPjeCmpySJ8LhIRQkEnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xux8umCH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HtB6vEo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 May 2025 16:07:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746454073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfCgR2i3xQWyZtj2OVFWv7zFTAvlYA/MlxgvIP/UMus=;
	b=xux8umCHuhw89QYs9Q9K9AvrO5pOJmnb5+Rl/q95FoWrrZkqRKCJsawTKTEp9hlOkPGm0T
	FbzKYTXLE8EQ/CNsLyGeUM3Mww/bTTPP7zOCOtZ/iOw8SseNu6ahg/3BqExFQod8kIeMVD
	WmmIgKPcbLHkK6eO+lqzCi2Tj+Zvk9haX6d5aj5lJOvpBfTICIlbrOcOui8dbUpNBYLPMH
	72UostovynQTtUygJ7Kx+v3CVNZmIFKk8s+gzYL5xuSYbUKopwgglZwj7Ol54WHwaxfmjc
	vXhaQCbHTH84BWXcsVrBcKdvgIMNscf4qIXybdaWHYab8TeDhLURa0hmOzaVbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746454073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sfCgR2i3xQWyZtj2OVFWv7zFTAvlYA/MlxgvIP/UMus=;
	b=0HtB6vEozKdHOywIgQO0tH7RpGKDvQNEs0cKKeuxOpOuoajNSXH6g63vDko5loRTal4XaN
	E2OSCLL0zYwjz8BA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v3 12/32] selftests: harness: Stop using
 setjmp()/longjmp()
Message-ID: <20250505160703-431086d8-76bd-4195-b2f6-06141e1cb6de@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250411-nolibc-kselftest-harness-v3-12-4d9c0295893f@linutronix.de>
 <aBiX9zbR7ehAxQjS@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBiX9zbR7ehAxQjS@finisterre.sirena.org.uk>

Hi Mark,

On Mon, May 05, 2025 at 07:50:31PM +0900, Mark Brown wrote:
> On Fri, Apr 11, 2025 at 11:00:36AM +0200, Thomas Weißschuh wrote:
> > Usage of longjmp() was added to ensure that teardown is always run in
> > commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN for ASSERT failures")
> > However instead of calling longjmp() to the teardown handler it is easier to
> > just call the teardown handler directly from __bail().
> > Any potential duplicate teardown invocations are harmless as the actual
> > handler will only ever be executed once since
> > commit fff37bd32c76 ("selftests/harness: Fix fixture teardown").
> 
> I didn't fully verify (I'm on holiday right now) but it looks like this,
> which is in -next as 8a37733a874f:
> 
> > @@ -757,7 +749,7 @@
> >   */
> >  #define OPTIONAL_HANDLER(_assert) \
> >  	for (; _metadata->trigger; _metadata->trigger = \
> > -			__bail(_assert, _metadata))
> > +			__bail(_assert, _metadata, self, variant))
> >  
> >  #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> >  
> 
> breaks the build of several selftests when building for arm64:

Thanks for the report. These tests are doing funny things with the harness
internals. I'll drop these patches from -next.

> In file included from seccomp_bpf.c:56:
> seccomp_bpf.c: In function ‘kill_thread_or_group’:
> ../kselftest_harness.h:755:52: error: ‘self’ undeclared (first use in this function)
>   755 |                         __bail(_assert, _metadata, self, variant))
>       |                                                    ^~~~
> ../kselftest_harness.h:803:14: note: in expansion of macro ‘OPTIONAL_HANDLER’
>   803 | } while (0); OPTIONAL_HANDLER(_assert)
>       |              ^~~~~~~~~~~~~~~~
> ../kselftest_harness.h:516:9: note: in expansion of macro ‘__EXPECT’
>   516 |         __EXPECT(expected, #expected, seen, #seen, ==, 1)
>       |         ^~~~~~~~
> seccomp_bpf.c:844:9: note: in expansion of macro ‘ASSERT_EQ’
>   844 |         ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>       |         ^~~~~~~~~
> 
> Full build log at:
> 
>     https://builds.sirena.org.uk/407f60a151df3c44397e5afc0111eb9b026c38d3/arm64/defconfig/build.log



