Return-Path: <linux-kselftest+bounces-4371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBF84E9F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176781C20D96
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104524EB2B;
	Thu,  8 Feb 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+TUfRCd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5C51039
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425352; cv=none; b=ZKCnzaYHayHxT+qL6Nfttv2SPPcfGnR4X6QnZkd/PjhGbew6/c+2iCLTMTo8Xnj1SSaGH2E6suyMM4YaThRT73+Y4P/4gqJ2ZY8lL0Fgz9pFjoUm6F1TaHP1dXuMXBr7G+YtPRkiLFrNdrmvjrZmuAhJYFycMsXEjtbG4R9HXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425352; c=relaxed/simple;
	bh=a6/BPafWl2qCU4XHyBwQAlPOwqYDGt/oKxIvcc90JxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aesw7uuCtQXhsllIqeNF8l0lAq1Fq8JBQ2PdiCp2DgRlSOd8l+cABaKcHGJ/ZQ+c1eSSQFn9Kz7dPlJWNXo9t4a7cAQaHMcK5sUnA03xdIRm+iBegw0VU8JpVlMEW05OjhHoXCU5eeRRekK99ELz5oNOWxBBjcGhs+CTi832Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+TUfRCd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaGh9xZ/5HFHiLGNtP8GrdGABTMwxb0FkMa8tkhhlR0=;
	b=U+TUfRCdOj0WQocvc9gFLsmrF/WM9wfRmz1BDqDaX7g0HObFwOlyUBLuVnn2MxCTcDul+C
	W0xLcT0O9elifHreZJobtqP6kiuMmr2MPvhj4Uj3g/HWe4DywXpd4kHU6+SIhMw8Mjs9Rs
	oMP6cS712lZfjUSNS3PVpEYcjetCB5o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614--pIBS7ibMRStqwKFQtQ0mw-1; Thu,
 08 Feb 2024 15:49:05 -0500
X-MC-Unique: -pIBS7ibMRStqwKFQtQ0mw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BC851C0BB44;
	Thu,  8 Feb 2024 20:49:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE871C10C0E;
	Thu,  8 Feb 2024 20:49:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 8/8] KVM: selftests: x86: Use TAP interface in the userspace_msr_exit test
Date: Thu,  8 Feb 2024 21:48:44 +0100
Message-ID: <20240208204844.119326-9-thuth@redhat.com>
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
References: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Use the kselftest_harness.h interface in this test to get TAP
output, so that it is easier for the user to see what the test
is doing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../kvm/x86_64/userspace_msr_exit_test.c      | 52 +++++--------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index 3533dc2fbfeeb..9591a5fd54d7c 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -8,6 +8,7 @@
 #define _GNU_SOURCE /* for program_invocation_short_name */
 #include <sys/ioctl.h>
 
+#include "kvm_test_harness.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "vmx.h"
@@ -527,14 +528,13 @@ static void run_guest_then_process_ucall_done(struct kvm_vcpu *vcpu)
 	process_ucall_done(vcpu);
 }
 
-static void test_msr_filter_allow(void)
+KVM_ONE_VCPU_TEST_SUITE(user_msr);
+
+KVM_ONE_VCPU_TEST(user_msr, msr_filter_allow, guest_code_filter_allow)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
+	struct kvm_vm *vm = vcpu->vm;
 	int rc;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code_filter_allow);
-
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
 	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
@@ -585,8 +585,6 @@ static void test_msr_filter_allow(void)
 	} else {
 		printf("To run the instruction emulated tests set the module parameter 'kvm.force_emulation_prefix=1'\n");
 	}
-
-	kvm_vm_free(vm);
 }
 
 static int handle_ucall(struct kvm_vcpu *vcpu)
@@ -646,16 +644,12 @@ static void handle_wrmsr(struct kvm_run *run)
 	}
 }
 
-static void test_msr_filter_deny(void)
+KVM_ONE_VCPU_TEST(user_msr, msr_filter_deny, guest_code_filter_deny)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-	struct kvm_run *run;
+	struct kvm_vm *vm = vcpu->vm;
+	struct kvm_run *run = vcpu->run;
 	int rc;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code_filter_deny);
-	run = vcpu->run;
-
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
 	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_INVAL |
@@ -689,18 +683,13 @@ static void test_msr_filter_deny(void)
 done:
 	TEST_ASSERT(msr_reads == 4, "Handled 4 rdmsr in user space");
 	TEST_ASSERT(msr_writes == 3, "Handled 3 wrmsr in user space");
-
-	kvm_vm_free(vm);
 }
 
-static void test_msr_permission_bitmap(void)
+KVM_ONE_VCPU_TEST(user_msr, msr_permission_bitmap, guest_code_permission_bitmap)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
+	struct kvm_vm *vm = vcpu->vm;
 	int rc;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code_permission_bitmap);
-
 	rc = kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR);
 	TEST_ASSERT(rc, "KVM_CAP_X86_USER_SPACE_MSR is available");
 	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
@@ -715,8 +704,6 @@ static void test_msr_permission_bitmap(void)
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_gs);
 	run_guest_then_process_rdmsr(vcpu, MSR_GS_BASE);
 	run_guest_then_process_ucall_done(vcpu);
-
-	kvm_vm_free(vm);
 }
 
 #define test_user_exit_msr_ioctl(vm, cmd, arg, flag, valid_mask)	\
@@ -786,31 +773,18 @@ static void run_msr_filter_flag_test(struct kvm_vm *vm)
 }
 
 /* Test that attempts to write to the unused bits in a flag fails. */
-static void test_user_exit_msr_flags(void)
+KVM_ONE_VCPU_TEST(user_msr, user_exit_msr_flags, NULL)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-
-	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	struct kvm_vm *vm = vcpu->vm;
 
 	/* Test flags for KVM_CAP_X86_USER_SPACE_MSR. */
 	run_user_space_msr_flag_test(vm);
 
 	/* Test flags and range flags for KVM_X86_SET_MSR_FILTER. */
 	run_msr_filter_flag_test(vm);
-
-	kvm_vm_free(vm);
 }
 
 int main(int argc, char *argv[])
 {
-	test_msr_filter_allow();
-
-	test_msr_filter_deny();
-
-	test_msr_permission_bitmap();
-
-	test_user_exit_msr_flags();
-
-	return 0;
+	return test_harness_run(argc, argv);
 }
-- 
2.43.0


