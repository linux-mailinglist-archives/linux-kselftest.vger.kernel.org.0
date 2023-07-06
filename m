Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1663749FA6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjGFOtH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGFOsj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 10:48:39 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0C2125;
        Thu,  6 Jul 2023 07:48:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QxfHq32sWz9xFGP;
        Thu,  6 Jul 2023 22:37:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHQg0y06ZkPxkwBA--.58122S12;
        Thu, 06 Jul 2023 15:47:26 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, song@kernel.org, jolsa@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 10/10] selftests/bpf: Prepare a test for user asymmetric key signatures
Date:   Thu,  6 Jul 2023 16:42:23 +0200
Message-Id: <20230706144225.1046544-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
References: <20230706144225.1046544-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHQg0y06ZkPxkwBA--.58122S12
X-Coremail-Antispam: 1UD129KBjvAXoWfGF4furWUCw1xZw4UurW8Crg_yoW8GF4rCo
        Z3K3y7K3W5Kr1UCw17XFyUCFWfury8K3s8Zws0v3ZFq3W7KryUAr4kGw1fX34agw4F9rWr
        WFn3A3WkZ397trn8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOo7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7Cj
        xVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
        Aaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        WY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8I
        cVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIF
        yTuYvjxUI-eODUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4-V5wAHsE
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Reuse the existing test for PKCS#7 signatures, to test also user asymmetric
key signatures.

Run the new test only if gpg supports the new command --conv-kernel.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 ...y_pkcs7_sig.c => verify_pkcs7_uasym_sig.c} | 159 +++++++++++++++---
 ...s7_sig.c => test_verify_pkcs7_uasym_sig.c} |  18 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  82 ++++++++-
 3 files changed, 226 insertions(+), 33 deletions(-)
 rename tools/testing/selftests/bpf/prog_tests/{verify_pkcs7_sig.c => verify_pkcs7_uasym_sig.c} (69%)
 rename tools/testing/selftests/bpf/progs/{test_verify_pkcs7_sig.c => test_verify_pkcs7_uasym_sig.c} (82%)

diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_uasym_sig.c
similarity index 69%
rename from tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
rename to tools/testing/selftests/bpf/prog_tests/verify_pkcs7_uasym_sig.c
index dd7f2bc7004..89664351d98 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_uasym_sig.c
@@ -18,7 +18,7 @@
 #include <linux/keyctl.h>
 #include <test_progs.h>
 
-#include "test_verify_pkcs7_sig.skel.h"
+#include "test_verify_pkcs7_uasym_sig.skel.h"
 
 #define MAX_DATA_SIZE (1024 * 1024)
 #define MAX_SIG_SIZE 1024
