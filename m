Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E84CF026
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 03:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfJHBDx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 21:03:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37006 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfJHBDw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 21:03:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so9760870pfo.4
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 18:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vZqNfdzXFLBolvsJwiaCHH/Ao7MkIlG7MJOIwY/rEk0=;
        b=apob+cwuo67D4AJAytzXv1z3MUQ5nG3xitNXa7RAZUS0crGsTYZdu/4n6FpPZgzLBF
         7zFE4Sm8bTb01Q3TQ8IaJNldHXHdTYYTqGJMRPWQ7o2p6UMSGNY6UPfw9JEwdPz8rBcD
         +dY65csGmWDkAzXW1KmHMeUAnibiOo7Zcij+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vZqNfdzXFLBolvsJwiaCHH/Ao7MkIlG7MJOIwY/rEk0=;
        b=d6FuvH22490HbmY0gym/An91bx1lnFVfx2l6ySXUU4SfFNcLQVUGU+V0AXJidn0YR7
         wH0oID4flx3csXYp4bp+FlMAg1wwJqkaab//Ji+Yk8piahmAwDYcEUh6VyI3FK1rnyvx
         F+mo3hp8FD1VwVrhWlJidhydVpV0Hk8zTV977IMybjKshiTEwk8UnBKVc105GqvG3Zt0
         V7z0c/xRsbPyGg+7YuC8d7GK9cCW0w95Y2iXc5fLpCSjzIPsQsZ0QbwmkyFL2LdC14JQ
         qfNXqL7byDBRgDlclHyB7WXceVXL1FsE3nBAE+l31lbCY0XWvWXcWqDJUN5HSEdf5taC
         /y1Q==
X-Gm-Message-State: APjAAAV8KqCj+9dCiE+jC/nSZORIJAX9Qodj5ioKjbx/LpNdKcfj4OQa
        mbkj12bQCjtWvl7IZ3+CCFYjI3P52rk=
X-Google-Smtp-Source: APXvYqwbowmQx8ZCaPRAasYaEYK2jqVkVnKafLzxeD0tjHl+bmtNfmLOz1qkUswAvcSxQ0Z6un8OKQ==
X-Received: by 2002:a62:e109:: with SMTP id q9mr35429138pfh.231.1570496630048;
        Mon, 07 Oct 2019 18:03:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm17475756pfp.67.2019.10.07.18.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 18:03:49 -0700 (PDT)
Date:   Mon, 7 Oct 2019 18:03:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendanhiggins@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <201910071752.5E9CAEB@keescook>
References: <20191007213633.92565-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007213633.92565-1-davidgow@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> This change adds a KUnit test for the kernel doubly linked list
> implementation in include/linux/list.h
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).
> 
> This change depends on KUnit, so should be merged via the 'test' branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  lib/Kconfig.debug |  12 +
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 726 insertions(+)
>  create mode 100644 lib/list-test.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a3017a5dadcd..60691c0aac3e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1961,6 +1961,18 @@ config SYSCTL_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config LIST_TEST
> +	bool "KUnit Test for Kernel Linked-list stuctures"
> +	depends on KUNIT
> +	help
> +	  This builds the linked list unit test, which runs on boot.
> +	  It tests that the API and basic functionality of the list_head type
> +	  and associated macros.
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> diff --git a/lib/Makefile b/lib/Makefile
> index bba1fd5485f7..309e174ee35d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) += objagg.o
> +
> +# KUnit tests
> +obj-$(CONFIG_LIST_TEST) += list-test.o
> diff --git a/lib/list-test.c b/lib/list-test.c
> new file mode 100644
> index 000000000000..f333e8b0d9fe
> --- /dev/null
> +++ b/lib/list-test.c
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <kunit/test.h>
> +
> +#include <linux/list.h>
> +
> +struct list_test_struct {
> +	int data;
> +	struct list_head list;
> +};
> +
> +static void list_init_test(struct kunit *test)
> +{
> +	/* Test the different ways of initialising a list. */
> +	struct list_head list1 = LIST_HEAD_INIT(list1);
> +	struct list_head list2;
> +	LIST_HEAD(list3);
> +
> +	INIT_LIST_HEAD(&list2);

Can you also add different storage locations and initial contents tests?
For example:

	struct list_head *list4;
	struct list_head *list5;

	list4 = kzalloc(sizeof(*list4));
	INIT_LIST_HEAD(list4);

	list5 = kmalloc(sizeof(*list5));
	memset(list4, 0xff, sizeof(*list5));
	INIT_LIST_HEAD(list5);


	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list4));
	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list5));

	kfree(list4);
	kfree(list5);

