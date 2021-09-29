Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41FF41C6EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbhI2Oj1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 10:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344564AbhI2OjY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 10:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632926263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxKKmmMRHJSYhaR7u+5ryK3qo040LzhTNWQ2wFcbJqY=;
        b=Hfnad3FyibG68Gagmp+wpSxm/MlrH5TwdASqLgirrnwaTKOOoKawqQlUNcE081CTtz5mFM
        9t745zKGnK7agBC5QXZkvPnt48nR4vAFePOB6SgrFlTgwaRRn4Xtc4AbqTX7rFUv99l2xX
        Cw7CRAWDQlm97BftumE+2r3ANvPogsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-8UlB_jwgMrCaCz7PRId56w-1; Wed, 29 Sep 2021 10:37:37 -0400
X-MC-Unique: 8UlB_jwgMrCaCz7PRId56w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 897568015C7;
        Wed, 29 Sep 2021 14:37:34 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 745251017E27;
        Wed, 29 Sep 2021 14:37:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v1 6/6] x86: remove memory hotplug support on X86_32
Date:   Wed, 29 Sep 2021 16:36:00 +0200
Message-Id: <20210929143600.49379-7-david@redhat.com>
In-Reply-To: <20210929143600.49379-1-david@redhat.com>
References: <20210929143600.49379-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CONFIG_MEMORY_HOTPLUG was marked BROKEN over one year and we just
restricted it to 64 bit. Let's remove the unused x86 32bit implementation
and simplify the Kconfig.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/Kconfig      |  6 +++---
 arch/x86/mm/init_32.c | 31 -------------------------------
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22d274e..85f4762429f1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -62,7 +62,7 @@ config X86
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
-	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
+	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
@@ -1615,7 +1615,7 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config ARCH_MEMORY_PROBE
 	bool "Enable sysfs memory/probe interface"
-	depends on X86_64 && MEMORY_HOTPLUG
+	depends on MEMORY_HOTPLUG
 	help
 	  This option enables a sysfs memory/probe interface for testing.
 	  See Documentation/admin-guide/mm/memory-hotplug.rst for more information.
@@ -2395,7 +2395,7 @@ endmenu
 
 config ARCH_HAS_ADD_PAGES
 	def_bool y
-	depends on X86_64 && ARCH_ENABLE_MEMORY_HOTPLUG
+	depends on ARCH_ENABLE_MEMORY_HOTPLUG
 
 config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	def_bool y
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index bd90b8fe81e4..5cd7ea6d645c 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -779,37 +779,6 @@ void __init mem_init(void)
 	test_wp_bit();
 }
 
-#ifdef CONFIG_MEMORY_HOTPLUG
-int arch_add_memory(int nid, u64 start, u64 size,
-		    struct mhp_params *params)
-{
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
-	int ret;
-
-	/*
-	 * The page tables were already mapped at boot so if the caller
-	 * requests a different mapping type then we must change all the
-	 * pages with __set_memory_prot().
-	 */
-	if (params->pgprot.pgprot != PAGE_KERNEL.pgprot) {
-		ret = __set_memory_prot(start, nr_pages, params->pgprot);
-		if (ret)
-			return ret;
-	}
-
-	return __add_pages(nid, start_pfn, nr_pages, params);
-}
-
-void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
-{
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
-
-	__remove_pages(start_pfn, nr_pages, altmap);
-}
-#endif
-
 int kernel_set_to_readonly __read_mostly;
 
 static void mark_nxdata_nx(void)
-- 
2.31.1

