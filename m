Return-Path: <linux-kselftest+bounces-21727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF549C2E8D
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516F128224E
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2CD19D89E;
	Sat,  9 Nov 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAvj/3ou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5DA19CD1E
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Nov 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170701; cv=none; b=ERiVC3M4ew2CaI4Ih51SyeCb3HJMHYYfh91lvYG6OW9fvI7K693UYgu30jTO804D9YI88djz3LqBUqFEnjdxO5ORMCJGj73FFWdMxn/nIifOxc7GsReag59S5LZHccDxHgUgflLwpdo0SgGnFCa3cvYbtfMCYWtuxAMB9Pdb5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170701; c=relaxed/simple;
	bh=8s6ddGOZtzDkflWCOawDnuSTfJ92cgecFe+UShoiJOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6meo4AsOF80UaqrIyp9E2nGnCQgwU6LSDRnJyVa2mxDl/6qDinuGJlUwYiVV/TAYAWZTId49j6tABeiVcOfBoQJjib++WEOdC6v0PIrt1SDeLot0NSt+nAZoNRD4yVMAxmiiEwwmFsKHaGxkrpzdLbUULa/Sz66aajPyqifMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAvj/3ou; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731170698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GX4i0/+a7YK4KExTAVwvodadlFDSzCXEktzzKm31mt0=;
	b=jAvj/3ouc8NZfmQyhJMOCazHvFqBYgy9svPaj3WnIfPk3jCth104GCTuvRP0KslRXvs2BE
	KKVBhA30mOvjgCzyH8w5y4cN6clCyeroshFKKWrTI0cP4ScPaKLQKFJUYag2l+nL6XFETr
	SUiVLzz9jfszQYJ/OyoNv80FshZ8m1Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-lovEoVTKNn6exVZe-RN1Vg-1; Sat, 09 Nov 2024 11:44:56 -0500
X-MC-Unique: lovEoVTKNn6exVZe-RN1Vg-1
X-Mimecast-MFC-AGG-ID: lovEoVTKNn6exVZe-RN1Vg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4cf04be1so1724920f8f.2
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2024 08:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731170695; x=1731775495;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX4i0/+a7YK4KExTAVwvodadlFDSzCXEktzzKm31mt0=;
        b=vTa5tjMpm4Bu8uL5oMaLV3WY8YRVFfJ4hDS6j3u9asb1ZpzucFoEqafcsLs1DukAOZ
         ezrVgieROxbVSzPzPZp6MLWUAArovaXJdwzkVLmxaUyvSAqchb1X9DynxeRbUWpcUqRS
         CjFU8p6u92TchXSi0Kk0b9VqkUjzPvNpeTd0HayiZYzMID/RB99DTsJgJZrK0THOpoUc
         Tln91EbV8JbMM1aKuUVUPxxtS9hGvmb/JjrAF3StchPhYLnw8mJs4u8v4yyP/GQbPHUj
         fT0O5/DH9udXGbunfgO9D+d2z9NGBysAqmfSPuBWPZvSmx4Ec+vBt8ZlrEuEDKwjmWFa
         tJzw==
X-Forwarded-Encrypted: i=1; AJvYcCVRBPT4Hi2v1HXXo4fpj07qDtUUepPPj8UpafOxY9/ttCiueJKdDmlRVVt+jvBheHmTmPJUKA/59Cnxox1Zm7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWcR1jBOKbp2J4HxMJQGxfZ7fqKA4fguhedBAxbUDDas4Z4wW
	JGDbgzcqZX3YvgUZPQsnwXAJsHd5Mhx2LHbnasvP96UYD4IVay4U9pvXz555KdPL3VjFEKMcrvV
	58fUTYdGjSU/nXDeLHCusEJwTqQdtjkky3KtulL4l/E60CQt5+vTXS/e51MmpNxlIyw==
X-Received: by 2002:a5d:5f49:0:b0:37d:52db:a0a7 with SMTP id ffacd0b85a97d-381f171cc78mr5932551f8f.2.1731170695426;
        Sat, 09 Nov 2024 08:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9UKJiVuPzSfIJH+7x40sfB4yBkpFpS8Np4UOKjaZ38NZ/KSbPShl7rlPxWCsKBneyDB740A==
X-Received: by 2002:a5d:5f49:0:b0:37d:52db:a0a7 with SMTP id ffacd0b85a97d-381f171cc78mr5932514f8f.2.1731170694974;
        Sat, 09 Nov 2024 08:44:54 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432b053047dsm111054265e9.3.2024.11.09.08.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 08:44:54 -0800 (PST)
Message-ID: <c60b32a3-e699-4a8c-8d52-09b34c4d5269@redhat.com>
Date: Sat, 9 Nov 2024 17:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific
 hypercalls
To: Sean Christopherson <seanjc@google.com>,
 Zack Rusin <zack.rusin@broadcom.com>
Cc: kvm@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Joel Stanley <joel@jms.id.au>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
 <20241030033514.1728937-3-zack.rusin@broadcom.com>
 <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
 <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
 <Zy0__5YB9F5d0eZn@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zy0__5YB9F5d0eZn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/24 23:32, Sean Christopherson wrote:
