Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8552C37FD95
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhEMSul (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 14:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231825AbhEMSuc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 14:50:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 606436140C;
        Thu, 13 May 2021 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620931762;
        bh=1UVF/wXQw2b4JmjGaOrIwMlsWSm1WSQxxM4QOgqZewc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lV55zjosqpbE1fEmHL8VW9S1ZjfKI7BCiMm4aeeQ61v7CeL7ZO/pnSuaS6s1bU3B4
         rfPtAjMals0P8Mp1lLk5B3qs/NLEUix5WF2kpdrDq8C9Ftw1+XDzV55BYWzQK7Mt49
         8FWd6Mmgio8OhuC5oHSTmZCogEL5pVAmdFUbDqfwjh3WdEJ9lilDlaINMxdGNco9n2
         RML6WG3eGWa3ey1Z1btsCOFpbyCT/8IT78FWvvNFgZPj/Ko6gOXPVCX15AcBFkrB5k
         FmTGko+cMXUe+FO+uYW0ruFUlrtfKnDwtm4gOIqK6S54Z4tSzS7XX5+4YdcEWR5wpG
         vO3BEi9K9BBIA==
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
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
        x86@kernel.org
Subject: [PATCH v19 8/8] secretmem: test: add basic selftest for memfd_secret(2)
Date:   Thu, 13 May 2021 21:47:34 +0300
Message-Id: <20210513184734.29317-9-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513184734.29317-1-rppt@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The test verifies that file descriptor created with memfd_secret does not
allow read/write operations, that secret memory mappings respect
RLIMIT_MEMLOCK and that remote accesses with process_vm_read() and
ptrace() to the secret memory fail.

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
 tools/testing/selftests/vm/.gitignore     |   1 +
 tools/testing/selftests/vm/Makefile       |   3 +-
 tools/testing/selftests/vm/memfd_secret.c | 296 ++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh |  17 ++
 4 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/vm/memfd_secret.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 1f651e85ed60..da92ded5a27c 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -21,5 +21,6 @@ va_128TBswitch
 map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
+memfd_secret
 local_config.*
 split_huge_page_test
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 73e1cc96d7c2..266580ea938c 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -34,6 +34,7 @@ TEST_GEN_FILES += khugepaged
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
+TEST_GEN_FILES += memfd_secret
 TEST_GEN_FILES += mlock-random-test
 TEST_GEN_FILES += mlock2-tests
 TEST_GEN_FILES += mremap_dontunmap
@@ -134,7 +135,7 @@ warn_32bit_failure:
 endif
 endif
 
-$(OUTPUT)/mlock-random-test: LDLIBS += -lcap
+$(OUTPUT)/mlock-random-test $(OUTPUT)/memfd_secret: LDLIBS += -lcap
 
 $(OUTPUT)/gup_test: ../../../../mm/gup_test.h
 
diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
new file mode 100644
index 000000000000..2462f52e9c96
--- /dev/null
+++ b/tools/testing/selftests/vm/memfd_secret.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright IBM Corporation, 2020
+ *
+ * Author: Mike Rapoport <rppt@linux.ibm.com>
+ */
+
+#define _GNU_SOURCE
+#include <sys/uio.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/syscall.h>
+#include <sys/resource.h>
+#include <sys/capability.h>
+
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+
+#include "../kselftest.h"
+
+#define fail(fmt, ...) ksft_test_result_fail(fmt, ##__VA_ARGS__)
+#define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
+#define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
+
+#ifdef __NR_memfd_secret
+
+#define PATTERN	0x55
+
+static const int prot = PROT_READ | PROT_WRITE;
+static const int mode = MAP_SHARED;
+
+static unsigned long page_size;
+static unsigned long mlock_limit_cur;
+static unsigned long mlock_limit_max;
+
+static int memfd_secret(unsigned int flags)
+{
+	return syscall(__NR_memfd_secret, flags);
+}
+
+static void test_file_apis(int fd)
+{
+	char buf[64];
+
+	if ((read(fd, buf, sizeof(buf)) >= 0) ||
+	    (write(fd, buf, sizeof(buf)) >= 0) ||
+	    (pread(fd, buf, sizeof(buf), 0) >= 0) ||
+	    (pwrite(fd, buf, sizeof(buf), 0) >= 0))
+		fail("unexpected file IO\n");
+	else
+		pass("file IO is blocked as expected\n");
+}
+
+static void test_mlock_limit(int fd)
+{
+	size_t len;
+	char *mem;
+
+	len = mlock_limit_cur;
+	mem = mmap(NULL, len, prot, mode, fd, 0);
+	if (mem == MAP_FAILED) {
+		fail("unable to mmap secret memory\n");
+		return;
+	}
+	munmap(mem, len);
+
+	len = mlock_limit_max * 2;
+	mem = mmap(NULL, len, prot, mode, fd, 0);
+	if (mem != MAP_FAILED) {
+		fail("unexpected mlock limit violation\n");
+		munmap(mem, len);
+		return;
+	}
+
+	pass("mlock limit is respected\n");
+}
+
+static void try_process_vm_read(int fd, int pipefd[2])
+{
+	struct iovec liov, riov;
+	char buf[64];
+	char *mem;
+
+	if (read(pipefd[0], &mem, sizeof(mem)) < 0) {
+		fail("pipe write: %s\n", strerror(errno));
+		exit(KSFT_FAIL);
+	}
+
+	liov.iov_len = riov.iov_len = sizeof(buf);
+	liov.iov_base = buf;
+	riov.iov_base = mem;
+
+	if (process_vm_readv(getppid(), &liov, 1, &riov, 1, 0) < 0) {
+		if (errno == ENOSYS)
+			exit(KSFT_SKIP);
+		exit(KSFT_PASS);
+	}
+
+	exit(KSFT_FAIL);
+}
+
+static void try_ptrace(int fd, int pipefd[2])
+{
+	pid_t ppid = getppid();
+	int status;
+	char *mem;
+	long ret;
+
+	if (read(pipefd[0], &mem, sizeof(mem)) < 0) {
+		perror("pipe write");
+		exit(KSFT_FAIL);
+	}
+
+	ret = ptrace(PTRACE_ATTACH, ppid, 0, 0);
+	if (ret) {
+		perror("ptrace_attach");
+		exit(KSFT_FAIL);
+	}
+
+	ret = waitpid(ppid, &status, WUNTRACED);
+	if ((ret != ppid) || !(WIFSTOPPED(status))) {
+		fprintf(stderr, "weird waitppid result %ld stat %x\n",
+			ret, status);
+		exit(KSFT_FAIL);
+	}
+
+	if (ptrace(PTRACE_PEEKDATA, ppid, mem, 0))
+		exit(KSFT_PASS);
+
+	exit(KSFT_FAIL);
+}
+
+static void check_child_status(pid_t pid, const char *name)
+{
+	int status;
+
+	waitpid(pid, &status, 0);
+
+	if (WIFEXITED(status) && WEXITSTATUS(status) == KSFT_SKIP) {
+		skip("%s is not supported\n", name);
+		return;
+	}
+
+	if ((WIFEXITED(status) && WEXITSTATUS(status) == KSFT_PASS) ||
+	    WIFSIGNALED(status)) {
+		pass("%s is blocked as expected\n", name);
+		return;
+	}
+
+	fail("%s: unexpected memory access\n", name);
+}
+
+static void test_remote_access(int fd, const char *name,
+			       void (*func)(int fd, int pipefd[2]))
+{
+	int pipefd[2];
+	pid_t pid;
+	char *mem;
+
+	if (pipe(pipefd)) {
+		fail("pipe failed: %s\n", strerror(errno));
+		return;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		fail("fork failed: %s\n", strerror(errno));
+		return;
+	}
+
+	if (pid == 0) {
+		func(fd, pipefd);
+		return;
+	}
+
+	mem = mmap(NULL, page_size, prot, mode, fd, 0);
+	if (mem == MAP_FAILED) {
+		fail("Unable to mmap secret memory\n");
+		return;
+	}
+
+	ftruncate(fd, page_size);
+	memset(mem, PATTERN, page_size);
+
+	if (write(pipefd[1], &mem, sizeof(mem)) < 0) {
+		fail("pipe write: %s\n", strerror(errno));
+		return;
+	}
+
+	check_child_status(pid, name);
+}
+
+static void test_process_vm_read(int fd)
+{
+	test_remote_access(fd, "process_vm_read", try_process_vm_read);
+}
+
+static void test_ptrace(int fd)
+{
+	test_remote_access(fd, "ptrace", try_ptrace);
+}
+
+static int set_cap_limits(rlim_t max)
+{
+	struct rlimit new;
+	cap_t cap = cap_init();
+
+	new.rlim_cur = max;
+	new.rlim_max = max;
+	if (setrlimit(RLIMIT_MEMLOCK, &new)) {
+		perror("setrlimit() returns error");
+		return -1;
+	}
+
+	/* drop capabilities including CAP_IPC_LOCK */
+	if (cap_set_proc(cap)) {
+		perror("cap_set_proc() returns error");
+		return -2;
+	}
+
+	return 0;
+}
+
+static void prepare(void)
+{
+	struct rlimit rlim;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+	if (!page_size)
+		ksft_exit_fail_msg("Failed to get page size %s\n",
+				   strerror(errno));
+
+	if (getrlimit(RLIMIT_MEMLOCK, &rlim))
+		ksft_exit_fail_msg("Unable to detect mlock limit: %s\n",
+				   strerror(errno));
+
+	mlock_limit_cur = rlim.rlim_cur;
+	mlock_limit_max = rlim.rlim_max;
+
+	printf("page_size: %ld, mlock.soft: %ld, mlock.hard: %ld\n",
+	       page_size, mlock_limit_cur, mlock_limit_max);
+
+	if (page_size > mlock_limit_cur)
+		mlock_limit_cur = page_size;
+	if (page_size > mlock_limit_max)
+		mlock_limit_max = page_size;
+
+	if (set_cap_limits(mlock_limit_max))
+		ksft_exit_fail_msg("Unable to set mlock limit: %s\n",
+				   strerror(errno));
+}
+
+#define NUM_TESTS 4
+
+int main(int argc, char *argv[])
+{
+	int fd;
+
+	prepare();
+
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+
+	fd = memfd_secret(0);
+	if (fd < 0) {
+		if (errno == ENOSYS)
+			ksft_exit_skip("memfd_secret is not supported\n");
+		else
+			ksft_exit_fail_msg("memfd_secret failed: %s\n",
+					   strerror(errno));
+	}
+
+	test_mlock_limit(fd);
+	test_file_apis(fd);
+	test_process_vm_read(fd);
+	test_ptrace(fd);
+
+	close(fd);
+
+	ksft_exit(!ksft_get_fail_cnt());
+}
+
+#else /* __NR_memfd_secret */
+
+int main(int argc, char *argv[])
+{
+	printf("skip: skipping memfd_secret test (missing __NR_memfd_secret)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_memfd_secret */
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index e953f3cd9664..95a67382f132 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -346,4 +346,21 @@ else
 	exitcode=1
 fi
 
+echo "running memfd_secret test"
+echo "------------------------------------"
+./memfd_secret
+ret_val=$?
+
+if [ $ret_val -eq 0 ]; then
+	echo "[PASS]"
+elif [ $ret_val -eq $ksft_skip ]; then
+	echo "[SKIP]"
+	exitcode=$ksft_skip
+else
+	echo "[FAIL]"
+	exitcode=1
+fi
+
+exit $exitcode
+
 exit $exitcode
-- 
2.28.0

