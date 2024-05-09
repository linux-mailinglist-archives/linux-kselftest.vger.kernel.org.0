Return-Path: <linux-kselftest+bounces-9781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3529A8C0D13
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 11:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B668E1F22497
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070514AD33;
	Thu,  9 May 2024 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyPsAZIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DBE14A607
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245560; cv=none; b=q6hBJSgK2V7aqbY31+w8ZOxNax+tuTES+fzJfBb5kzDFOMvAGAEoofkRZWtB4/Gr7xaKKDHLkLVWdIpHK7F5Uc55hz3X3tERDga0jGXT2ugNukrl+qdI6V5q+YY4uU9810r3+bhRe0ZUZy7IRbrIxFGepuOYnq3oLEL/wxcMwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245560; c=relaxed/simple;
	bh=hj1bCLnGW1s9WC31t5+30WoQ76gkkE4+6pZQzPj8yY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXEwxJ5guS6PoWsybmfnstqE2ZMVa2CMKbbRrr+XE4pVzSITeOJOdZq8mUA1BPjnG1VECEmgBaHAN6KOG0lR88oHCDRcc2qaSH/eXM9rZHqxlkhSMkbzgXJL49UpTtVpVgy4AyKipw77uqdFObtIDVZIQG0Lz06Ncc4vAhQLRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyPsAZIB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715245557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NXpcLQliZ9Cbk0k+GmVaEC4VBS+fcjmTXXyvgY9tgs=;
	b=HyPsAZIBD9Bb3GTpyfV2nDd3hl9G8FywSXxVpnWGdm9tgREapzhPsXFHpHsPr8FzE2hkGv
	aYOifY+OXgd6Mj5eQoIGsmd4Jmx35sJJprlBqRAl/gWhcnFFkxozvnQzwELgi4O0DQDAVW
	uPu3TPtg3hfAG9zxJwQJ9HPxzLGor+w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Wn9zvxr1NOqVJLTTDMODkw-1; Thu, 09 May 2024 05:05:53 -0400
X-MC-Unique: Wn9zvxr1NOqVJLTTDMODkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FEC3101A54F;
	Thu,  9 May 2024 09:05:53 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1889B100046E;
	Thu,  9 May 2024 09:05:53 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v8 1/3] KVM: selftests: aarch64: Add helper function for the vpmu vcpu creation
Date: Thu,  9 May 2024 05:05:38 -0400
Message-Id: <20240509090544.2063429-2-shahuang@redhat.com>
In-Reply-To: <20240509090544.2063429-1-shahuang@redhat.com>
References: <20240509090544.2063429-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Create a vcpu with vpmu would be a common requirement for the vpmu test,
so add the helper function for the vpmu vcpu creation. And use those
helper function in the vpmu_counter_access.c test.

Use this chance to delete the meaningless ASSERT about the pmuver,
because KVM does not advertise an IMP_DEF PMU to guests.

No functional changes intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 .../kvm/aarch64/vpmu_counter_access.c         | 32 ++++---------------
 .../selftests/kvm/include/aarch64/vpmu.h      | 28 ++++++++++++++++
 2 files changed, 34 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h

diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index d31b9f64ba14..68da44198719 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -16,6 +16,7 @@
 #include <processor.h>
 #include <test_util.h>
 #include <vgic.h>
+#include <vpmu.h>
 #include <perf/arm_pmuv3.h>
 #include <linux/bitfield.h>
 
@@ -407,18 +408,8 @@ static void guest_code(uint64_t expected_pmcr_n)
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
@@ -430,26 +421,15 @@ static void create_vpmu_vm(void *guest_code)
 					guest_sync_handler);
 	}
 
-	/* Create vCPU with PMUv3 */
-	vm_ioctl(vpmu_vm.vm, KVM_ARM_PREFERRED_TARGET, &init);
-	init.features[0] |= (1 << KVM_ARM_VCPU_PMU_V3);
-	vpmu_vm.vcpu = aarch64_vcpu_add(vpmu_vm.vm, 0, &init, guest_code);
+	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
 	vcpu_init_descriptor_tables(vpmu_vm.vcpu);
 	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64);
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
index 000000000000..5ef6cb011e41
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
@@ -0,0 +1,28 @@
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
-- 
2.40.1


