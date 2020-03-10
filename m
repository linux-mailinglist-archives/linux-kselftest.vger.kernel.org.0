Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FFD180B3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 23:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJWO2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 18:14:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:9274 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJWO2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 18:14:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:14:27 -0700
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="242472036"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.10.135]) ([10.251.10.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Mar 2020 15:14:26 -0700
Subject: Re: [PATCH V1 10/13] selftests/resctrl: Change Cache Allocation
 Technology (CAT) test
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <51d0f3c928fbc310c85bac6de20745f69cbc423e.1583657204.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4ac6fd87-1393-f247-40ae-5d6e34403e0f@intel.com>
Date:   Tue, 10 Mar 2020 15:14:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <51d0f3c928fbc310c85bac6de20745f69cbc423e.1583657204.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

Not just specific to this patch but I think the prevalent use of global
variables that are initialized/used or allocated/released from a variety
of places within the code is creating traps. I seemed to have stumbled
on a few during this review so far but it is hard to keep track of and I
am not confident that I caught them all. Having the code be symmetrical
(allocate and free from same area or initialize and use from same area)
does help to avoid such complexity.

This patch and the patch that follows are both quite large and difficult
to keep track of all the collected changes. There seems to be
opportunity for separating it into logical changes. Some of my comments
may be just because I could not keep track of all that is changed at the
same time.

On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> The present CAT test case, spawns two processes that run in two different
> control groups with exclusive schemata and both the processes read a buffer
> from memory only once. Before reading the buffer, perf miss count is
> cleared and perf miss count is calculated for the read. Since the processes
> are reading through the buffer only once and initially all the buffer is in
> memory perf miss count will always be the same regardless of the cache size
> allocated by CAT to these processes. So, the test isn't testing CAT. Fix
> this issue by changing the CAT test case.
> 
> The updated CAT test runs a "critical" process with exclusive schemata that
> reads a buffer (same as the size of allocated cache) multiple times
> there-by utilizing the allocated cache and calculates perf miss rate for

Transitioning the description from "perf miss count" to "perf miss rate"
is subtle. It would be valuable to elaborate what is meant with "perf
miss rate".

> every read of the buffer. The average of this perf miss rate is saved. This
> value indicates the critical process self induced misses. Now, the
> "critical" process runs besides a "noisy" neighbor that is reading a buffer
> that is 10 times the size of LLC and both the processes are in different
> control groups with exclusive schematas. The average perf miss rate for
> "critical" process is calculated again and compared with the earlier value.
> If the difference between both these values is greater than 5% it means
> that "noisy" neighbor does have impact on "critical" process which means
> CAT is not working as expected and hence the test fails.
> 
> Reported-by: Reinette Chatre <reinette.chatre@intel.com>
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>  tools/testing/selftests/resctrl/cache.c         | 167 ++++++++-----
>  tools/testing/selftests/resctrl/cat_test.c      | 312 ++++++++++++++----------
>  tools/testing/selftests/resctrl/fill_buf.c      |  33 ++-
>  tools/testing/selftests/resctrl/resctrl.h       |   9 +-
>  tools/testing/selftests/resctrl/resctrl_tests.c |   2 +-
>  tools/testing/selftests/resctrl/resctrlfs.c     |  34 ++-
>  6 files changed, 352 insertions(+), 205 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> index be60d7d3f066..e30cdd7b851c 100644
> --- a/tools/testing/selftests/resctrl/cache.c
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -10,9 +10,9 @@ struct read_format {
>  	} values[2];
>  };
>  
> -static struct perf_event_attr pea_llc_miss;
> +static struct perf_event_attr pea_llc_miss, pea_llc_access;
>  static struct read_format rf_cqm;
> -static int fd_lm;
> +static int fd_lm, fd_la;
>  char llc_occup_path[1024];
>  
>  static void initialize_perf_event_attr(void)
> @@ -27,15 +27,30 @@ static void initialize_perf_event_attr(void)
>  	pea_llc_miss.inherit = 1;
>  	pea_llc_miss.exclude_guest = 1;
>  	pea_llc_miss.disabled = 1;
> +
> +	pea_llc_access.type = PERF_TYPE_HARDWARE;
> +	pea_llc_access.size = sizeof(struct perf_event_attr);
> +	pea_llc_access.read_format = PERF_FORMAT_GROUP;
> +	pea_llc_access.exclude_kernel = 1;
> +	pea_llc_access.exclude_hv = 1;
> +	pea_llc_access.exclude_idle = 1;
> +	pea_llc_access.exclude_callchain_kernel = 1;
> +	pea_llc_access.inherit = 1;
> +	pea_llc_access.exclude_guest = 1;
> +	pea_llc_access.disabled = 1;
> +

This initialization appears to duplicate the initialization done above.
Perhaps this function could be a wrapper that calls an initialization
function with pointer to perf_event_attr that initializes structure the
same?


>  }
>  
>  static void ioctl_perf_event_ioc_reset_enable(void)
>  {
>  	ioctl(fd_lm, PERF_EVENT_IOC_RESET, 0);
>  	ioctl(fd_lm, PERF_EVENT_IOC_ENABLE, 0);
> +
> +	ioctl(fd_la, PERF_EVENT_IOC_RESET, 0);
> +	ioctl(fd_la, PERF_EVENT_IOC_ENABLE, 0);
>  }

