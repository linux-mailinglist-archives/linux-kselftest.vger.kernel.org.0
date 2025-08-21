Return-Path: <linux-kselftest+bounces-39517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6BEB2FE12
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4891C8448C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CE2D7818;
	Thu, 21 Aug 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RmuQ0Fx8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA3224234;
	Thu, 21 Aug 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789196; cv=none; b=PDOCD3RbYZmLlePiw3tj53qD8gYEAA6dbukclA+liTAXVq3+746CFRINRgmKulxEyIOx28GrAHrG2ORnlrPHpvqrc/UBCdpg8kv2puIOmq4Kef2bV/kuD/Qrltqvac5bN79884VrpJ272ZrzGJXaDxJF0J1B9yi4pIQDYpk20es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789196; c=relaxed/simple;
	bh=6EpRJ0Xfy+QCs9ctVXp6cVbyBNBAtx5211b7njYkhrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQjh0Zpe0QWdkUbxlC3rX1eEyOtr42Rd8bN59p2lJdamnLUfH5mNipCmI9sT8M95gL/NIm41aJ5pBVmRnAmgxKai4SWZO9f+jGYJkjU/dJk8OFPQXMRVN8ZhQc2UVT3qaCbmY4mguPmXNK95bQKKKxS7vWMuofp8md/qgzri46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RmuQ0Fx8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755789186;
	bh=6EpRJ0Xfy+QCs9ctVXp6cVbyBNBAtx5211b7njYkhrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RmuQ0Fx8PSY+jFpL9QaWEv+rmRSQFMwzxujYPwDofuO7aO4a0NGmy6IP9y3EHo3tE
	 bZFRGIzus5kUT4WITHxwPbVxf7OA6g2tg4vW2Tv78goo8B5SI5jSCUamkTU484slwU
	 fKwYAKLz1AvEUyy70SfybLakPNRkhz14Z9Jwr7DU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:13:02 +0200
Subject: [PATCH 1/2] kselftest/arm64/gcs: Correctly check return value when
 disabling GCS
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-gcs-fixes-v1-1-88519836c915@weissschuh.net>
References: <20250821-nolibc-gcs-fixes-v1-0-88519836c915@weissschuh.net>
In-Reply-To: <20250821-nolibc-gcs-fixes-v1-0-88519836c915@weissschuh.net>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755789186; l=984;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6EpRJ0Xfy+QCs9ctVXp6cVbyBNBAtx5211b7njYkhrs=;
 b=11Pm092QniwA1C7akmN/woe12MP6+ssB98JgfCEkl6lfy9QfgApnV3kEZCvBBgBbKkm0rjuW0
 AXoNaBLBMTfAWs8kkzmX7fq7gdjKCw5Is5MNRGwyWB8EFR51dmT8Ph6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The return value was not assigned to 'ret', so the check afterwards
does not do anything.

Fixes: 3d37d4307e0f ("kselftest/arm64: Add very basic GCS test program")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
index 54f9c888249d74451e1432280a395156ce72e56c..100d2a983155f7347a19b2b8b88f9494dc6a51d5 100644
--- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -410,7 +410,7 @@ int main(void)
 	}
 
 	/* One last test: disable GCS, we can do this one time */
-	my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
+	ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
 	if (ret != 0)
 		ksft_print_msg("Failed to disable GCS: %d\n", ret);
 

-- 
2.50.1


