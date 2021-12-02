Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54669466833
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359605AbhLBQbH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 11:31:07 -0500
Received: from foss.arm.com ([217.140.110.172]:37470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359617AbhLBQak (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 11:30:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E526B142F;
        Thu,  2 Dec 2021 08:27:17 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C997C3F73B;
        Thu,  2 Dec 2021 08:27:16 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cyphar@cyphar.com, shuah@kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/3] selftests: openat2: Print also errno in failure messages
Date:   Thu,  2 Dec 2021 16:26:52 +0000
Message-Id: <20211202162654.29704-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In E_func() macro, on error, print also errno in order to aid debugging.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/openat2/helpers.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index a6ea27344db2..ad5d0ba5b6ce 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -62,11 +62,12 @@ bool needs_openat2(const struct open_how *how);
 					(similar to chroot(2)). */
 #endif /* RESOLVE_IN_ROOT */
 
-#define E_func(func, ...)						\
-	do {								\
-		if (func(__VA_ARGS__) < 0)				\
-			ksft_exit_fail_msg("%s:%d %s failed\n", \
-					   __FILE__, __LINE__, #func);\
+#define E_func(func, ...)						      \
+	do {								      \
+		errno = 0;						      \
+		if (func(__VA_ARGS__) < 0)				      \
+			ksft_exit_fail_msg("%s:%d %s failed - errno:%d\n",    \
+					   __FILE__, __LINE__, #func, errno); \
 	} while (0)
 
 #define E_asprintf(...)		E_func(asprintf,	__VA_ARGS__)
-- 
2.17.1

