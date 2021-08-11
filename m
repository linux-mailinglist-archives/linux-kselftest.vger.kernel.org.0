Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936683E9121
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhHKMba (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 08:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230242AbhHKMbM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 08:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628685048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4e6sjxP1xMCtgKIkc/C7Ht738Uh5NYfem9ykOOCFrHo=;
        b=Ary+uH/D/YBSoN8vjgBwvPbAiHeqQ2UhFGeRqpeiCg9GqNLk++Cnv5MLYwnpOyBe+gsTGq
        C+t+LvmnRZ6sYqiIv2MUdnyRfoNNr02o1UIPoq3SVQKCZ6Vnj0M+XSeXInzIv6u6nIpmoc
        Z3Wt1+RHPfPlvwrytc7gKhuUU+zkslU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-vy3N7G0qPJ-MzSfqhPkfZQ-1; Wed, 11 Aug 2021 08:30:45 -0400
X-MC-Unique: vy3N7G0qPJ-MzSfqhPkfZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD40801A92;
        Wed, 11 Aug 2021 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAFB95D9C6;
        Wed, 11 Aug 2021 12:30:30 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
Date:   Wed, 11 Aug 2021 15:29:27 +0300
Message-Id: <20210811122927.900604-7-mlevitsk@redhat.com>
In-Reply-To: <20210811122927.900604-1-mlevitsk@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Modify debug_regs test to create a pending interrupt
and see that it is blocked when single stepping is done
with KVM_GUESTDBG_BLOCKIRQ

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
index 6097a8283377..5f078db1bcba 100644
--- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
+++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
@@ -8,12 +8,15 @@
 #include <string.h>
 #include "kvm_util.h"
 #include "processor.h"
+#include "apic.h"
 
 #define VCPU_ID 0
 
 #define DR6_BD		(1 << 13)
 #define DR7_GD		(1 << 13)
 
+#define IRQ_VECTOR 0xAA
+
 /* For testing data access debug BP */
 uint32_t guest_value;
 
@@ -21,6 +24,11 @@ extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
 
 static void guest_code(void)
 {
+	/* Create a pending interrupt on current vCPU */
+	x2apic_enable();
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
+			 APIC_DM_FIXED | IRQ_VECTOR);
+
 	/*
 	 * Software BP tests.
 	 *
@@ -38,12 +46,19 @@ static void guest_code(void)
 		     "mov %%rax,%0;\n\t write_data:"
 		     : "=m" (guest_value) : : "rax");
 
-	/* Single step test, covers 2 basic instructions and 2 emulated */
+	/*
+	 * Single step test, covers 2 basic instructions and 2 emulated
+	 *
+	 * Enable interrupts during the single stepping to see that
+	 * pending interrupt we raised is not handled due to KVM_GUESTDBG_BLOCKIRQ
+	 */
 	asm volatile("ss_start: "
+		     "sti\n\t"
 		     "xor %%eax,%%eax\n\t"
 		     "cpuid\n\t"
 		     "movl $0x1a0,%%ecx\n\t"
 		     "rdmsr\n\t"
+		     "cli\n\t"
 		     : : : "eax", "ebx", "ecx", "edx");
 
 	/* DR6.BD test */
@@ -72,11 +87,13 @@ int main(void)
 	uint64_t cmd;
 	int i;
 	/* Instruction lengths starting at ss_start */
-	int ss_size[4] = {
+	int ss_size[6] = {
+		1,		/* sti*/
 		2,		/* xor */
 		2,		/* cpuid */
 		5,		/* mov */
 		2,		/* rdmsr */
+		1,		/* cli */
 	};
 
 	if (!kvm_check_cap(KVM_CAP_SET_GUEST_DEBUG)) {
@@ -154,7 +171,8 @@ int main(void)
 	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
 		target_rip += ss_size[i];
 		CLEAR_DEBUG();
-		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
+		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
+				KVM_GUESTDBG_BLOCKIRQ;
 		debug.arch.debugreg[7] = 0x00000400;
 		APPLY_DEBUG();
 		vcpu_run(vm, VCPU_ID);
-- 
2.26.3

