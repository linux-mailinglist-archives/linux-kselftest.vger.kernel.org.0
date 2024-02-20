Return-Path: <linux-kselftest+bounces-5009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C27A85B67D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 10:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F007A1F22336
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196885F49E;
	Tue, 20 Feb 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM8xwjHn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AC2D79D;
	Tue, 20 Feb 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419699; cv=none; b=ZE4bdaOcRetHnf9J2P/gL8/nsJnK6DM0Bm9XGUzVYfYeA5pplH5Rlq90Uq/tXXUzKFJIjjB7/wbeokmsE14j7BAaMGlCMeLuux+/gwpk8Z6CKlvjIl15G0RHidoim2hbvyISCChPIjkk74jTvVM2E3WkjPMjMmzuzpy5GQsAyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419699; c=relaxed/simple;
	bh=3HN9ulJaX49LxKjkhZV7s4TD4cJFZMmgDS6EfuSIUUU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZhjMYjFu+WEDoayCwsWfAHrZHDQTDHUU7vBF+3iDzTBSm3O7fbaywQo/Q+DmQlkN6AdDGCsrowTKy6dz6j2YbEBvL49o6ysDCSHKGbKQIQCcgGQHS5ImOJH0VApAPoJRyXZSaq6Ams2/NyzRO2/CqvnM5TvwknqEdSizHrkQq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM8xwjHn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d094bc2244so71846491fa.1;
        Tue, 20 Feb 2024 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708419695; x=1709024495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o/fj/ap1poo56E3bkivsZeO6sqwzqsFLTlgp1qjL8Qw=;
        b=MM8xwjHn0Xikp4FKSAnolxQ5FdUY0jjQNlw1KtGyIrLpWWTPguuxTXkg+c+uh9YUL6
         aqF8k7MeAY1m8Xj8z9hYUemialWQwiOr2FOvNB9xYxiG6jSEL4taUsiXG8i6HWpttIU9
         bxCtQU16BJvqtuSFY7U0i476kBsxMRXXWQ9FaVIneKBA8WcKHA0biifYJBKZ1GYo+3Jj
         rmXGjM4aQjB+fjTS+1ItK3xU83DqR3kPfwD7JBQf+lUwt68MEU0JJznbZ4b5ZF4chVEW
         zpdzl1FgejFIx7z9zON/NNBrM1+H/n9STfPCEQHospHGje6s1IRNZEt7ayrvuLiLlplS
         knjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419695; x=1709024495;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/fj/ap1poo56E3bkivsZeO6sqwzqsFLTlgp1qjL8Qw=;
        b=VuRkquHzuu78ujzAX5cnSU10iz90zXdS15g2E322jHW7CYub5dC1LdWLC5xntVs25f
         bo30ruyoSyFA3XbrzA/dKVV2qbpcNoJUpik7r4eTXC+zWLyi0pvSetqTpwNbPTsCD6GH
         LeRtWB5BIhCsGe+Hsb+6vhL27Jwi4qIL55ArEP53YRcELF9vQSFRJY0XHjMmIXYuLp3Y
         FdJkiO2AKlBJn0UBwmmKSnvqo2pqfzGJ8hR/999kLosMbcoA+8ldM95npMIAjp9N1t9O
         LrmEJKT4DRZs8FRVLdhHlEjFnqiwYkMM+5huCLaQMRc/R+BYhlQtToy3cigh9TjFzA1G
         wgaw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Tc/AOcr7jkYKsqGDg+Ojkr5cz2lJUqYjFC42i/lc2X4SWYe+mTcFEeoDfT0nsZ8bR+aErm/q7vu2HIJCyIOwnIH08LrPgErSKbtqVawM80TS1mEkTVW/J6Qlq3CORLcHxs9t7eTWKMiwbD5g4vv2xYMBF0RtWWm03ar+sP0UtLYQeMps2RdpFDaK9OZ6w5zBgYBOT7YGvWrt6UAfM3mJBVKISz13G1lGMRMqE4bBtVYU+/QAeu9G0A==
X-Gm-Message-State: AOJu0YxX92PKgylyOqM6nRlKDjlgPJTI2iHzH7YwgONyB514IO12JdoO
	ixWlAuSCBqJCq9ltetvKaGAAhiswhvjnPvwwJMN6XDla6rvOVueU
X-Google-Smtp-Source: AGHT+IFrpma4yK6NolM0UzvNWWN+LIUqRlIuStiWNZ2+vrwK2FLXdflxBWw73wy8W/nf0y5Tfkcu9w==
X-Received: by 2002:a2e:3c09:0:b0:2d2:3017:c144 with SMTP id j9-20020a2e3c09000000b002d23017c144mr4977573lja.39.1708419694974;
        Tue, 20 Feb 2024 01:01:34 -0800 (PST)
Received: from [10.24.67.19] ([15.248.2.239])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033d70dd0e04sm279495wrb.8.2024.02.20.01.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:01:34 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <2bdd7614-f548-4b6f-a475-1fefe6f6f4ee@xen.org>
Date: Tue, 20 Feb 2024 09:01:33 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v13 09/21] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
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
 <20240215152916.1158-10-paul@xen.org> <ZdPM5tzyHEq4Z8t4@google.com>
Organization: Xen Project
In-Reply-To: <ZdPM5tzyHEq4Z8t4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/02/2024 21:49, Sean Christopherson wrote:
> On Thu, Feb 15, 2024, Paul Durrant wrote:
>> @@ -319,7 +340,16 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
>>   
>>   int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
>>   {
>> -	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
>> +	unsigned long uhva = gpc->uhva;
>> +
>> +	/*
>> +	 * If the GPA is valid then invalidate the HVA, otherwise
>> +	 * __kvm_gpc_refresh() will fail its strict either/or address check.
>> +	 */
> 
> It's not just to make the strict check happy, though that's obviously the direct
> motivation, it's so that there's one root of truth.  The strict check is there to
> enforce that behavior and to make it  more clear to readers that it's an either/or
> situation.
> 
>> +	if (!kvm_is_error_gpa(gpc->gpa))
>> +		uhva = KVM_HVA_ERR_BAD;
> 
> This would be a good time to use a ternary operator.
> 
> 	/*
> 	 * If the GPA is valid then ignore the HVA, as a cache can be GPA-based
> 	 * or HVA-based, not both.  For GPA-based caches, the HVA will be
> 	 * recomputed during refresh if necessary.
> 	 */
> 	unsigned long uhva = kvm_is_error_gpa(gpc->gpa) ? gpc->uhva :
> 							  KVM_HVA_ERR_BAD;

Ok. I thought that actually looked a little less neat in this case, but 
I'll change.

