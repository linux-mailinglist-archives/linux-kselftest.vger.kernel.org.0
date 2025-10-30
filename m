Return-Path: <linux-kselftest+bounces-44442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEB0C2150E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 17:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6DB94F02BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C12DF3D1;
	Thu, 30 Oct 2025 16:49:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57882DA779;
	Thu, 30 Oct 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842996; cv=none; b=kE59az4kAp5tPD7rGwBEmpRolOdjyS4HjKIBJoPnIS+hKGrnG/ReS+C1s7atKRUJQ0xLz2syXHPqDcyUMcOYby+tL0UsKJ6OY9EINZwcWQdmtTHRQ08yqwwnh+gtQVpy1Gheh8s9kKvujmh1Ju3eL954e0P5yahWvQUUfBxhH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842996; c=relaxed/simple;
	bh=xBXXop6DwgY/LOfHo1QMV8rxS1rh9qDlpQtXncsKU+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cetnf90mthtWmDtFU0zTPISrRWUEynnH42SyexOepSMx6LRDPZXHvl3remwKbgWQ/zTHwlx19sxOcRgGudXw2uRcRyehIbK2vAIWTrafDY2XMFAnV9iE4P1Wl/uNsKm/6d7Z5lC92g5x0LW3/QXXtFxAE+5qJkVHlH5o3tmSZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3923B2C40;
	Thu, 30 Oct 2025 09:49:46 -0700 (PDT)
