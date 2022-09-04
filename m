Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB795AC35B
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Sep 2022 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiIDHyt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Sep 2022 03:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiIDHyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Sep 2022 03:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D563DDB;
        Sun,  4 Sep 2022 00:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0819C60E84;
        Sun,  4 Sep 2022 07:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB41C433C1;
        Sun,  4 Sep 2022 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662278062;
        bh=/y4U+7PnZTbeKfXf+LRde+nSBvUuT66dww+jNyXTXHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIq7WnNNMyLMFrTdlGYYZRn0RG4ewvHSxAUMrH7qSzlqnEmRwRVgGIHr8Iy0GNQNN
         4+OsPjqSuP7c7FQTIIKY4EzXY0cW9naxkgV6+n99OEoLraUE730ef757zu9/MbQO32
         E7KahPcLP2T5Q1AW8QrtLQBM+K0pjHWxf6DErrjOcA6w1RJdWZ0hq6hQ9yn2iWfx9x
         OKo0NdpsmJipFKH2SSWZCnE9d7B8EK//cfop2ZgBqCm7i+lPEYr4/DX0zcrtwOzriL
         81sfn7MKqJZgmJ2Fwn99Lr77XlzHMn/20TyuPWjiMOyW3ywu//E6gJcKXmeJfchEN1
         mZRdcpOwwzmWw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] selftests/sgx: Include the dynamic heap size to the ELRANGE calculation
Date:   Sun,  4 Sep 2022 10:53:57 +0300
Message-Id: <20220904075358.7727-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904075358.7727-1-jarkko@kernel.org>
References: <20220904075358.7727-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When calculating ELRANGE, i.e. the address range defined for an enclave,
and represented by encl->encl_size, also dynamic memory should be taken
into account. Implement setup_test_encl_dynamic() with dynamic_size
parameter for the dynamic heap size, and use it in 'augment_via_eaccept'
and 'augment' tests.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/load.c |  5 +++--
 tools/testing/selftests/sgx/main.c | 24 +++++++++++++++++-------
 tools/testing/selftests/sgx/main.h |  3 ++-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 3b4e2422fb09..963a5c6bbbdc 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 	return 0;
 }
 
-bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
+	       unsigned long dynamic_size)
 {
 	const char device_path[] = "/dev/sgx_enclave";
 	unsigned long contents_size;
@@ -299,7 +300,7 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 	if (seg->src == MAP_FAILED)
 		goto err;
 
-	contents_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
+	contents_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size + dynamic_size;
 
 	for (encl->encl_size = 4096; encl->encl_size < contents_size; )
 		encl->encl_size <<= 1;
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index a1850e139c99..4feffe7cd8fb 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -22,6 +22,7 @@
 #include "main.h"
 
 static const size_t ENCL_HEAP_SIZE_DEFAULT = PAGE_SIZE;
+static const size_t ENCL_DYNAMIC_SIZE_DEFAULT = PAGE_SIZE;
 static const uint64_t MAGIC = 0x1122334455667788ULL;
 static const uint64_t MAGIC2 = 0x8877665544332211ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
@@ -173,8 +174,8 @@ FIXTURE(enclave) {
 	struct sgx_enclave_run run;
 };
 
-static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
-			    struct __test_metadata *_metadata)
+static bool setup_test_encl_dynamic(unsigned long heap_size, unsigned long dynamic_size,
+				    struct encl *encl, struct __test_metadata *_metadata)
 {
 	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
@@ -184,7 +185,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	unsigned int i;
 	void *addr;
 
-	if (!encl_load("test_encl.elf", encl, heap_size)) {
+	if (!encl_load("test_encl.elf", encl, heap_size, dynamic_size)) {
 		encl_delete(encl);
 		TH_LOG("Failed to load the test enclave.");
 		return false;
@@ -251,6 +252,12 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	return false;
 }
 
+static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
+			    struct __test_metadata *_metadata)
+{
+	return setup_test_encl_dynamic(heap_size, 0, encl, _metadata);
+}
+
 FIXTURE_SETUP(enclave)
 {
 }
@@ -1013,7 +1020,9 @@ TEST_F(enclave, augment)
 	if (!sgx2_supported())
 		SKIP(return, "SGX2 not supported");
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl_dynamic(ENCL_HEAP_SIZE_DEFAULT,
+					    ENCL_DYNAMIC_SIZE_DEFAULT,
+					    &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1143,7 +1152,9 @@ TEST_F(enclave, augment_via_eaccept)
 	if (!sgx2_supported())
 		SKIP(return, "SGX2 not supported");
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+	ASSERT_TRUE(setup_test_encl_dynamic(ENCL_HEAP_SIZE_DEFAULT,
+					    ENCL_DYNAMIC_SIZE_DEFAULT,
+					    &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
@@ -1264,8 +1275,7 @@ TEST_F(enclave, tcs_create)
 	int errno_save;
 	int ret, i;
 
-	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl,
-				    _metadata));
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
 	self->run.tcs = self->encl.encl_base;
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 9c1bc0d9b43c..8f77ce56ad09 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -32,7 +32,8 @@ extern unsigned char sign_key[];
 extern unsigned char sign_key_end[];
 
 void encl_delete(struct encl *ctx);
-bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
+bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
+	       unsigned long dynamic_size);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
 uint64_t encl_get_entry(struct encl *encl, const char *symbol);
-- 
2.37.2

