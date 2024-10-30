Return-Path: <linux-kselftest+bounces-21073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3ED9B5A70
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8EB1C226C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45911C461F;
	Wed, 30 Oct 2024 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J99NGQ6J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C611993B7
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730259325; cv=none; b=oFnk5Qb1fdi/vfH9L6JxhuZuZHdhPU+KjOKqY4urUH5rDI53s3CyvatkvKFox+b33lRM4t2baRlTBcSnk38tFiQeXlYJkvV/eflzO6z9fSgvDAESZRulLyyWjRb41BApJ62bUXydBjOq/qxpBYleYf/5tIyLc4eGhqz8yZ8PQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730259325; c=relaxed/simple;
	bh=IpK3iCKepmRoHoRT3dTc56O3/n6KoDfaNOMfErPW1c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONJCokrGzMqCYFfYzUwhdWyBRAiJYC4WzuyZ+jjvCBnvQE79prXWv8CUfiMbpv7Ob4nlYSbI+IJU1xGe436hOUKswhT+PEcrcuRAxbR0DyhzfsBQJ87xTMw9SnutHix8TLYMu8hGnOthT3y/hkjIdDRWxlf0PKSXhQM/4V43mo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J99NGQ6J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4608e389407so76289741cf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730259322; x=1730864122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPCD1LndjblnaQOLlh+NJCoCkXHp7fNk6gTan5Du7Vo=;
        b=J99NGQ6J4vvrrX8IMJWw8lFG4zcxI8atJ/mG7h2zdxsOEBbekMFxFHmD7BcstIwXDb
         +F/b9Jl12rsLYvfjaaTetmLTEpjcn++3qVepPxh+uVN+VTZHIRxO2FqZWw9I9sOImVms
         BIzvLH8aYfjLTLHh3NnofvFjIZRF4Ytmkwhrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730259322; x=1730864122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPCD1LndjblnaQOLlh+NJCoCkXHp7fNk6gTan5Du7Vo=;
        b=EK/ILGvCxSW19rZHYoSnLHXHONiwVkk/qkDzsBdqTNZGWNO+NSrFNO/wVuNhqDDI5p
         9MXLkuXKLaUp/QYz+QpWDUH8Jc3A5YkzrTuxFVfUXbYPf35Y5eDN6IGmkHv/J9Y+6fZN
         ZY1RhvPhOyn4Po6Ikxo9pIzC8tzay9YzKDrq+ksFiR2P5VEqgg41ui8NkQTVYSv7Zrdd
         293x0vfE0IFGYkm3tKV+uniSNNIJKywrRoz5ql1+MstZn3eFdhRNmkS8gv9Tt/AOp/tZ
         xgOzEn+UerQvJZfCGb5Lq3vNb7F8HN7N+We1tg0Qvk/sqm6HSLSzlUaJMILIFKWIPnmb
         BUKg==
X-Forwarded-Encrypted: i=1; AJvYcCWBf1DLPt4ap5nCoFWZNHdGsvN89bHW0D+CDf1u6YFBzQxWnpmSfQkOU/riOOsBNfZVFLkk4JeetT6BbyoZsgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxO+qynxzTIR5TAMEGPJwrDgN+0J05HLBg2FAOYd0YG/OE7fMl
	sH7glGnXf2F5Ys+xCOkJIuTbtvNOTo7RFzqCWtVWDltcRjxfSLA0yv47J+8dUg==
X-Google-Smtp-Source: AGHT+IGvqvrGUPIW3W466krAijES6+oygZ/+5sDNjWbmWwE75flUdG/mkbK2Qqi4HXz/VvGz42EwRw==
X-Received: by 2002:a05:622a:181c:b0:45e:fbd1:9890 with SMTP id d75a77b69052e-4613bfc868bmr200791401cf.8.1730259321901;
        Tue, 29 Oct 2024 20:35:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a4840sm51015561cf.86.2024.10.29.20.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:35:21 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: kvm@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Doug Covelli <doug.covelli@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] KVM: selftests: x86: Add a test for KVM_CAP_X86_VMWARE_HYPERCALL