> On Mon, Nov 04, 2024, Zack Rusin wrote:
>> On Mon, Nov 4, 2024 at 5:13 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> On Wed, Oct 30, 2024 at 4:35 AM Zack Rusin <zack.rusin@broadcom.com> wrote:
>>>>
>>>> VMware products handle hypercalls in userspace. Give KVM the ability
>>>> to run VMware guests unmodified by fowarding all hypercalls to the
>>>> userspace.
>>>>
>>>> Enabling of the KVM_CAP_X86_VMWARE_HYPERCALL_ENABLE capability turns
>>>> the feature on - it's off by default. This allows vmx's built on top
>>>> of KVM to support VMware specific hypercalls.
>>>
>>> Hi Zack,
>>
>> Hi, Paolo.
>>
>> Thank you for looking at this.
>>
>>> is there a spec of the hypercalls that are supported by userspace? I
>>> would like to understand if there's anything that's best handled in
>>> the kernel.
>>
>> There's no spec but we have open headers listing the hypercalls.
>> There's about a 100 of them (a few were deprecated), the full
>> list starts here:
>> https://github.com/vmware/open-vm-tools/blob/739c5a2f4bfd4cdda491e6a6f6869d88c0bd6972/open-vm-tools/lib/include/backdoor_def.h#L97
>> They're not well documented, but the names are pretty self-explenatory.
> 
> At a quick glance, this one needs to be handled in KVM:
> 
>    BDOOR_CMD_VCPU_MMIO_HONORS_PAT
> 
> and these probably should be in KVM:
> 
>    BDOOR_CMD_GETTIME
>    BDOOR_CMD_SIDT
>    BDOOR_CMD_SGDT
>    BDOOR_CMD_SLDT_STR
>    BDOOR_CMD_GETTIMEFULL
>    BDOOR_CMD_VCPU_LEGACY_X2APIC_OK
>    BDOOR_CMD_STEALCLOCK
> 
> and these maybe? (it's not clear what they do, from the name alone)
> 
>    BDOOR_CMD_GET_VCPU_INFO
>    BDOOR_CMD_VCPU_RESERVED
> 
>>> If we allow forwarding _all_ hypercalls to userspace, then people will
>>> use it for things other than VMware and there goes all hope of
>>> accelerating stuff in the kernel in the future.
> 
> To some extent, that ship has sailed, no?  E.g. do KVM_XEN_HVM_CONFIG with
> KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL set, and userspace can intercept pretty much
> all hypercalls with very few side effects.

Yes, but "pretty much all" is different from "this is a blanket 
hypercall vmexit for you to do as you please".

>>> So even having _some_ checks in the kernel before going out to
>>> userspace would keep that door open, or at least try.
>>
>> Doug just looked at this and I think I might have an idea on how to
>> limit the scope at least a bit: if you think it would help we could
>> limit forwarding of hypercalls to userspace only to those that that
>> come with a BDOOR_MAGIC (which is 0x564D5868) in eax. Would that help?
> 
> I don't think it addresses Paolo's concern (if I understood Paolo's concern
> correctly),

It does alleviate it.  Yeah, it would be just a tiny hurdle for 
userspace to set eax to a specific hex value to get them hypercalls. 
But it is _something_ at least.  It's enough to decrease substantially 
my level of sympathy for whoever does it, and as you point out it's also 
justified in terms of interoperability.

> but it would help from the perspective of allowing KVM to support
> VMware hypercalls and Xen/Hyper-V/KVM hypercalls in the same VM.

That too.  VMware in fact might be interested in reusing Hyper-V 
support.  Zack?

> I also think we should add CONFIG_KVM_VMWARE from the get-go, and if we're feeling
> lucky, maybe even retroactively bury KVM_CAP_X86_VMWARE_BACKDOOR behind that
> Kconfig.  That would allow limiting the exposure to VMware specific code, e.g. if
> KVM does end up handling hypercalls in-kernel.  And it might deter abuse to some
> extent.

A bit of wishful thinking on the last sentence but yes, we should do it.

Also we should have a single cap, KVM_CAP_X86_VMWARE, with flags 
KVM_CAP_X86_VMWARE_{BACKDOOR,HYPERCALL}.  Depending on exact details of 
VMware's spec it may even make sense to split further as in 
KVM_CAP_X86_VMWARE_{IOPORT,PMC,HYPERCALL}.  The I/O port is a bit nasty 
with how it bypasses the TSS; if VMware wanted to deprecate it, I would 
not complain at all.

To sum up:

- new Kconfig symbol hiding all existing VMware code

- new cap, KVM_CAP_X86_VMWARE returning the bits that you can set with 
KVM_ENABLE_CAP.  As in your patch, enable_vmware_backdoor provides a 
default for KVM_CAP_X86_VMWARE when the cap is not enabled, but it is 
generally deprecated.

- enable_vmware_backdoor should *not* enable KVM_CAP_X86_VMWARE_HYPERCALL

Paolo


