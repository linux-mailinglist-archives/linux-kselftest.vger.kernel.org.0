Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBCEF31A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2019 02:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfKEB7F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 20:59:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43764 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729987AbfKEB7F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 20:59:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id a18so7439877plm.10
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2019 17:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uB6oddDs4B5MJUkexIrktz0z9v6D2XtXOnfbRUzfnas=;
        b=JfPVSDAMfTA2eMXc/IL3xyiHo3mb7M/6Zkl0ebPXOqVQUX1Z6N9HPojRpc10M8MJ5e
         BrqyyOCA84XGdHYx8nMTpWIOZB1q1SkEb99dm08S8uYonB1HpRaeL64CPpN6pW5vt5R5
         WAWuvQEWuLhK9EMmM0M8OHvrANih4vMeO+NMz1oEGVm2hdjAwdhLGeAUEFew5NT/pExL
         SXct7bQ4YHmc8TKg12jqs44pidAteVYINOXxGeaggGl/s++jHp5ijZiT0AvyGa4KRg76
         A7ZFtxyGZsCofHCgKds9wForYwWutoVdffuzG55r1RgbUUDe0N6rUiV5xxtNgmN2AOBM
         5iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uB6oddDs4B5MJUkexIrktz0z9v6D2XtXOnfbRUzfnas=;
        b=V9rvy6ibyvXsUmG9FEIqvz4HQ8EzFTh0+qcOrO2sy5t/gZlUOyAD3AT66reWk0U6wd
         e35pQ6zyMh8swWKIf2bOG2SPkgcu6X9/DG21GIG7GqC4Zu11LNmyjy71CuDgP8NkQu8H
         BMPCKphQSNA3Vol+3enzbbBMMShtcdo37vqaxwXgQjO37POp/6fStGo6PYfDs7SV0XyC
         oVQc+/K6Z4FoywZnMRXZ6ZVpceRyaKxBtgxJUjvRs3/KCpbHDPB1HrTjpLURSqWomgOZ
         FPC8uRcuie8DgunxN+7/pnO1mCxv7HcW3y0+o+wsSqNzDk5CxFH7LkvjpTrSBMnRQfi1
         evng==
X-Gm-Message-State: APjAAAVagL8UHN1sNuAw9L8WPs3OD3vD9imvekhdM1ELGa1vDC07FOu+
        NrjwzHUT939j7y/wPKonXPHxIA==
X-Google-Smtp-Source: APXvYqwj2vCMWOZqVejxLCFtTPImCwciXJJhVXdprxtdj6wBJEQXejbBfy5C/bGV8Je3oDYo5g5ZRw==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr30306290pla.81.1572919144304;
        Mon, 04 Nov 2019 17:59:04 -0800 (PST)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id j6sm16484444pfa.124.2019.11.04.17.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 17:59:03 -0800 (PST)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, mathieu.desnoyers@efficios.com
Cc:     linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        vincent.chen@sifive.com
Subject: [PATCH 2/3] riscv: Add support for restartable sequence
Date:   Tue,  5 Nov 2019 09:58:33 +0800
Message-Id: <1572919114-3886-3-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
References: <1572919114-3886-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add calls to rseq_signal_deliver(), rseq_handle_notify_resume() and
rseq_syscall() to introduce RSEQ support.

1. Call the rseq_handle_notify_resume() function on return to userspace
   if TIF_NOTIFY_RESUME thread flag is set.

2. Call the rseq_signal_deliver() function to fixup on the pre-signal
   frame when a signal is delivered on top of a restartable sequence
   critical section.

3. Check that system calls are not invoked from within rseq critical
   sections by invoking rseq_signal() from ret_from_syscall(). With
   CONFIG_DEBUG_RSEQ, such behavior results in termination of the
   process with SIGSEGV.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/Kconfig         | 1 +
 arch/riscv/kernel/entry.S  | 4 ++++
 arch/riscv/kernel/signal.c | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d5bbf4223fd2..58759a4f8dff 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 8ca479831142..00e9eaa02969 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -212,6 +212,10 @@ ENTRY(handle_exception)
 handle_syscall:
 	 /* save the initial A0 value (needed in signal handlers) */
 	REG_S a0, PT_ORIG_A0(sp)
+#ifdef CONFIG_RSEQ_DEBUG
+	move a0, sp
+	call rseq_syscall
+#endif
 	/*
 	 * Advance SEPC to avoid executing the original
 	 * scall instruction on sret
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index d0f6f212f5df..f2f6017f92d0 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -219,6 +219,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 
+	rseq_signal_deliver(ksig, regs);
+
 	/* Are we from a system call? */
 	if (regs->scause == EXC_SYSCALL) {
 		/* Avoid additional syscall restarting via ret_from_exception */
@@ -302,5 +304,6 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 }
-- 
2.7.4

