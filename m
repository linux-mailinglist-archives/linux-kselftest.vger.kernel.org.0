Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51E549CCC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiAZOwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 09:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiAZOwv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 09:52:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62061C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 06:52:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BD66162C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 14:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EBBC340E3;
        Wed, 26 Jan 2022 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208770;
        bh=jm4UyXrKg8K/tVEMOvInmlJVENOimmSLeYrRFZ3iAhE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ct7qB/ZAGMxyNqXRG5A9kCT09NEZ3jSt5gRRvrD5WPAeCAP7Ht1/9Kb4YXZ0ioABC
         1mUvtkpMZ5F+ErEYve2etOfyiQCtPRTgKobkRgRm0CsXyfwO6mTKReroCii81W28WE
         DCPfcwYlFdillSzeKUpo/AnjSBxQVGHKok6SGuwImxnDl+baMWEtdZJ2UJPNSjiBuw
         F7n/gZySkP9wPLElD9Bx1JWgsUOAsYVDvSC2BfvtTXlZyqtoi2dDXHMIo2neBtQ7Gl
         9yuIT2DLTB+/pjuzde2hJwpwQTJq1jZubLm5pMcFKguOjarfsPY7g6q9QcOqBsMR9J
         zp2y2+L/0dWDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a vgic-v3
Date:   Wed, 26 Jan 2022 14:52:42 +0000
Message-Id: <20220126145242.3473836-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3473; h=from:subject; bh=jm4UyXrKg8K/tVEMOvInmlJVENOimmSLeYrRFZ3iAhE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8V/S6QVgi5cZ6m4uINQ0R+IA6o/Pp0GxJxgH2V3E xbqPOk+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFf0gAKCRAk1otyXVSH0Ae2B/ 0cD5U10nc39f3kDDOT/XI0PcJ6n6+O+Wc+lW1Mvs8Pj+qd4x7AbZPV4WZ1YL+x2l6I9FsJpEcMLnz1 rrkOnaCc1SJMDQ15wqRrLXVEXAgIW2w88TjGfTBnpgHxVX4CVmuxkpZUrXK/kD2xJORtfO8gae5ilD eX4+iMqFnu+VIirw5oCuwQPpkQR6CNYkJE7rQ8rosa2RZvZjWcQ3s59GxVayil+06kOM7urphERRuI bjIJ0f7QRkGebZ7gsvWKCIbU+zXqtQNu3ifb9ZEVU7Rje9XUr9hoeFzv7aYgKJlQ1gp1HzSIlLPo/9 N8Tu08HBMIvpai5MVPE6zE92vTnuDN
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

v3:
 - Use custom print_skip() helper.
 - Use internal version of _kvm_create_device.
v2:
 - The test for being able to create the GIC doesn't actually
   instantiate it, add a call doing so in that case.

 tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
 tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 4 ++++
 tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 9ad38bd360a4..b08d30bf71c5 100644
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
+		print_skip("Failed to create vgic-v3");
+		exit(KSFT_SKIP);
+	}
 
 	/* Make all the test's cmdline args visible to the guest */
 	sync_global_to_guest(vm, test_args);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index e6c7d7f8fbd1..7eca97799917 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -761,6 +761,10 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 
 	gic_fd = vgic_v3_setup(vm, 1, nr_irqs,
 			GICD_BASE_GPA, GICR_BASE_GPA);
+	if (gic_fd < 0) {
+		print_skip("Failed to create vgic-v3, skipping");
+		exit(KSFT_SKIP);
+	}
 
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT,
 		guest_irq_handlers[args.eoi_split][args.level_sensitive]);
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
index b3a0fca0d780..f5cd0c536d85 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/vgic.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -52,7 +52,9 @@ int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus, uint32_t nr_irqs,
 			nr_vcpus, nr_vcpus_created);
 
 	/* Distributor setup */
-	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	if (_kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3,
+			       false, &gic_fd) != 0)
+		return -1;
 
 	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_NR_IRQS,
 			0, &nr_irqs, true);
-- 
2.30.2

