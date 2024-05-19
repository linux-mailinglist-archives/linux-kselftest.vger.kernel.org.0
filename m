Return-Path: <linux-kselftest+bounces-10382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1AD8C9600
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 21:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150A41F2122B
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A37172F;
	Sun, 19 May 2024 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k57TD1iS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BAA6F09C
	for <linux-kselftest@vger.kernel.org>; Sun, 19 May 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145978; cv=none; b=f8pGJPBjv5x5pDgVHnftPfIn0MSXqStu6AgFm33hSSFfRZE4ZcDI7oZqlJbtI4H3X86f7FPZTc++xOPC1E+RXUxqzqfAZHZSDbPQnL+3mxeM+OKUWk3RARMKvY2rB8NciKQMro7mNIlQGdNPeNGEKsGcXChMhnmb2mjsa+klIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145978; c=relaxed/simple;
	bh=wNgy2pm8z4ldp8MuPhDft19azofrU0oPWpTD6QjozZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTUWamlVNfevdNKqRDUmUKeNHtVVzE2rzhZ6oCURcLiEA0vdoVqs/3NnvWPTxzTH5TPCEpDKPXgMdzPu182etDm6bROg0bcN1PVs1quiCBfq4XTP9QcVEUJURrs0QHM5g4vRqH41Sa6XyMPk+Dn95ZaX66yPY4m8V64xoZblNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k57TD1iS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee5235f5c9so53098525ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 19 May 2024 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716145976; x=1716750776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3OtVtNf5ShWXj1bE7269UiIDqXp6vnkrO47qSa2kQQ=;
        b=k57TD1iShxFnfC2pp8NYHPv0zxZ/Iwfy7yN1pt6fWUamOPDLQolO1/3FcnzUCzp3LB
         OtW3grJTjC++3uwKsKo5TOjM0S87Ir/Ot1ycwFSgUMYkfZ4Uvn5Fg5QAkl6f2/OW0D8T
         sjgNZyaEOEhN3J71zlhlhGAB7MnwpprIdWF7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716145976; x=1716750776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3OtVtNf5ShWXj1bE7269UiIDqXp6vnkrO47qSa2kQQ=;
        b=buS36lsIZgr91iNoRfmfk6FTqIoeBlBti3bEVysZFK74SRWz/Y/LOreg5Rvz/Ie3Ld
         BIiC9G9dK8TJNg4KOpKcEUSYy0NkRZ4YfS3k5jaX+fqkXSleFDEOs0tRpYPovdqflSBh
         5sn+0PoaqL72FSfUGtF+rmJBMeo0YNC7+j1wTEdvI4Jckcjo3QtBe+2p1zRcOrNdzc2l
         5BhFGRFRSYqfJKB1fzVj8CWi3jyjVczm8mjWeiz4yTt6r04UnO2aqbbPO/dfdqdI8hGb
         2Zl3Et/K4oG058p+IMvlGxNaAiiqXOE5o+3R7M9chkPYBkjAqXQ0hlknorYYRG4Q8pgF
         tM2g==
X-Forwarded-Encrypted: i=1; AJvYcCXhe7g6qjGz4KQmkl56Dg0G1BSvd2P2tjjDVbXreG7+pqcCFNvTQYmhLNiBAabzzN0cvKICHsxZRk4NyzwzgOsUJqQUmsSNHryx38vfJqyd
X-Gm-Message-State: AOJu0Yw6N+Nk78nEYL3zYjxdrukfvQb9sjaHDX56iC1Rgf/YRmoTYHtE
	fdfTuaCnKXrF0OAoCAUrgn92Jv8VANdTCoVdRSPvMCp6nO7jmYPheNQXdBPtQg==
X-Google-Smtp-Source: AGHT+IGiYr538O9UKfOPaoY+s/1NgBFP0a25H/jEh33Z7W757D3GovSMVXgJ6TnDZca13cnwDJNhhQ==
X-Received: by 2002:a17:903:2b07:b0:1f0:9aca:97b9 with SMTP id d9443c01a7336-1f09acaa30fmr121431235ad.68.1716145976075;
        Sun, 19 May 2024 12:12:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d16f2sm188855635ad.41.2024.05.19.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 12:12:55 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] kunit: test: Add vm_mmap() allocation resource manager
Date: Sun, 19 May 2024 12:12:52 -0700
Message-Id: <20240519191254.651865-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240519190422.work.715-kees@kernel.org>
References: <20240519190422.work.715-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5613; i=keescook@chromium.org;
 h=from:subject; bh=wNgy2pm8z4ldp8MuPhDft19azofrU0oPWpTD6QjozZ8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSk81T50rcpAOSlXL8bkcrTI2RR0tm5BAlNK8R
 nb+OGPQ79WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkpPNQAKCRCJcvTf3G3A
 JjxFD/4iRIjfhVQa49n95Z2UAyf3e2Lfrswbx6Upw/fDRLSG4t8nNL3GIgdSQsX5z+KBR9b60V7
 NHB11FzIrEz+3X/R1yyXhKOEqxuqUpYxFpZrKrMq+2nHE31wQCla7dm4bUr8ElF0Se3hhfH36Y2
 V1tJGteFBLk9R92hEn585x+9T7x+ccGGxXe1NCiQAxEFVx/W+4pv2Z9AZqHz3g5nhpDOCd+w3Oz
 4GgxYARWnJmm8++UZWpJnUMSjqT+1IgJiI/x9IpBPLTUhnFMxJ6lY+oNDyC4hAo65Onn8QHF5VV
 dpvwU/51JWdFElHHSE/O/BHJ18cmjrjn3/A8KB2NcPS0VO8kSIhdZdHPGkrWh5auZlKkAf5ts5h
 couc3iroXRwVk0eVeZ7U79OP6uSCwazjFIZwg4k05VMb96HlDy6jE3SAwRl1H3MT/XnrEhnTGjV
 C2o2MVd6BijHfJThjFmZAV3CozFe/JbrrLcqZf+How73xxhNFaJpUev+VYrLcJrI7FjLlpL4vqq
 aBfrxx9ubpcxw0cYZBMOWLR/K4J9+OdwsYsiNN6mmOBgLPRwmjXyqZZkPLi5dui0tA56L1T67Em
 1tlDtSzaKYrxCATVeS6jZV43HFP6vXKMRVY1sIgsw82D/3iF1wOJBKpRbv+xxFSWIujmRB9Vrke wPLV3zAgTzm0YDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For tests that need to allocate using vm_mmap() (e.g. usercopy and
execve), provide the interface to have the allocation tracked by KUnit
itself. This requires bringing up a placeholder userspace mm.

