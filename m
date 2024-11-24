Return-Path: <linux-kselftest+bounces-22488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD359D6EC6
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39EDAB2677A
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86591DFE0F;
	Sun, 24 Nov 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy4y6FxO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808E1DF26B;
	Sun, 24 Nov 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452138; cv=none; b=Y/9rqcB9i5L8ZQtE68Dz4kt8r35xWLJiWDeKLmcB4akzRwCKKt/s/frzprWpuybyw13pgqop6L65KUVt6OFl/x0/P9A3ACo2Dr/HmanL2myxOGR3eUtQYKJlWA2Qxx+nZH3uDI5rQ/z4Jk6xBdWlfCscjR0d4Aasba3CIRDybeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452138; c=relaxed/simple;
	bh=6pfOqibsCE2HGXSmSvgOSWW28Hn3vo3smyAJ7UMWNP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGc3VcMqBmPyypW2NObaVBEvZiFvb1q74aXcRS1lidSej403k6J36hOyzHnlqFbj6S+p63D9bFejlclo5NFpCvMe8DMJgacN2qZX1jj66dC58/LgTrPlFp8iQ2VTMa2avRbX1FPnCvsn3rg/N4aTIjqh25XUsFre7HD+yMywMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy4y6FxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510F1C4CECC;
	Sun, 24 Nov 2024 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452138;
	bh=6pfOqibsCE2HGXSmSvgOSWW28Hn3vo3smyAJ7UMWNP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fy4y6FxOmiyK6hF+ttlhQ/j26840A+x8p26SHZT9PIx6JmGaSzi+24t3lXLkudIgO
	 Y0ZZq35AL6uo8ZHtegVoEVrx6i6XBPoPScUZNjpnjyFNR/gP0r5ApL/+7iTCUtMoWp
	 A3Y7NQ0APloWF1RLSTAf+8fgmxJlnhi2dYQ8gHDqC3qGljreORHE8746iOA0Urd+pX
	 w30+YZcMFoPldp5hYnTvTLlvahJHwWyrXwUQ497qpprt67EiKL2S/L3q/YCoHn3yjr
	 R+gDiXE34+9cdlV9Cvng9VSHzOTfVW55ySzKCxoGXRtXUQIKHYsRjNrcp8mXXy3xgN
	 HjJYDbT0wZSgg==
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
Subject: [PATCH AUTOSEL 5.10 4/5] kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
Date: Sun, 24 Nov 2024 07:42:03 -0500
Message-ID: <20241124124210.3337020-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124210.3337020-1-sashal@kernel.org>
References: <20241124124210.3337020-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
 tools/testing/selftests/arm64/fp/sve-test.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 07f14e279a904..7784c684a865b 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -459,7 +459,8 @@ function irritator_handler
 	movi	v9.16b, #2
 	movi	v31.8b, #3
 	// And P0
-	rdffr	p0.b
+	ptrue	p0.d
+#ifndef SSVE
 	// And FFR
 	wrffr	p15.b
 
-- 
2.43.0


