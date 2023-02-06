Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA868C88C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 22:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBFVYC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 16:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBFVYB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 16:24:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A267CDC2
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Feb 2023 13:23:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id pj3so12916268pjb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Feb 2023 13:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjRXQ/qonNQW3nkbtuFUrdlBBvSAiIx0cRRrcJJmpv0=;
        b=pJyqPfUlhjfdu58efNPXYtzfuoMyBtyTVUOlJQCdPDvgLpoGLDksNB233WpM1C7/qO
         XU819MrT3H3L9PQKOQFDty8cW65kpSTlGA7WrNkSqB+nK0IwchD4iS2WGcwKvDd1+Bfq
         PKIqFkO7oDp71haOXUN9rsgsg0tI/1lxPd2s9zFMdf5Y7hEB19eynnCdQLPKxftjbgEi
         Ya+1lJLq/BTm2HhZTij33cBHdq9Qzhe3De4eyBkDtrUk7v/6emF7mWmb3/QICl8tFKPy
         tp9/uR7ZW0R+epAXHM2jzhgdWd9RP0HufOUuXqrhKtKisSoarOP+b4oalIcyjCikaaN3
         btfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjRXQ/qonNQW3nkbtuFUrdlBBvSAiIx0cRRrcJJmpv0=;
        b=ox95bQT4+BxXyAxsQDcvqijqHS3vrAcFnIAyY67m4CcQj0QqY3I8sbJC9yx+0rlnUW
         Xdm93Wqj6Z8dHB05BLLkqfJ0SZTnGjG0oTu5KrUQoxjOPV2RObrpl9L0ny6jBAy00lS1
         pRZDEpB1A4kIHOLIFUrNBVaQgQHHI826GJebrqmkGuyIyTFx3rj+KeyzV2lMO4NoL8zo
         69UTFWZDRy8Jj2f+Jirf+2QQA6ZC0y8LgI7OX6ZHWapD+gHfaaHCavDqeLknfd4A8i+Z
         ccsfLxRt/3nXajjPEjk52nvf7ZXqZOBYvOH9H/opLWwV7KQscv6EvwgsBf1NNfOvw9dC
         ufdg==
X-Gm-Message-State: AO0yUKVQ1xXQGDRDOAv2r8Y4wlka/X19uM91ZA48/pJa4Aguqexu1CC6
        ScV0VEccfHk9ySqZjp5EnpFHuA==
X-Google-Smtp-Source: AK7set8AfRRIiKtZXq7K8Kz0iylVHBuimpmNO1kC+dPlQrPVd0DozJysgSwmfofyxKr2tQZHNulhnw==
X-Received: by 2002:a17:902:cf45:b0:199:bd0:c44c with SMTP id e5-20020a170902cf4500b001990bd0c44cmr246208plg.31.1675718638754;
        Mon, 06 Feb 2023 13:23:58 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001991f3d85acsm1921117plq.299.2023.02.06.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:23:58 -0800 (PST)
Date:   Mon, 6 Feb 2023 13:23:54 -0800
From:   David Matlack <dmatlack@google.com>
To:     Kevin Cheng <chengkev@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] KVM: selftests: Added eBPF program and selftest to
 collect vmx exit stat
Message-ID: <Y+Fv6idxCMkuMf1R@google.com>
References: <20230126004346.4101944-1-chengkev@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126004346.4101944-1-chengkev@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 26, 2023 at 12:43:46AM +0000, Kevin Cheng wrote:
> Introduce a new selftest that loads an eBPF program that stores the
> number of vmx exit counts per vcpu per vm. A process is created per
> vm_create to load a separate eBPF program to collect its own stats
> unique to the pid.
> 
> This test aims to serve as a proof-of-concept and example for using eBPF
> to collect stats that are not provided by the other stats interfaces
> such as kvm_binary_stats. Since there will be no further stats being
> added to kvm_binary_stats, developers can use this selftest as a
> reference for writing their own eBPF program + selftest to collect
> whatever stat they may need for debugging/monitoring.
> 
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   4 +-
>  tools/testing/selftests/kvm/build_ebpf.sh     |   5 +
>  .../testing/selftests/kvm/kvm_vmx_exit_ebpf.c | 128 ++++++++++++++++++
>  .../selftests/kvm/kvm_vmx_exit_ebpf_kern.c    |  74 ++++++++++

x86-specific tests should go in tools/testing/selftests/kvm/x86_64.

