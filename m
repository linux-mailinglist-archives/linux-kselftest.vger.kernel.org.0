Return-Path: <linux-kselftest+bounces-140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C6B7EC773
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D67F280DD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F039FEA;
	Wed, 15 Nov 2023 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KUSmf0Uf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C734186
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 15:37:15 +0000 (UTC)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C984B109
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700062634;
	bh=TL8P9OqfNdkVHC03JlbPrXEAk5j3N1lf+MyEIeSgsUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KUSmf0UfISd5qVTFD7+JYH4ZnAkpf/k8KFqSiWYIZba3Gu3JH9Yer/s8fkJ92WXrI
	 9FBkrYsaigdDktYGwt33Z1MVGk20cDylg3Tk4WNir0IB8qR4TPRiGeQPUa8iHSSzvC
	 wFbgWuSu7jAr7NIAxShwsn3uL5vZONLxq/WLZz3atqD2B9GeVoxJyvh9lAGXtZ00RK
	 /miI86/mgD4Cmwp4ptZ6WqO++iS1UJ8AGPJKwaMPL4puVynypSxp9lbhAQe6TxkYnx
	 rjH/8d0p3SfjHk6tCZ8iNW05StETRztFkNqnjRsCxCM/2FpwrHc+P5J2FwnISB5v9W
	 dZ+r6bjvgp3ZQ==
Received: from [172.25.85.137] (unknown [12.186.190.1])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SVnN95YZJz1cN5;
	Wed, 15 Nov 2023 10:37:13 -0500 (EST)
Message-ID: <12dd2fb2-0fac-4763-ad34-02af9653f91b@efficios.com>
Date: Wed, 15 Nov 2023 10:37:39 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/memfd: fix a memleak
Content-Language: en-US
To: zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: cyphar@cyphar.com, dverkamp@chromium.org, keescook@chromium.org,
 akpm@linux-foundation.org, jeffxu@google.com, linux-kselftest@vger.kernel.org
References: <20231115054503.10403-1-zhujun2@cmss.chinamobile.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231115054503.10403-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-15 00:45, zhujun2 wrote:
> The memory allocated within a function should be released
> before the function return,otherwise memleak will occur.

[...]

> --- a/tools/testing/selftests/memfd/fuse_test.c
> +++ b/tools/testing/selftests/memfd/fuse_test.c
> @@ -205,6 +205,7 @@ static pid_t spawn_sealing_thread(void)
>   	stack = malloc(STACK_SIZE);
>   	if (!stack) {
>   		printf("malloc(STACK_SIZE) failed: %m\n");
> +		free(stack);
>   		abort();

Freeing process memory immediately before an abort(3) seems rather
pointless, because the whole process is going away anyway. It's like
tidying up your house right before it is scheduled to be bulldozed
away to make room for a new highway. :-)

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


