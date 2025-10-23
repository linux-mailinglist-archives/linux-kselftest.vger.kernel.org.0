Return-Path: <linux-kselftest+bounces-43963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D84C03E1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 01:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA74E05C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 23:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83118296BD4;
	Thu, 23 Oct 2025 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0/l3WWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE6727F00A;
	Thu, 23 Oct 2025 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263380; cv=none; b=X9GyIpglGvGskzpqaXEBUeeqpEIgTMXaud0Ij3KOpDpeJXU1THtuIvETAC6TYS4fRaMhVT8ZZsK0G8jnxVGeG9UcuD3AzXbWUWXVB/efsoxb9Fo9MR5cj6gZTYCL4ILOuSr6hynIZ8NIKA/zhKQZFBMVOf2X5dOuIaiNAr+cHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263380; c=relaxed/simple;
	bh=mlPjpupG6YFu3WZLIE4LsuGTPZmpesaS7fkVRKnB3lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aqU33sJ0ioFbdb6XZdzEFu7RoavoUSJyW6PrlijTJqS7zvaQoLEqusxyRp65yc+JdqfY8xCdP2HNahslBojI759fp83aujO0dM60EmJeazgNPqJV5DSoJ271tjn2QCRBwOvhLgzfpIL+oZvsm445BToaWRyIDGA9GCTMBGSZY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0/l3WWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B16C4CEE7;
	Thu, 23 Oct 2025 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761263379;
	bh=mlPjpupG6YFu3WZLIE4LsuGTPZmpesaS7fkVRKnB3lw=;
	h=From:Date:Subject:To:Cc:From;
	b=t0/l3WWYWLbBTQOHmNsyP23wB1Z5kdA1Je7bN6WcAXfXa3DXM2nBZi+kZ7/MGqcqs
	 ZtbQYYT4BD5rCqJLmzFMYUULpnyNXGx12yGfKLt14jFzO++9+O2UZlWrW2wbkCuT98
	 9afI+0ohwixDO2Z+f3b4nvBBzV5YdhKHjqgz2OCqZxuvxqb5GXoodOFTiFqeWn+IiP
	 18ajZwl7+bgiYnwprfxHgGqtytnhISHpp1NE0uCNQ9n8aqVNgZztwY6agaATmQu4Rk
	 qyxByaKbqEQV7NZYWDplCuruNvnbyOO/K6evKOgDHy3q2ensVTnaF3wUm2Afy2SLUd
	 lDG/JVCoijDoA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 24 Oct 2025 00:43:39 +0100
Subject: [PATCH] KVM: arm64: selftests: Filter ZCR_EL2 in get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-kvm-arm64-get-reg-list-zcr-el2-v1-1-0cd0ff75e22f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKq9+mgC/x3NQQqDMBBG4avIrPtDMlGhvYp0IekYh6qViUipe
 PcGl9/mvYOymEqmR3WQya5ZP0uBv1UUx35JAn0VEztuvOOA9z6jt7mtkWSDScKkecMvGmRixDq
 4uxPvBw5UIqvJoN9r0D3P8w/+AbhYcAAAAA==
X-Change-ID: 20251023-kvm-arm64-get-reg-list-zcr-el2-c43090e11f23
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mlPjpupG6YFu3WZLIE4LsuGTPZmpesaS7fkVRKnB3lw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo+r8QxY2JcsLXKRY9i3x2+USWkDSHg3bd2J9tr
 4x4LkFf+W6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaPq/EAAKCRAk1otyXVSH
 0KCsB/4sY4EU2Z485tooicTVWlxHlXnwLdrbACENRpSPR8AbNunmliL3tXgWrtUwaY1HkI8dpox
 OQV7mIl0CF1dNQVv94MyAum8RMJXHtzE/ecPLWToGYxAC6nNQrxlndg2NWqsa+poVrXpTdPbe3X
 TCuitoGMhhLSMX0eQiS4MOQEJA/dKMWNVu33FeioSKBJbW5fkJsnE6cgYSpDYaio/B/7ltDkfrY
 +9xmQPYzMNKdIJLUCcCpJWqKsQ/8VUTk4IKG9BkZQMSTYO6XykhzS97kEng26H1qDac+moC3+Jq
 87S+6fNn+tBG6QUWAKmsXaRQuXR+QV+uASWRNXKN1DUjaDOR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

get-reg-list includes ZCR_EL2 in the list of EL2 registers that it looks
for when NV is enabled but does not have any feature gate for this register,
meaning that testing any combination of features that includes EL2 but does
not include SVE will result in a test failure due to a missing register
being reported:

| The following lines are missing registers:
|
|	ARM64_SYS_REG(3, 4, 1, 2, 0),

Add ZCR_EL2 to feat_id_regs so that the test knows not to expect to see it
without SVE being enabled.

Fixes: 3a90b6f27964 ("KVM: arm64: selftests: get-reg-list: Add base EL2 registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/arm64/get-reg-list.c b/tools/testing/selftests/kvm/arm64/get-reg-list.c
index c9b84eeaab6b..7ae26ce875ad 100644
--- a/tools/testing/selftests/kvm/arm64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/arm64/get-reg-list.c
@@ -68,6 +68,7 @@ static struct feature_id_reg feat_id_regs[] = {
 	REG_FEAT(VNCR_EL2,	ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY),
 	REG_FEAT(CNTHV_CTL_EL2, ID_AA64MMFR1_EL1, VH, IMP),
 	REG_FEAT(CNTHV_CVAL_EL2,ID_AA64MMFR1_EL1, VH, IMP),
+	REG_FEAT(ZCR_EL2,	ID_AA64PFR0_EL1, SVE, IMP),
 };
 
 bool filter_reg(__u64 reg)

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251023-kvm-arm64-get-reg-list-zcr-el2-c43090e11f23

Best regards,
--  
Mark Brown <broonie@kernel.org>


