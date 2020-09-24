Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C945127730D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgIXNsZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Sep 2020 09:48:25 -0400
Received: from mail.efficios.com ([167.114.26.124]:45462 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgIXNsY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Sep 2020 09:48:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3F4462D496B;
        Thu, 24 Sep 2020 09:48:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aPd9KrK3dchO; Thu, 24 Sep 2020 09:48:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9E6922D4B8E;
        Thu, 24 Sep 2020 09:48:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9E6922D4B8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600955301;
        bh=voxn1eHtF54rqk8k4eFkeQTTNPOuzfqo+ZoGAAsWH2Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PsNHH39zrWTJUW+SiCUup14yqeraLcu6fCUCcnDtdD54DT5S0xBv0rdC3vK0QvTse
         mBp9RtwPrqFyw6B/nnolGEt5eYOgg5IcyJo1fnZdC1om7fTrIqhDBBR+esxHRFbHTN
         0g2gwrSJdTahtsl+0s94+khc5aiXvmuand3/mmB+20ZXCsjwPxnB19xVw85uHh2YtL
         2pXX0OjsgQNUWF4uFoQeO9BJjRPDHnUaR3RwDMU63cb6GnpOMgGLzeMfFGJ6Y74l80
         2HKU+cWXVDy9mJJQwVNWAlnvVFE4qgOhHMYUa/1yr6Y9HiVyJT+Mi7/kzTbAjCVRUQ
         +p1JpVAj9lraw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hnWDdOzXHOeu; Thu, 24 Sep 2020 09:48:21 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 848A12D4A1C;
        Thu, 24 Sep 2020 09:48:21 -0400 (EDT)
Date:   Thu, 24 Sep 2020 09:48:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <1096125156.67906.1600955301444.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200923233618.2572849-3-posk@google.com>
References: <20200923233618.2572849-1-posk@google.com> <20200923233618.2572849-3-posk@google.com>
Subject: Re: [PATCH v8 3/3] rseq/selftests: test
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: rseq/selftests: test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: 3OkqHNXzOlqgv1xXNXg9kB+AB61rcw==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Sep 23, 2020, at 7:36 PM, Peter Oskolkov posk@google.com wrote:

> Based on Google-internal RSEQ work done by
> Paul Turner and Andrew Hunter.
> 
> This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
> The test quite often fails without the previous patch in this patchset,
> but consistently passes with it.
> 
> v3: added rseq_offset_deref_addv() to x86_64 to make the test
>    more explicit; on other architectures I kept using existing
>    rseq_cmpeqv_cmpeqv_storev() as I have no easy way to test
>    there.  Added a comment explaining why the test works this way.
> v4: skipped the test if rseq_offset_deref_addv() is not present
>    (that is, on all architectures other than x86_64).
> v8: split rseq_offset_deref_addv() into a separate patch;
>    moved the test to param_test; other minor tweaks.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> ---
> tools/testing/selftests/rseq/param_test.c     | 223 +++++++++++++++++-
> .../testing/selftests/rseq/run_param_test.sh  |   2 +
> 2 files changed, 224 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/param_test.c
> b/tools/testing/selftests/rseq/param_test.c
> index e8a657a5f48a..384589095864 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -1,8 +1,10 @@
> // SPDX-License-Identifier: LGPL-2.1
> #define _GNU_SOURCE
> #include <assert.h>
> +#include <linux/membarrier.h>
> #include <pthread.h>
> #include <sched.h>
> +#include <stdatomic.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> @@ -1131,6 +1133,220 @@ static int set_signal_handler(void)
> 	return ret;
> }
> 
> +struct test_membarrier_thread_args {
> +	int stop;
> +	intptr_t percpu_list_ptr;
> +};
> +
> +/* Worker threads modify data in their "active" percpu lists. */
> +void *test_membarrier_worker_thread(void *arg)
> +{
> +	struct test_membarrier_thread_args *args =
> +		(struct test_membarrier_thread_args *)arg;
> +	const int iters = opt_reps;
> +	int i;
> +
> +	if (rseq_register_current_thread()) {
> +		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +
> +	/* Wait for initialization. */
> +	while (!atomic_load(&args->percpu_list_ptr)) {}
> +
> +	for (i = 0; i < iters; ++i) {
> +		int ret;
> +
> +		do {
> +			int cpu = rseq_cpu_start();
> +
> +			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
> +				sizeof(struct percpu_list_entry) * cpu, 1, cpu);
> +		} while (rseq_unlikely(ret));
> +	}
> +
> +	if (rseq_unregister_current_thread()) {
> +		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d):
> %s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +	return NULL;
> +}
> +
> +void test_membarrier_init_percpu_list(struct percpu_list *list)
> +{
> +	int i;
> +
> +	memset(list, 0, sizeof(*list));
> +	for (i = 0; i < CPU_SETSIZE; i++) {
> +		struct percpu_list_node *node;
> +
> +		node = malloc(sizeof(*node));
> +		assert(node);
> +		node->data = 0;
> +		node->next = NULL;
> +		list->c[i].head = node;
> +	}
> +}
> +
> +void test_membarrier_free_percpu_list(struct percpu_list *list)
> +{
> +	int i;
> +
> +	for (i = 0; i < CPU_SETSIZE; i++)
> +		free(list->c[i].head);
> +}
> +
> +static int sys_membarrier(int cmd, int flags, int cpu_id)
> +{
> +	return syscall(__NR_membarrier, cmd, flags, cpu_id);
> +}
> +
> +/*
> + * The manager thread swaps per-cpu lists that worker threads see,
> + * and validates that there are no unexpected modifications.
> + */
> +void *test_membarrier_manager_thread(void *arg)
> +{
> +	struct test_membarrier_thread_args *args =
> +		(struct test_membarrier_thread_args *)arg;
> +	struct percpu_list list_a, list_b;
> +	intptr_t expect_a = 0, expect_b = 0;
> +	int cpu_a = 0, cpu_b = 0;
> +
> +	if (rseq_register_current_thread()) {
> +		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +
> +	/* Init lists. */
> +	test_membarrier_init_percpu_list(&list_a);
> +	test_membarrier_init_percpu_list(&list_b);
> +
> +	atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
> +
> +	while (!atomic_load(&args->stop)) {
> +		/* list_a is "active". */
> +		cpu_a = rand() % CPU_SETSIZE;
> +		/*
> +		 * As list_b is "inactive", we should never see changes
> +		 * to list_b.
> +		 */
> +		if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
> +			fprintf(stderr, "Membarrier test failed\n");
> +			abort();
> +		}
> +
> +		/* Make list_b "active". */
> +		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
> +		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
> +					MEMBARRIER_CMD_FLAG_CPU, cpu_a) &&
> +				errno != ENXIO /* missing CPU */) {
> +			perror("sys_membarrier");
> +			abort();
> +		}
> +		/*
> +		 * Cpu A should now only modify list_b, so the values
> +		 * in list_a should be stable.
> +		 */
> +		expect_a = atomic_load(&list_a.c[cpu_a].head->data);
> +
> +		cpu_b = rand() % CPU_SETSIZE;
> +		/*
> +		 * As list_a is "inactive", we should never see changes
> +		 * to list_a.
> +		 */
> +		if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
> +			fprintf(stderr, "Membarrier test failed\n");
> +			abort();
> +		}
> +
> +		/* Make list_a "active". */
> +		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
> +		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
> +					MEMBARRIER_CMD_FLAG_CPU, cpu_b) &&
> +				errno != ENXIO /* missing CPU*/) {
> +			perror("sys_membarrier");
> +			abort();
> +		}
> +		/* Remember a value from list_b. */
> +		expect_b = atomic_load(&list_b.c[cpu_b].head->data);
> +	}
> +
> +	test_membarrier_free_percpu_list(&list_a);
> +	test_membarrier_free_percpu_list(&list_b);
> +
> +	if (rseq_unregister_current_thread()) {
> +		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d):
> %s\n",
> +			errno, strerror(errno));
> +		abort();
> +	}
> +	return NULL;
> +}
> +
> +/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
> +#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
> +void test_membarrier(void)
> +{
> +	const int num_threads = opt_threads;
> +	struct test_membarrier_thread_args thread_args;
> +	pthread_t worker_threads[num_threads];
> +	pthread_t manager_thread;
> +	int i, ret;
> +
> +	if (sys_membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ, 0, 0)) {
> +		perror("sys_membarrier");
> +		abort();
> +	}
> +
> +	thread_args.stop = 0;
> +	thread_args.percpu_list_ptr = 0;
> +	ret = pthread_create(&manager_thread, NULL,
> +			test_membarrier_manager_thread, &thread_args);
> +	if (ret) {
> +		errno = ret;
> +		perror("pthread_create");
> +		abort();
> +	}
> +
> +	for (i = 0; i < num_threads; i++) {
> +		ret = pthread_create(&worker_threads[i], NULL,
> +				test_membarrier_worker_thread, &thread_args);
> +		if (ret) {
> +			errno = ret;
> +			perror("pthread_create");
> +			abort();
> +		}
> +	}
> +
> +
> +	for (i = 0; i < num_threads; i++) {
> +		ret = pthread_join(worker_threads[i], NULL);
> +		if (ret) {
> +			errno = ret;
> +			perror("pthread_join");
> +			abort();
> +		}
> +	}
> +
> +	atomic_store(&thread_args.stop, 1);
> +	ret = pthread_join(manager_thread, NULL);
> +	if (ret) {
> +		errno = ret;
> +		perror("pthread_join");
> +		abort();
> +	}
> +}
> +#else /* RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV */
> +void test_membarrier(void)
> +{
> +	fprintf(stderr, "rseq_offset_deref_addv is not implemented on this
> architecture. "
> +			"Skipping membarrier test.\n");
> +}
> +#endif
> +
> static void show_usage(int argc, char **argv)
> {
> 	printf("Usage : %s <OPTIONS>\n",
> @@ -1153,7 +1369,7 @@ static void show_usage(int argc, char **argv)
> 	printf("	[-r N] Number of repetitions per thread (default 5000)\n");
> 	printf("	[-d] Disable rseq system call (no initialization)\n");
> 	printf("	[-D M] Disable rseq for each M threads\n");
> -	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy,
> (i)ncrement\n");
> +	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy,
> (i)ncrement, membarrie(r)\n");
> 	printf("	[-M] Push into buffer and memcpy buffer with memory barriers.\n");
> 	printf("	[-v] Verbose output.\n");
> 	printf("	[-h] Show this help.\n");
> @@ -1268,6 +1484,7 @@ int main(int argc, char **argv)
> 			case 'i':
> 			case 'b':
> 			case 'm':
> +			case 'r':
> 				break;
> 			default:
> 				show_usage(argc, argv);
> @@ -1320,6 +1537,10 @@ int main(int argc, char **argv)
> 		printf_verbose("counter increment\n");
> 		test_percpu_inc();
> 		break;
> +	case 'r':
> +		printf_verbose("membarrier\n");
> +		test_membarrier();
> +		break;
> 	}
> 	if (!opt_disable_rseq && rseq_unregister_current_thread())
> 		abort();
> diff --git a/tools/testing/selftests/rseq/run_param_test.sh
> b/tools/testing/selftests/rseq/run_param_test.sh
> index e426304fd4a0..f51bc83c9e41 100755
> --- a/tools/testing/selftests/rseq/run_param_test.sh
> +++ b/tools/testing/selftests/rseq/run_param_test.sh
> @@ -15,6 +15,7 @@ TEST_LIST=(
> 	"-T m"
> 	"-T m -M"
> 	"-T i"
> +	"-T r"
> )
> 
> TEST_NAME=(
> @@ -25,6 +26,7 @@ TEST_NAME=(
> 	"memcpy"
> 	"memcpy with barrier"
> 	"increment"
> +	"membarrier"
> )
> IFS="$OLDIFS"
> 
> --
> 2.28.0.709.gb0816b6eb0-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
