Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46893695708
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 03:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjBNC66 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 21:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBNC6q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 21:58:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53291E1C3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 18:57:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y125-20020a25c883000000b0086349255277so14367420ybf.8
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Feb 2023 18:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1X2XjCSWTS0Xt2U+9FcjOG0KGHQAkV0L4y9jO00ul8=;
        b=Jz3B8vjWMIfiSGvdijtz0pIAF82oGmD5/LXxTrKb6i7o7aCfKOxBSwLCVJCW6ZTOy3
         VWjY/bODigfBmyu8XjTUieBoX0zFJnOGdsJ9sF0+RPcn+2vWmYX/hr8rUmnvA6D0GrYH
         oHfbkr86mE/99Z4f6+k04v45m/VI1uaOjIGwDJflH9OeBcI0c3HprDPWQTOflTpl2Qrh
         NdkK2oBCKKzESCHRHfGZ8uZSV9OViMmkyOiV3OQQuh5EOXCRFPaa9dy+qzUJKyAKSHsB
         VqyQLMsmBhHkfNOmPcyERQjM7kx8uhqLS5uE1xhGrnL11U0xOXon2FhHrtkPvu6jO59x
         Ajcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1X2XjCSWTS0Xt2U+9FcjOG0KGHQAkV0L4y9jO00ul8=;
        b=fkphdfOJz5lmMyXE3dz6j7+YwHxjlSsTo4pA7njK9hDcOYTtouDWR6zaxGuE8JuDI5
         KP+qUcxXj/W9spz0oQjn2Yl+SieXdMIUwJNWjVoftw0Acy1Gj40vaBdDZ6PKknRUkz/Y
         T3PU8kfBaMEWk/W4Rrui2tpTrLdPDKrmdoXOwU5H95LSLyfanH4ueRelnfKYKc5/Ubxw
         93LF5+wdSFM4mS00gdaZqy3ZfL2RDgegrTYw5UTTN+UjNhtMqXBmn1oZa0d0eVzCUi+5
         dN87i80/q7K06HAJ8tbW8PiQ2cwRYVkV+cq5hsd7TOfm2da6qt1TWb9ojbugK8R3Fhmh
         ASYw==
X-Gm-Message-State: AO0yUKXa/o4UCOxcFMHQhorQzHcwrNV+oe8LvFpOHoAaWnCxhwg5lXO0
        DDSHZgvtUokTbQ9DrOS8H4wfvAY=
X-Google-Smtp-Source: AK7set+FZ6PYjIp0Bd4DuvC/w1q7HcNzSItU1Q3y6Mdoc+9GjxsosAUtZgOMTkm9xgLpVb0KYY44BSY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:ef42:0:b0:52f:7c8:c195 with SMTP id
 y63-20020a0def42000000b0052f07c8c195mr45214ywe.258.1676343438180; Mon, 13 Feb
 2023 18:57:18 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:57:16 -0800
In-Reply-To: <20230213221835.592763-1-zwisler@google.com>
Mime-Version: 1.0
References: <20230213221835.592763-1-zwisler@google.com>
Message-ID: <Y+r4jLwWvhcvyuih@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: use canonical ftrace path
From:   Stanislav Fomichev <sdf@google.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
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
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/13, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at  
> /sys/kernel/tracing.

> But, from Documentation/trace/ftrace.rst:

>    Before 4.1, all ftrace tracing control files were within the debugfs
>    file system, which is typically located at /sys/kernel/debug/tracing.
>    For backward compatibility, when mounting the debugfs file system,
>    the tracefs file system will be automatically mounted at:

>    /sys/kernel/debug/tracing

> Many comments and samples in the bpf code still refer to this older
> debugfs path, so let's update them to avoid confusion.  There are a few
> spots where the bpf code explicitly checks both tracefs and debugfs
> (tools/bpf/bpftool/tracelog.c and tools/lib/api/fs/fs.c) and I've left
> those alone so that the tools can continue to work with both paths.

Doesn't seem to apply cleanly to bpf-next?

https://github.com/kernel-patches/bpf/pull/4584

> Signed-off-by: Ross Zwisler <zwisler@google.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---

