Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5098E3511D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Apr 2021 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhDAJUT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 05:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233677AbhDAJUP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 05:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617268814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tqkY/KklJbUlRX7wYqGwlwbzfBKDIW/dEIBw+UVuq/Y=;
        b=gFNfzgTBJs7PWA51REdjVqmWkP9JjE65aOG8cM/AX/Wxhdq3kM8tuKlSRhnqtFTRYpVXXP
        eFctuFUsloUYLZ9PBVzyHJKsZPncdKcKsriOhdd2kWdhJQXtGby3QlcXOfiqc21xkXzIZL
        nb3EFKG6KxA/hjNEAYG9lGMpaqvkda4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-ZJ7W2wujNhe3moo_XGJ18g-1; Thu, 01 Apr 2021 05:20:13 -0400
X-MC-Unique: ZJ7W2wujNhe3moo_XGJ18g-1
Received: by mail-ed1-f70.google.com with SMTP id p6so2511457edq.21
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Apr 2021 02:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tqkY/KklJbUlRX7wYqGwlwbzfBKDIW/dEIBw+UVuq/Y=;
        b=FT6zpYXqvwweYSaQD9WG8JVKcS51rL1xpyaWbN7f+s3foNrBHHnHF3YiVSInWXo0ms
         iZjSuSWojXE51eVVBS3exUt7W7j9jUgefe0IDV5qazzQo3jNZjhpoGkIUpk3PSb3DTfn
         Baf3yWOroD6nk1P7cZQyfq4xAHMc4BajlLFSUDEYKYjlQUaSwXRLLBiJp5IvFKbTXPcU
         1TDEsM/I+CRt+ZWnnuY15RoC+0ThsChsHJZSqlyQpvTmn5zLklQl087FqNFAiuikba1z
         q62K1cJb3twVC12sUYU1o/q4Mr47sIgTOP7PDrOfU+7ZsOXWtXwoi4oMrVfgEgkJ0e+H
         Qsaw==
X-Gm-Message-State: AOAM532Tz7wK9JQ/d+KB+UYGdZOdBS4ZQ143rA0vSvZGEhIpY6oTNh+6
        oMEoDsocxXjKgexvkyL+zIFaXhIXeYl3MHWs7gPCfXtw1OE7MRqT1eiJSQrFoCR9/Mo0wH8rchj
        vER2Vcc/YdyGBd+jI3BrvaXaRvLeLsV+RzGT1+ZhvmbMOTvRR2LR02wd18V2aOJnXpXpFv1u1Iw
        FvBIcH
X-Received: by 2002:a17:906:845b:: with SMTP id e27mr7866969ejy.487.1617268812407;
        Thu, 01 Apr 2021 02:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOGG2JuaAQQ9FEvsR/6XcZyMErwwdTF32DTdaLR3mVZUquT9DGaRJ4UimdafWZKrfQNo8MTw==
X-Received: by 2002:a17:906:845b:: with SMTP id e27mr7866946ejy.487.1617268812200;
        Thu, 01 Apr 2021 02:20:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c17sm3643770edw.32.2021.04.01.02.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:20:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests: kvm: add get_emulated_cpuid test
In-Reply-To: <20210330185841.44792-5-eesposit@redhat.com>
References: <20210330185841.44792-1-eesposit@redhat.com>
 <20210330185841.44792-5-eesposit@redhat.com>
Date:   Thu, 01 Apr 2021 11:20:11 +0200
Message-ID: <87k0pms6no.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Emanuele Giuseppe Esposito <eesposit@redhat.com> writes:

