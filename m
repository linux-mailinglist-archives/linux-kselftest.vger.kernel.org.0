Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38D63E1FE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 02:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhHFARu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 20:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241119AbhHFARo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 20:17:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64C6461163;
        Fri,  6 Aug 2021 00:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209048;
        bh=mtizAPA5mmHzhy5HVIFitBew0+Sy6VfrTxywUHjPXjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbcmNxYKkvXRt8FurRHNWk3g4fjZ8t3fuJ712LnFhe/Nw6laENFUy46yy3Cj5c3du
         SRW2/3QXxFnLki83KrtMB8udr/6Bk5VMKQLQwSxHKqGpIM3HYfluCF6czNsOkUIf7i
         gLS4H3Y5Z9CTmU3bDhIbrOKLemZRCiPXH2Uxp7UVc0KA/55ckF7l8OTAHV4k3oieaa
         jJrWgLQKlpZxH9zH3rcjnLce0ZO2xQ0vdw3Qy/Qcrf+Fk8BcpF36uoqWv377pdMH/s
         lFWyqMhs11OfNquieV5IeW+7NMvX60wuiVmBYtq6TnzRCPqILMZ0JGo7ipobi5D9H+
         E1m/AenKNaF7g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] selftests/sgx: Move setup_test_encl() to each TEST_F()
Date:   Fri,  6 Aug 2021 03:17:03 +0300
Message-Id: <20210806001704.667889-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806001704.667889-1-jarkko@kernel.org>
References: <20210806001704.667889-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create the test enclave inside each TEST_F(), instead of FIXTURE_SETUP(),
so that the heap size can be defined per test.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 4fbe9856f775..f219768b4e9a 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -191,11 +191,6 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 
 FIXTURE_SETUP(enclave)
 {
-	if (!setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata))
-		ASSERT_TRUE(false);
-
-	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
 }
 
 FIXTURE_TEARDOWN(enclave)
@@ -227,6 +222,12 @@ TEST_F(enclave, unclobbered_vdso)
 {
 	struct encl_op op;
 
+	if (!setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata))
+		ASSERT_TRUE(false);
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	op.type = ENCL_OP_PUT;
 	op.buffer = MAGIC;
 
@@ -249,6 +250,12 @@ TEST_F(enclave, clobbered_vdso)
 {
 	struct encl_op op;
 
+	if (!setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata))
+		ASSERT_TRUE(false);
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	op.type = ENCL_OP_PUT;
 	op.buffer = MAGIC;
 
@@ -279,6 +286,12 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 {
 	struct encl_op op;
 
+	if (!setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata))
+		ASSERT_TRUE(false);
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
 
-- 
2.32.0

