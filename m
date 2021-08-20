Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8603F36B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHTWvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 18:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbhHTWvG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 18:51:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66858C061764
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z2-20020a5b0b02000000b005982be23a34so4538176ybp.19
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xP5ox9LWixjADMi17y3ZCQWo2erbBD1sONNzP8xurzE=;
        b=tXEUDIokv3wviiIHm0X1lfehl+7Wj+ai//AARTsEaN1rF/g+qgM0jkaL/67dfoLObd
         /VWDG94O6zohRyVJlvMoTwUthibKrCCzBDD8tEzYMgjHRfEGVjY26UAk17M/80W7qzcE
         +Dq6sPv3FDU89mJYh9+ekPU+ZZa3f2B3pNThMlV8S4zT3EvIZxmmzYeWWw8fAdOZ8aZX
         q/F5fTOs74/65WVjg0ebVGJBUIa2l+SoX8BfH6txrP6bpbe0aTcWGU0L3LUv9MLl2D19
         ODvhLnuYaGHH2tXSnKzKsh4myYkskgOnODjtxOKRgiVifadLsUQoTyf21e4iRZ975FFi
         gx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xP5ox9LWixjADMi17y3ZCQWo2erbBD1sONNzP8xurzE=;
        b=bw+/ExsHUAtLknLYQlNsczYTjHK9C/DjY3b403/kRO1eC2rjL0NC7yxXQVWAX05tiZ
         Arc1kCVOQxGH+Lxn6LteRD00Rx2avCtBSsr/JKJzSENCnzH7YI5kzyt4Q2m43YT18bda
         Ez/7b0UEf418YcXpwHPn0odk6hjq23m1bjtbBXKELup5yQg9/BHNHSz/mNj0tYXmbDOS
         9r4fjcTw9oK7gEEBB6hjAjesYDVm38yT5lKOZdwPZxfcRklTG3fmwG/aFH9st72+kqCG
         VHENXzpe8dvqqGtl0QeeDzPDPSIphs3ckedYhSROd5jbGnqXFAg2jZQUOaugsfZtbcGJ
         F+dQ==
X-Gm-Message-State: AOAM531FN3KgTfFiY4TuQc3C0MLy8sZ+gb4psC/uNSSEgRB1wC0Oc0lo
        zEam72C50UUPTQW/dAVQRDJVRejiLWg=
X-Google-Smtp-Source: ABdhPJzpWT+3ES5mMOXB298qwmvmgMpVNnMXVRiYwkdnjiampjGDXa11mhNSWVVNLuqYYUep/90t+CL+4oo=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a25:ad18:: with SMTP id y24mr28951064ybi.50.1629499826546;
 Fri, 20 Aug 2021 15:50:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:49:58 -0700
In-Reply-To: <20210820225002.310652-1-seanjc@google.com>
Message-Id: <20210820225002.310652-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 1/5] KVM: rseq: Update rseq when processing NOTIFY_RESUME
 on xfer to KVM guest
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
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

Invoke rseq's NOTIFY_RESUME handler when processing the flag prior to
transferring to a KVM guest, which is roughly equivalent to an exit to
userspace and processes many of the same pending actions.  While the task
cannot be in an rseq critical section as the KVM path is reachable only
by via ioctl(KVM_RUN), the side effects that apply to rseq outside of a
critical section still apply, e.g. the current CPU needs to be updated if
the task is migrated.

Clearing TIF_NOTIFY_RESUME without informing rseq can lead to segfaults
and other badness in userspace VMMs that use rseq in combination with KVM,
e.g. due to the CPU ID being stale after task migration.

Fixes: 72c3c0fe54a3 ("x86/kvm: Use generic xfer to guest work function")
Reported-by: Peter Foley <pefoley@google.com>
Bisected-by: Doug Evans <dje@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/entry/kvm.c |  4 +++-
 kernel/rseq.c      | 14 +++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 49972ee99aff..049fd06b4c3d 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -19,8 +19,10 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
 
-		if (ti_work & _TIF_NOTIFY_RESUME)
+		if (ti_work & _TIF_NOTIFY_RESUME) {
 			tracehook_notify_resume(NULL);
+			rseq_handle_notify_resume(NULL, NULL);
+		}
 
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
 		if (ret)
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 35f7bd0fced0..6d45ac3dae7f 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -282,9 +282,17 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
-	ret = rseq_ip_fixup(regs);
-	if (unlikely(ret < 0))
-		goto error;
+
+	/*
+	 * regs is NULL if and only if the caller is in a syscall path.  Skip
+	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
+	 * kill a misbehaving userspace on debug kernels.
+	 */
+	if (regs) {
+		ret = rseq_ip_fixup(regs);
+		if (unlikely(ret < 0))
+			goto error;
+	}
 	if (unlikely(rseq_update_cpu_id(t)))
 		goto error;
 	return;
-- 
2.33.0.rc2.250.ged5fa647cd-goog

