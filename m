Return-Path: <linux-kselftest+bounces-23292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F49F02F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2867F16ABED
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 03:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114E14375C;
	Fri, 13 Dec 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An9bMYSD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45287374FF;
	Fri, 13 Dec 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734059428; cv=none; b=V3Mii+8Ly+Vc9xUThe0XoKoyxIQHqfNl6N7OtjFOj/IMxVBkB+2TpvjHyNr2WGoGMtiCjXt7TkmMKTexxblP6irWSwbJqDEM1XayETUWjTYMwUNbGw1oE7oE1gaeaMjL6aH5Wqqjc4n1udMR61zHvJWKj6+i4KKP8IjoiQfYFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734059428; c=relaxed/simple;
	bh=HhhzfrW/pW4GddkG9gXA5GDFpeJlqT1FMnMgRr+1GnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba2QW8mEs7C7mhIezoz9BoQQ1Aq9OxjKgOMJCWEYSRG7qfznoFdwIJVTGVQmM3ELjUaeXl4EmpoRfkzVkqHiBUUF8JC9dwEGNzCWp2zhceKT74nKT1yz2WSj7jJP2O0aQm4+j4OpuMJsTRfNIu7T8HWdrVpqroOf6qRQLtw52yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An9bMYSD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee6dd1dd5eso1007245a91.3;
        Thu, 12 Dec 2024 19:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734059426; x=1734664226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+1+22PER6hvlVzWYwizTYd95vLavGqdcT63qMED+MM=;
        b=An9bMYSD3LkFHffzaEjWDE6+g5mb7OQY5gIU8i5PTew261SjCXZZKkmLTgpZMiebuA
         RAwH5ter+KC8zRlUjWhuvBhLT3iVpkqd2y7CdGgHMUDiM7hfzVb0TYxeyv2sNBvAhRdb
         Dm4wqXZs/dqGYwdgk/djqNbWa2y+RYaRRRYlxh45huT9BzEimyFDuQkxUDrGPSbgbQcj
         sfxv+R/WqnVYs05t0bKk+jzbxaPcNQJzg9sdmrW3tsKg442EAAZg/TJoOzR1HjTNwXlh
         dAm4rAv+N+PAc8rt9F7YR/QcLyMzWMnm2bVX+GD/WbK00uo1geROar9hsW8tYpTQfAz6
         a+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734059426; x=1734664226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+1+22PER6hvlVzWYwizTYd95vLavGqdcT63qMED+MM=;
        b=eb2tSH/WKcZUhgLj3ADMTlyh6loRKmOx8K+/ITXSG2jcaFFsrVx3ulITx6YpjpJnYy
         fs3+I8XUaE3P3ji8XbON5YUFleJRtcS8+6hF8EeM6tPV1rjV0/nwXl5jU4X8Ky5uHpH+
         dHDcht4yVpYjCPlvVXS0P7ookqS4CKDJjLw10ryMxsYM6HopNvq9qmoUaWKlKE0THz5I
         A/sCxz9O/afI+ZIEmxhat0tPy7bmI8lqIf7xCqCJjjLUhkdzlO3gOrfDmtHZvrw1r5X0
         wB6haxtp9G6SoUIQs7Tk7q0OicfW0YWdqnDimJ78KR/pfvguOJ5qAg3snWiB4h7oLlLO
         tZUA==
X-Forwarded-Encrypted: i=1; AJvYcCVpNwgeMHImnCrhS4/kxPF+2en66s4MVE7YIeD14CaFVBqRbiwE7Ge9BGavQ8JfVZrYjtKlQo8tL5LRamgj/cyo@vger.kernel.org, AJvYcCXmDACP79TLiEonOkEf7pO1dlX/2sU8dQc4cLv1LluI3qKhkQbL5SWYrKCotSVZH01BXmszQlx39ghjeKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ehcz7pv2T1gdmEBSdIGT/OIld69nuLayHVPobk+9COZdthSv
	iiBiXb6wrZWEraWHZzvW2VYWPKytNEb53FA8H/eADXFsnTnvQ517
X-Gm-Gg: ASbGncu/RdP/6TQD3oLL4eFicV9arSu3Rt1mN9WuLBSFxf1eo7wp2kluQ7B6oNrwRIl
	FO5Em+twRgki5H8JbylIzd0zNAjEVCNr4RQFFctJ5bLDv41Gnh3dXg+lgzjp4J2X8Z/XMnFbf7d
	j2wX3Ujrh3PA+qbw5oEfjXG/Kbfq939YI327vy9GCU6i69kALD1Wi0zDRZLnOCROD0Y0VAxY9qv
	fCaNI5C93ry29I1yp0Zr1kZJrOKrlWuotaCR2A2KKn+Yi8pOFBg9jxT0n5h5Q==
X-Google-Smtp-Source: AGHT+IF73QyyWo7yWYaEjHk1vGDsBSvExYHsD+39Sg8QKjMnqdNuzCMHA6vFdKf0AG2+0vXILPTs4g==
X-Received: by 2002:a17:90b:548b:b0:2ee:aed2:c15c with SMTP id 98e67ed59e1d1-2f28ffa7eeemr1490508a91.28.1734059426636;
        Thu, 12 Dec 2024 19:10:26 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d927bbsm2096511a91.2.2024.12.12.19.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:10:26 -0800 (PST)
Date: Fri, 13 Dec 2024 03:10:20 +0000
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
Message-ID: <Z1ulnP7ZleZBlIas@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241211071127.38452-2-liuhangbin@gmail.com>
 <032ea83b-0df0-4c88-b0d1-153d9c1bf865@blackwall.org>
 <Z1qvb7Nz7zAv0L1w@fedora>
 <d5606430-16cf-4a2b-ac29-88b73b4ef284@blackwall.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5606430-16cf-4a2b-ac29-88b73b4ef284@blackwall.org>

On Thu, Dec 12, 2024 at 11:43:15AM +0200, Nikolay Aleksandrov wrote:
> >>> --- a/drivers/net/bonding/bond_netlink.c
> >>> +++ b/drivers/net/bonding/bond_netlink.c
> >>> @@ -568,18 +568,21 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
> >>>  			struct nlattr *tb[], struct nlattr *data[],
> >>>  			struct netlink_ext_ack *extack)
> >>>  {
> >>> +	struct bonding *bond = netdev_priv(bond_dev);
> >>>  	int err;
> >>>  
> >>> -	err = bond_changelink(bond_dev, tb, data, extack);
> >>> -	if (err < 0)
> >>> +	err = register_netdevice(bond_dev);
> >>> +	if (err)
> >>>  		return err;
> >>>  
> >>> -	err = register_netdevice(bond_dev);
> >>> -	if (!err) {
> >>> -		struct bonding *bond = netdev_priv(bond_dev);
> >>> +	netif_carrier_off(bond_dev);
> >>> +	bond_work_init_all(bond);
> >>>  
> >>> -		netif_carrier_off(bond_dev);
> >>> -		bond_work_init_all(bond);
> >>> +	err = bond_changelink(bond_dev, tb, data, extack);
> >>> +	if (err) {
> >>> +		bond_work_cancel_all(bond);
> >>> +		netif_carrier_on(bond_dev);
> >>
> >> The patch looks good, but I'm curious why the carrier on here?
> > 
> > The current code set netif_carrier_off(bond_dev) after register_netdevice()
> > success, So I make it on if register failed.
> > 
> > Thanks
> > hangbin
> 
> I don't like adding code just for symmetry alone, I think you should drop it
> unless there is an actual reason to turn carrier on.

OK, I will drop it.

Thanks
Hangbin

