Return-Path: <linux-kselftest+bounces-28779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4969EA5CFDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E5C3A5408
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 19:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF411263C71;
	Tue, 11 Mar 2025 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsrbvN3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D081EDA06
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722504; cv=none; b=u0qIPa9VfmdtfMoTVxavLvQOzu7d9IbcRI8BIBCjHSboZrFESBvw+8EzrfKzVDsry+fAfiLJvqp8YdOhg024KAa9eSMq776ZI+UjsShhQhsZtNjDM/x5BTCEG20cLS1d363OMMhE2iJ+tBuuGDLCLIpxTg22O5DHG7WgnldhQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722504; c=relaxed/simple;
	bh=V8wGKSuG/67heF+aQk9MTGAzM0HmHSAIK9jMHT/3trc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfQWMFpIu1e3rxsiDxB9Ecj18bGkFDAWuvfvmkqMmpoXTS3Gi1f4sLk0SEmXFp9X6B2HxlrOuXVFWXS9fWYgXoEsPHJouCuszVwHUtvwcAsJmAr+uIemyIpCfXIcpf0Wl8mHCzZLZA5chMEQXb8aQcMIEDuoIFy0JNafnzp93Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsrbvN3A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741722501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bq/Cwq4gBqnqnmgfvCPLaJV5Ooqfni9+hYzA5Bx/ZoM=;
	b=SsrbvN3ACwpEczaYFeJHYXzIppA3eoL2a2oOXm+cXfRrqSczS1ZJWO2YV5RaH8FRKTgRbi
	pNQkpHYV0mMKN4uVwppcP2Cut2eE6DdWn142+ET0JRJS2GaXlx8FlDmtW7yoiSMsr11XzV
	sWLVDIX/yqrUUANw77nmisi6XC9m4xY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-UWeGmWkUNjqT_95xus9XQw-1; Tue, 11 Mar 2025 15:48:20 -0400
X-MC-Unique: UWeGmWkUNjqT_95xus9XQw-1
X-Mimecast-MFC-AGG-ID: UWeGmWkUNjqT_95xus9XQw_1741722499
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fc9861cso2399352f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 12:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722499; x=1742327299;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bq/Cwq4gBqnqnmgfvCPLaJV5Ooqfni9+hYzA5Bx/ZoM=;
        b=E4K9QHLHNDAu6ifUF1ml09NMA1Fo+rVy2ly1bTR2t8MwNkoUQC5vbmVikaDbDaSsWy
         HRK3musCMzm8LH6lkfcMHGqs7Knz+vS2hNDjqxLdhyENzrDqYPjUg6r6NCi9nNvNO1at
         KtWG+Uxi4tMp3GDwzZgG+L4JB30POIwYXVkaYhssisaQpvg2X4BqibirvER7BdXy2L/p
         CGC5FoqTUnMDMPb5Dz5HliEvIrfv6+soGiJ+lVCqYzCI29pt/le2LnFtd3LGFTvKpMaq
         hKTSyhlRAzrvegXaSAUbKtTsMc8XdxgebCN68Cc98PtbThgs+NzpUZrI7EKTNxYkhhv9
         KuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWziXP18xrIb3zpV6N41X7KF3iLYH69q92VdTIk8nXocFPzDlAHOZjn6e9YO4vhHDV7Z9spUGJCjblM9hn4k3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BEeU2XikJlEcc2F+HCLbQHJkxJmIQwkyHq7X/eYuipUm3Awj
	C/QKcD6YKZ0MMD5o5G3AoaOxGepjgdS7k4UJ5ePXZc/lBy1TLDIgVdYncgYSrd9Wk9RmdtGG0Eu
	56/hTWVimChZzfjcxc0q1m//PqtAGkIDDZESOWy2JgYQYSsU+uHSt+thJIgqvmc8Sfg==
X-Gm-Gg: ASbGncukacgj2zldO5VRQBjF/ZL8bOLB1eTu/iviQzVVAqtHZR5vohMj3lyxsUCeIoS
	fEEQ9Rqo6ShkbYxCy9UbD3knyq93UD50PrthLXtltOCYmNVJRVDQM5i27iJjdeuO/qq8Hor3uxv
	QsrR+AcPWfwyKVOwnD1er6MD9JPJ8yu4wq4Y6eF5ZlQ5eKaIu/uhN4AqfXVq7VAgfiEoIzpalDK
	zWP6tU3aqDon4zCzrv4TGQw1nWy3tXu1RqBzRVX2FszwRFF7vCsCBqIKQLZIIcjB6pYxSKgvxDR
	d3X89f7rU0cjEJEmiqvoQJM8yk74/X9i4xmqWUv0uGBb
X-Received: by 2002:a05:6000:4718:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-39132d29464mr18979170f8f.21.1741722499286;
        Tue, 11 Mar 2025 12:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXbw7q00lvP1bt0vHZTQDKUmkfV+45HTfk6x4dlKMXo5cKKnUnNZxgtX90v/yy4e+O8qbDeQ==
X-Received: by 2002:a05:6000:4718:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-39132d29464mr18979163f8f.21.1741722498927;
        Tue, 11 Mar 2025 12:48:18 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23d1d.dip0.t-ipconnect.de. [79.242.61.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01ebddsm19391570f8f.60.2025.03.11.12.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 12:48:18 -0700 (PDT)
Message-ID: <caaa80e9-16e6-4abb-b198-967c37aeb46f@redhat.com>
Date: Tue, 11 Mar 2025 20:48:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/cow: Fix the incorrect error handling
To: Cyan Yang <cyan.yang@sifive.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250311023730.56658-1-cyan.yang@sifive.com>
 <4a068856-328f-48ae-9b1c-0ec7d65dde6b@redhat.com> <Z9ASoTIastiD7utL@cyan-mbp>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z9ASoTIastiD7utL@cyan-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.25 11:38, Cyan Yang wrote:
> On Tue, Mar 11, 2025 at 10:19:32AM +0100, David Hildenbrand wrote:
>> On 11.03.25 03:37, Cyan Yang wrote:
>>> There are two error handlings did not check the correct return value.
>>> This patch will fix them.
>>>
>>> Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
>>> Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
>>> ---
>>>    tools/testing/selftests/mm/cow.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>>> index 9446673645eb..16fcadc090a4 100644
>>> --- a/tools/testing/selftests/mm/cow.c
>>> +++ b/tools/testing/selftests/mm/cow.c
>>> @@ -876,13 +876,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>>>    		mremap_size = thpsize / 2;
>>>    		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
>>>    				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>> -		if (mem == MAP_FAILED) {
>>> +		if (mremap_mem == MAP_FAILED) {
>>>    			ksft_test_result_fail("mmap() failed\n");
>>>    			goto munmap;
>>>    		}
>>
>> Yes, that check is wrong.
>>
>>>    		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
>>>    			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
>>> -		if (tmp != mremap_mem) {
>>> +		if (tmp == MAP_FAILED) {
>>>    			ksft_test_result_fail("mremap() failed\n");
>>>    			goto munmap;
>>>    		}
>>
>> As Dev says, this one is just fine. Leave it as it is.
>>
> 
> Thank you for the review.
> 
> I agree with you and Dev this is just fine. The reason I prefer to modify it is
> - usually caller checks the return value directly and "tmp == mremap_mem"
> should be determined by "mremap".
> 
> If you still prefer to leave it as it is, I will send out the v2 to remove it.

Yes, leave it as is. This does not belong in this fix for a real error 
checking problem. Thanks!

-- 
Cheers,

David / dhildenb


