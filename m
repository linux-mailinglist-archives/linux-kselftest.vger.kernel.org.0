Return-Path: <linux-kselftest+bounces-17344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B796E79E
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 04:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFED1F240B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 02:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45261CA94;
	Fri,  6 Sep 2024 02:19:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2651DA32;
	Fri,  6 Sep 2024 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589174; cv=none; b=REd58u0SeBm1YViCaiys+UoGIbzBSgxgImMWPlUfVmQ2sxiQPMGosUsK3byCMvrCGbcXKLOGzakHVMU0u3Vcw6Gwcj2fjKGQqunx5NDqbKR1aosenz5PW1M5OqAoXoDnHooiPoyAOFtbqT0Q5Y8HxeRb95lmsUtV6yZTMP/DveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589174; c=relaxed/simple;
	bh=s5Nne5LZ9SNHXUrCrmat+rbToYA5Uj/nMUjBN4q1x9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQ6gGDh1fo97XXoxP2DT0TKpOay/wvy+mH8KwGFvHVGfb/ogd4+ap+aqBGoIqIXMEqecr09L/vyROJ9v+/f7KurALCyQzSjPM+r1ZqtkFDwemZf68UuNa0SbP2WmH8TdWSV5LUslVFTILr5QT9vFJoOdscBejciYmdZiCp1pv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee166da66a8531-c2e33;
	Fri, 06 Sep 2024 10:19:21 +0800 (CST)
X-RM-TRANSID:2ee166da66a8531-c2e33
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566da66a8f49-8ed8e;
	Fri, 06 Sep 2024 10:19:21 +0800 (CST)
X-RM-TRANSID:2ee566da66a8f49-8ed8e
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mingo@redhat.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH v3] selftests: futex: Fix missing free in main
Date: Fri,  6 Sep 2024 10:19:18 +0800
Message-Id: <20240906021918.3125-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

By readind the code, I found there is no free() after asprintf().
Just free it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
v2->v3:
	Use a bool flag to determine if test_name needs free.

 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 215c6cb539b4..a103c69c0a3b 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -26,6 +26,7 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <string.h>
+#include <stdbool.h>
 #include "atomic.h"
 #include "futextest.h"
 #include "logging.h"
@@ -362,6 +363,7 @@ int main(int argc, char *argv[])
 {
 	char *test_name;
 	int c, ret;
+	bool is_static = false;
 
 	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
 		switch (c) {
@@ -404,6 +406,7 @@ int main(int argc, char *argv[])
 		       "%s broadcast=%d locked=%d owner=%d timeout=%ldns",
 		       TEST_NAME, broadcast, locked, owner, timeout_ns);
 	if (ret < 0) {
+		is_static = true;
 		ksft_print_msg("Failed to generate test name\n");
 		test_name = TEST_NAME;
 	}
@@ -416,5 +419,7 @@ int main(int argc, char *argv[])
 	ret = unit_test(broadcast, locked, owner, timeout_ns);
 
 	print_result(test_name, ret);
+	if (!is_static)
+		free(test_name);
 	return ret;
 }
-- 
2.33.0




