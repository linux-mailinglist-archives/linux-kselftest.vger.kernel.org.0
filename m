Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5908B313061
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhBHLNe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 06:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233003AbhBHLLA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 06:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612782569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWsy2OzXmBA8/rXmMsQxJYIV8N13PgKF6jEi0HBAh2s=;
        b=iMFIW12vG9UdE0KmjZT30eJYPr7arFPg3ZvJSw0K14H4Emfe6CkxEXQ3ygcE6bOBnYyM+N
        jUulMVgqWeoM71viwJT0igYKT5Dpo+y/9RsiwdbkwcKf6385tjDIUCMzd82PV2C6WSZ5d1
        YECdjmSKGWWdD6y0H+Ls79+Qj5QoEhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-36nl_Jg4ME-FV6yYg7r5ig-1; Mon, 08 Feb 2021 06:09:28 -0500
X-MC-Unique: 36nl_Jg4ME-FV6yYg7r5ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3FC835E20;
        Mon,  8 Feb 2021 11:09:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75D1E57;
        Mon,  8 Feb 2021 11:09:24 +0000 (UTC)
Date:   Mon, 8 Feb 2021 12:09:18 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: add a memslot-related performance
 benchmark
Message-ID: <20210208110918.2rzt24qv2g67jtqo@kamzik.brq.redhat.com>
References: <5e5d83b305077e3e65b130dbb31c131bfb831170.1612139762.git.maciej.szmigiero@oracle.com>
 <ec67677c725d9f52d4abef3cfef07eac266c15cd.1612139762.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec67677c725d9f52d4abef3cfef07eac266c15cd.1612139762.git.maciej.szmigiero@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 01, 2021 at 09:10:57AM +0100, Maciej S. Szmigiero wrote:
[...]
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index ce8f4ad39684..059a655053ca 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -31,3 +31,4 @@
>  /kvm_create_max_vcpus
>  /set_memory_region_test
>  /steal_time
> +/memslot_perf_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index e7c6237d7383..2abc9e182c30 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -65,6 +65,7 @@ TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
>  TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
>  TEST_GEN_PROGS_x86_64 += set_memory_region_test
>  TEST_GEN_PROGS_x86_64 += steal_time
> +TEST_GEN_PROGS_x86_64 += memslot_perf_test
> 
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
>  TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve

We've been trying keep the lists in .gitignore and Makefile in alphabetic
order. It's not really important, but seems like we should keep it now
that we've got it. Well, except I see dirty_log_perf_test and
dirty_log_test are out of order already...

[...]
> +static bool prepare_vm(struct vm_data *data, int nslots, uint64_t *maxslots,
> +		       void *guest_code, uint64_t mempages,
> +		       struct timespec *slot_runtime)
> +{
> +	uint32_t max_mem_slots;
> +	uint64_t rempages;
> +	uint64_t guest_addr;
> +	uint32_t slot;
> +	struct timespec tstart;
> +	struct sync_area *sync;
> +
> +	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
> +	TEST_ASSERT(max_mem_slots > 1,
> +		    "KVM_CAP_NR_MEMSLOTS should be greater than 1");
> +	TEST_ASSERT(nslots > 1 || nslots == -1,
> +		    "Slot count cap should be greater than 1");
> +	if (nslots != -1)
> +		max_mem_slots = min(max_mem_slots, (uint32_t)nslots);
> +	pr_info_v("Allowed number of memory slots: %"PRIu32"\n", max_mem_slots);
> +
> +	TEST_ASSERT(mempages > 1,
> +		    "Can't test without any memory");
> +
> +	data->npages = mempages;
> +	data->nslots = max_mem_slots - 1;
> +	data->pages_per_slot = mempages / data->nslots;
> +	if (!data->pages_per_slot) {
> +		*maxslots = mempages + 1;
> +		return false;
> +	}
> +
> +	rempages = mempages % data->nslots;
> +	data->hva_slots = malloc(sizeof(*data->hva_slots) * data->nslots);
> +	TEST_ASSERT(data->hva_slots, "malloc() fail");
> +
> +	data->vm = vm_create_default(VCPU_ID, mempages, guest_code);
> +
> +	vcpu_set_cpuid(data->vm, VCPU_ID, kvm_get_supported_cpuid());

This vcpu_set_cpuid() call, which causes problems for non-x86 builds,
is now embedded in vm_create_default() and therefore redundant here.


Otherwise this looks good to me. I'll try to find some time to test
it on an AArch64 machine configured to use 4k pages on the host.

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