> Introduce a new selftest for the KVM_GET_EMULATED_CPUID
> ioctl. Since the behavior and functionality is similar to
> get_cpuid_test, the test checks:
>
> 1) checks for corner case in the nent field of the struct kvm_cpuid2.
> 2) sets and gets it as cpuid from the guest VM
>
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/get_emulated_cpuid.c | 183 ++++++++++++++++++
>  3 files changed, 185 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 7bd7e776c266..f1523f3bfd04 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -8,6 +8,7 @@
>  /x86_64/debug_regs
>  /x86_64/evmcs_test
>  /x86_64/get_cpuid_test
> +x86_64/get_emulated_cpuid
>  /x86_64/get_msr_index_features
>  /x86_64/kvm_pv_test
>  /x86_64/hyperv_clock
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 67eebb53235f..0d8d3bd5a7c7 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -40,6 +40,7 @@ LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_ha
>  
>  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
>  TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> +TEST_GEN_PROGS_x86_64 += x86_64/get_emulated_cpuid
>  TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>  TEST_GEN_PROGS_x86_64 += x86_64/get_cpuid_test
>  TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
> diff --git a/tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c b/tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c
> new file mode 100644
> index 000000000000..f5294dc4b8ff
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021, Red Hat Inc.
> + *
> + * Generic tests for KVM CPUID set/get ioctls
> + */
> +#include <asm/kvm_para.h>
> +#include <linux/kvm_para.h>
> +#include <stdint.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +#define VCPU_ID 0
> +#define MAX_NENT 1000
> +
> +/* CPUIDs known to differ */
> +struct {
> +	u32 function;
> +	u32 index;
> +} mangled_cpuids[] = {
> +	{.function = 0xd, .index = 0},
> +};
> +
> +static void guest_main(void)
> +{
> +
> +}
> +
> +static bool is_cpuid_mangled(struct kvm_cpuid_entry2 *entrie)
> +{
> +	int i;
> +
> +	for (i = 0; i < sizeof(mangled_cpuids); i++) {
> +		if (mangled_cpuids[i].function == entrie->function &&
> +		    mangled_cpuids[i].index == entrie->index)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void check_cpuid(struct kvm_cpuid2 *cpuid, struct kvm_cpuid_entry2 *entrie)
> +{
> +	int i;
> +
> +	for (i = 0; i < cpuid->nent; i++) {
> +		if (cpuid->entries[i].function == entrie->function &&
> +		    cpuid->entries[i].index == entrie->index) {
> +			if (is_cpuid_mangled(entrie))
> +				return;
> +
> +			TEST_ASSERT(cpuid->entries[i].eax == entrie->eax &&
> +				    cpuid->entries[i].ebx == entrie->ebx &&
> +				    cpuid->entries[i].ecx == entrie->ecx &&
> +				    cpuid->entries[i].edx == entrie->edx,
> +				    "CPUID 0x%x.%x differ: 0x%x:0x%x:0x%x:0x%x vs 0x%x:0x%x:0x%x:0x%x",
> +				    entrie->function, entrie->index,
> +				    cpuid->entries[i].eax, cpuid->entries[i].ebx,
> +				    cpuid->entries[i].ecx, cpuid->entries[i].edx,
> +				    entrie->eax, entrie->ebx, entrie->ecx, entrie->edx);
> +			return;
> +		}
> +	}
> +
> +	TEST_ASSERT(false, "CPUID 0x%x.%x not found", entrie->function, entrie->index);
> +}
> +
> +static void compare_cpuids(struct kvm_cpuid2 *cpuid1,
> +						   struct kvm_cpuid2 *cpuid2)
> +{
> +	int i;
> +
> +	for (i = 0; i < cpuid1->nent; i++)
> +		check_cpuid(cpuid2, &cpuid1->entries[i]);
> +
> +	for (i = 0; i < cpuid2->nent; i++)
> +		check_cpuid(cpuid1, &cpuid2->entries[i]);
> +}

CPUID comparison here seems to be borrowed from get_cpuid_test.c, I
think we can either put it to a library or (my preference) just merge
these two selftests together. 'get_cpuid_test' name is generic enough to
be used for KVM_GET_EMULATED_CPUID too.

> +
> +struct kvm_cpuid2 *vcpu_alloc_cpuid(struct kvm_vm *vm, vm_vaddr_t *p_gva, struct kvm_cpuid2 *cpuid)
> +{
> +	int size = sizeof(*cpuid) + cpuid->nent * sizeof(cpuid->entries[0]);
> +	vm_vaddr_t gva = vm_vaddr_alloc(vm, size,
> +					getpagesize(), 0, 0);
> +	struct kvm_cpuid2 *guest_cpuids = addr_gva2hva(vm, gva);
> +
> +	memcpy(guest_cpuids, cpuid, size);
> +
> +	*p_gva = gva;
> +	return guest_cpuids;
> +}
> +
> +static struct kvm_cpuid2 *alloc_custom_kvm_cpuid2(int nent)
> +{
> +	struct kvm_cpuid2 *cpuid;
> +	size_t size;
> +
> +	size = sizeof(*cpuid);
> +	size += nent * sizeof(struct kvm_cpuid_entry2);
> +	cpuid = calloc(1, size);
> +	if (!cpuid) {
> +		perror("malloc");
> +		abort();
> +	}
> +
> +	cpuid->nent = nent;
> +
> +	return cpuid;
> +}
> +
> +static void test_emulated_entries(struct kvm_vm *vm)
> +{
> +	int res, right_nent;
> +	struct kvm_cpuid2 *cpuid;
> +
> +	cpuid = alloc_custom_kvm_cpuid2(MAX_NENT);
> +
> +	/* 0 nent, return E2BIG */
> +	cpuid->nent = 0;
> +	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
> +	TEST_ASSERT(res == -1 && errno == E2BIG,
> +				"KVM_GET_EMULATED_CPUID should fail E2BIG with nent=0");
> +
> +	/* high nent, set the entries and adjust */
> +	cpuid->nent = MAX_NENT;
> +	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
> +	printf("%d %d\n", res, errno);
> +	TEST_ASSERT(res == 0,
> +			"KVM_GET_EMULATED_CPUID should not fail with nent > actual nent");
> +	right_nent = cpuid->nent;
> +
> +	/* high nent, set the entries and adjust */
> +	cpuid->nent++;
> +	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
> +	TEST_ASSERT(res == 0,
> +			"KVM_GET_EMULATED_CPUID should not fail with nent > actual nent");
> +	TEST_ASSERT(right_nent == cpuid->nent,
> +				"KVM_GET_EMULATED_CPUID nent should be always the same");
> +
> +	/* low nent, return E2BIG */
> +	if (right_nent > 1) {
> +		cpuid->nent = 1;
> +		res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
> +		TEST_ASSERT(res == -1 && errno == E2BIG,
> +					"KVM_GET_EMULATED_CPUID should fail with nent=1");
> +	}
> +
> +	/* exact nent */
> +	cpuid->nent = right_nent;
> +	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
> +	TEST_ASSERT(res == 0,
> +			"KVM_GET_EMULATED_CPUID should not fail with nent == actual nent");
> +	TEST_ASSERT(cpuid->nent == right_nent,
> +			"KVM_GET_EMULATED_CPUID should be invaried when nent is exact");
> +
> +	free(cpuid);
> +}
> +
> +// emulated is all emulated
> +// supported is only hw + kvm

/*
 * ...
 */

comments please

> +int main(void)
> +{
> +	struct kvm_cpuid2 *emul_cpuid, *cpuid2;
> +	struct kvm_vm *vm;
> +
> +	if (!kvm_check_cap(KVM_CAP_EXT_EMUL_CPUID)) {
> +		print_skip("KVM_GET_EMULATED_CPUID not available");
> +		return 0;
> +	}
> +
> +	vm = vm_create_default(VCPU_ID, 0, guest_main);
> +
> +	emul_cpuid = kvm_get_emulated_cpuid();
> +	vcpu_set_cpuid(vm, VCPU_ID, emul_cpuid);
> +	cpuid2 = vcpu_get_cpuid(vm, VCPU_ID);
> +
> +	test_emulated_entries(vm);
> +	compare_cpuids(emul_cpuid, cpuid2);
> +
> +	kvm_vm_free(vm);
> +}

-- 
Vitaly