Received: from [10.57.36.244] (unknown [10.57.36.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24373F66E;
	Thu, 30 Oct 2025 09:49:50 -0700 (PDT)
Message-ID: <fcf2fe41-54bb-42af-a4ff-c3f39e62afdf@arm.com>
Date: Thu, 30 Oct 2025 16:49:48 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] selftests/sched_ext: Add test for sched_ext
 dl_server
To: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Luigi De Matteis <ldematteis123@gmail.com>, sched-ext@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-11-arighi@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251029191111.167537-11-arighi@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 19:08, Andrea Righi wrote:
> Add a selftest to validate the correct behavior of the deadline server
> for the ext_sched_class.
> 
> v3: - add a comment to explain the 4% threshold (Emil Tsalapatis)
> v2: - replaced occurences of CFS in the test with EXT (Joel Fernandes)
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
>  tools/testing/selftests/sched_ext/rt_stall.c  | 222 ++++++++++++++++++
>  3 files changed, 246 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
> 
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> index 5fe45f9c5f8fd..c9255d1499b6e 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -183,6 +183,7 @@ auto-test-targets :=			\
>  	select_cpu_dispatch_bad_dsq	\
>  	select_cpu_dispatch_dbl_dsp	\
>  	select_cpu_vtime		\
> +	rt_stall			\
>  	test_example			\
>  
>  testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
> new file mode 100644
> index 0000000000000..80086779dd1eb
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
> + *
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +
> +#include <scx/common.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +UEI_DEFINE(uei);
> +
> +void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops rt_stall_ops = {
> +	.exit			= (void *)rt_stall_exit,
> +	.name			= "rt_stall",
> +};
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
> new file mode 100644
> index 0000000000000..d0ffa0e72b37b
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/prctl.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <time.h>
> +#include <linux/sched.h>
> +#include <signal.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include "rt_stall.bpf.skel.h"
> +#include "scx_test.h"
> +#include "../kselftest.h"
> +
> +#define CORE_ID		0	/* CPU to pin tasks to */
> +#define RUN_TIME        5	/* How long to run the test in seconds */
> +
> +/* Simple busy-wait function for test tasks */
> +static void process_func(void)
> +{
> +	while (1) {
> +		/* Busy wait */
> +		for (volatile unsigned long i = 0; i < 10000000UL; i++)
> +			;
> +	}
> +}
> +
> +/* Set CPU affinity to a specific core */
> +static void set_affinity(int cpu)
> +{
> +	cpu_set_t mask;
> +
> +	CPU_ZERO(&mask);
> +	CPU_SET(cpu, &mask);
> +	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
> +		perror("sched_setaffinity");
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +/* Set task scheduling policy and priority */
> +static void set_sched(int policy, int priority)
> +{
> +	struct sched_param param;
> +
> +	param.sched_priority = priority;
> +	if (sched_setscheduler(0, policy, &param) != 0) {
> +		perror("sched_setscheduler");
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +/* Get process runtime from /proc/<pid>/stat */
> +static float get_process_runtime(int pid)
> +{
> +	char path[256];
> +	FILE *file;
> +	long utime, stime;
> +	int fields;
> +
> +	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
> +	file = fopen(path, "r");
> +	if (file == NULL) {
> +		perror("Failed to open stat file");
> +		return -1;
> +	}
> +
> +	/* Skip the first 13 fields and read the 14th and 15th */
> +	fields = fscanf(file,
> +			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
> +			&utime, &stime);
> +	fclose(file);
> +
> +	if (fields != 2) {
> +		fprintf(stderr, "Failed to read stat file\n");
> +		return -1;
> +	}
> +
> +	/* Calculate the total time spent in the process */
> +	long total_time = utime + stime;
> +	long ticks_per_second = sysconf(_SC_CLK_TCK);
> +	float runtime_seconds = total_time * 1.0 / ticks_per_second;
> +
> +	return runtime_seconds;
> +}
> +
> +static enum scx_test_status setup(void **ctx)
> +{
> +	struct rt_stall *skel;
> +
> +	skel = rt_stall__open();
> +	SCX_FAIL_IF(!skel, "Failed to open");
> +	SCX_ENUM_INIT(skel);
> +	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
> +
> +	*ctx = skel;
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static bool sched_stress_test(void)
> +{
> +	/*
> +	 * We're expecting the EXT task to get around 5% of CPU time when
> +	 * competing with the RT task (small 1% fluctuations are expected).
> +	 *
> +	 * However, the EXT task should get at least 4% of the CPU to prove
> +	 * that the EXT deadline server is working correctly. A percentage
> +	 * less than 4% indicates a bug where RT tasks can potentially
> +	 * stall SCHED_EXT tasks, causing the test to fail.
> +	 */
> +	const float expected_min_ratio = 0.04; /* 4% */
> +
> +	float ext_runtime, rt_runtime, actual_ratio;
> +	int ext_pid, rt_pid;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	/* Create and set up a EXT task */
> +	ext_pid = fork();
> +	if (ext_pid == 0) {
> +		set_affinity(CORE_ID);
> +		process_func();
> +		exit(0);
> +	} else if (ext_pid < 0) {
> +		perror("fork for EXT task");
> +		ksft_exit_fail();
> +	}
> +
> +	/* Create an RT task */
> +	rt_pid = fork();
> +	if (rt_pid == 0) {
> +		set_affinity(CORE_ID);
> +		set_sched(SCHED_FIFO, 50);
> +		process_func();
> +		exit(0);
> +	} else if (rt_pid < 0) {
> +		perror("fork for RT task");
> +		ksft_exit_fail();
> +	}
> +
> +	/* Let the processes run for the specified time */
> +	sleep(RUN_TIME);
> +
> +	/* Get runtime for the EXT task */
> +	ext_runtime = get_process_runtime(ext_pid);
> +	if (ext_runtime == -1)
> +		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", ext_pid);
> +	ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n",
> +		       ext_pid, ext_runtime);
> +
> +	/* Get runtime for the RT task */
> +	rt_runtime = get_process_runtime(rt_pid);
> +	if (rt_runtime == -1)
> +		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
> +	ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
> +
> +	/* Kill the processes */
> +	kill(ext_pid, SIGKILL);
> +	kill(rt_pid, SIGKILL);
> +	waitpid(ext_pid, NULL, 0);
> +	waitpid(rt_pid, NULL, 0);
> +
> +	/* Verify that the scx task got enough runtime */
> +	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
> +	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
> +
> +	if (actual_ratio >= expected_min_ratio) {
> +		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
> +				      expected_min_ratio * 100);
> +		return true;
> +	}
> +	ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
> +			      expected_min_ratio * 100);
> +	return false;
> +}
> +
> +static enum scx_test_status run(void *ctx)
> +{
> +	struct rt_stall *skel = ctx;
> +	struct bpf_link *link;
> +	bool res;
> +
> +	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
> +	SCX_FAIL_IF(!link, "Failed to attach scheduler");
> +
> +	res = sched_stress_test();
> +
> +	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
> +	bpf_link__destroy(link);
> +
> +	if (!res)
> +		ksft_exit_fail();
> +
> +	return SCX_TEST_PASS;
> +}
> +
> +static void cleanup(void *ctx)
> +{
> +	struct rt_stall *skel = ctx;
> +
> +	rt_stall__destroy(skel);
> +}
> +
> +struct scx_test rt_stall = {
> +	.name = "rt_stall",
> +	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
> +	.setup = setup,
> +	.run = run,
> +	.cleanup = cleanup,
> +};
> +REGISTER_SCX_TEST(&rt_stall)


I'd still prefer something like the below to also test if the
fair_server stop -> ext_server start -> fair_server start -> ext_server stop
flow works correctly, but FWIW
Tested-by: Christian Loehle <christian.loehle@arm.com>


------8<------
@@ -188,19 +188,24 @@ static bool sched_stress_test(void)
 static enum scx_test_status run(void *ctx)
 {
        struct rt_stall *skel = ctx;
-       struct bpf_link *link;
+       struct bpf_link *link = NULL;
        bool res;
 
-       link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
-       SCX_FAIL_IF(!link, "Failed to attach scheduler");
-
-       res = sched_stress_test();
-
-       SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
-       bpf_link__destroy(link);
-
-       if (!res)
-               ksft_exit_fail();
+       for (int i = 0; i < 4; i++) {
+               if (i % 2) {
+                       memset(&skel->data->uei, 0, sizeof(skel->data->uei));
+                       link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+                       SCX_FAIL_IF(!link, "Failed to attach scheduler");
+               }
+               res = sched_stress_test();
+               if (i % 2) {
+                       SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+                       bpf_link__destroy(link);
+               }
+
+               if (!res)
+                       ksft_exit_fail();
+       }
 
        return SCX_TEST_PASS;
 }


