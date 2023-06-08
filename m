Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEA2727C95
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjFHKRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjFHKRo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 06:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019F2D48
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Jun 2023 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686219413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkSBFkEaQ4x9rH0bVltqMnMT5xLInhrDlt72mpqM2uM=;
        b=I9eLixnDdWG76UH1zGyFZgDRWIwtkrI6lLfsqGUShGctJlOLo9cKc219XQZauZV0AEvcF8
        e9LUyjaFjJE/JIMjbyiOrkakkKTkC2axuS1m4jOBHkEYIWzhXWLpPi/AbpPR4pJ/vvBsLL
        Tj+UBkGis5TPZn+nltfEuaLHVVs1tf0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-2rYsaqU-PwOT2CZ-EnfP9g-1; Thu, 08 Jun 2023 06:16:52 -0400
X-MC-Unique: 2rYsaqU-PwOT2CZ-EnfP9g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-97463348446so66053866b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jun 2023 03:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219411; x=1688811411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkSBFkEaQ4x9rH0bVltqMnMT5xLInhrDlt72mpqM2uM=;
        b=gTER7TIiVDVZ0ghjIOOAe25oxDroL6NZ6V+1EK2JPThpD0uP/0JlGTHykn127K5R5W
         Nv6LrpmRHATu3Cxjq2kGB78SML5ON2CecNbZ+bQVe0QZ50qfaD2FMC+IA3sk+1pDirPc
         P23tvogwLg9j8EBzdjiWvmhEkL+GvWviPdf0eaiKoVAADnV1V8Wwel9ZdvTcZTV3BWXb
         zjxo4QpEz67ZPFp+SNmmG/KPEkCHoD0Bms16f8ApHbCHmXHD4oVj65eTgKJOafHgYME2
         sfs8owPod64tkvI6iT2Oo/N2MaWiKPT40M2xH32lNjumtuH10xBUzH04HRrz6oU9wEfh
         3wAw==
X-Gm-Message-State: AC+VfDx8YM9XGHvW8/ZjpROBnECcHTiuo5hhEAxit4OTAxOeFxgXNPBv
        GX2IOkv6SKQ5XUIoDPt/QIOfy5UL7INfApesSmISPPtGIwkdPnxxDg0JsgFCPrHVMXr0hse0huM
        xAqz8GZd1SuFxiVtE9K4Po7PEkqLw
X-Received: by 2002:a17:907:72cc:b0:973:9494:4e5c with SMTP id du12-20020a17090772cc00b0097394944e5cmr7850378ejc.65.1686219411437;
        Thu, 08 Jun 2023 03:16:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7x6MAb8Al9ZO5Rr9aBjQBOdF0IBf+DSr4m+9KOnoWcs8EgLyJWZmfwY8JRVpJ0lgZMIUV87A==
X-Received: by 2002:a17:907:72cc:b0:973:9494:4e5c with SMTP id du12-20020a17090772cc00b0097394944e5cmr7850367ejc.65.1686219411248;
        Thu, 08 Jun 2023 03:16:51 -0700 (PDT)
Received: from localhost.localdomain ([46.33.96.32])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b00977da0f14ffsm506558ejb.171.2023.06.08.03.16.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Jun 2023 03:16:50 -0700 (PDT)
From:   Michal Sekletar <msekleta@redhat.com>
To:     jirislaby@kernel.org
Cc:     arozansk@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        msekleta@redhat.com, shuah@kernel.org
Subject: [PATCH v2 2/2] selftests: tty: add selftest for tty timestamp updates
Date:   Thu,  8 Jun 2023 12:16:16 +0200
Message-Id: <20230608101616.44152-2-msekleta@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608101616.44152-1-msekleta@redhat.com>
References: <c91c458e-58d0-f13a-9adb-a48a19f82107@kernel.org>
 <20230608101616.44152-1-msekleta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 90a62cf75..862f5f9a7 100644
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
index 000000000..fe70462a4
--- /dev/null
+++ b/tools/testing/selftests/tty/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+tty_tstamp_update
diff --git a/tools/testing/selftests/tty/Makefile b/tools/testing/selftests/tty/Makefile
new file mode 100644
index 000000000..50d7027b2
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
index 000000000..0ee97943d
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
2.39.1

