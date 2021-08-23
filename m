Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2A3F528D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Aug 2021 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhHWVIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 17:08:36 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44824 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVIg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 17:08:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:37246)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIHAd-007Ra7-7u; Mon, 23 Aug 2021 15:07:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36560 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIHAb-003Zot-KN; Mon, 23 Aug 2021 15:07:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Ma\, XinjianX" <xinjianx.ma@intel.com>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "christian.brauner\@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "jannh\@google.com" <jannh@google.com>,
        "keescook\@chromium.org" <keescook@chromium.org>,
        "kernel-hardening\@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "oleg\@redhat.com" <oleg@redhat.com>,
        "torvalds\@linux-foundation.org" <torvalds@linux-foundation.org>
References: <d650b7794e264d5f8aa107644cc9784f@intel.com>
        <87a6lgysxp.fsf@disp2133>
        <20210818131117.x7omzb2wkjq7le3s@example.org>
        <87o89ttqql.fsf@disp2133>
        <20210819172618.qwrrw4m7wt33wfmz@example.org>
Date:   Mon, 23 Aug 2021 16:06:31 -0500
In-Reply-To: <20210819172618.qwrrw4m7wt33wfmz@example.org> (Alexey Gladkov's
        message of "Thu, 19 Aug 2021 19:26:18 +0200")
Message-ID: <87eeajswfc.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mIHAb-003Zot-KN;;;mid=<87eeajswfc.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19pToonl64FWbIbj8aFLkyc+Dgo1JmkbVU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4960]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1026 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 14 (1.3%), b_tie_ro: 11 (1.1%), parse: 2.3 (0.2%),
         extract_message_metadata: 28 (2.7%), get_uri_detail_list: 5 (0.5%),
        tests_pri_-1000: 36 (3.5%), tests_pri_-950: 1.72 (0.2%),
        tests_pri_-900: 1.30 (0.1%), tests_pri_-90: 369 (36.0%), check_bayes:
        367 (35.7%), b_tokenize: 16 (1.5%), b_tok_get_all: 13 (1.2%),
        b_comp_prob: 4.3 (0.4%), b_tok_touch_all: 330 (32.1%), b_finish: 1.24
        (0.1%), tests_pri_0: 553 (53.9%), check_dkim_signature: 1.06 (0.1%),
        check_dkim_adsp: 3.5 (0.3%), poll_dns_idle: 0.88 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 13 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] ucounts: Fix regression preventing increasing of rlimits in init_user_ns
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


"Ma, XinjianX" <xinjianx.ma@intel.com> reported:

> When lkp team run kernel selftests, we found after these series of patches, testcase mqueue: mq_perf_tests
> in kselftest failed with following message.
>
> # selftests: mqueue: mq_perf_tests
> #
> # Initial system state:
> #       Using queue path:                       /mq_perf_tests
> #       RLIMIT_MSGQUEUE(soft):                  819200
> #       RLIMIT_MSGQUEUE(hard):                  819200
> #       Maximum Message Size:                   8192
> #       Maximum Queue Size:                     10
> #       Nice value:                             0
> #
> # Adjusted system state for testing:
> #       RLIMIT_MSGQUEUE(soft):                  (unlimited)
> #       RLIMIT_MSGQUEUE(hard):                  (unlimited)
> #       Maximum Message Size:                   16777216
> #       Maximum Queue Size:                     65530
> #       Nice value:                             -20
> #       Continuous mode:                        (disabled)
> #       CPUs to pin:                            3
> # ./mq_perf_tests: mq_open() at 296: Too many open files
> not ok 2 selftests: mqueue: mq_perf_tests # exit=1
> ```
>
> Test env:
> rootfs: debian-10
> gcc version: 9

After investigation the problem turned out to be that ucount_max for
the rlimits in init_user_ns was being set to the initial rlimit value.
The practical problem is that ucount_max provides a limit that
applications inside the user namespace can not exceed.  Which means in
practice that rlimits that have been converted to use the ucount
infrastructure were not able to exceend their initial rlimits.

Solve this by setting the relevant values of ucount_max to
RLIM_INIFINITY.  A limit in init_user_ns is pointless so the code
should allow the values to grow as large as possible without riscking
an underflow or an overflow.

As the ltp test case was a bit of a pain I have reproduced the rlimit failure
and tested the fix with the following little C program:
> #include <stdio.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> #include <mqueue.h>
> #include <sys/time.h>
> #include <sys/resource.h>
> #include <errno.h>
> #include <string.h>
> #include <stdlib.h>
> #include <limits.h>
> #include <unistd.h>
>
> int main(int argc, char **argv)
> {
> 	struct mq_attr mq_attr;
> 	struct rlimit rlim;
> 	mqd_t mqd;
> 	int ret;
>
> 	ret = getrlimit(RLIMIT_MSGQUEUE, &rlim);
> 	if (ret != 0) {
> 		fprintf(stderr, "getrlimit(RLIMIT_MSGQUEUE) failed: %s\n", strerror(errno));
> 		exit(EXIT_FAILURE);
> 	}
> 	printf("RLIMIT_MSGQUEUE %lu %lu\n",
> 	       rlim.rlim_cur, rlim.rlim_max);
> 	rlim.rlim_cur = RLIM_INFINITY;
> 	rlim.rlim_max = RLIM_INFINITY;
> 	ret = setrlimit(RLIMIT_MSGQUEUE, &rlim);
> 	if (ret != 0) {
> 		fprintf(stderr, "setrlimit(RLIMIT_MSGQUEUE, RLIM_INFINITY) failed: %s\n", strerror(errno));
> 		exit(EXIT_FAILURE);
> 	}
>
> 	memset(&mq_attr, 0, sizeof(struct mq_attr));
> 	mq_attr.mq_maxmsg = 65536 - 1;
> 	mq_attr.mq_msgsize = 16*1024*1024 - 1;
>
> 	mqd = mq_open("/mq_rlimit_test", O_RDONLY|O_CREAT, 0600, &mq_attr);
> 	if (mqd == (mqd_t)-1) {
> 		fprintf(stderr, "mq_open failed: %s\n", strerror(errno));
> 		exit(EXIT_FAILURE);
> 	}
> 	ret = mq_close(mqd);
> 	if (ret) {
> 		fprintf(stderr, "mq_close failed; %s\n", strerror(errno));
> 		exit(EXIT_FAILURE);
> 	}
>
> 	return EXIT_SUCCESS;
> }

Fixes: 6e52a9f0532f ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Reported-by: kernel test robot lkp@intel.com
Acked-by: Alexey Gladkov <legion@kernel.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

This is a simplified version of my previous change that I have tested
and will push out to linux-next and then to Linus shortly.

 kernel/fork.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2cc5995..44f4c2d83763 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -828,10 +828,10 @@ void __init fork_init(void)
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC, task_rlimit(&init_task, RLIMIT_NPROC));
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE, task_rlimit(&init_task, RLIMIT_MSGQUEUE));
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, task_rlimit(&init_task, RLIMIT_SIGPENDING));
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK, task_rlimit(&init_task, RLIMIT_MEMLOCK));
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
+	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
-- 
2.20.1

