Return-Path: <linux-kselftest+bounces-11606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94A902AA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861611F229B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA614387C;
	Mon, 10 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl/7bxCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654D84E13;
	Mon, 10 Jun 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055211; cv=none; b=INf5ZSf5PrZA+9BTsTNX0pqvYiZ9Y7KeCn0PpOefHx1i6Z5D1Op4MQ7Uik3XSmEWhCWPjRvjSdWAs9+TBQV/FNRHUjz+aaG5ZwosSo7avNry0nFAS0Qgida1VBM9x36RLuZ9K8eanXf4NX+IDurKdWfWj2ORO9jPD/sXIYPLIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055211; c=relaxed/simple;
	bh=3j/bcxcB8UFkGMb3ZxhMLR0kpqs9qfqNcKbYHvdfWBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUJaY7F8FyALdoL5fsE9UkkRg7BrxuWDrfVRxrj6FnNChZSVVnxkzljl7CN9C2ENEaGdx6vrYigolRS1JIBPzMJlSJrrjeCR/qKvLcFAYr69tZrXjZpUhad75YPBP29z4DObeX1K/9EF4FFTa9liiuYzdgJJxtvGQib3A92OJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl/7bxCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB443C2BBFC;
	Mon, 10 Jun 2024 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055210;
	bh=3j/bcxcB8UFkGMb3ZxhMLR0kpqs9qfqNcKbYHvdfWBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nl/7bxCAfBVSlxdb7gguvNsnWbAy6D2tSbhxa2GEflQSSYfMDKGznr2G6gzWZLT85
	 8ZIHXsI7pS4shqswsV/HyTm9a/t74VAnlKY79PvFp4KSBsDt4MVxB+9nMWDXZV5iJn
	 OgDsInwaaAVeyR1bk57wb1BtqyIcc15WRsR12qesld4m2QU3YWtK0/R9nUtEP/h7Ed
	 /Q51b4IjOONiRJtgRXA1hw1m3S6U5wMT8aBFxe4TPZg6A1EPwBo4nBaTgF76xDsupR
	 HlxItfDfANV9HqDNR0cLenkLe8b3O9rWdxUBJhkeQRKO2aK402a1ROrp8mP43xASP6
	 q5M7/OeHW8EKg==
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] kunit: test: Add vm_mmap() allocation resource manager
Date: Mon, 10 Jun 2024 14:33:28 -0700
Message-Id: <20240610213330.1310156-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610213055.it.075-kees@kernel.org>
References: <20240610213055.it.075-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4915; i=kees@kernel.org; h=from:subject; bh=3j/bcxcB8UFkGMb3ZxhMLR0kpqs9qfqNcKbYHvdfWBA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmZ3Ep4UgasirhMPnqsaxGdFvkSE6qf5S1plve0 5PuY+roWKCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZmdxKQAKCRCJcvTf3G3A JteBD/4pMDAha8LKYPiDpIcEnfw7lv1K3ra4B66cx11pqtnsFESynjEtWGHxlyqhgBg6Gs16Xu+ fudiJUEMWEbH0irSGfF6DeXX83sA9pOxorrkKtt/9WvVTVdViPlOLkfUttxGwq7GMRBzelPjMxO YCx9+9cdB1J8yrY6qc4EdLJJUdkFJYaRF9XoRE8NzxwpKXiMNq6m0NHafEQUtBhWLROBuVlWexu 2XE7bNBdZqVaXGt6ulK4Vk5HZ6yotq2cSnaRdj4AsL3DA7ohd50JMwk0hHMKAIeZIkkbf3wYMF8 XZrdwH9JUCbJ3hf8TPKzbzo4CEqfGD0ySKA7hbGP7si+dwHykPmv54ibkCZwhyY7J2Kdo7Xl+OQ mRdRN/O8I8FRGY8BGi6YqUre/vvXxmluzsPS0ocNQa09Yj9TLOEKq0W/125ALr67Nk3WsJgPYkB uTgyYm6zL7n1VGTBBWfYo9CY1bYCzoQgWQ2jXS46oa45fkS5Pv+0+QY+kBGa/XTmi8P+3Loc08K g0RR7jTan6J9euI/pCPU5Z6FMnvpDngzMxarrOy9rk1wfpQBFzbuw3of7K6EdaCteXjAWq4HM9U AhUK/XSPsxMiW7EK5AyNZfhqwLLlDUO98YY0aQuy8IsCnWrhc5VkZ/E8WELOG+zeHhMzDtrk3rE FgikFG5i+5j79kw==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For tests that need to allocate using vm_mmap() (e.g. usercopy and
execve), provide the interface to have the allocation tracked by KUnit
itself. This requires bringing up a placeholder userspace mm.

This combines my earlier attempt at this with Mark Rutland's version[1].

Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/kunit/test.h   |  17 +++++++
 lib/kunit/Makefile     |   1 +
 lib/kunit/user_alloc.c | 111 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 lib/kunit/user_alloc.c

diff --git a/include/kunit/test.h b/include/kunit/test.h
index e32b4cb7afa2..ec61cad6b71d 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -480,6 +480,23 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
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
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 309659a32a78..56dd67dc6e57 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
 					resource.o \
+					user_alloc.o \
 					static_stub.o \
 					string-stream.o \
 					assert.o \
diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
new file mode 100644
index 000000000000..d66f42282f43
--- /dev/null
+++ b/lib/kunit/user_alloc.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit userspace memory allocation resource management.
+ */
+#include <kunit/resource.h>
+#include <kunit/test.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
+
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
+/* Create and attach a new mm if it doesn't already exist. */
+static int kunit_attach_mm(void)
+{
+	struct mm_struct *mm;
+
+	if (current->mm)
+		return 0;
+
+	mm = mm_alloc();
+	if (!mm)
+		return -ENOMEM;
+
+	/* Define the task size. */
+	mm->task_size = TASK_SIZE;
+
+	/* Make sure we can allocate new VMAs. */
+	arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);
+
+	/* Attach the mm. It will be cleaned up when the process dies. */
+	kthread_use_mm(mm);
+
+	return 0;
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
-- 
2.34.1


