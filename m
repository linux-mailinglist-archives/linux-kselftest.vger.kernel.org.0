Return-Path: <linux-kselftest+bounces-29658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B25A6E0FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 18:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC55C173884
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523E26657A;
	Mon, 24 Mar 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ED3fJ7N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF206265CC0
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837585; cv=none; b=F1hMS2S64uSRZNl8tImY3vYMKtgIzJdbr/CecEpRVrxKKINrj2biJxIuHJezHhf645EOgmhATeObuXH1b14HnsI+QL5//MgmpB1X5s+eOmv8/BufZqTLpMvDevWVMayhkDrts0IVFsmbZtCzhodI2C79rkPWsEIjNT+lrO1j6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837585; c=relaxed/simple;
	bh=9s/X3EcXq1cls+QrXMm/3bhusn/SOpHELkcXFGS8ybU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KPZgEr61TH++R0vT2VALmVso1DTovIz/ARlzqYWSYRENZgCbBZE9ECigla8XTsc/0G/NZ1q96+FZr77Y2xyupf9Hl9m2fN40o6jem2+nhgnzPZfkExgjSSet/oMBqzL/vUPXbsG/xVeGLn1r7SIcqA2KZGv8KRLUjafHQLkoYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ED3fJ7N; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso8046091a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Mar 2025 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837583; x=1743442383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=inTNfiK+UoZulh9AoMBj8W4HF655HVoauEo6Hos0PJ4=;
        b=0ED3fJ7NvSqLzzACSI4OROciiHZt0lZRuKO3k8Z+O5RIpIxKb+w1zSOQSJGCu34Fjn
         A9yVcy/nUWjJvVsWxV00ohON2kgTtWIhnNFQI0FZkoq9lGcINbKY2+/ssVzdrTUlvuNT
         24c0xYREtAMmQrYiDeACHEaOHdlHZOPJ0EdAu3qwmX9U21EBpobDJloxjjmVw9MjOy7l
         xoU3gmegbKQn/ATDYMxBkrKyCVPiiO6X9vBJAMZs7Fu+TBacC1PwRq1ta4+VaAY9oujx
         ULMMcAgTVWSsJyKWOuLLmbDK6YqsflG2x+XC0C8p+qkEnCBrU2FZg2rE7FqMUPQRR/gi
         tAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837583; x=1743442383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inTNfiK+UoZulh9AoMBj8W4HF655HVoauEo6Hos0PJ4=;
        b=Z3kOP8Q6neY6hsMHfJG45Wo6XeLarP8SWFh6uANaFajSCUh2DIGkL704hQAhi8I0Pu
         hke8+2iy4ibwrvoFfDKbtga9PYIb39IMIkW6X4+PoDc0a0P9bsouQlnZJlfUFKrGswe5
         E86IqqCOpLFnjfAa87x+Zg6/Esh6KHcqcqPNWL6oKbs0IZETtmndJDuNw4Wxx3G6bRNG
         cHBtg9ugKA0reLRB+PWnu+DMsxc6iylLmapB6IR4krK9VLkremaOWyie1xT1wXg0gksc
         KhYXo+OSOixTxH0U28PYKOvUgZOmFH7OrADhM5zI3H52YodehsHD67cRX68WqTTYaZCW
         lCJw==
X-Forwarded-Encrypted: i=1; AJvYcCVFjqx1dP7JcGi1CA6xz5Rx+EeErb44H/OEG0kUJst36NyTYFf1e/qWMTx9uOLZFKv2FhdP/+MSKQYVaTKBvGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+6qiIdItVWv3+ChIS1NGPa/rcUnpxQg/ozoDCL3VFgyiMEX6
	85M0kcYS6QGM//pwPbKcvpACVdzo8MzVJZxHs5HjKxE8oH6WjtfgR0ouTP4fGCdhR9nrZueLxv7
	w6fjlWg==
X-Google-Smtp-Source: AGHT+IHTcMJxsKm+v2TZxHZ+lGCjyf6A04l1EGBgrq/tk82YK/fK71733qiMqe/z518iPWP/HMV/QNXJNIDe
X-Received: from pjbqn14.prod.google.com ([2002:a17:90b:3d4e:b0:2ff:84e6:b2bd])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280b:b0:2ee:d824:b559
 with SMTP id 98e67ed59e1d1-3030fef09b9mr20407939a91.28.1742837583045; Mon, 24
 Mar 2025 10:33:03 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:47 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-8-mizhang@google.com>
Subject: [PATCH v4 07/38] perf: core/x86: Register a new vector for KVM GUEST PMI
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

