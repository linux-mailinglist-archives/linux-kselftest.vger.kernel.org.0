Return-Path: <linux-kselftest+bounces-14835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD9948AAC
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 09:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D211FB23A7A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7391BC9E6;
	Tue,  6 Aug 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NyHQ2PJl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B615FA9E;
	Tue,  6 Aug 2024 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930924; cv=none; b=IGwGakvMW7EO0bgFb9Txi/CJT5i0aZzUKE/DrIvFiAX8G3xnDjTuukLIW6N6LJFWpmPMb89K4Zw+qWKnUEoMM9lQ5yxXsB3gbPVFQNydDxkabDC3Hi5c3IDDsCulLwA0hvc5MIn+cstWTQUOmwBfTgcgQMoDFDknVisxcKNLApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930924; c=relaxed/simple;
	bh=FvtON3vnVnnZCZ3E2pyQmbK2UAJjPFTAP4qXLS3xw1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbEfsfrC/k+Mhhe7Qa8PbAqzK6dsXqX0V/9SAyQQC2iCqWHda/RXH90xsoBAvp3Jfyr/yYcXZP2hqsigI5/x711YBblGTxLNWKBipFb3r5IlAbU+gwKvUvWeKCK7NAdPVP8y8vkWxgFRow87IeJPEnulx1e3H17lEBk5IKhOkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NyHQ2PJl; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C0FB240003;
	Tue,  6 Aug 2024 07:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722930919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sO8lKz7O6hxkJcjSOeilnZ84bEIRi95aoJoAfRfsais=;
	b=NyHQ2PJlqGGqwvgu3Lg5fixGlspIbK/CJKgzl3m6Yu+Nld2Jxr7Jbd/H1eKQ7LXvB8bPpX
	6+4ImWYJbUTwNUXodiSRfXR23jAitmAl5nEfZddlu7BYlxlIUozv9iayBdVKaF+SuDA5m9
	5Y+01nyYvxozQhDgYdb8yuX17EKfSMqDK3NuTkpEyzvJuogf3jSuIm+TiKrLUAJK4PCyDv
	at1+y/zHiglpKA4gA4384VgkMlPdqpWUPxrgxzLj+czF5kyul8LAJzn/XL7lkiC3O4U0dP
	3v3yBqwACXNnSi+nQnw0YW7SbY6HmSTSnJBmdaU0mPn/yRddlxuo45Hrq8qVnQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 06 Aug 2024 09:55:12 +0200
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: convert
 get_current_cgroup_id_user to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-convert_cgroup_tests-v2-1-180c57e5b710@bootlin.com>
References: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
In-Reply-To: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
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

get_current_cgroup_id_user allows testing for bpf_get_current_cgroup_id()
bpf API but is not integrated into test_progs, and so is not tested
automatically in CI.

Convert it to the test_progs framework to allow running it automatically.
The most notable differences with the old test are the following:
- the new test relies on autoattach instead of manually hooking/enabling
  the targeted tracepoint through perf_event, which reduces quite a lot the
  test code size
- it also accesses bpf prog data through global variables instead of maps
- sleep duration passed to nanosleep syscall has been reduced to its
  minimum to not impact overall CI duration (we only care about the syscall
  being properly triggered, not about the passed duration)

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- use global variables instead of maps

The new test_progs part has been tested in a local qemu environment:

  ./test_progs -a cgroup_get_current_cgroup_id
  47      cgroup_get_current_cgroup_id:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   3 +-
 tools/testing/selftests/bpf/get_cgroup_id_user.c   | 151 ---------------------
 .../bpf/prog_tests/cgroup_get_current_cgroup_id.c  |  45 ++++++
 .../selftests/bpf/progs/get_cgroup_id_kern.c       |  26 +---
 5 files changed, 50 insertions(+), 176 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 8f14d8faeb0b..7d4d5d3e0210 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -19,7 +19,6 @@ test_sock
 urandom_read
 test_sockmap
 test_lirc_mode2_user
