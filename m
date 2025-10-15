Return-Path: <linux-kselftest+bounces-43161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0C5BDC3FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 05:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14E5421B60
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 03:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF302571B8;
	Wed, 15 Oct 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBJovzoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890487263E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497425; cv=none; b=j6ZTaTOrjeFqZRDpu305f5WcnH678PkSgtA1JIxeWmPeNvUVI61lIwnOwHP3u9bUUxX6larWjX2pyuA2ARCfJBxgEtGhz2VT6AjZUOIcuKBkpccGAvrc12mBVTdsLjJLCaMlGJTbviuEpA1Z2UmazzfET0jfb89cBwCT6uf6h5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497425; c=relaxed/simple;
	bh=IKc+jkIsO9mgc1GUn3H5nunONRgZo9m8m6soz3UG1+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/fkqhOcoGjkzOEsoe0i4zp02WPLJpjGhWMDpDUKoid038VzCO7ABsSUWzyLLtMwsAuecvh0skiE/YmHMz0A8UPXLa2cXZoHkWDvc+KYLJPvUsRuihyBwslZElAfVXXW7rPuxJKDykmE7Lx0KYjgqNOOQu6Kpjd7M3Co6unoro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBJovzoS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b60971c17acso4797828a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760497422; x=1761102222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJRtMauxgy5L7Cll4qsdqgeV1KauSjYifSS43lZLtuI=;
        b=LBJovzoSqKf9udA9UVg1Cvs40Lg3rqzWMX4+mjgwALr7lGviVDbLiAAlBZVS/2J6Rl
         JrImUUk/S9W4si2WQzt4wNjVXPN2yRtX6hxFT8tr2z26ZgprQvBmoMcbf9lUNXCb0wj+
         AvKiRAsjOEzZI+9HUImYm7N4W1imwYU7CQaGjAAFi5EWPwSy2wkm4q/kp5T8NpUcrem3
         muZ4ijrnu5kc0HgnpVszC9irmF93um5fceZ2E5eJcNZ86K8yJMaGPHs7y53yo5Yn2HEp
         6xC+w7BKssxUZFeitSc6udwqnjCLJIMu/DvcFquuEREM0oldecMBPDyS/ihMtgPiQLne
         hd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760497422; x=1761102222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJRtMauxgy5L7Cll4qsdqgeV1KauSjYifSS43lZLtuI=;
        b=MjuB7YKGFBM3w0YEA7QApnc3a3OHDnJDlStuTxGY/5N6wASe6dmcrttQR2TF6mY7VF
         uqnFQ6APLH4/pkNotXkTIyubz/WWwYj0W8FVWn/2UiTKyRKQz378ZgoBknF7xKeqtVaE
         8GGWiG4JwORYd2OrIOSyB74hph7kMFjQtaALsJ3el5xNfe+Zc5XwdSAm5+pSJP4Xo5OM
         LxIj4dKsFZTQWT3ptvYMY86NBMMPvS/3LixGf9JYMV28z7/FjZJ99pingLTI0mbsbmRq
         VvSEsDQjRFltyNGaUBh5fHzrI5LPfOFODgItNuCxbKO/lDnxUK1dwboWD4fYlab2hBTk
         3TAw==
X-Forwarded-Encrypted: i=1; AJvYcCUtnd5rcsTMm7lQHAM59aQHcFJcN0UcijBb9V9dh3e/uiIX51IYlLo8ifO9mWD628TFSJOaygRl2Ilbhn2mso8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBF/Py8hbFIghJKYsCwlF6XoKtceKxTNrjj83mRoz8v3YiW+Zg
	WiupGNBg9ODefbQpxZMv8zQ98DgwJKc5IZKONA5O6JERZjkDbb63GoKm
X-Gm-Gg: ASbGncvh3qPZdmaOwQcCKoYn8E7VlcLZRCS3vkBqGxgZngcj6beKW+kicgV0CKSozyX
	U3P34MsKwhrIlywbrKUiBWjiDmMS9rwZa151us5Dk9o+YJg2aOp0NBBmRsNJzZKm4ljSOBIo1Nf
	PUhMaUqqage7m5F0czjhoT6JDAGTjNwTMVwT5z+L1aKiBp1nluRMULHEvZnVVJgMvzJz/t+yLxC
	393mFEMhCOqj+IIDFSGoEJ/rpsKbtM6lTgCybN7HsZtH+m7/Ho8wezUItrkzPc2k+DBulQYP7qJ
	T+8Q8AlrM+yZsuBaclGAQQe/jYzX5cqhsfS2iFkacCZ4rknlpslTpzXIRJw6aEvlm6NG3X8QyKv
	7427ftYCvj7Th0ag62kNlvGKGDBPRX5DovuhuMSNz0GsJlA==
X-Google-Smtp-Source: AGHT+IGeFwOgcx2BiZRTvdSnQWCMeJtnp0M7gNlhEon3I1UQqUGSTj5fxR7SdCplRAQzjxgQdmFNIA==
X-Received: by 2002:a17:902:d58f:b0:290:2735:7285 with SMTP id d9443c01a7336-2902735728emr343125225ad.47.1760497422453;
        Tue, 14 Oct 2025 20:03:42 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08de5sm180126235ad.83.2025.10.14.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 20:03:41 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:03:32 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
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
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aO8PBOMk_EqyaGKN@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <aO5X7368r8veRe5J@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5X7368r8veRe5J@horms.kernel.org>

