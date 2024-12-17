Return-Path: <linux-kselftest+bounces-23456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E169F55C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40627163A90
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7731F892F;
	Tue, 17 Dec 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vYzcg8Xq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67E1F8919;
	Tue, 17 Dec 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459315; cv=none; b=g7KTfIiQVQgnln0/V2ZxIMNcTcwUhg/SpOA5O919sHGZxpZn1Is2Yj/toXn0CKGnJwammE7xZu6SywMbPPbdFZYOAX0ZhswZUQEWJocYjun1Qi79OoTANZd9ugne02xsuddOsIB78HpHV8c0MogSgcakmgYhfmEWv53ObtXq8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459315; c=relaxed/simple;
	bh=rc7JzmZN0U0cmazanc6cjPkftA8JqudgKFtX9XwF8+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFyWpw3conTsjz/YdHyzh9TfhdMmXeM6ggdYoMA73E7kSdUoDcsOgCPpsR8evqVrdU1CCafY1AtulmkEqbF14f+REx5noGmZeyRZCj77Ci8Fy1pQoPNQiveEfLE4ABI1MhVxMMrMw7oCsj1FgH/S54CXmY96dzTAvGE8zc33xOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vYzcg8Xq; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459312; x=1765995312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4VN5aP9uPohUChbBXN+Eoyl7CFAbxwb756OR/RUx5rY=;
  b=vYzcg8XqrZcO2EnXMP1qeBKviPS3XqRzS3tgim1S8UiXE+LHSznIAmGT
   I/joBpzlHQdnRDLt6MBn9ChZBlM6y7hl0rje8VnKq/113CzgC15L5H1/M
   hJ6TnbRtXXzjA5iwGA95THP3fSTURgSLI5IodhWxqoyLmnni7jmI0pJpr
   I=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="446604344"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:15:09 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.29.78:63567]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.24.38:2525] with esmtp (Farcaster)
 id 1c4b3b02-0951-4bdc-a6e8-edde075a77f7; Tue, 17 Dec 2024 18:15:09 +0000 (UTC)
X-Farcaster-Flow-ID: 1c4b3b02-0951-4bdc-a6e8-edde075a77f7
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:09 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:08 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:08 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id 1AAB4A0790;
	Tue, 17 Dec 2024 18:15:05 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 1/7] KVM: x86: Add function for vectoring error generation
Date: Tue, 17 Dec 2024 18:14:52 +0000
Message-ID: <20241217181458.68690-2-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241217181458.68690-1-iorlov@amazon.com>
References: <20241217181458.68690-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extract VMX code for unhandleable VM-Exit during vectoring into
vendor-agnostic function so that boiler-plate code can be shared by SVM.

Report an actual GPA for EPT misconfig or invalid GPA for any other exit
code in internal.data[3].

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- Return GPA for any exit reason, using reported GPA when it is valid or
INVALID_GPA otherwise.
- Rename the error preparation function
- Fix indentation
V2 -> V3:
- Move 'gpa' declaration into block it is used in
- Use 'if' instead of ternary operator when reporting GPA
- Remove redundant cast

 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 17 +++++------------
 arch/x86/kvm/x86.c              | 22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e159e44a6a1b..de8fb1ab230c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2062,6 +2062,8 @@ void __kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu,
 					  u64 *data, u8 ndata);
 void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
 
+void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
+
 void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 *data);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 893366e53732..acc2f0e0a339 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6557,19 +6557,12 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
 	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
 	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
-		int ndata = 3;
+		gpa_t gpa = INVALID_GPA;
 
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
-		vcpu->run->internal.data[0] = vectoring_info;
-		vcpu->run->internal.data[1] = exit_reason.full;
-		vcpu->run->internal.data[2] = vmx_get_exit_qual(vcpu);
-		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG) {
-			vcpu->run->internal.data[ndata++] =
-				vmcs_read64(GUEST_PHYSICAL_ADDRESS);
-		}
-		vcpu->run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
-		vcpu->run->internal.ndata = ndata;
+		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG)
+			gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
+
+		kvm_prepare_event_vectoring_exit(vcpu, gpa);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2e713480933a..7ce9cdb66f19 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8813,6 +8813,28 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_prepare_emulation_failure_exit);
 
+void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	u32 reason, intr_info, error_code;
+	struct kvm_run *run = vcpu->run;
+	u64 info1, info2;
+	int ndata = 0;
+
+	kvm_x86_call(get_exit_info)(vcpu, &reason, &info1, &info2,
+				    &intr_info, &error_code);
+
+	run->internal.data[ndata++] = info2;
+	run->internal.data[ndata++] = reason;
+	run->internal.data[ndata++] = info1;
+	run->internal.data[ndata++] = gpa;
+	run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
+
+	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
+	run->internal.ndata = ndata;
+}
+EXPORT_SYMBOL_GPL(kvm_prepare_event_vectoring_exit);
+
 static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 {
 	struct kvm *kvm = vcpu->kvm;
-- 
2.43.0


