Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66D3FE3FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Sep 2021 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhIAUbh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Sep 2021 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhIAUbg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Sep 2021 16:31:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0BC061760
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Sep 2021 13:30:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso696099ybq.10
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Sep 2021 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=kixEwIb9gqW04gwAAeUnH/ecCVyWuRkL9QSYK7iSzQk=;
        b=vI3cqGN3v2ltfEVTsw8l2uRo5chArr25iXsE02pKsVchqSHX3JFwdJCKj6AY7eXama
         mND0TI9aNvGKRlJ+u0ATyJo6zfv/z91nwaLKErTznJjazUVaGT690x3Hmpk6XHnLBa+G
         JH7Io8acVqTGgPK08MIOcCpnPO2aUCiyEmdAi5l4jpwbS0fKi7N0RrQ9sVfanRlND87X
         hXjn2TmotG9V4F+x55ib2PCSGt8vDrvWR7zm2oYT/36lcg0kO7CFioODoVr/MEbRD7FG
         AVHD0fYrsuTMVYH20bQZwQJedG/CM2LYbmTU0fBZDFoW11qYPntlj/PQlpJuSqJL+y88
         65Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=kixEwIb9gqW04gwAAeUnH/ecCVyWuRkL9QSYK7iSzQk=;
        b=tugfA74ChvKz9JLYkoo5pa7d7fqPIBrkYly5wZMD7c+a5xaUv/ovA8wxTkGymM3kn5
         Wi+uX6pSt14YDk4pT8kNwtUOUAKOiBn8u8sTpiZUSTyRjHOkh0HdsbaP/yCZGqawFttO
         WuybfSt97hy7eHJo0FLnhWWDfYj99l+g4VSqg9nZJ0CNntaDWOJnoMr2r14BSq3wlo9D
         fbH5iONL+ATIuJZdamHWm2pmRnnwWEPZdDYSPamVItct7TccBtU3FEQAU5lBQWqE9Ufw
         5bx8gVI0ZUCFF8Qi464rzx9fK+L3XNJ/mXzg1V/jY07k3CRYOCVcsv3WgDJmcbpMViT7
         z6jg==
X-Gm-Message-State: AOAM5311N0a1eoG0UHpABqGq9iq577akO0azDkiwIWX6CzIRw3oyJQ6a
        gPoi20htK50c+Mi4kxoW6yFuE9zeJwM=
X-Google-Smtp-Source: ABdhPJxOy0/3eJr4hrzQ/lo98CzNq7Zzsb3SLqOc/F5UhI3VQK6ru+OrtaCwLB3GIsnL+0WVfa3UVtPABkI=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:9935:5a5e:c7b6:e649])
 (user=seanjc job=sendgmr) by 2002:a25:9c01:: with SMTP id c1mr1791237ybo.228.1630528238358;
 Wed, 01 Sep 2021 13:30:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  1 Sep 2021 13:30:26 -0700
In-Reply-To: <20210901203030.1292304-1-seanjc@google.com>
Message-Id: <20210901203030.1292304-2-seanjc@google.com>
Mime-Version: 1.0
References: <20210901203030.1292304-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 1/5] KVM: rseq: Update rseq when processing NOTIFY_RESUME
 on xfer to KVM guest
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
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
2.33.0.153.gba50c8fa24-goog

