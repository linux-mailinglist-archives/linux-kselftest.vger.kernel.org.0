Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDDB3ACF72
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 17:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhFRPxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 11:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFRPxq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 11:53:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF6C061574;
        Fri, 18 Jun 2021 08:51:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m18so11284862wrv.2;
        Fri, 18 Jun 2021 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CD9XnXo3UlaYFvntUj461NFpsSCX2GWDOVULfKVOTy0=;
        b=nDc9H2/XnHo7s1BgDDoRt0U6v8ckmFqgmEWFtyKB3gfuFjOr7AP752I7pJacwMeuSn
         U/N4IaBNR+4GN8t3kdoNdZmWixER4cTnLJyqpxg5JCe/VumjOLB4qSraPZr409ZG3PZR
         0iX0k4yCHpfc85SqA80AbZrqtr9qe+aEXf6xYu+YT3n3aIR7jkhsSJ2AC8Rehe6CNfJO
         4ON9vNCZv3TbETMSsLGAyGhRJaZRjcAMvF6iZSQhEwrh5V/96XvHkN4F7tVugqqjzx4A
         hIB73eHqOfRDSbpcetHtIEFX+ecPZrlzSoUsDELCq6c6U7aMuqxznfJspBB+4rl5Qytn
         Juwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CD9XnXo3UlaYFvntUj461NFpsSCX2GWDOVULfKVOTy0=;
        b=dPLkWJbCB/eMDT6P+nFxGpx6d7jOFE2do36Qki8861TvRwuMJOi2WZba1I1MsucTuN
         SzPZdSdwXCoH2x/FZDeEG2VSASLQvUqltxRjdTFWDBIRWgcmjRvjc05LaVvQI9998M6i
         oc0oGAah1EBHq6yRMZy+yQsyySxtIkWUI0fpNF0gg1mV6OziWas5jQ1lf7tgLMeTkEQv
         xg4jPmVaF4d2Q9nKD2uNnnPLwgyuc0763Q8xiq31BLwskttrLooXsUduQ2/VuKZtebWu
         82bWQVdFb7+kiHSbFxSQcy3LHk0NCBVfQ0WLDCrJUNZcUkcheDQu2pbyxO7/5duQL/Cb
         q02g==
X-Gm-Message-State: AOAM533RKLfPKr9ssR+0RBxwYV5NkRiVoSoE5NPP1E6cysOBGIkgrAFx
        z0aBctoI6BCsXUrY/W4RTq4=
X-Google-Smtp-Source: ABdhPJzkI7Io3g4FbXkpApW8iRbTya+G4og+TF5Olp6jNzTRurHJqUU5y/Ze/8I4kybjCv0/noZ/6A==
X-Received: by 2002:adf:f20c:: with SMTP id p12mr13048124wro.257.1624031495092;
        Fri, 18 Jun 2021 08:51:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id b8sm11568956wmd.35.2021.06.18.08.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 08:51:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jing Zhang <jingzhangos@google.com>, KVM <kvm@vger.kernel.org>,
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
 <YMxEqvKyGnZinMOS@kroah.com> <f2616b8e-0cf8-570f-4bd3-7ef5cbcb37b0@gnu.org>
 <YMxYC8syYRBhbBAq@kroah.com>
From:   Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary stats
 data
Message-ID: <22bb0eb6-1305-4af9-aecc-166d7e62e6c3@gnu.org>
Date:   Fri, 18 Jun 2021 17:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMxYC8syYRBhbBAq@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/06/21 10:23, Greg KH wrote:
> On Fri, Jun 18, 2021 at 10:02:57AM +0200, Paolo Bonzini wrote:
>> On 18/06/21 09:00, Greg KH wrote:
>>>> +struct kvm_stats_header {
>>>> +	__u32 name_size;
>>>> +	__u32 count;
>>>> +	__u32 desc_offset;
>>>> +	__u32 data_offset;
>>>> +	char id[];
>>>> +};
>>>
>>> You mentioned before that the size of this really is the size of the
>>> structure + KVM_STATS_ID_MAXLEN, right?  Or is it - KVM_STATS_ID_MAXLEN?
>>>
>>> If so, why not put that value explicitly in:
>>> 	char id[THE_REST_OF_THE_HEADER_SPACE];
>>>
>>> As this is not a variable header size at all, and you can not change it
>>> going forward, so the variable length array here feels disingenuous.
>>
>> It can change; the header goes up to desc_offset.  Let's rename desc_offset
>> to header_size.
> 
> "Traditionally" the first field of a variable length structure like this
> has the size.  So maybe this needs to be:
> 
> struct kvm_stats_header {
> 	__u32 header_size;

Thinking more about it, I slightly prefer id_offset so that we can later 
give a meaning to any bytes after kvm_stats_header and before id_offset.

Adding four unused bytes (for now always zero) is also useful to future 
proof the struct a bit, thus:

struct kvm_stats_header {
	__u32 flags;
	__u32 name_size;
	__u32 num_desc;
	__u32 id_offset;
	__u32 desc_offset;
	__u32 data_offset;
}

(Indeed num_desc is better than count).

> Wait, what is "name_size" here for?

So that you know the full size of the descriptors is (name_size + 
sizeof(kvm_stats_desc) + name_size) * num_desc.  That's the memory you 
allocate and the size that you can then pass to a single pread system 
call starting from offset desc_offset.

There is certainly room for improvement in that the length of id[] and 
name[] can be unified to name_size.

>>>> +struct kvm_stats_desc {
>>>> +	__u32 flags;
>>>> +	__s16 exponent;
>>>> +	__u16 size;
>>>> +	__u32 offset;
>>>> +	__u32 unused;
>>>> +	char name[];
>>>> +};
>>>
>>> What is the max length of name?
>>
>> It's name_size in the header.
> 
> So it's specified in the _previous_ header?  That feels wrong, shouldn't
> this descriptor define what is in it?

Compared to e.g. PCI where you can do random-access reads from memory or 
configuration space, reading from a file has slightly different 
tradeoffs.  So designing a file format is slightly different compared to 
designing an in-memory format, or a wire protocol.

Paolo
