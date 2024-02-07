Return-Path: <linux-kselftest+bounces-4226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79584C6AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 09:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BE51F27105
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8239208BC;
	Wed,  7 Feb 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LY6jY6ow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41A208A5;
	Wed,  7 Feb 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296028; cv=none; b=o6dk6/dHK6T+yHQBcgQqSirmbHwMnqujcpBdg7Dzy03vuv/hB8d8hpWTNTkRlpprzYeyRvluEGODYkqOJkrPTDAxhwchhNRkXRe1SmpKQ4VVNXMBzqYlVdCYaiDOVbD8NCxoXwaWhgx+mnp7EAvuKXH16V6jmEjWDJS+avSSofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296028; c=relaxed/simple;
	bh=Ze9TjTNsusybIu4R+Q5RAlJ+7TR712PHZd4Dq2Qt1E0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nN2Y7ps5HNz/fMcWXZ3hck4j6gL2ijfv4DSxKXYQMzZzxaouNiMSnBuY8xO9Dl9152Qkkah4YGivq8pmpwQz1y7INlbm2vGK7iraemsUA0dRYAyyfBfUyPt00PhtnB6Tem8HLzCWDO7THPiVYhWwSRDRfKBODCCKTZlkII0k5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LY6jY6ow; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d073b54359so4871921fa.0;
        Wed, 07 Feb 2024 00:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707296025; x=1707900825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z5MHCMJOK96pZVawvfvH8EAWfIhq8izplmFA7WigwY=;
        b=LY6jY6owPFGJcstqVSp0BuxGOqdQir8Sg7W2Ehttsp3PKj7H/FdrnAfdSkDlCoCH+o
         pR1JgNzsADXMYh45dii1jZW+xzhakcsz+UK2dy/7n7BM4YslU7Z9dh98NgUuGG45XFku
         ZUCvL/Sd9VO9sdO8s5sdOXxfOUKdwHR/rlRTmvxb7eMlX5RkAkw7beRil3P+zIR/N3MM
         MtS/3IjfDwFev4lWz3xLV8qymxAcEXpxpv1/XJLCIKpC7Czfq+GeB44nWsQYR169OHiR
         cF5+xFCTawYE6g659WO++1eNpgQz53pOSY6UeXTaVqtJpGbFAJwKCQ2HNQau/+v+xllY
         keGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296025; x=1707900825;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z5MHCMJOK96pZVawvfvH8EAWfIhq8izplmFA7WigwY=;
        b=rimMpEmFv+C9qC36rbohF3wtXbr6GyKMaOhYGlDvCxy08sh6PbFKy/RLVIIvsSE3o/
         7vVJX/ylZJzEhQEzpjoEPJqqoqansQySFvT6zzP1K2Ptun0lsIthToeCcbQ6QvKxnvK7
         7vmA/Acm4uCXI50WObhkeKy+Er2ZeK9Qq7zGsnFZASokGgcEOACYV5A6wpXwhutFna2A
         sXEVqYvstwYUGZqfqwSPBkhBfRNRZbjsuzsNPc/+7mOMWGtwnoWmWAV81/5iMr8H7rVY
         ZFjthlo80ChLa5usg4DTAOan/CNxbbayuODQwmiGzvycsGPBi1ZmYpPJXItvTj3H3qZv
         yWPg==
X-Gm-Message-State: AOJu0YyGtm9q/vYEXXBbPOwWlHuxDUvBZZuw8pjdmGmQPETmhuq3d6Av
	yyWLib5RTfXIISnPmd36dm8W/FKuYvQ4AAX2bxK1EB3Mdpqn70nmssMjNKsCv1k=
X-Google-Smtp-Source: AGHT+IE3wHEuStBaDo7m2Yv58tZR8xHGAvRzh1++i5FDA8todSbtUIg29W4GZ+IiZgyFM72RbrbQTA==
X-Received: by 2002:ac2:4c45:0:b0:511:2dfc:9ffc with SMTP id o5-20020ac24c45000000b005112dfc9ffcmr3989109lfk.60.1707296024517;
        Wed, 07 Feb 2024 00:53:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuTUbJj4IMVhu38Cr/KsWdubMiAInf3zVws9WDhUkzruIBhaRK8IG81Nl1oSYP9ojkMRYm7SWTiHO7+BwCM/m7y9JT33ESAQjW2SDClU5vPV4YAw9xVkEw4SMeFGCgvO028iEdNhwbce8dd3nsNiGG584kbiwKq8uqeD//pxqbVBZL8M/KWa9VAndlKbF2wVjnbaX5EYB0J5lxS1K0pfCQaG434OP762fCyTc78Anh1gj79ShI22iUu2waZwryDsuhf8ZyqFDXImr5JWcSmPCL0m59UMTARcv1u+jvHk6rPHsMqDjfZFILcGYl73Wd1ZMdUkx2GdtagXm2YvzxVomVCg7bm1u3efwo/nkxeBkT1I6jxfd3WJ/Et7N5+Bzj93yUZQEclhlW3vRopvGATZoVBSEttq/3w3tKa3Y3I8q0Vrw6cS8=
Received: from [192.168.11.39] (54-240-197-227.amazon.com. [54.240.197.227])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b00a38620c3b3dsm503254ejb.198.2024.02.07.00.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 00:53:44 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <96e25eed-8487-40a4-b56c-b5ca42667645@xen.org>
Date: Wed, 7 Feb 2024 08:53:37 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 11/20] KVM: xen: allow shared_info to be mapped by
 fixed HVA
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-12-paul@xen.org> <ZcMCogbbVKuTIXWJ@google.com>
Organization: Xen Project
In-Reply-To: <ZcMCogbbVKuTIXWJ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 04:10, Sean Christopherson wrote:
> On Mon, Jan 15, 2024, Paul Durrant wrote:
>> @@ -638,20 +637,32 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
>>   		}
>>   		break;
>>   
>> -	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
>> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
>> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
>>   		int idx;
>>   
>>   		mutex_lock(&kvm->arch.xen.xen_lock);
>>   
>>   		idx = srcu_read_lock(&kvm->srcu);
>>   
>> -		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
>> -			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
>> -			r = 0;
>> +		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
>> +			if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
>> +				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
>> +				r = 0;
>> +			} else {
>> +				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
>> +						     gfn_to_gpa(data->u.shared_info.gfn),
>> +						     PAGE_SIZE);
>> +			}
>>   		} else {
>> -			r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
>> -					     gfn_to_gpa(data->u.shared_info.gfn),
>> -					     PAGE_SIZE);
>> +			if (data->u.shared_info.hva == 0) {
> 
> I know I said I don't care about the KVM Xen ABI, but I still think using '0' as
> "invalid" is ridiculous.
> 

I don't have any massive preference; we could define a 
KVM_XEN_INVALID_HVA too.

> More importantly, this code needs to check that HVA is a userspace pointer.
> Because __kvm_set_memory_region() performs the address checks, KVM assumes any
> hva that it gets out of a memslot, i.e. from a gfn, is a safe userspace address.
> 
> kvm_is_error_hva() will catch most addresses, but I'm pretty sure there's still
> a small window where userspace could use this to write kernel memory.

Ok. Good point. I'll add some appropriate checks.

   Paul

> 
>> +				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
>> +				r = 0;
>> +			} else {
>> +				r = kvm_gpc_activate_hva(&kvm->arch.xen.shinfo_cache,
>> +							 data->u.shared_info.hva,
>> +							 PAGE_SIZE);
>> +			}


