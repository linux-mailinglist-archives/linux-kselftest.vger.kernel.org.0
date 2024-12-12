Return-Path: <linux-kselftest+bounces-23249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1528D9EE33A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 10:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527461887E80
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C0920E339;
	Thu, 12 Dec 2024 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXrpJWbK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFB1D89ED;
	Thu, 12 Dec 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996410; cv=none; b=ms5RIio3Vsr3uVoQcNkSLsCYW6XmypOA5fJ4pxBe5pQr6oSl1aNhjocZID1nEJyozYADP69Cnsyra43BUqv51IXzgspGqRhvuQlaK/6uSPb7blq5V5TjmPCqMFTJodumES5vIWAvRO+MCfv8HQ0F/mVkCsxhi8uZdXNkOv3EsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996410; c=relaxed/simple;
	bh=VWc2DqF30kvxbMoJ5f4EU8dsIWaO5o/gnUsxhi8whLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TumkYOyqBT/ZuIXLGVYmQeY60cGdytlqYadzaZ7JTVhjvTYpwpXYLtGEvtbYRlK2Hi+IvAVzOQCIB6liEzyiXbEK3RJdbZQHiMTDMhwmWerHZ0BAn0FyScjLYKIHCH85SwXkBQlHPrteO9hXNpxROf+lquNgWevWeiEjisFiY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXrpJWbK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b662090so3234865ad.1;
        Thu, 12 Dec 2024 01:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733996408; x=1734601208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/blI0xGxrLnTmxcF6FdqTJxQ7aP9dl9YPrqYonhfjpE=;
        b=FXrpJWbK6l8UEo+xhCdM+20WHETvHHBEwfzLFkin7fEkOHWzaZXpfyABfSiZ8ZhnGv
         xW/VVwW75N+E1q4jbkP/80qR/O2iqSnEeBCdnRd96IsCoKCe7XoXRuvcphapL1Fpdjss
         cMTyonTA1qS+XRNbiattd1mDnSYFddFaCrrCPRorqXzovpEguHpeW/bHVWNIwK9TFpoN
         lSku4dhN23MrmhrJGXuYP0MXEovxRvBtxwDNT1RtuY58HcW2DOP2yg2T6++bL/w7lq8X
         q+439kCR2vp3hkE02OyLsDzWn2KDopCZk9Ywy1suBUGIwicUtMNpSVH+ZPr2wmOOQ3U8
         xasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996408; x=1734601208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/blI0xGxrLnTmxcF6FdqTJxQ7aP9dl9YPrqYonhfjpE=;
        b=BEZ8Jt3uSwaiTTv18x6G/tuAACickzvYGrkNqtxYGL6JsS3b0PR0i36iL0RJtZrCKQ
         Ef8qQw26amJ/bZFzUjWIQPU0Mg13mIqZr+QMuSkJ4FJXavoN2yrCwBMxl0LqWpjY21Xb
         z7vsviZrj1lt5bR+UiVdFtsQWdQ2lbAe0qwuhLvOAmsSS+hRm914d+xdLncga06sGP3s
         IlwHKst37LgvA05UjbHRg5mDyLhtXtaN2YUrlBTEPiqQy9qQjbF5pdu27ALYJWIzpoy2
         Ap3pOvKWvjQqtYORbU2JfTM+8cr6TwhGPHMYGpJYUZGvW2h5A/8BgVcJ4rKQ/LE9Ki1D
         lBkA==
X-Forwarded-Encrypted: i=1; AJvYcCUk0MwMf03jm689OoaNpGQSC7dpURw8xwHudJteEQqhCh9cWWKu5BOJxH1FBDsRaGfyk+NmQG4vXMcZdBI=@vger.kernel.org, AJvYcCVWn31vVV/8ITTGbYEMrXFm8qReLSxxlQyGgGwZ2B3wcp3zEfKm9VKrf2Uw2FTIoMxar3sSmL2o7T09GXYA0Vny@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJ5Hfkew25va+VnuM3xK5Nh+UR07yspWlpXxtQvDzFlzWolUj
	UCW6tyjxR7/mJTaG5IoX8X9rgVELIqeLh/rVT+4qnQ99hZ1zyVUf
