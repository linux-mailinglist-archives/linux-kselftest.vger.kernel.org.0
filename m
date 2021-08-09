Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2A3E42B9
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Aug 2021 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhHIJcP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Aug 2021 05:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234572AbhHIJcM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Aug 2021 05:32:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12155610E7;
        Mon,  9 Aug 2021 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628501512;
        bh=PGVB0tNh0Gvm8iSYYSxxnHLtfItRG4cHbrPX1EnEkic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Frll7Mt0G1UbPdR9qY+YBJJLHoIaAQLE526F6cvhDEXwRNFMoUNKYf4GdvWrygeZf
         ShlED2nQixxFdIBlpuRmIAcvX/FYsOVDsUFFE3uZmtIQ+Z7CAY+epldrSF89SAp7KR
         hRkZImWxZ7oMM1WFP2mJJ6cGWlcC2YEv86hIUkONd0t5si0lu6HHyS2M6wwJGPgjll
         psPsjF0QWrrmMTyaouPVRIoF9UekamcToUoJ0z+I7wAgbUAq9CYNxYzcrl6qFxCZ0z
         DJMbKimUKTQRcJkf3x28PGBKZ+wDQVAwtWRtWVty98i0VWO6KryhG+npByFzC/AH2+
         iUqzpzv1fXcfQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] selftests/sgx: Encpsulate the test enclave creation
Date:   Mon,  9 Aug 2021 12:31:25 +0300
Message-Id: <20210809093127.76264-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809093127.76264-1-jarkko@kernel.org>
References: <20210809093127.76264-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce setup_test_encl() so that the enclave creation can be moved to
TEST_F()'s. This is required for a reclaimer test where the heap size needs
to be set large enough to triger the page reclaimer.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---

v4:
* Wrap setup_test_encl() with ASSERT_TRUE().
* Update commit message.

 tools/testing/selftests/sgx/main.c | 44 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index deab02f2f3ce..5b3e49a36344 100644
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
@@ -186,7 +184,17 @@ FIXTURE_SETUP(enclave)
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
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
 }
 
 FIXTURE_TEARDOWN(enclave)
-- 
2.32.0

