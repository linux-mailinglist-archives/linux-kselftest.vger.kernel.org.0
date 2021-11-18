Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743DE456556
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 23:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhKRWIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 17:08:09 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:53614 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKRWIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 17:08:09 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:33116)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpWl-00Duya-6Y; Thu, 18 Nov 2021 15:05:07 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:52894 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpWj-00Auvb-Ue; Thu, 18 Nov 2021 15:05:06 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
        <202111171049.3F9C5F1@keescook>
        <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
        <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
        <87k0h6334w.fsf@email.froward.int.ebiederm.org>
        <202111171341.41053845C3@keescook>
        <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
        <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
        <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
        <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
        <202111171728.D85A4E2571@keescook>
        <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
Date:   Thu, 18 Nov 2021 16:04:58 -0600
In-Reply-To: <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 18 Nov 2021 15:58:02 -0600")
Message-ID: <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnpWj-00Auvb-Ue;;;mid=<877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/G8oOihSXjjRKLIib4SU0fG4hFBG0x2jw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,T_TooManySym_02,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 514 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (0.9%), b_tie_ro: 3.3 (0.6%), parse: 1.26
        (0.2%), extract_message_metadata: 17 (3.4%), get_uri_detail_list: 3.1
        (0.6%), tests_pri_-1000: 13 (2.4%), tests_pri_-950: 1.09 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 100 (19.4%), check_bayes:
        89 (17.2%), b_tokenize: 9 (1.8%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 63 (12.2%), b_finish: 0.73
        (0.1%), tests_pri_0: 366 (71.1%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 4.7 (0.9%), poll_dns_idle: 0.02 (0.0%), tests_pri_10:
        1.73 (0.3%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/2] signal: Don't always set SA_IMMUTABLE for forced signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Recently to prevent issues with SECCOMP_RET_KILL and similar signals
being changed before they are delivered SA_IMMUTABLE was added.

Unfortunately this broke debuggers[1][2] which reasonably expect to be
able to trap synchronous SIGTRAP and SIGSEGV even when the target
process is not configured to handle those signals.

Update force_sig_to_task to support both the case when we can
allow the debugger to intercept and possibly ignore the
signal and the case when it is not safe to let userspace
known about the signal until the process has exited.

Reported-by: Kyle Huey <me@kylehuey.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Cc: stable@vger.kernel.org
[1] https://lkml.kernel.org/r/CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com
[2] https://lkml.kernel.org/r/20211117150258.GB5403@xsang-OptiPlex-902
Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7c4b7ae714d4..02058c983bd6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1298,6 +1298,12 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
 	return ret;
 }
 
+enum sig_handler {
+	HANDLER_CURRENT, /* If reachable use the current handler */
+	HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
+	HANDLER_EXIT,	 /* Only visible as the proces exit code */
+};
+
 /*
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
@@ -1310,7 +1316,8 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
  * that is why we also clear SIGNAL_UNKILLABLE.
  */
 static int
-force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool sigdfl)
+force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
+	enum sig_handler handler)
 {
 	unsigned long int flags;
 	int ret, blocked, ignored;
@@ -1321,9 +1328,10 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
 	action = &t->sighand->action[sig-1];
 	ignored = action->sa.sa_handler == SIG_IGN;
 	blocked = sigismember(&t->blocked, sig);
-	if (blocked || ignored || sigdfl) {
+	if (blocked || ignored || (handler != HANDLER_CURRENT)) {
 		action->sa.sa_handler = SIG_DFL;
-		action->sa.sa_flags |= SA_IMMUTABLE;
+		if (handler == HANDLER_EXIT)
+			action->sa.sa_flags |= SA_IMMUTABLE;
 		if (blocked) {
 			sigdelset(&t->blocked, sig);
 			recalc_sigpending_and_wake(t);
@@ -1343,7 +1351,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
 
 int force_sig_info(struct kernel_siginfo *info)
 {
-	return force_sig_info_to_task(info, current, false);
+	return force_sig_info_to_task(info, current, HANDLER_CURRENT);
 }
 
 /*
@@ -1660,7 +1668,7 @@ void force_fatal_sig(int sig)
 	info.si_code = SI_KERNEL;
 	info.si_pid = 0;
 	info.si_uid = 0;
-	force_sig_info_to_task(&info, current, true);
+	force_sig_info_to_task(&info, current, HANDLER_SIG_DFL);
 }
 
 /*
@@ -1693,7 +1701,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
 	info.si_flags = flags;
 	info.si_isr = isr;
 #endif
-	return force_sig_info_to_task(&info, t, false);
+	return force_sig_info_to_task(&info, t, HANDLER_CURRENT);
 }
 
 int force_sig_fault(int sig, int code, void __user *addr
@@ -1813,7 +1821,8 @@ int force_sig_seccomp(int syscall, int reason, bool force_coredump)
 	info.si_errno = reason;
 	info.si_arch = syscall_get_arch(current);
 	info.si_syscall = syscall;
-	return force_sig_info_to_task(&info, current, force_coredump);
+	return force_sig_info_to_task(&info, current,
+		force_coredump ? HANDLER_EXIT : HANDLER_CURRENT);
 }
 
 /* For the crazy architectures that include trap information in
-- 
2.20.1