> [ Per Alexei's request, resending towards bpf-next ]

>   include/uapi/linux/bpf.h            | 8 ++++----
>   samples/bpf/cpustat_kern.c          | 4 ++--
>   samples/bpf/hbm.c                   | 4 ++--
>   samples/bpf/ibumad_kern.c           | 4 ++--
>   samples/bpf/lwt_len_hist.sh         | 2 +-
>   samples/bpf/offwaketime_kern.c      | 2 +-
>   samples/bpf/task_fd_query_user.c    | 4 ++--
>   samples/bpf/test_lwt_bpf.sh         | 2 +-
>   samples/bpf/test_overhead_tp_kern.c | 4 ++--
>   tools/include/uapi/linux/bpf.h      | 8 ++++----
>   10 files changed, 21 insertions(+), 21 deletions(-)

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 464ca3f01fe7..44387b31cbde 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1642,17 +1642,17 @@ union bpf_attr {
>    * 	Description
>    * 		This helper is a "printk()-like" facility for debugging. It
>    * 		prints a message defined by format *fmt* (of size *fmt_size*)
> - * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
> + * 		to file *\/sys/kernel/tracing/trace* from TraceFS, if
>    * 		available. It can take up to three additional **u64**
>    * 		arguments (as an eBPF helpers, the total number of arguments is
>    * 		limited to five).
>    *
>    * 		Each time the helper is called, it appends a line to the trace.
> - * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
> - * 		open, use *\/sys/kernel/debug/tracing/trace_pipe* to avoid this.
> + * 		Lines are discarded while *\/sys/kernel/tracing/trace* is
> + * 		open, use *\/sys/kernel/tracing/trace_pipe* to avoid this.
>    * 		The format of the trace is customizable, and the exact output
>    * 		one will get depends on the options set in
> - * 		*\/sys/kernel/debug/tracing/trace_options* (see also the
> + * 		*\/sys/kernel/tracing/trace_options* (see also the
>    * 		*README* file under the same directory). However, it usually
>    * 		defaults to something like:
>    *
> diff --git a/samples/bpf/cpustat_kern.c b/samples/bpf/cpustat_kern.c
> index 5aefd19cdfa1..944f13fe164a 100644
> --- a/samples/bpf/cpustat_kern.c
> +++ b/samples/bpf/cpustat_kern.c
> @@ -76,8 +76,8 @@ struct {

>   /*
>    * The trace events for cpu_idle and cpu_frequency are taken from:
> - * /sys/kernel/debug/tracing/events/power/cpu_idle/format
> - * /sys/kernel/debug/tracing/events/power/cpu_frequency/format
> + * /sys/kernel/tracing/events/power/cpu_idle/format
> + * /sys/kernel/tracing/events/power/cpu_frequency/format
>    *
>    * These two events have same format, so define one common structure.
>    */
> diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
> index 516fbac28b71..ff58ec43f56a 100644
> --- a/samples/bpf/hbm.c
> +++ b/samples/bpf/hbm.c
> @@ -65,7 +65,7 @@ static void Usage(void);
>   static void read_trace_pipe2(void);
>   static void do_error(char *msg, bool errno_flag);

> -#define DEBUGFS "/sys/kernel/debug/tracing/"
> +#define TRACEFS "/sys/kernel/tracing/"

>   static struct bpf_program *bpf_prog;
>   static struct bpf_object *obj;
> @@ -77,7 +77,7 @@ static void read_trace_pipe2(void)
>   	FILE *outf;
>   	char *outFname = "hbm_out.log";

> -	trace_fd = open(DEBUGFS "trace_pipe", O_RDONLY, 0);
> +	trace_fd = open(TRACEFS "trace_pipe", O_RDONLY, 0);
>   	if (trace_fd < 0) {
>   		printf("Error opening trace_pipe\n");
>   		return;
> diff --git a/samples/bpf/ibumad_kern.c b/samples/bpf/ibumad_kern.c
> index 9b193231024a..f07474c72525 100644
> --- a/samples/bpf/ibumad_kern.c
> +++ b/samples/bpf/ibumad_kern.c
> @@ -39,8 +39,8 @@ struct {
>   /* Taken from the current format defined in
>    * include/trace/events/ib_umad.h
>    * and
> - * /sys/kernel/debug/tracing/events/ib_umad/ib_umad_read/format
> - * /sys/kernel/debug/tracing/events/ib_umad/ib_umad_write/format
> + * /sys/kernel/tracing/events/ib_umad/ib_umad_read/format
> + * /sys/kernel/tracing/events/ib_umad/ib_umad_write/format
>    */
>   struct ib_umad_rw_args {
>   	u64 pad;
> diff --git a/samples/bpf/lwt_len_hist.sh b/samples/bpf/lwt_len_hist.sh
> index 0eda9754f50b..11fa0a087db6 100755
> --- a/samples/bpf/lwt_len_hist.sh
> +++ b/samples/bpf/lwt_len_hist.sh
> @@ -5,7 +5,7 @@ NS1=lwt_ns1
>   VETH0=tst_lwt1a
>   VETH1=tst_lwt1b

> -TRACE_ROOT=/sys/kernel/debug/tracing
> +TRACE_ROOT=/sys/kernel/tracing

>   function cleanup {
>   	# To reset saved histogram, remove pinned map
> diff --git a/samples/bpf/offwaketime_kern.c  
> b/samples/bpf/offwaketime_kern.c
> index eb4d94742e6b..23f12b47e9e5 100644
> --- a/samples/bpf/offwaketime_kern.c
> +++ b/samples/bpf/offwaketime_kern.c
> @@ -110,7 +110,7 @@ static inline int update_counts(void *ctx, u32 pid,  
> u64 delta)
>   }

>   #if 1
> -/* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format  
> */
> +/* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
>   struct sched_switch_args {
>   	unsigned long long pad;
>   	char prev_comm[TASK_COMM_LEN];
> diff --git a/samples/bpf/task_fd_query_user.c  
> b/samples/bpf/task_fd_query_user.c
> index a33d74bd3a4b..1e61f2180470 100644
> --- a/samples/bpf/task_fd_query_user.c
> +++ b/samples/bpf/task_fd_query_user.c
> @@ -235,7 +235,7 @@ static int test_debug_fs_uprobe(char *binary_path,  
> long offset, bool is_return)
>   	struct bpf_link *link;
>   	ssize_t bytes;

> -	snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/%s_events",
> +	snprintf(buf, sizeof(buf), "/sys/kernel/tracing/%s_events",
>   		 event_type);
>   	kfd = open(buf, O_WRONLY | O_TRUNC, 0);
>   	CHECK_PERROR_RET(kfd < 0);
> @@ -252,7 +252,7 @@ static int test_debug_fs_uprobe(char *binary_path,  
> long offset, bool is_return)
>   	close(kfd);
>   	kfd = -1;

> -	snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/events/%ss/%s/id",
> +	snprintf(buf, sizeof(buf), "/sys/kernel/tracing/events/%ss/%s/id",
>   		 event_type, event_alias);
>   	efd = open(buf, O_RDONLY, 0);
>   	CHECK_PERROR_RET(efd < 0);
> diff --git a/samples/bpf/test_lwt_bpf.sh b/samples/bpf/test_lwt_bpf.sh
> index 65a976058dd3..db5691e6637f 100755
> --- a/samples/bpf/test_lwt_bpf.sh
> +++ b/samples/bpf/test_lwt_bpf.sh
> @@ -19,7 +19,7 @@ IPVETH3="192.168.111.2"

>   IP_LOCAL="192.168.99.1"

> -TRACE_ROOT=/sys/kernel/debug/tracing
> +TRACE_ROOT=/sys/kernel/tracing

>   function lookup_mac()
>   {
> diff --git a/samples/bpf/test_overhead_tp_kern.c  
> b/samples/bpf/test_overhead_tp_kern.c
> index 80edadacb692..a1d53b0d8476 100644
> --- a/samples/bpf/test_overhead_tp_kern.c
> +++ b/samples/bpf/test_overhead_tp_kern.c
> @@ -8,7 +8,7 @@
>   #include <uapi/linux/bpf.h>
>   #include <bpf/bpf_helpers.h>

> -/* from /sys/kernel/debug/tracing/events/task/task_rename/format */
> +/* from /sys/kernel/tracing/events/task/task_rename/format */
>   struct task_rename {
>   	__u64 pad;
>   	__u32 pid;
> @@ -22,7 +22,7 @@ int prog(struct task_rename *ctx)
>   	return 0;
>   }

> -/* from /sys/kernel/debug/tracing/events/random/urandom_read/format */
> +/* from /sys/kernel/tracing/events/random/urandom_read/format */
>   struct urandom_read {
>   	__u64 pad;
>   	int got_bits;
> diff --git a/tools/include/uapi/linux/bpf.h  
> b/tools/include/uapi/linux/bpf.h
> index 464ca3f01fe7..44387b31cbde 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1642,17 +1642,17 @@ union bpf_attr {
>    * 	Description
>    * 		This helper is a "printk()-like" facility for debugging. It
>    * 		prints a message defined by format *fmt* (of size *fmt_size*)
> - * 		to file *\/sys/kernel/debug/tracing/trace* from DebugFS, if
> + * 		to file *\/sys/kernel/tracing/trace* from TraceFS, if
>    * 		available. It can take up to three additional **u64**
>    * 		arguments (as an eBPF helpers, the total number of arguments is
>    * 		limited to five).
>    *
>    * 		Each time the helper is called, it appends a line to the trace.
> - * 		Lines are discarded while *\/sys/kernel/debug/tracing/trace* is
> - * 		open, use *\/sys/kernel/debug/tracing/trace_pipe* to avoid this.
> + * 		Lines are discarded while *\/sys/kernel/tracing/trace* is
> + * 		open, use *\/sys/kernel/tracing/trace_pipe* to avoid this.
>    * 		The format of the trace is customizable, and the exact output
>    * 		one will get depends on the options set in
> - * 		*\/sys/kernel/debug/tracing/trace_options* (see also the
> + * 		*\/sys/kernel/tracing/trace_options* (see also the
>    * 		*README* file under the same directory). However, it usually
>    * 		defaults to something like:
>    *
> --
> 2.39.1.581.gbfd45094c4-goog

