Return-Path: <linux-kselftest+bounces-9661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2998BF177
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126D81F20626
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 23:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1113443B;
	Tue,  7 May 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBAezVF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F5134430;
	Tue,  7 May 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123314; cv=none; b=EAe1s3SjL/L0BmefTN659sp4w4Ea1wCM9TMFNiurrPOPieAytdrbuS1koMTczflLaqF9LI8lJ8PQQWBT5eoNOUe41tYAQ5vfmnLAMrCvcyF9W4mWjJrO8wDEeYQe6DHfedE5jYRywnVCgWD55bDwesd5RnfDfg1U2pu78q3qAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123314; c=relaxed/simple;
	bh=XdZxsoASaO5IpIo4VCvpiibSkBtatqEOIr6SGp02oOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYYVy3fHc2HBju2IZSZ0YD9wto0iDAUeOMGeQwOAPFfI7BgtQFr/jzKg6fW2mIGHoeflCSBj7VL9pXafM62SVgieZE8NwgqvJfx9VfNgyvqLsHkA/FkdgDhM8rkG7TWxH4Umzbm8UBf/PwdC38MulJmjO9qobzGbSvcl5q3haPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBAezVF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26094C4AF17;
	Tue,  7 May 2024 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123314;
	bh=XdZxsoASaO5IpIo4VCvpiibSkBtatqEOIr6SGp02oOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBAezVF62e+hIewTejfWdAkjioagQ2g01AscpYKPN0OBe9IKfrDAVsTHmStSgdE+z
	 AH1V0Zk2js4vMxhRPPFbMXqRG/BpIGJN+r3OVxtnWtp8ee1wDaglE1EA7LowbaVFo/
	 x3nd6pSBY6jplvmE1N06Bg84qL3uInvMw5pGxLzVC/27tqkdQMoyunCXYow4kMAQrz
	 jZFbZAyrAp3FgQAzkgZ525qTW30XMzVFKVDUb55zQF8wHfBIwtO3DKFMtSH0VGX7QD
	 B0HshBE+ush67gj1oRtolTgd5YaDtlQgay8pje/26gQIuxJ1LakC5ZuOPjCllSktRz
	 LV3eJEKgKaELw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pbonzini@redhat.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 18/52] KVM: selftests: Add test for uaccesses to non-existent vgic-v2 CPUIF
Date: Tue,  7 May 2024 19:06:44 -0400
Message-ID: <20240507230800.392128-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Oliver Upton <oliver.upton@linux.dev>

[ Upstream commit 160933e330f4c5a13931d725a4d952a4b9aefa71 ]

Assert that accesses to a non-existent vgic-v2 CPU interface
consistently fail across the various KVM device attr ioctls. This also
serves as a regression test for a bug wherein KVM hits a NULL
dereference when the CPUID specified in the ioctl is invalid.

Note that there is no need to print the observed errno, as TEST_ASSERT()
will take care of it.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240424173959.3776798-3-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/kvm/aarch64/vgic_init.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index eef816b80993f..ca917c71ff602 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -84,6 +84,18 @@ static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type,
 	return v;
 }
 
+static struct vm_gic vm_gic_create_barebones(uint32_t gic_dev_type)
+{
+	struct vm_gic v;
+
+	v.gic_dev_type = gic_dev_type;
+	v.vm = vm_create_barebones();
+	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
+
+	return v;
+}
+
+
 static void vm_gic_destroy(struct vm_gic *v)
 {
 	close(v->gic_fd);
@@ -357,6 +369,40 @@ static void test_vcpus_then_vgic(uint32_t gic_dev_type)
 	vm_gic_destroy(&v);
 }
 
+#define KVM_VGIC_V2_ATTR(offset, cpu) \
+	(FIELD_PREP(KVM_DEV_ARM_VGIC_OFFSET_MASK, offset) | \
+	 FIELD_PREP(KVM_DEV_ARM_VGIC_CPUID_MASK, cpu))
+
+#define GIC_CPU_CTRL	0x00
+
+static void test_v2_uaccess_cpuif_no_vcpus(void)
+{
+	struct vm_gic v;
+	u64 val = 0;
+	int ret;
+
+	v = vm_gic_create_barebones(KVM_DEV_TYPE_ARM_VGIC_V2);
+	subtest_dist_rdist(&v);
+
+	ret = __kvm_has_device_attr(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0));
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+	ret = __kvm_device_attr_get(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0), &val);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+	ret = __kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0), &val);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+
+	vm_gic_destroy(&v);
+}
+
 static void test_v3_new_redist_regions(void)
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
@@ -675,6 +721,9 @@ void run_tests(uint32_t gic_dev_type)
 	test_vcpus_then_vgic(gic_dev_type);
 	test_vgic_then_vcpus(gic_dev_type);
 
+	if (VGIC_DEV_IS_V2(gic_dev_type))
+		test_v2_uaccess_cpuif_no_vcpus();
+
 	if (VGIC_DEV_IS_V3(gic_dev_type)) {
 		test_v3_new_redist_regions();
 		test_v3_typer_accesses();
-- 
2.43.0


