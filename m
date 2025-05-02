Return-Path: <linux-kselftest+bounces-32170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0FAA714F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C7E9A244B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46FC248F72;
	Fri,  2 May 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Fj6/0mNv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46F1DF75C;
	Fri,  2 May 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188049; cv=pass; b=avz1KktmutRYF4HtWAtTlQ3fiJc/h5tHvUCuzY9PH2S1dBvfP/cGyL4D/4wH5J76+05nAzR1lut+OUBLlGbxnQNGygxdu3fvnJ5ndSSGhjuHpgD4N9Tx84SQgWlObu98OIuY0qjgvGKz/VRHA4Y0W/aomAVd9J2Pex5o3/2jvo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188049; c=relaxed/simple;
	bh=AAXs10Y+D9FMrTQBVnyIpowAABizRcyBZniMr4ggzuA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yil1/+wTUINR4FCt8U+td4f+DqKUt2DZo26WMt+QF2YDzyJMyi54krEzBPnGINUVpwDQIgSR5jgqDR9UH7hBjVis3se+wXhtmPzPLpA/rbqsGs2bcaLn1BQLfJZb3UeRjMGcADFcqL+G5S5rla/0WT501xG48CsDneeCLqLXaLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Fj6/0mNv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746188029; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xup1rjjGkskWuen+LfS8z173/CkhfoAgQ9jB7lZQtn655iAuoyErN6jciiYiCDPHJfIMqY+fE7NXW3hWQPqqGndORw3tuEXslA9spDTuMRmS69QlWASyOyZqw/6H+BwxfSeqzjUBuBvezfL5t/v8hbKtJGWacoGe77y3BhlGe6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746188029; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sH1dNx1Lo5zk4iM9N5df3G7uOySVxlRSII1dvHZ4avs=; 
	b=kdBL/7jonJvrkAs7z+wv2iAN+x37SxSPIW7zj3Kei7b9+OtKpkkmuZC2GlCKRCTVAf/wVG9yWoxmwKkMhA2VqrKHd8zLNXmkBko1xNRMDysD1U6kbtHNr0pj2soa86z/64jHEk+OlxQbSNX8+KL7WQ0yKAc9EldLiV8RnR0UQHw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746188029;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sH1dNx1Lo5zk4iM9N5df3G7uOySVxlRSII1dvHZ4avs=;
	b=Fj6/0mNvjWcr1hRUUVoOOe6aFqd/1BfIyjdGipGTn5vhkChv3kB/kyy+UGIbfBjc
	Hhz6TQ0RBkPceVE1IjkOd1FoqczhVF6fhk2p84TpBBHJs/nvRXnhlGGfETmSzmZqblN
	uGJHB7twfnkD8zL6ree7AoLkWb32xiqYWLlcuCOg=
Received: by mx.zohomail.com with SMTPS id 1746188027151311.4298556984256;
	Fri, 2 May 2025 05:13:47 -0700 (PDT)
Message-ID: <19160409-948f-4ae6-894a-6cfefcef4d4c@collabora.com>
Date: Fri, 2 May 2025 17:13:42 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/timens: Print TAP headers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
 <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:03 PM, Thomas Weißschuh wrote:
