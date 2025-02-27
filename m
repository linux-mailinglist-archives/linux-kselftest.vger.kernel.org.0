Return-Path: <linux-kselftest+bounces-27729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8342A478F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 10:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFE7A52C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C61227BA7;
	Thu, 27 Feb 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="n6ytZsN9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD0227B95
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648116; cv=none; b=JGJsKeIx20+3wEQu/9zH1ETMFFtCfMQH3HRhFxJh3yOsa65hzImV2jI9ZhIdc+9vKMgjLcxUcXsXrrth9nmZBxyPGhsgbrGAlvoYBt3L+hhXMfMLQnoUCPTcAtQ5YyryfWR5qkv+BGPwvs3A+WyrrMaIszeHFnPrr/IcpJqS4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648116; c=relaxed/simple;
	bh=qJ6d6yyVEiOIzWKAFqn29zVljBDyaAUEI1J5TgXK8MA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ofGund55dNOqWbUOtK7HKsoOz4d1dq2WOmpc6oJuiKfzJLODC/I64LROwbp1o7Tdbk1ybNVp1Bt07PVlm/lePV9CbNTKuPr2Wm8jL34yEMYfVMY9gxFAhLmIMN9N7I3YXS/fWWjdn0lfDJmll0zdIscz9tzJ2IzVoEMGroGazYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=n6ytZsN9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abba1b74586so100737966b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 01:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740648113; x=1741252913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QGKuyOFdmCrFZDueE7tG98lW1JYRuqGd31pjDPdwi0A=;
        b=n6ytZsN9bCZOytA5VLbihqdX0iuFDF1y6DcGq8WceZddRdPOc33d+6PLBb+Ej454Kb
         GfGyu2CNZ0u03yzImi5gZNQ4bRcqxQ5jlEa+nwhtYt0MXWZx8d9HLyEomoigX2Wmg9jr
         YFOFpSaO4g7ZqUozXLMwYSQPhYOeZbJjGTIC11m2IHsqMwgaQo4gvh2FWqaby4AuvltE
         Jk7Qo5bWETupQiI75zzai2Xk/JSkO8vGGXKflj7iW+kYVtD+wBmhV9RKbPYV8g5p7w+d
         4z8H1xAFYOmlURRFX7gBKXHv2RsTGPfBojfdgq2mDGPmwfCERSs+3Tlg9t0Bv63fZooD
         ljiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740648113; x=1741252913;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGKuyOFdmCrFZDueE7tG98lW1JYRuqGd31pjDPdwi0A=;
        b=pa0s96ZdntFZ/NXCnUmpQ/fTyrk5k0lpkBNOvmymSh/5cBBmacAFE7t1CuShWKqgVb
         Z7byYIMiVbrvfQSvGBHuFsiBMOpKMQHeXDfRkOa6K5D8Wa7dZxe9+TasTNJw3n+2i0jb
         7IEmEyxt7EjqMAVQ1g1o6wdNAhB/i2Q1DKZb0TMpfC+WkyCzsWYmzc92e7lU2uFqy/DE
         OOCZcZoDwGT8WjqacKl+K9778ZgDuRSWVgfsNWaSvi/4TryT/0E0iMUDCKbP61eONOuZ
         zsawn/SQIl1uib7t/a1zv3ulxZmqVt9DQopDCL7qTZBgjBwoULhBer1TNa7b2qK1uIGF
         joWw==
X-Forwarded-Encrypted: i=1; AJvYcCVvs4htNOaUP6M4WMigt36A0q3hIjcOAaUG0pzM4UFwxozJ3et/LOYVBtc43kN6hUzHCVi2bxER2QgtXe21WyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3U8FF+4ERt1usqo2FaZBIMmSWPgWEn2XcBtXTjIa/SjgArzs
	p38lnPsHgvf3Msu2A1cBJszV6fqWIQ6Xr1hq+Glwq3Yhe4AJ+fT9TWfkxAihL7M=
X-Gm-Gg: ASbGncvBk6E5r656SdBp9ntJEJ/JwG077Odz3pKLsdNNAd0ObTQzz6UaEmF9udpWqbk
	TxjqB+uK+AM3qflwlQi8FeoYjqn3IxmRzStucDbJeJxyu9rfyFXemmvLb7orzT9iXl3kjiuOTUq
	HRKkD+lWSsKQHNEDZmIBOGPe0k42BPO7QEMekxGmTHPitx5eE20Bu0RcCIP5s6SPu1V1n/vRi4Q
	TLkHDEahLLrtPmlNeT+ngWCk2f+YOt1tR6suebs6L/kmmcUy7556i2JMMqMWjThCEGOL/X3ayVD
	9oNRIGKG4ioLrc3+lXZDD/Mzx9n0wxb2JP3h29vZXOzUhJInIZTj5Qlb4w==
X-Google-Smtp-Source: AGHT+IHD+cNx6yl3X1EnkFEtFKEHouxEwyh4QDe/AW5lHxTVz7/szNt45pitj7P8HvFW9mO2l6DKdg==
X-Received: by 2002:a17:907:7fa3:b0:abb:b12b:e103 with SMTP id a640c23a62f3a-abed0dd817amr1443127466b.34.1740648113102;
        Thu, 27 Feb 2025 01:21:53 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6e9c25sm91516366b.108.2025.02.27.01.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 01:21:52 -0800 (PST)
