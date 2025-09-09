Return-Path: <linux-kselftest+bounces-41013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F002B4A013
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 05:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7891441BD8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 03:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336C26FA67;
	Tue,  9 Sep 2025 03:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXwEx3PV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540A246782;
	Tue,  9 Sep 2025 03:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388898; cv=none; b=kBstfqaas2W7Z3Pr8TKSB+1CYzGj6Hx/R5TwNFlytcBDsSiQ9TD48vS1mpCjjSflVZvpyO0O0OUs4c+SlvML55BKEha/xlqrIdKVDyhnRSzuHWyFDwGz0X0m9xW4jN6DZbwoA3aFfjMUZNYOTFzQuwkEynufFginJr4ZeUtAiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388898; c=relaxed/simple;
	bh=orjSvwB7+hYUTKHAwQIDI/zbkxH7nvrr/dl1kUuPBK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfHUMRJonOM6UlX5vK9LmLiL2SvKcviE137p/KX2wNbr1Jaajmzkk03UgmfCxD0a0AlEXiJMzihD7rK4GACQtuS0c02s169/TrE1NkE1oS2eovwHNCgJVhgd9xDOkEGv5jl0WDHb6AoVKe9TQlp5ANcDDSlTYyIStk+dJwKqy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXwEx3PV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4574757b3a.1;
        Mon, 08 Sep 2025 20:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757388896; x=1757993696; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y93QCEvHzdhBiLz070Y0aTFkqAkpWfOndtebv8x55Y0=;
        b=LXwEx3PVeQMxp56ILA/4qwmA8FrJTtJqpnRzzNLW63F9nVS0Uuc4paYe9/OoUZoOAN
         F1ntfLvb6/hcW8A+9FtHqCG9esus1rZ1NJF8Yp/FXLIDl8t0Jmys7Xw7xfaujZrChjUo
         JEec4mQkV1E+o+vDuS/hbuu3gfMKM10pYkZLnSxToFrXTUXWuvZvb9assfq5O8D1Sv77
         U1skVudHfFQNNob8/bpXK6CGG2XSzY5hGWhXGW29yRBIU7wa3JEhjw8dvtqf/i7w3E+7
         dJtUVlthicozY+pj2p3MIBpKlHOz9ukGc2VLRnXPgw4MAd5+58IZ/N8oFuQlXi+nBFpp
         f6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757388896; x=1757993696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y93QCEvHzdhBiLz070Y0aTFkqAkpWfOndtebv8x55Y0=;
        b=iUYvY4wR5YHa16mEsVlP/+IP7dQfLvUvJs/94V52aUgkjVumkm6t371d373TIfsP9P
         7TNtOzMhQ3b5f9RTsqSv/Hm4Tsv/EoukoAPv2eIhScUVHybn9E60KiH3Z0PfyPERwiFc
         BSMAdRsMl5U05OOvni+oE+y/FOyyOVDL8Bl6wK19TDJaRavnZoL89A0Ezq5u5kH6km3n
         R8gDk5qCz7zj16eprAq7E+3614WGnvgA+fsTtCwKWC52y6kU3rN8cnvptXHlVqdsftYQ
         6JSiraPVIPVDMOuemUoMSN6v/ODlcCqZxhqrAxVPyqTPo3W8GX/2RQBwuyAFKlPPgYV+
         ajsA==
X-Forwarded-Encrypted: i=1; AJvYcCVadJwFvGd3IITsokKutUaE9G9iKL0rEjQRbFf8Sy0NaBrT50Os74lD07+FuUPIl3J7wtpZf+hM8yCZUzj0VvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnYU7OOnROcApd4Q1XZRwhaf1a4QLa9t/f7AuX+Jqxox3nDHv
	amwyUqmMwN30r5Sr3CwY+cwT8ClYUMS1E7yuG4SYajwmV3WoRQWkwDNzDvEfwwc0Va0=
X-Gm-Gg: ASbGncuB43g83wOygQHtqzlxNJdPrn8dcK0kwIMn1Xoe3kwgABbl3HhHEgu5Dfs+odt
	3Ryhhq1No8kTr/DcG7+ls0JLtqCEwAGShviRTbd0EYajJ5xrPuHot7sWtGEidHeXIhCYjKLOixZ
	MEFkOdK9Qq/W3VaTeeiAn/8j5GybGioZ1Z5mGZgQ/77S3rENmvc0+sT/ZpFlPsT3tm7qXwB7tkq
	VjyBMhReJrScWqj0WnmESKCrNyFSOXtxE7z6uct3OJjvlYxtjS6XlKHo/9Ba190zzvfxqAA4syi
	BcpPF4O93GaxZBdh4eRjDHv+zE2jmat3lbwU/Me/U4f8iNxBNdJ+qkYx7rl8PHJOOOqUzFmnsIX
	J8uFQF+2EbUeoJiDk3Q7BcN52zIM=
