Return-Path: <linux-kselftest+bounces-40623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EEB40A71
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B11BA260E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38043306D49;
	Tue,  2 Sep 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI8aVViy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973982DEA64;
	Tue,  2 Sep 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830133; cv=none; b=KwdDiy3+XBPgdODnlAu5jjwQYcGhHBFy4oXKxw5Jsi74whGYaDwd7INZgApqcTaoqbaLarQf/xM6HBMxutdWjvCyCCEg8Skmg388qgC0UZTxqWzkDBGR4zXQiynG5ZM6hJRpVLiiypWojuAdHNw5u8dc696Hz9VjTg1MvexdHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830133; c=relaxed/simple;
	bh=T/KjOOsLhvMSRHctLIe0sEbSL/AegU7tU/jzAHfFzho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcuLbJJnMMWrrodz1MLBnvlnBMv/xLj5ADX2ojKazhooCRnDPgGue01cBQaU4Mdwqc6sYIkNNOavIS5TigAAqlytQCoIqwuN5k74KBZlVDpGA94XzWubbCYhiHAedxqR6ZhWkEA3HaoerSDTtA04Hv7Zui1IOx9PAGiGgF47waQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI8aVViy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49cf1d4f6fso3883723a12.3;
        Tue, 02 Sep 2025 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756830131; x=1757434931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrhZ8SbifWNGRbBXiNjXeMkZVlU0hBJ919giQwu5/3M=;
        b=nI8aVViyLO7LduY2F/WtqrfGQGbHbWbkBzh8Ft5M/yLH/eKcNHoHZYNj9SbxErMqH8
         xyJk62MKFec47weTEdK9IoBS14LmWi5xnm+Ju3gYKb2QIVHL23w3IaH3VAzA93/N/RZ4
         xFbEShH3nq4yxQbUnLUWioG7mKbapNXLC7Rw+P4Mr10K1TRmUEk+EX6wZmiS1tafrPux
         OWjIiq/JhmOXKtUkpqMqT080SfUy7z7iP4Plvu+1A7mcPWCEPxBm2pG9nF6vC2GkTBN1
         mHQXGgawrzkkTDInjkPOGg3WdVhgRDwssRhLk3UoEeK7L6LMFELsmy9gIW4IyLLFIMca
         iFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830131; x=1757434931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrhZ8SbifWNGRbBXiNjXeMkZVlU0hBJ919giQwu5/3M=;
        b=a6J4vlMGJdScH0T04w49NyCJSFX9zM1bl2+fdgWWmMywUJMNEvpvfN+ZlLpXcWoXsF
         9PCysHIP0H2WRodEvKcQBZ7kB5fJe0tIvhAF8ANodSdCcZEiqON9EFT5wKFhuU7E9GEd
         WCe9jgQXclqDwXB582ZBaH4PfSKzdemaSUBlRswpf5k+esdBvjFkZsuiNiw3wHH6dWxq
         JINS4+dgD5MXwFKTF15efRhIH1VxduN3nVMFS2JW6VKtBALIrrh6o8aGR8rZUVz2nfb9
         ToT3gj0jcufUJpSgtd9EBf3YRTfvnoVlOqq0HiGCiNHwX//fy5nu2PneFYNsR0G1P+6G
         yRlA==
X-Forwarded-Encrypted: i=1; AJvYcCVMevjed6vk3vxZOVAgFM0WcoUlM1WkSElnropwwl+gbgnRMPp2KvHCJFVHIuxqDrFdUB7AS2Mt2wi772/e2AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ALg1vYm8bSGe9gktmf4gjeU0zAjf0fTONoD3lWzq/xsWQPg8
	n05ExkVU2adSE5yJWO3qFp+Abb+ioX2mZOIrktxCOmut9kc/kqQnmRk=
X-Gm-Gg: ASbGncswbnbBZ2avIHFRqmFvS1I7jsN2ezbHX28VkYeAq8PiF3MkthR+/ruUVJcvI1H
	WynS9AgkbJcMhh7bDlsReIYY5mWNBkP1ubcgaAqKEQSTidJmNCiWfl5cwTqi1+PSaq3JfFFsXc/
	tluketDxOQdWgW3fNQMeWd7kXGmRp0Ceb1Zx8f16n6K7l2Yf7zm25v+iAYtgOJtC37Nf0t7V7xR
	0IzRAPl2CY70n1fIQSmdZozGdzVhkgnRlygsnLn773BESO6t09lZTcOhnGxXMF8QXh1UZsND1x8
	emWnCKqR1Z5Fj+s7l1KVP2lq60++2wk7Xres3H+qYnrC2k5SqedCRH1xN+FjzQ7X0YVnBrozB42
	PZZH3g1eFgeZOxLfCviPI7BhSiV/Rlr98cPztAg5ANQhHvRDc5xFC4Jwcb3rud9Vs2zS4YBHksd
	SKbQ4xqPJQL6U8cD4j8NxnJzqb9vkyLp/baGTiZcICdx85GTVOhJEifGx1DCCeK0w1iBVxVVgE4
	EvK
