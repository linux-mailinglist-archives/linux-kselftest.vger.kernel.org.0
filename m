Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6B59D06A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 07:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiHWFWf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 01:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHWFWe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 01:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DAB4F6A9
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 22:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661232151;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkIc8ViuUrab+AWM98YBTkyQZVuljcSqeeePZihec1I=;
        b=VhsPcgZzdZHe7lkOvTawn7p0uF6TjD3lO+AgVfDINq8YJ43mee+6Pfy2HDX9mVyHnIuJd9
        yhbamkSYwefLaezNCUyVas1GXbhst3I5YtP6EdGvPM5iHM1fkxRuMF8E6MahoX6WarjDfC
        brcgYYqo59semxkrFW45GOtWv9yqEY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-a2IubJ-xMtOP_V01WhvxAQ-1; Tue, 23 Aug 2022 01:22:30 -0400
X-MC-Unique: a2IubJ-xMtOP_V01WhvxAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B7E6101A596;
        Tue, 23 Aug 2022 05:22:29 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB621415125;
        Tue, 23 Aug 2022 05:22:19 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peterx@redhat.com, pbonzini@redhat.com, corbet@lwn.net,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-2-gshan@redhat.com> <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <87fshovtu0.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <171d0159-4698-354b-8b2f-49d920d03b1b@redhat.com>
Date:   Tue, 23 Aug 2022 15:22:17 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87fshovtu0.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Marc,

