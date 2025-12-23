Return-Path: <linux-kselftest+bounces-47898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 182CECD7BC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E52B530041F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1413469F4;
	Tue, 23 Dec 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ+BbwVJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB034679F;
	Tue, 23 Dec 2025 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453016; cv=none; b=SxkrUbs7WRLul2Vi0QRCC1YkjKdn3F/1c4b4f9oAeeLU/7tyCibWQc1uQXbGcKfAtd9oOBZj9BDtFig7T/7KgnWXdIBabrXe1iZfLgl9u+D7FLQPpSx7d4TngJJteUUSGGuef2Zg3CtK9FHSpRO+EnejN031hXGQaVewe2SyFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453016; c=relaxed/simple;
	bh=jbLNcvQ8qxr+FL0J4Bab/tdTijCeYtU2EXCu11Jdphc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjWoOBGCtTzrKNsweNvOlaQ63RM82pfSGX9pHAlZEJKAkfGb4JEouDUQlaHOZY3ZGNUhh+fA9bvpniP2s9m5ZKoxR7x5+GeRVUrYLxtBaEg3pL+oHaYPj+ff3bQgSNRCTJOqLC/FrNKhpwmyZv6JhBWrNSowNckgpjPAqfzzZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ+BbwVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED853C4CEF1;
	Tue, 23 Dec 2025 01:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766453015;
	bh=jbLNcvQ8qxr+FL0J4Bab/tdTijCeYtU2EXCu11Jdphc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EJ+BbwVJ5m3VApHWOcACnEn/Jtbrhz3GXdEHzeekIga3vryGLjkOdmsZwWXvDIOvA
	 BBxgwyPU7COryEy6mVlRZlH1M1GySUOo74ZpZV4vzwnepOJpu3u40EyJeDx5meyyjO
	 t+BakPXpQ/lA/tygjFk+NPGWxCqZXs46AeIkBmL4wL5FQb4EFwmrsu3b07okc/L3Hf
	 QH+5Z2LzInok83O39wAR0otC7kQm9VC9M3uW7HuLvCts3rYVg5ID7FmoN+EXUUCyca
	 MTjafTAzlcXP2WyAS9IdOPmbaOtX/H7zzjRsiT8gDGaEJfou0pOeMmagkWcuVg4qRS
	 qfylhUpbLObJw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:22 +0000
Subject: [PATCH v9 28/30] KVM: arm64: selftests: Skip impossible invalid
 value tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-28-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3644; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jbLNcvQ8qxr+FL0J4Bab/tdTijCeYtU2EXCu11Jdphc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6YjlDBX+enbPVACfxp+aByWhyMVRBBrMoHp
 yKUFjTo7kmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnumAAKCRAk1otyXVSH
 0PAdB/wKnIGQ0YWaL2F/ONZhaNf7iTxCd4x4MoDNmNeqoCkxjB7QvAl3CDHLRjbPZXLqxliOVWW
 n9wi9014gJZ/JD0umqy8ZetSmzKsOQw1mmMhW3nd22zLuLKufd/KC6upoXXMBq56T6yiP5FWnoU
 J4qeY8twwIzjd/zVmXaiK9ZE4RIbMhyhLi4USL89FG08YCzCFBK0ginrTgJ3h255gW6KCzuVm5E
 fOMzXi83SHaSprSXVV2EFXxUsBZXwsyesJAMt/3GSB0xyLcYIlFfPiOI0bwUXJP/tKwj/sSSFbw
 OL2lN0rqRDQ57wtw06kB9PzKMie3b7CaLj2SW44lWrTJRErt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The set_id_regs test currently assumes that there will always be invalid
