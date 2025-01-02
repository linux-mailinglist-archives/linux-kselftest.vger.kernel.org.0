Return-Path: <linux-kselftest+bounces-23831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E5A0007E
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 22:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108641883BD3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 21:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7431B1B85D2;
	Thu,  2 Jan 2025 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqaxXsTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91291B3953
	for <linux-kselftest@vger.kernel.org>; Thu,  2 Jan 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852789; cv=none; b=V70+QzTiAEbIilX00KOGWfanc1fPEBEkmUqjwQ7X6ImddPSs+sSNE3X8Mb66QvnSiCwQ77iG3vuScRORYqaMQOYADIInqdHVgFaT44GqhcQ6dUQMl1eM0Km0AsKcClgzk4/2Tw/RW+7YUPp+UsVIWmV94gJLUAtnS4YD3ErMMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852789; c=relaxed/simple;
	bh=DZpepdt0D7BoD/2lYM3PLrGAdcHfwsBLNF7IqjtIIyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zd+19rdksiIN2rLFsC++D7vNt2JR0U2x+nJ+1KZjJtYyLgOZX58XE6765FL24Qvj4akUYXUBHZPffwIwDB9+5ML3AP8XRjcxriRh4mK5mTBAwR8wgcMaPghI4R8LcxJcF4li7EXoc08pIse0deoVXRgN2vAT/Ildeht16TOfTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EqaxXsTq; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e39439abso440587139f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jan 2025 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735852786; x=1736457586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqSBiemQ2Bz4aDXI0PsW2FV8+vQOaGGeqetFAobMaIk=;
        b=EqaxXsTqULSrS7J8oANbp/GqTm4s/BidJDrHftYoipDxTVZX7ksfDnM3W/oula570Q
         wmB5QYmHH7UWxz8Q0uyxxA/xUZRfK4R1gLipbek8XddV2vLxkwEzDj6yv/IdQbksqMjQ
         bYWQcxfMv95GWUgSmWNKy4A/42/uUcW4nXv7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735852786; x=1736457586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqSBiemQ2Bz4aDXI0PsW2FV8+vQOaGGeqetFAobMaIk=;
        b=F0DYNeevAkIa6RdnQMJ4IN77yhmnChtHpHl1zb2h/gGplPzVWmSn/r5LKKGgZr9j23
         tFNJknkb4buTG0RLogIlxOp51gAHWFtcz6ShloPA92TueyxXlywMFbQineh1kgQUw4Kf
         mcIEp/n2kD2yi+qECSS9h88OV5KW+2B7X4Je5w4/PDYkDQCeAJRGh64scGUjH/8naaqq
         oG5uKlmG9RSOtoo3CLTyMjHAhO4GWVCd2Axv990DMnyQ7p255mlkU87jr9eETZx9sypX
         aiNw6TrkJMqd23l0d7tCXXt7wof0qsnfasI38EHCZnAUAguoCtq8aYEH3Eb18wllAcFT
         TTwA==
X-Forwarded-Encrypted: i=1; AJvYcCWK+HjShsysEPeob0RHWkt4ICgWblDH9hW9zluOZXDdO1JwXETO5iejgdQNPtxH6sPTMTGvRAAisRzJ+oTI0+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKbmZNvWdU3XYSwi6cvfNZ7ENRGqU2dOpx5APjKIBGm2vkrrR
	sTTSJDvrNHvGHujr2ZWPZy5WhDfjR5lpnQBkZAx79rYSVRccOahcus7IIbvrTuU=
X-Gm-Gg: ASbGncv65RjAhfRtMsl8+PHPmqgCBUZRvmmoyW6Zwu7rqL+HIVug6gkyU3s/7jC0DKQ
	GBid/3Lpvx4w1XOQwCWcMUSGil7cfZs8+U0BiQ9bI1KTogKmpS50mNh3IvyH12uZGSbpF/I0HuP
	O+Pbk4D4uptjGflkeLS5kStDSE+XJhHA3P8Cn1DAaSIdGZq6SHEvL1o79VH2aBk2RNa5fZLdh7L
	4XqRMKCynSjN5NAkSgPYhuoNxe8mibS/GF7SFdv1IqitEa5JDdUcBQ3j32VK5GALfly
X-Google-Smtp-Source: AGHT+IEK/JzaNsJZOqhdk+7MFsiTwmma6S0mMV1zPf9tGg8pwTfMuDUpDINXDedjU/9t6jSnmAXLDg==
X-Received: by 2002:a05:6602:60c3:b0:83a:639b:bc44 with SMTP id ca18e2360f4ac-8499e4ee011mr4149299339f.3.1735852786669;
        Thu, 02 Jan 2025 13:19:46 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d4253c0sm686345539f.0.2025.01.02.13.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 13:19:46 -0800 (PST)
Message-ID: <b5ae70c4-055b-442c-be91-3430367f842b@linuxfoundation.org>
Date: Thu, 2 Jan 2025 14:19:45 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ring-buffer: Add test for out-of-bound pgoff
 mapping
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, aha310510@gmail.com, eadavis@qq.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241218170318.2814991-1-vdonnefort@google.com>
 <20241223220504.4ae4adf2@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241223220504.4ae4adf2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/24 20:05, Steven Rostedt wrote:
> 
> Hi Shuah,
> 
> Care to take this through your tree?
> 
> On Wed, 18 Dec 2024 17:03:18 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Extend the ring-buffer mapping test coverage by checking an out-of-bound
>> pgoff which has proven to be problematic in the past.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>>
>> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
>> index d10a847130fb..a58f520f2f41 100644
>> --- a/tools/testing/selftests/ring-buffer/map_test.c
>> +++ b/tools/testing/selftests/ring-buffer/map_test.c
>> @@ -233,12 +233,18 @@ TEST_F(map, data_mmap)
>>   	ASSERT_NE(data, MAP_FAILED);
>>   	munmap(data, data_len);
>>   
>> -	/* Overflow the available subbufs by 1 */
>> +	/* Offset within ring-buffer bounds, mapping size overflow */
>>   	meta_len += desc->meta->subbuf_size * 2;
>>   	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
>>   		    desc->cpu_fd, meta_len);
>>   	ASSERT_EQ(data, MAP_FAILED);
>>   
>> +	/* Offset outside ring-buffer bounds */
>> +	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
>> +	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
>> +		    desc->cpu_fd, data_len + (desc->meta->subbuf_size * 2));
>> +	ASSERT_EQ(data, MAP_FAILED);
>> +
>>   	/* Verify meta-page padding */
>>   	if (desc->meta->meta_page_size > getpagesize()) {
>>   		data_len = desc->meta->meta_page_size;
>>
>> base-commit: 61baee2dc5341c936e7fa7b1ca33c5607868de69
> 
> You can ignore the above "base-commit" (I don't have it), as it applies
> fine to v6.13-rc4.
> 

Applied to linux_kselftest next for Linux 6.14-rc1.

thanks,
-- Shuah


