Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A855E40CE01
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhIOUcp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:13812 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhIOUcf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109372"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109372"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092792"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:15 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] selftests/sgx: Rename test properties in preparation for more enclave tests
Date:   Wed, 15 Sep 2021 13:31:01 -0700
Message-Id: <9a1d5d79c624fa7bb0dc89387fc7b3ab49d36dd0.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGX selftests prepares a data structure outside of the enclave with
the type of and data for the operation that needs to be run within
the enclave. At this time only two complementary operations are supported
by the enclave: copying a value from outside the enclave into a default
buffer within the enclave and reading a value from the enclave's default
buffer into a variable accessible outside the enclave.

In preparation for more operations supported by the enclave the names of the
current enclave operations are changed to more accurately reflect the
operations and more easily distinguish it from future operations:

* The enums ENCL_OP_PUT and ENCL_OP_GET are renamed to ENCL_OP_PUT_TO_BUFFER
  and ENCL_OP_GET_FROM_BUFFER respectively.
* The structs encl_op_put and encl_op_get are renamed to encl_op_put_to_buf
  and encl_op_get_from_buf respectively.
* The enclave functions do_encl_op_put and do_encl_op_get are renamed to
  do_encl_op_put_to_buf and do_encl_op_get_from_buf respectively.

No functional changes.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/defines.h   |  8 +++----
 tools/testing/selftests/sgx/main.c      | 32 ++++++++++++-------------
 tools/testing/selftests/sgx/test_encl.c | 12 +++++-----
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 6ff95a766287..9ea0c7882dfb 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -19,8 +19,8 @@
 #include "../../../../arch/x86/include/uapi/asm/sgx.h"
 
 enum encl_op_type {
-	ENCL_OP_PUT,
-	ENCL_OP_GET,
+	ENCL_OP_PUT_TO_BUFFER,
+	ENCL_OP_GET_FROM_BUFFER,
 	ENCL_OP_MAX,
 };
 
@@ -28,12 +28,12 @@ struct encl_op_header {
 	uint64_t type;
 };
 
-struct encl_op_put {
+struct encl_op_put_to_buf {
 	struct encl_op_header header;
 	uint64_t value;
 };
 
-struct encl_op_get {
+struct encl_op_get_from_buf {
 	struct encl_op_header header;
 	uint64_t value;
 };
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index a107fc576094..3eb9b89ece5f 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -220,15 +220,15 @@ FIXTURE_TEARDOWN(enclave)
 
 TEST_F(enclave, unclobbered_vdso)
 {
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
@@ -236,7 +236,7 @@ TEST_F(enclave, unclobbered_vdso)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
@@ -277,9 +277,9 @@ static bool sysfs_get_ulong(const char *path, unsigned long *value)
 
 TEST_F(enclave, unclobbered_vdso_oversubscribed)
 {
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 	unsigned long total_mem;
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
 
 	ASSERT_TRUE(sysfs_get_ulong(SGX_TOTAL_MEM_PATH, &total_mem));
 	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
@@ -287,7 +287,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
@@ -295,7 +295,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
@@ -308,15 +308,15 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 
 TEST_F(enclave, clobbered_vdso)
 {
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
@@ -324,7 +324,7 @@ TEST_F(enclave, clobbered_vdso)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
@@ -344,8 +344,8 @@ static int test_handler(long rdi, long rsi, long rdx, long ursp, long r8, long r
 
 TEST_F(enclave, clobbered_vdso_and_user_function)
 {
-	struct encl_op_put put_op;
-	struct encl_op_get get_op;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
 
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
@@ -355,7 +355,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-	put_op.header.type = ENCL_OP_PUT;
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
 
 	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, true), 0);
@@ -363,7 +363,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
 
-	get_op.header.type = ENCL_OP_GET;
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
 	get_op.value = 0;
 
 	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, true), 0);
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index f11eb8315704..4e8da738173f 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -16,16 +16,16 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
-static void do_encl_op_put(void *op)
+static void do_encl_op_put_to_buf(void *op)
 {
-	struct encl_op_put *op2 = op;
+	struct encl_op_put_to_buf *op2 = op;
 
 	memcpy(&encl_buffer[0], &op2->value, 8);
 }
 
-static void do_encl_op_get(void *op)
+static void do_encl_op_get_from_buf(void *op)
 {
-	struct encl_op_get *op2 = op;
+	struct encl_op_get_from_buf *op2 = op;
 
 	memcpy(&op2->value, &encl_buffer[0], 8);
 }
@@ -33,8 +33,8 @@ static void do_encl_op_get(void *op)
 void encl_body(void *rdi,  void *rsi)
 {
 	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
-		do_encl_op_put,
-		do_encl_op_get,
+		do_encl_op_put_to_buf,
+		do_encl_op_get_from_buf,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
-- 
2.25.1

