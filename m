Return-Path: <linux-kselftest+bounces-27671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A14CA46DC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DCE188D71D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964FB25D53D;
	Wed, 26 Feb 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgNtw+4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846AD25D539
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606090; cv=none; b=VjDQzf8YHz+gbqyCapZt83kepY056py5B6S2YEsCCn4TfLnYpSDdZKRY6QvpawS7xuLtLXGd6L1k7i+MXmxhTdg51zIv01VFKeiM588BFu/fkvdo6GZdAazajvEgaev6HNsTYfTMd++9YQ4mm/MZDNQqtZ7chYBsGThmlrHvdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606090; c=relaxed/simple;
	bh=Di9FYpPtVfl7GsOFof37nEkaTPeYYC8IFNc3O29zZBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKCKz54+QJyDP9G2RKyhm3NR7QQyJB3dMjN+TW4OLI6eU7EoiqklOl5tdJ0EWyJ1Cq8nfCmgQSkFp4JYk55Rn1OZUHW41SxthKTmJ5UkEdPTsjwl7TWCdsECWbv0RoktuHdVxHuzdFS9Ef9N2GilZvvgw7rpnjLnMXOfr+ZBhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgNtw+4H; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso2696005ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740606087; x=1741210887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGewUZ9tiTuQ/iU86a6R/FdqPI/FHFuOTv+IuUM0fSI=;
        b=EgNtw+4HYem2fMOMePu2C/PlLFff29/G4o4Xd13ceHo70FesJOCOcdhZUdhDn6gxP3
         HB/xmEcQmsssCccSgTG4sUEWKdSLaqB/KpS1HgB2Js9dvBGtPLdMI+azSqx6g8zn7pv0
         eZRIXMZoP5MyXrHC78aogofKGm+47rgefZTtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740606087; x=1741210887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGewUZ9tiTuQ/iU86a6R/FdqPI/FHFuOTv+IuUM0fSI=;
        b=SNOA/2Dr7lIiqMjPQnlBqqFpcgg/mwfUgTCdT5oQ1KJ/oflWM4uKHtHVpIMDKnouQg
         t+6XC6TSgEVypchci5ttWvFOcdcs606SZIU5rc1BCzQ4oaMtYV98HMTrqPGeUOwqv1Qv
         ftEcXqy+IeS67QAzS8bJCRyATRqrJASVoJRb6NdUAbRhMR3CyOfznc2YgqLXiDPvmpn7
         PubV0lXE703SE+r8vsmcohEHT1pe8CCDf4xJ85Kw01R+xQRhmIQJ5VTHfIl4XG5k3a2l
         TxqU/T278JAvyem74zQzExuOlAD/pMYcORR9u6iPeNxBwruW8nDvgqeBODAOM5Q92hC+
         Ni+g==
X-Forwarded-Encrypted: i=1; AJvYcCVUHFvZxV8qwF9hKxPLrI3NBbHy9tK0hWPh4VAuwPAm/gkROYjDhp+c9DijBKbHSneH+8qA0VI8xPWOKnL9dbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29BnylCQ9d6zqlDE2jfjNGC1BV2Jb3tAScERMFOQ8+SyTh576
	JWp/mDd4GJEp98RIp8C0Mz3ApXNi5cd+4H86tIN5Lq9UPiGi2Vvb2RTVt22t5z4=
X-Gm-Gg: ASbGncvUu5gpwBoJSCnGZgYTnb+SqV1wet/X7qrl85m3ZwZPxKZOWi1tA1rA0kGtOee
	BapTHXCqtOLUacY30fiAsgFj+3Sxcz0qQrVyTBrtkU4b/x/KrRtVpzasP/kkA0HXwof20pPUk09
	X5dvtyjvdaw56fpZRJ+++6k3aQ16N2Bjiq6YGap9teAM75hv/rlbDoCxTSzFuErRxoDBZO1eJfA
	FX7SooKIxl7/VP8eFiJHhgwrCPLKud/OPWmspWr7P0jn6vRxZKB2O5m+LaIhTrTEnCLzk/4wRCr
	A+MPhwV8oUAQBA8VIP4k+pYyLBTanUajpZWQ
X-Google-Smtp-Source: AGHT+IGEnHXG2qu9LDh932QF8VC4PSeuGzxYdyTHYY6hisaHR02G7GnV2uKJV/Dq51cIKq8C5TdmhQ==
X-Received: by 2002:a05:6e02:1c09:b0:3d3:ce83:527c with SMTP id e9e14a558f8ab-3d3d1f140cdmr58022385ab.1.1740606087525;
        Wed, 26 Feb 2025 13:41:27 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f790bcsm38180173.126.2025.02.26.13.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:41:27 -0800 (PST)
Message-ID: <0758d73d-98b7-4f9b-a3b2-001d69eb949d@linuxfoundation.org>
Date: Wed, 26 Feb 2025 14:41:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: Fix bad array reference.
To: liuye <liuye@kylinos.cn>, shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250206021239.51897-1-liuye@kylinos.cn>
 <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3b51ae45-4dd4-4238-bf3f-3cb4d263eda4@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/25 18:31, liuye wrote:
> Friendly ping.
> 
> 在 2025/2/6 10:12, Liu Ye 写道:
>> dir[directions] should be directions[dir] to correctly index the
>> directions array.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>   tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
>> index b12f1f9babf8..b925756373ce 100644
>> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
>> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
>> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>>   	}
>>   
>>   	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
>> -			threads, seconds, node, dir[directions], granule);
>> +			threads, seconds, node, directions[dir], granule);
>>   	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>>   			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",

How did you find this problem?

thanks,
-- Shuah