>  4 files changed, 210 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/build_ebpf.sh
>  create mode 100644 tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c
>  create mode 100644 tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 1750f91dd936..d9f56ccbc7bb 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
>  TEST_GEN_PROGS_x86_64 += steal_time
>  TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>  TEST_GEN_PROGS_x86_64 += system_counter_offset_test
> +TEST_GEN_PROGS_x86_64 += kvm_vmx_exit_ebpf
>  
>  # Compiled outputs used by test targets
>  TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
> @@ -176,6 +177,7 @@ TEST_GEN_PROGS_riscv += set_memory_region_test
>  TEST_GEN_PROGS_riscv += kvm_binary_stats_test
>  
>  TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
> +TEST_PROGS := build_ebpf.sh

build_ebpf.sh is not be a test program. It should be part of this
Makefile. i.e. running

  make -C tools/testing/selftests/kvm

should build tools/lib/bpf and kvm_vmx_exit_ebpf_kern.o. Developers
can't be expected to run
tools/testing/testing/selftests/kvm/build_ebpf.sh every time they want
to build the KVM selftests.

>  TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
>  TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
>  LIBKVM += $(LIBKVM_$(ARCH_DIR))
> @@ -208,7 +210,7 @@ no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
>  pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
>  	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
>  
> -LDLIBS += -ldl
> +LDLIBS += -ldl -L$(top_srcdir)/tools/lib/bpf -lbpf -lelf -lz

Please add a comment document why the different libraries are needed for
future readers.

>  LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
>  
>  LIBKVM_C := $(filter %.c,$(LIBKVM))
> diff --git a/tools/testing/selftests/kvm/build_ebpf.sh b/tools/testing/selftests/kvm/build_ebpf.sh
> new file mode 100644
> index 000000000000..b8038b0a0da5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/build_ebpf.sh
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c kvm_vmx_exit_ebpf_kern.c
> +        -o kvm_vmx_exit_ebpf_kern.o
> +make -C ../../../lib/bpf || exit

As mentioned above, this should be part of the Makefile.

> diff --git a/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c
> new file mode 100644
> index 000000000000..a4bd2c549207
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <signal.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <bpf/bpf.h>
> +#include <../bpf/libbpf.h>
> +#include <linux/btf.h>
> +
> +#include "test_util.h"
> +
> +#include "kvm_util.h"
> +#include "linux/kvm.h"
> +
> +#define VCPU_ID         0
> +
> +struct stats_map_key {
> +	__u32 pid;
> +	__u32 vcpu_id;
> +	__u32 exit_reason;
> +};
> +
> +static void guest_code(void)
> +{
> +	__asm__ __volatile__("cpuid");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (argc < 2) {
> +		fprintf(stderr, "Expected arguments: <number_of_vms>\n");
> +		return EXIT_FAILURE;

Selftests run by default with no arguments. So please provide a default
number of VMs to run with the test. Otherwise this test will just fail
by default.

It's common (at least for me) to run all KVM selftests when submitting
patches. So having one test that always fails will be annoying to deal
with.

Also, can you provide some details (e.g. in a comment) about why a user
might want to pick a different number of VMs? What is the value of
running this test with 1 VM vs. 2 vs. 3 etc.?

> +	}
> +	int n = atoi(argv[1]);
> +
> +	for (int i = 0; i < n; i++) {
> +		if (fork() == 0) {

Put the implementation of the child process into a helper function to
reduce indentation.

> +			struct kvm_vm *vm;
> +			struct kvm_vcpu *vcpu;
> +
> +			vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +			// BPF userspace code
> +			struct bpf_object *obj;
> +			struct bpf_program *prog;
> +			struct bpf_map *map_obj;
> +			struct bpf_link *link = NULL;
> +
> +			obj = bpf_object__open_file("kvm_vmx_exit_ebpf_kern.o", NULL);
> +			if (libbpf_get_error(obj)) {
> +				fprintf(stderr, "ERROR: opening BPF object file failed\n");
> +				return 0;

I notice the children and parent always return 0. The test should exit
with a non-0 return code if it fails.

> +			}
> +
> +			map_obj = bpf_object__find_map_by_name(obj, "vmx_exit_map");
> +			if (!map_obj) {
> +				fprintf(stderr, "ERROR: loading of vmx BPF map failed\n");
> +				goto cleanup;
> +			}
> +
> +			struct bpf_map *pid_map = bpf_object__find_map_by_name(obj, "pid_map");
> +
> +			if (!pid_map) {
> +				fprintf(stderr, "ERROR: loading of pid BPF map failed\n");
> +				goto cleanup;
> +			}
> +
> +			/* load BPF program */

No need for this comment. bpf_object__load() is quite obvious already :)

> +			if (bpf_object__load(obj)) {
> +				fprintf(stderr, "ERROR: loading BPF object file failed\n");
> +				goto cleanup;
> +			}
> +
> +			__u32 userspace_pid = (__u32)getpid();
> +			__u32 val = (__u32)getpid();
> +
> +			bpf_map_update_elem(bpf_map__fd(pid_map), &userspace_pid, &val, 0);
> +
> +			prog = bpf_object__find_program_by_name(obj, "bpf_exit_prog");
> +			if (libbpf_get_error(prog)) {
> +				fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
> +				goto cleanup;
> +			}
> +
> +			link = bpf_program__attach(prog);
> +			if (libbpf_get_error(link)) {
> +				fprintf(stderr, "ERROR: bpf_program__attach failed\n");
> +				link = NULL;
> +				goto cleanup;
> +			}
> +
> +			for (int j = 0; j < 10000; j++)
> +				vcpu_run(vcpu);

It might be interesting to (1) add some timing around this loop and (2)
run this loop without any bpf programs attached. i.e. Automatically do
an A/B performance comparison with and without bpf programs.

> +
> +			struct stats_map_key key = {
> +				.pid = 0,
> +				.vcpu_id = 0,
> +				.exit_reason = 18,
> +			};
> +
> +
> +			struct stats_map_key next_key, lookup_key;
> +
> +			lookup_key = key;
> +			while (bpf_map_get_next_key(bpf_map__fd(map_obj), &lookup_key, &next_key)
> +				 == 0) {
> +				int count;
> +
> +				bpf_map_lookup_elem(bpf_map__fd(map_obj), &next_key, &count);
> +				fprintf(stdout, "exit reason: '%d'\ncount: %d\npid: %d\n",
> +						next_key.exit_reason, count, next_key.pid);

Instead of printing ot the count, assert that the count has the right
value.

> +				lookup_key = next_key;
> +			}
> +
> +cleanup:
> +			bpf_link__destroy(link);
> +			bpf_object__close(obj);
> +			kvm_vm_free(vm);

Shouldn't the child process exit here? Otherwise it's going to keep
looping and creating *more* children?

> +		}
> +	}
> +
> +	for (int i = 0; i < n; i++)
> +		wait(NULL);
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c
> new file mode 100644
> index 000000000000..b9c076f93171
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c