Then we know it's not an accident that INIT_LIST_HEAD() works when both
all-zeros and all-0xFF initial contents are there. :)

> +
> +	/* list_empty_careful() checks both next and prev. */
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list1));
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list3));
> +}
> +
> +static void list_add_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add(&a, &list);
> +	list_add(&b, &list);
> +
> +	/* should be [list] -> b -> a */
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
> +	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
> +	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
> +}
> +
> +static void list_add_tail_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* should be [list] -> a -> b */
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &a);
> +	KUNIT_EXPECT_PTR_EQ(test, a.prev, &list);
> +	KUNIT_EXPECT_PTR_EQ(test, a.next, &b);
> +}
> +
> +static void list_del_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* before: [list] -> a -> b */
> +	list_del(&a);
> +
> +	/* now: [list] -> b */
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
> +	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
> +}
> +
> +static void list_replace_test(struct kunit *test)
> +{
> +	struct list_head a_old, a_new, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a_old, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* before: [list] -> a_old -> b */
> +	list_replace(&a_old, &a_new);
> +
> +	/* now: [list] -> a_new -> b */
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
> +	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
> +}
> +
> +static void list_replace_init_test(struct kunit *test)
> +{
> +	struct list_head a_old, a_new, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a_old, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* before: [list] -> a_old -> b */
> +	list_replace_init(&a_old, &a_new);
> +
> +	/* now: [list] -> a_new -> b */
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &a_new);
> +	KUNIT_EXPECT_PTR_EQ(test, b.prev, &a_new);
> +
> +	/* check a_old is empty (initialized) */
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a_old));
> +}
> +
> +static void list_swap_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* before: [list] -> a -> b */
> +	list_swap(&a, &b);
> +
> +	/* after: [list] -> b -> a */
> +	KUNIT_EXPECT_PTR_EQ(test, &b, list.next);
> +	KUNIT_EXPECT_PTR_EQ(test, &a, list.prev);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &a, b.next);
> +	KUNIT_EXPECT_PTR_EQ(test, &list, b.prev);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &list, a.next);
> +	KUNIT_EXPECT_PTR_EQ(test, &b, a.prev);
> +}
> +
> +static void list_del_init_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* before: [list] -> a -> b */
> +	list_del_init(&a);
> +	/* after: [list] -> b, a initialised */
> +
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
> +	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
> +}
> +
> +static void list_move_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +
> +	list_add_tail(&a, &list1);
> +	list_add_tail(&b, &list2);
> +
> +	/* before: [list1] -> a, [list2] -> b */
> +	list_move(&a, &list2);
> +	/* after: [list1] empty, [list2] -> a -> b */
> +
> +	KUNIT_EXPECT_TRUE(test, list_empty(&list1));
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &a, list2.next);
> +	KUNIT_EXPECT_PTR_EQ(test, &b, a.next);
> +}
> +
> +static void list_move_tail_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +
> +	list_add_tail(&a, &list1);
> +	list_add_tail(&b, &list2);
> +
> +	/* before: [list1] -> a, [list2] -> b */
> +	list_move_tail(&a, &list2);
> +	/* after: [list1] empty, [list2] -> b -> a */
> +
> +	KUNIT_EXPECT_TRUE(test, list_empty(&list1));
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &b, list2.next);
> +	KUNIT_EXPECT_PTR_EQ(test, &a, b.next);
> +}
> +
> +static void list_bulk_move_tail_test(struct kunit *test)
> +{
> +	struct list_head a, b, c, d, x, y;
> +	struct list_head *list1_values[] = { &x, &b, &c, &y };
> +	struct list_head *list2_values[] = { &a, &d };
> +	struct list_head *ptr;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +	int i = 0;
> +
> +	list_add_tail(&x, &list1);
> +	list_add_tail(&y, &list1);
> +
> +	list_add_tail(&a, &list2);
> +	list_add_tail(&b, &list2);
> +	list_add_tail(&c, &list2);
> +	list_add_tail(&d, &list2);
> +
> +	/* before: [list1] -> x -> y, [list2] -> a -> b -> c -> d */
> +	list_bulk_move_tail(&y, &b, &c);
> +	/* after: [list1] -> x -> b -> c -> y, [list2] -> a -> d */
> +
> +	list_for_each(ptr, &list1) {
> +		KUNIT_EXPECT_PTR_EQ(test, ptr, list1_values[i]);
> +		i++;
> +	}
> +	KUNIT_EXPECT_EQ(test, i, 4);
> +	i = 0;
> +	list_for_each(ptr, &list2) {
> +		KUNIT_EXPECT_PTR_EQ(test, ptr, list2_values[i]);
> +		i++;
> +	}
> +	KUNIT_EXPECT_EQ(test, i, 2);
> +}
> +
> +static void list_is_first_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	KUNIT_EXPECT_TRUE(test, list_is_first(&a, &list));
> +	KUNIT_EXPECT_FALSE(test, list_is_first(&b, &list));
> +}
> +
> +static void list_is_last_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	KUNIT_EXPECT_FALSE(test, list_is_last(&a, &list));
> +	KUNIT_EXPECT_TRUE(test, list_is_last(&b, &list));
> +}
> +
> +static void list_empty_test(struct kunit *test)
> +{
> +	struct list_head a;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +
> +	list_add_tail(&a, &list1);
> +
> +	KUNIT_EXPECT_FALSE(test, list_empty(&list1));
> +	KUNIT_EXPECT_TRUE(test, list_empty(&list2));
> +}
> +
> +static void list_empty_careful_test(struct kunit *test)
> +{
> +	struct list_head a;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +
> +	list_add_tail(&a, &list1);
> +
> +	KUNIT_EXPECT_FALSE(test, list_empty_careful(&list1));
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
> +}
> +
> +static void list_rotate_left_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +
> +	/* before: [list] -> a -> b */
> +	list_rotate_left(&list);
> +	/* after: [list] -> b -> a */
> +
> +	KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
> +	KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
> +	KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
> +}
> +
> +static void list_rotate_to_front_test(struct kunit *test)
> +{
> +	struct list_head a, b, c, d;
> +	struct list_head *list_values[] = { &c, &d, &a, &b };
> +	struct list_head *ptr;
> +	LIST_HEAD(list);
> +	int i = 0;
> +
> +	list_add_tail(&a, &list);
> +	list_add_tail(&b, &list);
> +	list_add_tail(&c, &list);
> +	list_add_tail(&d, &list);
> +
> +	/* before: [list] -> a -> b -> c -> d */
> +	list_rotate_to_front(&c, &list);
> +	/* after: [list] -> c -> d -> a -> b */
> +
> +	list_for_each(ptr, &list) {
> +		KUNIT_EXPECT_PTR_EQ(test, ptr, list_values[i]);
> +		i++;
> +	}
> +	KUNIT_EXPECT_EQ(test, i, 4);
> +}
> +
> +static void list_is_singular_test(struct kunit *test)
> +{
> +	struct list_head a, b;
> +	LIST_HEAD(list);
> +
> +	/* [list] empty */
> +	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
> +
> +	list_add_tail(&a, &list);
> +
> +	/* [list] -> a */
> +	KUNIT_EXPECT_TRUE(test, list_is_singular(&list));
> +
> +	list_add_tail(&b, &list);
> +
> +	/* [list] -> a -> b */
> +	KUNIT_EXPECT_FALSE(test, list_is_singular(&list));
> +}
> +
> +static void list_cut_position_test(struct kunit *test)
> +{
> +	struct list_head entries[3], *cur;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +	int i = 0;
> +
> +	list_add_tail(&entries[0], &list1);
> +	list_add_tail(&entries[1], &list1);
> +	list_add_tail(&entries[2], &list1);
> +
> +	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
> +	list_cut_position(&list2, &list1, &entries[1]);
> +	/* after: [list2] -> entries[0] -> entries[1], [list1] -> entries[2] */
> +
> +	list_for_each(cur, &list2) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 2);
> +
> +	list_for_each(cur, &list1) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +}
> +
> +static void list_cut_before_test(struct kunit *test)
> +{
> +	struct list_head entries[3], *cur;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +	int i = 0;
> +
> +	list_add_tail(&entries[0], &list1);
> +	list_add_tail(&entries[1], &list1);
> +	list_add_tail(&entries[2], &list1);
> +
> +	/* before: [list1] -> entries[0] -> entries[1] -> entries[2] */
> +	list_cut_before(&list2, &list1, &entries[1]);
> +	/* after: [list2] -> entries[0], [list1] -> entries[1] -> entries[2] */
> +
> +	list_for_each(cur, &list2) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 1);
> +
> +	list_for_each(cur, &list1) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +}
> +
> +static void list_splice_test(struct kunit *test)
> +{
> +	struct list_head entries[5], *cur;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +	int i = 0;
> +
> +	list_add_tail(&entries[0], &list1);
> +	list_add_tail(&entries[1], &list1);
> +	list_add_tail(&entries[2], &list2);
> +	list_add_tail(&entries[3], &list2);
> +	list_add_tail(&entries[4], &list1);
> +
> +	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
> +	list_splice(&list2, &entries[1]);
> +	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] uninit */
> +
> +	list_for_each(cur, &list1) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 5);
> +}
> +
> +static void list_splice_tail_test(struct kunit *test)
> +{
> +	struct list_head entries[5], *cur;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +	int i = 0;
> +
> +	list_add_tail(&entries[0], &list1);
> +	list_add_tail(&entries[1], &list1);
> +	list_add_tail(&entries[2], &list2);
> +	list_add_tail(&entries[3], &list2);
> +	list_add_tail(&entries[4], &list1);
> +
> +	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
> +	list_splice_tail(&list2, &entries[4]);
> +	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] uninit */
> +
> +	list_for_each(cur, &list1) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 5);
> +}
> +
> +static void list_splice_init_test(struct kunit *test)
> +{
> +	struct list_head entries[5], *cur;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +	int i = 0;
> +
> +	list_add_tail(&entries[0], &list1);
> +	list_add_tail(&entries[1], &list1);
> +	list_add_tail(&entries[2], &list2);
> +	list_add_tail(&entries[3], &list2);
> +	list_add_tail(&entries[4], &list1);
> +
> +	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
> +	list_splice_init(&list2, &entries[1]);
> +	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] empty */
> +
> +	list_for_each(cur, &list1) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 5);
> +
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
> +}
> +
> +static void list_splice_tail_init_test(struct kunit *test)
> +{
> +	struct list_head entries[5], *cur;
> +	LIST_HEAD(list1);
> +	LIST_HEAD(list2);
> +	int i = 0;
> +
> +	list_add_tail(&entries[0], &list1);
> +	list_add_tail(&entries[1], &list1);
> +	list_add_tail(&entries[2], &list2);
> +	list_add_tail(&entries[3], &list2);
> +	list_add_tail(&entries[4], &list1);
> +
> +	/* before: [list1]->e[0]->e[1]->e[4], [list2]->e[2]->e[3] */
> +	list_splice_tail_init(&list2, &entries[4]);
> +	/* after: [list1]->e[0]->e[1]->e[2]->e[3]->e[4], [list2] empty */
> +
> +	list_for_each(cur, &list1) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 5);
> +
> +	KUNIT_EXPECT_TRUE(test, list_empty_careful(&list2));
> +}
> +
> +static void list_entry_test(struct kunit *test)
> +{
> +	struct list_test_struct test_struct;

I guess this is not a missing initialization here because this is just
testing the container_of() wrapper macro?

> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct, list_entry(&(test_struct.list), struct list_test_struct, list));
> +}
> +
> +static void list_first_entry_test(struct kunit *test)
> +{
> +	struct list_test_struct test_struct1, test_struct2;
> +	static LIST_HEAD(list);

This is this static?

> +
> +	list_add_tail(&test_struct1.list, &list);
> +	list_add_tail(&test_struct2.list, &list);
> +
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry(&list, struct list_test_struct, list));
> +}
> +
> +static void list_last_entry_test(struct kunit *test)
> +{
> +	struct list_test_struct test_struct1, test_struct2;
> +	static LIST_HEAD(list);

Same, and why aren't these combined into one test?

> +
> +	list_add_tail(&test_struct1.list, &list);
> +	list_add_tail(&test_struct2.list, &list);
> +
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_last_entry(&list, struct list_test_struct, list));
> +}
> +
> +static void list_first_entry_or_null_test(struct kunit *test)
> +{
> +	struct list_test_struct test_struct1, test_struct2;
> +	static LIST_HEAD(list);

static why?

> +
> +	KUNIT_EXPECT_FALSE(test, list_first_entry_or_null(&list, struct list_test_struct, list));
> +
> +	list_add_tail(&test_struct1.list, &list);
> +	list_add_tail(&test_struct2.list, &list);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_first_entry_or_null(&list, struct list_test_struct, list));
> +}
> +
> +static void list_next_entry_test(struct kunit *test)
> +{
> +	struct list_test_struct test_struct1, test_struct2;
> +	static LIST_HEAD(list);

Same.

> +
> +	list_add_tail(&test_struct1.list, &list);
> +	list_add_tail(&test_struct2.list, &list);
> +
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct2, list_next_entry(&test_struct1, list));
> +}
> +
> +static void list_prev_entry_test(struct kunit *test)
> +{
> +	struct list_test_struct test_struct1, test_struct2;
> +	static LIST_HEAD(list);

Same.

> +
> +	list_add_tail(&test_struct1.list, &list);
> +	list_add_tail(&test_struct2.list, &list);
> +
> +
> +	KUNIT_EXPECT_PTR_EQ(test, &test_struct1, list_prev_entry(&test_struct2, list));
> +}
> +
> +static void list_for_each_test(struct kunit *test)
> +{
> +	struct list_head entries[3], *cur;
> +	LIST_HEAD(list);
> +	int i = 0;
> +
> +	list_add_tail(&entries[0], &list);
> +	list_add_tail(&entries[1], &list);
> +	list_add_tail(&entries[2], &list);
> +
> +	list_for_each(cur, &list) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 3);
> +}
> +
> +static void list_for_each_prev_test(struct kunit *test)
> +{
> +	struct list_head entries[3], *cur;
> +	LIST_HEAD(list);
> +	int i = 2;
> +
> +	list_add_tail(&entries[0], &list);
> +	list_add_tail(&entries[1], &list);
> +	list_add_tail(&entries[2], &list);
> +
> +	list_for_each_prev(cur, &list) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		i--;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, -1);

