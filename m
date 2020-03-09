Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F7F17D926
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Mar 2020 07:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgCIGAP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Mar 2020 02:00:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51790 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIGAO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Mar 2020 02:00:14 -0400
Received: by mail-pj1-f66.google.com with SMTP id y7so490703pjn.1
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Mar 2020 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N+hTR+7VvTDLQnJx4TPpX3zsg18nGz2QIJoewTIxG0A=;
        b=e9geQ2AvMExcxxSUXQJuKfsa6E76GJ88u2xkkl/c9vfcWI0ZL9bpehHVBO3UOMHHHU
         tQa4PbgR9PzVJtLP7fiS//JL4ZZVJEVo4pCl/o7CaPHOeVnQAE7Vc3pTfhZM8LQdAchC
         vgIHNpqVDpvcmei29nimf33urv8jIfxVAi78wW6QIy4LVTerYdiyOjop1BdRQEdTBqdC
         418MTn/Fcuk4T871vG6QL4cuI7ZZFj+qg3C36lIUNpD4FGLmHBaXxTPpQt5QzTOqu9xv
         0CsW4LWavfmFQs+VgpoJ4B02jJm+k2gGLY+fjjEzdwsxyOF+bnm1ljejqXDu3a1oifsL
         sAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N+hTR+7VvTDLQnJx4TPpX3zsg18nGz2QIJoewTIxG0A=;
        b=Dyu+9IFxcc4R35OUs5JUHPb1qgQv6Cu60YUy2lOlY67DiX7aeWPexhb6qQEyjNsQRK
         qOIitWbVGXdmOkzAtLPghof5/dHq97fPSoxDPbiH5M6Knla23DWAmnCH54VdHhqJbRAE
         Fqn0aV3yCLxcXlaB9jMxa+WeKpXUS2YJjL0HDS9xzYMX+SApnTESAuJg3Bf6T4Oz8BM3
         C38vL3QiBrsbkK9CRvakbq53rjwv/pmp6Khk7AlB/SS/U6eQRysiE9xhzxh7f3stXOqn
         86I/vrt73DxLzDpmZXGLwamFVzWttPZTKl6Wtg+wWE1pE8K0xi7yahTNVDQKfMQ25DdC
         CBHg==
X-Gm-Message-State: ANhLgQ0Nq1xmJSUFa7nsyjt2J99jXHTXct9Il3B2jq3+bzkYyF3yfgXT
        Zo/n1tPwgcTdrKfHJV+qOpVUj7fBVtkSMg==
X-Google-Smtp-Source: ADFU+vt8s60i8D4FK04Ht3isNmz46Gz2cNkJjQx3vQtINL2NFoFZ/KoFkID4G3S/KUvt7cf8ZnS28g==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr17157466pja.16.1583733613758;
        Sun, 08 Mar 2020 23:00:13 -0700 (PDT)
Received: from VincentChen-ThinkPad-T480s.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id nh4sm3033061pjb.39.2020.03.08.23.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Mar 2020 23:00:13 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        mathieu.desnoyers@efficios.com
Cc:     linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH V2 2/3] riscv: Add support for restartable sequence
Date:   Mon,  9 Mar 2020 13:59:51 +0800
Message-Id: <1583733592-22873-3-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
References: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
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
 arch/riscv/kernel/signal.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa98b279257e..ded32979d33d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -67,6 +67,7 @@ config RISCV
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_ARCH_KASAN if MMU && 64BIT
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index bad4d85b5e91..89d3713b0aef 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -214,6 +214,10 @@ ENTRY(handle_exception)
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
index 17ba190e84a5..d939c5de41c4 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -234,6 +234,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 
+	rseq_signal_deliver(ksig, regs);
 	/* Are we from a system call? */
 	if (regs->cause == EXC_SYSCALL) {
 		/* Avoid additional syscall restarting via ret_from_exception */
@@ -316,5 +317,6 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 }
-- 
2.7.4

