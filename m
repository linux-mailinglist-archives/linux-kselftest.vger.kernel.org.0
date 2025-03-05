Return-Path: <linux-kselftest+bounces-28295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31601A4F8F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 09:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C6F163E07
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269E91FC10C;
	Wed,  5 Mar 2025 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Kl+L+zMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9991FA243
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163922; cv=none; b=d34q7VQIuo3I3FKzVf4/OM/ba1PC1CG5jdz6fQIWBP63DW2LWpTTtzmGFlAy6NDqJy/9qJVgCl4OPdDL5sQJCfLiYcLHXsFXymuJsY4kbE4tdRHY6zPl7KoI9BtTm43C6UcFuyj0Bg8iPoSXwl73MMXvi2liMdEXLWTBX/wNg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163922; c=relaxed/simple;
	bh=2289srtRYhO2XLtWnNt1zZSHjLPywnfuAh4PjO7nRns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgFKCpr+KEom5+igfd6Hi0SKZ/6g3/5MM87ss6KR8p0LotRTEM+UT2rmdzdG1xKh6Uh4AAo3Q8alwqde+YqlIIePAisAt6Mk50iE759dR0HJuW9bypymq+7WDX6EFE7h1T/8YJqrC64LBstYFByFmPoGI0so9urwkWHlgmb7Ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Kl+L+zMZ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf615d5f31so692036966b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741163918; x=1741768718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pYkJMTg/+M64ocsPQ4ifBCCKMe3+ghvTVTjmpHLBzpE=;
        b=Kl+L+zMZ5y2wtmXdHQcWCMxvz8/K9zmYwbo25EZDOf5tNggVPJ4tsL9c0IBH+258+C
         qKp/P07gOTYQaYaGNpXD5zsGyp5yKQS39Mrxw6tiwb9YsTvf8tnBY3ig/B1Rg0Da4YUz
         aPy+fZWhkCFIhohkDoCX51BTfV0ynU1B7euG2wNiNTfFmU1HS1iG4S84WwbnDnSZVq0y
         FaqAmZxJeomHCn3nqNa8bVbAiG19omINJYusbzPG8XNKBuEB8RLHKoqvn3dlcN5W6uVR
         OH3f5HlYX6DqAwC1/H1XASikZlB0gsS2+Xaf3Jisa3VA8nkkTDX+lh/3rg+JcW3zCjtY
         uG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163918; x=1741768718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pYkJMTg/+M64ocsPQ4ifBCCKMe3+ghvTVTjmpHLBzpE=;
        b=OKBGxCZNMgU7vR5d2dJmsJ9CdsNWH+6+7pnyxGYNkXUBSbNaGRh2QjWQAd/5u4BubD
         gVwDw7xS688bQskkB/BUjVkjshlubCmAXR7l7rPxpxVfjTLo4cQUgI535uSXWoV/F6Qo
         3dsQUaJLe6W/xDfv+mXId/DEUs0RTk2gvLtTWk5mCgO9bVef5h7qQHRXoeBnCJs62Sv5
         NvLpPK8HWi9x1yXvh7taLvSHrMIf4Dt2SAhvNR6s9DGjTQp5J1vpyP7MSq/4YcKICeQR
         lrvjVcE/bAzUbMn8bc1Jt5uGsW0lh+fHDzsWg4CxmUWwzcabDuU4y695uqwTrarooQZ/
         tOnA==
X-Forwarded-Encrypted: i=1; AJvYcCWafRTnYvwZ8HnqvNk3pXkpwluh7tWw+VWgHAWZQTtPMwm/FKVREBKXgkChzwKbKyrSzbQHbddOxIo+910MmwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UAiEUY5y1iKNSZNnXYk5DsbbHg+I/CtDdDGUKNjUASlIG8m5
	LkS63DuwNRojvC29PRygR5a38/7Radxe1I5imItTSAIWyQ99TmBGbG0C/3FBr9U=
