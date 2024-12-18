Return-Path: <linux-kselftest+bounces-23533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D129F6FC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 22:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741F11888832
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8B1FC11C;
	Wed, 18 Dec 2024 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMEo39IH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6485383;
	Wed, 18 Dec 2024 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559035; cv=none; b=fILePbGwXVPXDAE37wJjXJ0QAIi+7JVaOitXSGT00H2QyrcT28PvEhprEfhVpTgbHv1lXS0R1HP5NthYo26eiF7V1w9NNxd05dXvvgM2FNpEt9SQNORP6K1VmTSROKDGTV3FWvQhhhUZzRabVOyrr8qFxPOjcfaJyH1ujsHDyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559035; c=relaxed/simple;
	bh=VMKwp68beag1rsGtcORCKXKjoNZOGhbCbWJbdj3nI28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUMhuMiqpC+OYe8ONDGWCBI8D7ZnDbS8kH2i7hFv0folXgcipxHhwljr4NGM13sMOt6BVMI3MCGN1hb4pl9ZE+i153JGgA2NGFCT/sJkMi2swHpsuVEpKDfE8oiycnrr0ACfE0SeG1lgYm3UWdcvj4y073Pcsg1HCBnWlWa0xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMEo39IH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso879155e9.2;
        Wed, 18 Dec 2024 13:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734559032; x=1735163832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LOHLjHabArNW5VIUyqYrw9ykNXPW0+LpDm9qCPwqpY=;
        b=FMEo39IH0rHqGmATNBcpR0zhyZzbrA7dhi4xqP+iEYRbPBhkpWLrtOckpcIIPzioS9
         eGWBExQgyLgNOolDnZwKEdWLk0+j1gjeT5/2UeK3lyWpL5wGXnQPf3WFQ55XaTREZT+h
         OTcYdmrmq0+8FXnNRSo9QsXZshaFqxT+hLV03oprznvB2ws++PdwNiZyZBdyONrATXEO
         dY9mbGmTcPEVEbvj4lXoda5ANoJRYiZwfsVF963aP2HbsJuthub7kgdVvpplx5m/56Gm
         kMCkCaXVZSf2l4Nbvrr+nzvQdajr5f2MmuQ+ThTK+OOAX6y/EU1WQR2KHrCJ+VwJ/R0H
         dyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734559032; x=1735163832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LOHLjHabArNW5VIUyqYrw9ykNXPW0+LpDm9qCPwqpY=;
        b=jAtJlXMfSroMsaMSyj9tV0K2/RF4ZSVB7XjeVOhoS5tfKd9h1rZ45aCTOxL0wVYWuZ
         b4/Nsw/GnjoqhGk/0gXqh3gqcZB2BL/8L4AQGQle3YM2/iFkeT8QyuwCGjzkhM/Zo21v
         3dNJsLf9pdxnK/haauBlhJ+bVv76zSs8qA0ofKnVXFILnLFvdO1HLN79tpzktXzLHFcI
         i0z7dt7RKkigA5TQFDu1kRax9A9kdgLbuyKtoTuSIY4LxBuqVsS10y/SEVoswXcOjj/B
         Je47wu04QyNMvHUEWvcnNTd8ECVWo2imd8ZxPqWnBeBqW2W5VKCFTQLiPrl26JbgJ+Jx
         CG3w==
X-Forwarded-Encrypted: i=1; AJvYcCUuMu9cl5oMQv1o3LEIPD72qBUOzoZaL/+SLmXgMNSiCQCAgI2WMeYrUN+c1yBalXGaqsTNW69E7b/t/4pB1Q9b@vger.kernel.org, AJvYcCUzYjTv900SpbtiuLcyDa1khGY5QxFYgKzVwzazs8HbAPwZZ7ZWKrHV+cGntpywAYPBnfA=@vger.kernel.org, AJvYcCX1ly3e78v9ja9ABdZRNKWTRqj7WFOXgk5XxLXBBrhcraJbccAbE1uJlUSibva3SBCL//KYXg8OPBnXZ2C2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Rp5MaksqJ8NPYKBFrjgGVv5sPrrL9uLb0hn7qVxNxz0Ye53w
	4kgzdVITiA3zi4O9KsHDmv1brCJ+8ORzkmKjaNvwtXCuy5V75WP4
X-Gm-Gg: ASbGncsEgVkN+72uU499GdIejNAGJdElRMIW9q7YTmMxzOjTh0e+jJl+aL+jAlKP82B
	U7NMToA6nHv2qyP2at2C3QX+qz+t57j3GgbPRoJe8UGdksIy15+W0VlOdHOPnf8L7FEstzEYb+1
	MSg74EhFXoLsC0e5tfM5RWrp036KosmMVOrtFC5ve233cZ4qmU5FWQk1tRF9Zid+xeK9mnnhslo
	4LJL9cja09VxYud5tlK0wM4xnI/IMwBJY0v2hOj4uticb6S7AUjjPRdRIX2wA94TAsyu+MxEbM7
	lNbC0m2Zaw3Gs/4sSLfWHrVd7FVX
X-Google-Smtp-Source: AGHT+IHc2nTeOAn7Cz5A6Wuy+3VMml2/uO3mZOip7BhDbLyuVs+vICnk5hLOqCFh5rA1kSqNE6CAaA==
X-Received: by 2002:a05:6000:4b0c:b0:386:4a60:6650 with SMTP id ffacd0b85a97d-388e4d8e6e7mr4235383f8f.42.1734559031423;
        Wed, 18 Dec 2024 13:57:11 -0800 (PST)
Received: from ?IPV6:2a02:8012:e013:0:3fe7:9506:a78f:9d50? ([2a02:8012:e013:0:3fe7:9506:a78f:9d50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1904asm31770635e9.30.2024.12.18.13.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 13:57:10 -0800 (PST)
Message-ID: <565a0127-f7da-4c68-8ac5-f0c6827c1899@gmail.com>
Date: Wed, 18 Dec 2024 21:57:08 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Enhance event delivery error handling
To: Sean Christopherson <seanjc@google.com>, Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, dwmw@amazon.co.uk,
 pdurrant@amazon.co.uk, jalliste@amazon.co.uk
References: <20241217181458.68690-1-iorlov@amazon.com>
 <Z2MYImBJGSjmBOII@google.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Z2MYImBJGSjmBOII@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 18:44, Sean Christopherson wrote:
> On Tue, Dec 17, 2024, Ivan Orlov wrote:
>> Currently, the unhandleable vectoring (e.g. when guest accesses MMIO
>> during vectoring) is handled differently on VMX and SVM: on VMX KVM
>> returns internal error, when SVM goes into infinite loop trying to
>> deliver an event again and again.
>>
>> This patch series eliminates this difference by returning a KVM internal
>> error when KVM can't emulate during vectoring for both VMX and SVM.
>>
>> Also, introduce a selftest test case which covers the error handling
>> mentioned above.
> 
> A few nits throughout, but I'll address them when applying.  Thanks!
> 

Hi Sean,

Awesome, thanks a lot for fixing the commits and for the review.

-- 
Kind regards,
Ivan Orlov

