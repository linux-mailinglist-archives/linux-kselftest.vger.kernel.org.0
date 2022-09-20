Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8250D5BDF40
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiITIGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiITIFS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 04:05:18 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD56A65242;
        Tue, 20 Sep 2022 01:02:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MWv791PV8z9xHMN;
        Tue, 20 Sep 2022 15:58:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAno13_ciljaChgAA--.64537S14;
        Tue, 20 Sep 2022 09:02:31 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v18 12/13] selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc
Date:   Tue, 20 Sep 2022 09:59:50 +0200
Message-Id: <20220920075951.929132-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920075951.929132-1-roberto.sassu@huaweicloud.com>
References: <20220920075951.929132-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAno13_ciljaChgAA--.64537S14
X-Coremail-Antispam: 1UD129KBjvAXoWftw43ur43Cw47Jr15Wry8Krg_yoW8uw1kKo
        Z3Gw43X3WrGr1UCF1jgFykCryfWw48Gas8AwnYvwnrXFyDK3sIkr48Cw4fX342v39YqFyr
        uFn3Z3s7uFWxtrn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYK7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
        0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
        67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l
        IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
        A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoeOJUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj39ApAAAst
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Perform several tests to ensure the correct implementation of the
bpf_verify_pkcs7_signature() kfunc.

Do the tests with data signed with a generated testing key (by using
sign-file from scripts/) and with the tcp_bic.ko kernel module if it is
found in the system. The test does not fail if tcp_bic.ko is not found.

First, perform an unsuccessful signature verification without data.

Second, perform a successful signature verification with the session
keyring and a new one created for testing.

Then, ensure that permission and validation checks are done properly on the
keyring provided to bpf_verify_pkcs7_signature(), despite those checks were
deferred at the time the keyring was retrieved with bpf_lookup_user_key().
The tests expect to encounter an error if the Search permission is removed
from the keyring, or the keyring is expired.

Finally, perform a successful and unsuccessful signature verification with
the keyrings with pre-determined IDs (the last test fails because the key
is not in the platform keyring).

The test is currently in the deny list for s390x (JIT does not support
calling kernel function).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 tools/testing/selftests/bpf/Makefile          |  14 +-
 tools/testing/selftests/bpf/config            |   5 +
 tools/testing/selftests/bpf/config.x86_64     |   5 -
 .../bpf/prog_tests/verify_pkcs7_sig.c         | 399 ++++++++++++++++++
 .../bpf/progs/test_verify_pkcs7_sig.c         |  90 ++++
 .../testing/selftests/bpf/verify_sig_setup.sh | 104 +++++
 7 files changed, 610 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
 create mode 100755 tools/testing/selftests/bpf/verify_sig_setup.sh

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 770c376c984d..759b2bb53b53 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -72,3 +72,4 @@ cgroup_hierarchical_stats                # JIT does not support calling kernel f
 htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
 tracing_struct                           # failed to auto-attach: -524                                                 (trampoline)
 lookup_key                               # JIT does not support calling kernel function                                (kfunc)
+verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1a0296bd744a..5898d3828b82 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -14,6 +14,7 @@ BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
 APIDIR := $(TOOLSINCDIR)/uapi
 GENDIR := $(abspath ../../../../include/generated)
 GENHDR := $(GENDIR)/autoconf.h
+HOSTPKG_CONFIG := pkg-config
 
 ifneq ($(wildcard $(GENHDR)),)
   GENFLAGS := -DHAVE_GENHDR
@@ -75,7 +76,7 @@ TEST_PROGS := test_kmod.sh \
 	test_xsk.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
-	with_tunnels.sh ima_setup.sh \
+	with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
 	test_xdp_vlan.sh test_bpftool.py
 
 # Compile but not part of 'make run_tests'
@@ -84,7 +85,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat
 
-TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
+TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
@@ -189,6 +190,12 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code		       \
 		     -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
