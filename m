Return-Path: <linux-kselftest+bounces-22476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267729D6E46
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E083A281532
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2990C1B0F15;
	Sun, 24 Nov 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF1aBSc4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE61AF4E9;
	Sun, 24 Nov 2024 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451989; cv=none; b=Kw9X94E2jY/9M1Z9gwcm8oe3cV61ydPwEIk8Yrf+Ax87EQC0t4BfcctEvykZorAe+1tjct0eENtiQDfol0NV3SGd+Hg1u9pWKnzeKq39A9q8c0sCLvngz7RtkIEGzjXeMR58iKbeESBhRxWqBG+xnl3tFY1mWUWXnO4YgJ6mlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451989; c=relaxed/simple;
	bh=81Ni8xHtPktgGt2jnb4WQsNexyhc+xoT9qdsR8aq7bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQYydmJegPaq8JobNr5BxcmmcbLfIkCfPjmGh3qDboqJAzQiWFoqo8WtVGgX7WIZbKS774a1149CLNPMSkbyaiWV/Ujx6/CS5UqahlBtrI5SjrEAHLVdm2j4cSgGWgIRpUNI3EhrEYz/fq1gA9kHw1kc800pYHPVc3LLHjtjzFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF1aBSc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB52C4CED1;
	Sun, 24 Nov 2024 12:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451988;
	bh=81Ni8xHtPktgGt2jnb4WQsNexyhc+xoT9qdsR8aq7bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CF1aBSc42nqUpGBvyqGjqOlECbnvxRnqNdOEuxeuWAO/RDJclDD7+ONwKOx5zksbf
	 6FXQBlY0aY0Y2hDMkkFisWvuhkDvGn0ZCkhn+oMLlQHRqGrEE0jzqn5SiDIJKunqaz
	 FzjuqXOEKMSaZ8YVDNHE95/t3xg2WxWbe9paD2mcdOGSpq87vDr8HFNVPgoY3m8Kob
	 sBH2TUIdAI0RJxg11Vg/AN4R5ybBV0oNWH+d1ZGLH1Un6/7U2awh4vJrTQiarf7WN8
	 2JRDjOcqYlPp9mW+tZ/hFQJpoNIFIII0Wqwk/pMfnYYRhJYlEppIazxiiQ7Xpbmntb
	 X5kujCx4q4//Q==
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
Subject: [PATCH AUTOSEL 6.12 17/19] kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
Date: Sun, 24 Nov 2024 07:38:52 -0500
Message-ID: <20241124123912.3335344-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index fff60e2a25add..4fcb492aee1fb 100644
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


