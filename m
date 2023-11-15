Return-Path: <linux-kselftest+bounces-138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5AE7EC768
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504111F25854
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB01C39FDE;
	Wed, 15 Nov 2023 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7mBQsAh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177533099
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 15:35:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52BF1A1
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700062534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AcyB6Agx9sfZRibieWrvHauKN3lxIyqP/C2CN7o4mVs=;
	b=T7mBQsAh3GS1yGt3MFenFiyAOA1CoeHB0BqaTsbU3mLULkG87CksA/8TphI07LBAnr3p6o
	irj9akLoPvuV3Kav2qqy8BiXk4+pbm0kQ7v7vDBtcxyKoCpCpr69dI1gnrLPuH1lzSnUSP
	rxGxXBEeZRMuslIEJfZtuZmHJX2JMvI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-TXhdF6mIOaqIWZFHTguonA-1; Wed,
 15 Nov 2023 10:34:56 -0500
X-MC-Unique: TXhdF6mIOaqIWZFHTguonA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C81193C000AA;
	Wed, 15 Nov 2023 15:34:54 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 979B32166B27;
	Wed, 15 Nov 2023 15:34:54 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: arm64: selftests: Clean up the GIC[D,R]_BASE_GPA
Date: Wed, 15 Nov 2023 10:34:48 -0500
Message-Id: <20231115153449.17815-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The GIC[D,R]_BASE_GPA has been defined in multiple files with the same
value, define it in one place to make the code clean.

Signed-off-by: Shaoqin Huang <shahuang@redhat.com>

---
v1->v2:
  - Clean up the vpmu_counter_access.c.

---
 tools/testing/selftests/kvm/aarch64/arch_timer.c          | 3 ---
 tools/testing/selftests/kvm/aarch64/vgic_irq.c            | 3 ---
 tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c | 3 ---
 tools/testing/selftests/kvm/dirty_log_perf_test.c         | 3 ---
 tools/testing/selftests/kvm/include/aarch64/vgic.h        | 3 +++
 5 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 274b8465b42a..818854007bfd 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -59,9 +59,6 @@ static struct test_args test_args = {
 
 #define msecs_to_usecs(msec)		((msec) * 1000LL)
 
-#define GICD_BASE_GPA			0x8000000ULL
-#define GICR_BASE_GPA			0x80A0000ULL
-
 enum guest_stage {
 	GUEST_STAGE_VTIMER_CVAL = 1,
 	GUEST_STAGE_VTIMER_TVAL,
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 2e64b4856e38..a48aff110fb6 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -19,9 +19,6 @@
 #include "gic_v3.h"
 #include "vgic.h"
 
-#define GICD_BASE_GPA		0x08000000ULL
-#define GICR_BASE_GPA		0x080A0000ULL
-
 /*
  * Stores the user specified args; it's passed to the guest and to every test
  * function.
diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
index 5ea78986e665..325a8ead0660 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
@@ -421,9 +421,6 @@ static void guest_code(uint64_t expected_pmcr_n)
 	GUEST_DONE();
 }
 
-#define GICD_BASE_GPA	0x8000000ULL
-#define GICR_BASE_GPA	0x80A0000ULL
-
 /* Create a VM that has one vCPU with PMUv3 configured. */
 static void create_vpmu_vm(void *guest_code)
 {
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index d374dbcf9a53..4971e8f77a0a 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -22,9 +22,6 @@
 #ifdef __aarch64__
 #include "aarch64/vgic.h"
 
-#define GICD_BASE_GPA			0x8000000ULL
-#define GICR_BASE_GPA			0x80A0000ULL
-
 static int gic_fd;
 
 static void arch_setup_vm(struct kvm_vm *vm, unsigned int nr_vcpus)
diff --git a/tools/testing/selftests/kvm/include/aarch64/vgic.h b/tools/testing/selftests/kvm/include/aarch64/vgic.h
index 0ac6f05c63f9..9dbb342fd808 100644
--- a/tools/testing/selftests/kvm/include/aarch64/vgic.h
+++ b/tools/testing/selftests/kvm/include/aarch64/vgic.h
@@ -33,4 +33,7 @@ void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu);
 
 #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
 
+#define GICD_BASE_GPA		0x08000000ULL
+#define GICR_BASE_GPA		0x080A0000ULL
+
 #endif // SELFTEST_KVM_VGIC_H
-- 
2.40.1


