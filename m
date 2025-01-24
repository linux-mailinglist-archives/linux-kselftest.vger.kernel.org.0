Return-Path: <linux-kselftest+bounces-25079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E9A1B31E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 10:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8F67A1C59
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7459421A433;
	Fri, 24 Jan 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irtemr4q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517923A0;
	Fri, 24 Jan 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712503; cv=none; b=CGUw/3stGc6vXKf9Fk9+WnGus23doxdc4oQH2W3ZQ2sWPtwsD1ht5d+FHmssYg51jg+5KlsadY9yMGLM9UB2Ga3qSpDtdAbJfYG6xempe+59U9t7N01OO4rmtaCP7reouUGxSLjCEh/myoPZdthHVvPVenKQmG7YUneWKoEFlhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712503; c=relaxed/simple;
	bh=ekBEzqmHVXsoFkfZ4bhPvyOWlylLl9N7yx+UMLISzYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f//v1/RkKIC3wTiGG3dOK6a8VcnHpKSWYsMlYW2VPRZmYkFIWL4SN5p0OiBjfRpRQJh3v2sAHGeXthdZTWfaBau48n3O+qygV6Ur/t50DWP8/KRdkIZkgV8kdyibrFe9KKDn9k8gBCshs1dwKcp3Txvr6N+VJT9HZpwbANs5bJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irtemr4q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644aca3a0so42346925ad.3;
        Fri, 24 Jan 2025 01:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737712501; x=1738317301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BIZkkKYWnNXZKqM/WO2iIxrtrYS3Hgl4WpBTQkCIUpA=;
        b=irtemr4qdzUq57ROA3onXKjcQdbRqY+BOEolJB5sRXscyXCa1FCrj3r/v6jB07FS22
         3OgsREGHS/vjlQV/vNzukGFjbGiDxBXyzAG52BGLqFJm1lgf/UL5m/u4/EsCp6JjTWO7
         LrCyp1vuEedkmrtuGy3F1AdLFzK5caBPElcMenFO7AkvdPtaYbA1I/X9KKYuzYQ9cxa1
         OQO8M3LzwqvpK6ygBDQyx9joCczASDUOGI3AoYRGmsmIMWEb7v8BdswmjRzR+mXhpxON
         EzKTraCN30NVCrsXyv5iuWr30N8mCy2tzXrMX3n04/nkIrPZOCQRxUQCxKWuwjYFgLJX
         7u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737712501; x=1738317301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIZkkKYWnNXZKqM/WO2iIxrtrYS3Hgl4WpBTQkCIUpA=;
        b=KEoqwRdZQ2/y/f2bEJLcQWgT/+ZCDs0bCvt16lPg0gAbM8qlnVy0yvr5dnK2mufZYS
         yoPSGtpLtStdjGIfzHbvUyebsivkCEvZe2OljYrEm3EJUndGG26R6yv3wd1kgti804mQ
         pMRurekhPfBr0MRzO93lZupVKOPxZic/6kqYWSZJ/aLB2vJWoFebE3dL9QjSKLPBUGVa
         cf/GorWO81LO/ZVJjD3c0CSEnyvamyBHoQw+0Krb3seEkGokeUNIxw/auormt8P+C2OI
         euYQPUSpj1Di0WY6O11u/fVdlSKOBAoj7nDaaYjq88hjV1aOOz2znmhq+dmqlz+7QB9F
         q3+g==
X-Forwarded-Encrypted: i=1; AJvYcCXE1FOgffrtwbTEqu9iqwN/lSvsEtu9UB5SQtAx8X4KrKniPeXPvZBZaQPPQMFIyEtRhpAyuL0kYPPz+c5nxMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQOMuyNYQF9OXYf68pZiq4N6lTgbtglLF3cB6qOO9n2sbm1qU
	8IgKC5A79A3w29I9f6b4kXJTurZiJT55m1VNwTSlF0vou+iz9K5+
