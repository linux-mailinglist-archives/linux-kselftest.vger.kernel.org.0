Return-Path: <linux-kselftest+bounces-18131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC197C985
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F65B1F22D00
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF9F19DFB5;
	Thu, 19 Sep 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xdswiPZ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C419D8B4
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726750308; cv=none; b=J8Xhleuu2IZS18aqjFIwQ7avGGCLV9exSHNvI4tP/vyd1jBZyleDba/zn9gC9Xa0RbRWlCiWKyjq2VuPwldaGoyEoCjOD6/0YCqxstqdNXS5TtBJvJCfT6+XMW88lWxFEM8tO9g/TTzfjYHpQG4Xdlh68CpqzOPaqZCfymmJrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726750308; c=relaxed/simple;
	bh=SlJmwhGl3SrJKXIOv4Gm2FmJKvlW3Kv5wJXm0Ihsfbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv3Fxx8CDx3pdwyotjiygZoKTcJq150zU6tMWg0DLReUgNndJbMGuRXR58ueR0Veni1osD6zN3XwiYAlKxg/AZwkt3IaPPQinLxyBgxr4deBtIpeyMTzmECXOot+8e241Cgg3aSduz/2cZ+YHLwGcf/V6WH3nLryvdNDPchnvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xdswiPZ3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d3cde1103so104210966b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Sep 2024 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726750305; x=1727355105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2ods2eZT8RMxJfTBuByt96hZQnySzfhNv8GJfRYckM=;
        b=xdswiPZ3zpI4ykYr/NoPyiNg5Cjuvudh40FXhFvATIpMm6YKJld59brEhi+RXEsXBU
         9sE4iY9T2hzc9sttavp15D4N52vagV25k3I3/uHzb+Sjt1/yePPSTpqAV5VIBcbxHDfF
         pP2fOht/6DLjwPkXmKIXu+RhrnjRyMTm4sksHN8BEMcOwLaTljH0BInRIJcgnaoawNhR
         d4fIHeD2fMx19HOiy1niyZXm2LF81eXuA/MN1TItTniMBmHQF5KP5uRYYOP91HkVw8e/
         lt8s52rmFKzO9ZFFyityDtvoscTzVMjbDyiNhg9p013aFAcbg/b17cqz9xxKLoOZ+Jfc
         rugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726750305; x=1727355105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ods2eZT8RMxJfTBuByt96hZQnySzfhNv8GJfRYckM=;
        b=vugT0wLPKcKNDJNJC37DbefCY1kGy2RSRfZB9YwDx+g93SfDwgr4LD/xmaoAbX9hBz
         CMYt962FvZg8CxKZXnmD3Rr9T+iBcTKyiSCSv+x1YNt1AEuzrvsUdocFhBI5hC83kJhQ
         QGqz8WSf5O0WLzYbtfJRG7i5Nik7jzFUQFsAokjB8kGNYWErlGXIftqf1NxnDwCVjuTo
         YxmLwX1FnMGj4u8+YG5rB9oPIEgD5FXP8JYbp143Vc5CFopnW00u+K6m/EPgXUasx3/5
         sJYh2oh08U1t45aJl7Hn/vuqpT/ZAb1rTjx8gke49F1xjpnsk0gbLoX45X3ZEIKK5cNX
         AJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSJZ2dbhvqwJPA3O21Md49ypmPKLPceO0sd0TBThPaBM7H5U7b2IvZdAEBlXz4aLVJvC+PPH5U6ghS5ydr4ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PS8qraKXcV7LyHxgmuck9qspL/TR+hOPSpd9Gd39MMnSOYmb
	Nhh8sSBxjCHC1jf/1b9Ozo+pC6jVqntuIgQN5GgVkIfV/Ubh4tIRW47f+W13ahOLVWIytFaz14B
	u+Ve06w==
X-Google-Smtp-Source: AGHT+IGZqgve+KamWKCTyn5ghHOmYZoUojN3YplaJpvEJ6WqeTRtpjQs7A0Ut18Ni9wirgc/SkN/uw==
X-Received: by 2002:a17:907:36cd:b0:a90:b73f:61d7 with SMTP id a640c23a62f3a-a90b73f63bamr599108766b.42.1726750305479;
        Thu, 19 Sep 2024 05:51:45 -0700 (PDT)
Received: from [10.130.6.89] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610968b9sm718971366b.5.2024.09.19.05.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:51:44 -0700 (PDT)
Message-ID: <18d61c52-be6f-4ef3-b020-d597ba7cdaeb@daynix.com>
Date: Thu, 19 Sep 2024 14:51:43 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
To: gur.stavi@huawei.com
Cc: andrew@daynix.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, jasowang@redhat.com, kuba@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org,
 virtualization@lists.linux-foundation.org, willemdebruijn.kernel@gmail.com,
 xuanzhuo@linux.alibaba.com, yuri.benditovich@daynix.com
References: <20240916071253.462-1-gur.stavi@huawei.com>
 <20240916080137.508-1-gur.stavi@huawei.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240916080137.508-1-gur.stavi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/09/16 10:01, gur.stavi@huawei.com wrote:
>> +
>> +static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
>> +				       const __be32 *input, size_t len)
>>
>> The function calculates a hash value but its name does not make it
>> clear. Consider adding a 'calc'.
>>
>> +{
>> +	u32 key;
>> +
>> +	while (len) {
>> +		state->key++;
>> +		key = be32_to_cpu(*state->key);
>>
>> You perform be32_to_cpu to support both CPU endianities.
>> If you will follow with an unconditional swab32, you could run the
>> following loop on a more natural 0 to 31 always referring to bit 0
>> and avoiding !!(key & bit):
>>
>> key = swab32(be32_to_cpu(*state->key));
>> for (i = 0; i < 32; i++, key >>= 1) {
>> 	if (be32_to_cpu(*input) & 1)
>> 		state->hash ^= state->key_buffer;
>> 	state->key_buffer = (state->key_buffer << 1) | (key & 1);
>> }
>>
> 
> Fixing myself, in previous version 'input' was tested against same bit.
> Advantage is less clear now, replacing !! with extra shift.
> However, since little endian CPUs are more common, the combination of
> swab32(be32_to_cpu(x) will actually become a nop.
> Similar tactic may be applied to 'input' by assigning it to local
> variable. This may produce more efficient version but not necessary
> easier to understand.
> 
> key = bswap32(be32_to_cpu(*state->key));
> for (u32 bit = BIT(31); bit; bit >>= 1, key >>= 1) {
> 	if (be32_to_cpu(*input) & bit)
> 		state->hash ^= state->key_buffer;
> 	state->key_buffer =
> 		(state->key_buffer << 1) | (key & 1);
> }

This unfortunately does not work. swab32() works at *byte*-level but we 
need to reverse the order of *bits*. bitrev32() is what we need, but it 
cannot eliminate be32_to_cpu().

Regards,
Akihiko Odaki

