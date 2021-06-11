Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDD3A4073
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhFKKxc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 06:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhFKKx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 06:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623408690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeF6NSmY+RlePXJwinqUloNFNozec5u88pDu1en91rg=;
        b=MwvFr1lLkN7lB27omfs0zhksr416oh/pLfq53qQHsDaHhZEYkq9sL8KScepZFWBoaq36D4
        /FoCUrVhf76TcvBf67PuHlDAWGKqR5NOAjIiGsd/9fFvq212eMALEl689hveaiubYGcIJO
        j7HznKYln4w2htEKLiU9SNrJ1LP/NFk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-3OLSzSNOPyWW2DiPJWQ6Uw-1; Fri, 11 Jun 2021 06:51:29 -0400
X-MC-Unique: 3OLSzSNOPyWW2DiPJWQ6Uw-1
Received: by mail-wr1-f72.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so2419606wru.13
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jun 2021 03:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GeF6NSmY+RlePXJwinqUloNFNozec5u88pDu1en91rg=;
        b=GfTboC1Tqp9DSpaOfZio6A9tWTr5ijLq//jr7G62SlZvlVq2Z7d4kgyI9YvIVqKMw4
         NrqSzld0yBrIOVKHWtsYF/3xy8QhPfKVe12Qau6nRL0Hef3MOIbO9ISdRNRKNA3UC23d
         4VpcZOTAPsrqAmwWTWEjqx+YtNRs3JevV9oz3QvFyY9ZtBPxUO/fTZv6ZVViVuVSuJAK
         K+L5KgFAPcaKyivORYHDsv761Eci+wHILtXtJOiIW6GZhH+DFKj5isnZVdZqFOwYpbkt
         KcB0oHichgzhttJy9Ft/h/BVxhrYnTSxdO4A1IInFaPXSgJBlTJKk5MbLnaFdbBsYikr
         V6jg==
X-Gm-Message-State: AOAM533M4srgeLoV3quQAj25wTmp1ngQNLrVVrObC+rBWMWa8eu2chJp
        nX4Atvhob9av23pjJYpRYu4O5d12tQCWtr6QXH9eCxeEeVZPuGUVW4g3deYfw4GxP4OHqapS2cA
        KycZPzl/iWOsxo58TKEl+1N41hj1q
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr3313576wrz.350.1623408688073;
        Fri, 11 Jun 2021 03:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkNd9ko6ID8OBZPsEJA+MAlG7UkZ9Guko+3nwZmFCnop+c0VjyxH8jWHme4xipbMFJRZnG/w==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr3313547wrz.350.1623408687852;
        Fri, 11 Jun 2021 03:51:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h9sm12694249wmm.33.2021.06.11.03.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 03:51:27 -0700 (PDT)
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
        KVMARM <kvmarm@lists.cs.columbia.edu>,
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-2-jingzhangos@google.com>
 <03f3fa03-6f61-7864-4867-3dc332a9d6f3@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 1/4] KVM: stats: Separate generic stats from
 architecture specific ones
Message-ID: <bdd315f7-0615-af69-90c3-1e5646f3e259@redhat.com>
Date:   Fri, 11 Jun 2021 12:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <03f3fa03-6f61-7864-4867-3dc332a9d6f3@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/06/21 08:57, Christian Borntraeger wrote:
>> @@ -755,12 +750,12 @@ struct kvm_vcpu_arch {
>>   };
>>   struct kvm_vm_stat {
>> +    struct kvm_vm_stat_generic generic;
> 
> s390 does not have remote_tlb_flush. I guess this does not hurt?

It would have to be accounted in gmap_flush_tlb, but there is no struct 
kvm in there.  A slightly hackish possibility would be to include the 
gmap by value (instead of by pointer) in struct kvm, and then use 
container_of.

This reminds me that I have never asked you why the gmap code is not in 
arch/s390/kvm, and also that there is no code in QEMU that uses 
KVM_VM_S390_UCONTROL or KVM_S390_VCPU_FAULT.  It would be nice to have 
some testcases for that, and also for KVM_S390_VCPU_FAULT with regular 
virtual machines... or to remove the code if it's unused.

Thanks,

Paolo

