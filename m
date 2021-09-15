Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2940CA5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhIOQgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 12:36:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3827 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhIOQeK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:10 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H8m0c3vhRz67yV7;
        Thu, 16 Sep 2021 00:30:24 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 18:32:48 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <mchehab+huawei@kernel.org>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 4/9] diglim: Tests - LSM
Date:   Wed, 15 Sep 2021 18:31:40 +0200
Message-ID: <20210915163145.1046505-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210915163145.1046505-1-roberto.sassu@huawei.com>
References: <20210915163145.1046505-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce more tests to ensure that DIGLIM LSM works as expected:

- digest_list_add_del_test_parser_upload;
- digest_list_add_del_test_parser_upload_not_measured;
- digest_list_add_del_test_parser_upload_write;
- digest_list_add_del_test_parser_upload_read;
- digest_list_add_del_test_parser_upload_char_dev.

The tests are in tools/testing/selftests/diglim/selftest.c.

A description of the tests can be found in
Documentation/security/diglim/tests.rst.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/diglim/tests.rst   |  18 +-
 tools/testing/selftests/diglim/Makefile   |  12 +-
 tools/testing/selftests/diglim/common.h   |   9 +
 tools/testing/selftests/diglim/selftest.c | 357 +++++++++++++++++++++-
 4 files changed, 378 insertions(+), 18 deletions(-)

diff --git a/Documentation/security/diglim/tests.rst b/Documentation/security/diglim/tests.rst
index 899e7d6683cf..21874918433d 100644
--- a/Documentation/security/diglim/tests.rst
+++ b/Documentation/security/diglim/tests.rst
@@ -14,7 +14,12 @@ expected:
 - ``digest_list_add_del_test_file_upload_measured``;
 - ``digest_list_add_del_test_file_upload_measured_chown``;
 - ``digest_list_check_measurement_list_test_file_upload``;
-- ``digest_list_check_measurement_list_test_buffer_upload``.
+- ``digest_list_check_measurement_list_test_buffer_upload``;
+- ``digest_list_add_del_test_parser_upload``;
+- ``digest_list_add_del_test_parser_upload_not_measured``
+- ``digest_list_add_del_test_parser_upload_write``;
+- ``digest_list_add_del_test_parser_upload_read``;
+- ``digest_list_add_del_test_parser_upload_char_dev``.
 
 The tests are in ``tools/testing/selftests/diglim/selftest.c``.
 
@@ -68,3 +73,14 @@ addition.
 
 The ``file_upload`` variant uploads a file, while the ``buffer_upload``
 variant uploads a buffer.
+
+The ``digest_list_add_del_test_parser`` tests verify the correctness of
+DIGLIM LSM. The ``upload`` variant ensures that files opened by the parser
+are evaluated and the actions are copied to the converted digest list. The
+``upload_not_measured`` variant ensures that the IMA measure action is not
+set to the converted digest list if the parser read a file not measured.
+The ``upload_write`` variant ensures that the parser cannot access a file
+concurrently written by another process. The ``upload_read`` variant
+ensures that files being read by the parser cannot be written by other
+processes. Finally, the ``upload_char_dev`` variant ensures that the parser
+cannot access files without measurable content (e.g. character device).
diff --git a/tools/testing/selftests/diglim/Makefile b/tools/testing/selftests/diglim/Makefile
index 100c219955d7..0e68d8363dd3 100644
--- a/tools/testing/selftests/diglim/Makefile
+++ b/tools/testing/selftests/diglim/Makefile
@@ -7,13 +7,19 @@ LDLIBS += -lpthread
 
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = selftest
-TEST_GEN_PROGS_EXTENDED = libcommon.so
+TEST_GEN_PROGS = selftest manage_digest_lists
+TEST_GEN_PROGS_EXTENDED = libcommon.so libcommon.a common.o
 
 include ../lib.mk
 
 $(OUTPUT)/libcommon.so: common.c
 	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
 
