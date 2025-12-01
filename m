Return-Path: <linux-kselftest+bounces-46809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41773C97E56
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 15:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022D03A350F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9643195E6;
	Mon,  1 Dec 2025 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRtegR7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64728BA95;
	Mon,  1 Dec 2025 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600484; cv=none; b=NLu+jCl1SrysAR8SG/CYlr7JKNKn49dGvcAY4LZ9w9sN0Ihe5jlLjZEsVqmhJfxCDcdgXrIkKsAzWySdxgYZr76oluf4YLTxUz5I89wHUZBZ775xscqtIV3jEUgu9oVeK7DtGu5q0hXdUy/5hkw6pMHG4+0NkxswaQL1/IVq3wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600484; c=relaxed/simple;
	bh=sHeFdN53jSp7ITbkpxqG8nQwDInFfPwljVAM7N25H+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrW0dlZeimH+KtSSQaNipFlOpt/E6wkvFv/ynBuil+6z+/+T4e7374A9uqjRWDduVddowJLcJpg3ChJaPiGoOEKLBD/1+/Oqhy/di+Aeb5aEl3qZCG57O37/niPixU/X0oXBw17thfU2BCOjOBnaInb4wwKJ73Xx/ro3CXFuF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRtegR7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD9AC4CEF1;
	Mon,  1 Dec 2025 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764600483;
	bh=sHeFdN53jSp7ITbkpxqG8nQwDInFfPwljVAM7N25H+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRtegR7+mYHDNv63syP0L8Yus4GOVSjVEY/PbUsmYaqoM+RwrsngtVGeytmR3vYWu
	 pFe0GhoQNBJRCqXJbqNnIKoQDqinhHMn7YDvUlhZDCzXgUlKSl4pxy3VBq6gCkiMnp
	 WCnlQNAjGuZBBKcnvLIckAkrV1qd4JMGEnySoIN+bhH6zZ9gDf4M9WQkmKCUl9/ZwE
	 /PVBLU8xuFjmHTEMLvqXAVdJtguPux0mg0sOkxmy8Wxla5QOTlR4TCePRPvpWRlqRz
	 0F4SPqONaE2z+1XCoLXICjP9kr2xqu51kvWvH9mXz4K0HQqClp5FknH+ie593/DwlU
	 P3aisBRfsX6GA==
Date: Mon, 1 Dec 2025 14:47:59 +0000
From: Simon Horman <horms@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC/RFT net-next v2 1/5] net: dsa: deny bridge VLAN with
 existing 8021q upper on any port
Message-ID: <aS2qnzL2WC-sFlnJ@horms.kernel.org>
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
 <20251201102817.301552-2-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201102817.301552-2-jonas.gorski@gmail.com>

On Mon, Dec 01, 2025 at 11:28:13AM +0100, Jonas Gorski wrote:

...

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index f59d66f0975d..fa1fe0f1493a 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c
> @@ -653,21 +653,30 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
>  
>  /* Must be called under rcu_read_lock() */
>  static int
> -dsa_user_vlan_check_for_8021q_uppers(struct net_device *user,
> +dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
>  				     const struct switchdev_obj_port_vlan *vlan)
>  {
> -	struct net_device *upper_dev;
> -	struct list_head *iter;
> +	struct dsa_switch *ds = dp->ds;
> +	struct dsa_port *other_dp;
>  
> -	netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
> -		u16 vid;
> +	dsa_switch_for_each_user_port(other_dp, ds) {
> +		struct net_device *user = other_dp->user;

Hi Jonas,

The AI robot is concerned that user may be NULL here.
And I can't convince myself that cannot be the case.

Could you take a look?

https://netdev-ai.bots.linux.dev/ai-review.html?id=3d47057e-e740-4b66-9d60-9ec2a7ee92a1#patch-0

> +		struct net_device *upper_dev;
> +		struct list_head *iter;
>  
> -		if (!is_vlan_dev(upper_dev))
> +		if (!dsa_port_bridge_same(dp, other_dp))
>  			continue;
>  
> -		vid = vlan_dev_vlan_id(upper_dev);
> -		if (vid == vlan->vid)
> -			return -EBUSY;
> +		netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
> +			u16 vid;
> +
> +			if (!is_vlan_dev(upper_dev))
> +				continue;
> +
> +			vid = vlan_dev_vlan_id(upper_dev);
> +			if (vid == vlan->vid)
> +				return -EBUSY;
> +		}
>  	}
>  
>  	return 0;

...

