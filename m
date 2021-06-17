Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E793AB2A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhFQLfC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 07:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231948AbhFQLfC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 07:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623929573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KwQqoYgcuee30cxqMSNTKwW1ocgA4MOYfQQA575EikA=;
        b=QYV9RRZYU9m7sK7aScnuKKBX+9ReOfAx3tgUQSIhRI4SWGHMLRQWjS7HqVsGmdcqDaPnRG
        lDsKKcHOLoJX2Nf7bmvD94SMMyRfxSrYMFFi/T+86c/Z6R4htw/v8Ia7eVC6Bd8X4HookP
        mRs46CgAn6lBVYuFozbyXr8WzlVDuuY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-JUPMei7vP1eIkn2l7GzJ_w-1; Thu, 17 Jun 2021 07:32:52 -0400
X-MC-Unique: JUPMei7vP1eIkn2l7GzJ_w-1
Received: by mail-ej1-f70.google.com with SMTP id gv42-20020a1709072beab02903eab8e33118so2026341ejc.19
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 04:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwQqoYgcuee30cxqMSNTKwW1ocgA4MOYfQQA575EikA=;
        b=E3ARcoZaCn56N9jpED4gpuWcVKLqupwQdYaQgQY2pwuaZjd+j7fJYuTbW1gmYC+Z2a
         B1PF5MVvUC5eeRA6NzA6KWQayxhbxUR0vQ7Sz2pMn/kthALDgBwzy8SXq59uoEqdfBOY
         Oze/8Jq/u2rmBvlogJ1b/0C+Vwj1pm44aKpuGO9OH/TxSb9E+803mpK7nXEr81rPrXhB
         iKI5YAGVJQlL4GTdJ2gCufbRIzSamtaD+HXFv8XevdLD5BH2fYMC3LCCdWPtW2wbDg3q
         RZBdianHzARJUGOiyzY6m86Mr4noXBrIDwBeV9OTgE1cIm1ds3aF+Xd+Su7OgmIqd21b
         XFQQ==
X-Gm-Message-State: AOAM530nHTf7RLPwQg5VJr8cs0kEXTWtZ/GkGk34vQ0X92rgvKRAmQrR
        zAGdj1JciZdPVxOKKjy9sckJtRjMP4VA61pyZl2Oi9PSNQWLbGpviKpjkrReUetLtD/OFjbTeH1
        31yKSabvGPX0JphsvCZ3wjK1T2N0p
X-Received: by 2002:a17:906:b24a:: with SMTP id ce10mr4692504ejb.83.1623929364978;
        Thu, 17 Jun 2021 04:29:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQxoLzPkjG7qTF6pnm47FJcTyBPVefQu9Gb2o8Ewl83hG/K5uvahTR/5zWHNZRrxu3APLVbA==
X-Received: by 2002:a17:906:b24a:: with SMTP id ce10mr4692477ejb.83.1623929364822;
        Thu, 17 Jun 2021 04:29:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id du16sm3512028ejc.42.2021.06.17.04.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 04:29:24 -0700 (PDT)
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com>
 <YMrkGZzPrt0jA1iP@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d959828-da89-bceb-f7cc-35622a60c431@redhat.com>
Date:   Thu, 17 Jun 2021 13:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMrkGZzPrt0jA1iP@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/06/21 07:56, Greg KH wrote:
> On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
>> +	struct kvm_stats_desc {
>> +		__u32 flags;
>> +		__s16 exponent;
>> +		__u16 size;
>> +		__u32 offset;
>> +		__u32 unused;
>> +		char name[0];
>> +	};
> 
> <snip>
> 
>> +The ``unused`` fields are reserved for future support for other types of
>> +statistics data, like log/linear histogram.
> 
> you HAVE to set unused to 0 for now, otherwise userspace does not know
> it is unused, right?

Jing, I think you planned to use it with other flags that are unused for 
now?  But please do check that it's zero in the testcase.

> It is not a pointer, it is the data itself.
> 
>> +string starts at the end of ``struct kvm_stats_desc``.
>> +The maximum length (including trailing '\0') is indicated by ``name_size``
>> +in ``struct kvm_stats_header``.
> 
> I thought we were replacing [0] arrays with [], are you sure you should
> be declaring this as [0]?  Same for all structures in this document (and
> code).

In C code [0] is a bit more flexible than [].  I think in this 
particular case [] won't work due to how the structures are declared. 
In the documentation [] is certainly clearer.

Paolo