+$(OUTPUT)/libcommon.a: common.o
+	ar rcs libcommon.a common.o
+
 $(OUTPUT)/selftest: selftest.c $(TEST_GEN_PROGS_EXTENDED)
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS) -lcommon
+	$(CC) $(CFLAGS) -DOUTPUT=\"$(OUTPUT)\" $< -o $@ $(LDFLAGS) -lcommon
+
+$(OUTPUT)/manage_digest_lists: manage_digest_lists.c $(TEST_GEN_PROGS_EXTENDED)
+	$(CC) $(CFLAGS) -static $< -o $@ $(LDFLAGS) -lcommon
diff --git a/tools/testing/selftests/diglim/common.h b/tools/testing/selftests/diglim/common.h
index 6c7979f4182e..b71031adb830 100644
--- a/tools/testing/selftests/diglim/common.h
+++ b/tools/testing/selftests/diglim/common.h
@@ -26,6 +26,15 @@
 
 #define BUFFER_SIZE 1024
 
+#define INTEGRITY_DIR "/sys/kernel/security/integrity"
+#define DIGEST_LIST_DIR INTEGRITY_DIR "/diglim"
+#define DIGEST_QUERY_PATH DIGEST_LIST_DIR "/digest_query"
+#define DIGEST_LABEL_PATH DIGEST_LIST_DIR "/digest_list_label"
+#define DIGEST_LIST_ADD_PATH DIGEST_LIST_DIR "/digest_list_add"
+#define DIGEST_LIST_DEL_PATH DIGEST_LIST_DIR "/digest_list_del"
+#define DIGEST_LISTS_LOADED_PATH DIGEST_LIST_DIR "/digest_lists_loaded"
+#define DIGESTS_COUNT DIGEST_LIST_DIR "/digests_count"
+
 int write_buffer(char *path, char *buffer, size_t buffer_len, int uid);
 int read_buffer(char *path, char **buffer, size_t *buffer_len, bool alloc,
 		bool is_char);
diff --git a/tools/testing/selftests/diglim/selftest.c b/tools/testing/selftests/diglim/selftest.c
index 273ba80c43fd..af7a590c445f 100644
--- a/tools/testing/selftests/diglim/selftest.c
+++ b/tools/testing/selftests/diglim/selftest.c
@@ -63,16 +63,6 @@ typedef uint64_t u64;
 
 #define DIGEST_LIST_PATH_TEMPLATE "/tmp/digest_list.XXXXXX"
 
-#define INTEGRITY_DIR "/sys/kernel/security/integrity"
-
-#define DIGEST_LIST_DIR INTEGRITY_DIR "/diglim"
-#define DIGEST_QUERY_PATH DIGEST_LIST_DIR "/digest_query"
-#define DIGEST_LABEL_PATH DIGEST_LIST_DIR "/digest_list_label"
-#define DIGEST_LIST_ADD_PATH DIGEST_LIST_DIR "/digest_list_add"
-#define DIGEST_LIST_DEL_PATH DIGEST_LIST_DIR "/digest_list_del"
-#define DIGEST_LISTS_LOADED_PATH DIGEST_LIST_DIR "/digest_lists_loaded"
-#define DIGESTS_COUNT DIGEST_LIST_DIR "/digests_count"
-
 #define IMA_POLICY_PATH INTEGRITY_DIR "/ima/policy"
 #define IMA_MEASUREMENTS_PATH INTEGRITY_DIR "/ima/ascii_runtime_measurements"
 
@@ -94,7 +84,11 @@ typedef uint64_t u64;
 #define MAX_DIGEST_LIST_SIZE 10000
 #define NUM_ITERATIONS 100000
 
