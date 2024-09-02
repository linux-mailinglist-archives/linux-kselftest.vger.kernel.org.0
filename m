Return-Path: <linux-kselftest+bounces-17018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0541C969349
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BBA1C22F57
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 05:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E761CDFA0;
	Tue,  3 Sep 2024 05:45:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C58312D20D;
	Tue,  3 Sep 2024 05:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725342321; cv=none; b=fIeQbM0ywmF/5PBZBqoakiwAFs4oCvA8aI15YxFxl9cHz7nykUHBoy0przu8fE3nLvjWYOz765giFryCUpu8THXDrBHBhW7O0tpHcDmMiESD/R+sZrkB2VnOu2sgzMTQ8cxRhaWqvYrhIeSl/5I2/Ap5XaI5q58LWacS9zFbjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725342321; c=relaxed/simple;
	bh=RWowS80iVgH6k0Jy6vms9nUCdvQMr8yAXUBZZg3PHDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VxMcvKFnnTDIvoFh1/mZVbAOJDiEBVzJFb1sKQ311ESnzGFUI8M3p4zlA7ea+3hXNPTLItOg83gwiW5iZRe+sHnYAuWSTupXbyDAj1iAHn2aXRgPr6xJtauIouzVG/3K4N+HNka1A2oNJsqR82SAZ9eTHSW3v2JY/Z8l6DOz+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866d6a264de9-13e1d;
	Tue, 03 Sep 2024 13:45:08 +0800 (CST)
X-RM-TRANSID:2ee866d6a264de9-13e1d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d6a2546d5-cd97d;
	Tue, 03 Sep 2024 13:45:08 +0800 (CST)
X-RM-TRANSID:2ee766d6a2546d5-cd97d
From: bajing <bajing@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bajing <bajing@cmss.chinamobile.com>
Subject: [PATCH] utimer-test: remove unused variables
Date: Mon,  2 Sep 2024 11:12:58 +0800
Message-Id: <20240902031258.2532-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable i is never referenced in the code, just remove it.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/alsa/utimer-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
index 32ee3ce57721..9d2683c83ef3 100644
--- a/tools/testing/selftests/alsa/utimer-test.c
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -140,7 +140,6 @@ TEST_F(timer_f, utimer) {
 TEST(wrong_timers_test) {
 	int timer_dev_fd;
 	int utimer_fd;
-	size_t i;
 	struct snd_timer_uinfo wrong_timer = {
 		.resolution = 0,
 		.id = UTIMER_DEFAULT_ID,
-- 
2.33.0




