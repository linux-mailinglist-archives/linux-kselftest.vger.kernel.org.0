Return-Path: <linux-kselftest+bounces-9579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7598BDCC5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 09:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1591C22F6A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6413D13C809;
	Tue,  7 May 2024 07:54:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120478274;
	Tue,  7 May 2024 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068486; cv=none; b=CFQPZ05cKyYuTu7cu3vxDrfpZqId1gr1G5YQyrON8mj33/lc7vWrc3Zon5z8P/Gn7YJU24TyzPA/LCrQn/6iahuecxSw5YquMYkBnnXu7Ey3XNX2xZBoep2MdbIIcQmaCxh7XsNC87fk1hSc9sWcZY6pch9qk/0cFWewrX4ujIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068486; c=relaxed/simple;
	bh=8CS7oD1P2aDL3KsONenRwoHwZOwp845fLH6pmTSlTgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDIoE4WZ1fRU1QVYctxkcOLSJju43WtIIdgoBsXOYIJuHqqmTEIjYXit9FfvuyNop8Dl3jL75uWMmW1QIIhVmk2g/2Qv45Ssl7Ah89UucQA3cdlXJgrRposx0hJiLfhk278Owv2wrRzuqBe18rN2MrQGVmcnJcCcSKgM1Tl7g3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83DAF106F;
	Tue,  7 May 2024 00:55:09 -0700 (PDT)
Received: from [10.57.67.145] (unknown [10.57.67.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30BA73F762;
	Tue,  7 May 2024 00:54:41 -0700 (PDT)
Message-ID: <a340524c-15c1-4b8e-b7a9-1fad52e97f69@arm.com>
Date: Tue, 7 May 2024 08:54:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mqueue: fix 5 warnings about signed/unsigned
 mismatches
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240505221359.65258-1-jhubbard@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240505221359.65258-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2024 23:13, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about several cases of using a signed integer for the
> priority argument to mq_receive(3), which expects an unsigned int.
> 
> Fix this by declaring the type as unsigned int in all cases.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/mqueue/mq_perf_tests.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
> index 5c16159d0bcd..fb898850867c 100644
> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
> @@ -323,7 +323,8 @@ void *fake_cont_thread(void *arg)
>  void *cont_thread(void *arg)
>  {
>  	char buff[MSG_SIZE];
> -	int i, priority;
> +	int i;
> +	unsigned int priority;
>  
>  	for (i = 0; i < num_cpus_to_pin; i++)
>  		if (cpu_threads[i] == pthread_self())
> @@ -425,7 +426,8 @@ struct test test2[] = {
>  void *perf_test_thread(void *arg)
>  {
>  	char buff[MSG_SIZE];
> -	int prio_out, prio_in;
> +	int prio_out;

It feels a bit odd for prio_out and prio_in to have different types. I don't
have any prior familiararity with these tests but looks like they are ultimately
the parameters of mq_send() and mq_receive() which both define them as unsigned
ints. Perhaps both should be converted?

> +	unsigned int prio_in;
>  	int i;
>  	clockid_t clock;
>  	pthread_t *t;
> 
> base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27


