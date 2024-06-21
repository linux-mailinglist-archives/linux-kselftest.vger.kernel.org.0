Return-Path: <linux-kselftest+bounces-12398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038E911A93
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917B41C21789
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 05:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A515A863;
	Fri, 21 Jun 2024 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y8znqxa5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A93155CA9;
	Fri, 21 Jun 2024 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948722; cv=none; b=owvleOkBk44NPzOwTBlryh66mURMsJwpGteGMjBjzgSia2TWERr6kLiX6SjzIKQot2GKz+iYr8xRUEhRQYBoRgbDmXZGFCQFmtK2icpSUskGNX5MpA7jg+5LuTiE1X62Boohaw8mdSJiAfJdLLuDaKbAOQxiOS8D8MV+aItLr2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948722; c=relaxed/simple;
	bh=GN1oOMDS213cL8pOkvgVzj842DNfj9f/a/AxPNBm2PY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JLQiRWiNLnCG+6lNossS43Bq0kR5c1FTZlsImk24iANjomKxlCfbNOFtbsFzNGCJUh9EwS1BhqFlX578admiicFa6QutiOQJtpiQL94FSpENxWqn9VZhEGIRFBl1AscZ3fTMl6pylBM2TyFx1Hnu/M4evIHogwWSpHZ/3yLhgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y8znqxa5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718948719;
	bh=GN1oOMDS213cL8pOkvgVzj842DNfj9f/a/AxPNBm2PY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Y8znqxa5H60VPj/ZvGTZ6BeXB4aILZQuU0MrtgYdsOmZdd2VM+7t8fIZIsHak03r8
	 ibGPC67MIf8VPL508V/FyShf+eTFFWLNd142SKQryPisPvJfwFyZWyyaZH4hoxLs9J
	 d592GASpgneI80w5svT6ZOVojmLdhkmL+8jPQqclSDUGWVnytQsRPUeaPYugKCQ0Rm
	 sknrTNdYZK2e4W1hOz5GSLHpWIkLdSIn94I0/X5/iqle9PTmp95JFG2OTKqxeSSMIA
	 64JQaDCQ6+JI5XqAZdHjzhAkdp0MZbEde2z01rm8uK9ZRZCkEtjsx04f9MhMyuCo+W
	 FpK0T1t6HT+FA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4389E378143B;
	Fri, 21 Jun 2024 05:45:12 +0000 (UTC)
Message-ID: <0f9ec70e-2faf-4bb9-ae79-6cea8f4c3a66@collabora.com>
Date: Fri, 21 Jun 2024 10:45:48 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
Subject: Re: [PATCH] selftests/futex: Order calls in futex_requeue
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>
References: <20240619002204.2492673-1-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240619002204.2492673-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 5:22 AM, Edward Liaw wrote:
> Like fbf4dec70277 ("selftests/futex: Order calls to futex_lock_pi"),
> which fixed a flake in futex_lock_pi due to racing between the parent
> and child threads.
> 
> The same issue can occur in the futex_requeue test, because it expects
> waiterfn to make progress to futex_wait before the parent starts to
> requeue. This is mitigated by the parent sleeping for WAKE_WAIT_US, but
> it still fails occasionally. This can be reproduced by adding a sleep in
> the waiterfn before futex_wait:
> 
> TAP version 13
> 1..2
> not ok 1 futex_requeue simple returned: 0
> not ok 2 futex_requeue simple returned: 0
> not ok 3 futex_requeue many returned: 0
> not ok 4 futex_requeue many returned: 0
> 
> Instead, replace the sleep with barriers to make the sequencing
> explicit.
> 
> Fixes: 7cb5dd8e2c8c ("selftests: futex: Add futex compare requeue test")
> Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../selftests/futex/functional/futex_requeue.c       | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
> index 51485be6eb2f..8f7d3e8bf32a 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue.c
> @@ -12,9 +12,9 @@
>  
>  #define TEST_NAME "futex-requeue"
>  #define timeout_ns  30000000
> -#define WAKE_WAIT_US 10000
>  
>  volatile futex_t *f1;
> +static pthread_barrier_t barrier;
>  
>  void usage(char *prog)
>  {
> @@ -32,6 +32,8 @@ void *waiterfn(void *arg)
>  	to.tv_sec = 0;
>  	to.tv_nsec = timeout_ns;
>  
> +	pthread_barrier_wait(&barrier);
> +
>  	if (futex_wait(f1, *f1, &to, 0))
>  		printf("waiter failed errno %d\n", errno);
>  
> @@ -70,13 +72,15 @@ int main(int argc, char *argv[])
>  	ksft_print_msg("%s: Test futex_requeue\n",
>  		       basename(argv[0]));
>  
> +	pthread_barrier_init(&barrier, NULL, 2);
>  	/*
>  	 * Requeue a waiter from f1 to f2, and wake f2.
>  	 */
>  	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
>  		error("pthread_create failed\n", errno);
>  
> -	usleep(WAKE_WAIT_US);
> +	pthread_barrier_wait(&barrier);
> +	pthread_barrier_destroy(&barrier);
>  
>  	info("Requeuing 1 futex from f1 to f2\n");
>  	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
> @@ -99,6 +103,7 @@ int main(int argc, char *argv[])
>  		ksft_test_result_pass("futex_requeue simple succeeds\n");
>  	}
>  
> +	pthread_barrier_init(&barrier, NULL, 11);
>  
>  	/*
>  	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
> @@ -109,7 +114,8 @@ int main(int argc, char *argv[])
>  			error("pthread_create failed\n", errno);
>  	}
>  
> -	usleep(WAKE_WAIT_US);
> +	pthread_barrier_wait(&barrier);
> +	pthread_barrier_destroy(&barrier);
>  
>  	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
>  	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);

-- 
BR,
Muhammad Usama Anjum

