Return-Path: <linux-kselftest+bounces-14527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AF3942C24
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8822857A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C81AD3F8;
	Wed, 31 Jul 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LMAnadpo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17171A8C0B;
	Wed, 31 Jul 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422423; cv=none; b=KKSiF8MiKHfoWAHjqpozfElACh0DUnoLBBPe7sO0P7e5/9eFzgxR+HwHAnCS+Ta9w71sRWOp4o6v9IoWKlQsly1w0AaM7MLCliJ+LsC1WB0Z7kNCDTh5VDToSrM9a18c9SXLDDmLdCYvzLH6mFWgBaPH/48qfSoFYGyacql9E/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422423; c=relaxed/simple;
	bh=LgTCFGjKc96Y9nDOwPIum4wGZAmcX7adX0/KCJZ9IlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVzEpIvXWnT0t9vY8a7Svmnv/Iq3/IfnySMrhNApR4K8CA90nzWVKTLmRi3rSCSJAqvoXSd4F3A6AhqZzHbinFVxvG+5LJV720EDsNEHrwTOM/WzTNQMeLrfFPnSjhODdMIv72C2uh4Pe1ibF656eJ7HRVK3FKx9NyTgL1eLK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LMAnadpo; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CC34E0005;
	Wed, 31 Jul 2024 10:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722422419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVvoGk2FvEZPT8DLnJ3Xemae0p+DGdG/L68bx2Ni87g=;
	b=LMAnadpovcy+jcLdENIny92btBWNGSy9altSU/C5r42UkWOAfV2CmpZcCE2EL3DIEnFNYN
	IrYFrd6qMSpr7eWeUHWztmiOmsWtez+06jIMOX/M/9whUTuTilYDc1hZsB18C8FJFUPssk
	jAU+nbopVvIcNh0cP77nCpAzbKM5hd7V473ayQd78Wla5TtbmzaXp3UR6hpPwQFGrXZY5O
	xvxmf7tbCSKhDGlnMQoPXkhqOM3pPbSg4ca88Axdxc40o3/hKMQ+QDACcdMTSVvvMKH43U
	MsPpNb1EtFUoXHnIrrPS5CC977nP4+Ho/iHeZ1ulRLOn3h/YE8/s7RWUHZt0yA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 31 Jul 2024 12:38:25 +0200
Subject: [PATCH bpf-next 2/4] selftests/bpf: convert test_cgroup_storage to
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-convert_cgroup_tests-v1-2-14cbc51b6947@bootlin.com>
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
In-Reply-To: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

test_cgroup_storage is currently a standalone program which is not run
when executing test_progs.

Convert it to the test_progs framework so it can be automatically executed
in CI. The conversion led to the following changes:
- converted the raw bpf program in the userspace test file into a dedicated
  test program in progs/ dir
- reduced the scope of cgroup_storage test: the content from this test
  overlaps with some other tests already present in test_progs, most
  notably netcnt and cgroup_storage_multi*. Those tests already check
  extensively local storage, per-cpu local storage, cgroups interaction,
  etc. So the new test only keep the part testing that the program return
  code (based on map content) properly leads to packet being passed or
  dropped.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Tested in a local qemu environment:

  ./test_progs -a cgroup_storage
  53      cgroup_storage:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   2 -
 .../selftests/bpf/prog_tests/cgroup_storage.c      |  65 ++++++++
 tools/testing/selftests/bpf/progs/cgroup_storage.c |  24 +++
 tools/testing/selftests/bpf/test_cgroup_storage.c  | 174 ---------------------
 5 files changed, 89 insertions(+), 177 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 108eb10626b9..a45f11f81337 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -21,7 +21,6 @@ urandom_read
 test_sockmap
 test_lirc_mode2_user
 test_skb_cgroup_id_user
-test_cgroup_storage
 test_flow_dissector
 flow_dissector_load
 test_tcpnotify_user
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d8483f81009..0ac0f9dbc2f8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -69,7 +69,6 @@ endif
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
 	test_dev_cgroup \
 	test_sock test_sockmap \
-	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32
 TEST_INST_SUBDIRS := no_alu32
