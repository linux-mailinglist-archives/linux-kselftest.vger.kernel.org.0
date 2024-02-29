Return-Path: <linux-kselftest+bounces-5599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD1D86C17E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 07:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E08E286BD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA244C6A;
	Thu, 29 Feb 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KU0Rzqq9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDC3E46B
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189882; cv=none; b=nJhOnNuQwOJlW+gyhr+uny88crieVK1l9skwQ4CdAk0oOp1ZYw/iAfVFx6lbqVK1wufsqi1cFT7XUCk3nyz6YcZ7Aio0ZZCYMw2gC6FQmsXSPEL9gw6q1Xgqf8U6UALPcG6Ad3rrmhRdx91CcNm+GwOnW4mjrWRn4g35v9clec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189882; c=relaxed/simple;
	bh=kSl3pHe/ihRWWBrf1Tezc0PNoeKDj3aNbp4aK+ZcfUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XD1pcc6VQsy++fQiDWxM2Bb4bM/CQlDdGOJhbVWw+EBdg54X0P7W5eHXSDyjnTDsAFuuGZEA3/q1Tv7LfNwBMAbUxQt1Jq0v5V8435kLeh9jualpVSVrbANX9DJ/FwXyOF2POS3/JQ3yjCHRNjiZIYU0XkSr3zE95RMTuuRS/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KU0Rzqq9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709189879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFmwQWt00Kaj3Ot93eqM53gw7IrZWb5swPo/SmIieP0=;
	b=KU0Rzqq9Th7y+JH2tQUObiwn4ZyMAcaxL0hZECiLoD2XdcWXED+EzNjsW16kGNSDU9SiF1
	hih70MdboIbMXbw6A+Bdj4zrfaOZEjFNgkjG/hBm7psTMzcG1NamEsY4f0aRCP1rdRHqhU
	mkzgBdLYQ+6Dvu8L3odlulNhxqEUN5U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-dGxUhgedMeCDdf-lt5JrlQ-1; Thu, 29 Feb 2024 01:57:55 -0500
X-MC-Unique: dGxUhgedMeCDdf-lt5JrlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55E9B185A784;
	Thu, 29 Feb 2024 06:57:55 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45FF148B;
	Thu, 29 Feb 2024 06:57:55 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 1/3] KVM: selftests: aarch64: Add helper function for the vpmu vcpu creation
Date: Thu, 29 Feb 2024 01:56:19 -0500
Message-Id: <20240229065625.114207-2-shahuang@redhat.com>
In-Reply-To: <20240229065625.114207-1-shahuang@redhat.com>
References: <20240229065625.114207-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Create a vcpu with vpmu would be a common requirement for the vpmu test,
so add the helper function for the vpmu vcpu creation. And use those
helper function in the vpmu_counter_access.c test.

Use this chance to delete the meaningless ASSERT about the pmuver,
because KVM does not advertise an IMP_DEF PMU to guests.

No functional changes intended.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 .../kvm/aarch64/vpmu_counter_access.c         | 33 ++++---------------
 .../selftests/kvm/include/aarch64/vpmu.h      | 29 ++++++++++++++++
 2 files changed, 36 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h

diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index 5f9713364693..e068a0a7a43b 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -16,6 +16,7 @@
 #include <processor.h>
 #include <test_util.h>
 #include <vgic.h>
+#include <vpmu.h>
 #include <perf/arm_pmuv3.h>
 #include <linux/bitfield.h>
 
@@ -426,18 +427,8 @@ static void guest_code(uint64_t expected_pmcr_n)
 /* Create a VM that has one vCPU with PMUv3 configured. */
 static void create_vpmu_vm(void *guest_code)
 {
-	struct kvm_vcpu_init init;
-	uint8_t pmuver, ec;
-	uint64_t dfr0, irq = 23;
-	struct kvm_device_attr irq_attr = {
-		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
-		.attr = KVM_ARM_VCPU_PMU_V3_IRQ,
-		.addr = (uint64_t)&irq,
-	};
-	struct kvm_device_attr init_attr = {
-		.group = KVM_ARM_VCPU_PMU_V3_CTRL,
-		.attr = KVM_ARM_VCPU_PMU_V3_INIT,
-	};
+	uint8_t ec;
+	uint64_t irq = 23;
 
 	/* The test creates the vpmu_vm multiple times. Ensure a clean state */
 	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
@@ -449,27 +440,17 @@ static void create_vpmu_vm(void *guest_code)
 					guest_sync_handler);
 	}
 
-	/* Create vCPU with PMUv3 */
-	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
-	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
-	vpmu_vm.vcpu = aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_code);
+	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
 	vcpu_init_descriptor_tables(vpmu_vm.vcpu);
+
 	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64,
 					GICD_BASE_GPA, GICR_BASE_GPA);
 	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
 		       "Failed to create vgic-v3, skipping");
 
-	/* Make sure that PMUv3 support is indicated in the ID register */
-	vcpu_get_reg(vpmu_vm.vcpu,
-		     KVM_ARM64_SYS_REG(SYS_ID_AA64DFR0_EL1), &dfr0);
-	pmuver = FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), dfr0);
-	TEST_ASSERT(pmuver != ID_AA64DFR0_EL1_PMUVer_IMP_DEF &&
-		    pmuver >= ID_AA64DFR0_EL1_PMUVer_IMP,
-		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
-
 	/* Initialize vPMU */
-	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
-	vcpu_ioctl(vpmu_vm.vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
+	vpmu_set_irq(vpmu_vm.vcpu, irq);
+	vpmu_init(vpmu_vm.vcpu);
 }
 
 static void destroy_vpmu_vm(void)
diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
new file mode 100644
index 000000000000..0dfcc7ab1c4d
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <kvm_util.h>
+
+static inline struct kvm_vcpu *vm_vcpu_add_with_vpmu(struct kvm_vm *vm,
+						     uint32_t vcpu_id,
+						     void *guest_code)
+{
+	struct kvm_vcpu_init init;
+
+	/* Create vCPU with PMUv3 */
+	vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
+	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
+
+	return aarch64_vcpu_add(vm, 0, &init, guest_code);
+}
+
+static void vpmu_set_irq(struct kvm_vcpu *vcpu, int irq)
+{
+	kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+			    KVM_ARM_VCPU_PMU_V3_IRQ, &irq);
+}
+
+static void vpmu_init(struct kvm_vcpu *vcpu)
+{
+	kvm_device_attr_set(vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+			    KVM_ARM_VCPU_PMU_V3_INIT, NULL);
+}
+
-- 
2.40.1


