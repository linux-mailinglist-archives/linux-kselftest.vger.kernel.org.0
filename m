Return-Path: <linux-kselftest+bounces-27458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BF8A440E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 14:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7223BEC7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765AE26A0DD;
	Tue, 25 Feb 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RbZyabTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C126A0A4
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490213; cv=none; b=HF7473ZR8JEnwEd8539XhUw4K5XR4jBj+rAJ5iHmXX8JfwhPS/lTIJchDhNcC6VE2ySVOttnmwinWNZ2EiVBIvZvbrJDtwPXVdDDeZNDqAuvOQMBybpxWzJWxsxzadI5DFZlL/gkT4NqGpRf7XVndjs79BC9qAk51tD84gg2LQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490213; c=relaxed/simple;
	bh=hvLj0F4Uwm40bxLfNRVMTVx2jzkCvz6JcDf1yH4Ju1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoZdA2uS6lTDYjhhNcapXK4ypYK6MI8y4Q9Wvr+52G/RmkPPg8EPkOnavm0bNOm3lAf5v4FHeE0BIMN5E2b6WLRqvcFqeAI6+02Egeqt7vsZG2tjjxGOkRTpO4whf9ZwZqTtZSaTUqBgyYzAHGjL5mvYnvHCkzofQx+14goK26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=RbZyabTS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abec8c122e4so211332466b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740490209; x=1741095009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FWPAKB8cSPuv3a8g0C1bOw8Zay5mwFkNm0SF2AsIuEQ=;
        b=RbZyabTSnrz9r84fjBO10x8bHkBJaQaMnhl2FqSeyxsPXLPEjyGU8yBFo25wa2a8kc
         Q4q5Lgmr3JgrRItPy3hKveqN7yzjHCX85oLRVq2BELG+XnecdKnjQ88Phz9+WG577KMX
         5b3+kOY22Hd+jgNZuBLPR/8IPlYFEkJUIrR09ttu0rZLbJPjad4JBtdH5wHcg3vA6U6u
         YsJi24IXOolHpdnPlAGjyisZn+SZEeM4QwmhXYrWSnio/CMY9qae/8bkx1K3PWvKoVQe
         aD8u36rZGDuqARWgqz4yOqE+UOjd0EzwpmOdHKOH/8gc/BTVQd79eIlMO2+ncNDEfH1W
         ZmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490209; x=1741095009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWPAKB8cSPuv3a8g0C1bOw8Zay5mwFkNm0SF2AsIuEQ=;
        b=LCh5VTJFbthgUa0G08C/x4IeLmwgVlqXVQ0WTK13hOxXoMjU4BCNt6KEFYhJEVgpGC
         TXZURP8w0UU3I/Qezxxplj7ycBm4b8mEq0wtKNd2Lb1rSUCgrCUm1APGiRV541EGsjTD
         Mt6/K9DfOVin3UtkTtEM/uwc3341a0b5Qs/mMTLwgwYOsAHdaoh1UNEvYIiY2vPbAv7x
         zYo8zvv4bk9vTkwdO3IFfYlwMMXAFPAD8k2n2pvY2HMUAwFuxo7sPK0eYi1YMw2x2689
         3lO7x6MO4PXuyt8yCtXO3z6/rUz+I0YSbs9i/sbjGcSvLZv/PL7Ua9aE/Jg5Oat4o9n+
         iCzg==
X-Forwarded-Encrypted: i=1; AJvYcCVAhmUkh1aYmlA7sbhKnnRPxRujPKDWSGIQQHVucCHjMRi+8qWEdpThya0cLHL9TjpVbmd/QyIasvk1WJT/Bl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEF/KutI7HwQH08w7jv+YW5BxJoE6rYeDmw16AdRlgFJ1XTst
	brBtefG9NyL09i66iWYqCGKIwtH59DFix6v3ZLOClXE7op1VwJT3rbSreeh7j08=
X-Gm-Gg: ASbGncvdpUWetsn01VwSIfnr/ws38IgCYWWci6UEpJLQRk9+AlBK6dYFRElgUCHzVoQ
	rOdKkeJx7QGUNgmGbZKkNBTlEKSokhJeRdajc0gb4RMZUmazS0ODTeRIN/WmqbWbZQ89EU4Bvky
	5bnTUAPe8M2XUIdcsUi0EXlHBnXCGQhGvxV4lvTLU/HGN2UNugz9P7gyFZOhn6vToiOKBqSRjlm
	vMm1qRk5MKG+L9P6jt9wzy9qb9zVrWCCrK/EO8MChZPRSsD2CG4zf9v0qsYxzoK4Vm5Kgeo0ZW1
	5Irjbdt7BeUCAeXXtBcQVvuOa5sDLVzlD5WCcTj0MeaIp4Unzbnm5b1Ucg==
