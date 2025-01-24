Return-Path: <linux-kselftest+bounces-25087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DB7A1B472
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3891188CCF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14221A424;
	Fri, 24 Jan 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY/ud89X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57DE23B0;
	Fri, 24 Jan 2025 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717040; cv=none; b=P9+FCMV3+9si63Do46G4J7QYqytvUQy6eRkbRyWz6RB5gSR0VG4Sl40W2+01s0SbnJjYasxDJRetGliIhJdovvDRg1fsg8KJ3zugsmddcTo6Ar9pjPQZssqfrbBa4jWHfPyyHYWdcfAmRJOgSD59Ww69ncpGqpyHlRMz3Vb9DrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717040; c=relaxed/simple;
	bh=D3nxBSAmFJS1ZYIFtB7ERBcKeGplwhffAUcJb4JAutU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2qWGn70gnlTrASPY70nWq+11q/Du2JGBCVPBKE6gKjYXVuBQ+qSgL+bMSyFtW/HTHK8iAi5FXIlmOgx3KoJYsFD0vDmbE7ISnt/wy6X4VYjnwknNjaNWkZGgu3qBvBsRjYI8VN8pxFbA6s2UmsysUf+kzh7O0qqUK7tnhdCYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY/ud89X; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21636268e43so42059755ad.2;
        Fri, 24 Jan 2025 03:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737717038; x=1738321838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kuiDC4Ce5yx1PUIsFy9n/ZgbqFYaXydoqCv8HLU67i0=;
        b=SY/ud89XNjmq1CDN2AaSMPEjBzvXFZsNgof6Ll/+KzpQ1vi8RTH3DR4CZxtpr2MRpy
         QvzL6r42KkeL60YQGLN3jLVQwC3WnLGekS/QvrNTU6DchOy6IxLOSM7XMKsSrMwMIqSH
         DUDsq0pmJ7p5Dj693sRwniKIt0vugqE1eou4OgsmYznEa7aQaw0RoLS9Vuq1PDeZs576
         UT7B1AYaSF+0+MBf51QjXX1I4hQxaJO/A4kX4y5FhJHha0ykHGm9KUAVDj8jTKnTCjk7
         0rk3U4JQWqR5JCDKzezLya+UkufjL/B61UYmLai9arwuOPQp0USNUmWHBXHXq0X7fHyR
         ya1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717038; x=1738321838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuiDC4Ce5yx1PUIsFy9n/ZgbqFYaXydoqCv8HLU67i0=;
        b=C5Qcrb3aG8oETI2GZNVcaIgqeVU1hWlZmG2E2TVTPWH5a0e+D5KuOsN7zQx/KTaNuv
         I0dpIhicGWzd65t7BDkrCs9OfXKoUojzxYf5Z55xIkv6dstoOCJ0CA8rpS2fD6GcQWDQ
         8xO4DDWo7d89fV8JEzlhQevF5UXS03Eg7wVnZcKcz7q2jaGGVdRM/TnzSXSdrICowJFb
         5hUmYmldFQdIdgQ810O/jGicrEAWPfybE314l2rxkdewYTnoJyKZU6p12qQIduwWCdUq
         HKQMM0apNysdhM39lJx5gQHbI/XFbEkXcMlaK4Ufwnj+LMWq6QD9UGgpvhnIrZVASUH8
         WW9w==
X-Forwarded-Encrypted: i=1; AJvYcCWBMaAtzDs1MCiFN8TKECCy/9wnr27yUmHrlPAsTOkavnuame+DqCdBL/ZTP8pOQ/3sPJJX7h84@vger.kernel.org, AJvYcCXQOPlSW5+c6icpzPb0eNrzZW+lP8jFEimoL+/IpDtIZ7YwxlGoJieCODiIYDZNV3+BaE20wlcUd7uiDSzW6cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykNfsQw5nZgl0lRpTKpotsPBwmQcoyUXoeKQ15phRvMc6Zg2T0
	f3bAbvW80rq8i1JUjbED0pRFYFtNc8V2M8pmrtBzgfp9uxiYFNo0
X-Gm-Gg: ASbGncsaVgTwQa5YamBVqLE+RqCz4MuWgfpYBX/JMeDSJlA0qURx9oV3vi1lKcX6D/S
	HJK0+QRvUQ1OJ9euQn11uLdONJ7Zl5BP6Rri70lgLCHmhJ7YK0kcqH/6A1R/qZlaa7ztZmoyneR
	0WvqS4+A3GAPSmV9AuTqnfb/a226OaI6uT4QhR8eO7oMrn30Ej+XOCYxWtQtlvjSihOrE/Ven4n
	XUtoYHv4zgdWVzX8VqzM7YqYz2DDRRX1MLYEi/e+xGt3I5A6/OtFT00rXFjyO1GqPJmuanLPI4G
	P4koUveazw==