Hi Simon,

Thanks for the comments, I will fix all of them.

Regards
Hangbin
On Tue, Oct 14, 2025 at 03:02:23PM +0100, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 08:02:14AM +0000, Hangbin Liu wrote:
> 
> ...
> 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a64cef2c537e..54f0e792fbd2 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -12616,6 +12616,101 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
> >  }
> >  EXPORT_SYMBOL(netdev_increment_features);
> >  
> > +/**
> > + *	netdev_compute_features_from_lowers - compute feature from lowers
> > + *	@dev: the upper device
> > + *	@update_header: whether to update upper device's header_len/headroom/tailroom
> > + *
> > + *	Recompute the upper device's feature based on all lower devices.
> > + */
> > +void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
> > +{
> > +	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
> > +	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	netdev_features_t xfrm_features = VIRTUAL_DEV_XFRM_FEATURES;
> > +#endif
> 
> Hi Hangbin,
> 
> It would be nice to avoid the #ifdefs in this function.
> 
> Could xfrm_features be declared unconditoinally.
> And then used behind if(IS_ENABLED(CONFIG_XFRM_OFFLOAD)) conditions?
> This would increase compile coverage (and readability IMHO).
> 
> > +	netdev_features_t mpls_features = VIRTUAL_DEV_MPLS_FEATURES;
> > +	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
> > +	netdev_features_t enc_features = VIRTUAL_DEV_ENC_FEATURES;
> > +	unsigned short max_header_len = ETH_HLEN;
> > +	unsigned int tso_max_size = TSO_MAX_SIZE;
> > +	u16 tso_max_segs = TSO_MAX_SEGS;
> > +	struct net_device *lower_dev;
> > +	unsigned short max_headroom;
> > +	unsigned short max_tailroom;
> > +	struct list_head *iter;
> > +
> > +	mpls_features = netdev_base_features(mpls_features);
> > +	vlan_features = netdev_base_features(vlan_features);
> > +	enc_features = netdev_base_features(enc_features);
> > +
> > +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> > +		gso_partial_features = netdev_increment_features(gso_partial_features,
> > +								 lower_dev->gso_partial_features,
> > +								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
> > +
> > +		vlan_features = netdev_increment_features(vlan_features,
> > +							  lower_dev->vlan_features,
> > +							  VIRTUAL_DEV_VLAN_FEATURES);
> > +
> > +		enc_features = netdev_increment_features(enc_features,
> > +							 lower_dev->hw_enc_features,
> > +							 VIRTUAL_DEV_ENC_FEATURES);
> > +
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +		xfrm_features = netdev_increment_features(xfrm_features,
> > +							  lower_dev->hw_enc_features,
> > +							  VIRTUAL_DEV_XFRM_FEATURES);
> > +#endif
> > +
> > +		mpls_features = netdev_increment_features(mpls_features,
> > +							  lower_dev->mpls_features,
> > +							  VIRTUAL_DEV_MPLS_FEATURES);
> > +
> > +		dst_release_flag &= lower_dev->priv_flags;
> > +
> > +		if (update_header) {
> > +			max_header_len = max_t(unsigned short, max_header_len,
> > +					lower_dev->hard_header_len);
> 
> Both the type of max_header_len and .hard_header_len is unsigned short.
> So I think max() can be used here instead of max_t(). Likewise for the
> following two lines.
> 
> > +			max_headroom = max_t(unsigned short, max_headroom,
> > +					lower_dev->needed_headroom);
> 
> Max Headroom [1] is used uninitialised the first time we reach here.
> Likewise for max_tailroom below.
> 
> [1] https://en.wikipedia.org/wiki/Max_Headroom
> 
> Flagged by Smatch.
> 
> > +			max_tailroom = max_t(unsigned short, max_tailroom,
> > +					lower_dev->needed_tailroom);
> > +		}
> > +
> > +		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
> > +		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
> > +	}
> > +
> > +	dev->gso_partial_features = gso_partial_features;
> > +	dev->vlan_features = vlan_features;
> > +	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
> > +				    NETIF_F_HW_VLAN_CTAG_TX |
> > +				    NETIF_F_HW_VLAN_STAG_TX;
> > +#ifdef CONFIG_XFRM_OFFLOAD
> > +	dev->hw_enc_features |= xfrm_features;
> > +#endif
> > +	dev->mpls_features = mpls_features;
> > +
> > +	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
> > +	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
> > +	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
> > +		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
> > +
> > +	if (update_header) {
> > +		dev->hard_header_len = max_header_len;
> > +		dev->needed_headroom = max_headroom;
> > +		dev->needed_tailroom = max_tailroom;
> 
> Also, maybe it can't happen in practice. But I think that max_headroom and
> max_tailroom will may be used uninitialised here if the previous
> 'update_header' condition is never reached/met.
> 
> Also flagged by Smatch.
> 
> > +	}
> > +
> > +	netif_set_tso_max_segs(dev, tso_max_segs);
> > +	netif_set_tso_max_size(dev, tso_max_size);
> > +
> > +	netdev_change_features(dev);
> > +}
> > +EXPORT_SYMBOL(netdev_compute_features_from_lowers);
> > +
> 
> ...

