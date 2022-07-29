Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3B584B85
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 08:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiG2GPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 02:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiG2GPU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 02:15:20 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FBA260C
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 23:15:07 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id i8-20020a056e020d8800b002d931252904so2470243ilj.23
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jul 2022 23:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hjVlZubyermfSkZizgaaxGB+KlUF18YguF7xhPiT/Ik=;
        b=mpb2InHEhH2Sm2XbOc+6nFidWtRjX48upV3ID2C0mZq33mBbL2LkFJDrwU0RgRfcfp
         CGD/5pjCizX/0U2QYQDrmNV6cxJPPVVrXc6JoqnuC3S6TlIgPIOgiv4JMFfw5iX1yQwZ
         uVQOwuh108d/qhSCddg4TYbrkdw8qB1afCSPXDA3StlvbI+X88SxRkRzNULWeei6GS+l
         LqAP3YzqRqGidDfaT7SlBaH/HCFCczYSPbdiaDKp23k/W0m+RwmMD1ZTNx6y51UlCnJG
         CFEn7BKNrVf2EHB0NrXGZ8i7oz8R8rUar3ilz/J444yv+8rBH8lb34dAI+B8yLNbkzI5
         CP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hjVlZubyermfSkZizgaaxGB+KlUF18YguF7xhPiT/Ik=;
        b=I3Ok/ASh90XcrwGyQ/V+5Hsj9/trvHCoodtgMyhTa66c894KNtvCELo4SvR18sw1Gm
         oVr5oQNSr7M1ul3uMNs9akv5daUSBODW2kbsv+5/liyVVK7D73ZTJWEaxIu6mmC+f+9k
         3pRvixJ7LSSSohqZjakQPL5vzgxaz8Lb1DUIolHsn0AyRD/rE77IYEW9GQJrdZsS57o2
         13LCVpYLGYXPo2eorGx+0P/IsPlD1V1gKgvHDjxlYbFN0lkEBIjHxBTeBWM4z4UuTz6D
         x8FmnM7aXxWH6DhjGzOYqyZ+CpUBWEaIjgPBm2xYpGpnTqMB9qvt92uTujRS+N5C/4O2
         M+uQ==
X-Gm-Message-State: AJIora9O34ZB8pe78ths0m4jCv4OoKkumL4ouxiEczdUnVsdA+mZjTFF
        Oh0hoAyynbxfkosJ0Y+SntHNsbi5CIs=
X-Google-Smtp-Source: AGRyM1sNSfg4OzUat+/XKg7JS3pq2fMNP0DXAZQDKp78R0vaRsinGs45PmzZCFSPn5h/qfz1QMFtWKG16Bw=
X-Received: from jeffxuk510a.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:65b])
 (user=jeffxu job=sendgmr) by 2002:a05:6602:2e8d:b0:67c:c24c:fec4 with SMTP id
 m13-20020a0566022e8d00b0067cc24cfec4mr683187iow.134.1659075307329; Thu, 28
 Jul 2022 23:15:07 -0700 (PDT)
Date:   Fri, 29 Jul 2022 06:15:03 +0000
In-Reply-To: <6f71a4f3-8f8e-926b-883c-1df630cfc1a0@linuxfoundation.org>
Message-Id: <20220729061504.744140-1-jeffxu@google.com>
Mime-Version: 1.0
References: <6f71a4f3-8f8e-926b-883c-1df630cfc1a0@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 3/4] selftests/memfd: add tests for F_SEAL_EXEC
From:   Jeff Xu <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Daniel Verkamp <dverkamp@chromium.org>

Basic tests to ensure that user/group/other execute bits cannot be
changed after applying F_SEAL_EXEC to a memfd.

Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
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
2.37.1.455.g008518b4e5-goog