@@ -29,6 +29,24 @@
 /* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
 #define MODULE_SIG_STRING "~Module signature appended~\n"
 
+#define PKEY_ID_PGP 0
+#define PKEY_ID_X509 1
+#define PKEY_ID_PKCS7 2
+
+static char *key_types_str[PKEY_ID_PKCS7 + 1] = {
+	[PKEY_ID_PGP] = "pgp",
+	[PKEY_ID_X509] = "x509",
+	[PKEY_ID_PKCS7] = "pkcs7",
+};
+
+enum algos { ALGO_RSA, ALGO_ECDSA_P256, ALGO_ECDSA_P384, ALGO__LAST };
+
+static char *algos_str[ALGO_ECDSA_P384 + 1] = {
+	[ALGO_RSA] = "rsa",
+	[ALGO_ECDSA_P256] = "ecdsa_p256",
+	[ALGO_ECDSA_P384] = "ecdsa_p384",
+};
+
 /*
  * Module signature information block.
  *
@@ -74,13 +92,15 @@ static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
 	return 0;
 }
 
-static int _run_setup_process(const char *setup_dir, const char *cmd)
+static int _run_setup_process(const char *setup_dir, const char *cmd,
+			      __u8 key_type, __u8 pkey_algo)
 {
 	int child_pid, child_status;
 
 	child_pid = fork();
 	if (child_pid == 0) {
-		execlp("./verify_sig_setup.sh", "./verify_sig_setup.sh", cmd,
+		execlp("./verify_sig_setup.sh", "./verify_sig_setup.sh",
+		       cmd, key_types_str[key_type], algos_str[pkey_algo] ?: "",
 		       setup_dir, NULL);
 		exit(errno);
 
@@ -92,11 +112,13 @@ static int _run_setup_process(const char *setup_dir, const char *cmd)
 	return -EINVAL;
 }
 
-static int populate_data_item_str(const char *tmp_dir, struct data *data_item)
+static int populate_data_item_str(const char *tmp_dir, __u8 key_type,
+				  struct data *data_item)
 {
 	struct stat st;
 	char data_template[] = "/tmp/dataXXXXXX";
 	char path[PATH_MAX];
+	char path_out[PATH_MAX];
 	int ret, fd, child_status, child_pid;
 
 	data_item->data_len = 4;
@@ -123,10 +145,26 @@ static int populate_data_item_str(const char *tmp_dir, struct data *data_item)
 	}
 
 	if (child_pid == 0) {
-		snprintf(path, sizeof(path), "%s/signing_key.pem", tmp_dir);
-
-		return execlp("./sign-file", "./sign-file", "-d", "sha256",
-			      path, path, data_template, NULL);
+		if (key_type == PKEY_ID_PKCS7) {
+			snprintf(path, sizeof(path), "%s/signing_key.pem",
+				 tmp_dir);
+
+			return execlp("./sign-file", "./sign-file", "-d",
+				      "sha256", path, path, data_template,
+				      NULL);
+		} else {
+			snprintf(path, sizeof(path), "%s.gpg", data_template);
+
+			return execlp("gpg", "gpg", "--no-options",
+				      "--no-auto-check-trustdb",
+				      "--no-permission-warning",
+				      "--default-key", "eBPF_UASYM_Test",
+				      "--sign", "-o", path, "--batch", "--yes",
+				      "--compress-algo=none", "-b",
+				      "--passphrase", "abc",
+				      "--pinentry-mode", "loopback", "-q",
+				      data_template, NULL);
+		}
 	}
 
 	waitpid(child_pid, &child_status, 0);
@@ -135,7 +173,35 @@ static int populate_data_item_str(const char *tmp_dir, struct data *data_item)
 	if (ret)
 		goto out;
 
-	snprintf(path, sizeof(path), "%s.p7s", data_template);
+	if (key_type != PKEY_ID_PKCS7) {
+		child_pid = fork();
+
+		if (child_pid == -1) {
+			ret = -errno;
+			goto out;
+		}
+
+		if (child_pid == 0) {
+			snprintf(path, sizeof(path), "%s.gpg", data_template);
+			snprintf(path_out, sizeof(path), "%s.kernel",
+				 data_template);
+
+			return execlp("gpg", "gpg", "--no-keyring",
+				      "--conv-kernel", "-o", path_out, path,
+				      NULL);
+		}
+
+		waitpid(child_pid, &child_status, 0);
+
+		ret = WEXITSTATUS(child_status);
+		if (ret)
+			goto out;
+	}
+
+	if (key_type == PKEY_ID_PKCS7)
+		snprintf(path, sizeof(path), "%s.p7s", data_template);
+	else
+		snprintf(path, sizeof(path), "%s.kernel", data_template);
 
 	ret = stat(path, &st);
 	if (ret == -1) {
@@ -254,12 +320,12 @@ static int populate_data_item_mod(struct data *data_item)
 	return ret;
 }
 
-void test_verify_pkcs7_sig(void)
+static void test_verify_pkcs7_uasym_sig(__u8 key_type, __u8 pkey_algo)
 {
 	libbpf_print_fn_t old_print_cb;
 	char tmp_dir_template[] = "/tmp/verify_sigXXXXXX";
 	char *tmp_dir;
-	struct test_verify_pkcs7_sig *skel = NULL;
+	struct test_verify_pkcs7_uasym_sig *skel = NULL;
 	struct bpf_map *map;
 	struct data data;
 	int ret, zero = 0;
@@ -272,37 +338,38 @@ void test_verify_pkcs7_sig(void)
 	if (!ASSERT_OK_PTR(tmp_dir, "mkdtemp"))
 		return;
 
-	ret = _run_setup_process(tmp_dir, "setup");
+	ret = _run_setup_process(tmp_dir, "setup", key_type, pkey_algo);
 	if (!ASSERT_OK(ret, "_run_setup_process"))
 		goto close_prog;
 
-	skel = test_verify_pkcs7_sig__open();
-	if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_sig__open"))
+	skel = test_verify_pkcs7_uasym_sig__open();
+	if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_uasym_sig__open"))
 		goto close_prog;
 
 	old_print_cb = libbpf_set_print(libbpf_print_cb);
-	ret = test_verify_pkcs7_sig__load(skel);
+	ret = test_verify_pkcs7_uasym_sig__load(skel);
 	libbpf_set_print(old_print_cb);
 
 	if (ret < 0 && kfunc_not_supported) {
 		printf(
-		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
+		  "%s:SKIP:bpf_verify_*_signature() kfunc not supported\n",
 		  __func__);
 		test__skip();
 		goto close_prog;
 	}
 
-	if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__load"))
+	if (!ASSERT_OK(ret, "test_verify_pkcs7_uasym_sig__load"))
 		goto close_prog;
 
-	ret = test_verify_pkcs7_sig__attach(skel);
-	if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__attach"))
+	ret = test_verify_pkcs7_uasym_sig__attach(skel);
+	if (!ASSERT_OK(ret, "test_verify_pkcs7_uasym_sig__attach"))
 		goto close_prog;
 
 	map = bpf_object__find_map_by_name(skel->obj, "data_input");
 	if (!ASSERT_OK_PTR(map, "data_input not found"))
 		goto close_prog;
 
+	skel->bss->key_type = key_type;
 	skel->bss->monitored_pid = getpid();
 
 	/* Test without data and signature. */
