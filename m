Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B433EF6A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 02:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhHRANE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Aug 2021 20:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhHRANC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Aug 2021 20:13:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC2C061796
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Aug 2021 17:12:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n200-20020a25d6d10000b02905935ac4154aso912370ybg.23
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Aug 2021 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=RvlRT/d0KRRmeshIggwU59tosJYpHrgSfIrmn/BlMZk=;
        b=J/btw2kBW8CCKgSWduzZ4yNDQ9jPCNg2xPl4jCpLAdyLiwH7QtHGV1y6kjLPOR4pVE
         ZDKjkdARZS8GmDTNnvP9LdXou+xjZuyTbyZJ3TuP5ICcsZkkW5Lr1qHUbtDSj4dhJzS7
         ooTKH9RNJpLv9wCBmNWPbwfMvnr4qNRJXMfHRkysKURa1BJZQjPIQgg39xXByf+jp+JF
         e1xsDX0mNvjkbpVXPm2eN3Uirkn3K3CJ0/qSGC0uZtA8TGlRNuSxpsGKtbnjhG+il1wB
         wct3FluI01m6+RJVx2rqioJ+HJcc4nTCOnqLLKsHdDDCHGUYHFL0GppeRXBvO0D++aBa
         W50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=RvlRT/d0KRRmeshIggwU59tosJYpHrgSfIrmn/BlMZk=;
        b=oxHx9cYgCwODWKVzZRh44zMYyNFEBwQm+pK64o2hyv9KwOOLiNOO2odq3Pt0UYRAaE
         4LtzYFEsFYMz+D5obtOl4tKzGisTYRS6vwr9pzsxsEDTg6jIk0kqEpqEfoQeu/saAv3w
         7Gq89MPSDrLEPaz6ZVZSNa3SiBhFTAmDoSkb9Y+i6iEWIXjVYtC2MDTtDMsMg2iq+mdq
         5SvBIev4hAyIjA+CZKbPa5/zMhZETeppTZUBz5taLqjAVd1H+UtYxjccXcranc7MGfry
         sFIgMCdx/EL9nUbXl4wNkFDO2kGR6pzFXsZH7t4Cu+h84vf/zhNIW0ElU+BCOl0t9Xy4
         oxdw==
X-Gm-Message-State: AOAM533uzPVZR6epCaZI7mABu1npQQWzu0p2ux/vX3jOv0BYngZkgd2w
        zDtygRfysxu4/8cp5tVTFM5WloameOA=
X-Google-Smtp-Source: ABdhPJygpO/HYN72sXYTpl6b7jRBgWVBum0X4WlFfzX7pr8xMRy0/Av5fz2lPwqaf0O3I2LLRev0nu5RwHI=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:158e:55a:74dd:5197])
 (user=seanjc job=sendgmr) by 2002:a25:a369:: with SMTP id d96mr7632412ybi.463.1629245547966;
 Tue, 17 Aug 2021 17:12:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 17 Aug 2021 17:12:07 -0700
In-Reply-To: <20210818001210.4073390-1-seanjc@google.com>
Message-Id: <20210818001210.4073390-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210818001210.4073390-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 2/5] entry: rseq: Call rseq_handle_notify_resume() in tracehook_notify_resume()
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm/kernel/signal.c     | 1 -
 arch/arm64/kernel/signal.c   | 1 -
 arch/csky/kernel/signal.c    | 4 +---
 arch/mips/kernel/signal.c    | 4 +---
 arch/powerpc/kernel/signal.c | 4 +---
 arch/s390/kernel/signal.c    | 1 -
 include/linux/tracehook.h    | 2 ++
 kernel/entry/common.c        | 4 +---
 kernel/entry/kvm.c           | 4 +---
 9 files changed, 7 insertions(+), 18 deletions(-)

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
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 78ef53b29958..b307db26bf2d 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -537,5 +537,4 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 void do_notify_resume(struct pt_regs *regs)
 {
 	tracehook_notify_resume(regs);
-	rseq_handle_notify_resume(NULL, regs);
 }
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
2.33.0.rc1.237.g0d66db33f3-goog

