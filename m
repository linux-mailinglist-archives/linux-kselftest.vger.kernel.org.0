Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74D19D93E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Apr 2020 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgDCOgF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Apr 2020 10:36:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55188 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCOgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Apr 2020 10:36:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033EXYIY031824;
        Fri, 3 Apr 2020 14:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=v2VPJBmV/wf+bKML1xDBcfICL0eqxAMEV+JWda6o6PE=;
 b=Rl/ErqpV+neETN6Bc64O+elKPBLIMUCj1Qnk9Gj46JzglrsyWRkCrcTpAryyJFa/Wgs+
 +jMQYGNrOyujEl5ghZVdoExygnaGocluIqp/YN9BPIJpdX9o3E+SuQEiXmahXBnmgG3V
 cR4WX68YELAJuHTdBFxDCP8YDnf+NpxsIqqNabODWhO+JkHyslthcUfWvjKWs+ZZ1Dp1
 /o4jyvAGUrq6tuL0H+4IMbA8lOvUsImtb6wc9P2Vx8HMY2jUupsOHva8ulqCSxX6mwxP
 5ODlmtz6VrOgGqWXMI32h2b9jxqC6RqVofM4Kx3SN4LxKzFWej0+7QJxJP9BsFlUtthg 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yunm0jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 14:35:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033EXCZl011078;
        Fri, 3 Apr 2020 14:35:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 304sjsyr1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 14:35:46 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033EZbX3019744;
        Fri, 3 Apr 2020 14:35:43 GMT
Received: from dhcp-10-175-200-49.vpn.oracle.com (/10.175.200.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 07:35:37 -0700
Date:   Fri, 3 Apr 2020 15:35:27 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Patricia Alfonso <trishalfonso@google.com>
cc:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 2/4] KUnit: KASAN Integration
In-Reply-To: <20200402204639.161637-2-trishalfonso@google.com>
Message-ID: <alpine.LRH.2.21.2004031529080.17071@localhost>
References: <20200402204639.161637-1-trishalfonso@google.com> <20200402204639.161637-2-trishalfonso@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=1 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030129
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2 Apr 2020, Patricia Alfonso wrote:

> Integrate KASAN into KUnit testing framework.
>         - Fail tests when KASAN reports an error that is not expected
>         - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN
> 	tests
>         - Expected KASAN reports pass tests and are still printed when run
>         without kunit_tool (kunit_tool still bypasses the report due to the
>         test passing)
>         - KUnit struct in current task used to keep track of the current
> 	test from KASAN code
> 
> Make use of "[PATCH v3 kunit-next 1/2] kunit: generalize
> kunit_resource API beyond allocated resources" and "[PATCH v3
> kunit-next 2/2] kunit: add support for named resources" from Alan
> Maguire [1]
>         - A named resource is added to a test when a KASAN report is
>          expected
>         - This resource contains a struct for kasan_data containing
>         booleans representing if a KASAN report is expected and if a
>         KASAN report is found
> 
> [1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)
> 
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/kunit/test.h  |  5 ++++
>  include/linux/kasan.h |  6 +++++
>  lib/kunit/test.c      | 13 ++++++----
>  lib/test_kasan.c      | 56 +++++++++++++++++++++++++++++++++++++++----
>  mm/kasan/report.c     | 30 +++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 9 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index ac59d18e6bab..1dc3d118f64b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -225,6 +225,11 @@ struct kunit {
>  	struct list_head resources; /* Protected by lock. */
>  };
>  
> +static inline void kunit_set_failure(struct kunit *test)
> +{
> +	WRITE_ONCE(test->success, false);
> +}
> +
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
>  
>  int kunit_run_tests(struct kunit_suite *suite);
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5cde9e7c2664..148eaef3e003 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -14,6 +14,12 @@ struct task_struct;
>  #include <asm/kasan.h>
>  #include <asm/pgtable.h>
>  
> +/* kasan_data struct is used in KUnit tests for KASAN expected failures */
> +struct kunit_kasan_expectation {
> +	bool report_expected;
> +	bool report_found;
> +};
> +
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>  extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
>  extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 2cb7c6220a00..030a3281591e 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -10,16 +10,12 @@
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched.h>
>  
>  #include "debugfs.h"
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>  
> -static void kunit_set_failure(struct kunit *test)
> -{
> -	WRITE_ONCE(test->success, false);
> -}
> -
>  static void kunit_print_tap_version(void)
>  {
>  	static bool kunit_has_printed_tap_version;
> @@ -288,6 +284,10 @@ static void kunit_try_run_case(void *data)
>  	struct kunit_suite *suite = ctx->suite;
>  	struct kunit_case *test_case = ctx->test_case;
>  
> +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> +	current->kunit_test = test;
> +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
> +
>  	/*
>  	 * kunit_run_case_internal may encounter a fatal error; if it does,
>  	 * abort will be called, this thread will exit, and finally the parent
> @@ -603,6 +603,9 @@ void kunit_cleanup(struct kunit *test)
>  		spin_unlock(&test->lock);
>  		kunit_remove_resource(test, res);
>  	}
> +#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
> +	current->kunit_test = NULL;
> +#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
>  
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 3872d250ed2c..dbfa0875ee09 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -23,12 +23,60 @@
>  
>  #include <asm/page.h>
>  
> -/*
> - * Note: test functions are marked noinline so that their names appear in
> - * reports.
> +#include <kunit/test.h>
> +
> +static struct kunit_resource resource;
> +static struct kunit_kasan_expectation fail_data;
> +static bool multishot;
> +static int orig_panic_on_warn;
> +
> +static int kasan_test_init(struct kunit *test)
> +{
> +	/*
> +	 * Temporarily enable multi-shot mode and set panic_on_warn=0.
> +	 * Otherwise, we'd only get a report for the first case.
> +	 */
> +	multishot = kasan_save_enable_multi_shot();
> +
> +	orig_panic_on_warn = panic_on_warn;
> +	panic_on_warn = 0;
> +

When I build kunit and test_kasan as a module, I'm seeing

ERROR: "panic_on_warn" [lib/test_kasan.ko] undefined!

Looks like this variable isn't exported (unlike
panic_timeout).

