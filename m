Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A1456559
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 23:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhKRWIo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 17:08:44 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39486 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKRWIn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 17:08:43 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38218)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpXK-00E39T-6Z; Thu, 18 Nov 2021 15:05:42 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:52906 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpXH-00Av0p-Bt; Thu, 18 Nov 2021 15:05:41 -0700
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
Date:   Thu, 18 Nov 2021 16:05:31 -0600
In-Reply-To: <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 18 Nov 2021 15:58:02 -0600")
Message-ID: <871r3dqfv8.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnpXH-00Av0p-Bt;;;mid=<871r3dqfv8.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ee9ZQZjXSCESInoDhJZjCrjsKA+I5xtg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,T_TooManySym_01,
        XMNoVowels,XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4985]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2240 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.2%), b_tie_ro: 3.2 (0.1%), parse: 1.57
        (0.1%), extract_message_metadata: 19 (0.8%), get_uri_detail_list: 5.0
        (0.2%), tests_pri_-1000: 23 (1.0%), tests_pri_-950: 1.10 (0.0%),
        tests_pri_-900: 0.86 (0.0%), tests_pri_-90: 591 (26.4%), check_bayes:
        590 (26.3%), b_tokenize: 15 (0.7%), b_tok_get_all: 155 (6.9%),
        b_comp_prob: 3.4 (0.2%), b_tok_touch_all: 413 (18.4%), b_finish: 0.75
        (0.0%), tests_pri_0: 1587 (70.9%), check_dkim_signature: 0.50 (0.0%),
        check_dkim_adsp: 1.93 (0.1%), poll_dns_idle: 0.48 (0.0%),
        tests_pri_10: 1.81 (0.1%), tests_pri_500: 6 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 2/2] signal: Replace force_fatal_sig with force_exit_sig when in doubt
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Recently to prevent issues with SECCOMP_RET_KILL and similar signals
being changed before they are delivered SA_IMMUTABLE was added.

Unfortunately this broke debuggers[1][2] which reasonably expect
to be able to trap synchronous SIGTRAP and SIGSEGV even when
the target process is not configured to handle those signals.

Add force_exit_sig and use it instead of force_fatal_sig where
historically the code has directly called do_exit.  This has the
implementation benefits of going through the signal exit path
(including generating core dumps) without the danger of allowing
userspace to ignore or change these signals.

This avoids userspace regressions as older kernels exited with do_exit
which debuggers also can not intercept.

In the future is should be possible to improve the quality of
implementation of the kernel by changing some of these force_exit_sig
calls to force_fatal_sig.  That can be done where it matters on
a case-by-case basis with careful analysis.

Reported-by: Kyle Huey <me@kylehuey.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
[1] https://lkml.kernel.org/r/CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com
[2] https://lkml.kernel.org/r/20211117150258.GB5403@xsang-OptiPlex-902
Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed")
Fixes: a3616a3c0272 ("signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die")
Fixes: 83a1f27ad773 ("signal/powerpc: On swapcontext failure force SIGSEGV")
Fixes: 9bc508cf0791 ("signal/s390: Use force_sigsegv in default_trap_handler")
Fixes: 086ec444f866 ("signal/sparc32: In setup_rt_frame and setup_fram use force_fatal_sig")
Fixes: c317d306d550 ("signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails")
Fixes: 695dd0d634df ("signal/x86: In emulate_vsyscall force a signal instead of calling do_exit")
Fixes: 1fbd60df8a85 ("signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.")
Fixes: 941edc5bf174 ("exit/syscall_user_dispatch: Send ordinary signals on failure")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/m68k/kernel/traps.c              |  2 +-
 arch/powerpc/kernel/signal_32.c       |  2 +-
 arch/powerpc/kernel/signal_64.c       |  4 ++--
 arch/s390/kernel/traps.c              |  2 +-
 arch/sparc/kernel/signal_32.c         |  4 ++--
 arch/sparc/kernel/windows.c           |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/kernel/vm86_32.c             |  2 +-
 include/linux/sched/signal.h          |  1 +
 kernel/entry/syscall_user_dispatch.c  |  4 ++--
 kernel/signal.c                       | 13 +++++++++++++
 11 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 99058a6da956..34d6458340b0 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1145,7 +1145,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	force_fatal_sig(SIGSEGV);
