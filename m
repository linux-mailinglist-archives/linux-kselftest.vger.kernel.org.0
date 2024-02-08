Return-Path: <linux-kselftest+bounces-4355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7B84E575
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 17:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEE5B26D6F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21687F481;
	Thu,  8 Feb 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxBJ0I4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07D81ABC;
	Thu,  8 Feb 2024 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411090; cv=none; b=DeDhzhkdbNK24hZmMw651lCwRdZyAcgdc2vFH+13T5vi0Yq8ShF5dE7RJt+fRcfqXBkZ6QH9a9MgCQLX/Jyl6RoWzDr1bhYxY4h0R0yWRdWFRa07XXrfBfqtnr8AO4EW2cuq7KD6jHJR6SuQtI6axlGTNMbo4d+xBoA4Ol7AnEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411090; c=relaxed/simple;
	bh=xzC243P64BD4dxu+mYtwLuALx8x8SKQa6GlBkvYhvAY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UqXeq/Gy3RgrhA+L3yMBL8Wz4UfSPj+SokVYQyMeiiMWLHlz9tLx6DGTc5K/2eJr4Ay+38mmouqnLkehr5qzA4ra/Sn9pVP2GiQyKLoLM7iux1tfDL1p9uBlb3Nxgx7SE8hHvmXCWnwcWea2fJJb2XhaS0bkZe3SsR7Q1Z9YEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxBJ0I4B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41008ab427fso651315e9.0;
        Thu, 08 Feb 2024 08:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707411087; x=1708015887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKmRKXQ4Jb/UJrwbolAziRwHoP1CqWPr7lokSDT3Zv8=;
        b=AxBJ0I4Bnv52AE55DZtgtZxJHwKo/GIRiGc8t1xnQyxVx3S3XQParJyOXx/5/1hv2b
         S/emQJ46s0iAf/KpWVxCmd2mRDOOGv+2KUkH5J7TWU+lY663+oubSjODcxk02sJp2qV0
         BaZMH5L2xG18WW5h9Q7PhtVT7Q9t9s06dY17kwBUQyjRVv1wq5NQmoKrAxgZI7W5tbyN
         B3z0N24lnWtBFl1wTl/YxwM/n2HUZhx6hlrUEJuvelCRbZFDgIbkrHDVL5Y1cOnLYGFm
         FXoCZyAGJ8Gn5TCXvEVd4LUGKI4zjTc4PkXH17ydoqGpaFk4+HQf7IiVwFlOOPeanAFa
         oX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411087; x=1708015887;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKmRKXQ4Jb/UJrwbolAziRwHoP1CqWPr7lokSDT3Zv8=;
        b=S7HPzEcnhNg2A8p0Si+5N0rVoo5HJWuLPQukbeDc3YDUx6mfeGgrB8XJcamDn73cHR
         LhPgOzCbE4YLkGqxFmxptAMOXkLkdsr1pdluudBKzqfIdafD3uSG7mP/S6uIUxdJ45cL
         UmZPrez1gu7dgQdDLUPSSPcL2WT40Ibxr36hAYapPxH7PLDLMz5dUXmkuk0WoNaw/T4J
         sHteQLwjH0oGIdNES5qD9q32U5Vr9A6pjaGXSC8k78p+5Y+x67HIwXlL6v7LgxM4uTRs
         s8QLvOeYmGHRzoYOnwA+VSgWfrFSoDONFdwhj6W+3gF1FLXpfKyRH26AuXrTevXWDrFM
         5bHQ==
X-Gm-Message-State: AOJu0YxiCvj0cENuzlczYdma9ZQn4qat0E0zvoauuVyOVZkF2l48kVXw
	UJmkijSLbxUCZiY8vl9if9gPmm6pBW/S9mUrYinlU/TkpiQKT1cM
