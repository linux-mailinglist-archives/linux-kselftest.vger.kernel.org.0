Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D538F21464F
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jul 2020 16:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgGDODN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Jul 2020 10:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgGDODM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Jul 2020 10:03:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376BF21883;
        Sat,  4 Jul 2020 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593871389;
        bh=QbVSl3oLPOXYImHDoGUqheNC6ixh/nQxUqncQKrHdUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7MM4KK/XY/rLpBgDLs24yd08b6v6DAqGqi8TiGqs0dfUMLQzf9BEze8tWV9g49tH
         goFze2nW/zWlkvIHFfPQLviRdwzgjjbf75CgOxqJm5dsRzp2IjifM1uiBThEHBvaT2
         KKU8Ixz1ZJeNbe/t7azgpjzakv/vn4ZlqOPyegpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] selftests: add readfile(2) selftests
Date:   Sat,  4 Jul 2020 16:02:49 +0200
Message-Id: <20200704140250.423345-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704140250.423345-1-gregkh@linuxfoundation.org>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the functionality of readfile(2) in various ways.

Also provide a simple speed test program to benchmark using readfile()
instead of using open()/read()/close().

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/readfile/.gitignore   |   3 +
 tools/testing/selftests/readfile/Makefile     |   7 +
 tools/testing/selftests/readfile/readfile.c   | 285 +++++++++++++++++
 .../selftests/readfile/readfile_speed.c       | 301 ++++++++++++++++++
 5 files changed, 597 insertions(+)
 create mode 100644 tools/testing/selftests/readfile/.gitignore
 create mode 100644 tools/testing/selftests/readfile/Makefile
 create mode 100644 tools/testing/selftests/readfile/readfile.c
 create mode 100644 tools/testing/selftests/readfile/readfile_speed.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..82359233b945 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -46,6 +46,7 @@ TARGETS += ptrace
 TARGETS += openat2
 TARGETS += rseq
 TARGETS += rtc
+TARGETS += readfile
 TARGETS += seccomp
 TARGETS += sigaltstack
 TARGETS += size
