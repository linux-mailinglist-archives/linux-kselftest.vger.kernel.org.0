Return-Path: <linux-kselftest+bounces-24329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87787A0B2D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 10:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3873A3A22F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57062327AE;
	Mon, 13 Jan 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRPK6b8x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CA55896
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760662; cv=none; b=dKEVYNrFOiiDOlgV/29Mgs1ls/D+Vp8rmeun5yPhi7hQPv0478TlsnKMu5ULM5BCdYLtMV5eKf+03V/HT4zvKq2o4UHBhsUnN8OSX3zb9STQTlsIGRoq05vxYwBMvj2ek19kml/LOrV+UojrLc5Lq2BU9QUJqpoUZ2lYz1ss2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760662; c=relaxed/simple;
	bh=++94Yq/dSXQtqNyr06EebbfTko9t2h3FkIt/ATHw+24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHCYBG9OMcaGcapN1Y/6koF7vWm/9ZFLwyCdMXpu1gjgAgBO06osgJJzcuaVpAJ9Wh1wjHaKaBtjjrSjgPyQqJwiDGLcQpZqm77CxNvu3UgG+DpM19tHaPSDJmIvEwigAEdKhWp8Z1djCOPCRZ3KAb8oOW6PYwFqPGcYwvpxmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRPK6b8x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736760659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xefopU7QEsHCUkb3WideIOMXlL4/pP/+78DJfgfOICw=;
	b=fRPK6b8xIpQevQCH+gN7HaMLXvSo4QKwMRETBhUujFBcbRPm7IzROVVb1xe7dJPcHBHVyE
	km7GShbSpfStO9QrbzRUAERxiW+Vyi1Rm66GgeZhsfa0Dn3Jmt6C2gzF8VS6yKGvdRlmTa
	N9Rifp9NiWoCKRZtpbsDSKcBopqUgIY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-c6uZGyJBPS-_Ye4twoxllg-1; Mon, 13 Jan 2025 04:30:58 -0500
X-MC-Unique: c6uZGyJBPS-_Ye4twoxllg-1
X-Mimecast-MFC-AGG-ID: c6uZGyJBPS-_Ye4twoxllg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so23098075e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 01:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760657; x=1737365457;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xefopU7QEsHCUkb3WideIOMXlL4/pP/+78DJfgfOICw=;
        b=jbZt+7T6uzzdZ+kwS5mPl3btusu93CZAUi99SMU0wwaCRIMwoShXZPg/4kxtofl4Fc
         rI35u3/Tl2xjJAM1PhTr2iOp7LqshO0HxD6hybhvoy4PyhtzN6Qy1nHpOcdJJXUwaJNv
         sq3N+snGLgZJVzircwKJ4XSS2bjwc5lscseOQlrAUbCAbYPeC4E3guzP3dURAc0yAjP2
         Ee+vW4HqU97pVQQiYaFP8vlU9D75KmBUHg+IvJcJfEH6SNV/GAGK0BBbaAiCLtAGoJy5
         KyXRtwRUSE2RHkcULIPgyRUUyCkHwzEhu3hePr9xyTgQco+gcO3861tUg/XAcFYfbpsm
         ap8A==
X-Forwarded-Encrypted: i=1; AJvYcCVlR4BMaBAwmBdEzSS6/R6iX01Wm2HXE5XdKQERCoiP7IY7ysOSDhdnUmfEu8OzTOPto195nxfLmHO5BMfYVOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykN7JwwGd3Gbs1UU6AGPVtTmpg6uQS1p8pD17C/8f/9AEKKLOU
	IH1YfILeQupm/56R2KbqMku/Dxth474BDsxm3pp6i32184Y10scPUL2wEvdmzb1kOZneEQLsoKz
	Kr/0bUSTshV54oiGKGY12CZGuFdUGFmWBbDZ53ZRHCMzioNAq77t1wrPa1EB3oaFpk/J2pfcyYa
	0C
