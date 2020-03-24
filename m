Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76871916C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 17:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCXQpZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 12:45:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57694 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCXQpY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 12:45:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGh2EU102497;
        Tue, 24 Mar 2020 16:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=5b9wb3f2bzObgWbQdpgaIklwxUsss6rC628mYngDBJc=;
 b=omve0INnLixQXjdE9kKGCVur/9jvIAKhCD1DBVY0LurnAR2WwVGVBqF1Obg0hZK7Rl8/
 U/KA3E6H/mcQWy7AN7aU34RMv8L5vrTJ21p0BFKymosP22tBlT/Fs/0jR2HaU94LyU7o
 H3ttcHup9ebE+sYbjUy6bJKyKd3oZPXc0snXIan1GOSvcFdCN/MvWg4qOKldByn/lo3S
 DFCy8cEaGTGZu5t43dfuqxtAVSx4NPAKo5J9LRMyF1IAzfYPMfYtelJkjqppQJJYf29I
 E/ehac9OCHYgkOO+QZnbypZX8IbPwHuoXZx5Soi7qtcUXga+KAKAFWquUlcHMTZk+sxC sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ywavm5enc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 16:45:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02OGgEWr139025;
        Tue, 24 Mar 2020 16:45:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yxw4pmwqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 16:45:13 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02OGjBBr015605;
        Tue, 24 Mar 2020 16:45:11 GMT
Received: from dhcp-10-175-162-99.vpn.oracle.com (/10.175.162.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Mar 2020 09:45:11 -0700
Date:   Tue, 24 Mar 2020 16:45:06 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Patricia Alfonso <trishalfonso@google.com>
cc:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/3] KUnit: KASAN Integration
In-Reply-To: <20200319164227.87419-3-trishalfonso@google.com>
Message-ID: <alpine.LRH.2.21.2003241640150.30637@localhost>
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-3-trishalfonso@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=1 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003240088
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Thu, 19 Mar 2020, Patricia Alfonso wrote:

> Integrate KASAN into KUnit testing framework.
> 	- Fail tests when KASAN reports an error that is not expected
>      	- Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>      	- Expected KASAN reports pass tests and are still printed when run
>      	without kunit_tool (kunit_tool still bypasses the report due to the
> 	test passing)
>      	- KUnit struct in current task used to keep track of the current test
>      	from KASAN code
> 
> Make use of "[RFC PATCH kunit-next 1/2] kunit: generalize
> kunit_resource API beyond allocated resources" and "[RFC PATCH
> kunit-next 2/2] kunit: add support for named resources" from Alan
> Maguire [1]
> 	- A named resource is added to a test when a KASAN report is
> 	 expected
>         - This resource contains a struct for kasan_data containing
>         booleans representing if a KASAN report is expected and if a
>         KASAN report is found
> 
> [1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)
> 
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
>  include/kunit/test.h | 10 ++++++++++
>  lib/kunit/test.c     | 10 +++++++++-
>  lib/test_kasan.c     | 37 +++++++++++++++++++++++++++++++++++++
>  mm/kasan/report.c    | 33 +++++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 70ee581b19cd..2ab265f4f76c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -19,9 +19,19 @@
>  
>  struct kunit_resource;
>  
> +#ifdef CONFIG_KASAN
> +/* kasan_data struct is used in KUnit tests for KASAN expected failures */
> +struct kunit_kasan_expectation {
> +	bool report_expected;
> +	bool report_found;
> +};
> +#endif /* CONFIG_KASAN */
> +

Above should be moved to mm/kasan/kasan.h I think.

>  typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
>  typedef void (*kunit_resource_free_t)(struct kunit_resource *);
>  
> +void kunit_set_failure(struct kunit *test);
> +

Can you explain a bit more about why we need this exported?
I see where it's used but I'd just like to make sure I
understand what you're trying to do. Thanks!

