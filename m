Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC0E6953A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBMWSr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 17:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBMWSq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 17:18:46 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF591BAF6
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 14:18:45 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h29so3928153ila.8
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 14:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjm/Vc/deIEaH+aQF6B66KE0Ii8SzYI9sL4Ts+fG4eA=;
        b=Gm/qU0V+m9CFby80dIGwz8Bvy4C+/h4E3Pu/RHB0UfUt/L7jEu+j2qIQDZJnf/40zR
         avAY5BR+DMqDa51rkrD/u1dh/tm/17aDn4x98iSAcAEa0PP1EBGCCQcBDFvX/+zzdcl2
         MKkXGM8djPSDHCCZUmMrXJKargpJhE+xKoNfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjm/Vc/deIEaH+aQF6B66KE0Ii8SzYI9sL4Ts+fG4eA=;
        b=qpYS184jy3zIEdG9vLp7QnFAkn5EFUr8aQ8LpiVxg/ZR/7ZgNOs/nQ9gl1HHM3iKOe
         Is2BUl6Lj+mWCRFioJlV0yHp8dyPyg16uWc1EYS5WQ2hju3hA0XqWWTRbS5Lf/VfpFHh
         Fy9pE+WSskrIwiKBnjSlNes/ByXsB/JJOScJ4lPRj7G6vF23f7QHUx5mGrTBafox4/OL
         QBVqcQGSZZl/csh75Ef84R68FgreipY+hFXuZrUpmHUp5sR7G3s1IeJBJs5Q8zsjvciL
         cMXzM4FcZrTAu3XnDnRJGz1yav5KDZdu4rC3y/sM4GngP+oLX9wcer9K4ufY7K9SfR22
         AiTA==
X-Gm-Message-State: AO0yUKV4JebupPD9ney7Trilkt3EqHAADKhB8TrPAnb2aUY8wltQFYwt
        u2dez15X+BMnz5OyY4Jgds71HA==
X-Google-Smtp-Source: AK7set+gq2QLXYYprC0FQNPa5EjSAce6ZInOpbMokOscNfVCC3OFfj7XGoSHJvKkfSquDYOUM2VErg==
X-Received: by 2002:a05:6e02:1c41:b0:315:415a:4e61 with SMTP id d1-20020a056e021c4100b00315415a4e61mr317985ilg.11.1676326724641;
        Mon, 13 Feb 2023 14:18:44 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:d644:5bf8:7c67:1ab8])
        by smtp.gmail.com with ESMTPSA id s8-20020a02cc88000000b003a60e5a2638sm4233508jap.94.2023.02.13.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:18:44 -0800 (PST)
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
Subject: [PATCH bpf-next 1/2] bpf: use canonical ftrace path
Date:   Mon, 13 Feb 2023 15:18:34 -0700
Message-Id: <20230213221835.592763-1-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
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

Many comments and samples in the bpf code still refer to this older
debugfs path, so let's update them to avoid confusion.  There are a few
spots where the bpf code explicitly checks both tracefs and debugfs
(tools/bpf/bpftool/tracelog.c and tools/lib/api/fs/fs.c) and I've left
those alone so that the tools can continue to work with both paths.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---

[ Per Alexei's request, resending towards bpf-next ]

 include/uapi/linux/bpf.h            | 8 ++++----
 samples/bpf/cpustat_kern.c          | 4 ++--
 samples/bpf/hbm.c                   | 4 ++--
 samples/bpf/ibumad_kern.c           | 4 ++--
 samples/bpf/lwt_len_hist.sh         | 2 +-
 samples/bpf/offwaketime_kern.c      | 2 +-
 samples/bpf/task_fd_query_user.c    | 4 ++--
 samples/bpf/test_lwt_bpf.sh         | 2 +-
 samples/bpf/test_overhead_tp_kern.c | 4 ++--
 tools/include/uapi/linux/bpf.h      | 8 ++++----
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 464ca3f01fe7..44387b31cbde 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1642,17 +1642,17 @@ union bpf_attr {
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
index 0eda9754f50b..11fa0a087db6 100755
--- a/samples/bpf/lwt_len_hist.sh
+++ b/samples/bpf/lwt_len_hist.sh
@@ -5,7 +5,7 @@ NS1=lwt_ns1
 VETH0=tst_lwt1a
 VETH1=tst_lwt1b
 
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
index 65a976058dd3..db5691e6637f 100755
--- a/samples/bpf/test_lwt_bpf.sh
+++ b/samples/bpf/test_lwt_bpf.sh
@@ -19,7 +19,7 @@ IPVETH3="192.168.111.2"
 
 IP_LOCAL="192.168.99.1"
 
-TRACE_ROOT=/sys/kernel/debug/tracing
+TRACE_ROOT=/sys/kernel/tracing
 
 function lookup_mac()
 {
diff --git a/samples/bpf/test_overhead_tp_kern.c b/samples/bpf/test_overhead_tp_kern.c
index 80edadacb692..a1d53b0d8476 100644
--- a/samples/bpf/test_overhead_tp_kern.c
+++ b/samples/bpf/test_overhead_tp_kern.c
@@ -8,7 +8,7 @@
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 
-/* from /sys/kernel/debug/tracing/events/task/task_rename/format */
+/* from /sys/kernel/tracing/events/task/task_rename/format */
 struct task_rename {
 	__u64 pad;
 	__u32 pid;
@@ -22,7 +22,7 @@ int prog(struct task_rename *ctx)
 	return 0;
 }
 
-/* from /sys/kernel/debug/tracing/events/random/urandom_read/format */
+/* from /sys/kernel/tracing/events/random/urandom_read/format */
 struct urandom_read {
 	__u64 pad;
 	int got_bits;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 464ca3f01fe7..44387b31cbde 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1642,17 +1642,17 @@ union bpf_attr {
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
2.39.1.581.gbfd45094c4-goog

