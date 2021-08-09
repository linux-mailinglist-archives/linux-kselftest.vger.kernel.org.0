Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D631F3E42BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhHIJcT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 05:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234597AbhHIJcT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 05:32:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22A2D611C5;
        Mon,  9 Aug 2021 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501518;
        bh=FOrdcQNSfE4qcKwJIDhTp8LMWfTjCfvnygplnr9i9uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhNsKRBO35VbzPgqXJX5LVF37nhqTKYJQAlDmw2WuYUyK93k+4x3vOxQZyseSE33j
         VozV6SoUhJyypy01Gud8Uz+cJ5XA9pisqiZEAs0fa0EEUp+BZ9vPk/x4m0o62FSj+v
         EKYkLTWvPLixsy6iWgUmv8io64YY81ny81mveiKZ1EwsNgewMmKB+sucTY2tIcOIjs
         AOXThBbO5ebGOniQqHIJh9O47P5c4Qo7BTv3T9C1D095RZPtFzOlsAovAvNzowNGft
         YgMsxbdoLNwo74Mt+9jYj8qS1ORfbbfGZXxEklq7GzaUYjGNgc02/FOl6Z+t+GrvM7
         7EMyDa9vFaoVQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] selftests/sgx: Add a new kselftest: unclobbered_vdso_oversubscribed
Date:   Mon,  9 Aug 2021 12:31:27 +0300
Message-Id: <20210809093127.76264-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809093127.76264-1-jarkko@kernel.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
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

v4:
* Wrap setup_test_encl() and get_sysfs_long() with ASSERT_TRUE().

 tools/testing/selftests/sgx/main.c | 59 ++++++++++++++++++++++++++++++
 tools/testing/selftests/sgx/main.h |  1 +
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f41fba919d06..2e0a6523c60c 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -245,6 +245,65 @@ TEST_F(enclave, unclobbered_vdso)
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
+	ASSERT_TRUE(sysfs_get_ulong(SGX_TOTAL_MEM_PATH, &total_mem));
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
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