>  /**
>   * struct kunit_resource - represents a *test managed resource*
>   * @data: for the user to store arbitrary data.
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 86a4d9ca0a45..3f927ef45827 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -10,11 +10,12 @@
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched.h>
>  
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>  
> -static void kunit_set_failure(struct kunit *test)
> +void kunit_set_failure(struct kunit *test)
>  {
>  	WRITE_ONCE(test->success, false);
>  }
> @@ -237,6 +238,10 @@ static void kunit_try_run_case(void *data)
>  	struct kunit_suite *suite = ctx->suite;
>  	struct kunit_case *test_case = ctx->test_case;
>  
> +#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
> +	current->kunit_test = test;
> +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT) */
> +
>  	/*
>  	 * kunit_run_case_internal may encounter a fatal error; if it does,
>  	 * abort will be called, this thread will exit, and finally the parent
> @@ -590,6 +595,9 @@ void kunit_cleanup(struct kunit *test)
>  		spin_unlock(&test->lock);
>  		kunit_remove_resource(test, res);
>  	}
> +#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
> +	current->kunit_test = NULL;

As per patch 1, I'd suggest changing here and elsewhere to 
"IS_ENABLED(CONFIG_KUNIT)".

> +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT)*/
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
>  
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 3872d250ed2c..cf73c6bee81b 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,6 +23,43 @@
>  
>  #include <asm/page.h>
>  
> +#include <kunit/test.h>
> +
> +struct kunit_resource resource;
> +struct kunit_kasan_expectation fail_data;
> +
> +#define KUNIT_SET_KASAN_DATA(test) do { \
> +	fail_data.report_expected = true; \
> +	fail_data.report_found = false; \
> +	kunit_add_named_resource(test, \
> +				NULL, \
> +				NULL, \
> +				&resource, \
> +				"kasan_data", &fail_data); \
> +} while (0)
> +
> +#define KUNIT_DO_EXPECT_KASAN_FAIL(test, condition) do { \
> +	struct kunit_resource *resource; \
> +	struct kunit_kasan_expectation *kasan_data; \
> +	condition; \
> +	resource = kunit_find_named_resource(test, "kasan_data"); \
> +	kasan_data = resource->data; \
> +	KUNIT_EXPECT_EQ(test, \
> +			kasan_data->report_expected, \
> +			kasan_data->report_found); \
> +	kunit_put_resource(resource); \
> +} while (0)
> +
> +/**
> + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> + * not cause a KASAN error.
> + *
> + */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> +	KUNIT_SET_KASAN_DATA(test); \
> +	KUNIT_DO_EXPECT_KASAN_FAIL(test, condition); \
> +} while (0)
> +
>  /*
>   * Note: test functions are marked noinline so that their names appear in
>   * reports.
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..ef3d0f54097e 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -32,6 +32,8 @@
>  
>  #include <asm/sections.h>
>  
> +#include <kunit/test.h>
> +
>  #include "kasan.h"
>  #include "../slab.h"
>  
> @@ -455,12 +457,38 @@ static bool report_enabled(void)
>  	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
>  }
>  
> +#if IS_BUILTIN(CONFIG_KUNIT)

again we could tweak this to IS_ENABLED(CONFIG_KUNIT); BTW
the reason we can compile kunit as a module for these tests
is the KASAN tests are tristate themselves. If they were
builtin only it wouldn't be possible to build kunit as
a module.

> +void kasan_update_kunit_status(struct kunit *cur_test)
> +{
> +	struct kunit_resource *resource;
> +	struct kunit_kasan_expectation *kasan_data;
> +
> +	if (kunit_find_named_resource(cur_test, "kasan_data")) {
> +		resource = kunit_find_named_resource(cur_test, "kasan_data");
> +		kasan_data = resource->data;
> +		kasan_data->report_found = true;
> +
> +		if (!kasan_data->report_expected)
> +			kunit_set_failure(current->kunit_test);
> +		else
> +			return;
> +	} else
> +		kunit_set_failure(current->kunit_test);
> +}
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +
>  void kasan_report_invalid_free(void *object, unsigned long ip)
>  {
>  	unsigned long flags;
>  	u8 tag = get_tag(object);
>  
>  	object = reset_tag(object);
> +
> +#if IS_BUILTIN(CONFIG_KUNIT)

same comment as above.
 
> +	if (current->kunit_test)
> +		kasan_update_kunit_status(current->kunit_test);
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +
>  	start_report(&flags);
>  	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
>  	print_tags(tag, object);
> @@ -481,6 +509,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
>  	if (likely(!report_enabled()))
>  		return;
>  
> +#if IS_BUILTIN(CONFIG_KUNIT)

here too.

> +	if (current->kunit_test)
> +		kasan_update_kunit_status(current->kunit_test);
> +#endif /* IS_BUILTIN(CONFIG_KUNIT) */
> +
>  	disable_trace_on_warning();
>  
>  	tagged_addr = (void *)addr;
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
> 