+$(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
+	$(call msg,SIGN-FILE,,$@)
+	$(Q)$(CC) $(shell $(HOSTPKG_CONFIG)--cflags libcrypto 2> /dev/null) \
+		  $< -o $@ \
+		  $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
 	$(call msg,MOD,,$@)
 	$(Q)$(RM) bpf_testmod/bpf_testmod.ko # force re-compilation
@@ -516,7 +523,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
-		       ima_setup.sh					\
+		       $(OUTPUT)/sign-file				\
+		       ima_setup.sh verify_sig_setup.sh			\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index add5a5a919b4..905a9be8d0a2 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -33,6 +33,11 @@ CONFIG_IPV6_TUNNEL=y
 CONFIG_KEYS=y
 CONFIG_LIRC=y
 CONFIG_LWTUNNEL=y
+CONFIG_MODULE_SIG=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
 CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index ce70c9509204..21ce5ea4304e 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -145,11 +145,6 @@ CONFIG_MCORE2=y
 CONFIG_MEMCG=y
 CONFIG_MEMORY_FAILURE=y
 CONFIG_MINIX_SUBPARTITION=y
-CONFIG_MODULE_SIG=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULES=y
-CONFIG_MODVERSIONS=y
 CONFIG_NAMESPACES=y
 CONFIG_NET=y
 CONFIG_NET_9P=y
diff --git a/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
new file mode 100644
index 000000000000..579d6ee83ce0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <endian.h>
+#include <limits.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <linux/keyctl.h>
+#include <test_progs.h>
+
+#include "test_verify_pkcs7_sig.skel.h"
+
+#define MAX_DATA_SIZE (1024 * 1024)
+#define MAX_SIG_SIZE 1024
+
+#define VERIFY_USE_SECONDARY_KEYRING (1UL)
+#define VERIFY_USE_PLATFORM_KEYRING  (2UL)
+
+/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
+#define MODULE_SIG_STRING "~Module signature appended~\n"
+
+/*
+ * Module signature information block.
+ *
+ * The constituents of the signature section are, in order:
+ *
+ *	- Signer's name
+ *	- Key identifier
+ *	- Signature data
+ *	- Information block
+ */
+struct module_signature {
+	__u8	algo;		/* Public-key crypto algorithm [0] */
+	__u8	hash;		/* Digest algorithm [0] */
+	__u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	__u8	signer_len;	/* Length of signer's name [0] */
+	__u8	key_id_len;	/* Length of key identifier [0] */
+	__u8	__pad[3];
+	__be32	sig_len;	/* Length of signature data */
+};
+
+struct data {
+	__u8 data[MAX_DATA_SIZE];
+	__u32 data_len;
+	__u8 sig[MAX_SIG_SIZE];
+	__u32 sig_len;
+};
+
+static bool kfunc_not_supported;
+
+static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
+			   va_list args)
+{
+	if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
+		return 0;
+
+	if (strcmp(va_arg(args, char *), "bpf_verify_pkcs7_signature"))
+		return 0;
+
+	kfunc_not_supported = true;
+	return 0;
+}
+
+static int _run_setup_process(const char *setup_dir, const char *cmd)
+{
+	int child_pid, child_status;
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		execlp("./verify_sig_setup.sh", "./verify_sig_setup.sh", cmd,
+		       setup_dir, NULL);
+		exit(errno);
+
+	} else if (child_pid > 0) {
+		waitpid(child_pid, &child_status, 0);
+		return WEXITSTATUS(child_status);
+	}
+
+	return -EINVAL;
+}
+
+static int populate_data_item_str(const char *tmp_dir, struct data *data_item)
+{
+	struct stat st;
+	char data_template[] = "/tmp/dataXXXXXX";
+	char path[PATH_MAX];
+	int ret, fd, child_status, child_pid;
+
+	data_item->data_len = 4;
+	memcpy(data_item->data, "test", data_item->data_len);
+
+	fd = mkstemp(data_template);
+	if (fd == -1)
+		return -errno;
+
+	ret = write(fd, data_item->data, data_item->data_len);
+
+	close(fd);
+
+	if (ret != data_item->data_len) {
+		ret = -EIO;
+		goto out;
+	}
+
+	child_pid = fork();
+
+	if (child_pid == -1) {
+		ret = -errno;
+		goto out;
+	}
+
+	if (child_pid == 0) {
+		snprintf(path, sizeof(path), "%s/signing_key.pem", tmp_dir);
+
+		return execlp("./sign-file", "./sign-file", "-d", "sha256",
+			      path, path, data_template, NULL);
+	}
+
+	waitpid(child_pid, &child_status, 0);
+
+	ret = WEXITSTATUS(child_status);
+	if (ret)
+		goto out;
+
+	snprintf(path, sizeof(path), "%s.p7s", data_template);
+
+	ret = stat(path, &st);
+	if (ret == -1) {
+		ret = -errno;
+		goto out;
+	}
+
+	if (st.st_size > sizeof(data_item->sig)) {
+		ret = -EINVAL;
+		goto out_sig;
+	}
+
+	data_item->sig_len = st.st_size;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1) {
+		ret = -errno;
+		goto out_sig;
+	}
+
+	ret = read(fd, data_item->sig, data_item->sig_len);
+
+	close(fd);
+
+	if (ret != data_item->sig_len) {
+		ret = -EIO;
+		goto out_sig;
+	}
+
+	ret = 0;
+out_sig:
+	unlink(path);
+out:
+	unlink(data_template);
+	return ret;
+}
+
+static int populate_data_item_mod(struct data *data_item)
+{
+	char mod_path[PATH_MAX], *mod_path_ptr;
+	struct stat st;
+	void *mod;
+	FILE *fp;
+	struct module_signature ms;
+	int ret, fd, modlen, marker_len, sig_len;
+
+	data_item->data_len = 0;
+
+	if (stat("/lib/modules", &st) == -1)
+		return 0;
+
+	/* Requires CONFIG_TCP_CONG_BIC=m. */
+	fp = popen("find /lib/modules/$(uname -r) -name tcp_bic.ko", "r");
+	if (!fp)
+		return 0;
+
+	mod_path_ptr = fgets(mod_path, sizeof(mod_path), fp);
+	pclose(fp);
+
+	if (!mod_path_ptr)
+		return 0;
+
+	mod_path_ptr = strchr(mod_path, '\n');
+	if (!mod_path_ptr)
+		return 0;
+
+	*mod_path_ptr = '\0';
+
+	if (stat(mod_path, &st) == -1)
+		return 0;
+
+	modlen = st.st_size;
+	marker_len = sizeof(MODULE_SIG_STRING) - 1;
+
+	fd = open(mod_path, O_RDONLY);
+	if (fd == -1)
+		return -errno;
+
+	mod = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+
+	close(fd);
+
+	if (mod == MAP_FAILED)
+		return -errno;
+
+	if (strncmp(mod + modlen - marker_len, MODULE_SIG_STRING, marker_len)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	modlen -= marker_len;
+
+	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
+
+	sig_len = __be32_to_cpu(ms.sig_len);
+	modlen -= sig_len + sizeof(ms);
+
+	if (modlen > sizeof(data_item->data)) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	memcpy(data_item->data, mod, modlen);
+	data_item->data_len = modlen;
+
+	if (sig_len > sizeof(data_item->sig)) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	memcpy(data_item->sig, mod + modlen, sig_len);
+	data_item->sig_len = sig_len;
+	ret = 0;
+out:
+	munmap(mod, st.st_size);
+	return ret;
+}
+
+void test_verify_pkcs7_sig(void)
+{
+	libbpf_print_fn_t old_print_cb;
+	char tmp_dir_template[] = "/tmp/verify_sigXXXXXX";
+	char *tmp_dir;
+	struct test_verify_pkcs7_sig *skel = NULL;
+	struct bpf_map *map;
+	struct data data;
+	int ret, zero = 0;
+
+	/* Trigger creation of session keyring. */
+	syscall(__NR_request_key, "keyring", "_uid.0", NULL,
+		KEY_SPEC_SESSION_KEYRING);
+
+	tmp_dir = mkdtemp(tmp_dir_template);
+	if (!ASSERT_OK_PTR(tmp_dir, "mkdtemp"))
+		return;
+
+	ret = _run_setup_process(tmp_dir, "setup");
+	if (!ASSERT_OK(ret, "_run_setup_process"))
+		goto close_prog;
+
+	skel = test_verify_pkcs7_sig__open();
+	if (!ASSERT_OK_PTR(skel, "test_verify_pkcs7_sig__open"))
+		goto close_prog;
+
+	old_print_cb = libbpf_set_print(libbpf_print_cb);
+	ret = test_verify_pkcs7_sig__load(skel);
+	libbpf_set_print(old_print_cb);
+
+	if (ret < 0 && kfunc_not_supported) {
+		printf(
+		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
+		  __func__);
+		test__skip();
+		goto close_prog;
+	}
+
+	if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__load"))
+		goto close_prog;
+
+	ret = test_verify_pkcs7_sig__attach(skel);
+	if (!ASSERT_OK(ret, "test_verify_pkcs7_sig__attach"))
+		goto close_prog;
+
+	map = bpf_object__find_map_by_name(skel->obj, "data_input");
+	if (!ASSERT_OK_PTR(map, "data_input not found"))
+		goto close_prog;
+
+	skel->bss->monitored_pid = getpid();
+
+	/* Test without data and signature. */
+	skel->bss->user_keyring_serial = KEY_SPEC_SESSION_KEYRING;
+
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data, BPF_ANY);
+	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem data_input"))
+		goto close_prog;
+
+	/* Test successful signature verification with session keyring. */
+	ret = populate_data_item_str(tmp_dir, &data);
+	if (!ASSERT_OK(ret, "populate_data_item_str"))
+		goto close_prog;
+
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data, BPF_ANY);
+	if (!ASSERT_OK(ret, "bpf_map_update_elem data_input"))
+		goto close_prog;
+
+	/* Test successful signature verification with testing keyring. */
+	skel->bss->user_keyring_serial = syscall(__NR_request_key, "keyring",
+						 "ebpf_testing_keyring", NULL,
+						 KEY_SPEC_SESSION_KEYRING);
+
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data, BPF_ANY);
+	if (!ASSERT_OK(ret, "bpf_map_update_elem data_input"))
+		goto close_prog;
+
+	/*
+	 * Ensure key_task_permission() is called and rejects the keyring
+	 * (no Search permission).
+	 */
+	syscall(__NR_keyctl, KEYCTL_SETPERM, skel->bss->user_keyring_serial,
+		0x37373737);
+
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data, BPF_ANY);
+	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem data_input"))
+		goto close_prog;
+
+	syscall(__NR_keyctl, KEYCTL_SETPERM, skel->bss->user_keyring_serial,
+		0x3f3f3f3f);
+
+	/*
+	 * Ensure key_validate() is called and rejects the keyring (key expired)
+	 */
+	syscall(__NR_keyctl, KEYCTL_SET_TIMEOUT,
+		skel->bss->user_keyring_serial, 1);
+	sleep(1);
+
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data, BPF_ANY);
+	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem data_input"))
+		goto close_prog;
+
+	skel->bss->user_keyring_serial = KEY_SPEC_SESSION_KEYRING;
+
+	/* Test with corrupted data (signature verification should fail). */
+	data.data[0] = 'a';
+	ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data, BPF_ANY);
+	if (!ASSERT_LT(ret, 0, "bpf_map_update_elem data_input"))
+		goto close_prog;
+
+	ret = populate_data_item_mod(&data);
+	if (!ASSERT_OK(ret, "populate_data_item_mod"))
+		goto close_prog;
+
+	/* Test signature verification with system keyrings. */
+	if (data.data_len) {
+		skel->bss->user_keyring_serial = 0;
+		skel->bss->system_keyring_id = 0;
+
+		ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data,
+					  BPF_ANY);
+		if (!ASSERT_OK(ret, "bpf_map_update_elem data_input"))
+			goto close_prog;
+
+		skel->bss->system_keyring_id = VERIFY_USE_SECONDARY_KEYRING;
+
+		ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data,
+					  BPF_ANY);
+		if (!ASSERT_OK(ret, "bpf_map_update_elem data_input"))
+			goto close_prog;
+
+		skel->bss->system_keyring_id = VERIFY_USE_PLATFORM_KEYRING;
+
+		ret = bpf_map_update_elem(bpf_map__fd(map), &zero, &data,
+					  BPF_ANY);
+		ASSERT_LT(ret, 0, "bpf_map_update_elem data_input");
+	}
+
+close_prog:
+	_run_setup_process(tmp_dir, "cleanup");
+
+	if (!skel)
+		return;
+
+	skel->bss->monitored_pid = 0;
+	test_verify_pkcs7_sig__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
new file mode 100644
index 000000000000..ce419304ff1f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define MAX_DATA_SIZE (1024 * 1024)
+#define MAX_SIG_SIZE 1024
+
+extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
+extern void bpf_key_put(struct bpf_key *key) __ksym;
+extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
+				      struct bpf_dynptr *sig_ptr,
+				      struct bpf_key *trusted_keyring) __ksym;
+
+__u32 monitored_pid;
+__u32 user_keyring_serial;
+__u64 system_keyring_id;
+
+struct data {
+	__u8 data[MAX_DATA_SIZE];
+	__u32 data_len;
+	__u8 sig[MAX_SIG_SIZE];
+	__u32 sig_len;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct data);
+} data_input SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm.s/bpf")
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	struct bpf_dynptr data_ptr, sig_ptr;
+	struct data *data_val;
+	struct bpf_key *trusted_keyring;
+	__u32 pid;
+	__u64 value;
+	int ret, zero = 0;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	data_val = bpf_map_lookup_elem(&data_input, &zero);
+	if (!data_val)
+		return 0;
+
+	bpf_probe_read(&value, sizeof(value), &attr->value);
+
+	bpf_copy_from_user(data_val, sizeof(struct data),
+			   (void *)(unsigned long)value);
+
+	if (data_val->data_len > sizeof(data_val->data))
+		return -EINVAL;
+
+	bpf_dynptr_from_mem(data_val->data, data_val->data_len, 0, &data_ptr);
+
+	if (data_val->sig_len > sizeof(data_val->sig))
+		return -EINVAL;
+
+	bpf_dynptr_from_mem(data_val->sig, data_val->sig_len, 0, &sig_ptr);
+
+	if (user_keyring_serial)
+		trusted_keyring = bpf_lookup_user_key(user_keyring_serial, 0);
+	else
+		trusted_keyring = bpf_lookup_system_key(system_keyring_id);
+
+	if (!trusted_keyring)
+		return -ENOENT;
+
+	ret = bpf_verify_pkcs7_signature(&data_ptr, &sig_ptr, trusted_keyring);
+
+	bpf_key_put(trusted_keyring);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/bpf/verify_sig_setup.sh b/tools/testing/selftests/bpf/verify_sig_setup.sh
new file mode 100755
index 000000000000..ba08922b4a27
--- /dev/null
+++ b/tools/testing/selftests/bpf/verify_sig_setup.sh
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+set -o pipefail
+
+VERBOSE="${SELFTESTS_VERBOSE:=0}"
+LOG_FILE="$(mktemp /tmp/verify_sig_setup.log.XXXXXX)"
+
+x509_genkey_content="\
+[ req ]
+default_bits = 2048
+distinguished_name = req_distinguished_name
+prompt = no
+string_mask = utf8only
+x509_extensions = myexts
+
+[ req_distinguished_name ]
+CN = eBPF Signature Verification Testing Key
+
+[ myexts ]
+basicConstraints=critical,CA:FALSE
+keyUsage=digitalSignature
+subjectKeyIdentifier=hash
+authorityKeyIdentifier=keyid
+"
+
+usage()
+{
+	echo "Usage: $0 <setup|cleanup <existing_tmp_dir>"
+	exit 1
+}
+
+setup()
+{
+	local tmp_dir="$1"
+
+	echo "${x509_genkey_content}" > ${tmp_dir}/x509.genkey
+
+	openssl req -new -nodes -utf8 -sha256 -days 36500 \
+			-batch -x509 -config ${tmp_dir}/x509.genkey \
+			-outform PEM -out ${tmp_dir}/signing_key.pem \
+			-keyout ${tmp_dir}/signing_key.pem 2>&1
+
+	openssl x509 -in ${tmp_dir}/signing_key.pem -out \
+		${tmp_dir}/signing_key.der -outform der
+
+	key_id=$(cat ${tmp_dir}/signing_key.der | keyctl padd asymmetric ebpf_testing_key @s)
+
+	keyring_id=$(keyctl newring ebpf_testing_keyring @s)
+	keyctl link $key_id $keyring_id
+}
+
+cleanup() {
+	local tmp_dir="$1"
+
+	keyctl unlink $(keyctl search @s asymmetric ebpf_testing_key) @s
+	keyctl unlink $(keyctl search @s keyring ebpf_testing_keyring) @s
+	rm -rf ${tmp_dir}
+}
+
+catch()
+{
+	local exit_code="$1"
+	local log_file="$2"
+
+	if [[ "${exit_code}" -ne 0 ]]; then
+		cat "${log_file}" >&3
+	fi
+
+	rm -f "${log_file}"
+	exit ${exit_code}
+}
+
+main()
+{
+	[[ $# -ne 2 ]] && usage
+
+	local action="$1"
+	local tmp_dir="$2"
+
+	[[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
+
+	if [[ "${action}" == "setup" ]]; then
+		setup "${tmp_dir}"
+	elif [[ "${action}" == "cleanup" ]]; then
+		cleanup "${tmp_dir}"
+	else
+		echo "Unknown action: ${action}"
+		exit 1
+	fi
+}
+
+trap 'catch "$?" "${LOG_FILE}"' EXIT
+
+if [[ "${VERBOSE}" -eq 0 ]]; then
+	# Save the stderr to 3 so that we can output back to
+	# it incase of an error.
+	exec 3>&2 1>"${LOG_FILE}" 2>&1
+fi
+
+main "$@"
+rm -f "${LOG_FILE}"
-- 
2.25.1