-get_cgroup_id_user
 test_skb_cgroup_id_user
 test_cgroup_storage
 test_flow_dissector
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7e4b107b37b4..7e8f6354c115 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -67,7 +67,7 @@ endif
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_sock test_sockmap get_cgroup_id_user \
+	test_sock test_sockmap \
 	test_cgroup_storage \
 	test_tcpnotify_user test_sysctl \
 	test_progs-no_alu32
@@ -295,7 +295,6 @@ $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
-$(OUTPUT)/get_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_cgroup_storage: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sysctl: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
deleted file mode 100644
index aefd83ebdcd7..000000000000
--- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
+++ /dev/null
@@ -1,151 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <syscall.h>
-#include <unistd.h>
-#include <linux/perf_event.h>
-#include <sys/ioctl.h>
-#include <sys/time.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-
-#include <linux/bpf.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "cgroup_helpers.h"
-#include "testing_helpers.h"
-
-#define CHECK(condition, tag, format...) ({		\
-	int __ret = !!(condition);			\
-	if (__ret) {					\
-		printf("%s:FAIL:%s ", __func__, tag);	\
-		printf(format);				\
-	} else {					\
-		printf("%s:PASS:%s\n", __func__, tag);	\
-	}						\
-	__ret;						\
-})
-
-static int bpf_find_map(const char *test, struct bpf_object *obj,
-			const char *name)
-{
-	struct bpf_map *map;
-
-	map = bpf_object__find_map_by_name(obj, name);
-	if (!map)
-		return -1;
-	return bpf_map__fd(map);
-}
-
-#define TEST_CGROUP "/test-bpf-get-cgroup-id/"
-
-int main(int argc, char **argv)
-{
-	const char *probe_name = "syscalls/sys_enter_nanosleep";
-	const char *file = "get_cgroup_id_kern.bpf.o";
-	int err, bytes, efd, prog_fd, pmu_fd;
-	int cgroup_fd, cgidmap_fd, pidmap_fd;
-	struct perf_event_attr attr = {};
-	struct bpf_object *obj;
-	__u64 kcgid = 0, ucgid;
-	__u32 key = 0, pid;
-	int exit_code = 1;
-	char buf[256];
-	const struct timespec req = {
-		.tv_sec = 1,
-		.tv_nsec = 0,
-	};
-
-	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
-	if (CHECK(cgroup_fd < 0, "cgroup_setup_and_join", "err %d errno %d\n", cgroup_fd, errno))
-		return 1;
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "bpf_prog_test_load", "err %d errno %d\n", err, errno))
-		goto cleanup_cgroup_env;
-
-	cgidmap_fd = bpf_find_map(__func__, obj, "cg_ids");
-	if (CHECK(cgidmap_fd < 0, "bpf_find_map", "err %d errno %d\n",
-		  cgidmap_fd, errno))
-		goto close_prog;
-
-	pidmap_fd = bpf_find_map(__func__, obj, "pidmap");
-	if (CHECK(pidmap_fd < 0, "bpf_find_map", "err %d errno %d\n",
-		  pidmap_fd, errno))
-		goto close_prog;
-
-	pid = getpid();
-	bpf_map_update_elem(pidmap_fd, &key, &pid, 0);
-
-	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
-		snprintf(buf, sizeof(buf),
-			 "/sys/kernel/tracing/events/%s/id", probe_name);
-	} else {
-		snprintf(buf, sizeof(buf),
-			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
-	}
-	efd = open(buf, O_RDONLY, 0);
-	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
-		goto close_prog;
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (CHECK(bytes <= 0 || bytes >= sizeof(buf), "read",
-		  "bytes %d errno %d\n", bytes, errno))
-		goto close_prog;
-
-	attr.config = strtol(buf, NULL, 0);
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-
-	/* attach to this pid so the all bpf invocations will be in the
-	 * cgroup associated with this pid.
-	 */
-	pmu_fd = syscall(__NR_perf_event_open, &attr, getpid(), -1, -1, 0);
-	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n", pmu_fd,
-		  errno))
-		goto close_prog;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n", err,
-		  errno))
-		goto close_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n", err,
-		  errno))
-		goto close_pmu;
-
-	/* trigger some syscalls */
-	syscall(__NR_nanosleep, &req, NULL);
-
-	err = bpf_map_lookup_elem(cgidmap_fd, &key, &kcgid);
-	if (CHECK(err, "bpf_map_lookup_elem", "err %d errno %d\n", err, errno))
-		goto close_pmu;
-
-	ucgid = get_cgroup_id(TEST_CGROUP);
-	if (CHECK(kcgid != ucgid, "compare_cgroup_id",
-		  "kern cgid %llx user cgid %llx", kcgid, ucgid))
-		goto close_pmu;
-
-	exit_code = 0;
-	printf("%s:PASS\n", argv[0]);
-
-close_pmu:
-	close(pmu_fd);
-close_prog:
-	bpf_object__close(obj);
-cleanup_cgroup_env:
-	cleanup_cgroup_environment();
-	return exit_code;
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_get_current_cgroup_id.c b/tools/testing/selftests/bpf/prog_tests/cgroup_get_current_cgroup_id.c
new file mode 100644
index 000000000000..ceb192dbb5ba
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_get_current_cgroup_id.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include "test_progs.h"
+#include "cgroup_helpers.h"
+#include "get_cgroup_id_kern.skel.h"
+
+#define TEST_CGROUP "/test-bpf-get-cgroup-id/"
+
+void test_cgroup_get_current_cgroup_id(void)
+{
+	struct get_cgroup_id_kern *skel;
+	const struct timespec req = {
+		.tv_sec = 0,
+		.tv_nsec = 1,
+	};
+	int cgroup_fd;
+	__u64 ucgid;
+
+	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
+	if (!ASSERT_OK_FD(cgroup_fd, "cgroup switch"))
+		return;
+
+	skel = get_cgroup_id_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "load program"))
+		goto cleanup_cgroup;
+
+	if (!ASSERT_OK(get_cgroup_id_kern__attach(skel), "attach bpf program"))
+		goto cleanup_progs;
+
+	skel->bss->expected_pid = getpid();
+	/* trigger the syscall on which is attached the tested prog */
+	if (!ASSERT_OK(syscall(__NR_nanosleep, &req, NULL), "nanosleep"))
+		goto cleanup_progs;
+
+	ucgid = get_cgroup_id(TEST_CGROUP);
+
+	ASSERT_EQ(skel->bss->cg_id, ucgid, "compare cgroup ids");
+
+cleanup_progs:
+	get_cgroup_id_kern__destroy(skel);
+cleanup_cgroup:
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c b/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
index 68587b1de34e..30fd504856c7 100644
--- a/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
+++ b/tools/testing/selftests/bpf/progs/get_cgroup_id_kern.c
@@ -4,34 +4,16 @@
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u64);
-} cg_ids SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u32);
-} pidmap SEC(".maps");
+__u64 cg_id;
+__u64 expected_pid;
 
 SEC("tracepoint/syscalls/sys_enter_nanosleep")
 int trace(void *ctx)
 {
 	__u32 pid = bpf_get_current_pid_tgid();
-	__u32 key = 0, *expected_pid;
-	__u64 *val;
-
-	expected_pid = bpf_map_lookup_elem(&pidmap, &key);
-	if (!expected_pid || *expected_pid != pid)
-		return 0;
 
-	val = bpf_map_lookup_elem(&cg_ids, &key);
-	if (val)
-		*val = bpf_get_current_cgroup_id();
+	if (expected_pid == pid)
+		cg_id = bpf_get_current_cgroup_id();
 
 	return 0;
 }

-- 
2.46.0


