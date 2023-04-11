Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB736DDD82
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDKORf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 10:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDKORR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 10:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E84C49CF
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681222550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwTQ8oLmv6mJPSwow3w38v2InKFos9H0Yp4Ad7AU1D8=;
        b=b2bpNsezngzTj0GhvSSgy4c5tzmvfsViE3ovH5434JfdOjWKYq7CXHtKdqvPNd+IdPf0w+
        tW08xQ2+qAP9rdS8X1U0kXoxpJbvuvQ/BJ0xnT+b4mNuyW9rNO+XU0mzTS7jgiSx0ak47e
        2DxrgZY3OTfkiVzQWqsiYa5GGmKkKYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-6m8W4uXYOJij1C-eHrqkJw-1; Tue, 11 Apr 2023 10:15:47 -0400
X-MC-Unique: 6m8W4uXYOJij1C-eHrqkJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFB748996F4;
        Tue, 11 Apr 2023 14:15:40 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABE2F400F285;
        Tue, 11 Apr 2023 14:15:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/6] sparc/mm: don't unconditionally set HW writable bit when setting PTE dirty on 64bit
Date:   Tue, 11 Apr 2023 16:15:26 +0200
Message-Id: <20230411141529.428991-5-david@redhat.com>
In-Reply-To: <20230411141529.428991-1-david@redhat.com>
References: <20230411141529.428991-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On sparc64, there is no HW modified bit, therefore, SW tracks via a SW
bit if the PTE is dirty via pte_mkdirty(). However, pte_mkdirty()
currently also unconditionally sets the HW writable bit, which is wrong.

pte_mkdirty() is not supposed to make a PTE actually writable, unless the
SW writable bit -- pte_write() -- indicates that the PTE is not
write-protected. Fortunately, sparc64 also defines a SW writable bit.

For example, this already turned into a problem in the context of
THP splitting as documented in commit 624a2c94f5b7 ("Partly revert "mm/thp:
carry over dirty bit when thp splits on pmd""), and for page migration,
as documented in commit 96a9c287e25d ("mm/migrate: fix wrongly apply write
bit after mkdirty on sparc64").

Also, we might want to use the dirty PTE bit in the context of KSM with
shared zeropage [1], whereby setting the page writable would be
problematic.

But more general, any code that might end up setting a PTE/PMD dirty
inside a VM without write permissions is possibly broken,

Before this commit (sun4u in QEMU):
	root@debian:~/linux/tools/testing/selftests/mm# ./mkdirty
	# [INFO] detected THP size: 8192 KiB
	TAP version 13
	1..6
	# [INFO] PTRACE write access
	not ok 1 SIGSEGV generated, page not modified
	# [INFO] PTRACE write access to THP
	not ok 2 SIGSEGV generated, page not modified
	# [INFO] Page migration
	ok 3 SIGSEGV generated, page not modified
	# [INFO] Page migration of THP
	ok 4 SIGSEGV generated, page not modified
	# [INFO] PTE-mapping a THP
	ok 5 SIGSEGV generated, page not modified
	# [INFO] UFFDIO_COPY
	not ok 6 SIGSEGV generated, page not modified
	Bail out! 3 out of 6 tests failed
	# Totals: pass:3 fail:3 xfail:0 xpass:0 skip:0 error:0

Test #3,#4,#5 pass ever since we added some MM workarounds, the
underlying issue remains.

Let's fix the remaining issues and prepare for reverting the workarounds
by setting the HW writable bit only if both, the SW dirty bit and the SW
writable bit are set.

We have to move pte_dirty() and pte_dirty() up. The code patching
mechanism and handling constants > 22bit is a bit special on sparc64.

The ASM logic in pte_mkdirty() and pte_mkwrite() match the logic in
pte_mkold() to create the mask depending on the machine type. The ASM
logic in __pte_mkhwwrite() matches the logic in pte_present(), just
using an "or" instead of an "and" instruction.

With this commit (sun4u in QEMU):
	root@debian:~/linux/tools/testing/selftests/mm# ./mkdirty
	# [INFO] detected THP size: 8192 KiB
	TAP version 13
	1..6
	# [INFO] PTRACE write access
	ok 1 SIGSEGV generated, page not modified
	# [INFO] PTRACE write access to THP
	ok 2 SIGSEGV generated, page not modified
	# [INFO] Page migration
	ok 3 SIGSEGV generated, page not modified
	# [INFO] Page migration of THP
	ok 4 SIGSEGV generated, page not modified
	# [INFO] PTE-mapping a THP
	ok 5 SIGSEGV generated, page not modified
	# [INFO] UFFDIO_COPY
	ok 6 SIGSEGV generated, page not modified
	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

This handling seems to have been in place forever.

[1] https://lkml.kernel.org/r/533a7c3d-3a48-b16b-b421-6e8386e0b142@redhat.com

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/sparc/include/asm/pgtable_64.h | 116 ++++++++++++++++------------
 1 file changed, 66 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 2dc8d4641734..5563efa1a19f 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -357,6 +357,42 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
  */
 #define pgprot_noncached pgprot_noncached
 
+static inline unsigned long pte_dirty(pte_t pte)
+{
+	unsigned long mask;
+
+	__asm__ __volatile__(
+	"\n661:	mov		%1, %0\n"
+	"	nop\n"
+	"	.section	.sun4v_2insn_patch, \"ax\"\n"
+	"	.word		661b\n"
+	"	sethi		%%uhi(%2), %0\n"
+	"	sllx		%0, 32, %0\n"
+	"	.previous\n"
+	: "=r" (mask)
+	: "i" (_PAGE_MODIFIED_4U), "i" (_PAGE_MODIFIED_4V));
+
+	return (pte_val(pte) & mask);
+}
+
+static inline unsigned long pte_write(pte_t pte)
+{
+	unsigned long mask;
+
+	__asm__ __volatile__(
+	"\n661:	mov		%1, %0\n"
+	"	nop\n"
+	"	.section	.sun4v_2insn_patch, \"ax\"\n"
+	"	.word		661b\n"
+	"	sethi		%%uhi(%2), %0\n"
+	"	sllx		%0, 32, %0\n"
+	"	.previous\n"
+	: "=r" (mask)
+	: "i" (_PAGE_WRITE_4U), "i" (_PAGE_WRITE_4V));
+
+	return (pte_val(pte) & mask);
+}
+
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
@@ -418,28 +454,43 @@ static inline bool is_hugetlb_pte(pte_t pte)
 }
 #endif
 