Here is more duplication.

>  
> -static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
> +static int perf_event_open_llc_miss_rate(pid_t pid, int cpu_no)
>  {
>  	fd_lm = perf_event_open(&pea_llc_miss, pid, cpu_no, -1,
>  				PERF_FLAG_FD_CLOEXEC);
> @@ -45,29 +60,40 @@ static int perf_event_open_llc_miss(pid_t pid, int cpu_no)
>  		return -1;
>  	}
>  
> +	fd_la = perf_event_open(&pea_llc_access, pid, cpu_no, fd_lm,
> +				PERF_FLAG_FD_CLOEXEC);
> +	if (fd_la == -1) {
> +		perror("Error opening member");
> +		ctrlc_handler(0, NULL, NULL);
> +		return -1;

Should fd_lm not be closed on this error path?

> +	}
> +
>  	return 0;
>  }
>  
> -static int initialize_llc_perf(void)
> +static void initialize_llc_perf(void)
>  {
>  	memset(&pea_llc_miss, 0, sizeof(struct perf_event_attr));
> +	memset(&pea_llc_access, 0, sizeof(struct perf_event_attr));
>  	memset(&rf_cqm, 0, sizeof(struct read_format));
>  
> -	/* Initialize perf_event_attr structures for HW_CACHE_MISSES */
> +	/*
> +	 * Initialize perf_event_attr structures for HW_CACHE_MISSES and
> +	 * HW_CACHE_REFERENCES
> +	 */
>  	initialize_perf_event_attr();
>  
>  	pea_llc_miss.config = PERF_COUNT_HW_CACHE_MISSES;
> +	pea_llc_access.config = PERF_COUNT_HW_CACHE_REFERENCES;
>  
> -	rf_cqm.nr = 1;
> -
> -	return 0;
> +	rf_cqm.nr = 2;
>  }
>  
>  static int reset_enable_llc_perf(pid_t pid, int cpu_no)
>  {
>  	int ret = 0;
>  
> -	ret = perf_event_open_llc_miss(pid, cpu_no);
> +	ret = perf_event_open_llc_miss_rate(pid, cpu_no);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -78,21 +104,21 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
>  }
>  
>  /*
> - * get_llc_perf:	llc cache miss through perf events
> - * @cpu_no:		CPU number that the benchmark PID is binded to
> + * get_llc_perf_miss_rate:	llc cache miss rate through perf events

Could "llc" be "LLC" to be consistent with below?

> + * @cpu_no:			CPU number that the benchmark PID is binded to
>   *
> - * Perf events like HW_CACHE_MISSES could be used to validate number of
> - * cache lines allocated.
> + * Perf events like HW_CACHE_MISSES and HW_CACHE_REFERENCES could be used to
> + * approximate LLc occupancy under controlled environment

s/LLc/LLC/

>   *
>   * Return: =0 on success.  <0 on failure.
>   */
> -static int get_llc_perf(unsigned long *llc_perf_miss)
> +static int get_llc_perf_miss_rate(float *llc_perf_miss_rate)
>  {
> -	__u64 total_misses;
> +	__u64 total_misses, total_references;
>  
>  	/* Stop counters after one span to get miss rate */
> -
>  	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
> +	ioctl(fd_la, PERF_EVENT_IOC_DISABLE, 0);
>  
>  	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
>  		perror("Could not get llc misses through perf");
> @@ -100,11 +126,19 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
>  		return -1;
>  	}
>  
> +	if (read(fd_la, &rf_cqm, sizeof(struct read_format)) == -1) {
> +		perror("Could not get llc accesses through perf");
> +
> +		return -1;

It looks like the cleanup (closing of file descriptors) is omitted on
this and the earlier error path.

> +	}
> +
>  	total_misses = rf_cqm.values[0].value;
> +	total_references = rf_cqm.values[1].value;
>  
>  	close(fd_lm);
> +	close(fd_la);
>  
> -	*llc_perf_miss = total_misses;
> +	*llc_perf_miss_rate = ((float)total_misses / total_references) * 100;
>  
>  	return 0;
>  }
> @@ -176,15 +210,16 @@ static int print_results_cache(char *filename, int bm_pid,
>  
>  int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
>  {
> -	unsigned long llc_perf_miss = 0, llc_occu_resc = 0, llc_value = 0;
> +	unsigned long llc_occu_resc = 0, llc_value = 0;
> +	float llc_perf_miss_rate = 0;
>  	int ret;
>  
>  	/* Measure cache miss from perf */
>  	if (!strcmp(param->resctrl_val, "cat")) {
> -		ret = get_llc_perf(&llc_perf_miss);
> +		ret = get_llc_perf_miss_rate(&llc_perf_miss_rate);
>  		if (ret < 0)
>  			return ret;
> -		llc_value = llc_perf_miss;
> +		llc_value = llc_perf_miss_rate;

What is the benefit of llc_perf_miss_rate being of type float?

>  	}
>  
>  	/* Measure llc occupancy from resctrl */
> @@ -202,66 +237,72 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
>  }
>  
>  /*
> - * cache_val:		execute benchmark and measure LLC occupancy resctrl
> - * and perf cache miss for the benchmark
> - * @param:		parameters passed to cache_val()
> + * setup_critical_process:	Bind given pid to given cpu and write the pid
> + *				in requested resctrl FS location, set schemata,
> + *				initialize perf LLC counters and also initialize
> + *				fill buffer benchmark.
> + * @pid:			pid of the process
> + * @param:			Parameters passed to cache_val()
>   *
> - * Return:		0 on success. non-zero on failure.
> + * Return:			0 on success. non-zero on failure.
>   */
> -int cat_val(struct resctrl_val_param *param)
> +int setup_critical_process(pid_t pid, struct resctrl_val_param *param)
>  {
> -	int malloc_and_init_memory = 1, memflush = 1, operation = 0, ret = 0;
> +	int ret = 0;
>  	char *resctrl_val = param->resctrl_val;
> -	pid_t bm_pid;
> +	char schemata[64];
>  
> -	if (strcmp(param->filename, "") == 0)
> -		sprintf(param->filename, "stdio");
> +	/* Taskset parent (critical process) to a specified cpu */
> +	ret = taskset_benchmark(pid, param->cpu_no);
> +	if (ret)
> +		return ret;
>  
> -	bm_pid = getpid();
> +	/* Write parent to specified con_mon grp, mon_grp in resctrl FS */
> +	ret = write_bm_pid_to_resctrl(pid, param->ctrlgrp, param->mongrp,
> +				      resctrl_val);
> +	if (ret)
> +		return ret;
>  
> -	/* Taskset benchmark to specified cpu */
> -	ret = taskset_benchmark(bm_pid, param->cpu_no);
> +	sprintf(schemata, "%lx", param->mask);
> +	ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, "cat");
>  	if (ret)
>  		return ret;
>  
> -	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS */
> -	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
> -				      resctrl_val);
> +	initialize_llc_perf();
> +
> +	ret = init_buffer(param->span, 1, 1);
>  	if (ret)
>  		return ret;
>  
> -	if ((strcmp(resctrl_val, "cat") == 0)) {
> -		ret = initialize_llc_perf();
> -		if (ret)
> -			return ret;
> -	}
> +	return 0;
> +}
> +
> +int run_critical_process(pid_t pid, struct resctrl_val_param *param)
> +{
> +	int ret = 0;
>  
> -	/* Test runs until the callback setup() tells the test to stop. */
> +	/* Test runs until the callback setup() tells the test to stop */
>  	while (1) {
> -		if (strcmp(resctrl_val, "cat") == 0) {
> -			ret = param->setup(param);
> -			if (ret) {
> -				ret = 0;
> -				break;
> -			}
> -			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
> -			if (ret)
> -				break;
> -
> -			if (run_fill_buf(param->span, malloc_and_init_memory,
> -					 memflush, operation, resctrl_val)) {
> -				fprintf(stderr, "Error-running fill buffer\n");
> -				ret = -1;
> -				break;
> -			}
> -
> -			sleep(1);
> -			ret = measure_cache_vals(param, bm_pid);
> -			if (ret)
> -				break;
> -		} else {
> +		ret = param->setup(param);
> +		if (ret) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		ret = reset_enable_llc_perf(pid, param->cpu_no);

This is in a while(1) loop and it seems reset_enable_llc_perf() opens
the file descriptors and reset then enable the counters. Would it not be
more efficient to open the file descriptors outside of this while() loop
and just reset/enable the counters within?

> +		if (ret)
> +			break;
> +
> +		/* Read buffer once */
> +		if (use_buffer_once(0)) {
> +			fprintf(stderr, "Error-running fill buffer\n");
> +			ret = -1;
>  			break;
>  		}

If I understand correctly reset_enable_llc_perf() will open the perf
file descriptors and start the measurement and measure_cache_vals() will
read from the file descriptors to obtain the measurements. It seems that
if use_buffer_once() fails that the perf file descriptors need to be closed?


> +
> +		ret = measure_cache_vals(param, pid);
> +		if (ret)
> +			break;
>  	}
>  
>  	return ret;
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 046c7f285e72..f7a67f005fe5 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -11,70 +11,65 @@
>  #include "resctrl.h"
>  #include <unistd.h>
>  
> -#define RESULT_FILE_NAME1	"result_cat1"
> -#define RESULT_FILE_NAME2	"result_cat2"
> -#define NUM_OF_RUNS		5
> -#define MAX_DIFF_PERCENT	4
> -#define MAX_DIFF		1000000
> +#define RESULT_FILE_NAME	"result_cat"
> +#define NUM_OF_RUNS		10
> +#define MAX_DIFF_PERCENT	5
>  
> -int count_of_bits;
>  char cbm_mask[256];
> -unsigned long long_mask;
> -unsigned long cache_size;
>  
> -/*
> - * Change schemata. Write schemata to specified
> - * con_mon grp, mon_grp in resctrl FS.
> - * Run 5 times in order to get average values.
> - */
> +static unsigned long avg_llc_perf_miss_rate_single_thread;
> +static unsigned long p1_mask, p2_mask;

If these _have_ to be global variables, could they have more descriptive
names?

> +static unsigned long cache_size;
> +static pid_t noisy_pid;
> +static int count_of_bits;
> +
> +/* Run 5 times in order to get average values */

Seems like NUM_OF_RUNS above was changed to 10 so the above is no longer
accurate. Perhaps just say "Run NUM_OF_RUNS times" ?

>  static int cat_setup(struct resctrl_val_param *p)
>  {
> -	char schemata[64];
> -	int ret = 0;
> -
>  	/* Run NUM_OF_RUNS times */
>  	if (p->num_of_runs >= NUM_OF_RUNS)
>  		return -1;
>  
> -	if (p->num_of_runs == 0) {
> -		sprintf(schemata, "%lx", p->mask);
> -		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
> -				     p->resctrl_val);
> -	}
>  	p->num_of_runs++;
> -
> -	return ret;
> +	return 0;
>  }

All of this complication does not seem to be necessary. This cat_setup()
does not actually do any setup ... it seems to only exist to be able to
break out of an infinite loop. Why not just eliminate this function and
just run the loop within run_critical_process() NUM_OF_RUNS times?

>  
> -static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
> -			    unsigned long span)
> +static void show_cache_info(unsigned long sum_llc_perf_miss_rate,
> +			    int no_of_bits, unsigned long span)
>  {
> -	unsigned long allocated_cache_lines = span / 64;
> -	unsigned long avg_llc_perf_miss = 0;
> -	float diff_percent;
> +	unsigned long avg_llc_perf_miss_rate = 0, diff_percent = 0;
> +
> +	avg_llc_perf_miss_rate = sum_llc_perf_miss_rate / (NUM_OF_RUNS - 1);
> +	if (!noisy_pid) {
> +		avg_llc_perf_miss_rate_single_thread = avg_llc_perf_miss_rate;
> +		return;
> +	}
>  
> -	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
> -	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
> -				allocated_cache_lines * 100;
> +	diff_percent = labs(avg_llc_perf_miss_rate -
> +		       avg_llc_perf_miss_rate_single_thread);
>  
> -	printf("%sok CAT: cache miss rate within %d%%\n",
> -	       !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT ?
> +	printf("%sok CAT: cache miss rate difference within %d%%\n",
> +	       !is_amd && diff_percent > MAX_DIFF_PERCENT ?
>  	       "not " : "", MAX_DIFF_PERCENT);
> -	tests_run++;
> -	printf("# Percent diff=%d\n", abs((int)diff_percent));
>  	printf("# Number of bits: %d\n", no_of_bits);
> -	printf("# Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
> -	printf("# Allocated cache lines: %lu\n", allocated_cache_lines);
> +	printf("# Buffer size: %lu\n", span);
> +	printf("# Avg_llc_perf_miss_rate without noisy process: %lu%%\n",
> +	       avg_llc_perf_miss_rate_single_thread);
> +	printf("# Avg_llc_perf_miss_rate with noisy process: %lu%%\n",
> +	       avg_llc_perf_miss_rate);
> +	printf("# Percent diff: %lu\n", diff_percent);
> +	tests_run++;
>  }
>  
>  static int check_results(struct resctrl_val_param *param)
>  {
>  	char *token_array[8], temp[512];
> -	unsigned long sum_llc_perf_miss = 0;
> +	unsigned long sum_llc_perf_miss_rate = 0;
>  	int runs = 0, no_of_bits = 0;
>  	FILE *fp;
>  
> -	printf("# Checking for pass/fail\n");
> +	if (noisy_pid)
> +		printf("# Checking for pass/fail\n");
>  	fp = fopen(param->filename, "r");
>  	if (!fp) {
>  		perror("# Cannot open file");
> @@ -90,37 +85,107 @@ static int check_results(struct resctrl_val_param *param)
>  			token_array[fields++] = token;
>  			token = strtok(NULL, ":\t");
>  		}
> +
>  		/*
>  		 * Discard the first value which is inaccurate due to monitoring
>  		 * setup transition phase.
>  		 */
> -		if (runs > 0)
> -			sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
>  		runs++;
> +		if (runs == 1)
> +			continue;
> +
> +		sum_llc_perf_miss_rate += strtoul(token_array[3], NULL, 0);
>  	}
>  
>  	fclose(fp);
>  	no_of_bits = count_bits(param->mask);
> -
> -	show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
> +	show_cache_info(sum_llc_perf_miss_rate, no_of_bits, param->span);
>  
>  	return 0;
>  }
>  
>  void cat_test_cleanup(void)
>  {
> -	remove(RESULT_FILE_NAME1);
> -	remove(RESULT_FILE_NAME2);
> +	remove(RESULT_FILE_NAME);
> +}
> +
> +static int prepare_masks_for_two_processes(int no_of_bits, char *cache_type)

It would be valuable to include comments that describe the goal of these
masks. Some questions that may be asked when seeing this function ...
Why are two masks needed? What are the differences between them? How are
they intended to be used?

> +{
> +	int ret, i;
> +	unsigned long long_mask, shareable_mask;
> +
> +	/* Get default cbm mask for L3/L2 cache */
> +	ret = get_cbm_mask(cache_type);
> +	if (ret)
> +		return ret;
> +
> +	/* Get max number of bits from default cbm mask */
> +	long_mask = strtoul(cbm_mask, NULL, 16);
> +	count_of_bits = count_bits(long_mask);
> +
> +	/*
> +	 * Max limit is count_of_bits - 1 because we need exclusive masks for
> +	 * the two processes. So, the last saved bit will be used by the other
> +	 * process.
> +	 */
> +	if (no_of_bits < 1 || no_of_bits > count_of_bits - 1) {
> +		printf("Invalid input value for no_of_bits 'n'\n");
> +		printf("Please Enter value in range 1 to %d\n",
> +		       count_of_bits - 1);
> +		return -1;
> +	}
> +
> +	ret = get_shareable_mask(cache_type, &shareable_mask);
> +	if (ret)
> +		return ret;
> +
> +	/* Prepare cbm mask without any shareable bits */
> +	for (i = 0; i < no_of_bits; i++) {
> +		p1_mask <<= 1;
> +		p1_mask |= 1;
> +	}
> +	p1_mask = ~shareable_mask & p1_mask;
> +	p2_mask = ~p1_mask & long_mask;
> +
> +	return 0;
>  }
>  
> -int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> +static int start_noisy_process(pid_t pid, int sibling_cpu_no)
>  {
> -	unsigned long l_mask, l_mask_1;
> -	int ret, pipefd[2], sibling_cpu_no;
> -	char pipe_message;
> -	pid_t bm_pid;
> +	int ret;
> +	unsigned long buf_size = cache_size * 10;
>  
> -	cache_size = 0;
> +	/* Taskset noisy process to specified cpu */
> +	ret = taskset_benchmark(pid, sibling_cpu_no);
> +	if (ret)
> +		return ret;
> +
> +	/* Write noisy process to root con_mon grp in resctrl FS */
> +	ret = write_bm_pid_to_resctrl(pid, "", "", "cat");
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Passing 'cat' will not loop around buffer forever, hence don't pass
> +	 * test name
> +	 */
> +	ret = run_fill_buf(buf_size, 1, 1, 0, "");
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type)
> +{
> +	int ret, sibling_cpu_no;
> +	unsigned long buf_size;
> +	pid_t critical_pid;
> +	char schemata[64];
> +
> +	noisy_pid = 0;
> +	critical_pid = getpid();
> +	printf("# critical_pid: %d\n", critical_pid);
>  
>  	ret = remount_resctrlfs(true);
>  	if (ret)
> @@ -129,77 +194,43 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	if (!validate_resctrl_feature_request("cat"))
>  		return -1;
>  
> -	/* Get default cbm mask for L3/L2 cache */
> -	ret = get_cbm_mask(cache_type);
> +	ret = prepare_masks_for_two_processes(no_of_bits, cache_type);
>  	if (ret)
>  		return ret;

Global variables p1_mask and p2_mask are initialized from above and only
used in this function. Would it not be simpler to just initialize and
use them as local variables here?

>  
> -	long_mask = strtoul(cbm_mask, NULL, 16);
> +	/*
> +	 * Change root con_mon grp schemata to be exclusive of critical process
> +	 * schemata to avoid any interference
> +	 */
> +	sprintf(schemata, "%lx", p2_mask);
> +	ret = write_schemata("", schemata, cpu_no, "cat");
> +	if (ret)
> +		return ret;
>  
>  	/* Get L3/L2 cache size */
>  	ret = get_cache_size(cpu_no, cache_type, &cache_size);
>  	if (ret)
>  		return ret;
> -	printf("cache size :%lu\n", cache_size);
> -
> -	/* Get max number of bits from default-cabm mask */
> -	count_of_bits = count_bits(long_mask);
> -
> -	if (n < 1 || n > count_of_bits - 1) {
> -		printf("Invalid input value for no_of_bits n!\n");
> -		printf("Please Enter value in range 1 to %d\n",
> -		       count_of_bits - 1);
> -		return -1;
> -	}
> -
> -	/* Get core id from same socket for running another thread */
> -	sibling_cpu_no = get_core_sibling(cpu_no);
> -	if (sibling_cpu_no < 0)
> -		return -1;
> +	printf("# cache size: %lu\n", cache_size);
>  
> +	buf_size = cache_size * ((float)(no_of_bits) / count_of_bits);

Is all the parentheses and float necessary? The number of bits with
which the cache can be partitioned should divide the cache evenly, no?
How about:
buf_size = cache_size / count_of_bits * no_of_bits

>  	struct resctrl_val_param param = {
>  		.resctrl_val	= "cat",
>  		.cpu_no		= cpu_no,
>  		.mum_resctrlfs	= 0,
>  		.setup		= cat_setup,
> +		.ctrlgrp	= "c1",
> +		.filename	= RESULT_FILE_NAME,
> +		.mask		= p1_mask,
> +		.num_of_runs	= 0,
> +		.span		= buf_size
>  	};
>  
> -	l_mask = long_mask >> n;
> -	l_mask_1 = ~l_mask & long_mask;
> -
> -	/* Set param values for parent thread which will be allocated bitmask
> -	 * with (max_bits - n) bits
> -	 */
> -	param.span = cache_size * (count_of_bits - n) / count_of_bits;
> -	strcpy(param.ctrlgrp, "c2");
> -	strcpy(param.mongrp, "m2");
> -	strcpy(param.filename, RESULT_FILE_NAME2);
> -	param.mask = l_mask;
> -	param.num_of_runs = 0;
> -
> -	if (pipe(pipefd)) {
> -		perror("# Unable to create pipe");
> -		return errno;
> -	}
> -
> -	bm_pid = fork();
> -
> -	/* Set param values for child thread which will be allocated bitmask
> -	 * with n bits
> -	 */
> -	if (bm_pid == 0) {
> -		param.mask = l_mask_1;
> -		strcpy(param.ctrlgrp, "c1");
> -		strcpy(param.mongrp, "m1");
> -		param.span = cache_size * n / count_of_bits;
> -		strcpy(param.filename, RESULT_FILE_NAME1);
> -		param.num_of_runs = 0;
> -		param.cpu_no = sibling_cpu_no;
> -	}
> -
> -	remove(param.filename);
> +	ret = setup_critical_process(critical_pid, &param);
> +	if (ret)
> +		return ret;
>  
> -	ret = cat_val(&param);
> +	ret = run_critical_process(critical_pid, &param);
>  	if (ret)
>  		return ret;
>  
> @@ -207,38 +238,51 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
>  	if (ret)
>  		return ret;
>  
> -	if (bm_pid == 0) {
> -		/* Tell parent that child is ready */
> -		close(pipefd[0]);
> -		pipe_message = 1;
> -		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> -		    sizeof(pipe_message)) {
> -			close(pipefd[1]);
> -			perror("# failed signaling parent process");
> -			return errno;
> -		}
> +	printf("# ran critical process without noisy process\n");
>  
> -		close(pipefd[1]);
> -		while (1)
> -			;
> +	/*
> +	 * Results from first run of critical process are already calculated
> +	 * and stored in 'avg_llc_perf_miss_single_thread'. Hence, delete the
> +	 * file, so that it could be reused for second run.
> +	 */
> +	cat_test_cleanup();
> +
> +	/* Get core id from same socket for running noisy process */
> +	sibling_cpu_no = get_core_sibling(cpu_no);
> +	if (sibling_cpu_no < 0)
> +		return -1;
> +
> +	noisy_pid = fork();
> +	if (noisy_pid == 0) {

This is confusing. Before the above "noisy_pid == 0" meant that we are
dealing with the critical process. Now this changes, "noisy_pid == 0"
means that we are dealing with the noisy process ... and below
"noisy_pid != 0" means we are dealing with the critical process?

> +		/*
> +		 * Child is the noisy_process which runs in root con_mon grp by
> +		 * default and hence no need to write pid to resctrl FS.
> +		 * Schemata for root con_mon grp is also set above.
> +		 */
> +		printf("# noisy_pid: %d\n", getpid());
> +		ret = start_noisy_process(getpid(), sibling_cpu_no);
> +		exit(EXIT_SUCCESS);
> +	} else if (noisy_pid == -1) {
> +		return -1;
>  	} else {
> -		/* Parent waits for child to be ready. */
> -		close(pipefd[1]);
> -		pipe_message = 0;
> -		while (pipe_message != 1) {
> -			if (read(pipefd[0], &pipe_message,
> -				 sizeof(pipe_message)) < sizeof(pipe_message)) {
> -				perror("# failed reading from child process");
> -				break;
> -			}
> -		}
> -		close(pipefd[0]);
> -		kill(bm_pid, SIGKILL);
> -	}
> +		/*
> +		 * Parent runs again. Sleep for a second here so that noisy
> +		 * process gets to run before critical process
> +		 */
> +		sleep(1);
> +		param.num_of_runs = 0;
> +		ret = run_critical_process(critical_pid, &param);
> +		if (ret)
> +			return ret;
>  
> -	cat_test_cleanup();
> -	if (bm_pid)
> -		umount_resctrlfs();
> +		ret = check_results(&param);
> +		if (ret)
> +			return ret;
> +
> +		ret = kill(noisy_pid, SIGKILL);
> +		if (ret)
> +			printf("Failed to kill noisy_pid\n");
> +	}
>  
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 204ae8870a32..0500dab90b2e 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -139,7 +139,6 @@ static int fill_cache_write(char *resctrl_val)
>  	return 0;
>  }
>  
> -static
>  int init_buffer(unsigned long long buf_size, int malloc_and_init, int memflush)
>  {
>  	unsigned char *start_ptr, *end_ptr;
> @@ -177,7 +176,33 @@ int init_buffer(unsigned long long buf_size, int malloc_and_init, int memflush)
>  	return 0;
>  }
>  
> -static int use_buffer_forever(int op, char *resctrl_val)
> +int use_buffer_once(int op)
> +{
> +	FILE *fp;
> +	int ret = 0;
> +
> +	if (op == 0) {
> +		ret = fill_one_span_read();
> +
> +		/* Consume result so that reading memory is not optimized */
> +		fp = fopen("/dev/null", "w");
> +		if (!fp)
> +			perror("Unable to write to /dev/null");
> +		fprintf(fp, "Sum: %d ", ret);
> +		fclose(fp);
> +		ret = 0;
> +	} else {
> +		fill_one_span_write();
> +	}
> +
> +	if (ret) {
> +		printf("\n Error in fill cache read/write...\n");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +int use_buffer_forever(int op, char *resctrl_val)
>  {
>  	int ret;
>  
> @@ -187,7 +212,7 @@ static int use_buffer_forever(int op, char *resctrl_val)
>  		ret = fill_cache_write(resctrl_val);
>  
>  	if (ret) {
> -		printf("\n Errror in fill cache read/write...\n");
> +		printf("\n Error in fill cache read/write...\n");

Please remove this hunk. Two reasons: (1) only one logical change per
patch, (2) a fix for this was already submitted upstream.

>  		return -1;
>  	}
>  
> @@ -228,7 +253,7 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
>  	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
>  			 resctrl_val);
>  	if (ret) {
> -		printf("\n Errror in fill cache\n");
> +		printf("\n Error in fill cache\n");

Same comment as above.

>  		return -1;
>  	}
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index e320e79bc4d4..79148cbbd7a4 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -27,7 +27,7 @@
>  #define MB			(1024 * 1024)
>  #define RESCTRL_PATH		"/sys/fs/resctrl"
>  #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
> -#define CBM_MASK_PATH		"/sys/fs/resctrl/info"
> +#define INFO_PATH		"/sys/fs/resctrl/info"
>  
>  #define PARENT_EXIT(err_msg)			\
>  	do {					\
> @@ -84,6 +84,9 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>  			    char *resctrl_val);
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>  		    int group_fd, unsigned long flags);
> +int init_buffer(unsigned long long buf_size, int malloc_and_init, int memflush);
> +int use_buffer_once(int op);
> +int use_buffer_forever(int op, char *resctrl_val);
>  int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
>  		 int op, char *resctrl_va);
>  int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
> @@ -93,9 +96,11 @@ void mbm_test_cleanup(void);
>  int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
>  void mba_test_cleanup(void);
>  int get_cbm_mask(char *cache_type);
> +int get_shareable_mask(char *cache_type, unsigned long *shareable_mask);
>  int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
> -int cat_val(struct resctrl_val_param *param);
> +int setup_critical_process(pid_t pid, struct resctrl_val_param *param);
> +int run_critical_process(pid_t pid, struct resctrl_val_param *param);
>  void cat_test_cleanup(void);
>  int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
>  int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 84a436e0775c..60db128312a6 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -192,8 +192,8 @@ int main(int argc, char **argv)
>  		printf("# Starting CAT test ...\n");
>  		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
>  		printf("%sok CAT: test\n", res ? "not " : "");
> -		tests_run++;
>  		cat_test_cleanup();
> +		tests_run++;
>  	}

