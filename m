Return-Path: <linux-kselftest+bounces-4642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5E854C8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 16:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2C828DCFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0AB5D47E;
	Wed, 14 Feb 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cedw4qI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE221E862;
	Wed, 14 Feb 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924084; cv=none; b=m6VdrxH37hFSvX1cD+C1zoF9zLF3FdEIUFxB++k3FMMSfFQbgd+ZGeW3gVMeSm3ARYMKTVaeHNexaU3aSgmwMTftDN+GpHywCTq2yDeCArQTI0zq2mkyZkT9TUCQQb960CHgtecY41WRYbKBKYLT8Kr0oaWkdKqhekAYnN+1mhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924084; c=relaxed/simple;
	bh=hoHcVDk16XAJElysZKBwoYlEivbmMy1dE57Ck84C2fY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BFELBUCHcJ/vItHlyt55AedWcAhf/xLkovkDkI13rHV4alXh18srDaU38Yix0cEjQ/fh087KvIapuoXe/9S3yD14gTP06qPVQLkF+NaxQQBHu+m03uZkcNR88ZQm2eSm5uSah2iMkoCoa+Vdv1eG2wN+luJjf5Z2QpmYRwwGWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cedw4qI+; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso66529611fa.3;
        Wed, 14 Feb 2024 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707924080; x=1708528880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Pr15UxaRNNmkvqK+He+wlb2GgZLfbS3fJbzNeeMrFQ=;
        b=cedw4qI+pTV6/2u6nNlddaxvBCwMndE1abicqsDpqwgDkcNJvPMeXckqG6wS2U/Fmb
         QxyAy+tYAfwNq6NqqYWb6j/x1es52tcJ1lknv2RWHF/BdlJ22Y1Y0CNg8BywuKmARtg3
         juVGU/t/bduVg6Ul4vRNwu4PbJnjgyMMsWQtAK8BQm+IQ9xVzUpOvjmy6zeQ31dX2Yl0
         pSonwhSnU4Qmj67oB9oWf57WX85R3KG+zBDm7xXuC3fVkNfSKxHxHgLdH8MXbK0nbVvy
         /FnLIkxjlK947XLfB5NrgOYam1b6tz277yv9NOFi9H0ilPAoNaQnTyNrp255HQ27cKJ0
         alBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924080; x=1708528880;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pr15UxaRNNmkvqK+He+wlb2GgZLfbS3fJbzNeeMrFQ=;
        b=HBImv+qgFty8oRwiy/Myk+HybFl144jejQfaqwrVEST4CUhGmgXquCy+onfZ7sacNu
         KgWyH8bJQtVCS5iK6TSrrDK2PigavI4I7eHQHbZKu87omgrMuz+h+/1T/V6BN9PVjDi5
         Daoc8jWA32PZFqYbQrDD2d2GttIDlua3NIS7kVUBwdSBWH8M0RffSvph0VcosS8/+e5f
         tm674TCHZOPV+SeqE3CAC3brsoRvJSDpjZAkOOFB5I8H5fkaZj6RXxgp4acx4oIolSFp
         A57YZLlOP0LRgfEVnqBCxK9OtaqAWGHGQHJVl/zwmZEHHUog/j+aRtMrAzEQ3lAezwFT
         tm5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW2UyVt2is1EWvPlTbJeU9JTrWWLI14xdCVBLibJG9iC9kusjO2exC0UStPbervngam97zYPSDBSTe2jf/9mVHzvZtDXlcrocDqcWl8WVgzqq/XxJYXPy7nd/izbqGqigdSN1aSvSpLsokhDfhcNKGJrI8dwkjzt/a1xIjXKlajlOKjawY9wejYFsZncBX0rZhyJcVQqpXRQYSvRH0
X-Gm-Message-State: AOJu0YxBhOUOGIX9nDAiAx69/M7m0VIac6fJfCk34DkhAOCeqyJtMl1C
	Ruc1l+akn6kfMCjVYGmsPZj733nsiFnWBNPrn2CQyzdcANBG757W