+	force_exit_sig(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 00a9c9cd6d42..3e053e2fd6b6 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1063,7 +1063,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 	if (do_setcontext(new_ctx, regs, 0)) {
-		force_fatal_sig(SIGSEGV);
+		force_exit_sig(SIGSEGV);
 		return -EFAULT;
 	}
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index ef518535d436..d1e1fc0acbea 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -704,7 +704,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 */
 
 	if (__get_user_sigset(&set, &new_ctx->uc_sigmask)) {
-		force_fatal_sig(SIGSEGV);
+		force_exit_sig(SIGSEGV);
 		return -EFAULT;
 	}
 	set_current_blocked(&set);
@@ -713,7 +713,7 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 		return -EFAULT;
 	if (__unsafe_restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext)) {
 		user_read_access_end();
-		force_fatal_sig(SIGSEGV);
+		force_exit_sig(SIGSEGV);
 		return -EFAULT;
 	}
 	user_read_access_end();
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 035705c9f23e..2b780786fc68 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		report_user_fault(regs, SIGSEGV, 0);
-		force_fatal_sig(SIGSEGV);
+		force_exit_sig(SIGSEGV);
 	} else
 		die(regs, "Unknown program exception");
 }
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index cd677bc564a7..ffab16369bea 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -244,7 +244,7 @@ static int setup_frame(struct ksignal *ksig, struct pt_regs *regs,
 		get_sigframe(ksig, regs, sigframe_size);
 
 	if (invalid_frame_pointer(sf, sigframe_size)) {
-		force_fatal_sig(SIGILL);
+		force_exit_sig(SIGILL);
 		return -EINVAL;
 	}
 
@@ -336,7 +336,7 @@ static int setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs,
 	sf = (struct rt_signal_frame __user *)
 		get_sigframe(ksig, regs, sigframe_size);
 	if (invalid_frame_pointer(sf, sigframe_size)) {
-		force_fatal_sig(SIGILL);
+		force_exit_sig(SIGILL);
 		return -EINVAL;
 	}
 
diff --git a/arch/sparc/kernel/windows.c b/arch/sparc/kernel/windows.c
index bbbd40cc6b28..8f20862ccc83 100644
--- a/arch/sparc/kernel/windows.c
+++ b/arch/sparc/kernel/windows.c
@@ -122,7 +122,7 @@ void try_to_clear_window_buffer(struct pt_regs *regs, int who)
 		if ((sp & 7) ||
 		    copy_to_user((char __user *) sp, &tp->reg_window[window],
 				 sizeof(struct reg_window32))) {
-			force_fatal_sig(SIGILL);
+			force_exit_sig(SIGILL);
 			return;
 		}
 	}
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 0b6b277ee050..fd2ee9408e91 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -226,7 +226,7 @@ bool emulate_vsyscall(unsigned long error_code,
 	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
 		warn_bad_vsyscall(KERN_DEBUG, regs,
 				  "seccomp tried to change syscall nr or ip");
-		force_fatal_sig(SIGSYS);
+		force_exit_sig(SIGSYS);
 		return true;
 	}
 	regs->orig_ax = -1;
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index cce1c89cb7df..c21bcd668284 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -160,7 +160,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	user_access_end();
 Efault:
 	pr_alert("could not access userspace vm86 info\n");
-	force_fatal_sig(SIGSEGV);
+	force_exit_sig(SIGSEGV);
 	goto exit_vm86;
 }
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 23505394ef70..33a50642cf41 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -352,6 +352,7 @@ extern __must_check bool do_notify_parent(struct task_struct *, int);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
 extern void force_sig(int);
 extern void force_fatal_sig(int);
+extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 4508201847d2..0b6379adff6b 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -48,7 +48,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 		 * the selector is loaded by userspace.
 		 */
 		if (unlikely(__get_user(state, sd->selector))) {
-			force_fatal_sig(SIGSEGV);
+			force_exit_sig(SIGSEGV);
 			return true;
 		}
 
@@ -56,7 +56,7 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 			return false;
 
 		if (state != SYSCALL_DISPATCH_FILTER_BLOCK) {
-			force_fatal_sig(SIGSYS);
+			force_exit_sig(SIGSYS);
 			return true;
 		}
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index 02058c983bd6..fe7ba05145d4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1671,6 +1671,19 @@ void force_fatal_sig(int sig)
 	force_sig_info_to_task(&info, current, HANDLER_SIG_DFL);
 }
 
+void force_exit_sig(int sig)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_KERNEL;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	force_sig_info_to_task(&info, current, HANDLER_EXIT);
+}
+
 /*
  * When things go south during signal handling, we
  * will force a SIGSEGV. And if the signal that caused
-- 
2.20.1

