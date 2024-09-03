Return-Path: <linux-kselftest+bounces-18210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39AB97E75F
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B021F21792
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E68191F91;
	Mon, 23 Sep 2024 08:17:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20993191F75;
	Mon, 23 Sep 2024 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079428; cv=none; b=tjKuZslE4829BLieYihnaDg41GGxIFSqkSdYUQG4rv8tE/9WHRnK5Iqi3O+0VhtcCib5x5d6zQRtCIa24wrgCDl8Bg/gaEdvHFis/2zEeYD3teZS638V8KaeubP2Y2EP1K3OuMFIzsyMxjbwod/Y4y5HO/u2tIm4DzEXSCKSeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079428; c=relaxed/simple;
	bh=yhVHNfGCJAxMxc8ooW+E7yXbgIE8uBQxA4zLSnMclpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o7yByo5Di+0VX6WtLwVu2SnSYvhV9LSnu6n7atQ2Q7WSU5YB09enNcY1aa73Aa1fAvsTBoffydVAZuTidKwDzOdiWHYeb38LRFTzRXvIF41e7rt3i+YUcfDXqp6yoZZM/zA9oX+0PoyQcYB3EwYw6YbmWkofwYQ+5MpvOX3emZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666f123fe26c-47b2f;
	Mon, 23 Sep 2024 16:17:03 +0800 (CST)
X-RM-TRANSID:2ee666f123fe26c-47b2f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166f123eff15-586e1;
	Mon, 23 Sep 2024 16:17:02 +0800 (CST)
X-RM-TRANSID:2ee166f123eff15-586e1
From: Ba Jing <bajing@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: bajing@cmss.chinamobile.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] memfd: fuse_mnt: remove unused macro
Date: Tue,  3 Sep 2024 12:44:55 +0800
Message-Id: <20240903044455.11268-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro FUSE_USE_VERSION is never referenced in the code,
just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/memfd/fuse_mnt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/memfd/fuse_mnt.c b/tools/testing/selftests/memfd/fuse_mnt.c
index 6936f2a001f3..f9f06fd43c5f 100644
--- a/tools/testing/selftests/memfd/fuse_mnt.c
+++ b/tools/testing/selftests/memfd/fuse_mnt.c
@@ -12,8 +12,6 @@
  * file-system.
  */
 
-#define FUSE_USE_VERSION 26
-
 #include <fuse.h>
 #include <stdio.h>
 #include <string.h>
-- 
2.33.0