values available in bitfields for it to generate but this may not be the
case if the architecture has defined meanings for every possible value for
the bitfield. An assert added in commit bf09ee918053e ("KVM: arm64:
selftests: Remove ARM64_FEATURE_FIELD_BITS and its last user") refuses to
run for single bit fields which will show the issue most readily but there
is no reason wider ones can't show the same issue.

Rework the tests for invalid value to check if an invalid value can be
generated and skip the test if not, removing the assert.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/set_id_regs.c | 58 ++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/set_id_regs.c b/tools/testing/selftests/kvm/arm64/set_id_regs.c
index 322cd13b9352..641194c5005a 100644
--- a/tools/testing/selftests/kvm/arm64/set_id_regs.c
+++ b/tools/testing/selftests/kvm/arm64/set_id_regs.c
@@ -318,11 +318,12 @@ uint64_t get_safe_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
 }
 
 /* Return an invalid value to a given ftr_bits an ftr value */
-uint64_t get_invalid_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
+uint64_t get_invalid_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr,
+			   bool *skip)
 {
 	uint64_t ftr_max = ftr_bits->mask >> ftr_bits->shift;
 
-	TEST_ASSERT(ftr_max > 1, "This test doesn't support single bit features");
+	*skip = false;
 
 	if (ftr_bits->sign == FTR_UNSIGNED) {
 		switch (ftr_bits->type) {
@@ -330,42 +331,72 @@ uint64_t get_invalid_value(const struct reg_ftr_bits *ftr_bits, uint64_t ftr)
 			ftr = max((uint64_t)ftr_bits->safe_val + 1, ftr + 1);
 			break;
 		case FTR_LOWER_SAFE:
+			if (ftr == ftr_max)
+				*skip = true;
 			ftr++;
 			break;
 		case FTR_HIGHER_SAFE:
+			if (ftr == 0)
+				*skip = true;
 			ftr--;
 			break;
 		case FTR_HIGHER_OR_ZERO_SAFE:
-			if (ftr == 0)
+			switch (ftr) {
+			case 0:
 				ftr = ftr_max;
-			else
+				break;
+			case 1:
+				*skip = true;
+				break;
+			default:
 				ftr--;
-			break;
+				break;
+			}
 		default:
+			*skip = true;
 			break;
 		}
 	} else if (ftr != ftr_max) {
 		switch (ftr_bits->type) {
 		case FTR_EXACT:
 			ftr = max((uint64_t)ftr_bits->safe_val + 1, ftr + 1);
+			if (ftr > ftr_max)
+				*skip = true;
 			break;
 		case FTR_LOWER_SAFE:
-			ftr++;
+			if (ftr == ftr_max)
+				*skip = true;
+			else
+				ftr++;
 			break;
 		case FTR_HIGHER_SAFE:
-			ftr--;
-			break;
-		case FTR_HIGHER_OR_ZERO_SAFE:
 			if (ftr == 0)
-				ftr = ftr_max - 1;
+				*skip = true;
 			else
 				ftr--;
 			break;
+		case FTR_HIGHER_OR_ZERO_SAFE:
+			switch (ftr) {
+			case 0:
+				if (ftr_max > 1)
+					ftr = ftr_max - 1;
+				else
+					*skip = true;
+				break;
+			case 1:
+				*skip = true;
+				break;
+			default:
+				ftr--;
+				break;
+			break;
+			}
 		default:
+			*skip = true;
 			break;
 		}
 	} else {
-		ftr = 0;
+		*skip = true;
 	}
 
 	return ftr;
@@ -400,12 +431,15 @@ static void test_reg_set_fail(struct kvm_vcpu *vcpu, uint64_t reg,
 	uint8_t shift = ftr_bits->shift;
 	uint64_t mask = ftr_bits->mask;
 	uint64_t val, old_val, ftr;
+	bool skip;
 	int r;
 
 	val = vcpu_get_reg(vcpu, reg);
 	ftr = (val & mask) >> shift;
 
-	ftr = get_invalid_value(ftr_bits, ftr);
+	ftr = get_invalid_value(ftr_bits, ftr, &skip);
+	if (skip)
+		return;
 
 	old_val = val;
 	ftr <<= shift;

-- 
2.47.3


