Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3663D64B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jul 2021 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbhGZQAq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 12:00:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3496 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbhGZQAW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 12:00:22 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GYQNZ2fZLz6L9lV;
        Tue, 27 Jul 2021 00:29:02 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 18:40:48 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 12/12] diglim: Tests
Date:   Mon, 26 Jul 2021 18:37:00 +0200
Message-ID: <20210726163700.2092768-13-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726163700.2092768-1-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a number of tests to ensure that DIGLIM works as expected:

- digest_list_add_del_test_file_upload;
- digest_list_add_del_test_file_upload_fault;
- digest_list_add_del_test_buffer_upload;
- digest_list_add_del_test_buffer_upload_fault;
- digest_list_fuzzing_test;
- digest_list_add_del_test_file_upload_measured;
- digest_list_check_measurement_list_test_file_upload;
- digest_list_check_measurement_list_test_buffer_upload.

The tests are in tools/testing/selftests/diglim/selftest.c.

A description of the tests can be found in
Documentation/security/diglim/tests.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/diglim/index.rst   |    1 +
 Documentation/security/diglim/tests.rst   |   66 +
 MAINTAINERS                               |    2 +
 tools/testing/selftests/Makefile          |    1 +
 tools/testing/selftests/diglim/Makefile   |   19 +
 tools/testing/selftests/diglim/common.c   |  115 ++
 tools/testing/selftests/diglim/common.h   |   31 +
 tools/testing/selftests/diglim/config     |    3 +
 tools/testing/selftests/diglim/selftest.c | 1382 +++++++++++++++++++++
 9 files changed, 1620 insertions(+)
 create mode 100644 Documentation/security/diglim/tests.rst
 create mode 100644 tools/testing/selftests/diglim/Makefile
 create mode 100644 tools/testing/selftests/diglim/common.c
 create mode 100644 tools/testing/selftests/diglim/common.h
 create mode 100644 tools/testing/selftests/diglim/config
 create mode 100644 tools/testing/selftests/diglim/selftest.c

diff --git a/Documentation/security/diglim/index.rst b/Documentation/security/diglim/index.rst
index 0f28c5ad71c0..d4ba4ce50a59 100644
--- a/Documentation/security/diglim/index.rst
+++ b/Documentation/security/diglim/index.rst
@@ -11,3 +11,4 @@ Digest Lists Integrity Module (DIGLIM)
    architecture
    implementation
    remote_attestation
+   tests
diff --git a/Documentation/security/diglim/tests.rst b/Documentation/security/diglim/tests.rst
new file mode 100644
index 000000000000..d58ddbaeeb55
--- /dev/null
+++ b/Documentation/security/diglim/tests.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Testing
+=======
+
+This section introduces a number of tests to ensure that DIGLIM works as
+expected:
+
+- ``digest_list_add_del_test_file_upload``;
+- ``digest_list_add_del_test_file_upload_fault``;
+- ``digest_list_add_del_test_buffer_upload``;
+- ``digest_list_add_del_test_buffer_upload_fault``;
+- ``digest_list_fuzzing_test``;
+- ``digest_list_add_del_test_file_upload_measured``;
+- ``digest_list_check_measurement_list_test_file_upload``;
+- ``digest_list_check_measurement_list_test_buffer_upload``.
+
+The tests are in ``tools/testing/selftests/diglim/selftest.c``.
+
+The first four tests randomly perform add, delete and query of digest
+lists. They internally keep track at any time of the digest lists that are
+currently uploaded to the kernel.
+
+Also, digest lists are generated randomly by selecting an arbitrary digest
+algorithm and an arbitrary number of digests. To ensure a good number of
+collisions, digests are a sequence of zeros, except for the first four
+bytes that are set with a random number within a defined range.
+
+When a query operation is selected, a digest is chosen by getting another
+random number within the same range. Then, the tests count how many times
+the digest is found in the internally stored digest lists and in the query
+result obtained from the kernel. The tests are successful if the obtained
+numbers are the same.
+
+The ``file_upload`` variant creates a temporary file from a generated
+digest list and sends its path to the kernel, so that the file is uploaded.
+The ``buffer_upload`` variant directly sends the digest list buffer to the
+kernel (it will be done by the user space parser after it converts a digest
+list not in the compact format).
+
+The ``fault`` variant performs the test by enabling the ad-hoc fault
+injection mechanism in the kernel (accessible through
+``<debugfs>/fail_diglim``). The fault injection mechanism randomly injects
+errors during the addition and deletion of digest lists. When an error
+occurs, the rollback mechanism performs the reverse operation until the
+point the error occurred, so that the kernel is left in the same state as
+when the requested operation began. Since the kernel returns the error to
+user space, the tests also know that the operation didn't succeed and
+behave accordingly (they also revert the internal state).
+
+The fuzzing test simply sends randomly generated digest lists to the
+kernel, to ensure that the parser is robust enough to handle malformed
+data.
+
+The ``measured`` variant of the ``digest_list_add_del_test`` series checks
+whether the digest lists actions are properly set after adding an IMA rule
+to measure the digest lists.
+
+The ``digest_list_check_measurement_list_test`` tests verify the remote
+attestation functionality. They verify whether IMA creates a measurement
+entry for each addition and deletion of a digest list, and that the
+deletion is forbidden if IMA created a measurement entry only for the
+addition.
+
+The ``file_upload`` variant uploads a file, while the ``buffer_upload``
+variant uploads a buffer.
diff --git a/MAINTAINERS b/MAINTAINERS
index a7c502685109..e63061e63363 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5462,12 +5462,14 @@ F:	Documentation/security/diglim/implementation.rst
 F:	Documentation/security/diglim/index.rst
 F:	Documentation/security/diglim/introduction.rst
 F:	Documentation/security/diglim/remote_attestation.rst
+F:	Documentation/security/diglim/tests.rst
 F:	include/linux/diglim.h
 F:	include/uapi/linux/diglim.h
 F:	security/integrity/diglim/diglim.h
 F:	security/integrity/diglim/fs.c
 F:	security/integrity/diglim/methods.c
 F:	security/integrity/diglim/parser.c
+F:	tools/testing/selftests/diglim/
 
 DIOLAN U2C-12 I2C DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index fb010a35d61a..37460b308e07 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -8,6 +8,7 @@ TARGETS += clone3
 TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
+TARGETS += diglim
 TARGETS += drivers/dma-buf
 TARGETS += efivarfs
 TARGETS += exec
