Return-Path: <linux-kselftest+bounces-48311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A1CF971E
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F183307BF51
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C183396F0;
	Tue,  6 Jan 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngvY8V64"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD3338F35;
	Tue,  6 Jan 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717670; cv=none; b=cdfPIkWal1toL8/k9E9NVfNqbZHOgnY/dIk1lHkvi98irqjx3HeSA3xhTW48FbNG5ww1MSAExIt9V0RhelACYs7PyHLchvWmCN00aZg+JOXH3fj0V1jcdJ5YhUl5yyjdPCiUMFJWYzMzo2hAgmm/3Vreb3TkT1wqa/GyECCNxio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717670; c=relaxed/simple;
	bh=/9fO9HltczDK8z6tnrwTg+VY6XIFgeW+AlaaLIcWhnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kaAppDaHJMzNtp35UnjSQCxCuc/ly/w3Yt/k1Cort1xdb9UtaMFPBATy6MbDYZoCAKqd20ktR+B5RsdbhO3FC5tAbN/c1vzDxmisikAhF+jntVNqju4a4EeErjCfzvsR77cAHEUoVPdisyfVNL1TKwV4zkvUGl3RfTJ1hdNBK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngvY8V64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2645C116C6;
	Tue,  6 Jan 2026 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717670;
	bh=/9fO9HltczDK8z6tnrwTg+VY6XIFgeW+AlaaLIcWhnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ngvY8V64PZc8rB8bDVqvmPoZxj4H8p048XGdCbQopKMg9mofeMuOJp+f25PiBGbVP
	 JVgdtiaJ06JyTYQMqN3H8ocSZF6S8kbplwRxvwajFZle/PJ8rlPxhZgSbiw2pwVI2j
	 /RcJ1btTK59hFttHwAjU0dudxdr3PofdNIDUvvlAg+eQfV2pNdh5GaccwNq+U2nMWC
	 dTmlpO6lyJp4rTL1L/q45ca+gEa6U+jyNfH8/GB3nwS7CgQSeENkPBtDzj/jYuEoM9
	 rLt5PTZF41q/3+31rBTZ+KYT6PXhbz3prw01gJqK0MPeSL+OyyMAuSG6wg7zttYewx
	 WL3C4kC1aS4XQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Jan 2026 16:35:42 +0000
Subject: [PATCH v4 2/5] KVM: selftests: arm64: Report register reset tests
 individually
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-kvm-arm64-set-id-regs-aarch64-v4-2-c7ef4551afb3@kernel.org>
References: <20260106-kvm-arm64-set-id-regs-aarch64-v4-0-c7ef4551afb3@kernel.org>
In-Reply-To: <20260106-kvm-arm64-set-id-regs-aarch64-v4-0-c7ef4551afb3@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Oliver Upton <oupton@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/9fO9HltczDK8z6tnrwTg+VY6XIFgeW+AlaaLIcWhnE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhsxYa6m3vbbzpCs6JrmKBwp9n3BNfkvWnwynZWZf9kws5
 v3GvjCjk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYSMBd9r8yrz6EvpJ/dGzC
 JXGTzGtBghnzfjut4ouaIXo1/3W/7Wa5W1estnjUM8uqfYxtWSI7UaaqxuYid3T8tKtX4sQrbsp
 VWvcGr7zr2VeycPqGK11zJ3Mw/iiLr5fovsWQaXre0kVx75LP86vZ396p9TU/ftnc1E4vzM+I3Y
 CtdaZRe+7+m+lVpiX278X97pf/3MHc9U73+lwPvql71k0weckVaOfWk/bgVA1nwgmZ4syK998Ya
 j6sbvdu/SzAqnyH1a5+X4rQqh0Mf23y1OffnqfR+c5DStcsasu6b62aFXdM1Y50fc+7YMsvWpqW
 E6lh8vyb/QmH8HWSP2pvb6muefNWlWOWU/Dp2a736l3cAQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

set_id_regs tests that registers have their values preserved over reset.
Currently it reports all registers in a single test with an instantly fatal
assert which isn't great for diagnostics, it's hard to tell which register
failed or if it's just one register. Change this to report each register as
a separate test so that it's clear from the program output which registers
have problems.

Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 84e9484a4899..b61942895808 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -779,11 +779,18 @@ static void test_assert_id_reg_unchanged(struct kvm_vcpu *vcpu, uint32_t encodin
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
@@ -801,8 +808,6 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
 	test_assert_id_reg_unchanged(vcpu, SYS_MIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_REVIDR_EL1);
 	test_assert_id_reg_unchanged(vcpu, SYS_AIDR_EL1);
-
-	ksft_test_result_pass("%s\n", __func__);
 }
 
 int main(void)
@@ -830,7 +835,8 @@ int main(void)
 
 	ksft_print_header();
 
-	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST;
+	test_cnt = 2 + MPAM_IDREG_TEST + MTE_IDREG_TEST + GUEST_READ_TEST +
+		ID_REG_RESET_UNCHANGED_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
 			test_cnt++;

-- 
2.47.3


