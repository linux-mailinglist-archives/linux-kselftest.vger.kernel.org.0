Return-Path: <linux-kselftest+bounces-19133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B4992023
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8953A1F218E6
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Oct 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2D18991B;
	Sun,  6 Oct 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="XmNK0Pm8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211228377;
	Sun,  6 Oct 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728237247; cv=pass; b=qOgl4H+yGo/sQQZT14BHcYg4CB6edawKoOQOqbULwB2JGeh+ffL2+j419/TT+45j6btTzXBN2RsWplhtG8dcWQJIYL89Quvwd4SG+CQelHnZgh+6k62xeKw7AQKPLnReiu4gOoDG4QaM3iq5lm9Clqx3BMMfTfRy+CwWVR2TYjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728237247; c=relaxed/simple;
	bh=BjiXsL+KzJMtLRg2VOkzfZQ/KCtQf5NUzaW2sSbaEfE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ScTTSN0+M+cxhZrJmdjqXRpJCh5n0BTu7CyP5MxRzl0wnMYu9gv0rFSakXvFiQoA27FdNeg9vDiB8WXUvEYsm5MggPohh0Y2itFYAfPGMLlBvSlpbx8moV0ZPefUcGB6ZOkDHFaZexGNMrpRlBPfH5th4yKlU1wguJ+HuWRQK+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=XmNK0Pm8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728237226; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JrecHpJJjq+le7Cch8iMQ00Jl10IxUEg8AdklhwPaHe6jLfNGQej5eeMqLPD11s6wVfuTCa97FqcB/u7TFu8pribJbt8BTdfMyMR0yJVtYcbXb7We+sZbU5ku3YIuSScDypM94JnsA47cpQHduHSkssABLrb425xpkfFryZbMIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728237226; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XTnVDAmnVGyJDi/jgM2YrR/nJtg9MBkwlu2KSem8Wh8=; 
	b=BGm0xk5L8zLrUsy/0LV1PVbAmRioiYqSRTlw/Wi6YPZNLWkkShyWTgiKCUvGHGy7Pqdsnl+CC2B7Tr7g6V4QR8HTEsKwD9W0LapL/JTYYCzRVGjDlY4dxc0wf5XY1aLLThIvHsHPtFt9bgvRCYYS+inS7EMEW/pCYVaeE6N3gUg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728237226;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XTnVDAmnVGyJDi/jgM2YrR/nJtg9MBkwlu2KSem8Wh8=;
	b=XmNK0Pm8739o8mTtjI9Y4zO2oEnhKe5Q9DSyaV1eO+QUJiwQ5KNJZ2a3NdDeGJx8
	133V1k99tF0WW/CeJ0ZCAQm5PI6r1D/xi+g3iIPDSdZlLKXM8sW2skQc6P1MjHOfyWl
	QHrnHx2oIoxQ2jectMOycWXUkpVGn1W/A+DhZKwQ=
Received: by mx.zohomail.com with SMTPS id 1728237224277627.9130859707182;
	Sun, 6 Oct 2024 10:53:44 -0700 (PDT)
Message-ID: <d1015505-132b-4a94-b7b2-7ba9105b95e6@collabora.com>
Date: Sun, 6 Oct 2024 22:53:37 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 kernel-team@android.com, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] selftests/mm: replace atomic_bool with
 pthread_barrier_t
To: Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lokesh Gidra <lokeshgidra@google.com>, Peter Xu <peterx@redhat.com>
References: <20241003211716.371786-1-edliaw@google.com>
 <20241003211716.371786-2-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241003211716.371786-2-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/4/24 2:17 AM, Edward Liaw wrote:
> Swaps synchronization primitive with pthread_barrier, so that
> stdatomic.h does not need to be included.
> 
> The synchronization is needed on Android ARM64; we see a deadlock with
> pthread_create when the parent thread races forward before the child has
> a chance to start doing work.
> 
> Fixes: 8c864371b2a1 ("selftests/mm: fix ARM related issue with fork after
> pthread_create")
> Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/uffd-common.c     |  5 +++--
>  tools/testing/selftests/mm/uffd-common.h     |  3 +--
>  tools/testing/selftests/mm/uffd-unit-tests.c | 14 ++++++++------
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 717539eddf98..852e7281026e 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -18,7 +18,7 @@ bool test_uffdio_wp = true;
>  unsigned long long *count_verify;
>  uffd_test_ops_t *uffd_test_ops;
>  uffd_test_case_ops_t *uffd_test_case_ops;
> -atomic_bool ready_for_fork;
> +pthread_barrier_t ready_for_fork;
>  
>  static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
>  {
> @@ -519,7 +519,8 @@ void *uffd_poll_thread(void *arg)
>  	pollfd[1].fd = pipefd[cpu*2];
>  	pollfd[1].events = POLLIN;
>  
> -	ready_for_fork = true;
> +	/* Ready for parent thread to fork */
> +	pthread_barrier_wait(&ready_for_fork);
>  
>  	for (;;) {
>  		ret = poll(pollfd, 2, -1);
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index a70ae10b5f62..3e6228d8e0dc 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -33,7 +33,6 @@
>  #include <inttypes.h>
>  #include <stdint.h>
>  #include <sys/random.h>
> -#include <stdatomic.h>
>  
>  #include "../kselftest.h"
>  #include "vm_util.h"
> @@ -105,7 +104,7 @@ extern bool map_shared;
>  extern bool test_uffdio_wp;
>  extern unsigned long long *count_verify;
>  extern volatile bool test_uffdio_copy_eexist;
> -extern atomic_bool ready_for_fork;
> +extern pthread_barrier_t ready_for_fork;
>  
>  extern uffd_test_ops_t anon_uffd_test_ops;
>  extern uffd_test_ops_t shmem_uffd_test_ops;
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index b3d21eed203d..3db2296ac631 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -774,7 +774,7 @@ static void uffd_sigbus_test_common(bool wp)
>  	char c;
>  	struct uffd_args args = { 0 };
>  
> -	ready_for_fork = false;
> +	pthread_barrier_init(&ready_for_fork, NULL, 2);
>  
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>  
> @@ -791,8 +791,9 @@ static void uffd_sigbus_test_common(bool wp)
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
>  
> -	while (!ready_for_fork)
> -		; /* Wait for the poll_thread to start executing before forking */
> +	/* Wait for child thread to start before forking */
> +	pthread_barrier_wait(&ready_for_fork);
> +	pthread_barrier_destroy(&ready_for_fork);
>  
>  	pid = fork();
>  	if (pid < 0)
> @@ -833,7 +834,7 @@ static void uffd_events_test_common(bool wp)
>  	char c;
>  	struct uffd_args args = { 0 };
>  
> -	ready_for_fork = false;
> +	pthread_barrier_init(&ready_for_fork, NULL, 2);
>  
>  	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
>  	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> @@ -844,8 +845,9 @@ static void uffd_events_test_common(bool wp)
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
>  
> -	while (!ready_for_fork)
> -		; /* Wait for the poll_thread to start executing before forking */
> +	/* Wait for child thread to start before forking */
> +	pthread_barrier_wait(&ready_for_fork);
> +	pthread_barrier_destroy(&ready_for_fork);
>  
>  	pid = fork();
>  	if (pid < 0)

-- 
BR,
Muhammad Usama Anjum


