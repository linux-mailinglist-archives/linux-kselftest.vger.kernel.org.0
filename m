Return-Path: <linux-kselftest+bounces-22484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175779D6EA4
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC2BB231A6
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404A1D63C7;
	Sun, 24 Nov 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoLdtwmh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4E1D63F0;
	Sun, 24 Nov 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452099; cv=none; b=Y9AUAasYU51pJO+n+M2E9Ld5QTsCcUzucgN4imIOayHhIOGRCjXBUR/FpMJSmfZnK8NU9BUnXhlUYpH1zMOcydwoF+JRmo+M+87S2fd4u7w3PiOYzuQgqKtPt8iwp7eogEOE+c5UjxaG0ZvoqhllGWio0T4nRc8GYwffgAgFBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452099; c=relaxed/simple;
	bh=Ddb741SszSH6SeCJvr4j4w0DO0K0H8EoTGj/hXFKhHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+xRURuA5irYC3y0sERVHnn/x8bj+xCcZiaS5Lj+mvpAn/Om9e+fLdaHGCHjv2sJ8Aaq2msZDexS1uh+rY7/jXiE9vSfqtQd35JREoYeWgCcGPOxkl+3Nnnqs1jLBY1IhwJPKV3nGuhU1roff4ZNPLpBQBSlDKZCuDzkoSK2/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoLdtwmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF496C4CECC;
	Sun, 24 Nov 2024 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452098;
	bh=Ddb741SszSH6SeCJvr4j4w0DO0K0H8EoTGj/hXFKhHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoLdtwmhdnKaFS6UBSCdJTn3sGRtOvaR3mStrLcz7uviqtcbxcf+JMAVWXiR7OnfQ
	 eukLyUjqq38Ho0TC+23VTxf59vDIYpD6ChZ+Kk6K2RT02vuD7G7RC3NYr96Qszrwtl
	 ulgYdhmFLNGyyhYRUdGuDvadnhe1WefHsA+9KdcC8KhLG90Z5XYtWU0+7Rnjrcunsy
	 LpjftbYw0Uz6+20jvNfYbH/poduigZw6OwX/fGDMFsn21NlgZ7ORn/tH8A2r40JAkI
	 fV7LfyNhviQLfbEWvU1m47QEYj3wPZRu3kPLl9FQRcnejNnPlDkV3HMPww1mi5DT7X
	 PmWgSNcMjoDsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	shuah@kernel.org,
	mark.rutland@arm.com,
	thiago.bauermann@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 6/7] kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
Date: Sun, 24 Nov 2024 07:41:17 -0500
Message-ID: <20241124124126.3336691-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124126.3336691-1-sashal@kernel.org>
References: <20241124124126.3336691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 3e360ef0c0a1fb6ce9a302e40b8057c41ba8a9d2 ]

When building for streaming SVE the irritator for SVE skips updates of both
P0 and FFR. While FFR is skipped since it might not be present there is no
reason to skip corrupting P0 so switch to an instruction valid in streaming
mode and move the ifdef.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20241107-arm64-fp-stress-irritator-v2-3-c4b9622e36ee@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-test.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 2a18cb4c528c5..b9648daeabbb1 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -304,9 +304,9 @@ function irritator_handler
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3
-#ifndef SSVE
 	// And P0
-	rdffr	p0.b
+	ptrue	p0.d
+#ifndef SSVE
 	// And FFR
 	wrffr	p15.b
 #endif
-- 
2.43.0


