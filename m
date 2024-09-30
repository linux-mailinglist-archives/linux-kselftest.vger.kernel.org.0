Return-Path: <linux-kselftest+bounces-18649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC7598A5E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA41C22593
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08FC18FDB2;
	Mon, 30 Sep 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsO7ae9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D654D9FE;
	Mon, 30 Sep 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704340; cv=none; b=fvAeakSS6mW0gt9A/t+JBt9tTC48pn4ZZ58EYWFXP3tNVCIGwgs0bDb5jDiAz58Gmzt/++gyHU+xVa3kKG1Gr8qO1i451yNLJ6j3e6kKd2jDZT3CGewnIOhuYTjSxTr0QZxTJqi2jnvZFOaV7mDE58JyxhONHn/IKxVFQl8wrMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704340; c=relaxed/simple;
	bh=LoRGxtWYz5q0JftDlHdTeNxriMQmKKzgzfPx3HFoHVQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dZ0Alh92rPfuMYTlUHZi8Awzokogz8yEmptud12bYqgCQmNb3Hds3xP+sD+MXDepzVOslWLNRGyE575dAtpbMl2AWO1rAVSvnZgjZGOCEkHYOiCpIJQHFND/jub0LTDmapPCnSPnyvawM5yk7KmTirIdTMrCMzXtN3gH3eOyu0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsO7ae9L; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727704339; x=1759240339;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LoRGxtWYz5q0JftDlHdTeNxriMQmKKzgzfPx3HFoHVQ=;
  b=TsO7ae9Lk9P/g/c984exndYftv/KCem7o0GCpuFg+PjQqKmHyPdvxOHW
   F/6i+aqSOVT8wHBKDD6N4uXSo6U4EKD1RpxxauwVSQEvSZiWBluBMAWhq
   roI4hqA8LIe5Yt+QK78DhUpYE9y3EU4cmDFyhyBwBcHzrwMrATNKnYvTP
   czjjCcV1b/FrBCfuIOPwIa4ayLtW2i7jl7uYdyd/ftm1rq72MoSav0fFa
   GklNP2ICIDu2rS92mlQ0ro2ewRYKBLYEdVRL6Wpc/osIyVLurufuPedt3
   XBDZQ2gu/MQWS7CZh+SmxzjusDmY9ER6BFbWTsPY8Btr4AHz0ErTFLYli
   A==;
X-CSE-ConnectionGUID: jcyONqgsTfmtIVkW0Pakhw==
X-CSE-MsgGUID: uQt33fqqT22h1qgdfMGfuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="52207941"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="52207941"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:52:16 -0700
X-CSE-ConnectionGUID: N8oAuKZRQ2WeEDi/dUVtqg==
X-CSE-MsgGUID: 6PheTJ2dSHm2TGCkq4mtew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96639867"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:52:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Sep 2024 16:52:09 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, shuah@kernel.org, tony.luck@intel.com, 
    peternewman@google.com, babu.moger@amd.com, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 07/13] selftests/resctrl: Only support measured read
 operation
In-Reply-To: <491d5a951751dd74ccb84e175f6dd457dbed5c31.1726164080.git.reinette.chatre@intel.com>
Message-ID: <f18e1956-0eda-2674-2948-72059489c21b@linux.intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com> <491d5a951751dd74ccb84e175f6dd457dbed5c31.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Sep 2024, Reinette Chatre wrote:

