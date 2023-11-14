Return-Path: <linux-kselftest+bounces-102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D037EB252
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14322812A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D093FE51;
	Tue, 14 Nov 2023 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ9jhbCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67B41236;
	Tue, 14 Nov 2023 14:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FD3C116B8;
	Tue, 14 Nov 2023 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972592;
	bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NJ9jhbCZtT33Qvof3TlCzkkFhz5s+fq7thPKABIDhzv7DUXN8pq3oHHiIRGSktlnL
	 72ejabE3GFSkmCUq/2YFLnc+cZDPYbw0e/kjIyvkxRWtZbyYGa4IiJQfayH/fIfkqf
	 92R+7hAZa7klpM9Fb0GqNK+XEUE7cWnUj4IcowB8lyqnbVzb1oLcEUMcgl1XsDtcnV
	 300Bv9ThGLCHhms8Hq8sl+5ZoO8zlP7QoqX9W/DysaVyRU0errvieR7fHGoiZpOZST
	 U0uJMg3MijVfNMRWpz05QcirghdcvKuGLyvSxIm27WI84zoGz+Ce42un29uyb65Mlm
	 XCncXueZaM1RQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:35:06 +0000
Subject: [PATCH v2 21/21] KVM: arm64: selftests: Teach get-reg-list about
 FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-21-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uwufjRPZpufB4WAKz4BvxO1YI+sO9dPrjMMi385iZbk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WljyZx9r11YL8tcSv5B8kuEfjpvUQEKebxv1Zj
 Tas9auiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFpQAKCRAk1otyXVSH0BRGB/
 0eKQ35FdG4nEY5EMIhWlYN7NyAik/Z8VmcnuImgEnedGuih5QNXSXGmyTcg+eoM3Ug+sF+9HdXnYs6
 r7BGS+4K0FAIhZ8EemtAZnN7MHTkCtiaWndEdzRG4u9ekRHwvcfslpdgQoETJVHO6h0n2/gRIpZGlI
 90D1oWpNyYWZjFpTh61erW89DUsGuj0ljQU26xo5eMnef9S3riMClGoK/1AqLOtlu/98ZZ4ebfvCI6
 gh0C7bmQdtzP2sd32hYuAJk6OUQ8etGAoh9fxNtgUKKSZLRhfTCIkBjGkrhMKR6W9/MheCeCvIADvH
 bKXZvUhzzWTmEAEKQBIeFt8R0l5BPO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_FPMR defines a new register FMPR which is available at all ELs and is
discovered via ID_AA64PFR2_EL1.FPMR, add this to the set of registers that
get-reg-list knows to check for with the required identification register
depdendency.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 71ea6ecec7ce..1e43511d1440 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -40,6 +40,12 @@ static struct feature_id_reg feat_id_regs[] = {
 		ARM64_SYS_REG(3, 0, 0, 7, 3),	/* ID_AA64MMFR3_EL1 */
 		4,
 		1
+	},
+	{
+		ARM64_SYS_REG(3, 3, 4, 4, 2),	/* FPMR */
+		ARM64_SYS_REG(3, 0, 0, 4, 2),	/* ID_AA64PFR2_EL1 */
+		32,
+		1
 	}
 };
 
@@ -481,6 +487,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 3, 14, 2, 1),	/* CNTP_CTL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 2, 2),	/* CNTP_CVAL_EL0 */
 	ARM64_SYS_REG(3, 4, 3, 0, 0),	/* DACR32_EL2 */
+	ARM64_SYS_REG(3, 3, 4, 4, 2),	/* FPMR */
 	ARM64_SYS_REG(3, 4, 5, 0, 1),	/* IFSR32_EL2 */
 	ARM64_SYS_REG(3, 4, 5, 3, 0),	/* FPEXC32_EL2 */
 };

-- 
2.30.2


