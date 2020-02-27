Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4308171BB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 15:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbgB0OE6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 09:04:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387660AbgB0OE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 09:04:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RE2ile138988;
        Thu, 27 Feb 2020 14:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=i5WAIG8BP2KWpfWgwk/JzPQ6t5ls5kkthOiIZq0xTpA=;
 b=RoDjzK66+Xglfwr6Y2DqP/xTE/OLivcZHnGkuDmhMuMzhLyYJCbaT48bCtdQ6F6qhZix
 dZY43nybQRbhef1AtDjscvkI6gtZOLlFV+f/zwxFUMGwDnJ+xwMtXHklNGEglOTspOFg
 KYzFZnI0nbup55oh34yLkjYixzwJaBL7XgrTWMmrMbhvcF/oPc9OacQ57xNdpFgNAc+D
 Ly6lGm1WohBPCVXeJoZ462FKb6UcCib3qQs10HiufDtlPdtJjtLFmNQ8s3SgjqL0ITVG
 2EJ8sctvDvjOWa8b/Wm/laj8QDIKM/RdLiCH+63BbLkFCgq9BejjjZTQ6c76edt3CrnQ ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ydct3b3ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 14:04:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RE2dRY096971;
        Thu, 27 Feb 2020 14:04:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2ydcs97jy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 14:04:39 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01RE4buE018835;
        Thu, 27 Feb 2020 14:04:39 GMT
Received: from dhcp-10-175-190-15.vpn.oracle.com (/10.175.190.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 06:04:36 -0800
Date:   Thu, 27 Feb 2020 14:04:28 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@dhcp-10-175-190-15.vpn.oracle.com
To:     Patricia Alfonso <trishalfonso@google.com>
cc:     aryabinin@virtuozzo.com, dvyukov@google.com,
        brendanhiggins@google.com, davidgow@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
In-Reply-To: <20200227024301.217042-2-trishalfonso@google.com>
Message-ID: <alpine.LRH.2.20.2002271136160.12417@dhcp-10-175-190-15.vpn.oracle.com>
References: <20200227024301.217042-1-trishalfonso@google.com> <20200227024301.217042-2-trishalfonso@google.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=13 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=13 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270111
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 26 Feb 2020, Patricia Alfonso wrote:

> Integrate KASAN into KUnit testing framework.

This is a great idea! Some comments/suggestions below...

>  - Fail tests when KASAN reports an error that is not expected
>  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>  - KUnit struct added to current task to keep track of the current test
> from KASAN code
>  - Booleans representing if a KASAN report is expected and if a KASAN
>  report is found added to kunit struct
>  - This prints "line# has passed" or "line# has failed"
> 
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
> If anyone has any suggestions on how best to print the failure
> messages, please share!
> 
> One issue I have found while testing this is the allocation fails in
> kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> does cause the test to fail on the KUnit side, as expected, but it
> seems to skip all the tests before this one because the output starts
> with this failure instead of with the first test, kmalloc_oob_right().
> 
>  include/kunit/test.h                | 24 ++++++++++++++++++++++++
>  include/linux/sched.h               |  7 ++++++-
>  lib/kunit/test.c                    |  7 ++++++-
>  mm/kasan/report.c                   | 19 +++++++++++++++++++
>  tools/testing/kunit/kunit_kernel.py |  2 +-
>  5 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 2dfb550c6723..2e388f8937f3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -21,6 +21,8 @@ struct kunit_resource;
>  typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
>  typedef void (*kunit_resource_free_t)(struct kunit_resource *);
>  
> +void kunit_set_failure(struct kunit *test);
> +
>  /**
>   * struct kunit_resource - represents a *test managed resource*
>   * @allocation: for the user to store arbitrary data.
> @@ -191,6 +193,9 @@ struct kunit {
>  	 * protect it with some type of lock.
>  	 */
>  	struct list_head resources; /* Protected by lock. */
> +
> +	bool kasan_report_expected;
> +	bool kasan_report_found;
>  };
>  

Is this needed here? You're testing something pretty
specific so it seems wrong to add to the generic
kunit resource unless there's a good reason. I see the
code around setting these values in mm/kasan/report.c,
but I wonder if we could do something more generic.

How about the concept of a static resource (assuming a
dynamically allocated one is out because it messes
with memory allocation tests)? Something like this:

#define kunit_add_static_resource(test, resource_ptr, resource_field)	\
	do {								\
		spin_lock(&test->lock);					\
		(resource_ptr)->resource_field.init = NULL;		\
		(resource_ptr)->resource_field.free = NULL;		\
		list_add_tail(&(resource_ptr)->resource_field,		\
 			      &test->resources);			\
		spin_unlock(&test->lock);				\
	} while (0)	      

	  
Within your kasan code you could then create a kasan-specific
structure that embends a kunit_resource, and contains the
values you need:

struct kasan_report_resource {
	struct kunit_resource res;
	bool kasan_report_expected;
	bool kasan_report_found;
};

(One thing we'd need to do for such static resources is fix
kunit_resource_free() to check if there's a free() function,
and if not assume a static resource)

If you then create an init() function associated with your
kunit suite (which will be run for every case) it can do this:

int kunit_kasan_test_init(struct kunit *test)
{
	kunit_add_static_resource(test, &my_kasan_report_resource, res);
	...
}

The above should also be used to initialize current->kasan_unit_test
instead of doing that in kunit_try_run_case().  With those
changes, you don't (I think) need to change anything in core
kunit (assuming support for static resources).

