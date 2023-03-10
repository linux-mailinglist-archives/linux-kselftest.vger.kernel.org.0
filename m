Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0D6B55AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjCJXeO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 18:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjCJXeM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 18:34:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3998A62FE4;
        Fri, 10 Mar 2023 15:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF16361D7D;
        Fri, 10 Mar 2023 23:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD96DC433D2;
        Fri, 10 Mar 2023 23:33:53 +0000 (UTC)
Date:   Fri, 10 Mar 2023 18:33:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zwisler@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>,
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
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: use canonical ftrace
 path
Message-ID: <20230310183352.2943e633@gandalf.local.home>
In-Reply-To: <20230310175209.2130880-2-zwisler@kernel.org>
References: <20230310175209.2130880-1-zwisler@kernel.org>
        <20230310175209.2130880-2-zwisler@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 10 Mar 2023 10:52:09 -0700
zwisler@kernel.org wrote:

> diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
> index 156743cf5870..4fa61ac8a0ee 100644
> --- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
> +++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
> @@ -86,8 +86,12 @@ int main(int argc, char **argv)
>  	pid = getpid();
>  	bpf_map_update_elem(pidmap_fd, &key, &pid, 0);
>  
> -	snprintf(buf, sizeof(buf),
> -		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> +		snprintf(buf, sizeof(buf),
> +			 "/sys/kernel/tracing/events/%s/id", probe_name);
> +	else
> +		snprintf(buf, sizeof(buf),
> +			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);

I don't know how the BPF folks feel, but I do know some kernel developers
prefer that if you need to break a single command into multiple lines that
you then need to add brackets around it. As it makes it easier to read.

	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
		snprintf(buf, sizeof(buf),
			 "/sys/kernel/tracing/events/%s/id", probe_name);
	} else {
		snprintf(buf, sizeof(buf),
			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
	}



>  	efd = open(buf, O_RDONLY, 0);
>  	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
>  		goto close_prog;
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 113dba349a57..22be0a9a5a0a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -338,7 +338,12 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
>  	 * Filtering out duplicates by using hashmap__add, which won't
>  	 * add existing entry.
>  	 */
> -	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> +
> +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> +		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
> +	else
> +		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> +
>  	if (!f)
>  		return -EINVAL;
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> index c717741bf8b6..60f92fd3c37a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> @@ -17,8 +17,12 @@ static void test_task_fd_query_tp_core(const char *probe_name,
>  	if (CHECK(err, "bpf_prog_test_load", "err %d errno %d\n", err, errno))
>  		goto close_prog;
>  
> -	snprintf(buf, sizeof(buf),
> -		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> +		snprintf(buf, sizeof(buf),
> +			 "/sys/kernel/tracing/events/%s/id", probe_name);
> +	else
> +		snprintf(buf, sizeof(buf),
> +			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);

Same here.

>  	efd = open(buf, O_RDONLY, 0);
>  	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
>  		goto close_prog;
> diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> index 770fcc3bb1ba..d3e377fa8e9b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> @@ -16,8 +16,12 @@ void serial_test_tp_attach_query(void)
>  	for (i = 0; i < num_progs; i++)
>  		obj[i] = NULL;
>  
> -	snprintf(buf, sizeof(buf),
> -		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
> +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> +		snprintf(buf, sizeof(buf),
> +			 "/sys/kernel/tracing/events/sched/sched_switch/id");
> +	else
> +		snprintf(buf, sizeof(buf),
> +			 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");

and here.

But perhaps the BPF folks don't care?

-- Steve

>  	efd = open(buf, O_RDONLY, 0);
>  	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
>  		return;
