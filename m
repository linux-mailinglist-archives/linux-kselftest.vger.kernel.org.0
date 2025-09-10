Return-Path: <linux-kselftest+bounces-41090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A77B50AF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDCB7B1340
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60462367C1;
	Wed, 10 Sep 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSg7gWar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482BA1F4C99;
	Wed, 10 Sep 2025 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470681; cv=none; b=COydESNqdKtHND7wU9ks/YHSJpbB55L0rGDbHGogJaRGR6nf//bCWCJYAJoBO+JIWojVMlmq0dsqmIap6xb1k0zm2o8DBIWlvJSiAKpRIhvR5vDOy3aeWPREL39cIMRcJTANmuY1JYWvXVuu5BvIjzcHWZkLmNkGGeLHF+j46To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470681; c=relaxed/simple;
	bh=Z8UUjtpleGNxoM90ZOBXYNu70/s3Z/yE4vxQyC4XyxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/2pDOxnvF2gerMWAiLMKu05J9qFoOEDMqH9zxQRSgG1ZvgqNt90ABZIS7skqI9U+2yQHHIfcW4zDVJiAyFMMHm1+GQgPf6woZ1DIg2SYFiDzdyzd2kiMfEqmXZEfvzr5WjJcOKZxiWDdaQOQVE1exYuXvTgK3DzcWEsdlQiX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSg7gWar; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24b21006804so68729265ad.3;
        Tue, 09 Sep 2025 19:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470680; x=1758075480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hoMtWLKxhgeJvMt8cQYfr59gWPRX1DL/xUlEHER9iYo=;
        b=RSg7gWar2EOXjkMBOiFlP3mN6oqcVDeBoVg9t7rOa4yYYuWF8LqBR5XG5lvOa9SfAY
         dTBm74O7lo1F2UNfpPuslqLsImPS7th70OiXHCfkQQ22SGCBs7RYQtUruCbQ2SpZxfzw
         SauEJXtllzMv6VjahpQs9J4x6uAMushWiXbTc5+NyHSWIjsWtRW0uqKUJ1hvJzK5gVUs
         VcQIAsoP44GN+WNw6yd1YqKd39E4y/Cw+ijtkSM5Wo8UjOsE61WyBC5m/SpDmVJNSBe2
         UTFPVaFjfCgqjDTXH8bnozjMxXURJpQn2azBcqqn31LWRKN7k47ZXla/eqqy4UiZGeuh
         jWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470680; x=1758075480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoMtWLKxhgeJvMt8cQYfr59gWPRX1DL/xUlEHER9iYo=;
        b=OZHuGaut7FMnnx9odLWbWRFoch/CqrRALmoYP8IBZqvJfkUyr0lwB6ceqCGHM0neWs
         B4qS8yKeBeYd2ha+/QQwdTEKqMfPq5uVg2axsIFcLbb+CdIn2WZ/6go4/sCrLXVjNhCo
         qsYBXrRlaesfqWLVkcS0/4ammv9d6SXVDpEEEqFUy7ryw7ivv2jVdcPt+/xLa7riLP+L
         QIVyGh023Fc1rsgrtSgFT7OJoy8WF1FmqvaY2Kb2tJGehUpGo8hsetUSQLt26AwKTQaI
         Hx+a/KEP+Og3fUZ+BdI1Rm0SMB9Wud6J9gJj8zwT34VCYbbqtIStibRkex05mnmcdGod
         qCZA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ibL0LfMXVGQRAwMH3zttPW4qFFzLgfEOwag+UvB/PfaxKdtCnb+AArCXIPoo+aCviWjceEbd817Z8FglJSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vNx1OyZQx/hNdDkPYVy/GxuJCdrqWQ95SjeH/gFxnaWJ9p9n
	BSaHFHGKxZqvYkv9nREABc9j9b8cP4gs7sOMeUUfjWKYWZ0XzhTODksv
X-Gm-Gg: ASbGncvRTCi02OoF3jPOMlGd6zqDNjXyPk638n6EEGyyZ8osUrItCZfKa1OFoWgEMtV
	l8DpQGfdV49DvCJakHGXS3vj/mE/KOmB9mNVMhQxs8KQdTRcAwsb/lLyzsVBG68/nmfZsFDufES
	rGQL7gsRj7kU2ealnm9i+SHt7lad1uMi9Ak6Db0dQYjVFo14WoTatre/WNrLbRcg5SDfSmJpC/8
	NjD2HN7Ti328jdXi0OPO7QB+a0gT67Vq8VhqVlipd84KyHaD2g+OXxvNBYpJ3faWs50G59OpecX
	6nH+ZqCUrqz8/2oWgMyJq0m7CQw64XtMU1xtGRzEWIpAQ4OgKWI2B/JtlmY98WcWwTy7cC5a8rq
	c+fA2mzV0Uw9126QoK+t/lHWRAtNnRdHVoRreFw==
