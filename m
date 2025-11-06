Return-Path: <linux-kselftest+bounces-44874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3EC3931F
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 06:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14EDB34C04B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 05:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E52D8796;
	Thu,  6 Nov 2025 05:58:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DB28E9;
	Thu,  6 Nov 2025 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408710; cv=none; b=PwEjFiJgiQRUw8DPjoy7eG7/Ji20RxmLujuzCFoGcKqsUHgHk0sXgl5loBCy6utfLzDvxrEXTcUwslSs/shRbKhHMjWHu1f9geaPtH/w2PF/vpzdeCelcwXipmI+fCUm9UFTwYL0HN/1bw0XkKUXhuoT2JsuvIe6NX9nUDPYZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408710; c=relaxed/simple;
	bh=DswA1willBQzbF6hAF3QyQvRhGbnRQbotxR22cAl3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfVTusl1WaazsUhzR4vvgACGNFZjqGuVpYVidsRwePOQbnF2aCvm+BUQF5tol4uZMqjDe1qiccGJLgJ0R3UXh/4npCYLZUzGJ+XyGzVH50B7Pz47y/D0mn00gPn18rEy76UuiQIFb0Mrgvop2hwZ9CT6iiGZmsETuK4Hvi3vp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9690c38fc83e-aa902;
	Thu, 06 Nov 2025 13:58:23 +0800 (CST)
X-RM-TRANSID:2ee9690c38fc83e-aa902
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8690c38fd764-45acd;
	Thu, 06 Nov 2025 13:58:23 +0800 (CST)
X-RM-TRANSID:2ee8690c38fd764-45acd
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] selftest/alsa: correct grammar in conf_get_bool error string
Date: Thu,  6 Nov 2025 13:58:19 +0800
Message-ID: <20251106055819.1996-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phrase "an bool" is grammatically incorrect; it should be
"a bool".

Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 5b7c83fe87b3..317212078e36 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -448,7 +448,7 @@ int conf_get_bool(snd_config_t *root, const char *key1, const char *key2, int de
 		ksft_exit_fail_msg("key '%s'.'%s' search error: %s\n", key1, key2, snd_strerror(ret));
 	ret = snd_config_get_bool(cfg);
 	if (ret < 0)
-		ksft_exit_fail_msg("key '%s'.'%s' is not an bool\n", key1, key2);
+		ksft_exit_fail_msg("key '%s'.'%s' is not a bool\n", key1, key2);
 	return !!ret;
 }
 
-- 
2.50.1.windows.1




