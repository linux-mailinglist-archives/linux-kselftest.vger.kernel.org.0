Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5F6B833E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCMU5o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCMU5k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 16:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B48C806;
        Mon, 13 Mar 2023 13:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7C7614B9;
        Mon, 13 Mar 2023 20:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD58C4339B;
        Mon, 13 Mar 2023 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678741055;
        bh=aydtj4mL2tU3ari7cLv4cu2dOzcNaunjmzlB61xvH/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTOltm9wWLNG9j9u+iB6PWlIdkqifElqjfrYzbbZCP55moAsTv76t71Tk/KL1Yfnd
         iLTqqBj1ghvech0kmYzDHyA57zZ0mx04KrHSGNdK5vzHfOH5zoW54y3eaH4DB5K7s1
         nqzRutmr4WlYYIUvjdpz7o+IkAMRWhSsySScZKacHaDrHugI1DJcIqe5BPQfqyL7Bx
         mMf9NgzmhS05xKewFCjPS807X0JV8927a7V+klzEZ22HL5abTEeZ+YC98YBuy0FWfM
         7V6zAsNjRpxvi0/rsH6PvWZp7bxnVOAHdQNuxzDWlFLdoyLaMrFh9M51iJptmoC+d6
         LdI65N53Krx9w==
From:   Ross Zwisler <zwisler@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: use canonical ftrace path
Date:   Mon, 13 Mar 2023 14:56:28 -0600
Message-Id: <20230313205628.1058720-3-zwisler@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230313205628.1058720-1-zwisler@kernel.org>
References: <20230310192050.4096886-1-zwisler@kernel.org>
 <20230313205628.1058720-1-zwisler@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

The canonical location for the tracefs filesystem is at
/sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

Many tests in the bpf selftest code still refer to this older debugfs
path, so let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/testing/selftests/bpf/get_cgroup_id_user.c    |  9 +++++++--
 .../selftests/bpf/prog_tests/kprobe_multi_test.c    |  7 ++++++-
 .../selftests/bpf/prog_tests/task_fd_query_tp.c     |  9 +++++++--
 .../selftests/bpf/prog_tests/tp_attach_query.c      |  9 +++++++--
 .../testing/selftests/bpf/prog_tests/trace_printk.c | 10 +++++++---
 .../selftests/bpf/prog_tests/trace_vprintk.c        | 10 +++++++---
 .../selftests/bpf/progs/test_stacktrace_map.c       |  2 +-
 tools/testing/selftests/bpf/progs/test_tracepoint.c |  2 +-
 tools/testing/selftests/bpf/test_ftrace.sh          |  7 ++++++-
 tools/testing/selftests/bpf/test_tunnel.sh          | 13 +++++++++----
 tools/testing/selftests/bpf/trace_helpers.c         |  8 ++++++--
 11 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
