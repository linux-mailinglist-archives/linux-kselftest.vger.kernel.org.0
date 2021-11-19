Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AF7456819
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 03:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhKSCdf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 21:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhKSCde (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 21:33:34 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD7C061574;
        Thu, 18 Nov 2021 18:30:33 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b4so7265015pgh.10;
        Thu, 18 Nov 2021 18:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfWoU11i9l1hrghcFLr0V/V4RGmiMDJFhLcgjw/m3ds=;
        b=bIRdy2sa1gDo/Wfq/jeFgkddF0d9qPL/TNUY+KGvLVjQxaenIxADBMxT9xMwOdWaUq
         w8h+OySr3K66TftwzJrFCOXw2SKf9k+hV6DGAYciq+eXCohSmWOmYZFIRz7rWuBrzyAn
         E00TqrbA3iwMgYQTP5ZRp450/6gvRxYuvtTCEzNWAEgmtcTbScgiMfjUmCUbbN9Q0dgA
         yXpd8jhCDyhadnwcno+EcnMU3/clmeRL8dftAjvcEQ8yZUWAiuBpaD1G2fCTCcN2g//R
         lSy9M/J+TNsjQa364w+hpU2an2iuw3qwgc6At7wXMsR2cTUAQiT44mWmeZzIFhO79NKt
         0BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfWoU11i9l1hrghcFLr0V/V4RGmiMDJFhLcgjw/m3ds=;
        b=cFz4laBxxtKbpM1DJkvTR25PgJcIpJNqMsJHp7f0bVYnTi5t9hRnqzmag+6Z5XNMbi
         hWI3BrEXWYCxZmEz32y/ixEemL/EWdetn2+bMCIh2MwzB6+EnWIpJM3BX/k0ZrF1ZGNJ
         z4Hkjiu4G+ubZyxLFCzqzgPP2HZcI6xdUHfzCb8g6ukAS0LCjGbiFgryh3RK1W0vUlu8
         YWNuV3oCxS0mxkpD/PW78FS1k7wkjmoizAExbA0EDTCy/SIRd77PlVpD/VIYkZIewfmW
         ZtALpNZKJTJMxsKKTeO6hXNie4cC2x5OsBDqvh0k7LS0HxdPnP/wyIjVdiVL00W7rrPZ
         BlkA==
X-Gm-Message-State: AOAM531+FomK/PO1LDL+hVoCnnVm786xqUbbEFtY07z+x7h58xGWGY4g
        Ra5CMMMkWKCW04AhgoqJpdc=
X-Google-Smtp-Source: ABdhPJz0wiJH1Nmv3CCtEgPH9qJYpX9Df6pmNmMG16++XhVxMKcMSrgvuZaSSxdLlnlaHNEC+weLlA==
X-Received: by 2002:a05:6a00:1a8d:b0:49f:de63:d9c0 with SMTP id e13-20020a056a001a8d00b0049fde63d9c0mr59790884pfv.79.1637289032688;
        Thu, 18 Nov 2021 18:30:32 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g20sm975734pfj.12.2021.11.18.18.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 18:30:31 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shuah@kernel.org
Cc:     christian.brauner@ubuntu.com, cyphar@cyphar.com,
        chi.minghao@zte.com.cn, rgb@redhat.com,
        baolin.wang@linux.alibaba.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] openat2: use ARRAY_SIZE instead of ARRAY_LEN
Date:   Fri, 19 Nov 2021 02:30:25 +0000
Message-Id: <20211119023025.1945-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

ARRAY_SIZE defined in <linux/kernel.h> is safer than self-defined
macros to get size of an array such as ARRAY_LEN used here.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 tools/testing/selftests/openat2/openat2_test.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 1bddbe934204..c467f85e854e 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#include <linux/kernel.h>
 #include <fcntl.h>
 #include <sched.h>
 #include <sys/stat.h>
@@ -82,14 +83,14 @@ void test_openat2_struct(void)
 		  .size = sizeof(struct open_how_ext), .err = -E2BIG },
 	};
 
-	BUILD_BUG_ON(ARRAY_LEN(misalignments) != NUM_OPENAT2_STRUCT_VARIATIONS);
-	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_STRUCT_TESTS);
+	BUILD_BUG_ON(ARRAY_SIZE(misalignments) != NUM_OPENAT2_STRUCT_VARIATIONS);
+	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_STRUCT_TESTS);
 
-	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
 		struct struct_test *test = &tests[i];
 		struct open_how_ext how_ext = test->arg;
 
-		for (int j = 0; j < ARRAY_LEN(misalignments); j++) {
+		for (int j = 0; j < ARRAY_SIZE(misalignments); j++) {
 			int fd, misalign = misalignments[j];
 			char *fdpath = NULL;
 			bool failed;
@@ -240,9 +241,9 @@ void test_openat2_flags(void)
 		  .how.resolve = 0, .err = -EINVAL },
 	};
 
-	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_FLAG_TESTS);
+	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_FLAG_TESTS);
 
-	for (int i = 0; i < ARRAY_LEN(tests); i++) {
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
 		int fd, fdflags = -1;
 		char *path, *fdpath = NULL;
 		bool failed = false;
-- 
2.25.1

