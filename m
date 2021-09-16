Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6CB40DED1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240186AbhIPQAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 12:00:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:1706 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240084AbhIPQAk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 12:00:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="244977584"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="244977584"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 08:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="472824281"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by orsmga007.jf.intel.com with ESMTP; 16 Sep 2021 08:59:15 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Dou Shengnan <shengnanx.dou@intel.com>
Subject: [PATCH v3 5/5] selftests/pfru: add test for Platform Firmware Runtime Update and Telemetry
Date:   Fri, 17 Sep 2021 00:04:55 +0800
Message-Id: <80966998ecc8fd7842a7899b4846b23b9b9b76c3.1631802163.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631802162.git.yu.c.chen@intel.com>
References: <cover.1631802162.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a simple test for Platform Firmware Runtime Update and Telemetry
drivers. It is based on ioctl to either update firmware driver or code
injection, and read corresponding PFRU Telemetry log into user space.

For example:

./pfru_test -h
usage: pfru_test [OPTIONS]
 code injection:
  -l, --load
  -s, --stage
  -a, --activate
  -u, --update [stage and activate]
  -q, --query
  -d, --revid update
 telemetry:
  -G, --getloginfo
  -T, --type(0:execution, 1:history)
  -L, --level(0, 1, 2, 4)
  -R, --read
  -D, --revid log

./pfru_test -G
 log_level:4
 log_type:0
 log_revid:2
 max_data_size:65536
 chunk1_size:0
 chunk2_size:1401
 rollover_cnt:0
 reset_cnt:4

./pfru_test -q
 code injection image type:794bf8b2-6e7b-454e-885f-3fb9bb185402
 fw_version:0
 code_rt_version:1
 driver update image type:0e5f0b14-f849-7945-ad81-bc7b6d2bb245
 drv_rt_version:0
 drv_svn:0
 platform id:39214663-b1a8-4eaa-9024-f2bb53ea4723
 oem id:a36db54f-ea2a-e14e-b7c4-b5780e51ba3d

launch the update:
./pfru_test -l yours.cap -u -T 1 -L 4

Tested-by: Dou Shengnan <shengnanx.dou@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v3: No change since v2.
v2: Do not allow non-root user to run this test.
    (Shuah Khan)
    Test runs on platform without pfru_telemetry should skip
    instead of reporting failure/error.
    (Shuah Khan)
    Reuse uapi/linux/pfru.h instead of copying it into
    the test directory.
    (Mike Rapoport)
---
 include/uapi/linux/pfru.h                |   5 +
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/pfru/Makefile    |   7 +
 tools/testing/selftests/pfru/config      |   2 +
 tools/testing/selftests/pfru/pfru_test.c | 328 +++++++++++++++++++++++
 5 files changed, 343 insertions(+)
 create mode 100644 tools/testing/selftests/pfru/Makefile
 create mode 100644 tools/testing/selftests/pfru/config
 create mode 100644 tools/testing/selftests/pfru/pfru_test.c

diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
index b04852602133..c8a98efd5eb6 100644
--- a/include/uapi/linux/pfru.h
+++ b/include/uapi/linux/pfru.h
@@ -8,7 +8,12 @@
 #define __PFRU_H__
 
 #include <linux/ioctl.h>
+#ifdef __KERNEL__
 #include <linux/uuid.h>
+#else
+#include <uuid/uuid.h>
+#include <linux/types.h>
+#endif
 
 #define PFRU_UUID		"ECF9533B-4A3C-4E89-939E-C77112601C6D"
 #define PFRU_CODE_INJ_UUID		"B2F84B79-7B6E-4E45-885F-3FB9BB185402"
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c852eb40c4f7..9f1d7b5ea4a7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -58,6 +58,7 @@ TARGETS += seccomp
 TARGETS += sgx
 TARGETS += sigaltstack
 TARGETS += size
+TARGETS += pfru
 TARGETS += sparc64
 TARGETS += splice
 TARGETS += static_keys
