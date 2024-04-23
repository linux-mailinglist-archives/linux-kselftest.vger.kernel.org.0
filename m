Return-Path: <linux-kselftest+bounces-8718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A69B8AF520
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8941F22D03
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5F13E88D;
	Tue, 23 Apr 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Y55Q53ct"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1A13C9C9
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892088; cv=none; b=uIGh1PhxHzymC2k2uHjeDX4/ptd7IShR+VElscqp0NDUz1G0Q2FtLdIVrt4XdBszaQ6BKPRUpQA3PNF0Z+V9b6SX562WWqIlQQ7kj+zyJCzzdLd6uLvsV4ImVBTT22BkTgT7TZRY+dftmuPAOhsg/sbUxhDW78AXyf/7+X2wiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892088; c=relaxed/simple;
	bh=pX9dtei+83WbcGhlmmrQLgeyG4KgE/xvvg03BZojpDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnI1dCiBD9E4nLeAuzXinPjyoJmduKWwZynvzcmsYmhAoehakPv76qjfcK2K+n4tFuAcu7GfvoPI2rUT5mPa0LtSQU9wUbmRc2r5iUJfYNv4ybys7ZOkRDl+W7PPTqvO0T9QIJkL9a1xKQqkyoNJs4nZU1IRPvrtHkYVGqTMXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Y55Q53ct; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VP7px1nckzDp6;
	Tue, 23 Apr 2024 19:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1713892073;
	bh=pX9dtei+83WbcGhlmmrQLgeyG4KgE/xvvg03BZojpDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y55Q53ctaPBwqA8H+m73mMZRMQhB9lv+Y2m7TjW2ZTUmaRh1V4d0vOAWcjxTYfIzE
	 n9qRXiOoVFBjcOXbRJADvB9/yfUDFwY6VKLy/ZzWxjSdQuTpY6aBlMIzl2TixdgWeI
	 ezsQWELEBwtylr0DRzRQ5lcTRlKLgy95AmbXRtkY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VP7pw4MDlzHlg;
	Tue, 23 Apr 2024 19:07:52 +0200 (CEST)
Date: Tue, 23 Apr 2024 19:07:51 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: test: Move fault tests behind KUNIT_FAULT_TEST
 Kconfig option
Message-ID: <20240423.shuwee5Baesh@digikod.net>
References: <20240423090808.242389-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423090808.242389-1-davidgow@google.com>
X-Infomaniak-Routing: alpha

On Tue, Apr 23, 2024 at 05:08:06PM +0800, David Gow wrote:
> The NULL dereference tests in kunit_fault deliberately trigger a kernel
> BUG(), and therefore print the associated stack trace, even when the
> test passes. This is both annoying (as it bloats the test output), and
> can confuse some test harnesses, which assume any BUG() is a failure.
> 
> Allow these tests to be specifically disabled (without disabling all
> of KUnit's other tests), by placing them behind the
> CONFIG_KUNIT_FAULT_TEST Kconfig option. This is enabled by default, but
> can be set to 'n' to disable the test. An empty 'kunit_fault' suite is
> left behind, which will automatically be marked 'skipped'.
> 
> As the fault tests already were disabled under UML (as they weren't
> compatible with its fault handling), we can simply adapt those
> conditions, and add a dependency on !UML for our new option.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net/
> Fixes: 82b0beff3497 ("kunit: Add tests for fault")
> Signed-off-by: David Gow <davidgow@google.com>

Good idea!

Reviewed-by: Mickaël Salaün <mic@digikod.net>

> ---
>  lib/kunit/Kconfig      | 11 +++++++++++
>  lib/kunit/kunit-test.c |  8 ++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 68a6daec0aef..34d7242d526d 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -24,6 +24,17 @@ config KUNIT_DEBUGFS
>  	  test suite, which allow users to see results of the last test suite
>  	  run that occurred.
>  
> +config KUNIT_FAULT_TEST
> +	bool "Enable KUnit tests which print BUG stacktraces"
> +	depends on KUNIT_TEST
> +	depends on !UML
> +	default y
> +	help
> +	  Enables fault handling tests for the KUnit framework. These tests may
> +	  trigger a kernel BUG(), and the associated stack trace, even when they
> +	  pass. If this conflicts with your test infrastrcture (or is confusing
> +	  or annoying), they can be disabled by setting this to N.
> +
>  config KUNIT_TEST
>  	tristate "KUnit test for KUnit" if !KUNIT_ALL_TESTS
>  	default KUNIT_ALL_TESTS
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 0fdca5fffaec..e3412e0ca399 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -109,7 +109,7 @@ static struct kunit_suite kunit_try_catch_test_suite = {
>  	.test_cases = kunit_try_catch_test_cases,
>  };
>  
> -#ifndef CONFIG_UML
> +#if IS_ENABLED(CONFIG_KUNIT_FAULT_TEST)
>  
>  static void kunit_test_null_dereference(void *data)
>  {
> @@ -136,12 +136,12 @@ static void kunit_test_fault_null_dereference(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, ctx->function_called);
>  }
>  
> -#endif /* !CONFIG_UML */
> +#endif /* CONFIG_KUNIT_FAULT_TEST */
>  
>  static struct kunit_case kunit_fault_test_cases[] = {
> -#ifndef CONFIG_UML
> +#if IS_ENABLED(CONFIG_KUNIT_FAULT_TEST)
>  	KUNIT_CASE(kunit_test_fault_null_dereference),
> -#endif /* !CONFIG_UML */
> +#endif /* CONFIG_KUNIT_FAULT_TEST */
>  	{}
>  };
>  
> -- 
> 2.44.0.769.g3c40516874-goog
> 