Is there an in-kernel API to read sysctl values we could
use here that would be safe for module and builtin access
maybe? 

Alan

> +	return 0;
> +}
> +
> +static void kasan_test_exit(struct kunit *test)
> +{
> +	kasan_restore_multi_shot(multishot);
> +
> +	/* Restore panic_on_warn */
> +	panic_on_warn = orig_panic_on_warn;
> +}
> +
> +/**
> + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> + * not cause a KASAN error. This uses a KUnit resource named "kasan_data." Do
> + * Do not use this name for a KUnit resource outside here.
> + *
>   */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> +	struct kunit_resource *res; \
> +	struct kunit_kasan_expectation *kasan_data; \
> +	fail_data.report_expected = true; \
> +	fail_data.report_found = false; \
> +	kunit_add_named_resource(test, \
> +				NULL, \
> +				NULL, \
> +				&resource, \
> +				"kasan_data", &fail_data); \
> +	condition; \
> +	res = kunit_find_named_resource(test, "kasan_data"); \
> +	kasan_data = res->data; \
> +	KUNIT_EXPECT_EQ(test, \
> +			kasan_data->report_expected, \
> +			kasan_data->report_found); \
> +	kunit_put_resource(res); \
> +} while (0)
>  
> -static noinline void __init kmalloc_oob_right(void)
>  {
>  	char *ptr;
>  	size_t size = 123;
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..497477c4b679 100644
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
> @@ -455,12 +457,35 @@ static bool report_enabled(void)
>  	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
>  }
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void kasan_update_kunit_status(struct kunit *cur_test)
> +{
> +	struct kunit_resource *resource;
> +	struct kunit_kasan_expectation *kasan_data;
> +
> +	if (!kunit_find_named_resource(cur_test, "kasan_data")) {
> +		kunit_set_failure(cur_test);
> +		return;
> +	}
> +
> +	resource = kunit_find_named_resource(cur_test, "kasan_data");
> +	kasan_data = resource->data;
> +	kasan_data->report_found = true;
> +}
> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> +
>  void kasan_report_invalid_free(void *object, unsigned long ip)
>  {
>  	unsigned long flags;
>  	u8 tag = get_tag(object);
>  
>  	object = reset_tag(object);
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +	if (current->kunit_test)
> +		kasan_update_kunit_status(current->kunit_test);
> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> +
>  	start_report(&flags);
>  	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
>  	print_tags(tag, object);
> @@ -481,6 +506,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
>  	if (likely(!report_enabled()))
>  		return;
>  
> +#if IS_ENABLED(CONFIG_KUNIT)
> +	if (current->kunit_test)
> +		kasan_update_kunit_status(current->kunit_test);
> +#endif /* IS_ENABLED(CONFIG_KUNIT) */
> +
>  	disable_trace_on_warning();
>  
>  	tagged_addr = (void *)addr;
> -- 
> 2.26.0.292.g33ef6b2f38-goog
> 
> 