diff --git a/tools/testing/selftests/pfru/Makefile b/tools/testing/selftests/pfru/Makefile
new file mode 100644
index 000000000000..c61916ccf637
--- /dev/null
+++ b/tools/testing/selftests/pfru/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+CFLAGS += -Wall -O2
+LDLIBS := -luuid
+
+TEST_GEN_PROGS := pfru_test
+include ../lib.mk
diff --git a/tools/testing/selftests/pfru/config b/tools/testing/selftests/pfru/config
new file mode 100644
index 000000000000..37f53609acbd
--- /dev/null
+++ b/tools/testing/selftests/pfru/config
@@ -0,0 +1,2 @@
+CONFIG_ACPI_PFRU=m
+CONFIG_ACPI_PFRU_TELEMETRY=m
diff --git a/tools/testing/selftests/pfru/pfru_test.c b/tools/testing/selftests/pfru/pfru_test.c
new file mode 100644
index 000000000000..b3799d73ab1c
--- /dev/null
+++ b/tools/testing/selftests/pfru/pfru_test.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests Runtime Update/Telemetry (see Documentation/x86/pfru_update.rst)
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include "../../../../include/uapi/linux/pfru.h"
+
+#define MAX_LOG_SIZE 65536
+
+char *capsule_name;
+int action, query_cap, log_type, log_level, log_read, log_getinfo,
+	revid, log_revid;
+int set_log_level, set_log_type,
+	set_revid, set_log_revid;
+
+char *progname;
+
+static int valid_log_level(int level)
+{
+	return (level == LOG_ERR) || (level == LOG_WARN) ||
+		(level == LOG_INFO) || (level == LOG_VERB);
+}
+
+static int valid_log_type(int type)
+{
+	return (type == LOG_EXEC_IDX) || (type == LOG_HISTORY_IDX);
+}
+
+static void help(void)
+{
+	fprintf(stderr,
+		"usage: %s [OPTIONS]\n"
+		" code injection:\n"
+		"  -l, --load\n"
+		"  -s, --stage\n"
+		"  -a, --activate\n"
+		"  -u, --update [stage and activate]\n"
+		"  -q, --query\n"
+		"  -d, --revid update\n"
+		" telemetry:\n"
+		"  -G, --getloginfo\n"
+		"  -T, --type(0:execution, 1:history)\n"
+		"  -L, --level(0, 1, 2, 4)\n"
+		"  -R, --read\n"
+		"  -D, --revid log\n",
+		progname);
+}
+
+char *option_string = "l:sauqd:GT:L:RD:h";
+static struct option long_options[] = {
+	{"load", required_argument, 0, 'l'},
+	{"stage", no_argument, 0, 's'},
+	{"activate", no_argument, 0, 'a'},
+	{"update", no_argument, 0, 'u'},
+	{"query", no_argument, 0, 'q'},
+	{"getloginfo", no_argument, 0, 'G'},
+	{"type", required_argument, 0, 'T'},
+	{"level", required_argument, 0, 'L'},
+	{"read", no_argument, 0, 'R'},
+	{"setrev", required_argument, 0, 'd'},
+	{"setrevlog", required_argument, 0, 'D'},
+	{"help", no_argument, 0, 'h'},
+	{}
+};
+
+static void parse_options(int argc, char **argv)
+{
+	char *pathname;
+	int c;
+
+	pathname = strdup(argv[0]);
+	progname = basename(pathname);
+
+	while (1) {
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, option_string,
+				long_options, &option_index);
+		if (c == -1)
+			break;
+		switch (c) {
+		case 'l':
+			capsule_name = optarg;
+			break;
+		case 's':
+			action = 1;
+			break;
+		case 'a':
+			action = 2;
+			break;
+		case 'u':
+			action = 3;
+			break;
+		case 'q':
+			query_cap = 1;
+			break;
+		case 'G':
+			log_getinfo = 1;
+			break;
+		case 'T':
+			log_type = atoi(optarg);
+			set_log_type = 1;
+			break;
+		case 'L':
+			log_level = atoi(optarg);
+			set_log_level = 1;
+			break;
+		case 'R':
+			log_read = 1;
+			break;
+		case 'd':
+			revid = atoi(optarg);
+			set_revid = 1;
+			break;
+		case 'D':
+			log_revid = atoi(optarg);
+			set_log_revid = 1;
+			break;
+		case 'h':
+			help();
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+void print_cap(struct pfru_update_cap_info *cap)
+{
+	char *uuid = malloc(37);
+
+	if (!uuid) {
+		perror("Can not allocate uuid buffer\n");
+		exit(1);
+	}
+	uuid_unparse(cap->code_type, uuid);
+	printf("code injection image type:%s\n", uuid);
+	printf("fw_version:%d\n", cap->fw_version);
+	printf("code_rt_version:%d\n", cap->code_rt_version);
+
+	uuid_unparse(cap->drv_type, uuid);
+	printf("driver update image type:%s\n", uuid);
+	printf("drv_rt_version:%d\n", cap->drv_rt_version);
+	printf("drv_svn:%d\n", cap->drv_svn);
+
+	uuid_unparse(cap->platform_id, uuid);
+	printf("platform id:%s\n", uuid);
+	uuid_unparse(cap->oem_id, uuid);
+	printf("oem id:%s\n", uuid);
+
+	free(uuid);
+}
+
+int main(int argc, char *argv[])
+{
+	int fd_update, fd_log, fd_capsule;
+	struct pfru_telem_data_info data_info;
+	struct pfru_telem_info info;
+	struct pfru_update_cap_info cap;
+	void *addr_map_capsule;
+	struct stat st;
+	char *log_buf;
+	int ret = 0;
+
+	if (getuid() != 0) {
+		printf("Please run the test as root - Exiting.\n");
+		return 1;
+	}
+
+	parse_options(argc, argv);
+
+	fd_update = open("/dev/pfru/update", O_RDWR);
+	if (fd_update < 0) {
+		printf("PFRU device not supported - Quit...\n");
+		return 1;
+	}
+
+	if (query_cap) {
+		ret = read(fd_update, &cap, sizeof(cap));
+		if (ret == -1) {
+			perror("Read error.");
+			return 1;
+		}
+		print_cap(&cap);
+	}
+
+	fd_log = open("/dev/pfru/telemetry", O_RDWR);
+	if (fd_log < 0) {
+		printf("PFRU telemetry not supported. Skip...\n");
+		goto skip_log_set;
+	}
+
+	if (log_getinfo) {
+		ret = ioctl(fd_log, PFRU_LOG_IOC_GET_DATA_INFO, &data_info);
+		if (ret) {
+			perror("Get log data info failed.");
+			return 1;
+		}
+		ret = ioctl(fd_log, PFRU_LOG_IOC_GET_INFO, &info);
+		if (ret) {
+			perror("Get log info failed.");
+			return 1;
+		}
+		printf("log_level:%d\n", info.log_level);
+		printf("log_type:%d\n", info.log_type);
+		printf("log_revid:%d\n", info.log_revid);
+		printf("max_data_size:%d\n", data_info.max_data_size);
+		printf("chunk1_size:%d\n", data_info.chunk1_size);
+		printf("chunk2_size:%d\n", data_info.chunk2_size);
+		printf("rollover_cnt:%d\n", data_info.rollover_cnt);
+		printf("reset_cnt:%d\n", data_info.reset_cnt);
+
+		return 0;
+	}
+
+	info.log_level = -1;
+	info.log_type = -1;
+	info.log_revid = -1;
+
+	if (set_log_level) {
+		if (!valid_log_level(log_level)) {
+			printf("Invalid log level %d\n",
+			       log_level);
+		} else {
+			info.log_level = log_level;
+		}
+	}
+	if (set_log_type) {
+		if (!valid_log_type(log_type)) {
+			printf("Invalid log type %d\n",
+			       log_type);
+		} else {
+			info.log_type = log_type;
+		}
+	}
+	if (set_log_revid) {
+		if (!pfru_valid_revid(log_revid)) {
+			printf("Invalid log revid %d\n",
+			       log_revid);
+		} else {
+			info.log_revid = log_revid;
+		}
+	}
+
+	ret = ioctl(fd_log, PFRU_LOG_IOC_SET_INFO, &info);
+	if (ret) {
+		perror("Log information set failed.(log_level, log_type, log_revid)");
+		return 1;
+	}
+
+skip_log_set:
+	if (set_revid) {
+		ret = ioctl(fd_update, PFRU_IOC_SET_REV, &revid);
+		if (ret) {
+			perror("pfru update revid set failed");
+			return 1;
+		}
+		printf("pfru update revid set to %d\n", revid);
+	}
+
+	if (capsule_name) {
+		fd_capsule = open(capsule_name, O_RDONLY);
+		if (fd_capsule < 0) {
+			perror("Can not open capsule file...");
+			return 1;
+		}
+		if (fstat(fd_capsule, &st) < 0) {
+			perror("Can not fstat capsule file...");
+			return 1;
+		}
+		addr_map_capsule = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED,
+					fd_capsule, 0);
+		if (addr_map_capsule == MAP_FAILED) {
+			perror("Failed to mmap capsule file.");
+			return 1;
+		}
+		ret = write(fd_update, (char *)addr_map_capsule, st.st_size);
+		printf("Load %d bytes of capsule file into the system\n",
+		       ret);
+		if (ret == -1) {
+			perror("Failed to load capsule file");
+			return 1;
+		}
+		munmap(addr_map_capsule, st.st_size);
+		printf("Load done.\n");
+	}
+
+	if (action) {
+		if (action == 1)
+			ret = ioctl(fd_update, PFRU_IOC_STAGE, NULL);
+		else if (action == 2)
+			ret = ioctl(fd_update, PFRU_IOC_ACTIVATE, NULL);
+		else if (action == 3)
+			ret = ioctl(fd_update, PFRU_IOC_STAGE_ACTIVATE, NULL);
+		else
+			return 1;
+		printf("Update finished, return %d\n", ret);
+	}
+
+	if (fd_log > 0 && log_read) {
+		log_buf = malloc(MAX_LOG_SIZE + 1);
+		if (!log_buf) {
+			perror("log_buf allocate failed.");
+			return 1;
+		}
+		ret = read(fd_log, log_buf, MAX_LOG_SIZE);
+		if (ret == -1) {
+			perror("Read error.");
+			return 1;
+		}
+		log_buf[ret] = '\0';
+		printf("%s\n", log_buf);
+		free(log_buf);
+	}
+
+	return 0;
+}
-- 
2.25.1