-enum upload_types { UPLOAD_FILE, UPLOAD_FILE_CHOWN, UPLOAD_BUFFER };
+#define DIGEST_LIST_PARSER_PATH OUTPUT "/manage_digest_lists"
+#define DIGEST_LIST_PARSER_PATH_COPY "/tmp/diglim/manage_digest_lists"
+
+enum upload_types { UPLOAD_FILE, UPLOAD_FILE_CHOWN, UPLOAD_BUFFER,
+		    UPLOAD_PARSER, UPLOAD_PARSER_CHOWN, NO_UPLOAD };
 
 const char *const hash_algo_name[HASH_ALGO__LAST] = {
 	[HASH_ALGO_MD4]		= "md4",
@@ -486,6 +480,69 @@ static struct digest_list_item *digest_list_generate_random(void)
 	return !ret ? digest_list : NULL;
 }
 
+static struct digest_list_item *digest_list_generate_file(char *file_path,
+							enum compact_types type)
+{
+	struct digest_list_item *digest_list;
+	struct compact_list_hdr *hdr;
+	u8 digest[64];
+	int ret;
+
+	digest_list = calloc(1, sizeof(*digest_list));
+	if (!digest_list)
+		return NULL;
+
+	digest_list->size = sizeof(struct compact_list_hdr) +
+			    hash_digest_size[HASH_ALGO_SHA256];
+	digest_list->buf = calloc(digest_list->size, sizeof(unsigned char));
+	if (!digest_list->buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	hdr = (struct compact_list_hdr *)digest_list->buf;
+
+	hdr->version = 1;
+	hdr->_reserved = 0;
+	hdr->type = type;
+	hdr->modifiers = 0;
+	hdr->algo = HASH_ALGO_SHA256;
+	hdr->count = 1;
+	hdr->datalen = hash_digest_size[hdr->algo];
+
+	hdr->type = __cpu_to_le16(hdr->type);
+	hdr->algo = __cpu_to_le16(hdr->algo);
+	hdr->count = __cpu_to_le32(hdr->count);
+	hdr->datalen = __cpu_to_le32(hdr->datalen);
+
+	ret = calc_file_digest(digest_list->buf + sizeof(*hdr), file_path,
+			       HASH_ALGO_SHA256);
+	if (ret < 0)
+		goto out;
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
+out:
+	if (ret < 0) {
+		free(digest_list->buf);
+		free(digest_list);
+		return NULL;
+	}
+
+	return digest_list;
+}
+
 static int digest_list_upload(struct digest_list_item *digest_list, enum ops op,
 			      enum upload_types upload_type, int uid)
 {
@@ -494,16 +551,20 @@ static int digest_list_upload(struct digest_list_item *digest_list, enum ops op,
 	unsigned char *buffer = digest_list->buf;
 	size_t buffer_len = digest_list->size;
 	unsigned char rnd[3];
-	int ret = 0, fd;
+	int ret = 0, fd, status;
 
 	if (op == DIGEST_LIST_ADD) {
 		if (upload_type == UPLOAD_FILE ||
-		    upload_type == UPLOAD_FILE_CHOWN) {
+		    upload_type == UPLOAD_FILE_CHOWN ||
+		    upload_type == UPLOAD_PARSER ||
+		    upload_type == UPLOAD_PARSER_CHOWN ||
+		    upload_type == NO_UPLOAD) {
 			fd = mkstemp(path_template);
 			if (fd < 0)
 				return -EPERM;
 
-			if (upload_type == UPLOAD_FILE_CHOWN)
+			if (upload_type == UPLOAD_FILE_CHOWN ||
+			    upload_type == UPLOAD_PARSER_CHOWN)
 				ret = fchown(fd, 3000, -1);
 
 			fchmod(fd, 0644);
@@ -550,6 +611,25 @@ static int digest_list_upload(struct digest_list_item *digest_list, enum ops op,
 				   strlen(basename), -1);
 		if (ret < 0)
 			goto out;
+	} else if (upload_type == UPLOAD_PARSER ||
+		   upload_type == UPLOAD_PARSER_CHOWN) {
+		if (fork() == 0) {
+			execlp(DIGEST_LIST_PARSER_PATH_COPY,
+			       DIGEST_LIST_PARSER_PATH_COPY,
+			       path_template, path_upload, NULL);
+			exit(1);
+		}
+
+		ret = 0;
+
+		wait(&status);
+		if (WEXITSTATUS(status) != 0)
+			ret = -EINVAL;
+
+		goto out;
+	} else if (upload_type == NO_UPLOAD) {
+		ret = 0;
+		goto out;
 	}
 
 	ret = write_buffer(path_upload, (char *)buffer, buffer_len, uid);
@@ -1439,4 +1519,253 @@ TEST_F_TIMEOUT(test_measure,
 						       UPLOAD_BUFFER);
 }
 
+FIXTURE(test_parser)
+{
+	struct digest_list_item *digest_list;
+};
+
+#define PARSER_RULES "measure func=DIGEST_LIST_CHECK fowner=3000 \n"
+
+FIXTURE_SETUP(test_parser)
+{
+	int ret;
+
+	ret = load_ima_policy(PARSER_RULES);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("load_ima_policy() failed");
+	}
+
+	unlink(DIGEST_LIST_PARSER_PATH_COPY);
+	mkdir("/tmp/diglim", 0700);
+
+	ret = copy_file(DIGEST_LIST_PARSER_PATH, DIGEST_LIST_PARSER_PATH_COPY);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("copy_file() failed");
+	}
+
+	ret = chown(DIGEST_LIST_PARSER_PATH_COPY, 3000, -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("chown() failed");
+	}
+
+	chmod(DIGEST_LIST_PARSER_PATH_COPY, 0755);
+
+	self->digest_list = digest_list_generate_file(
+						DIGEST_LIST_PARSER_PATH_COPY,
+						COMPACT_PARSER);
+	ASSERT_NE(NULL, self->digest_list) {
+		TH_LOG("Cannot generate digest list");
+	}
+
+	self->digest_list->actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
+
+	ret = digest_list_upload(self->digest_list, DIGEST_LIST_ADD,
+				 UPLOAD_FILE, 1000);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(self->digest_list, DIGEST_LIST_ADD);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+}
+
+FIXTURE_TEARDOWN(test_parser)
+{
+	int ret;
+
+	ret = digest_list_upload(self->digest_list, DIGEST_LIST_DEL,
+				 UPLOAD_FILE, 1000);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	free(self->digest_list->buf);
+	free(self->digest_list);
+}
+
+TEST_F_TIMEOUT(test_parser, digest_list_add_del_test_parser_upload, UINT_MAX)
+{
+	struct digest_list_item *digest_list;
+	int ret;
+
+	digest_list = digest_list_generate_file("/bin/cat", COMPACT_FILE);
+	ASSERT_NE(NULL, digest_list) {
+		TH_LOG("Cannot generate digest list");
+	}
+
+	digest_list->actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
+
+	ret = digest_list_upload(digest_list, DIGEST_LIST_ADD,
+				 UPLOAD_PARSER_CHOWN, -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_list, DIGEST_LIST_ADD);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	ret = digest_list_upload(digest_list, DIGEST_LIST_DEL,
+				 UPLOAD_PARSER_CHOWN, -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_list, DIGEST_LIST_DEL);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	free(digest_list);
+}
+
+TEST_F_TIMEOUT(test_parser, digest_list_add_del_test_parser_upload_not_measured,
+	       UINT_MAX)
+{
+	struct digest_list_item *digest_list;
+	int ret;
+
+	digest_list = digest_list_generate_file("/bin/cat", COMPACT_FILE);
+	ASSERT_NE(NULL, digest_list) {
+		TH_LOG("Cannot generate digest list");
+	}
+
+	ret = digest_list_upload(digest_list, DIGEST_LIST_ADD,
+				 UPLOAD_PARSER, -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_list, DIGEST_LIST_ADD);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	ret = digest_list_upload(digest_list, DIGEST_LIST_DEL,
+				 UPLOAD_PARSER, -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	ret = digest_list_check(digest_list, DIGEST_LIST_DEL);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_check() failed");
+	}
+
+	free(digest_list);
+}
+
+TEST_F_TIMEOUT(test_parser, digest_list_add_del_test_parser_upload_write,
+	       UINT_MAX)
+{
+	char path_template[] = DIGEST_LIST_PATH_TEMPLATE;
+	struct digest_list_item *digest_list;
+	int ret, fd, status, fds[2];
+	char c = 0;
+
+	digest_list = digest_list_generate_file("/bin/cat", COMPACT_FILE);
+	ASSERT_NE(NULL, digest_list) {
+		TH_LOG("Cannot generate digest list");
+	}
+
+	digest_list->actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
+
+	ret = digest_list_upload(digest_list, DIGEST_LIST_ADD, NO_UPLOAD, -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	memcpy(path_template + sizeof(DIGEST_LIST_PATH_TEMPLATE) - 7,
+	       digest_list->filename_suffix, 6);
+
+	ret = pipe(fds);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("pipe() failed");
+	}
+
+	if (fork() == 0) {
+		fd = open(path_template, O_WRONLY);
+		if (fd < 0)
+			exit(1);
+
+		close(fds[1]);
+		ret = read(fds[0], &c, sizeof(c));
+		exit(1);
+	}
+
+	close(fds[0]);
+
+	if (fork() == 0) {
+		execlp(DIGEST_LIST_PARSER_PATH, DIGEST_LIST_PARSER_PATH,
+		       path_template, DIGEST_LIST_ADD_PATH, NULL);
+		exit(1);
+	}
+
+	wait(&status);
+	ASSERT_EQ(1, WEXITSTATUS(status)) {
+		TH_LOG("digest list parser unexpected exit code %d",
+		       WEXITSTATUS(status));
+	}
+
+	free(digest_list);
+}
+
+TEST_F_TIMEOUT(test_parser, digest_list_add_del_test_parser_upload_read,
+	       UINT_MAX)
+{
+	char path_template[] = DIGEST_LIST_PATH_TEMPLATE;
+	struct digest_list_item *digest_list;
+	int ret, fd;
+
+	digest_list = digest_list_generate_file("/bin/cat", COMPACT_FILE);
+	ASSERT_NE(NULL, digest_list) {
+		TH_LOG("Cannot generate digest list");
+	}
+
+	ret = digest_list_upload(digest_list, DIGEST_LIST_ADD, NO_UPLOAD, -1);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("digest_list_upload() failed");
+	}
+
+	memcpy(path_template + sizeof(DIGEST_LIST_PATH_TEMPLATE) - 7,
+	       digest_list->filename_suffix, 6);
+
+	if (fork() == 0) {
+		execlp(DIGEST_LIST_PARSER_PATH, DIGEST_LIST_PARSER_PATH,
+		       path_template, DIGEST_LIST_ADD_PATH, "open_and_wait",
+		       NULL);
+		exit(1);
+	}
+
+	fd = open(path_template, O_WRONLY);
+	ASSERT_LT(0, fd) {
+		TH_LOG("digest list open success unexpected");
+		close(fd);
+	}
+
+	wait(NULL);
+	free(digest_list);
+	unlink(path_template);
+}
+
+TEST_F_TIMEOUT(test_parser, digest_list_add_del_test_parser_upload_char_dev,
+	       UINT_MAX)
+{
+	int status;
+
+	if (fork() == 0) {
+		execlp(DIGEST_LIST_PARSER_PATH, DIGEST_LIST_PARSER_PATH,
+		       "/dev/null", DIGEST_LIST_ADD_PATH, NULL);
+		exit(1);
+	}
+
+	wait(&status);
+	ASSERT_NE(0, WEXITSTATUS(status)) {
+		TH_LOG("digest list parser success unexpected");
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

