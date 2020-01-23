Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99419146BEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 15:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgAWOyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 09:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgAWOyA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 09:54:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E9021D7D;
        Thu, 23 Jan 2020 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579791239;
        bh=hilFPIhlFBQfbuasUEx0/b2WjqD/Zwvg+YvxXvtSuSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpIp55VYA5xhSBuwunXmJ+sbYZmkHf9BrDJ/TMWlneBJf7HPOfub97LyJC50JX8nT
         xtOnI0gZv7H4+5+MKx2UvVDXHYbhikjVBlpZERBsx6tDRhfhRJEMn6KWe321c/hx+6
         v+vO9EXtrAsBt/NDDdrOtvnIvF+BDDYKXaQ6RplU=
Date:   Thu, 23 Jan 2020 15:53:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kunit 1/3] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
Message-ID: <20200123145357.GA1687563@kroah.com>
References: <1579790840-27009-1-git-send-email-alan.maguire@oracle.com>
 <1579790840-27009-2-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579790840-27009-2-git-send-email-alan.maguire@oracle.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 23, 2020 at 02:47:18PM +0000, Alan Maguire wrote:
> add debugfs support for displaying kunit test suite results; this is
> especially useful for module-loaded tests to allow disentangling of
> test result display from other dmesg events.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/kunit/test.h |  21 +++++++---
>  lib/kunit/Makefile   |   3 +-
>  lib/kunit/debugfs.c  | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/kunit/debugfs.h  |  11 +++++
>  lib/kunit/test.c     |  88 ++++++++++++++++++++++++++++++----------
>  5 files changed, 206 insertions(+), 28 deletions(-)
>  create mode 100644 lib/kunit/debugfs.c
>  create mode 100644 lib/kunit/debugfs.h
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 2dfb550..37219b8a 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -125,6 +125,8 @@ struct kunit_case {
>  	bool success;
>  };
>  
> +#define	kunit_status2str(status)	(status ? "ok" : "not ok")
> +
>  /**
>   * KUNIT_CASE - A helper for creating a &struct kunit_case
>   *
> @@ -157,6 +159,9 @@ struct kunit_suite {
>  	int (*init)(struct kunit *test);
>  	void (*exit)(struct kunit *test);
>  	struct kunit_case *test_cases;
> +
> +	/* private - internal use only */
> +	struct dentry *debugfs;
>  };
>  
>  /**
> @@ -197,6 +202,15 @@ struct kunit {
>  
>  int kunit_run_tests(struct kunit_suite *suite);
>  
> +size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
> +
> +unsigned int kunit_test_case_num(struct kunit_suite *suite,
> +				 struct kunit_case *test_case);
> +
> +int __kunit_test_suites_init(struct kunit_suite **suites);
> +
> +void __kunit_test_suites_exit(struct kunit_suite **suites);
> +
>  /**
>   * kunit_test_suites() - used to register one or more &struct kunit_suite
>   *			 with KUnit.
> @@ -226,15 +240,12 @@ struct kunit {
>  	static struct kunit_suite *suites[] = { __VA_ARGS__, NULL};	\
>  	static int kunit_test_suites_init(void)				\
>  	{								\
> -		unsigned int i;						\
> -		for (i = 0; suites[i] != NULL; i++)			\
> -			kunit_run_tests(suites[i]);			\
> -		return 0;						\
> +		return __kunit_test_suites_init(suites);		\
>  	}								\
>  	late_initcall(kunit_test_suites_init);				\
>  	static void __exit kunit_test_suites_exit(void)			\
>  	{								\
> -		return;							\
> +		return __kunit_test_suites_exit(suites);		\
>  	}								\
>  	module_exit(kunit_test_suites_exit)
>  
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index fab5564..869aab0 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -3,7 +3,8 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
>  kunit-objs +=				test.o \
>  					string-stream.o \
>  					assert.o \
> -					try-catch.o
> +					try-catch.o \
> +					debugfs.o
>  
>  obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
>  
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> new file mode 100644
> index 0000000..5994f32
> --- /dev/null
> +++ b/lib/kunit/debugfs.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + *    Author: Alan Maguire <alan.maguire@oracle.com>
> + */
> +#include <asm/unistd.h>

Why do you need this asm include file?

> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/time.h>
> +
> +#include <uapi/linux/limits.h>
> +#include <kunit/test.h>
> +
> +#include "string-stream.h"
> +
> +#define KUNIT_DEBUGFS_ROOT             "kunit"
> +#define KUNIT_DEBUGFS_RESULTS          "results"
> +
> +/*
> + * Create a debugfs representation of test suites:
> + *
> + * Path						Semantics
> + * /sys/kernel/debug/kunit/<testsuite>/results	Show results of last run for
> + *						testsuite
> + *
> + */
> +
> +static struct dentry *debugfs_rootdir;
> +
> +void debugfs_cleanup(void)

Can you prefix all of your global symbols here with "kunit_debugfs"
instead of just "debugfs" to show that this really is not the core
debugfs kernel code?

thanks,

greg k-h
