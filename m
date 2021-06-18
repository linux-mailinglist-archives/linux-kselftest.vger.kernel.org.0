Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B900D3AC5B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 10:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhFRIF7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 04:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhFRIF3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 04:05:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C72C06175F;
        Fri, 18 Jun 2021 01:03:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g8so14538797ejx.1;
        Fri, 18 Jun 2021 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3xbPqY0irxJhl12JwAlZ97VPkIKSYJSliaTHl1kU42s=;
        b=X6Ghoa6vhet8MEaZEltddHovRPROJW0xifz5IyKxQPy9ewQVLhAot7OqQfkwAC0G6J
         0ZqFW6LEPTg+F9ps12wbJJrHIBFV2uQHAhJTVID9EgmaG0Z0/XdPcnvw3//o4AYNnk+y
         8rl39MwfIx/1WZGzS0j8F/68Y+nSBbJgAManVOMUWzv2+ODm2nh8KUxWAvw77rSOh+6I
         3ZZzdX7f/ZCkiM4ar/16oLAN3sYAY8jOpZqqU9XtNhAuAsIt9L7OqYgwVfOnXg7DBr0r
         tt/YK/AcxAj4stDfnsDqIVFL/W8uJ8FwYPxXkJOQ1QOdq9h/FnEmSkTqABoVw3LesFsk
         7GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3xbPqY0irxJhl12JwAlZ97VPkIKSYJSliaTHl1kU42s=;
        b=ODfOuZeaDuSUmr6I8K6WF8apd+ObP1iFYZ72/tG1aIlkvRfK5q4eAZTsv2DT8DFCMN
         YnrOj2BwvnWjxHriNyYLgIVCa0EypxtB2gQnW6/BoFvdYm/iPtZw7iXOoTwT3JT32dlV
         buNfTCLggXncdObW7Mix1zHbuuC3vtivAaPBvZn41r7KAZHLUrrBfCQils1CIyBenwUa
         7zPTcXfHp62xCgKTNaplmI4efcbzEIkBTc3D52wOfsTjiO69PBk9lmwBxW7AcH6ufqqY
         H3/JtwnbSGpXdIq99LabcBzhmxJYDYW6HVSPL0gijfLewtFVa27O/aD67DM1ukgAIyv0
         PyWw==
X-Gm-Message-State: AOAM531vQJyPlMWeUm1EoFI6qXRI9OrmsRxuRB9lEmnpt110LW/C0Esr
        RjksBOLgBdFS7B48hU+Zwus=
X-Google-Smtp-Source: ABdhPJxEFgsEbgHJkMRzhhTkPUPj8+EQf+r+/JMQ0JQA3N6KTgyL2iffbuEMHZFd87UEgYmHVCAo+Q==
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr9792782ejf.539.1624003380108;
        Fri, 18 Jun 2021 01:03:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id l22sm13925edr.15.2021.06.18.01.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:02:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
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
 <20210618044819.3690166-3-jingzhangos@google.com>
 <YMxEqvKyGnZinMOS@kroah.com>
From:   Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary stats
 data
Message-ID: <f2616b8e-0cf8-570f-4bd3-7ef5cbcb37b0@gnu.org>
Date:   Fri, 18 Jun 2021 10:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMxEqvKyGnZinMOS@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/06/21 09:00, Greg KH wrote:
>> +struct kvm_stats_header {
>> +	__u32 name_size;
>> +	__u32 count;
>> +	__u32 desc_offset;
>> +	__u32 data_offset;
>> +	char id[];
>> +};
> 
> You mentioned before that the size of this really is the size of the
> structure + KVM_STATS_ID_MAXLEN, right?  Or is it - KVM_STATS_ID_MAXLEN?
> 
> If so, why not put that value explicitly in:
> 	char id[THE_REST_OF_THE_HEADER_SPACE];
> 
> As this is not a variable header size at all, and you can not change it
> going forward, so the variable length array here feels disingenuous.

It can change; the header goes up to desc_offset.  Let's rename 
desc_offset to header_size.

>> +struct kvm_stats_desc {
>> +	__u32 flags;
>> +	__s16 exponent;
>> +	__u16 size;
>> +	__u32 offset;
>> +	__u32 unused;
>> +	char name[];
>> +};
> 
> What is the max length of name?

It's name_size in the header.

> Why aren't these structures defined here in kerneldoc so that we can
> understand them better?  Putting them in a .rst file guarantees they
> will get out of sync, and you can always directly import the kerneldoc
> into the .rst file.

This is a problem in general with Documentation/virt/kvm/api.rst.  The 
file is organized to match the kerneldoc structs to the ioctl that they 
are used for, and sometimes a ioctl includes different structs for each 
architecture.

It is probably possible to do it using :identifiers: and/or :doc:, but 
it would require running scripts/kernel-doc on the uAPI headers dozens 
of times.  That is quite expensive at 0.3s each run, but that's what you 
get with Perl (gcc -fsyntax-only is 20 times faster).

Paolo
