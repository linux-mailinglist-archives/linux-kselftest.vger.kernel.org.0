Return-Path: <linux-kselftest+bounces-27726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6846A47837
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562C13AC2E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E71226D13;
	Thu, 27 Feb 2025 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Co0WY4qi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE3222595
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740646214; cv=none; b=gwrv4BBT0ojY+2BOUV35yVjH8fJ6WC4CKIPvoyshu+6JWvZa4L0P1AFCJnKcxMMt5aXKkDfBuBlYBiJy+OelISJw8TwPKMW4mY20bR0aHsaXSPSLY7kEfEYAifOD51wjgwaMHNl7HgoNmZJVrt+UDrRoZ3c8wgWwE9DvLQyowwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740646214; c=relaxed/simple;
	bh=JM+T7KfoPxmUdPAxF2o/EGA8MRCN5GsbvnEZMBkYBy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIb3Q7js5XEaO4mNnGH2H+Wjx+63WSXzewSieNU5H/euXd0nWask/VHTLHPjRc4o6RROtAOdgmVjVkMsNd8mywIldANFEnw0s6ZE+HusxPl3A0TeP73MMh9aYjb7wtx2nHAASNF42aSPuqnDL5Srrg9C9LuSoX1W8eHzAxNUb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Co0WY4qi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so875255a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740646210; x=1741251010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHAs0BomZnNCju/Ns/9yEvfqTk3h2ZNMb6EVPfKogsM=;
        b=Co0WY4qiMvt8L+p7QCc5GqTOsWorDW9UQsd2Y3yjwWlm+OdTlyqTh22QaR6scm7vzW
         tiwnGDKXLhgKUMFr25xLyBn8WbFcmb1/bR9bcUwzIqktAEWGrZpHq/COWq0Uw8gzOswq
         N4JKiyAP1z3gC1UJVEqFa2LUIgRz2pfRPd7bdAXa+znVpDBLuNSTcT3F68gNrxGBOb1j
         Ka7jF/7ANDh8zFIOWJpIj6isXszpalEn4w7E78wuQIphV77XqBJgA8Cunb1XnVakusKO
         uHNVNxcfenDj8Hl2Ofcc51sMTYahyZYtL4rXBdBvHQCYeNr3kSQZOG/pPAC36pC5Oqup
         PPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740646210; x=1741251010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHAs0BomZnNCju/Ns/9yEvfqTk3h2ZNMb6EVPfKogsM=;
        b=Vu4aLmofuONENgKYqCENrF7p0L+gj7iPHODyZrdAwQnJGNjJ9//cYyPqersHqGIzn+
         VUrxgKRFBqifP71mtRoq1LJ8aLoK1DfFJnh49nIG8gFmolJQNAAqqwooIkyO3KtIK1Cc
         fSO6vvWyW0Fl4U0jBXIzhpwbSETTJITSwMZkbej+XxRLETSEIUCIQDZ5UBEoB3Sn56Nc
         fk9OwbRVjWYdqMDhHQpd0yQ05i7pSx85e7//FihYd3Uv2+f5T8CdUyBq8wSSto2LrQde
         f9dv0k62S+0sF5CJKwnHf+7Q0f+N2Y/I5imNNxYG7KUh+zqXnCkup34xw7nQ/YDrC8Qc
         vjyg==
X-Forwarded-Encrypted: i=1; AJvYcCVe5Eitvtv/7Hr5M/+Wn11DkJTKa0kgtpuLAhYtySe3Z/r753SyC2RsjN9dQZGIepNlfsi6W/DDKLeg7vwafQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSc0pWTV1MVjfyV5aW3Yv96yRxuYSDw47gHscrAMlBNOAtw+l/
	oDIQpAw1p8diZTHzleRocV5/6raHyFblWmusbVi6nQ17hA5UyYS3+8hm5f8R6rk=