On 8/23/22 7:42 AM, Marc Zyngier wrote:
> On Mon, 22 Aug 2022 02:58:20 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>> On 8/19/22 6:00 PM, Marc Zyngier wrote:
>>> On Fri, 19 Aug 2022 01:55:57 +0100,
>>> Gavin Shan <gshan@redhat.com> wrote:
>>>>
>>>> The ring-based dirty memory tracking has been available and enabled
>>>> on x86 for a while. The feature is beneficial when the number of
>>>> dirty pages is small in a checkpointing system or live migration
>>>> scenario. More details can be found from fb04a1eddb1a ("KVM: X86:
>>>> Implement ring-based dirty memory tracking").
>>>>
>>>> This enables the ring-based dirty memory tracking on ARM64. It's
>>>> notable that no extra reserved ring entries are needed on ARM64
>>>> because the huge pages are always split into base pages when page
>>>> dirty tracking is enabled.
>>>
>>> Can you please elaborate on this? Adding a per-CPU ring of course
>>> results in extra memory allocation, so there must be a subtle
>>> x86-specific detail that I'm not aware of...
>>>
>>
>> Sure. I guess it's helpful to explain how it works in next revision.
>> Something like below:
>>
>> This enables the ring-based dirty memory tracking on ARM64. The feature
>> is enabled by CONFIG_HAVE_KVM_DIRTY_RING, detected and enabled by
>> CONFIG_HAVE_KVM_DIRTY_RING. A ring buffer is created on every vcpu and
>> each entry is described by 'struct kvm_dirty_gfn'. The ring buffer is
>> pushed by host when page becomes dirty and pulled by userspace. A vcpu
>> exit is forced when the ring buffer becomes full. The ring buffers on
>> all vcpus can be reset by ioctl command KVM_RESET_DIRTY_RINGS.
>>
>> Yes, I think so. Adding a per-CPU ring results in extra memory allocation.
>> However, it's avoiding synchronization among multiple vcpus when dirty
>> pages happen on multiple vcpus. More discussion can be found from [1]
> 
> Oh, I totally buy the relaxation of the synchronisation (though I
> doubt this will have any visible effect until we have something like
> Oliver's patches to allow parallel faulting).
> 
> But it is the "no extra reserved ring entries are needed on ARM64"
> argument that I don't get yet.
> 

Ok. The extra reserved ring entries are x86 specific. When x86's PML
(Page Modification Logging) hardware capability is enabled, the vcpu
exits due to full PML buffer, which is 512 entries. All the information
in PML buffer is pushed to the dirty ring buffer in one shoot. To
avoid overrunning the dirty ring buffer, there are 512 entries are
reserved.

   === include/linux/kvm_host.h

   #define KVM_DIRTY_RING_RSVD_ENTRIES    64     // fixed and reserved ring entries

   === virt/kvm/dirty_ring.c

   int __weak kvm_cpu_dirty_log_size(void)
   {
         return 0;
   }

   u32 kvm_dirty_ring_get_rsvd_entries(void)
   {
         return KVM_DIRTY_RING_RSVD_ENTRIES + kvm_cpu_dirty_log_size();
   }

   === arch/x86/kvm/mmu/mmu.c

   int kvm_cpu_dirty_log_size(void)
   {
         return kvm_x86_ops.cpu_dirty_log_size;    // Set to 512 when PML is enabled
   }


kvm_cpu_dirty_log_size() isn't be overrided by ARM64, meaning it returns
zero on ARM64. On x86, it returns 512 when PML is enabled.

>>
>> [1] https://patchwork.kernel.org/project/kvm/patch/BL2PR08MB4812F929A2760BC40EA757CF0630@BL2PR08MB481.namprd08.prod.outlook.com/
>> (comment#8 from Radim Krčmář on May 3, 2016, 2:11 p.m. UTC)
>>
>>
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    Documentation/virt/kvm/api.rst    | 2 +-
>>>>    arch/arm64/include/uapi/asm/kvm.h | 1 +
>>>>    arch/arm64/kvm/Kconfig            | 1 +
>>>>    arch/arm64/kvm/arm.c              | 8 ++++++++
>>>>    4 files changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>>> index abd7c32126ce..19fa1ac017ed 100644
>>>> --- a/Documentation/virt/kvm/api.rst
>>>> +++ b/Documentation/virt/kvm/api.rst
>>>> @@ -8022,7 +8022,7 @@ regardless of what has actually been exposed through the CPUID leaf.
>>>>    8.29 KVM_CAP_DIRTY_LOG_RING
>>>>    ---------------------------
>>>>    -:Architectures: x86
>>>> +:Architectures: x86, arm64
>>>>    :Parameters: args[0] - size of the dirty log ring
>>>>      KVM is capable of tracking dirty memory using ring buffers that
>>>> are
>>>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>>>> index 3bb134355874..7e04b0b8d2b2 100644
>>>> --- a/arch/arm64/include/uapi/asm/kvm.h
>>>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>>>> @@ -43,6 +43,7 @@
>>>>    #define __KVM_HAVE_VCPU_EVENTS
>>>>      #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
>>>> +#define KVM_DIRTY_LOG_PAGE_OFFSET 64
>>>
>>> For context, the documentation says:
>>>
>>> <quote>
>>> - if KVM_CAP_DIRTY_LOG_RING is available, a number of pages at
>>>     KVM_DIRTY_LOG_PAGE_OFFSET * PAGE_SIZE. [...]
>>> </quote>
>>>
>>> What is the reason for picking this particular value?
>>>
>>
>> It's inherited from x86. I don't think it has to be this particular
>> value.  The value is used to distinguish the region's owners like
>> kvm_run, KVM_PIO_PAGE_OFFSET, KVM_COALESCED_MMIO_PAGE_OFFSET, and
>> KVM_DIRTY_LOG_PAGE_OFFSET.
>>
>> How about to have 2 for KVM_DIRTY_LOG_PAGE_OFFSET in next revision?
>> The virtual area is cheap, I guess it's also nice to use x86's
>> pattern to have 64 for KVM_DIRTY_LOG_PAGE_OFFSET.
>>
>>      #define KVM_COALESCED_MMIO_PAGE_OFFSET   1
>>      #define KVM_DIRTY_LOG_PAGE_OFFSET        2
> 
> Given that this is just an offset in the vcpu "file", I don't think it
> matters that much. 64 definitely allows for some struct vcpu growth,
> and it doesn't hurt to be compatible with x86 (for once...).
> 

Sure, thanks. I think it'd better to have same pattern as x86 either.

>>
>>>>      #define KVM_REG_SIZE(id)
>>>> \
>>>>    	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
>>>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>>>> index 815cc118c675..0309b2d0f2da 100644
>>>> --- a/arch/arm64/kvm/Kconfig
>>>> +++ b/arch/arm64/kvm/Kconfig
>>>> @@ -32,6 +32,7 @@ menuconfig KVM
>>>>    	select KVM_VFIO
>>>>    	select HAVE_KVM_EVENTFD
>>>>    	select HAVE_KVM_IRQFD
>>>> +	select HAVE_KVM_DIRTY_RING
>>>>    	select HAVE_KVM_MSI
>>>>    	select HAVE_KVM_IRQCHIP
>>>>    	select HAVE_KVM_IRQ_ROUTING
>>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>>> index 986cee6fbc7f..3de6b9b39db7 100644
>>>> --- a/arch/arm64/kvm/arm.c
>>>> +++ b/arch/arm64/kvm/arm.c
>>>> @@ -866,6 +866,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>>>    		if (!ret)
>>>>    			ret = 1;
>>>>    +		/* Force vcpu exit if its dirty ring is soft-full */
>>>> +		if (unlikely(vcpu->kvm->dirty_ring_size &&
>>>> +			     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
>>>> +			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>>>> +			trace_kvm_dirty_ring_exit(vcpu);
>>>> +			ret = 0;
>>>> +		}
>>>> +
>>>
>>> Why can't this be moved to kvm_vcpu_exit_request() instead? I would
>>> also very much like the check to be made a common helper with x86.
>>>
>>> A seemingly approach would be to make this a request on dirty log
>>> insertion, and avoid the whole "check the log size" on every run,
>>> which adds pointless overhead to unsuspecting users (aka everyone).
>>>
>>
>> I though of having the check in kvm_vcpu_exit_request(). The various
>> exit reasons are prioritized. x86 gives KVM_EXIT_DIRTY_RING_FULL the
>> highest priority and ARM64 is just to follow. I don't think it really
>> matters. I will improve it accordingly in next revision:
>>
>> - Change kvm_dirty_ring_soft_full() to something as below in dirty_ring.c
>>
>>    bool kvm_dirty_ring_soft_full(struct kvm_vcpu *vcpu)
>>    {
>>         struct kvm *kvm = vcpu->vcpu;
>>         struct kvm_dirty_ring *ring = &vcpu->dirty_ring;
>>
>>         if (unlikely(kvm->dirty_ring_size &&
>>                      kvm_dirty_ring_used(ring) >= ring->soft_limit)) {
>>             vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>>             trace_kvm_dirty_ring_exit(vcpu);
>>             return true;
>>         }
>>
>>         return false;
>>    }
>>
>> - Use the modified kvm_dirty_ring_soft_full() in kvm_vcpu_exit_request().
>>
>> Userspace needs KVM_EXIT_DIRTY_RING_FULL to collect the dirty log in time.
>> Otherwise, the dirty log in the ring buffer will be overwritten. I'm not
>> sure if anything else I missed?
> 
> I'm fine with the above, but what I really wanted is a request from
> the dirty-ring insertion, instead of a check in kvm_vpcu_exit_request.
> Something like this (which obviously doesn't compile, but you'll get
> the idea):
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 986cee6fbc7f..0b41feb6fb7d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -747,6 +747,12 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
>   
>   		if (kvm_check_request(KVM_REQ_SUSPEND, vcpu))
>   			return kvm_vcpu_suspend(vcpu);
> +
> +		if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu)) {
> +			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> +			trace_kvm_dirty_ring_exit(vcpu);
> +			return 0;
> +		}
>   	}
>   
>   	return 1;
> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index f4c2a6eb1666..08b2f01164fa 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -149,6 +149,7 @@ int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring)
>   
>   void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
>   {
> +	struct kvm_vcpu *vcpu = container_of(ring, struct kvm_vcpu, dirty_ring);
>   	struct kvm_dirty_gfn *entry;
>   
>   	/* It should never get full */
> @@ -166,6 +167,9 @@ void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
>   	kvm_dirty_gfn_set_dirtied(entry);
>   	ring->dirty_index++;
>   	trace_kvm_dirty_ring_push(ring, slot, offset);
> +
> +	if (kvm_dirty_ring_soft_full(vcpu))
> +		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
>   }
>   
>   struct page *kvm_dirty_ring_get_page(struct kvm_dirty_ring *ring, u32 offset)
> 

Ok, thanks for the details, Marc. I will adopt your code in next revision :)

Thanks,
Gavin

