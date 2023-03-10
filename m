Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BF6B4F7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 18:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjCJRwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 12:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCJRwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 12:52:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB676161;
        Fri, 10 Mar 2023 09:52:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAB94B82089;
        Fri, 10 Mar 2023 17:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C410EC433D2;
        Fri, 10 Mar 2023 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678470738;
        bh=O+Esizz49eDVD0nZLwhoBoCxIFUOp9NOk9OqSnjPQP8=;
        h=From:To:Cc:Subject:Date:From;
        b=UkUlkxNlx5RfT2h9XJDJ+K6Ghs/ACyaUvyGJ4UfA8INn1gENYxXy8OgWanrAkr4xX
         XKI9IxAW8Un40yLb64V50xs1JAChu+0cT55iUaSCK2ucCoMlS65wKwaZKZJdJJ0GA1
         UmXCu1gx6dwF3LcDmuGjW5nlGgMmKHEvxuPMdmCqlfXEP8Td4033zQDkvCQ6EjFyNW
         CrOjtQdEEKTvJurefcUiExoE6WR0xXAYe65LHR+NLo9sau+YRzFpzxyfJLOLF3zLYP
         WbRLnY5G1A9Rh2w7jyMthUWa14xocBLUfuGYkBTPC+8QJ843LpPVSUZcKuBLpcT18L
         Yy3Ctl+ne6zFA==
From:   zwisler@kernel.org
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
        Yonghong Song <yhs@fb.com>, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH bpf-next v3 1/2] bpf: use canonical ftrace path
Date:   Fri, 10 Mar 2023 10:52:08 -0700
Message-Id: <20230310175209.2130880-1-zwisler@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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
---

v2 was submitted to bpf-next via a pair of pull requests:
	https://github.com/kernel-patches/bpf/pull/4672
	https://github.com/kernel-patches/bpf/pull/4648

The only change since v2 is that I rebased on the current bpf-next_base.

I've run this through all the BPF selftests on a local machine:
	sudo ./test_verifier
	sudo make run_tests

and didn't hit any regressions.  I've also tested to make sure each
modified selftest runs successfully with each path of tracefs (with and
without debugfs).

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

base-commit: d1d51a62d060d02f99ee407959e24ad10a40e053
prerequisite-patch-id: 9d1a70f239e7476600fe4018125df58a368dc725
prerequisite-patch-id: 29fea9a24684ec09762b277403d7bffffb25cdf3
prerequisite-patch-id: 9cb5a22a0f88413c393ddc29f264fbd96938c598
prerequisite-patch-id: 87ce0f3257a51e8cc06dd21ae3fa4102406ba4b4
prerequisite-patch-id: a46e67372e8493e5f7dab95f72281bd690cbeacf
prerequisite-patch-id: bae92ed6da92da5587f8d54fed5976c7dd6a468a
prerequisite-patch-id: c84726372fab0771a2c2ff0942f13a9556db8740
prerequisite-patch-id: 8a1a8806ec58ca208ee81f83557af90472fcba7f
prerequisite-patch-id: 0f7d6ec99549b042bc37603a2a9034853015a6d6
prerequisite-patch-id: 88a110f7993c374c6df429a1f67706e5abd65a02
prerequisite-patch-id: 3ada332d91275a471e9b65eb532571ef5caad4af
prerequisite-patch-id: e7ade2dda63127886579bf88f3eddda82d6a103b
prerequisite-patch-id: a49488cb1b167a9c85405c142cc3edb7bdb32c3d
prerequisite-patch-id: 9656ecd9c036e140d819c3929f01ac7264452382
prerequisite-patch-id: d1fa19bc1974a78632f48080b4eef3d4d6c07d3d
prerequisite-patch-id: 245b71b3aecf33a9d2a9609fc45f72ac50d1e92a
prerequisite-patch-id: 1253300de46fe258927fd3ddd5009a1468f6e69b
prerequisite-patch-id: 638e5805bdaa8842589729a26707c47a593464c2
prerequisite-patch-id: 1d08f9dfe4c360d566edbee925424b789e0f844b
prerequisite-patch-id: b6c73e77b10fc771566de294973334646cad4d44
prerequisite-patch-id: 57034da9a1b439c9fa3ecca69a099204a339502a
prerequisite-patch-id: ef11bfbcdf2239002958554e2dc5fbe8ec4d6e9a
prerequisite-patch-id: 68c01f7ca5b9c740b9259b73d97f168765c794d0
prerequisite-patch-id: 846110172a75fdaf1017da1fec3709fa301a5a47
prerequisite-patch-id: 8070c339fe5ce2e46b5de76b59d0a3f2c25d9abb
prerequisite-patch-id: c48cc68777605390db454b6392569ccdcd88cdc1
prerequisite-patch-id: 0d36d64d21de2d0df3ac31c5203a5cd868b4be47
prerequisite-patch-id: 6538cefc509c89e2375dcb6dc85d11fb6993474d
prerequisite-patch-id: dc57bbf1190a31aec332cab39f990ac568e6722d
prerequisite-patch-id: 0d90b60b4ce60024f31f576bab79453f6d480a8e
prerequisite-patch-id: 15c1914741be406aeee6c66332f079f3f8367751
prerequisite-patch-id: 78a735554858860fa695dd9e20bf7c5a41fafe20
prerequisite-patch-id: 238aaa7c1f55fdac815a6e14310d074c1ac70983
prerequisite-patch-id: d514061d937de74e8cc3d8848488a60dad2e2a2e
prerequisite-patch-id: 0f1a878f5768b886db78ea0fc6fe17d2297daa2e
prerequisite-patch-id: fa48be79a1e1e1c611d7975501a8f9dfa6f1c4fe
prerequisite-patch-id: 0a193e915faed8479f150c30ba0c335e288f634f
prerequisite-patch-id: 2cab00be3bb34454f98dac426301468e7ef12ad1
prerequisite-patch-id: daa2a81b90fda8ca09d11a35aff5a282e6f76ec2
prerequisite-patch-id: 5001694a51d83ed8ca428855b92b3ead261a469d
-- 
2.40.0.rc1.284.g88254d51c5-goog

