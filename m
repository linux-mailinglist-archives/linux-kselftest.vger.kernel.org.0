Return-Path: <linux-kselftest+bounces-3347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF6E836E48
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A780BB3410B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089136D1D6;
	Mon, 22 Jan 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj+hI9ND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23916D1D2;
	Mon, 22 Jan 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940952; cv=none; b=uznY0jRGsuaeuoytAVGKgBs8SF+Hn7SaVTnbwNJyUhh+4//JWFjyHAVSe2y4jn20hPpi1dDQOrQBO5pgZWO09Lueig5kfWW+vMmZ3DGWWaMnGhUBKJpa2fbJUFF6JWADhKqBVbWwFJTdFPgazs1N4LQilslRcinLV5E/BXqg2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940952; c=relaxed/simple;
	bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3Uf3BOiQue53dUGrjixM5Vpq7/1RGaEwFACL/Fj3XT3laUtArrLLzCfw7SdOYYnqK1W42HqiRbX40yPa/brYakmd86Cxb7FbhuprhUZ8YD5FXZZX/i0s1dGjz7TqWSUMIFV0FFAzcPBiTZRGSoy+JqT+vqzJoCMfNPqrqYMPzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj+hI9ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51841C43394;
	Mon, 22 Jan 2024 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940952;
	bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Oj+hI9NDkZw4nksX/ebabnElbF98vXXo/UNNa374lOCqxXYkyGZB75eNdVB2PdZId
	 UiSRCCUJ+ouVYTkst5uzAbZDi46MWLvInfSCXPGmu13sMFyA0WM7YC2CtQDPDzFDTN
	 CVNrLj4mDO3Rga4P8a0FPqK7FMSc075Nf9TKme7O3vfkSENm1pgT0iLWP9vzAdTs68
	 3zhydMMkCgx+JBURI+eiVNumi9m0hTZJ45xHlvQBIyzQjsbGswj7CCPzoD7aD1M92n
	 ja2sExHds3I8rmh0AcmNktg1jrcSzZFD6rKuTOOVlSNsJkLNBgsyaq4qATvlO5OjFT
	 6vDgrD5n1QS4A==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 22 Jan 2024 16:28:16 +0000
Subject: [PATCH v4 13/14] KVM: arm64: selftests: Document feature registers
 added in 2023 extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-arm64-2023-dpisa-v4-13-776e094861df@kernel.org>
References: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
In-Reply-To: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RtrbRWeplo/J+dSChm3CUN1rkk7mxJJmNnU3ySYX5lo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpellHdb2ud+gUPZtfkzkXLry7SeB/PWA0A6mTm9
 0cRYFiKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XpQAKCRAk1otyXVSH0FmuB/
 wIVj/rHr3W484q+VYW7miJhzwYuMjVYN4/W5S865dqDEC8LUazvC9egdOXxnMYePsDzaGDhHtGqtCH
 yeIFPk0EDSs+3PsZHt9KXBIlQ2Bvj84QQ/7ffBuCKsjHNlMSnpTP3imUzDyd8e4fZ/o8WYBlusB1Wz
 99HznLh5+B+pryBw2IzPfXkrI4i1L5NwIx6Z8fIFo76mUNVREfq8NMHepgtl42b6bS2roN5THchnnS
 tUtmVr/En8d6M3RswsiKRfwicnaFdDZavGyfxpG/xlL36br1hcNxZX3x54MhCaIhe+dP1FpXUizmyc
 p7U1nWvW4EVih9nfKHtUiF7UGic35d
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


