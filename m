Return-Path: <linux-kselftest+bounces-40586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF5B3FEA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414807B4226
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE830F54A;
	Tue,  2 Sep 2025 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3U/VCcT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D230EF90;
	Tue,  2 Sep 2025 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813576; cv=none; b=TbdrbakFqoeE9wULvZH4LVHVjNZzTZkGxnQkM5U2SiAWhmRg8DSbdln0/CSzoZxQgfafVYwXj0bo23CCkhu/GIPqA12ewdu8LhaTlgqcRi3op3rDmtxDShtXlQ1cbxYht1N67i0uRomUEI4AIKZCndBVjJR02F75QFHrkNLJOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813576; c=relaxed/simple;
	bh=ApIjPu6tr41pN88JrHKurRe18MYIB0RS0vVGxBjI5iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hofk+kC47w8cZ40idYU4mAann+Nj5GdqynuGfdyvocVceTwWzfvLbWN8lO6oXs0MCIvlC8vshVPTPjJkRRmJ1DTgHw/R9NDaJqpfGxWrgnHaHXVAcJdgm7qHpjKD33lOrhkO/YhO4l3iDDTKUQquMUTZm+Y3rogGMDfYEtWkTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3U/VCcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBF7C4CEF7;
	Tue,  2 Sep 2025 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813576;
	bh=ApIjPu6tr41pN88JrHKurRe18MYIB0RS0vVGxBjI5iI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y3U/VCcTyDJrfmX5N1I3ma4BNaMP6NnjIsplzE8qqNmwu2XCxAwPUL27++y15kkKf
	 BmsUHdrWff0+p/dch1o3gGe+npIHUciHViJNy5RewFkc2eTGS73eT+87n5zjbvIgHL
	 +d/B7S5l1MZcDikktnMIhVP+ZZp6Y4hPurHVL61m5+8pDKMhvsge7DALAiAvF3xK2R
	 hBLIVSVdNSk1LVU8EuI/NB2BwDVEi1MCNj6EHElJ3Gcj8x0FhilbvHTC5mIfcYCzey
	 OoVIK7Ua1fA02entp4HnJ4vr9YmZ2mJGEjIFto/pZJ13T/znl9czAGX9fYee9/n676
	 1bhOcFyHloFpw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:29 +0100
Subject: [PATCH v8 26/29] KVM: arm64: Expose SME to nested guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-26-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ApIjPu6tr41pN88JrHKurRe18MYIB0RS0vVGxBjI5iI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiOkZba4yI6s4kTrmrdeDhrz3ok1FUW6bPBY
 q74Sa3+y/iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYjgAKCRAk1otyXVSH
 0B0eB/4yoHkWE2bYFaQkDOX1dyrxupmFWVwQPQqDQ5u01j8CCEG7HlTowkwPc+l3bqfDugrPdSs
 ZXSIAHLlcppfcijjwVmDKC6HpLNxG0f6rNy9DoxM6eHanWIjJaLs5yEqk5pmIjALIdPSxy5YnFL
 7Owmj00+UDfilbqgmg1xdquA/jc0f9GICTfWllO8jkhzkQ9c8RgG9IKIGmV2InLCvYof3+ws3el
 ICGQ2kZL2svSg4O2ryDcK2wiottcvFbIIVqEGwrrARywl16wkp8mSHgNvJoETdt5ZfF2N615sry
 knnXAMcPzDGKO8TnyWmDB2E891gSf86fdlPcyRkiV7wt8SbY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

With support for context switching SME state in place allow access to SME
in nested guests.

The SME floating point state is handled along with all the other floating
point state, SME specific floating point exceptions are directed into the
same handlers as other floating point exceptions with NV specific handling
for the vector lengths already in place.

TPIDR2_EL0 is context switched along with the other TPIDRs as part of the
main guest register context switch.

SME priority support is currently masked from all guests including nested
ones.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 153b3e11b115..804694f2dc9a 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1458,9 +1458,10 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
 		break;
 
 	case SYS_ID_AA64PFR1_EL1:
-		/* Only support BTI, SSBS, CSV2_frac */
+		/* Only support BTI, SSBS, SME, CSV2_frac */
 		val &= (ID_AA64PFR1_EL1_BT	|
 			ID_AA64PFR1_EL1_SSBS	|
+			ID_AA64PFR1_EL1_SME	|
 			ID_AA64PFR1_EL1_CSV2_frac);
 		break;
 

-- 
2.39.5