I think we should carve out a new directory for bpf programs. If we mix
this in with the selftest .c files, it will start to get confusing.

e.g. tools/testing/selftests/kvm/bpf/vmx_exit_count.c

Note I dropped the "kvm_" prefix since it's obvious this is a
KVM-related program since it's under the KVM selftest directory. And I
also dropped "_ebpf_kern" since that's now obvious from the fact that
this is in the bpf/ subdirectory (which should only contain bpf
programs).

> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/bpf.h>
> +#include <stdint.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +struct kvm_vcpu {
> +	int vcpu_id;
> +};
> +
> +struct vmx_args {
> +	__u64 pad;
> +	unsigned int exit_reason;
> +	__u32 isa;
> +	struct kvm_vcpu *vcpu;
> +};
> +
> +struct stats_map_key {
> +	__u32 pid;
> +	__u32 vcpu_id;
> +	__u32 exit_reason;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1024);
> +	__type(key, struct stats_map_key);
> +	__type(value, int);
> +} vmx_exit_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +} pid_map SEC(".maps");
> +
> +
> +SEC("tracepoint/kvm/kvm_exit")
> +int bpf_exit_prog(struct vmx_args *ctx)
> +{
> +	__u32 curr_pid = (bpf_get_current_pid_tgid() >> 32);
> +
> +	__u32 *userspace_pid = bpf_map_lookup_elem(&pid_map, &curr_pid);
> +
> +	if (!userspace_pid || *userspace_pid != curr_pid)
> +		return 0;
> +
> +	struct kvm_vcpu *vcpu = ctx->vcpu;
> +	int _vcpu_id = BPF_CORE_READ(vcpu, vcpu_id);
> +
> +	struct stats_map_key key = {
> +		.pid = (bpf_get_current_pid_tgid() >> 32),
> +		.vcpu_id = _vcpu_id,
> +		.exit_reason = ctx->exit_reason,
> +	};
> +
> +	int *value = bpf_map_lookup_elem(&vmx_exit_map, &key);
> +
> +	if (value) {
> +		*value = *value + 1;
> +		bpf_map_update_elem(&vmx_exit_map, &key, value, BPF_ANY);
> +	} else {
> +		int temp = 1;
> +
> +		bpf_map_update_elem(&vmx_exit_map, &key, &temp, BPF_ANY);
> +	}
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 
