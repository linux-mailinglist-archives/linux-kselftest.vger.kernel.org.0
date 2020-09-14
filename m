Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF562693F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Sep 2020 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgINRrD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 13:47:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgINRqs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 13:46:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08EHUuPS128324;
        Mon, 14 Sep 2020 13:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=PJMppOhILtF+I4++Iv/JzPDYs9zo2E26U06FhVM6yNY=;
 b=hyCpxQqes49/5tI1lEEmANIR1lWSlMf10uDV0kp8AlxKHld0RbeelMNF/g7kiVGuNfEZ
 CfwiSZGc7vdyl3waCwozZ5S3apasDeUD/gIAk5MGHh/56OsisS3cfhIVdaiGfiqZIDHh
 JoIKSwbqPr7OVT5lKXoGI/wsNsjIp3ZrIVGkva7ss9NpDO0SEvMBcXClY7/+rOceVTYO
 MCfvxBRazJJkBMgyKDKWeAGmE7VMDIWZ1ycnoLUY4aBGmsB8XKoMxdQD72V4VN2xQU7G
 YDzSai5HxzBkM9nw4yGBSEYAibnOS72SEmspuggb7sySXLpw13JShSvufRWQPa+Xb8lP CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33jcs6rq58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 13:46:35 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08EHVFcA129928;
        Mon, 14 Sep 2020 13:46:35 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33jcs6rq51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 13:46:35 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08EHg9ID003788;
        Mon, 14 Sep 2020 17:46:34 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 33gny8wys6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Sep 2020 17:46:34 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08EHkTuG18219438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Sep 2020 17:46:29 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1BFE136051;
        Mon, 14 Sep 2020 17:46:32 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AA4E13604F;
        Mon, 14 Sep 2020 17:46:31 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.73.235])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 14 Sep 2020 17:46:31 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id BA8EC2E3885; Mon, 14 Sep 2020 23:16:25 +0530 (IST)
Date:   Mon, 14 Sep 2020 23:16:25 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        srivatsa@csail.mit.edu, shuah@kernel.org, npiggin@gmail.com,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
Subject: Re: [RFC v4 1/1] selftests/cpuidle: Add support for cpuidle latency
 measurement
