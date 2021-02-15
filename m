Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4731BFA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhBOQrV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhBOQp1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613407439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p32yrhYZRIgR/WiILityRbY8UJL08Kbup6w2UNC6/nE=;
        b=CRKigEV9LOxTWbuu50VAJj5e0w4k2FMrw02kNPDUWoUy1IYkC4m5c9hNcmW3BRGhrpwWw9
        dIeEzlX6geZd6uqvwugJQa9hpsZeo3rmbnt1CaKt3pnx5EqYYabq9dcw8XF/xNznGg/0ST
        Aq6mhIH7EDBuAsEStHJeL2m5JRmNxjE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-n5MpYhRXMn2Wazs1JS_-GA-1; Mon, 15 Feb 2021 11:43:58 -0500
X-MC-Unique: n5MpYhRXMn2Wazs1JS_-GA-1
Received: by mail-ej1-f70.google.com with SMTP id hx26so4775303ejc.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p32yrhYZRIgR/WiILityRbY8UJL08Kbup6w2UNC6/nE=;
        b=AuRuc1BzrPqqdEDHamSo1OZlu9KP3/gR2Vi2oPn14P4c6GyXz5Zma7rk3x89J8jBJu
         jKsVfv2Fryr56g8AoDn2AES0SZbT6//q/QDFD0K1kB3AxdF7SgbBGCMocRargOQ3LIBa
         SflpkXUz4scmOkYyFCTkKoRBVwcD9RhFNvdWbjyGkQpIFAVJiT9tZh07X+f8Zy8163TN
         GX6IhR4A+lT+gZ/isovvOH9WxpPO/6IcqU3aeD7fU/C4ZuXS+XV2W2sjgSDQetQdcJN5
         +8JLlsffhFSAx2IflCYg9Ms1YMqSgE92clPkGgTbpZL2P3FGHPSP/oG5OuKXxiWttxPy
         QbRQ==
X-Gm-Message-State: AOAM533m44ZXk1l0DzThdnPQqdNgsI0bPo6jLi3o53mD7CFtt5Xxokng
        xdABQ/oRJSJ/sObB4ir8szXjxHRiNBM5kYZ7cFq9ftb/Clo39zsuyn6E/QFFY5bS2bqCF2GGYu4
        OhsVeH+TQjYXDUuqKjKiA1HvEkD0A
X-Received: by 2002:a17:906:7e42:: with SMTP id z2mr16456537ejr.177.1613407437121;
        Mon, 15 Feb 2021 08:43:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0PMAkrdMEdn6cfe/LUrnCCNoBVh4opo9+Wo0JLvvGKilfm04bnEdmdjBW+wfCrSzmIA9meA==
X-Received: by 2002:a17:906:7e42:: with SMTP id z2mr16456504ejr.177.1613407436909;
        Mon, 15 Feb 2021 08:43:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id di27sm10429178edb.21.2021.02.15.08.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Feb 2021 08:43:56 -0800 (PST)
Subject: Re: [PATCH] selftests: kvm: add hardware_disable test
To:     Marc Orr <marcorr@google.com>, ikalvarado@google.com,
        huah@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, jmattson@google.com
References: <20210213001452.1719001-1-marcorr@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4bf9adb-e816-4532-4a8f-24242d31b55b@redhat.com>
Date:   Mon, 15 Feb 2021 17:43:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210213001452.1719001-1-marcorr@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/02/21 01:14, Marc Orr wrote:
> From: Ignacio Alvarado <ikalvarado@google.com>
> 
> This test launches 512 VMs in serial and kills them after a random
> amount of time.
> 
> The test was original written to exercise KVM user notifiers in
> the context of1650b4ebc99d:
> - KVM: Disable irq while unregistering user notifier
> - https://lore.kernel.org/kvm/CACXrx53vkO=HKfwWwk+fVpvxcNjPrYmtDZ10qWxFvVX_PTGp3g@mail.gmail.com/
> 
> Recently, this test piqued my interest because it proved useful to
> for AMD SNP in exercising the "in-use" pages, described in APM section
> 15.36.12, "Running SNP-Active Virtual Machines".
> 
> To run the test, first compile:
> $ make "CPPFLAGS=-static -Wl,--whole-archive -lpthread -Wl,--no-whole-archive" \
>      -C tools/testing/selftests/kvm/
> 
> Then, copy the test over to a machine with the kernel and run:
> $ ./hardware_disable_test

Queued, but these two paragraphs do not belong in an upstream commit 
message.  Thanks!

Paolo