@@ -313,7 +380,7 @@ void test_verify_pkcs7_sig(void)
 		goto close_prog;
 
 	/* Test successful signature verification with session keyring. */
-	ret = populate_data_item_str(tmp_dir, &data);
+	ret = populate_data_item_str(tmp_dir, key_type, &data);
 	if (!ASSERT_OK(ret, "populate_data_item_str"))
 		goto close_prog;
 
@@ -363,9 +430,13 @@ void test_verify_pkcs7_sig(void)
 	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem data_input"))
 		goto close_prog;
 
-	ret = populate_data_item_mod(&data);
-	if (!ASSERT_OK(ret, "populate_data_item_mod"))
-		goto close_prog;
+	data.data_len = 0;
+
+	if (key_type == PKEY_ID_PKCS7) {
+		ret = populate_data_item_mod(&data);
+		if (!ASSERT_OK(ret, "populate_data_item_mod"))
+			goto close_prog;
+	}
 
 	/* Test signature verification with system keyrings. */
 	if (data.data_len) {
@@ -392,11 +463,49 @@ void test_verify_pkcs7_sig(void)
 	}
 
 close_prog:
-	_run_setup_process(tmp_dir, "cleanup");
+	_run_setup_process(tmp_dir, "cleanup", key_type, pkey_algo);
 
 	if (!skel)
 		return;
 
 	skel->bss->monitored_pid = 0;
