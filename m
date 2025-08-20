Return-Path: <linux-kselftest+bounces-39392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C86B2E4FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC49D5E3B55
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C2C2836BF;
	Wed, 20 Aug 2025 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaNraaPs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3A27A91D;
	Wed, 20 Aug 2025 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714582; cv=none; b=aOoQyyTIPDB1gLCJqfNyhRlIcMfgDEg4O0EyA8KDDdyEUQsF9W6uNOjFF/hyrOW2AJjOrsVVtZfzr04Ja7xHaPg4ov0KxFuIAtcARIGZ5iR/izvV3CSP8QqqZsMJ9lb1dZjjHJPPhwtcPJgdnGWs2fM93yqLGlEafBxtNZn0xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714582; c=relaxed/simple;
	bh=GwelV5LaIEzscbAlxJJsBp+tkWj6WmmOlhFzMPKmCGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWYspbsvilc05Vc6UnzPmSMD6B9maOXZhb3t5PfeCzPhwQQ8gBTvcz5Is+3FZdPw4a5QWYceDsA3AVLZmPG0l/DWq9QnmXrD6jBXKiwe/C/l+rhexcPRSEs1f+Cp7h9sbAVVP+WN3sX9QJ7YUtddLXXr6pdxg8mciFOi6t+AEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaNraaPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BAC113D0;
	Wed, 20 Aug 2025 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755714582;
	bh=GwelV5LaIEzscbAlxJJsBp+tkWj6WmmOlhFzMPKmCGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JaNraaPsML5Qc1tIxPjIpxw6r84mMnvT0ZzLb0ODANQe1pV+3xQ5+OX6hjtRvDBqg
	 8KxM206jloGSlTFdW/rsswOiJNDGlXYEQgpSsRaEn+gAuu9dptq5rPUJEkW8tRQRtl
	 pVlCASshs5zrD2h3+cu3Us/Y3+sUCMhiLJF7V8gQDRQCSjP51zBanQ6NTyffzcEiZz
	 dJB9Rl4jWWlelr6v7zukv3xpVcnW3isJgACzzVQHuZRvbPo3LSz1A+WyUrHkMVGACl
	 G5btUQF7m8wQzvfuziQAxeoJ8LBNGbK+gczvVoRciUtBySij+dnWhRkfKnp56fo7uZ
	 9eF5E511Bl9Jw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 19:29:07 +0100
Subject: [PATCH 5/5] kselftest/arm64: Cover disabling streaming mode
 without SVE in fp-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-sme-ptrace-sme-only-v1-5-f7c22b2871f8@kernel.org>
References: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
In-Reply-To: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 David Spickett <david.spickett@arm.com>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Luis Machado <luis.machado.foss@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GwelV5LaIEzscbAlxJJsBp+tkWj6WmmOlhFzMPKmCGg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBophQEmL7YR3MYjzO1vG3QUOVkCppXRHzu9l8if
 U0cm+pxwKeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKYUBAAKCRAk1otyXVSH
 0F0NB/94TAcfPdpxW7X2dovVYEJ/U4M+3O9CS2qasqzlNqOkJsMii/if3DdQmbDhBlMfOlEMa34
 F589eg9i23JU/mE+uvGkdY2Rmluye7U2EJStnb9Wj4KLCaNIjCZJjgg/YU0yCqAy4lxkH5O4X+X
 taFmvGpqZILHY8sTKiZWUkXyh0SxPgUdOs/Yul+CXbSejNoVVD+aD27dxrOREAedGiEwOB3CA+m
 0kSxJT8Ea1zNDiY2GfFmYjWkzLOkdPivi47EHBEq/fOSswzaTZcTV4M/TVW66i85SJ+9DiIEtkB
 fwuwtL54MhiiNJ92LsmOP/cjTgsok/SQMAxCyskWdK2wzX44
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On a system which support SME but not SVE we can now disable streaming mode
via ptrace by writing FPSIMD formatted data through NT_ARM_SVE with a VL of
0. Extend fp-ptrace to cover rather than skip these cases, relax the check
for SVE writes of FPSIMD format data to not skip if SME is supported and
accept 0 as the VL when performing the ptrace write.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index cdd7a45c045d..3bb4bbff120f 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1071,7 +1071,7 @@ static bool sve_write_supported(struct test_config *config)
 
 static bool sve_write_fpsimd_supported(struct test_config *config)
 {
-	if (!sve_supported())
+	if (!sve_supported() && !sme_supported())
 		return false;
 
 	if ((config->svcr_in & SVCR_ZA) != (config->svcr_expected & SVCR_ZA))
@@ -1231,9 +1231,6 @@ static void sve_write_fpsimd(pid_t child, struct test_config *config)
 	vl = vl_expected(config);
 	vq = __sve_vq_from_vl(vl);
 
-	if (!vl)
-		return;
-
 	iov.iov_len = SVE_PT_SIZE(vq, SVE_PT_REGS_FPSIMD);
 	iov.iov_base = malloc(iov.iov_len);
 	if (!iov.iov_base) {

-- 
2.39.5


