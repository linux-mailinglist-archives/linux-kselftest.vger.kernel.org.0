Return-Path: <linux-kselftest+bounces-46533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B942EC8B269
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 18:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757573A510D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7E33E354;
	Wed, 26 Nov 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwifJlrr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CD33A008
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177250; cv=none; b=DnE3oNS5Hp5lqxUE569XqfnnAzzCBfXlRhdsteTQLiFc4gBzYeq+XRelhptZsaZbD0zJOlIA4T25YptDD17TE/TFn/K5fu3T3jm2kZcrLJSog5+9K2pbKwSym8O7KvRSVD19OgkNvzSY3F/dkif4lZsa15vevZuMYJY2Sa46ekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177250; c=relaxed/simple;
	bh=3Ejxx6pAoM1ChRfzDminYzCeEx52+t9tKpy08nqT/aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BObCk90AU6NFhBAbwwNDYbJvzOLEy00X1aHXJS2XcfjzxjDIwNwOssawIrvj4HFLv/eJsr5Xk1z64CIhXYI4sM3o1TND2tjiM6alt2HS6J7YU1BmI7uRb25X9kTaJpN6rUUH8ggBZDMunBqJpXeTXspD+AprtpvrWotmnEx6BRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwifJlrr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso41466035e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 09:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764177247; x=1764782047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKxxWS88sRLsch0GDN5eUzk0Z8XTysZ7hNh3XkKXTY0=;
        b=WwifJlrrthmN37TlCsSaXDi+P43eVdqFDdOR5fVPJGfMVvRjgkYPvkkzGX9rDcErG7
         c/a8DLrD6hSEDNdc9qqLMp5qUh3rCI6LqJjsFcw1T2wJeStF2eK9TgvetxfH8tlSqTDx
         rdNA7LV/rfAKTKKEDIrcSj2O3Dn0+2d/v5TM6HzeSTS9PJPMjq3BkWxrJC418y3usmdd
         2PCVYF6egY0JmWZGmGNoXvsVxlxBuAZ0AYRP9CY8UVXRJnJDE9n7CM3a1pYXkxUay5OR
         e/pe+2laecGIPQBa9kvK/9zFAT/lIKJCRxVeAiFoofUHB3yt/0MmXxLvklc5tCjKYUNR
         nU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764177247; x=1764782047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKxxWS88sRLsch0GDN5eUzk0Z8XTysZ7hNh3XkKXTY0=;
        b=syPIMg+l/JLh5hXw2/uQHUu/ZZohOhAb9oKIGFkMZU1rv6wIK5jgLvJkUFGpcr/aPi
         P3lcXqIKbhh2fNW33e3fTTaYDpVHb7T81GGPverMo2IgrpoVhBgM5LOSZzMYf/5oIx3c
         UmBeToNhOvHtU8zum7aePbLPm3fR4EMDjQFCImaopJ9RmSt3IStm459Dvu7WvQMqkG63
         XSTysFf8JAJe+vIzXqsfRE6CBFX7SClTfazNLkLvNGr4j1w/ro6DMfMCUJpltcsfl8gQ
         Y9WoUjqLFiGk2egOcDiCA+lNak4Bb0ifnf9N4dD+puXz+KxZR4S6ynHUhUf31PKex/AC
         oQHg==
X-Forwarded-Encrypted: i=1; AJvYcCWZHrHM36nhTvafvzw3FtiprIYuBbfawqLMV4KOhKQvtQJzJ5T12GSqXHoN3Pjwz5vuL0Y3T/fI1wVKQz7NEoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYF5YPfxItw2Al1uWDFyltLoVG4V1HHJhG80nxfA03jWCg/YT1
	EflffUnKpDujuDnJNeYXGJXPfIgLIc/9qsyzPb6y/tnyD1krJJoxEFAO
X-Gm-Gg: ASbGncs91wgvOumXTZiuUxrpYHH2DaRxOX08GLpFRP5lYH43MBsvYBck5U7WCsCReSp
	hwThh5a1QbS3WBgnZDvSw8Kzr2r8cHwob7No5WPzpkS4mYOGTZjHMF8zfdB9MwOfjv7Iv0bRDPs
	HlyALJMaskZzwbo+AyAgghX8fv/wdo7cpd991okRTQfocPzVbc5CV6NBTNJ6CMACknJzgbVFJtP
	Melg3I8PsB3Jt1QWHp3v2+u+PIxAfmEg5icClRh+bzlCaBIrSxkxPIIvBIqD84BHoIQ53Cxw963
	ZhAUP17/rHwFfrQ4I2h0wV+RO8JqNirSHMIPuppDolHn67I3zg2QDt9ullghL0ThP/bSiQXPAuW
	7AO66aACZynATgKgthSRJWdbuZa2t54Dmp0UgltNZZJkD+ioYJSEhr+RWpRIuSOnO9FKtumnryN
	Syg4rTemoqK+ClgDlYzyojh6JEwj3LxLKS4g==
X-Google-Smtp-Source: AGHT+IEeUlabJkkeU4URSCYq6YEVT7i8LLPu8eSrASZVzCkAxvaNf+MzxONBZP4ebaKs4/OMcLwVpg==
X-Received: by 2002:a05:600c:1d1b:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-477c1133e4bmr203373495e9.35.1764177246757;
        Wed, 26 Nov 2025 09:14:06 -0800 (PST)
Received: from [10.24.66.241] ([15.248.2.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ffesm42577404f8f.10.2025.11.26.09.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 09:14:06 -0800 (PST)
Message-ID: <5cffcb56-26f7-4dac-a0ae-44329084d27d@gmail.com>
Date: Wed, 26 Nov 2025 17:14:05 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: arm64: Add pre_fault_memory implementation
To: Marc Zyngier <maz@kernel.org>
Cc: oliver.upton@linux.dev, pbonzini@redhat.com, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, isaku.yamahata@intel.com,
 xmarcalx@amazon.co.uk, kalyazin@amazon.co.uk, jackabt@amazon.com
References: <20251119154910.97716-1-jackabt.amazon@gmail.com>
 <20251119154910.97716-2-jackabt.amazon@gmail.com>
 <86see3r7e9.wl-maz@kernel.org> <86pl97r3ox.wl-maz@kernel.org>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <86pl97r3ox.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/11/2025 12:54 pm, Marc Zyngier wrote:
> On Mon, 24 Nov 2025 11:34:38 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Wed, 19 Nov 2025 15:49:08 +0000,
>> Jack Thomson <jackabt.amazon@gmail.com> wrote:
>>>
> 
> [...]
> 
>>> +	fault_info->hpfar_el2 = HPFAR_EL2_NS |
>>> +		FIELD_PREP(HPFAR_EL2_FIPA, ipa >> 12);
>>> +
>>> +	if (kvm_slot_has_gmem(memslot)) {
>>> +		ret = gmem_abort(vcpu, ipa, NULL, memslot, false);
>>> +	} else {
>>> +		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
>>> +		if (kvm_is_error_hva(hva)) {
>>> +			ret = -EFAULT;
>>> +			goto out;
>>> +		}
>>> +		ret = user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva,
>>> +				     false);
>>> +	}
> 
> And thinking of it a bit more, this is completely broken. What happens
> if the vcpu is in a nested context? You just populate random pages in
> an IPA space that is not relevant at all, corrupting the guest state.
> 
> You must correctly handle the context the vcpu is in, instead of
> assuming that this is the canonical context. This means going via the
> *guest's* S2 translation, just like handle_mem_abort() does.
> 
> 	M.
> 

Thanks Marc for taking a look, I'll update to fix these issues and
address the other comments.

-- 
Thanks,
Jack

