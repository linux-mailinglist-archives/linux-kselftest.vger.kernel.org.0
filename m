Return-Path: <linux-kselftest+bounces-27749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F20A47F4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5884165540
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7E123024D;
	Thu, 27 Feb 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ihRs/256"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8C21C19C
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663068; cv=none; b=MHQB8PMxUwj28eqrL9x36o2jgouOEnCFRLoCo057ip3sCFKFgRwIBepuAfp0TBhvAvbCTz+iE8dGiFQI34QPob8puKTvCW+wngzkkKBSUFno/zlZ5IpdEjaEy/45C1xw/6e6Zkbk/ejathkO56+X3q4IxYzCIHgH4ouoX+Xa6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663068; c=relaxed/simple;
	bh=5K1DQgpCnV8OGVSz6GIqpEfTt8kjItGXwWAZ4X3AWLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqMG6bVLddJe7xgjh2a3JLDmgmxfik2WBSbcjwJ4cDitz1pgOa5eiuSOgf49uikt5eGgrS1yl6I7VxuZ8cWANxTQ2lpZ0sPmL2na1VbyMBPtfe/Z+2nhtJTKV35as7eBiUy5eM/Mp4I7ROPFq/U/jJR9I15+pcLKBT9fENI9ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ihRs/256; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbae92be71so90191466b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 05:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740663064; x=1741267864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wXFTKX1544/JIF02ehdLe2SrnajJcR6+uQqWAAhPPY=;
        b=ihRs/256BSg5Z5Cbra1h9RobjQnf2t4kdPCyir05PZiMdHHq2oLTr9+YSTW2Uxs6a/
         gprp/a+hdm2GYPbvkQZbSPKMOJ208igladzRPsXOF/+5oE6KnU+hy3oNqQ4Fo5stVxOX
         UsEB92c8vXgcvgnlTbuKBOgiJidholdphkNBvweODGLqY9EkSzUx/Cbl/jGWqcSbafWy
         iI2HFPvWEJXsEBGDS7v3+20X1//GKO7PokvUK11CmDnJB+rjSkNEk3ehgUg2iBRlZnHT
         qLTnjIhXJYAAhMueyiZeni/wQoSlXZDOX7ordoirjSy3tCOCyHvjxouD4XgyY6lvWgy/
         ZEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663064; x=1741267864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wXFTKX1544/JIF02ehdLe2SrnajJcR6+uQqWAAhPPY=;
        b=Op+m4KA2iDVzV/JnkieYSjBFZV18We0OA9o7mtXiveW29TgDAGiOs616Ja5mNyyZ20
         GngkYmKZAA64LPxRAuPbZYdZDJwELF8v09jaIBtbvqDGjgapQ2M2ssVKysmRadmk2Yo7
         ZmkIOW7DtciB3LLXeT4xMNpZl9akOFoSa2ZGWtGBpx1lJUdMWFQPITP1cgIAWuYGI0bd
         GF5X5KFb12b8Qauz1mt+PTw4OKICsZa6Uy/93k5GXkk+dBVmm5LoPAJMJ1q0FY0mY4IH
         Tw8TXh70yIjlBC6+7VugqFqGNIPMcJJpXUEYs5jCjyDFtlUBuwHMaNQ2TjWcxU8l1E32
         q5VA==
X-Forwarded-Encrypted: i=1; AJvYcCXIulUVF/IJKK9iZvRzvyonZhUWHUH1QQ/gOCdR1RFx4H7l2Xb/m7vqc+imKx5rMDVLT4CGH5p9GsUVYIMsRYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/SxwnngzBzrCBy+g8fm8cGthMOepKsurCDBRh3OVji60CkiOU
	Otoshtn/jki5DUWYjAbHezGQ0Mdn79FgHKFbxy7tiTvzGGIbIMdkWXPoO33nt/Q=
