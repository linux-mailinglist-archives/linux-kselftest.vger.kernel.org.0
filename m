Return-Path: <linux-kselftest+bounces-1176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B711B805A7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C61F21802
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E7760BBE;
	Tue,  5 Dec 2023 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRLIbCim"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029035E0D2;
	Tue,  5 Dec 2023 16:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EE4C433CD;
	Tue,  5 Dec 2023 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795138;
	bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YRLIbCimtgBlJYEdyxF9hD+TexA96gyzv2Cp7KVIysejHpC1ZV/hlUKJmn1K68C+n
	 /qNf+tYW1lVyyfJtS3wX5M/buQarU8cUfPF/vRjfcTIXKAPOuuodHmVPhiz/Ip8HuG
	 nKrx5VnxaHZHlAKQjvZ3gSBWPxBmz9ydygJc5fwG96voLvBrAHyZ5T+DD10iYRojMJ
	 Ofz0/O1+qcwgxuqGlbNf7+i7uQslabni9/PZ1VJ0tASjBBp5sADbmyoMsAfAt1sQh/
	 Lh7i3kyytiPwyeNhFJY48hqtlyP6uJP0az59qBKxnBWnWOdw9I+CkpqL2Se/BGncZV
	 QEabB/cpfMCRQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:18 +0000
Subject: [PATCH v3 20/21] KVM: arm64: selftests: Document feature registers
 added in 2023 extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-20-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1T4CgCPiHmKGN/VARDp7A3cLzr3fw+Oqk/gk6kB
 jrlxPJ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U+AAKCRAk1otyXVSH0HnrB/
 wLwtOnY0ZOVUQqzs2bZEncaCUPR7CtD1MQGN0vdj44RZgh6yX1UYEvULTVJOjRm4pGi9yk4aN747A5
 OmLixp/5QUJEtY+hqnBh2tKagwP1qSuNtSLt1BF00TpxzIipRwMhYxGgtpa9zPRBRZjA/nUCyoopxB
 J372rjpTzH7NN+bfY8mkG6acKBMY9JtdGk5yRRhOlzBp5cypJd7tfIasgkAU2/eqRKM5oVZuAqlfer
 IruowDG6Frpqyb/a/t4H59yo97OK/kQyIHcxMQ/g2wyh+f7kp0k0vOskzDFdeZ5CDfOCy9F1eVIu2H
 EKo1kd4LPjhDEFNh4TG3n0C4ZYJjYt
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