Message-ID: <20200914174625.GB25628@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200902114506.45809-1-psampat@linux.ibm.com>
 <20200902114506.45809-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902114506.45809-2-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-14_06:2020-09-14,2020-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=2
 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009140138
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 02, 2020 at 05:15:06PM +0530, Pratik Rajesh Sampat wrote:
> Measure cpuidle latencies on wakeup to determine and compare with the
> advertsied wakeup latencies for each idle state.
> 
> Cpuidle wakeup latencies are determined for IPIs and Timer events and
> can help determine any deviations from what is advertsied by the
> hardware.
> 
> A baseline measurement for each case of IPI and timers is taken at
> 100 percent CPU usage to quantify for the kernel-userpsace overhead
> during execution.
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  tools/testing/selftests/Makefile          |   1 +
>  tools/testing/selftests/cpuidle/Makefile  |   7 +
>  tools/testing/selftests/cpuidle/cpuidle.c | 616 ++++++++++++++++++++++
>  tools/testing/selftests/cpuidle/settings  |   1 +
>  4 files changed, 625 insertions(+)
>  create mode 100644 tools/testing/selftests/cpuidle/Makefile
>  create mode 100644 tools/testing/selftests/cpuidle/cpuidle.c
>  create mode 100644 tools/testing/selftests/cpuidle/settings
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 9018f45d631d..2bb0e87f76fd 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -8,6 +8,7 @@ TARGETS += cgroup
>  TARGETS += clone3
>  TARGETS += core
>  TARGETS += cpufreq
> +TARGETS += cpuidle
>  TARGETS += cpu-hotplug
>  TARGETS += drivers/dma-buf
>  TARGETS += efivarfs
> diff --git a/tools/testing/selftests/cpuidle/Makefile b/tools/testing/selftests/cpuidle/Makefile
> new file mode 100644
> index 000000000000..d332485e1bc5
> --- /dev/null
> +++ b/tools/testing/selftests/cpuidle/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TEST_GEN_PROGS := cpuidle
> +
> +CFLAGS += -O2
> +LDLIBS += -lpthread
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/cpuidle/cpuidle.c b/tools/testing/selftests/cpuidle/cpuidle.c
> new file mode 100644
> index 000000000000..4b1e7a91f75c
> --- /dev/null
> +++ b/tools/testing/selftests/cpuidle/cpuidle.c
> @@ -0,0 +1,616 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Cpuidle latency measurement microbenchmark
> + *
> + * A mechanism to measure wakeup latency for IPI and Timer based interrupts
> + * Results of this microbenchmark can be used to check and validate against the
> + * advertised latencies for each cpuidle state
> + *
> + * IPIs (using pipes) and Timers are used to wake the CPU up and measure the
> + * time difference
> + *
> + * Usage:
> + *	./cpuidle --mode <full / quick / num_cpus> --output <output location>
> + *
> + * Copyright (C) 2020 Pratik Rajesh Sampat <psampat@linux.ibm.com>, IBM
> + */
> +
> +#define _GNU_SOURCE
> +#include <assert.h>
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/time.h>
> +#include <unistd.h>
> +
> +#define READ		0
> +#define WRITE		1
> +#define TIMEOUT_US	500000
> +
> +static int pipe_fd[2];
> +static int *cpu_list;
> +static int cpus;
> +static int idle_states;
> +static uint64_t *latency_list;
> +static uint64_t *residency_list;
> +
> +static char *log_file = "cpuidle.log";
> +
> +static int get_online_cpus(int *online_cpu_list, int total_cpus)
> +{
> +	char filename[80];
> +	int i, index = 0;
> +	FILE *fptr;
> +
> +	for (i = 0; i < total_cpus; i++) {
> +		char status;
> +
> +		sprintf(filename, "/sys/devices/system/cpu/cpu");
> +		sprintf(filename + strlen(filename), "%d%s", i, "/online");
> +		fptr = fopen(filename, "r");
> +		if (!fptr)
> +			continue;
> +		assert(fscanf(fptr, "%c", &status) != EOF);
> +		if (status == '1')
> +			online_cpu_list[index++] = i;
> +		fclose(fptr);
> +	}
> +	return index;
> +}
> +
> +static uint64_t us_to_ns(uint64_t val)
> +{
> +	return val * 1000;
> +}
> +
> +static void get_latency(int cpu)
> +{
> +	char filename[80];
> +	uint64_t latency;
> +	FILE *fptr;
> +	int state;
> +
> +	for (state = 0; state < idle_states; state++) {
> +		sprintf(filename, "%s%d%s%d%s", "/sys/devices/system/cpu/cpu",
> +			cpu, "/cpuidle/state",
> +			state, "/latency");
> +		fptr = fopen(filename, "r");
> +		assert(fptr);
> +
> +		assert(fscanf(fptr, "%ld", &latency) != EOF);
> +		latency_list[state] = latency;
> +		fclose(fptr);
> +	}
> +}
> +
> +static void get_residency(int cpu)
> +{
> +	uint64_t residency;
> +	char filename[80];
> +	FILE *fptr;
> +	int state;
> +
> +	for (state = 0; state < idle_states; state++) {
> +		sprintf(filename, "%s%d%s%d%s", "/sys/devices/system/cpu/cpu",
> +			cpu, "/cpuidle/state",
> +			state, "/residency");
> +		fptr = fopen(filename, "r");
> +		assert(fptr);
> +
> +		assert(fscanf(fptr, "%ld", &residency) != EOF);
> +		residency_list[state] = residency;
> +		fclose(fptr);
> +	}
> +}
> +
> +static int get_idle_state_count(int cpu)
> +{
> +	struct dirent *entry;
> +	int dir_count = 0;
> +	char filename[80];
> +	DIR *dirp;
> +
> +	sprintf(filename, "%s%d%s", "/sys/devices/system/cpu/cpu",
> +		cpu, "/cpuidle");
> +
> +	dirp = opendir(filename);
> +	if (!dirp)
> +		return -1;
> +	while (entry = readdir(dirp)) {
> +		if (entry->d_type == DT_DIR) {
> +			if (strcmp(entry->d_name, ".") == 0 ||
> +			    strcmp(entry->d_name, "..") == 0)
> +				continue;
> +			dir_count++;
> +		}
> +	}
> +	closedir(dirp);
> +	return dir_count;
> +}
> +
> +/* Enable or disable all idle states */
> +static int state_all_idle(char *disable)
> +{
> +	char filename[80];
> +	FILE *fptr;
> +	int i, j;
> +
> +	for (i = 0; i < cpus; i++) {
> +		for (j = 0; j < idle_states; j++) {
> +			sprintf(filename, "%s%d%s%d%s",
> +				"/sys/devices/system/cpu/cpu", cpu_list[i],
> +				"/cpuidle/state", j, "/disable");
> +			fptr = fopen(filename, "w");
> +			assert(fptr);
> +			fprintf(fptr, "%s", disable);
> +			fclose(fptr);
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* Disable all idle states */
> +static int cpuidle_disable_all_states(void)
> +{
> +	return state_all_idle("1");
> +}
> +
> +static int cpuidle_enable_all_states(void)
> +{
> +	return state_all_idle("0");
> +}
> +
> +static int state_operation(char *disable, int state)
> +{
> +	char filename[80];
> +	FILE *fptr;
> +	int i;
> +
> +	for (i = 0; i < cpus; i++) {
> +		sprintf(filename, "%s%d%s%d%s", "/sys/devices/system/cpu/cpu",
> +			cpu_list[i], "/cpuidle/state", state, "/disable");
> +		fptr = fopen(filename, "w");
> +		assert(fptr);
> +		fprintf(fptr, "%s", disable);
> +		fclose(fptr);
> +	}
> +	return 0;
> +}
> +
> +static int cpuidle_enable_state(int state)
> +{
> +	return state_operation("0", state);
> +}
> +
> +static int cpuidle_disable_state(int state)
> +{
> +	return state_operation("1", state);
> +}
> +
> +static uint64_t average(uint64_t *arr, int size)
> +{
> +	int i, sum = 0;
> +
> +	assert(size != 0);
> +	for (i = 0; i < size; i++)
> +		sum += arr[i];
> +	return sum / size;
> +}
> +
> +static pthread_t start_thread_on(void *(*fn)(void *), void *arg, uint64_t cpu)
> +{
> +	pthread_attr_t attr;
> +	cpu_set_t cpuset;
> +	pthread_t tid;
> +	int rc;
> +
> +	CPU_ZERO(&cpuset);
> +	CPU_SET(cpu, &cpuset);
> +
> +	rc = pthread_attr_init(&attr);
> +	if (rc) {
> +		perror("pthread_attr_init");
> +		exit(1);
> +	}
> +
> +	rc = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
> +	if (rc) {
> +		perror("pthread_attr_setaffinity_np");
> +		exit(1);
> +	}
> +
> +	rc = pthread_create(&tid, &attr, fn, arg);
> +	if (rc) {
> +		perror("pthread_create");
> +		exit(1);
> +	}
> +	return tid;
> +}
> +
> +void *util_full_cpu(void *unused)
> +{
> +	FILE *fptr;
> +
> +	fptr = fopen("/dev/null", "w");
> +	assert(fptr);
> +	while (1) {
> +		fprintf(fptr, "0");
> +		nanosleep((const struct timespec[]){{0, 10L}}, NULL);

It is not clear why the nanosleep is needed. Perhaps you want
the equivalent of cpu_relax() in the linux kernel ?





> +	}
> +	fclose(fptr);
> +}
> +
> +/* IPI based wakeup latencies */
> +struct latency {
> +	unsigned int src_cpu;
> +	unsigned int dest_cpu;
> +	struct timespec time_start;
> +	struct timespec time_end;
> +	uint64_t latency_ns;
> +} ipi_wakeup;
> +
> +static void *writer(void *unused)
> +{
> +	signed char c = 'P';
> +
> +	assert(write(pipe_fd[WRITE], &c, 1) == 1);
> +	ipi_wakeup.src_cpu = sched_getcpu();
> +
> +	return NULL;
> +}
> +
> +static void *reader(void *unused)
> +{
> +	signed char c;
> +
> +	assert(read(pipe_fd[READ], &c, 1) ==  1);
> +	ipi_wakeup.dest_cpu = sched_getcpu();
> +
> +	return NULL;
> +}
> +
> +static void ipi_test_once(int baseline, int src_cpu, int dest_cpu)
> +{
> +	pthread_t tid, tid1, baseline_tid;
> +
> +	if (baseline) {
> +		baseline_tid = start_thread_on(util_full_cpu, NULL, dest_cpu);
> +		/* Run process for long enough to gain 100% usage*/
> +		sleep(2);
> +	}
> +
> +	clock_gettime(CLOCK_REALTIME, &ipi_wakeup.time_start);
> +

If we capture the time_start here, it would also include the time
required to create a thread and run it on src_cpu.

Shouldn't we move clock_gettime(time_start) inside the writer, just
before the write(pipe) and another clock_gettime(time_end) in the
reader soon after the read(pipe) returns ?



> +	tid = start_thread_on(writer, NULL, src_cpu);
> +	pthread_join(tid, NULL);
> +	tid1 = start_thread_on(reader, NULL, dest_cpu);
> +	pthread_join(tid1, NULL);
> +
> +	clock_gettime(CLOCK_REALTIME, &ipi_wakeup.time_end);
> +	ipi_wakeup.latency_ns = (ipi_wakeup.time_end.tv_sec -
> +		ipi_wakeup.time_start.tv_sec) * 1000000000ULL +
> +		ipi_wakeup.time_end.tv_nsec - ipi_wakeup.time_start.tv_nsec;
> +
> +	if (baseline)
> +		pthread_cancel(baseline_tid);
> +}
> +
> +static void ipi_test(int src_cpu)
> +{
> +	uint64_t avg_arr[cpus], avg_latency;
> +	int cpu, state;
> +	FILE *fptr;
> +
> +	assert(cpuidle_disable_all_states() == 0);
> +
> +	if (pipe(pipe_fd))
> +		exit(1);
> +
> +	fptr = fopen(log_file, "a");
> +	fprintf(fptr, "----IPI TEST----\n");
> +
> +	fprintf(fptr, "----Baseline IPI Latency----\n");
> +	fprintf(fptr, "%s %10s %18s\n", "SRC_CPU", "DEST_CPU",
> +		"Baseline_latency(ns)");
> +	/* Run the test as dummy once to stablize */
> +	ipi_test_once(1, src_cpu, cpu_list[0]);
> +	for (cpu = 0; cpu < cpus; cpu++) {
> +		ipi_test_once(1, src_cpu, cpu_list[cpu]);
> +		fprintf(fptr, "%3d %10d %12ld\n", ipi_wakeup.src_cpu,
> +			ipi_wakeup.dest_cpu,
> +			ipi_wakeup.latency_ns);
> +		avg_arr[cpu] = ipi_wakeup.latency_ns;
> +	}
> +	avg_latency = average(avg_arr, cpus);
> +	fprintf(fptr, "Baseline average IPI latency(ns): %ld\n\n", avg_latency);
> +
> +	for (state = 0; state < idle_states; state++) {
> +		fprintf(fptr, "--Enabling state: %d--\n", state);
> +		assert(cpuidle_enable_state(state) == 0);
> +		fprintf(fptr, "%s %10s %18s\n", "SRC_CPU", "DEST_CPU",
> +			"IPI_Latency(ns)");
> +		for (cpu = 0; cpu < cpus; cpu++) {
> +			/* Allow sufficient cycles to go idle */
> +			sleep(1);
> +			ipi_test_once(0, src_cpu, cpu_list[cpu]);
> +			fprintf(fptr, "%3d %10d %18ld\n", ipi_wakeup.src_cpu,
> +				ipi_wakeup.dest_cpu,
> +				ipi_wakeup.latency_ns);
> +			avg_arr[cpu] = ipi_wakeup.latency_ns;
> +		}
> +		fprintf(fptr, "Expected Latency(ns): %ld\n",
> +			us_to_ns(latency_list[state]));
> +		avg_latency = average(avg_arr, cpus);
> +		fprintf(fptr, "Observed Average IPI latency(ns): %ld\n\n",
> +			avg_latency);
> +		assert(cpuidle_disable_state(state) == 0);
> +	}
> +
> +	assert(cpuidle_enable_all_states() == 0);
> +	fclose(fptr);
> +}
> +
> +/* Timer based wakeup latencies */
> +static int soak_done;
> +struct timer_data {
> +	unsigned int src_cpu;
> +	uint64_t timeout;
> +	struct timespec time_start;
> +	struct timespec time_end;
> +	uint64_t timeout_diff_ns;
> +} timer_wakeup;
> +
> +void catch_alarm(int sig)
> +{
> +	soak_done = 1;
> +}
> +
> +static void setup_timer(void)
> +{
> +	struct itimerval timer_settings = {};
> +	int err;
> +
> +	timer_settings.it_value.tv_usec = timer_wakeup.timeout;
> +	err = setitimer(ITIMER_REAL, &timer_settings, NULL);
> +	if (err < 0) {
> +		perror("failed to arm interval timer");
> +		exit(1);
> +	}
> +	signal(SIGALRM, catch_alarm);
> +	while (!soak_done)
> +		sleep(1);
> +}
> +
> +static void *queue_timer(void *timeout)
> +{
> +	timer_wakeup.src_cpu = sched_getcpu();
> +	timer_wakeup.timeout = (uint64_t)timeout;
> +	setup_timer();
> +
> +	return NULL;
> +}
> +
> +static void timeout_test_once(int baseline, uint64_t timeout, int dest_cpu)
> +{
> +	pthread_t tid, baseline_tid;
> +
> +	if (baseline) {
> +		baseline_tid = start_thread_on(util_full_cpu, NULL, dest_cpu);
> +		/* Run process for long enough to gain 100% usage */
> +		sleep(2);
> +	}
> +
> +	clock_gettime(CLOCK_REALTIME, &timer_wakeup.time_start);
> +

Here too, should we move the clock_gettime(time_start) in setup_timer()
just before calling setittimer() and clockgettime(time_end) in
catch_alarm() ?




> +	tid = start_thread_on(queue_timer, (void *)timeout, dest_cpu);
> +	pthread_join(tid, NULL);
> +
> +	clock_gettime(CLOCK_REALTIME, &timer_wakeup.time_end);
> +	timer_wakeup.timeout_diff_ns = (timer_wakeup.time_end.tv_sec -
> +		timer_wakeup.time_start.tv_sec) * 1000000000ULL +
> +		(timer_wakeup.time_end.tv_nsec - timer_wakeup.time_start.tv_nsec);
> +	if (baseline)
> +		pthread_cancel(baseline_tid);
> +}
> +
> +static void timeout_test(unsigned long timeout)
> +{
> +	uint64_t avg_arr[cpus], avg_timeout_diff;
> +	int state, cpu;
> +	FILE *fptr;
> +
> +	assert(cpuidle_disable_all_states() == 0);
> +	fptr = fopen(log_file, "a");
> +	fprintf(fptr, "----TIMEOUT TEST----\n");
> +
> +	fprintf(fptr, "----Baseline Timeout Latency diff----\n");
> +	fprintf(fptr, "%s %10s\n", "SRC_CPU", "Baseline_Latency(ns)");
> +	/* Run the test as dummy once to stablize */
> +	timeout_test_once(1, timeout, cpu_list[0]);
> +	for (cpu = 0; cpu < cpus; cpu++) {
> +		timeout_test_once(1, timeout, cpu_list[cpu]);
> +		fprintf(fptr, "%3d %11ld\n", timer_wakeup.src_cpu,
> +			timer_wakeup.timeout_diff_ns);
> +		avg_arr[cpu] = timer_wakeup.timeout_diff_ns;
> +	}
> +	avg_timeout_diff = average(avg_arr, cpus);
> +	fprintf(fptr, "Baseline Average Timeout diff(ns): %ld\n\n",
> +		avg_timeout_diff);
> +
> +	for (state = 0; state < idle_states; state++) {
> +		fprintf(fptr, "--Enabling state: %d--\n", state);
> +		assert(cpuidle_enable_state(state) == 0);
> +		fprintf(fptr, "%s %11s\n", "SRC_CPU", "Timeout_Latency(ns)");
> +		for (cpu = 0; cpu < cpus; cpu++) {
> +			/* Allow sufficient cycles to go idle */
> +			sleep(1);
> +			timeout_test_once(0, timeout,
> +					  cpu_list[cpu]);
> +			fprintf(fptr, "%3d %15ld\n", timer_wakeup.src_cpu,
> +				timer_wakeup.timeout_diff_ns);
> +			avg_arr[cpu] = timer_wakeup.timeout_diff_ns;
> +		}
> +		fprintf(fptr, "Expected Residency(ns): %ld\n",
> +			us_to_ns(residency_list[state]));
> +		avg_timeout_diff = average(avg_arr, cpus);
> +		fprintf(fptr, "Observed Average Timeout diff(ns): %ld\n\n",
> +			avg_timeout_diff);
> +		assert(cpuidle_disable_state(state) == 0);
> +	}
> +	assert(cpuidle_enable_all_states() == 0);
> +	fclose(fptr);
> +}
> +
> +static struct option options[] = {
> +	{"output", required_argument, 0, 'o'},
> +	{"mode", required_argument, 0, 'm'},
> +};
> +
> +static void usage(void)
> +{
> +	fprintf(stderr, "Usage: cpuidle <options>\n\n");
> +	fprintf(stderr, "\t\t--mode=X\t(quick / full / <num_cpus>)\n");
> +	fprintf(stderr, "\t\t--output=X\tOutput loc (def: cpuidle.log)\n\n");
> +}
> +
> +void get_n_random_cpus(int *shf_list, int shf_size, int *list, int n)
> +{
> +	/* Shuffle the Online CPU list */
> +	int i;
> +	int shuffle_index_list[shf_size];
> +
> +	for (i = 0; i < shf_size; i++)
> +		shuffle_index_list[i] = i;
> +	for (i = 0; i < shf_size; i++) {
> +		int idx = i + rand() % (shf_size - i);
> +		int temp = shuffle_index_list[i];
> +
> +		shuffle_index_list[i] = shuffle_index_list[idx];
> +		shuffle_index_list[idx] = temp;
> +	}
> +
> +	/* Pick the first n from the shf_list elements */
> +	for (i = 0; i < n; i++)
> +		list[i] = shf_list[shuffle_index_list[i]];
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int total_cpus, online_cpus, option_index = 0;
> +	int *online_cpu_list;
> +	signed char c;
> +	FILE *fptr;
> +
> +	if (getuid()) {
> +		fprintf(stderr, "cpuidle latency test must run as root\n");
> +		exit(1);
> +	}
> +
> +	total_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	online_cpu_list = malloc(total_cpus * sizeof(int));
> +	if (!online_cpu_list) {
> +		perror("Malloc failure");
> +		exit(1);
> +	}
> +
> +	online_cpus = get_online_cpus(&online_cpu_list[0], total_cpus);
> +	if (!online_cpus) {
> +		perror("Unable to get online CPUS");
> +		exit(1);
> +	}
> +
> +	/* Get one CPU for a quick test */
> +	cpus = 1;
> +	cpu_list = malloc(1 * sizeof(int));
> +	srand(time(NULL));
> +	cpu_list[0] = online_cpu_list[(rand() % online_cpus) + 1];
> +
> +	while (1) {
> +		c = getopt_long(argc, argv, "", options, &option_index);
> +		if (c == -1)
> +			break;
> +
> +		switch (c) {
> +		case 'o':
> +			log_file = optarg;
> +			break;
> +		case 'm':
> +			if (!strcmp(optarg, "full")) {
> +				cpu_list = realloc(cpu_list,
> +						   online_cpus * sizeof(int));
> +				memcpy(cpu_list, online_cpu_list,
> +				       online_cpus * sizeof(int));
> +				cpus = online_cpus;
> +			} else if (strcmp(optarg, "quick")) {
> +				int opt_cpus;
> +
> +				opt_cpus = atoi(optarg);
> +				if (!opt_cpus) {
> +					fprintf(stderr, "Error parsing mode\n");
> +					usage();
> +					exit(1);
> +				}
> +				if (opt_cpus > online_cpus) {
> +					fprintf(stderr, "Number of CPUS > Online CPUs\n");
> +					usage();
> +					exit(1);
> +				}
> +				cpu_list = realloc(cpu_list,
> +						   opt_cpus * sizeof(int));
> +				get_n_random_cpus(online_cpu_list, online_cpus,
> +						  &cpu_list[0], opt_cpus);
> +				cpus = opt_cpus;
> +			}
> +			break;
> +		default:
> +			usage();
> +			exit(1);
> +		}
> +	}
> +
> +	idle_states = get_idle_state_count(online_cpu_list[0]);
> +	if (idle_states == -1) {
> +		perror("Unable to get idle states");
> +		exit(1);
> +	}
> +
> +	fptr = fopen(log_file, "w+");
> +	fprintf(fptr, "cpuidle latency selftests. IPI & Timers\n");
> +	fprintf(fptr, "Number of CPUS: %d\n", total_cpus);
> +	fprintf(fptr, "Number of idle states: %d\n", idle_states);
> +	fclose(fptr);
> +
> +	latency_list = malloc(idle_states * sizeof(uint64_t));
> +	residency_list = malloc(idle_states * sizeof(uint64_t));
> +	if (!latency_list || !residency_list) {
> +		perror("Malloc failure");
> +		exit(1);
> +	}
> +
> +	get_latency(online_cpu_list[0]);
> +	get_residency(online_cpu_list[0]);
> +
> +	ipi_test(online_cpu_list[0]);
> +	printf("IPI test done\n");
> +	fflush(stdout);
> +
> +	timeout_test(TIMEOUT_US);
> +	printf("Timeout test done\n");
> +	fflush(stdout);
> +
> +	printf("Output logged at: %s\n", log_file);
> +
> +	free(latency_list);
> +	free(residency_list);
> +	free(cpu_list);
> +	free(online_cpu_list);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/cpuidle/settings b/tools/testing/selftests/cpuidle/settings
> new file mode 100644
> index 000000000000..e7b9417537fb
> --- /dev/null
> +++ b/tools/testing/selftests/cpuidle/settings
> @@ -0,0 +1 @@
> +timeout=0
> -- 
> 2.26.2
> 
