Return-Path: <linux-kselftest+bounces-40900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C6B4785C
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 02:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA7202A9A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 00:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955731A58D;
	Sun,  7 Sep 2025 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaONZwU6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8823741;
	Sun,  7 Sep 2025 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757204578; cv=none; b=EsqwkchqNfTOf5H/WMQWzsBG20Tk0SO+rJhDrIDOLWX2M+rfND/EGSEU7fuuv9Ib1T7WyCE0wK2z3shK5JEDEsQJMaY4r4wZU6inuzhX1wvZScwjxaEbyxGAI0/8M7UXWJTOrKSEFujvMW8OxyOpitidO3Fwu4nz66lQhxx3CWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757204578; c=relaxed/simple;
	bh=aznrg/OGqPa40peqPhI3tP0psk9VK9iCdIlKkG+46vI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbL7fwntjzLpk6z4wxaxZDF3LwhYzK1bns2DEykgOOMRkKJWGk3QK90nRn7LcBPcv767JxTShlFLMMES4keLU+nOeHhx2EYO6HLkfH73w+TcOwmZmtx2sVyTHBByRJo4Dc702+oAtl6RITXTrS/sfOHl/vIJhrJIEhSSKELvgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaONZwU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48914C4CEE7;
	Sun,  7 Sep 2025 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757204577;
	bh=aznrg/OGqPa40peqPhI3tP0psk9VK9iCdIlKkG+46vI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GaONZwU6zwuu1VOquhmYsJzWh0CiaIGsHBgSdV1NNSzAMEDYCQy6uxJgAuU9aUSIZ
	 FfdnMV55JroPPAPL9dhZbjSkUQ8BY7jk63sp5Wd4nLGI3B5fTlAQPZahN87lq51+fP
	 DPlIrhK2mZGaymUcUTmjTk9HCNM0onA48zGS9pymkcJiiOShwWD4Iy99nbRh4lDdjp
	 p0GPyYE2UOSJkyzRWzqYWF5zM0BJLbTNVkxccaBT+zGKbgC7CYIUCRHEwaP2Y9x4j+
	 mDxj5Gygd6FvDOhm2AXxLtW2hPvqolEColzYiGYNTWVnL9osXnie8LyAIg+P/XZGZD
	 KJEuNphxM9V2Q==
Date: Sat, 6 Sep 2025 17:22:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sabrina
 Dubroca <sdubroca@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Shuah Khan
 <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima
 <kuniyu@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 1/5] net: add a common function to compute
 features from lowers devices
Message-ID: <20250906172256.1571f8f9@kernel.org>
In-Reply-To: <20250902072602.361122-2-liuhangbin@gmail.com>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
	<20250902072602.361122-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 07:25:58 +0000 Hangbin Liu wrote:
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
>  void netdev_update_features(struct net_device *dev);
>  void netdev_change_features(struct net_device *dev);
>  
> +/* netdevice features */
> +#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> +					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> +					 NETIF_F_GSO_ENCAP_ALL | \
> +					 NETIF_F_HIGHDMA | NETIF_F_LRO)
> +
> +#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> +					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
> +					 NETIF_F_GSO_PARTIAL)
> +
> +#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> +					 NETIF_F_GSO_SOFTWARE)
> +
> +#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
> +					 NETIF_F_GSO_ESP)
> +
> +#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> +void netdev_compute_features_from_lowers(struct net_device *dev);

Isn't this what the ALL_FOR_ALL, ONE_FOR_ALL etc. flag sets were
supposed to also achieve? Please try to move the new code closer
to those, both in terms of where they are defined and naming...

