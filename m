Return-Path: <linux-kselftest+bounces-19032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475B99058A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441BE1C21299
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEF02141D3;
	Fri,  4 Oct 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNZ6qE6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72186212EEA;
	Fri,  4 Oct 2024 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051082; cv=none; b=M5Ym8/aV6eXxkecvhwtVSlTmpHWY+OYtzOXY3YcSgLhinwHCBDCAtacfah6A+1gu9WWwl0ZlBhB5oJoHoGMtYdMTUQdCkoYO2tEAvv5G42Vf6BkldedIs3Ys2y5sgbiQQqQwamTfEdYCmzx9N5A9avIuorjggZdHDVH+sEMAyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051082; c=relaxed/simple;
	bh=Nwp845l10Zh5dEAny2NLoc/0356a4QNSSMZpBMdcDvQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TetwSZnzqzulFwHynl90z+3++RCAXcPxVr1IBkYc+7PirLuS/Jj2HSUrAIVR+nMjFRyBO8ECakGnw3kuyypH6T30L7OoyG/QRr7ORewXwcgrP5QodfFREkjdBMRyJ7TzNzmOZsB/h7SjxWhLcRzakhHfYyz6MT1Duyf4FM3Jf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNZ6qE6y; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728051081; x=1759587081;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nwp845l10Zh5dEAny2NLoc/0356a4QNSSMZpBMdcDvQ=;
  b=aNZ6qE6yY0XclFpe9DROOvvbSCBj5HZO4UphnfqmMuQrCLc9dCKMy49u
   5px99o8DqV63+IfxgmOK9sort9BtqrCk1Xefodof7W8H8IJJ5VvzrTcua
   HeMA19c8uJ7YCocZbK1ZV3/W4YRcm3Id/O9IxyZeobnGS/KJJyXMF2Yys
   eGfq38cigvc59Z+VLbKq2Gb66bLxu8JZpM6zFfnErxuF1qbbO6VmktrDa
   IUnmJMduCc1iQp3bHdMyEYN56GgMun6cOOunChgxxBOOx34BFR5tH5Nzi
   qodqlJzzsqiXxZfmjbiPvpzOq3mFRlq1RqPgn2gDmb/0FpwtxCSn8drYi
   Q==;
