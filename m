Return-Path: <linux-kselftest+bounces-4646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AEE854DB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF072815F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC605F875;
	Wed, 14 Feb 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AngGxXPN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE45D732;
	Wed, 14 Feb 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926959; cv=none; b=vFBth7aZfnkqPh3RAinuebY0NVhujsDWnKJZaHGBzhKuc0YXHUOWvWn4dG2GMsPp4Z0G8rL5uT3KjjAXRX9SXBp5F5XagV1vwdlWqA7c7MEKMh4YtA7380GgegOf9Q1zgkCQjwZHoORdcAQDVDlJfSxqiVUWXNHJCkhdc2m8PTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926959; c=relaxed/simple;
	bh=dQoeYKZoENFVQvLsGVJmPnsaFxLZEW+StaKHuAoCXJ0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ituthCBce9PrtJYyoDlrvzEWcjUZ0zB+K4Sfm9ogNWX7ZCqhcA0iGfB2BQh19BXtpdzPIk21iROGVh/oveymrKQslwf4IQV2o/fKtplILTc/B+ufIMaaNj3Zdawj/P2oG6Q3eqE8CTwAqcJEDOMAeTxzbnI3wABXBi31k5yPW4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AngGxXPN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41166710058so22628365e9.3;
        Wed, 14 Feb 2024 08:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707926956; x=1708531756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qYfvmPaesO8YWN53cqmm2yO+rqp53z4kUnNbercSOGU=;
        b=AngGxXPNv8C6+Fe1p8UeCbBRBuleUlbMZd3oKmV/fO8jkmptiBRvLgbOhg5u+2BTeB
         3QEWweK2jgiRLUl+5GHjYPkuv/DjxOErqeNXNR0jDDvtqS5dAMqElaG5yIS5IB5P+CnV
         VE+qw+Jx/iTNk1c+X30VgtMOtkicUwqGo7VirEzfcFuwGELiMqbaa/Z5Mj3ki3JjqA7J
         Wwpq9xrxxex0Y8B1SSEhSDBL4ozNfoDe/gRTZ9K3qIv8cwmUjPw626hC05mGAxfBH0Ye
         p2RuneBHysNMXoeez6YxReNMDAdDV2706z2osT+P6C2sXQirv4ePQSIuFI21K1g90E1V
         tpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707926956; x=1708531756;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYfvmPaesO8YWN53cqmm2yO+rqp53z4kUnNbercSOGU=;
        b=CXUvXAHZwqWiLLi9LuQfhphu0Q2tHSMs0CCax+PWksKrmwhfIy385kQKYBffHMKrfe
         2J0IufEhE+mfubcWui2lwRKLQRjTBIqZYFESP131AaF4Hv8TFpnxCUlMiipRdT9wTC8Z
         WAokz0pup57tygNs2Q6DNW6GDyXpl5zK57WE5A8IRXvmyYmS0hO75ffBjuRnhWVVzlmo
         zpqsjPLLV42PbZNiLZ0lZM0GtMvdN7JmO2yjLztdo6NUfzdX9CAqJPGljwClVKu7Rz+C
         c8juv15MK7lY+PSufCpLfV66sQ43nimXjGI+YZuWANC1jYkAdt1318V3bXoubb7RoElG
         q9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr7Qk+wX3gPd+y/U2fietKeCKTNzciSTTOzRHiVUd5h67JLBYKnezIREWqk8M0HRQ/RlJdW40fEIPm5C9KjG+1HoByJqvBg3f26zw3xaHu1nw2pnlvmKGqhVJ3hfOqqLqpLIeYWUwxYRG0K7g9NcWG34PmQhVFERWgMqvQwLucX5FYdwbdnaYQ2sdHOZPSPhHdIqdG0gz7j96MmaJz
X-Gm-Message-State: AOJu0YywcRQhW4DShVLtw0FE4iZYzQS/nSXCrQPRXH3TTCbWtKjrP2VB
	BwjhNxrMYvyZWXT4kZ+9fN8GWIZH8iWUQ7+BZ+iCds0OTGVtyfwA
