Return-Path: <linux-kselftest+bounces-24112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61662A06F36
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 08:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05FB3A32A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61570214A61;
	Thu,  9 Jan 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="yI5QcCUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC32147EE
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408519; cv=none; b=N4WzknuBXtdi0Ed5PZ/QjwgrkHHu0OryyOt1N4uLwb1rGN0yNgJX2KEzyoSzEsTZwYWrmwPaZGozaFU9VFnT1UxVBE75w1FVO3s/3OKktMMJCAvzKzLPwabSQ6j24SbhBlv01ICq7CxznuB0/ygrbgLLwJlCUvBkvXPIOfGN64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408519; c=relaxed/simple;
	bh=Pl+1xEqrW1IF0EiFRc252FTvX3vzsbZHF/HiOa6V3hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSipfA62oSvB5UanapJtTFAedqP7rtP2l2Wle5ocB4b97acJLQfXFgdenwNT2ESvnLcV/+dvUfQsnKFqdLhKQWVmZYlfmRcb5XInlaiCylxe0loIVUbfpVZXmJWX1WfsyWNuE9/JZ2PGHwC1fLpNF7l8D9zfETRq+0wV9perbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=yI5QcCUO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216395e151bso7338435ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Jan 2025 23:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736408516; x=1737013316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zujq2FV01D6C2KPe0/EF8xmEzpLBI/t0RD3pI7VCDdo=;
        b=yI5QcCUOTfFkCRIKaIrEraVpL5GKdr70Cbw2jy9TqWfvH1hbeqhewj9IZbX+3l5SUf
         KX0TXLjr6qMoQkinOHj9WqGYDJrszYPCBzrhYESbrvuq3t6Kl9E4KY0hqz9/edqLPpD+
         IM1ItO6u96gnCEr+FOh4jbMp2XBjwZiza2auO91abI+WEuniKN6SN6mj28oX/kN3ogNs
         O1/1NKGsMMmVR2K30TpKU/y+FG8GGJj02QmHFDGUcuBzrWp1C7gu84fZCSIQHxuxilUD
         0H3NeKDMwS7SJUJL48M8qUBjdHG/PDRdgydug4BAtwNo60jMOPxm1/4QQ9COGTPuL2IF
         SgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736408516; x=1737013316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zujq2FV01D6C2KPe0/EF8xmEzpLBI/t0RD3pI7VCDdo=;
        b=lHHcwcV5W62xi83w/TctTJgai0VpY7qrRemmCRe7bTw8xwsXyWBIQE1Zmgo1J7hD2Z
         g7dIumysEWMfTG0VkT8g+ip81q2j6rCyaQVD2LTqbs/FKc5+jYQG835NBFKOGhxHRof2
         69UapXMafMa/9YW5YLwlM7x/cOnC0KcxEVKFi7snQYfYvHlKw2KBeaORq0V9EF/jiiek
         tA+vxtKWvoqY6wtLdYLIQCBcKILXGNDOfZehYq3cjHHR/0/Ygf2EtVxm/yB4ugF1c0YQ
         Ymn3TQFtFZLVhxNnq65/Lk6bBqYRlIE3r4NaiTot27ZUTmYlRSMq7QLfH8W2+QJpASPY
         Fuiw==
X-Forwarded-Encrypted: i=1; AJvYcCW4xS3L6YAEG59GHJNqRd+cZaeKNmzs7It4UVBwW1cqfqEM53OHWdZhIMd7CBpD9oBRehzorMurwqEvNmjqPb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjoqQwb88ftH+1rswG2HT0gO1CfAbIrZmn/GqFZl21nCVrRopu
	VbssXgWbM4wStteGPvfoIXBriWUswrhoTXVMgb9IwW8SI0XhPuUaftElPO9Sk+c=
X-Gm-Gg: ASbGncvRtp3Rpg8+EmaJOfKX9j5SUnifI5K4ko5y3c08Okru4pyBnxpzXEAQ6Urc1OT
	AWSPrDK5N/+q8Bd0aaI4VwHh6VOczOq8zuthgKWbBRDalt9Gr2CtuGZ1DTriB0+MXV7AK3Zc4wJ
	AiP/i4cOCLMfycM/ECCcYJxoEo/9dnKr3VEMBeAXYtbjSJZmb/4MLDop3d5eNWL/71MGWNJ6ZS7
	AbmiFs3OTzAVMjRCegwqP50FFqqrDetvgpQmL9/TWT31lP8AGDKPP/404/XdNv4tPg=
X-Google-Smtp-Source: AGHT+IHoQ1/i8R8+7m2WyjiW1QZh9ruYZdAVL4zxUuyhPIV5VRkeFn1oW3Ykol5jTRSqrVxVwBQ5DQ==
X-Received: by 2002:a17:902:eccf:b0:215:a808:61cf with SMTP id d9443c01a7336-21a8d6ca6bbmr42525445ad.25.1736408516440;
        Wed, 08 Jan 2025 23:41:56 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d44a0sm338516125ad.165.2025.01.08.23.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:41:56 -0800 (PST)
Message-ID: <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
Date: Thu, 9 Jan 2025 16:41:50 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250109023056-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>> tun used to simply advance iov_iter when it needs to pad virtio header,
>> which leaves the garbage in the buffer as is. This is especially
>> problematic when tun starts to allow enabling the hash reporting
>> feature; even if the feature is enabled, the packet may lack a hash
>> value and may contain a hole in the virtio header because the packet
>> arrived before the feature gets enabled or does not contain the
>> header fields to be hashed. If the hole is not filled with zero, it is
>> impossible to tell if the packet lacks a hash value.
>>
>> In theory, a user of tun can fill the buffer with zero before calling
>> read() to avoid such a problem, but leaving the garbage in the buffer is
>> awkward anyway so fill the buffer in tun.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> But if the user did it, you have just overwritten his value,
> did you not?

Yes. but that means the user expects some part of buffer is not filled 
after read() or recvmsg(). I'm a bit worried that not filling the buffer 
may break assumptions others (especially the filesystem and socket 
infrastructures in the kernel) may have.

If we are really confident that it will not cause problems, this 
behavior can be opt-in based on a flag or we can just write some 
documentation warning userspace programmers to initialize the buffer.

> 
>> ---
>>   drivers/net/tun_vnet.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
>> index fe842df9e9ef..ffb2186facd3 100644
>> --- a/drivers/net/tun_vnet.c
>> +++ b/drivers/net/tun_vnet.c
>> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>>   	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>>   		return -EFAULT;
>>   
>> -	iov_iter_advance(iter, sz - sizeof(*hdr));
>> +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>> +		return -EFAULT;
>>   
>>   	return 0;
>>   }
>>
>> -- 
>> 2.47.1
> 


