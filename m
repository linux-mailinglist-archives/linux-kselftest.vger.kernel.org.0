Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982A8DD75E
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2019 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfJSI1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Oct 2019 04:27:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfJSI1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Oct 2019 04:27:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9J8NfeA089970;
        Sat, 19 Oct 2019 08:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Oz64Q6r7thn7CZ3zAYkWauQrO9/H12CT413GOLuk17Q=;
 b=KuMhEHRzecAqh4nBJd65WIPwfeuB5H9gykK4SJMbb8VHuYsoqsjEVAM6R5lj6lDNJrMo
 G1eIbKP8rH/RPuEGWXMArNSCk95CJGN1VwFwkVj9ALOfosD+9hR0xtGq+q+xUhwgfPv6
 62PGupnzsljR4MmOFzakU5k5RdhumzXG37z5LrBCODEtka9Ft6eNXsbiPBQLT0s2CdB5
 8SVlK0PyrvUxL+NojUxJ2PAs+gMeCHMaqABC9fzmdpnPRgonQdyEMsgFO20RkemJG+Mr
 yAPlCwWJuNO8S9TDeyRZ+R6V6k8WCbxO6hFputUwnb2UF1BikHFIkP012AuiUFe9miui RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4q8ce5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 08:27:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9J8NDIu043324;
        Sat, 19 Oct 2019 08:27:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vqqmh7m3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 08:27:42 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9J8Rf8w020082;
        Sat, 19 Oct 2019 08:27:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Oct 2019 08:27:40 +0000
Date:   Sat, 19 Oct 2019 11:27:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendanhiggins@google.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v4] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191019082731.GM21344@kadam>
References: <20191018215549.65000-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018215549.65000-1-davidgow@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910190072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910190072
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 02:55:49PM -0700, David Gow wrote:
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
> ---
> 
> The changes from v3 are mostly to do with naming:
> - The Kconfig entry has been renamed from LIST_TEST to LIST_KUNIT_TEST,
>   which matches the SYSCTL_KUNIT_TEST entry,
> - The Kconfig description was updated to better match other KUnit tests,
>   specifying that the test is not intended for use in a production
>   kernel. A now-redundant mention of the test running a boot was
>   removed.
> - The MAINTAINERS entry refers to a "KUNIT TEST" rather than a "UNIT
>   TEST"
> - The module name has changed from "list-test" to "list-kunit-test".
> 
> Earlier versions of the test can be found:
> v3:
> https://lore.kernel.org/linux-kselftest/20191016215707.95317-1-davidgow@google.com/
> v2:
> https://lore.kernel.org/linux-kselftest/20191010185631.26541-1-davidgow@google.com/
> v1:
> https://lore.kernel.org/linux-kselftest/20191007213633.92565-1-davidgow@google.com/
> 
>  MAINTAINERS       |   5 +
>  lib/Kconfig.debug |  18 ++
>  lib/Makefile      |   3 +
>  lib/list-test.c   | 740 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 766 insertions(+)
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
> diff --git a/lib/Makefile b/lib/Makefile
> index bba1fd5485f7..890e581d00c4 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -292,3 +292,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) += objagg.o
> +
> +# KUnit tests
> +obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
> diff --git a/lib/list-test.c b/lib/list-test.c
> new file mode 100644
> index 000000000000..75ba3ddac959
> --- /dev/null
> +++ b/lib/list-test.c
> @@ -0,0 +1,740 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the Kernel Linked-list structures.
> + *
> + * Copyright (C) 2019, Google LLC.
> + * Author: David Gow <davidgow@google.com>
> + */
> +#include <kunit/test.h>
> +
> +#include <linux/list.h>
> +
> +struct list_test_struct {
> +	int data;
> +	struct list_head list;
> +};
> +
> +static void list_test_list_init(struct kunit *test)
> +{
> +	/* Test the different ways of initialising a list. */
> +	struct list_head list1 = LIST_HEAD_INIT(list1);
> +	struct list_head list2;
> +	LIST_HEAD(list3);
> +	struct list_head *list4;
> +	struct list_head *list5;
> +
> +	INIT_LIST_HEAD(&list2);
> +
> +	list4 = kzalloc(sizeof(*list4), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, list4);

Why not just use GFP_KERNEL | GFP_NOFAIL and remove the check?

kzalloc() can't return error pointers.  If this were an IS_ERR_OR_NULL()
check then it would generate a static checker warning, but static
checkers don't know about KUNIT_ASSERT_NOT_ERR_OR_NULL() yet so you're
safe.

But generally NULL is a special case of success.  A common situation is
where the user deliberately disables a feature, that means it's not an
error but we also don't have a valid pointer to return because it's
disabled.

regards,
dan carpenter