> Signed-off-by: Ignacio Alvarado <ikalvarado@google.com>
> Signed-off-by: Marc Orr <marcorr@google.com>
> ---
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/hardware_disable_test.c     | 165 ++++++++++++++++++
>   3 files changed, 167 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/hardware_disable_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index ce8f4ad39684..d631e111441a 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -28,6 +28,7 @@
>   /demand_paging_test
>   /dirty_log_test
>   /dirty_log_perf_test
> +/hardware_disable_test
>   /kvm_create_max_vcpus
>   /set_memory_region_test
>   /steal_time
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index fe41c6a0fa67..c1c403d878f6 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -62,6 +62,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
>   TEST_GEN_PROGS_x86_64 += demand_paging_test
>   TEST_GEN_PROGS_x86_64 += dirty_log_test
>   TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
> +TEST_GEN_PROGS_x86_64 += hardware_disable_test
>   TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
>   TEST_GEN_PROGS_x86_64 += set_memory_region_test
>   TEST_GEN_PROGS_x86_64 += steal_time
> diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> new file mode 100644
> index 000000000000..2f2eeb8a1d86
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This test is intended to reproduce a crash that happens when
> + * kvm_arch_hardware_disable is called and it attempts to unregister the user
> + * return notifiers.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <semaphore.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/wait.h>
> +
> +#include <test_util.h>
> +
> +#include "kvm_util.h"
> +
> +#define VCPU_NUM 4
> +#define SLEEPING_THREAD_NUM (1 << 4)
> +#define FORK_NUM (1ULL << 9)
> +#define DELAY_US_MAX 2000
> +#define GUEST_CODE_PIO_PORT 4
> +
> +sem_t *sem;
> +
> +/* Arguments for the pthreads */
> +struct payload {
> +	struct kvm_vm *vm;
> +	uint32_t index;
> +};
> +
> +static void guest_code(void)
> +{
> +	for (;;)
> +		;  /* Some busy work */
> +	printf("Should not be reached.\n");
> +}
> +
> +static void *run_vcpu(void *arg)
> +{
> +	struct payload *payload = (struct payload *)arg;
> +	struct kvm_run *state = vcpu_state(payload->vm, payload->index);
> +
> +	vcpu_run(payload->vm, payload->index);
> +
> +	TEST_ASSERT(false, "%s: exited with reason %d: %s\n",
> +		    __func__, state->exit_reason,
> +		    exit_reason_str(state->exit_reason));
> +	pthread_exit(NULL);
> +}
> +
> +static void *sleeping_thread(void *arg)
> +{
> +	int fd;
> +
> +	while (true) {
> +		fd = open("/dev/null", O_RDWR);
> +		close(fd);
> +	}
> +	TEST_ASSERT(false, "%s: exited\n", __func__);
> +	pthread_exit(NULL);
> +}
> +
> +static inline void check_create_thread(pthread_t *thread, pthread_attr_t *attr,
> +				       void *(*f)(void *), void *arg)
> +{
> +	int r;
> +
> +	r = pthread_create(thread, attr, f, arg);
> +	TEST_ASSERT(r == 0, "%s: failed to create thread", __func__);
> +}
> +
> +static inline void check_set_affinity(pthread_t thread, cpu_set_t *cpu_set)
> +{
> +	int r;
> +
> +	r = pthread_setaffinity_np(thread, sizeof(cpu_set_t), cpu_set);
> +	TEST_ASSERT(r == 0, "%s: failed set affinity", __func__);
> +}
> +
> +static inline void check_join(pthread_t thread, void **retval)
> +{
> +	int r;
> +
> +	r = pthread_join(thread, retval);
> +	TEST_ASSERT(r == 0, "%s: failed to join thread", __func__);
> +}
> +
> +static void run_test(uint32_t run)
> +{
> +	struct kvm_vm *vm;
> +	cpu_set_t cpu_set;
> +	pthread_t threads[VCPU_NUM];
> +	pthread_t throw_away;
> +	struct payload payloads[VCPU_NUM];
> +	void *b;
> +	uint32_t i, j;
> +
> +	CPU_ZERO(&cpu_set);
> +	for (i = 0; i < VCPU_NUM; i++)
> +		CPU_SET(i, &cpu_set);
> +
> +	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> +	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
> +	vm_create_irqchip(vm);
> +
> +	fprintf(stderr, "%s: [%d] start vcpus\n", __func__, run);
> +	for (i = 0; i < VCPU_NUM; ++i) {
> +		vm_vcpu_add_default(vm, i, guest_code);
> +		payloads[i].vm = vm;
> +		payloads[i].index = i;
> +
> +		check_create_thread(&threads[i], NULL, run_vcpu,
> +				    (void *)&payloads[i]);
> +		check_set_affinity(threads[i], &cpu_set);
> +
> +		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
> +			check_create_thread(&throw_away, NULL, sleeping_thread,
> +					    (void *)NULL);
> +			check_set_affinity(throw_away, &cpu_set);
> +		}
> +	}
> +	fprintf(stderr, "%s: [%d] all threads launched\n", __func__, run);
> +	sem_post(sem);
> +	for (i = 0; i < VCPU_NUM; ++i)
> +		check_join(threads[i], &b);
> +	/* Should not be reached */
> +	TEST_ASSERT(false, "%s: [%d] child escaped the ninja\n", __func__, run);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	uint32_t i;
> +	int s, r;
> +	pid_t pid;
> +
> +	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
> +	sem_unlink("vm_sem");
> +
> +	for (i = 0; i < FORK_NUM; ++i) {
> +		pid = fork();
> +		TEST_ASSERT(pid >= 0, "%s: unable to fork", __func__);
> +		if (pid == 0)
> +			run_test(i); /* This function always exits */
> +
> +		fprintf(stderr, "%s: [%d] waiting semaphore\n", __func__, i);
> +		sem_wait(sem);
> +		r = (rand() % DELAY_US_MAX) + 1;
> +		fprintf(stderr, "%s: [%d] waiting %dus\n", __func__, i, r);
> +		usleep(r);
> +		r = waitpid(pid, &s, WNOHANG);
> +		TEST_ASSERT(r != pid,
> +			    "%s: [%d] child exited unexpectedly status: [%d]",
> +			    __func__, i, s);
> +		fprintf(stderr, "%s: [%d] killing child\n", __func__, i);
> +		kill(pid, SIGKILL);
> +	}
> +
> +	sem_destroy(sem);
> +	exit(0);
> +}
> 

