Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4B43FF17
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhJ2PMK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 11:12:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38362 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJ2PMJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 11:12:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:44310)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgTVk-006xUw-G8; Fri, 29 Oct 2021 09:09:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:54384 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgTVh-004SCm-Ga; Fri, 29 Oct 2021 09:09:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <YXrN+Hnl9pSOsWlA@arighi-desktop> <202110280955.B18CB67@keescook>
        <878rydm56l.fsf@disp2133> <202110281136.5CE65399A7@keescook>
Date:   Fri, 29 Oct 2021 10:09:04 -0500
In-Reply-To: <202110281136.5CE65399A7@keescook> (Kees Cook's message of "Thu,
        28 Oct 2021 11:47:48 -0700")
Message-ID: <87k0hvkgvj.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mgTVh-004SCm-Ga;;;mid=<87k0hvkgvj.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/FEeRP4fHav6LdZxVWjjrMekdL2ZOhVZk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubLong,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1761 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 10 (0.6%), b_tie_ro: 9 (0.5%), parse: 0.85 (0.0%),
         extract_message_metadata: 10 (0.6%), get_uri_detail_list: 2.2 (0.1%),
        tests_pri_-1000: 17 (1.0%), tests_pri_-950: 2.7 (0.2%),
        tests_pri_-900: 1.87 (0.1%), tests_pri_-90: 397 (22.5%), check_bayes:
        395 (22.4%), b_tokenize: 12 (0.7%), b_tok_get_all: 10 (0.6%),
        b_comp_prob: 2.6 (0.1%), b_tok_touch_all: 365 (20.7%), b_finish: 1.46
        (0.1%), tests_pri_0: 1299 (73.8%), check_dkim_signature: 0.74 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 0.50 (0.0%), tests_pri_10:
        3.3 (0.2%), tests_pri_500: 16 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


As Andy pointed out that there are races between
force_sig_info_to_task and sigaction[1] when force_sig_info_task.  As
Kees discovered[2] ptrace is also able to change these signals.

In the case of seeccomp killing a process with a signal it is a
security violation to allow the signal to be caught or manipulated.

Solve this problem by introducing a new flag SA_IMMUTABLE that
prevents sigaction and ptrace from modifying these forced signals.
This flag is carefully made kernel internal so that no new ABI is
introduced.

Longer term I think this can be solved by guaranteeing short circuit
delivery of signals in this case.  Unfortunately reliable and
guaranteed short circuit delivery of these signals is still a ways off
from being implemented, tested, and merged.  So I have implemented a much
simpler alternative for now.

[1] https://lkml.kernel.org/r/b5d52d25-7bde-4030-a7b1-7c6f8ab90660@www.fastmail.com
[2] https://lkml.kernel.org/r/202110281136.5CE65399A7@keescook
Cc: stable@vger.kernel.org
Fixes: 307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I have tested this patch and this changed works for me to fix the issue.

I believe this closes all of the races that force_sig_info_to_task
has when sigdfl is specified.  So this should be enough for anything
that needs a guaranteed that userspace can not race with the kernel
is handled.

Can folks look this over and see if I missed something?
Thank you,
Eric


 include/linux/signal_types.h           | 3 +++
 include/uapi/asm-generic/signal-defs.h | 1 +
 kernel/signal.c                        | 8 +++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index 34cb28b8f16c..927f7c0e5bff 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -70,6 +70,9 @@ struct ksignal {
 	int sig;
 };
 
+/* Used to kill the race between sigaction and forced signals */
+#define SA_IMMUTABLE		0x008000000
+
 #ifndef __ARCH_UAPI_SA_FLAGS
 #ifdef SA_RESTORER
 #define __ARCH_UAPI_SA_FLAGS	SA_RESTORER
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index fe929e7b77ca..7572f2f46ee8 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -45,6 +45,7 @@
 #define SA_UNSUPPORTED	0x00000400
 #define SA_EXPOSE_TAGBITS	0x00000800
 /* 0x00010000 used on mips */
+/* 0x00800000 used for internal SA_IMMUTABLE */
 /* 0x01000000 used on x86 */
 /* 0x02000000 used on x86 */
 /*
diff --git a/kernel/signal.c b/kernel/signal.c
index 6a5e1802b9a2..056a107e3cbc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1336,6 +1336,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t, bool
 	blocked = sigismember(&t->blocked, sig);
 	if (blocked || ignored || sigdfl) {
 		action->sa.sa_handler = SIG_DFL;
+		action->sa.sa_flags |= SA_IMMUTABLE;
 		if (blocked) {
 			sigdelset(&t->blocked, sig);
 			recalc_sigpending_and_wake(t);
@@ -2760,7 +2761,8 @@ bool get_signal(struct ksignal *ksig)
 		if (!signr)
 			break; /* will return 0 */
 
-		if (unlikely(current->ptrace) && signr != SIGKILL) {
+		if (unlikely(current->ptrace) && (signr != SIGKILL) &&
+		    !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
 			signr = ptrace_signal(signr, &ksig->info);
 			if (!signr)
 				continue;
@@ -4110,6 +4112,10 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	k = &p->sighand->action[sig-1];
 
 	spin_lock_irq(&p->sighand->siglock);
+	if (k->sa.sa_flags & SA_IMMUTABLE) {
+		spin_unlock_irq(&p->sighand->siglock);
+		return -EINVAL;
+	}
 	if (oact)
 		*oact = *k;
 
-- 
2.20.1

