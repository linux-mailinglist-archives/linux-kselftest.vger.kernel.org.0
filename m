Return-Path: <linux-kselftest+bounces-10621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F718CD740
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 17:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45865B21859
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD45F9EB;
	Thu, 23 May 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYTA96l2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1513ACC;
	Thu, 23 May 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478632; cv=none; b=ZDZgYGW3ZK0VTZQ0/2q5yQS1bMD8AGoWvaWbfUGyKkZ5EQ5mzQzuNRlrdT+uhVAtt5ur//4EbLzInkUlGeOp7cvTCWH8y95cQwxusdVMubymRLglOCngBOUNqDhVhUXxu3Ss70SvpQqCvgrobaqsichhRdz3JgMFesrgBxoz3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478632; c=relaxed/simple;
	bh=DAu0j9XaO+BHc2+KymxPQHl8SlC0N0yHcL/u9tksZGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sjdt7yUUuI5J7GexX32X5owZZbcZikCOKtFxFAEfgusfHcbckTNSQoqEFRwj4/7kWVq7sduMgLX8O1MRR7zmaAD3Xs3TWQq8OElwKMObaJ7cRsf5YB+mpEw+RaZ3mDPgAPSey+yUU4IiPOAMLOsTFpJLKZEHAl5vdGTYORM/V8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYTA96l2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4201986d60aso18318045e9.3;
        Thu, 23 May 2024 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716478629; x=1717083429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qDb430+CIQ85u0Ej/5d34NhAAWYKYgLxz+dFZEGGm10=;
        b=jYTA96l2T/CxGeiVP1luTiCFNwk45Vqz7q+tFrNc6AqzKmYqdgMNgva6O7C4nxer2p
         hE3xUw2bvlzh61xNyyI5T/dM+ZpUSL5vLbcMzI9559/P/FMJyKQ7yEGIayZFyfG6SQLO
         z5uoAfAqwfJQfFrxh7SS52B6yo6tW6DzIdb1Cxxtdn2CYNcMXW2x/57SBJ6O6ozC5vfR
         m/3IJ8uTskLv9JPo1HtBXeTivZU7gUOE9RFKQQBuFj4J6krHa6Splex0KxWqVVwFdhtL
         26SLr+MvwSM9yzfglSBNrt5GqfGHb1+aa7vl82bZaAJfHYC9K9nlkmtkl4AZ1HGzxh63
         3kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478629; x=1717083429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDb430+CIQ85u0Ej/5d34NhAAWYKYgLxz+dFZEGGm10=;
        b=lQABQIc+byIcBwUOc016iHuP1ns4SrcR0337n1algVcYYjpniwJbwBAhHxytqkMhwx
         d1WJ4Qe+zMMzBxabxxlKlxB+CpltNirPSqWfPqx8PLQ+cMquHSBvWnD7Z7+QcBtQCVKC
         LoW0uGqOIO/jif93g3HEglHYQUXjREioZfmF/PnTQ7irOsSZsflHtVQBDULAhkuJ0gcG
         EfMMdzmUMD7g5C1EggdRH3MmsC7w+58EL5YmUDvsgU4dEoPwjx9MT4i8stSnvOEy1d74
         vIIXfQpTQ7NX5z1Mlj3YPN4A/BEkWb0Zom3wgxho3U700DFASaoQDkDtsZUi7y5m2shQ
         1GpA==
X-Forwarded-Encrypted: i=1; AJvYcCUXi0ECp2TYrkM+OkoHMaENfpTwWa7Kj16PivVUGPqmrnG0bJjOmhQ/CryUqsOf6RkIuKONuY/RUZRYhLRUifvuYdEfUGyQ0ZDxrnJXWjlRGW1pmuml9Tqff21dZ3elyBmTBeX0HIV6i/U1mdK7OMJ8JTV+0LF6Yf6PlZ/QCFgzf73GIiLgBEBhBYmKDUbUf11LzntENpXhJZDO0s3y17N2ylW4
X-Gm-Message-State: AOJu0Yz/y/EDXK3tDQL6aQe2auORCn3YWfKrWARBta6HjPM7m1Zb8wOW
	V8HaCs428eI1JyF/JFyDHZh2iOwzdvudXhJLkWLK3aQVugVFTdRb
X-Google-Smtp-Source: AGHT+IEUIVMFkaS08BYTq3/iyXcLgSdVBbrFOs8cO1ObYD0tOhF3B7ZYgZC33WVK4gteyLMmSMe+TA==
X-Received: by 2002:a05:600c:35c3:b0:41f:dae4:e9b7 with SMTP id 5b1f17b1804b1-420fd349963mr31813365e9.40.1716478628647;
        Thu, 23 May 2024 08:37:08 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42100fb7fe1sm28045695e9.45.2024.05.23.08.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:37:08 -0700 (PDT)
Message-ID: <637ed8cb-4503-40eb-9731-eb56e6b1cd93@gmail.com>
Date: Thu, 23 May 2024 16:37:07 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] selftests: kvm: fix shift of 32 bit unsigned int
 more than 32 bits
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240523113802.2195703-1-colin.i.king@gmail.com>
 <da8581c8-3d56-454b-bddb-e523a983cb44@moroto.mountain>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <da8581c8-3d56-454b-bddb-e523a983cb44@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/05/2024 16:35, Dan Carpenter wrote:
> On Thu, May 23, 2024 at 12:38:02PM +0100, Colin Ian King wrote:
>> Currrentl a 32 bit 1u value is being shifted more than 32 bits causing
>> overflow and incorrect checking of bits 32-63. Fix this by using the
>> BIT_ULL macro for shifting bits.
>>
>> Detected by cppcheck:
>> sev_init2_tests.c:108:34: error: Shifting 32-bit value by 63 bits is
>> undefined behaviour [shiftTooManyBits]
>>
>> Fixes: dfc083a181ba ("selftests: kvm: add tests for KVM_SEV_INIT2")
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   tools/testing/selftests/kvm/x86_64/sev_init2_tests.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
>> index 7a4a61be119b..ea09f7a06aa4 100644
>> --- a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
>> +++ b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
>> @@ -105,11 +105,11 @@ void test_features(uint32_t vm_type, uint64_t supported_features)
>>   	int i;
>>   
>>   	for (i = 0; i < 64; i++) {
>> -		if (!(supported_features & (1u << i)))
>> +		if (!(supported_features & BIT_ULL(i)))
>>   			test_init2_invalid(vm_type,
>>   				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) },
>>   				"unknown feature");
>> -		else if (KNOWN_FEATURES & (1u << i))
>> +		else if (KNOWN_FEATURES & BIT_ULL(u))
>                                                    ^
> Should be i.  How does this build?  :P

good catch, I sent the wrong one :-(
> 
> regards,
> dan carpenter
> 


