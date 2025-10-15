Return-Path: <linux-kselftest+bounces-43250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF7BE032B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B00048691A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421303016E2;
	Wed, 15 Oct 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOEDk1TK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CC298CD7;
	Wed, 15 Oct 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553250; cv=none; b=M/ClbbH54KoLFdsIKSlRlvgtVymD8Ig0FTsd+1MRb6Q0FsrlIP0N/qW0zoUw9tYa20UMzaJP+qrRpSB7sUMr2ccTViPLD/rd13biWyyl3+xnvl+aqxdu5yctPkmzUIOABwMeHT4w3fsVP+95+OZIicngwvr82hv+ZeaGKRMUils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553250; c=relaxed/simple;
	bh=UYiRQSvgs+jqwo1HIyxcSuFqSwz8wIVukPHpImMwyIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laf96pLFXewziEelQJSVKS7xEIUhxQKZkL8i7RBQEgbBiUA3N/+fnpWYmkDYYD+n79/cZ3ofQARxanueKtk2bVMnMFckl4MGq9n8rO/G9BDOLy3SqjaXk3EHdwfMpFFhtoD4VAaBD5rqPfTU9p2a3hAwQFoHRuw95aJa/DPj65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOEDk1TK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C68C4CEF8;
	Wed, 15 Oct 2025 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553249;
	bh=UYiRQSvgs+jqwo1HIyxcSuFqSwz8wIVukPHpImMwyIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JOEDk1TKOjy+sC4x4jD08sMX/9cOzdUAu2Drq6EqtlqtkOXstKVfDB3o1we/whMWc
	 NYuCMn5I5HwyzfBwDCkpx+eAR7TCllmtTVbSGyeBTvghTNqiIb35VmH/iFlaOkHxnw
	 /o14sS8HvwFWWx6aE1cB/SqXmMJAjhPotn2E3o9Qd8iCctD9xNtcMnw25OqLesbHdf
	 bFE+KISodttgwOsCT4rEK0o38x06cmfw7n0NfaqvQCUo2UOYqm2lWjAL9jVWLPkZMf
	 8Ha1ZwQ7XsYExqR+70kRUYkoGFBx+9A79cE9ZZ8aRJy5qZeENg+MGhD+l3iAgZlogf
	 RIA24f459PU9A==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 18:56:38 +0100
Subject: [PATCH v2 3/3] kselftest/arm64: Cover disabling streaming mode
 without SVE in fp-ptrace
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm64-sme-ptrace-sme-only-v2-3-33c7b2f27cbf@kernel.org>
References: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
In-Reply-To: <20251015-arm64-sme-ptrace-sme-only-v2-0-33c7b2f27cbf@kernel.org>
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
X-Mailer: b4 0.15-dev-2a268
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UYiRQSvgs+jqwo1HIyxcSuFqSwz8wIVukPHpImMwyIA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo7+kUW7mFnAgXj0oaG5JSKhdvIsEUwyyPyt8j1
 wi+2EsZtxCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO/pFAAKCRAk1otyXVSH
 0DQbB/976gT7Mug2JIPAZ1WwQXFgHP1WlsQ7C2JzCVbO6aQakwbYHMPhSyqLJm9LVSIr3iTdhu9
 O/xfa/bTdYTIXC3Cadu/kSL4Gd/eM5q9Sf5qyxIIv9T9ox4hq/XunynZMyX+8JbvopLCor1qaQX
 yCWVTuIzBf8esBtIy8tObX/pKuU9T1YxJy8LMtGmA1QSDtF5OzrWIcb6TLzwu4XJxS3L96bTYo3
 Gsj5FhAnm5gA12AH2E3ekO5mpyBgquSV3/XTHKiXiV9ewXGtEsvqCKoTTegojjICtY0JGkZVybZ
 DtksaYcL99KTtZ9Ht+3IElE4WC2qeczhQ9cX+pwXIIbAmv4Q
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
index a85c19e9524e..0114108ab25f 100644
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
2.47.2


