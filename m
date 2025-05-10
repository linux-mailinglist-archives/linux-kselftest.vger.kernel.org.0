Return-Path: <linux-kselftest+bounces-32811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F87AB2191
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 08:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692304E37EF
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D11E32DB;
	Sat, 10 May 2025 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dAmddKkl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4E178CC8;
	Sat, 10 May 2025 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746860082; cv=none; b=ktg0gb5CKStbqYxaZrAnoMhi2g8KOzvjBiKbY9WQIE8BT4oGzX8JL/6xDYuAkRMWniJ+nt+sSkw+zzlW+vaMNrdhI1uk3YAExT7lCtcdecvtyJemhJKnS5ojEtDtZ+VfbPZnRlE+ZtWkh1JH/dXxwyM3k/soDAqIyvn4TTCwWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746860082; c=relaxed/simple;
	bh=mdnOUrBAK4hSGCJ/wGMi1H1M6KiEQEjDBPc6zkE+Olc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLfJr2ioY0T9DyMzoy6Ml7vyNt2KNDDBtLxO+oN/QmpkIGHi4RyXTMKyAs62HdqV9MXjrGgN/eiwAMXMazrQzArR2zUqi7x5dTKdt7zXgQIoudRUeWUAkpopna13D7m/tHD/NgRLvSajtNrIoz9lQBi4GJGZim3ByOOFRbqRrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dAmddKkl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1746860065;
	bh=mdnOUrBAK4hSGCJ/wGMi1H1M6KiEQEjDBPc6zkE+Olc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAmddKklFUQDIjKEg3mw0lS4BtYt0yQAx9GPLwf5dQwSj/v3UONoD8jSzszAvvRVA
	 ZERMZnqbsJQiltplbeV4A3LzuEIWJAVbuQhPx2k92+ugMGpTOUIcytnwk2LmXfErHu
	 Rt8J6K5obLJ+5vI8a3OnR1rjYQge471hZy6Rpeqo=
Date: Sat, 10 May 2025 08:54:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/14] kselftest harness and nolibc compatibility
Message-ID: <d8d36e51-9456-49a3-88c4-44cffdcc5c0a@t-8ch.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>

Hi Shuah and Kees,

On 2025-05-05 17:15:18+0200, Thomas Weißschuh wrote:
> Nolibc is useful for selftests as the test programs can be very small,
> and compiled with just a kernel crosscompiler, without userspace support.
> Currently nolibc is only usable with kselftest.h, not the more
> convenient to use kselftest_harness.h
> This series provides this compatibility by removing the usage of problematic
> libc features from the harness.

I'd like to get this series into the next merge window.
For that I'd like to expose it to linux-next through the nolibc tree.
If you don't have the time for a review or issues crop up, I will drop
the patches again.

Are you fine with that?

The issues reported by Mark have been fixed and tests have been written
for them.

> Based on nolibc/for-next.
> The series is meant to be merged through the nolibc tree.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v4:
> - Drop patches for nolibc which where already applied
> - Preserve signatures of test functions for tests making assumptions about them
>   drop 'selftests: harness: Always provide "self" and "variant"'
>   add 'selftests: harness: Add "variant" and "self" to test metadata'
>   adapt 'selftests: harness: Stop using setjmp()/longjmp()'
> - Validate test function signatures in harness selftest
> - Link to v3: https://lore.kernel.org/r/20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de
> 
> Changes in v3:
> - Send patches to correct kselftest harness maintainers
> - Move harness selftest to dedicated directory
> - Add harness selftest to MAINTAINERS
> - Integrate harness selftest cleanup with the selftest framework
> - Consistently use "kselftest harness" in commit messages
> - Properly propagate kselftest harness failure
> - Link to v2: https://lore.kernel.org/r/20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de
> 
> Changes in v2:
> - Rebase unto v6.15-rc1
> - Rename internal nolibc symbols
> - Handle edge case of waitpid(INT_MIN) == ESRCH
> - Fix arm configurations for final testing patch
> - Clean up global getopt.h variable declarations
> - Add Acks from Willy
> - Link to v1: https://lore.kernel.org/r/20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de
> 
> ---
> Thomas Weißschuh (14):
>       selftests: harness: Add kselftest harness selftest
>       selftests: harness: Use C89 comment style
>       selftests: harness: Ignore unused variant argument warning
>       selftests: harness: Mark functions without prototypes static
>       selftests: harness: Remove inline qualifier for wrappers
>       selftests: harness: Remove dependency on libatomic
>       selftests: harness: Implement test timeouts through pidfd
>       selftests: harness: Don't set setup_completed for fixtureless tests
>       selftests: harness: Move teardown conditional into test metadata
>       selftests: harness: Add teardown callback to test metadata
>       selftests: harness: Add "variant" and "self" to test metadata
>       selftests: harness: Stop using setjmp()/longjmp()
>       selftests: harness: Guard includes on nolibc
>       HACK: selftests/nolibc: demonstrate usage of the kselftest harness
> 
>  MAINTAINERS                                        |    1 +
>  tools/testing/selftests/Makefile                   |    1 +
>  tools/testing/selftests/kselftest_harness.h        |  175 +-
>  .../testing/selftests/kselftest_harness/.gitignore |    2 +
>  tools/testing/selftests/kselftest_harness/Makefile |    7 +
>  .../selftests/kselftest_harness/harness-selftest.c |  138 ++
>  .../kselftest_harness/harness-selftest.expected    |   64 +
>  .../kselftest_harness/harness-selftest.sh          |   13 +
>  tools/testing/selftests/nolibc/Makefile            |   15 +-
>  tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
>  tools/testing/selftests/nolibc/nolibc-test.c       | 1715 +-------------------
>  tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
>  12 files changed, 313 insertions(+), 1821 deletions(-)
> ---
> base-commit: 2051d3b830c0889ae55e37e9e8ff0d43a4acd482
> change-id: 20250130-nolibc-kselftest-harness-8b2c8cac43bf
> 
> Best regards,
> -- 
> Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 

