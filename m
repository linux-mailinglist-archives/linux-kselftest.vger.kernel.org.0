Return-Path: <linux-kselftest+bounces-43131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9A2BD9D8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E170E3BE935
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E50313552;
	Tue, 14 Oct 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nedNbgJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F326E701;
	Tue, 14 Oct 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450549; cv=none; b=Y+Zqf+JVWga+1uKvT/v9a777A9hC9DcitaZ56HrIt8zjv4syhxxngf32s4f+xJp4AQPSCDC9i1enck/TxkQR0s9MFnVuAoapl5lUD266BXOK/qNoCapo1LuuxL0ASlv6VYxK07cfgClnFl/PJBk9OYgqKOMChoTt8L0AqNsvS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450549; c=relaxed/simple;
	bh=gIcKOwx7EBDgW8Sx478GJcKsfrDPtNKXx+9x9gVAaNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUZzrAhuna4iwpAcgqIm5baVTACq7QtMj6ay18TKL0D5FW7b4uanHPt9BNoZ/SrY2hQhb+4UAs5XMytb0doB8jwtfJ5Tlf8h5OVFMAAT2Xmd0DLnPhZRhedNBYzxOvktu+lQJ6usluljC/VLq2KOAxKdXRHX6dnqqH+okdVBuXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nedNbgJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07C1C4CEE7;
	Tue, 14 Oct 2025 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760450549;
	bh=gIcKOwx7EBDgW8Sx478GJcKsfrDPtNKXx+9x9gVAaNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nedNbgJFCTR6PipWLNxn35PwEW/5hZVqWfKAmrr3PQTFbhqOtXh31W1eTJt64QDus
	 xvMIKJU/k6xj78Ekk3e12lofNXOkh7w+qaf7Hdp6SgQPx9MjfdIimwYCqNBb7zuGwi
	 r8Sns5mQq9jdDdi9Y8VTVT7tOEH9+AyyXfMoVm1N8kcbZ0243CKWDRkZimAmcJWSNj
	 nnnEi+xwdKvIudYbEO5BlLGsjW2F6dIWlvVrvJlfPOmCiikS9AN3CYnqnwnUlsysO4
	 /fDtRzrpbVjKaaUnLOVBge7UDWVynh6unm/MWnT5u7pnUXDKUvW1Roy9MvvuuTEwOB
	 ghx4UEbVOAg2g==
Date: Tue, 14 Oct 2025 15:02:23 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aO5X7368r8veRe5J@horms.kernel.org>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014080217.47988-2-liuhangbin@gmail.com>

On Tue, Oct 14, 2025 at 08:02:14AM +0000, Hangbin Liu wrote:

...

> diff --git a/net/core/dev.c b/net/core/dev.c
> index a64cef2c537e..54f0e792fbd2 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -12616,6 +12616,101 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
>  }
>  EXPORT_SYMBOL(netdev_increment_features);
>  
> +/**
> + *	netdev_compute_features_from_lowers - compute feature from lowers
> + *	@dev: the upper device
> + *	@update_header: whether to update upper device's header_len/headroom/tailroom
> + *
> + *	Recompute the upper device's feature based on all lower devices.
> + */
> +void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
> +{
> +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	netdev_features_t xfrm_features = VIRTUAL_DEV_XFRM_FEATURES;
> +#endif

Hi Hangbin,

It would be nice to avoid the #ifdefs in this function.

Could xfrm_features be declared unconditoinally.
And then used behind if(IS_ENABLED(CONFIG_XFRM_OFFLOAD)) conditions?
This would increase compile coverage (and readability IMHO).

> +	netdev_features_t mpls_features = VIRTUAL_DEV_MPLS_FEATURES;
> +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> +	netdev_features_t enc_features = VIRTUAL_DEV_ENC_FEATURES;
> +	unsigned short max_header_len = ETH_HLEN;
> +	unsigned int tso_max_size = TSO_MAX_SIZE;
> +	u16 tso_max_segs = TSO_MAX_SEGS;
> +	struct net_device *lower_dev;
> +	unsigned short max_headroom;
> +	unsigned short max_tailroom;
> +	struct list_head *iter;
> +
> +	mpls_features = netdev_base_features(mpls_features);
> +	vlan_features = netdev_base_features(vlan_features);
> +	enc_features = netdev_base_features(enc_features);
> +
> +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> +		gso_partial_features = netdev_increment_features(gso_partial_features,
> +								 lower_dev->gso_partial_features,
> +								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
> +
> +		vlan_features = netdev_increment_features(vlan_features,
> +							  lower_dev->vlan_features,
> +							  VIRTUAL_DEV_VLAN_FEATURES);
> +
> +		enc_features = netdev_increment_features(enc_features,
> +							 lower_dev->hw_enc_features,
> +							 VIRTUAL_DEV_ENC_FEATURES);
> +
> +#ifdef CONFIG_XFRM_OFFLOAD
> +		xfrm_features = netdev_increment_features(xfrm_features,
> +							  lower_dev->hw_enc_features,
> +							  VIRTUAL_DEV_XFRM_FEATURES);
> +#endif
> +
> +		mpls_features = netdev_increment_features(mpls_features,
> +							  lower_dev->mpls_features,
> +							  VIRTUAL_DEV_MPLS_FEATURES);
> +
> +		dst_release_flag &= lower_dev->priv_flags;
> +
> +		if (update_header) {
> +			max_header_len = max_t(unsigned short, max_header_len,
> +					lower_dev->hard_header_len);

Both the type of max_header_len and .hard_header_len is unsigned short.
So I think max() can be used here instead of max_t(). Likewise for the
following two lines.

> +			max_headroom = max_t(unsigned short, max_headroom,
> +					lower_dev->needed_headroom);

Max Headroom [1] is used uninitialised the first time we reach here.
Likewise for max_tailroom below.

[1] https://en.wikipedia.org/wiki/Max_Headroom

Flagged by Smatch.

> +			max_tailroom = max_t(unsigned short, max_tailroom,
> +					lower_dev->needed_tailroom);
> +		}
> +
> +		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
> +		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
> +	}
> +
> +	dev->gso_partial_features = gso_partial_features;
> +	dev->vlan_features = vlan_features;
> +	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> +				    NETIF_F_HW_VLAN_CTAG_TX |
> +				    NETIF_F_HW_VLAN_STAG_TX;
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	dev->hw_enc_features |= xfrm_features;
> +#endif
> +	dev->mpls_features = mpls_features;
> +
> +	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> +	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
> +	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
> +		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
> +
> +	if (update_header) {
> +		dev->hard_header_len = max_header_len;
> +		dev->needed_headroom = max_headroom;
> +		dev->needed_tailroom = max_tailroom;

Also, maybe it can't happen in practice. But I think that max_headroom and
max_tailroom will may be used uninitialised here if the previous
'update_header' condition is never reached/met.

Also flagged by Smatch.

> +	}
> +
> +	netif_set_tso_max_segs(dev, tso_max_segs);
> +	netif_set_tso_max_size(dev, tso_max_size);
> +
> +	netdev_change_features(dev);
> +}
> +EXPORT_SYMBOL(netdev_compute_features_from_lowers);
> +

...

