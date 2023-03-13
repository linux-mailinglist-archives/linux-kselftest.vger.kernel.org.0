Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659506B833A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCMU5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCMU5h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 16:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE28ABF0;
        Mon, 13 Mar 2023 13:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13FF9614E7;
        Mon, 13 Mar 2023 20:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7C3C433EF;
        Mon, 13 Mar 2023 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678741053;
        bh=vFAwScw+LRgSosrH7cgs0qwCan40eQRqicvDOpDEnDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTANyfFq9VBJd24YKvb0LmktP1Zi9dFqV9xstPdbGjgAL0IUJvWgXwCXx+M/8gVri
         mv23+SfZrccq/V426CWEtpJFM4354IXFxVVmGjB0lbiYOr5RnLcguz0TOIz9Rwu2/f
         4PFmdzL9Uv4Bc0cys+8t+B+Aq7TS9672WnJZiMwwa3Csfl3TiLyrQNr9MyhWaTGy39
         bI+w1bfqieC4STYdgiMK1xQs9zdnsvW8lJoPC/EY6sXiFgVaq1RNg4FLcGD/bnhWEa
         gLhp7OZsIQcyT7b6o3QdLlEO3E8UPkZhwGhqfZsYm4HuE90C3yufcZUIAY8VdaUho4
         4AVMWExNnyh/g==
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
Subject: [PATCH bpf-next v4 1/2] bpf: use canonical ftrace path
Date:   Mon, 13 Mar 2023 14:56:27 -0600
Message-Id: <20230313205628.1058720-2-zwisler@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230313205628.1058720-1-zwisler@kernel.org>
References: <20230310192050.4096886-1-zwisler@kernel.org>
 <20230313205628.1058720-1-zwisler@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