X-Google-Smtp-Source: AGHT+IHbwEiqjQv9iLuTObvOUfd63cZXOTmHaFzCbjCfhIWuPnvc95/UXs9KA9We+Pi+LWXj6QxSeQ==
X-Received: by 2002:a05:600c:35d6:b0:410:d8fa:fa5f with SMTP id r22-20020a05600c35d600b00410d8fafa5fmr2698181wmq.11.1707926956005;
        Wed, 14 Feb 2024 08:09:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJhlD+mcvhAaSJKZYf9+Nf0YrHsZXIbSGJYOxZwxaLmrbYRTabfVe63syiSYHd3UlFKRm2UBHVx1o40zkVnNmf+2ryPyDd/nh+S3kQk05loZsE1TOEfRpTjuz6xlDl/uXAqSfGiOtxUUABpqqQlyL979sOHEijeSvIDucbdnwdWGLjPjpRBGBmBoY5sgOhWI2hEkmF8YA/3SD5hOGyPnMM+aPjPya8j0GFpXmScMFxW5DgVOmVtb7Q08MZ75KqmVdEvC+jmQJR1k2G6fgIX8neByJn8uxEjB5HHhm1QiDJYxFCUvueO4joZfM3q1Mod5fNzHYS+lTG9gAiJiGvDnBY640d135etRuTY6hIqaMG7amUQtouqVs3YMos/9XXyeo2vkuyfTfbmrOBBqfXU9TRE+stjRacbwkssitqqBAguPVGrUP6Q0h5Q8R9L/zXYux4a740zZMgZEm7GT4P7yFz9mc0nGZ1u1bsyX2Iwm6ydxN3L7UQlT7JuIwXs3SjWtmyB61Xzh8V6dm7xYA9jIU0/RRsBCrCrCLl8iWdgKVVjQ==
Received: from [192.168.11.205] (54-240-197-228.amazon.com. [54.240.197.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b00411d640085csm2315458wmf.43.2024.02.14.08.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:09:15 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <02385b22-1a59-4bf0-ba08-0da18ca75f74@xen.org>
Date: Wed, 14 Feb 2024 16:09:01 +0000
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
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-9-paul@xen.org> <ZcMBDP6H5PRo5C2d@google.com>
 <7c31e31d0f0ad3f40619f8e0ecf67f1e3d3eef5f.camel@infradead.org>
 <Zczj2vDCasKcBcjn@google.com>
Organization: Xen Project
In-Reply-To: <Zczj2vDCasKcBcjn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 16:01, Sean Christopherson wrote:
> On Tue, Feb 06, 2024, David Woodhouse wrote:
>> On Tue, 2024-02-06 at 20:03 -0800, Sean Christopherson wrote:
>>> +s390 folks (question on kvm_is_error_gpa() for ya)
>>>
>>> On Mon, Jan 15, 2024, Paul Durrant wrote:
>>>> @@ -1398,7 +1414,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>>>>    static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
>>>>    {
>>>>          lockdep_assert_held(&gpc->lock);
>>>> -       mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
>>>> +
>>>> +       if (gpc->gpa != KVM_XEN_INVALID_GPA)
>>>
>>> KVM_XEN_INVALID_GPA absolutely doesn't belong in common code.  Not to mention
>>> that it will break when Paolo (rightly) moves it to an x86 header.
>>>
>>> https://lore.kernel.org/all/20240131233056.10845-3-pbonzini@redhat.com
>>
>> We can use plain INVALID_GPA for that, I think. ISTR the reason we have
>> a separate KVM_XEN_INVALID_GPA is because that's a userspace API.
>>
>> ...
>>
>>> But!  kvm_is_error_gpa() already exists, and it very, very sneakily
>>> does a memslot lookup and checks for a valid HVA.
>>
>> Hm, that doesn't sound as fast as simple comparison. We also can't do
>> it from kvm_gpc_check(), can we?
> 
> You snipped the part where I suggested renaming the existing kvm_is_error_gpa().
> 
> I am suggesting we do the below (and obviously rename the s390 usage, too), and
> then the gpc code can use use kvm_is_error_gpa().
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index bbfefd7e612f..e1df988e4d57 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -148,6 +148,11 @@ static inline bool kvm_is_error_hva(unsigned long addr)
>   
>   #endif
>   
> +static inline bool kvm_is_error_gpa(gpa_t gpa)
> +{
> +       return gpa == INVALID_GPA;
> +}
> +

Are you ok with a local kvm_gpc_is_error_gpa() or somesuch until there 
is agreement with s390?

   Paul

>   #define KVM_ERR_PTR_BAD_PAGE   (ERR_PTR(-ENOENT))
>   
>   static inline bool is_error_page(struct page *page)
> @@ -1787,7 +1792,7 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
>          return (hpa_t)pfn << PAGE_SHIFT;
>   }
>   
> -static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
> +static inline bool kvm_gpa_is_in_memslot(struct kvm *kvm, gpa_t gpa)
>   {
>          unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
>   