X-Gm-Gg: ASbGncvQXgJ6TD6Uu4y4otgz099ptXaXfry8PWGzLsIpWJGusGHBVa9CiEYU2cgE18J
	zujTmBZ+BhbjRcWRQRDflckx3/DboFrGWb6opCeWzdg/mW+ljoLpYEn7W6N6Ww03XY2vHsZLx+V
	uRd4e9R9oGUbDHyyNkyF8nNFKNjty4NkQTD7Aw3y36sYj9uMrGPu/ZjN31XYtTxZhrBMjwBcekQ
	f83YHQ6hWHn8E61vvkxbgN6ypoPbn4ppylNP4JeLxoknHCZA6II5iimOJX6wYHGRe0++lrrJxIm
	yLscram6vwiJBwhCjlYuFNJYFZK0nmUcxgjqOmL1na6DrnSk8+GXptyEkw==
X-Google-Smtp-Source: AGHT+IE0aNnzvv1Qi4koQK1Hzo4GjpUtdykg2u0L4Pn0RkAUHo9vRWuUm6DYMvxfLSo0bViwlkQMRQ==
X-Received: by 2002:a05:6402:2553:b0:5de:594d:e9aa with SMTP id 4fb4d7f45d1cf-5e4455c30f9mr28084142a12.8.1740663063527;
        Thu, 27 Feb 2025 05:31:03 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0b86e84csm125023766b.0.2025.02.27.05.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 05:31:03 -0800 (PST)
Message-ID: <f88b234a-37ec-46a4-b920-35f598ab6c38@blackwall.org>
Date: Thu, 27 Feb 2025 15:31:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 <13cb4b16-51b0-4042-8435-6dac72586e55@blackwall.org>
 <Z8Bm9i9St0zzDhRZ@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z8Bm9i9St0zzDhRZ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 15:21, Hangbin Liu wrote:
> On Thu, Feb 27, 2025 at 11:21:51AM +0200, Nikolay Aleksandrov wrote:
>>>> @@ -617,6 +611,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>>>>  
>>>>  	mutex_lock(&bond->ipsec_lock);
>>>>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>>> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
>>>> +			list_del(&ipsec->list);
>>>
>>> To be able to do this here, you'll have to use list_for_each_entry_safe().
>>>
>>
>> One more thing - note I'm not an xfrm expert by far but it seems to me here you have
>> to also call  xdo_dev_state_free() with the old active slave dev otherwise that will
>> never get called with the original real_dev after the switch to a new
>> active slave (or more accurately it might if the GC runs between the switching
>> but it is a race), care must be taken wrt sequence of events because the XFRM
> 
> Can we just call xs->xso.real_dev->xfrmdev_ops->xdo_dev_state_free(xs)
> no matter xs->xso.real_dev == real_dev or not? I'm afraid calling
> xdo_dev_state_free() every where may make us lot more easily.
> 

You'd have to check all drivers that implement the callback to answer that and even then
I'd stick to the canonical way of how it's done in xfrm and make the bond just passthrough.
Any other games become dangerous and new code will have to be carefully reviewed every
time, calling another device's free_sa when it wasn't added before doesn't sound good.

>> GC may be running in parallel which probably means that in bond_ipsec_free_sa()
>> you'll have to take the mutex before calling xdo_dev_state_free() and check
>> if the entry is still linked in the bond's ipsec list before calling the free_sa
>> callback, if it isn't then del_sa_all got to it before the GC and there's nothing
>> to do if it also called the dev's free_sa callback. The check for real_dev doesn't
>> seem enough to protect against this race.
> 
> I agree that we need to take the mutex before calling xdo_dev_state_free()
> in bond_ipsec_free_sa(). Do you think if this is enough? I'm a bit lot here.
> 
> Thanks
> Hangbin

Well, the race is between the xfrm GC and del_sa_all, in bond's free_sa if you
walk the list under the mutex before calling real_dev's free callback and
don't find the current element that's being freed in free_sa then it was
cleaned up by del_sa_all, otherwise del_sa_all is waiting to walk that
list and clean the entries. I think it should be fine as long as free_sa
was called once with the proper device.