Many comments and samples in the bpf code still refer to this older
debugfs path, so let's update them to avoid confusion.  There are a few
spots where the bpf code explicitly checks both tracefs and debugfs
(tools/bpf/bpftool/tracelog.c and tools/lib/api/fs/fs.c) and I've left
those alone so that the tools can continue to work with both paths.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/uapi/linux/bpf.h           | 8 ++++----
 samples/bpf/cpustat_kern.c         | 4 ++--
 samples/bpf/hbm.c                  | 4 ++--
 samples/bpf/ibumad_kern.c          | 4 ++--
 samples/bpf/lwt_len_hist.sh        | 2 +-
 samples/bpf/offwaketime_kern.c     | 2 +-
 samples/bpf/task_fd_query_user.c   | 4 ++--
 samples/bpf/test_lwt_bpf.sh        | 2 +-
 samples/bpf/test_overhead_tp.bpf.c | 4 ++--
 tools/include/uapi/linux/bpf.h     | 8 ++++----
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d8c534e05b0a..13129df937cd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1647,17 +1647,17 @@ union bpf_attr {
  * 	Description
  * 		This helper is a "printk()-like" facility for debugging. It
  * 		prints a message defined by format *fmt* (of size *fmt_size*)
- * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
+ * 		to file *\/sys/kernel/tracing/trace* from TraceFS, if
  * 		available. It can take up to three additional **u64**
  * 		arguments (as an eBPF helpers, the total number of arguments is
  * 		limited to five).
  *
  * 		Each time the helper is called, it appends a line to the trace.
- * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
- * 		open, use *\/sys/kernel/debug/tracing/trace_pipe* to avoid this.
+ * 		Lines are discarded while *\/sys/kernel/tracing/trace* is
+ * 		open, use *\/sys/kernel/tracing/trace_pipe* to avoid this.
  * 		The format of the trace is customizable, and the exact output
  * 		one will get depends on the options set in
- * 		*\/sys/kernel/debug/tracing/trace_options* (see also the
+ * 		*\/sys/kernel/tracing/trace_options* (see also the
  * 		*README* file under the same directory). However, it usually
  * 		defaults to something like:
  *
diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
index 5aefd19cdfa1..944f13fe164a 100644
--- a/samples/bpf/cpustat_kern.c
+++ b/samples/bpf/cpustat_kern.c
@@ -76,8 +76,8 @@ struct {
 
 /*
  * The trace events for cpu_idle and cpu_frequency are taken from:
- * /sys/kernel/debug/tracing/events/power/cpu_idle/format
- * /sys/kernel/debug/tracing/events/power/cpu_frequency/format
+ * /sys/kernel/tracing/events/power/cpu_idle/format
+ * /sys/kernel/tracing/events/power/cpu_frequency/format
  *
  * These two events have same format, so define one common structure.
  */
diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index 516fbac28b71..ff58ec43f56a 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -65,7 +65,7 @@ static void Usage(void);
 static void read_trace_pipe2(void);
 static void do_error(char *msg, bool errno_flag);
 
-#define DEBUGFS "/sys/kernel/debug/tracing/"
+#define TRACEFS "/sys/kernel/tracing/"
 
 static struct bpf_program *bpf_prog;
 static struct bpf_object *obj;
@@ -77,7 +77,7 @@ static void read_trace_pipe2(void)
 	FILE *outf;
 	char *outFname = "hbm_out.log";
 
-	trace_fd = open(DEBUGFS "trace_pipe", O_RDONLY, 0);
+	trace_fd = open(TRACEFS "trace_pipe", O_RDONLY, 0);
 	if (trace_fd < 0) {
 		printf("Error opening trace_pipe\n");
 		return;
diff --git a/samples/bpf/ibumad_kern.c b/samples/bpf/ibumad_kern.c
index 9b193231024a..f07474c72525 100644
--- a/samples/bpf/ibumad_kern.c
+++ b/samples/bpf/ibumad_kern.c
@@ -39,8 +39,8 @@ struct {
 /* Taken from the current format defined in
  * include/trace/events/ib_umad.h
  * and
- * /sys/kernel/debug/tracing/events/ib_umad/ib_umad_read/format
- * /sys/kernel/debug/tracing/events/ib_umad/ib_umad_write/format
+ * /sys/kernel/tracing/events/ib_umad/ib_umad_read/format
+ * /sys/kernel/tracing/events/ib_umad/ib_umad_write/format
  */
 struct ib_umad_rw_args {
 	u64 pad;
diff --git a/samples/bpf/lwt_len_hist.sh b/samples/bpf/lwt_len_hist.sh
index 7078bfcc4f4d..381b2c634784 100755
--- a/samples/bpf/lwt_len_hist.sh
+++ b/samples/bpf/lwt_len_hist.sh
@@ -5,7 +5,7 @@ NS1=lwt_ns1
 VETH0=tst_lwt1a
 VETH1=tst_lwt1b
 BPF_PROG=lwt_len_hist.bpf.o
-TRACE_ROOT=/sys/kernel/debug/tracing
+TRACE_ROOT=/sys/kernel/tracing
 
 function cleanup {
 	# To reset saved histogram, remove pinned map
diff --git a/samples/bpf/offwaketime_kern.c b/samples/bpf/offwaketime_kern.c
index eb4d94742e6b..23f12b47e9e5 100644
--- a/samples/bpf/offwaketime_kern.c
+++ b/samples/bpf/offwaketime_kern.c
@@ -110,7 +110,7 @@ static inline int update_counts(void *ctx, u32 pid, u64 delta)
 }
 
 #if 1
-/* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
+/* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
 	char prev_comm[TASK_COMM_LEN];
diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index a33d74bd3a4b..1e61f2180470 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -235,7 +235,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 	struct bpf_link *link;
 	ssize_t bytes;
 
-	snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/%s_events",
+	snprintf(buf, sizeof(buf), "/sys/kernel/tracing/%s_events",
 		 event_type);
 	kfd = open(buf, O_WRONLY | O_TRUNC, 0);
 	CHECK_PERROR_RET(kfd < 0);
@@ -252,7 +252,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 	close(kfd);
 	kfd = -1;
 
-	snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/events/%ss/%s/id",
+	snprintf(buf, sizeof(buf), "/sys/kernel/tracing/events/%ss/%s/id",
 		 event_type, event_alias);
 	efd = open(buf, O_RDONLY, 0);
 	CHECK_PERROR_RET(efd < 0);
diff --git a/samples/bpf/test_lwt_bpf.sh b/samples/bpf/test_lwt_bpf.sh
index 2e9f5126963b..0bf2d0f6bf4b 100755
--- a/samples/bpf/test_lwt_bpf.sh
+++ b/samples/bpf/test_lwt_bpf.sh
@@ -21,7 +21,7 @@ IP_LOCAL="192.168.99.1"
 
 PROG_SRC="test_lwt_bpf.c"
 BPF_PROG="test_lwt_bpf.o"
-TRACE_ROOT=/sys/kernel/debug/tracing
+TRACE_ROOT=/sys/kernel/tracing
 CONTEXT_INFO=$(cat ${TRACE_ROOT}/trace_options | grep context)
 
 function lookup_mac()
diff --git a/samples/bpf/test_overhead_tp.bpf.c b/samples/bpf/test_overhead_tp.bpf.c
index 67cab3881969..8b498328e961 100644
--- a/samples/bpf/test_overhead_tp.bpf.c
+++ b/samples/bpf/test_overhead_tp.bpf.c
@@ -7,7 +7,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 
-/* from /sys/kernel/debug/tracing/events/task/task_rename/format */
+/* from /sys/kernel/tracing/events/task/task_rename/format */
 struct task_rename {
 	__u64 pad;
 	__u32 pid;
@@ -21,7 +21,7 @@ int prog(struct task_rename *ctx)
 	return 0;
 }
 
-/* from /sys/kernel/debug/tracing/events/fib/fib_table_lookup/format */
+/* from /sys/kernel/tracing/events/fib/fib_table_lookup/format */
 struct fib_table_lookup {
 	__u64 pad;
 	__u32 tb_id;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d8c534e05b0a..13129df937cd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1647,17 +1647,17 @@ union bpf_attr {
  * 	Description
  * 		This helper is a "printk()-like" facility for debugging. It
  * 		prints a message defined by format *fmt* (of size *fmt_size*)
- * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
+ * 		to file *\/sys/kernel/tracing/trace* from TraceFS, if
  * 		available. It can take up to three additional **u64**
  * 		arguments (as an eBPF helpers, the total number of arguments is
  * 		limited to five).
  *
  * 		Each time the helper is called, it appends a line to the trace.
- * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
- * 		open, use *\/sys/kernel/debug/tracing/trace_pipe* to avoid this.
+ * 		Lines are discarded while *\/sys/kernel/tracing/trace* is
+ * 		open, use *\/sys/kernel/tracing/trace_pipe* to avoid this.
  * 		The format of the trace is customizable, and the exact output
  * 		one will get depends on the options set in
- * 		*\/sys/kernel/debug/tracing/trace_options* (see also the
+ * 		*\/sys/kernel/tracing/trace_options* (see also the
  * 		*README* file under the same directory). However, it usually
  * 		defaults to something like:
  *
-- 
2.40.0.rc1.284.g88254d51c5-goog

