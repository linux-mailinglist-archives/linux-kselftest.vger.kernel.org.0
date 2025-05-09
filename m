Return-Path: <linux-kselftest+bounces-32757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4DBAB1907
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62021661CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466F22FAF4;
	Fri,  9 May 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NJj+R9mY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTNlQEpS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA92144D5;
	Fri,  9 May 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805269; cv=none; b=BJU0NKEXDIPafWcuFoYMctWZyxHE9um6M5HQ8gtiwfS+nIIwIQN7fraBIQzDZSQRlJFdOyfHuDPQAromwUWSSle4kxcnvAiSUeEeuEPIw5aDzmGABxPkGiA6jcpHoJHiUVtg+FL3W+OOhR0/zUhgobmSUjm5zBkY7ymmz66kJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805269; c=relaxed/simple;
	bh=IsqvHrgc9gZJMan1urhoJgogqDUV5xkt3EJV5Z0xLUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPYv5AtJtIEUrJtkMdMxyqoPCyjdseoSJfCqzmHhbkMjAFcq8zSWzGnqWIoVlt9gxxHpAJS0Z70ppiukZ62kZi7VuD5RVsmArHN+AsIwQSFuRwIxEBD9qmXSYSpiMWI4VMzndIekX9dYDyJDZ+LKX433fvS10deXi9+AZ9W1/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NJj+R9mY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTNlQEpS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 9 May 2025 17:41:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746805266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1APoggo0DpAnUbpHZz6B/xHsBGNf33UiQ2Va0joSECI=;
	b=NJj+R9mYKiTZ0UJWjSaKhR1oeNH13wDjDc1UgFukrp2Ci8nNv1TWytgcJ/FPGjJbz6ctVg
	LFsNlfLjgrTrEc6hE+aMPuP4VF5Dm4zR7ZY8MEEFyfl0z01RtbMlOFpED8kxdisGOt8ayd
	aWxeJUx3Nnfr/QfGBpR1ibM3y4fx8qB8qjEJG2uagBf0LuniaBgRrqXt08GjLdG/1BOFxf
	iaK9nJmztMp6xWnEmwPk3xZgZshvzQFp1noUTbN8mSMWTYLBN3k9vIf8C1kFQA4R8U4mYR
	p06EeHopJIPoCFgPByX5PSQ2GTEvObECZyA9N1MWcyhVq5fHyrooGibaz+bifQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746805266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1APoggo0DpAnUbpHZz6B/xHsBGNf33UiQ2Va0joSECI=;
	b=QTNlQEpSodmDBGbke82MBZDNVejpgVG3T08YrMa2HFd4OOpfSHtjjKn618GZP+rxDu9r3G
	OwiTZGsRjzqtRRBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, "Bird, Timothy" <Tim.Bird@sony.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 1/3] selftests/timens: Print TAP headers
Message-ID: <20250509172639-61bade20-67f9-4815-8316-1bb16749f8d9@linutronix.de>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
 <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
 <5609c6de-e5cf-4f6d-8412-71149fae2580@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5609c6de-e5cf-4f6d-8412-71149fae2580@linuxfoundation.org>

+Cc Kees

On Wed, May 07, 2025 at 03:06:16PM -0600, Shuah Khan wrote:
> On 5/2/25 06:03, Thomas Weißschuh wrote:
> > The TAP specification requires that the output begins with a header line.
> > These headers lines are missing in the timens tests.
> > 
> > Print such a line.
> 
> There is no cover letter for this - so I will respond to the first
> patch.

Hm, I sent one and can also see it on lore.

> The TAP information is added by the kselftest wrapper if
> you were to run the test using ksefltest.
> 
> The following will add the TAP header or if you use make kselftest
> command from the main Makefile.
> 
> make -C timens run_tests
> 
> cd timens; make run_tests (will also add TAP header)
> 
> The only time you won't see the TAP headers is when you run the test
> from the test directory just as a command. Is this what you need
> to do? I would rather not see TAP headers added to invidual tests
> unless there is a good reason for it.

Yes, I am running each test on its own, as part of kunit based on [0].
I also looked at the vDSO selftests and those all print the TAP headers on
their own. The same for all of the x86 selftests I looked at.

> The problem with adding TAP headers is two-fold:
> 
> 1. It becomes hard to read the ouptput if test is run using
>    the framework a. make -C timens run_tests b. cd timens; make run_tests

Isn't this what "KSFT_TAP_LEVEL" was added for in
commit 10f531f67482 ("selftests: kselftest framework: add handling for TAP header level") ?

> 2. These headers become bested and TAP doesn't like nested TAP headers.
>    My undestansing is parses will have problems.

They are also prefixed with a "#", so they should be ignored by parsers.

> I am adding Tim Bird to the discussion.
> 
> Tim, is this still an issue? Are nested TAP headers still a problem.
> 
> Even if they aren't there is the issue of multiple TAP headers for
> each test when we run the test using framework.

The suppression was actually there at some point and got removed by Kees in
commit f41c322f17ec ("selftests: Remove KSFT_TAP_LEVEL").

[0] https://lore.kernel.org/all/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de/

