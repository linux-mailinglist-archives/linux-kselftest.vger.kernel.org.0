Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C356A98D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 14:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCCNoW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 08:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCCNoS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 08:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0FE12865
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Mar 2023 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677850963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VRBvAso0m6Mh4AYb8jIiudho0ePNxChhIVaVb3X9gn0=;
        b=Oa7rcj5jMNYHRrCZm8+QMBxmO22QGfzl9FXSYBF4HSZznfBLEvYZedBssOwWVyeeTAnZxK
        2ksAWOXyD0ZAzWrplnKR2Fdk8O0NfAlcuXnVLrLHBL80jiwsGgRoMUiqHrkO6gyOk0YELA
        +WjQvSifJ03gpp8Xm6cyF5tGmjUJh6o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-mQ3cnKj9OyaRCFw6YJT2uA-1; Fri, 03 Mar 2023 08:42:42 -0500
X-MC-Unique: mQ3cnKj9OyaRCFw6YJT2uA-1
Received: by mail-wm1-f69.google.com with SMTP id p22-20020a7bcc96000000b003e2036a1516so2851518wma.7
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Mar 2023 05:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRBvAso0m6Mh4AYb8jIiudho0ePNxChhIVaVb3X9gn0=;
        b=1pkd1Z6gxB7HuxcpzXOYvP4NPiDm86r4TFuoGXSuwZfItpfFUDufjmiGpNnPO07edw
         kK2eLzZrPTGukGvYXpaogBI8ezxynGFCVi1dWdjxMOpkuziRkEyU32T2rzBz5jQrcbok
         PwaBtnXN7kXZ8zhZ34FRVx/376FYg6Mk6CPlMV55Yh3PK7goy0FmB37AioBGDwZRIGv2
         i4DGV4g6zZhPJBgLg0gXcrTCQxla8Ij+a6aJObbH8937rO9BxyhjG2esZT5P0z4j65Vu
         ayMMr9umq82H2uX4hJa2/zPso1Utea2FrJoEAAeBcYnCPyC6/HvVoE+PVD5+IhM27IZH
         xrTA==
X-Gm-Message-State: AO0yUKVYclsBiHH8f0aqgmxbdiF15ZO1lfB5IdJkPyB2rfWBK8uT6Y3c
        OjkKqWYmZpAefAZFljPpKkxz2i/mdI9hMrG5VywEkmYAb+4bOD9H0xALax3c07Ye5qWzqlDcZ46
        QkbobE9Jms/1h1WIwbiLlqaXRWQDERrkn8w==
X-Received: by 2002:a05:6000:1289:b0:2c7:1524:eb07 with SMTP id f9-20020a056000128900b002c71524eb07mr1195448wrx.67.1677850961243;
        Fri, 03 Mar 2023 05:42:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/LUwHmGIAdTsbIGVjpc4uuopNpN8Lb5bV+jaI23Vz/K5QtjmEqhYCXmnTN3x4dHcJnCwSFbA==
X-Received: by 2002:a05:6000:1289:b0:2c7:1524:eb07 with SMTP id f9-20020a056000128900b002c71524eb07mr1195437wrx.67.1677850961025;
        Fri, 03 Mar 2023 05:42:41 -0800 (PST)
Received: from localhost.localdomain ([46.33.96.29])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d4d47000000b002c5706f7c6dsm2208708wru.94.2023.03.03.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:42:40 -0800 (PST)
From:   Michal Sekletar <msekleta@redhat.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, arozansk@redhat.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Sekletar <msekleta@redhat.com>
Subject: [PATCH 2/2] selftests: tty: add selftest for tty timestamp updates
Date:   Fri,  3 Mar 2023 14:36:06 +0100
Message-Id: <20230303133606.227934-2-msekleta@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303133606.227934-1-msekleta@redhat.com>
References: <20230303133606.227934-1-msekleta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Michal Sekletar <msekleta@redhat.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/tty/.gitignore        |  2 +
 tools/testing/selftests/tty/Makefile          |  5 ++
 .../testing/selftests/tty/tty_tstamp_update.c | 88 +++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/tty/.gitignore
 create mode 100644 tools/testing/selftests/tty/Makefile
 create mode 100644 tools/testing/selftests/tty/tty_tstamp_update.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 13a6837a0c6b..fc46926f505b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -84,6 +84,7 @@ TARGETS += timers
 endif
 TARGETS += tmpfs
 TARGETS += tpm2
