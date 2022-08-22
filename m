Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9359B762
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiHVB6n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 21:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiHVB6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 21:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0210FC9
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 18:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661133516;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Krkj7XTnCtjViG9b8n/OBoFVjFdMc6CFu64n/j38mOw=;
        b=GzgxjqxmeoIJx2tjETMTMlI3wK6YgT1hoe6S5Ar5grrwVfUcEFYKPy0HEwtDZ3NS2BFBYI
        XxXl7qDYCZ10o5PgfT6MfBUOqG/1sln/K0w30w6EXU8QRAGYR5UecFZ6sMeGqbBOY1E+9Q
        olXjbqTuPTkTg+jJjQ0eaajDBkWMokg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-cjhPf0ltNzSeEla4-Qi79A-1; Sun, 21 Aug 2022 21:58:33 -0400
X-MC-Unique: cjhPf0ltNzSeEla4-Qi79A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49F8F8032F1;
        Mon, 22 Aug 2022 01:58:32 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DF624010D42;
        Mon, 22 Aug 2022 01:58:24 +0000 (UTC)
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
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
Date:   Mon, 22 Aug 2022 11:58:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87lerkwtm5.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Marc,

On 8/19/22 6:00 PM, Marc Zyngier wrote:
> On Fri, 19 Aug 2022 01:55:57 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> The ring-based dirty memory tracking has been available and enabled
>> on x86 for a while. The feature is beneficial when the number of
>> dirty pages is small in a checkpointing system or live migration
>> scenario. More details can be found from fb04a1eddb1a ("KVM: X86:
>> Implement ring-based dirty memory tracking").
>>
>> This enables the ring-based dirty memory tracking on ARM64. It's
>> notable that no extra reserved ring entries are needed on ARM64
>> because the huge pages are always split into base pages when page
>> dirty tracking is enabled.
> 
> Can you please elaborate on this? Adding a per-CPU ring of course
> results in extra memory allocation, so there must be a subtle
> x86-specific detail that I'm not aware of...
> 

Sure. I guess it's helpful to explain how it works in next revision.
Something like below:

This enables the ring-based dirty memory tracking on ARM64. The feature
is enabled by CONFIG_HAVE_KVM_DIRTY_RING, detected and enabled by
CONFIG_HAVE_KVM_DIRTY_RING. A ring buffer is created on every vcpu and
each entry is described by 'struct kvm_dirty_gfn'. The ring buffer is
pushed by host when page becomes dirty and pulled by userspace. A vcpu
exit is forced when the ring buffer becomes full. The ring buffers on
all vcpus can be reset by ioctl command KVM_RESET_DIRTY_RINGS.

Yes, I think so. Adding a per-CPU ring results in extra memory allocation.
However, it's avoiding synchronization among multiple vcpus when dirty
pages happen on multiple vcpus. More discussion can be found from [1]

[1] https://patchwork.kernel.org/project/kvm/patch/BL2PR08MB4812F929A2760BC40EA757CF0630@BL2PR08MB481.namprd08.prod.outlook.com/
(comment#8 from Radim Krčmář on May 3, 2016, 2:11 p.m. UTC)


>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   Documentation/virt/kvm/api.rst    | 2 +-
>>   arch/arm64/include/uapi/asm/kvm.h | 1 +
>>   arch/arm64/kvm/Kconfig            | 1 +
>>   arch/arm64/kvm/arm.c              | 8 ++++++++
>>   4 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index abd7c32126ce..19fa1ac017ed 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -8022,7 +8022,7 @@ regardless of what has actually been exposed through the CPUID leaf.
>>   8.29 KVM_CAP_DIRTY_LOG_RING
>>   ---------------------------
>>   
>> -:Architectures: x86
>> +:Architectures: x86, arm64
>>   :Parameters: args[0] - size of the dirty log ring
>>   
>>   KVM is capable of tracking dirty memory using ring buffers that are
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 3bb134355874..7e04b0b8d2b2 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -43,6 +43,7 @@
>>   #define __KVM_HAVE_VCPU_EVENTS
>>   
>>   #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
>> +#define KVM_DIRTY_LOG_PAGE_OFFSET 64
> 
> For context, the documentation says:
> 
> <quote>
> - if KVM_CAP_DIRTY_LOG_RING is available, a number of pages at
>    KVM_DIRTY_LOG_PAGE_OFFSET * PAGE_SIZE. [...]
> </quote>
> 
> What is the reason for picking this particular value?
> 

It's inherited from x86. I don't think it has to be this particular value.
The value is used to distinguish the region's owners like kvm_run, KVM_PIO_PAGE_OFFSET,
KVM_COALESCED_MMIO_PAGE_OFFSET, and KVM_DIRTY_LOG_PAGE_OFFSET.

How about to have 2 for KVM_DIRTY_LOG_PAGE_OFFSET in next revision?
The virtual area is cheap, I guess it's also nice to use x86's
pattern to have 64 for KVM_DIRTY_LOG_PAGE_OFFSET.

     #define KVM_COALESCED_MMIO_PAGE_OFFSET   1
     #define KVM_DIRTY_LOG_PAGE_OFFSET        2

>>   
>>   #define KVM_REG_SIZE(id)						\
>>   	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
>> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
>> index 815cc118c675..0309b2d0f2da 100644
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -32,6 +32,7 @@ menuconfig KVM
>>   	select KVM_VFIO
>>   	select HAVE_KVM_EVENTFD
>>   	select HAVE_KVM_IRQFD
>> +	select HAVE_KVM_DIRTY_RING
>>   	select HAVE_KVM_MSI
>>   	select HAVE_KVM_IRQCHIP
>>   	select HAVE_KVM_IRQ_ROUTING
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 986cee6fbc7f..3de6b9b39db7 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -866,6 +866,14 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>   		if (!ret)
>>   			ret = 1;
>>   
>> +		/* Force vcpu exit if its dirty ring is soft-full */
>> +		if (unlikely(vcpu->kvm->dirty_ring_size &&
>> +			     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
>> +			vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>> +			trace_kvm_dirty_ring_exit(vcpu);
>> +			ret = 0;
>> +		}
>> +
> 
> Why can't this be moved to kvm_vcpu_exit_request() instead? I would
> also very much like the check to be made a common helper with x86.
> 
> A seemingly approach would be to make this a request on dirty log
> insertion, and avoid the whole "check the log size" on every run,
> which adds pointless overhead to unsuspecting users (aka everyone).
> 

I though of having the check in kvm_vcpu_exit_request(). The various
exit reasons are prioritized. x86 gives KVM_EXIT_DIRTY_RING_FULL the
highest priority and ARM64 is just to follow. I don't think it really
matters. I will improve it accordingly in next revision:

- Change kvm_dirty_ring_soft_full() to something as below in dirty_ring.c

   bool kvm_dirty_ring_soft_full(struct kvm_vcpu *vcpu)
   {
        struct kvm *kvm = vcpu->vcpu;
        struct kvm_dirty_ring *ring = &vcpu->dirty_ring;

        if (unlikely(kvm->dirty_ring_size &&
                     kvm_dirty_ring_used(ring) >= ring->soft_limit)) {
            vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
            trace_kvm_dirty_ring_exit(vcpu);
            return true;
        }

        return false;
   }

- Use the modified kvm_dirty_ring_soft_full() in kvm_vcpu_exit_request().

Userspace needs KVM_EXIT_DIRTY_RING_FULL to collect the dirty log in time.
Otherwise, the dirty log in the ring buffer will be overwritten. I'm not
sure if anything else I missed?

Thanks,
Gavin





