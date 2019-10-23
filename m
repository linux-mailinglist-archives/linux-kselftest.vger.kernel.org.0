Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C015E260D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 00:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405764AbfJWWCz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 18:02:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35967 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405676AbfJWWCz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 18:02:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so10766023plk.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2019 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1thfPODjnoKymh0RHqmcX+0PR8e0dlYfkmxouB7h5+4=;
        b=EBIXqB0eDakGs+f2oqaOdh0DVPTJntdeDdTuy7Qyze61blnzpx/S0EuI6IQg9zNqU/
         mo5XmnPuP2T/I+ytUYgMpYp9tv+5PKWWZC+KUAV//Fi19hVvaK/rWwS58ctEEkf1hD3y
         TWhvnCWq/AzuaYt9bN/Rmgr9kxJo0kSOMt3mIPa9F57dcNFaiVDvPWDpwRttQwEvDUsZ
         1sq04F7uOPn7s1UvC2/wtb4aPUuHnE1b3iMetMbm5GeekeCt0IOLqTwftPD03AkmbxE2
         BM8fH0g5Yb3A3AGNn8ZtXaLORy6sf3e9yReq4EuyMu8P+SVhIdph7pr4nJZ/34FnFmB7
         t1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1thfPODjnoKymh0RHqmcX+0PR8e0dlYfkmxouB7h5+4=;
        b=RQE6UjQ2Ueg92kir5s14aZ8dWkgAHA6Je6Z27aUsXcWgTXJi5cBRvJPXrosfcmXMNe
         NZSNx8icOQS2McQcffY3va7BStOAdcUegEj1mtpsxOZzU3YhS/+n7iDdlXVJXJI53b2h
         hLtfk8K6bZU1Xhh9c9XSryI8LQBpN7CeiZIBNRvQ95vHQ6FX1VAOAQbqTeOmvegibLGs
         K70vmgkL6fiWcL/gRMNtyJehYhwcXEs5GOSFxSPhLp4hiZonaOWdPItT+OzhIx+dclZU
         hsBuk+noq3SBOdCufzmi0Ae/bDdkD9PuiRBNr8H6qMF1P4eVkKM+x2nauXsbWWINvdyh
         0O3A==
X-Gm-Message-State: APjAAAVZmHWNujxUJ/ORcYGclIztTfihWROOKzbbd+2RXVwb7NPpQi2l
        bZHkLiXgAQaYnQL7mYEjkC2Bow==
X-Google-Smtp-Source: APXvYqyy14/T26jgC0nr0nn9U8HgSJ/w8mZFfiA4lnyO9LtHupuU21wg9L7JhPjg5S3O/lZEIQ/wCA==
X-Received: by 2002:a17:902:8b81:: with SMTP id ay1mr868026plb.79.1571868174092;
        Wed, 23 Oct 2019 15:02:54 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id a6sm5789436pfn.99.2019.10.23.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 15:02:53 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:02:48 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH linux-kselftest/test v5] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191023220248.GA55483@google.com>
References: <20191022221322.122788-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022221322.122788-1-davidgow@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 22, 2019 at 03:13:22PM -0700, 'David Gow' via KUnit Development wrote:
> Add a KUnit test for the kernel doubly linked list implementation in
> include/linux/list.h
> 
> Each test case (list_test_x) is focused on testing the behaviour of the
> list function/macro 'x'. None of the tests pass invalid lists to these
> macros, and so should behave identically with DEBUG_LIST enabled and
> disabled.
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

I think I already had a "Reviewed-by and a Tested-by" on this patch.
Please make sure to apply the footers to subsequent versions of a patch
in the future.

> ---
> v5 replaces the use of KUNIT_ASSERT_NOT_ERR_OR_NULL() -- to check the
> return value from kzalloc() and kmalloc() -- with the __GFP_NOFAIL
> arugment. (Both in the list_test_list_init test.)
> 
> Earlier versions of the test can be found:
> v4: https://lore.kernel.org/linux-kselftest/20191018215549.65000-1-davidgow@google.com/
> v3: https://lore.kernel.org/linux-kselftest/20191016215707.95317-1-davidgow@google.com/
> v2: https://lore.kernel.org/linux-kselftest/20191010185631.26541-1-davidgow@google.com/
> v1: https://lore.kernel.org/linux-kselftest/20191007213633.92565-1-davidgow@google.com/
> 
> 
>  MAINTAINERS       |   5 +
>  lib/Kconfig.debug |  18 ++
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 738 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 764 insertions(+)
>  create mode 100644 lib/list-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ef985e01457..7ced1b69a3d3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9504,6 +9504,11 @@ F:	Documentation/misc-devices/lis3lv02d.rst
>  F:	drivers/misc/lis3lv02d/
>  F:	drivers/platform/x86/hp_accel.c
>  
> +LIST KUNIT TEST
> +M:	David Gow <davidgow@google.com>
> +S:	Maintained
> +F:	lib/list-test.c

Probably want to have a "mailing list" line. Something like:
"""
L:	linux-kselftest@vger.kernel.org
L:	kunit-dev@googlegroups.com
"""

> +
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5dadcd..7991b78eb1f3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1961,6 +1961,24 @@ config SYSCTL_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_KUNIT_TEST
> +	bool "KUnit Test for Kernel Linked-list structures"
> +	depends on KUNIT
> +	help
> +	  This builds the linked list KUnit test suite.
> +	  It tests that the API and basic functionality of the list_head type
> +	  and associated macros.
> +	

nit: unnecessary tab.

> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running the KUnit test harness, and not intended for inclusion into a
> +	  production build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
[...]
> diff --git a/lib/list-test.c b/lib/list-test.c
> new file mode 100644
> index 000000000000..a6d17647e309
> --- /dev/null
> +++ b/lib/list-test.c
[...]
> +static void list_test_list_entry(struct kunit *test)
> +{
> +	struct list_test_struct test_struct;
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list), struct list_test_struct, list));

nit: here and elsewhere: over 80 chars.

> +}
> +
> +static void list_test_list_first_entry(struct kunit *test)
> +{
> +	struct list_test_struct test_struct1, test_struct2;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&test_struct1.list, &list);
> +	list_add_tail(&test_struct2.list, &list);
> +
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list, struct list_test_struct, list));
> +}
[...]
> +static void list_test_list_for_each_entry(struct kunit *test)
> +{
> +	struct list_test_struct entries[5], *cur;
> +	static LIST_HEAD(list);
> +	int i = 0;
> +
> +	for (i = 0; i < 5; ++i) {
> +		entries[i].data = i;
> +		list_add_tail(&entries[i].list, &list);
> +	}
> +
> +	i = 0;
> +
> +	list_for_each_entry(cur, &list, list) {
> +		KUNIT_EXPECT_EQ(test, cur->data, i);
> +		i++;
> +	}
> +	

nit: another unnecessary tab. Looks like you should probably run checkpatch.

> +	KUNIT_EXPECT_EQ(test, i, 5);
> +}
> +
> +static void list_test_list_for_each_entry_reverse(struct kunit *test)
> +{
> +	struct list_test_struct entries[5], *cur;
> +	static LIST_HEAD(list);
> +	int i = 0;
> +
> +	for (i = 0; i < 5; ++i) {
> +		entries[i].data = i;
> +		list_add_tail(&entries[i].list, &list);
> +	}
> +
> +	i = 4;
> +
> +	list_for_each_entry_reverse(cur, &list, list) {
> +		KUNIT_EXPECT_EQ(test, cur->data, i);
> +		i--;
> +	}
> +	
> +	KUNIT_EXPECT_EQ(test, i, -1);
> +}
[...]

Cheers
