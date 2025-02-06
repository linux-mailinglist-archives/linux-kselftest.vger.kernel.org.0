Return-Path: <linux-kselftest+bounces-25889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F4BA2A19F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 07:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E921681AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 06:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00821224B11;
	Thu,  6 Feb 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="F0mlw8j/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64A22257A
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Feb 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824816; cv=none; b=XP9JOAwMr6x1Cqs7lC6zQhCdOqVUP4MFxghpKn5UeUNI4giR9M+Coy4OMFalriKwdYUbmM6HUKwuwVqK1ylGW7P5HEgoL46l+EYNCQYC6ghLPAQtMP47NcSdADN9o+XUEq6679+Ouvp11oW7lPWhXfmRuGR6ZQk271Z4vmU89Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824816; c=relaxed/simple;
	bh=QFOprhmkYAckDmLpj8OaQpl0QIRArOwxk2YuENHmzqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGXWu05JoytkegCVectR9xDp/efO6qh0siHXOXm5T9sqmh537lfaz9SKgmjlfH7PDkTIA/YkvQhv9sdGHEzADjUz73r+bc5A8ILvLiDmm8Cc1jXdzNVQ6W4T4AC/O3vElbvsO6fSMJtj4jsUAqvoq2s4dv0XsTZpbdEqf28j4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=F0mlw8j/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9bd7c480eso1012717a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2025 22:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738824813; x=1739429613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfPzJgqGwInu62D/JbABqcLSTAUY1ivE7x32/lUlB+s=;
        b=F0mlw8j/AG0MKEBcdJHMFfXXcLJ0ZHP9/2K6J65yteNpK+qdNKxi18sDLlaF6onQnk
         7c70gicAMlBwDxssr+lPqXbLewbQ61RYZzGZA9AY1cZ3ojHEeFqPVvWp2W6wq6PdJ2bE
         dhHzIGyD5t5vvHpYQ2LULeZ9rPFAIDAly6LNqJ5wLvylIZqJcjCrNgEQhbCKjwhNjzji
         MMKSGqxhTzGYnejgMhOTdphd7HLFgxNBm+LPWbpTPy2vL60I1iVcWsL+XvNdoH43xudi
         lGe7fCgaaruH+etviHr/ZmC0t4qH7k5F/h9dOxCCLMbehoxwPncy/r7dWoQ1vnfqnb7E
         DR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738824813; x=1739429613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfPzJgqGwInu62D/JbABqcLSTAUY1ivE7x32/lUlB+s=;
        b=iw3BdBcwvYW2FPLZG6TPXPXyt/i/acRaGOTh0yPHyqTsGUuEZsZQ7ByxqR+32uJ9jI
         vaxrsUYB6xQaY/mo0dZ4vTUGvVNOa0jWv/ZkYogDbnyvFt8Qb7GmyEOg1jKkTeaNLgAB
         T5YHHHhp0c4aO9KESarOtkAXMDKdnhipL9YHa8ankpuMMrjSu/Ud9lNmpWjJfHxudVUy
         n0NhYku7JTgxfMi8bKgX9qaUH42cmjQEZJJKBTkwxj1k8+QK5HNcZOwrAYLUA9qg7sxg
         +0qVZ0Y6rFPezvGILYMngevNojmHdeAEFVRhbPpwUTRnHyJei+q6lTe7h9MpV7N/oK4M
         FFOg==
X-Forwarded-Encrypted: i=1; AJvYcCXvE8gafYsqjYiYeenXigR8IPD9AGoyTgQYOmnF44hvo4qIfcAoWXX60p8G8FJAPyxXY1YHFNQzohhoACFPoN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUnnRqxjvVEvPapjGqi1bAR54Vt7CEeMCyIkV59Yrs9AriOZs
	tdVuEAUj4YotMhr38YaNUiUkkMNaGfAH2I8oCGzjOX6+8RKPw+oHnoFOvkvb2YE=
X-Gm-Gg: ASbGncvkv0wcV4KbdTIJUvvsae4MaJhdlKJ+B2JQVG7c5E2ddnVaawreFYQ4jxIUZcT
	ND15zsnqFejGcJTfgzXoVXGRUuvw7yu1HNvrAkVyLWP6QTdCIwT/QcIKaDjegm06DcFJDxMhN/0
	gPOfCJuN46tc5y80E+gcMoH5OYW1y8pr+KCmReBrsy0EFatVFL7kLlOyyGvhXu9rvTtlX3kgtIC
	42aQNDepb5ZRmUemK47AT2ATsOoUSsDiOdblvWuuQCBEApNA/O6iPO5rWCBA/sBEu52s1DLnOsp
	3nN1wU25DIUZQKHc32cz2XawJE5l
X-Google-Smtp-Source: AGHT+IER8psjFE80ifTWvoXn5WHFoV2OjIRpn8B020yOLPR0qnk21Bx82Mdy+x+4gwZSwLApBeX7OA==
X-Received: by 2002:a17:90b:2d8e:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2f9e0767573mr10783588a91.12.1738824813210;
        Wed, 05 Feb 2025 22:53:33 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e24559sm2800958a91.31.2025.02.05.22.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 22:53:32 -0800 (PST)
Message-ID: <12dbfa5e-32cc-4355-89e4-6c1cd4e12d1a@daynix.com>
Date: Thu, 6 Feb 2025 15:53:26 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
Cc: Willem de Bruijn <willemb@google.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
 <67a3d2efbba32_170d392944d@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67a3d2efbba32_170d392944d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 6:06, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
>> future changes easier.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> ---
>>   drivers/net/tun.c | 26 ++++++++------------------
>>   1 file changed, 8 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..452fc5104260fe7ff5fdd5cedc5d2647cbe35c79 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -298,10 +298,10 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
>>   	return tfile->napi_frags_enabled;
>>   }
>>   
>> -#ifdef CONFIG_TUN_VNET_CROSS_LE
>>   static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
>>   {
>> -	return tun->flags & TUN_VNET_BE ? false :
>> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
>> +		 (tun->flags & TUN_VNET_BE)) &&
>>   		virtio_legacy_is_little_endian();
> 
> Since I have other comments to the series:
> 
> Can we make this a bit simpler to the reader, by splitting the test:
> 
>      if (IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && tun->flags & TUN_VNET_BE)
>              return false;
> 
>      return virtio_legacy_is_little_endian();
> 

I kept all in one expression to show how different variables are reduced 
into one bool value, but I agree it is too complicated.

I'm adding a new variable to simplify this. The return statement will 
look like: return !be && virtio_legacy_is_little_endian();

It means: for tun, whether the legacy format is in little endian will be 
determined from the tun-specific big-endian flag and the virtio's common 
logic.

