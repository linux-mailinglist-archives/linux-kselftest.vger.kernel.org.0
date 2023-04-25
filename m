Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781FB6EE701
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjDYRjV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjDYRjU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:39:20 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 10:38:53 PDT
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004FA14466;
        Tue, 25 Apr 2023 10:38:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Q5TWY16Slz9v7QZ;
        Wed, 26 Apr 2023 01:29:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3dADLD0hkGxlWAg--.5466S7;
        Tue, 25 Apr 2023 18:38:28 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 5/6] selftests/bpf: Prepare a test for UMD-parsed signatures
Date:   Tue, 25 Apr 2023 19:35:56 +0200
Message-Id: <20230425173557.724688-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dADLD0hkGxlWAg--.5466S7
X-Coremail-Antispam: 1UD129KBjvAXoW3tr4DZrWUGw4Dtw1DGr45ZFb_yoW8JFyUuo
        Z3K347K3W3Kr1UC347X3WUCFyruryxK3s5Zws5Z3ZFq342kryUAr1kGw1fX3429w4F934r
        WFn3Aw1DZr9rtrnxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOo7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
        Aaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
        yTuYvjxUI1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBF1jj4x8NAABsj
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Reuse the existing test for PKCS#7 signatures, to test also UMD-parsed
signatures.

Don't enable the test just yet, as the test would fail without a UMD parser
for PGP keys and signatures.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 ...ify_pkcs7_sig.c => verify_pkcs7_umd_sig.c} | 109 ++++++++++++++----
 ...kcs7_sig.c => test_verify_pkcs7_umd_sig.c} |  18 ++-
 .../testing/selftests/bpf/verify_sig_setup.sh |  82 +++++++++++--
 3 files changed, 176 insertions(+), 33 deletions(-)
 rename tools/testing/selftests/bpf/prog_tests/{verify_pkcs7_sig.c => verify_pkcs7_umd_sig.c} (75%)
 rename tools/testing/selftests/bpf/progs/{test_verify_pkcs7_sig.c => test_verify_pkcs7_umd_sig.c} (82%)

diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_umd_sig.c
similarity index 75%
rename from tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
rename to tools/testing/selftests/bpf/prog_tests/verify_pkcs7_umd_sig.c
index dd7f2bc7004..94d78146989 100644
--- a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_umd_sig.c
@@ -18,7 +18,7 @@
 #include <linux/keyctl.h>
 #include <test_progs.h>
 
-#include "test_verify_pkcs7_sig.skel.h"
+#include "test_verify_pkcs7_umd_sig.skel.h"
 
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
 
@@ -92,7 +112,8 @@ static int _run_setup_process(const char *setup_dir, const char *cmd)
 	return -EINVAL;
 }
 
-static int populate_data_item_str(const char *tmp_dir, struct data *data_item)
+static int populate_data_item_str(const char *tmp_dir, __u8 key_type,
+				  struct data *data_item)
 {
 	struct stat st;
 	char data_template[] = "/tmp/dataXXXXXX";
@@ -123,10 +144,26 @@ static int populate_data_item_str(const char *tmp_dir, struct data *data_item)
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
+				      "--default-key", "eBPF_UMD_Test",
+				      "--sign", "-o", path, "--batch", "--yes",
+				      "--compress-algo=none", "-b",
+				      "--passphrase", "abc",
+				      "--pinentry-mode", "loopback", "-q",
+				      data_template, NULL);
+		}
 	}
 
 	waitpid(child_pid, &child_status, 0);
@@ -135,7 +172,10 @@ static int populate_data_item_str(const char *tmp_dir, struct data *data_item)
 	if (ret)
 		goto out;
 
-	snprintf(path, sizeof(path), "%s.p7s", data_template);
+	if (key_type == PKEY_ID_PKCS7)
+		snprintf(path, sizeof(path), "%s.p7s", data_template);
+	else
+		snprintf(path, sizeof(path), "%s.gpg", data_template);
 
 	ret = stat(path, &st);
 	if (ret == -1) {
@@ -254,12 +294,12 @@ static int populate_data_item_mod(struct data *data_item)
 	return ret;
 }
 
