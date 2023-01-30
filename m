Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9468189D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 19:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbjA3SUF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 13:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbjA3STq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:46 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EDA2F79F
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 10:19:43 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h18so2709415ilj.6
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8GX0Wkc/Q+y5CtnCubAeAM7A8kJEXpZOTfFdtPApYY=;
        b=Fg3lU9wH1mI2ZQOlkoNVREVl34mm09TwXfzNvgtyh4leDB1b4UAR9PvjAG6xGyMwcv
         oZTwlycNAaxdx+gWUlIqWowBQlqBgSNFG7tswHZh+/K2hvKrHAvfuoT7TKLEnLTBn/4U
         FJaexkgBDmkWVUATraM/oVpHdiWbydCfky4lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8GX0Wkc/Q+y5CtnCubAeAM7A8kJEXpZOTfFdtPApYY=;
        b=eeyT+zt7lAEdp92qCRMRvFZ1qLoIvl+3LL0TKPoM29N+Dov8U/HnRt6uxqPBBp+aZ7
         Tb+gzOPFqmFCkvc9tWi1k9Yzs7ufVjiMF09bekaiQeo0CH8twvCznKELBN1NRJkxTRX/
         3rilsQHnbYC8gSsHKM09g7p2AEZpQGGs8OFBVSgRI6BRSuU1oS5LriD7G3AH8mdVZTDj
         ja+q0PpKAXWqqbZIE/qZd5jX8rwCmgpv5rtHMdXFp6GhAdAig3g7ZmKVT1kk3XJDjLuZ
         pkTSnPF/tG0peb+Z2BeR23Wi3x9H0Jn/ABfXCh7D3IDYe6XAgQ/qks1ooHiK80PZ5eBw
         p3gg==
X-Gm-Message-State: AO0yUKWq4V8iUg2wGcvGBvVdxvP7W5fg6W3dVLtSkHfQZCY9KqoF6f03
        3Hwpd2zmVOjZ5xPls9AZDAB4DA==
X-Google-Smtp-Source: AK7set+QENDfYDRT6I5+SqzDBq5LX7wHInhqO1KyMSbNn0tWkB0Z/osyYboUCBeBHuBoNxf9lXEXxQ==
X-Received: by 2002:a05:6e02:1c22:b0:310:e499:274e with SMTP id m2-20020a056e021c2200b00310e499274emr8094546ilh.18.1675102783165;
        Mon, 30 Jan 2023 10:19:43 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:42 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 3/9] selftests/bpf: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:09 -0700
Message-Id: <20230130181915.1113313-4-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

Many tests in the bpf selftest code still refer to this older debugfs
path, so let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/testing/selftests/bpf/get_cgroup_id_user.c          | 2 +-
 .../testing/selftests/bpf/prog_tests/kprobe_multi_test.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/trace_printk.c     | 2 +-
 tools/testing/selftests/bpf/prog_tests/trace_vprintk.c    | 2 +-
 tools/testing/selftests/bpf/progs/test_stacktrace_map.c   | 2 +-
 tools/testing/selftests/bpf/progs/test_tracepoint.c       | 2 +-
 tools/testing/selftests/bpf/test_ftrace.sh                | 2 +-
 tools/testing/selftests/bpf/test_tunnel.sh                | 8 ++++----
 tools/testing/selftests/bpf/trace_helpers.c               | 4 ++--
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
index 156743cf5870..478e080128be 100644
--- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
@@ -87,7 +87,7 @@ int main(int argc, char **argv)
 	bpf_map_update_elem(pidmap_fd, &key, &pid, 0);
 
 	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
+		 "/sys/kernel/tracing/events/%s/id", probe_name);
 	efd = open(buf, O_RDONLY, 0);
 	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
 		goto close_prog;
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index d457a55ff408..9eaf16e9ff6e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -338,7 +338,7 @@ static int get_syms(char ***symsp, size_t *cntp)
 	 * Filtering out duplicates by using hashmap__add, which won't
 	 * add existing entry.
 	 */
