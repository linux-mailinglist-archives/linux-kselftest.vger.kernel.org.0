Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0E34E398C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 08:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiCVH2F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiCVH2D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 03:28:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103AC56;
        Tue, 22 Mar 2022 00:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75F74B81AE4;
        Tue, 22 Mar 2022 07:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F443C340EC;
        Tue, 22 Mar 2022 07:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647933993;
        bh=RzLHsXsPs3Je45PF2I3isW4cEiviXfi7RkKws8ivgew=;
        h=From:To:Cc:Subject:Date:From;
        b=moaxBKyw5iVYg+ex1Ck8QRJVfTt/TtFUBj5tNhEZrlI747TvVmK3PM1ww8L/mLRKN
         lhUw1KCge9LL8Go8wBicDptdN1k3Vc4IxOyQsfwUSjGfaooBxnoyZNxinFnIbbFpY2
         VwmQ28smNDXwloHZ1W8OzFlPabJind3iC1joIVOYhqyihuKKBug1TM2YzaoOhY3tqb
         9h+m6ywi+5emwgOuVEhuCk4KLZmriG9i6JpajowTzSUohJQaBrVzTLgV54QF3HrZV3
         N/fNlTSmlWshuKQcCjK8hHVZSSYlSv4+ST0gTJnWo4YnWrOFx0yf7rF9LuZh7t41He
         Aus64dTur9yww==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/sgx: Make TCS table relocatable
Date:   Tue, 22 Mar 2022 09:25:33 +0200
Message-Id: <20220322072533.342510-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a PT_NOTE section with n_namesz containg "TCS" and n_descz
containing 32-bit offset to the TCS table inside the enclave. This
allows to place the TCS segment freely, and thereby make the kselftest
more robust.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/load.c            | 56 ++++++++++++++-----
 tools/testing/selftests/sgx/main.c            | 37 +++---------
 tools/testing/selftests/sgx/main.h            |  2 +
 tools/testing/selftests/sgx/test_encl.lds     | 17 ++++--
 .../selftests/sgx/test_encl_bootstrap.S       |  7 +++
 5 files changed, 72 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 006b464c8fc9..214b9da631bd 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -19,6 +19,9 @@
 #include "defines.h"
 #include "main.h"
 
+const char *TCS_NOTE_NAME = "TCS";
+const unsigned long TCS_NOTE_LEN = 4;
+
 void encl_delete(struct encl *encl)
 {
 	struct encl_segment *heap_seg;
@@ -187,11 +190,31 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 
 	encl->nr_segments = 1; /* one for the heap */
 
+	/* Count the loadable segments and discover the TCS array. */
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		Elf64_Phdr *phdr = &phdr_tbl[i];
+		Elf64_Nhdr *note;
+		char *note_name;
 
-		if (phdr->p_type == PT_LOAD)
+		switch (phdr->p_type) {
+		case PT_LOAD:
 			encl->nr_segments++;
+			break;
+
+		case PT_NOTE:
+			note = encl->bin + (phdr->p_offset & PAGE_MASK);
+			note_name = &((char *)note)[sizeof(*note)];
+
+			if (note->n_namesz == TCS_NOTE_LEN &&
+			    !strncmp(note_name, TCS_NOTE_NAME, TCS_NOTE_LEN)) {
+				/* 32-bit address. */
+				encl->tcs = (struct sgx_tcs *)(unsigned long)(note->n_descsz);
+			}
+			break;
+
+		default:
+			break;
+		}
 	}
 
 	encl->segment_tbl = calloc(encl->nr_segments,
@@ -215,31 +238,36 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 			goto err;
 		}
 
-		if (j == 0 && flags != (PF_R | PF_W)) {
-			fprintf(stderr,
-				"TCS has invalid segment flags 0x%02x.\n",
-				phdr->p_flags);
-			goto err;
-		}
-
 		if (j == 0) {
 			src_offset = phdr->p_offset & PAGE_MASK;
 			encl->src = encl->bin + src_offset;
+		}
+
+		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
+		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
+		seg->src = encl->src + seg->offset;
+		seg->measure = true;
+
+		if (seg->offset == (unsigned long)encl->tcs) {
+			if (flags != (PF_R | PF_W)) {
+				fprintf(stderr,
+					"TCS has invalid segment flags 0x%02x.\n",
+					phdr->p_flags);
+				goto err;
+			}
 
 			seg->prot = PROT_READ | PROT_WRITE;
 			seg->flags = SGX_PAGE_TYPE_TCS << 8;
 		} else  {
+			if ((flags & (PF_R | PF_W | PF_X)) == (PF_R | PF_W))
+				encl->data_offset = seg->offset;
+
 			seg->prot = (phdr->p_flags & PF_R) ? PROT_READ : 0;
 			seg->prot |= (phdr->p_flags & PF_W) ? PROT_WRITE : 0;
 			seg->prot |= (phdr->p_flags & PF_X) ? PROT_EXEC : 0;
 			seg->flags = (SGX_PAGE_TYPE_REG << 8) | seg->prot;
 		}
 