-void test_verify_pkcs7_sig(void)
+static void test_verify_pkcs7_umd_sig(__u8 key_type, __u8 pkey_algo)
 {
 	libbpf_print_fn_t old_print_cb;
 	char tmp_dir_template[] = "/tmp/verify_sigXXXXXX";
 	char *tmp_dir;
-	struct test_verify_pkcs7_sig *skel = NULL;
+	struct test_verify_pkcs7_umd_sig *skel = NULL;
 	struct bpf_map *map;
 	struct data data;
 	int ret, zero = 0;
@@ -272,37 +312,38 @@ void test_verify_pkcs7_sig(void)
 	if (!ASSERT_OK_PTR(tmp_dir, "mkdtemp"))
 		return;
 
-	ret = _run_setup_process(tmp_dir, "setup");
+	ret = _run_setup_process(tmp_dir, "setup", key_type, pkey_algo);
 	if (!ASSERT_OK(ret, "_run_setup_process"))
 		goto close_prog;
 
-	skel = test_verify_pkcs7_sig__open();
-	if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_sig__open"))
+	skel = test_verify_pkcs7_umd_sig__open();
+	if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_umd_sig__open"))
 		goto close_prog;
 
 	old_print_cb = libbpf_set_print(libbpf_print_cb);
-	ret = test_verify_pkcs7_sig__load(skel);
+	ret = test_verify_pkcs7_umd_sig__load(skel);
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
+	if (!ASSERT_OK(ret, "test_verify_pkcs7_umd_sig__load"))
 		goto close_prog;
 
-	ret = test_verify_pkcs7_sig__attach(skel);
-	if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__attach"))
+	ret = test_verify_pkcs7_umd_sig__attach(skel);
+	if (!ASSERT_OK(ret, "test_verify_pkcs7_umd_sig__attach"))
 		goto close_prog;
 
 	map = bpf_object__find_map_by_name(skel->obj, "data_input");
 	if (!ASSERT_OK_PTR(map, "data_input not found"))
 		goto close_prog;
 
+	skel->bss->key_type = key_type;
 	skel->bss->monitored_pid = getpid();
 
 	/* Test without data and signature. */
@@ -313,7 +354,7 @@ void test_verify_pkcs7_sig(void)
 		goto close_prog;
 
 	/* Test successful signature verification with session keyring. */
-	ret = populate_data_item_str(tmp_dir, &data);
+	ret = populate_data_item_str(tmp_dir, key_type, &data);
 	if (!ASSERT_OK(ret, "populate_data_item_str"))
 		goto close_prog;
 
@@ -363,9 +404,13 @@ void test_verify_pkcs7_sig(void)
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
@@ -392,11 +437,25 @@ void test_verify_pkcs7_sig(void)
 	}
 
 close_prog:
-	_run_setup_process(tmp_dir, "cleanup");
+	_run_setup_process(tmp_dir, "cleanup", key_type, pkey_algo);
 
 	if (!skel)
 		return;
 
 	skel->bss->monitored_pid = 0;
-	test_verify_pkcs7_sig__destroy(skel);
+	test_verify_pkcs7_umd_sig__destroy(skel);
+}
+
+void test_verify_pkcs7_sig(void)
+{
+	return test_verify_pkcs7_umd_sig(PKEY_ID_PKCS7, ALGO__LAST);
+}
+
+void test_verify_umd_sig(void)
+{
+	int i;
+
+	/* Change the limit to ALGO__LAST when UMD supports PGP. */
+	for (i = 0; i < 0; i++)
+		test_verify_pkcs7_umd_sig(PKEY_ID_PGP, i);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_umd_sig.c
similarity index 82%
rename from tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
rename to tools/testing/selftests/bpf/progs/test_verify_pkcs7_umd_sig.c
index 7748cc23de8..e22b013a4e4 100644
--- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_umd_sig.c
@@ -20,10 +20,14 @@ extern void bpf_key_put(struct bpf_key *key) __ksym;
 extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
 				      struct bpf_dynptr *sig_ptr,
 				      struct bpf_key *trusted_keyring) __ksym;
+extern int bpf_verify_umd_signature(struct bpf_dynptr *data_ptr,
+				    struct bpf_dynptr *sig_ptr,
+				    struct bpf_key *trusted_keyring) __ksym;
 
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
+		ret = bpf_verify_umd_signature(&data_ptr, &sig_ptr,
+					       trusted_keyring);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
 
 	bpf_key_put(trusted_keyring);
 
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
index ba08922b4a2..5f6e612aae9 100755
--- a/tools/testing/selftests/bpf/verify_sig_setup.sh
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -26,13 +26,39 @@ subjectKeyIdentifier=hash
 authorityKeyIdentifier=keyid
 "
 
+gpg_genkey_content_common="\
+     Name-Real: eBPF_UMD_Test
+     Name-Comment: eBPF_UMD_Test
+     Name-Email: ebpf_umd_test@localhost
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
+	key_id=$(gpg --export eBPF_UMD_Test | keyctl padd asymmetric ebpf_testing_key @s)
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
+	key_fingerprint=$(gpg --fingerprint --with-colons eBPF_UMD_Test | awk -F ":" '$1 == "fpr" {print $(NF-1)}')
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
2.25.1

