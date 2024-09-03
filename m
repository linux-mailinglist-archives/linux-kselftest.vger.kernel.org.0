Return-Path: <linux-kselftest+bounces-18208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E08B97E6A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54DB1F22954
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 07:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26CB3E49E;
	Mon, 23 Sep 2024 07:31:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6F17741;
	Mon, 23 Sep 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076712; cv=none; b=cRxS21S8I027cBK7tFPuwTng+p6FapQUeXP+ByX1l86tj0YZXkkq4KNcEJ14+HQrQ+iYzK+ErIJxwqXJSAtViEN3tKaHxBkGK+ub8WM72GKyzmwuiaAxW16pmchJ6N9J/b6JwYshDUOs8LQ73U+oVFtmw9DZzSGB5bLip+u9gLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076712; c=relaxed/simple;
	bh=elqByFWh5GHxLKOzHe6uhAkoZrMhYzEHUUpGfpo8fQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZHPAKcfgNRMsDTTOquOmUOX34gEWHgqiMw4PPl3kgv34UQE7+ns143CPQrGqvTUlyaJI1474Lq/zoOCUDRcsVJYlLlC91fro8oM//ywGAUTfLQbLouGaQ/F1MHDPrNuHtLtIQlJXXEUqRH/it1iQ4fbLRam9DMnaSu81kdw5Ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166f11961015-48918;
	Mon, 23 Sep 2024 15:31:46 +0800 (CST)
X-RM-TRANSID:2ee166f11961015-48918
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66f1195156e-54c1b;
	Mon, 23 Sep 2024 15:31:46 +0800 (CST)
X-RM-TRANSID:2eea66f1195156e-54c1b
From: Ba Jing <bajing@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: yutingtseng@google.com,
	cmllamas@google.com,
	gregkh@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] binderfs: binderfs_test: remove unused variable
Date: Tue,  3 Sep 2024 12:16:20 +0800
Message-Id: <20240903041620.10812-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable "wret" is never referenced in the code, just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 319567f0fae1..81db85a5cc16 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -57,7 +57,6 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 {
 	int fd, ret, saved_errno, result = 1;
 	size_t len;
-	ssize_t wret;
 	struct binderfs_device device = { 0 };
 	struct binder_version version = { 0 };
 	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
-- 
2.33.0




