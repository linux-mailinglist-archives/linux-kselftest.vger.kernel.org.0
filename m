Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBF701C1A
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 May 2023 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjENHYG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 May 2023 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjENHYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 May 2023 03:24:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81461199E;
        Sun, 14 May 2023 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684049041; x=1715585041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TOAxC5UenIz2OCqRgB/SeZ4dajNYb3y4+R1INLen2Q0=;
  b=hsR3oClME9l9Fm5TrfFCif++1RD23YBOxF6z+wjQvN6rCuuhuDXVwpq6
   JFGzJgig9+5vaHodRH3LavZujRM1qBUfX34HQtC1ZbApKUxpKi+js/fae
   zjr5zHBiEmzyYQQK9vhDdNGjR0ilxu/dpvN2usvChP88vKzPdoFWM1lY+
   TrmnvWHNgPSc7SjRBheGnp2zgghmN+jATZEsKJ6AcXhQyUHn7wB0UNXQY
   cl2hX+OQ9TkaEaD3FqtphzRPDn0LLA0HTxUUmrSXoJQzVEvZ27eYVUr04
   mXUi/PB4WFbs86cDBLH5yyPIrBEfgXefoEFAggw2+kjrW28IfPVv8gti+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="354167286"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="354167286"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731262945"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="731262945"
Received: from mply-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.130.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 00:24:00 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 1/3] x86/tdx: Add TDX Guest event notify interrupt support
Date:   Sun, 14 May 2023 00:23:44 -0700
Message-Id: <83a832b156f6e3bf906fee657b0147f042481a36.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Host-guest event notification via configured interrupt vector is useful
in cases where a guest makes an asynchronous request and needs a
callback from the host to indicate the completion or to let the host
notify the guest about events like device removal. One usage example is,
callback requirement of GetQuote asynchronous hypercall.

In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
guest to specify which interrupt vector to use as an event-notify
vector from the VMM. Details about the SetupEventNotifyInterrupt
hypercall can be found in TDX Guest-Host Communication Interface
(GHCI) Specification, section "VP.VMCALL<SetupEventNotifyInterrupt>".

As per design, VMM will post the event completion IRQ using the same
CPU on which SetupEventNotifyInterrupt hypercall request is received.
So allocate an IRQ vector from "x86_vector_domain", and set the CPU
affinity of the IRQ vector to the CPU on which
SetupEventNotifyInterrupt hypercall is made.

Add tdx_register_event_irq_cb()/tdx_unregister_event_irq_cb()
interfaces to allow drivers to register/unregister event notification
handlers.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Erdem Aktas <erdemaktas@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Used early_initcall() instead of arch_initcall() to trigger
   tdx_event_irq_init().
 * Removed unused headers and included headers for spinlock and list
   explicitly.
 * Since during the early_initcall() only one CPU would be enabled, remove
   CPU locking logic (like using set_cpus_allowed_ptr() or get_cpu())

Changes since v2:
 * Fixed commit log and comments as per review suggestions.
 * Used __irq_domain_alloc_irqs() instead of irq_domain_alloc_irqs() to
   pass affinity mask.
 * Used smp_processor_id() instead of hardcoding CPU0 as per review
   suggestion.

 arch/x86/coco/tdx/tdx.c    | 159 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |   6 ++
 2 files changed, 165 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index e146b599260f..49d7e11066c1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,12 +7,17 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/irqdomain.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -27,6 +32,7 @@
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
+#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -51,6 +57,16 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+struct event_irq_entry {
+	tdx_event_irq_cb_t handler;
+	void *data;
+	struct list_head head;
+};
+
+static int tdx_event_irq __ro_after_init;
+static LIST_HEAD(event_irq_cb_list);
+static DEFINE_SPINLOCK(event_irq_cb_lock);
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -873,3 +889,146 @@ void __init tdx_early_init(void)
 
 	pr_info("Guest detected\n");
 }
