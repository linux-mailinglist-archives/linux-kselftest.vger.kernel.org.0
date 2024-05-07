Return-Path: <linux-kselftest+bounces-9662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADFE8BF1EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 01:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE451F22016
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 23:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103F914A4DB;
	Tue,  7 May 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc+rKPV8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB7137746;
	Tue,  7 May 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123461; cv=none; b=eSYtUJIVW49A4mmc3zMv3RPlfH5nag1bB5puy8eOWgRu7gSDoJjw4DyY++80Wxnpql9q0XHKzCLovjDX4l9+KVM5+wrf6dc6aLIN8skaHyfrYTA2i0Obdosg9AWeRc8CKzhKLAyUR6rpgnylSdaGy+cklqxKq0+DOxOXj02o620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123461; c=relaxed/simple;
	bh=XdZxsoASaO5IpIo4VCvpiibSkBtatqEOIr6SGp02oOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEftpGk+lXuUwLF0S+yOTATUxHWr8M0BOMZ7ewmrEyI403Ax00Nz9xdRdzxyNYNio6KCYloe8IA6C1wBr2xwySRa8G9cQtP+I2+Q9hYG+7eaDzH5OLNxQw8JKazBP633o1jiR8XGvMU16U/8exIFSr5SCB1uOe6kJt/xbBZuNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc+rKPV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCF7C3277B;
	Tue,  7 May 2024 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123460;
	bh=XdZxsoASaO5IpIo4VCvpiibSkBtatqEOIr6SGp02oOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qc+rKPV8hknaPxiJQDUoNANTgJMCDq3AudkjQ553yJOMzeIpo/KjV7x5g04bwv2W1
	 S5ttBZkqLallG6yClosavBPf1ZaO/p9tFRe4/g5KmStLmJCmGApy4HAdDPaa5Pfqdz
	 mAN50uMgO6WV+7EQil6lAo9R6SQdkE7sKpnPN2SZJwRNp+79+8vrJlviCvRP7ReesC
	 N+akT5QRdPTagqSo9TIhDisDjhHrNKRzRkKw7ZkgmC7zdzs8Naw1xCLpgYJYRiJAL/
	 k/cgCpERk44slwoutnqR2Oo8M9B6J9xbZayI+sv2Ce5xGNgvFGonN/EkjNbh+l7D0T
	 b7WNgtIDWa7gA==
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
Subject: [PATCH AUTOSEL 6.6 15/43] KVM: selftests: Add test for uaccesses to non-existent vgic-v2 CPUIF
Date: Tue,  7 May 2024 19:09:36 -0400
Message-ID: <20240507231033.393285-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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


