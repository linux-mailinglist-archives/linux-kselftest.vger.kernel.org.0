Return-Path: <linux-kselftest+bounces-34959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22211AD9566
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351DF3A4623
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30172EB5CD;
	Fri, 13 Jun 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWCKb+js"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2323239E7A
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842099; cv=none; b=a56sSaQx+jh4bpqwCNaWn0MVCG1XP78tsvBkaRmkO7KG9qrem50rNOQyYycP8irFHRJkUDENC7a3rgIoVbnRBuLGKDMz106py4mf3JKZ+Hf3kYP+kcTzBbWMmmfVPsiTmxy2YDpN+FnQq2hfneJfUFWBAkNUo8sRSiLKL7oZaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842099; c=relaxed/simple;
	bh=RY9vOJOTnPoQGM71RK4CQ3oaie3GZfCxmMPWtcit47k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f78hoy/s1S5R3Bq+cJ4eon5tTdvd5RIb5krnWvPgEkhR/Y8jICsktoTyPm7FRk7RI49GYDlalMea7iNdI5pKPEFiN3puGdxwL9BFxwPswxEdmBLbnrIqTKTap/WI/amBkkY5oM5xMeU+fqWPRpvLciLPbdm6tus4tMkepaiCnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PWCKb+js; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e98ee3fcso3002295a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842097; x=1750446897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yEGB1XBlJyFOc33mF8HkysHzlE2Wpy4+59tD02EfyJ4=;
        b=PWCKb+js3f+k1T+cL+SeXTWAXJaJYEvyUOzF0edP/sQOdVA5DpO02easxFkGp8czLB
         BfsFL4ZvW8soJz+z0kYNCYj3qGuKfFcHfOEvuF8E3v4/inN2I+gzEHRkUiyHWEm0GzF1
         Nxc6RtvwYxGkwv0yua3bKg+tyatrmKcjiOXb23wPAAEFNcuQfW6Nh0FtcVdaOFUf4Vqg
         WUsGESPPMq/HBq5tNbSoHNk8kBD4y6crALRPaefWzMtD6+1Lk+33ZhA33AHjxaz+cFFW
         hq8o7GDBPYsXgXRBwbjX6qWHfRK1f2J6htuaU3mBGTmoMQozaW5xjQ//6zAwZsYuWTr4
         BVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842097; x=1750446897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEGB1XBlJyFOc33mF8HkysHzlE2Wpy4+59tD02EfyJ4=;
        b=gFyiJN5IkrOIwe+V9C/kevvKQ6FtcbT5MMphkmleoeKmSzgp09lGqYKB0HCyN62LhF
         FL8fGFahqDasoCQGzzVUURCUiHoBM7Bb+UQVw7YCr4L6iJigv2ipEtge4TxmzJJcEfhC
         AkerSibYSZv2OLtjZE4GEwImZixjCZMXR8rP2Ib5h4i0oGRs29L5maH1dVzC6uGCkNtu
         7dEe/fijjj/zuOYYKyDrK6yRS80fSaZ0yKfPWNEw/0JQRKo6YxVkgfo18hlB8ALTyJfM
         mplVY/PeBmafcWEX4t6An9TU5vmz20byaOo301XUzd+IWcmpBYIZOappInqjIoER9vHy
         Ezmg==
X-Gm-Message-State: AOJu0YzVzoobzSDcAZWOHjUsyP44mFw+ykAMLPcS2VlMLhLbOAY7B8Gn
	E0Ka31xsNQ1axiURC9nxKrSb0HksM8zQuXQ+jwTday94WoQBNw4g7Vu4yVTL1Xot/nVUl8r+Tkw
	dQ+vpD4jCzFisxxlIMuM+ut7tjf0qUMwJtM+r98nXjl2xKVAUVFxF05arCUjsC/oKeoYf633EzY
	FuFCbDLFPyhXke8Gsjkg1IbLLdEJJ4xUlAEgKAkm8RxWk=
X-Google-Smtp-Source: AGHT+IFFuR69PJDd7BsIpTM0aA+lzThoYubZQJbh5cEx7KYbBwGWGloMSfcPdi3XNIgGq89r5XPgiBtCPw==
X-Received: from pjyp8.prod.google.com ([2002:a17:90a:e708:b0:311:ef56:7694])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17d0:b0:313:d7ec:b7b7
 with SMTP id 98e67ed59e1d1-313e90c5ce8mr2569833a91.13.1749842097051; Fri, 13
 Jun 2025 12:14:57 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:57 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-31-sagis@google.com>
Subject: [PATCH v7 30/30] KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag to a
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
2.50.0.rc2.692.g299adb8693-goog


