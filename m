Return-Path: <linux-kselftest+bounces-6791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E9890F06
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE41F2367E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5CB14298;
	Fri, 29 Mar 2024 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlOV+jLa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78312E48;
	Fri, 29 Mar 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671248; cv=none; b=C5a7t1UyQnOT/GvdTgqJypTH0kko4EvPz/JBZjkvE1c/43Kbh/dSxoMsr4doimg8/6WnqEB3QmdDyj5lr7ijgFs6exPEIIbkBJ387OmcmQEqxSMg+8UDNLbfnMHi2TrZvkG2Z5AEqnhw8k/T17WCZGs5vx2pQ9ymUNHk556lE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671248; c=relaxed/simple;
	bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aohnwRbktimnCx2pxHogm8d8Ivfh55xeGNAPZ2dhk5Jn+Ob/+OJKwpLpWSJu3VMhNEGVsueYzW+3nN9E0eXiNdwZZ2ORrvCaQxB//EtMEA6eQhkX/lxtkNxEWWm9m/9RK7t+BFldDiXDXN0cKHoi1TRf7+pnoO3gxbAPQYvdWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlOV+jLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36A4C43394;
	Fri, 29 Mar 2024 00:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711671247;
	bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nlOV+jLa6Tkf/v8jg9AogiwUdi2BMVz3niqtQI1MnmskhyuxKkCiof+7CGwRQ0Wdt
	 WO5ZEw8ld14UN8EtpMOVUP9JLcKPWcmaxvWaF4vte/81/B1mUoAhsZxl0bLBGhgTem
	 2c/lC95hnnsng24I3fkrxOf7y4jA/ZaFRRWiBM4Wt8F5OiAhZlsvPPzOJhkshynT8K
	 nVYv3CmJf9EeAtahbN7IBMZ19CS/ApSlMFT0YrMAoWXBdJMwjHobSQDbc9kWRoiaBL
	 RaC/iC9OqRjZc2L2JS//SBfh8m4xQaavaj3uo5BGcJDUk3tamiZBjO810D6NkarvRD
	 FWBsqwMRuNZ8Q==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 29 Mar 2024 00:13:45 +0000
Subject: [PATCH v6 4/5] KVM: arm64: selftests: Document feature registers
 added in 2023 extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-arm64-2023-dpisa-v6-4-ba42db6c27f3@kernel.org>
References: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
In-Reply-To: <20240329-arm64-2023-dpisa-v6-0-ba42db6c27f3@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmBge+s+lkBil5O5ULHYTCu6HqHEpkyLZR2s7CdXxc
 zwWvNxyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgYHvgAKCRAk1otyXVSH0IHBB/
 48Gom+Co43qHyYjyopetCX/UN7yiLE0+B13Es7XY35I2YHvjzhk4LSB5/q87XV6DpP02W3A4k4U5TZ
 7SsNqis78qg0D/oc3ovJ9RtGdNqMCz4xgBORtywy0MFl5qZTOETxyVnjpoT9VF/JCbRTXd9epR+m7B
 jHFp6KNS69NdP1oNhN3CEYhW7LBC85c16WufdH9FlFXym/rAZ8IuLx8AuHjgH4TILI7Pj4RwrQd5WZ
 ArbmVPzlRv94qdw4kRii6Q2FYcUTdMpjwlU/KqvUOUba0+30T/RBLmg1gQw1ccu8UeEf3T1diaYu8U
 za5MB6Wv+0vF2tdyDX9BixiFsEbm79
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


