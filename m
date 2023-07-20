Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D5675B4A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGTQjy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGTQjs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A035A1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689871063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QESi3DN0fC8QnZsNV/N4VXfEg//bCfMhfN1lMbJjDRM=;
        b=iU8xckKi9lSBBhZFQBostjkXaY8dFSzdE6B56zeYYq4nfwzSMpTkHxj9NeK48CZgBtRXXa
        KkwR+IvznUgJC4jaE3l6O+PFCZHnacAIsmqy6u8MaGwJbp3XuIqQF9jW5Uv2uEutyKuvPN
        qPoZya+XOb4GYVQ9XNmh/X0NIiN6gNc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-lKQNgwDjNBmDn1pKucKVhA-1; Thu, 20 Jul 2023 12:34:27 -0400
X-MC-Unique: lKQNgwDjNBmDn1pKucKVhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF85A936D34;
        Thu, 20 Jul 2023 16:34:24 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFF9140C2070;
        Thu, 20 Jul 2023 16:34:16 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: [RFC PATCH v2 18/20] context_tracking,x86: Defer kernel text patching IPIs
Date:   Thu, 20 Jul 2023 17:30:54 +0100
Message-Id: <20230720163056.2564824-19-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-1-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
them vs the newly patched instruction. CPUs that are executing in userspace
do not need this synchronization to happen immediately, and this is
actually harmful interference for NOHZ_FULL CPUs.

As the synchronization IPIs are sent using a blocking call, returning from
text_poke_bp_batch() implies all CPUs will observe the patched
instruction(s), and this should be preserved even if the IPI is deferred.
In other words, to safely defer this synchronization, any kernel
instruction leading to the execution of the deferred instruction
sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.

This means we must pay attention to mutable instructions in the early entry
code:
- alternatives
- static keys
- all sorts of probes (kprobes/ftrace/bpf/???)

The early entry code leading to ct_work_flush() is noinstr, which gets rid
of the probes.

Alternatives are safe, because it's boot-time patching (before SMP is
even brought up) which is before any IPI deferral can happen.

This leaves us with static keys. Any static key used in early entry code
should be only forever-enabled at boot time, IOW __ro_after_init (pretty
much like alternatives). Objtool is now able to point at static keys that
don't respect this, and all static keys used in early entry code have now
been verified as behaving like so.

Leverage the new context_tracking infrastructure to defer sync_core() IPIs
to a target CPU's next kernel entry.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/context_tracking_work.h |  6 +++--
 arch/x86/include/asm/text-patching.h         |  1 +
 arch/x86/kernel/alternative.c                | 24 ++++++++++++++++----
 arch/x86/kernel/kprobes/core.c               |  4 ++--
 arch/x86/kernel/kprobes/opt.c                |  4 ++--
 arch/x86/kernel/module.c                     |  2 +-
 include/linux/context_tracking_work.h        |  4 ++--
 7 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
index 5bc29e6b2ed38..2c66687ce00e2 100644
--- a/arch/x86/include/asm/context_tracking_work.h
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -2,11 +2,13 @@
 #ifndef _ASM_X86_CONTEXT_TRACKING_WORK_H
 #define _ASM_X86_CONTEXT_TRACKING_WORK_H
 
