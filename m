Return-Path: <linux-kselftest+bounces-41160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 676BFB51BA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C2F7B2B00
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19EF255F2D;
	Wed, 10 Sep 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbrcSsIu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178D8479
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518275; cv=none; b=oSThGylFGh2Xty1sVafAUY8IVasSQzUdNpbj4W6kj2Hb0vtu8ciC1y081Iutuv7SZxUpjuBVYpNdXOgEWNqrQaQ1QkpcdgnaCdg5fdDOrC5n0V0N4qd7csVi5c1pi093Vzmvzuk312wqLiFOlb/K3FvxeS7CWebBRnJ6Y28Dor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518275; c=relaxed/simple;
	bh=jc2/UzEiHHii7qwYws85Ns4EPsygWxg33Jjz8SvEiiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOioRhqGZabZNumBQ7B5rNs5xwCkk5Ph8kr3SpduNJyfbmiP13fo/V3cansUDU9QiBYY7x/SoIiKJXjb+NFUBtyJ45jUnLHySkf6K83eRmAQgCBR85/sVeCGcxXKCIsendHlZ0tLzh1lowlSY9IN32hTaZv7yLJ0Sd1GX5KPRGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbrcSsIu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b70820360so5670590a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518273; x=1758123073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aslT2dP/KbCqLz9yRRveBsORSsjyA/aQ8k1L0oN8zws=;
        b=PbrcSsIuoYXNvNnkA8TMAiRC+U+K0vOeEVILZLZN1owUvd1zgZyNK/tO9mu/zDPnUo
         OdRC41SUOaE4hE6nhVnQzFfJjr8dyqXZ3TktA1I0YUlBXbbKZHUsNrhWkpPWMFq9yGeT
         QBZ0O4wy3goLWrL0lZPyT49UraPYUGs3ydzJRZw5gIxt+LU02ocOqXt4Jj3JcMUrqhoO
         ZZ4rklPgyNM3gWLnh9H/PfVKdgHzJI5lMQLclUCxZs4VT3ZWhQd5imVjQueeZsf3xcL6
         NFW+u2MDg+7a1460J27Fh4/OhVF7gWQtNdKujv8w1QWzuaUOD3ZrJctSjYNF/iUXJGJp
         PjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518273; x=1758123073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aslT2dP/KbCqLz9yRRveBsORSsjyA/aQ8k1L0oN8zws=;
        b=eMSYxmHgWq5EOGj73qF7KXEyzDscF7E3ytMNd/eosEUKWF33kYd5WTUcWHDFbWjMcH
         u7wPpKPbv9dCtZwQ8zvweW2tYijHhIkltoHedmkbWGdYcvp25PXDnQUzwPVEPZ0DYBeo
         he4Z2eKavHwXa3W1DjkTN0CP+LAAVZHIOE9jrQ8F15xWDJboEvMlvMUz9X8u5bUE1Rv6
         8HCpDLN3g6iHjSp5SAWdhQwyaqn1Tlacu7KWvpFprSMQavsg8PoKLm9Rh1cSTB9P7EBx
         mO8Q6hfKgwWxbdsisBmvrE6D30bd8VteWZv94jSWFhav2ikNNjbsplj53IGodWG5T6xC
         Oabg==
X-Forwarded-Encrypted: i=1; AJvYcCUG2WpUZhnWkO+fEqoLyB0pbK2zMIl50Z2BAzMrHq8mG+1K/9XWt5dsYGvC6zQ2zuJxJaFpfrLOGzsXLNFoFi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeIH7za0XZPhnoxa21DPCh7fda1CW7KwCEzWCJHRk04K+6zEEE
	i3WGTP5V5sGSlo7oBBLO0ohxbQlvlpuip93pabgD6RAI3vFeHLoO57A=
X-Gm-Gg: ASbGncvsN2ysJeWS3luSs8Bl9CxjewX+D5QFXgicGjpBVYIeuW2E64QFyfGv/Zc1OtM
	Q5/RxLMTeAqa9riW3WHZKf5JjMygNAjg6nt823myJHcbpyaRE+/5sL48sz3fDb8NjdfNFzLR3GG
	VbDFRHwxyGD5k0P33RNr5CFs8rcggpr+vE5N7q69ZBnCEIIBjKiL43xaDpX3LsJ8317czmTvcEX
	qkMwlPLIGuS7avgTPzS8+0naUujhGOYjv07OnBzznUDBdY1pUnb5AbisDT9zfTCD5x85YZ9zhpz
	fpBQFqfv55ATZn47Oo3s3p/lGwfk9ptab7irNmOybMXrkJJ/CY6dLQPtCqJ9v1UO9PnS1C0/UW1
	qT2kc9PYKrbD4a5RnyiCKwo+VkAFrwCuxw21aGIo2txBT3hhZKcIvElXea1AN8aY/YotjNY6Jxi
	U/rifSVmnHZRij4hQhJwhuLXbUjSr5nOInMuEmIYI4Ihc/P/oTvGEwUirbFWndMQK10PycpWBBM
	auY
X-Google-Smtp-Source: AGHT+IFJAsN22RzEZGX9qXHrJTseEBNmURBALNvMji0DSxk8mi2vxAkq0iZRnzEUXZZujDM5omoPXg==
X-Received: by 2002:a17:90b:1fc7:b0:321:38a:229a with SMTP id 98e67ed59e1d1-32d43ef084fmr19911611a91.7.1757518272964;
        Wed, 10 Sep 2025 08:31:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-775f6b42023sm2592143b3a.87.2025.09.10.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:31:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 08:31:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 3/5] team: use common function to compute the
 features
Message-ID: <aMGZwEnJ943Rwf-Q@mini-arch>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909081853.398190-4-liuhangbin@gmail.com>

On 09/09, Hangbin Liu wrote:
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
>  drivers/net/team/team_core.c | 78 +++---------------------------------
>  1 file changed, 5 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 17f07eb0ee52..c5fbe392fc62 100644
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
> @@ -1976,27 +1919,16 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
>  
>  	err = team_port_add(team, port_dev, extack);
>  
> -	if (!err)
> -		netdev_change_features(dev);
> -
>  	return err;

do the same `return team_port_add` here as you do in team_del_slave?

