Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461CE3659BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Apr 2021 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhDTNRr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Apr 2021 09:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232443AbhDTNRp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Apr 2021 09:17:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE057613CA;
        Tue, 20 Apr 2021 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618924634;
        bh=I/WWp3ZhiKpLexAP/6uikhopmlNfpvxqz9r1ZOciMHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjXkKne+FA6PkCeeaRcCEbX6RLKVRuOZ950ZCFbmq7MKlDrFMoTQh9mnZRkPy2aGx
         /gLjaLVwUrA1Rp2N6jWx+BpEIWTFmBe1vqlBsoiPGg0GkiVz5tLIB0gsurVKD4pkaw
         7gXvNEn04SUiRgGDfrhEgpO4bnMBzvJNM0M7y6t+/VENHx8C/E9ulvt5AmJqWDUUQn
         zKcjUrgm6zeqJrE/wb8pbdExYJ3d26l9AX4v5MOq3N/1HlIm+936DGGRA0IZdnoFfM
         VLSUXFbe7czTs8sXSG+NXGS+jKF3NMjIzssHmIppiVUWTlLNzvGw0BLAO7qZijhlnW
         CdBL8LeCbxZ3w==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 2/2] secretmem: optimize page_is_secretmem()
Date:   Tue, 20 Apr 2021 16:16:11 +0300
Message-Id: <20210420131611.8259-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210420131611.8259-1-rppt@kernel.org>
References: <20210420131611.8259-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Kernel test robot reported -4.2% regression of will-it-scale.per_thread_ops
due to commit "mm: introduce memfd_secret system call to create "secret"
memory areas".

The perf profile of the test indicated that the regression is caused by
page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):

 27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_pgd_range
  0.00  +3.2   3.19 ± 2%  perf-profile.children.cycles-pp.page_mapping
  0.00  +3.7   3.66 ± 2%  perf-profile.children.cycles-pp.page_is_secretmem

Further analysis showed that the slow down happens because neither
page_is_secretmem() nor page_mapping() are not inline and moreover,
multiple page flags checks in page_mapping() involve calling
compound_head() several times for the same page.

Make page_is_secretmem() inline and replace page_mapping() with page flag
checks that do not imply page-to-head conversion.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
 mm/secretmem.c            | 12 +-----------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 907a6734059c..b842b38cbeb1 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -4,8 +4,32 @@
 
 #ifdef CONFIG_SECRETMEM
 
+extern const struct address_space_operations secretmem_aops;
+
+static inline bool page_is_secretmem(struct page *page)
+{
+	struct address_space *mapping;
+
+	/*
+	 * Using page_mapping() is quite slow because of the actual call
+	 * instruction and repeated compound_head(page) inside the
+	 * page_mapping() function.
+	 * We know that secretmem pages are not compound and LRU so we can
+	 * save a couple of cycles here.
+	 */
+	if (PageCompound(page) || !PageLRU(page))
+		return false;
+
+	mapping = (struct address_space *)
+		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
+
+	if (mapping != page->mapping)
+		return false;
+
+	return page->mapping->a_ops == &secretmem_aops;
+}
+
 bool vma_is_secretmem(struct vm_area_struct *vma);
-bool page_is_secretmem(struct page *page);
 bool secretmem_active(void);
 
 #else
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3b1ba3991964..0bcd15e1b549 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -151,22 +151,12 @@ static void secretmem_freepage(struct page *page)
 	clear_highpage(page);
 }
 
-static const struct address_space_operations secretmem_aops = {
+const struct address_space_operations secretmem_aops = {
 	.freepage	= secretmem_freepage,
 	.migratepage	= secretmem_migratepage,
 	.isolate_page	= secretmem_isolate_page,
 };
 
-bool page_is_secretmem(struct page *page)
-{
-	struct address_space *mapping = page_mapping(page);
-
-	if (!mapping)
-		return false;
-
-	return mapping->a_ops == &secretmem_aops;
-}
-
 static struct vfsmount *secretmem_mnt;
 
 static struct file *secretmem_file_create(unsigned long flags)
-- 
2.28.0