index 156743cf5870..aefd83ebdcd7 100644
--- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
@@ -86,8 +86,13 @@ int main(int argc, char **argv)
 	pid = getpid();
 	bpf_map_update_elem(pidmap_fd, &key, &pid, 0);
 
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
+		snprintf(buf, sizeof(buf),
+			 "/sys/kernel/tracing/events/%s/id", probe_name);
+	} else {
+		snprintf(buf, sizeof(buf),
+			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
+	}
 	efd = open(buf, O_RDONLY, 0);
 	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
 		goto close_prog;
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 113dba349a57..22be0a9a5a0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -338,7 +338,12 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
 	 * Filtering out duplicates by using hashmap__add, which won't
 	 * add existing entry.
 	 */
-	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
+		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
+	else
+		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+
 	if (!f)
 		return -EINVAL;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
index c717741bf8b6..c91eda624657 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
@@ -17,8 +17,13 @@ static void test_task_fd_query_tp_core(const char *probe_name,
 	if (CHECK(err, "bpf_prog_test_load", "err %d errno %d\n", err, errno))
 		goto close_prog;
 
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
+		snprintf(buf, sizeof(buf),
+			 "/sys/kernel/tracing/events/%s/id", probe_name);
+	} else {
+		snprintf(buf, sizeof(buf),
+			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
+	}
 	efd = open(buf, O_RDONLY, 0);
 	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
 		goto close_prog;
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index 770fcc3bb1ba..655d69f0ff0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -16,8 +16,13 @@ void serial_test_tp_attach_query(void)
 	for (i = 0; i < num_progs; i++)
 		obj[i] = NULL;
 
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
+	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
+		snprintf(buf, sizeof(buf),
+			 "/sys/kernel/tracing/events/sched/sched_switch/id");
+	} else {
+		snprintf(buf, sizeof(buf),
+			 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
+	}
 	efd = open(buf, O_RDONLY, 0);
 	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index cade7f12315f..7b9124d506a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -5,7 +5,8 @@
 
 #include "trace_printk.lskel.h"
 
-#define TRACEBUF	"/sys/kernel/debug/tracing/trace_pipe"
+#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
+#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 #define SEARCHMSG	"testing,testing"
 
 void serial_test_trace_printk(void)
@@ -34,8 +35,11 @@ void serial_test_trace_printk(void)
 	if (!ASSERT_OK(err, "trace_printk__attach"))
 		goto cleanup;
 
-	fp = fopen(TRACEBUF, "r");
-	if (!ASSERT_OK_PTR(fp, "fopen(TRACEBUF)"))
+	if (access(TRACEFS_PIPE, F_OK) == 0)
+		fp = fopen(TRACEFS_PIPE, "r");
+	else
+		fp = fopen(DEBUGFS_PIPE, "r");
+	if (!ASSERT_OK_PTR(fp, "fopen(TRACE_PIPE)"))
 		goto cleanup;
 
 	/* We do not want to wait forever if this test fails... */
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
index 7a4e313e8558..44ea2fd88f4c 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
@@ -5,7 +5,8 @@
 
 #include "trace_vprintk.lskel.h"
 
-#define TRACEBUF	"/sys/kernel/debug/tracing/trace_pipe"
+#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
+#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 #define SEARCHMSG	"1,2,3,4,5,6,7,8,9,10"
 
 void serial_test_trace_vprintk(void)
@@ -27,8 +28,11 @@ void serial_test_trace_vprintk(void)
 	if (!ASSERT_OK(err, "trace_vprintk__attach"))
 		goto cleanup;
 
-	fp = fopen(TRACEBUF, "r");
-	if (!ASSERT_OK_PTR(fp, "fopen(TRACEBUF)"))
+	if (access(TRACEFS_PIPE, F_OK) == 0)
+		fp = fopen(TRACEFS_PIPE, "r");
+	else
+		fp = fopen(DEBUGFS_PIPE, "r");
+	if (!ASSERT_OK_PTR(fp, "fopen(TRACE_PIPE)"))
 		goto cleanup;
 
 	/* We do not want to wait forever if this test fails... */
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
index 728dbd39eff0..47568007b668 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
@@ -38,7 +38,7 @@ struct {
 	__type(value, stack_trace_t);
 } stack_amap SEC(".maps");
 
-/* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
+/* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
 	char prev_comm[TASK_COMM_LEN];
diff --git a/tools/testing/selftests/bpf/progs/test_tracepoint.c b/tools/testing/selftests/bpf/progs/test_tracepoint.c
index 43bd7a20cc50..4cb8bbb6a320 100644
--- a/tools/testing/selftests/bpf/progs/test_tracepoint.c
+++ b/tools/testing/selftests/bpf/progs/test_tracepoint.c
@@ -4,7 +4,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
-/* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
+/* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
 	char prev_comm[TASK_COMM_LEN];
diff --git a/tools/testing/selftests/bpf/test_ftrace.sh b/tools/testing/selftests/bpf/test_ftrace.sh
index 20de7bb873bc..f5109eb0e951 100755
--- a/tools/testing/selftests/bpf/test_ftrace.sh
+++ b/tools/testing/selftests/bpf/test_ftrace.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 
-TR=/sys/kernel/debug/tracing/
+if [[ -e /sys/kernel/tracing/trace ]]; then
+    TR=/sys/kernel/tracing/
+else
+    TR=/sys/kernel/debug/tracing/
+fi
+
 clear_trace() { # reset trace output
     echo > $TR/trace
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 06857b689c11..2dec7dbf29a2 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -571,8 +571,13 @@ setup_xfrm_tunnel()
 
 test_xfrm_tunnel()
 {
+	if [[ -e /sys/kernel/tracing/trace ]]; then
+		TRACE=/sys/kernel/tracing/trace
+	else
+		TRACE=/sys/kernel/debug/tracing/trace
+	fi
 	config_device
-	> /sys/kernel/debug/tracing/trace
+	> ${TRACE}
 	setup_xfrm_tunnel
 	mkdir -p ${BPF_PIN_TUNNEL_DIR}
 	bpftool prog loadall ${BPF_FILE} ${BPF_PIN_TUNNEL_DIR}
@@ -581,11 +586,11 @@ test_xfrm_tunnel()
 		${BPF_PIN_TUNNEL_DIR}/xfrm_get_state
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	sleep 1
-	grep "reqid 1" /sys/kernel/debug/tracing/trace
+	grep "reqid 1" ${TRACE}
 	check_err $?
-	grep "spi 0x1" /sys/kernel/debug/tracing/trace
+	grep "spi 0x1" ${TRACE}
 	check_err $?
-	grep "remote ip 0xac100164" /sys/kernel/debug/tracing/trace
+	grep "remote ip 0xac100164" ${TRACE}
 	check_err $?
 	cleanup
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 09a16a77bae4..934bf28fc888 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -12,7 +12,8 @@
 #include <sys/mman.h>
 #include "trace_helpers.h"
 
-#define DEBUGFS "/sys/kernel/debug/tracing/"
+#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
+#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
 #define MAX_SYMS 300000
 static struct ksym syms[MAX_SYMS];
@@ -136,7 +137,10 @@ void read_trace_pipe(void)
 {
 	int trace_fd;
 
-	trace_fd = open(DEBUGFS "trace_pipe", O_RDONLY, 0);
+	if (access(TRACEFS_PIPE, F_OK) == 0)
+		trace_fd = open(TRACEFS_PIPE, O_RDONLY, 0);
+	else
+		trace_fd = open(DEBUGFS_PIPE, O_RDONLY, 0);
 	if (trace_fd < 0)
 		return;
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

