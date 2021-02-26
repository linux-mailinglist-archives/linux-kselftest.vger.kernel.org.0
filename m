Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A881325D58
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 06:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhBZF51 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 00:57:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2591 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBZF51 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 00:57:27 -0500
Received: from dggeme711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DmzP95f9FzWBGL;
        Fri, 26 Feb 2021 13:54:05 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme711-chm.china.huawei.com (10.1.199.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 26 Feb 2021 13:56:42 +0800
Subject: Re: [RFC PATCH v2 3/7] KVM: selftests: Make a generic helper to get
 vm guest mode strings
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20210225055940.18748-1-wangyanan55@huawei.com>
 <20210225055940.18748-4-wangyanan55@huawei.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <5fb5933a-0191-5901-e0e2-eeb4583b40d8@huawei.com>
Date:   Fri, 26 Feb 2021 13:56:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210225055940.18748-4-wangyanan55@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme711-chm.china.huawei.com (10.1.199.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2021/2/25 13:59, Yanan Wang wrote:
> For generality and conciseness, make an API which can be used in all
> kvm libs and selftests to get vm guest mode strings. And the index i
> is checked in the API in case of possiable faults.
>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
And here too, will include Suggested-by: Sean Christopherson 
<seanjc@google.com>.
> ---
>   .../testing/selftests/kvm/include/kvm_util.h  |  4 +--
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 29 ++++++++++++-------
>   2 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 2d7eb6989e83..f52a7492f47f 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -68,9 +68,6 @@ enum vm_guest_mode {
>   #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
>   #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
>   
> -#define vm_guest_mode_string(m) vm_guest_mode_string[m]
> -extern const char * const vm_guest_mode_string[];
> -
>   struct vm_guest_mode_params {
>   	unsigned int pa_bits;
>   	unsigned int va_bits;
> @@ -84,6 +81,7 @@ int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
>   int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
>   		    struct kvm_enable_cap *cap);
>   void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
> +const char *vm_guest_mode_string(uint32_t i);
>   
>   struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
>   void kvm_vm_free(struct kvm_vm *vmp);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d787cb802b4a..cc22c4ab7d67 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -141,17 +141,24 @@ static void vm_open(struct kvm_vm *vm, int perm)
>   		"rc: %i errno: %i", vm->fd, errno);
>   }
>   
> -const char * const vm_guest_mode_string[] = {
> -	"PA-bits:52,  VA-bits:48,  4K pages",
> -	"PA-bits:52,  VA-bits:48, 64K pages",
> -	"PA-bits:48,  VA-bits:48,  4K pages",
> -	"PA-bits:48,  VA-bits:48, 64K pages",
> -	"PA-bits:40,  VA-bits:48,  4K pages",
> -	"PA-bits:40,  VA-bits:48, 64K pages",
> -	"PA-bits:ANY, VA-bits:48,  4K pages",
> -};
> -_Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
> -	       "Missing new mode strings?");
> +const char *vm_guest_mode_string(uint32_t i)
> +{
> +	static const char * const strings[] = {
> +		[VM_MODE_P52V48_4K]	= "PA-bits:52,  VA-bits:48,  4K pages",
> +		[VM_MODE_P52V48_64K]	= "PA-bits:52,  VA-bits:48, 64K pages",
> +		[VM_MODE_P48V48_4K]	= "PA-bits:48,  VA-bits:48,  4K pages",
> +		[VM_MODE_P48V48_64K]	= "PA-bits:48,  VA-bits:48, 64K pages",
> +		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
> +		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
> +		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
> +	};
> +	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
> +		       "Missing new mode strings?");
> +
> +	TEST_ASSERT(i < NUM_VM_MODES, "Guest mode ID %d too big", i);
> +
> +	return strings[i];
> +}
>   
>   const struct vm_guest_mode_params vm_guest_mode_params[] = {
>   	{ 52, 48,  0x1000, 12 },
