Return-Path: <linux-kselftest+bounces-31021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02001A910AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21CB46046C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC422D4EB;
	Thu, 17 Apr 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="husKvgdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E661C3F30;
	Thu, 17 Apr 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849642; cv=none; b=LjCX9NngCIkFg6EqM/0E7ztkNy+kKP7fq5Tf1SEPXpLo1YmB0KtQ/4fG2py8nunOvPLB0jsxpqlpsy34H1b4gc9fEchk3BWN2N+jHeqe/3MxBT1a6hMhfHWxSMniiuUuxfbz4p2rlhXknNr/QBUj4PWSg++3x1TRQ5zYnsUcguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849642; c=relaxed/simple;
	bh=h3hcTuhJ/enbUfNVFyfDycfLuRL7LaoTm3WlqJwa4DQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oa4LEHXMlnsDN3tgPGJXoQmnC6H1yLYKwQ3Lhk/eAwzqyAxZV45hUMypruYcnjx8qzGsXyFygpEksDJQXA2SKs4W2exAKWZ/BD72aOrTLqUDzbC+2sbwv2OLR5wXXx6c105mje1D8rIDttcXENmgUQIqQuvst1rjURFoOmv90dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=husKvgdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2587AC4CEE2;
	Thu, 17 Apr 2025 00:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849642;
	bh=h3hcTuhJ/enbUfNVFyfDycfLuRL7LaoTm3WlqJwa4DQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=husKvgdpNGac4aEmz2a8LrtekbLfHboqcUZTISl25gegAlsSISd2QxneSp4ORGFED
	 fAjrjtPZHo3rBf04uAuXwwvla5fntn/XrZ82Ke/EwuQQnJYiy5M7eh1iN1aqhar+Zt
	 PkqHf1WIUt8dsTwzoZa3rHsHccxTe67whG8iutYEvQs2noL8l0/IcidhhQlTunX7uZ
	 FcoK25ca2+Sc3OB77m9CtMmEeYENFpGjhhcgBqAKYvmdsRgUKFZCUteZWaL/HtXv0p
	 ztd6V3Knvnp20un3cFDtg8z84fZFDOjVCHKvNftyvCixxluxVioAX92QyrbTF14w74
	 Z/MbxIPlt6sSQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:29 +0100
Subject: [PATCH v5 25/28] KVM: arm64: Expose SME to nested guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-25-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=broonie@kernel.org;
 h=from:subject:message-id; bh=h3hcTuhJ/enbUfNVFyfDycfLuRL7LaoTm3WlqJwa4DQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEqCQNyqY3LZseLPc/PyUZbteRvSD1dXOrGL020K
 YedjAN2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKggAKCRAk1otyXVSH0LCbB/
 9BF3Mn5ovMuDqziZZPCiLH51J+v/o26aqdZXm7BidvPRR+1FKOtjOli2O62XceQ9oZxtM4+OatkK8X
 JO9l5Olh4UHg5AxMD1SqwPamsY9cGN0qSk3EuoxHDm6IOTZtpZY81egCAQlJzgTj6uYE5au84H0KdL
 2y9s7VFUIT6+JXKBZfYT1d/0DFqo7VgvFoy4AqnVHTGI8QRqNvKAfdLwaYNFxt5vZE8fp/J7JDY1QU
 0mzm3gp7pIvoy/O73+hqGn/SlmOcZUiQQSwMsWDugQLhL24QeKPHpNJzIEpKfcwtTHj2Dsb6z2HSGm
 PHXHtBAvUK0TBqV7tj/kdmTktd8MjL
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
index 4a3fc11f7ecf..a599216ce1ce 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -841,9 +841,10 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
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