X-Google-Smtp-Source: AGHT+IGt1d9HYoncPo/XlY2JEaN6xcouJm1b6mDBrkdkRB6XvWdMBX+M9vXDwh/uV+eQuDAPmnCDIA==
X-Received: by 2002:a17:907:9722:b0:aab:daf9:972 with SMTP id a640c23a62f3a-abc09ac1bd0mr1636694466b.28.1740490208363;
        Tue, 25 Feb 2025 05:30:08 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed204f6edsm139335666b.128.2025.02.25.05.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:30:07 -0800 (PST)
Message-ID: <72827395-743d-488f-af12-39eead3a0650@blackwall.org>
Date: Tue, 25 Feb 2025 15:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
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
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
 <a658145a-df99-4c79-92a2-0f67dd5c157b@blackwall.org>
 <Z73CBzgTVucuOMMb@fedora>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z73CBzgTVucuOMMb@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 15:13, Hangbin Liu wrote:
> On Tue, Feb 25, 2025 at 01:05:24PM +0200, Nikolay Aleksandrov wrote:
>>> @@ -592,15 +611,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>>>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>>>  out:
>>>  	netdev_put(real_dev, &tracker);
>>> -	mutex_lock(&bond->ipsec_lock);
>>> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
>>> -		if (ipsec->xs == xs) {
>>> -			list_del(&ipsec->list);
>>> -			kfree(ipsec);
>>> -			break;
>>> -		}
>>> -	}
>>> -	mutex_unlock(&bond->ipsec_lock);
>>> +
>>> +	xfrm_work = kmalloc(sizeof(*xfrm_work), GFP_ATOMIC);
>>> +	if (!xfrm_work)
>>> +		return;
>>> +
>>
>> What happens if this allocation fails? I think you'll leak memory and
>> potentially call the xdo_dev callbacks for this xs again because it's
>> still in the list. Also this xfrm_work memory doesn't get freed anywhere, so
>> you're leaking it as well.
> 
> Yes, I thought this too simply and forgot free the memory.
>>
>> Perhaps you can do this allocation in add_sa, it seems you can sleep
>> there and potentially return an error if it fails, so this can never
>> fail later. You'll have to be careful with the freeing dance though.
> 
> Hmm, if we allocation this in add_sa, how to we get the xfrm_work
> in del_sa? Add the xfrm_work to another list will need to sleep again
> to find it out in del_sa.
> 

Well, you have struct bond_ipsec and it is tied with the work's lifetime
so you can stick it there. :)
I haven't looked closely how feasible it is.

>> Alternatively, make the work a part of struct bond so it doesn't need
>> memory management, but then you need a mechanism to queue these items (e.g.
>> a separate list with a spinlock) and would have more complexity with freeing
>> in parallel.
> 
> I used a dealy work queue in bond for my draft patch. As you said,
> it need another list to queue the xs. And during the gc works, we need
> to use spinlock again to get the xs out...
> 

Correct, it's a different kind of mess. :)

>>
>>> +	INIT_WORK(&xfrm_work->work, bond_xfrm_state_gc_work);
>>> +	xfrm_work->bond = bond;
>>> +	xfrm_work->xs = xs;
>>> +	xfrm_state_hold(xs);
>>> +
>>> +	queue_work(bond->wq, &xfrm_work->work);
>>
>> Note that nothing waits for this work anywhere and .ndo_uninit runs before
>> bond's .priv_destructor which means ipsec_lock will be destroyed and will be
>> used afterwards when destroying bond->wq from the destructor if there were
>> any queued works.
> 
> Do you mean we need to register the work queue in bond_init and cancel
> it in bond_work_cancel_all()?
> 
> Thanks
> Hangbin

That is one way, the other is if you have access to the work queue items then
you can cancel them which should be easier (i.e. cancel_delayed_work_sync).

Regardless of which way you choose to solve this (gc or work in bond_ipsec), there will
be some dance to be done for the sequence of events that will not be straight-forward.

Cheers,
 Nik


