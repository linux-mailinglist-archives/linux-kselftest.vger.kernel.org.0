Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B956D49BC1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiAYTak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 14:30:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39026 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiAYTaU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 14:30:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5A8EB81A29
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 19:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D38C340E0;
        Tue, 25 Jan 2022 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643139018;
        bh=btODPc+dZZQjxxnN5VCaILHerPfd9JLeVrfEn0bK9tk=;
        h=From:To:Cc:Subject:Date:From;
        b=dSaFsdFwwAbRTjAdd1rKt01j6MoQhSzqoCXB2ttuKNPsms8UHQdMsW+rxJYBkNFXd
         4MJVsENl3zHU69VdsZWGyNsDBYObbrZbAF3pjvSb7H+Y7C3SJ1xwa6JJGsOJvEDMJ3
         mk7nEIOCoQQk7Mp2qAXTegcOnvX/btKBmaGrEUByTvkl9Tx6t6XESuXU2zwc6comKt
         sAcvRzhvhfCs+wNUclZKB6J8en4RUY5Vcrkv577RFB0T0V+OCeM01kEYSyborXZaad
         MarSneoWjlXL6UAmAosDhFFj7pVAnQPuZ0zfc5oaZAWw1g9RE9mB2GF/wWKzdJefxd
         w9HQo8L8eHpfw==
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest: kvm/arm64: Skip tests if we can't create a vgic-v3
Date:   Tue, 25 Jan 2022 19:28:51 +0000
Message-Id: <20220125192851.3907611-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; h=from:subject; bh=btODPc+dZZQjxxnN5VCaILHerPfd9JLeVrfEn0bK9tk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8E8ZLLSOntKYlRv4TqS2Cfufo39D0QY0X34iBQg9 heFyjdKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfBPGQAKCRAk1otyXVSH0E6QCA CAATGByCssAImuJDJhg0mPnn6WtDIRT6Qdp5QicLgIS0yy84siOHyM/APpEBo8VsO4SzEe+Yt2lxvW +lPjCTHcszqOXLFL0M2kfeilUUqZ36Qy6KcrmalDt+v29KXzcx0xxCUiHTcWCpxN+EdXif4gaThT9z vomXR0usgx5LHcbHkv5rPkbDiR6nFcKVvs0eOaVt2u4OOKvS4eDJVLGW1eXms+DF1AuC94oOGFpQi8 +CgFU2pBd2NRcu1U5NkzEPP8PKj2JCXuk+nR/6V/tfNNcsvh7TrwijEUoKd/Z0eW/4yjk664mCC9Qu wfNB2mnHKn3WCThyad6cQ6YmXjueJv
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The arch_timer and vgic_irq kselftests assume that they can create a
vgic-v3, using the library function vgic_v3_setup() which aborts with a
test failure if it is not possible to do so. Since vgic-v3 can only be
instantiated on systems where the host has GICv3 this leads to false
positives on older systems where that is not the case.

Fix this by changing vgic_v3_setup() to return an error if the vgic can't
be instantiated and have the callers skip if this happens. We could also
exit flagging a skip in vgic_v3_setup() but this would prevent future test
cases conditionally deciding which GIC to use or generally doing more
complex output.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
 tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 5 +++++
 tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 9ad38bd360a4..791d38404652 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -366,6 +366,7 @@ static struct kvm_vm *test_vm_create(void)
 {
 	struct kvm_vm *vm;
 	unsigned int i;
+	int ret;
 	int nr_vcpus = test_args.nr_vcpus;
 
 	vm = vm_create_default_with_vcpus(nr_vcpus, 0, 0, guest_code, NULL);
@@ -382,7 +383,11 @@ static struct kvm_vm *test_vm_create(void)
 
 	ucall_init(vm, NULL);
 	test_init_timer_irq(vm);
-	vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
+	ret = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
+	if (ret < 0) {
+		pr_info("Failed to create vgic-v3, skipping\n");
+		exit(KSFT_SKIP);
+	}
 
 	/* Make all the test's cmdline args visible to the guest */
 	sync_global_to_guest(vm, test_args);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index e6c7d7f8fbd1..8c6b61b8e6aa 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -761,6 +761,11 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 
 	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
 			GICD_BASE_GPA, GICR_BASE_GPA);
+	if (gic_fd < 0) {
+		pr_info("Failed to create vgic-v3, skipping\n");
+		exit(KSFT_SKIP);
+	}
+
 
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
 		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
index b3a0fca0d780..647c18733e1b 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -52,7 +52,9 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
 			nr_vcpus, nr_vcpus_created);
 
 	/* Distributor setup */
-	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, true);
+	if (gic_fd == -1)
+		return -1;
 
 	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
 			0, &nr_irqs, true);
-- 
2.30.2

