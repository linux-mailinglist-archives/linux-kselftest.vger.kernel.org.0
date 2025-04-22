Return-Path: <linux-kselftest+bounces-31281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF631A96356
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 11:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28E64412D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D520258CF5;
	Tue, 22 Apr 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+PFCv6/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTgYbPj+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB493259C9F;
	Tue, 22 Apr 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311715; cv=none; b=sospWo1DEIepYiS/jnuh675Ln9tFhy3CtkysP3x0NQXAEDI7N0D2qiqG4X3iL87KlxrH+6aFwG8Qeoypl5h7VyfdRe40Gj6H1N6kMwPDolXuebSczD1RBpuk+a+3jFRl9nczXN0ZhYF4nzAji7LrfwGZ65zNTxHot8GQLURuQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311715; c=relaxed/simple;
	bh=L48CHmVyL1oJeYQ5mamzDlg3xG71JJZtLzFPgXsNhpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqt+Y088FYwAPhbaTsr3hqTSkCQpUBLJwhFJMjoGY2QExawHYs2lQQZ7NxFuy4eq21TzCLzs2MO7HJwLVLuNDfsWauEQjT43FJcgkGVklHSM449Kcl+gfBobZj3Z/BdKRV7qquWyF3C39w15Dv+XP2g6TREdsGbtQ80hMgHnY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+PFCv6/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTgYbPj+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 10:48:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745311709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo37DsUl5gsDwjhOEAH737O813yf3Txn66/HRcaSJ+4=;
	b=Z+PFCv6/d29PbuWF+2+lJr+cbhh37OrmFIxmbeYRvE646glDG3CWi1jGDxFIGzhgR6ERlZ
	AP2Ofconhdf0NK+klLLHZVgOUw1uU/VpzqSlV8iqS/7LMT+J4T57Ghu5T8tVDfhCMvHX/Y
	1gbYSyHE+sb80lhTs23262pZlloNBd61T/a7VedSVUi9JULccS9Tgr60DCdOswa/UiKBQx
	ct+1/Ya+GpKQZESOS9cwif94gKOR1tV6fzcHODup1RZIJk6qKL86FP+4ke5NwIt+ozWkls
	o3elEdSjpsp5fXNcsn/0TJP3xj7JUKJO7fb6jFtZ7UcG5YNZEefnz8ZtTX+BOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745311709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo37DsUl5gsDwjhOEAH737O813yf3Txn66/HRcaSJ+4=;
	b=sTgYbPj+N+ljOsS5MRdIemAS4U7f845p5BuWHu4qwAgLnoJP3tOFU4KPwRWO73mZJ0hvvG
	U17tI7aA4ktZrNDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 00/32] kselftest harness and nolibc compatibility
Message-ID: <20250422103612-64ea71dd-d51d-487e-b387-508c372af07c@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>

Hi,

On Fri, Apr 11, 2025 at 11:00:24AM +0200, Thomas Weiﬂschuh wrote:
> Nolibc is useful for selftests as the test programs can be very small,
> and compiled with just a kernel crosscompiler, without userspace support.
> Currently nolibc is only usable with kselftest.h, not the more
> convenient to use kselftest_harness.h
> This series provides this compatibility by adding new features to nolibc
> and removing the usage of problematic features from the harness.
> 
> The first half of the series are changes to the harness, the second one
> are for nolibc. Both parts are very independent and should go through
> different trees.

I need a few nolibc bits of this series (snprintf() and prep patches) to base
further patches on. For that I'd like to pick up all the nolibc patches from
this series through the nolibc tree. They got Acks from Willy.

Any objections?


Thomas

> The last patch is not meant to be applied and serves as test that
> everything works together correctly.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
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
> Thomas Weiﬂschuh (32):
>       selftests: harness: Add kselftest harness selftest
>       selftests: harness: Use C89 comment style
>       selftests: harness: Ignore unused variant argument warning
>       selftests: harness: Mark functions without prototypes static
>       selftests: harness: Remove inline qualifier for wrappers
>       selftests: harness: Remove dependency on libatomic
>       selftests: harness: Implement test timeouts through pidfd
>       selftests: harness: Don't set setup_completed for fixtureless tests
>       selftests: harness: Always provide "self" and "variant"
>       selftests: harness: Move teardown conditional into test metadata
>       selftests: harness: Add teardown callback to test metadata
>       selftests: harness: Stop using setjmp()/longjmp()
>       selftests: harness: Guard includes on nolibc
>       tools/nolibc: handle intmax_t/uintmax_t in printf
>       tools/nolibc: use intmax definitions from compiler
>       tools/nolibc: use pselect6_time64 if available
>       tools/nolibc: use ppoll_time64 if available
>       tools/nolibc: add tolower() and toupper()
>       tools/nolibc: add _exit()
>       tools/nolibc: add setpgrp()
>       tools/nolibc: implement waitpid() in terms of waitid()
>       Revert "selftests/nolibc: use waitid() over waitpid()"
>       tools/nolibc: add dprintf() and vdprintf()
>       tools/nolibc: add getopt()
>       tools/nolibc: allow different write callbacks in printf
>       tools/nolibc: allow limiting of printf destination size
>       tools/nolibc: add snprintf() and friends
>       selftests/nolibc: use snprintf() for printf tests
>       selftests/nolibc: rename vfprintf test suite
>       selftests/nolibc: add test for snprintf() truncation
>       tools/nolibc: implement width padding in printf()
>       HACK: selftests/nolibc: demonstrate usage of the kselftest harness
> 
>  MAINTAINERS                                        |    1 +
>  tools/include/nolibc/Makefile                      |    1 +
>  tools/include/nolibc/getopt.h                      |  101 ++
>  tools/include/nolibc/nolibc.h                      |    1 +
>  tools/include/nolibc/stdint.h                      |    4 +-
>  tools/include/nolibc/stdio.h                       |  127 +-
>  tools/include/nolibc/string.h                      |   17 +
>  tools/include/nolibc/sys.h                         |  105 +-
>  tools/testing/selftests/Makefile                   |    1 +
>  tools/testing/selftests/kselftest_harness.h        |  181 +-
>  .../testing/selftests/kselftest_harness/.gitignore |    2 +
>  tools/testing/selftests/kselftest_harness/Makefile |    7 +
>  .../selftests/kselftest_harness/harness-selftest.c |  129 ++
>  .../kselftest_harness/harness-selftest.expected    |   62 +
>  .../kselftest_harness/harness-selftest.sh          |   13 +
>  tools/testing/selftests/nolibc/Makefile            |   13 +-
>  tools/testing/selftests/nolibc/harness-selftest.c  |    1 +
>  tools/testing/selftests/nolibc/nolibc-test.c       | 1729 +-------------------
>  tools/testing/selftests/nolibc/run-tests.sh        |    2 +-
>  19 files changed, 637 insertions(+), 1860 deletions(-)
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250130-nolibc-kselftest-harness-8b2c8cac43bf
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 

