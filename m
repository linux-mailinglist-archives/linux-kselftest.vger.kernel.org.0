Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AB840CDFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 22:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhIOUci (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 16:32:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:13812 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhIOUce (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 16:32:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="286109366"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="286109366"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="545092780"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 13:31:14 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     linux-sgx@vger.kernel.org, jarkko@kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] selftests/sgx: Encpsulate the test enclave creation
Date:   Wed, 15 Sep 2021 13:30:57 -0700
Message-Id: <263ba6df7b5d386e34fac7457cf51d97994de579.1631731214.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org>

Introduce setup_test_encl() so that the enclave creation can be moved to
TEST_F()'s. This is required for a reclaimer test where the heap size needs
to be set large enough to triger the page reclaimer.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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
2.25.1