X-Google-Smtp-Source: AGHT+IFjQeGKuP8MS2+YRigvEM4CIUUOSSqsMWYg6pA8Bym0Eunfbv0JIczCZFegBy5/QMuWlWerGQ==
X-Received: by 2002:a05:6a20:840b:b0:1e1:c748:13c1 with SMTP id adf61e73a8af0-1eb215ec017mr42296405637.27.1737717038062;
        Fri, 24 Jan 2025 03:10:38 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78f18asm1597886b3a.177.2025.01.24.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:10:37 -0800 (PST)
Date: Fri, 24 Jan 2025 11:10:30 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "razor@blackwall.org" <razor@blackwall.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"liali@redhat.com" <liali@redhat.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Boris Pismenny <borisp@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net v2] bonding: Correctly support GSO ESP offload
Message-ID: <Z5N1JiVml-YE6L-5@fedora>
References: <20250124085744.434869-1-cratiu@nvidia.com>
 <Z5Njbd8-ieEcbAEV@fedora>
 <2c92e0c58e7d0ab4b06c16f9f1f67f6f9e48d35b.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c92e0c58e7d0ab4b06c16f9f1f67f6f9e48d35b.camel@nvidia.com>

On Fri, Jan 24, 2025 at 10:35:40AM +0000, Cosmin Ratiu wrote:
> On Fri, 2025-01-24 at 09:54 +0000, Hangbin Liu wrote:
> > On Fri, Jan 24, 2025 at 10:57:44AM +0200, Cosmin Ratiu wrote:
> > > ---
> > >  drivers/net/bonding/bond_main.c | 19 ++++++++++---------
> > >  1 file changed, 10 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/net/bonding/bond_main.c
> > > b/drivers/net/bonding/bond_main.c
> > > index 7b78c2bada81..e45bba240cbc 100644
> > > --- a/drivers/net/bonding/bond_main.c
> > > +++ b/drivers/net/bonding/bond_main.c
> > > @@ -1538,17 +1538,20 @@ static netdev_features_t
> > > bond_fix_features(struct net_device *dev,
> > >  				 NETIF_F_HIGHDMA | NETIF_F_LRO)
> > >  
> > >  #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > > -				 NETIF_F_RXCSUM |
> > > NETIF_F_GSO_SOFTWARE)
> > > +				 NETIF_F_RXCSUM |
> > > NETIF_F_GSO_SOFTWARE | \
> > > +				 NETIF_F_GSO_PARTIAL)
> > >  
> > >  #define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
> > >  				 NETIF_F_GSO_SOFTWARE)
> > >  
> > > +#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
> > > +
> > >  
> > >  static void bond_compute_features(struct bonding *bond)
> > >  {
> > > +	netdev_features_t gso_partial_features =
> > > BOND_GSO_PARTIAL_FEATURES;
> > >  	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
> > >  					IFF_XMIT_DST_RELEASE_PERM;
> > > -	netdev_features_t gso_partial_features = NETIF_F_GSO_ESP;
> > >  	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
> > >  	netdev_features_t enc_features  = BOND_ENC_FEATURES;
> > >  #ifdef CONFIG_XFRM_OFFLOAD
> > > @@ -1582,8 +1585,9 @@ static void bond_compute_features(struct
> > > bonding *bond)
> > >  							 
> > > BOND_XFRM_FEATURES);
> > >  #endif /* CONFIG_XFRM_OFFLOAD */
> > >  
> > > -		if (slave->dev->hw_enc_features &
> > > NETIF_F_GSO_PARTIAL)
> > > -			gso_partial_features &= slave->dev-
> > > >gso_partial_features;
> > > +		gso_partial_features =
> > > netdev_increment_features(gso_partial_features,
> > > +								
> > > slave->dev->gso_partial_features,
> > > +								
> > > BOND_GSO_PARTIAL_FEATURES);
> > >  
> > >  		mpls_features =
> > > netdev_increment_features(mpls_features,
> > >  							  slave-
> > > >dev->mpls_features,
> > > @@ -1598,12 +1602,8 @@ static void bond_compute_features(struct
> > > bonding *bond)
> > >  	}
> > >  	bond_dev->hard_header_len = max_hard_header_len;
> > >  
> > > -	if (gso_partial_features & NETIF_F_GSO_ESP)
> > > -		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
> > > -	else
> > > -		bond_dev->gso_partial_features &=
> > > ~NETIF_F_GSO_ESP;
> > > -
> > >  done:
> > > +	bond_dev->gso_partial_features = gso_partial_features;
> > >  	bond_dev->vlan_features = vlan_features;
> > >  	bond_dev->hw_enc_features = enc_features |
> > > NETIF_F_GSO_ENCAP_ALL |
> > >  				    NETIF_F_HW_VLAN_CTAG_TX |
> > 
> >         if (!bond_has_slaves(bond))
> >                 goto done;
> > 
> > If there is no slaves, should we add the gso_partial_features?
> 
> The other partial feature sets are added after 'done:', why not do the
> same for gso_partial_features for consistency? 'gso_partial_features'
> is otherwise not set anywhere else and relies on it being set to zero
> when allocated in alloc_netdev_mqs. I think it's better for it to be
> explicitly initialized in all cases here, like the other feature sets.
> 
> Cosmin.

OK.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

