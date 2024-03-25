Return-Path: <linux-kselftest+bounces-6530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A188A11D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 14:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5232C6399
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EEA173DAB;
	Mon, 25 Mar 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rPNf+1na"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545371779A9;
	Mon, 25 Mar 2024 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350482; cv=none; b=JKp9dFJ8YYw+XOtPCgBvuYA+s5HkjsqVEXJxB+nDiSC3gTwmIZUnI+PaEInZ/8BIRQtTzftyAbZ6G1T7qIb5SqNPr24Y7N1yRv01HQf/ECXYMoxjEJDHx0Ogrw/xVelWE87/iGtlOSx0yJ0vyYGnNI8zzS+AfvOkW5jdhdXa/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350482; c=relaxed/simple;
	bh=RYipOSGUX4my2qn452CUgIgo10im9DGVFZvk24Lu0+0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fajqBmSTrjYu5Tt/o+RRaiU6ZSQx1G0m2cKDYujEliUgLudl/Dcz/9CwhY6SVfF8Wc5uhShDVI2JGlCcGl1qeMj9dQYAlbPNrdd2E748Rz4aoMA/XaVm5grnHsWY0r8X2b/TOqU7+zR9oRxy2xwFYhSLQV6mGU82cCjBzrGppIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rPNf+1na; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711350478;
	bh=RYipOSGUX4my2qn452CUgIgo10im9DGVFZvk24Lu0+0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rPNf+1nao3lkhN0wR7LxxzsGYAoZ5Y6j/fgpzyw00EBbK4oYRe6jT04dgI6h44lJe
	 u6PI8TbiKvlYajDRUoGYsiwm22u+wE03tgADXooWxABeRo2BA0BGhrBrLHuBct9pNN
	 zPbK7KKVZEvKnN685aDw9sqnSYhkx+I/w2HYT3xfhTkCAL6MtkCFmKZXkkIuggYcpT
	 St6LoMxs3L9Oxg0aNL2AttQV6TsP+LSt5SU106mWngXMYqJUFgD9+4hGtXkZBQQIvt
	 LY+jxifwiv3MqvTlx6O09YP0s5MahyIWQpFNo5pOF7b0PwpHPVWEN6B0YHPOEQtQag
	 t2Q9g8v/HaJEg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8E1AB378148F;
	Mon, 25 Mar 2024 07:07:55 +0000 (UTC)
Message-ID: <3945548d-20b2-4926-b764-5942cc4524ef@collabora.com>
Date: Mon, 25 Mar 2024 12:08:30 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: x86: test_vsyscall: conform test to TAP
 format output
Content-Language: en-US
To: Shuah Khan <shuah@kernel.org>
References: <20240314103216.286603-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240314103216.286603-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft Reminder