What is the benefit of this change? If you want to do cleanup like this
then it would be great to separate it into a different patch to keep
logical changes together and make this patch easier to review.

>  
>  	printf("1..%d\n", tests_run);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 465faaad3239..52452bb0178a 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -215,7 +215,7 @@ int get_cbm_mask(char *cache_type)
>  	char cbm_mask_path[1024];
>  	FILE *fp;
>  
> -	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
> +	sprintf(cbm_mask_path, "%s/%s/cbm_mask", INFO_PATH, cache_type);

This could also be a separate patch.

>  
>  	fp = fopen(cbm_mask_path, "r");
>  	if (!fp) {
> @@ -235,6 +235,38 @@ int get_cbm_mask(char *cache_type)
>  }
>  
>  /*
> + * get_shareable_mask - Get shareable mask from shareable_bits for given cache
> + * @cache_type:		Cache level L2/L3
> + * @shareable_mask:	Mask is returned as unsigned long value
> + *
> + * Return: = 0 on success, < 0 on failure.
> + */
> +int get_shareable_mask(char *cache_type, unsigned long *shareable_mask)
> +{
> +	char shareable_bits_file[1024];
> +	FILE *fp;
> +
> +	sprintf(shareable_bits_file, "%s/%s/shareable_bits", INFO_PATH,
> +		cache_type);
> +
> +	fp = fopen(shareable_bits_file, "r");
> +	if (!fp) {
> +		perror("Failed to open shareable_bits file");
> +
> +		return -1;
> +	}
> +	if (fscanf(fp, "%lx", shareable_mask) <= 0) {
> +		perror("Could not get shareable bits");
> +		fclose(fp);
> +
> +		return -1;
> +	}
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +/*
>   * get_core_sibling - Get sibling core id from the same socket for given CPU
>   * @cpu_no:	CPU number
>   *
> 

Apart from the code comments I do remain interested in how this test
performs on different systems under different load to ensure that the
hardware prefetcher does not interfere with the results. If you do have
assumptions/requirements in this area ("This has to run on an idle
system") then it should be added to at least the README.

As a sidenote when I looked at the README it seems to not take these
cache tests into account ... it reads "Currently it supports Memory
Bandwidth Monitoring test and Memory Bandwidth Allocation test on Intel
RDT hardware. More tests will be added in the future."

Reinette
