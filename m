Return-Path: <linux-kselftest+bounces-46759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02132C94F04
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4B95344E6C
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F074284670;
	Sun, 30 Nov 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgJ9uLCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310027934B;
	Sun, 30 Nov 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764501530; cv=none; b=ph9eDuC9uVJ4HsjG0zO5RhWFBmNDkhqazf0ij6QwKEHA1l1syW3L/xZ4tuNTmSierSYPq54ewlOCXwi5l4xvtvJqf2b15t4Iw+0zWZghiYOb7H0MAXSm8rof8kBRBU4u3Es8UR8V9C/oAABn8IgFkVb1mmQJCOeO25vrxF5IJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764501530; c=relaxed/simple;
	bh=Mv2TNIorv+Vl9StJ3rAHbansoPrEBArJPuXjfAYQx5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVBum5Xw1NXmf9177cJapKTu4ucuf8sotCu/NSZJ2WZ7VLm2K/GZLRSh4JiSpGa16qY+GGLQmMHTNLYsBuvJj4q3b8xJCrWa1o+x/e1bkptz+iGWPW1c2mquSwGvIBwkwYAf8nb4duNhZTR/AHDSd1SgbeDVAWUIk7b+SvtsiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgJ9uLCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C503C4CEF8;
	Sun, 30 Nov 2025 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764501529;
	bh=Mv2TNIorv+Vl9StJ3rAHbansoPrEBArJPuXjfAYQx5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgJ9uLCflbDe4V56Zn+EhA12EOoiQEDWrl58/vwTrn/T4zlaUp6u7U3yzJWKNkAxr
	 IiLbuZjOEiOHf8cf1oxIXvL+mkpo7nuKWwJtUhv6kZ5cCPBvMYAZuwSUksyQEhMRrN
	 ESz3zJM8btnS19tBA/iOaUxlfzXqxaagg/uoN0X+ievjN5jI7dA9P7iL2kAF7WCwT9
	 FaGvriFrMqPQvu/eRl34K8I7AQjTDZ560xypBAsdG7aDOo+PzBJMAPOEbH06BfhH7W
	 F1dhejn+vvbHZdH6tzG3bDJJLAt3vB03eLs3ueip6Ddi1Joqaj0QUxw0NIrBm29sLT
	 7Jk8HEn/9CCPg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/5] KVM: selftests: test userfaultfd minor for guest_memfd
Date: Sun, 30 Nov 2025 13:18:12 +0200
Message-ID: <20251130111812.699259-6-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251130111812.699259-1-rppt@kernel.org>
References: <20251130111812.699259-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikita Kalyazin <kalyazin@amazon.com>

The test demonstrates that a minor userfaultfd event in guest_memfd can
be resolved via a memcpy followed by a UFFDIO_CONTINUE ioctl.

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index e7d9aeb418d3..d0cf57d41cc9 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -10,13 +10,17 @@
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
+#include <pthread.h>
 
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
 #include <linux/sizes.h>
+#include <linux/userfaultfd.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/ioctl.h>
 
 #include "kvm_util.h"
 #include "test_util.h"
@@ -254,6 +258,98 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	}
 }
 
+struct fault_args {
+	char *addr;
+	volatile char value;
+};
+
+static void *fault_thread_fn(void *arg)
+{
+	struct fault_args *args = arg;
+
+	/* Trigger page fault */
+	args->value = *args->addr;
+	return NULL;
+}
+
+static void test_uffd_minor(int fd, size_t total_size)
+{
+	struct uffdio_api uffdio_api = {
+		.api = UFFD_API,
+	};
+	struct uffdio_register uffd_reg;
+	struct uffdio_continue uffd_cont;
+	struct uffd_msg msg;
+	struct fault_args args;
+	pthread_t fault_thread;
+	void *mem, *mem_nofault;
+	int uffd, ret;
+	off_t offset = page_size;
+	void *fault_addr;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC);
+	TEST_ASSERT(uffd != -1, "userfaultfd creation should succeed");
+
+	ret = ioctl(uffd, UFFDIO_API, &uffdio_api);
+	TEST_ASSERT(ret != -1, "ioctl(UFFDIO_API) should succeed");
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
+
+	mem_nofault = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem_nofault != MAP_FAILED, "mmap should succeed");
+
+	uffd_reg.range.start = (unsigned long)mem;
+	uffd_reg.range.len = total_size;
+	uffd_reg.mode = UFFDIO_REGISTER_MODE_MINOR;
+	ret = ioctl(uffd, UFFDIO_REGISTER, &uffd_reg);
+	TEST_ASSERT(ret != -1, "ioctl(UFFDIO_REGISTER) should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			offset, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
+
+	memset(mem_nofault + offset, 0xaa, page_size);
+
+	fault_addr = mem + offset;
+	args.addr = fault_addr;
+
+	ret = pthread_create(&fault_thread, NULL, fault_thread_fn, &args);
+	TEST_ASSERT(ret == 0, "pthread_create should succeed");
+
+	ret = read(uffd, &msg, sizeof(msg));
+	TEST_ASSERT(ret != -1, "read from userfaultfd should succeed");
+	TEST_ASSERT(msg.event == UFFD_EVENT_PAGEFAULT, "event type should be pagefault");
+	TEST_ASSERT((void *)(msg.arg.pagefault.address & ~(page_size - 1)) == fault_addr,
+		    "pagefault should occur at expected address");
+
+
+	uffd_cont.range.start = (unsigned long)fault_addr;
+	uffd_cont.range.len = page_size;
+	uffd_cont.mode = 0;
+	ret = ioctl(uffd, UFFDIO_CONTINUE, &uffd_cont);
+	TEST_ASSERT(ret != -1, "ioctl(UFFDIO_CONTINUE) should succeed");
+
+	/*
+	 * wait for fault_thread to finish to make sure fault happened and was
+	 * resolved before we verify the values
+	 */
+	ret = pthread_join(fault_thread, NULL);
+	TEST_ASSERT(ret == 0, "pthread_join should succeed");
+
+	TEST_ASSERT(args.value == *(char *)(mem_nofault + offset),
+		    "memory should contain the value that was copied");
+	TEST_ASSERT(args.value == *(char *)(mem + offset),
+		    "no further fault is expected");
+
+	ret = munmap(mem_nofault, total_size);
+	TEST_ASSERT(!ret, "munmap should succeed");
+
+	ret = munmap(mem, total_size);
+	TEST_ASSERT(!ret, "munmap should succeed");
+	close(uffd);
+}
+
 #define gmem_test(__test, __vm, __flags)				\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, page_size * 4, __flags);	\
@@ -273,6 +369,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
 		if (flags & GUEST_MEMFD_FLAG_INIT_SHARED) {
 			gmem_test(mmap_supported, vm, flags);
 			gmem_test(fault_overflow, vm, flags);
+			gmem_test(uffd_minor, vm, flags);
 		} else {
 			gmem_test(fault_private, vm, flags);
 		}
-- 
2.51.0


