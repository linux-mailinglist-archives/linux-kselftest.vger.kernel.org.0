Return-Path: <linux-kselftest+bounces-20512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045599AD5B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8941F21705
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BAE2003D6;
	Wed, 23 Oct 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHtL0+aZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77A20012B;
	Wed, 23 Oct 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715991; cv=none; b=lH3ybxaQcSPu9a2kOqqP0Uih3Y88RMvqmwUHR/aXkArjphN51+Wpo4ngGR4ScEnKVwFlNuT2XiPhAbJHKTVAYp/hufwb6yBrh9qa8BUX2LJHvm2sT3pBc0BlEP+4ePxQ+Paus/sGQi0EUO+9fV2K9zkkjr9u+9bVN4+EFBBMvTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715991; c=relaxed/simple;
	bh=2eYH4MlA2swbnr7Adf9Eu7+rMkjhAxSKCoo92NFhmpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aq1g3sDLhgHCPO5VjJpgajutakRAZlEXlInGskxMGWHxEzzKPs+zhRPHn9pA5DtKM0F6m6/Vtv2ErKufZm4WyM91pCTVhBjP3q0irNVjnY6iymWJ3NmjjyWVMY77l8qc/UYsXIQ30qsJQzpXA+MrZAuKeNpPjFempGrMForvhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHtL0+aZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CF0C4CEE5;
	Wed, 23 Oct 2024 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715991;
	bh=2eYH4MlA2swbnr7Adf9Eu7+rMkjhAxSKCoo92NFhmpw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HHtL0+aZd7/UFWdJoQ1PUrq2RV2TSukC8tOFWZ8I3o8vQY4dHdkOzmBCQTEyb7ZbT
	 SWbG/D5ipAZWBUWmZjAx5BV1wK9e5KWqWRKargoNf+IfxvN/QS49LScmAQDbWp7/Cq
	 JKupvjpZWV+jqn+tIXeDNRoTTc7NR060b06Gj5cBV26xRlTQiIjNUpUGlvdzabtVzY
	 NzE8PG85FZMx6Cs4N4TNBpafoRwq0dfgWBajllRdkkx+fDUOBLLrPGgvwin/aHCnmJ
	 J2UdHBhfNoBmOB+hFbiyeLd31w14RSqmPogQ8wUUgATZh50KxUFRXJhAq60cNgIesO
	 wpCwCESrNztFQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 21:38:33 +0100
Subject: [PATCH 5/6] kselftest/arm64: Provide a SIGUSR1 handler in the
 kernel mode FP stress test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-stress-irritator-v1-5-a51af298d449@kernel.org>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2eYH4MlA2swbnr7Adf9Eu7+rMkjhAxSKCoo92NFhmpw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGV8JzNZQSvHQxUSc42pdgj2HsNPx/BcpVh07gynO
 a+c6ELeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlfCQAKCRAk1otyXVSH0A/XB/
 wKth7XVx9oz7qbfbhUEMkGwkOSykh7+5RLlvAUOJIoBYlh1ieDD1L9OWcTkbAa2RD+uhlnQrQc2eUm
 eUG/QBJVTQryVUwdV0wPEbOt9JARw63DmunugDrJ5ZzsHKJjNSeVswGtEU+C12ZSO3DmjSt+YQgKiy
 CML0owjEHha21n4gBuapaeBgeWUlGPAOEcWWFxQDPf/bCigtcl61nptjMwpkHisLNDg34Xw3MoVVbv
 rJHizDjXjmogDrvp/XAwGY2MZEFOeNcat73ig+/AOhdYuYg54HSQGvrCeRk9tYBZe5iWnjofKP4rdd
 5JLYCyp/lk5qIIURn4WaTlXEglTh7G
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The other stress test programs provide a SIGUSR1 handler which modifies the
live register state in order to validate that signal context is being
restored during signal return. While we can't usefully do this when testing
kernel mode FP usage provide a handler for SIGUSR1 which just counts the
number of signals like we do for SIGUSR2, allowing fp-stress to treat all
the test programs uniformly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/kernel-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/kernel-test.c b/tools/testing/selftests/arm64/fp/kernel-test.c
index e8da3b4cbd23202c6504ffd8043f8ef351d739f6..859345379044fc287458644309d66cf5f3d8bdf5 100644
--- a/tools/testing/selftests/arm64/fp/kernel-test.c
+++ b/tools/testing/selftests/arm64/fp/kernel-test.c
@@ -267,6 +267,10 @@ int main(void)
 		       strerror(errno), errno);
 
 	sa.sa_sigaction = handle_kick_signal;
+	ret = sigaction(SIGUSR1, &sa, NULL);
+	if (ret < 0)
+		printf("Failed to install SIGUSR1 handler: %s (%d)\n",
+		       strerror(errno), errno);
 	ret = sigaction(SIGUSR2, &sa, NULL);
 	if (ret < 0)
 		printf("Failed to install SIGUSR2 handler: %s (%d)\n",

-- 
2.39.2


