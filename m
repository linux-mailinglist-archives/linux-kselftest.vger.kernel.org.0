Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C6C6C90D7
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Mar 2023 21:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjCYU7N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Mar 2023 16:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCYU7M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Mar 2023 16:59:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD242689;
        Sat, 25 Mar 2023 13:59:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x3so21044793edb.10;
        Sat, 25 Mar 2023 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679777949; x=1682369949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOkHB3mU6jZljf9gVbxLDgI3yP0VZBhBZesGbxbybZw=;
        b=SQGA7KYVH3D2WTBeR8641cnQbpEsmSL/lzoPf0KMRBYaAcJbrWB6Y/Usa7btzUu89e
         r6tcqtxJ0izxXzc/jWvX4kZgcePeScoLdAMg7aRtKKBQq132h7VXZhkaGzmg9o6cWKTk
         9jjqyJZQr4tkjzn1kxaSmvm/EnIQmzDGoo9pjJ2/5QKr/GfEFeM6yMh6yZMx67tCX999
         2PdlVRcD3adR5A8GvIUpgVzb/UQWBx/+Ro5zHWcCULKGSfs3B+cqPegOpSKdYohGg6sQ
         5gPlRhmDyXfNhmlOvtsHcD2rCsdc9XE+7VjkzGnHCEGB2rGfE9RDOyGUIkemZh2RErqF
         Nn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679777949; x=1682369949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOkHB3mU6jZljf9gVbxLDgI3yP0VZBhBZesGbxbybZw=;
        b=ONdS15/E7gEdZjm0RYd5gg64Ral3RMUFwv+KDKhq7l4AbieS+vpePfnArn/704gq3T
         5Hfwy3q5dvO+CJ2QONiDBParO82R4cvJViuITa9UOJZzcsJqcbZ2z7r84NhQgoUA8ZBR
         zGemJ9Xjv6bA0GsOYCbx0d6oLc6JjQsF1wLNSuxSXbq7XFAHZZBY8R2MeBOdpKFUkhNw
         ed/wXZ+okCc4Et1tuX93vfWQNKW2xtBU5IdKCww6963iN99YagtU4mezsDx5lhjnbfce
         0zhtvR7sn0l5Apa/ZsOzQEUnUrepnn6pvJIMD0c4DmV6yP1nuAmXAWaVuWuESX0An42F
         28Cg==
X-Gm-Message-State: AAQBX9dYsYsI6gp/Xq80F0LcPgdjgcJVU+vAmMUeOKFeEQjLChhAE055
        wyQLJDPWZBdY6D8v5QWPhFQ=
X-Google-Smtp-Source: AKy350Zf2xFKvcZ0tlVEUyhkALBh5Oi4WhTX1RmzmttS5oNlDzIhNHIiTko+UnihFhZxSlPsUTonrg==
X-Received: by 2002:a05:6402:268e:b0:502:1f7b:f0a6 with SMTP id w14-20020a056402268e00b005021f7bf0a6mr6842871edd.0.1679777948929;
        Sat, 25 Mar 2023 13:59:08 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004af62273b66sm12597440edj.18.2023.03.25.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 13:59:08 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     shuah@kernel.org, colin.i.king@gmail.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        himadrispandya@gmail.com
Subject: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_VMA action
Date:   Sun, 26 Mar 2023 00:59:02 +0400
Message-Id: <20230325205903.5550-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch will add the new test, which covers the prctl call with
PR_SET_VMA command. The test tries to give a name to the anonymous
VMA within the process memory map, and then checks the result of
the operation by parsing 'maps' virtual file.

Additionally, the test tries to call the prctl PR_SET_VMA command
with invalid arguments, and checks the error codes for correctness.

At the moment anonymous VMA naming through prctl call functionality
is not covered with any tests, so I think implementing it makes sense.

In version 2 of this patch I consider the selftest Makefile rule about
TARGETS entries order - I moved the 'prctl' entry in the Makefile to
follow the lexicographic order. In version 1 it was placed at the
end of the list.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/prctl/.gitignore      |   1 +
 tools/testing/selftests/prctl/Makefile        |   2 +-
 tools/testing/selftests/prctl/config          |   1 +
 .../selftests/prctl/set-anon-vma-name-test.c  | 104 ++++++++++++++++++
 5 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/prctl/config
 create mode 100644 tools/testing/selftests/prctl/set-anon-vma-name-test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 13a6837a0c6b..97dcdaa656f6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -58,6 +58,7 @@ TARGETS += nsfs
 TARGETS += pidfd
 TARGETS += pid_namespace
 TARGETS += powerpc
