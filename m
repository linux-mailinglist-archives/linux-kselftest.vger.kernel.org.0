Return-Path: <linux-kselftest+bounces-30794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F3A88E87
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C977A305C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAA1F4E27;
	Mon, 14 Apr 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLxdKTY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7622356A8
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667367; cv=none; b=F4DarduT/MdkLn9t5x4gfd7HsdLkHIal6y4KHs1YZWA7p3GKIutnLMYaulNWeFGPikrB0Q59D9/f8QtWO3cWdIVmvPi+9E5zaraREDlXtplPGLTZ+Napq5O8nSKW5WSmcv7s6U/CZDvBLREcQO2LLeidQYwY62CI3j2bd7OynTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667367; c=relaxed/simple;
	bh=0s0eRAzp79ZyqJlag/s9T0KZQwLlfgI5CTpQtvOBf1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gr01X9bq2xqLkENlk86WRbaon21t3N5RxxFUxIlxjelFb0knQpR+2g2BVcxv+IDpqU50W+G5WHK/p6wgwJs1/Z9joWuROZVqBtvlc//ZVSAHLnd4y5ijoCy5hkFHHGYT3l11B21S55gtAQ6585oGhzZ2Ya9Z1aWX1rWq5AlEdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLxdKTY8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736cd27d51fso3958237b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667364; x=1745272164; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBSumKkK0GopQQbf4kIGENs+zTxb+YbX4N+rBsmVgUU=;
        b=RLxdKTY8Kax25vuWCeEG7w9NP835NfPOog24dW4r0CUYdEQ8k8HYWsp9mj2Wulb1Xy
         UfOu8nDE1BRZCvc8rTRVNlHoRrhIzxu3S619npXswMfnDVfK/2woTnLBT7qJdShxYP0s
         hwD9PkN4IsgJLoB6MpoE1gm+hqd5Z75SZf1msf7UdjQdly4VPyRKJpnTwC5dUXaeExG8
         IqA+/KLQBR7Rq0O0ZlESYtAJHgAhJtgfrIsXBBO0xxu/uedkYKdyROJDhxHtuAjyW4Uc
         oY5gDtBiXk4H+IIyjPrj8UawxI1nyptQCSnLhsLoGTo8S+TNS8+IDRUkjIF9NN3BzYNX
         s94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667364; x=1745272164;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBSumKkK0GopQQbf4kIGENs+zTxb+YbX4N+rBsmVgUU=;
        b=XuQroUTDtanXvna7Z3oBdxcp/JwwtrTw6QXcLzlD6y6KvRRrGAoMqlzP5OKTUBEj5s
         O02SxdS0X8qcygHVujgp2Hsd7qbj2ZjFB3FQmNJ0BZZBqLf9lWj6Avpof4lGdCvIdDEW
         bFVkwe8IqFCf/mmAt3dvgGfsQmiKICicy5s2CzFmJePjURR9rTHfBsDKFbRq0T/dEQZS
         vLoHQ7jrrb/s0thMmTXOCOiFWzL3i68bH+/1t4pDOnhbT5cQaY9hYE72sAMWPEYxCFKr
         ZOJlPs486y9WSKCyfV3lXE8Jwi8w/Npr5/GRIhMQfzE8MeEz/x8J9EpFyBZlqqdW6g9+
         0hYQ==
X-Gm-Message-State: AOJu0Yzla6Kpu4hOq21B/dBIlYWoub/aKfuKh6eIsWNSQMFg9g6mRf1+
	g/it2CFGPVeFzm3oBFb43dwNJqaifMFLVQKVjdbDS9MBUEaM90hPofDiPp7ZVW4yB5N4739xPO2
	LOOuAe5wgvkz6/I7ykCNPt+ax4mhbWMrQ/ZCPdsPO7krHGQZBnCzuHEaFMIDMJySU1PAgkch8U1
	38d9JgFg8tkQ2rR/NtJFvxKsfh5lTcgruAV9pWMmA=
X-Google-Smtp-Source: AGHT+IGAf9r8FGSlKp+K/4EeU8L9n+YGVWZYWn0f4xUb+jtnHNJ+DjWrf/1g8NbljgvPb7hNXCk6l26e0g==
X-Received: from pfbha18.prod.google.com ([2002:a05:6a00:8512:b0:736:59f0:d272])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2286:b0:736:4110:5579
 with SMTP id d2e1a72fcca58-73bd119d755mr17279180b3a.2.1744667364222; Mon, 14
 Apr 2025 14:49:24 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:59 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-31-sagis@google.com>
Subject: [PATCH v6 30/30] KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag to a
 non-GUEST_MEMFD memslot
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Yan Zhao <yan.y.zhao@intel.com>

Add a selftest to verify that adding flag KVM_MEM_LOG_DIRTY_PAGES to a
!KVM_MEM_GUEST_MEMFD memslot does not produce host errors in TDX.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 82acc17a66ab..410d814dd39a 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -1167,6 +1167,47 @@ void verify_tdcall_vp_info(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_LOG_DIRTY_PAGES_FLAG_TEST_GPA (0xc0000000)
+#define TDX_LOG_DIRTY_PAGES_FLAG_TEST_GVA_SHARED (0x90000000)
+#define TDX_LOG_DIRTY_PAGES_FLAG_REGION_SLOT 10
+#define TDX_LOG_DIRTY_PAGES_FLAG_REGION_NR_PAGES (0x1000 / getpagesize())
+
+void guest_code_log_dirty_flag(void)
+{
+	memset((void *)TDX_LOG_DIRTY_PAGES_FLAG_TEST_GVA_SHARED, 1, 8);
+	tdx_test_success();
+}
+
+/*
+ * Verify adding flag KVM_MEM_LOG_DIRTY_PAGES to a !KVM_MEM_GUEST_MEMFD memslot
+ * in a TD does not produce host errors.
+ */
+void verify_log_dirty_pages_flag_on_non_gmemfd_slot(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_log_dirty_flag);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TDX_LOG_DIRTY_PAGES_FLAG_TEST_GPA,
+				    TDX_LOG_DIRTY_PAGES_FLAG_REGION_SLOT,
+				    TDX_LOG_DIRTY_PAGES_FLAG_REGION_NR_PAGES,
+				    KVM_MEM_LOG_DIRTY_PAGES);
+	virt_map_shared(vm, TDX_LOG_DIRTY_PAGES_FLAG_TEST_GVA_SHARED,
+			(uint64_t)TDX_LOG_DIRTY_PAGES_FLAG_TEST_GPA,
+			TDX_LOG_DIRTY_PAGES_FLAG_REGION_NR_PAGES);
+	td_finalize(vm);
+
+	printf("Verifying Log dirty flag:\n");
+	vcpu_run(vcpu);
+	tdx_test_assert_success(vcpu);
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -1174,7 +1215,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(15);
+	ksft_set_plan(16);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -1205,6 +1246,8 @@ int main(int argc, char **argv)
 			 "verify_host_reading_private_mem\n");
 	ksft_test_result(!run_in_new_process(&verify_tdcall_vp_info),
 			 "verify_tdcall_vp_info\n");
+	ksft_test_result(!run_in_new_process(&verify_log_dirty_pages_flag_on_non_gmemfd_slot),
+			 "verify_log_dirty_pages_flag_on_non_gmemfd_slot\n");
 
 	ksft_finished();
 	return 0;
-- 
2.49.0.504.g3bcea36a83-goog