X-Google-Smtp-Source: AGHT+IGyFvg5S9HPImDh5w5FpK3WH8gvrbyC8vFLmQHTmP4kfMQigz825zz60Doo7wJpkiWUKGEexg==
X-Received: by 2002:a2e:8e2f:0:b0:2d0:de6f:c697 with SMTP id r15-20020a2e8e2f000000b002d0de6fc697mr1935294ljk.13.1707924080107;
        Wed, 14 Feb 2024 07:21:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYkWebjCqp/wgBMia5PRqUrydyGf0lABVvAFxLoYzDh2jHWoGMdGQPUx/hgj5ZoaURRwfe6Bnf2mXKW6VGoxFmwkGX4UyM39Tgiv3q/Rlwt9QyIX/IqJrB5i5hpCPCgnNlnX3Mu76l7E/02LH2Ldiu5lid9/QC019gSdpZ/39RwEWVD4oAZ0rLcuEVpMD/DVAy1LQvB1qfoL0sAPhprVzIxL8ybnPlP2Z7XNxpgz/nbDw387JFIV7tVElLB+BvAZlYPqwRpQcSQ0o9YaybYu1LYiN4wQ4gNFRT8MLPIWkBvx4BIXkzMmPhDUOIwP9QXDXhkiVG2Ct9QCwM6BHjAKx+R2+Wd3nF9GtHHt2ylF0LFDTjOsX+NgD+FbIHFgdrHCfOcU79Rcg9vJJjagYB0P0+X8GHfgwlY68kBAI7NaT7WUQRX23O0izOo/hvZKdreLG6rOyvT2AEij6CM8ahfMbn7MTnnpR0Rzq3YN3N6NCexJ7Ma9DLj5ojuSaWn7mv/x5hRV0hgQamerAsV6XnYYKz0XNlsJadLiIsidYD8VRzsQ==
Received: from [192.168.11.205] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c2d4400b00411d3a414c6sm2165101wmg.47.2024.02.14.07.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:21:19 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <9c542f39-959e-4ab1-94a5-39e049a30743@xen.org>
Date: Wed, 14 Feb 2024 15:21:05 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 08/20] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-9-paul@xen.org> <ZcMBDP6H5PRo5C2d@google.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <ZcMBDP6H5PRo5C2d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 04:03, Sean Christopherson wrote:
> +s390 folks (question on kvm_is_error_gpa() for ya)
> 
> On Mon, Jan 15, 2024, Paul Durrant wrote:
>> @@ -1398,7 +1414,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>>   static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
>>   {
>>   	lockdep_assert_held(&gpc->lock);
>> -	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
>> +
>> +	if (gpc->gpa != KVM_XEN_INVALID_GPA)
> 
> KVM_XEN_INVALID_GPA absolutely doesn't belong in common code.  Not to mention
> that it will break when Paolo (rightly) moves it to an x86 header.
> 
> https://lore.kernel.org/all/20240131233056.10845-3-pbonzini@redhat.com
> 
>> +		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
>>   }
>>   
>>   void kvm_sigset_activate(struct kvm_vcpu *vcpu);
>> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
>> index 97eec8ee3449..ae822bff812f 100644
>> --- a/virt/kvm/pfncache.c
>> +++ b/virt/kvm/pfncache.c
>> @@ -48,7 +48,10 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
>>   	if (!gpc->active)
>>   		return false;
>>   
>> -	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
>> +	if (gpc->gpa != KVM_XEN_INVALID_GPA && gpc->generation != slots->generation)
> 
> This needs a comment.  I know what it's doing, but it wasn't obvious at first
> glance, and it definitely won't be intuitive for readers that aren't intimately
> familiar with memslots.
> 
>> +		return false;
>> +
>> +	if (kvm_is_error_hva(gpc->uhva))
>>   		return false;
>>   
>>   	if (offset_in_page(gpc->uhva) + len > PAGE_SIZE)
>> @@ -209,11 +212,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
>>   	return -EFAULT;
>>   }
>>   
>> -static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
>> +static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
>>   			     unsigned long len)
>>   {
>>   	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
>> -	unsigned long page_offset = offset_in_page(gpa);
>> +	unsigned long page_offset = (gpa != KVM_XEN_INVALID_GPA) ?
>> +		offset_in_page(gpa) :
>> +		offset_in_page(uhva);
> 
> This formatting is funky.  I also think it would be worth adding a helper to pair
> with kvm_is_error_hva().
> 
> But!  kvm_is_error_gpa() already exists, and it very, very sneakily does a memslot
> lookup and checks for a valid HVA.
> 
> s390 people, any objection to renaming kvm_is_error_gpa() to something like
> kvm_gpa_has_memslot() or kvm_gpa_is_in_memslot()?  s390 is the only code that
> uses the existing helper.
> 
> That would both to free up the name to pair with kvm_is_error_hva(), and would
> make it obvious what the helper does; I was quite surprised that "error" means
> "is covered by a valid memslot".
> 

Seemingly no response to this; I'll define a local helper rather than 
re-working the open-coded tests to check against INVALID_GPA. This can 
then be trivially replaced if need be.

> Back to this code, then we can have a slightly cleaner:
> 
> 	unsigned long page_offset = kvm_is_error_gpa(gpa) ? offset_in_page(gpa) :
> 							    offset_in_page(uhva);
> 
> 
> And I think it's worth asserting that exactly _one_ of GPA or HVA is valid, e.g.
> to ensure KVM doesn't end up with botched offsets, and to make it a bit more
> clear what's going on.
> 
> 
> 	if (WARN_ON_ONCE(kvm_is_error_gpa(gpa) == kvm_is_error_hva(uhva))
> 		return -EINVAL;

Sure.