+static inline pte_t __pte_mkhwwrite(pte_t pte)
+{
+	unsigned long val = pte_val(pte);
+
+	/*
+	 * Note: we only want to set the HW writable bit if the SW writable bit
+	 * and the SW dirty bit are set.
+	 */
+	__asm__ __volatile__(
+	"\n661:	or		%0, %2, %0\n"
+	"	.section	.sun4v_1insn_patch, \"ax\"\n"
+	"	.word		661b\n"
+	"	or		%0, %3, %0\n"
+	"	.previous\n"
+	: "=r" (val)
+	: "0" (val), "i" (_PAGE_W_4U), "i" (_PAGE_W_4V));
+
+	return __pte(val);
+}
+
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	unsigned long val = pte_val(pte), tmp;
+	unsigned long val = pte_val(pte), mask;
 
 	__asm__ __volatile__(
-	"\n661:	or		%0, %3, %0\n"
-	"	nop\n"
-	"\n662:	nop\n"
+	"\n661:	mov		%1, %0\n"
 	"	nop\n"
 	"	.section	.sun4v_2insn_patch, \"ax\"\n"
 	"	.word		661b\n"
-	"	sethi		%%uhi(%4), %1\n"
-	"	sllx		%1, 32, %1\n"
-	"	.word		662b\n"
-	"	or		%1, %%lo(%4), %1\n"
-	"	or		%0, %1, %0\n"
+	"	sethi		%%uhi(%2), %0\n"
+	"	sllx		%0, 32, %0\n"
 	"	.previous\n"
-	: "=r" (val), "=r" (tmp)
-	: "0" (val), "i" (_PAGE_MODIFIED_4U | _PAGE_W_4U),
-	  "i" (_PAGE_MODIFIED_4V | _PAGE_W_4V));
+	: "=r" (mask)
+	: "i" (_PAGE_MODIFIED_4U), "i" (_PAGE_MODIFIED_4V));
 
-	return __pte(val);
+	pte = __pte(val | mask);
+	return pte_write(pte) ? __pte_mkhwwrite(pte) : pte;
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
@@ -481,7 +532,8 @@ static inline pte_t pte_mkwrite(pte_t pte)
 	: "=r" (mask)
 	: "i" (_PAGE_WRITE_4U), "i" (_PAGE_WRITE_4V));
 
-	return __pte(val | mask);
+	pte = __pte(val | mask);
+	return pte_dirty(pte) ? __pte_mkhwwrite(pte) : pte;
 }
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -584,42 +636,6 @@ static inline unsigned long pte_young(pte_t pte)
 	return (pte_val(pte) & mask);
 }
 
-static inline unsigned long pte_dirty(pte_t pte)
-{
-	unsigned long mask;
-
-	__asm__ __volatile__(
-	"\n661:	mov		%1, %0\n"
-	"	nop\n"
-	"	.section	.sun4v_2insn_patch, \"ax\"\n"
-	"	.word		661b\n"
-	"	sethi		%%uhi(%2), %0\n"
-	"	sllx		%0, 32, %0\n"
-	"	.previous\n"
-	: "=r" (mask)
-	: "i" (_PAGE_MODIFIED_4U), "i" (_PAGE_MODIFIED_4V));
-
-	return (pte_val(pte) & mask);
-}
-
-static inline unsigned long pte_write(pte_t pte)
-{
-	unsigned long mask;
-
-	__asm__ __volatile__(
-	"\n661:	mov		%1, %0\n"
-	"	nop\n"
-	"	.section	.sun4v_2insn_patch, \"ax\"\n"
-	"	.word		661b\n"
-	"	sethi		%%uhi(%2), %0\n"
-	"	sllx		%0, 32, %0\n"
-	"	.previous\n"
-	: "=r" (mask)
-	: "i" (_PAGE_WRITE_4U), "i" (_PAGE_WRITE_4V));
-
-	return (pte_val(pte) & mask);
-}
-
 static inline unsigned long pte_exec(pte_t pte)
 {
 	unsigned long mask;
-- 
2.39.2