X-Gm-Gg: ASbGncsTlrmFp7viK11o+8veJgRPCvwAc3APPjO1pC8+itJp0O/OJCo1j8e490LdfRM
	kCE6fxaszZFP4RnvR/gqwjxxc2vDenkK2ftyRTXlWsmX1lAUiGtA9Ni05baA2s8QcL1BqSs4HBP
	TYNQ/VsRu9G5Z7ysgNLBoVbgaMgZI2HN1Ijk0tq0t7N9qDS1or13Sa9T6CKAZVsRaxhQsC9ov6J
	MFtUvrymfzORzYtnTSH+S830bMBKz3N28e95LYvaLg1rrybFsKecGvPA5OVuqtEiNhfSmkpHP3K
	g/pzuEfjOA==
X-Google-Smtp-Source: AGHT+IH/OqXcULIPeM7OIDOkr2Io3BTjD+TdF2pZ2fi0Hg5/ik4B72Pnjn7Jlv6nouU6xkrXuFyo/g==
X-Received: by 2002:a17:902:d2d2:b0:215:b01a:627f with SMTP id d9443c01a7336-21c352de4c0mr463179785ad.4.1737712501118;
        Fri, 24 Jan 2025 01:55:01 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414dd18sm12567805ad.184.2025.01.24.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:55:00 -0800 (PST)
Date: Fri, 24 Jan 2025 09:54:53 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, linux-kselftest@vger.kernel.org,
	Liang Li <liali@redhat.com>
Subject: Re: [PATCH net v2] bonding: Correctly support GSO ESP offload
Message-ID: <Z5Njbd8-ieEcbAEV@fedora>
References: <20250124085744.434869-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124085744.434869-1-cratiu@nvidia.com>

On Fri, Jan 24, 2025 at 10:57:44AM +0200, Cosmin Ratiu wrote:
> ---
>  drivers/net/bonding/bond_main.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7b78c2bada81..e45bba240cbc 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1538,17 +1538,20 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
>  				 NETIF_F_HIGHDMA | NETIF_F_LRO)
>  
>  #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> -				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)
> +				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
> +				 NETIF_F_GSO_PARTIAL)
>  
>  #define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
>  				 NETIF_F_GSO_SOFTWARE)
>  
> +#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> +
>  
>  static void bond_compute_features(struct bonding *bond)
>  {
> +	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
>  	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
>  					IFF_XMIT_DST_RELEASE_PERM;
> -	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
>  	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
>  	netdev_features_t enc_features  = BOND_ENC_FEATURES;
>  #ifdef CONFIG_XFRM_OFFLOAD
> @@ -1582,8 +1585,9 @@ static void bond_compute_features(struct bonding *bond)
>  							  BOND_XFRM_FEATURES);
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  
> -		if (slave->dev->hw_enc_features & NETIF_F_GSO_PARTIAL)
> -			gso_partial_features &= slave->dev->gso_partial_features;
> +		gso_partial_features = netdev_increment_features(gso_partial_features,
> +								 slave->dev->gso_partial_features,
> +								 BOND_GSO_PARTIAL_FEATURES);
>  
>  		mpls_features = netdev_increment_features(mpls_features,
>  							  slave->dev->mpls_features,
> @@ -1598,12 +1602,8 @@ static void bond_compute_features(struct bonding *bond)
>  	}
>  	bond_dev->hard_header_len = max_hard_header_len;
>  
> -	if (gso_partial_features & NETIF_F_GSO_ESP)
> -		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
> -	else
> -		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
> -
>  done:
> +	bond_dev->gso_partial_features = gso_partial_features;
>  	bond_dev->vlan_features = vlan_features;
>  	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
>  				    NETIF_F_HW_VLAN_CTAG_TX |

        if (!bond_has_slaves(bond))
                goto done;

If there is no slaves, should we add the gso_partial_features?

Thanks
Hangbin
> @@ -6046,6 +6046,7 @@ void bond_setup(struct net_device *bond_dev)
>  	bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
>  	bond_dev->features |= bond_dev->hw_features;
>  	bond_dev->features |= NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX;
> +	bond_dev->features |= NETIF_F_GSO_PARTIAL;
>  #ifdef CONFIG_XFRM_OFFLOAD
>  	bond_dev->hw_features |= BOND_XFRM_FEATURES;
>  	/* Only enable XFRM features if this is an active-backup config */
> -- 
> 2.45.0
> 