+#include <asm/sync_core.h>
+
 static __always_inline void arch_context_tracking_work(int work)
 {
 	switch (work) {
-	case CONTEXT_WORK_n:
-		// Do work...
+	case CONTEXT_WORK_SYNC:
+		sync_core();
 		break;
 	}
 }
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 29832c338cdc5..b6939e965e69d 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -43,6 +43,7 @@ extern void text_poke_early(void *addr, const void *opcode, size_t len);
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
+extern void text_poke_sync_deferrable(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy(void *addr, const void *opcode, size_t len);
 extern void *text_poke_copy_locked(void *addr, const void *opcode, size_t len, bool core_ok);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 72646d75b6ffe..fcce480e1919e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -18,6 +18,7 @@
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
 #include <linux/sync_core.h>
+#include <linux/context_tracking.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -1933,9 +1934,24 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
+static bool do_sync_core_defer_cond(int cpu, void *info)
+{
+	return !ct_set_cpu_work(cpu, CONTEXT_WORK_SYNC);
+}
+
+static void __text_poke_sync(smp_cond_func_t cond_func)
+{
+	on_each_cpu_cond(cond_func, do_sync_core, NULL, 1);
+}
+
 void text_poke_sync(void)
 {
-	on_each_cpu(do_sync_core, NULL, 1);
+	__text_poke_sync(NULL);
+}
+
+void text_poke_sync_deferrable(void)
+{
+	__text_poke_sync(do_sync_core_defer_cond);
 }
 
 /*
@@ -2145,7 +2161,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
 	}
 
-	text_poke_sync();
+	text_poke_sync_deferrable();
 
 	/*
 	 * Second step: update all but the first byte of the patched range.
@@ -2207,7 +2223,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		 * not necessary and we'd be safe even without it. But
 		 * better safe than sorry (plus there's not only Intel).
 		 */
-		text_poke_sync();
+		text_poke_sync_deferrable();
 	}
 
 	/*
@@ -2228,7 +2244,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	}
 
 	if (do_sync)
-		text_poke_sync();
+		text_poke_sync_deferrable();
 
 	/*
 	 * Remove and wait for refs to be zero.
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index f7f6042eb7e6c..a38c914753397 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -735,7 +735,7 @@ void arch_arm_kprobe(struct kprobe *p)
 	u8 int3 = INT3_INSN_OPCODE;
 
 	text_poke(p->addr, &int3, 1);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 	perf_event_text_poke(p->addr, &p->opcode, 1, &int3, 1);
 }
 
@@ -745,7 +745,7 @@ void arch_disarm_kprobe(struct kprobe *p)
 
 	perf_event_text_poke(p->addr, &int3, 1, &p->opcode, 1);
 	text_poke(p->addr, &p->opcode, 1);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 }
 
 void arch_remove_kprobe(struct kprobe *p)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 57b0037d0a996..88451a744ceda 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -521,11 +521,11 @@ void arch_unoptimize_kprobe(struct optimized_kprobe *op)
 	       JMP32_INSN_SIZE - INT3_INSN_SIZE);
 
 	text_poke(addr, new, INT3_INSN_SIZE);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 	text_poke(addr + INT3_INSN_SIZE,
 		  new + INT3_INSN_SIZE,
 		  JMP32_INSN_SIZE - INT3_INSN_SIZE);
-	text_poke_sync();
+	text_poke_sync_deferrable();
 
 	perf_event_text_poke(op->kp.addr, old, JMP32_INSN_SIZE, new, JMP32_INSN_SIZE);
 }
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b05f62ee2344b..8b4542dc51b6d 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -242,7 +242,7 @@ static int write_relocate_add(Elf64_Shdr *sechdrs,
 				   write, apply);
 
 	if (!early) {
-		text_poke_sync();
+		text_poke_sync_deferrable();
 		mutex_unlock(&text_mutex);
 	}
 
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
index fb74db8876dd2..13fc97b395030 100644
--- a/include/linux/context_tracking_work.h
+++ b/include/linux/context_tracking_work.h
@@ -5,12 +5,12 @@
 #include <linux/bitops.h>
 
 enum {
-	CONTEXT_WORK_n_OFFSET,
+	CONTEXT_WORK_SYNC_OFFSET,
 	CONTEXT_WORK_MAX_OFFSET
 };
 
 enum ct_work {
-	CONTEXT_WORK_n        = BIT(CONTEXT_WORK_n_OFFSET),
+	CONTEXT_WORK_SYNC     = BIT(CONTEXT_WORK_SYNC_OFFSET),
 	CONTEXT_WORK_MAX      = BIT(CONTEXT_WORK_MAX_OFFSET)
 };
 
-- 
2.31.1

