Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32434A04
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2019 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfFDOSD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jun 2019 10:18:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfFDOSD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fnKal4vlAfnEhHiZ62MpoW51VyknnUeB4tHqDSZ7yb0=; b=QGB5fTPS0Y1QbkDcmoH+UkgrxA
        1pMk8z+7aPIz0M+LOllnD+yAWo2PKijhU9Of83jsAWaNOGHbvnhM2IQck3GnEi+acdgX4PFfjXX1W
        8dYMp+e54crQ0CzwiC48jwbmrELFhJ/gciYLAQXJe7mP/wV/+2HI55UusjHY/V6bFASKi5HgkPP8Q
        /bkB7ouKvrGMio/R1G2oLILaMq7yd6Ah+rImQZ6uCGXSZrYPpd7QLN9erf94Abeheb/CCJfEZt9RB
        qRJj+GdOJUVq+4w4bfEshAGOm9wTPo4f9yMhKZrNIpSOMQmMnojudwXZzDT8MIJIASC6ZhOHf4clg
        y0SDma1Q==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rz-VM; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002lw-V3; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Changbin Du <changbin.du@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 18/22] docs: move protection-keys.rst to the core-api book
Date:   Tue,  4 Jun 2019 11:17:52 -0300
Message-Id: <07193510c4ce4be2332ec03e5232779c36e7bb4c.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This document is used by multiple architectures:

	$ echo $(git grep -l  pkey_mprotect arch|cut -d'/' -f 2|sort|uniq)
	alpha arm arm64 ia64 m68k microblaze mips parisc powerpc s390 sh sparc x86 xtensa

So, let's move it to the core book and adjust the links to it
accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/core-api/index.rst                    | 1 +
 Documentation/{x86 => core-api}/protection-keys.rst | 0
 Documentation/x86/index.rst                         | 1 -
 arch/powerpc/Kconfig                                | 2 +-
 arch/x86/Kconfig                                    | 2 +-
 tools/testing/selftests/x86/protection_keys.c       | 2 +-
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/{x86 => core-api}/protection-keys.rst (100%)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index ee1bb8983a88..2466a4c51031 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -34,6 +34,7 @@ Core utilities
    timekeeping
    boot-time-mm
    memory-hotplug
+   protection-keys
 
 
 Interfaces for kernel debugging
diff --git a/Documentation/x86/protection-keys.rst b/Documentation/core-api/protection-keys.rst
similarity index 100%
rename from Documentation/x86/protection-keys.rst
rename to Documentation/core-api/protection-keys.rst
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index ae36fc5fc649..f2de1b2d3ac7 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,7 +19,6 @@ x86-specific Documentation
    tlb
    mtrr
    pat
-   protection-keys
    intel_mpx
    amd-memory-encryption
    pti
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1120ff8ac715..e437aa3e78b4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -898,7 +898,7 @@ config PPC_MEM_KEYS
 	  page-based protections, but without requiring modification of the
 	  page tables when an application changes protection domains.
 
-	  For details, see Documentation/vm/protection-keys.rst
+	  For details, see Documentation/core-api/protection-keys.rst
 
 	  If unsure, say y.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 23de3b9da480..61244bdb886f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1911,7 +1911,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	  page-based protections, but without requiring modification of the
 	  page tables when an application changes protection domains.
 
-	  For details, see Documentation/x86/protection-keys.txt
+	  For details, see Documentation/core-api/protection-keys.rst
 
 	  If unsure, say y.
 
diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 5d546dcdbc80..480995bceefa 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Tests x86 Memory Protection Keys (see Documentation/x86/protection-keys.txt)
+ * Tests x86 Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
  *
  * There are examples in here of:
  *  * how to set protection keys on memory
-- 
2.21.0

