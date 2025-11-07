Return-Path: <linux-kselftest+bounces-45079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A81C3FA0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 12:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 308634F0547
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BA31E0F0;
	Fri,  7 Nov 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldsIBA7i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528031B104;
	Fri,  7 Nov 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513474; cv=none; b=dIimKQMBbCvuG/8FOOXBJJXa8fra3uL0r/8KebPQA4CYzn9vEJrqqndlZ6IJoAyWrxWhRPkqJqHHo6O8H84esx/hQ0FNzW1NoE+MNHUq2aZbu61g8LtbKqR9I9fPSSlwzQOg8vO9ZR2rNt06ysTpAvuTKY5H1nnq9zxt8cuucFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513474; c=relaxed/simple;
	bh=BvnStadPPZig6VYjAjMr1d2Qtw5EOq71oMfP2oI6vbg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VRG1sbRrUJ6yTT0wZ781uj4pwSGI8exlXejsheFOoTWWkTU/YzBB8UeRw6VxdcLtyvz14HVA9fYeJpso4PmS4qCGGoMCOtY9qXsISahsbCL45PXgx5mUveYlnXX+ToLmi249nxmausWjjQ+B9igu0npyFASZ4nxieMHoslJVTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldsIBA7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44252C4CEF8;
	Fri,  7 Nov 2025 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762513472;
	bh=BvnStadPPZig6VYjAjMr1d2Qtw5EOq71oMfP2oI6vbg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ldsIBA7iZ/WYl7HzA2SE0gy1mNxaUYFHZFgX9SXeLez7ruIVkPHtlIoIT3/jr5CK4
	 osaIp5/l1zfNkDjvx9XU7eXnMV3CMY23KZeznI1inR8/xp2hdkO/5dgFgN9Qt35fGk
	 /FbYGi4NwdCkjsZ2v/VSEqnQmms07LFVNJ2GK88LcktCW9CRSY5wspsQbV2GldsUYM
	 2A5Q1rvaaAOq1jg3UpgIfan50aqqW4eqLmSujf+RGOtwuUD585stqi8pZg1UmoOUd4
	 j+epm8FMT4NkzsznMAH03+UrAsczfTJ+lOD6b1cop/VCttFlws0wAOhobIUPRJJIJs
	 HPzmAZR7bQZrg==
Content-Type: multipart/mixed; boundary="===============5137293592050232588=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e7c21df731231e96fd630f5486d6a4af9daf73b8ee5dcd09e8284912ef90c818@mail.kernel.org>
In-Reply-To: <20251107102853.1082118-4-dtatulea@nvidia.com>
References: <20251107102853.1082118-4-dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] page_pool: add benchmarking for napi-based recycling
From: bot+bpf-ci@kernel.org
To: dtatulea@nvidia.com,kuba@kernel.org,hawk@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org
Cc: dtatulea@nvidia.com,tariqt@nvidia.com,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Nov 2025 11:04:32 +0000 (UTC)

--===============5137293592050232588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> index cb6468adb..84683c547 100644
> --- a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> +++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> @@ -16,6 +17,8 @@
>  static int verbose = 1;
>  #define MY_POOL_SIZE 1024
>
> +DEFINE_MUTEX(wait_for_tasklet);
> +

[ ... ]

> +/* Testing page_pool requires running under softirq.
> + *
> + * Running under a tasklet satisfy this, as tasklets are built on top of
> + * softirq.
> + */
> +static void pp_tasklet_handler(struct tasklet_struct *t)
> +{
> +	uint32_t nr_loops = loops;
> +
> +	if (in_serving_softirq())
> +		pr_warn("%s(): in_serving_softirq fast-path\n",
> +			__func__); // True
> +	else
> +		pr_warn("%s(): Cannot use page_pool fast-path\n", __func__);
> +
> +	if (enabled(bit_run_bench_tasklet01))
> +		time_bench_loop(nr_loops, 0, "tasklet_page_pool01_fast_path",
> +				NULL, time_bench_page_pool01_fast_path);
> +
> +	if (enabled(bit_run_bench_tasklet02))
> +		time_bench_loop(nr_loops, 0, "tasklet_page_pool02_ptr_ring",
> +				NULL, time_bench_page_pool02_ptr_ring);
> +
> +	if (enabled(bit_run_bench_tasklet03))
> +		time_bench_loop(nr_loops, 0, "tasklet_page_pool03_slow", NULL,
> +				time_bench_page_pool03_slow);
> +
> +	if (enabled(bit_run_bench_tasklet04))
> +		time_bench_loop(nr_loops, 0, "tasklet_page_pool04_napi_aware",
> +				NULL, time_bench_page_pool04_napi_aware);
> +
> +	mutex_unlock(&wait_for_tasklet); /* Module __init waiting on unlock */
        ^^^^^^^^^^^^^

Can mutex_unlock() be called from softirq context? The pp_tasklet_handler()
function runs as a tasklet handler in softirq context, but mutexes are
sleeping locks that require process context. Would a completion or spinlock
be more appropriate here?

The synchronization pattern appears to be:
  bench_page_pool_simple_module_init()->mutex_lock(&wait_for_tasklet)
  bench_page_pool_simple_module_init()->tasklet_schedule(&pp_tasklet)
  bench_page_pool_simple_module_init()->mutex_lock(&wait_for_tasklet) [blocks]
  pp_tasklet_handler()->mutex_unlock(&wait_for_tasklet) [softirq context]

> +}
> +DECLARE_TASKLET_DISABLED(pp_tasklet, pp_tasklet_handler);
> +
> +static void run_tasklet_tests(void)
> +{
> +	tasklet_enable(&pp_tasklet);
> +	/* "Async" schedule tasklet, which runs on the CPU that schedule it */
> +	tasklet_schedule(&pp_tasklet);
> +}

[ ... ]

> @@ -251,12 +332,19 @@ static int __init bench_page_pool_simple_module_init(void)
>
>  	run_benchmark_tests();
>
> +	mutex_lock(&wait_for_tasklet);
> +	run_tasklet_tests();
> +	/* Sleep on mutex, waiting for tasklet to release */
> +	mutex_lock(&wait_for_tasklet);
> +
>  	return 0;
>  }

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19165940352

--===============5137293592050232588==--

