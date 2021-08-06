Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41423E1FE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbhHFARu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 20:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242720AbhHFARq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 20:17:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01F0261165;
        Fri,  6 Aug 2021 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209051;
        bh=pBCuRbKWqZ8VXzwKr9l8E31otOpcFW6kulIyrKJFcrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUehiHdmaPA4C/NIvnesCu3Gp1aHv1JldJmON5ZbydPiryo2C0/M4F9mXoZ3gEo6s
         cAnvPkoulXUt9/KztN3VtMTPQuiSfcUaljmN+fldTXWjZQxAIvHYy0/EAwodIB+ohR
         568lNt2P2jEaLHttaQTLAniDS3vdCnJ23XCqLwItr7jQI0M1fQjfJ/64HP6KQojTPQ
         0fxpoZZ9c+dvPukzXjpZAB52Pq65YC21VZydGYOdmIvXQK/KObB3XsXkELCyVEk4TY
         QZvAa8ApLED7U8ZK90plKM4F9Q8U3+6dOAAgV06f5teBRFisUhW8JXjBIGRAdlgKvA
         IyF1ONYzhfyKQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed
Date:   Fri,  6 Aug 2021 03:17:04 +0300
Message-Id: <20210806001704.667889-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806001704.667889-1-jarkko@kernel.org>
References: <20210806001704.667889-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a variation of the unclobbered_vdso test.

In the new test, create a heap for the test enclave, which has the same
size as all available Enclave Page Cache (EPC) pages in the system. This
will guarantee that all test_encl.elf pages *and* SGX Enclave Control
Structure (SECS) have been swapped out by the page reclaimer during the
load time..

This test will trigger both the page reclaimer and the page fault handler.
The page reclaimer triggered, while the heap is being created during the
load time. The page fault handler is triggered for all the required pages,
while the test case is executing.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 62 ++++++++++++++++++++++++++++++
 tools/testing/selftests/sgx/main.h |  1 +
 2 files changed, 63 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f219768b4e9a..3be34c3db74a 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -246,6 +246,68 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EQ(self->run.user_data, 0);
 }
 
+static bool sysfs_get_ulong(const char *path, unsigned long *value)
+{
+	struct stat sbuf;
+	char buf[128];
+	ssize_t ret;
+	int fd;
+
+	ret = stat(path, &sbuf);
+	if (ret)
+		return false;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0) {
+		close(fd);
+		return false;
+	}
+
+	errno = 0;
+	*value = strtoul(buf, NULL, 0);
+
+	close(fd);
+
+	return errno ? false : true;
+}
+
+TEST_F(enclave, unclobbered_vdso_oversubscribed)
+{
+	unsigned long total_mem;
+	struct encl_op op;
+
+	if (!sysfs_get_ulong(SGX_TOTAL_MEM_PATH, &total_mem))
+		ASSERT_TRUE(false);
+
+	if (!setup_test_encl(total_mem, &self->encl, _metadata))
+		ASSERT_TRUE(false);
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	op.type = ENCL_OP_PUT;
+	op.buffer = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	op.type = ENCL_OP_GET;
+	op.buffer = 0;
+
+	EXPECT_EQ(ENCL_CALL(&op, &self->run, false), 0);
+
+	EXPECT_EQ(op.buffer, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+}
+
 TEST_F(enclave, clobbered_vdso)
 {
 	struct encl_op op;
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index b45c52ec7ab3..dd7767364107 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -7,6 +7,7 @@
 #define MAIN_H
 
 #define ENCL_HEAP_SIZE_DEFAULT	4096
+#define SGX_TOTAL_MEM_PATH	"/sys/kernel/debug/x86/sgx_total_mem"
 
 struct encl_segment {
 	void *src;
-- 
2.32.0

