Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E416323EEE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Aug 2020 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgHGOQG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Aug 2020 10:16:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57944 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGOQF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Aug 2020 10:16:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077EBWxv004637;
        Fri, 7 Aug 2020 14:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=KCMyD2M5e2LHkH30l1dv6Rn00BI66zsqpvc8P6q/Qos=;
 b=W7iMAkkzz03Rb0wseVn+5YhS6VLr1+EGJEDd0iYaLeiM7cCV+Qa9OoLxay8rKotKe70J
 Jd3NQjDno3VyrwEw6jAcA9E6ukHkHC/BnVJIA8ytQ90+2tvslR7IK+5eIRx6P0v8l3nf
 Ui9ugAVgpSEa22OXZrMpzQ/ZIO2yTRCNsA5+hwRNICNnlebg+D4EB8Dg/luISv7/0QwX
 QFC2q4nq96wGgGYvz42XLwfDqKYAYW5+V1prxH4L63tBRyhOkQP6Z9wHMzJY8dVZMcTT
 axorBMVDS9pr1KiYAx22rQ9iodwM9MVioqgOZYHqepJUqHVOBm9OsFNiepEnnwfJQslD eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32r6gx0qvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 07 Aug 2020 14:15:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077E80rI173628;
        Fri, 7 Aug 2020 14:15:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32r6cxs1fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Aug 2020 14:15:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 077EFuZG015834;
        Fri, 7 Aug 2020 14:15:56 GMT
Received: from dhcp-10-175-209-88.vpn.oracle.com (/10.175.209.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Aug 2020 14:15:56 +0000
Date:   Fri, 7 Aug 2020 15:15:49 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Uriel Guajardo <urielguajardojr@gmail.com>
cc:     brendanhiggins@google.com, urielguajardo@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/2] kunit: support failure from dynamic analysis tools
In-Reply-To: <20200806174326.3577537-1-urielguajardojr@gmail.com>
Message-ID: <alpine.LRH.2.21.2008071510580.10525@localhost>
References: <20200806174326.3577537-1-urielguajardojr@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9705 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9705 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070102
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 6 Aug 2020, Uriel Guajardo wrote:

> Adds an API to allow dynamic analysis tools to fail the currently
> running KUnit test case.
> 
> - Always places the kunit test in the task_struct to allow other tools
> to access the currently running KUnit test.
> 
> - Creates a new header file to avoid circular dependencies that could be
> created from the test.h file.
> 
> Requires KASAN-KUnit integration patch to access the kunit test from
> task_struct:
> https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com/
> 
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> ---
>  include/kunit/test-bug.h | 24 ++++++++++++++++++++++++
>  include/kunit/test.h     |  1 +
>  lib/kunit/test.c         | 10 ++++++----
>  3 files changed, 31 insertions(+), 4 deletions(-)
>  create mode 100644 include/kunit/test-bug.h
> 
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> new file mode 100644
> index 000000000000..283c19ec328f
> --- /dev/null
> +++ b/include/kunit/test-bug.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> + *
> + * Copyright (C) 2020, Google LLC.
> + * Author: Uriel Guajardo <urielguajardo@google.com>
> + */
> +
> +#ifndef _KUNIT_TEST_BUG_H
> +#define _KUNIT_TEST_BUG_H
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +
> +extern void kunit_fail_current_test(void);
> +
> +#else
> +
> +static inline void kunit_fail_current_test(void)
> +{
> +}
> +
> +#endif
> +
> +#endif /* _KUNIT_TEST_BUG_H */

This is great stuff!

One thing I wonder though; how obvious will it be to someone
running a KUnit test that the cause of the test failure
is a dynamic analysis tool?  Yes we'll see the dmesg logging
from that tool but I don't think there's any context _within_
KUnit that could clarify the source of the failure.  What about
changing the above API to include a string message that KUnit can
log, so it can at least identify the source of the failure
(ubsan, kasan etc).  That would alert anyone looking at KUnit
output only that there's an external context to examine.

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 3391f38389f8..81bf43a1abda 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -11,6 +11,7 @@
>  
>  #include <kunit/assert.h>
>  #include <kunit/try-catch.h>
> +#include <kunit/test-bug.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index dcc35fd30d95..d8189d827368 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -16,6 +16,12 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>  
> +void kunit_fail_current_test(void)
> +{
> +	if (current->kunit_test)
> +		kunit_set_failure(current->kunit_test);
> +}
> +
>  static void kunit_print_tap_version(void)
>  {
>  	static bool kunit_has_printed_tap_version;
> @@ -284,9 +290,7 @@ static void kunit_try_run_case(void *data)
>  	struct kunit_suite *suite = ctx->suite;
>  	struct kunit_case *test_case = ctx->test_case;
>  
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>  	current->kunit_test = test;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
>  
>  	/*
>  	 * kunit_run_case_internal may encounter a fatal error; if it does,
> @@ -602,9 +606,7 @@ void kunit_cleanup(struct kunit *test)
>  		spin_unlock(&test->lock);
>  		kunit_remove_resource(test, res);
>  	}
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>  	current->kunit_test = NULL;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
>  
> -- 
> 2.28.0.163.g6104cc2f0b6-goog
> 
> 
