Return-Path: <linux-kselftest+bounces-40158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B26B39703
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2AD1895D35
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 08:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783962DE1FE;
	Thu, 28 Aug 2025 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BST+qMrX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC630CDA9;
	Thu, 28 Aug 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369872; cv=none; b=budvadBrN5yybVVpGoIPMCrF+caCMdPhDW0dRPaaGB5XQ+wPLBuv3dTBGtt0Qggwmuus9dAppr3XbAj5TbDfBEFXgAItXTF8fIi+oPL/FogV8N84X0NEGXfR5Z6s4mbFBftJavTWzcvpfWaRhgCn2wZ8rss6webo9F9woFDDzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369872; c=relaxed/simple;
	bh=JU8e67JXoyDcoiz+WOWMpbDnRwoX/LcgBXcbmLV4mCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pC6V8nAghOJKMkJc5ZX63w5wD7Dbhm+7laTbQTqfZmc7buYQRBZ0IMWSn1zNtjv/1yiUbFEoxZbqOpKgHo+hFvHmK7o9eE4Ul10/XqNSJ7PnnzSNwoyfj2J1obeEbx1p4gG03fWlhX1ZsymLJUxOsKpBoTNT845i4H1c45vCLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BST+qMrX; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dc
	Z8eW9SfHiaSW+F0WbLPWjXirgK7fUM+UexN7NPa50=; b=BST+qMrXAv/T1mdSer
	7tyOZb0Dypvq9iz9AzkuonSldGk5XTYQ+Zyxz9C8KMAjEj+plFXQ58LxyiIP75v8
	jMXFrH6qSEJKQYATlKIswn6MBRKUGuKijfPr9KxvcNTAfOYvFu+zVv04rv1P+k1A
	iQw1AN82j52UIVuFkHbqBwKg8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXnwTEE7BoG8c8FA--.36775S2;
	Thu, 28 Aug 2025 16:31:00 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhou Yuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH] selftests: filelock: Initialize the flock to zero
Date: Thu, 28 Aug 2025 16:30:58 +0800
Message-Id: <20250828083058.2173695-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXnwTEE7BoG8c8FA--.36775S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17ZFWkAry3Jw1kury5twb_yoWkArgEkr
	yjqrZ7Jr1vgF1Fyrs7K3WrKrZ5t3WUCr4xXwn8Ka13Ary5Ca1UAFWDXr18ZF18GFZ5G3yS
	kayj9r9Ikr17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVyDUUUUU==
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiYAm3JmiwD8BelwABsn

From: Zhou Yuhang <zhouyuhang@kylinos.cn>

Flock fl and fl2 are not initialized after definition.
Due to struct padding, this may cause memcmp() to return
a non-zero value. The output is as follows:

 # [INFO] opened fds 3 4
 # [SUCCESS] set OFD read lock on first fd
 # [SUCCESS] read and write locks conflicted
 # [SUCCESS] F_UNLCK test returns: locked, type 0 pid -1 len 3
 # [FAIL] F_UNLCK test returns: locked, type 0 pid -1 len 3

Initialize them to zero to solve this problem.

Signed-off-by: Zhou Yuhang <zhouyuhang@kylinos.cn>
---
 tools/testing/selftests/filelock/ofdlocks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..84e25505bebb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -36,6 +36,8 @@ int main(void)
 {
 	int rc;
 	struct flock fl, fl2;
+	memset(&fl, 0, sizeof(fl));
+	memset(&fl2, 0, sizeof(fl2));
 	int fd = open("/tmp/aa", O_RDWR | O_CREAT | O_EXCL, 0600);
 	int fd2 = open("/tmp/aa", O_RDONLY);
 
-- 
2.33.0


