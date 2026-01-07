Return-Path: <linux-kselftest+bounces-48387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C717DCFCE63
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 393A930028BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB033074B1;
	Wed,  7 Jan 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2hhQb4o5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1F304BBF;
	Wed,  7 Jan 2026 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777974; cv=none; b=hMq6yjWbSSqWqx0x9sQich4FZTeGYS9q+qfd0o5gjWEsgV7kS2a1BgD8HAcNGC24qQGm9NZopdPEpveJx9copzdwTPOejLZZvw/JtO9gvmbGJYLhqCxH5X5D+hK/AtldeypBnDl82tyi/uN8eR/fRb/XQfeRvoqlHP7dTJFViPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777974; c=relaxed/simple;
	bh=c9JKDW3Cofq0rhFW3oNbtqWRo1B48DbDp00ms5FAjIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKQMNPFZNE+fpQ60worm0UVVefMvvr9Y6QPnxhBEUmx1/49AuuewLDJNfAD/DkQfrSaJcamhLVYAa4vQpkDpl9HcWuK/MDlM/pIuSppvl0cVyOLl9kyA7xJEGH4XVyMh6k3sgeD05pbvYkm6uXfsw/OmRWU5F12oG7ZwgaYUwGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2hhQb4o5; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wx0hAerQEel3FrgFH6XRLyBNvwoIyfSZ5/JucRZrZR8=;
	b=2hhQb4o5kIjNsiqNSPcBHeubnG9DXvx6EmzFYEheaehplYKrt+3mEwp8LE11x4NU1VNoeBOgU
	wD5kT3m0SxKiGHEuocMt2pQp61frC3yJtTy1/+e3+UpGfPGqdfmNZLce3vz4edx189fmPTu0Jg4
	mAVVQc9+Mjv+LLgep58PAEk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dmMyN2HF6zKm6k;
	Wed,  7 Jan 2026 17:22:52 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6703D40565;
	Wed,  7 Jan 2026 17:26:08 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 17:26:08 +0800
Received: from huawei.com (10.173.125.37) by kwepemq500010.china.huawei.com
 (7.202.194.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Jan
 2026 17:26:07 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <shuah@kernel.org>
CC: <david@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <nao.horiguchi@gmail.com>,
	<linmiaohe@huawei.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH 1/3] selftests/mm: add memory failure anonymous page test
Date: Wed, 7 Jan 2026 17:37:08 +0800
Message-ID: <20260107093710.3928374-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260107093710.3928374-1-linmiaohe@huawei.com>
References: <20260107093710.3928374-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

This patch adds a new kselftest to validate memory failure handling for
anonymous pages. The test performs the following operations:
1. Allocates anonymous pages using mmap().
2. Injects memory failure via madvise syscall.
3. Verifies expected error handling behavior.
4. Unpoison memory.

This test helps ensure that memory failure handling for anonymous pages
works correctly, including proper SIGBUS delivery to user processes, page
isolation and recovery paths.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 MAINTAINERS                                 |   1 +
 tools/testing/selftests/mm/.gitignore       |   1 +
 tools/testing/selftests/mm/Makefile         |   1 +
 tools/testing/selftests/mm/memory-failure.c | 239 ++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh   |  21 ++
 tools/testing/selftests/mm/vm_util.c        |  41 ++++
 tools/testing/selftests/mm/vm_util.h        |   3 +
 7 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/mm/memory-failure.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..3401b408a07e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11683,6 +11683,7 @@ F:	include/linux/memory-failure.h
 F:	include/trace/events/memory-failure.h
 F:	mm/hwpoison-inject.c
 F:	mm/memory-failure.c
+F:	tools/testing/selftests/mm/memory-failure.c
 
 HYCON HY46XX TOUCHSCREEN SUPPORT
 M:	Giulio Benetti <giulio.benetti@benettiengineering.com>
diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index c2a8586e51a1..83ad9454dd9d 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -12,6 +12,7 @@ map_hugetlb
 map_populate
 thuge-gen
 compaction_test
+memory-failure
 migration
 mlock2-tests
 mrelease_test
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eaf9312097f7..9495f7594e28 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -75,6 +75,7 @@ TEST_GEN_FILES += map_populate
 ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
 TEST_GEN_FILES += memfd_secret
 endif
+TEST_GEN_FILES += memory-failure
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mkdirty
 TEST_GEN_FILES += mlock-random-test
diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/selftests/mm/memory-failure.c
new file mode 100644
index 000000000000..37806a58f4b4
--- /dev/null
+++ b/tools/testing/selftests/mm/memory-failure.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory-failure functional tests.
+ *
+ * Author(s): Miaohe Lin <linmiaohe@huawei.com>
+ */
+
+#include "../kselftest_harness.h"
+
+#include <sys/mman.h>
+#include <linux/mman.h>
+#include <linux/string.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "vm_util.h"
+
+enum inject_type {
+	MADV_HARD,
+	MADV_SOFT,
+};
+
+enum result_type {
+	MADV_HARD_ANON,
+	MADV_SOFT_ANON,
+};
+
+static jmp_buf signal_jmp_buf;
+static siginfo_t siginfo;
+const char *pagemap_proc = "/proc/self/pagemap";
+const char *kpageflags_proc = "/proc/kpageflags";
+
+FIXTURE(memory_failure)
+{
+	unsigned long page_size;
+	unsigned long corrupted_size;
+	unsigned long pfn;
+	int pagemap_fd;
+	int kpageflags_fd;
+	bool triggered;
+};
+
+FIXTURE_VARIANT(memory_failure)
+{
+	enum inject_type type;
+	int (*inject)(FIXTURE_DATA(memory_failure) * self, void *vaddr);
+};
+
+static int madv_hard_inject(FIXTURE_DATA(memory_failure) * self, void *vaddr)
+{
+	return madvise(vaddr, self->page_size, MADV_HWPOISON);
+}
+
+FIXTURE_VARIANT_ADD(memory_failure, madv_hard)
+{
+	.type = MADV_HARD,
+	.inject = madv_hard_inject,
+};
+
+static int madv_soft_inject(FIXTURE_DATA(memory_failure) * self, void *vaddr)
+{
+	return madvise(vaddr, self->page_size, MADV_SOFT_OFFLINE);
+}
+
+FIXTURE_VARIANT_ADD(memory_failure, madv_soft)
+{
+	.type = MADV_SOFT,
+	.inject = madv_soft_inject,
+};
+
+static void sigbus_action(int signo, siginfo_t *si, void *args)
+{
+	memcpy(&siginfo, si, sizeof(siginfo_t));
+	siglongjmp(signal_jmp_buf, 1);
+}
+
+static int setup_sighandler(void)
+{
+	struct sigaction sa = {
+		.sa_sigaction = sigbus_action,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	return sigaction(SIGBUS, &sa, NULL);
+}
+
+FIXTURE_SETUP(memory_failure)
+{
+	memset(self, 0, sizeof(*self));
+
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+
+	memset(&siginfo, 0, sizeof(siginfo));
+	if (setup_sighandler())
+		SKIP(return, "setup sighandler failed.\n");
+
+	self->pagemap_fd = open(pagemap_proc, O_RDONLY);
+	if (self->pagemap_fd == -1)
+		SKIP(return, "open %s failed.\n", pagemap_proc);
+
+	self->kpageflags_fd = open(kpageflags_proc, O_RDONLY);
+	if (self->kpageflags_fd == -1)
+		SKIP(return, "open %s failed.\n", kpageflags_proc);
+}
+
+static void teardown_sighandler(void)
+{
+	struct sigaction sa = {
+		.sa_handler = SIG_DFL,
+		.sa_flags = SA_SIGINFO,
+	};
+
+	sigaction(SIGBUS, &sa, NULL);
+}
+
+FIXTURE_TEARDOWN(memory_failure)
+{
+	close(self->kpageflags_fd);
+	close(self->pagemap_fd);
+	teardown_sighandler();
+}
+
+static void prepare(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure) * self,
+		    void *vaddr)
+{
+	self->pfn = pagemap_get_pfn(self->pagemap_fd, vaddr);
+	ASSERT_NE(self->pfn, -1UL);
+
+	ASSERT_EQ(get_hardware_corrupted_size(&self->corrupted_size), 0);
+}
+
+static bool check_memory(void *vaddr, unsigned long size)
+{
+	char buf[64];
+
+	memset(buf, 0xce, sizeof(buf));
+	while (size >= sizeof(buf)) {
+		if (memcmp(vaddr, buf, sizeof(buf)))
+			return false;
+		size -= sizeof(buf);
+		vaddr += sizeof(buf);
+	}
+
+	return true;
+}
+
+static void check(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure) * self,
+		  void *vaddr, enum result_type type, int setjmp)
+{
+	unsigned long size;
+	uint64_t pfn_flags;
+
+	switch (type) {
+	case MADV_SOFT_ANON:
+		/* It is not expected to receive a SIGBUS signal. */
+		ASSERT_EQ(setjmp, 0);
+
+		/* The page content should remain unchanged. */
+		ASSERT_TRUE(check_memory(vaddr, self->page_size));
+
+		/* The backing pfn of addr should have changed. */
+		ASSERT_NE(pagemap_get_pfn(self->pagemap_fd, vaddr), self->pfn);
+		break;
+	case MADV_HARD_ANON:
+		/* The SIGBUS signal should have been received. */
+		ASSERT_EQ(setjmp, 1);
+
+		/* Check if siginfo contains correct SIGBUS context. */
+		ASSERT_EQ(siginfo.si_signo, SIGBUS);
+		ASSERT_EQ(siginfo.si_code, BUS_MCEERR_AR);
+		ASSERT_EQ(1UL << siginfo.si_addr_lsb, self->page_size);
+		ASSERT_EQ(siginfo.si_addr, vaddr);
+
+		/* XXX Check backing pte is hwpoison entry when supported. */
+		ASSERT_TRUE(pagemap_is_swapped(self->pagemap_fd, vaddr));
+		break;
+	default:
+		SKIP(return, "unexpected inject type %d.\n", type);
+	}
+
+	/* Check if the value of HardwareCorrupted has increased. */
+	ASSERT_EQ(get_hardware_corrupted_size(&size), 0);
+	ASSERT_EQ(size, self->corrupted_size + self->page_size / 1024);
+
+	/* Check if HWPoison flag is set. */
+	ASSERT_EQ(pageflags_get(self->pfn, self->kpageflags_fd, &pfn_flags), 0);
+	ASSERT_EQ(pfn_flags & KPF_HWPOISON, KPF_HWPOISON);
+}
+
+static void cleanup(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure) * self,
+		    void *vaddr)
+{
+	unsigned long size;
+	uint64_t pfn_flags;
+
+	ASSERT_EQ(unpoison_memory(self->pfn), 0);
+
+	/* Check if HWPoison flag is cleared. */
+	ASSERT_EQ(pageflags_get(self->pfn, self->kpageflags_fd, &pfn_flags), 0);
+	ASSERT_NE(pfn_flags & KPF_HWPOISON, KPF_HWPOISON);
+
+	/* Check if the value of HardwareCorrupted has decreased. */
+	ASSERT_EQ(get_hardware_corrupted_size(&size), 0);
+	ASSERT_EQ(size, self->corrupted_size);
+}
+
+TEST_F(memory_failure, anon)
+{
+	char *addr;
+	int ret;
+
+	addr = mmap(0, self->page_size, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (addr == MAP_FAILED)
+		SKIP(return, "mmap failed, not enough memory.\n");
+	memset(addr, 0xce, self->page_size);
+
+	prepare(_metadata, self, addr);
+
+	ret = sigsetjmp(signal_jmp_buf, 1);
+	if (!self->triggered) {
+		self->triggered = true;
+		ASSERT_EQ(variant->inject(self, addr), 0);
+		FORCE_READ(*addr);
+	}
+
+	if (variant->type == MADV_HARD)
+		check(_metadata, self, addr, MADV_HARD_ANON, ret);
+	else
+		check(_metadata, self, addr, MADV_SOFT_ANON, ret);
+
+	cleanup(_metadata, self, addr);
+
+	ASSERT_EQ(munmap(addr, self->page_size), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 2dadbfc6e535..043ac00a98b8 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -87,6 +87,8 @@ separated by spaces:
 	test VMA merge cases behave as expected
 - rmap
 	test rmap behaves as expected
+- memory-failure
+	test memory-failure behaves as expected
 
 example: ./run_vmtests.sh -t "hmm mmap ksm"
 EOF
@@ -535,6 +537,25 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
 
 CATEGORY="rmap" run_test ./rmap
 
+# Try to load hwpoison_inject if not present.
+HWPOISON_DIR=/sys/kernel/debug/hwpoison/
+if [ ! -d "$HWPOISON_DIR" ]; then
+	if ! modprobe -q -R hwpoison_inject; then
+		echo "Module hwpoison_inject not found, skipping..."
+	else
+		modprobe hwpoison_inject > /dev/null 2>&1
+		LOADED_MOD=1
+	fi
+fi
+
+if [ -d "$HWPOISON_DIR" ]; then
+	CATEGORY="memory-failure" run_test ./memory-failure
+fi
+
+if [ -n "${LOADED_MOD}" ]; then
+	modprobe -r hwpoison_inject > /dev/null 2>&1
+fi
+
 if [ "${HAVE_HUGEPAGES}" = 1 ]; then
 	echo "$orig_nr_hugepgs" > /proc/sys/vm/nr_hugepages
 fi
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index d954bf91afd5..a6d4ff7dfdc0 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -723,3 +723,44 @@ int ksm_stop(void)
 	close(ksm_fd);
 	return ret == 1 ? 0 : -errno;
 }
+
+int get_hardware_corrupted_size(unsigned long *val)
+{
+	unsigned long size;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+	int ret = -1;
+
+	if (!f)
+		return ret;
+
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "HardwareCorrupted: %12lu kB", &size) == 1) {
+			*val = size;
+			ret = 0;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return ret;
+}
+
+int unpoison_memory(unsigned long pfn)
+{
+	int unpoison_fd, len;
+	char buf[32];
+	ssize_t ret;
+
+	unpoison_fd = open("/sys/kernel/debug/hwpoison/unpoison-pfn", O_WRONLY);
+	if (unpoison_fd < 0)
+		return -errno;
+
+	len = sprintf(buf, "0x%lx\n", pfn);
+	ret = write(unpoison_fd, buf, len);
+	close(unpoison_fd);
+
+	return ret > 0 ? 0 : -errno;
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 6ad32b1830f1..b0c4ea994082 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -20,6 +20,7 @@
 
 #define KPF_COMPOUND_HEAD             BIT_ULL(15)
 #define KPF_COMPOUND_TAIL             BIT_ULL(16)
+#define KPF_HWPOISON                  BIT_ULL(19)
 #define KPF_THP                       BIT_ULL(22)
 /*
  * Ignore the checkpatch warning, we must read from x but don't want to do
@@ -147,6 +148,8 @@ long ksm_get_full_scans(void);
 int ksm_use_zero_pages(void);
 int ksm_start(void);
 int ksm_stop(void);
+int get_hardware_corrupted_size(unsigned long *val);
+int unpoison_memory(unsigned long pfn);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.33.0