> The TAP specification requires that the output begins with a header line.
> These headers lines are missing in the timens tests.
> 
> Print such a line.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/timens/clock_nanosleep.c | 2 ++
>  tools/testing/selftests/timens/exec.c            | 2 ++
>  tools/testing/selftests/timens/futex.c           | 2 ++
>  tools/testing/selftests/timens/gettime_perf.c    | 2 ++
>  tools/testing/selftests/timens/procfs.c          | 2 ++
>  tools/testing/selftests/timens/timens.c          | 2 ++
>  tools/testing/selftests/timens/timer.c           | 2 ++
>  tools/testing/selftests/timens/timerfd.c         | 2 ++
>  tools/testing/selftests/timens/vfork_exec.c      | 2 ++
>  9 files changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
> index 72d41b955fb2263ae74c34b446fb322d1bd50c6a..346bff3d128dfa8c8c743cc2eba74917994bb2f7 100644
> --- a/tools/testing/selftests/timens/clock_nanosleep.c
> +++ b/tools/testing/selftests/timens/clock_nanosleep.c
> @@ -115,6 +115,8 @@ int main(int argc, char *argv[])
>  {
>  	int ret, nsfd;
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	ksft_set_plan(4);
> diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
> index d12ff955de0d8f6665fa957e81438e373af9f92c..a644162d56fdc86827b83a45f83c2597c253aa6a 100644
> --- a/tools/testing/selftests/timens/exec.c
> +++ b/tools/testing/selftests/timens/exec.c
> @@ -36,6 +36,8 @@ int main(int argc, char *argv[])
>  		return 0;
>  	}
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	ksft_set_plan(1);
> diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
> index 6b2b9264e851caed06a628589eda0bf81ff33f16..339633ae037a74d2026ca835ac8600cd0394ae01 100644
> --- a/tools/testing/selftests/timens/futex.c
> +++ b/tools/testing/selftests/timens/futex.c
> @@ -66,6 +66,8 @@ int main(int argc, char *argv[])
>  	pid_t pid;
>  	struct timespec mtime_now;
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	ksft_set_plan(2);
> diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
> index 6b13dc277724126a9d2d5e17c805217760df72ad..d6658b7b754877fbf67237d6c22787a2a89066ce 100644
> --- a/tools/testing/selftests/timens/gettime_perf.c
> +++ b/tools/testing/selftests/timens/gettime_perf.c
> @@ -67,6 +67,8 @@ int main(int argc, char *argv[])
>  	time_t offset = 10;
>  	int nsfd;
>  
> +	ksft_print_header();
> +
>  	ksft_set_plan(8);
>  
>  	fill_function_pointers();
> diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
> index 1833ca97eb247b1b45b7a86f0ca800d4a6e58c74..0a9ff90ee69a9327ed905428f1462fa189ffd830 100644
> --- a/tools/testing/selftests/timens/procfs.c
> +++ b/tools/testing/selftests/timens/procfs.c
> @@ -180,6 +180,8 @@ int main(int argc, char *argv[])
>  {
>  	int ret = 0;
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	ksft_set_plan(2);
> diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
> index 387220791a052e6013bd0fb4162f123d85152183..a9c0534ef8f67184c34882ae163472c179f593e4 100644
> --- a/tools/testing/selftests/timens/timens.c
> +++ b/tools/testing/selftests/timens/timens.c
> @@ -151,6 +151,8 @@ int main(int argc, char *argv[])
>  	time_t offset;
>  	int ret = 0;
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	check_supported_timers();
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
> index 5b939f59dfa4d64e4c2e4dc8eb6a644d44211f13..51babe63e233bdaaef35c1cafbcb5b5cc91c021e 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -75,6 +75,8 @@ int main(int argc, char *argv[])
>  	pid_t pid;
>  	struct timespec btime_now, mtime_now;
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	check_supported_timers();
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
> index a4196bbd6e33f41b6a3ae346070037aff1cf4087..e58bc8b64ce2738dccb8c2a2c88e592c237b55d5 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -82,6 +82,8 @@ int main(int argc, char *argv[])
>  	pid_t pid;
>  	struct timespec btime_now, mtime_now;
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	check_supported_timers();
> diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
> index 5b8907bf451dde3f3e2699f87797c155b9115aab..b957e1a651243adde41ec5cd57bbd12a7cac9eeb 100644
> --- a/tools/testing/selftests/timens/vfork_exec.c
> +++ b/tools/testing/selftests/timens/vfork_exec.c
> @@ -91,6 +91,8 @@ int main(int argc, char *argv[])
>  		return check("child after exec", &now);
>  	}
>  
> +	ksft_print_header();
> +
>  	nscheck();
>  
>  	ksft_set_plan(4);
> 


-- 
Regards,
Usama