+
+static irqreturn_t tdx_event_irq_handler(int irq, void *dev_id)
+{
+	struct event_irq_entry *entry;
+
+	spin_lock(&event_irq_cb_lock);
+	list_for_each_entry(entry, &event_irq_cb_list, head) {
+		if (entry->handler)
+			entry->handler(entry->data);
+	}
+	spin_unlock(&event_irq_cb_lock);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tdx_event_irq_init() - Register IRQ for event notification from the VMM to
+ *			  the TDX Guest.
+ *
+ * Use SetupEventNotifyInterrupt TDVMCALL to register the event notification
+ * IRQ with the VMM, which is used by the VMM to notify the TDX guest when
+ * needed, for instance, when VMM finishes the GetQuote request from the TDX
+ * guest. The VMM always notifies the TDX guest via the same CPU that calls
+ * the SetupEventNotifyInterrupt TDVMCALL. Allocate an IRQ/vector from the
+ * x86_vector_domain and pin it on the same CPU on which TDVMCALL is called.
+ * For simplicity, use early_initcall() to allow both IRQ allocation and
+ * TDVMCALL to use BSP.
+ */
+static int __init tdx_event_irq_init(void)
+{
+	struct irq_affinity_desc desc;
+	struct irq_alloc_info info;
+	struct irq_cfg *cfg;
+	int irq;
+
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return 0;
+
+	init_irq_alloc_info(&info, NULL);
+
+	cpumask_set_cpu(smp_processor_id(), &desc.mask);
+
+	irq = __irq_domain_alloc_irqs(x86_vector_domain, -1, 1,
+				      cpu_to_node(smp_processor_id()), &info,
+				      false, &desc);
+	if (irq <= 0) {
+		pr_err("Event notification IRQ allocation failed %d\n", irq);
+		return -EIO;
+	}
+
+	irq_set_handler(irq, handle_edge_irq);
+
+	/*
+	 * The IRQ cannot be migrated because VMM always notifies the TDX
+	 * guest on the same CPU on which the SetupEventNotifyInterrupt
+	 * TDVMCALL is called. Set the IRQ with IRQF_NOBALANCING to prevent
+	 * its affinity from being changed.
+	 */
+	if (request_irq(irq, tdx_event_irq_handler, IRQF_NOBALANCING,
+			"tdx_event_irq", NULL)) {
+		pr_err("Event notification IRQ request failed\n");
+		goto err_free_domain_irqs;
+	}
+
+	cfg = irq_cfg(irq);
+
+	if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, cfg->vector, 0, 0, 0)) {
+		pr_err("Event notification hypercall failed\n");
+		goto err_free_irqs;
+	}
+
+	tdx_event_irq = irq;
+
+	return 0;
+
+err_free_irqs:
+	free_irq(irq, NULL);
+err_free_domain_irqs:
+	irq_domain_free_irqs(irq, 1);
+
+	return -EIO;
+}
+early_initcall(tdx_event_irq_init)
+
+/**
+ * tdx_register_event_irq_cb() - Register TDX event IRQ callback handler.
+ * @handler: Address of driver specific event IRQ callback handler. Handler
+ *           will be called in IRQ context and hence cannot sleep.
+ * @data: Context data to be passed to the callback handler.
+ *
+ * Return: 0 on success or standard error code on other failures.
+ */
+int tdx_register_event_irq_cb(tdx_event_irq_cb_t handler, void *data)
+{
+	struct event_irq_entry *entry;
+	unsigned long flags;
+
+	if (tdx_event_irq <= 0)
+		return -EIO;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->data = data;
+	entry->handler = handler;
+
+	spin_lock_irqsave(&event_irq_cb_lock, flags);
+	list_add_tail(&entry->head, &event_irq_cb_list);
+	spin_unlock_irqrestore(&event_irq_cb_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_register_event_irq_cb);
+
+/**
+ * tdx_unregister_event_irq_cb() - Unregister TDX event IRQ callback handler.
+ * @handler: Address of driver specific event IRQ callback handler.
+ * @data: Context data to be passed to the callback handler.
+ *
+ * Return: 0 on success or -EIO if event IRQ is not allocated.
+ */
+int tdx_unregister_event_irq_cb(tdx_event_irq_cb_t handler, void *data)
+{
+	struct event_irq_entry *entry;
+	unsigned long flags;
+
+	if (tdx_event_irq <= 0)
+		return -EIO;
+
+	spin_lock_irqsave(&event_irq_cb_lock, flags);
+	list_for_each_entry(entry, &event_irq_cb_list, head) {
+		if (entry->handler == handler && entry->data == data) {
+			list_del(&entry->head);
+			kfree(entry);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&event_irq_cb_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_unregister_event_irq_cb);
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 28d889c9aa16..8807fe1b1f3f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -53,6 +53,8 @@ struct ve_info {
 
 #ifdef CONFIG_INTEL_TDX_GUEST
 
+typedef int (*tdx_event_irq_cb_t)(void *);
+
 void __init tdx_early_init(void);
 
 /* Used to communicate with the TDX module */
@@ -69,6 +71,10 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
+int tdx_register_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
+
+int tdx_unregister_event_irq_cb(tdx_event_irq_cb_t handler, void *data);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.34.1