> The CMT, MBM, and MBA tests rely on a benchmark to generate
> memory traffic. By default this is the "fill_buf" benchmark that
> can be replaced via the "-b" command line argument.
> 
> The original intent of the "-b" command line parameter was
> to replace the default "fill_buf" benchmark, but the implementation
> also exposes an alternative use case where the "fill_buf" parameters
> itself can be modified. One of the parameters to "fill_buf" is the
> "operation" that can be either "read" or "write" and indicates
> whether the "fill_buf" should use "read" or "write" operations on the
> allocated buffer.
> 
> While replacing "fill_buf" default parameters is technically possible,
> replacing the default "read" parameter with "write" is not supported
> because the MBA and MBM tests only measure "read" operations. The
> "read" operation is also most appropriate for the CMT test that aims
> to use the benchmark to allocate into the cache.
> 
> Avoid any potential inconsistencies between test and measurement by
> removing code for unsupported "write" operations to the buffer.
> Ignore any attempt from user space to enable this unsupported test
> configuration, instead always use read operations.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V1:
> - New patch.
> ---
>  tools/testing/selftests/resctrl/fill_buf.c    | 28 ++-----------------
>  tools/testing/selftests/resctrl/resctrl.h     |  2 +-
>  .../testing/selftests/resctrl/resctrl_tests.c |  5 +++-
>  tools/testing/selftests/resctrl/resctrl_val.c |  5 ++--
>  4 files changed, 9 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 854f0108d8e6..e4f1cea317f1 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -88,18 +88,6 @@ static int fill_one_span_read(unsigned char *buf, size_t buf_size)
>  	return sum;
>  }
>  
> -static void fill_one_span_write(unsigned char *buf, size_t buf_size)
> -{
> -	unsigned char *end_ptr = buf + buf_size;
> -	unsigned char *p;
> -
> -	p = buf;
> -	while (p < end_ptr) {
> -		*p = '1';
> -		p += (CL_SIZE / 2);
> -	}
> -}
> -
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
>  {
>  	int ret = 0;
> @@ -114,15 +102,6 @@ void fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
>  	*value_sink = ret;
>  }
>  
> -static void fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
> -{
> -	while (1) {
> -		fill_one_span_write(buf, buf_size);
> -		if (once)
> -			break;
> -	}
> -}
> -
>  unsigned char *alloc_buffer(size_t buf_size, int memflush)
>  {
>  	void *buf = NULL;
> @@ -151,7 +130,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
>  	return buf;
>  }
>  
> -int run_fill_buf(size_t buf_size, int memflush, int op)
> +int run_fill_buf(size_t buf_size, int memflush)
>  {
>  	unsigned char *buf;
>  
> @@ -159,10 +138,7 @@ int run_fill_buf(size_t buf_size, int memflush, int op)
>  	if (!buf)
>  		return -1;
>  
> -	if (op == 0)
> -		fill_cache_read(buf, buf_size, false);
> -	else
> -		fill_cache_write(buf, buf_size, false);
> +	fill_cache_read(buf, buf_size, false);
>  
>  	free(buf);
>  
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 51f5f4b25e06..ba1ce1b35699 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>  unsigned char *alloc_buffer(size_t buf_size, int memflush);
>  void mem_flush(unsigned char *buf, size_t buf_size);
>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
> -int run_fill_buf(size_t buf_size, int memflush, int op);
> +int run_fill_buf(size_t buf_size, int memflush);
>  int initialize_mem_bw_imc(void);
>  int measure_mem_bw(const struct user_params *uparams,
>  		   struct resctrl_val_param *param, pid_t bm_pid,
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index bee4123a5a9b..60627dbae20a 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -265,13 +265,16 @@ int main(int argc, char **argv)
>  			ksft_exit_fail_msg("Out of memory!\n");
>  		uparams.benchmark_cmd[1] = span_str;
>  		uparams.benchmark_cmd[2] = "1";
> -		uparams.benchmark_cmd[3] = "0";
>  		/*
> +		 * Third parameter was previously used for "operation"
> +		 * (read/write) of which only (now default) "read"/"0"
> +		 * works.
>  		 * Fourth parameter was previously used to indicate
>  		 * how long "fill_buf" should run for, with "false"
>  		 * ("fill_buf" will keep running until terminated)
>  		 * the only option that works.
>  		 */
> +		uparams.benchmark_cmd[3] = NULL;
>  		uparams.benchmark_cmd[4] = NULL;
>  		uparams.benchmark_cmd[5] = NULL;

The same question as with the previous patch, why is [4] = NULL kept 
around?

-- 
 i.

>  	}
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 5331354aaf64..8b5973c5e934 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -622,8 +622,8 @@ int measure_mem_bw(const struct user_params *uparams,
>   */
>  static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  {
> -	int operation, ret, memflush;
>  	char **benchmark_cmd;
> +	int ret, memflush;
>  	size_t span;
>  	FILE *fp;
>  
> @@ -643,9 +643,8 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  		/* Execute default fill_buf benchmark */
>  		span = strtoul(benchmark_cmd[1], NULL, 10);
>  		memflush =  atoi(benchmark_cmd[2]);
> -		operation = atoi(benchmark_cmd[3]);
>  
> -		if (run_fill_buf(span, memflush, operation))
> +		if (run_fill_buf(span, memflush))
>  			fprintf(stderr, "Error in running fill buffer\n");
>  	} else {
>  		/* Execute specified benchmark */
> 


