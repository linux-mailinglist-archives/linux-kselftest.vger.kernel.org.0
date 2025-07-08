Return-Path: <linux-kselftest+bounces-36758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC77AFCCDC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1CC3A3B55
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3FF2DEA86;
	Tue,  8 Jul 2025 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F4kH8C6j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0A2D613;
	Tue,  8 Jul 2025 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983290; cv=none; b=SGMnvMAB+vMoolkZ9+eEnQkNjmxjxii19nS1eQY22yQBO3ld14BfSM+a1Cmbha/VxtP5SOvuFyOD/qReva7o6pAFk+YpHhu8kHpdBtuSKjF5POY5eqsAx6tE3c1NjST4eHVgmsEKH/bCyenZTA6OsUhsWjWbONSciJxkkQyP9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983290; c=relaxed/simple;
	bh=jiSOZcyewoX4/3vPQOddofnAR9Fx/TVJaWuJIbk7pB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXYQDr787dC5dQgtTEDNZ+eRVZ6uMbgPW9ADzjVC90ZVD+k7tC5h8VGQVgTzcMKch/WHUsairUjWLQf6VNrx5I6MPAlWc5BW89R/tw9gOzfsty/AK5pISwuOMyyWPD4ASLCN0iMQtVLcWUG/NMJRG6nKSwFVue6PiDqNdH8u8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F4kH8C6j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p+b4mVKuoAsfo3cEZdXjX+/aNWu2K+lEqLExqcNWMUg=; b=F4kH8C6jYQBYLoupXb2aexf8sT
	uVL4oZsxSIOP9UPd301zLEdaVp7q/rXBCuxwpXTY4obCtJulpKCCPknU8VzZG+yP7OwKyY43F6IJM
	cGy7PfLw2X1G2kw+WWfP/NtYuxDjqcYZLJNm4GvQb3V2vBI5YTOwyzU7j8UUsHwvZdjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZ8sc-000pFd-OL; Tue, 08 Jul 2025 16:01:06 +0200
Date: Tue, 8 Jul 2025 16:01:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: netdevsim: Add PHY support in netdevsim
Message-ID: <c6685b48-b525-47bd-8364-a26d787b1e3a@lunn.ch>
References: <20250702082806.706973-1-maxime.chevallier@bootlin.com>
 <20250702082806.706973-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702082806.706973-2-maxime.chevallier@bootlin.com>

> +static int nsim_phy_state_link_set(void *data, u64 val)
> +{
> +	struct nsim_phy_device *ns_phy = (struct nsim_phy_device *)data;
> +
> +	ns_phy->link = !!val;
> +
> +	phy_trigger_machine(ns_phy->phy);
> +
> +	return 0;
> +}
> +
> +static int nsim_phy_state_link_get(void *data, u64 *val)
> +{
> +	struct nsim_phy_device *ns_phy = (struct nsim_phy_device *)data;
> +
> +	*val = ns_phy->link;
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(nsim_phy_state_link_fops, nsim_phy_state_link_get,
> +			 nsim_phy_state_link_set, "%llu\n");
> +
> +static void nsim_phy_debugfs_create(struct nsim_dev_port *port,
> +				    struct nsim_phy_device *ns_phy)
> +{
> +	char phy_dir_name[sizeof("phy") + 10];
> +
> +	sprintf(phy_dir_name, "phy%u", ns_phy->phy->phyindex);
> +
> +	/* create debugfs stuff */
> +	ns_phy->phy_dir = debugfs_create_dir(phy_dir_name, port->ddir);
> +
> +	debugfs_create_file("link", 0600, ns_phy->phy_dir, ns_phy, &nsim_phy_state_link_fops);

Maybe this can be converted into:

debugfs_create_bool("link", 0600, ns_phy->phy_dir, &ns_phy->link);

You loose the phy_trigger_machine(), but that might actually be
good. PHYs are async to any operation you take on them. It can take up
to 1 second due to the polling before any change is reported. So any
user space tools which expect an immediate state change are broken. So
leaving the PHY state machine to poll the PHY to notice the link has
changed is a better simulation.

	Andrew

