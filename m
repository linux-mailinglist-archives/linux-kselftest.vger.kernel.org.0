Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AA3E42BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhHIJcR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 05:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234589AbhHIJcP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 05:32:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14AC66108C;
        Mon,  9 Aug 2021 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501515;
        bh=Y7p2x/bDegQypWg8UgxBnNey4+WYsv8vlUAGmvEtYqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOZkva887JOAgYUEXXphvC8YIKSeR57Zxd49C9WFK2aRUWI5BPylZ35lpGFzl2hTW
         OuVvXFkcEXw7NLseC2BS7jIiIxyIZeLcCKT/zq/mWGMlbLVL8H2RNbrfmCFmXAnaWP
         3df8FUI5nf5NQe0vnXfDpLLrT11YIA9Bx1Yj2vYn5jObgkeOaqrdOfuLdxP4a4Aos6
         lmPUf2Zh0b4XTko+4AXD0IyBcq85GFEWbL6E0nmEBMQlvD038083me0yg5VWBS4VyB
         bA4kxhJWac3mzC9q/hi5I9QKJi9Qt4drPH2acv8P8oY7sqmBnqLPw+ZuSJPfmFVNId
         fdqXVJahagkww==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] selftests/sgx: Move setup_test_encl() to each TEST_F()
Date:   Mon,  9 Aug 2021 12:31:26 +0300
Message-Id: <20210809093127.76264-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809093127.76264-1-jarkko@kernel.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create the test enclave inside each TEST_F(), instead of FIXTURE_SETUP(),
so that the heap size can be defined per test.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v4:
* Wrap setup_test_encl() with ASSERT_TRUE().
* Update commit message.

 tools/testing/selftests/sgx/main.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 5b3e49a36344..f41fba919d06 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -191,10 +191,6 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 
 FIXTURE_SETUP(enclave)
 {
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
-
-	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
 }
 
 FIXTURE_TEARDOWN(enclave)
@@ -226,6 +222,11 @@ TEST_F(enclave, unclobbered_vdso)
 {
 	struct encl_op op;
 
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	op.type = ENCL_OP_PUT;
 	op.buffer = MAGIC;
 
@@ -248,6 +249,11 @@ TEST_F(enclave, clobbered_vdso)
 {
 	struct encl_op op;
 
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	op.type = ENCL_OP_PUT;
 	op.buffer = MAGIC;
 
@@ -278,6 +284,11 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 {
 	struct encl_op op;
 
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-- 
2.32.0

