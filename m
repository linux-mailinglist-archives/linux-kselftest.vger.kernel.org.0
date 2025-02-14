Return-Path: <linux-kselftest+bounces-26630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D489A35464
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BDB1890AC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2511FDE3D;
	Fri, 14 Feb 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeyoKeOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02115DBC1;
	Fri, 14 Feb 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498558; cv=none; b=jshCidY6PrbztSRjakc0d5I4fHy/kQeEyv1YpRcVYJ6zIBefD7swlpHwGBDg8GalN0GO0beb8zXkkNiIstC+1UuO9cDWO4CGYPiKEQT+YFginvJob6tb9t36riofgtVAmbSz6rPki070Dv3XQeYtlMwCBTaenBF2KEE2QrMG5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498558; c=relaxed/simple;
	bh=JUdjCdwWXgHJ0BQ7rRBLVqj2VAyzOivKMWGTdmvk78E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eg9iE9MR9JdFa0KfgbxVp2i2Mszn+rU4x9/53NT0P0vQE5OSzS8EfW2ufidV0bnjlAVF+60/8SyR2V4kC31hXcg+KtjmDuOEpkFUa+JB7+bQMLQIdBIDyzrD3PGc8jO3rQVcGOMJC/Etfc5iy6ysL7qqm8mP/OUgv6UdV8Sij9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeyoKeOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292C4C4CEE6;
	Fri, 14 Feb 2025 02:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498558;
	bh=JUdjCdwWXgHJ0BQ7rRBLVqj2VAyzOivKMWGTdmvk78E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qeyoKeOq3LhP9SwJ3dlzye1hzKsOi9O59nDkQ9wR+K8pTgNjo+S/ZfmhCKISN0o4r
	 cEtI8SIDEZQPpU7w8M3criu1Z9OgUWVTpAt853sWEHAScHfT6wjI0uOXwFvYbUiuPT
	 BO71i/oA4DL40u/68lQ6RK9TlYWOFZjOsYnzX2yIwIE9dW8oiOoUywrUxkTxUXFVIe
	 M8lCCvf5jphj9aJ4JU/AGwFEs0SWedevBwRjv+UfIXa/kaOjN9HXh+lSELMQWNuXq+
	 HNONRWvJicOqEC3iy29sfsjkV8I+ximjbZYRol6KVy1Qs/UsOEokBqHt+k0KjlJ+hU
	 8KRAjGeSwAllw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:58:09 +0000
Subject: [PATCH v4 26/27] KVM: arm64: selftests: Add SME system registers
 to get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-26-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JUdjCdwWXgHJ0BQ7rRBLVqj2VAyzOivKMWGTdmvk78E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPUAbLtNqVxgMYtHdPngkRqF4iTgj4ko7UuAkVV
 T1f1iQeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66j1AAKCRAk1otyXVSH0J5UB/
 0UwzkUr/qEiXnlx6rIyePn8f5jckMB1M3RPf+amV4dwtmsAm8QQfyd8bs911zisZ9BL96M7+fcGmTa
 NGre1IjHeVBUQJJyDWU/Xl1Dw0C6JEJreVbo7bw6HsB75qGcfrAjol1ntLfOVz8LAkQkyZumOR/8Gp
 xS753HwM55AelORtYtH5kj85HxVajQdFtj8hKTPzMAkhWDvilnSF54j8Hg6kU56o1fEKyeY2Aduoav
 kCw/n5gHQRurY7t9RCpIqPKtgk21Jp1ruUDd+cOlUYInf6nS/sWIsS6oPaGZ4kSyzHlmEn3akF9Nsn
 cp/18KGhFYeOiNJz25LlNRsmD+oInv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a number of new system registers, update get-reg-list to check for
them based on the visibility of SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 32 +++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/get-reg-list.c b/tools/testing/selftests/kvm/arm64/get-reg-list.c
index d43fb3f49050ba3de950d19d56b45beefec9dbeb..3e9c19c4a0d658f349a7d476a90b877882815709 100644
--- a/tools/testing/selftests/kvm/arm64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/arm64/get-reg-list.c
@@ -23,6 +23,18 @@ struct feature_id_reg {
 };
 
 static struct feature_id_reg feat_id_regs[] = {
+	{
+		ARM64_SYS_REG(3, 0, 1, 2, 4),	/* SMPRI_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 0, 1, 2, 6),	/* SMCR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
 	{
 		ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
@@ -52,7 +64,25 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		16,
 		1
-	}
+	},
+	{
+		ARM64_SYS_REG(3, 1, 0, 0, 6),	/* SMIDR_EL1 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 4, 2, 2),	/* SVCR */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 13, 0, 5),	/* TPIDR2_EL0 */
+		ARM64_SYS_REG(3, 0, 0, 4, 1),	/* ID_AA64PFR1_EL1 */
+		24,
+		1
+	},
 };
 
 bool filter_reg(__u64 reg)

-- 
2.39.5


