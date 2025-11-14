Return-Path: <linux-kselftest+bounces-45655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28801C5E0A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 16:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 487954F8192
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3232D0EE;
	Fri, 14 Nov 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3t1aR2c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241732D0C2;
	Fri, 14 Nov 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134737; cv=none; b=kwK4jRI4KAIHJOkdtfaEZ+2Gd5bPSf7i6WMeswlfU55JtV25j+0tBbmKh7Y3In1LuiVN6JAulbmGXZtiTHiAbwiZV8m9xmed819MgQMSTbe8Tis8rNsLYhr+0GT6BuFnRupgdPAZRhvPopEeUzzgyIUz2JRDwpoDCaP3QOnkvtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134737; c=relaxed/simple;
	bh=OOWNdlvS0e5zsqxUjtF1fvoktLBbLPB8K99I3mro3t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFvnWUBCpuusfXMxxM5Fttv0D3PfCmBuoLt9Ct+5sHRwDfU6SVqTNaLHE4ONAB3F8ytKz9T+C0Y/JsrA5wGMvJnQ2tqmwXP6DoXt5Ti8OQSxf7KFD0opZGxU1i4nOn+sh1fmFpkSIg2dfE9lDokP1uIfXemc3mscsoscguyTC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3t1aR2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1CDC4CEF1;
	Fri, 14 Nov 2025 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763134737;
	bh=OOWNdlvS0e5zsqxUjtF1fvoktLBbLPB8K99I3mro3t0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B3t1aR2cw8emhFUhtudXYJsbh2iph2cNegTPxBt7/Sii068LSR22SVKEYGGguBqkT
	 xq5gjfTXccsKRrCIEASxsqJfE2aCtpgKJbaMrXrMmHgUBeCSnTWLtHXt7jtZiLK4jo
	 cpkcM1gK3phnESEfyU/mOk48gotIZxox1quhuLGnUkOH+5OVZT0VM7Kmm9Hi/IgQcw
	 hsMv6msiAyRu3Whn1LlB7lGvwkqxhZoi5zTXH4FcH348sGsKZjwFttpkhy3iQ33mps
	 pTSbkWSvPQap3d27XkyLnNhkC+plVBjz+iRGBAHq0KgQsiRaOVlSmlNqghhwQm/PQU
	 YlGTWt3s6N9rQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Nov 2025 15:35:36 +0000
Subject: [PATCH v2 3/4] KVM: selftests: arm64: Make set_id_regs bitfield
 validatity checks non-fatal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-kvm-arm64-set-id-regs-aarch64-v2-3-672f214f41bf@kernel.org>
References: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
In-Reply-To: <20251114-kvm-arm64-set-id-regs-aarch64-v2-0-672f214f41bf@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=3523; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OOWNdlvS0e5zsqxUjtF1fvoktLBbLPB8K99I3mro3t0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpF00FbT8dIGIkVDBmG9vCD2Uz45dTz5cu1zLgR
 ymKD5kDLf+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaRdNBQAKCRAk1otyXVSH
 0PiNB/9dJS0M4IeUGVK9uzaPxFh3v0wahvRTtIMYA2jaswPqvpgI5LnEbOFGlw1H4PwiyjAcSIs
 kNzSmHcaDnTti8Y6SdWt4A/9QEud4dIDQyYRhP1d8OaxeHLgAwIpftbYoaLuNUTtR7OPsDdgjA2
 HM5HJfXcgAxxiX4/cY5vvNuISm4dK2m17y8Gl0sYrywUdpT7UrYeRbxsdLa4IVayuNnQfGsKKT7
 Dv3RWy0W0IMtX/DencLJ6/mlgr86cinRJxTN869ad/9ue/lq5+J5O7wjC+E9pQWfSQ4MSAWlXpC
 CI9/wll1qp1F4X4mbgB1ZtJtL+ESOU9e6MuP4G4epPmWy7CT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently when set_id_regs encounters a problem checking validation of
writes to feature registers it uses an immediately fatal assert to report
the problem. This is not idiomatic for kselftest, and it is also not great
for usability. The affected bitfield is not clearly reported and further
tests do not have their results reported.

Switch to using standard kselftest result reporting for the two asserts
we do, these are non-fatal asserts so allow the program to continue and the
test names include the affected field.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 1a53f3a4be8d..abe97f9293c9 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -405,6 +405,7 @@ static uint64_t test_reg_set_success(struct kvm_vcpu *vcpu, uint64_t reg,
 	uint8_t shift = ftr_bits->shift;
 	uint64_t mask = ftr_bits->mask;
 	uint64_t val, new_val, ftr;
+	bool match;
 
 	val = vcpu_get_reg(vcpu, reg);
 	ftr = (val & mask) >> shift;
@@ -417,7 +418,10 @@ static uint64_t test_reg_set_success(struct kvm_vcpu *vcpu, uint64_t reg,
 
 	vcpu_set_reg(vcpu, reg, val);
 	new_val = vcpu_get_reg(vcpu, reg);
-	TEST_ASSERT_EQ(new_val, val);
+	match = new_val == val;
+	if (!match)
+		ksft_print_msg("%lx != %lx\n", new_val, val);
+	ksft_test_result(match, "%s valid write succeeded\n", ftr_bits->name);
 
 	return new_val;
 }
@@ -429,6 +433,7 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
 	uint64_t mask = ftr_bits->mask;
 	uint64_t val, old_val, ftr;
 	int r;
+	bool match;
 
 	val = vcpu_get_reg(vcpu, reg);
 	ftr = (val & mask) >> shift;
@@ -445,7 +450,10 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
 		    "Unexpected KVM_SET_ONE_REG error: r=%d, errno=%d", r, errno);
 
 	val = vcpu_get_reg(vcpu, reg);
-	TEST_ASSERT_EQ(val, old_val);
+	match = val == old_val;
+	if (!match)
+		ksft_print_msg("%lx != %lx\n", val, old_val);
+	ksft_test_result(match, "%s invalid write rejected\n", ftr_bits->name);
 }
 
 static uint64_t test_reg_vals[KVM_ARM_FEATURE_ID_RANGE_SIZE];
@@ -485,7 +493,11 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
 		for (int j = 0;  ftr_bits[j].type != FTR_END; j++) {
 			/* Skip aarch32 reg on aarch64 only system, since they are RAZ/WI. */
 			if (aarch64_only && sys_reg_CRm(reg_id) < 4) {
-				ksft_test_result_skip("%s on AARCH64 only system\n",
+				ksft_print_msg("%s on AARCH64 only system\n",
+					       ftr_bits[j].name);
+				ksft_test_result_skip("%s invalid write rejected\n",
+						      ftr_bits[j].name);
+				ksft_test_result_skip("%s valid write succeeded\n",
 						      ftr_bits[j].name);
 				continue;
 			}
@@ -497,8 +509,6 @@ static void test_vm_ftr_id_regs(struct kvm_vcpu *vcpu, bool aarch64_only)
 
 			test_reg_vals[idx] = test_reg_set_success(vcpu, reg,
 								  &ftr_bits[j]);
-
-			ksft_test_result_pass("%s\n", ftr_bits[j].name);
 		}
 	}
 }
@@ -835,7 +845,7 @@ int main(void)
 		ID_REG_RESET_UNCHANGED_TEST;
 	for (i = 0; i < ARRAY_SIZE(test_regs); i++)
 		for (j = 0; test_regs[i].ftr_bits[j].type != FTR_END; j++)
-			test_cnt++;
+			test_cnt += 2;
 
 	ksft_set_plan(test_cnt);
 

-- 
2.47.2


