Return-Path: <linux-kselftest+bounces-20127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310199A3AD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2687286774
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D62B20103E;
	Fri, 18 Oct 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYHt83gy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D781201030;
	Fri, 18 Oct 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245887; cv=none; b=QzPfY1A7MeKzClzXfqJ4p2gc/E60wFCaOzlu7Yj4OXLs0XR1mbXoH84N23Afvmc4i9/3kfUqoKwdyCabUN7cWizhN/g//w3o3sDy9dAbAo6cvcLvs3y7YSXsYplAmR91x2kBplHhf7PhSnPrnladFN3aC6SJxyXLeqwsI2qMM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245887; c=relaxed/simple;
	bh=XlqX620mv1+3TxjbnqU6cqutUY30PUf1MS0RFO7eNFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGJSTFuV2OgD4IK5j9fFpvGaaQHWKGAHz6Lv7akKHqF2WWfhbBDtnhxjvyH9Ez4Ac+aTmSrBqGY5EmrYhz4oFJLtMtSf5he3d1NHHGl4RofjYUi3/vfe9IxGsFEm0TeJk4pUuv98w5CuUZOYuiXP9RxBy2RPYlp/dm9LVU83TQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYHt83gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD21C4CEC3;
	Fri, 18 Oct 2024 10:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729245887;
	bh=XlqX620mv1+3TxjbnqU6cqutUY30PUf1MS0RFO7eNFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYHt83gyEPN94gmmQ4zd/8t9/jKaZnTiARIk3mpDHxmWsnCg9XCCAaaoTDSD9ocHi
	 DZObaLtkYZugfCrN1oL/cjterNn7qzh0Gw1IfQvrxqUeT5Fi91Ez8TLkHiHF78QBmC
	 BGCZ+XFMDRdHYECp0DeXWgYWg0+7lcT+9t8sUCzHdsACCPgF7A5ZYEfLgJncqbUUqd
	 8+tTEeay1ByOcKpO6FzzdgG40YD9OywSgQm4fsRU84bzPArc6RnEggyFjOFYaUF0ud
	 1TcsTAQxM454aw6/oec9YjRdgw8EJI+Xx/zlp3uW/0PbGzALfukveZOOhTFpeny2hn
	 KTollB6GuUsNA==
Date: Fri, 18 Oct 2024 11:04:40 +0100
From: Simon Horman <horms@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: davem@davemloft.net, Liam.Howlett@oracle.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, peili.io@oracle.com
Subject: Re: [PATCH net-next v5 3/3] connector/cn_proc: Selftest for threads
Message-ID: <20241018100440.GF1697@kernel.org>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
 <20241017181436.2047508-4-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017181436.2047508-4-anjali.k.kulkarni@oracle.com>

On Thu, Oct 17, 2024 at 11:14:36AM -0700, Anjali Kulkarni wrote:
> Test to check if setting PROC_CN_MCAST_NOTIFY in proc connector API, allows
> a thread's non-zero exit status to be returned to proc_filter.
> 
> The threads.c program creates 2 child threads. 1st thread handles signal
> SIGSEGV, and 2nd thread needs to indicate some error condition (value 1)
> to the kernel, instead of using pthread_exit() with 1.
> 
> In both cases, child sends notify_netlink_thread_exit(exit_code) to kernel,
> to let kernel know it has exited abnormally with exit_code.
> 
> Compile:
>     make thread
>     make proc_filter
> Run:
>     ./threads
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  tools/testing/selftests/connector/Makefile    |  23 +-
>  .../testing/selftests/connector/proc_filter.c |  34 ++-
>  tools/testing/selftests/connector/thread.c    | 232 ++++++++++++++++++
>  .../selftests/connector/thread_filter.c       |  96 ++++++++
>  4 files changed, 378 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/connector/thread.c
>  create mode 100644 tools/testing/selftests/connector/thread_filter.c
> 
> diff --git a/tools/testing/selftests/connector/Makefile b/tools/testing/selftests/connector/Makefile
> index 92188b9bac5c..bf335826bc3b 100644
> --- a/tools/testing/selftests/connector/Makefile
> +++ b/tools/testing/selftests/connector/Makefile
> @@ -1,5 +1,26 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -Wall $(KHDR_INCLUDES)
> +KERNEL="../../../.."
> +
> +CFLAGS += -Wall $(KHDR_INCLUDES) -I $(KERNEL)/include/uapi -I $(KERNEL)/include
> +
> +proc_filter: proc_filter.o
> +	cc proc_filter.o -o proc_filter
> +
> +proc_filter.o: proc_filter.c
> +	cc -c proc_filter.c -o proc_filter.o $(CFLAGS)
> +
> +thread: thread.o thread_filter.o
> +	cc thread.o thread_filter.o -o thread
> +
> +thread.o: thread.c $(DEPS)
> +		cc -c thread.c -o thread.o $(CFLAGS)
> +
> +thread_filter.o: thread_filter.c
> +		cc -c thread_filter.c -o thread_filter.o $(CFLAGS)
> +
> +define EXTRA_CLEAN
> +	rm *.o thread
> +endef
>  
>  TEST_GEN_PROGS = proc_filter
>  

I am a little confused by this, as it seems to result in user-space
code using kernel headers. Is that expected?

$ make -C tools/testing/selftests/connector
...
cc -c proc_filter.c -o proc_filter.o -Wall -isystem /home/horms/projects/linux/linux/tools/testing/selftests/../../../usr/include -I "../../../.."/include/uapi -I "../../../.."/include -D_GNU_SOURCE=
In file included from ../../../../include/uapi/linux/netlink.h:7,
                 from proc_filter.c:11:
../../../../include/uapi/linux/types.h:10:2: warning: #warning "Attempt to use kernel headers from user space, see https://kernelnewbies.org/KernelHeaders" [-Wcpp]
   10 | #warning "Attempt to use kernel headers from user space, see https://kernelnewbies.org/KernelHeaders"
      |  ^~~~~~~
...

> diff --git a/tools/testing/selftests/connector/thread.c b/tools/testing/selftests/connector/thread.c

...

> +static inline void init_threads(pthread_attr_t *attr)

Please don't use inline in .c files unless there is a demonstrable,
usually performance, reason to do so.

Likewise twice more in this patch and once in patch 1/3.

> +{
> +	int ret;
> +
> +	ret = pthread_attr_init(attr);
> +	if (ret != 0) {
> +		perror("pthread_attr_init failed");
> +		exit(ret);
> +	}
> +
> +	ret = pthread_attr_setdetachstate(attr, PTHREAD_CREATE_DETACHED);
> +	if (ret != 0) {
> +		perror("pthread_attr_setdetachstate failed");
> +		exit(ret);
> +	}
> +}

...

