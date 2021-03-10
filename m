Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405403344DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 18:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhCJRL6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 12:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231776AbhCJRLx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 12:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615396313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npEmB1G2ved3m8cb8eHAFpucuy0wI7cKFS8zXAK0eEM=;
        b=i2Ua58fEpNqkeaBeKgWXZHpT4bcNni9IbWzlb35CdxxUmLs5Idp3+gvCoPXNDBVReKbdeS
        Z6gD3uoYpa1QGTXdby6PtwrNnRv8kcSDXPsX3Y86BBdrVyiOZLrqENg4DnUOFZ5R629cX+
        2uUJIBMZqQfTTG6BPTxTfUtiok2WOD0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-01qXISFpMtqdD4DCXMGEHQ-1; Wed, 10 Mar 2021 12:11:51 -0500
X-MC-Unique: 01qXISFpMtqdD4DCXMGEHQ-1
Received: by mail-ej1-f72.google.com with SMTP id fy8so7506689ejb.19
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 09:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=npEmB1G2ved3m8cb8eHAFpucuy0wI7cKFS8zXAK0eEM=;
        b=crGoJmNpx5ipjibo/eBlWsK0Ysv/4YeVsDqALbZCWio256bZGZ2WUIMaeWJIbk/msJ
         nuIGB5JlO/9ztOrCUm8g/c6hT4S4KmfzJiWs+KzvdjtB6l8VUuWCKySXms0ECoUQx8/U
         qDxq5uq+xsAaN3dj2fmjMNHrj2KzcHprfPMjSnoJKDyInnzZoqiUP43aQN35yUdklX6H
         F2HBMJ3MENb/q0blA8DJf4QQq8mhvDCwGCKZGa3e0LVDwkK6jc4/i2B4nb0rAnr5gKvi
         3ZpbTS8GOpegyFCwsKq1BB9u33wp3iuQMVGBEQ6NXbFGixCqWMlTE5OdH8O81lIvhQ9F
         szZg==
X-Gm-Message-State: AOAM532ItFXNE08WXM2Kz/+wgZAAC0fqEI/cRdxiBrxN3Pcq8PJyvLrg
        pcqx6KvpidQXhTZmMHBL/FPURZa5XuWmyCe3f/pCoI1rplepLH58xrTmWs/u0w2N6+AtdmhxBgt
        fHvz2710RIo+gE8DCGKgQUZcOXfLx
X-Received: by 2002:a17:906:29c3:: with SMTP id y3mr4574775eje.430.1615396310182;
        Wed, 10 Mar 2021 09:11:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPss/0WtwYTPFF2AWpi4QdCF2rQJI8+OlQAs4Ax1N/oVR6iCHbCOYshTcU9dU+pTRgby2Rsw==
X-Received: by 2002:a17:906:29c3:: with SMTP id y3mr4574734eje.430.1615396309942;
        Wed, 10 Mar 2021 09:11:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n25sm11384840edq.55.2021.03.10.09.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 09:11:49 -0800 (PST)
Subject: Re: [RFC PATCH 3/4] KVM: stats: Add ioctl commands to pull statistics
 in binary format
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVM ARM <kvmarm@lists.cs.columbia.edu>,
        Linux MIPS <linux-mips@vger.kernel.org>,
        KVM PPC <kvm-ppc@vger.kernel.org>,
        Linux S390 <linux-s390@vger.kernel.org>,
        Linux kselftest <linux-kselftest@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
References: <20210310003024.2026253-1-jingzhangos@google.com>
 <20210310003024.2026253-4-jingzhangos@google.com>
 <875z1zxb11.wl-maz@kernel.org>
 <a475d935-e404-93dd-4c6d-a5f8038d8f4d@redhat.com>
 <8735x3x7lu.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2749fe68-acbb-8f4d-dc76-4cb23edb9b35@redhat.com>
Date:   Wed, 10 Mar 2021 18:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8735x3x7lu.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/03/21 18:05, Marc Zyngier wrote:
> On Wed, 10 Mar 2021 16:03:42 +0000,
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 10/03/21 16:51, Marc Zyngier wrote:
>>>> +	kvm_for_each_vcpu(j, vcpu, kvm) {
>>>> +		pdata = data + VM_STAT_COUNT;
>>>> +		for (i = 0; i < VCPU_STAT_COUNT; i++, pdata++)
>>>> +			*pdata += *((u64 *)&vcpu->stat + i);
>>> Do you really need the in-kernel copy? Why not directly organise the
>>> data structures in a way that would allow a bulk copy using
>>> copy_to_user()?
>>
>> The result is built by summing per-vCPU counters, so that the counter
>> updates are fast and do not require a lock.  So consistency basically
>> cannot be guaranteed.
> 
> Sure, but I wonder whether there is scope for VM-global counters to be
> maintained in parallel with per-vCPU counters if speed/efficiency is
> of the essence (and this seems to be how it is sold in the cover
> letter).

Maintaining VM-global counters would require an atomic instruction and 
would suffer lots of cacheline bouncing even on architectures that have 
relaxed atomic memory operations.

Speed/efficiency of retrieving statistics is important, but let's keep 
in mind that the baseline for comparison is hundreds of syscalls and 
filesystem lookups.

Paolo