X-Gm-Gg: ASbGncv/GPJbxCZXPw7W9DH7RJmbxczgIy+yWZ7BwBeIl54O7Lz0fjTk3Sa9AHafQ7C
	4Wl4sAZ8tJHHsf44qyejgKaKJS4NNIQ4kLWln+tPJeIbYfcrQRvekxDPSE4ackriStIGJpBhtoj
	YJwbpr/MzmzqGuJYIyQyHVt9fZnyzSHOCNWIMv9SiozGUijHWc8vdfQjzXW7Ioe4vnPWpEo3kPc
	nYfVpicgwBOV41V7ZGBqOTZeVgS2QPyXZPGFBpzuZqw3YS0guLEy4fUr6AZpOq5W5HVQJFluxRz
	/BOBLKG/R96TJmpQuLBBMmXTaiN+WSt5EsQLCMDC1jp16ANpexDrWjCXdOUiHurUUDbfdi5UQ+t
	I
X-Google-Smtp-Source: AGHT+IElgGUiKsdceMJGHW/USzAGMtLne0NJyyzCA7jjzyWv3l7S4LlPXebJjKkvecpJUtsWxeoP+w==
X-Received: by 2002:a17:907:3e11:b0:ac2:b73:db4b with SMTP id a640c23a62f3a-ac20d842dc5mr197841066b.4.1741163917771;
        Wed, 05 Mar 2025 00:38:37 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac052702e83sm431265666b.21.2025.03.05.00.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:38:37 -0800 (PST)
Message-ID: <4108bfd8-b19f-46ea-8820-47dd8fb9ee7c@blackwall.org>
Date: Wed, 5 Mar 2025 10:38:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 net 1/3] bonding: move IPsec deletion to
 bond_ipsec_free_sa
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304131120.31135-1-liuhangbin@gmail.com>
 <20250304131120.31135-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250304131120.31135-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 15:11, Hangbin Liu wrote:
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
> At the same time, protect bond_ipsec_del_sa_all and bond_ipsec_add_sa_all
> with x->lock for each xs being processed. This prevents XFRM from
> concurrently initiating add/delete operations on the managed states.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 53 +++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e45bba240cbc..06b060d9b031 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -537,15 +537,22 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	}
>  
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		spin_lock_bh(&ipsec->xs->lock);
> +		/* Skip dead xfrm states, they'll be freed later. */
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> +			goto next;
> +
>  		/* If new state is added before ipsec_lock acquired */
>  		if (ipsec->xs->xso.real_dev == real_dev)
> -			continue;
> +			goto next;
>  
>  		ipsec->xs->xso.real_dev = real_dev;
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			ipsec->xs->xso.real_dev = NULL;
>  		}
> +next:
> +		spin_unlock_bh(&ipsec->xs->lock);
>  	}
>  out:
>  	mutex_unlock(&bond->ipsec_lock);
> @@ -560,7 +567,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	struct net_device *bond_dev = xs->xso.dev;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -592,15 +598,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
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
> @@ -617,8 +614,18 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  
>  	mutex_lock(&bond->ipsec_lock);
>  	list_for_each_entry(ipsec, &bond->ipsec_list, list) {

Second time - you should use list_for_each_entry_safe if you're walking and deleting
elements from the list.

> +		spin_lock_bh(&ipsec->xs->lock);
>  		if (!ipsec->xs->xso.real_dev)
> -			continue;
> +			goto next;
> +
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD) {
> +			/* already dead no need to delete again */
> +			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
> +				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);

Have you checked if .xdo_dev_state_free can sleep?
I see at least one that can: mlx5e_xfrm_free_state().

> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			goto next;
> +		}
>  
>  		if (!real_dev->xfrmdev_ops ||
>  		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
> @@ -631,6 +638,8 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
>  			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
>  				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
>  		}
> +next:
> +		spin_unlock_bh(&ipsec->xs->lock);
>  	}
>  	mutex_unlock(&bond->ipsec_lock);
>  }
> @@ -640,6 +649,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>  	struct net_device *bond_dev = xs->xso.dev;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> +	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -659,11 +669,22 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
>  	if (!xs->xso.real_dev)
>  		goto out;
>  
> -	WARN_ON(xs->xso.real_dev != real_dev);
> +	mutex_lock(&bond->ipsec_lock);
> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xs == xs) {
> +			/* do xdo_dev_state_free if real_dev matches,
> +			 * otherwise only remove the list
> +			 */
> +			if (real_dev && real_dev->xfrmdev_ops &&
> +			    real_dev->xfrmdev_ops->xdo_dev_state_free)
> +				real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&bond->ipsec_lock);
>  
> -	if (real_dev && real_dev->xfrmdev_ops &&
> -	    real_dev->xfrmdev_ops->xdo_dev_state_free)
> -		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
>  }


