Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8B332C8D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Mar 2021 02:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhCDA5w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 19:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346279AbhCCQ0Q (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Mar 2021 11:26:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB23664ED7;
        Wed,  3 Mar 2021 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614788628;
        bh=xidrDhecGP6CNp1WbvEb+2by3BdO1w+m3Yqw9X4ZQKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNtqLs272LmTWPImnmDa7KBFiBC4TQdgRv5ieOdhPBuHU24cUpJwgDIVa9ImRcXt3
         +D2Xxn5mu/dwiyPTikLZ5WG4U7s65gMHWJykrawzmFFidQhAKbnweVAqzciIBa39AD
         bYPlnC3hRVLouSLXMvsRBKwz0Iy7A/ijcH2oe23eJvFvszDee+tjwhIi2+bKWMlQzU
         YOHSBPEQ8gSb/pzaj9f9YN3GFKIay3FczR7H8ummNW0+C1JuKXErey1KetJ+dkH9cX
         kE+eqSxeOTl8oCNXuoIFCC7JHT245VfX3hHSy/RQvhEbT9h6U1em9Nr+1+X3euExO5
         DuFp/dFKedl7g==
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
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v18 7/9] PM: hibernate: disable when there are active secretmem users
Date:   Wed,  3 Mar 2021 18:22:07 +0200
Message-Id: <20210303162209.8609-8-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210303162209.8609-1-rppt@kernel.org>
References: <20210303162209.8609-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

It is unsafe to allow saving of secretmem areas to the hibernation
snapshot as they would be visible after the resume and this essentially
will defeat the purpose of secret memory mappings.

Prevent hibernation whenever there are active secret memory users.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christopher Lameter <cl@linux.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Bottomley <jejb@linux.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/secretmem.h |  6 ++++++
 kernel/power/hibernate.c  |  5 ++++-
 mm/secretmem.c            | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 70e7db9f94fe..907a6734059c 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -6,6 +6,7 @@
 
 bool vma_is_secretmem(struct vm_area_struct *vma);
 bool page_is_secretmem(struct page *page);
+bool secretmem_active(void);
 
 #else
 
@@ -19,6 +20,11 @@ static inline bool page_is_secretmem(struct page *page)
 	return false;
 }
 
+static inline bool secretmem_active(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SECRETMEM */
 
 #endif /* _LINUX_SECRETMEM_H */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index da0b41914177..559acef3fddb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -31,6 +31,7 @@
 #include <linux/genhd.h>
 #include <linux/ktime.h>
 #include <linux/security.h>
+#include <linux/secretmem.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -81,7 +82,9 @@ void hibernate_release(void)
 
 bool hibernation_available(void)
 {
-	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
+	return nohibernate == 0 &&
+		!security_locked_down(LOCKDOWN_HIBERNATION) &&
+		!secretmem_active();
 }
 
 /**
diff --git a/mm/secretmem.c b/mm/secretmem.c
index fa6738e860c2..f2ae3f32a193 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -40,6 +40,13 @@ module_param_named(enable, secretmem_enable, bool, 0400);
 MODULE_PARM_DESC(secretmem_enable,
 		 "Enable secretmem and memfd_secret(2) system call");
 
+static atomic_t secretmem_users;
+
+bool secretmem_active(void)
+{
+	return !!atomic_read(&secretmem_users);
+}
+
 static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -94,6 +101,12 @@ static const struct vm_operations_struct secretmem_vm_ops = {
 	.fault = secretmem_fault,
 };
 
+static int secretmem_release(struct inode *inode, struct file *file)
+{
+	atomic_dec(&secretmem_users);
+	return 0;
+}
+
 static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long len = vma->vm_end - vma->vm_start;
@@ -116,6 +129,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 }
 
 static const struct file_operations secretmem_fops = {
+	.release	= secretmem_release,
 	.mmap		= secretmem_mmap,
 };
 
@@ -212,6 +226,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned long, flags)
 	file->f_flags |= O_LARGEFILE;
 
 	fd_install(fd, file);
+	atomic_inc(&secretmem_users);
 	return fd;
 
 err_put_fd:
-- 
2.28.0