Date: Tue, 29 Oct 2024 23:34:09 -0400
Message-ID: <20241030033514.1728937-4-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241030033514.1728937-1-zack.rusin@broadcom.com>
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a testcase to exercise KVM_CAP_X86_VMWARE_HYPERCALL and validate
that KVM exits to userspace on hypercalls and registers are correctly
preserved.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Doug Covelli <doug.covelli@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/include/uapi/linux/kvm.h                |   2 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/x86_64/vmware_hypercall_test.c        | 108 ++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/vmware_hypercall_test.c

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 637efc055145..4c2cc6ed29a0 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -933,6 +933,8 @@ struct kvm_enable_cap {
 #define KVM_CAP_PRE_FAULT_MEMORY 236
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
+#define KVM_CAP_X86_VMWARE_BACKDOOR 239
+#define KVM_CAP_X86_VMWARE_HYPERCALL 240
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb..fa538d01249b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -103,6 +103,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/sync_regs_test
 TEST_GEN_PROGS_x86_64 += x86_64/ucna_injection_test
 TEST_GEN_PROGS_x86_64 += x86_64/userspace_io_test
 TEST_GEN_PROGS_x86_64 += x86_64/userspace_msr_exit_test
+TEST_GEN_PROGS_x86_64 += x86_64/vmware_hypercall_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_apic_access_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_close_while_nested_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/vmware_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/vmware_hypercall_test.c
new file mode 100644
index 000000000000..0600919ecec8
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/vmware_hypercall_test.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vmware_hypercall_test
+ *
+ * Copyright (c) 2024 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ *
+ * Based on:
+ *    xen_vmcall_test.c
+ *
+ *    Copyright © 2020 Amazon.com, Inc. or its affiliates.
+ *
+ * VMware hypercall testing
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define ARGVALUE(x) (0xdeadbeef5a5a0000UL + (x))
+#define RETVALUE(x) (0xcafef00dfbfbffffUL + (x))
+
+static void guest_code(void)
+{
+	unsigned long rax = ARGVALUE(1);
+	unsigned long rbx = ARGVALUE(2);
+	unsigned long rcx = ARGVALUE(3);
+	unsigned long rdx = ARGVALUE(4);
+	unsigned long rsi = ARGVALUE(5);
+	unsigned long rdi = ARGVALUE(6);
+	register unsigned long rbp __asm__("rbp") = ARGVALUE(7);
+
+	__asm__ __volatile__("vmcall" :
+			     "=a"(rax),  "=b"(rbx), "=c"(rcx), "=d"(rdx),
+			     "=S"(rsi), "=D"(rdi) :
+			     "a"(rax), "b"(rbx), "c"(rcx), "d"(rdx),
+			     "S"(rsi), "D"(rdi), "r"(rbp));
+	GUEST_ASSERT_EQ(rax, RETVALUE(1));
+	GUEST_ASSERT_EQ(rbx, RETVALUE(2));
+	GUEST_ASSERT_EQ(rcx, RETVALUE(3));
+	GUEST_ASSERT_EQ(rdx, RETVALUE(4));
+	GUEST_ASSERT_EQ(rdi, RETVALUE(5));
+	GUEST_ASSERT_EQ(rsi, RETVALUE(6));
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	if (!kvm_check_cap(KVM_CAP_X86_VMWARE_HYPERCALL)) {
+		print_skip("KVM_CAP_X86_VMWARE_HYPERCALL not available");
+		exit(KSFT_SKIP);
+	}
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_enable_cap(vm, KVM_CAP_X86_VMWARE_HYPERCALL, 1);
+
+	for (;;) {
+		struct kvm_run *run = vcpu->run;
+		struct ucall uc;
+
+		vcpu_run(vcpu);
+
+		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
+			struct kvm_regs regs;
+
+			TEST_ASSERT_EQ(run->hypercall.ret, 0);
+			TEST_ASSERT_EQ(run->hypercall.longmode, 1);
+			TEST_ASSERT_EQ(run->hypercall.nr, ARGVALUE(1));
+			TEST_ASSERT_EQ(run->hypercall.args[0], ARGVALUE(2));
+			TEST_ASSERT_EQ(run->hypercall.args[1], ARGVALUE(3));
+			TEST_ASSERT_EQ(run->hypercall.args[2], ARGVALUE(4));
+			TEST_ASSERT_EQ(run->hypercall.args[3], ARGVALUE(5));
+			TEST_ASSERT_EQ(run->hypercall.args[4], ARGVALUE(6));
+			TEST_ASSERT_EQ(run->hypercall.args[5], ARGVALUE(7));
+
+			run->hypercall.ret = RETVALUE(1);
+			vcpu_regs_get(vcpu, &regs);
+			regs.rbx = RETVALUE(2);
+			regs.rcx = RETVALUE(3);
+			regs.rdx = RETVALUE(4);
+			regs.rdi = RETVALUE(5);
+			regs.rsi = RETVALUE(6);
+			vcpu_regs_set(vcpu, &regs);
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+		}
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0


