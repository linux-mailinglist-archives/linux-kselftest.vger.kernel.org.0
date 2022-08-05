Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5716158B26D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Aug 2022 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbiHEWWB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbiHEWVy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 18:21:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8722E1B786
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 15:21:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c9-20020a5b0989000000b0067b7758254cso3093171ybq.14
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8AvsEq4SstPGeW7QF9LLj/CM82M+f11wZB7WzW/AmUg=;
        b=mMb+PeyF4VQkekJjv1Q+X2LF/3kKZ0J2TCbHkTTU/n5K6SxiBoS32IjQbd7vR1JBuY
         KK5mNxKRvJhbNpXkBgLNsjozyQGZZykaqk9VJaar90tvBTvpEwaJWc/oPcu8lkQsledi
         CfI3NYgAM5qa/N6/BrSW4XoQzQJwhjQqwzUAlLdH+uaizI1Yde5jEVhQMh4/W4ts0DRC
         nTZKmQYKwiV5MoJ69N1hpt8b+LYHYMNfd2Tl2jK9YjWAMNbaO4NhjiFuji/3ZwNy8TCO
         iFrzR+jYcS+CMSO5r4DA1Bvpyvedk6yb/v6haitjoDbX9YF4zss9+D/gTqEGtTKwy5vd
         1RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8AvsEq4SstPGeW7QF9LLj/CM82M+f11wZB7WzW/AmUg=;
        b=kILoaI1Z7zLNFsCSg9yiNZonnymwB9VHyVZQXVUcp5daZKBcr3xy6hWNZW6FqUj6sh
         gWYeKSnoh7Wy6tny8btkMGEQdZIUoCCd/9AvoatB/k9zK9HTbdFehOmfuPI7aF4uyVe+
         Jw8SpJyTjM/8y69rHu5fre7CWwiKgQzcmECjo58TS9wwfU6Lvv15yC+5VVX/Eay1xkc1
         PPx3r/JijJYIzRzd+489X7yUCV/qRBIMER0TyXBN85WSo9gc5vnAZzrKCzifeR1BdljA
         M0K+HmJn/K43EeQGGVM8y6Q6jyftJzqsTBSQuqb2K4SMsZud+SOCsYD0VGdrDpsXICVC
         a0rQ==
X-Gm-Message-State: ACgBeo3+bBJIWmzszOs/Sh9/N5kPQ+LyFTaEq3al8nFwglOtb9YabFIN
        fbhvfy7NGxTWlDkbrRfI0CGzbbwbk/U=
X-Google-Smtp-Source: AA6agR7MhJWGNuJekXT5wplu+5rroD6wgWIQKDgy1c8mBYuUwU+BizAsUUXtqWQTJ2dbcZa+Q1JevcSWC98=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a81:7b85:0:b0:321:119:5a0d with SMTP id
 w127-20020a817b85000000b0032101195a0dmr8242026ywc.55.1659738112795; Fri, 05
 Aug 2022 15:21:52 -0700 (PDT)
Date:   Fri,  5 Aug 2022 22:21:24 +0000
In-Reply-To: <20220805222126.142525-1-jeffxu@google.com>
Message-Id: <20220805222126.142525-4-jeffxu@google.com>
Mime-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 3/5] selftests/memfd: add tests for F_SEAL_EXEC
From:   <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Daniel Verkamp <dverkamp@chromium.org>

Basic tests to ensure that user/group/other execute bits cannot be
changed after applying F_SEAL_EXEC to a memfd.

Co-developed-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 129 ++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..1d7e7b36bbdd 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -28,12 +28,44 @@
 #define MFD_DEF_SIZE 8192
 #define STACK_SIZE 65536
 
+#ifndef F_SEAL_EXEC
+#define F_SEAL_EXEC	0x0020
+#endif
+
+#ifndef MAX_PATH
+#define MAX_PATH 256
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
 