Message-ID: <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
Date: Thu, 27 Feb 2025 11:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227083717.4307-1-liuhangbin@gmail.com>
 <20250227083717.4307-2-liuhangbin@gmail.com>
 <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
Content-Language: en-US
In-Reply-To: <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:50, Nikolay Aleksandrov wrote:
> On 2/27/25 10:37, Hangbin Liu wrote:
>> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
>> a warning:
>>
>>   BUG: sleeping function called from invalid context at...
>>
>> Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
>> which is not held by spin_lock_bh().
>>
>> Additionally, delete the IPsec list in bond_ipsec_del_sa_all() when the
>> XFRM state is DEAD to prevent xdo_dev_state_free() from being triggered
>> again in bond_ipsec_free_sa().
>>
>> For bond_ipsec_free_sa(), there are now three conditions:
>>
>>   1. if (!slave): When no active device exists.
>>   2. if (!xs->xso.real_dev): When xdo_dev_state_add() fails.
>>   3. if (xs->xso.real_dev != real_dev): When an xs has already been freed
>>      by bond_ipsec_del_sa_all() due to migration, and the active slave has
>>      changed to a new device. At the same time, the xs is marked as DEAD
>>      due to the XFRM entry is removed, triggering xfrm_state_gc_task() and
>>      bond_ipsec_free_sa().
>>
>> In all three cases, xdo_dev_state_free() should not be called, only xs
>> should be removed from bond->ipsec list.
>>
>> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
>> Reported-by: Jakub Kicinski <kuba@kernel.org>
>> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
>> Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> ---
>>  drivers/net/bonding/bond_main.c | 34 ++++++++++++++++++++++-----------
>>  1 file changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index e45bba240cbc..683bf1221caf 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -537,6 +537,10 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>>  	}
>>  
>>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>> +		/* Skip dead xfrm states, they'll be freed later. */
>> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
>> +			continue;
>> +
>>  		/* If new state is added before ipsec_lock acquired */
>>  		if (ipsec->xs->xso.real_dev == real_dev)
>>  			continue;
>> @@ -560,7 +564,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>>  	struct net_device *bond_dev = xs->xso.dev;
>>  	struct net_device *real_dev;
>>  	netdevice_tracker tracker;
>> -	struct bond_ipsec *ipsec;
>>  	struct bonding *bond;
>>  	struct slave *slave;
>>  
>> @@ -592,15 +595,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>>  out:
>>  	netdev_put(real_dev, &tracker);
>> -	mutex_lock(&bond->ipsec_lock);
>> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>> -		if (ipsec->xs == xs) {
>> -			list_del(&ipsec->list);
>> -			kfree(ipsec);
>> -			break;
>> -		}
>> -	}
>> -	mutex_unlock(&bond->ipsec_lock);
>>  }
>>  
>>  static void bond_ipsec_del_sa_all(struct bonding *bond)
>> @@ -617,6 +611,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>>  
>>  	mutex_lock(&bond->ipsec_lock);
>>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
>> +			list_del(&ipsec->list);
> 
> To be able to do this here, you'll have to use list_for_each_entry_safe().
> 

One more thing - note I'm not an xfrm expert by far but it seems to me here you have
to also call  xdo_dev_state_free() with the old active slave dev otherwise that will
never get called with the original real_dev after the switch to a new
active slave (or more accurately it might if the GC runs between the switching
but it is a race), care must be taken wrt sequence of events because the XFRM
GC may be running in parallel which probably means that in bond_ipsec_free_sa()
you'll have to take the mutex before calling xdo_dev_state_free() and check
if the entry is still linked in the bond's ipsec list before calling the free_sa
callback, if it isn't then del_sa_all got to it before the GC and there's nothing
to do if it also called the dev's free_sa callback. The check for real_dev doesn't
seem enough to protect against this race.

Cheers,
 Nik

>> +			kfree(ipsec);
>> +			continue;
>> +		}
>> +
>>  		if (!ipsec->xs->xso.real_dev)
>>  			continue;
>>  
>> @@ -640,6 +640,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>>  	struct net_device *bond_dev = xs->xso.dev;
>>  	struct net_device *real_dev;
>>  	netdevice_tracker tracker;
>> +	struct bond_ipsec *ipsec;
>>  	struct bonding *bond;
>>  	struct slave *slave;
>>  
>> @@ -659,13 +660,24 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>>  	if (!xs->xso.real_dev)
>>  		goto out;
>>  
>> -	WARN_ON(xs->xso.real_dev != real_dev);
>> +	if (xs->xso.real_dev != real_dev)
>> +		goto out;
>>  
>>  	if (real_dev && real_dev->xfrmdev_ops &&
>>  	    real_dev->xfrmdev_ops->xdo_dev_state_free)
>>  		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
>>  out:
>>  	netdev_put(real_dev, &tracker);
>> +
>> +	mutex_lock(&bond->ipsec_lock);
>> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>> +		if (ipsec->xs == xs) {
>> +			list_del(&ipsec->list);
>> +			kfree(ipsec);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&bond->ipsec_lock);
>>  }
>>  
>>  /**
> 