-		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
-		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
-		seg->src = encl->src + seg->offset;
-		seg->measure = true;
-
 		j++;
 	}
 
@@ -322,5 +350,7 @@ bool encl_build(struct encl *encl)
 		return false;
 	}
 
+	encl->tcs = (struct sgx_tcs *)((unsigned long)encl->tcs + encl->encl_base);
+
 	return true;
 }
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index dd74fa42302e..929f3a06a66c 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -109,25 +109,6 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
-/*
- * Return the offset in the enclave where the data segment can be found.
- * The first RW segment loaded is the TCS, skip that to get info on the
- * data segment.
- */
-static off_t encl_get_data_offset(struct encl *encl)
-{
-	int i;
-
-	for (i = 1; i < encl->nr_segments; i++) {
-		struct encl_segment *seg = &encl->segment_tbl[i];
-
-		if (seg->prot == (PROT_READ | PROT_WRITE))
-			return seg->offset;
-	}
-
-	return -1;
-}
-
 FIXTURE(enclave) {
 	struct encl encl;
 	struct sgx_enclave_run run;
@@ -248,7 +229,7 @@ TEST_F(enclave, unclobbered_vdso)
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
+	self->run.tcs = (__u64)self->encl.tcs;
 
 	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
@@ -321,7 +302,7 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
+	self->run.tcs = (__u64)self->encl.tcs;
 
 	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
@@ -350,7 +331,7 @@ TEST_F(enclave, clobbered_vdso)
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
+	self->run.tcs = (__u64)self->encl.tcs;
 
 	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
 	put_op.value = MAGIC;
@@ -386,7 +367,7 @@ TEST_F(enclave, clobbered_vdso_and_user_function)
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
+	self->run.tcs = (__u64)self->encl.tcs;
 
 	self->run.user_handler = (__u64)test_handler;
 	self->run.user_data = 0xdeadbeef;
@@ -419,7 +400,7 @@ TEST_F(enclave, tcs_entry)
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
+	self->run.tcs = (__u64)self->encl.tcs;
 
 	op.type = ENCL_OP_NOP;
 
@@ -431,7 +412,7 @@ TEST_F(enclave, tcs_entry)
 	EXPECT_EQ(self->run.exception_addr, 0);
 
 	/* Move to the next TCS. */
-	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
+	self->run.tcs = (__u64)self->encl.tcs + PAGE_SIZE;
 
 	EXPECT_EQ(ENCL_CALL(&op, &self->run, true), 0);
 
@@ -464,11 +445,9 @@ TEST_F(enclave, pte_permissions)
 	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
 
 	memset(&self->run, 0, sizeof(self->run));
-	self->run.tcs = self->encl.encl_base;
+	self->run.tcs = (__u64)self->encl.tcs;
 
-	data_start = self->encl.encl_base +
-		     encl_get_data_offset(&self->encl) +
-		     PAGE_SIZE;
+	data_start = self->encl.encl_base + self->encl.data_offset;
 
 	/*
 	 * Sanity check to ensure it is possible to write to page that will
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index b45c52ec7ab3..bccb263be8d9 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -29,6 +29,8 @@ struct encl {
 	struct encl_segment *segment_tbl;
 	struct sgx_secs secs;
 	struct sgx_sigstruct sigstruct;
+	struct sgx_tcs *tcs;
+	unsigned long data_offset;
 };
 
 extern unsigned char sign_key[];
diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
index a1ec64f7d91f..6f72d4183292 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -2,17 +2,15 @@ OUTPUT_FORMAT(elf64-x86-64)
 
 PHDRS
 {
-	tcs PT_LOAD;
 	text PT_LOAD;
+	tcs PT_LOAD;
 	data PT_LOAD;
+	note PT_NOTE;
 }
 
 SECTIONS
 {
 	. = 0;
-	.tcs : {
-		*(.tcs*)
-	} : tcs
 
 	. = ALIGN(4096);
 	.text : {
@@ -22,13 +20,22 @@ SECTIONS
 		. = ALIGN(4096);
 	} : text
 
+	.tcs : {
+		*(.tcs*)
+	} : tcs
+
 	.data : {
 		*(.data*)
+		. = ALIGN(4096);
 	} : data
 
+	.note : {
+		*(.note.tcs*)
+	} : note
+
 	/DISCARD/ : {
 		*(.comment*)
-		*(.note*)
+		*(.note.gnu.*)
 		*(.debug*)
 		*(.eh_frame*)
 	}
diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 82fb0dfcbd23..cf821c80f82c 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -10,6 +10,7 @@
 	.section ".tcs", "aw"
 	.balign	4096
 
+encl_tcs:
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
 	.quad	encl_ssa_tcs1		# OSSA
@@ -94,3 +95,9 @@ encl_stack:
 	.balign 4096
 	# Stack of TCS #2
 	.space 4096
+
+	.section ".note.tcs", "", @progbits
+	.long 4
+	.long encl_tcs
+	.long 0
+	.string "TCS"
-- 
2.35.1

