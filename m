Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ADF3F5575
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 03:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHXBUp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 21:20:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:32082 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233487AbhHXBUm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 21:20:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="204408296"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="204408296"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 18:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="443630247"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2021 18:19:55 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 23 Aug 2021 18:19:54 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 24 Aug 2021 09:19:53 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.2242.010;
 Tue, 24 Aug 2021 09:19:53 +0800
From:   "Ma, XinjianX" <xinjianx.ma@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: [PATCH] ucounts: Fix regression preventing increasing of rlimits
 in init_user_ns
Thread-Topic: [PATCH] ucounts: Fix regression preventing increasing of rlimits
 in init_user_ns
Thread-Index: AQHXmGLx+8SQcsWA7kykjkjhccpFyquB2fCQ
Date:   Tue, 24 Aug 2021 01:19:52 +0000
Message-ID: <06bb27f1d79243febf9ddc4633c4e084@intel.com>
References: <d650b7794e264d5f8aa107644cc9784f@intel.com>
        <87a6lgysxp.fsf@disp2133>       <20210818131117.x7omzb2wkjq7le3s@example.org>
        <87o89ttqql.fsf@disp2133>       <20210819172618.qwrrw4m7wt33wfmz@example.org>
 <87eeajswfc.fsf_-_@disp2133>
