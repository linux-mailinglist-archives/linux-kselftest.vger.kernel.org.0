Return-Path: <linux-kselftest+bounces-22654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992069DFAA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DDB21808
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1701D6DDF;
	Mon,  2 Dec 2024 06:18:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995833F6;
	Mon,  2 Dec 2024 06:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733120307; cv=none; b=BJZH35lQNMR7l1G8Vg+PmBAXOGHC5ULNMxrA8xZRKHz34G7KnaD+r6ZWwkDfbjGMxm+7xkFabVqd55s7I3ALT6diTXo5s6kMegYVbueJD/VPVPM8fWiXE+9XRFsKeKLL2z8s4rLhngc2eeMc0loCmFP9CNFfB7g74GzdTwTpiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733120307; c=relaxed/simple;
	bh=3JFTkuNFQcN8qX6OhnkEhHz4I4p1K/TpY3YTFQuzY18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hqfdv6rRinmS164apPwgElDWzGk0ND8iWQQxU4JwYTrVheF7pEaCHr4I0gjJowIlUkBiUL1LXRHfmh/waLjk7amFyEfMHpZ6rI5aQmZlb1cCcSeyKz+1UWmWxE1OGHXtZlUxPSPDYM24cy0rPnTbM4ydpCzlJD2oZ7rFQ3EGH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4674d5127bf1-864fb;
	Mon, 02 Dec 2024 14:18:16 +0800 (CST)
X-RM-TRANSID:2ee4674d5127bf1-864fb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8674d51265cd-dac6e;
	Mon, 02 Dec 2024 14:18:16 +0800 (CST)
X-RM-TRANSID:2ee8674d51265cd-dac6e
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests: kselftest: Fix the wrong format specifier
Date: Mon,  2 Dec 2024 12:31:11 +0800
Message-Id: <20241202043111.3888-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The format specifier of "unsigned int" in printf()
should be "%u", not "%d".

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 29fedf609611..062c02a7be2d 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -403,7 +403,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...
 	 */
 	if (ksft_plan || ksft_test_num()) {
 		ksft_cnt.ksft_xskip++;
-		printf("ok %d # SKIP ", 1 + ksft_test_num());
+		printf("ok %u # SKIP ", 1 + ksft_test_num());
 	} else {
 		printf("1..0 # SKIP ");
 	}
-- 
2.33.0