X-Google-Smtp-Source: AGHT+IFWAxS7GwuQtDUJHjXYB714zrawjzVF4GAUe9Ho5fpPBIC8TOyzVIQWHR9c78UtLyb3yYKjcg==
X-Received: by 2002:a05:6a00:7605:b0:772:2d49:4eb5 with SMTP id d2e1a72fcca58-7741bf5b1f2mr15716590b3a.14.1757388895968;
        Mon, 08 Sep 2025 20:34:55 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e5b5csm461701b3a.7.2025.09.08.20.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:34:55 -0700 (PDT)
Date: Tue, 9 Sep 2025 03:34:48 +0000
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
Message-ID: <aL-gWAFWPAKuNoUi@fedora>
References: <20250820091009.393785-1-liuhangbin@gmail.com>
 <1546564.1755908490@famine>
 <aKvhk8Cq3ZdWeH_7@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKvhk8Cq3ZdWeH_7@fedora>

Hi Jay,

On Mon, Aug 25, 2025 at 04:07:55AM +0000, Hangbin Liu wrote:
> On Fri, Aug 22, 2025 at 05:21:30PM -0700, Jay Vosburgh wrote:
> > Hangbin Liu <liuhangbin@gmail.com> wrote:
> > 
> > >Commit 5c3bf6cba791 ("bonding: assign random address if device address is
> > >same as bond") fixed an issue where, after releasing the first slave and
> > >re-adding it to the bond with fail_over_mac=follow, both the active and
> > >backup slaves could end up with duplicate MAC addresses. To avoid this,
> > >the new slave was assigned a random address.
> > >
> > >However, if this happens when adding the very first slave, the bond’s
> > >hardware address is set to match the slave’s. Later, during the
> > >fail_over_mac=follow check, the slave’s MAC is randomized because it
> > >naturally matches the bond, which is incorrect.
> > 
> > 	The description here seems confusing to me; what does "this"
> > refer to?  I don't understand the sequence of events that lead to the
> > issue being fixed here.
> > 
> > 	I wonder if there's another bug somewhere, since nominally when
> > releasing the last interface in the bond, __bond_release_one() should
> > randomize the bond's MAC address, so it shouldn't match when adding (or
> > re-adding ?) the first interface to the bond.
> > 
> 
> Sorry I didn't make it clear. A easy reproducer would describe the issue. e.g.
> (omit the lo interface)
> 
> [root@virtme-ng net]# ip link add type veth
> [root@virtme-ng net]# ip link add bond0 type bond mode 1 miimon 100 fail_over_mac 2
> [root@virtme-ng net]# ip link show
> 3: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff
> 4: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
> 5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 92:5d:9c:47:e7:53 brd ff:ff:ff:ff:ff:ff
> [root@virtme-ng net]# ip link set veth0 master bond0
> [root@virtme-ng net]# ip link show
> 3: veth0@veth1: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP,M-DOWN> mtu 1500 qdisc noqueue master bond0 state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
>     link/ether 4e:b5:4a:b4:03:18 brd ff:ff:ff:ff:ff:ff
> 4: veth1@veth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
> 5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff
> 
> Here we can see the veth0's mac address is randomized. The reason is in
> function bond_enslave(), we set the bond mac address to the same as slave's
> if it's the first one.
> 
>         /* If this is the first slave, then we need to set the master's hardware
>          * address to be the same as the slave's.
>          */
>         if (!bond_has_slaves(bond) &&
>             bond->dev->addr_assign_type == NET_ADDR_RANDOM) {
>                 res = bond_set_dev_addr(bond->dev, slave_dev);
>                 if (res)
>                         goto err_undo_flags;
>         }
> 
> And later
> 
>        } else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
>                    BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
>                    memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
>                 /* Set slave to random address to avoid duplicate mac
>                  * address in later fail over.
>                  */
>                 eth_random_addr(ss.__data);
>         } else {
> 
> Here we check the bond and slave's mac address, which would be the same
> definitely, which cause the first slave's mac got changed.

Any comments for this?

Thanks
Hangbin

> 
> > 
> > >The issue is normally hidden since the first slave usually becomes the
> > >active one, which restores the bond's MAC address. However, if another
> > >slave is selected as the initial active interface, the issue becomes visible.
> > >
> > >Fix this by assigning a random address only when slaves already exist in
> > >the bond.
> > >
> > >Fixes: 5c3bf6cba791 ("bonding: assign random address if device address is same as bond")
> > >Reported-by: Qiuling Ren <qren@redhat.com>
> > >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > >---
> > > drivers/net/bonding/bond_main.c | 1 +
> > > 1 file changed, 1 insertion(+)
> > >
> > >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > >index 257333c88710..8832bc9f107b 100644
> > >--- a/drivers/net/bonding/bond_main.c
> > >+++ b/drivers/net/bonding/bond_main.c
> > >@@ -2132,6 +2132,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> > > 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
> > > 	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
> > > 		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> > >+		   bond_has_slaves(bond) &&
> > > 		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
> > > 		/* Set slave to random address to avoid duplicate mac
> > > 		 * address in later fail over.
> > >-- 
> > >2.50.1
> > >
> > 
> > ---
> > 	-Jay Vosburgh, jv@jvosburgh.net
> > 