diff --git a/tools/testing/selftests/readfile/.gitignore b/tools/testing/selftests/readfile/.gitignore
new file mode 100644
index 000000000000..f0e758d437e4
--- /dev/null
+++ b/tools/testing/selftests/readfile/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+readfile
+readfile_speed
diff --git a/tools/testing/selftests/readfile/Makefile b/tools/testing/selftests/readfile/Makefile
new file mode 100644
index 000000000000..1bf1bdec40f8
--- /dev/null
+++ b/tools/testing/selftests/readfile/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -O2 -Wl,-no-as-needed -Wall
+
+TEST_GEN_PROGS := readfile readfile_speed
+
+include ../lib.mk
diff --git a/tools/testing/selftests/readfile/readfile.c b/tools/testing/selftests/readfile/readfile.c
new file mode 100644
index 000000000000..f0736c6dfa69
--- /dev/null
+++ b/tools/testing/selftests/readfile/readfile.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ * Copyright (c) 2020 The Linux Foundation
+ *
+ * Test the readfile() syscall in various ways.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <string.h>
+#include <syscall.h>
+
+#include "../kselftest.h"
+
+//#ifndef __NR_readfile
+//#define __NR_readfile	-1
+//#endif
+
+#define __NR_readfile	440
+
+#define TEST_FILE1	"/sys/devices/system/cpu/vulnerabilities/meltdown"
+#define TEST_FILE2	"/sys/devices/system/cpu/vulnerabilities/spectre_v1"
+#define TEST_FILE4	"/sys/kernel/debug/usb/devices"
+
+static int sys_readfile(int fd, const char *filename, unsigned char *buffer,
+			size_t bufsize, int flags)
+{
+	return syscall(__NR_readfile, fd, filename, buffer, bufsize, flags);
+}
+
+/*
+ * Test that readfile() is even in the running kernel or not.
+ */
+static void test_readfile_supported(void)
+{
+	const char *proc_map = "/proc/self/maps";
+	unsigned char buffer[10];
+	int retval;
+
+	if (__NR_readfile < 0)
+		ksft_exit_skip("readfile() syscall is not defined for the kernel this test was built against\n");
+
+	/*
+	 * Do a simple test to see if the syscall really is present in the
+	 * running kernel
+	 */
+	retval = sys_readfile(0, proc_map, &buffer[0], sizeof(buffer), 0);
+	if (retval == -1)
+		ksft_exit_skip("readfile() syscall not present on running kernel\n");
+
+	ksft_test_result_pass("readfile() syscall present\n");
+}
+
+/*
+ * Open all files in a specific sysfs directory and read from them
+ *
+ * This tests the "openat" type functionality of opening all files relative to a
+ * directory.  We don't care at the moment about the contents.
+ */
+static void test_sysfs_files(void)
+{
+	static unsigned char buffer[8000];
+	const char *sysfs_dir = "/sys/devices/system/cpu/vulnerabilities/";
+	struct dirent *dirent;
+	DIR *vuln_sysfs_dir;
+	int sysfs_fd;
+	int retval;
+
+	sysfs_fd = open(sysfs_dir, O_PATH | O_DIRECTORY);
+	if (sysfs_fd == -1) {
+		ksft_test_result_skip("unable to open %s directory\n",
+				      sysfs_dir);
+		return;
+	}
+
+	vuln_sysfs_dir = opendir(sysfs_dir);
+	if (!vuln_sysfs_dir) {
+		ksft_test_result_skip("%s unable to be opened, skipping test\n");
+		return;
+	}
+
+	ksft_print_msg("readfile: testing relative path functionality by reading files in %s\n",
+		       sysfs_dir);
+	/* open all sysfs file in this directory and read the whole thing */
+	while ((dirent = readdir(vuln_sysfs_dir))) {
+		/* ignore . and .. */
+		if (strcmp(dirent->d_name, ".") == 0 ||
+		    strcmp(dirent->d_name, "..") == 0)
+			continue;
+
+		retval = sys_readfile(sysfs_fd, dirent->d_name, &buffer[0],
+				      sizeof(buffer), 0);
+
+		if (retval <= 0) {
+			ksft_test_result_fail("readfile(%s) failed with %d\n",
+					      dirent->d_name, retval);
+			goto exit;
+		}
+
+		/* cut off trailing \n character */
+		buffer[retval - 1] = 0x00;
+		ksft_print_msg("    '%s' contains \"%s\"\n", dirent->d_name,
+			       buffer);
+	}
+
+	ksft_test_result_pass("readfile() relative path functionality passed\n");
+
+exit:
+	closedir(vuln_sysfs_dir);
+	close(sysfs_fd);
+}
+
+/* Temporary directory variables */
+static int root_fd;		/* test root directory file handle */
+static char tmpdir[PATH_MAX];
+
+static void setup_tmpdir(void)
+{
+	char *tmpdir_root;
+
+	tmpdir_root = getenv("TMPDIR");
+	if (!tmpdir_root)
+		tmpdir_root = "/tmp";
+
+	snprintf(tmpdir, PATH_MAX, "%s/readfile.XXXXXX", tmpdir_root);
+	if (!mkdtemp(tmpdir)) {
+		ksft_test_result_fail("mkdtemp(%s) failed\n", tmpdir);
+		ksft_exit_fail();
+	}
+
+	root_fd = open(tmpdir, O_PATH | O_DIRECTORY);
+	if (root_fd == -1) {
+		ksft_exit_fail_msg("%s unable to be opened, error = %d\n",
+				   tmpdir, root_fd);
+		ksft_exit_fail();
+	}
+
+	ksft_print_msg("%s created to use for testing\n", tmpdir);
+}
+
+static void teardown_tmpdir(void)
+{
+	int retval;
+
+	close(root_fd);
+
+	retval = rmdir(tmpdir);
+	if (retval) {
+		ksft_exit_fail_msg("%s removed with return value %d\n",
+				   tmpdir, retval);
+		ksft_exit_fail();
+	}
+	ksft_print_msg("%s cleaned up and removed\n", tmpdir);
+
+}
+
+static void test_filesize(size_t size)
+{
+	char filename[PATH_MAX];
+	unsigned char *write_data;
+	unsigned char *read_data;
+	int fd;
+	int retval;
+	size_t i;
+
+	snprintf(filename, PATH_MAX, "size-%ld", size);
+
+	read_data = malloc(size);
+	write_data = malloc(size);
+	if (!read_data || !write_data)
+		ksft_exit_fail_msg("Unable to allocate %ld bytes\n", size);
+
+	fd = openat(root_fd, filename, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+	if (fd < 0)
+		ksft_exit_fail_msg("Unable to create file %s\n", filename);
+
+	ksft_print_msg("%s created\n", filename);
+
+	for (i = 0; i < size; ++i)
+		write_data[i] = (unsigned char)(0xff & i);
+
+	write(fd, write_data, size);
+	close(fd);
+
+	retval = sys_readfile(root_fd, filename, read_data, size, 0);
+
+	if (retval != size) {
+		ksft_test_result_fail("Read %d bytes but wanted to read %ld bytes.\n",
+				      retval, size);
+		goto exit;
+	}
+
+	if (memcmp(read_data, write_data, size) != 0) {
+		ksft_test_result_fail("Read data of buffer size %d did not match written data\n",
+				      size);
+		goto exit;
+	}
+
+	ksft_test_result_pass("readfile() of size %ld succeeded.\n", size);
+
+exit:
+	unlinkat(root_fd, filename, 0);
+	free(write_data);
+	free(read_data);
+}
+
+
+/*
+ * Create a bunch of differently sized files, and verify we read the correct
+ * amount of data from them.
+ */
+static void test_filesizes(void)
+{
+	setup_tmpdir();
+
+	test_filesize(0x10);
+	test_filesize(0x100);
+	test_filesize(0x1000);
+	test_filesize(0x10000);
+	test_filesize(0x100000);
+	test_filesize(0x1000000);
+
+	teardown_tmpdir();
+
+}
+
+static void readfile(const char *filename)
+{
+//	int root_fd;
+	unsigned char buffer[16000];
+	int retval;
+
+	memset(buffer, 0x00, sizeof(buffer));
+
+//	root_fd = open("/", O_DIRECTORY);
+//	if (root_fd == -1)
+//		ksft_exit_fail_msg("error with root_fd\n");
+
+	retval = sys_readfile(root_fd, filename, &buffer[0], sizeof(buffer), 0);
+
+//	close(root_fd);
+
+	if (retval <= 0)
+		ksft_test_result_fail("readfile() test of filename=%s failed with retval %d\n",
+				      filename, retval);
+	else
+		ksft_test_result_pass("readfile() test of filename=%s succeeded with retval=%d\n",
+				      filename, retval);
+//	buffer='%s'\n",
+//	       filename, retval, &buffer[0]);
+
+}
+
+
+int main(int argc, char *argv[])
+{
+	ksft_print_header();
+	ksft_set_plan(10);
+
+	test_readfile_supported();	// 1 test
+
+	test_sysfs_files();		// 1 test
+
+	test_filesizes();		// 6 tests
+
+	setup_tmpdir();
+
+	readfile(TEST_FILE1);
+	readfile(TEST_FILE2);
+//	readfile(TEST_FILE4);
+
+	teardown_tmpdir();
+
+	if (ksft_get_fail_cnt())
+		return ksft_exit_fail();
+
+	return ksft_exit_pass();
+}
+
diff --git a/tools/testing/selftests/readfile/readfile_speed.c b/tools/testing/selftests/readfile/readfile_speed.c
new file mode 100644
index 000000000000..11ca79163131
--- /dev/null
+++ b/tools/testing/selftests/readfile/readfile_speed.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+ * Copyright (c) 2020 The Linux Foundation
+ *
+ * Tiny test program to try to benchmark the speed of the readfile syscall vs.
+ * the open/read/close sequence it can replace.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+/* Default test file if no one wants to pick something else */
+#define DEFAULT_TEST_FILE	"/sys/devices/system/cpu/vulnerabilities/meltdown"
+
+#define DEFAULT_TEST_LOOPS	1000
+
+#define DEFAULT_TEST_TYPE	"both"
+
+/* Max number of bytes that will be read from the file */
+#define TEST_BUFFER_SIZE	10000
+static unsigned char test_buffer[TEST_BUFFER_SIZE];
+
+enum test_type {
+	TEST_READFILE,
+	TEST_OPENREADCLOSE,
+	TEST_BOTH,
+};
+
+/* Find the readfile syscall number */
+//#ifndef __NR_readfile
+//#define __NR_readfile	-1
+//#endif
+#define __NR_readfile	440
+
+static int sys_readfile(int fd, const char *filename, unsigned char *buffer,
+			size_t bufsize, int flags)
+{
+	return syscall(__NR_readfile, fd, filename, buffer, bufsize, flags);
+}
+
+/* Test that readfile() is even in the running kernel or not.  */
+static void test_readfile_supported(void)
+{
+	const char *proc_map = "/proc/self/maps";
+	unsigned char buffer[10];
+	int retval;
+
+	if (__NR_readfile < 0) {
+		fprintf(stderr,
+			"readfile() syscall is not defined for the kernel this test was built against.\n");
+		exit(1);
+	}
+
+	/*
+	 * Do a simple test to see if the syscall really is present in the
+	 * running kernel
+	 */
+	retval = sys_readfile(0, proc_map, &buffer[0], sizeof(buffer), 0);
+	if (retval == -1) {
+		fprintf(stderr,
+			"readfile() syscall not present on running kernel.\n");
+		exit(1);
+	}
+}
+
+static inline long long get_time_ns(void)
+{
+        struct timespec t;
+
+        clock_gettime(CLOCK_MONOTONIC, &t);
+
+        return (long long)t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
+/* taken from all-io.h from util-linux repo */
+static inline ssize_t read_all(int fd, unsigned char *buf, size_t count)
+{
+	ssize_t ret;
+	ssize_t c = 0;
+	int tries = 0;
+
+	while (count > 0) {
+		ret = read(fd, buf, count);
+		if (ret <= 0) {
+			if (ret < 0 && (errno == EAGAIN || errno == EINTR) &&
+			    (tries++ < 5)) {
+				usleep(250000);
+				continue;
+			}
+			return c ? c : -1;
+		}
+		tries = 0;
+		count -= ret;
+		buf += ret;
+		c += ret;
+	}
+	return c;
+}
+
+static int openreadclose(const char *filename, unsigned char *buffer,
+			 size_t bufsize)
+{
+	size_t count;
+	int fd;
+
+	fd = openat(0, filename, O_RDONLY);
+	if (fd < 0) {
+		printf("error opening %s\n", filename);
+		return fd;
+	}
+
+	count = read_all(fd, buffer, bufsize);
+	if (count < 0) {
+		printf("Error %ld reading from %s\n", count, filename);
+	}
+
+	close(fd);
+	return count;
+}
+
+static int run_test(enum test_type test_type, const char *filename)
+{
+	switch (test_type) {
+	case TEST_READFILE:
+		return sys_readfile(0, filename, &test_buffer[0],
+				    TEST_BUFFER_SIZE, O_RDONLY);
+
+	case TEST_OPENREADCLOSE:
+		return openreadclose(filename, &test_buffer[0],
+				     TEST_BUFFER_SIZE);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const char * const test_names[] = {
+	[TEST_READFILE]		= "readfile",
+	[TEST_OPENREADCLOSE]	= "open/read/close",
+};
+
+static int run_test_loop(int loops, enum test_type test_type,
+			 const char *filename)
+{
+	long long time_start;
+	long long time_end;
+	long long time_elapsed;
+	int retval = 0;
+	int i;
+
+	fprintf(stdout,
+		"Running %s test on file %s for %d loops...\n",
+		test_names[test_type], filename, loops);
+
+	/* Fill the cache with one run of the read first */
+	retval = run_test(test_type, filename);
+	if (retval < 0) {
+		fprintf(stderr,
+			"test %s was unable to run with error %d\n",
+			test_names[test_type], retval);
+		return retval;
+	}
+
+	time_start = get_time_ns();
+
+	for (i = 0; i < loops; ++i) {
+		retval = run_test(test_type, filename);
+
+		if (retval < 0) {
+			fprintf(stderr,
+				"test failed on loop %d with error %d\n",
+				i, retval);
+			break;
+		}
+	}
+	time_end = get_time_ns();
+
+	time_elapsed = time_end - time_start;
+
+	fprintf(stdout, "Took %lld ns\n", time_elapsed);
+
+	return retval;
+}
+
+static int do_read_file_test(int loops, enum test_type test_type,
+			     const char *filename)
+{
+	int retval;
+
+	if (test_type == TEST_BOTH) {
+		retval = do_read_file_test(loops, TEST_READFILE, filename);
+		retval = do_read_file_test(loops, TEST_OPENREADCLOSE, filename);
+		return retval;
+	}
+	return run_test_loop(loops, test_type, filename);
+}
+
+static int check_file_present(const char *filename)
+{
+	struct stat sb;
+	int retval;
+
+	retval = stat(filename, &sb);
+	if (retval == -1) {
+		fprintf(stderr,
+			"filename %s is not present\n", filename);
+		return retval;
+	}
+
+	if ((sb.st_mode & S_IFMT) != S_IFREG) {
+		fprintf(stderr,
+			"filename %s must be a real file, not anything else.\n",
+			filename);
+		return -1;
+	}
+	return 0;
+}
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage: %s [options]\n"
+		" -l loops     Number of loops to run the test for.\n"
+		"              default is %d\n"
+		" -t testtype  Test type to run.\n"
+		"              types are: readfile, openreadclose, both\n"
+		"              default is %s\n"
+		" -f filename  Filename to read from, full path, not relative.\n"
+		"              default is %s\n",
+		progname,
+		DEFAULT_TEST_LOOPS, DEFAULT_TEST_TYPE, DEFAULT_TEST_FILE);
+}
+
+int main(int argc, char *argv[])
+{
+	char *progname;
+	char *testtype = DEFAULT_TEST_TYPE;
+	char *filename = DEFAULT_TEST_FILE;
+	int loops = DEFAULT_TEST_LOOPS;
+	enum test_type test_type;
+	int retval;
+	char c;
+
+	progname = strrchr(argv[0], '/');
+	progname = progname ? 1+progname : argv[0];
+
+	while (EOF != (c = getopt(argc, argv, "t:l:f:h"))) {
+		switch (c) {
+		case 'l':
+			loops = atoi(optarg);
+			break;
+
+		case 't':
+			testtype = optarg;
+			break;
+
+		case 'f':
+			filename = optarg;
+			break;
+
+		case 'h':
+			usage(progname);
+			return 0;
+
+		default:
+			usage(progname);
+			return -1;
+		}
+	}
+
+	if (strcmp(testtype, "readfile") == 0)
+		test_type = TEST_READFILE;
+	else if (strcmp(testtype, "openreadclose") == 0)
+		test_type = TEST_OPENREADCLOSE;
+	else if (strcmp(testtype, "both") == 0)
+		test_type = TEST_BOTH;
+	else {
+		usage(progname);
+		return -1;
+	}
+
+	test_readfile_supported();
+
+	retval = check_file_present(filename);
+	if (retval)
+		return retval;
+
+	return do_read_file_test(loops, test_type, filename);
+}
-- 
2.27.0