This combines my earlier attempt at this with Mark Rutland's version[1].

Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/kunit/test.h |  17 ++++++
 lib/kunit/test.c     | 139 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 61637ef32302..8c3835a6f282 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -478,6 +478,23 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
 	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
 }
 
+/**
+ * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
+ * @test: The test context object.
+ * @file: struct file pointer to map from, if any
+ * @addr: desired address, if any
+ * @len: how many bytes to allocate
+ * @prot: mmap PROT_* bits
+ * @flag: mmap flags
+ * @offset: offset into @file to start mapping from.
+ *
+ * See vm_mmap() for more information.
+ */
+unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
+			    unsigned long addr, unsigned long len,
+			    unsigned long prot, unsigned long flag,
+			    unsigned long offset);
+
 void kunit_cleanup(struct kunit *test);
 
 void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 1d1475578515..09194dbffb63 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,13 +11,14 @@
 #include <kunit/test-bug.h>
 #include <kunit/attributes.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
-#include <linux/mm.h>
 
 #include "debugfs.h"
 #include "device-impl.h"
@@ -871,6 +872,142 @@ void kunit_kfree(struct kunit *test, const void *ptr)
 }
 EXPORT_SYMBOL_GPL(kunit_kfree);
 
+struct kunit_vm_mmap_resource {
+	unsigned long addr;
+	size_t size;
+};
+
+/* vm_mmap() arguments */
+struct kunit_vm_mmap_params {
+	struct file *file;
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flag;
+	unsigned long offset;
+};
+
+/*
+ * Arbitrarily chosen user address for the base allocation.
+ */
+#define UBUF_ADDR_BASE	SZ_2M
+
+/* Create and attach a new mm if it doesn't already exist. */
+static int kunit_attach_mm(void)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+
+	if (current->mm)
+		return 0;
+
+	mm = mm_alloc();
+	if (!mm)
+		return -ENOMEM;
+
+	if (mmap_write_lock_killable(mm))
+		goto out_free;
+
+	/* Define the task size. */
+	mm->task_size = TASK_SIZE;
+
+	/* Prepare the base VMA. */
+	vma = vm_area_alloc(mm);
+	if (!vma)
+		goto out_unlock;
+
+	vma_set_anonymous(vma);
+	vma->vm_start = UBUF_ADDR_BASE;
+	vma->vm_end = UBUF_ADDR_BASE + PAGE_SIZE;
+	vm_flags_init(vma, VM_READ | VM_MAYREAD | VM_WRITE | VM_MAYWRITE);
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	if (insert_vm_struct(mm, vma))
+		goto out_free_vma;
+
+	mmap_write_unlock(mm);
+
+	/* Make sure we can allocate new VMAs. */
+	arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);
+
+	/* Attach the mm. It will be cleaned up when the process dies. */
+	kthread_use_mm(mm);
+
+	return 0;
+
+out_free_vma:
+	vm_area_free(vma);
+out_unlock:
+	mmap_write_unlock(mm);
+out_free:
+	mmput(mm);
+	return -ENOMEM;
+}
+
+static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_vm_mmap_params *p = context;
+	struct kunit_vm_mmap_resource vres;
+	int ret;
+
+	ret = kunit_attach_mm();
+	if (ret)
+		return ret;
+
+	vres.size = p->len;
+	vres.addr = vm_mmap(p->file, p->addr, p->len, p->prot, p->flag, p->offset);
+	if (!vres.addr)
+		return -ENOMEM;
+	res->data = kmemdup(&vres, sizeof(vres), GFP_KERNEL);
+	if (!res->data) {
+		vm_munmap(vres.addr, vres.size);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void kunit_vm_mmap_free(struct kunit_resource *res)
+{
+	struct kunit_vm_mmap_resource *vres = res->data;
+
+	/*
+	 * Since this is executed from the test monitoring process,
+	 * the test's mm has already been torn down. We don't need
+	 * to run vm_munmap(vres->addr, vres->size), only clean up
+	 * the vres.
+	 */
+
+	kfree(vres);
+	res->data = NULL;
+}
+
+unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
+			    unsigned long addr, unsigned long len,
+			    unsigned long prot, unsigned long flag,
+			    unsigned long offset)
+{
+	struct kunit_vm_mmap_params params = {
+		.file = file,
+		.addr = addr,
+		.len = len,
+		.prot = prot,
+		.flag = flag,
+		.offset = offset,
+	};
+	struct kunit_vm_mmap_resource *vres;
+
+	vres = kunit_alloc_resource(test,
+				    kunit_vm_mmap_init,
+				    kunit_vm_mmap_free,
+				    GFP_KERNEL,
+				    &params);
+	if (vres)
+		return vres->addr;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kunit_vm_mmap);
+
 void kunit_cleanup(struct kunit *test)
 {
 	struct kunit_resource *res;
-- 
2.34.1


