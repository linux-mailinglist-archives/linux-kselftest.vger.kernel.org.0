Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1EC4E39CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiCVHqn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCVHq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 03:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A0128E31;
        Tue, 22 Mar 2022 00:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F0B61520;
        Tue, 22 Mar 2022 07:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E91C340EC;
        Tue, 22 Mar 2022 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647934946;
        bh=gkxma+dYkNBfdMa1USHkI+B0zztS2NuVGYqVCmPTUsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJVlNu5W8jIidC8dx2FP5BCuNluczQehYE7CigRcJPkltj/XOGzYUJx6R07XaLY3j
         VCNde99UBnZZS4KFFy8jBqr9oudGx4nrZ0Or+sVF0aLm5yohE/5O69pOJY6L2+YJzs
         b0fmlWaleuHF024k7sqIqVV5H/qXFrUlvxcsaUjxRCU+38PHJOKSrIV+ojYQxokYmd
         syvXUR5OZIDrvNYJ+eYUZS2BklX44EtVszk/DN3pt3W/joYhTDmMT9/JxxAoEisI2F
         KUQM14dGB52SsdBB0CiE/ybEOsiCU+5cKY91F3iVuibM2tbtxKvOOU90tZPrkiFsob
         /4OTK+B4r63/A==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-sgx@vger.kernel.org (open list:INTEL SGX),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] selftests/sgx: Make TCS table relocatable
Date:   Tue, 22 Mar 2022 09:43:12 +0200
Message-Id: <20220322074313.7444-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322074313.7444-1-jarkko@kernel.org>
References: <20220322074313.7444-1-jarkko@kernel.org>
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

Add a PT_NOTE section with n_namesz containg "TCS" and n_descz containing
32-bit offset to the TCS table inside the enclave. This allows to place the
TCS segment freely, and thereby make the kselftest binary layout way more
robust.

Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Add RIP relative addressing fix for bootstrap as prepending patch, as
  this depends on it.
* Moved TCS section as the last so that it is easy to add new TCS's,
  e.g dynamically with EAUG + EMODT, behind it.
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
index dd74fa42302e..b206548803b4 100644
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
+	data_start = self->encl.encl_base + self->encl.data_offset + PAGE_SIZE;
 
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
index a1ec64f7d91f..d76df884d8a4 100644
--- a/tools/testing/selftests/sgx/test_encl.lds
+++ b/tools/testing/selftests/sgx/test_encl.lds
@@ -2,17 +2,15 @@ OUTPUT_FORMAT(elf64-x86-64)
 
 PHDRS
 {
-	tcs PT_LOAD;
 	text PT_LOAD;
 	data PT_LOAD;
+	tcs PT_LOAD;
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
@@ -24,11 +22,20 @@ SECTIONS
 
 	.data : {
 		*(.data*)
+		. = ALIGN(4096);
 	} : data
 
+	.tcs : {
+		*(.tcs*)
+	} : tcs
+
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
index 1c1b5c6c4ffe..912b21537532 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -10,6 +10,7 @@
 	.section ".tcs", "aw"
 	.balign	4096
 
+encl_tcs:
 	.fill	1, 8, 0			# STATE (set by CPU)
 	.fill	1, 8, 0			# FLAGS
 	.quad	encl_ssa_tcs1		# OSSA
@@ -90,3 +91,9 @@ encl_stack:
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

