Return-Path: <linux-kselftest+bounces-27320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34758A414F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 06:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890603A50F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB451ACEBB;
	Mon, 24 Feb 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QdCGswTK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6626AFB;
	Mon, 24 Feb 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740376660; cv=none; b=lPRCyEbfp9G69j99nKQlWdKUzXJVJGlxeZ+mNx1ZCGF1NJei8GSFkFzjRZPa6Hby30DeVtYWMn6gH4KVu8uTHClvpH+JsvYaeMwBKQvSyUPqnegpwABk12W9gJhjSEtKGM0FlrpFqCu5cMQStLY4F3aTjsWdnjMIze0kqv7ZFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740376660; c=relaxed/simple;
	bh=ZghOa/rh7/XYmJlUMNYJZStWfXtLSRK7dnQ0UkvSyAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=InWpAaR+P8VQRYUwFLGY2Er6igB4AWysOCr35jLr9guZ5h+2m+mme+vZRKaLfObxTQppBhw+6vMMczXZDl0ZVDN5Bjob47ZkYyqxZlugONCOENHujs3d9B2vPZBwQ3ihX/Xr0BQEB7cnkaHcIOk30CMm2np/CvRIilzt4Z37FDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QdCGswTK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740376649; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PkQdJ1EwM6LyBpKOZQnLPZsBn40VnpFifRy4oWcDI+g=;
	b=QdCGswTKdcQiRc00lnu+gIgihRTfgZuSsoVALSIqMaphBs+aD30CdQEk63xb9z44p6IiBntB/rwOx1xGPRK0hYPgRz401jy4hQJZZ9sO7Lp8IeICRWb+ps4UeDIOco97SxZY75YpYWsFWQuuVbbxEk0Wf5uVpOEvFrvLXBs+rzc=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WQ2fAKH_1740376628 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 13:57:28 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] selftests/filesystems: Remove duplicate sys/types.h header
Date: Mon, 24 Feb 2025 13:57:07 +0800
Message-Id: <20250224055707.114093-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./tools/testing/selftests/filesystems/utils.c: sys/types.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19042
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/filesystems/utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index e553c89c5b19..06419bf4ba19 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #endif
 #include <fcntl.h>
-#include <sys/types.h>
 #include <dirent.h>
 #include <grp.h>
 #include <linux/limits.h>
-- 
2.32.0.3.g01195cf9f