Both of these tests test that the list contained the correct number of
entries, not that anything about ordering was established. I would load
values into these with the list_test_struct and test that the counting
matches the expected ordering.

> +}
> +
> +static void list_for_each_safe_test(struct kunit *test)
> +{
> +	struct list_head entries[3], *cur, *n;
> +	LIST_HEAD(list);
> +	int i = 0;
> +
> +
> +	list_add_tail(&entries[0], &list);
> +	list_add_tail(&entries[1], &list);
> +	list_add_tail(&entries[2], &list);
> +
> +	list_for_each_safe(cur, n, &list) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		list_del(&entries[i]);
> +		i++;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, i, 3);

I would expect an is_empty() test here too.

> +}
> +
> +static void list_for_each_prev_safe_test(struct kunit *test)
> +{
> +	struct list_head entries[3], *cur, *n;
> +	LIST_HEAD(list);
> +	int i = 2;
> +
> +	list_add_tail(&entries[0], &list);
> +	list_add_tail(&entries[1], &list);
> +	list_add_tail(&entries[2], &list);
> +
> +	list_for_each_prev_safe(cur, n, &list) {
> +		KUNIT_EXPECT_PTR_EQ(test, cur, &entries[i]);
> +		list_del(&entries[i]);
> +		i--;
> +	}

Same thing here.

> +
> +	KUNIT_EXPECT_EQ(test, i, -1);
> +}
> +
> +static void list_for_each_entry_test(struct kunit *test)
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
> +}
> +
> +static void list_for_each_entry_reverse_test(struct kunit *test)
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