Create a new vector in the host IDT for kvm guest PMI handling within
mediated passthrough vPMU. In addition, guest PMI handler registration
is added into x86_set_kvm_irq_handler().

This is the preparation work to support mediated passthrough vPMU to
handle kvm guest PMIs without interference from PMI handler of the host
PMU.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/hardirq.h                |  1 +
 arch/x86/include/asm/idtentry.h               |  1 +
 arch/x86/include/asm/irq_vectors.h            |  5 ++++-
 arch/x86/kernel/idt.c                         |  1 +
 arch/x86/kernel/irq.c                         | 21 +++++++++++++++++++
 .../beauty/arch/x86/include/asm/irq_vectors.h |  5 ++++-
 6 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 6ffa8b75f4cd..25fac35b9a29 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -19,6 +19,7 @@ typedef struct {
 	unsigned int kvm_posted_intr_ipis;
 	unsigned int kvm_posted_intr_wakeup_ipis;
 	unsigned int kvm_posted_intr_nested_ipis;
+	unsigned int kvm_guest_pmis;
 #endif
 	unsigned int x86_platform_ipis;	/* arch dependent */
 	unsigned int apic_perf_irqs;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index ad5c68f0509d..b0cb3220e1bb 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -745,6 +745,7 @@ DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup_ipi);
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
+DECLARE_IDTENTRY_SYSVEC(KVM_GUEST_PMI_VECTOR,	        sysvec_kvm_guest_pmi_handler);
 #else
 # define fred_sysvec_kvm_posted_intr_ipi		NULL
 # define fred_sysvec_kvm_posted_intr_wakeup_ipi		NULL
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 47051871b436..250cdab11306 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -77,7 +77,10 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-/* 0xf5 - unused, was UV_BAU_MESSAGE */
+#if IS_ENABLED(CONFIG_KVM)
+#define KVM_GUEST_PMI_VECTOR		0xf5
+#endif
+
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index f445bec516a0..0bec4c7e2308 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -157,6 +157,7 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(POSTED_INTR_VECTOR,		asm_sysvec_kvm_posted_intr_ipi),
 	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
 	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),
+	INTG(KVM_GUEST_PMI_VECTOR,		asm_sysvec_kvm_guest_pmi_handler),
 # endif
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 18cd418fe106..b29714e23fc4 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -183,6 +183,12 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ",
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
+
+	seq_printf(p, "%*s: ", prec, "VPMU");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ",
+			   irq_stats(j)->kvm_guest_pmis);
+	seq_puts(p, " KVM GUEST PMI\n");
 #endif
 #ifdef CONFIG_X86_POSTED_MSI
 	seq_printf(p, "%*s: ", prec, "PMN");
@@ -311,6 +317,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
 #if IS_ENABLED(CONFIG_KVM)
 static void dummy_handler(void) {}
 static void (*kvm_posted_intr_wakeup_handler)(void) = dummy_handler;
+static void (*kvm_guest_pmi_handler)(void) = dummy_handler;
 
 void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void))
 {
@@ -321,6 +328,10 @@ void x86_set_kvm_irq_handler(u8 vector, void (*handler)(void))
 	    (handler == dummy_handler ||
 	     kvm_posted_intr_wakeup_handler == dummy_handler))
 		kvm_posted_intr_wakeup_handler = handler;
+	else if (vector == KVM_GUEST_PMI_VECTOR &&
+		 (handler == dummy_handler ||
+		  kvm_guest_pmi_handler == dummy_handler))
+		kvm_guest_pmi_handler = handler;
 	else
 		WARN_ON_ONCE(1);
 
@@ -356,6 +367,16 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 	apic_eoi();
 	inc_irq_stat(kvm_posted_intr_nested_ipis);
 }
+
+/*
+ * Handler for KVM_GUEST_PMI_VECTOR.
+ */
+DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_guest_pmi_handler)
+{
+	apic_eoi();
+	inc_irq_stat(kvm_guest_pmis);
+	kvm_guest_pmi_handler();
+}
 #endif
 
 #ifdef CONFIG_X86_POSTED_MSI
diff --git a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
index 47051871b436..250cdab11306 100644
--- a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
+++ b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
@@ -77,7 +77,10 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-/* 0xf5 - unused, was UV_BAU_MESSAGE */
+#if IS_ENABLED(CONFIG_KVM)
+#define KVM_GUEST_PMI_VECTOR		0xf5
+#endif
+
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
-- 
2.49.0.395.g12beb8f557-goog