@@ -297,7 +296,6 @@ $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
-$(OUTPUT)/test_cgroup_storage: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sysctl: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tag: $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
new file mode 100644
index 000000000000..c116fc22b460
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_storage.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "cgroup_storage.skel.h"
+
+#define TEST_CGROUP "/test-bpf-cgroup-storage-buf/"
+#define PING_CMD "ping localhost -c 1 -W 1 -q"
+
+void test_cgroup_storage(void)
+{
+	struct bpf_cgroup_storage_key key;
+	struct cgroup_storage *skel;
+	unsigned long long value;
+	int cgroup_fd;
+	int err;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_OK_FD(cgroup_fd, "create cgroup"))
+		return;
+
+	skel = cgroup_storage__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto cleanup_cgroup;
+
+	skel->links.bpf_prog =
+		bpf_program__attach_cgroup(skel->progs.bpf_prog, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.bpf_prog, "attach program"))
+		goto cleanup_progs;
+
+	/* Check that one out of every two packets is dropped */
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_OK(err, "first ping");
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_NEQ(err, 0, "second ping");
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_OK(err, "third ping");
+
+	err = bpf_map__get_next_key(skel->maps.cgroup_storage, NULL, &key,
+				    sizeof(key));
+	if (!ASSERT_OK(err, "get first key"))
+		goto cleanup_progs;
+	err = bpf_map__lookup_elem(skel->maps.cgroup_storage, &key, sizeof(key),
+				   &value, sizeof(value), 0);
+	if (!ASSERT_OK(err, "first packet count read"))
+		goto cleanup_progs;
+
+	/* Add one to the packet counter, check again packet filtering */
+	value++;
+	err = bpf_map__update_elem(skel->maps.cgroup_storage, &key, sizeof(key),
+				   &value, sizeof(value), 0);
+	if (!ASSERT_OK(err, "increment packet counter"))
+		goto cleanup_progs;
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_OK(err, "fourth ping");
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_NEQ(err, 0, "fifth ping");
+	err = SYS_NOFAIL(PING_CMD);
+	ASSERT_OK(err, "sixth ping");
+
+cleanup_progs:
+	cgroup_storage__destroy(skel);
+cleanup_cgroup:
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_storage.c b/tools/testing/selftests/bpf/progs/cgroup_storage.c
new file mode 100644
index 000000000000..db1e4d2d3281
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_storage.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} cgroup_storage SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int bpf_prog(struct __sk_buff *skb)
+{
+	__u64 *counter;
+
+	counter = bpf_get_local_storage(&cgroup_storage, 0);
+	__sync_fetch_and_add(counter, 1);
+
+	/* Drop one out of every two packets */
+	return (*counter & 1);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
deleted file mode 100644
index 0861ea60dcdd..000000000000
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ /dev/null
@@ -1,174 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <assert.h>
-#include <bpf/bpf.h>
-#include <linux/filter.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/sysinfo.h>
-
-#include "bpf_util.h"
-#include "cgroup_helpers.h"
-#include "testing_helpers.h"
-
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
-#define TEST_CGROUP "/test-bpf-cgroup-storage-buf/"
-
-int main(int argc, char **argv)
-{
-	struct bpf_insn prog[] = {
-		BPF_LD_MAP_FD(BPF_REG_1, 0), /* percpu map fd */
-		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_local_storage),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 0x1),
-		BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
-
-		BPF_LD_MAP_FD(BPF_REG_1, 0), /* map fd */
-		BPF_MOV64_IMM(BPF_REG_2, 0), /* flags, not used */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_local_storage),
-		BPF_MOV64_IMM(BPF_REG_1, 1),
-		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
-		BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 0x1),
-		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
-		BPF_EXIT_INSN(),
-	};
-	size_t insns_cnt = ARRAY_SIZE(prog);
-	int error = EXIT_FAILURE;
-	int map_fd, percpu_map_fd, prog_fd, cgroup_fd;
-	struct bpf_cgroup_storage_key key;
-	unsigned long long value;
-	unsigned long long *percpu_value;
-	int cpu, nproc;
-
-	nproc = bpf_num_possible_cpus();
-	percpu_value = malloc(sizeof(*percpu_value) * nproc);
-	if (!percpu_value) {
-		printf("Not enough memory for per-cpu area (%d cpus)\n", nproc);
-		goto err;
-	}
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	map_fd = bpf_map_create(BPF_MAP_TYPE_CGROUP_STORAGE, NULL, sizeof(key),
-				sizeof(value), 0, NULL);
-	if (map_fd < 0) {
-		printf("Failed to create map: %s\n", strerror(errno));
-		goto out;
-	}
-
-	percpu_map_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, NULL,
-				       sizeof(key), sizeof(value), 0, NULL);
-	if (percpu_map_fd < 0) {
-		printf("Failed to create map: %s\n", strerror(errno));
-		goto out;
-	}
-
-	prog[0].imm = percpu_map_fd;
-	prog[7].imm = map_fd;
-	prog_fd = bpf_test_load_program(BPF_PROG_TYPE_CGROUP_SKB,
-				   prog, insns_cnt, "GPL", 0,
-				   bpf_log_buf, BPF_LOG_BUF_SIZE);
-	if (prog_fd < 0) {
-		printf("Failed to load bpf program: %s\n", bpf_log_buf);
-		goto out;
-	}
-
-	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
-
-	/* Attach the bpf program */
-	if (bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_INET_EGRESS, 0)) {
-		printf("Failed to attach bpf program\n");
-		goto err;
-	}
-
-	if (bpf_map_get_next_key(map_fd, NULL, &key)) {
-		printf("Failed to get the first key in cgroup storage\n");
-		goto err;
-	}
-
-	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
-		printf("Failed to lookup cgroup storage 0\n");
-		goto err;
-	}
-
-	for (cpu = 0; cpu < nproc; cpu++)
-		percpu_value[cpu] = 1000;
-
-	if (bpf_map_update_elem(percpu_map_fd, &key, percpu_value, 0)) {
-		printf("Failed to update the data in the cgroup storage\n");
-		goto err;
-	}
-
-	/* Every second packet should be dropped */
-	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
-	assert(system("ping localhost -c 1 -W 1 -q > /dev/null"));
-	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
-
-	/* Check the counter in the cgroup local storage */
-	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
-		printf("Failed to lookup cgroup storage\n");
-		goto err;
-	}
-
-	if (value != 3) {
-		printf("Unexpected data in the cgroup storage: %llu\n", value);
-		goto err;
-	}
-
-	/* Bump the counter in the cgroup local storage */
-	value++;
-	if (bpf_map_update_elem(map_fd, &key, &value, 0)) {
-		printf("Failed to update the data in the cgroup storage\n");
-		goto err;
-	}
-
-	/* Every second packet should be dropped */
-	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
-	assert(system("ping localhost -c 1 -W 1 -q > /dev/null"));
-	assert(system("ping localhost -c 1 -W 1 -q > /dev/null") == 0);
-
-	/* Check the final value of the counter in the cgroup local storage */
-	if (bpf_map_lookup_elem(map_fd, &key, &value)) {
-		printf("Failed to lookup the cgroup storage\n");
-		goto err;
-	}
-
-	if (value != 7) {
-		printf("Unexpected data in the cgroup storage: %llu\n", value);
-		goto err;
-	}
-
-	/* Check the final value of the counter in the percpu local storage */
-
-	for (cpu = 0; cpu < nproc; cpu++)
-		percpu_value[cpu] = 0;
-
-	if (bpf_map_lookup_elem(percpu_map_fd, &key, percpu_value)) {
-		printf("Failed to lookup the per-cpu cgroup storage\n");
-		goto err;
-	}
-
-	value = 0;
-	for (cpu = 0; cpu < nproc; cpu++)
-		value += percpu_value[cpu];
-
-	if (value != nproc * 1000 + 6) {
-		printf("Unexpected data in the per-cpu cgroup storage\n");
-		goto err;
-	}
-
-	error = 0;
-	printf("test_cgroup_storage:PASS\n");
-
-err:
-	cleanup_cgroup_environment();
-	free(percpu_value);
-
-out:
-	return error;
-}

-- 
2.45.2


