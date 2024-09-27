Return-Path: <linux-kselftest+bounces-18437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4C9987D39
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 05:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD321C2279F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9D5258;
	Fri, 27 Sep 2024 03:01:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979833EA;
	Fri, 27 Sep 2024 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727406089; cv=none; b=faVF1aXfjzo6A1xI6ifbbI9jkqfreuioFc7QOIpZdJ65lNoz/icxLqWMLhAQeqOZha5poWUZbyB5YcFSLCniY7E2y2KfKfSga9TGA7Ao6WgCr8dfC7I19bYkybs0NOS8V9Jz9NSg+C+6XVvlcJnDIKGXDzFu4rYNUA0D8aoZ0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727406089; c=relaxed/simple;
	bh=TKDYi1Est0qtsTfBoJQsqjNCm5BH5ShjwJeqn6DcCsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9oNKGwEDiDH+GfzZ3K2jIJDFzwx6ygOl+kIz0VmnJLAIPzZQhpX2H1pbUjZbW2MPhZlKF/HBBRXKOWz7fhOFvBoPxrky5Zdm1Z4rKzWhJtyTJXtG+H9LyqhguAWHYK30DzMzLELJpTQW4YKRRrt+mRk/LwlmszPe7tJzd/LF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166f61ff937c-6cc80;
	Fri, 27 Sep 2024 11:01:16 +0800 (CST)
X-RM-TRANSID:2ee166f61ff937c-6cc80
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166f61ffb975-2bc22;
	Fri, 27 Sep 2024 11:01:16 +0800 (CST)
X-RM-TRANSID:2ee166f61ffb975-2bc22
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] selftests/mm: Add missing free.
Date: Fri, 27 Sep 2024 11:01:14 +0800
Message-Id: <20240927030114.3792-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

There is a memory leak in mkdirty, just free src before return.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/testing/selftests/mm/mkdirty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 1db134063c38..af2fce496912 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -280,6 +280,7 @@ static void test_uffdio_copy(void)
 	dst = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
 	if (dst == MAP_FAILED) {
 		ksft_test_result_fail("mmap() failed\n");
+		free(src);
 		return;
 	}
 
-- 
2.33.0




