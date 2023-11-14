Return-Path: <linux-kselftest+bounces-101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26DE7EB251
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7CF281293
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162004123A;
	Tue, 14 Nov 2023 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZdxZuqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562441237;
	Tue, 14 Nov 2023 14:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14499C433BB;
	Tue, 14 Nov 2023 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972589;
	bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MZdxZuqQS/XCeGxM/kivPa7IpJWDktjqRlqNdMm66VzqGPfmiiHKa69wsy9kG7jKJ
	 pIx9bouOUxMsa73sOeoGYYXUMmz1/gvvFli6MC5QY1XgU8zQ4+0nOKsEOtVSEKWgIA
	 Q5UK0xyv0Ai9bpF07Roz/X8zcQ+/2Ou2TEJFZ9XuHNUrM1+FyxzHyUFEz5I9ZID4By
	 WkhaP8rJE4UAAATpzfZ9LyyG8huR70oAO743hcixhgk4pzWgaoSn0ocN3S9exlMVgw
	 iplMsk+ZxIr1PArpIQgQg2skqPO+77Lh7DlXXcA9t4aCkBqHBblgJoMZJa1xA4xSwF
	 FZbEk/lXIsz6Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:35:05 +0000
Subject: [PATCH v2 20/21] KVM: arm64: selftests: Document feature registers
 added in 2023 extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-20-47251894f6a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4Wk6Rdizd0teYDpHLF5vYfFahxZEHcZmnD2tO0f
 90YAn6OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFpAAKCRAk1otyXVSH0FMfB/
 0a7BR0gFJP7bzs3Z5Q80cNK5sYdcR7PAh7c233DaEhaMh+1cU5qxOgVbRM70SM9IjdNFSs9uPyTfsk
 r8NQePoJanKT3ZiSLWYPHgTkuCuI8vdUxTqHh+69MEb9JWeHsa6vXaYQfXVtBxuSLbQX1x8/74McdD
 GMoSizo6vLPiNBgW1xMQDnTF2OMPyfkeGKHeymXcMcD58PnKWxbizCSYgYo5u6GhrBPlBkxaUKwn0p
 bGvsZzGZO5MHXTAFKDY8P3t/6S183grwwFLqtYVh49dnedOMGCsqawEMqX7SMWgTctXZJIZY8UpN5E
 ULM26iJ84hgRZq2a3v+tEs7bKbOF82
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2023 architecture extensions allocated some previously usused feature
registers, add comments mapping the names in get-reg-list as we do for the
other allocated registers.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 709d7d721760..71ea6ecec7ce 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -428,7 +428,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 4, 4),	/* ID_AA64ZFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 4, 5),	/* ID_AA64SMFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 4, 6),
-	ARM64_SYS_REG(3, 0, 0, 4, 7),
+	ARM64_SYS_REG(3, 0, 0, 4, 7),	/* ID_AA64FPFR_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 5, 0),	/* ID_AA64DFR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 5, 1),	/* ID_AA64DFR1_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 5, 2),
@@ -440,7 +440,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 6, 0),	/* ID_AA64ISAR0_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 1),	/* ID_AA64ISAR1_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 2),	/* ID_AA64ISAR2_EL1 */
-	ARM64_SYS_REG(3, 0, 0, 6, 3),
+	ARM64_SYS_REG(3, 0, 0, 6, 3),	/* ID_AA64ISAR3_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 6, 4),
 	ARM64_SYS_REG(3, 0, 0, 6, 5),
 	ARM64_SYS_REG(3, 0, 0, 6, 6),

-- 
2.30.2


