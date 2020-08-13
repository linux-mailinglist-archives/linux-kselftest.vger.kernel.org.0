Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526B624375E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMJLa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 05:11:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38042 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMJL3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 05:11:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D97nlS141864;
        Thu, 13 Aug 2020 09:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=/JqtlkEZ2IxP0kOfhJd1yadQM7B/Phq73vNVsDC8rV0=;
 b=Vh/XH9KzblD91nLox+7d0V10BMblzfWRNjajigcTIN3UQjChoI/GrWdPtjXMTVhGcIzo
 gmJfL2yJ5tkkLOCHKQognppXJ5wkVaem5S7A4j6DVvL1GtuSTXiLz6c28PYeCd0eTrKN
 ufGuBDqi1lgO5XuI8muISr9MiXG0Q81m48Iafg+VUdQecrXQ3XCxROy/zmWK1ydjDvqM
 zzOXUPGo0S8mJ1HHh8bh0tcKwpREvSJ2It/vUADE+hzr1JXXRLgvOVuVtlCzKY6IVQD8
 VQPRoDwRADxNq1IC3sh8kOUveuazjRGdplJWMO1zHD1UFmEnQetRDqV0R2o+AlICDeI1 wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32sm0mygwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Aug 2020 09:11:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D97cXd176701;
        Thu, 13 Aug 2020 09:11:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32t5mrjbhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 09:11:13 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07D9BBqK014639;
        Thu, 13 Aug 2020 09:11:11 GMT
Received: from dhcp-10-175-205-125.vpn.oracle.com (/10.175.205.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 09:11:10 +0000
Date:   Thu, 13 Aug 2020 10:11:02 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Uriel Guajardo <urielguajardojr@gmail.com>
cc:     brendanhiggins@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        urielguajardo@google.com
Subject: Re: [PATCH v2] kunit: added lockdep support
In-Reply-To: <20200812193332.954395-1-urielguajardojr@gmail.com>
Message-ID: <alpine.LRH.2.21.2008130925460.4960@localhost>
References: <20200812193332.954395-1-urielguajardojr@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130068
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 12 Aug 2020, Uriel Guajardo wrote:

> KUnit will fail tests upon observing a lockdep failure. Because lockdep
> turns itself off after its first failure, only fail the first test and
> warn users to not expect any future failures from lockdep.
> 
> Similar to lib/locking-selftest [1], we check if the status of
> debug_locks has changed after the execution of a test case. However, we
> do not reset lockdep afterwards.
> 
> Like the locking selftests, we also fix possible preemption count
> corruption from lock bugs.
> 
> Depends on kunit: support failure from dynamic analysis tools [2]
> 
> [1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137
> 
> [2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/
> 
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> ---
> v2 Changes:
> - Removed lockdep_reset
> 
> - Added warning to users about lockdep shutting off
> ---
>  lib/kunit/test.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index d8189d827368..7e477482457b 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -11,6 +11,7 @@
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched.h>
> +#include <linux/debug_locks.h>
>  
>  #include "debugfs.h"
>  #include "string-stream.h"
> @@ -22,6 +23,26 @@ void kunit_fail_current_test(void)
>  		kunit_set_failure(current->kunit_test);
>  }
>  
> +static void kunit_check_locking_bugs(struct kunit *test,
> +				     unsigned long saved_preempt_count,
> +				     bool saved_debug_locks)
> +{
> +	preempt_count_set(saved_preempt_count);
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +	if (softirq_count())
> +		current->softirqs_enabled = 0;
> +	else
> +		current->softirqs_enabled = 1;
> +#endif
> +#if IS_ENABLED(CONFIG_LOCKDEP)
> +	if (saved_debug_locks && !debug_locks) {
> +		kunit_set_failure(test);
> +		kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> +		kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> +	}
> +#endif
> +}

Nit: I could be wrong but the general approach for this sort of
feature is to do conditional compilation combined with "static inline"
definitions to handle the case where the feature isn't enabled. 
Could we tidy this up a bit and haul this stuff out into a
conditionally-compiled (if CONFIG_LOCKDEP) kunit lockdep.c file?
Then in kunit's lockdep.h we'd have

struct kunit_lockdep {
	int preempt_count;
	bool debug_locks;
};

#if IS_ENABLED(CONFIG_LOCKDEP)
void kunit_test_init_lockdep(struct kunit_test *test, struct 
			     kunit_lockdep *lockdep);
void kunit_test_check_lockdep(struct kunit_test *test,
			      struct kunit_lockdep *lockdep);
#else
static inline void kunit_init_lockdep(struct kunit_test *test,
				      struct kunit_lockdep *lockdep) { }
static inline void kunit_check_lockdep(struct kunit_test *test,
				       struct kunit_lockdep *lockdep) { }
#endif


The test execution code could then call

	struct kunit_lockdep lockdep;

	kunit_test_init_lockdep(test, &lockdep);

	kunit_test_check_lockdep(test, &lockdep);

If that approach makes sense, we could go a bit further
and we might benefit from a bit more generalization
here.  _If_ the pattern of needing pre- and post- test
actions is sustained across multiple analysis tools,
could we add generic hooks for this? That would allow any
additional dynamic analysis tools to utilize them.  So 
kunit_try_run_case() would then cycle through the registered
pre- hooks prior to running the case and post- hooks after,
failing if any of the latter returned a failure value.

I'm thinking something like

  kunit_register_external_test("lockdep", lockdep_pre, lockdep_post, 
			       &kunit_lockdep);

(or we could define a kunit_external_test struct for
better extensibility).

A void * would be passed to pre/post, in this case it'd
be a pointer to a struct containing the saved preempt
count/debug locks, and the registration could be called during
kunit initialization.  This doesn't need to be done with your
change of course but I wanted to float the idea as in addition
to uncluttering the test case execution code, it might allow
us to build facilities on top of that generic tool support for
situations like "I'd like to see if the test passes absent
any lockdep issues, so I'd like to disable lockdep-based failure".
Such situations are more likely to arise in a world where
kunit+tests are built as modules and run multiple times within
a single system boot admittedly, but worth considering I think.

For that we'd need a way to select which dynamic tools kunit
enables(kernel/module parameters or debugfs could do
this), but a generic approach might help that sort of thing.

An external test under this model wouldn't have to necessarily
be external to the area under test; the general criteria for
such things would be "something I want to track across multiple
test case execution".

Again I'm not trying to put you on the hook for any of
the above suggestions (having lockdep support like this is
fantastic!), but I think it'd be good to see if there's a
pattern here we could potentially exploit in other use cases.

Thanks!

Alan
