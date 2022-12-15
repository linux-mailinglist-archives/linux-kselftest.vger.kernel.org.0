Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A6F64D46B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 01:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiLOAOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 19:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLOANm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:42 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1D532EC
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:16 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s7so5138626plk.5
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfROb3ZkcZ7Ac7CKaQoVSCHLc1zwDwCheELrvNAzva4=;
        b=EEBsbANJ5rVxA3zNQWjC0OwYANmCqoR2KQqQ6RbXOFYUIhlWxdJeMRwj9ifXy3gRpA
         bV3fXAoCNZ0OVZV99aDQcbltEdQYi4nYBWh5mT8wpvJr5QdHxBaF4+Od8j4v1tCYrKBB
         xIK3hSfSZ7PNnJc9ZYeZQ6xIHca1IYtzMhWgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfROb3ZkcZ7Ac7CKaQoVSCHLc1zwDwCheELrvNAzva4=;
        b=0BI/bmSJfMfKfHeROj2qNgbTWlu0EYNGYzFMA8sChHJH8GZRuzRqZq/I/5JPaitFMQ
         nLMKHsnYHWE4u5+x6gM68oWeOswsXtWfhdmrBOzcsg+oFn9nq9CpRHXKYvJ1/dx4J1eT
         eKFDrVV3e+8ePKQir+uItCflwgUW2IQwt9T5siFCOQZ59kT94tQ9ljOVw+7GuhqxrBOz
         EsQ1a2Ztv0ZZVHKdXijKOA0DuMVsg0+gpsLMQWOPBATDKslFTYLuWvwu37upS0IOAohX
         RUG1Vns31yIiKf9mDPbbl9+MmUsDmJry04XGr10DtagCUWAU5FfW9wGfeGlIn8K07+hs
         zW6Q==
X-Gm-Message-State: ANoB5pmhwjLn6IrV6U2B0Lx8P6+mDjGaEB3H5msI3P68nYvw93mX593S
        UbEiD1fK9d2u/COpAcj99ESTkg==
X-Google-Smtp-Source: AA0mqf5FkGT3aKj+Iri+fkdEapJVxPOjm37Mu3bRXj+pTnXCNATSsFbSxU7zW7UjlccSkGKowjUlRg==
X-Received: by 2002:a17:90a:9704:b0:21d:4b50:23b1 with SMTP id x4-20020a17090a970400b0021d4b5023b1mr29685502pjo.5.1671063135792;
        Wed, 14 Dec 2022 16:12:15 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:15 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 2/5] selftests/memfd: add tests for F_SEAL_EXEC
Date:   Thu, 15 Dec 2022 00:12:02 +0000
Message-Id: <20221215001205.51969-3-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221215001205.51969-1-jeffxu@google.com>
References: <20221215001205.51969-1-jeffxu@google.com>
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
Co-developed-by: Jeff Xu <jeffxu@google.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 123 ++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..f18a15a1f275 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -28,12 +28,38 @@
 #define MFD_DEF_SIZE 8192
 #define STACK_SIZE 65536
 
+#define F_SEAL_EXEC	0x0020
+
 /*
  * Default is not to test hugetlbfs
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
 
+static ssize_t fd2name(int fd, char *buf, size_t bufsize)
+{
+	char buf1[PATH_MAX];
+	int size;
+	ssize_t nbytes;
+
+	size = snprintf(buf1, PATH_MAX, "/proc/self/fd/%d", fd);
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
@@ -98,11 +124,14 @@ static unsigned int mfd_assert_get_seals(int fd)
 
 static void mfd_assert_has_seals(int fd, unsigned int seals)
 {
+	char buf[PATH_MAX];
+	int nbytes;
 	unsigned int s;
+	fd2name(fd, buf, PATH_MAX);
 
 	s = mfd_assert_get_seals(fd);
 	if (s != seals) {
-		printf("%u != %u = GET_SEALS(%d)\n", seals, s, fd);
+		printf("%u != %u = GET_SEALS(%s)\n", seals, s, buf);
 		abort();
 	}
 }
@@ -594,6 +623,64 @@ static void mfd_fail_grow_write(int fd)
 	}
 }
 
+static void mfd_assert_mode(int fd, int mode)
+{
+	struct stat st;
+	char buf[PATH_MAX];
+	int nbytes;
+
+	fd2name(fd, buf, PATH_MAX);
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
+	char buf[PATH_MAX];
+	int nbytes;
+
+	fd2name(fd, buf, PATH_MAX);
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
+	char buf[PATH_MAX];
+	int nbytes;
+
+	fd2name(fd, buf, PATH_MAX);
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
@@ -880,6 +967,39 @@ static void test_seal_resize(void)
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
@@ -1059,6 +1179,7 @@ int main(int argc, char **argv)
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
+	test_seal_exec();
 
 	test_share_dup("SHARE-DUP", "");
 	test_share_mmap("SHARE-MMAP", "");
-- 
2.39.0.rc1.256.g54fd8350bd-goog