-	test_verify_pkcs7_sig__destroy(skel);
+	test_verify_pkcs7_uasym_sig__destroy(skel);
+}
+
+static bool gpg_conv_kernel_supported(void)
+{
+	bool supported = false;
+	char line[1024];
+	FILE *fp;
+
+	fp = popen("gpg --conv-kernel /dev/null 2>&1", "r");
+	if (!fp)
+		return false;
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strstr(line, "gpg: processing message failed: Unknown system error")) {
+			supported = true;
+			break;
+		}
+	}
+
+	pclose(fp);
+	return supported;
+}
+
+void test_verify_pkcs7_sig(void)
+{
+	test_verify_pkcs7_uasym_sig(PKEY_ID_PKCS7, ALGO__LAST);
+}
+
+void test_verify_uasym_sig(void)
+{
+	int i;
+
+	/* This test requires support for the new gpg command --conv-kernel. */
+	if (!gpg_conv_kernel_supported())
+		return;
+
+	for (i = 0; i < ALGO__LAST; i++)
+		test_verify_pkcs7_uasym_sig(PKEY_ID_PGP, i);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_uasym_sig.c
similarity index 82%
rename from tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
rename to tools/testing/selftests/bpf/progs/test_verify_pkcs7_uasym_sig.c
index 7748cc23de8..f25a023b5bb 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_uasym_sig.c
@@ -20,10 +20,14 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
 extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
+extern int bpf_verify_uasym_signature(struct bpf_dynptr *data_ptr,
+				      struct bpf_dynptr *sig_ptr,
+				      struct bpf_key *trusted_keyring) __ksym;
 
 __u32 monitored_pid;
 __u32 user_keyring_serial;
 __u64 system_keyring_id;
+__u8 key_type;
 
 struct data {
 	__u8 data[MAX_DATA_SIZE];
@@ -86,7 +90,19 @@ int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
 	if (!trusted_keyring)
 		return -ENOENT;
 
-	ret = bpf_verify_pkcs7_signature(&data_ptr, &sig_ptr, trusted_keyring);
+	switch (key_type) {
+	case PKEY_ID_PKCS7:
+		ret = bpf_verify_pkcs7_signature(&data_ptr, &sig_ptr,
+						 trusted_keyring);
+		break;
+	case PKEY_ID_PGP:
+		ret = bpf_verify_uasym_signature(&data_ptr, &sig_ptr,
+						 trusted_keyring);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
 
 	bpf_key_put(trusted_keyring);
 
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
index ba08922b4a2..90770ae9e12 100755
--- a/tools/testing/selftests/bpf/verify_sig_setup.sh
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -26,13 +26,39 @@ subjectKeyIdentifier=hash
 authorityKeyIdentifier=keyid
 "
 
+gpg_genkey_content_common="\
+     Name-Real: eBPF_UASYM_Test
+     Name-Comment: eBPF_UASYM_Test
+     Name-Email: ebpf_uasym_test@localhost
+     Expire-Date: 0
+     Passphrase: abc
+     %commit
+"
+gpg_genkey_content_rsa="\
+     Key-Type: RSA
+     Key-Length: 4096
+     $gpg_genkey_content_common
+"
+
+gpg_genkey_content_ecdsa_p256="\
+     Key-Type: ECDSA
+     Key-Curve: NIST P-256
+     $gpg_genkey_content_common
+"
+
+gpg_genkey_content_ecdsa_p384="\
+     Key-Type: ECDSA
+     Key-Curve: NIST P-384
+     $gpg_genkey_content_common
+"
+
 usage()
 {
-	echo "Usage: $0 <setup|cleanup <existing_tmp_dir>"
+	echo "Usage: $0 <setup|cleanup> <key type> <existing_tmp_dir>"
 	exit 1
 }
 
-setup()
+setup_pkcs7()
 {
 	local tmp_dir="$1"
 
@@ -52,11 +78,37 @@ setup()
 	keyctl link $key_id $keyring_id
 }
 
-cleanup() {
+setup_pgp()
+{
+	local tmp_dir="$1"
+	local varname="gpg_genkey_content_$2"
+
+	modprobe ecdsa_generic
+
+	echo "${!varname}" > ${tmp_dir}/gpg.genkey
+	gpg --batch --generate-key ${tmp_dir}/gpg.genkey
+
+	key_id=$(gpg --export eBPF_UASYM_Test | gpg --conv-kernel | keyctl padd asymmetric ebpf_testing_key @s)
+	keyring_id=$(keyctl newring ebpf_testing_keyring @s)
+	keyctl link $key_id $keyring_id
+}
+
+cleanup_pkcs7() {
+	local tmp_dir="$1"
+
+	keyctl unlink $(keyctl search @s asymmetric ebpf_testing_key) @s
+	keyctl unlink $(keyctl search @s keyring ebpf_testing_keyring) @s
+	rm -rf ${tmp_dir}
+}
+
+cleanup_pgp() {
 	local tmp_dir="$1"
 
 	keyctl unlink $(keyctl search @s asymmetric ebpf_testing_key) @s
 	keyctl unlink $(keyctl search @s keyring ebpf_testing_keyring) @s
+	key_fingerprint=$(gpg --fingerprint --with-colons eBPF_UASYM_Test | awk -F ":" '$1 == "fpr" {print $(NF-1)}')
+	gpg --delete-secret-key --batch --yes $key_fingerprint
+	gpg --delete-key --batch --yes $key_fingerprint
 	rm -rf ${tmp_dir}
 }
 
@@ -75,17 +127,33 @@ catch()
 
 main()
 {
-	[[ $# -ne 2 ]] && usage
+	[[ $# -ne 4 ]] && usage
 
 	local action="$1"
-	local tmp_dir="$2"
+	local key_type="$2"
+	local key_algo="$3"
+	local tmp_dir="$4"
 
 	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
 
 	if [[ "${action}" == "setup" ]]; then
-		setup "${tmp_dir}"
+		if [[ "${key_type}" == "pkcs7" ]]; then
+			setup_pkcs7 "${tmp_dir}"
+		elif [[ "${key_type}" == "pgp" ]]; then
+			setup_pgp "${tmp_dir}" "${key_algo}"
+		else
+			echo "Unknown key type: ${key_type}"
+			exit 1
+		fi
 	elif [[ "${action}" == "cleanup" ]]; then
-		cleanup "${tmp_dir}"
+		if [[ "${key_type}" == "pkcs7" ]]; then
+			cleanup_pkcs7 "${tmp_dir}"
+		elif [[ "${key_type}" == "pgp" ]]; then
+			cleanup_pgp "${tmp_dir}"
+		else
+			echo "Unknown key type: ${key_type}"
+			exit 1
+		fi
 	else
 		echo "Unknown action: ${action}"
 		exit 1
-- 
2.34.1