X-Gm-Gg: ASbGncuUjdXJzJ6u1F5Uzc398keh3aSR1dkgoyd1/pLUIyQKAnFsHPgYEHneajb45+w
	3erxZNQyXyh5XpozOQkAxNGZG5UEZhv8mCkJPAXXh/M/PV7T3zI1pSS9AmON33qIjqM+xv5+Hc+
	QlB6Yr0hiVk3V0/mGoH6hB5vizNxsmmVGJ/AtWqdZ2y9I5vIk01AjZA1mbkmGZvnOi563CDRAl9
	ZMJo4of4Bcqg9D7njkpgm2espYV5gLVzy4Q0H5B6mqCv/yrH+VJulkZwQSQ87X78MVlm8mEl6wS
	KEQovYmQMtzfRIk=
X-Received: by 2002:a05:600c:1f95:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-436e26d946cmr151807795e9.21.1736760657176;
        Mon, 13 Jan 2025 01:30:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuEniF7zOMwP2J+tlHm/kAvUE2AsZC5lEappPWSxQZhCAcrsHWYUT9/ULjKT+O2pdX1D8e5w==
X-Received: by 2002:a05:600c:1f95:b0:434:a525:7257 with SMTP id 5b1f17b1804b1-436e26d946cmr151807565e9.21.1736760656787;
        Mon, 13 Jan 2025 01:30:56 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d11csm11752748f8f.16.2025.01.13.01.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 01:30:56 -0800 (PST)
Message-ID: <e97c2a5d-c815-4936-a767-ac42a3220a90@redhat.com>
Date: Mon, 13 Jan 2025 10:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/mm: virtual_address_range: Avoid reading
 VVAR mappings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
 <20250110-virtual_address_range-tests-v2-3-262a2bf3c3d0@linutronix.de>
 <9243dd8e-3f03-4ed5-bdcf-95c947c57849@redhat.com>
 <20250113095211-bde77070-8be1-4393-898e-22eff532189b@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113095211-bde77070-8be1-4393-898e-22eff532189b@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.01.25 10:09, Thomas Weißschuh wrote:
> On Fri, Jan 10, 2025 at 04:41:03PM +0100, David Hildenbrand wrote:
>> On 10.01.25 14:05, Thomas Weißschuh wrote:
>>> The virtual_address_range selftest reads from the start of each mapping
>>> listed in /proc/self/maps.
>>> However not all mappings are valid to be arbitrarily accessed.
>>> For example the vvar data used for virtual clocks on x86 [vvar_vclock]
>>> can only be accessed if 1) the kernel configuration enables virtual
>>> clocks and 2) the hypervisor provided the data for it.
>>> Only the VDSO itself has the necessary information to know this.
>>> Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
>>> the virtual clock data was split out into its own mapping, leading
>>> to EFAULT from read() during the validation.
>>>
>>> Skip the various vvar mappings in virtual_address_range to avoid the issue.
>>>
>>> Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
>>> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>>    tools/testing/selftests/mm/virtual_address_range.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>> index 4fc1c21a5e218eaec4d059b75c31a21dd4e8a215..993990aba56fc986c42084ffa91973558aa07e87 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -152,6 +152,10 @@ static int validate_complete_va_space(void)
>>>    		if (prot[0] != 'r')
>>>    			continue;
>>> +		/* Only the VDSO can know if a VVAR mapping is really readable */
>>> +		if (vma_name && !strncmp(vma_name, "[vvar", 5))
>>> +			continue;
>>
>> I'm wondering if there is a more generic way ... but likely not when staring
>> at /proc/self/maps.
>>
>> /proc/self/smaps would indicate this as
>>
>> VM_IO: "io"
>> VM_DONTDUMP: "dd"
>> VM_PFNMAP: "pf"
>>
>> Especially checking for VM_IO sounds reasonable ...
> 
> Agreed.
> 
> Can we instead rely on madvise(MADV_DOFORK) returning EINVAL iff VM_IO?

That might be one option indeed, although it feels like this is 
something that might change in the future ... not sure.

MADV_POPULATE_READ fails with -EFAULT on VM_IO, but also on VM_PFNMAP
and some other conditions, and might not be completely what we want.

We do have some initial smaps parsing in vm_util.c:__check_huge(), maybe 
that could be factored out / reused, not sure how hard that would be to 
extend to return the flags.

-- 
Cheers,

David / dhildenb


