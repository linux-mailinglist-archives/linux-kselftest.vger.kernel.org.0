Return-Path: <linux-kselftest+bounces-41324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D89B54AEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DB2A05591
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09262302767;
	Fri, 12 Sep 2025 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7U9Zx/6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC0302754;
	Fri, 12 Sep 2025 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676137; cv=none; b=TuONo+Ji5Fi/vW6I88LlAYrCQrjVeEbVUgcjWOV53w9j+VOoTrVMf8LBgz496Omw/Ty/w3AML+sx7u5kdfBONlN+TdgmGBd7WJVDPQt4zBFqi2TP3NlQ3JJNkiwusR3+R9SmRv5fqUuudZl4DioPBUtpBGM/kT2Pj/Ur95zX8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676137; c=relaxed/simple;
	bh=IeBrm10npHswatwOwtRAuiaKWaoJBlDnxxV0/8Ycbl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNaAat07yumcJCY43gMt7Dy2OVCpijmQJhh7Dv//ZRyQm9SieciZe6f+n/FDePr7QmL596VfZDd0UFwIkx3beAWBEp91xneA00oGulvARO6magaM/bBP3UUr+s08QbSBHLiFrDh/c/ttFII0keGxpiwqdMI81GUFVKrztgpYHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7U9Zx/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356F2C4CEFD;
	Fri, 12 Sep 2025 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757676137;
	bh=IeBrm10npHswatwOwtRAuiaKWaoJBlDnxxV0/8Ycbl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h7U9Zx/6aHXAM+5tj6gtPPv0G2aF8WwSGMYHqWTwTkFcejHy6ZqvlTQeqkpGpMBkg
	 rEt+ZG2DqRiuxj/oVnUUkrTReuxciNyZqzHqDZHZSJmlnoahTTq3jI6kncqJpHwvLD
	 ZSrFteZwKViocvHRfODMN1DjklciUy/lO01cZfzCtCypTUxjHC4hJHSan4f2JftKW2
	 xsvUfTo9AdDmB1P5KSwFcYLXxWQMmqVxdXc3UfZp2VoNgsjs0VMcdNn9bRiRhEjfsT
	 czqAnnPYAhS4QN6gao5KI2h/fst2jI6POG0dAiR3MXU33wtNgktbyRymQbeGkvs04X
	 wwFUo0TzoNikw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 12 Sep 2025 10:25:31 +0100
Subject: [PATCH v16 5/6] KVM: arm64: Allow GCS to be enabled for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm64-gcs-v16-5-6435e5ec37db@kernel.org>
References: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
In-Reply-To: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IeBrm10npHswatwOwtRAuiaKWaoJBlDnxxV0/8Ycbl8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoxAJYbjs1gu8XoeJOTzmWGxk48gJgJmlcEt1sN
 LwCLyb43WGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMQCWAAKCRAk1otyXVSH
 0DPMB/9fvrbX2YUDNAXM4i/lFcz1NafZgkZpthkn7QrwZjcoEKj96jMloLwbl6pBdb3E5fIWVe1
 PqCU5ujWX3mUMkpgrumSskfoO7VKMqjfm5GwxEdgY9bRU35oDo2rirXZRyecfQUgqLq1DhObN+q
 ZAWp0lrURcA2PwCz0om5Plb1b9zv0b2TZZ/HkrjQaLQfXZajz+f+t1EeJcEzKqfgOHfR1zh9+dU
 fsVZNXsSdG78RUOtsHZfkDYf2iMXoIrYgHhVM977K6cZC7P/m4vpAUujBf1YnmHPZstLLKoTfZ5
 kbqadCyXSCm/NLJ8xibHuaCqiIwoi6otcOWdEwlmYk2BWidZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Now that required functionality for GCS is in place expose
ID_AA64PFR1_EL1.GCS, allowing guests to be given the feature.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/nested.c   | 7 ++++---
 arch/arm64/kvm/sys_regs.c | 2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 153b3e11b115..d2d55e18c610 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1459,9 +1459,10 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
 
 	case SYS_ID_AA64PFR1_EL1:
 		/* Only support BTI, SSBS, CSV2_frac */
-		val &= (ID_AA64PFR1_EL1_BT	|
-			ID_AA64PFR1_EL1_SSBS	|
-			ID_AA64PFR1_EL1_CSV2_frac);
+		val &= (ID_AA64PFR1_EL1_BT		|
+			ID_AA64PFR1_EL1_SSBS		|
+			ID_AA64PFR1_EL1_CSV2_frac	|
+			ID_AA64PFR1_EL1_GCS);
 		break;
 
 	case SYS_ID_AA64MMFR0_EL1:
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 03fb2dce0b80..60e234422064 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1616,7 +1616,6 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_RNDR_trap);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_NMI);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_GCS);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_THE);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTEX);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_PFAR);
@@ -2953,7 +2952,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 				     ~(ID_AA64PFR1_EL1_PFAR |
 				       ID_AA64PFR1_EL1_MTEX |
 				       ID_AA64PFR1_EL1_THE |
-				       ID_AA64PFR1_EL1_GCS |
 				       ID_AA64PFR1_EL1_MTE_frac |
 				       ID_AA64PFR1_EL1_NMI |
 				       ID_AA64PFR1_EL1_RNDR_trap |

-- 
2.47.2


