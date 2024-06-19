Return-Path: <linux-kselftest+bounces-12221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A890E590
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7AB1C21481
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 08:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFEC80045;
	Wed, 19 Jun 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ/6Iq5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698BB80026
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785947; cv=none; b=ELZVXV8qra29mClGivkz0kYAEhp2QxecoJ1sGdQ2dmC1BLSAmYgxHnmXXQreHP8IpYFy1HxlAGkUshxGVNabJSASexQ89zO8IhBlxP4H0ouVJt5IaNe2881rojfjsmbSscCVla47YahcwAy6IYRW0Myos34V7+uPNBgFuKaS2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785947; c=relaxed/simple;
	bh=I96RkC4xfGimI+iZ2geT9XHUh0BU0vYjRgveulZ7u5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IH7RBjEsCVtUWpwvhipT8p8Be7iodNKRaYnvxaeDHOoGUJosM+e1nmWz35DuwgjhUSmozI59tzwjkMmx5G50kDiAlYvzq2S1Fn7mYk9HzwU83FU0jITJJEWo108pE0/5xwvh9whc8pIvXIVTdZ2RseB6O19HsGJvLuzfTKbouRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQ/6Iq5n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718785945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOUVrsFqTcI6hNO1ofc9efuSDWP7z/I3VahfSx2CWU4=;
	b=UQ/6Iq5n/shMcV8u2KsVSSmsrEAvPtf0rg3hKhKVBvqLGB8ODo+eBCw7voIu9ufRKRZngY
	tO1RwW8Lw+fSIbXLaLHN4GRMi9LtmBoq89Zi7XvHlWK+7oq2K/90EvP6K43N5AVkFQF8rL
	u6t0aIIc+lRgWW/SXN2Uj3Aa0qvNJU0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-bwNdooy7PYmIH39rXBvjfw-1; Wed,
 19 Jun 2024 04:32:21 -0400
X-MC-Unique: bwNdooy7PYmIH39rXBvjfw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA4ED195609E;
	Wed, 19 Jun 2024 08:32:19 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D43C19560AF;
	Wed, 19 Jun 2024 08:32:17 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Shaoqin Huang <shahuang@redhat.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/3] KVM: selftests: aarch64: Add invalid filter test in pmu_event_filter_test
Date: Wed, 19 Jun 2024 04:31:56 -0400
Message-Id: <20240619083200.1047073-4-shahuang@redhat.com>
In-Reply-To: <20240619083200.1047073-1-shahuang@redhat.com>
References: <20240619083200.1047073-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add the invalid filter test which sets the filter beyond the event
space and sets the invalid action to double check if the
KVM_ARM_VCPU_PMU_V3_FILTER will return the expected error.

Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
---
 .../kvm/aarch64/pmu_event_filter_test.c       | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
index 308b8677e08e..1abbe6d8deb2 100644
--- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
@@ -8,6 +8,7 @@
  * This test checks if the guest only see the limited pmu event that userspace
  * sets, if the guest can use those events which user allow, and if the guest
  * can't use those events which user deny.
+ * It also checks that setting invalid filter ranges return the expected error.
  * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
  * is supported on the host.
  */
@@ -31,6 +32,7 @@ struct vpmu_vm {
 
 static struct vpmu_vm vpmu_vm;
 
+#define KVM_PMU_EVENT_INVALID 3
 #define FILTER_NR 10
 
 struct test_desc {
@@ -181,6 +183,40 @@ static void destroy_vpmu_vm(void)
 	kvm_vm_free(vpmu_vm.vm);
 }
 
+static void test_invalid_filter(void)
+{
+	struct kvm_pmu_event_filter invalid;
+	int ret;
+
+	pr_info("Test: test_invalid_filter\n");
+
+	memset(&vpmu_vm, 0, sizeof(vpmu_vm));
+
+	vpmu_vm.vm = vm_create(1);
+	vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
+	vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64);
+	__TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
+		       "Failed to create vgic-v3, skipping");
+
+	/* The max event number is (1 << 16), set a range largeer than it. */
+	invalid = __DEFINE_FILTER(BIT(15), BIT(15) + 1, KVM_PMU_EVENT_ALLOW);
+	ret = __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+				    KVM_ARM_VCPU_PMU_V3_FILTER, &invalid);
+	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
+		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
+		    ret, errno);
+
+	/* Set the Invalid action. */
+	invalid = __DEFINE_FILTER(0, 1, KVM_PMU_EVENT_INVALID);
+	ret = __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
+				    KVM_ARM_VCPU_PMU_V3_FILTER, &invalid);
+	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
+		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
+		    ret, errno);
+
+	destroy_vpmu_vm();
+}
+
 static void run_test(struct test_desc *t)
 {
 	pr_info("Test: %s\n", t->name);
@@ -311,4 +347,6 @@ int main(void)
 	TEST_REQUIRE(kvm_pmu_support_events());
 
 	run_tests();
+
+	test_invalid_filter();
 }
-- 
2.40.1


