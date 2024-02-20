Return-Path: <linux-kselftest+bounces-5007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D185B672
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA309B2649A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E475F49B;
	Tue, 20 Feb 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaVdyU6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032A5F492;
	Tue, 20 Feb 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419586; cv=none; b=rR6LqCT0p8hIoR8nT6wp2AT4YhvfXxKp0DjtJIEiearveXZwoWaDRaxm+C8TtNpFXb2bQVjaLXWkKLp2R6Q12m7nZVycrxJfXVO7IYAnsnweoLYAjyis90m45vbfUpuODcdmWnv+kCeD8YRat3UC7esCHr6WOHoKs3WEcSYmvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419586; c=relaxed/simple;
	bh=kMRyy94TGbI5G9a7NUzCwy7GqE4yhZZpGtIMYZLgoSk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sH//qOB2w65i4izcaSqehvYGGJYb9MzOOzLTzZvJz1OeNjR4H6hMfX3pVAH0wsgbSWwUc+eVAuTUoKKGUdnZayru0OXIVmzd2mBIWWywm6AfvKaqwXH1k9NrJI/Tuq9Kal0lmjlV/pMOtmsrDhcLUmA3EmAQIWLmH0Ww6rCz3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaVdyU6O; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4127008decdso1780865e9.1;
        Tue, 20 Feb 2024 00:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419583; x=1709024383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CioH3BsTUz1maYuaICq+/SgJ+oQ0/fhAEh2/1YJhMeI=;
        b=VaVdyU6Ob8JqmhehsbCvrPTtFGTcxsVwiBDrU6eUabGse5midM2FQU/V6VnOLMFEyB
         3LCtl7S6u8f+4tKXNX29UrFjCh2APgta873hMBMyWIOzvekbeZTjNfTwSSZ4j9BNDtKw
         j7wo2wcA4BIMweYYMyRF2uvG+A+2UumIq7VxCu03AOgVok1V01yq0BQkGLAf4WbzaCyh
         955GmrL8Llk/glh2yIYMqQJj5fMpt6k1ghsD5/XSIMYC9S4WTM4tZWdqXQPL1q63Pljf
         pOHc+gvhHAYy+0QryfqorI2bYOioEuBPMSJy9l+5ziBwzl5FEDXYoIdwwlamfnKFEUx/
         3MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419583; x=1709024383;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CioH3BsTUz1maYuaICq+/SgJ+oQ0/fhAEh2/1YJhMeI=;
        b=kRXkfF6u+UnJTwo3glqWFeRF13mlM4xT9OFO+8wUmcbT5nZqHoV2ltgciWSpWNQohb
         IggZKyobc0jZC0GITccyzAp/8tYGQLlZJsxsxxc8khNvk+M9wKHRxJ8e5X84EIgqsTRF
         urkIH3GrNBvV1Mci7yL/hE+vIpsgue00UU6u6GaqF7hXsIkYiYXTcqQDgp26wEJVhM0Q
         6Nufq/wuWkVIftWNs1wTAH+JmebLUbfA3eoZcW5pIwqds9ZqZ8AhTJE9b3yyitxCojyZ
         rYtU6+eooyZ8DAeI3ynddtV3ZUnjPzvmuce2ynIsTPrZIV0CyFQRq+O0Z0G2pi9Er8vr
         8adA==
X-Forwarded-Encrypted: i=1; AJvYcCUYhu9RICOLdzQjQRE3KMqyM8/2d4DClbAg5Yd9EmFQs7qQMGaun3NUlQCHfDfhVyEmOM9GSXe2/A7dWy/tL7AlcJXtaSkxPUyyXPAE8y7Ya+U/Alu/dQ3cIQhchB77bORJnOBUV4KDMKsS6oxVqsXVMFFU7PlqFuYtLPej9lp3tmlnRgnNhnuNrlj4moTX5CkvI/GVyeIZfsVdwmfLvsGOeGG7f0u79oZsgFxT1w0UqrYPEn5RKS1gkQ==
X-Gm-Message-State: AOJu0YzZJeJn+9FZXOlPfDx5MTab3rKXNPkiFBseCt68sGbs9mumStlT
	dXah44LzzVkBe0zEImf8Es6b0WIR12D2aSxq5HjVdYV+K2Qkl7/Hc5lWMBrqHX8=
X-Google-Smtp-Source: AGHT+IENQnZyd9AKtSsKq7VyOw+rJmwnCSsxPyTeYgkBgVSsc/+PvQop+z/l0W1bAvIRueJO4UZgdw==
X-Received: by 2002:a05:6000:1787:b0:33d:56a0:88e3 with SMTP id e7-20020a056000178700b0033d56a088e3mr3094047wrg.65.1708419582378;
        Tue, 20 Feb 2024 00:59:42 -0800 (PST)
Received: from [10.24.67.19] ([15.248.2.239])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033d70dd0e04sm279495wrb.8.2024.02.20.00.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 00:59:41 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <7871cd67-156a-4823-9b0d-d54ee4b72dd0@xen.org>
Date: Tue, 20 Feb 2024 08:59:39 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 04/21] KVM: pfncache: add a mark-dirty helper
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240215152916.1158-1-paul@xen.org>
 <20240215152916.1158-5-paul@xen.org> <ZdPLLsdNnAb5eXiZ@google.com>
Organization: Xen Project
In-Reply-To: <ZdPLLsdNnAb5eXiZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 21:42, Sean Christopherson wrote:
> On Thu, Feb 15, 2024, Paul Durrant wrote:
>> +/**
>> + * kvm_gpc_mark_dirty_in_slot - mark a cached guest page as dirty.
>> + *
>> + * @gpc:	   struct gfn_to_pfn_cache object.
> 
> Meh, just omit the kerneldoc comment.
> 
>> + */
>> +static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
>> +{
>> +	lockdep_assert_held(&gpc->lock);
>> +	if (gpc->memslot)
>> +		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot,
>> +					gpc->gpa >> PAGE_SHIFT);
> 
> It's kinda silly, but I think it's worth landing this below gpa_to_gfn() so that
> there's no need to open code the shift.
> 
> And I have a (very) slight preference for an early return.
> 
> static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
> {
> 	lockdep_assert_held(&gpc->lock);
> 
> 	if (!gpc->memslot)
> 		return;
> 
> 	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
> }
> 

Ok. Will change.

>> +}
>> +
>>   void kvm_sigset_activate(struct kvm_vcpu *vcpu);
>>   void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
>>   
>> -- 
>> 2.39.2
>>


