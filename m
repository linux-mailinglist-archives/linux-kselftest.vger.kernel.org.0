Return-Path: <linux-kselftest+bounces-22479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16F9D6E81
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BD916300D
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503C1C9DC6;
	Sun, 24 Nov 2024 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAg6YzeZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908D1C8FD7;
	Sun, 24 Nov 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452043; cv=none; b=DwhYztkbXunXPDps+gPM5H6mrfZ4H41qUBFqAAv5VTbmdJx+tzeLZdPtYKSBbaRy3rCWbXvn+IGZ8wX7bbcm8NoIGxSI9B1NDkXDxO954MyidfeBgNrU/y4oJL0+nBodBnOfsQWIBjepipCkhigz7qZf5oGDRufOXk2gSIoV/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452043; c=relaxed/simple;
	bh=81Ni8xHtPktgGt2jnb4WQsNexyhc+xoT9qdsR8aq7bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2T7803M+x7bhZHPMh4kK41wautoxgkImZIPf1fTI+SwiCgQSjInhglaQbKdk+42e7CI1re3/EAuMZB4hXixrxhfsK04HFVWnhkBWVpszo9NQ+TVIBxq0nC5K2/CloT6x8e0IBU0WEgNHSo1BhY2PG7joU410v9C9NVOdh8FuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAg6YzeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B051C4CED3;
	Sun, 24 Nov 2024 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452042;
	bh=81Ni8xHtPktgGt2jnb4WQsNexyhc+xoT9qdsR8aq7bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAg6YzeZ2ZB974sDtraLLD/eUyc+3Esg7YhYUaV78AEb3mpR6Fjh5i0odsMsQj+RE
	 t7nQkLtCsOuAvatMuv+SIxCjzgBEJ/XRhOFMOj7F+AEH9o84WhV4vgUmd5jkAgbbUI
	 PV10eyknuR70GOd4YGL5F7Stm09uXm4/jELIIUWX8JKEf2RB9j9Qu6K2VSoRbbISPn
	 v8Hl7rNx1jbqaSL/thO8gQdYBeGxjNo1f2XbpCgIrSNT3ZQ4O5aA49LvFSqW+1JQ9s
	 8naUBEIbqBeOge4zfukPbjQ7+Di6dmSbqE1KVyBPSMbpmGr6nLnn6yBWvlxFYilHHV
	 ZYnVtV3Taa08A==
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
Subject: [PATCH AUTOSEL 6.11 14/16] kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
Date: Sun, 24 Nov 2024 07:39:51 -0500
Message-ID: <20241124124009.3336072-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