Oh! Here is the data test. Why keep these separate? You could combine
the counting tests with these?

One thing to consider adding is a short comment above each test to
clarify the test intention. While these are relatively simple tests, it
could clarify things like "only testing counts here" or "similar to
test_foo(), this adds in ordering verification", etc.

> +}
> +
> +static struct kunit_case list_test_cases[] = {
> +	KUNIT_CASE(list_init_test),
> +	KUNIT_CASE(list_add_test),
> +	KUNIT_CASE(list_add_tail_test),
> +	KUNIT_CASE(list_del_test),
> +	KUNIT_CASE(list_replace_test),
> +	KUNIT_CASE(list_replace_init_test),
> +	KUNIT_CASE(list_swap_test),
> +	KUNIT_CASE(list_del_init_test),
> +	KUNIT_CASE(list_move_test),
> +	KUNIT_CASE(list_move_tail_test),
> +	KUNIT_CASE(list_bulk_move_tail_test),
> +	KUNIT_CASE(list_is_first_test),
> +	KUNIT_CASE(list_is_last_test),
> +	KUNIT_CASE(list_empty_test),
> +	KUNIT_CASE(list_empty_careful_test),
> +	KUNIT_CASE(list_rotate_left_test),
> +	KUNIT_CASE(list_rotate_to_front_test),
> +	KUNIT_CASE(list_is_singular_test),
> +	KUNIT_CASE(list_cut_position_test),
> +	KUNIT_CASE(list_cut_before_test),
> +	KUNIT_CASE(list_splice_test),
> +	KUNIT_CASE(list_splice_tail_test),
> +	KUNIT_CASE(list_splice_init_test),
> +	KUNIT_CASE(list_splice_tail_init_test),
> +	KUNIT_CASE(list_entry_test),
> +	KUNIT_CASE(list_first_entry_test),
> +	KUNIT_CASE(list_last_entry_test),
> +	KUNIT_CASE(list_first_entry_or_null_test),
> +	KUNIT_CASE(list_next_entry_test),
> +	KUNIT_CASE(list_prev_entry_test),
> +	KUNIT_CASE(list_for_each_test),
> +	KUNIT_CASE(list_for_each_prev_test),
> +	KUNIT_CASE(list_for_each_safe_test),
> +	KUNIT_CASE(list_for_each_prev_safe_test),
> +	KUNIT_CASE(list_for_each_entry_test),
> +	KUNIT_CASE(list_for_each_entry_reverse_test),
> +	{},
> +};
> +
> +static struct kunit_suite list_test_module = {
> +	.name = "list-test",
> +	.test_cases = list_test_cases,
> +};
> +
> +kunit_test_suite(list_test_module);
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 

Thanks for working on this! I'm excited to see some core API unit tests!
:)

-- 
Kees Cook
