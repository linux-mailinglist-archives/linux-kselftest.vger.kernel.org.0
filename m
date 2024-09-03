Return-Path: <linux-kselftest+bounces-18207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA79D97E666
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE9128148E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498C8381B9;
	Mon, 23 Sep 2024 07:14:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554110F9;
	Mon, 23 Sep 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727075659; cv=none; b=ShIOWHa5/UVOTy2ieTbsE+ezuq03jyY2yYNrOHZ8jq35nZ9W464Yny1Uz3diTAYxrejg7S//4Ryq1eGVhQ/lXOvw8O5e9oL3JmyjhksZ/JP/zv4mPEUsIf+sdc7E7sLut5n5G2AzzNJEUhZ2sZBVxs+7Et47dkgGrIPdk/EB+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727075659; c=relaxed/simple;
	bh=x5Wk62IgIijt75WEyRRVjgBpTs6lTU7zBqjDq6XLbDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i2/jE+SB5GHBecU3r5Qg/bR+LW+fxRJq+R0qpDPqYHuJOwYy5fkXVFjNVJ3XS7zW/CvmarAhfqNAOzIi6iUlcmd0dkXTXkGkDEHcMdNaTdoB75BECeHBx4M6gIocmAXzcPZPJT8XUKliDw95nkhopezVqBjyjtCYIUMCT4rBGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566f1153f2fa-782fe;
	Mon, 23 Sep 2024 15:14:08 +0800 (CST)
X-RM-TRANSID:2ee566f1153f2fa-782fe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966f1152fda2-56de0;
	Mon, 23 Sep 2024 15:14:08 +0800 (CST)
X-RM-TRANSID:2ee966f1152fda2-56de0
From: Ba Jing <bajing@cmss.chinamobile.com>
To: chenxiang66@hisilicon.com
Cc: shuah@kernel.org,
	zhujun2@cmss.chinamobile.com,
	bajing@cmss.chinamobile.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma_map_benchmark: remove unused NSEC_PER_MSEC macro
Date: Tue,  3 Sep 2024 11:59:49 +0800
Message-Id: <20240903035949.10622-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro NSEC_PER_MSEC is never referenced in the code, just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index b12f1f9babf8..50283a83ae1b 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -13,8 +13,6 @@
 #include <linux/types.h>
 #include <linux/map_benchmark.h>
 
-#define NSEC_PER_MSEC	1000000L
-
 static char *directions[] = {
 	"BIDIRECTIONAL",
 	"TO_DEVICE",
-- 
2.33.0




