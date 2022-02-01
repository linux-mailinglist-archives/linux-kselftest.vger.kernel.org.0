Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB214A548F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 02:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiBABQl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 20:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiBABQk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 20:16:40 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC4C06173B
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 17:16:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id s16so13765180pgs.13
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 17:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvxcvzXH4VJ6E7zlHksxhLJ0Jar5RcY37sbz8vcUnwA=;
        b=n4Xh8YTEBFhu25veL76yREgUBbEjEjW92HU+rostZl5q2oTixGNege0DDfUmWh5Bul
         GSzaKNQNJMVDUaBazlPuwYdJZOsQ0OMS+GQuZ4FnrivwTO4qZ7J/MAWDUNoSQ4712tQn
         5aIboyezBxyMpGb/KTKLzCiHWfGzCd7/RHNow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvxcvzXH4VJ6E7zlHksxhLJ0Jar5RcY37sbz8vcUnwA=;
        b=nISevodoy3melxfgXtdEowhPuomERfYDrLLtHJ9gt92dPGOuw0w1zz+mfMji0LWHTp
         iWVeybeDPpZJEk3lROoaHOutDHQdcCD0Go4ipkJu0J33lGl2rk6umDu56wv0O4MalxKj
         KnDvZeB8F6xbdzcKOQh5LWolRAn73+naBIAY+RYELzSdGlmD3B88XkuDOeonSxSY+5mp
         mAVKRJvdeZeUf7qu/TUPR4LSSseCtQYsgsInOt5Rwvq/2LWfPAwBOCL2uqGMF/jtP/Lz
         1xqDw6pP40R5p8K7305XWtu+oqp/sU8s4wOdeDD9cyOmQSzkEL1twY3Aa68tO8kS03gk
         t/KA==
X-Gm-Message-State: AOAM5327ekuW9WmU7+X+ErdHsuHFj+dIqQJcdyh8ImpWlXNC0N48HAA8
        MX4WnEmuGcmHI5ggavyf9CP8Gw==
X-Google-Smtp-Source: ABdhPJygvz6vAby26Gb6IKXH4kaHD1Vneb7nQ+T6LqCv4x/uIdljdV6rZICzA999yVljOt7DA57yVQ==
X-Received: by 2002:aa7:9682:: with SMTP id f2mr23009248pfk.56.1643678200095;
        Mon, 31 Jan 2022 17:16:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm29967814pga.57.2022.01.31.17.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 17:16:39 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kselftest@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] selftests/exec: Test for empty string on NULL argv
Date:   Mon, 31 Jan 2022 17:16:37 -0800
Message-Id: <20220201011637.2457646-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; h=from:subject; bh=KVYgP4gBGoag0XXkWLoVuF2irAM9dKCsptscwOX961o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh+In1d7YWRksOQF3vTA7Ad/dWv3vnj+wq4c1QUv75 5/y9xyWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfiJ9QAKCRCJcvTf3G3AJmJnD/ wNNO8OqXL3vCcU15W01vFWGk7q8FIyycXT5RgTNAe//OMfilFwNRZrNrPk9oFOiNSgYOAKJ6ozi9kY GoeTNflQ3j6z03RmGX2kD3YZ7smAV/g5F6oL0+O7WKUMc1Qvh+Li6/8Dm+jZGi8EiL+qO9yWv6FU59 jEz0tPWDRtn+NLW0Yphtb9uWaY//uvnsBgw6MRmqRUVVZzDUyC4aB1KdjNF58CyCnVkpy/O9L/xhOl tlaNH7otK628H8Ed1jkhrJWiauj/vWIuxKUgdKFlPSIsZA/J/LoJ2rDMrMKQT6oDIlhrakwd0nfUt0 qSfH3XLWxI5Tv4SS2+6J1pLTSXUUrvYxLxcPpok48Xzn4gjVuEcvXR1G4PCh47oYVQwW3PqQ9I6VEr bL1Ld0cwSfKH0P4a5zpGpUp5I4OXmalSl0Lt/9PkoYi+wbHXC5a8NtnCnd5lawjxRDGv+WQF4P6F2C Yq5qFB6AykeZjD308o/V0ZfuwmaBknBpI/STtH0bHV0Q5rwJW8+DCMWTokojs2Nz/10dyCKAyOBO7V kej3JLmZTsoIg9ae80Qx5+SJjka3kmOGrLzoGPUlOnOK26JfJ1/wQExTmbiY+lAsNkrTGUDgDrg9q1 pHxqok5I3I5NWJTTpULhOke2pIC9DaH9KEUnohglrdlhgNRnQC6EnihEVS8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test for the NULL argv argument producing a single empty string on exec.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is testing for this patch:
https://lore.kernel.org/linux-hardening/20220201000947.2453721-1-keescook@chromium.org/
---
 tools/testing/selftests/exec/Makefile    |  1 +
 tools/testing/selftests/exec/null-argv.c | 78 ++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/exec/null-argv.c

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index dd61118df66e..4832cd8f4f9c 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -10,6 +10,7 @@ TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 TEST_FILES := Makefile
 
 TEST_GEN_PROGS += recursion-depth
+TEST_GEN_PROGS += null-argv
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
diff --git a/tools/testing/selftests/exec/null-argv.c b/tools/testing/selftests/exec/null-argv.c
new file mode 100644
index 000000000000..c19726e710d1
--- /dev/null
+++ b/tools/testing/selftests/exec/null-argv.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Test that empty argvs are swapped out for a single empty string. */
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+
+#define FORK(exec)				\
+do {						\
+	pid = fork();				\
+	if (pid == 0) {				\
+		/* Child */			\
+		exec; /* Some kind of exec */	\
+		perror("# " #exec);		\
+		return 1;			\
+	}					\
+	check_result(pid, #exec);		\
+} while (0)
+
+void check_result(pid_t pid, const char *msg)
+{
+	int wstatus;
+
+	if (pid == (pid_t)-1) {
+		perror("# fork");
+		ksft_test_result_fail("fork failed: %s\n", msg);
+		return;
+	}
+	if (waitpid(pid, &wstatus, 0) < 0) {
+		perror("# waitpid");
+		ksft_test_result_fail("waitpid failed: %s\n", msg);
+		return;
+	}
+	if (!WIFEXITED(wstatus)) {
+		ksft_test_result_fail("child did not exit: %s\n", msg);
+		return;
+	}
+	if (WEXITSTATUS(wstatus) != 0) {
+		ksft_test_result_fail("non-zero exit: %s\n", msg);
+		return;
+	}
+	ksft_test_result_pass("%s\n", msg);
+}
+
+int main(int argc, char *argv[], char *envp[])
+{
+	pid_t pid;
+	static char * const args[] = { NULL };
+	static char * const str[] = { "", NULL };
+
+	/* argc counting checks */
+	if (argc < 1) {
+		fprintf(stderr, "# FAIL: saw argc == 0 (old kernel?)\n");
+		return 1;
+	}
+	if (argc != 1) {
+		fprintf(stderr, "# FAIL: unknown argc (%d)\n", argc);
+		return 1;
+	}
+	if (argv[0][0] == '\0') {
+		/* Good, we found a NULL terminated string at argv[0]! */
+		return 0;
+	}
+
+	/* Test runner. */
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	FORK(execve(argv[0], str, NULL));
+	FORK(execve(argv[0], NULL, NULL));
+	FORK(execve(argv[0], NULL, envp));
+	FORK(execve(argv[0], args, NULL));
+	FORK(execve(argv[0], args, envp));
+
+	ksft_exit(ksft_cnt.ksft_pass == ksft_plan);
+}
-- 
2.30.2

