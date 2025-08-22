Return-Path: <linux-kselftest+bounces-39646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB8B30B74
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AF95876D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 02:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72B2BE05F;
	Fri, 22 Aug 2025 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwK4r9Py"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA472BDC04;
	Fri, 22 Aug 2025 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827765; cv=none; b=GgC+33I+9IoXtHG38Zpb6q01Zw2l2d6pXA6rPEBAbT5BLBWfdC/QbviUkfV7INYgByR3hDTeiTCsQ1FJKOMxVs31MYe5miXnBPvIdnruWBMSrl2tpdin+XfQfqCBH26sTzgHejfHUJ2Z6d29OiTgNt9YIe8raFoYdMuD5S1zRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827765; c=relaxed/simple;
	bh=ApIjPu6tr41pN88JrHKurRe18MYIB0RS0vVGxBjI5iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMcRM4cJOUo0iH6eVi2A4wRVc15mIq2PyNkuNkNjSnKkapx0UNDD5oqn77ENPY3dG7r83zwz9yzdhK0LeRhv8klJKLRfgtI0kT1L5OYOpj9Wg4pre8mHvbWdmtl800+AhAAvU8n6kJ+WPEmwOp6dTXi7svuT+8F2z3m/FDjz9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwK4r9Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6900C4CEED;
	Fri, 22 Aug 2025 01:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827765;
	bh=ApIjPu6tr41pN88JrHKurRe18MYIB0RS0vVGxBjI5iI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qwK4r9Py1WNdLXRolIsS2xDD8JZJhqzFwqK+ySVueAtJyHFnEQPFhxQfXvud2TzED
	 AYF1c7+e2p11M2YJHpEuisx5nOTdu2hxjXXLVmBSqYAdD2lS3WYP/oKCAA1QX++V1q
	 XVjl8YMs/q4b3awokyte6bcF5GeVev3zYfeQlVraKxZQuOFRobv0CWwxSddUljpBDh
	 m8wu3T/SfYqaCtXCwNljFPSugY4tG0M/0FJj1yxzeeOJNR/5f3nAkCS9mWbLb5OfHM
	 tWcyM4e5vZLk0/lrGq0g+hJmxHkjNDi2K4tkjymW4vzCLvgrK6TDntzNJie2XU/dxb
	 CgVMyZBlGmuWQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:55 +0100
Subject: [PATCH v7 26/29] KVM: arm64: Expose SME to nested guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-26-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ApIjPu6tr41pN88JrHKurRe18MYIB0RS0vVGxBjI5iI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop83MctByn9lZGlMQrCOz++sZYZV3/BxfsPz/F
 KPOJwdzE3qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNzAAKCRAk1otyXVSH
 0F8yB/sFH7V+bkn2VfS0isUHveeJS62fiiB5c3YS3JAVQ41jZpkvIm2k6AAkqorbB6LxXiwdkrZ
 rx3xTr8Q3KUrjWok7+55CSTU8K/SNKwH2OYYXXYsFKjEPtA7KN+Aaw63IUzqgSmDrovAOUH6SI+
 5Yu0HHJ9CyKK/ghNSJD8QwerdqfyQXeZXucZ62++Yq/02G1e+wJTAyIC2tvqGYcoTEE5z0aKR9D
 VAdEUMAvWAo68qn1FSBneDg6JvJr+TB57KF1XNmpEvHVn5MCTCe8SF7laOSI+ekUFdbhhT1GS/b
 V2ByGttxzG+ZONQtxG4WC8NuL7b3NowIv5Z0Gmfe//B90HqX
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


