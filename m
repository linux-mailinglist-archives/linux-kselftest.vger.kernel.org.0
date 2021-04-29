Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C307D36F166
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 22:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhD2UwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Apr 2021 16:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhD2UwF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Apr 2021 16:52:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A31C061343
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 13:51:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a2587480000b02904e5857564e2so47274222ybn.16
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Apr 2021 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hBy97l2OeZjjc1FDpx7psPwcShHF084Bzuhbgq1Esqw=;
        b=BIJYPNQHmeMv/1hfbiD+Rv1WlEDG3I3kXvfMXNF3GV7WyIJftczSnQ+idl3er6pC5b
         v58FtVvXxSHpbxzg6t2EasdQC7+0nV24tVozL+LVXBL1yF7CeGBBs2Uj7sO8xq4IwYN/
         M6+eB+Oiybw9Hc6iPglJvasvzqyCMz/p/5Lljj70/CgoT+lmEOlBjS8jDAJV0lNacyWI
         6QJjrmBCLmpD10Z4f8szzPzYPCe9MqSneVMpNGYkyosNSvJdiXrk1Iiz5Pb7p2+odcPs
         Qv+/sRjQxRUnpFL1u/CSArveybUd092KIWfE+ePV/OCS5sQeHMl1OwOlkpSSLLxe158A
         cXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hBy97l2OeZjjc1FDpx7psPwcShHF084Bzuhbgq1Esqw=;
        b=sq31FWq+C4ZcdSHNp25CWlJ+3OVYCKJKpr7uvCKOzwWU0HdQTLIa3TfJMfECyEqvAF
         FSmDtmWPZDBxe5QU4ODLfp/89+3K4zI8pX8d+aiGTH+fFcvBmWraq75PdjU1w1yhphts
         RP0BEBTKxVisHOcx1O3UxxHiBXYTW1a5rhBjhBBeCR49SMfwFipyDGnUR/f6zcKcNaDi
         8eRKmSOKl/WHD1BQt4kAXMeyW4VORYc1SN+KJZnRi+OV8g7UkJ+WwujCZoKOo2Aztu5+
         F+UdaYjTwim5hjaDkYRFKIaNaZaHrXPhIRzKNBYIXshXlMXMFCHx2uDBQ1XY7PiwUkGi
         SqFA==
X-Gm-Message-State: AOAM531v4K64qK/C584hbtDmuZ2XF1kFYzvw5E3yZZrN72dmqYkwuh7o
        ylPl6HJlbASkfU5In7h1ibWhDGdk9uUA4+0/yqjUFw==
X-Google-Smtp-Source: ABdhPJzwU0e46V+gJsvpQiQajWvtcmUD9D9YsHQk3iiQkd72ctNuxyQyDiBCe+kdgfusEP5n3g3y3PBkZuryHrwHA0M6yQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:bab5:c64e:5a6c:36bd])
 (user=brendanhiggins job=sendgmr) by 2002:a25:2d45:: with SMTP id
 s5mr2074502ybe.519.1619729475080; Thu, 29 Apr 2021 13:51:15 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:51:06 -0700
In-Reply-To: <20210429205109.2847831-1-brendanhiggins@google.com>
Message-Id: <20210429205109.2847831-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210429205109.2847831-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [RFC v2 1/4] kunit: Add 'kunit_shutdown' option
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, sboyd@kernel.org, keescook@chromium.org,
        frowand.list@gmail.com, dlatypov@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: David Gow <davidgow@google.com>

Add a new kernel command-line option, 'kunit_shutdown', which allows the
user to specify that the kernel poweroff, halt, or reboot after
completing all KUnit tests; this is very handy for running KUnit tests
on UML or a VM so that the UML/VM process exits cleanly immediately
after running all tests without needing a special initramfs.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 lib/kunit/executor.c                | 20 ++++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  2 +-
 tools/testing/kunit/kunit_parser.py |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 15832ed446685..7db619624437c 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/reboot.h>
 #include <kunit/test.h>
 #include <linux/glob.h>
 #include <linux/moduleparam.h>
@@ -18,6 +19,9 @@ module_param(filter_glob, charp, 0);
 MODULE_PARM_DESC(filter_glob,
 		"Filter which KUnit test suites run at boot-time, e.g. list*");
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
 static struct kunit_suite * const *
 kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
 {
@@ -82,6 +86,20 @@ static struct suite_set kunit_filter_suites(void)
 	return filtered;
 }
 
+static void kunit_handle_shutdown(void)
+{
+	if (!kunit_shutdown)
+		return;
+
+	if (!strcmp(kunit_shutdown, "poweroff"))
+		kernel_power_off();
+	else if (!strcmp(kunit_shutdown, "halt"))
+		kernel_halt();
+	else if (!strcmp(kunit_shutdown, "reboot"))
+		kernel_restart(NULL);
+
+}
+
 static void kunit_print_tap_header(struct suite_set *suite_set)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
@@ -112,6 +130,8 @@ int kunit_run_all_tests(void)
 		kfree(suite_set.start);
 	}
 
+	kunit_handle_shutdown();
+
 	return 0;
 }
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index f309a33256cd3..7d5b77967d48f 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -206,7 +206,7 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
 		if not args:
 			args = []
-		args.extend(['mem=1G', 'console=tty'])
+		args.extend(['mem=1G', 'console=tty','kunit_shutdown=halt'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
 		self._ops.linux_bin(args, timeout, build_dir)
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index e8bcc139702e2..8d8d4d70b39dd 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -49,7 +49,7 @@ class TestStatus(Enum):
 
 kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
-			  'Kernel panic - not syncing: VFS:)')
+			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def isolate_kunit_output(kernel_output) -> Iterator[str]:
 	started = False
-- 
2.31.1.498.g6c1eba8ee3d-goog