X-Google-Smtp-Source: AGHT+IG98zrnkTg7fNviSPhs9dA5QQKDFf0R75aZSaa7TrzSaBD5iM3Z4iLKBGwnVTuNoUDV2ArfTA==
X-Received: by 2002:a05:600c:1390:b0:40e:a569:3555 with SMTP id u16-20020a05600c139000b0040ea5693555mr7176214wmf.35.1707411086636;
        Thu, 08 Feb 2024 08:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJGeVnGM1lvv2MH7XIj5f2p/JxGIGtjAiHNgpy9kBet5NobTXGQKb1AyMzKpLypnfjDu2z/xOytq/bA3PTsVPLibIpy2/fyDpBXD56ZMBYTRhfcA2QFMblj68MYTjaxxPNPPWEXt8Zr8AppKd9iM2RPeCiu5mUh37nMJPRuii360LL3VYh5FmOCgJJIrcVmCNN1Nj7EHkJkUSeUbO+3SSYcCh2/SAO13fZQnQuw0v1wtAGXK79i0kbUBHtgeuaS9xz6FHIzipQI5nVfuNExrF0VQNRFUWK5OfMmW4ukVdepViLHCuha0TEp0AlPm06TmMjGntWiOtEU+xGMg3E4AnMy71lQSqJjgT1ZoqBjNA9hkBxGrGAvOiuN7dcFhvuBoae38d6MS2ds0+OtDbZo/AjpGGz8L7SJJ2ByFzpJSLM++X2vaw=
Received: from [192.168.10.199] (54-240-197-239.amazon.com. [54.240.197.239])
        by smtp.gmail.com with ESMTPSA id m33-20020a05600c3b2100b004100826da82sm2153919wms.21.2024.02.08.08.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:51:26 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <148d903c-fcc5-4a6a-aef1-c1e77e74d0fc@xen.org>
Date: Thu, 8 Feb 2024 16:51:18 +0000
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
 <92918ee8-3cc9-41c3-a284-5cd6648abc05@xen.org> <ZcUF-TNbykWvh3r7@google.com>
Organization: Xen Project
In-Reply-To: <ZcUF-TNbykWvh3r7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/02/2024 16:48, Sean Christopherson wrote:
> On Thu, Feb 08, 2024, Paul Durrant wrote:
>> On 07/02/2024 04:10, Sean Christopherson wrote:
>>> On Mon, Jan 15, 2024, Paul Durrant wrote:
>>>> @@ -638,20 +637,32 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
>>>>    		}
>>>>    		break;
>>>> -	case KVM_XEN_ATTR_TYPE_SHARED_INFO: {
>>>> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO:
>>>> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA: {
>>>>    		int idx;
>>>>    		mutex_lock(&kvm->arch.xen.xen_lock);
>>>>    		idx = srcu_read_lock(&kvm->srcu);
>>>> -		if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
>>>> -			kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
>>>> -			r = 0;
>>>> +		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
>>>> +			if (data->u.shared_info.gfn == KVM_XEN_INVALID_GFN) {
>>>> +				kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
>>>> +				r = 0;
>>>> +			} else {
>>>> +				r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
>>>> +						     gfn_to_gpa(data->u.shared_info.gfn),
>>>> +						     PAGE_SIZE);
>>>> +			}
>>>>    		} else {
>>>> -			r = kvm_gpc_activate(&kvm->arch.xen.shinfo_cache,
>>>> -					     gfn_to_gpa(data->u.shared_info.gfn),
>>>> -					     PAGE_SIZE);
>>>> +			if (data->u.shared_info.hva == 0) {
>>>
>>> I know I said I don't care about the KVM Xen ABI, but I still think using '0' as
>>> "invalid" is ridiculous.
>>>
>>
>> With the benefit of some sleep, I'm wondering why 0 is a 'ridiculous'
>> invalid value for a *virtual* address? Surely it's essentially a numerical
>> cast of the canonically invalid NULL pointer?
> 
> It's legal to mmap() virtual address '0', albeit not by default:
> 
>    config DEFAULT_MMAP_MIN_ADDR
> 	int "Low address space to protect from user allocation"
> 	depends on MMU
> 	default 4096
> 	help
> 	  This is the portion of low virtual memory which should be protected
> 	  from userspace allocation.  Keeping a user from writing to low pages
> 	  can help reduce the impact of kernel NULL pointer bugs.
> 
> 	  For most ppc64 and x86 users with lots of address space
> 	  a value of 65536 is reasonable and should cause no problems.
> 	  On arm and other archs it should not be higher than 32768.
> 	  Programs which use vm86 functionality or have some need to map
> 	  this low address space will need CAP_SYS_RAWIO or disable this
> 	  protection by setting the value to 0.
> 
> 	  This value can be changed after boot using the
> 	  /proc/sys/vm/mmap_min_addr tunable.
> 
> 
> Obviously it's equally ridiculous that userspace would ever mmap() '0' and pass
> that as the shared_info, but given that this is x86-only, there are architecturally
> illegal addresses that can be used, at least until Intel adds LA64 ;-)

Ok. Thanks for the reference.


