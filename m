Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353506953A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 23:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBMWSv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 17:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBMWSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 17:18:49 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CFD1C317
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 14:18:46 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id b9so5580824ila.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRWQduPmN91iFAS5BBJCNCcuPyWFBW+Nj2BiZbIFrWo=;
        b=cHwRGNoPEWFDIRtyTqHsxecvM7OojiMb4qU1yfogG5wYgk3a+8u4GK/+uwjhJinaSw
         TwQw+90Cj+tjRsaZ0tRq8TdcUS+mt/pkVIjprDUpUan5qxlCWiLng+/WWHknceaVVIDk
         Oo11X/cLi3F1fvUU983xzgJ/0lfpiU3Fr8UuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRWQduPmN91iFAS5BBJCNCcuPyWFBW+Nj2BiZbIFrWo=;
        b=vLu+bPPXWnwFWUOT361xmaA6glURocYm5XCl0Bspt7e7HloPA8h3W8udAw2QXPm/3C
         f0Ga6oat3ng0tzkOascGBbGCA1wgKdK8ODVwMCvzOQ+jcrvyR7r9wbz2Rr22xgmd93JU
         JSImCWu8EbnLY3OVqdzm+PPz6/ORZENTxWkjYibebDdK7UXWFwRwWSc8m1PcDeEqMxcz
         8MVdXCgeS5EpvpS/4/Dy+aW2ZuJJliyD936RNmU+OQf4mCIfFdkX2/SJsiC97wKPvr2G
         Mu8K5r0DsavKa+7I0aKCk30ONuD550DHbKlGsQ1c+/owX2Bn92qwu5/oCfMC+yXEQTS0
         Uwew==
X-Gm-Message-State: AO0yUKVhfdFMqhFYQQuolaKVvA3/jHhGWpfGVCV0lKGft/Vpyz2xkbMh
        af0jBIjtyNNoQn+m9sVzgWUNKA==
X-Google-Smtp-Source: AK7set89VlubTgzaLUf91OOFVU/glsOKFNCyHhNv+9INbUdipmkq/oitdjYBwf2S79zB5BALj4KMwQ==
X-Received: by 2002:a92:c54f:0:b0:315:4b70:8376 with SMTP id a15-20020a92c54f000000b003154b708376mr221388ilj.29.1676326725758;
        Mon, 13 Feb 2023 14:18:45 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:d644:5bf8:7c67:1ab8])
        by smtp.gmail.com with ESMTPSA id s8-20020a02cc88000000b003a60e5a2638sm4233508jap.94.2023.02.13.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:18:45 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
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
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: use canonical ftrace path
Date:   Mon, 13 Feb 2023 15:18:35 -0700
Message-Id: <20230213221835.592763-2-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
In-Reply-To: <20230213221835.592763-1-zwisler@google.com>
References: <20230213221835.592763-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---

[ Per Alexei's request, resending towards bpf-next ]

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
index c6f37e825f11..6f0f2d8984db 100644
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
index 2eaedc1d9ed3..bbbd242f7cef 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -543,7 +543,7 @@ setup_xfrm_tunnel()
 test_xfrm_tunnel()
 {
 	config_device
-	> /sys/kernel/debug/tracing/trace
+	> /sys/kernel/tracing/trace
 	setup_xfrm_tunnel
 	mkdir -p ${BPF_PIN_TUNNEL_DIR}
 	bpftool prog loadall ${BPF_FILE} ${BPF_PIN_TUNNEL_DIR}
@@ -552,11 +552,11 @@ test_xfrm_tunnel()
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
index 09a16a77bae4..d2816aa35a9b 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -12,7 +12,7 @@
 #include <sys/mman.h>
 #include "trace_helpers.h"
 
-#define DEBUGFS "/sys/kernel/debug/tracing/"
+#define TRACEFS "/sys/kernel/tracing/"
 
 #define MAX_SYMS 300000
 static struct ksym syms[MAX_SYMS];
@@ -136,7 +136,7 @@ void read_trace_pipe(void)
 {
 	int trace_fd;
 
-	trace_fd = open(DEBUGFS "trace_pipe", O_RDONLY, 0);
+	trace_fd = open(TRACEFS "trace_pipe", O_RDONLY, 0);
 	if (trace_fd < 0)
 		return;
 
-- 
2.39.1.581.gbfd45094c4-goog

