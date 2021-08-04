Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039B43E038E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 16:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhHDOmo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 10:42:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:48481 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238191AbhHDOmm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 10:42:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="299522001"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="299522001"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 07:42:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="511998985"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.28.78]) ([10.255.28.78])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 07:42:23 -0700
Subject: Re: [RFC PATCH 1/4] KVM: selftests: Add support for creating
 non-default type VMs
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
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
 <e1651746-aa46-31e7-e1c0-99f3faaf1586@intel.com>
 <ede70f11e713ee0140c0e684c3d46b3aa1176e5e.camel@redhat.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <42a812a9-7f17-2a26-d289-1f921408a469@intel.com>
Date:   Wed, 4 Aug 2021 22:42:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ede70f11e713ee0140c0e684c3d46b3aa1176e5e.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/4/2021 10:24 PM, Maxim Levitsky wrote:
> On Wed, 2021-08-04 at 14:09 +0800, Xiaoyao Li wrote:
>> On 7/27/2021 2:37 AM, Erdem Aktas wrote:
>>> Currently vm_create function only creates KVM_X86_LEGACY_VM type VMs.
>>> Changing the vm_create function to accept type parameter to create
>>> new VM types.
>>>
>>> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
>>> Reviewed-by: Sean Christopherson <seanjc@google.com>
>>> Reviewed-by: Peter Gonda <pgonda@google.com>
>>> Reviewed-by: Marc Orr <marcorr@google.com>
>>> Reviewed-by: Sagi Shahar <sagis@google.com>
>>> ---
>>>    .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>>>    tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++--
>>>    2 files changed, 27 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
>>> index d53bfadd2..c63df42d6 100644
>>> --- a/tools/testing/selftests/kvm/include/kvm_util.h
>>> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
>>> @@ -88,6 +88,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
>>>    void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
>>>    
>>>    struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
>>> +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm, int type);
>>>    void kvm_vm_free(struct kvm_vm *vmp);
>>>    void kvm_vm_restart(struct kvm_vm *vmp, int perm);
>>>    void kvm_vm_release(struct kvm_vm *vmp);
>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> index e5fbf16f7..70caa3882 100644
>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> @@ -180,13 +180,36 @@ _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params)
>>>     * Return:
>>>     *   Pointer to opaque structure that describes the created VM.
>>>     *
>>> - * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
>>> + * Wrapper VM Create function to create a VM with default type (0).
>>
>> Can we pass KVM_X86_LEGACY_VM (whatever name when it's upstreamed)
>> instead of 0?
> 
> To be honest I would prefer this to be called something like KVM_X86_STANDARD_VM,
> or something.
> 
> I don't think that normal unencrypted virtualization is already legacy, even if TDX
> docs claim that.

I'm not proposing to use this specific name introduced in TDX RFC 
series, but proposing to use the name defined in KVM in the future 
instead of hard-coded 0.

Yes, KVM_X86_STANDARD_VM or KVM_X86_NORMAL_VM (proposed by Paolo) is 
better than KVM_X86_LEGACY_VM.

> Just my personal opinion.
> 
> Best regards,
> 	Maxim Levitsky
> 
>>
>>> + */
>>> +struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>>> +{
>>> +	return __vm_create(mode, phy_pages, perm, 0);
>>> +}
>>> +
>>
>>
> 
> 

