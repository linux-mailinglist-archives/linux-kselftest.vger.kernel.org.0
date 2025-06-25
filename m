Return-Path: <linux-kselftest+bounces-35768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE1AE814D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBF71890DF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C52EF9D6;
	Wed, 25 Jun 2025 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzRDGd80"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518F2D5409;
	Wed, 25 Jun 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850780; cv=none; b=ICzeC7JNRKQk7hlI3PThRu0MbOzHmVW87K/6ULH2+Mcte7OrS1fH5lQSkb/HfVEzw9ZPDomWQuu6I4egY61c/IWlmZVIy5GiEKKkut3WzblTthve6mSgSueCelfQHG8XWZvkH2iVSaprUL4URTYlRee4QiDGNleGwEgC+QcD/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850780; c=relaxed/simple;
	bh=WD7Qdl+8RLPaAAK0jVM2Hhe8rXkw7WP2aSYuPJ67M/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=frDHxedtgp4IUFgbzMVJ0/4Yyva9SxN3ro9/e+RWtDY7xvK9Jm3SQ2QivnLf/NIN/g+CVK2QlxUX8Q29q2jE+CfdKXBuxfcVEUDku9bc0JTzIbsBuIUvUinX3+IgBnfiwkNrlLSGU6hXO5KkomBm5RQb7zSHVhF1n7sKV7VqFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzRDGd80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A962C4CEEF;
	Wed, 25 Jun 2025 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850778;
	bh=WD7Qdl+8RLPaAAK0jVM2Hhe8rXkw7WP2aSYuPJ67M/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EzRDGd80v1T245DORt+m7lyT/phx2cMHa6Bmx3wSaBUv807/ZAbWRHNjVD0PV9rss
	 p0R+INLGwxcn5rgLMXiLMMG9tZx/z+fdW30XVXgUnpETuj7kqu8olCzWZtlivzvSeD
	 8AHxwSJG6nnRxGmnIuLs1OZN2qOtOgIKvztoWSS3yKD1a0FgIVprLTkXOrEb74mg2V
	 Sg9beXfaT2OQpWNforpr7JzNDggWasBEoweuoMzswUkxjpLGCx1MsAG0yA/uc1IG9U
	 8QJsytPThyQYE1ymwEaOpwd1b3H2j8WFPyC1zeivKGLe9MeZQYfc4+QVL3ECLCWD/r
	 R3rw1u07jJpQA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:16 +0100
Subject: [PATCH v6 25/28] KVM: arm64: Expose SME to nested guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-25-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WD7Qdl+8RLPaAAK0jVM2Hhe8rXkw7WP2aSYuPJ67M/g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9x4iTmgZQfqDlvOFBXIQoOeOfmXAs97MM384
 e38IEaxSD6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvceAAKCRAk1otyXVSH
 0I+rB/90XLlA//CNIkOF15gb5lFWd9Gk5kUpa6TKktgykbrMG3194zYAKMl6f1qOP628gc1tIHx
 w1BsKTfiukZB3i2iPdTWjpc3UkK4qfQIpMNmje1Ksse+lVQC7tL0x2gN5hRGao9w6C0m+tKwMOB
 9Rv0Ij6RJdbNWxaHQBjX7Q3BKaqdP9nMNAFinfRJr1nMyV3NRrTzTtUFa83R39+tdw6azfSCO+U
 qYiVuJ3porNhbLVq03b8Sj7vLVpzrX4gVyHxD/sB8w6OdT3ARonMKxWrlO6FYsQuC936U2gE2wm
 BMElLujtN0Fay6KKAkR+gHcDPGsUExmWmY4lUcmya2IIJ2q4
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
index 5b191f4dc566..9a03439dab90 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1442,9 +1442,10 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
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


