Return-Path: <linux-kselftest+bounces-44427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B9C21057
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F35D934890E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3F365D20;
	Thu, 30 Oct 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFvIALRb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB83655F3;
	Thu, 30 Oct 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839249; cv=none; b=HDSOc4ItsK+kRPMO3jux4t/JnWFBu4zpBgm+Ygqa/jNk1mFcxj+j7fR/aCB8kiJ4/9ZKy/yxEuGXqyKGjDON56TDwfLKC9mURzr8LOeK6pldrFO5nKi5syzk3kGwdOZyLJw/HGpXQPn/gahN9dwx83Pc6UWqM+kj906b5nhKS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839249; c=relaxed/simple;
	bh=NZCHWtWgDq5zz30CCAR3ifMlNJpsHOdaSLoln4mIKFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfpyC9defKqVUkKDWvTg9ZHRstNMhpHA4fH+x1NmyE3kcl2Pk+y6ghZp76NvoalVtjYYU+ggRWfb3Scs62Buwe28hgmhDLuotaF3n5c58ndz27xqPnlfRHP48HH3eKCbM1LmjZm+UnpqEJqrXxicOWFvcIPvzXS/Cu6AML1yFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFvIALRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE71AC4CEFF;
	Thu, 30 Oct 2025 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761839248;
	bh=NZCHWtWgDq5zz30CCAR3ifMlNJpsHOdaSLoln4mIKFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FFvIALRbAweVCw2UoxmIuKV8ciopyH/0U0RPhAY6EFh+wONWJWJG+paNTnnWtK+mv
	 itTIuVHb/sK7nVeUQSiWAvSIY5l6QIerAxUvsxSTCg0cwOmfr6OSS09tVxn+2mrigC
	 t/fAmJOfIDPfpU2LjAkqUMsFOuzAHdLDrQL+oJ5iLvDDKiV6f567WMFtBsFMYNFBZ/
	 DbyH0ZH6+STkyfdfsUgObz6blaPGNiH1IZB407FTa6NL+dIopu/Zb1YP52nth2F+NM
	 IdG8qsWfP11gL4NEFgJnHpvoO1JqFe/3Fox3ES+rvzQ2PBsHP14yU1ZY7+z3uTjN+V
	 w74/54Prjl4vg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 30 Oct 2025 15:42:48 +0000
Subject: [PATCH 2/3] KVM: selftests: arm64: Report register reset tests
 individually
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-kvm-arm64-set-id-regs-aarch64-v1-2-96fe0d2b178e@kernel.org>
References: <20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org>
In-Reply-To: <20251030-kvm-arm64-set-id-regs-aarch64-v1-0-96fe0d2b178e@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NZCHWtWgDq5zz30CCAR3ifMlNJpsHOdaSLoln4mIKFs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpA4iGyvPLC38rdS2RIy+FJ+eOECrgfTa4QqA8i
 pePN12GnbCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaQOIhgAKCRAk1otyXVSH
 0EMVB/9sVxjcnfn5VzQgHVPjt2KP3qIKdpSoNTV6oWRIyMcs56td9lA4MRkrfXW8dkGbbZMd8gH
 Xz9rdLGvnb2/gHZnT1+z2HA5WEt06Od6luR+XPAEFMZ64ibXEHdXx8OhdemAspmT+Tk9eyy7ijc
 Gx+efN/IGXq1EeuEmVo75d8c6pk+IZ/Kpi6qHKBfNJcYdE0pAgjBtZumqiEnC5dVFWitMzzp8bY
 pcmTw4W5Z8Tvzs+raAD1H/FSktJihHS5kn/6u7QDaDQOG3g+C71dRh5kgz9JvcD92hEZq2KWcqM
 eh5JqP5bcc42u5QeIo7ZKML3+inb4wQrpaFrGQ5ZBZwRxYGI
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

set_id_regs tests that registers have their values preserved over reset.
Currently it reports all registers in a single test with an instantly fatal
assert which isn't great for diagnostics, it's hard to tell which register
failed or if it's just one register. Change this to report each register as
a separate test so that it's clear from the program output which registers
have problems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 7a759e976c2c..1a53f3a4be8d 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -775,11 +775,18 @@ static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encodin
 {
 	size_t idx = encoding_to_range_idx(encoding);
 	uint64_t observed;
+	bool pass;
 
 	observed = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(encoding));
-	TEST_ASSERT_EQ(test_reg_vals[idx], observed);
+	pass = test_reg_vals[idx] == observed;
+	if (!pass)
+		ksft_print_msg("%lx != %lx\n", test_reg_vals[idx], observed);
+	ksft_test_result(pass, "%s unchanged by reset\n",
+			 get_reg_name(encoding));
 }
 
+#define ID_REG_RESET_UNCHANGED_TEST (ARRAY_SIZE(test_regs) + 6)
+
 static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -797,8 +804,6 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1);
-
-	ksft_test_result_pass("%s\n", __func__);
 }
 
 int main(void)
@@ -826,7 +831,8 @@ int main(void)
 
 	ksft_print_header();
 
-	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST;
+	test_cnt = 2 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST +
+		ID_REG_RESET_UNCHANGED_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
 			test_cnt++;

-- 
2.47.2