X-Google-Smtp-Source: AGHT+IHyDcasNmEHyeO6kcdp8vnamRAvkNnpljuz2J/TSAKeE8ghhhcuoQIxiBYP7sQiUc1mJNbjWQ==
X-Received: by 2002:a17:902:d4cb:b0:249:2c76:54fc with SMTP id d9443c01a7336-24944a9e7b4mr159382985ad.39.1756830130600;
        Tue, 02 Sep 2025 09:22:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24905da2896sm137876915ad.81.2025.09.02.09.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:22:10 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:22:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] team: use common function to compute the
 features
Message-ID: <aLcZsYrC7Q1sqpSv@mini-arch>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829095430.443891-4-liuhangbin@gmail.com>

On 08/29, Hangbin Liu wrote:
> Use the new helper netdev_compute_features_from_lowers() to compute the
> team device features. This helper performs both the feature computation
> and the netdev_change_features() call.
> 
> Note that such change replace the lower layer traversing currently done
> using team->port_list with netdev_for_each_lower_dev(). Such change is
> safe as `port_list` contains exactly the same elements as
> `team->dev->adj_list.lower` and the helper is always invoked under the
> RTNL lock.
> 
> With this change, the explicit netdev_change_features() in
> team_add_slave() can be safely removed, as team_port_add()
> already takes care of the notification via
> netdev_compute_features_from_lowers(), and same thing for team_del_slave()
> 
> This also fixes missing computations for MPLS, XFRM, and TSO/GSO partial
> features.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/team/team_core.c | 73 ++----------------------------------
>  1 file changed, 4 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 17f07eb0ee52..018d876e140a 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -982,63 +982,6 @@ static void team_port_disable(struct team *team,
>  	team_lower_state_changed(port);
>  }
>  
> -#define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
> -			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> -			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
> -			    NETIF_F_GSO_ENCAP_ALL)
> -
> -#define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
> -
> -static void __team_compute_features(struct team *team)
> -{
> -	struct team_port *port;
> -	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
> -	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
> -	unsigned short max_hard_header_len = ETH_HLEN;
> -	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
> -					IFF_XMIT_DST_RELEASE_PERM;
> -
> -	rcu_read_lock();
> -	if (list_empty(&team->port_list))
> -		goto done;
> -
> -	vlan_features = netdev_base_features(vlan_features);
> -	enc_features = netdev_base_features(enc_features);
> -
> -	list_for_each_entry_rcu(port, &team->port_list, list) {
> -		vlan_features = netdev_increment_features(vlan_features,
> -					port->dev->vlan_features,
> -					TEAM_VLAN_FEATURES);
> -		enc_features =
> -			netdev_increment_features(enc_features,
> -						  port->dev->hw_enc_features,
> -						  TEAM_ENC_FEATURES);
> -
> -		dst_release_flag &= port->dev->priv_flags;
> -		if (port->dev->hard_header_len > max_hard_header_len)
> -			max_hard_header_len = port->dev->hard_header_len;
> -	}
> -done:
> -	rcu_read_unlock();
> -
> -	team->dev->vlan_features = vlan_features;
> -	team->dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> -				     NETIF_F_HW_VLAN_CTAG_TX |
> -				     NETIF_F_HW_VLAN_STAG_TX;
> -	team->dev->hard_header_len = max_hard_header_len;
> -
> -	team->dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> -	if (dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
> -		team->dev->priv_flags |= IFF_XMIT_DST_RELEASE;
> -}
> -
> -static void team_compute_features(struct team *team)
> -{
> -	__team_compute_features(team);
> -	netdev_change_features(team->dev);
> -}
> -
>  static int team_port_enter(struct team *team, struct team_port *port)
>  {
>  	int err = 0;
> @@ -1300,7 +1243,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>  	port->index = -1;
>  	list_add_tail_rcu(&port->list, &team->port_list);
>  	team_port_enable(team, port);
> -	__team_compute_features(team);
> +	netdev_compute_features_from_lowers(team->dev);
>  	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
>  	__team_options_change_check(team);
>  
> @@ -1382,7 +1325,7 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
>  	dev_set_mtu(port_dev, port->orig.mtu);
>  	kfree_rcu(port, rcu);
>  	netdev_info(dev, "Port device %s removed\n", portname);
> -	__team_compute_features(team);
> +	netdev_compute_features_from_lowers(team->dev);
>  
>  	return 0;
>  }

[..]

> @@ -1976,9 +1919,6 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
>  
>  	err = team_port_add(team, port_dev, extack);
>  
> -	if (!err)
> -		netdev_change_features(dev);
> -
>  	return err;
>  }
>  
> @@ -1991,11 +1931,6 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
>  
>  	err = team_port_del(team, port_dev);
>  
> -	if (err)
> -		return err;
> -
> -	netdev_change_features(dev);
> -
>  	return err;
>  }

nit: change these to 'return team_port_xxx()' ? Can drop the 'err' as
well, don't think it's needed anymore?

