Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC963DFB52
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhHDGJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 02:09:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:42718 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235499AbhHDGJq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 02:09:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="210744639"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="210744639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 23:09:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="511750613"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.122]) ([10.239.13.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 23:09:28 -0700
Subject: Re: [RFC PATCH 1/4] KVM: selftests: Add support for creating
 non-default type VMs
To:     Erdem Aktas <erdemaktas@google.com>,
        linux-kselftest@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ricardo Koller <ricarkol@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
References: <20210726183816.1343022-1-erdemaktas@google.com>
 <20210726183816.1343022-2-erdemaktas@google.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <e1651746-aa46-31e7-e1c0-99f3faaf1586@intel.com>
Date:   Wed, 4 Aug 2021 14:09:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726183816.1343022-2-erdemaktas@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/27/2021 2:37 AM, Erdem Aktas wrote:
> Currently vm_create function only creates KVM_X86_LEGACY_VM type VMs.
> Changing the vm_create function to accept type parameter to create
> new VM types.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Peter Gonda <pgonda@google.com>
> Reviewed-by: Marc Orr <marcorr@google.com>
> Reviewed-by: Sagi Shahar <sagis@google.com>
> ---
>   .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++--
>   2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index d53bfadd2..c63df42d6 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -88,6 +88,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
>   void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
>   
>   struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm, int type);
>   void kvm_vm_free(struct kvm_vm *vmp);
>   void kvm_vm_restart(struct kvm_vm *vmp, int perm);
>   void kvm_vm_release(struct kvm_vm *vmp);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e5fbf16f7..70caa3882 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -180,13 +180,36 @@ _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params)
>    * Return:
>    *   Pointer to opaque structure that describes the created VM.
>    *
> - * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
> + * Wrapper VM Create function to create a VM with default type (0).

Can we pass KVM_X86_LEGACY_VM (whatever name when it's upstreamed) 
instead of 0?

> + */
> +struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
> +{
> +	return __vm_create(mode, phy_pages, perm, 0);
> +}
> +


