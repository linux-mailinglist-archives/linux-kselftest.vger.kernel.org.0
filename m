Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB53B0A87
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jun 2021 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFVQow (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Jun 2021 12:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229718AbhFVQov (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Jun 2021 12:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624380155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZ/jjShM2csaIDvFW5mRJFXnn5bjSb9YKl92SFLLi/Q=;
        b=MNxf4EfgnwqKh2eZV+OpzuCl002hNBC9jBo1MU4viiKn1+9k4RMHvKRTgW+bJ6xgphfRtJ
        mpii2akK4vr0Uq0yOoZq2hUaDa/iDR4eIQt7O5kBDFJFpHYeJVeqpe6YAeYld46p/VUH/4
        w1sDHoasflg+bVuxLUrW98JVCeVglWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-wrTd_EXvP-2D4187s7K3lA-1; Tue, 22 Jun 2021 12:42:33 -0400
X-MC-Unique: wrTd_EXvP-2D4187s7K3lA-1
Received: by mail-wm1-f70.google.com with SMTP id w186-20020a1cdfc30000b02901ced88b501dso929001wmg.2
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jun 2021 09:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZ/jjShM2csaIDvFW5mRJFXnn5bjSb9YKl92SFLLi/Q=;
        b=V0Rr0QPov15X0qY/WhV8cVBpWozOUqYBdJVMj7dTGGSqZYx/LwHr2xxeIGslHqGu39
         fqgZhI7zp23v4fE6dzmVCEIPxBCyfw8AmvvXXW2T9FJxvSivfLkZpKq151gM5aaTHftB
         KAlD58rm78tEfItH7YM/jRmOSV1jQ3fcaF2ckEeuvReK3H2AulEcvXApib38ew/azfTL
         HskE/2+cbb1QAw1pUAjvdHcexhfvjVohf6e+P43AknRpsUiybvq1WzmX+pbi7aD0B7hf
         YaOOldziv7h7eQcUzovM1tYT5XJnKCHyWow4xrzZZYB8m70SIGfbx4VXhjhBwZM4a5yU
         dehA==
X-Gm-Message-State: AOAM533cRXuTgDFv4Zlx6CpzZsWfRb/zPTCQ4nwHVWZ77wwtnu+AuMbg
        FeK5yt/Ix3uXMhW5mmdTI9SKTUloISvn9+Fy651LCrZTQOAYga/S9EpFmXKId9ARMBQ60PP/oJc
        anXM8xxuFPTcfvT9vihWgFBzrp0QR
X-Received: by 2002:a5d:5901:: with SMTP id v1mr6220217wrd.29.1624380152418;
        Tue, 22 Jun 2021 09:42:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMCrXjYKpnnKgCX3jUH7OpoFM7otxXIytOLeUgT7ko+rdeB5uWN7XLaCuCrizomfZcmKzIDQ==
X-Received: by 2002:a5d:5901:: with SMTP id v1mr6220195wrd.29.1624380152245;
        Tue, 22 Jun 2021 09:42:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 12sm1106900wmj.12.2021.06.22.09.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 09:42:31 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: fix triple fault if ept=0 in
 dirty_log_test
To:     Hou Wenlong <houwenlong93@linux.alibaba.com>, kvm@gver.kernel.org
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <411ea2173f89abce56fc1fca5af913ed9c5a89c9.1624351343.git.houwenlong93@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d664ee87-c42e-a96b-ca9f-aceebc7fc2cd@redhat.com>
Date:   Tue, 22 Jun 2021 18:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <411ea2173f89abce56fc1fca5af913ed9c5a89c9.1624351343.git.houwenlong93@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 22/06/21 15:55, Hou Wenlong wrote:
> Commit 22f232d134e1 ("KVM: selftests: x86: Set supported CPUIDs on
> default VM") moved vcpu_set_cpuid into vm_create_with_vcpus, but
> dirty_log_test doesn't use it to create vm. So vcpu's CPUIDs is
> not set, the guest's pa_bits in kvm would be smaller than the
> value queried by userspace.
> 
> However, the dirty track memory slot is in the highest GPA, the
> reserved bits in gpte would be set with wrong pa_bits.
> For shadowpaing, page fault would fail in permission_fault and
> be injected into guest. Since guest doesn't have idt, it finally
> leads to vm_exit for triple fault.
> 
> Move vcpu_set_cpuid into vm_vcpu_add_default to set supported
> CPUIDs on default vcpu, since almost all tests need it.
> 
> Fixes: 22f232d134e1 ("KVM: selftests: x86: Set supported CPUIDs on default VM")
> Signed-off-by: Hou Wenlong <houwenlong93@linux.alibaba.com>
> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c         | 4 ----
>   tools/testing/selftests/kvm/lib/x86_64/processor.c | 3 +++
>   tools/testing/selftests/kvm/steal_time.c           | 2 --
>   3 files changed, 3 insertions(+), 6 deletions(-)

Queued, but this is missing:

diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
index 5f8dd74d415f..fd309fb9e2c4 100644
--- a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -102,8 +102,6 @@ static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, bool bsp_code)
  		vm_vcpu_add_default(vm, vcpuid, guest_bsp_vcpu);
  	else
  		vm_vcpu_add_default(vm, vcpuid, guest_not_bsp_vcpu);
-
-	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
  }
  
  static void run_vm_bsp(uint32_t bsp_vcpu)

Paolo

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index a2b732cf96ea..8ea854d7822d 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -375,10 +375,6 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
>   		uint32_t vcpuid = vcpuids ? vcpuids[i] : i;
>   
>   		vm_vcpu_add_default(vm, vcpuid, guest_code);
> -
> -#ifdef __x86_64__
> -		vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
> -#endif
>   	}
>   
>   	return vm;
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index efe235044421..595322b24e4c 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -600,6 +600,9 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>   	/* Setup the MP state */
>   	mp_state.mp_state = 0;
>   	vcpu_set_mp_state(vm, vcpuid, &mp_state);
> +
> +	/* Setup supported CPUIDs */
> +	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
>   }
>   
>   /*
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index fcc840088c91..a6fe75cb9a6e 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -73,8 +73,6 @@ static void steal_time_init(struct kvm_vm *vm)
>   	for (i = 0; i < NR_VCPUS; ++i) {
>   		int ret;
>   
> -		vcpu_set_cpuid(vm, i, kvm_get_supported_cpuid());
> -
>   		/* ST_GPA_BASE is identity mapped */
>   		st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
>   		sync_global_to_guest(vm, st_gva[i]);
> 

