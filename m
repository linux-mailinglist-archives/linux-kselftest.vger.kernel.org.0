Return-Path: <linux-kselftest+bounces-20142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F29A4150
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD63283337
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C81EE007;
	Fri, 18 Oct 2024 14:37:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94353768E1;
	Fri, 18 Oct 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262248; cv=none; b=hdVbao/Md8d5qg4CpV1At8OzKKAg3L8RjVTQYDWKj9iSUwqYcB/eNe3yMDQE+U7MgEy7ddiFbyf0VMnkyXqEQ9ZVoHY90A+WaACdTBtRoE1MsJ6sEUelgZrCwiWQrDqwkaPjeFy8r51dVMPDfajCWvf47bHSl5PyeBLd+QcZSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262248; c=relaxed/simple;
	bh=A0Qe57BA5SKFuEpfXr/0vVf3iraWpCGMTe6Ux26pQBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N52ckIcDOYdcZPz685S+J0HwBX8TxW9gF3R0FEWqfz77KnKGclG9rHPe80L4qAbkSHbUcaImWQHkfRMo+Oyh5S3bQQoZRabpPLn76NUXmm02V0N8E+ZqC7CI31lQ1kgSmwceibDVUAppIMwg0Ce72AZdJsIoiRF7AYC4658vAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6765FDA7;
	Fri, 18 Oct 2024 07:37:55 -0700 (PDT)
Received: from [10.57.87.223] (unknown [10.57.87.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC163F58B;
	Fri, 18 Oct 2024 07:37:24 -0700 (PDT)
Message-ID: <b17802cb-5dcd-4161-b192-89abd55c1228@arm.com>
Date: Fri, 18 Oct 2024 15:37:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: replace atomic_bool with
 pthread_barrier_t
Content-Language: en-GB
To: Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lokesh Gidra <lokeshgidra@google.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 linux-mm@kvack.org, Aishwarya TCV <Aishwarya.TCV@arm.com>
References: <20241003211716.371786-1-edliaw@google.com>
 <20241003211716.371786-2-edliaw@google.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241003211716.371786-2-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/2024 22:17, Edward Liaw wrote:
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

Hi Edward,

This change is causing uffd-unit-tests to hang on arm64 when running the "move on anon" test. It's happening because this wait is never returning for this case. And that happens because ready_for_fork was never initialized for this test. It looks like there are other places where a thread is created for uffd_poll_thread() where ready_for_fork is not initialized too.

I added this change and it solves the problem, although it's pretty hacky.

This is blocking our arm64 testing on linux-next so would appreciate either a quick fix or removing the change until a fix is ready.

Thanks,
Ryan

----8<-----
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 852e7281026e..a05eb705be02 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -19,6 +19,7 @@ unsigned long long *count_verify;
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
 pthread_barrier_t ready_for_fork;
+bool wait_ready_for_fork;
 
 static int uffd_mem_fd_create(off_t mem_size, bool hugetlb)
 {
@@ -520,7 +521,8 @@ void *uffd_poll_thread(void *arg)
        pollfd[1].events = POLLIN;
 
        /* Ready for parent thread to fork */
-       pthread_barrier_wait(&ready_for_fork);
+       if (wait_ready_for_fork)
+               pthread_barrier_wait(&ready_for_fork);
 
        for (;;) {
                ret = poll(pollfd, 2, -1);
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 3e6228d8e0dc..e94329a39b34 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -105,6 +105,7 @@ extern bool test_uffdio_wp;
 extern unsigned long long *count_verify;
 extern volatile bool test_uffdio_copy_eexist;
 extern pthread_barrier_t ready_for_fork;
+extern bool wait_ready_for_fork;
 
 extern uffd_test_ops_t anon_uffd_test_ops;
 extern uffd_test_ops_t shmem_uffd_test_ops;
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 3db2296ac631..d1fc4cd6a948 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -775,6 +775,7 @@ static void uffd_sigbus_test_common(bool wp)
        struct uffd_args args = { 0 };
 
        pthread_barrier_init(&ready_for_fork, NULL, 2);
+       wait_ready_for_fork = true;
 
        fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
 
@@ -794,6 +795,7 @@ static void uffd_sigbus_test_common(bool wp)
        /* Wait for child thread to start before forking */
        pthread_barrier_wait(&ready_for_fork);
        pthread_barrier_destroy(&ready_for_fork);
+       wait_ready_for_fork = false;
 
        pid = fork();
        if (pid < 0)
@@ -835,6 +837,7 @@ static void uffd_events_test_common(bool wp)
        struct uffd_args args = { 0 };
 
        pthread_barrier_init(&ready_for_fork, NULL, 2);
+       wait_ready_for_fork = true;
 
        fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
        if (uffd_register(uffd, area_dst, nr_pages * page_size,
@@ -848,6 +851,7 @@ static void uffd_events_test_common(bool wp)
        /* Wait for child thread to start before forking */
        pthread_barrier_wait(&ready_for_fork);
        pthread_barrier_destroy(&ready_for_fork);
+       wait_ready_for_fork = false;
 
        pid = fork();
        if (pid < 0)
----8<-----


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