X-CSE-ConnectionGUID: xsJ4JBAbSW22bg+snr0VOg==
X-CSE-MsgGUID: U8A8wGGvQyuBrPRztFh9WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="44741342"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="44741342"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:11:19 -0700
X-CSE-ConnectionGUID: 9SCwF67sRXCbrVHgE6sMkA==
X-CSE-MsgGUID: uqDaLssJSlGiVTwArgO43w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79686194"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 07:11:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 4 Oct 2024 17:11:12 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 10/13] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
In-Reply-To: <3f9f6c40da0f147171df2b1e6ca159ff0ac0f344.1726164080.git.reinette.chatre@intel.com>
Message-ID: <dc50c9d9-3ee6-c769-cf8c-36027f9ea6bb@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <3f9f6c40da0f147171df2b1e6ca159ff0ac0f344.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-882515112-1728051072=:957"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-882515112-1728051072=:957
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> The CMT, MBA, and MBM tests rely on the resctrl_val() wrapper to
> start and run a benchmark while providing test specific flows
> via callbacks to do test specific configuration and measurements.
>=20
> At a high level, the resctrl_val() flow is:
> =09a) Start by fork()ing a child process that installs a signal
> =09   handler for SIGUSR1 that, on receipt of SIGUSR1, will
> =09   start running a benchmark.
> =09b) Assign the child process created in (a) to the resctrl
> =09   control and monitoring group that dictates the memory and
> =09   cache allocations with which the process can run and will
> =09   contain all resctrl monitoring data of that process.
> =09c) Once parent and child are considered "ready" (determined via
> =09   a message over a pipe) the parent signals the child (via
> =09   SIGUSR1) to start the benchmark, waits one second for the
> =09   benchmark to run, and then starts collecting monitoring data
> =09   for the tests, potentially also changing allocation
> =09   configuration depending on the various test callbacks.
>=20
> A problem with the above flow is the "black box" view of the
> benchmark that is combined with an arbitrarily chosen
> "wait one second" before measurements start. No matter what
> the benchmark does, it is given one second to initialize before
> measurements start.
>=20
> The default benchmark "fill_buf" consists of two parts,
> first it prepares a buffer (allocate, initialize, then flush), then it
> reads from the buffer (in unpredictable ways) until terminated.
> Depending on the system and the size of the buffer, the first "prepare"
> part may not be complete by the time the one second delay expires. Test
> measurements may thus start before the work needing to be measured runs.
>=20
> Split the default benchmark into its "prepare" and "runtime" parts and
> simplify the resctrl_val() wrapper while doing so. This same split
> cannot be done for the user provided benchmark (without a user
> interface change), so the current behavior is maintained for user
> provided benchmark.
>=20
> Assign the test itself to the control and monitoring group and run the
> "prepare" part of the benchmark in this context, ensuring it runs with
> required cache and memory bandwidth allocations. With the benchmark
> preparation complete it is only needed to fork() the "runtime" part
> of the benchmark (or entire user provided benchmark).
>=20
> Keep the "wait one second" delay before measurements start. For the
> default "fill_buf" benchmark this time now covers only the "runtime"
> portion that needs to be measured. For the user provided benchmark this
> delay maintains current behavior.
>=20
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> Changes since V1:
> - Keep the fflush(stdout) before fork() to avoid duplicate messages. (Ilp=
o)
> - Re-order in series to that the new behavior is introduced after issues
>   with existing behavior is addressed.
> ---
>  tools/testing/selftests/resctrl/fill_buf.c    |  15 --
>  tools/testing/selftests/resctrl/resctrl.h     |   1 -
>  tools/testing/selftests/resctrl/resctrl_val.c | 199 +++++-------------
>  3 files changed, 50 insertions(+), 165 deletions(-)
>=20
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/s=
elftests/resctrl/fill_buf.c
> index e4f1cea317f1..75956345cb12 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -129,18 +129,3 @@ unsigned char *alloc_buffer(size_t buf_size, int mem=
flush)
> =20
>  =09return buf;
>  }
> -
> -int run_fill_buf(size_t buf_size, int memflush)
> -{
> -=09unsigned char *buf;
> -
> -=09buf =3D alloc_buffer(buf_size, memflush);
> -=09if (!buf)
> -=09=09return -1;
> -
> -=09fill_cache_read(buf, buf_size, false);
> -
> -=09free(buf);
> -
> -=09return 0;
> -}
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/se=
lftests/resctrl/resctrl.h
> index 98462752cb46..dc01dc75cba5 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -168,7 +168,6 @@ int perf_event_open(struct perf_event_attr *hw_event,=
 pid_t pid, int cpu,
>  unsigned char *alloc_buffer(size_t buf_size, int memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> -int run_fill_buf(size_t buf_size, int memflush);
>  int initialize_read_mem_bw_imc(void);
>  int measure_read_mem_bw(const struct user_params *uparams,
>  =09=09=09struct resctrl_val_param *param, pid_t bm_pid);
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testin=
g/selftests/resctrl/resctrl_val.c
> index 380c3f218d01..f025be5c7d82 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -373,7 +373,7 @@ static int get_mem_bw_resctrl(FILE *fp, unsigned long=
 *mbm_total)
>  =09return 0;
>  }
> =20
> -static pid_t bm_pid, ppid;
> +static pid_t bm_pid;
> =20
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>  {
> @@ -431,13 +431,6 @@ void signal_handler_unregister(void)
>  =09}
>  }
> =20
> -static void parent_exit(pid_t ppid)
> -{
> -=09kill(ppid, SIGKILL);
> -=09umount_resctrlfs();
> -=09exit(EXIT_FAILURE);
> -}
> -
>  /*
>   * print_results_bw:=09the memory bandwidth results are stored in a file
>   * @filename:=09=09file that stores the results
> @@ -535,56 +528,6 @@ int measure_read_mem_bw(const struct user_params *up=
arams,
>  =09return ret;
>  }
> =20
> -struct benchmark_info {
> -=09const struct user_params *uparams;
> -=09struct resctrl_val_param *param;
> -};
> -
> -/*
> - * run_benchmark - Run a specified benchmark or fill_buf (default benchm=
ark)
> - *=09=09   in specified signal. Direct benchmark stdio to /dev/null.
> - * @signum:=09signal number
> - * @info:=09signal info
> - * @ucontext:=09user context in signal handling
> - */
> -static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
> -{
> -=09struct benchmark_info *benchmark_info;
> -=09const struct user_params *uparams;
> -=09struct resctrl_val_param *param;
> -=09FILE *fp;
> -=09int ret;
> -
> -=09benchmark_info =3D info->si_ptr;
> -=09uparams =3D benchmark_info->uparams;
> -=09param =3D benchmark_info->param;
> -
> -=09/*
> -=09 * Direct stdio of child to /dev/null, so that only parent writes to
> -=09 * stdio (console)
> -=09 */
> -=09fp =3D freopen("/dev/null", "w", stdout);
> -=09if (!fp) {
> -=09=09ksft_perror("Unable to direct benchmark status to /dev/null");
> -=09=09parent_exit(ppid);
> -=09}
> -
> -=09if (param->fill_buf) {
> -=09=09if (run_fill_buf(param->fill_buf->buf_size,
> -=09=09=09=09 param->fill_buf->memflush))
> -=09=09=09fprintf(stderr, "Error in running fill buffer\n");
> -=09} else if (uparams->benchmark_cmd[0]) {
> -=09=09/* Execute specified benchmark */
> -=09=09ret =3D execvp(uparams->benchmark_cmd[0], (char **)uparams->benchm=
ark_cmd);
> -=09=09if (ret)
> -=09=09=09ksft_perror("execvp");
> -=09}
> -
> -=09fclose(stdout);
> -=09ksft_print_msg("Unable to run specified benchmark\n");
> -=09parent_exit(ppid);
> -}
> -
>  /*
>   * resctrl_val:=09execute benchmark and measure memory bandwidth on
>   *=09=09=09the benchmark
> @@ -598,12 +541,11 @@ int resctrl_val(const struct resctrl_test *test,
>  =09=09const struct user_params *uparams,
>  =09=09struct resctrl_val_param *param)
>  {
> -=09struct benchmark_info benchmark_info;
> -=09struct sigaction sigact;
> -=09int ret =3D 0, pipefd[2];
> -=09char pipe_message =3D 0;
> -=09union sigval value;
> +=09unsigned char *buf =3D NULL;
> +=09cpu_set_t old_affinity;
>  =09int domain_id;
> +=09int ret =3D 0;
> +=09pid_t ppid;
> =20
>  =09if (strcmp(param->filename, "") =3D=3D 0)
>  =09=09sprintf(param->filename, "stdio");
> @@ -614,108 +556,65 @@ int resctrl_val(const struct resctrl_test *test,
>  =09=09return ret;
>  =09}
> =20
> -=09benchmark_info.uparams =3D uparams;
> -=09benchmark_info.param =3D param;
> -
> -=09/*
> -=09 * If benchmark wasn't successfully started by child, then child shou=
ld
> -=09 * kill parent, so save parent's pid
> -=09 */
>  =09ppid =3D getpid();
> =20
> -=09if (pipe(pipefd)) {
> -=09=09ksft_perror("Unable to create pipe");
> +=09/* Taskset test to specified CPU. */
> +=09ret =3D taskset_benchmark(ppid, uparams->cpu, &old_affinity);
> +=09if (ret)
> +=09=09return ret;
> =20
> -=09=09return -1;
> +=09/* Write test to specified control & monitoring group in resctrl FS. =
*/
> +=09ret =3D write_bm_pid_to_resctrl(ppid, param->ctrlgrp, param->mongrp);
> +=09if (ret)
> +=09=09goto reset_affinity;
> +
> +=09if (param->init) {
> +=09=09ret =3D param->init(param, domain_id);
> +=09=09if (ret)
> +=09=09=09goto reset_affinity;
>  =09}
> =20
>  =09/*
> -=09 * Fork to start benchmark, save child's pid so that it can be killed
> -=09 * when needed
> +=09 * If not running user provided benchmark, run the default
> +=09 * "fill_buf". First phase of "fill_buf" is to prepare the
> +=09 * buffer that the benchmark will operate on. No measurements
> +=09 * are needed during this phase and prepared memory will be
> +=09 * passed to next part of benchmark via copy-on-write thus
> +=09 * no impact on the benchmark that relies on reading from
> +=09 * memory only.
>  =09 */
> +=09if (param->fill_buf) {
> +=09=09buf =3D alloc_buffer(param->fill_buf->buf_size,
> +=09=09=09=09   param->fill_buf->memflush);
> +=09=09if (!buf) {
> +=09=09=09ret =3D -ENOMEM;
> +=09=09=09goto reset_affinity;
> +=09=09}
> +=09}
> +
>  =09fflush(stdout);
>  =09bm_pid =3D fork();
>  =09if (bm_pid =3D=3D -1) {
> +=09=09ret =3D -errno;
>  =09=09ksft_perror("Unable to fork");
> -
> -=09=09return -1;
> +=09=09goto free_buf;
>  =09}
> =20
> +=09/*
> +=09 * What needs to be measured runs in separate process until
> +=09 * terminated.
> +=09 */
>  =09if (bm_pid =3D=3D 0) {
> -=09=09/*
> -=09=09 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
> -=09=09 * start benchmark
> -=09=09 */
> -=09=09sigfillset(&sigact.sa_mask);
> -=09=09sigdelset(&sigact.sa_mask, SIGUSR1);
> -
> -=09=09sigact.sa_sigaction =3D run_benchmark;
> -=09=09sigact.sa_flags =3D SA_SIGINFO;
> -
> -=09=09/* Register for "SIGUSR1" signal from parent */
> -=09=09if (sigaction(SIGUSR1, &sigact, NULL)) {
> -=09=09=09ksft_perror("Can't register child for signal");
> -=09=09=09parent_exit(ppid);
> -=09=09}
> -
> -=09=09/* Tell parent that child is ready */
> -=09=09close(pipefd[0]);
> -=09=09pipe_message =3D 1;
> -=09=09if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
> -=09=09    sizeof(pipe_message)) {
> -=09=09=09ksft_perror("Failed signaling parent process");
> -=09=09=09close(pipefd[1]);
> -=09=09=09return -1;
> -=09=09}
> -=09=09close(pipefd[1]);
> -
> -=09=09/* Suspend child until delivery of "SIGUSR1" from parent */
> -=09=09sigsuspend(&sigact.sa_mask);
> -
> -=09=09ksft_perror("Child is done");
> -=09=09parent_exit(ppid);
> +=09=09if (param->fill_buf)
> +=09=09=09fill_cache_read(buf, param->fill_buf->buf_size, false);
> +=09=09else if (uparams->benchmark_cmd[0])
> +=09=09=09execvp(uparams->benchmark_cmd[0], (char **)uparams->benchmark_c=
md);
> +=09=09exit(EXIT_SUCCESS);
>  =09}
> =20
>  =09ksft_print_msg("Benchmark PID: %d\n", (int)bm_pid);
> =20
> -=09value.sival_ptr =3D (void *)&benchmark_info;
> -
> -=09/* Taskset benchmark to specified cpu */
> -=09ret =3D taskset_benchmark(bm_pid, uparams->cpu, NULL);
> -=09if (ret)
> -=09=09goto out;
> -
> -=09/* Write benchmark to specified control&monitoring grp in resctrl FS =
*/
> -=09ret =3D write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp=
);
> -=09if (ret)
> -=09=09goto out;
> -
> -=09if (param->init) {
> -=09=09ret =3D param->init(param, domain_id);
> -=09=09if (ret)
> -=09=09=09goto out;
> -=09}
> -
> -=09/* Parent waits for child to be ready. */
> -=09close(pipefd[1]);
> -=09while (pipe_message !=3D 1) {
> -=09=09if (read(pipefd[0], &pipe_message, sizeof(pipe_message)) <
> -=09=09    sizeof(pipe_message)) {
> -=09=09=09ksft_perror("Failed reading message from child process");
> -=09=09=09close(pipefd[0]);
> -=09=09=09goto out;
> -=09=09}
> -=09}
> -=09close(pipefd[0]);
> -
> -=09/* Signal child to start benchmark */
> -=09if (sigqueue(bm_pid, SIGUSR1, value) =3D=3D -1) {
> -=09=09ksft_perror("sigqueue SIGUSR1 to child");
> -=09=09ret =3D -1;
> -=09=09goto out;
> -=09}
> -
> -=09/* Give benchmark enough time to fully run */
> +=09/* Give benchmark enough time to fully run. */
>  =09sleep(1);
> =20
>  =09/* Test runs until the callback setup() tells the test to stop. */
> @@ -733,8 +632,10 @@ int resctrl_val(const struct resctrl_test *test,
>  =09=09=09break;
>  =09}
> =20
> -out:
>  =09kill(bm_pid, SIGKILL);
> -
> +free_buf:
> +=09free(buf);
> +reset_affinity:
> +=09taskset_restore(ppid, &old_affinity);
>  =09return ret;
>  }
>=20

--8323328-882515112-1728051072=:957--

