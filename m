Return-Path: <linux-kselftest+bounces-23693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 096FD9F976B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255AF188DD00
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69722ACEF;
	Fri, 20 Dec 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcTRhuQb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9EB22ACE4;
	Fri, 20 Dec 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713556; cv=none; b=gOhnoFS87spH+jFQtnK5wI/wB68vj//3pb9cwE+Xa0KVHseiHIisOvpEoO1Fd0EKgz5qXwMcifUivSZTOdxFwlYLkMzRMGVS9M4A6oBIghq0f17RwAWMCVVWsCvkPt0RKwrUyAa+WIMexLmGGE+BcwW/J7fvB/wEiP+eVMrPXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713556; c=relaxed/simple;
	bh=BMpX53mDkGtZeDpM3IZW9C72ZCWeUNb4UNWXTPztxR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0nFU9oFQc+Pzs6RHUGDa9AOLAnVbgtVn9+7qGeXpqr4rCozt+yhoqcb0sPpRL/3rL7OvZsVwswOgwDk+NAUteo5w1EqdnTHbIevzlRwzDtubZ1blnSZZwBKy4npy3hrNwGFT8gmIVI6MIfrftzCi87E5PlQkwSv9q/4QoOOL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcTRhuQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D7FC4CECD;
	Fri, 20 Dec 2024 16:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713555;
	bh=BMpX53mDkGtZeDpM3IZW9C72ZCWeUNb4UNWXTPztxR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qcTRhuQbVKn4fohTb31NbiWO0D8Ehb1pTIFbnDGyigSlNolct15uwnKPDW30WN9g/
	 InDJmbxVv7nCvXjD3DVPbkwyQ9PRtje3M2q26cwrpyEYiFkdAL3E1neCI1t7okf9Tr
	 BSavZ33MJoo9/AZwG3vJ+BLiGJz/THPM/fml2PWgCCONWWZkpR4S9e9TAivK6ho8Dw
	 6IC+mRZdSgCMsES2beqius/z1vXlB9wqzHOaowUjac44j/h8ExH7g1S1sTRFiwzSZI
	 Y5fDpsttSsuN/t/es/H1me2muvwdzJKU6gWpXdgTR47Gbqe4MarxHsZaEuN1kM4Bqc
	 sbX9SYiWzk5QQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:51 +0000
Subject: [PATCH RFC v3 26/27] KVM: arm64: selftests: Add SME system
 registers to get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-26-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BMpX53mDkGtZeDpM3IZW9C72ZCWeUNb4UNWXTPztxR8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBoEEPCkL2wDGSGuRsaO/ZJz1XX7TZ4bauI+Jah
 6W6aufGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgaAAKCRAk1otyXVSH0Nf/B/
 9CYyGIA/2XCRRw7P5W9LfDx3YHsUN+7rm9dYArODfp6zBm+X/B7PQtaGbBl6i/rCOqU/GOy5lM5/Kg
 BE+6jEgB3jtsFmK/vmMuF+xFfYh0FXCRRXK1scYdYQYYSYsuld9+hSuzzGsc0JZpJdUklIZpCAC+ez
 vXERWUzbLNJUOLAs9Vk4sGSVvzfl6VRGBSIQjA40ki/NIGBY2kLC0Mddl/6yWCCjKF1wVSqeckIcnJ
 TzgrBwUzP0ie5VKhvFF5ahucgFbB0fgju+RaDyyPyXXb32tQnPDQWj7n34wclFS5xc+RkwsE0NzVXq
 qLffnpbiwWYywwxNlTq3YrzCMKQUen
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a number of new system registers, update get-reg-list to check for
them based on the visibility of SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index d43fb3f49050ba3de950d19d56b45beefec9dbeb..3e9c19c4a0d658f349a7d476a90b877882815709 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
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