X-Google-Smtp-Source: AGHT+IFedI9PGiVHfEfsx+MPHFEUf2i3JtUvfkPim/DMT/2S+EXjwrUvzoQPSBoGMFrnRWOAYoRamw==
X-Received: by 2002:a17:903:40c9:b0:249:37ad:ad03 with SMTP id d9443c01a7336-2517330a5dcmr183940475ad.34.1757470679511;
        Tue, 09 Sep 2025 19:17:59 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2adf5154sm10481545ad.131.2025.09.09.19.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:17:59 -0700 (PDT)
Date: Wed, 10 Sep 2025 02:17:52 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Qiuling Ren <qren@redhat.com>
Subject: Re: [PATCH net 1/2] bonding: set random address only when slaves
 already exist
Message-ID: <aMDf0Lj0PzJfY46x@fedora>
References: <20250820091009.393785-1-liuhangbin@gmail.com>
 <1546564.1755908490@famine>
 <aKvhk8Cq3ZdWeH_7@fedora>
 <aL-gWAFWPAKuNoUi@fedora>
 <2918806.1757449543@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2918806.1757449543@famine>

On Tue, Sep 09, 2025 at 01:25:43PM -0700, Jay Vosburgh wrote:
> >> 
> >> Sorry I didn't make it clear. A easy reproducer would describe the issue. e.g.
> >> (omit the lo interface)
> >> 
> >> [root@virtme-ng net]# ip link add type veth
> >> [root@virtme-ng net]# ip link add bond0 type bond mode 1 miimon 100 fail_over_mac 2
> >> [root@virtme-ng net]# ip link show
> >> 3: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
> >>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff
> >> 4: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
> >>     link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
> >> 5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
> >>     link/ether 92:5d:9c:47:e7:53 brd ff:ff:ff:ff:ff:ff
> >> [root@virtme-ng net]# ip link set veth0 master bond0
> >> [root@virtme-ng net]# ip link show
> >> 3: veth0@veth1: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP,M-DOWN> mtu 1500 qdisc noqueue master bond0 state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
> >>     link/ether 4e:b5:4a:b4:03:18 brd ff:ff:ff:ff:ff:ff
> >> 4: veth1@veth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
> >>     link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
> >> 5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
> >>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff
> >> 
> >> Here we can see the veth0's mac address is randomized. The reason is in
> >> function bond_enslave(), we set the bond mac address to the same as slave's
> >> if it's the first one.
> >> 
> >>         /* If this is the first slave, then we need to set the master's hardware
> >>          * address to be the same as the slave's.
> >>          */
> >>         if (!bond_has_slaves(bond) &&
> >>             bond->dev->addr_assign_type == NET_ADDR_RANDOM) {
> >>                 res = bond_set_dev_addr(bond->dev, slave_dev);
> >>                 if (res)
> >>                         goto err_undo_flags;
> >>         }
> >> 
> >> And later
> >> 
> >>        } else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
> >>                    BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> >>                    memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
> >>                 /* Set slave to random address to avoid duplicate mac
> >>                  * address in later fail over.
> >>                  */
> >>                 eth_random_addr(ss.__data);
> >>         } else {
> >> 
> >> Here we check the bond and slave's mac address, which would be the same
> >> definitely, which cause the first slave's mac got changed.
> >
> >Any comments for this?
> 
> 	Sorry, fell off the radar.
> 
> 	I follow what's going on now, and it's actually a lot simpler
> than the description suggests, at least to my reading.  Perhaps language
> like:
> 
> After commit 5c3bf6cba791 ("bonding: assign random address if device
> address is same as bond"), bonding will erroneously randomize the MAC
> address of the first interface added to the bond if fail_over_mac =
> follow.
> 
> Correct this by additionally testing for the bond being empty before
> randomizing the MAC.
> 
> 	Does that sound ok to you?

Sure. As a non native English speaker, I always struggle to organize the patch
description. Thanks for your update.

Regards
Hangbin

