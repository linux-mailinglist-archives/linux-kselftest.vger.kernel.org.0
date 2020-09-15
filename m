Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D91B26AEC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 22:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgIOUmC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 16:42:02 -0400
Received: from mail.efficios.com ([167.114.26.124]:39948 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgIOUll (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 16:41:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DE66829EC40;
        Tue, 15 Sep 2020 16:41:36 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VbGBGWYQvovi; Tue, 15 Sep 2020 16:41:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3CED329E9E7;
        Tue, 15 Sep 2020 16:41:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3CED329E9E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1600202496;
        bh=le8h0tVNuYHcELnncLlBkUwt9cA1/N/I19Gf5v4OgdI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Hul3Sqq3R/mdqhpxSpM4sJiS4BURXV4nK/9vKMIhTldDEhExOQtfLE2TR7YjuNZlw
         vdDAOBs5pscLGFdmZjCaFiky47DMCI3kwR66TlnzLmMNyQY/0jI/W9jzJnYrDgs5k+
         eRz1qu28IRJeXlZm7ee5nFVnZqSFakx/3M46XKdc/VygCjvIjM+VGSpi0sPjV208pZ
         z+YXjSCwUtMAXwPgPiFvTY/TzlXohXZZTeQ3x744baCG6vs/Z5tlEKT2O/R5BaPKhQ
         SlHXvF/R68cNhZYYkLII6aLz2XSgGAQHwsG4kNn6rKOZmJqqgnhO7pCbzvMZQ2KLH9
         Acbu8qVFcU5Iw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dH1jgJsX6iiR; Tue, 15 Sep 2020 16:41:36 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 26A7429EBC0;
        Tue, 15 Sep 2020 16:41:36 -0400 (EDT)
Date:   Tue, 15 Sep 2020 16:41:36 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Message-ID: <1887105478.12300.1600202496058.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200915185541.1565837-2-posk@google.com>
References: <20200915185541.1565837-1-posk@google.com> <20200915185541.1565837-2-posk@google.com>
Subject: Re: [PATCH 2/2 v7] rseq/selftests: test
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: rseq/selftests: test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Thread-Index: dRGTwmcn7exPT8Wdisjha6Fa3zHQ7Q==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ Adding selftests maintainer and mailing list in CC. You should add them to the CC list
  of the selftests patches for the next round. ]

----- On Sep 15, 2020, at 2:55 PM, Peter Oskolkov posk@google.com wrote:

> Based on Google-internal RSEQ work done by
> Paul Turner and Andrew Hunter.
> 
> This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
> The test quite often fails without the previous patch in this patchset,
> but consistently passes with it.

Did you consider moving this test into tools/testing/selftests/rseq/param_test.c
instead, and update the script "run_param_test.sh" accordingly ? You would leverage for
free all the work I have done to insert configurable delay loops into the critical
sections, which will very likely increase the likelihood of failure tremendously.

Reproducible frequent and fast failure is really something we want to aim for here
when a bug is hiding.

> 
> v3: added rseq_offset_deref_addv() to x86_64 to make the test
>    more explicit; on other architectures I kept using existing
>    rseq_cmpeqv_cmpeqv_storev() as I have no easy way to test
>    there.  Added a comment explaining why the test works this way.
> v4: skipped the test if rseq_offset_deref_addv() is not present
>    (that is, on all architectures other than x86_64).
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
> .../selftests/rseq/basic_percpu_ops_test.c    | 187 ++++++++++++++++++
> tools/testing/selftests/rseq/rseq-x86.h       |  57 ++++++
> 2 files changed, 244 insertions(+)
> 
> diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> index eb3f6db36d36..e6e10ba4b9ed 100644
> --- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> +++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
> @@ -3,16 +3,24 @@
> #include <assert.h>
> #include <pthread.h>
> #include <sched.h>
> +#include <stdatomic.h>

That would be the first time stdatomic.h is included in the kernel selftests.
Do we want this dependency ?

> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <stddef.h>
> +#include <syscall.h>
> +#include <unistd.h>
> 
> #include "rseq.h"
> 
> #define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
> 
> +/* The local <linux/membarrier.h> may not contain the commands below. */
> +#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ	(1<<7)
> +#define MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ	(1<<8)
> +#define MEMBARRIER_CMD_FLAG_CPU		(1<<0)
> +

The usual way to build and run tests AFAIK is to do "make headers_install"
first, and then build the tests against those headers. Therefore, when
building the tests, the additional membarrier commands and flags should always
be there. Please remove those duplicated preprocessor defines.

> struct percpu_lock_entry {
> 	intptr_t v;
> } __attribute__((aligned(128)));
> @@ -289,6 +297,183 @@ void test_percpu_list(void)
> 	assert(sum == expected_sum);
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
> +	const int iters = 10 * 1000 * 1000;
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
> +							128 * cpu, 1, cpu);

