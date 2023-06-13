Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4472E9BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjFMRZz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbjFMRZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 13:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE21FC6
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686676953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sibWrZTthPa1bJP5sLmxvxVXAGcmZF28m2PyeMA6jMI=;
        b=KR1c+20pAC+2PBmK+H0YXNH9UD7kKLjokdIO0s6rCcA6gNRvxA3OHu2R989PKD2LruCyVy
        ckM9S5jBkUqelzPkUP2JckPwx8GpAngBRk10dt3tT3PX9aEUGRLg0OiG6EYau79NSak9yQ
        9U5XvA+2sHWuUc0e9TnnzFiSoY19CQ4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-Mj2q49PRNSKIFmQOc8Mh6A-1; Tue, 13 Jun 2023 13:22:31 -0400
X-MC-Unique: Mj2q49PRNSKIFmQOc8Mh6A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ec790b902bso771173e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 10:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686676949; x=1689268949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sibWrZTthPa1bJP5sLmxvxVXAGcmZF28m2PyeMA6jMI=;
        b=XpBJqrGB/Uh5Hpsf2Y6KCDhRhO3m0Om3Hp9aQtb4YH10A8iDlADRUZ5zcJyPvFuR/k
         QytPm0rakID6OKjJp/ei2chRJgEYxd5pXFOsoGOF7cDxisDQHSRb5Ooe60TJk3W99/Zh
         bLnqaAxOx/vm7NjHWLPcQcxilJfBkW/KZEa4+OgH4Tsftu/dgJBWMgyUJotS7z3QH8mO
         yqiDMTCu6kfjV7lhn6awUT9DcZQvCI9xxDxryFp0iybhyOgYV+63ZD+/lmC2gJWYDUXd
         88W3YnBX4pMqUq+x/HBtwP0cOcr8vhDF6lazM6PQnAVf8V4pRhPqjRsp4oAngjjG53MO
         6uuQ==
X-Gm-Message-State: AC+VfDzk15o9rygFlv+m1wQ4e6mTd9vLvg/n70BjCZoHKrFKjHOmS3UX
        2cHSSXTcmQKUD/j8wbofyqaelwFhINF3KD5k652ZQNZC4Sk7GNh4UMxCtWuBw5nVDUtiG/e69gG
        yWFE+WzJI8Nld2IPom50bNc2IZxSR
X-Received: by 2002:a2e:3602:0:b0:2b1:ec1a:88bc with SMTP id d2-20020a2e3602000000b002b1ec1a88bcmr5584358lja.43.1686676948683;
        Tue, 13 Jun 2023 10:22:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4diH5HAIVXJVx0kiLZAH9mvuOYHkDg0sAOhTLmoatgX3zOqlxnpIQyTeT7f6Z9ryPifSG4VA==
X-Received: by 2002:a2e:3602:0:b0:2b1:ec1a:88bc with SMTP id d2-20020a2e3602000000b002b1ec1a88bcmr5584334lja.43.1686676948123;
        Tue, 13 Jun 2023 10:22:28 -0700 (PDT)
Received: from localhost.localdomain ([46.33.96.32])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7d1d0000000b0050bc4600d38sm6697705edp.79.2023.06.13.10.22.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jun 2023 10:22:27 -0700 (PDT)
From:   Michal Sekletar <msekleta@redhat.com>
To:     jirislaby@kernel.org
Cc:     arozansk@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        msekleta@redhat.com, shuah@kernel.org
Subject: [PATCH v3 2/2] selftests: tty: add selftest for tty timestamp updates
Date:   Tue, 13 Jun 2023 19:21:08 +0200
Message-Id: <20230613172107.78138-2-msekleta@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230613172107.78138-1-msekleta@redhat.com>
References: <2023061359-document-armband-d67d@gregkh>
 <20230613172107.78138-1-msekleta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new test case which checks that timestamp updates on actual terminal
character device (e.g. /dev/pts/0) happen even if the terminal is
accessed via magic /dev/tty file.

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
index 90a62cf75008..862f5f9a76a0 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -86,6 +86,7 @@ TARGETS += timers
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
2.40.0

