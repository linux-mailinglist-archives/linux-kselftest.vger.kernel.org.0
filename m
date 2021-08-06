Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9455D3E1FE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Aug 2021 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbhHFARm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 20:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237202AbhHFARl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 20:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3E4961166;
        Fri,  6 Aug 2021 00:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209046;
        bh=5BJ0JYsrjhLXFa/JwNpSZG3ltphoMxiwwEveE2LxUGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXt+avImv8IkWpTt5eeRaxcsjvZzz2dda8mGkF0Tu0SH+LY33QslysP4R10McPxZF
         3RRqHqJ0ThHsRjr0iTOVNnV3P1tJxSyYmEPOOYdfyzoFz8SG80AN1QV4ZqCdzsiauX
         PW7nDZcutSpMpcVsz9fm2ZrIgAjfNMcPDav/V2xeNAJCVUj3IasNXzY/zkxWGLC0zb
         xHGjl6vIrQdHC5LcC1bvGifs0IMuKcxKAAQQek0y54zZg6zHXO5NuQ3e/PfXZK3Agv
         Gt6uKbnFs+he8icBhp22ysd/fIueKLRgndbPQUUK9hhG0qxS3GYhwcAPL4yq+uqQpM
         n5UhkhaQJcxhQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] selftests/sgx: Encpsulate the test enclave creation
Date:   Fri,  6 Aug 2021 03:17:02 +0300
Message-Id: <20210806001704.667889-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806001704.667889-1-jarkko@kernel.org>
References: <20210806001704.667889-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Having a helper function to build the test enclave is important for
couple of reasons:

1. Allows to parametrize the heap size for different tests.
3. Allows to easily create multiple enclaves.

Introduce setup_test_encl() for this purpose.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/main.c | 45 ++++++++++++++++++------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index deab02f2f3ce..4fbe9856f775 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -112,7 +112,8 @@ FIXTURE(enclave) {
 	struct sgx_enclave_run run;
 };
 
-FIXTURE_SETUP(enclave)
+static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
+			    struct __test_metadata *_metadata)
 {
 	Elf64_Sym *sgx_enter_enclave_sym = NULL;
 	struct vdso_symtab symtab;
@@ -122,25 +123,25 @@ FIXTURE_SETUP(enclave)
 	unsigned int i;
 	void *addr;
 
-	if (!encl_load("test_encl.elf", &self->encl, ENCL_HEAP_SIZE_DEFAULT)) {
-		encl_delete(&self->encl);
-		ksft_exit_skip("cannot load enclaves\n");
+	if (!encl_load("test_encl.elf", encl, heap_size)) {
+		encl_delete(encl);
+		TH_LOG("Failed to load the test enclave.\n");
 	}
 
-	if (!encl_measure(&self->encl))
+	if (!encl_measure(encl))
 		goto err;
 
-	if (!encl_build(&self->encl))
+	if (!encl_build(encl))
 		goto err;
 
 	/*
 	 * An enclave consumer only must do this.
 	 */
-	for (i = 0; i < self->encl.nr_segments; i++) {
-		struct encl_segment *seg = &self->encl.segment_tbl[i];
+	for (i = 0; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
 
-		addr = mmap((void *)self->encl.encl_base + seg->offset, seg->size,
-			    seg->prot, MAP_SHARED | MAP_FIXED, self->encl.fd, 0);
+		addr = mmap((void *)encl->encl_base + seg->offset, seg->size,
+			    seg->prot, MAP_SHARED | MAP_FIXED, encl->fd, 0);
 		EXPECT_NE(addr, MAP_FAILED);
 		if (addr == MAP_FAILED)
 			goto err;
@@ -160,16 +161,13 @@ FIXTURE_SETUP(enclave)
 
 	vdso_sgx_enter_enclave = addr + sgx_enter_enclave_sym->st_value;
 
-	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
-
-	return;
+	return true;
 
 err:
-	encl_delete(&self->encl);
+	encl_delete(encl);
 
-	for (i = 0; i < self->encl.nr_segments; i++) {
-		seg = &self->encl.segment_tbl[i];
+	for (i = 0; i < encl->nr_segments; i++) {
+		seg = &encl->segment_tbl[i];
 
 		TH_LOG("0x%016lx 0x%016lx 0x%02x", seg->offset, seg->size, seg->prot);
 	}
@@ -186,7 +184,18 @@ FIXTURE_SETUP(enclave)
 		fclose(maps_file);
 	}
 
-	ASSERT_TRUE(false);
+	TH_LOG("Failed to initialize the test enclave.\n");
+
+	return false;
+}
+
+FIXTURE_SETUP(enclave)
+{
+	if (!setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata))
+		ASSERT_TRUE(false);
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
 }
 
 FIXTURE_TEARDOWN(enclave)
-- 
2.32.0

