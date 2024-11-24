Return-Path: <linux-kselftest+bounces-22486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4259D6EB3
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399D6281455
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B401DE4C0;
	Sun, 24 Nov 2024 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caoositV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF31AB525;
	Sun, 24 Nov 2024 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452122; cv=none; b=jLi+TQQpmVxhlztZB8mqsh/vKVpe7oVpysnmedMJEbTE9Jo7cJwsmTNAjJ33rAIjt23vZcsDcDBa6173ADfPR1kMRX9El6nXwo01kRXf2CBmPXqOuFl7nB8MDaOt1PNt3BSa/JQ1FJVHHu3CAVrCD0IAP0sQ3ezfqp2mvWNeKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452122; c=relaxed/simple;
	bh=sf64Z8/K2JmDjSHufuyPNPpzb2t6/Com4h0XELkBt2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdNfDnrVpxOwbO9LcI0fUDMhyXg1S4nICdvKa0hxxuURBMQRRsw0DcLkg4nZmwokENUy4AiUBj8U9/DArmZszawpPEs4HNYXVDypXYrIc0/KQwsBxFgcbBiv09lmefs2MwLn4WppV7NCcNSMMbruH9BIW/9aw0MEZu0FIoBcQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caoositV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBFAC4CECC;
	Sun, 24 Nov 2024 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452121;
	bh=sf64Z8/K2JmDjSHufuyPNPpzb2t6/Com4h0XELkBt2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caoositVIPi/DlBvtIyXSN7VUM5x51dLwmLQgkiHEP72gJVoGzyPjTyP5AYZsKisQ
	 nXs4Frza7WYh0yBbaKF0vvXh5Y9FuHs1zHitWkhe+q/VP+Vt7uyr9nipdmo6MHLF9M
	 cBPZqOmXmxZvt0MyHjK9dHmZwFjuvow1ULXClOoU/7j4eoR/RQJl2ykgy9oH3QymR8
	 +oFxmGUOKDu0E2LZ0O1Rf6X/jpKi27TW2TiEPKlFTfFALag/PH6I2csLgjkOwPjUMf
	 wvNB5QLuq+p28/g5lYXRpYBU/xJuwBmby2rAqlIoZbu/ProyiCpB9xQOv5p9XFaZrG
	 faoFzawfRHsbQ==
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
Subject: [PATCH AUTOSEL 5.15 5/6] kselftest/arm64: Corrupt P0 in the irritator when testing SSVE
Date: Sun, 24 Nov 2024 07:41:41 -0500
Message-ID: <20241124124149.3336868-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124149.3336868-1-sashal@kernel.org>
References: <20241124124149.3336868-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index e3e08d9c7020e..f631d17c899d2 100644
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


