Return-Path: <linux-kselftest+bounces-28996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9FA609EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC71888AFD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FB1946C7;
	Fri, 14 Mar 2025 07:15:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2E85C192B90;
	Fri, 14 Mar 2025 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936514; cv=none; b=tZf8uG+rp0OVhxpqnZ/LdH+2KEXA7Z/+dYpsEwXvAniRGdFXOCw4dCAStDKpzma6/EUWbFMm6yXudnUJkPbcIYyv9UOkJuo0y633+rIZE1d7ZSKdXsDb7CmhXqG/PJRNk+IP+2R++KsPhMu3ncoy3jMQZ9YmZS1oFtX3pkqCzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936514; c=relaxed/simple;
	bh=nr//3ymoIr2kXu5Wal9VqeaXpouWjvTZB3gAxPELClc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=a84quFMNNZDMoRz5058lgSL2qfmYwQD9m4rcbgai2Kz+M8CjvCwf+FSUz9MXCBsR+7KqddT8b+/btzWw2G9s5vjJDYHWpdxsRTbmRNWGvgvB4u2Am173kOxOsx2B/K+b0uFwnx5Ybxz4lOx8b6MR+cOlZ5SS0ZdLK4Dwda3Wypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 35C206068097C;
	Fri, 14 Mar 2025 15:15:09 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: zfigura@codeweavers.com,
	shuah@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	wine-devel@winehq.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/4] selftests: ntsync: avoid possible overflow in 32-bit machine
Date: Fri, 14 Mar 2025 15:14:52 +0800
Message-Id: <20250314071454.201697-3-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250314071454.201697-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using '-m32' flag  to compile this test with gcc, there are some
errors when running test:

 ntsync.c:785:wake_any:Expected ETIMEDOUT (110) == ret (0)
 ntsync.c:823:wake_any:Expected (1) (1) == __count (0)
 ...
 FAILED: 7 / 11 tests passed.
 Totals: pass:7 fail:4 xfail:0 xpass:0 skip:0 error:0

There is an overflow about 'timeout'. 'timespec->tv_sec' is 4 bytes in
32-bit machine. And 'timeout.tv_sec * 1000000000' causing the overflow
problem, adding a cast to avoid this problem.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 tools/testing/selftests/drivers/ntsync/ntsync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index bfb6fad653d0..ded83dc58e6b 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -103,7 +103,7 @@ static int wait_objs(int fd, unsigned long request, __u32 count,
 
 	clock_gettime(CLOCK_MONOTONIC, &timeout);
 
-	args.timeout = timeout.tv_sec * 1000000000 + timeout.tv_nsec;
+	args.timeout = (__u64)timeout.tv_sec * 1000000000 + timeout.tv_nsec;
 	args.count = count;
 	args.objs = (uintptr_t)objs;
 	args.owner = owner;
@@ -729,7 +729,7 @@ static __u64 get_abs_timeout(unsigned int ms)
 {
 	struct timespec timeout;
 	clock_gettime(CLOCK_MONOTONIC, &timeout);
-	return (timeout.tv_sec * 1000000000) + timeout.tv_nsec + (ms * 1000000);
+	return ((__u64)timeout.tv_sec * 1000000000) + timeout.tv_nsec + (ms * 1000000);
 }
 
 static int wait_for_thread(pthread_t thread, unsigned int ms)
-- 
2.30.2