In-Reply-To: <87eeajswfc.fsf_-_@disp2133>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.108.32.68]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Tuesday, August 24, 2021 5:07 AM
> To: Alexey Gladkov <legion@kernel.org>
> Cc: Ma, XinjianX <xinjianx.ma@intel.com>; linux-kselftest@vger.kernel.org;
> lkp <lkp@intel.com>; akpm@linux-foundation.org; axboe@kernel.dk;
> christian.brauner@ubuntu.com; containers@lists.linux-foundation.org;
> jannh@google.com; keescook@chromium.org; kernel-
> hardening@lists.openwall.com; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; oleg@redhat.com; torvalds@linux-foundation.org
> Subject: [PATCH] ucounts: Fix regression preventing increasing of rlimits in
> init_user_ns
> 
> 
> "Ma, XinjianX" <xinjianx.ma@intel.com> reported:
> 
> > When lkp team run kernel selftests, we found after these series of
> > patches, testcase mqueue: mq_perf_tests in kselftest failed with following
> message.
> >
> > # selftests: mqueue: mq_perf_tests
> > #
> > # Initial system state:
> > #       Using queue path:                       /mq_perf_tests
> > #       RLIMIT_MSGQUEUE(soft):                  819200
> > #       RLIMIT_MSGQUEUE(hard):                  819200
> > #       Maximum Message Size:                   8192
> > #       Maximum Queue Size:                     10
> > #       Nice value:                             0
> > #
> > # Adjusted system state for testing:
> > #       RLIMIT_MSGQUEUE(soft):                  (unlimited)
> > #       RLIMIT_MSGQUEUE(hard):                  (unlimited)
> > #       Maximum Message Size:                   16777216
> > #       Maximum Queue Size:                     65530
> > #       Nice value:                             -20
> > #       Continuous mode:                        (disabled)
> > #       CPUs to pin:                            3
> > # ./mq_perf_tests: mq_open() at 296: Too many open files not ok 2
> > selftests: mqueue: mq_perf_tests # exit=1 ```
> >
> > Test env:
> > rootfs: debian-10
> > gcc version: 9
> 
> After investigation the problem turned out to be that ucount_max for the
> rlimits in init_user_ns was being set to the initial rlimit value.
> The practical problem is that ucount_max provides a limit that applications
> inside the user namespace can not exceed.  Which means in practice that
> rlimits that have been converted to use the ucount infrastructure were not
> able to exceend their initial rlimits.
> 
> Solve this by setting the relevant values of ucount_max to RLIM_INIFINITY.  A
> limit in init_user_ns is pointless so the code should allow the values to grow
> as large as possible without riscking an underflow or an overflow.
> 
> As the ltp test case was a bit of a pain I have reproduced the rlimit failure and
> tested the fix with the following little C program:
> > #include <stdio.h>
> > #include <fcntl.h>
> > #include <sys/stat.h>
> > #include <mqueue.h>
> > #include <sys/time.h>
> > #include <sys/resource.h>
> > #include <errno.h>
> > #include <string.h>
> > #include <stdlib.h>
> > #include <limits.h>
> > #include <unistd.h>
> >
> > int main(int argc, char **argv)
> > {
> > 	struct mq_attr mq_attr;
> > 	struct rlimit rlim;
> > 	mqd_t mqd;
> > 	int ret;
> >
> > 	ret = getrlimit(RLIMIT_MSGQUEUE, &rlim);
> > 	if (ret != 0) {
> > 		fprintf(stderr, "getrlimit(RLIMIT_MSGQUEUE) failed: %s\n",
> strerror(errno));
> > 		exit(EXIT_FAILURE);
> > 	}
> > 	printf("RLIMIT_MSGQUEUE %lu %lu\n",
> > 	       rlim.rlim_cur, rlim.rlim_max);
> > 	rlim.rlim_cur = RLIM_INFINITY;
> > 	rlim.rlim_max = RLIM_INFINITY;
> > 	ret = setrlimit(RLIMIT_MSGQUEUE, &rlim);
> > 	if (ret != 0) {
> > 		fprintf(stderr, "setrlimit(RLIMIT_MSGQUEUE, RLIM_INFINITY)
> failed: %s\n", strerror(errno));
> > 		exit(EXIT_FAILURE);
> > 	}
> >
> > 	memset(&mq_attr, 0, sizeof(struct mq_attr));
> > 	mq_attr.mq_maxmsg = 65536 - 1;
> > 	mq_attr.mq_msgsize = 16*1024*1024 - 1;
> >
> > 	mqd = mq_open("/mq_rlimit_test", O_RDONLY|O_CREAT, 0600,
> &mq_attr);
> > 	if (mqd == (mqd_t)-1) {
> > 		fprintf(stderr, "mq_open failed: %s\n", strerror(errno));
> > 		exit(EXIT_FAILURE);
> > 	}
> > 	ret = mq_close(mqd);
> > 	if (ret) {
> > 		fprintf(stderr, "mq_close failed; %s\n", strerror(errno));
> > 		exit(EXIT_FAILURE);
> > 	}
> >
> > 	return EXIT_SUCCESS;
> > }
> 
> Fixes: 6e52a9f0532f ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
> Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
> Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
> Reported-by: kernel test robot lkp@intel.com
Sorry, but <> around email address is needed 
Reported-by: kernel test robot <lkp@intel.com>

> Acked-by: Alexey Gladkov <legion@kernel.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> This is a simplified version of my previous change that I have tested and will
> push out to linux-next and then to Linus shortly.
> 
>  kernel/fork.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c index bc94b2cc5995..44f4c2d83763
> 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -828,10 +828,10 @@ void __init fork_init(void)
>  	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
>  		init_user_ns.ucount_max[i] = max_threads/2;
> 
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,
> task_rlimit(&init_task, RLIMIT_NPROC));
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,
> task_rlimit(&init_task, RLIMIT_MSGQUEUE));
> -	set_rlimit_ucount_max(&init_user_ns,
> UCOUNT_RLIMIT_SIGPENDING, task_rlimit(&init_task, RLIMIT_SIGPENDING));
> -	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,
> task_rlimit(&init_task, RLIMIT_MEMLOCK));
> +	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,
> RLIM_INFINITY);
> +	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,
> RLIM_INFINITY);
> +	set_rlimit_ucount_max(&init_user_ns,
> UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
> +	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,
> RLIM_INFINITY);
> 
>  #ifdef CONFIG_VMAP_STACK
>  	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN,
> "fork:vm_stack_cache",
> --
> 2.20.1

