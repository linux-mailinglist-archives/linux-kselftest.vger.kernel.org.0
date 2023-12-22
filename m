Return-Path: <linux-kselftest+bounces-2399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E0081CD09
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730F61C20919
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182D28E24;
	Fri, 22 Dec 2023 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM2fnupJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4C3A8D2;
	Fri, 22 Dec 2023 16:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F381C43391;
	Fri, 22 Dec 2023 16:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262174;
	bh=Eqiu1chagGhTcnIyOpiBJNSkyCxEQeYdYSo/PeIYJMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hM2fnupJZ2dUFAbuswYsLHLGcq5mTuLT7biQIYRfWs6U+M9nlNdxcisjV3M3Ae8HI
	 a3yjltfjiDqOR/tXISi4i9dWSiNKTTYIZ1BLKlhR1DZXGu6KJHxQR/wS81INyB7ewh
	 ABNjmqTPwSs0pLMx8hxT8nKKJGWn16o1mgg5Ubc7REEFwu2u92q2OUymfLIK6Lr5YB
	 zhGUdQk6DtKAMPd37c/5X5V4N3EauozcwwTpaD11vMm2hN46Pe/YybRbltxpN/3/1F
	 +t7h7r6P4nkdNcqMwIvEAu81mLfeDUHXJ5xBxb3RoHTsFXb+tz+zFcVJjbl2txJbJ2
	 +KS6AS4YzN4fw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:30 +0000
Subject: [PATCH RFC v2 22/22] KVM: arm64: selftests: Add SME system
 registers to get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-22-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Eqiu1chagGhTcnIyOpiBJNSkyCxEQeYdYSo/PeIYJMQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeNVsaHrnnQbngnHuBuqjYI/Pj9JtsW1ceX0thP
 H1P3vLWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3jQAKCRAk1otyXVSH0OXZB/
 sFtZLoRSmnBHVnWocfVXVf1Tp6VNNZUksZt4QbQHRwrB3mqNXn+9/LKkfTHwUsPXxopybxa/5ck4GG
 a/lV0DMG9RFKajFgYAn7ZI+akjBlJ5ZEbStV/AkhIl6iGR7WSgbdydiE/unuPxPJmi6kWc4SpLisgm
 ck5gNvGQKDqZH4jcf5p9M40xsfMyRM/fKTquuvUqBaglN8fxetIitmz3U2UWwVuEjXH6BJjOAdO+oO
 4NTjR7wWH2WRhP+/ckvYqB0vKKq7Jgtfa4OQhtBWvTBzorlkij2O1wQ1cbL9q4RPJE/04nnOMY6avI
 k75ee+yxu5jigUBRi/eU59nKP6mKb5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a number of new system registers, update get-reg-list to check for
them based on the visibility of SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 709d7d721760..a1c2853388b6 100644
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
@@ -40,7 +52,25 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		4,
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
2.30.2