That 128 happens to be related to:

struct percpu_list_entry {
        struct percpu_list_node *head;
} __attribute__((aligned(128)));

struct percpu_list {
        struct percpu_list_entry c[CPU_SETSIZE];
};

Please don't hardcode numbers like that. Instead:

+			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
+							sizeof(struct percpu_list_entry) * cpu, 1, cpu);

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
> +		sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
> +			       MEMBARRIER_CMD_FLAG_CPU, cpu_a);

missing error check.

> +		/*
> +		 * Cpu A should now only modify list_b, so we values

we -> the

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
> +		sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
> +			       MEMBARRIER_CMD_FLAG_CPU, cpu_b);

missing error check.

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
> +void test_membarrier(void)
> +{
> +#ifndef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV

Please lift the preprocessor conditional outside of the function, e.g.:

#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
void test_membarrier(void)
{
   [... code goes here...]
}
#else /* RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV /*
void test_membarrier(void)
{
}
#endif /* RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV */


> +	fprintf(stderr, "rseq_offset_deref_addv is not implemented on this
> architecture. "
> +			"Skipping membarrier test.\n");
> +	return;
> +#else
> +	struct test_membarrier_thread_args thread_args;
> +	pthread_t worker_threads[CPU_SETSIZE];
> +	pthread_t manager_thread;
> +	int i;
> +
> +	sys_membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ, 0, 0);

Missing error handling.

> +
> +	thread_args.stop = 0;
> +	thread_args.percpu_list_ptr = 0;
> +	pthread_create(&manager_thread, NULL,
> +		       test_membarrier_manager_thread, &thread_args);
> +
> +	for (i = 0; i < CPU_SETSIZE; i++)
> +		pthread_create(&worker_threads[i], NULL,
> +		       test_membarrier_worker_thread, &thread_args);
> +
> +	for (i = 0; i < CPU_SETSIZE; i++)
> +		pthread_join(worker_threads[i], NULL);
> +
> +	atomic_store(&thread_args.stop, 1);
> +	pthread_join(manager_thread, NULL);

Arguably the existing tests do not check pthread_* errors, but I guess it would not
hurt to do so.

> +#endif
> +}
> +
> int main(int argc, char **argv)
> {
> 	if (rseq_register_current_thread()) {
> @@ -300,6 +485,8 @@ int main(int argc, char **argv)
> 	test_percpu_spinlock();
> 	printf("percpu_list\n");
> 	test_percpu_list();
> +	printf("membarrier\n");
> +	test_membarrier();
> 	if (rseq_unregister_current_thread()) {
> 		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
> 			errno, strerror(errno));
> diff --git a/tools/testing/selftests/rseq/rseq-x86.h
> b/tools/testing/selftests/rseq/rseq-x86.h
> index b2da6004fe30..640411518e46 100644
> --- a/tools/testing/selftests/rseq/rseq-x86.h
> +++ b/tools/testing/selftests/rseq/rseq-x86.h
> @@ -279,6 +279,63 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
> #endif
> }
> 
> +#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
> +
> +/*
> + *   pval = *(ptr+off)
> + *  *pval += inc;
> + */

Addition to rseq-x86.h should be split into its own commit.

Thanks,

Mathieu

> +static inline __attribute__((always_inline))
> +int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto (
> +		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
> +#endif
> +		/* Start rseq by storing table entry pointer into rseq_cs. */
> +		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
> +		RSEQ_INJECT_ASM(3)
> +#ifdef RSEQ_COMPARE_TWICE
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
> +#endif
> +		/* get p+v */
> +		"movq %[ptr], %%rbx\n\t"
> +		"addq %[off], %%rbx\n\t"
> +		/* get pv */
> +		"movq (%%rbx), %%rcx\n\t"
> +		/* *pv += inc */
> +		"addq %[inc], (%%rcx)\n\t"
> +		"2:\n\t"
> +		RSEQ_INJECT_ASM(4)
> +		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
> +		: /* gcc asm goto does not allow outputs */
> +		: [cpu_id]		"r" (cpu),
> +		  [rseq_abi]		"r" (&__rseq_abi),
> +		  /* final store input */
> +		  [ptr]			"m" (*ptr),
> +		  [off]			"er" (off),
> +		  [inc]			"er" (inc)
> +		: "memory", "cc", "rax", "rbx", "rcx"
> +		  RSEQ_INJECT_CLOBBER
> +		: abort
> +#ifdef RSEQ_COMPARE_TWICE
> +		  , error1
> +#endif
> +	);
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +#endif
> +}
> +
> static inline __attribute__((always_inline))
> int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
> 				 intptr_t *v2, intptr_t newv2,
> --
> 2.28.0.618.gf4bc123cb7-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
