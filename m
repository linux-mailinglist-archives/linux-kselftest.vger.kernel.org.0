Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F775B49F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGTQhm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGTQhS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493C30F7
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlKugqrUieeoCK15s+XaSmSpmpWi+6cYdLHEecxMVFQ=;
        b=Trf10nGyLqf9QYWmxP99v+vg8S0eS0e5sGyTHMpcvaHyrfzvszLvhPSnZ5L6IgNWbYOg0C
        OnjUxcrkVdlEexP5SnkHZIwatWV1jio5ZHUBbevLTbZyluNY7s+9cEkagVmSN/hvcuBLG4
        q+5MRJ0nxf4gNZ5NHhF5SDaOirzN1pc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-myilGmoaNUKUY_DOur6_gg-1; Thu, 20 Jul 2023 12:34:35 -0400
X-MC-Unique: myilGmoaNUKUY_DOur6_gg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95D7E3815EEF;
        Thu, 20 Jul 2023 16:34:32 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28EAC40C2070;
        Thu, 20 Jul 2023 16:34:24 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [RFC PATCH v2 19/20] context_tracking,x86: Add infrastructure to defer kernel TLBI
Date:   Thu, 20 Jul 2023 17:30:55 +0100
Message-Id: <20230720163056.2564824-20-vschneid@redhat.com>
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

Kernel TLB invalidation IPIs are a common source of interference on
NOHZ_FULL CPUs. Given NOHZ_FULL CPUs executing in userspace are not
accessing any kernel addresses, these invalidations do not need to happen
immediately, and can be deferred until the next user->kernel transition.

Rather than make __flush_tlb_all() noinstr, add a minimal noinstr
variant that doesn't try to leverage INVPCID.

FIXME: not fully noinstr compliant
XXX: same issue as with ins patching, when do we access data that should be
invalidated?

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/x86/include/asm/context_tracking_work.h |  4 ++++
 arch/x86/include/asm/tlbflush.h              |  1 +
 arch/x86/mm/tlb.c                            | 17 +++++++++++++++++
 include/linux/context_tracking_state.h       |  4 ++++
 include/linux/context_tracking_work.h        |  2 ++
 5 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
index 2c66687ce00e2..9d4f021b5a45b 100644
--- a/arch/x86/include/asm/context_tracking_work.h
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_CONTEXT_TRACKING_WORK_H
 
 #include <asm/sync_core.h>
+#include <asm/tlbflush.h>
 
 static __always_inline void arch_context_tracking_work(int work)
 {
@@ -10,6 +11,9 @@ static __always_inline void arch_context_tracking_work(int work)
 	case CONTEXT_WORK_SYNC:
 		sync_core();
 		break;
+	case CONTEXT_WORK_TLBI:
+		__flush_tlb_all_noinstr();
+		break;
 	}
 }
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 80450e1d5385a..323b971987af7 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -17,6 +17,7 @@
 DECLARE_PER_CPU(u64, tlbstate_untag_mask);
 
 void __flush_tlb_all(void);
+void noinstr __flush_tlb_all_noinstr(void);
 
 #define TLB_FLUSH_ALL	-1UL
 #define TLB_GENERATION_INVALID	0
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 267acf27480af..631df9189ded4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1237,6 +1237,23 @@ void __flush_tlb_all(void)
 }
 EXPORT_SYMBOL_GPL(__flush_tlb_all);
 
+void noinstr __flush_tlb_all_noinstr(void)
+{
+	/*
+	 * This is for invocation in early entry code that cannot be
+	 * instrumented. A RMW to CR4 works for most cases, but relies on
+	 * being able to flip either of the PGE or PCIDE bits. Flipping CR4.PCID
+	 * would require also resetting CR3.PCID, so just try with CR4.PGE, else
+	 * do the CR3 write.
+	 *
+	 * TODO: paravirt
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_PGE))
+		__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
+	else
+		flush_tlb_local();
+}
+
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	struct flush_tlb_info *info;
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 292a0b7c06948..3571c62cbb9cd 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -62,6 +62,10 @@ enum ctx_state {
 #define RCU_DYNTICKS_END   (CT_STATE_SIZE - 1)
 #define RCU_DYNTICKS_IDX   BIT(RCU_DYNTICKS_START)
 
+/*
+ * When CONFIG_CONTEXT_TRACKING_WORK=n, _END is 1 behind _START, which makes
+ * the CONTEXT_WORK size computation below 0, which is what we want!
+ */
 #define	CONTEXT_WORK_START (CONTEXT_STATE_END + 1)
 #define CONTEXT_WORK_END   (RCU_DYNTICKS_START - 1)
 
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
index 13fc97b395030..47d5ced39a43a 100644
--- a/include/linux/context_tracking_work.h
+++ b/include/linux/context_tracking_work.h
@@ -6,11 +6,13 @@
 
 enum {
 	CONTEXT_WORK_SYNC_OFFSET,
+	CONTEXT_WORK_TLBI_OFFSET,
 	CONTEXT_WORK_MAX_OFFSET
 };
 
 enum ct_work {
 	CONTEXT_WORK_SYNC     = BIT(CONTEXT_WORK_SYNC_OFFSET),
+	CONTEXT_WORK_TLBI     = BIT(CONTEXT_WORK_TLBI_OFFSET),
 	CONTEXT_WORK_MAX      = BIT(CONTEXT_WORK_MAX_OFFSET)
 };
 
-- 
2.31.1

