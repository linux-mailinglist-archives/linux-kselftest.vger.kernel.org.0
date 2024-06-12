Return-Path: <linux-kselftest+bounces-11794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9BB905C67
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169C31F23FB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7A284A24;
	Wed, 12 Jun 2024 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKl3kZhV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1F74079;
	Wed, 12 Jun 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222362; cv=none; b=DqAAZQz1Qc1mYVGm51YNP1UotiOa7qvDdQ9XvqnjefkQGJwpb78LWsCa1eoeAOrq1/WqfYfbc0k2SzIrIpAAJ9LYMa0u90du2/QRGWC5dHYZ1Is4ENM1NZjtKQv6DUCuCQbtTMu8cyIUbH81KQKPNp5aTClGtzJqD0T6MVA8pOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222362; c=relaxed/simple;
	bh=gQgeucopIFvRVCQF4ceGCKz1t07xM+X5iOVy95uccjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xq3qTG63iGEVzTKdP1ewrZeI4yLiBWtkgF9M1dKL9rwY6z/1Zz5AG7eDIxo6bit/QJbspoJn8e1wZSqhM8TUCFUgdSTVULHdqo9NjLt72hImuD9dw9XjT4dvq+1FRhGCPcdzGGHNMGb3sjM3eDqRgfBIadTTTN+dvfMGUg4QP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKl3kZhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4C6C116B1;
	Wed, 12 Jun 2024 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718222361;
	bh=gQgeucopIFvRVCQF4ceGCKz1t07xM+X5iOVy95uccjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKl3kZhVXMEQWk0rL50H9tF9IHBSDs+fVjhQGW42FbfODB+S0naJePqfsW5g7/JKi
	 VW8qY4iWOxDWAA5QnfkkREieUYrzxqXE77QyKX0iojrJNDQGOcGKl68fFgI4Vh6ukF
	 4CaYm+uxvFkwsm4nxLSS+Qhh7C+TyqB4b5CsmuF/wZa+BiatUAh0czyLOjiBincA6N
	 bLCeTRRYhcIA2cqDB4lXjSLVD1Ceij3661JndLj5NLxcRgUPfy+JKtgdGmonMNqvYs
	 LBvD6hGiD88HFRJ1FdXClG3OJInsk0yBKJZCAs4dOsabQPB/omhR0l4+rJCWxwXSM1
	 JvUbwOSO76ceA==
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	David Gow <davidgow@google.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/2] kunit: test: Add vm_mmap() allocation resource manager
Date: Wed, 12 Jun 2024 12:59:18 -0700
Message-Id: <20240612195921.2685842-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612195412.make.760-kees@kernel.org>
References: <20240612195412.make.760-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6270; i=kees@kernel.org; h=from:subject; bh=gQgeucopIFvRVCQF4ceGCKz1t07xM+X5iOVy95uccjk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmaf4XuIRCT8NnVJGnJWFziMecus/DIzUDHhQ+G 38BprOXOvaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZmn+FwAKCRCJcvTf3G3A Jtn6D/46Rfh4zJS6vBl7xbJXDk3oIL0oWLD+jfCBA3u4l4U0xMMqvSfXhDEntBmnPiDgQVi9Bcs 6ErHoErU3Ee1//9FRYsHYIG285IeqLcZ6JZvDJRJ0m5F7mv11KOjHB0y1E5uYxzwh3TgwUdJ0ra 4lrMXY111Ef3HauaCUNGu/yVbA+N9G+reZg+gASME9zM93mCCj6OnHRqx5CJoSxIIRCfwZRGHlR ZKPKWb7BYsLMV2Lml8bXu7bldKw0g4ucfH98xq46UjJ19wYrZVtwXuLMPhtcW2kgTEC5qaSgxuY MaEUTI2BZnwvLW6RCqfDzmOA5wfYZTc8/isVHZ3zYN0Q5fY1ZGFDoe+EUvv+YNMakIBcluxPyMS J6fCueMJp2Cn+eiJuS53dlTMJEEVFw94GYZpNITJgtt5uoVSrSBwiApSb37CrUKG0/G/Xi6lrZA 3b0KPzD6MXYMSnncMS2K5wYxrBw1oAHkVPY6GegE8rpecm4XjTASULxDkcd3wDjGIvNSffD5Z79 r8UXvyxrnyV2Z8Y+dpzVKiHcSeJNbmezVH8Zrptyx592nPhi2sM8927u7lOzlmiyMgpgkYFPexF 2NMBoZGrI3GMJwyw7LUPTBcUGwGJTJP7+StB8+lda45BmLS27DbobzDnfhhQIn1RWssnmQc7xNM gqwuj7BSWlNuZPA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For tests that need to allocate using vm_mmap() (e.g. usercopy and
execve), provide the interface to have the allocation tracked by KUnit
itself. This requires bringing up a placeholder userspace mm.

This combines my earlier attempt at this with Mark Rutland's version[1].

Normally alloc_mm() and arch_pick_mmap_layout() aren't exported for
modules, so export these only for KUnit testing.

Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/kunit/test.h   |  17 +++++++
 kernel/fork.c          |   3 ++
 lib/kunit/Makefile     |   1 +
 lib/kunit/user_alloc.c | 113 +++++++++++++++++++++++++++++++++++++++++
 mm/util.c              |   3 ++
 5 files changed, 137 insertions(+)
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
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..cea203197136 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -115,6 +115,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>
 
+#include <kunit/visibility.h>
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -1334,6 +1336,7 @@ struct mm_struct *mm_alloc(void)
 	memset(mm, 0, sizeof(*mm));
 	return mm_init(mm, current, current_user_ns());
 }
+EXPORT_SYMBOL_IF_KUNIT(mm_alloc);
 
 static inline void __mmput(struct mm_struct *mm)
 {
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
index 000000000000..76d3d1345ed7
--- /dev/null
+++ b/lib/kunit/user_alloc.c
@@ -0,0 +1,113 @@
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
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..df37c47d9374 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -26,6 +26,8 @@
 
 #include <linux/uaccess.h>
 
+#include <kunit/visibility.h>
+
 #include "internal.h"
 #include "swap.h"
 
@@ -482,6 +484,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	clear_bit(MMF_TOPDOWN, &mm->flags);
 }
 #endif
+EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
 
 /**
  * __account_locked_vm - account locked pages to an mm's locked_vm
-- 
2.34.1