To retrieve the resource during tests or in kasan context, the
method seems to be to use kunit_resource_find(). However, that
requires a match function which seems a bit heavyweight for the
static case.  We should probably have a default "find by name"
or similar function here, and add an optional "name" field
to kunit resources to simplify things.  Anyway here you'd
use something like:

	kasan_report_resource = kunit_resource_find(test, matchfn, 
						    NULL, matchdata); 


Are there any barriers to taking this sort of approach (apart
from the support for static resources not being there yet)?

>  void kunit_init_test(struct kunit *test, const char *name);
> @@ -941,6 +946,25 @@ do {									       \
>  						ptr,			       \
>  						NULL)
>  
> +/**
> + * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> + * not cause a KASAN error.
> + *
> + */
> +#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do {	\
> +	test->kasan_report_expected = true;	\
> +	test->kasan_report_found = false; \
> +	condition; \
> +	if (test->kasan_report_found == test->kasan_report_expected) { \
> +		pr_info("%d has passed", __LINE__); \
> +	} else { \
> +		kunit_set_failure(test); \
> +		pr_info("%d has failed", __LINE__); \
> +	} \
> +	test->kasan_report_expected = false;	\
> +	test->kasan_report_found = false;	\
> +} while (0)
> +

Feels like this belongs in test_kasan.c, and could be reworked
to avoid adding test->kasan_report_[expected|found] as described
above.  Instead of having your own pass/fail logic couldn't you
do this:

	KUNIT_EXPECT_EQ(test, expected, found);

? That will set the failure state too so no need to export
a separate function for that, and no need to log anything
as KUNIT_EXPECT_EQ() should do that for you.

>  /**
>   * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
>   * @test: The test context object.
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 04278493bf15..db23d56061e7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -32,6 +32,8 @@
>  #include <linux/posix-timers.h>
>  #include <linux/rseq.h>
>  
> +#include <kunit/test.h>
> +

This feels like the wrong place to add this #include, and
when I attempted to build to test I ran into a bunch of
compilation errors; for example:

 CC      kernel/sched/core.o
In file included from ./include/linux/uaccess.h:11,
                 from ./arch/x86/include/asm/fpu/xstate.h:5,
                 from ./arch/x86/include/asm/pgtable.h:26,
                 from ./include/linux/kasan.h:16,
                 from ./include/linux/slab.h:136,
                 from ./include/kunit/test.h:16,
                 from ./include/linux/sched.h:35,
                 from init/do_mounts.c:3:
./arch/x86/include/asm/uaccess.h: In function 'set_fs':
./arch/x86/include/asm/uaccess.h:32:9: error: dereferencing pointer to 
incomplete type 'struct task_struct'
  current->thread.addr_limit = fs;

(I'm testing with CONFIG_SLUB). Removing this #include
resolves these errors, but then causes problems for
lib/test_kasan.c. I'll dig around a bit more.

>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
>  struct backing_dev_info;
> @@ -1178,7 +1180,10 @@ struct task_struct {
>  
>  #ifdef CONFIG_KASAN
>  	unsigned int			kasan_depth;
> -#endif
> +#ifdef CONFIG_KUNIT
> +	struct kunit *kasan_kunit_test;
> +#endif /* CONFIG_KUNIT */
> +#endif /* CONFIG_KASAN */
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	/* Index of current stored address in ret_stack: */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 9242f932896c..d266b9495c67 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -9,11 +9,12 @@
>  #include <kunit/test.h>
>  #include <linux/kernel.h>
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
> @@ -236,6 +237,10 @@ static void kunit_try_run_case(void *data)
>  	struct kunit_suite *suite = ctx->suite;
>  	struct kunit_case *test_case = ctx->test_case;
>  
> +#ifdef CONFIG_KASAN
> +	current->kasan_kunit_test = test;
> +#endif
> +
>  	/*
>  	 * kunit_run_case_internal may encounter a fatal error; if it does,
>  	 * abort will be called, this thread will exit, and finally the parent
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 5ef9f24f566b..5554d23799a5 100644
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
> @@ -461,6 +463,15 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>  	u8 tag = get_tag(object);
>  
>  	object = reset_tag(object);
> +
> +	if (current->kasan_kunit_test) {
> +		if (current->kasan_kunit_test->kasan_report_expected) {
> +			current->kasan_kunit_test->kasan_report_found = true;
> +			return;
> +		}
> +		kunit_set_failure(current->kasan_kunit_test);
> +	}
> +
>  	start_report(&flags);
>  	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
>  	print_tags(tag, object);
> @@ -481,6 +492,14 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
>  	if (likely(!report_enabled()))
>  		return;
>  
> +	if (current->kasan_kunit_test) {
> +		if (current->kasan_kunit_test->kasan_report_expected) {
> +			current->kasan_kunit_test->kasan_report_found = true;
> +			return;
> +		}
> +		kunit_set_failure(current->kasan_kunit_test);
> +	}
> +
>  	disable_trace_on_warning();
>  
>  	tagged_addr = (void *)addr;
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index cc5d844ecca1..63eab18a8c34 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
>  		return True
>  
>  	def run_kernel(self, args=[], timeout=None, build_dir=''):
> -		args.extend(['mem=256M'])
> +		args.extend(['mem=256M', 'kasan_multi_shot'])
>  		process = self._ops.linux_bin(args, timeout, build_dir)
>  		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>  			for line in process.stdout:

I tried applying this to the "kunit" branch of linux-kselftest, and
the above failed. Which branch are you building with? Probably
best to use the kunit branch I think. Thanks!

Alan

> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
> 
