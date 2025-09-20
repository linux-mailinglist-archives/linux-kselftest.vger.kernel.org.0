Return-Path: <linux-kselftest+bounces-42007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A72B8D01B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 21:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640567E3C32
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78EA26C3B0;
	Sat, 20 Sep 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGwwqtVP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8226C39B;
	Sat, 20 Sep 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758398307; cv=none; b=BNAq9pC8B7iIyz/TflZSjgvsfRB+JLnT+0Cko4GDTeC1UDeyppfPjBPwHoeQsmoSyIiZZfwPXoyy06f/jGqfwvWtoT0EEy42YEwAZriOPNWsGeX1ygPVmJgsqKdA9cJd6s7HrbxyPy2ZUJv8bH7mkB4kdsRLQQzUGajOOy+q1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758398307; c=relaxed/simple;
	bh=orK/rxMSHEqI9JzhhkIKyObIXyhNnpoojzfzCXkiSJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyLoBTjRXMXiBV7qi1DPNuHea7eEgRs7vp+HhUPG0WrS+SQebMaMnWqLvcvYkJxX/saVcFWgm02YJOGOWZ05uIX1JCfUl/pFgFbbJdt/H/yZKH2Y01SmoRgpXjMUETEYw/HfQVzTTP1KDHcjwmpCYfgfhab+TpzeKOPKR71ip9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGwwqtVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA457C4CEEB;
	Sat, 20 Sep 2025 19:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758398307;
	bh=orK/rxMSHEqI9JzhhkIKyObIXyhNnpoojzfzCXkiSJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IGwwqtVPIQi2VQkNfYuTHsXktRxPjwCCszOKuTTGYejxWYA448m6clFU6KYa2twqE
	 3LfWQhb/R2bVrlVyhy+3JnzhKYLmL4lqC1k8YD5sutx4ZLWX3P+QmYii2lol/dbtkQ
	 1DrBY4W8cTE9ggL9T8WG3TLsp6YV/wz/zk0uhz54Yn1J8rX9ExPoSthg5tIAdvlnGo
	 IyOXK6O4uoPcCRJbw+xOwN9JEWp6BeVIP6oyxklMN67WR7S0is2H9Zmd6V/o+L6p7Q
	 iJRpTiVRLKw3J6No4WAI0hrk8cXYK1mUia/bLjx1/PHeBWoIektrnd1QHxqOWy6uWZ
	 q0Hwm3D0oPFjA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 20 Sep 2025 20:52:00 +0100
Subject: [PATCH 2/2] KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in
 set_id_regs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-kvm-arm64-id-aa64isar3-el1-v1-2-1764c1c1c96d@kernel.org>
References: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
In-Reply-To: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=broonie@kernel.org;
 h=from:subject:message-id; bh=orK/rxMSHEqI9JzhhkIKyObIXyhNnpoojzfzCXkiSJc=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhozz7FF1gnFzGo5dqztrUXrEL71JrXbSCzuBXlZ5hwXZ2
 Ru2z2bsZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAm0pPGwdA4s3zroZU6R9IU
 Xk/4Y2Zmdzp5w8esjpUnI473VIS0iHNcvfrKTla6Unx+wXLBs0rvvkt/Uq+Sy9bmN5oSvTol2EY
 vUCyRg2fW55nF7p/0nM+onP8lqGGo8Z3RWWF+UX85T6zXrTNnnZZrPTBKPrvB++XZENect8kKtg
 2Vm/3NF+YYsVgnmM9rC9dgExZQO/XO/939TlPulV+1DA89WVJm1m/orat5TD2mPGH+3biJny6Ja
 Kr+Urf/dKP/1Sr1nw/+lbq8jfmx36zZzmjajxfxoqai9yrqm49wTGevK3Ln/7GQXeEE24zF1fvE
 81y2ykfGnUv3flont3u92209rW39f/8y7P26pbVgbcIuAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We have a couple of writable bitfields in ID_AA64ISAR3_EL1 but the
set_id_regs selftest does not cover this register at all, add coverage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index bfb70926272d..c7c38b1a1f10 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -125,6 +125,13 @@ static const struct reg_ftr_bits ftr_id_aa64isar2_el1[] = {
 	REG_FTR_END,
 };
 
+static const struct reg_ftr_bits ftr_id_aa64isar3_el1[] = {
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FPRCVT, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, LSFE, 0),
+	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64ISAR3_EL1, FAMINMAX, 0),
+	REG_FTR_END,
+};
+
 static const struct reg_ftr_bits ftr_id_aa64pfr0_el1[] = {
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, CSV3, 0),
 	REG_FTR_BITS(FTR_LOWER_SAFE, ID_AA64PFR0_EL1, CSV2, 0),
@@ -221,6 +228,7 @@ static struct test_feature_reg test_regs[] = {
 	TEST_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0_el1),
 	TEST_REG(SYS_ID_AA64ISAR1_EL1, ftr_id_aa64isar1_el1),
 	TEST_REG(SYS_ID_AA64ISAR2_EL1, ftr_id_aa64isar2_el1),
+	TEST_REG(SYS_ID_AA64ISAR3_EL1, ftr_id_aa64isar3_el1),
 	TEST_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0_el1),
 	TEST_REG(SYS_ID_AA64PFR1_EL1, ftr_id_aa64pfr1_el1),
 	TEST_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0_el1),
@@ -239,6 +247,7 @@ static void guest_code(void)
 	GUEST_REG_SYNC(SYS_ID_AA64ISAR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ISAR1_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64ISAR2_EL1);
+	GUEST_REG_SYNC(SYS_ID_AA64ISAR3_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64PFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR0_EL1);
 	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);

-- 
2.47.2


