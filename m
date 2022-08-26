Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4825A20A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 08:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiHZGFt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244621AbiHZGFs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 02:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26713204F
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Aug 2022 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661493946;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lqh2n2750WP3Dgy6fwmu8zFAJxbNa0Ek7hJYWPU2vOg=;
        b=aSDPCfIIGfndBi88FMpGG6HPQkrsPqNe3wxt8KQudjNte5+O5L9NcO0y9kCLk+I3CA5715
        By7KpGe36LLowYJzDhB88vaIWTDX72EPESED835Gu/ETGpVQKFi1KsNO38ct1T0/kHPxL4
        s7USfmDIQR5Wti34sW3lzyNRSg94YqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-XrZySnM_PJeUU444C_7XHw-1; Fri, 26 Aug 2022 02:05:39 -0400
X-MC-Unique: XrZySnM_PJeUU444C_7XHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E497885A58A;
        Fri, 26 Aug 2022 06:05:38 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2893E945DD;
        Fri, 26 Aug 2022 06:05:30 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
To:     Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, corbet@lwn.net, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        oliver.upton@linux.dev, catalin.marinas@arm.com, will@kernel.org,
        shuah@kernel.org, seanjc@google.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
References: <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <87fshovtu0.wl-maz@kernel.org>
 <171d0159-4698-354b-8b2f-49d920d03b1b@redhat.com>
 <YwTc++Lz6lh3aR4F@xz-m1.local> <87bksawz0w.wl-maz@kernel.org>
 <YwVEoM1pj2MPCELp@xz-m1.local> <878rnewpaw.wl-maz@kernel.org>
 <YwVgaGp3HOGzC8k2@xz-m1.local> <87y1vdr98o.wl-maz@kernel.org>
 <YwZQHqS5DZBloYPZ@xz-m1.local> <877d2xweae.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <78c613e8-b600-119e-0d33-b049dd7c35ce@redhat.com>
Date:   Fri, 26 Aug 2022 16:05:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <877d2xweae.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Marc,

On 8/25/22 6:57 AM, Marc Zyngier wrote:
> On Wed, 24 Aug 2022 17:21:50 +0100,
> Peter Xu <peterx@redhat.com> wrote:
>>
>> On Wed, Aug 24, 2022 at 03:45:11PM +0100, Marc Zyngier wrote:
>>> On Wed, 24 Aug 2022 00:19:04 +0100,
>>> Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Tue, Aug 23, 2022 at 11:47:03PM +0100, Marc Zyngier wrote:
>>>>> Atomicity doesn't guarantee ordering, unfortunately.
>>>>
>>>> Right, sorry to be misleading.  The "atomicity" part I was trying to say
>>>> the kernel will always see consistent update on the fields.
>>>>
>>>> The ordering should also be guaranteed, because things must happen with
>>>> below sequence:
>>>>
>>>>    (1) kernel publish dirty GFN data (slot, offset)
>>>>    (2) kernel publish dirty GFN flag (set to DIRTY)
>>>>    (3) user sees DIRTY, collects (slots, offset)
>>>>    (4) user sets it to RESET
>>>>    (5) kernel reads RESET
>>>
>>> Maybe. Maybe not. The reset could well be sitting in the CPU write
>>> buffer for as long as it wants and not be seen by the kernel if the
>>> read occurs on another CPU. And that's the crucial bit: single-CPU is
>>> fine, but cross CPU isn't. Unfortunately, the userspace API is per-CPU
>>> on collection, and global on reset (this seems like a bad decision,
>>> but it is too late to fix this).
>>
>> Regarding the last statement, that's something I had question too and
>> discussed with Paolo, even though at that time it's not a outcome of
>> discussing memory ordering issues.
>>
>> IIUC the initial design was trying to avoid tlb flush flood when vcpu
>> number is large (each RESET per ring even for one page will need all vcpus
>> to flush, so O(N^2) flushing needed). With global RESET it's O(N).  So
>> it's kind of a trade-off, and indeed until now I'm not sure which one is
>> better.  E.g., with per-ring reset, we can have locality too in userspace,
>> e.g. the vcpu thread might be able to recycle without holding global locks.
> 
> I don't get that. On x86, each CPU must perform the TLB invalidation
> (there is an IPI for that). So whether you do a per-CPU scan of the
> ring or a global scan is irrelevant: each entry you find in any of the
> rings must result in a global invalidation, since you've updated the
> PTE to make the page RO.
> 
> The same is true on ARM, except that the broadcast is done in HW
> instead of being tracked in SW.
> 
> Buy anyway, this is all moot. The API is what it is, and it isn't
> going to change any time soon. All we can do is add some
> clarifications to the API for the more relaxed architectures, and make
> sure the kernel behaves accordingly.
> 
> [...]
> 
>>> It may be safe, but it isn't what the userspace API promises.
>>
>> The document says:
>>
>>    After processing one or more entries in the ring buffer, userspace calls
>>    the VM ioctl KVM_RESET_DIRTY_RINGS to notify the kernel about it, so that
>>    the kernel will reprotect those collected GFNs.  Therefore, the ioctl
>>    must be called *before* reading the content of the dirty pages.
>>
>> I'd say it's not an explicit promise, but I think I agree with you that at
>> least it's unclear on the behavior.
> 
> This is the least problematic part of the documentation. The bit I
> literally choke on is this:
> 
> <quote>
> It's not necessary for userspace to harvest the all dirty GFNs at once.
> However it must collect the dirty GFNs in sequence, i.e., the userspace
> program cannot skip one dirty GFN to collect the one next to it.
> </quote>
> 
> This is the core of the issue. Without ordering rules, the consumer on
> the other side cannot observe the updates correctly, even if userspace
> follows the above to the letter. Of course, the kernel itself must do
> the right thing (I guess it amounts to the kernel doing a
> load-acquire, and userspace doing a store-release -- effectively
> emulating x86...).
> 
>> Since we have a global recycle mechanism, most likely the app (e.g. current
>> qemu impl) will use the same thread to collect/reset dirty GFNs, and
>> trigger the RESET ioctl().  In that case it's safe, IIUC, because no
>> cross-core ops.
>>
>> QEMU even guarantees this by checking it (kvm_dirty_ring_reap_locked):
>>
>>      if (total) {
>>          ret = kvm_vm_ioctl(s, KVM_RESET_DIRTY_RINGS);
>>          assert(ret == total);
>>      }
>>
>> I think the assert() should never trigger as mentioned above.  But ideally
>> maybe it should just be a loop until cleared gfns match total.
> 
> Right. If userspace calls the ioctl on every vcpu, then things should
> work correctly. It is only that the overhead is higher than what it
> should be if multiple vcpus perform a reset at the same time.
> 
>>
>>> In other words, without further straightening of the API, this doesn't
>>> work as expected on relaxed memory architectures. So before this gets
>>> enabled on arm64, this whole ordering issue must be addressed.
>>
>> How about adding some more documentation for KVM_RESET_DIRTY_RINGS on the
>> possibility of recycling partial of the pages, especially when collection
>> and the ioctl() aren't done from the same thread?
> 
> I'd rather tell people about the ordering rules. That will come at
> zero cost on x86.
> 
>> Any suggestions will be greatly welcomed.
> 
> I'll write a couple of patch when I get the time, most likely next
> week. Gavin will hopefully be able to take them as part of his series.
> 

Thanks, Marc. Please let me know where I can check out the patches
when they're ready. I can include the patches into this series in
next revision :)

Thanks,
Gavin