X-Gm-Gg: ASbGncu4En7n+yFtXNZf7BXLjE29PM2ugct7O1KRziGdf8qLP/U6NN6ma8VTJPb++IC
	vqps41OEdquuO9VIHMTC+AtHWD2g+8/0/lZko8mhSMWc7vNAVt0wjbkiyry1pRJyGKpGSKS6cep
	lmCfcB1YHaDLjxJ5KqL3r8Xacjs+O4NhXyudPDLlJzu9CHi8npNOa09k1noJpxHN4clRqLyzsOm
	hWWHj9PlRlrUyBiLqPxFv3yJR4Mqgur8APWASPhTvTaau4GY41OTvyUYLwQXrb9Nq+2INANqMiT
	DgKoapWOEgVUIwUrQ1jQZntw6mDYbRfDT/pgPIxdzDGGJhspFqxZchfuzA==
X-Google-Smtp-Source: AGHT+IFBWYi4qkBq4PKRHbFbNW+hgP9t6Ix0w6cYY5Br99KK5Bxk+XjMxKjzlfWob2i8Ld9tnj1i2g==
X-Received: by 2002:a05:6402:239c:b0:5e4:a4d0:58cc with SMTP id 4fb4d7f45d1cf-5e4a4d05947mr5689642a12.29.1740646209890;
        Thu, 27 Feb 2025 00:50:09 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa3bsm764641a12.16.2025.02.27.00.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:50:09 -0800 (PST)
Message-ID: <446e8ef4-7ac0-43ad-99ff-29c21a2ee117@blackwall.org>
Date: Thu, 27 Feb 2025 10:50:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
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
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250227083717.4307-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:37, Hangbin Liu wrote:
> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
> a warning:
> 
>   BUG: sleeping function called from invalid context at...
> 
> Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
> which is not held by spin_lock_bh().
> 
> Additionally, delete the IPsec list in bond_ipsec_del_sa_all() when the
> XFRM state is DEAD to prevent xdo_dev_state_free() from being triggered
> again in bond_ipsec_free_sa().
> 
> For bond_ipsec_free_sa(), there are now three conditions:
> 
>   1. if (!slave): When no active device exists.
>   2. if (!xs->xso.real_dev): When xdo_dev_state_add() fails.
>   3. if (xs->xso.real_dev != real_dev): When an xs has already been freed
>      by bond_ipsec_del_sa_all() due to migration, and the active slave has
>      changed to a new device. At the same time, the xs is marked as DEAD
>      due to the XFRM entry is removed, triggering xfrm_state_gc_task() and
>      bond_ipsec_free_sa().
> 
> In all three cases, xdo_dev_state_free() should not be called, only xs
> should be removed from bond->ipsec list.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 34 ++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e45bba240cbc..683bf1221caf 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -537,6 +537,10 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	}
>  
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		/* Skip dead xfrm states, they'll be freed later. */
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> +			continue;
> +
>  		/* If new state is added before ipsec_lock acquired */
>  		if (ipsec->xs->xso.real_dev == real_dev)
>  			continue;
> @@ -560,7 +564,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	struct net_device *bond_dev = xs->xso.dev;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -592,15 +595,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
> -	mutex_lock(&bond->ipsec_lock);
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		if (ipsec->xs == xs) {
> -			list_del(&ipsec->list);
> -			kfree(ipsec);
> -			break;
> -		}
> -	}
> -	mutex_unlock(&bond->ipsec_lock);
>  }
>  
>  static void bond_ipsec_del_sa_all(struct bonding *bond)
> @@ -617,6 +611,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  
>  	mutex_lock(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> +			list_del(&ipsec->list);

To be able to do this here, you'll have to use list_for_each_entry_safe().

> +			kfree(ipsec);
> +			continue;
> +		}
> +
>  		if (!ipsec->xs->xso.real_dev)
>  			continue;
>  
> @@ -640,6 +640,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>  	struct net_device *bond_dev = xs->xso.dev;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> +	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -659,13 +660,24 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>  	if (!xs->xso.real_dev)
>  		goto out;
>  
> -	WARN_ON(xs->xso.real_dev != real_dev);
> +	if (xs->xso.real_dev != real_dev)
> +		goto out;
>  
>  	if (real_dev && real_dev->xfrmdev_ops &&
>  	    real_dev->xfrmdev_ops->xdo_dev_state_free)
>  		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
> +
> +	mutex_lock(&bond->ipsec_lock);
> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xs == xs) {
> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&bond->ipsec_lock);
>  }
>  
>  /**