On 3/14/24 3:32 PM, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> Without using TAP messages, the passed/failed/skip test names cannot be
> found.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/x86/test_vsyscall.c | 506 +++++++++-----------
>  1 file changed, 238 insertions(+), 268 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
> index 47cab972807c4..d4c8e8d79d389 100644
> --- a/tools/testing/selftests/x86/test_vsyscall.c
> +++ b/tools/testing/selftests/x86/test_vsyscall.c
> @@ -21,6 +21,13 @@
>  #include <sys/uio.h>
>  
>  #include "helpers.h"
> +#include "../kselftest.h"
> +
> +#ifdef __x86_64__
> +#define TOTAL_TESTS 13
> +#else
> +#define TOTAL_TESTS 8
> +#endif
>  
>  #ifdef __x86_64__
>  # define VSYS(x) (x)
> @@ -39,18 +46,6 @@
>  /* max length of lines in /proc/self/maps - anything longer is skipped here */
>  #define MAPS_LINE_LEN 128
>  
> -static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
> -		       int flags)
> -{
> -	struct sigaction sa;
> -	memset(&sa, 0, sizeof(sa));
> -	sa.sa_sigaction = handler;
> -	sa.sa_flags = SA_SIGINFO | flags;
> -	sigemptyset(&sa.sa_mask);
> -	if (sigaction(sig, &sa, 0))
> -		err(1, "sigaction");
> -}
> -
>  /* vsyscalls and vDSO */
>  bool vsyscall_map_r = false, vsyscall_map_x = false;
>  
> @@ -75,83 +70,25 @@ static void init_vdso(void)
>  	if (!vdso)
>  		vdso = dlopen("linux-gate.so.1", RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>  	if (!vdso) {
> -		printf("[WARN]\tfailed to find vDSO\n");
> +		ksft_print_msg("[WARN] failed to find vDSO\n");
>  		return;
>  	}
>  
>  	vdso_gtod = (gtod_t)dlsym(vdso, "__vdso_gettimeofday");
>  	if (!vdso_gtod)
> -		printf("[WARN]\tfailed to find gettimeofday in vDSO\n");
> +		ksft_print_msg("[WARN] failed to find gettimeofday in vDSO\n");
>  
>  	vdso_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
>  	if (!vdso_gettime)
> -		printf("[WARN]\tfailed to find clock_gettime in vDSO\n");
> +		ksft_print_msg("[WARN] failed to find clock_gettime in vDSO\n");
>  
>  	vdso_time = (time_func_t)dlsym(vdso, "__vdso_time");
>  	if (!vdso_time)
> -		printf("[WARN]\tfailed to find time in vDSO\n");
> +		ksft_print_msg("[WARN] failed to find time in vDSO\n");
>  
>  	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
>  	if (!vdso_getcpu)
> -		printf("[WARN]\tfailed to find getcpu in vDSO\n");
> -}
> -
> -static int init_vsys(void)
> -{
> -#ifdef __x86_64__
> -	int nerrs = 0;
> -	FILE *maps;
> -	char line[MAPS_LINE_LEN];
> -	bool found = false;
> -
> -	maps = fopen("/proc/self/maps", "r");
> -	if (!maps) {
> -		printf("[WARN]\tCould not open /proc/self/maps -- assuming vsyscall is r-x\n");
> -		vsyscall_map_r = true;
> -		return 0;
> -	}
> -
> -	while (fgets(line, MAPS_LINE_LEN, maps)) {
> -		char r, x;
> -		void *start, *end;
> -		char name[MAPS_LINE_LEN];
> -
> -		/* sscanf() is safe here as strlen(name) >= strlen(line) */
> -		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
> -			   &start, &end, &r, &x, name) != 5)
> -			continue;
> -
> -		if (strcmp(name, "[vsyscall]"))
> -			continue;
> -
> -		printf("\tvsyscall map: %s", line);
> -
> -		if (start != (void *)0xffffffffff600000 ||
> -		    end != (void *)0xffffffffff601000) {
> -			printf("[FAIL]\taddress range is nonsense\n");
> -			nerrs++;
> -		}
> -
> -		printf("\tvsyscall permissions are %c-%c\n", r, x);
> -		vsyscall_map_r = (r == 'r');
> -		vsyscall_map_x = (x == 'x');
> -
> -		found = true;
> -		break;
> -	}
> -
> -	fclose(maps);
> -
> -	if (!found) {
> -		printf("\tno vsyscall map in /proc/self/maps\n");
> -		vsyscall_map_r = false;
> -		vsyscall_map_x = false;
> -	}
> -
> -	return nerrs;
> -#else
> -	return 0;
> -#endif
> +		ksft_print_msg("[WARN] failed to find getcpu in vDSO\n");
>  }
>  
>  /* syscalls */
> @@ -176,98 +113,76 @@ static inline long sys_getcpu(unsigned * cpu, unsigned * node,
>  	return syscall(SYS_getcpu, cpu, node, cache);
>  }
>  
> -static jmp_buf jmpbuf;
> -static volatile unsigned long segv_err;
> -
> -static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
> -{
> -	ucontext_t *ctx = (ucontext_t *)ctx_void;
> -
> -	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
> -	siglongjmp(jmpbuf, 1);
> -}
> -
>  static double tv_diff(const struct timeval *a, const struct timeval *b)
>  {
>  	return (double)(a->tv_sec - b->tv_sec) +
>  		(double)((int)a->tv_usec - (int)b->tv_usec) * 1e-6;
>  }
>  
> -static int check_gtod(const struct timeval *tv_sys1,
> -		      const struct timeval *tv_sys2,
> -		      const struct timezone *tz_sys,
> -		      const char *which,
> -		      const struct timeval *tv_other,
> -		      const struct timezone *tz_other)
> +static void check_gtod(const struct timeval *tv_sys1,
> +		       const struct timeval *tv_sys2,
> +		       const struct timezone *tz_sys,
> +		       const char *which,
> +		       const struct timeval *tv_other,
> +		       const struct timezone *tz_other)
>  {
> -	int nerrs = 0;
>  	double d1, d2;
>  
> -	if (tz_other && (tz_sys->tz_minuteswest != tz_other->tz_minuteswest || tz_sys->tz_dsttime != tz_other->tz_dsttime)) {
> -		printf("[FAIL] %s tz mismatch\n", which);
> -		nerrs++;
> -	}
> +	if (tz_other && (tz_sys->tz_minuteswest != tz_other->tz_minuteswest ||
> +			 tz_sys->tz_dsttime != tz_other->tz_dsttime))
> +		ksft_print_msg("%s tz mismatch\n", which);
>  
>  	d1 = tv_diff(tv_other, tv_sys1);
>  	d2 = tv_diff(tv_sys2, tv_other); 
> -	printf("\t%s time offsets: %lf %lf\n", which, d1, d2);
>  
> -	if (d1 < 0 || d2 < 0) {
> -		printf("[FAIL]\t%s time was inconsistent with the syscall\n", which);
> -		nerrs++;
> -	} else {
> -		printf("[OK]\t%s gettimeofday()'s timeval was okay\n", which);
> -	}
> +	ksft_print_msg("%s time offsets: %lf %lf\n", which, d1, d2);
>  
> -	return nerrs;
> +	ksft_test_result(!(d1 < 0 || d2 < 0), "%s gettimeofday()'s timeval\n", which);
>  }
>  
> -static int test_gtod(void)
> +static void test_gtod(void)
>  {
>  	struct timeval tv_sys1, tv_sys2, tv_vdso, tv_vsys;
>  	struct timezone tz_sys, tz_vdso, tz_vsys;
>  	long ret_vdso = -1;
>  	long ret_vsys = -1;
> -	int nerrs = 0;
>  
> -	printf("[RUN]\ttest gettimeofday()\n");
> +	ksft_print_msg("test gettimeofday()\n");
>  
>  	if (sys_gtod(&tv_sys1, &tz_sys) != 0)
> -		err(1, "syscall gettimeofday");
> +		ksft_exit_fail_msg("syscall gettimeofday: %s\n", strerror(errno));
>  	if (vdso_gtod)
>  		ret_vdso = vdso_gtod(&tv_vdso, &tz_vdso);
>  	if (vsyscall_map_x)
>  		ret_vsys = vgtod(&tv_vsys, &tz_vsys);
>  	if (sys_gtod(&tv_sys2, &tz_sys) != 0)
> -		err(1, "syscall gettimeofday");
> +		ksft_exit_fail_msg("syscall gettimeofday: %s\n", strerror(errno));
>  
>  	if (vdso_gtod) {
> -		if (ret_vdso == 0) {
> -			nerrs += check_gtod(&tv_sys1, &tv_sys2, &tz_sys, "vDSO", &tv_vdso, &tz_vdso);
> -		} else {
> -			printf("[FAIL]\tvDSO gettimeofday() failed: %ld\n", ret_vdso);
> -			nerrs++;
> -		}
> +		if (ret_vdso == 0)
> +			check_gtod(&tv_sys1, &tv_sys2, &tz_sys, "vDSO", &tv_vdso, &tz_vdso);
> +		else
> +			ksft_test_result_fail("vDSO gettimeofday() failed: %ld\n", ret_vdso);
> +	} else {
> +		ksft_test_result_skip("vdso_gtod isn't set\n");
>  	}
>  
>  	if (vsyscall_map_x) {
> -		if (ret_vsys == 0) {
> -			nerrs += check_gtod(&tv_sys1, &tv_sys2, &tz_sys, "vsyscall", &tv_vsys, &tz_vsys);
> -		} else {
> -			printf("[FAIL]\tvsys gettimeofday() failed: %ld\n", ret_vsys);
> -			nerrs++;
> -		}
> +		if (ret_vsys == 0)
> +			check_gtod(&tv_sys1, &tv_sys2, &tz_sys, "vsyscall", &tv_vsys, &tz_vsys);
> +		else
> +			ksft_test_result_fail("vsys gettimeofday() failed: %ld\n", ret_vsys);
> +	} else {
> +		ksft_test_result_skip("vsyscall_map_x isn't set\n");
>  	}
> -
> -	return nerrs;
>  }
>  
> -static int test_time(void) {
> -	int nerrs = 0;
> -
> -	printf("[RUN]\ttest time()\n");
> +static void test_time(void)
> +{
>  	long t_sys1, t_sys2, t_vdso = 0, t_vsys = 0;
>  	long t2_sys1 = -1, t2_sys2 = -1, t2_vdso = -1, t2_vsys = -1;
> +
> +	ksft_print_msg("test time()\n");
>  	t_sys1 = sys_time(&t2_sys1);
>  	if (vdso_time)
>  		t_vdso = vdso_time(&t2_vdso);
> @@ -275,56 +190,60 @@ static int test_time(void) {
>  		t_vsys = vtime(&t2_vsys);
>  	t_sys2 = sys_time(&t2_sys2);
>  	if (t_sys1 < 0 || t_sys1 != t2_sys1 || t_sys2 < 0 || t_sys2 != t2_sys2) {
> -		printf("[FAIL]\tsyscall failed (ret1:%ld output1:%ld ret2:%ld output2:%ld)\n", t_sys1, t2_sys1, t_sys2, t2_sys2);
> -		nerrs++;
> -		return nerrs;
> +		ksft_print_msg("syscall failed (ret1:%ld output1:%ld ret2:%ld output2:%ld)\n",
> +			       t_sys1, t2_sys1, t_sys2, t2_sys2);
> +		ksft_test_result_skip("vdso_time\n");
> +		ksft_test_result_skip("vdso_time\n");
> +		return;
>  	}
>  
>  	if (vdso_time) {
> -		if (t_vdso < 0 || t_vdso != t2_vdso) {
> -			printf("[FAIL]\tvDSO failed (ret:%ld output:%ld)\n", t_vdso, t2_vdso);
> -			nerrs++;
> -		} else if (t_vdso < t_sys1 || t_vdso > t_sys2) {
> -			printf("[FAIL]\tvDSO returned the wrong time (%ld %ld %ld)\n", t_sys1, t_vdso, t_sys2);
> -			nerrs++;
> -		} else {
> -			printf("[OK]\tvDSO time() is okay\n");
> -		}
> +		if (t_vdso < 0 || t_vdso != t2_vdso)
> +			ksft_test_result_fail("vDSO failed (ret:%ld output:%ld)\n",
> +					      t_vdso, t2_vdso);
> +		else if (t_vdso < t_sys1 || t_vdso > t_sys2)
> +			ksft_test_result_fail("vDSO returned the wrong time (%ld %ld %ld)\n",
> +					      t_sys1, t_vdso, t_sys2);
> +		else
> +			ksft_test_result_pass("vDSO time() is okay\n");
> +	} else {
> +		ksft_test_result_skip("vdso_time isn't set\n");
>  	}
>  
>  	if (vsyscall_map_x) {
> -		if (t_vsys < 0 || t_vsys != t2_vsys) {
> -			printf("[FAIL]\tvsyscall failed (ret:%ld output:%ld)\n", t_vsys, t2_vsys);
> -			nerrs++;
> -		} else if (t_vsys < t_sys1 || t_vsys > t_sys2) {
> -			printf("[FAIL]\tvsyscall returned the wrong time (%ld %ld %ld)\n", t_sys1, t_vsys, t_sys2);
> -			nerrs++;
> -		} else {
> -			printf("[OK]\tvsyscall time() is okay\n");
> -		}
> +		if (t_vsys < 0 || t_vsys != t2_vsys)
> +			ksft_test_result_fail("vsyscall failed (ret:%ld output:%ld)\n",
> +					      t_vsys, t2_vsys);
> +		else if (t_vsys < t_sys1 || t_vsys > t_sys2)
> +			ksft_test_result_fail("vsyscall returned the wrong time (%ld %ld %ld)\n",
> +					      t_sys1, t_vsys, t_sys2);
> +		else
> +			ksft_test_result_pass("vsyscall time() is okay\n");
> +	} else {
> +		ksft_test_result_skip("vsyscall_map_x isn't set\n");
>  	}
> -
> -	return nerrs;
>  }
>  
> -static int test_getcpu(int cpu)
> +static void test_getcpu(int cpu)
>  {
> -	int nerrs = 0;
> +	unsigned int cpu_sys, cpu_vdso, cpu_vsys, node_sys, node_vdso, node_vsys;
>  	long ret_sys, ret_vdso = -1, ret_vsys = -1;
> +	unsigned int node = 0;
> +	bool have_node = false;
> +	cpu_set_t cpuset;
>  
> -	printf("[RUN]\tgetcpu() on CPU %d\n", cpu);
> +	ksft_print_msg("getcpu() on CPU %d\n", cpu);
>  
> -	cpu_set_t cpuset;
>  	CPU_ZERO(&cpuset);
>  	CPU_SET(cpu, &cpuset);
>  	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0) {
> -		printf("[SKIP]\tfailed to force CPU %d\n", cpu);
> -		return nerrs;
> +		ksft_print_msg("failed to force CPU %d\n", cpu);
> +		ksft_test_result_skip("vdso_getcpu\n");
> +		ksft_test_result_skip("vsyscall_map_x\n");
> +
> +		return;
>  	}
>  
> -	unsigned cpu_sys, cpu_vdso, cpu_vsys, node_sys, node_vdso, node_vsys;
> -	unsigned node = 0;
> -	bool have_node = false;
>  	ret_sys = sys_getcpu(&cpu_sys, &node_sys, 0);
>  	if (vdso_getcpu)
>  		ret_vdso = vdso_getcpu(&cpu_vdso, &node_vdso, 0);
> @@ -332,10 +251,9 @@ static int test_getcpu(int cpu)
>  		ret_vsys = vgetcpu(&cpu_vsys, &node_vsys, 0);
>  
>  	if (ret_sys == 0) {
> -		if (cpu_sys != cpu) {
> -			printf("[FAIL]\tsyscall reported CPU %hu but should be %d\n", cpu_sys, cpu);
> -			nerrs++;
> -		}
> +		if (cpu_sys != cpu)
> +			ksft_print_msg("syscall reported CPU %hu but should be %d\n",
> +				       cpu_sys, cpu);
>  
>  		have_node = true;
>  		node = node_sys;
> @@ -343,63 +261,84 @@ static int test_getcpu(int cpu)
>  
>  	if (vdso_getcpu) {
>  		if (ret_vdso) {
> -			printf("[FAIL]\tvDSO getcpu() failed\n");
> -			nerrs++;
> +			ksft_test_result_fail("vDSO getcpu() failed\n");
>  		} else {
>  			if (!have_node) {
>  				have_node = true;
>  				node = node_vdso;
>  			}
>  
> -			if (cpu_vdso != cpu) {
> -				printf("[FAIL]\tvDSO reported CPU %hu but should be %d\n", cpu_vdso, cpu);
> -				nerrs++;
> -			} else {
> -				printf("[OK]\tvDSO reported correct CPU\n");
> -			}
> -
> -			if (node_vdso != node) {
> -				printf("[FAIL]\tvDSO reported node %hu but should be %hu\n", node_vdso, node);
> -				nerrs++;
> +			if (cpu_vdso != cpu || node_vdso != node) {
> +				if (cpu_vdso != cpu)
> +					ksft_print_msg("vDSO reported CPU %hu but should be %d\n",
> +						       cpu_vdso, cpu);
> +				if (node_vdso != node)
> +					ksft_print_msg("vDSO reported node %hu but should be %hu\n",
> +						       node_vdso, node);
> +				ksft_test_result_fail("Wrong values\n");
>  			} else {
> -				printf("[OK]\tvDSO reported correct node\n");
> +				ksft_test_result_pass("vDSO reported correct CPU and node\n");
>  			}
>  		}
> +	} else {
> +		ksft_test_result_skip("vdso_getcpu isn't set\n");
>  	}
>  
>  	if (vsyscall_map_x) {
>  		if (ret_vsys) {
> -			printf("[FAIL]\tvsyscall getcpu() failed\n");
> -			nerrs++;
> +			ksft_test_result_fail("vsyscall getcpu() failed\n");
>  		} else {
>  			if (!have_node) {
>  				have_node = true;
>  				node = node_vsys;
>  			}
>  
> -			if (cpu_vsys != cpu) {
> -				printf("[FAIL]\tvsyscall reported CPU %hu but should be %d\n", cpu_vsys, cpu);
> -				nerrs++;
> +			if (cpu_vsys != cpu || node_vsys != node) {
> +				if (cpu_vsys != cpu)
> +					ksft_print_msg("vsyscall reported CPU %hu but should be %d\n",
> +						       cpu_vsys, cpu);
> +				if (node_vsys != node)
> +					ksft_print_msg("vsyscall reported node %hu but should be %hu\n",
> +						       node_vsys, node);
> +				ksft_test_result_fail("Wrong values\n");
>  			} else {
> -				printf("[OK]\tvsyscall reported correct CPU\n");
> -			}
> -
> -			if (node_vsys != node) {
> -				printf("[FAIL]\tvsyscall reported node %hu but should be %hu\n", node_vsys, node);
> -				nerrs++;
> -			} else {
> -				printf("[OK]\tvsyscall reported correct node\n");
> +				ksft_test_result_pass("vsyscall reported correct CPU and node\n");
>  			}
>  		}
> +	} else {
> +		ksft_test_result_skip("vsyscall_map_x isn't set\n");
>  	}
> +}
> +
> +#ifdef __x86_64__
> +
> +static jmp_buf jmpbuf;
> +static volatile unsigned long segv_err;
> +
> +static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
> +		       int flags)
> +{
> +	struct sigaction sa;
>  
> -	return nerrs;
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_sigaction = handler;
> +	sa.sa_flags = SA_SIGINFO | flags;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(sig, &sa, 0))
> +		ksft_exit_fail_msg("sigaction failed\n");
>  }
>  
> -static int test_vsys_r(void)
> +static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
>  {
> -#ifdef __x86_64__
> -	printf("[RUN]\tChecking read access to the vsyscall page\n");
> +	ucontext_t *ctx = (ucontext_t *)ctx_void;
> +
> +	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
> +	siglongjmp(jmpbuf, 1);
> +}
> +
> +static void test_vsys_r(void)
> +{
> +	ksft_print_msg("Checking read access to the vsyscall page\n");
>  	bool can_read;
>  	if (sigsetjmp(jmpbuf, 1) == 0) {
>  		*(volatile int *)0xffffffffff600000;
> @@ -408,32 +347,25 @@ static int test_vsys_r(void)
>  		can_read = false;
>  	}
>  
> -	if (can_read && !vsyscall_map_r) {
> -		printf("[FAIL]\tWe have read access, but we shouldn't\n");
> -		return 1;
> -	} else if (!can_read && vsyscall_map_r) {
> -		printf("[FAIL]\tWe don't have read access, but we should\n");
> -		return 1;
> -	} else if (can_read) {
> -		printf("[OK]\tWe have read access\n");
> -	} else {
> -		printf("[OK]\tWe do not have read access: #PF(0x%lx)\n",
> -		       segv_err);
> -	}
> -#endif
> -
> -	return 0;
> +	if (can_read && !vsyscall_map_r)
> +		ksft_test_result_fail("We have read access, but we shouldn't\n");
> +	else if (!can_read && vsyscall_map_r)
> +		ksft_test_result_fail("We don't have read access, but we should\n");
> +	else if (can_read)
> +		ksft_test_result_pass("We have read access\n");
> +	else
> +		ksft_test_result_pass("We do not have read access: #PF(0x%lx)\n", segv_err);
>  }
>  
> -static int test_vsys_x(void)
> +static void test_vsys_x(void)
>  {
> -#ifdef __x86_64__
>  	if (vsyscall_map_x) {
>  		/* We already tested this adequately. */
> -		return 0;
> +		ksft_test_result_pass("vsyscall_map_x is true\n");
> +		return;
>  	}
>  
> -	printf("[RUN]\tMake sure that vsyscalls really page fault\n");
> +	ksft_print_msg("Make sure that vsyscalls really page fault\n");
>  
>  	bool can_exec;
>  	if (sigsetjmp(jmpbuf, 1) == 0) {
> @@ -443,20 +375,14 @@ static int test_vsys_x(void)
>  		can_exec = false;
>  	}
>  
> -	if (can_exec) {
> -		printf("[FAIL]\tExecuting the vsyscall did not page fault\n");
> -		return 1;
> -	} else if (segv_err & (1 << 4)) { /* INSTR */
> -		printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
> -		       segv_err);
> -	} else {
> -		printf("[FAIL]\tExecution failed with the wrong error: #PF(0x%lx)\n",
> -		       segv_err);
> -		return 1;
> -	}
> -#endif
> -
> -	return 0;
> +	if (can_exec)
> +		ksft_test_result_fail("Executing the vsyscall did not page fault\n");
> +	else if (segv_err & (1 << 4)) /* INSTR */
> +		ksft_test_result_pass("Executing the vsyscall page failed: #PF(0x%lx)\n",
> +				      segv_err);
> +	else
> +		ksft_test_result_fail("Execution failed with the wrong error: #PF(0x%lx)\n",
> +				      segv_err);
>  }
>  
>  /*
> @@ -470,14 +396,13 @@ static int test_vsys_x(void)
>   * fact that ptrace() ever worked was a nice courtesy of old kernels,
>   * but the code to support it is fairly gross.
>   */
> -static int test_process_vm_readv(void)
> +static void test_process_vm_readv(void)
>  {
> -#ifdef __x86_64__
>  	char buf[4096];
>  	struct iovec local, remote;
>  	int ret;
>  
> -	printf("[RUN]\tprocess_vm_readv() from vsyscall page\n");
> +	ksft_print_msg("process_vm_readv() from vsyscall page\n");
>  
>  	local.iov_base = buf;
>  	local.iov_len = 4096;
> @@ -489,27 +414,71 @@ static int test_process_vm_readv(void)
>  		 * We expect process_vm_readv() to work if and only if the
>  		 * vsyscall page is readable.
>  		 */
> -		printf("[%s]\tprocess_vm_readv() failed (ret = %d, errno = %d)\n", vsyscall_map_r ? "FAIL" : "OK", ret, errno);
> -		return vsyscall_map_r ? 1 : 0;
> +		ksft_test_result(!vsyscall_map_r,
> +				 "process_vm_readv() failed (ret = %d, errno = %d)\n", ret, errno);
> +		return;
>  	}
>  
> -	if (vsyscall_map_r) {
> -		if (!memcmp(buf, remote.iov_base, sizeof(buf))) {
> -			printf("[OK]\tIt worked and read correct data\n");
> -		} else {
> -			printf("[FAIL]\tIt worked but returned incorrect data\n");
> -			return 1;
> +	if (vsyscall_map_r)
> +		ksft_test_result(!memcmp(buf, remote.iov_base, sizeof(buf)), "Read data\n");
> +	else
> +		ksft_test_result_fail("process_rm_readv() succeeded, but it should have failed in this configuration\n");
> +}
> +
> +static void init_vsys(void)
> +{
> +	int nerrs = 0;
> +	FILE *maps;
> +	char line[MAPS_LINE_LEN];
> +	bool found = false;
> +
> +	maps = fopen("/proc/self/maps", "r");
> +	if (!maps) {
> +		ksft_test_result_skip("Could not open /proc/self/maps -- assuming vsyscall is r-x\n");
> +		vsyscall_map_r = true;
> +		return;
> +	}
> +
> +	while (fgets(line, MAPS_LINE_LEN, maps)) {
> +		char r, x;
> +		void *start, *end;
> +		char name[MAPS_LINE_LEN];
> +
> +		/* sscanf() is safe here as strlen(name) >= strlen(line) */
> +		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
> +			   &start, &end, &r, &x, name) != 5)
> +			continue;
> +
> +		if (strcmp(name, "[vsyscall]"))
> +			continue;
> +
> +		ksft_print_msg("vsyscall map: %s", line);
> +
> +		if (start != (void *)0xffffffffff600000 ||
> +		    end != (void *)0xffffffffff601000) {
> +			ksft_print_msg("address range is nonsense\n");
> +			nerrs++;
>  		}
> -	} else {
> -		printf("[FAIL]\tprocess_rm_readv() succeeded, but it should have failed in this configuration\n");
> -		return 1;
> +
> +		ksft_print_msg("vsyscall permissions are %c-%c\n", r, x);
> +		vsyscall_map_r = (r == 'r');
> +		vsyscall_map_x = (x == 'x');
> +
> +		found = true;
> +		break;
>  	}
> -#endif
>  
> -	return 0;
> +	fclose(maps);
> +
> +	if (!found) {
> +		ksft_print_msg("no vsyscall map in /proc/self/maps\n");
> +		vsyscall_map_r = false;
> +		vsyscall_map_x = false;
> +	}
> +
> +	ksft_test_result(!nerrs, "vsyscall map\n");
>  }
>  
> -#ifdef __x86_64__
>  static volatile sig_atomic_t num_vsyscall_traps;
>  
>  static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
> @@ -521,15 +490,17 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
>  		num_vsyscall_traps++;
>  }
>  
> -static int test_emulation(void)
> +static void test_emulation(void)
>  {
>  	time_t tmp;
>  	bool is_native;
>  
> -	if (!vsyscall_map_x)
> -		return 0;
> +	if (!vsyscall_map_x) {
> +		ksft_test_result_skip("vsyscall_map_x isn't set\n");
> +		return;
> +	}
>  
> -	printf("[RUN]\tchecking that vsyscalls are emulated\n");
> +	ksft_print_msg("checking that vsyscalls are emulated\n");
>  	sethandler(SIGTRAP, sigtrap, 0);
>  	set_eflags(get_eflags() | X86_EFLAGS_TF);
>  	vtime(&tmp);
> @@ -545,36 +516,35 @@ static int test_emulation(void)
>  	 */
>  	is_native = (num_vsyscall_traps > 1);
>  
> -	printf("[%s]\tvsyscalls are %s (%d instructions in vsyscall page)\n",
> -	       (is_native ? "FAIL" : "OK"),
> -	       (is_native ? "native" : "emulated"),
> -	       (int)num_vsyscall_traps);
> -
> -	return is_native;
> +	ksft_test_result(!is_native, "vsyscalls are %s (%d instructions in vsyscall page)\n",
> +			 (is_native ? "native" : "emulated"), (int)num_vsyscall_traps);
>  }
>  #endif
>  
>  int main(int argc, char **argv)
>  {
> -	int nerrs = 0;
> +	int total_tests = TOTAL_TESTS;
>  
> -	init_vdso();
> -	nerrs += init_vsys();
> +	ksft_print_header();
> +	ksft_set_plan(total_tests);
>  
> -	nerrs += test_gtod();
> -	nerrs += test_time();
> -	nerrs += test_getcpu(0);
> -	nerrs += test_getcpu(1);
> -
> -	sethandler(SIGSEGV, sigsegv, 0);
> -	nerrs += test_vsys_r();
> -	nerrs += test_vsys_x();
> +	init_vdso();
> +#ifdef __x86_64__
> +	init_vsys();
> +#endif
>  
> -	nerrs += test_process_vm_readv();
> +	test_gtod();
> +	test_time();
> +	test_getcpu(0);
> +	test_getcpu(1);
>  
>  #ifdef __x86_64__
> -	nerrs += test_emulation();
> +	sethandler(SIGSEGV, sigsegv, 0);
> +	test_vsys_r();
> +	test_vsys_x();
> +	test_process_vm_readv();
> +	test_emulation();
>  #endif
>  
> -	return nerrs ? 1 : 0;
> +	ksft_finished();
>  }

-- 
BR,
Muhammad Usama Anjum

