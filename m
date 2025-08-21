Return-Path: <linux-kselftest+bounces-39519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3266DB2FE1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A5A07E9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED982F6193;
	Thu, 21 Aug 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iAK3Yt20"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4A20B218;
	Thu, 21 Aug 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789197; cv=none; b=WNRZdw5u9rJ0aV1s5Cp5LpCnWBkWtnqTzzOn9rk+88qzpZbTpp8EEM1/XXDaEV+HTw72HggkTjthMfjHmWYf/eFYhdOYsJZ0w3GDYC9M17tDPQgFw+jsjjVrPW/BvN9Gd1aUkVjLL116CXuNabRPaHHgjSCb1t6HTCaaFpQjmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789197; c=relaxed/simple;
	bh=h/4lrKAX6pF/gjGhEXhKe5bBTHwGePjRZnh/r+I4xI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHw6zAUelfPSwdcuB2CIO9eaoRCrjY25kZCA3EQTgru5JOF5CFBV3zRx0MIcyCW9qwtfQKTopoPGlhGhaTqq3yYuZq3yf0MIs3AbAZvi58Ab6KbNl1pnFxOXzROs7x64CQLNss2eCOEtwJ0bgrld5QhENc8oZwK4DBqdESch9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iAK3Yt20; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755789186;
	bh=h/4lrKAX6pF/gjGhEXhKe5bBTHwGePjRZnh/r+I4xI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iAK3Yt209KoUD5hZLoakwBGYllm7FZn2mNfFs8SUAjwxpvDND+DcEhqweUbyX04ZS
	 Ec2UW43S3gLMOWXSQu461XAx0VZg5ureV6xd61Jxc0+VIIa5D4M/UwaQQD8fS2mmSN
	 8m5SKRzpBm2jGKj4zmdSZKrvvVWJC+N7BIDNfX00=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:13:03 +0200
Subject: [PATCH 2/2] kselftest/arm64/gcs: Use nolibc's getauxval()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-gcs-fixes-v1-2-88519836c915@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755789186; l=1309;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=h/4lrKAX6pF/gjGhEXhKe5bBTHwGePjRZnh/r+I4xI4=;
 b=hIZZJkYzmN2hdyvFbNdtAvwuxrH719lR2ZzZJRUedITZyThsSbc/iRxqfkT61PGxExwDfboaA
 rHiSZqT3Cx3Dy4prmE4ufwjTxVehaU0ivf0eJruoKdrB4KZF1fPQude
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Nolibc now does have getauxval(), use it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
index 100d2a983155f7347a19b2b8b88f9494dc6a51d5..250977abc3988685abf68666d35b7a8547f74f4e 100644
--- a/tools/testing/selftests/arm64/gcs/basic-gcs.c
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -10,6 +10,7 @@
 
 #include <sys/mman.h>
 #include <asm/mman.h>
+#include <asm/hwcap.h>
 #include <linux/sched.h>
 
 #include "kselftest.h"
@@ -386,14 +387,13 @@ int main(void)
 
 	ksft_print_header();
 
-	/*
-	 * We don't have getauxval() with nolibc so treat a failure to
-	 * read GCS state as a lack of support and skip.
-	 */
+	if (!(getauxval(AT_HWCAP) & HWCAP_GCS))
+		ksft_exit_skip("SKIP GCS not supported\n");
+
 	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
 			  &gcs_mode, 0, 0, 0);
 	if (ret != 0)
-		ksft_exit_skip("Failed to read GCS state: %d\n", ret);
+		ksft_exit_fail_msg("Failed to read GCS state: %d\n", ret);
 
 	if (!(gcs_mode & PR_SHADOW_STACK_ENABLE)) {
 		gcs_mode = PR_SHADOW_STACK_ENABLE;

-- 
2.50.1