-	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
+	f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
 	if (!f)
 		return -EINVAL;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
index c717741bf8b6..6d70559fc19b 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
@@ -18,7 +18,7 @@ static void test_task_fd_query_tp_core(const char *probe_name,
 		goto close_prog;
 
 	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
+		 "/sys/kernel/tracing/events/%s/id", probe_name);
 	efd = open(buf, O_RDONLY, 0);
 	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
 		goto close_prog;
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index a479080533db..4308e3a828d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -17,7 +17,7 @@ void serial_test_tp_attach_query(void)
 		obj[i] = NULL;
 
 	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
+		 "/sys/kernel/tracing/events/sched/sched_switch/id");
 	efd = open(buf, O_RDONLY, 0);
 	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_printk.c b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
index cade7f12315f..ff50a928cb98 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_printk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_printk.c
@@ -5,7 +5,7 @@
 
 #include "trace_printk.lskel.h"
 
-#define TRACEBUF	"/sys/kernel/debug/tracing/trace_pipe"
+#define TRACEBUF	"/sys/kernel/tracing/trace_pipe"
 #define SEARCHMSG	"testing,testing"
 
 void serial_test_trace_printk(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
index 7a4e313e8558..e568d7f247ec 100644
--- a/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
+++ b/tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
@@ -5,7 +5,7 @@
 
 #include "trace_vprintk.lskel.h"
 
-#define TRACEBUF	"/sys/kernel/debug/tracing/trace_pipe"
+#define TRACEBUF	"/sys/kernel/tracing/trace_pipe"
 #define SEARCHMSG	"1,2,3,4,5,6,7,8,9,10"
 
 void serial_test_trace_vprintk(void)
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
index 20de7bb873bc..e3e2328a1b65 100755
--- a/tools/testing/selftests/bpf/test_ftrace.sh
+++ b/tools/testing/selftests/bpf/test_ftrace.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TR=/sys/kernel/debug/tracing/
+TR=/sys/kernel/tracing/
 clear_trace() { # reset trace output
     echo > $TR/trace
 }
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index e9ebc67d73f7..6927e586a3a2 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -542,7 +542,7 @@ setup_xfrm_tunnel()
 test_xfrm_tunnel()
 {
 	config_device
-	> /sys/kernel/debug/tracing/trace
+	> /sys/kernel/tracing/trace
 	setup_xfrm_tunnel
 	mkdir -p ${BPF_PIN_TUNNEL_DIR}
 	bpftool prog loadall ./test_tunnel_kern.o ${BPF_PIN_TUNNEL_DIR}
@@ -551,11 +551,11 @@ test_xfrm_tunnel()
 		${BPF_PIN_TUNNEL_DIR}/xfrm_get_state
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	sleep 1
-	grep "reqid 1" /sys/kernel/debug/tracing/trace
+	grep "reqid 1" /sys/kernel/tracing/trace
 	check_err $?
-	grep "spi 0x1" /sys/kernel/debug/tracing/trace
+	grep "spi 0x1" /sys/kernel/tracing/trace
 	check_err $?
-	grep "remote ip 0xac100164" /sys/kernel/debug/tracing/trace
+	grep "remote ip 0xac100164" /sys/kernel/tracing/trace
 	check_err $?
 	cleanup
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 9c4be2cdb21a..65895f5fb562 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -12,7 +12,7 @@
 #include <sys/mman.h>
 #include "trace_helpers.h"
 
-#define DEBUGFS "/sys/kernel/debug/tracing/"
+#define TRACEFS "/sys/kernel/tracing/"
 
 #define MAX_SYMS 300000
 static struct ksym syms[MAX_SYMS];
@@ -130,7 +130,7 @@ void read_trace_pipe(void)
 {
 	int trace_fd;
 
-	trace_fd = open(DEBUGFS "trace_pipe", O_RDONLY, 0);
+	trace_fd = open(TRACEFS "trace_pipe", O_RDONLY, 0);
 	if (trace_fd < 0)
 		return;
 
-- 
2.39.1.456.gfc5497dd1b-goog