diff --git a/tools/testing/selftests/diglim/Makefile b/tools/testing/selftests/diglim/Makefile
new file mode 100644
index 000000000000..100c219955d7
--- /dev/null
+++ b/tools/testing/selftests/diglim/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+LDFLAGS += -lcrypto
+
+CFLAGS += -O2 -Wall -Wl,-no-as-needed -g -I./ -I../../../../usr/include/ \
+	  -L$(OUTPUT) -Wl,-rpath=./ -ggdb
+LDLIBS += -lpthread
+
+OVERRIDE_TARGETS = 1
+
+TEST_GEN_PROGS = selftest
+TEST_GEN_PROGS_EXTENDED = libcommon.so
+
+include ../lib.mk
+
+$(OUTPUT)/libcommon.so: common.c
+	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
+
+$(OUTPUT)/selftest: selftest.c $(TEST_GEN_PROGS_EXTENDED)
+	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS) -lcommon
diff --git a/tools/testing/selftests/diglim/common.c b/tools/testing/selftests/diglim/common.c
new file mode 100644
index 000000000000..88ff48fed308
--- /dev/null
+++ b/tools/testing/selftests/diglim/common.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Common functions.
+ */
+
+#include <sys/random.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/hash_info.h>
+
+#include "common.h"
+
+int write_buffer(char *path, char *buffer, size_t buffer_len, int uid)
+{
+	ssize_t to_write = buffer_len, written = 0;
+	int ret = 0, ret_seteuid, fd, cur_uid = geteuid();
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (uid >= 0) {
+		ret_seteuid = seteuid(uid);
+		if (ret_seteuid < 0)
+			return ret_seteuid;
+	}
+
+	while (to_write) {
+		written = write(fd, buffer + buffer_len - to_write, to_write);
+		if (written <= 0) {
+			ret = -errno;
+			break;
+		}
+
+		to_write -= written;
+	}
+
+	if (uid >= 0) {
+		ret_seteuid = seteuid(cur_uid);
+		if (ret_seteuid < 0)
+			return ret_seteuid;
+	}
+
+	close(fd);
+	return ret;
+}
+
+int read_buffer(char *path, char **buffer, size_t *buffer_len, bool alloc,
+		bool is_char)
+{
+	ssize_t len = 0, read_len;
+	int ret = 0, fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (alloc) {
+		*buffer = NULL;
+		*buffer_len = 0;
+	}
+
+	while (1) {
+		if (alloc) {
+			if (*buffer_len == len) {
+				*buffer_len += BUFFER_SIZE;
+				*buffer = realloc(*buffer, *buffer_len + 1);
+				if (!*buffer) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
+		}
+
+		read_len = read(fd, *buffer + len, *buffer_len - len);
+		if (read_len < 0) {
+			ret = -errno;
+			goto out;
+		}
+
+		if (!read_len)
+			break;
+
+		len += read_len;
+	}
+
+	*buffer_len = len;
+	if (is_char)
+		(*buffer)[(*buffer_len)++] = '\0';
+out:
+	close(fd);
+	if (ret < 0) {
+		if (alloc) {
+			free(*buffer);
+			*buffer = NULL;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/diglim/common.h b/tools/testing/selftests/diglim/common.h
new file mode 100644
index 000000000000..d3e5808c06e8
--- /dev/null
+++ b/tools/testing/selftests/diglim/common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header of common.c
+ */
+
+#include <sys/random.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/hash_info.h>
+
+#define BUFFER_SIZE 1024
+
+int write_buffer(char *path, char *buffer, size_t buffer_len, int uid);
+int read_buffer(char *path, char **buffer, size_t *buffer_len, bool alloc,
+		bool is_char);
diff --git a/tools/testing/selftests/diglim/config b/tools/testing/selftests/diglim/config
new file mode 100644
index 000000000000..faafc742974c
--- /dev/null
+++ b/tools/testing/selftests/diglim/config
@@ -0,0 +1,3 @@
+CONFIG_DIGEST_LISTS=y
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
diff --git a/tools/testing/selftests/diglim/selftest.c b/tools/testing/selftests/diglim/selftest.c
new file mode 100644
index 000000000000..efcd83409b39
--- /dev/null
+++ b/tools/testing/selftests/diglim/selftest.c
@@ -0,0 +1,1382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2005,2006,2007,2008 IBM Corporation
+ * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Functions to test DIGLIM.
+ */
+
+#include <sys/random.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <string.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <linux/types.h>
+#include <linux/hash_info.h>
+#include <linux/diglim.h>
+
+#include <openssl/evp.h>
+
+#include "common.h"
+#include "../kselftest_harness.h"
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+typedef uint64_t u64;
+
+#define MD5_DIGEST_SIZE 16
+#define SHA1_DIGEST_SIZE 20
+#define RMD160_DIGEST_SIZE 20
+#define SHA256_DIGEST_SIZE 32
+#define SHA384_DIGEST_SIZE 48
+#define SHA512_DIGEST_SIZE 64
+#define SHA224_DIGEST_SIZE 28
+#define RMD128_DIGEST_SIZE 16
+#define RMD256_DIGEST_SIZE 32
+#define RMD320_DIGEST_SIZE 40
+#define WP256_DIGEST_SIZE 32
+#define WP384_DIGEST_SIZE 48
+#define WP512_DIGEST_SIZE 64
+#define TGR128_DIGEST_SIZE 16
+#define TGR160_DIGEST_SIZE 20
+#define TGR192_DIGEST_SIZE 24
+#define SM3256_DIGEST_SIZE 32
+#define STREEBOG256_DIGEST_SIZE 32
+#define STREEBOG512_DIGEST_SIZE 64
+
+#define DIGEST_LIST_PATH_TEMPLATE "/tmp/digest_list.XXXXXX"
+
+#define INTEGRITY_DIR "/sys/kernel/security/integrity"
+
+#define DIGEST_LIST_DIR INTEGRITY_DIR "/diglim"
+#define DIGEST_QUERY_PATH DIGEST_LIST_DIR "/digest_query"
+#define DIGEST_LABEL_PATH DIGEST_LIST_DIR "/digest_label"
+#define DIGEST_LIST_ADD_PATH DIGEST_LIST_DIR "/digest_list_add"
+#define DIGEST_LIST_DEL_PATH DIGEST_LIST_DIR "/digest_list_del"
+#define DIGEST_LISTS_LOADED_PATH DIGEST_LIST_DIR "/digest_lists_loaded"
+#define DIGESTS_COUNT DIGEST_LIST_DIR "/digests_count"
+
+#define IMA_POLICY_PATH INTEGRITY_DIR "/ima/policy"
+#define IMA_MEASUREMENTS_PATH INTEGRITY_DIR "/ima/ascii_runtime_measurements"
+
+#define DIGEST_LIST_DEBUGFS_DIR "/sys/kernel/debug/fail_diglim"
+#define DIGEST_LIST_DEBUGFS_TASK_FILTER DIGEST_LIST_DEBUGFS_DIR "/task-filter"
+#define DIGEST_LIST_DEBUGFS_PROBABILITY DIGEST_LIST_DEBUGFS_DIR "/probability"
+#define DIGEST_LIST_DEBUGFS_TIMES DIGEST_LIST_DEBUGFS_DIR "/times"
+#define DIGEST_LIST_DEBUGFS_VERBOSE DIGEST_LIST_DEBUGFS_DIR "/verbose"
+#define PROCFS_SELF_FAULT "/proc/self/make-it-fail"
+
+#define MAX_LINE_LENGTH 512
+#define LABEL_LEN 32
+#define MAX_DIGEST_COUNT 100
+#define MAX_DIGEST_LISTS 100
+#define MAX_DIGEST_BLOCKS 10
+#define MAX_DIGEST_VALUE 10
+#define MAX_SEARCH_ATTEMPTS 10
+#define NUM_QUERIES 1000
+#define MAX_DIGEST_LIST_SIZE 10000
+#define NUM_ITERATIONS 100000
+
+enum upload_types { UPLOAD_FILE, UPLOAD_BUFFER };
+
+const char *const hash_algo_name[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]		= "md4",
+	[HASH_ALGO_MD5]		= "md5",
+	[HASH_ALGO_SHA1]	= "sha1",
+	[HASH_ALGO_RIPE_MD_160]	= "rmd160",
+	[HASH_ALGO_SHA256]	= "sha256",
+	[HASH_ALGO_SHA384]	= "sha384",
+	[HASH_ALGO_SHA512]	= "sha512",
+	[HASH_ALGO_SHA224]	= "sha224",
+	[HASH_ALGO_RIPE_MD_128]	= "rmd128",
+	[HASH_ALGO_RIPE_MD_256]	= "rmd256",
+	[HASH_ALGO_RIPE_MD_320]	= "rmd320",
+	[HASH_ALGO_WP_256]	= "wp256",
+	[HASH_ALGO_WP_384]	= "wp384",
+	[HASH_ALGO_WP_512]	= "wp512",
+	[HASH_ALGO_TGR_128]	= "tgr128",
+	[HASH_ALGO_TGR_160]	= "tgr160",
+	[HASH_ALGO_TGR_192]	= "tgr192",
+	[HASH_ALGO_SM3_256]	= "sm3",
+	[HASH_ALGO_STREEBOG_256] = "streebog256",
+	[HASH_ALGO_STREEBOG_512] = "streebog512",
+};
+
+const int hash_digest_size[HASH_ALGO__LAST] = {
+	[HASH_ALGO_MD4]		= MD5_DIGEST_SIZE,
+	[HASH_ALGO_MD5]		= MD5_DIGEST_SIZE,
+	[HASH_ALGO_SHA1]	= SHA1_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_160]	= RMD160_DIGEST_SIZE,
+	[HASH_ALGO_SHA256]	= SHA256_DIGEST_SIZE,
+	[HASH_ALGO_SHA384]	= SHA384_DIGEST_SIZE,
+	[HASH_ALGO_SHA512]	= SHA512_DIGEST_SIZE,
+	[HASH_ALGO_SHA224]	= SHA224_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_128]	= RMD128_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_256]	= RMD256_DIGEST_SIZE,
+	[HASH_ALGO_RIPE_MD_320]	= RMD320_DIGEST_SIZE,
+	[HASH_ALGO_WP_256]	= WP256_DIGEST_SIZE,
+	[HASH_ALGO_WP_384]	= WP384_DIGEST_SIZE,
+	[HASH_ALGO_WP_512]	= WP512_DIGEST_SIZE,
+	[HASH_ALGO_TGR_128]	= TGR128_DIGEST_SIZE,
+	[HASH_ALGO_TGR_160]	= TGR160_DIGEST_SIZE,
+	[HASH_ALGO_TGR_192]	= TGR192_DIGEST_SIZE,
+	[HASH_ALGO_SM3_256]	= SM3256_DIGEST_SIZE,
+	[HASH_ALGO_STREEBOG_256] = STREEBOG256_DIGEST_SIZE,
+	[HASH_ALGO_STREEBOG_512] = STREEBOG512_DIGEST_SIZE,
+};
+
+struct digest_list_item {
+	unsigned long long size;
+	u8 *buf;
+	u8 actions;
+	char digest_str[64 * 2 + 1];
+	enum hash_algo algo;
+	char filename_suffix[6 + 1];
+};
+
+static const char hex_asc[] = "0123456789abcdef";
+
+#define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
+#define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
+
+static inline char *hex_byte_pack(char *buf, unsigned char byte)
+{
+	*buf++ = hex_asc_hi(byte);
+	*buf++ = hex_asc_lo(byte);
+	return buf;
+}
+
+/* from lib/hexdump.c (Linux kernel) */
+static int hex_to_bin(char ch)
+{
+	if ((ch >= '0') && (ch <= '9'))
+		return ch - '0';
+	ch = tolower(ch);
+	if ((ch >= 'a') && (ch <= 'f'))
+		return ch - 'a' + 10;
+	return -1;
+}
+
+int _hex2bin(unsigned char *dst, const char *src, size_t count)
+{
+	while (count--) {
+		int hi = hex_to_bin(*src++);
+		int lo = hex_to_bin(*src++);
+
+		if ((hi < 0) || (lo < 0))
+			return -1;
+
+		*dst++ = (hi << 4) | lo;
+	}
+	return 0;
+}
+
+char *_bin2hex(char *dst, const void *src, size_t count)
+{
+	const unsigned char *_src = src;
+
+	while (count--)
+		dst = hex_byte_pack(dst, *_src++);
+	return dst;
+}
+
+u32 num_max_digest_lists = MAX_DIGEST_LISTS;
+u32 digest_lists_pos;
+struct digest_list_item *digest_lists[MAX_DIGEST_LISTS];
+
+enum hash_algo ima_hash_algo = HASH_ALGO__LAST;
+
+static enum hash_algo get_ima_hash_algo(void)
+{
+	char *measurement_list, *measurement_list_ptr;
+	size_t measurement_list_len;
+	int ret, i = 0;
+
+	if (ima_hash_algo != HASH_ALGO__LAST)
+		return ima_hash_algo;
+
+	ret = read_buffer(IMA_MEASUREMENTS_PATH, &measurement_list,
+			  &measurement_list_len, true, true);
+	if (ret < 0)
+		return HASH_ALGO_SHA256;
+
+	measurement_list_ptr = measurement_list;
+	while ((strsep(&measurement_list_ptr, " ")) && i++ < 2)
+		;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++) {
+		if (!strncmp(hash_algo_name[i], measurement_list_ptr,
+			     strlen(hash_algo_name[i]))) {
+			ima_hash_algo = i;
+			break;
+		}
+	}
+
+	free(measurement_list);
+	return ima_hash_algo;
+}
+
+int calc_digest(u8 *digest, void *data, u64 len, enum hash_algo algo)
+{
+	EVP_MD_CTX *mdctx;
+	const EVP_MD *md;
+	int ret = -EINVAL;
+
+	OpenSSL_add_all_algorithms();
+
+	md = EVP_get_digestbyname(hash_algo_name[algo]);
+	if (!md)
+		goto out;
+
+	mdctx = EVP_MD_CTX_create();
+	if (!mdctx)
+		goto out;
+
+	if (EVP_DigestInit_ex(mdctx, md, NULL) != 1)
+		goto out_mdctx;
+
+	if (EVP_DigestUpdate(mdctx, data, len) != 1)
+		goto out_mdctx;
+
+	if (EVP_DigestFinal_ex(mdctx, digest, NULL) != 1)
+		goto out_mdctx;
+
+	ret = 0;
+out_mdctx:
+	EVP_MD_CTX_destroy(mdctx);
+out:
+	EVP_cleanup();
+	return ret;
+}
+
+int calc_file_digest(u8 *digest, char *path, enum hash_algo algo)
+{
+	void *data = MAP_FAILED;
+	struct stat st;
+	int fd, ret = 0;
+
+	if (stat(path, &st) == -1)
+		return -EACCES;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (st.st_size) {
+		data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (data == MAP_FAILED) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = calc_digest(digest, data, st.st_size, algo);
+out:
+	if (data != MAP_FAILED)
+		munmap(data, st.st_size);
+
+	close(fd);
+	return ret;
+}
+
+static struct digest_list_item *digest_list_generate(void)
+{
+	struct digest_list_item *digest_list;
+	struct compact_list_hdr *hdr_array = NULL;
+	u8 *buf_ptr;
+	u32 num_digest_blocks = 0;
+	u8 digest[64];
+	int ret, i, j;
+
+	digest_list = calloc(1, sizeof(*digest_list));
+	if (!digest_list)
+		return NULL;
+
+	while (!num_digest_blocks) {
+		ret = getrandom(&num_digest_blocks,
+				sizeof(num_digest_blocks), 0);
+		if (ret < 0)
+			goto out;
+
+		num_digest_blocks = num_digest_blocks % MAX_DIGEST_BLOCKS;
+	}
+
+	hdr_array = calloc(num_digest_blocks, sizeof(*hdr_array));
+	if (!hdr_array)
+		goto out;
+
+	for (i = 0; i < num_digest_blocks; i++) {
+		ret = getrandom(&hdr_array[i], sizeof(hdr_array[i]), 0);
+		if (ret < 0)
+			goto out;
+
+		hdr_array[i].version = 1;
+		hdr_array[i]._reserved = 0;
+		/* COMPACT_DIGEST_LIST type is not allowed. */
+		hdr_array[i].type = hdr_array[i].type % (COMPACT__LAST - 1);
+		hdr_array[i].modifiers =
+		    hdr_array[i].modifiers % (1 << COMPACT_MOD_IMMUTABLE) + 1;
+		hdr_array[i].algo = hdr_array[i].algo % HASH_ALGO_RIPE_MD_128;
+		hdr_array[i].count = hdr_array[i].count % MAX_DIGEST_COUNT;
+
+		while (!hdr_array[i].count) {
+			ret = getrandom(&hdr_array[i].count,
+					sizeof(hdr_array[i].count), 0);
+			if (ret < 0)
+				goto out;
+
+			hdr_array[i].count =
+				hdr_array[i].count % MAX_DIGEST_COUNT;
+		}
+
+		hdr_array[i].datalen =
+		    hdr_array[i].count * hash_digest_size[hdr_array[i].algo];
+
+		digest_list->size += sizeof(*hdr_array) + hdr_array[i].datalen;
+	}
+
+	digest_list->buf = calloc(digest_list->size, sizeof(unsigned char));
+	if (!digest_list->buf) {
+		free(digest_list);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	buf_ptr = digest_list->buf;
+
+	for (i = 0; i < num_digest_blocks; i++) {
+		memcpy(buf_ptr, &hdr_array[i], sizeof(*hdr_array));
+		buf_ptr += sizeof(*hdr_array);
+
+		for (j = 0; j < hdr_array[i].count; j++) {
+			ret = getrandom(buf_ptr, sizeof(u32), 0);
+			if (ret < 0)
+				goto out;
+
+			*(u32 *)buf_ptr = *(u32 *)buf_ptr % MAX_DIGEST_VALUE;
+			buf_ptr += hash_digest_size[hdr_array[i].algo];
+		}
+	}
+
+	digest_list->algo = get_ima_hash_algo();
+	if (digest_list->algo == HASH_ALGO__LAST) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = calc_digest(digest, digest_list->buf, digest_list->size,
+			  digest_list->algo);
+	if (ret < 0)
+		goto out;
+
+	_bin2hex(digest_list->digest_str, digest,
+		 hash_digest_size[digest_list->algo]);
+
+	ret = 0;
+out:
+	if (ret < 0) {
+		free(digest_list->buf);
+		free(digest_list);
+	}
+
+	free(hdr_array);
+	return !ret ? digest_list : NULL;
+}
+
+static struct digest_list_item *digest_list_generate_random(void)
+{
+	struct digest_list_item *digest_list;
+	struct compact_list_hdr *hdr;
+	u32 size = 0;
+	u8 digest[64];
+	int ret;
+
+	digest_list = calloc(1, sizeof(*digest_list));
+	if (!digest_list)
+		return NULL;
+
+	while (!size) {
+		ret = getrandom(&size, sizeof(size), 0);
+		if (ret < 0)
+			goto out;
+
+		size = size % MAX_DIGEST_LIST_SIZE;
+	}
+
+	digest_list->size = size;
+	digest_list->buf = calloc(digest_list->size, sizeof(unsigned char));
+	if (!digest_list->buf) {
+		free(digest_list);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = getrandom(digest_list->buf, digest_list->size, 0);
+	if (ret < 0)
+		goto out;
+
+	hdr = (struct compact_list_hdr *)digest_list->buf;
+	hdr->version = 1;
+	hdr->_reserved = 0;
+	hdr->type = hdr->type % (COMPACT__LAST - 1);
+	hdr->algo = hdr->algo % HASH_ALGO__LAST;
+
+	digest_list->algo = get_ima_hash_algo();
+	if (digest_list->algo == HASH_ALGO__LAST) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	ret = calc_digest(digest, digest_list->buf, digest_list->size,
+			  digest_list->algo);
+	if (ret < 0)
+		goto out;
+
+	_bin2hex(digest_list->digest_str, digest,
+		 hash_digest_size[digest_list->algo]);
+
+	ret = 0;
+out:
+	if (ret < 0) {
+		free(digest_list->buf);
+		free(digest_list);
+	}
+
+	return !ret ? digest_list : NULL;
+}
+
+static int digest_list_upload(struct digest_list_item *digest_list, enum ops op,
+			      enum upload_types upload_type, int uid)
+{
+	char path_template[] = DIGEST_LIST_PATH_TEMPLATE;
+	char *path_upload = DIGEST_LIST_ADD_PATH, *basename;
+	unsigned char *buffer = digest_list->buf;
+	size_t buffer_len = digest_list->size;
+	unsigned char rnd[3];
+	int ret = 0, fd;
+
+	if (op == DIGEST_LIST_ADD) {
+		if (upload_type == UPLOAD_FILE) {
+			fd = mkstemp(path_template);
+			if (fd < 0)
+				return -EPERM;
+
+			fchmod(fd, 0644);
+			close(fd);
+			ret = write_buffer(path_template,
+					   (char *)digest_list->buf,
+					   digest_list->size, -1);
+			if (ret < 0)
+				goto out;
+
+			buffer = (unsigned char *)path_template;
+			buffer_len = strlen(path_template);
+		} else {
+			ret = getrandom(rnd, sizeof(rnd), 0);
+			if (ret < 0)
+				goto out;
+
+			_bin2hex(path_template +
+				 sizeof(DIGEST_LIST_PATH_TEMPLATE) - 7, rnd,
+				 sizeof(rnd));
+		}
+
+		memcpy(digest_list->filename_suffix,
+		       path_template + sizeof(DIGEST_LIST_PATH_TEMPLATE) - 7,
+		       6);
+	} else {
+		memcpy(path_template + sizeof(DIGEST_LIST_PATH_TEMPLATE) - 7,
+		       digest_list->filename_suffix, 6);
+		path_upload = DIGEST_LIST_DEL_PATH;
+		if (upload_type == UPLOAD_FILE) {
+			buffer = (unsigned char *)path_template;
+			buffer_len = strlen(path_template);
+		}
+	}
+
+	if (upload_type == UPLOAD_BUFFER) {
+		basename = strrchr(path_template, '/') + 1;
+		ret = write_buffer(DIGEST_LABEL_PATH, basename,
+				   strlen(basename), -1);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = write_buffer(path_upload, (char *)buffer, buffer_len, uid);
+out:
+	if ((op == DIGEST_LIST_ADD && ret < 0) ||
+	    (op == DIGEST_LIST_DEL && !ret))
+		unlink(path_template);
+
+	return ret;
+}
+
+static int digest_list_check(struct digest_list_item *digest_list, enum ops op)
+{
+	char path[PATH_MAX];
+	u8 digest_list_buf[MAX_LINE_LENGTH];
+	char digest_list_info[MAX_LINE_LENGTH];
+	ssize_t size = digest_list->size;
+	struct compact_list_hdr *hdr;
+	struct stat st;
+	int ret = 0, i, fd, path_len, len, read_len;
+
+	path_len = snprintf(path, sizeof(path), "%s/%s-%s-digest_list.%s.ascii",
+			    DIGEST_LISTS_LOADED_PATH,
+			    hash_algo_name[digest_list->algo],
+			    digest_list->digest_str,
+			    digest_list->filename_suffix);
+
+	path[path_len - 6] = '\0';
+
+	if (op == DIGEST_LIST_DEL) {
+		if (stat(path, &st) != -1)
+			return -EEXIST;
+
+		path[path_len - 6] = '.';
+
+		if (stat(path, &st) != -1)
+			return -EEXIST;
+
+		return 0;
+	}
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	while (size) {
+		len = read(fd, digest_list_buf, sizeof(digest_list_buf));
+		if (len <= 0) {
+			ret = -errno;
+			goto out;
+		}
+
+		if (memcmp(digest_list_buf,
+			   digest_list->buf + digest_list->size - size, len)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		size -= len;
+	}
+
+	close(fd);
+
+	path[path_len - 6] = '.';
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	size = digest_list->size;
+	while (size) {
+		hdr = (struct compact_list_hdr *)(digest_list->buf +
+						  digest_list->size - size);
+
+		/* From digest_list_show_common(). */
+		len = snprintf(digest_list_info, sizeof(digest_list_info),
+			"actions: %d, version: %d, algo: %s, type: %d, modifiers: %d, count: %d, datalen: %d\n",
+			digest_list->actions, hdr->version,
+			hash_algo_name[hdr->algo], hdr->type, hdr->modifiers,
+			hdr->count, hdr->datalen);
+
+		read_len = read(fd, digest_list_buf, len);
+
+		if (read_len != len ||
+		    memcmp(digest_list_info, digest_list_buf, len)) {
+			ret = -EIO;
+			goto out;
+		}
+
+		size -= sizeof(*hdr);
+
+		for (i = 0; i < hdr->count; i++) {
+			_bin2hex(digest_list_info,
+				 digest_list->buf + digest_list->size - size,
+				 hash_digest_size[hdr->algo]);
+
+			read_len = read(fd, digest_list_buf,
+					hash_digest_size[hdr->algo] * 2 + 1);
+
+			if (read_len != hash_digest_size[hdr->algo] * 2 + 1 ||
+			    memcmp(digest_list_info, digest_list_buf,
+				   read_len - 1) ||
+				   digest_list_buf[read_len - 1] != '\n') {
+				ret = -EIO;
+				goto out;
+			}
+
+			size -= hash_digest_size[hdr->algo];
+		}
+	}
+out:
+	close(fd);
+	return ret;
+}
+
+static int digest_list_query(u8 *digest, enum hash_algo algo,
+			     char **query_result)
+{
+	ssize_t len, to_write, written;
+	char query[256] = { 0 };
+	size_t query_result_len;
+	int ret = 0, fd;
+
+	len = snprintf(query, sizeof(query), "%s-", hash_algo_name[algo]);
+
+	_bin2hex(query + len, digest, hash_digest_size[algo]);
+	len += hash_digest_size[algo] * 2 + 1;
+
+	fd = open(DIGEST_QUERY_PATH, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	to_write = len;
+
+	while (to_write) {
+		written = write(fd, query + len - to_write, to_write);
+		if (written <= 0) {
+			ret = -errno;
+			break;
+		}
+
+		to_write -= written;
+	}
+
+	close(fd);
+	if (ret < 0)
+		return ret;
+
+	return read_buffer(DIGEST_QUERY_PATH, query_result, &query_result_len,
+			   true, true);
+}
+
+static int *get_count_gen_lists(u8 *digest, enum hash_algo algo,
+				bool is_digest_list)
+{
+	struct compact_list_hdr *hdr;
+	u8 *buf_ptr;
+	unsigned long long size;
+	struct digest_list_item *digest_list;
+	u8 digest_list_digest[64];
+	int i, j, *count;
+
+	count = calloc(num_max_digest_lists, sizeof(*count));
+	if (!count)
+		return count;
+
+	for (i = 0; i < num_max_digest_lists; i++) {
+		if (!digest_lists[i])
+			continue;
+
+		digest_list = digest_lists[i];
+		size = digest_lists[i]->size;
+		buf_ptr = digest_lists[i]->buf;
+
+		if (is_digest_list) {
+			_hex2bin(digest_list_digest, digest_list->digest_str,
+				 hash_digest_size[digest_list->algo]);
+			if (!memcmp(digest_list_digest, digest,
+				    hash_digest_size[digest_list->algo]))
+				count[i]++;
+
+			continue;
+		}
+
+		while (size) {
+			hdr = (struct compact_list_hdr *)buf_ptr;
+			if (hdr->algo != algo) {
+				buf_ptr += sizeof(*hdr) + hdr->datalen;
+				size -= sizeof(*hdr) + hdr->datalen;
+				continue;
+			}
+
+			buf_ptr += sizeof(*hdr);
+			size -= sizeof(*hdr);
+
+			for (j = 0; j < hdr->count; j++) {
+				if (!memcmp(digest, buf_ptr,
+				    hash_digest_size[algo]))
+					count[i]++;
+				buf_ptr += hash_digest_size[algo];
+				size -= hash_digest_size[algo];
+			}
+		}
+	}
+
+	return count;
+}
+
+static int *get_count_kernel_query(u8 *digest, enum hash_algo algo,
+				   bool is_digest_list)
+{
+	char *query_result = NULL, *query_result_ptr, *line;
+	char digest_list_info[MAX_LINE_LENGTH];
+	char label[256];
+	struct compact_list_hdr *hdr;
+	struct digest_list_item *digest_list;
+	unsigned long long size, size_info;
+	int ret, i, *count = NULL;
+
+	count = calloc(num_max_digest_lists, sizeof(*count));
+	if (!count)
+		return count;
+
+	ret = digest_list_query(digest, algo, &query_result);
+	if (ret < 0)
+		goto out;
+
+	query_result_ptr = query_result;
+
+	while ((line = strsep(&query_result_ptr, "\n"))) {
+		if (!strlen(line))
+			continue;
+
+		for (i = 0; i < num_max_digest_lists; i++) {
+			if (!digest_lists[i])
+				continue;
+
+			digest_list = digest_lists[i];
+			size = digest_list->size;
+
+			if (is_digest_list) {
+				snprintf(label, sizeof(label),
+					 "%s-%s-digest_list.%s",
+					 hash_algo_name[digest_list->algo],
+					 digest_list->digest_str,
+					 digest_list->filename_suffix);
+
+				/* From digest_query_show(). */
+				size_info = snprintf(digest_list_info,
+					 sizeof(digest_list_info),
+					 "%s (actions: %d): type: %d, size: %lld\n",
+					 label, digest_list->actions,
+					 COMPACT_DIGEST_LIST, size);
+
+				/* strsep() replaced '\n' with '\0' in line. */
+				digest_list_info[size_info - 1] = '\0';
+
+				if (!strcmp(digest_list_info, line))
+					count[i]++;
+
+				continue;
+			}
+
+			while (size) {
+				hdr =
+				  (struct compact_list_hdr *)(digest_list->buf +
+						digest_list->size - size);
+				size -= sizeof(*hdr) + hdr->datalen;
+
+				snprintf(label, sizeof(label),
+					 "%s-%s-digest_list.%s",
+					 hash_algo_name[digest_list->algo],
+					 digest_list->digest_str,
+					 digest_list->filename_suffix);
+
+				/* From digest_query_show(). */
+				size_info = snprintf(digest_list_info,
+					 sizeof(digest_list_info),
+					 "%s (actions: %d): version: %d, algo: %s, type: %d, modifiers: %d, count: %d, datalen: %d\n",
+					 label, digest_list->actions,
+					 hdr->version,
+					 hash_algo_name[hdr->algo], hdr->type,
+					 hdr->modifiers, hdr->count,
+					 hdr->datalen);
+
+				/* strsep() replaced '\n' with '\0' in line. */
+				digest_list_info[size_info - 1] = '\0';
+
+				if (!strcmp(digest_list_info, line)) {
+					count[i]++;
+					break;
+				}
+			}
+		}
+	}
+out:
+	free(query_result);
+	if (ret < 0)
+		free(count);
+
+	return (!ret) ? count : NULL;
+}
+
+static int compare_count(u8 *digest, enum hash_algo algo,
+			 bool is_digest_list, struct __test_metadata *_metadata)
+{
+	int *count_gen_list_array, *count_kernel_query_array;
+	int count_gen_list = 0, count_kernel_query = 0;
+	char digest_str[64 * 2 + 1] = { 0 };
+	int i;
+
+	count_gen_list_array = get_count_gen_lists(digest, algo,
+						   is_digest_list);
+	if (!count_gen_list_array)
+		return -EINVAL;
+
+	count_kernel_query_array = get_count_kernel_query(digest, algo,
+							  is_digest_list);
+	if (!count_kernel_query_array) {
+		free(count_gen_list_array);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_max_digest_lists; i++) {
+		count_gen_list += count_gen_list_array[i];
+		count_kernel_query += count_kernel_query_array[i];
+	}
+
+	_bin2hex(digest_str, digest, hash_digest_size[algo]);
+
+	TH_LOG("digest: %s, algo: %s, gen list digests: %d, kernel digests: %d",
+	       digest_str, hash_algo_name[algo], count_gen_list,
+	       count_kernel_query);
+	free(count_gen_list_array);
+	free(count_kernel_query_array);
+	return (count_gen_list == count_kernel_query) ? 0 : -EINVAL;
+}
+
+static void digest_list_delete_all(struct __test_metadata *_metadata,
+				   enum upload_types upload_type)
+{
+	int ret, i;
+
+	for (i = 0; i < MAX_DIGEST_LISTS; i++) {
+		if (!digest_lists[i])
+			continue;
+
+		ret = digest_list_upload(digest_lists[i], DIGEST_LIST_DEL,
+					 upload_type, -1);
+		ASSERT_EQ(0, ret) {
+			TH_LOG("digest_list_upload() failed\n");
+		}
+
+		free(digest_lists[i]->buf);
+		free(digest_lists[i]);
+		digest_lists[i] = NULL;
+	}
+}
+
+FIXTURE(test)
+{
+	enum upload_types upload_type;
+};
+
+FIXTURE_SETUP(test)
+{
+}
+
+FIXTURE_TEARDOWN(test)
+{
+	digest_list_delete_all(_metadata, self->upload_type);
+}
+
+static int enable_fault_injection(void)
+{
+	int ret;
+
+	ret = write_buffer(DIGEST_LIST_DEBUGFS_TASK_FILTER, "Y", 1, -1);
+	if (ret < 0)
+		return ret;
+
+	ret = write_buffer(DIGEST_LIST_DEBUGFS_PROBABILITY, "1", 1, -1);
+	if (ret < 0)
+		return ret;
+
+	ret = write_buffer(DIGEST_LIST_DEBUGFS_TIMES, "10000", 5, -1);
+	if (ret < 0)
+		return ret;
+
+	ret = write_buffer(DIGEST_LIST_DEBUGFS_VERBOSE, "1", 1, -1);
+	if (ret < 0)
+		return ret;
+
+	ret = write_buffer(PROCFS_SELF_FAULT, "1", 1, -1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void digest_list_add_del_test(struct __test_metadata *_metadata,
+				     int fault_injection,
+				     enum upload_types upload_type)
+{
+	u32 value;
+	enum ops op;
+	enum hash_algo algo;
+	u8 digest[64];
+	int ret, i, cur_queries = 1;
+
+	while (cur_queries <= NUM_QUERIES) {
+		ret = getrandom(&op, 1, 0);
+		ASSERT_EQ(1, ret) {
+			TH_LOG("getrandom() failed\n");
+		}
+
+		op = op % 2;
+
+		switch (op) {
+		case DIGEST_LIST_ADD:
+			TH_LOG("add digest list...");
+			for (digest_lists_pos = 0;
+			     digest_lists_pos < num_max_digest_lists;
+			     digest_lists_pos++)
+				if (!digest_lists[digest_lists_pos])
+					break;
+
+			if (digest_lists_pos == num_max_digest_lists)
+				continue;
+
+			digest_lists[digest_lists_pos] = digest_list_generate();
+			ASSERT_NE(NULL, digest_lists[digest_lists_pos]) {
+				TH_LOG("digest_list_generate() failed");
+			}
+
+			ret = digest_list_upload(digest_lists[digest_lists_pos],
+						 op, upload_type, -1);
+			/* Handle failures from fault injection. */
+			if (fault_injection && ret < 0) {
+				TH_LOG("handle failure...");
+				ret = digest_list_check(
+						digest_lists[digest_lists_pos],
+						DIGEST_LIST_DEL);
+				ASSERT_EQ(0, ret) {
+					TH_LOG("digest_list_check() failed");
+				}
+
+				free(digest_lists[digest_lists_pos]->buf);
+				free(digest_lists[digest_lists_pos]);
+				digest_lists[digest_lists_pos] = NULL;
+				break;
+			}
+
+			ASSERT_EQ(0, ret) {
+				TH_LOG("digest_list_upload() failed");
+			}
+
+			ret = digest_list_check(digest_lists[digest_lists_pos],
+						op);
+			ASSERT_EQ(0, ret) {
+				TH_LOG("digest_list_check() failed");
+			}
+
+			break;
+		case DIGEST_LIST_DEL:
+			TH_LOG("delete digest list...");
+			for (digest_lists_pos = 0;
+			     digest_lists_pos < num_max_digest_lists;
+			     digest_lists_pos++)
+				if (digest_lists[digest_lists_pos])
+					break;
+
+			if (digest_lists_pos == num_max_digest_lists)
+				continue;
+
+			for (i = 0; i < MAX_SEARCH_ATTEMPTS; i++) {
+				ret = getrandom(&digest_lists_pos,
+						sizeof(digest_lists_pos), 0);
+				ASSERT_EQ(sizeof(digest_lists_pos), ret) {
+					TH_LOG("getrandom() failed");
+				}
+
+				digest_lists_pos =
+					digest_lists_pos % num_max_digest_lists;
+
+				if (digest_lists[digest_lists_pos])
+					break;
+			}
+
+			if (i == MAX_SEARCH_ATTEMPTS) {
+				for (digest_lists_pos = 0;
+				     digest_lists_pos < num_max_digest_lists;
+				     digest_lists_pos++)
+					if (digest_lists[digest_lists_pos])
+						break;
+
+				if (digest_lists_pos == num_max_digest_lists)
+					continue;
+			}
+
+			ret = digest_list_upload(digest_lists[digest_lists_pos],
+						 op, upload_type, -1);
+			ASSERT_EQ(0, ret) {
+				TH_LOG("digest_list_upload() failed");
+			}
+
+			ret = digest_list_check(digest_lists[digest_lists_pos],
+						op);
+			ASSERT_EQ(0, ret) {
+				TH_LOG("digest_list_check() failed");
+			}
+
+			free(digest_lists[digest_lists_pos]->buf);
+			free(digest_lists[digest_lists_pos]);
+			digest_lists[digest_lists_pos] = NULL;
+			break;
+		default:
+			break;
+		}
+
+		ret = getrandom(&value, sizeof(value), 0);
+		ASSERT_EQ(sizeof(value), ret) {
+			TH_LOG("getrandom() failed");
+		}
+
+		value = value % 10;
+
+		if (value != 1)
+			continue;
+
+		ret = getrandom(&value, sizeof(value), 0);
+		ASSERT_EQ(sizeof(value), ret) {
+			TH_LOG("getrandom() failed");
+		}
+
+		value = value % MAX_DIGEST_VALUE;
+
+		ret = getrandom(&algo, sizeof(algo), 0);
+		ASSERT_EQ(sizeof(algo), ret) {
+			TH_LOG("getrandom() failed");
+		}
+
+		algo = algo % HASH_ALGO_RIPE_MD_128;
+
+		memset(digest, 0, sizeof(digest));
+		*(u32 *)digest = value;
+
+		ret = compare_count(digest, algo, false, _metadata);
+		ASSERT_EQ(0, ret) {
+			TH_LOG("count mismatch");
+		}
+
+		ret = getrandom(&value, sizeof(value), 0);
+		ASSERT_EQ(sizeof(value), ret) {
+			TH_LOG("getrandom() failed");
+		}
+
+		value = value % MAX_DIGEST_LISTS;
+
+		if (digest_lists[value] != NULL) {
+			_hex2bin(digest, digest_lists[value]->digest_str,
+				 hash_digest_size[digest_lists[value]->algo]);
+
+			ret = compare_count(digest, digest_lists[value]->algo,
+					    true, _metadata);
+			ASSERT_EQ(0, ret) {
+				TH_LOG("count mismatch");
+			}
+		}
+
+		TH_LOG("query digest lists (%d/%d)...", cur_queries,
+		       NUM_QUERIES);
+
+		cur_queries++;
+	}
+}
+
+TEST_F_TIMEOUT(test, digest_list_add_del_test_file_upload, UINT_MAX)
+{
+	self->upload_type = UPLOAD_FILE;
+	digest_list_add_del_test(_metadata, 0, self->upload_type);
+}
+
+TEST_F_TIMEOUT(test, digest_list_add_del_test_file_upload_fault, UINT_MAX)
+{
+	int ret;
+
+	self->upload_type = UPLOAD_FILE;
+
+	ret = enable_fault_injection();
+	ASSERT_EQ(0, ret) {
+		TH_LOG("enable_fault_injection() failed");
+	}
+
+	digest_list_add_del_test(_metadata, 1, self->upload_type);
+}
+
+TEST_F_TIMEOUT(test, digest_list_add_del_test_buffer_upload, UINT_MAX)
+{
+	self->upload_type = UPLOAD_BUFFER;
+	digest_list_add_del_test(_metadata, 0, self->upload_type);
+}
+
+TEST_F_TIMEOUT(test, digest_list_add_del_test_buffer_upload_fault, UINT_MAX)
+{
+	int ret;
+
+	self->upload_type = UPLOAD_BUFFER;
+
+	ret = enable_fault_injection();
+	ASSERT_EQ(0, ret) {
+		TH_LOG("enable_fault_injection() failed");
+	}
+
+	digest_list_add_del_test(_metadata, 1, self->upload_type);
+}
+
+FIXTURE(test_fuzzing)
+{
+};
+
+FIXTURE_SETUP(test_fuzzing)
+{
+}
+
+FIXTURE_TEARDOWN(test_fuzzing)
+{
+}
+
+TEST_F_TIMEOUT(test_fuzzing, digest_list_fuzzing_test, UINT_MAX)
+{
+	char digests_count_before[256] = { 0 };
+	char *digests_count_before_ptr = digests_count_before;
+	char digests_count_after[256] = { 0 };
+	char *digests_count_after_ptr = digests_count_after;
+	size_t len = sizeof(digests_count_before) - 1;
+	int ret, i;
+
+	ret = read_buffer(DIGESTS_COUNT, &digests_count_before_ptr, &len,
+			  false, true);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("read_buffer() failed");
+	}
+
+	for (i = 1; i <= NUM_ITERATIONS; i++) {
+		TH_LOG("add digest list (%d/%d)...", i, NUM_ITERATIONS);
+
+		digest_lists[0] = digest_list_generate_random();
+		ASSERT_NE(NULL, digest_lists[0]) {
+			TH_LOG("digest_list_generate() failed");
+		}
+
+		ret = digest_list_upload(digest_lists[0], DIGEST_LIST_ADD,
+					 UPLOAD_FILE, -1);
+		if (!ret) {
+			ret = digest_list_check(digest_lists[0],
+						DIGEST_LIST_ADD);
+			ASSERT_EQ(0, ret) {
+				TH_LOG("digest_list_check() failed");
+			}
+
+			ret = digest_list_upload(digest_lists[0],
+						 DIGEST_LIST_DEL, UPLOAD_FILE,
+						 -1);
+			ASSERT_EQ(0, ret) {
+				TH_LOG("digest_list_upload() failed");
+			}
+
+			ret = digest_list_check(digest_lists[0],
+						DIGEST_LIST_DEL);
+			ASSERT_EQ(0, ret) {
+				TH_LOG("digest_list_check() failed");
+			}
+		}
+
+		free(digest_lists[0]->buf);
+		free(digest_lists[0]);
+		digest_lists[0] = NULL;
+	}
+
+	ret = read_buffer(DIGESTS_COUNT, &digests_count_after_ptr, &len, false,
+			  true);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("read_buffer() failed");
+	}
+
+	ASSERT_STREQ(digests_count_before, digests_count_after);
+}
+
+#define IMA_MEASURE_RULES "dont_measure func=CRITICAL_DATA label=diglim euid=1000 \nmeasure func=CRITICAL_DATA label=diglim \n"
+
+/* This must be the last group of tests, otherwise an OOM will likely occur. */
+FIXTURE(test_measure)
+{
+};
+
+FIXTURE_SETUP(test_measure)
+{
+	char *cur_ima_policy = NULL;
+	size_t cur_ima_policy_len = 0;
+	bool rule_found = false;
+	int ret;
+
+	ret = read_buffer(IMA_POLICY_PATH, &cur_ima_policy, &cur_ima_policy_len,
+			  true, true);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("read_buffer() failed");
+	}
+
+	rule_found = (strstr(cur_ima_policy, IMA_MEASURE_RULES) != NULL);
+	free(cur_ima_policy);
+
+	if (!rule_found) {
+		ret = write_buffer(IMA_POLICY_PATH, IMA_MEASURE_RULES,
+				sizeof(IMA_MEASURE_RULES), -1);
+		ASSERT_EQ(0, ret) {
+			TH_LOG("write_buffer() failed");
+		}
+	}
+}
+
+FIXTURE_TEARDOWN(test_measure)
+{
+}
+
+TEST_F_TIMEOUT(test_measure, digest_list_add_del_test_file_upload_measured,
+	       UINT_MAX)
+{
+	int ret;
+
+	digest_lists[0] = digest_list_generate();
+	ASSERT_NE(NULL, digest_lists[0]) {
+		TH_LOG("digest_list_generate() failed");
+	}
+
+	digest_lists[0]->actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
+
+	ret = digest_list_upload(digest_lists[0], DIGEST_LIST_ADD, UPLOAD_FILE,
+				 -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_lists[0], DIGEST_LIST_ADD);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	ret = digest_list_upload(digest_lists[0], DIGEST_LIST_DEL, UPLOAD_FILE,
+				 -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_lists[0], DIGEST_LIST_DEL);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	free(digest_lists[0]->buf);
+	free(digest_lists[0]);
+	digest_lists[0] = NULL;
+}
+
+void digest_list_check_measurement_list_test_common(
+					struct __test_metadata *_metadata,
+					enum upload_types upload_type)
+{
+	char *measurement_list = NULL;
+	size_t measurement_list_len;
+	char event_digest_name[512];
+	bool entry_found;
+	int ret;
+
+	digest_lists[0] = digest_list_generate();
+	ASSERT_NE(NULL, digest_lists[0]) {
+		TH_LOG("digest_list_generate() failed");
+	}
+
+	digest_lists[0]->actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
+
+	ret = digest_list_upload(digest_lists[0], DIGEST_LIST_ADD, upload_type,
+				 -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_lists[0], DIGEST_LIST_ADD);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	ret = read_buffer(IMA_MEASUREMENTS_PATH, &measurement_list,
+			  &measurement_list_len, true, true);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("read_buffer() failed");
+	}
+
+	snprintf(event_digest_name, sizeof(event_digest_name),
+		 "%s:%s add_%s_digest_list.%s",
+		 hash_algo_name[digest_lists[0]->algo],
+		 digest_lists[0]->digest_str,
+		 upload_type == UPLOAD_FILE ? "file" : "buffer",
+		 digest_lists[0]->filename_suffix);
+
+	entry_found = (strstr(measurement_list, event_digest_name) != NULL);
+	free(measurement_list);
+
+	ASSERT_EQ(true, entry_found) {
+		TH_LOG("digest list not found in measurement list");
+	}
+
+	ret = digest_list_upload(digest_lists[0], DIGEST_LIST_DEL, upload_type,
+				 1000);
+	ASSERT_NE(0, ret) {
+		TH_LOG("digest_list_upload() success unexpected");
+	}
+
+	ret = digest_list_upload(digest_lists[0], DIGEST_LIST_DEL, upload_type,
+				 -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_lists[0], DIGEST_LIST_DEL);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	measurement_list = NULL;
+
+	ret = read_buffer(IMA_MEASUREMENTS_PATH, &measurement_list,
+			  &measurement_list_len, true, true);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("read_buffer() failed");
+	}
+
+	snprintf(event_digest_name, sizeof(event_digest_name),
+		 "%s:%s del_%s_digest_list.%s",
+		 hash_algo_name[digest_lists[0]->algo],
+		 digest_lists[0]->digest_str,
+		 upload_type == UPLOAD_FILE ? "file" : "buffer",
+		 digest_lists[0]->filename_suffix);
+
+	entry_found = (strstr(measurement_list, event_digest_name) != NULL);
+	free(measurement_list);
+
+	ASSERT_EQ(true, entry_found) {
+		TH_LOG("digest list not found in measurement list");
+	}
+
+	free(digest_lists[0]->buf);
+	free(digest_lists[0]);
+	digest_lists[0] = NULL;
+}
+
+TEST_F_TIMEOUT(test_measure,
+	       digest_list_check_measurement_list_test_file_upload, UINT_MAX)
+{
+	digest_list_check_measurement_list_test_common(_metadata, UPLOAD_FILE);
+}
+
+TEST_F_TIMEOUT(test_measure,
+	       digest_list_check_measurement_list_test_buffer_upload, UINT_MAX)
+{
+	digest_list_check_measurement_list_test_common(_metadata,
+						       UPLOAD_BUFFER);
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1