+static ssize_t fd2name(int fd, char *buf, size_t bufsize)
+{
+	char buf1[MAX_PATH];
+	int size;
+	ssize_t nbytes;
+
+	size = snprintf(buf1, MAX_PATH, "/proc/self/fd/%d", fd);
+	if (size < 0) {
+		printf("snprintf(%d) failed on %m\n", fd);
+		abort();
+	}
+
+	/*
+	 * reserver one byte for string termination.
+	 */
+	nbytes = readlink(buf1, buf, bufsize-1);
+	if (nbytes == -1) {
+		printf("readlink(%s) failed %m\n", buf1);
+		abort();
+	}
+	buf[nbytes] = '\0';
+	return nbytes;
+}
+
 static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 {
 	int r, fd;
@@ -98,11 +130,14 @@ static unsigned int mfd_assert_get_seals(int fd)
 
 static void mfd_assert_has_seals(int fd, unsigned int seals)
 {
+	char buf[MAX_PATH];
+	int nbytes;
 	unsigned int s;
+	fd2name(fd, buf, MAX_PATH);
 
 	s = mfd_assert_get_seals(fd);
 	if (s != seals) {
-		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
+		printf("%u != %u = GET_SEALS(%s)\n", seals, s, buf);
 		abort();
 	}
 }
@@ -594,6 +629,64 @@ static void mfd_fail_grow_write(int fd)
 	}
 }
 
+static void mfd_assert_mode(int fd, int mode)
+{
+	struct stat st;
+	char buf[MAX_PATH];
+	int nbytes;
+
+	fd2name(fd, buf, MAX_PATH);
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%s) failed: %m\n", buf);
+		abort();
+	}
+
+	if ((st.st_mode & 07777) != mode) {
+		printf("fstat(%s) wrong file mode 0%04o, but expected 0%04o\n",
+		       buf, (int)st.st_mode & 07777, mode);
+		abort();
+	}
+}
+
+static void mfd_assert_chmod(int fd, int mode)
+{
+	char buf[MAX_PATH];
+	int nbytes;
+
+	fd2name(fd, buf, MAX_PATH);
+
+	if (fchmod(fd, mode) < 0) {
+		printf("fchmod(%s, 0%04o) failed: %m\n", buf, mode);
+		abort();
+	}
+
+	mfd_assert_mode(fd, mode);
+}
+
+static void mfd_fail_chmod(int fd, int mode)
+{
+	struct stat st;
+	char buf[MAX_PATH];
+	int nbytes;
+
+	fd2name(fd, buf, MAX_PATH);
+
+	if (fstat(fd, &st) < 0) {
+		printf("fstat(%s) failed: %m\n", buf);
+		abort();
+	}
+
+	if (fchmod(fd, mode) == 0) {
+		printf("fchmod(%s, 0%04o) didn't fail as expected\n",
+		       buf, mode);
+		abort();
+	}
+
+	/* verify that file mode bits did not change */
+	mfd_assert_mode(fd, st.st_mode & 07777);
+}
+
 static int idle_thread_fn(void *arg)
 {
 	sigset_t set;
@@ -880,6 +973,39 @@ static void test_seal_resize(void)
 	close(fd);
 }
 
+/*
+ * Test SEAL_EXEC
+ * Test that chmod() cannot change x bits after sealing
+ */
+static void test_seal_exec(void)
+{
+	int fd;
+
+	printf("%s SEAL-EXEC\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_exec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_mode(fd, 0777);
+
+	mfd_assert_chmod(fd, 0644);
+
+	mfd_assert_has_seals(fd, 0);
+	mfd_assert_add_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+
+	mfd_assert_chmod(fd, 0600);
+	mfd_fail_chmod(fd, 0777);
+	mfd_fail_chmod(fd, 0670);
+	mfd_fail_chmod(fd, 0605);
+	mfd_fail_chmod(fd, 0700);
+	mfd_fail_chmod(fd, 0100);
+	mfd_assert_chmod(fd, 0666);
+
+	close(fd);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1059,6 +1185,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_exec();
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
-- 
2.37.1.559.g78731f0fdb-goog

