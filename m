Return-Path: <linux-kselftest+bounces-4266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD284D0A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A131F25DD9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C96135A4D;
	Wed,  7 Feb 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcN3sbci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866B612F365;
	Wed,  7 Feb 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328762; cv=none; b=op7HQquZtY9CLuw1QnlGQ4oxin/Jrjt9Z3m1aCVQOv2QuKWxveXq7ewnnKJ7DhO4n5rxv9nuomFprsELjMNmuiTqrd3xkETooKt/4aX/oZU1/tlTf3m1kOU67n/eHN1k/2F6wmRgd1tA9JIVPOjatyaEbIZuSBNRFk8qpFbmZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328762; c=relaxed/simple;
	bh=3apt9vZ3hftEsa5TOJ4CT5yROR6mgWfUiQ1RR21TjI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sr/tFkHGhJy3xlcSg8uMewQMEHiF9prDSU6VvgstJyqGJ4s9ypDVu/HSLwsfMCPn6LuvP0W/h8Lk5+Cq8NHPEl2pSLJ8i/FwHun4t67g9R8jmmI72M1fq6y1NrhB/CVattcfwrldn0JQqU3YRd1e/ixgO1/EXrLo3pt3V0SEEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcN3sbci; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328757; x=1738864757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3apt9vZ3hftEsa5TOJ4CT5yROR6mgWfUiQ1RR21TjI0=;
  b=WcN3sbcie59lKDTVRRElcgrHfXl/2IcqP1mwllzS2CtQzjG0q8drVYRa
   hL0GuI4EHjG4gQVsb4hXP6UwAZjCy7UtJl7tr1jBJD8QVj6dwTwhWsMus
   rOYm9HxIHknVDjHgJFtn4ssdTKkWILaIuJmdVejWmxaTpXuVrvRfAo4as
   XLxn/mvOWw2IJdl0Y9Eej5HezoSps0oFe+urYHinFwnDhZNMs8l6peX2F
   k6ThYcmx0dr6R+58OT9uoIZMltL8Wa0AGcBAJ+AJyZFHu91wUJSc3QVUm
   FAZSK2b4iomrk+36OOy/6+sa/AhoY2uORNhGTWdcdfMKfZTbTLDZ5rY/C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622651"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020752"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:58 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 18/25] KVM: nVMX: Add a prerequisite to SHADOW_FIELD_R[OW] macros
Date: Wed,  7 Feb 2024 09:26:38 -0800
Message-ID: <20240207172646.3981-19-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a prerequisite for accessing VMCS fields referenced in macros
SHADOW_FIELD_R[OW], because a VMCS field may not exist on some CPUs.

Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/nested.c             | 70 ++++++++++++++++++------
 arch/x86/kvm/vmx/vmcs_shadow_fields.h | 76 +++++++++++++--------------
 2 files changed, 91 insertions(+), 55 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1132e360ff13..94da6a0a2f81 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -53,14 +53,14 @@ struct shadow_vmcs_field {
 	u16	offset;
 };
 static struct shadow_vmcs_field shadow_read_only_fields[] = {
-#define SHADOW_FIELD_RO(x, y) { x, offsetof(struct vmcs12, y) },
+#define SHADOW_FIELD_RO(x, y, c) { x, offsetof(struct vmcs12, y) },
 #include "vmcs_shadow_fields.h"
 };
 static int max_shadow_read_only_fields =
 	ARRAY_SIZE(shadow_read_only_fields);
 
 static struct shadow_vmcs_field shadow_read_write_fields[] = {
-#define SHADOW_FIELD_RW(x, y) { x, offsetof(struct vmcs12, y) },
+#define SHADOW_FIELD_RW(x, y, c) { x, offsetof(struct vmcs12, y) },
 #include "vmcs_shadow_fields.h"
 };
 static int max_shadow_read_write_fields =
@@ -83,6 +83,17 @@ static void init_vmcs_shadow_fields(void)
 			pr_err("Missing field from shadow_read_only_field %x\n",
 			       field + 1);
 
+		switch (field) {
+#define SHADOW_FIELD_RO(x, y, c)		\
+		case x:				\
+			if (!(c))		\
+				continue;	\
+			break;
+#include "vmcs_shadow_fields.h"
+		default:
+			break;
+		}
+
 		clear_bit(field, vmx_vmread_bitmap);
 		if (field & 1)
 #ifdef CONFIG_X86_64
@@ -114,18 +125,12 @@ static void init_vmcs_shadow_fields(void)
 		 * on bare metal.
 		 */
 		switch (field) {
-		case GUEST_PML_INDEX:
-			if (!cpu_has_vmx_pml())
-				continue;
-			break;
-		case VMX_PREEMPTION_TIMER_VALUE:
-			if (!cpu_has_vmx_preemption_timer())
-				continue;
-			break;
-		case GUEST_INTR_STATUS:
-			if (!cpu_has_vmx_apicv())
-				continue;
+#define SHADOW_FIELD_RW(x, y, c)		\
+		case x:				\
+			if (!(c))		\
+				continue;	\
 			break;
+#include "vmcs_shadow_fields.h"
 		default:
 			break;
 		}
