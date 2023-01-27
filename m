Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1A67E77B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjA0N6m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjA0N62 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:28 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AEA2312C;
        Fri, 27 Jan 2023 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827888;
        bh=7jIfTNCu7zpPLHJpUW3uli6pP+V4do4UcRBq1ufAji0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvURC9U1jZI6BZB0ToC7FIqkTyLlEnklVvuXSavwfDi5OJBDX8BbJXZTVE79Ro1y6
         qjBz5USNdaQ2LoEooh45BZZu4u+Rq89a3B6BiCzSpKF/+cY2d24icng8W/rckilmVS
         dEWIWRrHyG5u6e2QrwlYdQtH2dKLtY23jQ94Xl6RE5ByZ5jHlQFz4bvt3eduq19B1v
         lHNALEEByemodJogrT+eLdLnV+a2Bt8Rd8QOcsEZuJvb8wBRZOB/5FMC3ms4pqhG8D
         mLCtXVrL50YGcn2QL1btABgcOT7KTgpThZzkjbE9X5bsIV5Y6AMNERja4NMFJAr74T
         WL6yOCtK/O26A==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0c1jKPzhd4;
        Fri, 27 Jan 2023 08:58:08 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 34/34] selftests: tdx: Use installed kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:55 -0500
Message-Id: <20230127135755.79929-35-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use $(KHDR_INCLUDES) as lookup path for installed kernel headers rather
than using kernel headers in include/uapi from the source kernel tree
kernel headers.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
---
 tools/testing/selftests/tdx/Makefile         | 2 +-
 tools/testing/selftests/tdx/tdx_guest_test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tdx/Makefile b/tools/testing/selftests/tdx/Makefile
index 8dd43517cd55..306e9c4d5ef7 100644
--- a/tools/testing/selftests/tdx/Makefile
+++ b/tools/testing/selftests/tdx/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O3 -Wl,-no-as-needed -Wall -static
+CFLAGS += -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES) -static
 
 TEST_GEN_PROGS := tdx_guest_test
 
diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
index 2a2afd856798..81d8cb88ea1a 100644
--- a/tools/testing/selftests/tdx/tdx_guest_test.c
+++ b/tools/testing/selftests/tdx/tdx_guest_test.c
@@ -12,8 +12,8 @@
 #include <errno.h>
 #include <fcntl.h>
 
+#include <linux/tdx-guest.h>
 #include "../kselftest_harness.h"
-#include "../../../../include/uapi/linux/tdx-guest.h"
 
 #define TDX_GUEST_DEVNAME "/dev/tdx_guest"
 #define HEX_DUMP_SIZE 8
-- 
2.25.1

