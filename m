Return-Path: <linux-kselftest+bounces-44234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04367C16FAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC3F3AD051
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6A351FB6;
	Tue, 28 Oct 2025 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjIt/cYh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297F358D28
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686480; cv=none; b=jnk/Sc6BCAsc4OfadySlqmNNN78xY69Lfi0oli6Hi+e9eH33tJoVv3rJe4JeLQhCWmlGuAdbskj61JFmd1ug3D5p3dE7DYC7o7Gk+2bDuggt9Epz3THPNhZx29OqSFdQTeF7Z3lx3E/6nYGsa5N/HAuMwBz34z0yIzTZd5PjqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686480; c=relaxed/simple;
	bh=qfaC2A7mPzRh1wHLGzIzthw0+fibjKOEou+mOk9ZG90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsWXpltHbSHj44hSyYUvFiq3LR6F91ZKkJX2O1LNDy5kqsbkphfNCIBvcNdGsGRwQDADayeAQlHdFUsMt3SIARKA6s1a/cNzzJ65I9r+pYaUeW6zufchBgaVVKyfAGqL+1n57U7Ql5QN1zWs96LqbSkXk7yk4mZZhe0WiO3EOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjIt/cYh; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-654ebc6acd1so6015384eaf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686477; x=1762291277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CS0IWmflrx758IAyyWQq7DhPqTRvRcCDsa+nQ4BIQi4=;
        b=WjIt/cYhRMQxSZ5dj4nZMe59IdNEzIK3M2gwoVZnS9HaVvnNAUGW41Dmo9hvB18AWi
         HojWpk0TsgiKE9Siofje5YOY9lCbKVmsoAfORCdmYWcolEV9wKIxKm1gJY1M1mjOwk6f
         qTrECfQcbjFFWAADt08y1udDkHzuQMlVStg+W3wqGaRuGPrfF+Gd3DN5YwcUbHH1hD8s
         oOiC2v6GK9p5yXyIxMUGsdBfZnZYEBoWvAzVCtRNNCFpF3LSQlvgAwQpZHzKY8/B/Vq5
         TkBQTIgUmNXeAE15G5mIo2c4RWaklhfacDAlFNttebSREsUSU72ImvbyfFPcrPi2GkcA
         a0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686477; x=1762291277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS0IWmflrx758IAyyWQq7DhPqTRvRcCDsa+nQ4BIQi4=;
        b=wBg3HzOHnS91T1CE+syukYnikCRENiCvJmx5eYAtg33nKC/vpUUxOzIQf2xtEjzj8N
         EaSTcc2BekI7cJxMVd8FikONU7VkdkT4/zd7SeZj/cfAtOLyh0UH5Y6xLTQAUdd7T8Kg
         RgjEH2goGjK4LuwBZegyj8mKaI/eJYbZ6UBMWeaqjIv6zvKKotDqsJb+o8yxeOKc5tzL
         ep1/AOfPcXhy9aUrXFXfDaeMUgn4HEFLVq3vTDaFIS++8y9Mrwx9OyYeOY7otGtPhdM3
         HUDu4ysMRbqLchBkql2qW/imn/peqrKuTx0Az66OyH+1LMRPBNdFjZ4U8h7T+slbzWDK
         ENZg==
X-Gm-Message-State: AOJu0YxZuP45ygtFTItBFMLr8QGg8v1ke/sWP4cmgtqeefxI2ty4bKSj
	G0h8o1jyO6dOEKLGtHB8Lx2qPFeYm1PlfGmm2m4Qq9bqgujyeLDRXr9nK0cZlJbCJtrnRQSXwDg
	4727h1LbTCyzdhj0D4x4iZmKNysL45U1XA2uwUAXf5rI/ouqebnRAq7n8oW3JPNJNsNRSQn7qFk
	+bTbQ3eaXttcKE/pI4XTStupl67BmcjDflAsmsRp4q8eE=
X-Google-Smtp-Source: AGHT+IH9FCcaXI/EKUJmw3moCTxbFHd52ZJluIjy8ghlVGUWeAZZptsgmg2AF7Kqcixt3CD2LMrRRymXIA==
X-Received: from oabcr6.prod.google.com ([2002:a05:6870:ebc6:b0:3c9:a56f:e0b7])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:6081:b0:3d2:f13:698c
 with SMTP id 586e51a60fabf-3d74b26bce8mr402771fac.32.1761686476891; Tue, 28
 Oct 2025 14:21:16 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:49 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-24-sagis@google.com>
Subject: [PATCH v12 23/23] KVM: selftests: Add TDX lifecycle test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding a test to verify TDX lifecycle by creating a simple TD.

Signed-off-by: Sagi Shahar <sagis@google.com>

---------------------------------------------

Changes from v11:
 * Removed vm_tdx_create_with_one_vcpu and replaced the call site with
   vm_create_shape_with_one_vcpu
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  8 +++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 33 +++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/tdx_vm_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index b7a518d62098..2f49c8965df9 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += x86/tdx_vm_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index dba2b3d558d1..7cd70ff15412 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -369,6 +369,7 @@ static inline unsigned int x86_model(unsigned int eax)
 #define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
 #define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
 #define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
+#define VM_SHAPE_TDX		VM_TYPE(KVM_X86_TDX_VM)
 
 /* Page table bitfield declarations */
 #define PTE_PRESENT_MASK        BIT_ULL(0)
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 2467b6c35557..f8e1c4d92a7a 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -11,6 +11,14 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	return vm->type == KVM_X86_TDX_VM;
 }
 
+/*
+ * Verify that TDX is supported by KVM.
+ */
+static inline bool is_tdx_enabled(void)
+{
+	return !!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_TDX_VM));
+}
+
 /*
  * TDX ioctls
  */
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
new file mode 100644
index 000000000000..a37ab0fb2a97
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "processor.h"
+#include "kvm_util.h"
+#include "tdx/tdx_util.h"
+#include "ucall_common.h"
+#include "kselftest_harness.h"
+
+static void guest_code_lifecycle(void)
+{
+	GUEST_DONE();
+}
+
+TEST(verify_td_lifecycle)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_shape_with_one_vcpu(VM_SHAPE_TDX, &vcpu,
+					   guest_code_lifecycle);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char **argv)
+{
+	TEST_REQUIRE(is_tdx_enabled());
+	return test_harness_run(argc, argv);
+}
-- 
2.51.1.851.g4ebd6896fd-goog


