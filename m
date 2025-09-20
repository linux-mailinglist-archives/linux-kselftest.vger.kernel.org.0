Return-Path: <linux-kselftest+bounces-42006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49DB8D012
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 21:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6121B25315
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B326A0BD;
	Sat, 20 Sep 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CslDXXYX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BF269CE6;
	Sat, 20 Sep 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758398305; cv=none; b=MsHIczI32zOV8uI7vUTdWbxVl3ptmwUtnt9GBlz7/VxEJsVoEfIwmwmeiMvIPjd8+1xth/OcoHW/Pe2xyFOejgth2hkHV4N2E/YFKNNxoIJYmkHRr0Pzl8jeXm8bS3lIsAv0sSYi6uBe5mX4eQpiZsRJ7/l9GxHUJCc/SnSGsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758398305; c=relaxed/simple;
	bh=/PGuPzUPjL3A+P9KZEgqSNbC4HFlPgCGBNUXeYVZjK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJLknsbosoKu9T/eWx3cba4rut+6TZkyFiY/e+Z5mnWh4wx1PtmUrpQbbDhbvXVPAAv7iD9iAlDjVh3qPCWDTYqupVRigZjra8GsNmD0t6TqvgjYYP/w7wUUb1hz+qpsWnkEuBELwq3n6yGf9WETYsALewVe44cqWVihBepgxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CslDXXYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707AEC4CEF0;
	Sat, 20 Sep 2025 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758398304;
	bh=/PGuPzUPjL3A+P9KZEgqSNbC4HFlPgCGBNUXeYVZjK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CslDXXYXuTB9Eq5YwbxWKZ8CSsFsmO6kQaDa37/KASlu98PSgBFB5QMFWl8i4zSgt
	 f8jgz9AJWe76SYrzxjdQ6fKnaP1TKra9ID6lD1lvY2VevmEorWNNekFILptbQgs4SL
	 Hct83s/3S94u/Bn+FeMLsUW/WjcY/I7KaErkcme2v7K/OnMfAcKHqu5B821Re4WH10
	 QNEUchqYxX3Du70yTlNEcAAiVKrrLzyqQG2/S+3VEcLk2prF2QzzBMxOgiL6V+7dk/
	 VKMYqQYEVN7oPdeSaZinTYsiDOjKld5DDV9yClU5j1wcwKvR15tLdBEfOz3KU75gp5
	 AublQ1vm8HDTg==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 20 Sep 2025 20:51:59 +0100
Subject: [PATCH 1/2] KVM: arm64: selftests: Remove a duplicate register
 listing in set_id_regs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250920-kvm-arm64-id-aa64isar3-el1-v1-1-1764c1c1c96d@kernel.org>
References: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
In-Reply-To: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/PGuPzUPjL3A+P9KZEgqSNbC4HFlPgCGBNUXeYVZjK8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBozwdauQ6uUrBMCoPa4Nf0CnLyOqrS6iJbILFgo
 eNy9Y8VhFGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaM8HWgAKCRAk1otyXVSH
 0DrOB/4seDJw2IoI/2DuQs0EWGFEjPs/mkTg6Q3hIla8YNEM/PAhkfyxfa/k12oG131sa14o9Q3
 2OaZgYXZjeYN6id/cK6LYuZxcFKGytrwsgbFYYTxvCnWKTFBTYps8wspfMsx8ET9At+dlt1xbq5
 826QdoYqA/eKgB0OoVYItjHw9kigvKkrHmlPsDlFmvy6WTLRSCGcr3/sDFa6aoC4ckdp5gUKYoz
 wwUqEIoDw7tnq5TbwAM4LgQeqdLTCEgsRbXkJ4u1VswoJABpA/q1CAv9i1BoqQeDT6YhFwcUJiR
 S836wRFSFD/ShHmowSHJrYQTskjp/mCJ7Ha7n+fOtveV2wWE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we list the main set of registers with bits we test three
times, once in the test_regs array which is used at runtime, once in the
guest code and once in a list of ARRAY_SIZE() operations we use to tell
kselftest how many tests we plan to execute. This is needlessly fiddly,
when adding new registers as the test_cnt calculation is formatted with
two registers per line. Instead count the number of bitfields in the
register arrays at runtime.

The existing code subtracts ARRAY_SIZE(test_regs) from the number of
tests to account for the terminating FTR_REG_END entries in the per
register arrays, the new code accounts for this when enumerating.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index d3bf9204409c..bfb70926272d 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -763,7 +763,7 @@ int main(void)
 	struct kvm_vm *vm;
 	bool aarch64_only;
 	uint64_t val, el0;
-	int test_cnt;
+	int test_cnt, i, j;
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_WRITABLE_IMP_ID_REGS));
@@ -779,13 +779,10 @@ int main(void)
 
 	ksft_print_header();
 
-	test_cnt = ARRAY_SIZE(ftr_id_aa64dfr0_el1) + ARRAY_SIZE(ftr_id_dfr0_el1) +
-		   ARRAY_SIZE(ftr_id_aa64isar0_el1) + ARRAY_SIZE(ftr_id_aa64isar1_el1) +
-		   ARRAY_SIZE(ftr_id_aa64isar2_el1) + ARRAY_SIZE(ftr_id_aa64pfr0_el1) +
-		   ARRAY_SIZE(ftr_id_aa64pfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr0_el1) +
-		   ARRAY_SIZE(ftr_id_aa64mmfr1_el1) + ARRAY_SIZE(ftr_id_aa64mmfr2_el1) +
-		   ARRAY_SIZE(ftr_id_aa64mmfr3_el1) + ARRAY_SIZE(ftr_id_aa64zfr0_el1) -
-		   ARRAY_SIZE(test_regs) + 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST;
+	test_cnt = 3 + MPAM_IDREG_TEST + MTE_IDREG_TEST;
+	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
+		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
+			test_cnt++;
 
 	ksft_set_plan(test_cnt);
 

-- 
2.47.2


