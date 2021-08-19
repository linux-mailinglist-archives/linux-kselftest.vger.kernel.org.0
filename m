Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1203A3F1C49
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbhHSPLO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 11:11:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49282 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbhHSPLN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 11:11:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:58660)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mGjgh-000qyp-A5; Thu, 19 Aug 2021 09:10:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53670 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mGjgf-00B3f5-1i; Thu, 19 Aug 2021 09:10:34 -0600
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
Date:   Thu, 19 Aug 2021 10:10:26 -0500
In-Reply-To: <20210818131117.x7omzb2wkjq7le3s@example.org> (Alexey Gladkov's
        message of "Wed, 18 Aug 2021 15:11:17 +0200")
Message-ID: <87o89ttqql.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mGjgf-00B3f5-1i;;;mid=<87o89ttqql.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+FJyKRYLudFvOu6Oz0NG+8QSd5IgBNsjA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4973]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1658 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.2%), b_tie_ro: 2.6 (0.2%), parse: 0.69
        (0.0%), extract_message_metadata: 9 (0.5%), get_uri_detail_list: 1.62
        (0.1%), tests_pri_-1000: 12 (0.7%), tests_pri_-950: 1.01 (0.1%),
        tests_pri_-900: 0.83 (0.0%), tests_pri_-90: 188 (11.3%), check_bayes:
        187 (11.3%), b_tokenize: 7 (0.4%), b_tok_get_all: 34 (2.1%),
        b_comp_prob: 1.71 (0.1%), b_tok_touch_all: 141 (8.5%), b_finish: 0.65
        (0.0%), tests_pri_0: 1429 (86.2%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 1.78 (0.1%), tests_pri_10:
        2.8 (0.2%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v11 5/9] Reimplement RLIMIT_MSGQUEUE on top of ucounts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> On Tue, Aug 17, 2021 at 10:47:14AM -0500, Eric W. Biederman wrote:
>> "Ma, XinjianX" <xinjianx.ma@intel.com> writes:
>> 
>> > Hi Alexey,
>> >
>> > When lkp team run kernel selftests, we found after these series of patches, testcase mqueue: mq_perf_tests
>> > in kselftest failed with following message.
>> 
>> Which kernel was this run against?
>> 
>> Where can the mq_perf_tests that you ran and had problems with be found?
>> 
>> During your run were you using user namespaces as part of your test
>> environment?
>> 
>> The error message too many files corresponds to the error code EMFILES
>> which is the error code that is returned when the rlimit is reached.
>> 
>> One possibility is that your test environment was run in a user
>> namespace and so you wound up limited by rlimit of the user who created
>> the user namespace at the point of user namespace creation. 
>> 
>> At this point if you can give us enough information to look into this
>> and attempt to reproduce it that would be appreciated.
>
> I was able to reproduce it on master without using user namespace.
> I suspect that the maximum value is not assigned here [1]:
>
> set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE, task_rlimit(&init_task, RLIMIT_MSGQUEUE));
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c#n832

The rlimits for init_task are set to INIT_RLIMITS.
In INIT_RLIMITS RLIMIT_MSGQUEUE is set to MQ_MAX_BYTES

So that definitely means that as the code is current constructed the
rlimit can not be effectively raised.

So it looks like we are just silly and preventing the initial rlimits
from being raised.

So we probably want to do something like:

diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2cc5995..557ce0083ba3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -825,13 +825,13 @@ void __init fork_init(void)
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
+	/* For non-rlimit ucounts make their default limit max_threads/2 */
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC, task_rlimit(&init_task, RLIMIT_NPROC));
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE, task_rlimit(&init_task, RLIMIT_MSGQUEUE));
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, task_rlimit(&init_task, RLIMIT_SIGPENDING));
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK, task_rlimit(&init_task, RLIMIT_MEMLOCK));
+	/* In init_user_ns default rlimit to be the only limit */
+	for (; i < UCOUNT_COUNTS; i++)
+		set_rlimit_ucount_max(&init_user_ns, i, RLIMIT_INFINITY);
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",


Eric