+TARGETS += prctl
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
diff --git a/tools/testing/selftests/prctl/.gitignore b/tools/testing/selftests/prctl/.gitignore
index 91af2b631bc9..7a657b25f686 100644
--- a/tools/testing/selftests/prctl/.gitignore
+++ b/tools/testing/selftests/prctl/.gitignore
@@ -2,3 +2,4 @@
 disable-tsc-ctxt-sw-stress-test
 disable-tsc-on-off-stress-test
 disable-tsc-test
+set-anon-vma-name-test
diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index c7923b205222..c058b81eeb41 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
-		disable-tsc-test
+		disable-tsc-test set-anon-vma-name-test
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/prctl/config b/tools/testing/selftests/prctl/config
new file mode 100644
index 000000000000..c6ed03c544e5
--- /dev/null
+++ b/tools/testing/selftests/prctl/config
@@ -0,0 +1 @@
+CONFIG_ANON_VMA_NAME=y
diff --git a/tools/testing/selftests/prctl/set-anon-vma-name-test.c b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
new file mode 100644
index 000000000000..26d853c5a0c1
--- /dev/null
+++ b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This test covers the anonymous VMA naming functionality through prctl calls
+ */
+
+#include <errno.h>
+#include <sys/prctl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <string.h>
+
+#include "../kselftest_harness.h"
+
+#define AREA_SIZE 1024
+
+#define GOOD_NAME "goodname"
+#define BAD_NAME "badname\1"
+
+#ifndef PR_SET_VMA
+#define PR_SET_VMA 0x53564d41
+#define PR_SET_VMA_ANON_NAME 0
+#endif
+
+
+int rename_vma(unsigned long addr, unsigned long size, char *name)
+{
+	int res;
+
+	res = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, addr, size, name);
+	if (res < 0)
+		return -errno;
+	return res;
+}
+
+int was_renaming_successful(char *target_name, unsigned long ptr)
+{
+	FILE *maps_file;
+
+	char line_buf[512], name[128], mode[8];
+	unsigned long start_addr, end_addr, offset;
+	unsigned int major_id, minor_id, node_id;
+
+	char target_buf[128];
+	int res = 0, sscanf_res;
+
+	// The entry name in maps will be in format [anon:<target_name>]
+	sprintf(target_buf, "[anon:%s]", target_name);
+	maps_file = fopen("/proc/self/maps", "r");
+	if (!maps_file) {
+		printf("## /proc/self/maps file opening error\n");
+		return 0;
+	}
+
+	// Parse the maps file to find the entry we renamed
+	while (fgets(line_buf, sizeof(line_buf), maps_file)) {
+		sscanf_res = sscanf(line_buf, "%lx-%lx %7s %lx %u:%u %u %s", &start_addr,
+					&end_addr, mode, &offset, &major_id,
+					&minor_id, &node_id, name);
+		if (sscanf_res == EOF) {
+			res = 0;
+			printf("## EOF while parsing the maps file\n");
+			break;
+		}
+		if (!strcmp(name, target_buf) && start_addr == ptr) {
+			res = 1;
+			break;
+		}
+	}
+	fclose(maps_file);
+	return res;
+}
+
+FIXTURE(vma) {
+	void *ptr_anon, *ptr_not_anon;
+};
+
+FIXTURE_SETUP(vma) {
+	self->ptr_anon = mmap(NULL, AREA_SIZE, PROT_READ | PROT_WRITE,
+					MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	ASSERT_NE(self->ptr_anon, NULL);
+	self->ptr_not_anon = mmap(NULL, AREA_SIZE, PROT_READ | PROT_WRITE,
+					MAP_PRIVATE, 0, 0);
+	ASSERT_NE(self->ptr_not_anon, NULL);
+}
+
+FIXTURE_TEARDOWN(vma) {
+	munmap(self->ptr_anon, AREA_SIZE);
+	munmap(self->ptr_not_anon, AREA_SIZE);
+}
+
+TEST_F(vma, renaming) {
+	TH_LOG("Try to rename the VMA with correct parameters");
+	EXPECT_GE(rename_vma((unsigned long)self->ptr_anon, AREA_SIZE, GOOD_NAME), 0);
+	EXPECT_TRUE(was_renaming_successful(GOOD_NAME, (unsigned long)self->ptr_anon));
+
+	TH_LOG("Try to pass invalid name (with non-printable character \\1) to rename the VMA");
+	EXPECT_EQ(rename_vma((unsigned long)self->ptr_anon, AREA_SIZE, BAD_NAME), -EINVAL);
+
+	TH_LOG("Try to rename non-anonynous VMA");
+	EXPECT_EQ(rename_vma((unsigned long) self->ptr_not_anon, AREA_SIZE, GOOD_NAME), -EINVAL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1