X-Gm-Gg: ASbGncvYyi+NS+arwqcnKQ3Xlyu5D+maXAJu3VwQCfAxfzpQa6witwjH4PSCgNFmic1
	G2SN6sjV3a3Po+N28ACcnOZQACp445ReJINLuvd3w25b5Hl7qXSmwRCGg16OvYq3E63YHWjl7Gk
	xcmk3hD3FV+IA49sQJTKSTyupEU600yarP+i6LOnnL3k/dy7WitHMX5wIjJgXAYykjhThOETnZD
	CHzXJCF6xp4xd7caMNBBWNnhQf75wL7Iiz+evpFQW6cXJph5upCYTIRSdq6aQ==
X-Google-Smtp-Source: AGHT+IHntqbqE7yVouwpim9oB24q3YJgf2IDzhh9r1HTEYqi1yN2bS5ekftsd6hxoWVMvQ3kxEwRMQ==
X-Received: by 2002:a17:902:c942:b0:215:5c1a:f369 with SMTP id d9443c01a7336-2177838d73emr96475535ad.11.1733996408237;
        Thu, 12 Dec 2024 01:40:08 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216281f45a2sm89778335ad.250.2024.12.12.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:40:07 -0800 (PST)
Date: Thu, 12 Dec 2024 09:39:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: fix xfrm offload feature setup on
 active-backup mode
Message-ID: <Z1qvb7Nz7zAv0L1w@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241211071127.38452-2-liuhangbin@gmail.com>
 <032ea83b-0df0-4c88-b0d1-153d9c1bf865@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032ea83b-0df0-4c88-b0d1-153d9c1bf865@blackwall.org>

On Thu, Dec 12, 2024 at 11:19:33AM +0200, Nikolay Aleksandrov wrote:
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 49dd4fe195e5..7daeab67e7b5 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -4389,7 +4389,7 @@ void bond_work_init_all(struct bonding *bond)
> >  	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
> >  }
> >  
> > -static void bond_work_cancel_all(struct bonding *bond)
> > +void bond_work_cancel_all(struct bonding *bond)
> >  {
> >  	cancel_delayed_work_sync(&bond->mii_work);
> >  	cancel_delayed_work_sync(&bond->arp_work);
> > diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> > index 2a6a424806aa..7fe8c62366eb 100644
> > --- a/drivers/net/bonding/bond_netlink.c
> > +++ b/drivers/net/bonding/bond_netlink.c
> > @@ -568,18 +568,21 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
> >  			struct nlattr *tb[], struct nlattr *data[],
> >  			struct netlink_ext_ack *extack)
> >  {
> > +	struct bonding *bond = netdev_priv(bond_dev);
> >  	int err;
> >  
> > -	err = bond_changelink(bond_dev, tb, data, extack);
> > -	if (err < 0)
> > +	err = register_netdevice(bond_dev);
> > +	if (err)
> >  		return err;
> >  
> > -	err = register_netdevice(bond_dev);
> > -	if (!err) {
> > -		struct bonding *bond = netdev_priv(bond_dev);
> > +	netif_carrier_off(bond_dev);
> > +	bond_work_init_all(bond);
> >  
> > -		netif_carrier_off(bond_dev);
> > -		bond_work_init_all(bond);
> > +	err = bond_changelink(bond_dev, tb, data, extack);
> > +	if (err) {
> > +		bond_work_cancel_all(bond);
> > +		netif_carrier_on(bond_dev);
> 
> The patch looks good, but I'm curious why the carrier on here?

The current code set netif_carrier_off(bond_dev) after register_netdevice()
success, So I make it on if register failed.

Thanks
hangbin
> 
> > +		unregister_netdevice(bond_dev);
> >  	}
> >  
> >  	return err;

