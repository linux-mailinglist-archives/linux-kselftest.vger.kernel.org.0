Return-Path: <linux-kselftest+bounces-28457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C919A561F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84096189478C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A9C1A8F82;
	Fri,  7 Mar 2025 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AMDoANXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E01A3BA1
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Mar 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333375; cv=none; b=HoBS+5tg++XJA+lVepm+GM9w1Yt8kBLRBeB9zBoRv1Jc+TTiJXDCxe/iCn9SbNJKcZdVhVLRVb3YeM/irdJzDU21ipxiUD4oU2yr+u5ibVCrN1PvGi5KciExMcDZvmDYSHAsE1WUzuD91mvETGchCNJMDjg11K2/wjA00YqAR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333375; c=relaxed/simple;
	bh=t//et2Z3gwsmlCE4BktKeI01ti1hs98yzzyOzqkX5Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTy0j2ZaUQZg6llXepP+oRBlYWPFoBj+wsMwsZbXhxflH6sB0lWYZQLPl5oDzTVTXzLnpE2N1W2ZUAprZ1OWb8aWyt6pISNruD9leYi7r19BxQohzNr+4SI1r0snVFnlgfmwpS5pzknryaxOiE+BEb3pinhlhb68Riz1gcJSC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AMDoANXJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so211759466b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741333372; x=1741938172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XD8qhYPMz/D8R07DChHcNjp4dWxmyKArfoz3ubpHOk=;
        b=AMDoANXJPg7dErpGmHnt4QUQ9mMoimN2AVXutYQDLSO9IWku2fE003A40wf0/IVchO
         S8l/LuYEAx7r7eB4BLMoOIskt6nzF9yoUSgLZ5bN6CklZ74vqVX+3AicLnRjB3msAhj7
         OA+LzOwBClLHa3ak7MqF0nwepTGabZI3D/AsgudLvxcYy/FZLHbxFSEbXoiiXpBBRqWE
         CvczwcJztzjQSyG5SSiAnG19z8d+5OJHD9Yb6ZTUkNwaxHGmTm8rjE3i7sTq5YRArrSG
         JugWm4AhaOdEY/I+LFWgCvN56jEk0zy2lnULvJ/nUbhzYZNV7IyAAR+Jb3IFgb4IBz9a
         RfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741333372; x=1741938172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XD8qhYPMz/D8R07DChHcNjp4dWxmyKArfoz3ubpHOk=;
        b=IJasLXz1/ROdR6sx46rN7hQM0fF2tu0xPMVmEdQ82RfbBk7AnQUO7h58Y37w6xCEu2
         CQJTSww4HgiyE+CKv/9Bm5EKvBbU7X6QUXPhVZRDZgpsGpQy6Xmi+G9iA7Myb8AJ0Zow
         9pLYhkx3uNPunqlTQ42UQx+hxTOZfIrsgev2ntB+6Azaw5P5fwMFXvzatwu1lDJb6ekL
         HBntXxIEuWG9wGq/qgyvDdV1HokDBAFZVMOer0DhpXrkTDPal+i7AehPyOd2t6x3ONV2
         Sgef+Ue6AhQjJmp/pDKZXm3qHJ+1iNBjpnuRKXw89djwNztZMWGYVkIsTcQClBP6RNGE
         hNxg==
X-Forwarded-Encrypted: i=1; AJvYcCUyqFdN1GDEoAzlY5TlOLAQLqjV199VvUTFyRiMCruNTipmYWYEmH2QmDnvuPQrB8PB7Tw1uPcm+MBWzm+uurI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jDm5ryXcq9c917wgVdT3YB0Z8dmynpdV8sRMRmDc1vNtPWV2
	GnBzdtUMvwxIGAxaf4CFnB2/xEzPTFjxgRJ/8+V1IFKgujTOxtca8dilI+Dttac=
X-Gm-Gg: ASbGnctIaGgrgXUepl5fw8iSTTGI6tiUd8w5i+gXqeTe5iSRFw+9JV3JuEpeKnaRJRE
	aiLwAgU9pJhJVWchqwzm+tc+Vksp5iOnGV4Pi1PjkJR+TM4gSfYzBSe1k6dEvk6hmaYfPybLQNY
	g4+GAK0qW7kG/hX4VGVLjbBqF8du2/78toFGI29JYeKBWyRLWeV8B39YoKEy/SOZKqmrlIaxD0f
	WO0Cf42NWqJH4rCQo6/pQzdzkO7vE3YjntGMzWPwyjqwISNUGY4jsaLOQgPMuS2K2LuX4fhH+RA
	2GJksXMHIfybVgU+qHF4nB9rKfRxkD1KDEApGlnBiBUN+yBXzyrjR6NfblVI3BMaHtTSDWd86qt
	Y
