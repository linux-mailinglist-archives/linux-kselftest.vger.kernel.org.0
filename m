Return-Path: <linux-kselftest+bounces-41387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB0B54FBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FAA466514
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06030E857;
	Fri, 12 Sep 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXMKPetI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940353009F1
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684190; cv=none; b=L0zEQAJDrziZQl0fwfgNnqVlLU5r2K7/lP9s4aQuX1BEJRXFnylaPs5HLh8MJV3cfrsDRVdSaue28qBcnuOS4wi2H4wOx+/zwuPFqTS5lFcu7SQEoGoRjz+MncLbLKVsUBpKAWdQ6OokqQpoBvk1AjMClQCv235zOS6Y+DRi6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684190; c=relaxed/simple;
	bh=t9IrEKU78LnKLsHKxdMDundR46ahi8bvNgSaH4WLBT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbvgBEQqTbxtBn86L0dKQzjRrN/Xh0A/qzFIcysnAynYnOPEhknHCADx1djjAGxGNOCF0sYKVkQGDax2F/Vse1Vwdm/ApHRkIZ7FD89Tk/UZZbyh/GAb6n0RTNuieKznTGNDtLI2ZdKxVV4aNGRh8/C3r7kmO8iXC0HDPPO9W4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXMKPetI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757684187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c1q+KGAAfVttCgY48bVWecGNxQdsIbBlAjKhfUHOaks=;
	b=QXMKPetI518VF0LKVdjgk5g/aiROs3ChN23Cap/jiqr2+f58W5djWTeTbSLNcXeZ2RYnEb
	zIxbJYevhSST3Nzs6PMx74hdb5jooXlogvRCCPcj6f7voJrBnEbU4gl91Eet+nfEz3e3d3
	mR09p+dTWnmKcDXrsUsWbWz0G1mBBEY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-UsXYEeLBOPWl8bniGaybKA-1; Fri, 12 Sep 2025 09:36:25 -0400
X-MC-Unique: UsXYEeLBOPWl8bniGaybKA-1
X-Mimecast-MFC-AGG-ID: UsXYEeLBOPWl8bniGaybKA_1757684185
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dde353979so11078905e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 06:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684184; x=1758288984;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1q+KGAAfVttCgY48bVWecGNxQdsIbBlAjKhfUHOaks=;
        b=VfqtWPOaocFHzZgAkZ62B9dLx6PJ2OQXqSpGZnosiqRoDK+urA1EslZWjriMfZSEG9
         tgXWM05ADi46JfPzbQpu7ioRucxG6ihVw/zSx8NPYIe2G1avGNK8VgRX9Z/hZcytOFe9
         wiZ7fmgOTZJJNJNsY9d534DDfz3Kfy2wwfo7R1IPXNLRtN07l05fTNmdmYWCsgFl04/K
         JxJ/C6eOuqhNRiFGLiUXMG/L/nDgRC5fblqtcrKPaPJPHa5lUPdBDWoG7tb5jdcYuXM5
         yR1NQ7af+VkL4dwla2gdEAWwA6oOhkkxtO+KR2ir7vdZwXkXOuIRD+lU3Z1MZL7csf53
         Ct4g==
X-Forwarded-Encrypted: i=1; AJvYcCWdAHVleJZUzdAd9xaUaXyc5z7gAGOAqkEJ7EX6X+RxtFOMb9Ln+upYJceZ6wDybUE0OyhduhX2pPs1T5JeGVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IF98R3fVEbkDCGqyUDzreoW9KtJyAqjPtUwgzI+UuhF3KMMi
	A1PvPeX9gZ1HAjRRLpeswyh3vNm0CaHhPUPMeI3uDDWqnC1aT2QmvXLILLkQSKZ6/KFQcNCnkjS
	JU4eJ3YXY6mAcYgqJ5i25TDHgHeB81uB62lZP431RdP7uKSgK6t/94x/Au7PPHYdtKddc6w==
X-Gm-Gg: ASbGncvP41bR5DYVSJo6LpzgBVN81W3IxOh3Px1G/PJOrp2yhotr7MZgjD4HHJEuSe5
	/00fBUQn6MYGuZIKDhztuawgWLrXKPQkyhDbm9Q9uuejhq/9e/8MA5QG5GJsafxQ1Dt4nG6oDiM
	VxD219A89nDzW/Z1CADtYBTSY9m7SCrYb+Wa6LVJ88+L1Yl3VSLRo8kKWzxUgppFAH1sD87ek1K
	gbpB6eUh2PU0jIRtw/lmIHAyg2MOc4vpuIMMSagm99G2b7MYo7eIIe61Y10T3f+hOyXi0SQxinm
	6JO8hCIT9VRkoqHCUYWgmJdsnRi7LSZaE71kLH6DVE9FZR7hCMC/K7bEEeUks3+BPHA06yljB3Q
	eV0nJRHYxqJfZS3G8kTdmBVZ93j8kSt+MjQAb9H+rWygC8fmpbNNN+yaN5oJwwErfkyA=
X-Received: by 2002:a05:600c:6c94:b0:45b:9afe:ad48 with SMTP id 5b1f17b1804b1-45f211d57e3mr30670945e9.16.1757684183831;
        Fri, 12 Sep 2025 06:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3C7qbPdEaHDu5BvlzuZaVRkx6nsTgwqOonYfi1PulO3k0njjhXYjiDSVgBgoJliI1MGMrzg==
X-Received: by 2002:a05:600c:6c94:b0:45b:9afe:ad48 with SMTP id 5b1f17b1804b1-45f211d57e3mr30670335e9.16.1757684182982;
        Fri, 12 Sep 2025 06:36:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01512379sm65835905e9.0.2025.09.12.06.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:36:22 -0700 (PDT)
Message-ID: <8e55ba3a-e7ae-422a-9c79-11aa0e17eae9@redhat.com>
Date: Fri, 12 Sep 2025 15:36:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: kalyazin@amazon.com, James Houghton <jthoughton@google.com>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael.day@amd.com" <michael.day@amd.com>,
 "Roy, Patrick" <roypat@amazon.co.uk>, "Thomson, Jack"
 <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20250902111951.58315-1-kalyazin@amazon.com>
 <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.09.25 12:15, Nikita Kalyazin wrote:
> 
> 
> On 10/09/2025 22:23, James Houghton wrote:
>> On Tue, Sep 2, 2025 at 4:20 AM Kalyazin, Nikita <kalyazin@amazon.co.uk> wrote:
>>>
>>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>
>> Hi Nikita,
> 
> Hi James,
> 
> Thanks for the review!
> 
> 
>>>
>>> write syscall populates guest_memfd with user-supplied data in a generic
>>> way, ie no vendor-specific preparation is performed.  This is supposed
>>> to be used in non-CoCo setups where guest memory is not
>>> hardware-encrypted.
>>
>> What's meant to happen if we do use this for CoCo VMs? I would expect
>> write() to fail, but I don't see why it would (seems like we need/want
>> a check that we aren't write()ing to private memory).
> 
> I am not so sure that write() should fail even in CoCo VMs if we access
> not-yet-prepared pages.  My understanding was that the CoCoisation of
> the memory occurs during "preparation".  But I may be wrong here.

But how do you handle that a page is actually inaccessible and should 
not be touched?

IOW, with CXL you could crash the host.

There is likely some state check missing, or it should be restricted to 
VM types.

Do we know how this would interact with the direct-map removal?

-- 
Cheers

David / dhildenb


