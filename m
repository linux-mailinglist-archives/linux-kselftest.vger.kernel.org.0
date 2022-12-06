Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922DE644791
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 16:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiLFPHf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 10:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiLFPGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9082C2A706
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Dec 2022 07:02:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w23so14154276ply.12
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Dec 2022 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmJ6vAUUVWR2mQbJ18nVP5DOm/6S97wQS9z+LXJq08M=;
        b=mBzEgGghhFXhuTglJ/L1+wl3Zqb+kJf1g0t7Wmcd1QW9nQokkOZUett2xiWp7tYEs4
         f6/NFng9UDtQ/SBc64ze+Rxg4tcA0Sk3S/ZX10DCX9Rocpit2YogmnVRjhBESgNO3DPf
         3dzmfanK2mMJpatcmm58Ov+Cy7pN5VT3QY5Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmJ6vAUUVWR2mQbJ18nVP5DOm/6S97wQS9z+LXJq08M=;
        b=irGfJaVHJIrLCfGQOBJKpdFUg3gX1L9jm5lNKH6EcTtDIOIGm+8QF3lSEdsgM1IdLU
         cVMlhQm2a6boaaUwingRGY5sCGczz0XV2LZ3b9Pw5uhWHl2unyjUuoPIaHddP5nF9xSu
         fFLj8mk7pxz2aAYq8EAGXbPd758OG6bnUGMG3eWsrVyGgO/9CER75LEynzH7mzUO38ec
         e1Z35qDN5l3Qosw3ChAygImn7qAtRpX4uluCJuLqaYp1aowalPAg9jApB14tDDNVVid/
         y7uoxnxvsw4f8JyWzsMOhNL6wZgrtzIEeBbmvgUI5qiQG9ZyfdLCElWgJdk3/bI5IlSJ
         bjQw==
X-Gm-Message-State: ANoB5pmtgYMDHe36GxvQrAp+YQ/au/j5S0rOtCM93HLJuFdmTguW5tWE
        IlCD7pZRxSf/MCJY2fl1cxu4lw==
X-Google-Smtp-Source: AA0mqf6Bb9v1RHfZ8B/GeWQjsIDk4UVvErq7q40bdVEdC066ZHoBix2x+NZtAHPNc+67pV5HDx2yxw==
X-Received: by 2002:a17:903:28d:b0:189:b74e:cd07 with SMTP id j13-20020a170903028d00b00189b74ecd07mr23520438plr.169.1670338972076;
        Tue, 06 Dec 2022 07:02:52 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 62-20020a621441000000b00575bab45644sm3343019pfu.61.2022.12.06.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:02:51 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v4 2/6] selftests/memfd: add tests for F_SEAL_EXEC
Date:   Tue,  6 Dec 2022 15:02:29 +0000
Message-Id: <20221206150233.1963717-3-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206150233.1963717-1-jeffxu@google.com>
References: <20221206150233.1963717-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Daniel Verkamp <dverkamp@chromium.org>

Basic tests to ensure that user/group/other execute bits cannot be
changed after applying F_SEAL_EXEC to a memfd.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
Co-developed-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
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
2.39.0.rc0.267.gcb52ba06e7-goog

