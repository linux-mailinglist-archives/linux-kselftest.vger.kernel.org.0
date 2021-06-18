Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34C3AC610
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhFRI3R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 04:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233743AbhFRI3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 04:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624004825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cJFa3rkdFzYGb5rzW5d+HyixyhjbZALeUmzplacLDE=;
        b=WDUDMG+yIFy+RLOkgd3s42sCcbDRp33y9//JHRxyT5g8w0zD9A9nGKR6oWRLpUeO70Gc0m
        GqcWr6mpTPPUibiM8YW6nEtkI4qD29pX+AHt8bgKNQcL8v8bEoSbHzdtA8RSUUG4xM/xoD
        9AcB9o7Q1x5fNhHCiW5+NPIBM8YFxWY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-5WANlfqUORiNPMxJVmGwkg-1; Fri, 18 Jun 2021 04:27:03 -0400
X-MC-Unique: 5WANlfqUORiNPMxJVmGwkg-1
Received: by mail-ed1-f69.google.com with SMTP id v8-20020a0564023488b0290393873961f6so3131590edc.17
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 01:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3cJFa3rkdFzYGb5rzW5d+HyixyhjbZALeUmzplacLDE=;
        b=NsdNEZ4Cl2c2umG3UkfUrQVApTV1jYlpXT7B/D7WmH25nkMEE6yg2IgjI9keMbCYtS
         E4NrmWTZIID0gFubDZgSDBd6jNTU6XVmlkUT/s/ED+wUHEMd8I7jSg8NDtiw5E9+9vC6
         fUYa8zsBm4Ym+LjTBaC44hBkCvRpjX3Uf4FG81lOPHf6HI8mSdMLjOZlOzkyDEH/8HJA
         boR6fgAQ1QSfrnYGY9aJRJddy52q3FXLZQvRBbeGVMZvKhL1fmPyqL5wd8xB5YL0yv6S
         JoVOdxSbE6NMYy0qI/7ZG/M1OxtKSLOBZCWonZAB0rW0a3ve7QGRjpvnA8gyRwGFhdLa
         bdtA==
X-Gm-Message-State: AOAM530cE02TqvjGTclLkpnYpSBnueRhcWaO9cCLN04WYKq4mbFG/XUT
        pSeN/DzM4x7p5h4Z3SVa/yxZQfyylGgJ+FDWnKIGC9qcwF4ZGFPRtYyWOO0s/oerKXqTaRk9n1e
        4FdYCJzoX67qYAsUx72rn9PV7xjem
X-Received: by 2002:a05:6402:2710:: with SMTP id y16mr3390947edd.101.1624004822547;
        Fri, 18 Jun 2021 01:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGq2oipoZItfIeXLaX4qbZsbrZASIiqcoDPCV2d+cJqFo6XvKWJmN2hFBt1VaAXBJaJ52UYQ==
X-Received: by 2002:a05:6402:2710:: with SMTP id y16mr3390904edd.101.1624004822357;
        Fri, 18 Jun 2021 01:27:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m7sm709185ejo.95.2021.06.18.01.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:27:01 -0700 (PDT)
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
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-6-jingzhangos@google.com>
 <YMxE8pUrbQkwlpbD@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v11 5/7] KVM: stats: Add documentation for binary
 statistics interface
Message-ID: <0036c55a-72d6-7b5c-a6fd-3a285476e522@redhat.com>
Date:   Fri, 18 Jun 2021 10:26:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMxE8pUrbQkwlpbD@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/06/21 09:02, Greg KH wrote:
>> +	struct kvm_stats_desc {
>> +		__u32 flags;
>> +		__s16 exponent;
>> +		__u16 size;
>> +		__u32 offset;
>> +		__u32 unused;
>> +		char name[];
>> +	};
> As I mention in another patch, this should be sucked in directly from
> the .h file in kerneldoc format, so that everything stays in sync.  I
> bet almost this whole file can be put into the .h file, look at how drm
> and v4l2 does this in a way that you only have to write the above one
> time, not try to keep it in sync in two different places.

V4L's userspace-api/media/v4l is absurdly good and I'd say it's by far 
the best documentation of any Linux subsystem, but it's all handwritten 
just like in KVM.  In fact, grepping for kernel-doc directives in 
Documentation/ gives no hits for the V4L uAPI documentation.

DRM has great kernel documentation, but quality-wise the KVM userland 
documentation is on a completely different level compared to DRM; just 
compare https://www.kernel.org/doc/html/latest/virt/kvm/api.html to 
https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html.  The latter is 
not about how to use the DRM interfaces from userspace, it's about how 
to implement the userspace interfaces.  It is full of kernel struct 
definitions that should have no place in a uAPI manual, and does not 
include documentation for almost anything in include/uapi/drm/drm.h

Paolo

