Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54BF3FE409
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Sep 2021 22:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhIAUby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Sep 2021 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhIAUbj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Sep 2021 16:31:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725BFC061575
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Sep 2021 13:30:41 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so752993qko.16
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Sep 2021 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=giTQddjb7cpAi8wl/yB8ohJy2e3SP57iEZ0RPdTMiX4=;
        b=qo9DlRqJtCTPumjwlk5l4imqmY2ErZqq+GepqSOLQ2deYmIUPQU8+wH2lFcBni5wXt
         U+ddTYQjPT6c1EwwyBv7IvG3vgEK3bVShoj4DDagCGT557POKrDxuqRbrIhR78uRFr7M
         qY9arXK6NbeexZOqpGWhO+2RBPGzZsKbBVOAXt+E3ne/X4idqXekt4xUxj6u+2LVfScY
         jHJdAHps3YPjQZMRarQBDCDRE/cWd5qiXNWVflOcwRXIwRpJ/9O8+1TK8/Tlsyw3lYTK
         eEU2YTfNjIHMThTpZYfK/hpRIKhz7TwYvm1CLcJb6oa8Cp/oRNoLnj48pVoM9hMyWUSE
         hBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=giTQddjb7cpAi8wl/yB8ohJy2e3SP57iEZ0RPdTMiX4=;
        b=DTbUwHH8J73hGovQ+qR8uEmtX/Wyipuj3z8YajZc06uOoObAQcUDs7DYeNdXTAf9XZ
         2uXBKObDIcXlJwd+25OHUXB4rviROQUshH366bUDUKzOapZNgwsZIz0iOI/2hopTN4gV
         G9HVYQCqH0KGsHk8B4MUdiTp5qUl6WvKo8/JEBlI3KOq3P6HTX4nE43N3FLD+uhbsw8A
         OemsuJXp/tJsHUxD858Lj+NyfK2CvrHPrXSqRjMZzvTD9Idrqo1oVrAIveppPIBneCp7
         oF5ivYvpn8gFrvLmLAhWywjIuHCTLOmRrZxoPyUeyS19bBGlBQaTRVWEIr19A5s0GwNI
         eJWw==
X-Gm-Message-State: AOAM5332oWirnlXKD9dcQKejshTq/I3fKuQ0DND5HTYMZr3hITHTCJCS
        eGDqOn8cijeF84zPRxZjT96dJeY3MTs=
X-Google-Smtp-Source: ABdhPJw7wWnrrZv0Hl12fIkw1gDrfVuwJFEdAgJjEGSXg6Gnkm+HSf6HSTCwp1BJtHL2p/bM/JEZu4BNelM=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:9935:5a5e:c7b6:e649])
 (user=seanjc job=sendgmr) by 2002:a05:6214:312:: with SMTP id
 i18mr1625618qvu.48.1630528240555; Wed, 01 Sep 2021 13:30:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  1 Sep 2021 13:30:27 -0700
In-Reply-To: <20210901203030.1292304-1-seanjc@google.com>
Message-Id: <20210901203030.1292304-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210901203030.1292304-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 2/5] entry: rseq: Call rseq_handle_notify_resume() in tracehook_notify_resume()
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Invoke rseq_handle_notify_resume() from tracehook_notify_resume() now
that the two function are always called back-to-back by architectures
that have rseq.  The rseq helper is stubbed out for architectures that
don't support rseq, i.e. this is a nop across the board.

Note, tracehook_notify_resume() is horribly named and arguably does not
belong in tracehook.h as literally every line of code in it has nothing
to do with tracing.  But, that's been true since commit a42c6ded827d
("move key_repace_session_keyring() into tracehook_notify_resume()")
first usurped tracehook_notify_resume() back in 2012.  Punt cleaning that
mess up to future patches.

No functional change intended.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm/kernel/signal.c     | 1 -
 arch/arm64/kernel/signal.c   | 1 -
 arch/csky/kernel/signal.c    | 4 +---
 arch/mips/kernel/signal.c    | 4 +---
 arch/powerpc/kernel/signal.c | 4 +---
 include/linux/tracehook.h    | 2 ++
 kernel/entry/common.c        | 4 +---
 kernel/entry/kvm.c           | 4 +---
 8 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a3a38d0a4c85..9df68d139965 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -670,7 +670,6 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 				uprobe_notify_resume(regs);
 			} else {
 				tracehook_notify_resume(regs);
-				rseq_handle_notify_resume(NULL, regs);
 			}
 		}
 		local_irq_disable();
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 23036334f4dc..22b55db13da6 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -951,7 +951,6 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 
 			if (thread_flags & _TIF_NOTIFY_RESUME) {
 				tracehook_notify_resume(regs);
-				rseq_handle_notify_resume(NULL, regs);
 
 				/*
 				 * If we reschedule after checking the affinity
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 312f046d452d..bc4238b9f709 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -260,8 +260,6 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		do_signal(regs);
 
-	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+	if (thread_info_flags & _TIF_NOTIFY_RESUME)
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(NULL, regs);
-	}
 }
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index f1e985109da0..c9b2a75563e1 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -906,10 +906,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		do_signal(regs);
 
-	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+	if (thread_info_flags & _TIF_NOTIFY_RESUME)
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(NULL, regs);
-	}
 
 	user_enter();
 }
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index e600764a926c..b93b87df499d 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -293,10 +293,8 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 		do_signal(current);
 	}
 
-	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+	if (thread_info_flags & _TIF_NOTIFY_RESUME)
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(NULL, regs);
-	}
 }
 
 static unsigned long get_tm_stackpointer(struct task_struct *tsk)
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 3e80c4bc66f7..2564b7434b4d 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -197,6 +197,8 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 
 	mem_cgroup_handle_over_high();
 	blkcg_maybe_throttle_current();
+
+	rseq_handle_notify_resume(NULL, regs);
 }
 
 /*
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bf16395b9e13..d5a61d565ad5 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -171,10 +171,8 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			handle_signal_work(regs, ti_work);
 
-		if (ti_work & _TIF_NOTIFY_RESUME) {
+		if (ti_work & _TIF_NOTIFY_RESUME)
 			tracehook_notify_resume(regs);
-			rseq_handle_notify_resume(NULL, regs);
-		}
 
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 049fd06b4c3d..49972ee99aff 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -19,10 +19,8 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
 
-		if (ti_work & _TIF_NOTIFY_RESUME) {
+		if (ti_work & _TIF_NOTIFY_RESUME)
 			tracehook_notify_resume(NULL);
-			rseq_handle_notify_resume(NULL, NULL);
-		}
 
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
 		if (ret)
-- 
2.33.0.153.gba50c8fa24-goog

