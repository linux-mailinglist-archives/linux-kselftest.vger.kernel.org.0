Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC80E3AB2AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhFQLg0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 07:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232361AbhFQLg0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 07:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623929658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eFNQaz+UBr3+VeZ6q7OSgOqHodPl71Dh+9dEuoGcM+Q=;
        b=Mm2jA20VedSXFqP3ceZh04iBDxZPYxRcJEY9WTRUJwV4hrKO6Vmd6vZ7qjZ9g/18drS3mP
        Q9O6nTfvPJDVPYKOk207f5baJIEefT5893/dd+bFmbTevesHmHGKNA+b9SULIXUF0ixY8H
        h7dJvQFhQNmJW7maBE8BEb/ETjqD+VU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-UO_Pf__WMWygOA4pcF3uBA-1; Thu, 17 Jun 2021 07:34:17 -0400
X-MC-Unique: UO_Pf__WMWygOA4pcF3uBA-1
Received: by mail-ed1-f70.google.com with SMTP id f12-20020a056402150cb029038fdcfb6ea2so1310174edw.14
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 04:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFNQaz+UBr3+VeZ6q7OSgOqHodPl71Dh+9dEuoGcM+Q=;
        b=Ys/Az0C1kXdz5cBoXn6JaiStPUyA3FflponIUU2dZ0Wy8hkCKNE+ual9bz0kH6VJTD
         cfQwmd/rCSVFeyz3BComjD0/NTL5+xxMKucaLerP1ryZJcbmiUu+e8kT/1WH/Q0P7YvX
         7F2D5MJuOvW50ZSvOrrvdVW0FA4VT3zT8MvMMZUOo5vgbG1Kefz8PFlYgJcSFmbyKP0U
         3qmCzHYSo/f+fPtwTqZY3PGR67x+DfxpWWO2HF8rOsQAhBxttjvCSvF3ZYfJBDq/bnoH
         1p/zY/884eC7Gc+/pxMxbq0pLfjKyT9CXSmLfoAFG80votlphhiQrHrglaUiVVF1qy0U
         0RrQ==
X-Gm-Message-State: AOAM530O2Sw8o/6RcVf/YDizcTNLJiV/VJvjzOwnz2vsJ/Ly6luoQQVS
        xYpVrMfc9ZFICkUKPVmNwXaNNqDVFXUhkb0cz52K5qpjAe0sB3k7vPv5LkFqT8uE2oFbh2dst4p
        a+AIrbfasuVG79+iU9chrtai7eCgw
X-Received: by 2002:a17:906:ca4a:: with SMTP id jx10mr4731042ejb.200.1623929246049;
        Thu, 17 Jun 2021 04:27:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw32CbI/7oXViDiR3/KwQ1e7FS2cEfJU4e5y3PkNkTiAFxV1nv9UNltBlc/li58ogeNN1nAkA==
X-Received: by 2002:a17:906:ca4a:: with SMTP id jx10mr4730994ejb.200.1623929245836;
        Thu, 17 Jun 2021 04:27:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s5sm4131010edi.93.2021.06.17.04.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 04:27:25 -0700 (PDT)
Subject: Re: [PATCH v10 2/5] KVM: stats: Add fd-based API to read binary stats
 data
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
 <20210617044146.2667540-3-jingzhangos@google.com>
 <YMr4rArKvj3obDEM@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9cc4df4-a502-31ec-0f5d-32a53c372f06@redhat.com>
Date:   Thu, 17 Jun 2021 13:27:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMr4rArKvj3obDEM@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/06/21 09:24, Greg KH wrote:
>> Provides a file descriptor per VM to read VM stats info/data.
>> Provides a file descriptor per vCPU to read vCPU stats info/data.
> Shouldn't this be two separate patches, one for each thing as these are
> two different features being added?

They share a lot of code.  We could have three patches though:

- add common code for binary statistics file descriptor

- add VM ioctl to retrieve a statistics file descriptor [including the 
definition of VM stats descriptors]

- add VCPU ioctl to retrieve a statistics file descriptor [again 
including the definitions of VCPU stats].

Paolo

