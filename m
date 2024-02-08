Return-Path: <linux-kselftest+bounces-4368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E863584E9E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D228287A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5924C3BB;
	Thu,  8 Feb 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrfyKjY5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB8450252
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425346; cv=none; b=ao1rCcAdHgrAhKp1aw7QKSnC3MUso0YU5M0FXQUlCRIAH5+RkVQEAeJHgvy62rbDV4H+zd/SdtN5Z/9oKhBK/wzBZ95fLHt7Igg9ljItXnIfVKp849dgOO/DeRSbu3TjY23EUY/RGA2YOlZf2fMXwZyFn+Kk8BrG2GlukT/OOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425346; c=relaxed/simple;
	bh=W5to7iDa4oRE760XTEaEtgW3bD/CXiFOButwlNgLoZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh3meabCs8YFpc0IDnn6arRH7GY656l7Tx7yNAT9LNg0WsLYVU75eFN9nheU77Ymz7deBp77b7p3x8VewJ4jw/kNPU2+pbzgfNZXaVum2TaivTF19eHs+1re4xa99W80fAZ9DfGXzOfpyjP1guBpYkjLUyZnpRpVR/5k7nwra6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrfyKjY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FjsFqrrKXsl521gM/hDv0+tlQIs54sn7FNkgqZxeow=;
	b=BrfyKjY5BRfX1luHWMPBBC3w669/jrVb6Sz0x9Psd2DNMAeUXeY9fk0lhcKXjDPhMcyLIh
	2zXnPB2xOsEHyTgYWvuilMvVQHFNp/VPMetqtBTCRDh57pJuxlhpQ4ugxsXv/cuUqrZ5kj
	hv3RKp5UQddAtAwS0gK8j8MjBDBUvEQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-Ckeg5F9OOzOY29lxHvM9Pg-1; Thu,
 08 Feb 2024 15:49:01 -0500
X-MC-Unique: Ckeg5F9OOzOY29lxHvM9Pg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75C5F29AA3AC;
	Thu,  8 Feb 2024 20:49:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F46D1C10C0E;
	Thu,  8 Feb 2024 20:48:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 6/8] KVM: selftests: x86: Use TAP interface in the fix_hypercall test
Date: Thu,  8 Feb 2024 21:48:42 +0100
Message-ID: <20240208204844.119326-7-thuth@redhat.com>
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

Use the kvm_test_harness.h interface in this test to get TAP
output, so that it is easier for the user to see what the test
is doing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/x86_64/fix_hypercall_test.c | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 0f728f05ea82f..f3c2239228b10 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -9,6 +9,7 @@
 #include <linux/stringify.h>
 #include <stdint.h>
 
+#include "kvm_test_harness.h"
 #include "apic.h"
 #include "test_util.h"
 #include "kvm_util.h"
@@ -83,6 +84,8 @@ static void guest_main(void)
 	GUEST_DONE();
 }
 
+KVM_ONE_VCPU_TEST_SUITE(fix_hypercall);
+
 static void enter_guest(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -103,14 +106,11 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void test_fix_hypercall(bool disable_quirk)
+static void test_fix_hypercall(struct kvm_vcpu *vcpu, bool disable_quirk)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+	struct kvm_vm *vm = vcpu->vm;
 
-	vm_init_descriptor_tables(vcpu->vm);
+	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vcpu->vm, UD_VECTOR, guest_ud_handler);
 
@@ -126,10 +126,19 @@ static void test_fix_hypercall(bool disable_quirk)
 	enter_guest(vcpu);
 }
 
-int main(void)
+KVM_ONE_VCPU_TEST(fix_hypercall, enable_quirk, guest_main)
+{
+	test_fix_hypercall(vcpu, false);
+}
+
+KVM_ONE_VCPU_TEST(fix_hypercall, disable_quirk, guest_main)
+{
+	test_fix_hypercall(vcpu, true);
+}
+
+int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
 
-	test_fix_hypercall(false);
-	test_fix_hypercall(true);
+	return test_harness_run(argc, argv);
 }
-- 
2.43.0