+TARGETS += tty
 TARGETS += user
 TARGETS += vDSO
 TARGETS += mm
diff --git a/tools/testing/selftests/tty/.gitignore b/tools/testing/selftests/tty/.gitignore
new file mode 100644
index 000000000000..fe70462a4aad
--- /dev/null
+++ b/tools/testing/selftests/tty/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+tty_tstamp_update
diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftests/tty/Makefile
new file mode 100644
index 000000000000..50d7027b2ae3
--- /dev/null
+++ b/tools/testing/selftests/tty/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS = -O2 -Wall
+TEST_GEN_PROGS := tty_tstamp_update
+
+include ../lib.mk
diff --git a/tools/testing/selftests/tty/tty_tstamp_update.c b/tools/testing/selftests/tty/tty_tstamp_update.c
new file mode 100644
index 000000000000..0ee97943dccc
--- /dev/null
+++ b/tools/testing/selftests/tty/tty_tstamp_update.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <linux/limits.h>
+
+#include "../kselftest.h"
+
+#define MIN_TTY_PATH_LEN 8
+
+static bool tty_valid(char *tty)
+{
+	if (strlen(tty) < MIN_TTY_PATH_LEN)
+		return false;
+
+	if (strncmp(tty, "/dev/tty", MIN_TTY_PATH_LEN) == 0 ||
+	    strncmp(tty, "/dev/pts", MIN_TTY_PATH_LEN) == 0)
+		return true;
+
+	return false;
+}
+
+static int write_dev_tty(void)
+{
+	FILE *f;
+	int r = 0;
+
+	f = fopen("/dev/tty", "r+");
+	if (!f)
+		return -errno;
+
+	r = fprintf(f, "hello, world!\n");
+	if (r != strlen("hello, world!\n"))
+		r = -EIO;
+
+	fclose(f);
+	return r;
+}
+
+int main(int argc, char **argv)
+{
+	int r;
+	char tty[PATH_MAX] = {};
+	struct stat st1, st2;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	r = readlink("/proc/self/fd/0", tty, PATH_MAX);
+	if (r < 0)
+		ksft_exit_fail_msg("readlink on /proc/self/fd/0 failed: %m\n");
+
+	if (!tty_valid(tty))
+		ksft_exit_skip("invalid tty path '%s'\n", tty);
+
+	r = stat(tty, &st1);
+	if (r < 0)
+		ksft_exit_fail_msg("stat failed on tty path '%s': %m\n", tty);
+
+	/* We need to wait at least 8 seconds in order to observe timestamp change */
+	/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fbf47635315ab308c9b58a1ea0906e711a9228de */
+	sleep(10);
+
+	r = write_dev_tty();
+	if (r < 0)
+		ksft_exit_fail_msg("failed to write to /dev/tty: %s\n",
+				   strerror(-r));
+
+	r = stat(tty, &st2);
+	if (r < 0)
+		ksft_exit_fail_msg("stat failed on tty path '%s': %m\n", tty);
+
+	/* We wrote to the terminal so timestamps should have been updated */
+	if (st1.st_atim.tv_sec == st2.st_atim.tv_sec &&
+	    st1.st_mtim.tv_sec == st2.st_mtim.tv_sec) {
+		ksft_test_result_fail("tty timestamps not updated\n");
+		ksft_exit_fail();
+	}
+
+	ksft_test_result_pass(
+		"timestamps of terminal '%s' updated after write to /dev/tty\n", tty);
+	return EXIT_SUCCESS;
+}
-- 
2.39.2