@@ -1585,6 +1590,18 @@ static void copy_shadow_to_vmcs12(struct vcpu_vmx *vmx)
 
 	for (i = 0; i < max_shadow_read_write_fields; i++) {
 		field = shadow_read_write_fields[i];
+
+		switch (field.encoding) {
+#define SHADOW_FIELD_RW(x, y, c)		\
+		case x:				\
+			if (!(c))		\
+				continue;	\
+			break;
+#include "vmcs_shadow_fields.h"
+		default:
+			break;
+		}
+
 		val = __vmcs_readl(field.encoding);
 		vmcs12_write_any(vmcs12, field.encoding, field.offset, val);
 	}
@@ -1619,6 +1636,23 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
 	for (q = 0; q < ARRAY_SIZE(fields); q++) {
 		for (i = 0; i < max_fields[q]; i++) {
 			field = fields[q][i];
+
+			switch (field.encoding) {
+#define SHADOW_FIELD_RO(x, y, c)			\
+			case x:				\
+				if (!(c))		\
+					continue;	\
+				break;
+#define SHADOW_FIELD_RW(x, y, c)			\
+			case x:				\
+				if (!(c))		\
+					continue;	\
+				break;
+#include "vmcs_shadow_fields.h"
+			default:
+				break;
+			}
+
 			val = vmcs12_read_any(vmcs12, field.encoding,
 					      field.offset);
 			__vmcs_writel(field.encoding, val);
@@ -5492,9 +5526,10 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 static bool is_shadow_field_rw(unsigned long field)
 {
 	switch (field) {
-#define SHADOW_FIELD_RW(x, y) case x:
+#define SHADOW_FIELD_RW(x, y, c)	\
+	case x:				\
+		return c;
 #include "vmcs_shadow_fields.h"
-		return true;
 	default:
 		break;
 	}
@@ -5504,9 +5539,10 @@ static bool is_shadow_field_rw(unsigned long field)
 static bool is_shadow_field_ro(unsigned long field)
 {
 	switch (field) {
-#define SHADOW_FIELD_RO(x, y) case x:
+#define SHADOW_FIELD_RO(x, y, c)	\
+	case x:				\
+		return c;
 #include "vmcs_shadow_fields.h"
-		return true;
 	default:
 		break;
 	}
diff --git a/arch/x86/kvm/vmx/vmcs_shadow_fields.h b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
index cad128d1657b..7f48056fe351 100644
--- a/arch/x86/kvm/vmx/vmcs_shadow_fields.h
+++ b/arch/x86/kvm/vmx/vmcs_shadow_fields.h
@@ -3,10 +3,10 @@ BUILD_BUG_ON(1)
 #endif
 
 #ifndef SHADOW_FIELD_RO
-#define SHADOW_FIELD_RO(x, y)
+#define SHADOW_FIELD_RO(x, y, c)
 #endif
 #ifndef SHADOW_FIELD_RW
-#define SHADOW_FIELD_RW(x, y)
+#define SHADOW_FIELD_RW(x, y, c)
 #endif
 
 /*
@@ -32,48 +32,48 @@ BUILD_BUG_ON(1)
  */
 
 /* 16-bits */
-SHADOW_FIELD_RW(GUEST_INTR_STATUS, guest_intr_status)
-SHADOW_FIELD_RW(GUEST_PML_INDEX, guest_pml_index)
-SHADOW_FIELD_RW(HOST_FS_SELECTOR, host_fs_selector)
-SHADOW_FIELD_RW(HOST_GS_SELECTOR, host_gs_selector)
+SHADOW_FIELD_RW(GUEST_INTR_STATUS, guest_intr_status, cpu_has_vmx_apicv())
+SHADOW_FIELD_RW(GUEST_PML_INDEX, guest_pml_index, cpu_has_vmx_pml())
+SHADOW_FIELD_RW(HOST_FS_SELECTOR, host_fs_selector, true)
+SHADOW_FIELD_RW(HOST_GS_SELECTOR, host_gs_selector, true)
 
 /* 32-bits */
-SHADOW_FIELD_RO(VM_EXIT_REASON, vm_exit_reason)
-SHADOW_FIELD_RO(VM_EXIT_INTR_INFO, vm_exit_intr_info)
-SHADOW_FIELD_RO(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len)
-SHADOW_FIELD_RO(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field)
-SHADOW_FIELD_RO(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code)
-SHADOW_FIELD_RO(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code)
-SHADOW_FIELD_RO(GUEST_CS_AR_BYTES, guest_cs_ar_bytes)
-SHADOW_FIELD_RO(GUEST_SS_AR_BYTES, guest_ss_ar_bytes)
-SHADOW_FIELD_RW(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control)
-SHADOW_FIELD_RW(PIN_BASED_VM_EXEC_CONTROL, pin_based_vm_exec_control)
-SHADOW_FIELD_RW(EXCEPTION_BITMAP, exception_bitmap)
-SHADOW_FIELD_RW(VM_ENTRY_EXCEPTION_ERROR_CODE, vm_entry_exception_error_code)
-SHADOW_FIELD_RW(VM_ENTRY_INTR_INFO_FIELD, vm_entry_intr_info_field)
-SHADOW_FIELD_RW(VM_ENTRY_INSTRUCTION_LEN, vm_entry_instruction_len)
-SHADOW_FIELD_RW(TPR_THRESHOLD, tpr_threshold)
-SHADOW_FIELD_RW(GUEST_INTERRUPTIBILITY_INFO, guest_interruptibility_info)
-SHADOW_FIELD_RW(VMX_PREEMPTION_TIMER_VALUE, vmx_preemption_timer_value)
+SHADOW_FIELD_RO(VM_EXIT_REASON, vm_exit_reason, true)
+SHADOW_FIELD_RO(VM_EXIT_INTR_INFO, vm_exit_intr_info, true)
+SHADOW_FIELD_RO(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len, true)
+SHADOW_FIELD_RO(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code, true)
+SHADOW_FIELD_RO(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field, true)
+SHADOW_FIELD_RO(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code, true)
+SHADOW_FIELD_RO(GUEST_CS_AR_BYTES, guest_cs_ar_bytes, true)
+SHADOW_FIELD_RO(GUEST_SS_AR_BYTES, guest_ss_ar_bytes, true)
+SHADOW_FIELD_RW(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control, true)
+SHADOW_FIELD_RW(PIN_BASED_VM_EXEC_CONTROL, pin_based_vm_exec_control, true)
+SHADOW_FIELD_RW(EXCEPTION_BITMAP, exception_bitmap, true)
+SHADOW_FIELD_RW(VM_ENTRY_EXCEPTION_ERROR_CODE, vm_entry_exception_error_code, true)
+SHADOW_FIELD_RW(VM_ENTRY_INTR_INFO_FIELD, vm_entry_intr_info_field, true)
+SHADOW_FIELD_RW(VM_ENTRY_INSTRUCTION_LEN, vm_entry_instruction_len, true)
+SHADOW_FIELD_RW(TPR_THRESHOLD, tpr_threshold, true)
+SHADOW_FIELD_RW(GUEST_INTERRUPTIBILITY_INFO, guest_interruptibility_info, true)
+SHADOW_FIELD_RW(VMX_PREEMPTION_TIMER_VALUE, vmx_preemption_timer_value, cpu_has_vmx_preemption_timer())
 
 /* Natural width */
-SHADOW_FIELD_RO(EXIT_QUALIFICATION, exit_qualification)
-SHADOW_FIELD_RO(GUEST_LINEAR_ADDRESS, guest_linear_address)
-SHADOW_FIELD_RW(GUEST_RIP, guest_rip)
-SHADOW_FIELD_RW(GUEST_RSP, guest_rsp)
-SHADOW_FIELD_RW(GUEST_CR0, guest_cr0)
-SHADOW_FIELD_RW(GUEST_CR3, guest_cr3)
-SHADOW_FIELD_RW(GUEST_CR4, guest_cr4)
-SHADOW_FIELD_RW(GUEST_RFLAGS, guest_rflags)
-SHADOW_FIELD_RW(CR0_GUEST_HOST_MASK, cr0_guest_host_mask)
-SHADOW_FIELD_RW(CR0_READ_SHADOW, cr0_read_shadow)
-SHADOW_FIELD_RW(CR4_READ_SHADOW, cr4_read_shadow)
-SHADOW_FIELD_RW(HOST_FS_BASE, host_fs_base)
-SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base)
+SHADOW_FIELD_RO(EXIT_QUALIFICATION, exit_qualification, true)
+SHADOW_FIELD_RO(GUEST_LINEAR_ADDRESS, guest_linear_address, true)
+SHADOW_FIELD_RW(GUEST_RIP, guest_rip, true)
+SHADOW_FIELD_RW(GUEST_RSP, guest_rsp, true)
+SHADOW_FIELD_RW(GUEST_CR0, guest_cr0, true)
+SHADOW_FIELD_RW(GUEST_CR3, guest_cr3, true)
+SHADOW_FIELD_RW(GUEST_CR4, guest_cr4, true)
+SHADOW_FIELD_RW(GUEST_RFLAGS, guest_rflags, true)
+SHADOW_FIELD_RW(CR0_GUEST_HOST_MASK, cr0_guest_host_mask, true)
+SHADOW_FIELD_RW(CR0_READ_SHADOW, cr0_read_shadow, true)
+SHADOW_FIELD_RW(CR4_READ_SHADOW, cr4_read_shadow, true)
+SHADOW_FIELD_RW(HOST_FS_BASE, host_fs_base, true)
+SHADOW_FIELD_RW(HOST_GS_BASE, host_gs_base, true)
 
 /* 64-bit */
-SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address)
-SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address)
+SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS, guest_physical_address, true)
+SHADOW_FIELD_RO(GUEST_PHYSICAL_ADDRESS_HIGH, guest_physical_address, true)
 
 #undef SHADOW_FIELD_RO
 #undef SHADOW_FIELD_RW
-- 
2.43.0


