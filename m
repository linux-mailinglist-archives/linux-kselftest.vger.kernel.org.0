Return-Path: <linux-kselftest+bounces-37604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA0B0AC15
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 00:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635C61C27AC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3782222C3;
	Fri, 18 Jul 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3aY5+68"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BCE2222BA;
	Fri, 18 Jul 2025 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877019; cv=none; b=I5dM6tmkhQeFPYzb+oGT2BQdkMAHJzMnMst530T0sF1rTlYE8ZYgqs2DP4iMUQaw5n16bHzM4eIR3jLH42UXGBKgGqzYalOj+P+3CjtTp69duoVXQmbyDyzqqhYoTc0xWkVonrUz7Er56/EYlGRxB+Xa22PTb3ss7YIWOj5/5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877019; c=relaxed/simple;
	bh=sH6Ii1yok4Xx0txtePIyhU6/M/Q4z40Fm8HNPEuf03w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSJULfE2lmH6QeUB3dwZ81sl5KcTWDuO4DbaSqSEDzC3/8vDSDUcsJCVIPEkCXMLn5sw1jnLdFA2TeHXCDrJgODnGVR60358WWVFAtBm0z9vSpFDGkbGzChbmSz1G5/Ra2RM+t1IgsLClR//2CVbykoM96p2D0SmfcwiOW9f1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3aY5+68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3548C4CEF4;
	Fri, 18 Jul 2025 22:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752877019;
	bh=sH6Ii1yok4Xx0txtePIyhU6/M/Q4z40Fm8HNPEuf03w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A3aY5+68E2faKqP/mfbNzVQ8oD7wGRuAB94ovQRusAFVFZTMPZnLHrSJJScEyHmPV
	 laHU///OLU9vJMoHUc1byS+FskzRH2CBjx/aPYX6xF7I+9ps1XxCtZzpbJX8yfGFTv
	 FBxg9kdJWOM3nHTJeoSB33o5GJzswj5gO9W5fi1gKKtXXBAI/yJQYL9NC+P12xDhrQ
	 ONOaSs39ETFmaWIxDdxeyAOihO0LeebPlvvJmih+Uhz6wghXVXKNKrzNcKIne7O1yC
	 EqnJ6vWNv1F2Rj6/WTK5lvbgv2E83qkLOzN+veonXr1X2P2cRJd0DObLOOThDq75GS
	 3ZAbFhV3K86hA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 18 Jul 2025 23:14:50 +0100
Subject: [PATCH 1/3] kselftest/arm64: Test SME on SME only systems in
 fp-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-arm64-fp-ptrace-sme-only-v1-1-3b96dd19a503@kernel.org>
References: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
In-Reply-To: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=967; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sH6Ii1yok4Xx0txtePIyhU6/M/Q4z40Fm8HNPEuf03w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoesfV47we0+i69DcpVnKwyR0AbIPC7B+e1wPit
 /M1crAyL5yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHrH1QAKCRAk1otyXVSH
 0GqrB/4srXY64OmGEkdaiWelmOGt+Frzf74cTcB+ycaQkWJ8yl0qXjNes29yADLKtIPaLMj9DMr
 RlMpD9uDVphtmHPLDFovqRucLcS2s5M1X+5e89FFrlyIeQaOZqvTKJLgMn9w9GeoJOM+C7kpOZo
 qdI1KG/T08L9rz9UWELYpR3m8grTFXwMdZRq8clSsb4Oj6NwDlOmU5LL1AZo7+guXXBjJWbSoKA
 fbtbXjKR2Wn7ldaolHTOzuO/QPvhq6ne2Bim4AWVo+TNUk1VNRdNzHrxzUgDlVlUdL2wGjPvC5q
 ojOu2+f/JqCo0w4ZbFRVKSFgO6nuHvs+1FYFiRqWRa6HL+8v
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When checking that the vector extensions are supported fp-ptrace
currently only checks for SVE being supported which means that we get
into a confused half configured state for SME only systems. Check for
SME as well.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index 191c47ca0ed8..d953e9b0ebe5 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1607,7 +1607,7 @@ int main(void)
 	 * Run the test set if there is no SVE or SME, with those we
 	 * have to pick a VL for each run.
 	 */
-	if (!sve_supported()) {
+	if (!sve_supported() && !sme_supported()) {
 		test_config.sve_vl_in = 0;
 		test_config.sve_vl_expected = 0;
 		test_config.sme_vl_in = 0;

-- 
2.39.5


