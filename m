Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60F259CF69
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 05:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiHWDTj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 23:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiHWDTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 23:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD5442AD1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 20:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661224772;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ANTOwf8ibiQnhay23Kr+MLhE1efu6Ju+xkjCoFvJ1Q=;
        b=ech+sSyE3/nKkvhVjBPgTs5Ct5aQu9bcqnIXgSSXIy0SnvAUlIuP/8C8rYqB0mw0KyYA9Z
        SNh0+bEBcWDzlTBJhpfqwOeH0x0VTMaHLOFmpNroMHFvMr3+iZWBSuDu4qAoSkABbzb79I
        r/uPudhWiexXtmr0aDasmvvHBf76J18=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-g4xrL82LMhKJQVBZhkz-yQ-1; Mon, 22 Aug 2022 23:19:27 -0400
X-MC-Unique: g4xrL82LMhKJQVBZhkz-yQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48A7E2999B31;
        Tue, 23 Aug 2022 03:19:26 +0000 (UTC)
Received: from [10.64.54.16] (vpn2-54-16.bne.redhat.com [10.64.54.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 555641121315;
        Tue, 23 Aug 2022 03:19:18 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        seanjc@google.com, drjones@redhat.com, dmatlack@google.com,
        bgardon@google.com, ricarkol@google.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-2-gshan@redhat.com> <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <YwPRO0r2sfzcbgyz@xz-m1.local>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <cc062eeb-0a13-3cf4-7ce7-f4f0b1caaf97@redhat.com>
Date:   Tue, 23 Aug 2022 13:19:15 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YwPRO0r2sfzcbgyz@xz-m1.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 8/23/22 4:55 AM, Peter Xu wrote:
> On Mon, Aug 22, 2022 at 11:58:20AM +1000, Gavin Shan wrote:
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
>> It's inherited from x86. I don't think it has to be this particular value.
>> The value is used to distinguish the region's owners like kvm_run, KVM_PIO_PAGE_OFFSET,
>> KVM_COALESCED_MMIO_PAGE_OFFSET, and KVM_DIRTY_LOG_PAGE_OFFSET.
>>
>> How about to have 2 for KVM_DIRTY_LOG_PAGE_OFFSET in next revision?
>> The virtual area is cheap, I guess it's also nice to use x86's
>> pattern to have 64 for KVM_DIRTY_LOG_PAGE_OFFSET.
>>
>>      #define KVM_COALESCED_MMIO_PAGE_OFFSET   1
>>      #define KVM_DIRTY_LOG_PAGE_OFFSET        2
> 
> It was chosen not to be continuous of previous used offset because it'll be
> the 1st vcpu region that can cover multiple & dynamic number of pages.  I
> wanted to leave the 3-63 (x86 used offset 2 already) for small fields so
> they can be continuous, which looks a little bit cleaner.
> 
> Currently how many pages it'll use depends on the size set by the user,
> though there's a max size limited by KVM_DIRTY_RING_MAX_ENTRIES, which is a
> maximum of 1MB memory.
> 
> So I think setting it to 2 is okay, as long as we keep the rest 1MB address
> space for the per-vcpu ring structure, so any new vcpu fields (even if only
> 1 page will be needed) need to be after that maximum size of the ring.
> 

Thanks for the details. I think it'd keep the layout since virtual area
is really cheap. So lets keep it as of being if Marc doesn't object. In
this way, the new area, which is usually one page size can go after
KVM_COALESCED_MMIO_PAGE_OFFSET.

#define KVM_DIRTY_LOG_PAGE_OFFSET 64

Thanks,
Gavin



