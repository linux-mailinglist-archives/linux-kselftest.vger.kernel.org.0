Return-Path: <linux-kselftest+bounces-22482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B199D6E91
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5022815D0
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD1B1D5151;
	Sun, 24 Nov 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDOeUL0M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AFF1D514E;
	Sun, 24 Nov 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452075; cv=none; b=j4JHRAL4XdKPzted3zUT+ALydlG+B/sKMqzBgR5puL704MtzNjDKVAjW7scwkvoJ09mBG1bwEq5fBVsv6EomrDPW0+o9i+O/pBCpdCRLqD9NVeK5Ipi6UUuxNa5BAHEOjI9KjzJNshGNjZS816yy1c2Eu7gTzZNCS3bzBiL00u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452075; c=relaxed/simple;
	bh=yxGeVVGri2wpZ+0iD8qGbO6TdcZZxy4i4MTqaAO6Gx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDdYCij7eBVY8SrKWEKyUHyAQEecwdyASJjwiY8cxzY9Wa1Au5xqH3v25mwNRve1JzRi9Fyp8/hSDwBscfT1gP359Ay/LxVG1Elo19opldrcXa2BBtQk6anaG0/rKVOys/MKoW3rNAugoGQAuLV6fkUe3Mn6DUDZdybygDKg4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDOeUL0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1921FC4CECC;
	Sun, 24 Nov 2024 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452075;
	bh=yxGeVVGri2wpZ+0iD8qGbO6TdcZZxy4i4MTqaAO6Gx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDOeUL0MiivdrYj2uX7NvEXEQrHwUBwx2SLg7ZAOy+9Hp2HbnO3XTff3nCyiKY211
	 fYyHk8DQ0JEpcGjlu2dKadmgWAShPn6EXaYE2RDMHg/IRHzc5CQsp6tms9F90vxJ8G
	 ibPJd7OGkx5LCxkpjSThSKe/Asl/jxPyvW0hermE8dAFvl+8ZlrTkGHT0AnYH46AMO
	 GLFgIeiLrhZuurN9v0O0rjdpLz/7eLYXH+FDbL4h762Zhpzj9O9BJgCGHtkV6BR3xB
	 B8QBaS5qrh/dafnWSBFxMDvSgpccOnrc53HJVrGqQe4HiXR9eFUgy3OhwKPnOZijm4
	 GLxhLnwm223Tg==
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
Subject: [PATCH AUTOSEL 6.6 8/9] kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
Date: Sun, 24 Nov 2024 07:40:46 -0500
Message-ID: <20241124124057.3336453-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124057.3336453-1-sashal@kernel.org>
References: <20241124124057.3336453-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 4328895dfc876..ff60360a97f80 100644
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