X-Google-Smtp-Source: AGHT+IEH13LmOv2SYeD1yfj/wayj59JsykxuHFBkNQDvlFstY/vY9J/NE9qf0IEHfzyAirhV4iNiaQ==
X-Received: by 2002:a05:6402:40ce:b0:5dc:9589:9f64 with SMTP id 4fb4d7f45d1cf-5e5e22be6abmr6606800a12.13.1741333371314;
        Thu, 06 Mar 2025 23:42:51 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399c9062sm226908166b.161.2025.03.06.23.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 23:42:50 -0800 (PST)
Message-ID: <6dd52efd-3367-4a77-8e7b-7f73096bcb3f@blackwall.org>
Date: Fri, 7 Mar 2025 09:42:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 net 1/3] bonding: fix calling sleeping function in spin
 lock and some race conditions
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
References: <20250307031903.223973-1-liuhangbin@gmail.com>
 <20250307031903.223973-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250307031903.223973-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/25 05:19, Hangbin Liu wrote:
> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
> a warning:
> 
>   BUG: sleeping function called from invalid context at...
> 
> Fix this by moving the IPsec deletion operation to bond_ipsec_free_sa,
> which is not held by spin_lock_bh().
> 
> Additionally, there are also some race conditions as bond_ipsec_del_sa_all()
> and __xfrm_state_delete could running in parallel without any lock.
> e.g.
> 
>   bond_ipsec_del_sa_all()            __xfrm_state_delete()
>     - .xdo_dev_state_delete            - bond_ipsec_del_sa()
>     - .xdo_dev_state_free                - .xdo_dev_state_delete()
>                                        - bond_ipsec_free_sa()
>   bond active_slave changes              - .xdo_dev_state_free()
> 
>   bond_ipsec_add_sa_all()
>     - ipsec->xs->xso.real_dev = real_dev;
>     - xdo_dev_state_add
> 
> To fix this, let's add xs->lock during bond_ipsec_del_sa_all(), and delete
> the IPsec list when the XFRM state is DEAD, which could prevent
> xdo_dev_state_free() from being triggered again in bond_ipsec_free_sa().
> 
> In bond_ipsec_add_sa(), if .xdo_dev_state_add() failed, the xso.real_dev
> is set without clean. Which will cause trouble if __xfrm_state_delete is
> called at the same time. Reset the xso.real_dev to NULL if state add failed.
> 
> Despite the above fixes, there are still races in bond_ipsec_add_sa()
> and bond_ipsec_add_sa_all(). If __xfrm_state_delete() is called immediately
> after we set the xso.real_dev and before .xdo_dev_state_add() is finished,
> like
> 
>   ipsec->xs->xso.real_dev = real_dev;
>                                        __xfrm_state_delete
>                                          - bond_ipsec_del_sa()
>                                            - .xdo_dev_state_delete()
>                                          - bond_ipsec_free_sa()
>                                            - .xdo_dev_state_free()
>   .xdo_dev_state_add()
> 
> But there is no good solution yet. So I just added a FIXME note in here
> and hope we can fix it in future.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> Suggested-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 69 ++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e45bba240cbc..dd3d0d41d98f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -506,6 +506,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
>  		list_add(&ipsec->list, &bond->ipsec_list);
>  		mutex_unlock(&bond->ipsec_lock);
>  	} else {
> +		xs->xso.real_dev = NULL;
>  		kfree(ipsec);
>  	}
>  out:
> @@ -541,7 +542,15 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  		if (ipsec->xs->xso.real_dev == real_dev)
>  			continue;
>  
> +		/* Skip dead xfrm states, they'll be freed later. */
> +		if (ipsec->xs->km.state == XFRM_STATE_DEAD)
> +			continue;

As we commented earlier, reading this state without x->lock is wrong.

> +
>  		ipsec->xs->xso.real_dev = real_dev;
> +		/* FIXME: there is a race that before .xdo_dev_state_add()
> +		 * is called, the __xfrm_state_delete() is called in parallel,
> +		 * which will call .xdo_dev_state_delete() and xdo_dev_state_free()
> +		 */
>  		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
>  			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
>  			ipsec->xs->xso.real_dev = NULL;
[snip]

TBH, keeping buggy code with a comment doesn't sound good to me. I'd rather remove this
support than tell people "good luck, it might crash". It's better to be safe until a
correct design is in place which takes care of these issues.

Cheers,
 Nik


