Return-Path: <linux-kselftest+bounces-39818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5542B334E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 06:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704B8480725
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 04:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76CE230BF6;
	Mon, 25 Aug 2025 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCyHsjzQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31C1C4A0A;
	Mon, 25 Aug 2025 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756094877; cv=none; b=DDNUim5zikNyS8NnaAXjpBHsYSyPS9vyTwZDRMhlTmnoyoGM+spHLMAurOBtAOC5HCgCccTwG62wkiu25fM65nSSnsbb3VrATkfS1O2kdqXexg7hGPQqaJBLifrAmqIF6Ur1bQKpUyoH4ICOOoPVVSWAz+1mq57Aq0SwJW0eUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756094877; c=relaxed/simple;
	bh=ztYMGLnQwU9SVZO/z+Fo2N5tqZsGS3NoFn/KuZ90AC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyGh8UYQoOI8Ew8Gm4NOBN1OfZQHe7h0PrcToA1ZPxc1kna0rUuyQxxh+EVKhTnam9Js0q2EynxvWeUPKnW3oTb1U03L000ZAE74y54XxyHNenAGLS5sKaCbEcjRbhQHIaYN6pQjiNh+J4IlvqDbwPM/uFJX6SGZvwuO0cn2jvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCyHsjzQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2467de5160eso10203045ad.0;
        Sun, 24 Aug 2025 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756094875; x=1756699675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TtHbu/cHDkXDqhy1WqpDPxfLfr1D0TNEz4oybRSN+Y=;
        b=WCyHsjzQU/GkyuEChvFdqiee/j3H+HP7XR9TSAcm2INVTtkSO1VqLv9tPo9obbqOzR
         ONbEfYcqj0Ta5oZQhcBtrPWis6HBBEvCwcOaVMq1W4SQ01ydRcA9MBetZUcCVIBFagaW
         h89EOQ3ZTdfsg5Bu4mreUaVxFPBsefwwhFSK9UJnCDxb0H14HI6La3mv3m2X2lVgmqKF
         8g7jj6b67zMsuFWIsyD7CZlowB5EH86LreRYBd2bSuH179vqYQUe/e/irftNGNxYhsPU
         cWByYv+t3b4g7cv/tceuSqj1sRHnMLqZA6c5eh7kcpmRtw4jaTEhkj7ENmaU078RPFq0
         cTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756094875; x=1756699675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TtHbu/cHDkXDqhy1WqpDPxfLfr1D0TNEz4oybRSN+Y=;
        b=Rm0UomPfoCQaomvbzeCp8yXkRH0f0OJAZ7pnxQVw/dV3uowDiwrgAq4PeNpULQVJ5h
         zJxkwf/7FPVq8RfRR4Pk2mNZ39EkBkkv4KaUvo1m24zj0+4HYr7p0YFdtNoSAFbPolfj
         1I0yjqGLHkCxDspWz2GucIxvV6wZhx/w+xMrLKGC4Fk2s+AJNBvPF/ecpfgGR9sUFmmK
         Pk1+JhKjrM6QMBw3upiKZw0tMVA60deUVLuNl9yfZg1GuXr2iZs/mwcIxGDmnc3Pnr4x
         uGHENHML06c83362EqInSn50Wn4461yulqLC6zzjtjLhG+YBnGXwP13YkZGd1SCEPYdC
         KZfA==
X-Forwarded-Encrypted: i=1; AJvYcCWhqt0PFGYSNy9bNsWHZ490JYcnqjauRst1o2NsRON1SvMnXa9m9hdxlfzKt/oOzFsRnwpHCIUl56N93583ij0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzku1zBewR60N+EmWz93wN+LfLQ7h5vjT4LdDwdpvIWH+pzHWi6
	3BpipmtzqxuVEndGioAe0/rivtNC4phZbE+6c0yHTz0E+QzUiwVwYCZi
X-Gm-Gg: ASbGncus/X0U3kvHlV0s0yZ6wEiOvltEEaK3dIZvbbhyLGd/DiS3tskQ81ly1wJQiyh
	7fasjQvCob0DSeSHOMPYBa/UqGYrFrkkv9Mx7pRqlM4ilim9AnocvFJf3morU22wd9De3s0W/hR
	OnjO4oFSKd4LZCCNxKNSqzy9q97r4nj1DjdoNCnv05iXDppeg1Wkk3YqUaOIO72/pnBDVFhllH+
	keSOpDsvVzy+/fdnmkx+DR5Qh5yqH00Lg8b9JsGkTqrvZshRa9DGkedy0oxi0MKk2xiPVKsxK66
	2ru8+b6PviyYuAT7X6fR3YwVzJJqnd7hSZ5owsCLwm9SfZH/qkbtuUXY2oLQzHoY6+PvzoXjfvx
	JPW9y3obvsIzoAmt5ZMj/+Ajl1yU=
X-Google-Smtp-Source: AGHT+IFSZrmY/aYVO4yuuK6DFY5CMe4DpUswGqOWN5JlFH1kW6s3CQj19Z30MjoAY42HZ5OFoYxd9A==
X-Received: by 2002:a17:902:ce01:b0:246:620:a0b7 with SMTP id d9443c01a7336-2462efca36fmr147865605ad.59.1756094874932;
        Sun, 24 Aug 2025 21:07:54 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779fd6sm54979095ad.24.2025.08.24.21.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:07:54 -0700 (PDT)
Date: Mon, 25 Aug 2025 04:07:47 +0000
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
Message-ID: <aKvhk8Cq3ZdWeH_7@fedora>
References: <20250820091009.393785-1-liuhangbin@gmail.com>
 <1546564.1755908490@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546564.1755908490@famine>

On Fri, Aug 22, 2025 at 05:21:30PM -0700, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> >Commit 5c3bf6cba791 ("bonding: assign random address if device address is
> >same as bond") fixed an issue where, after releasing the first slave and
> >re-adding it to the bond with fail_over_mac=follow, both the active and
> >backup slaves could end up with duplicate MAC addresses. To avoid this,
> >the new slave was assigned a random address.
> >
> >However, if this happens when adding the very first slave, the bond’s
> >hardware address is set to match the slave’s. Later, during the
> >fail_over_mac=follow check, the slave’s MAC is randomized because it
> >naturally matches the bond, which is incorrect.
> 
> 	The description here seems confusing to me; what does "this"
> refer to?  I don't understand the sequence of events that lead to the
> issue being fixed here.
> 
> 	I wonder if there's another bug somewhere, since nominally when
> releasing the last interface in the bond, __bond_release_one() should
> randomize the bond's MAC address, so it shouldn't match when adding (or
> re-adding ?) the first interface to the bond.
> 

Sorry I didn't make it clear. A easy reproducer would describe the issue. e.g.
(omit the lo interface)

[root@virtme-ng net]# ip link add type veth
[root@virtme-ng net]# ip link add bond0 type bond mode 1 miimon 100 fail_over_mac 2
[root@virtme-ng net]# ip link show
3: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff
4: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 92:5d:9c:47:e7:53 brd ff:ff:ff:ff:ff:ff
[root@virtme-ng net]# ip link set veth0 master bond0
[root@virtme-ng net]# ip link show
3: veth0@veth1: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP,M-DOWN> mtu 1500 qdisc noqueue master bond0 state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
    link/ether 4e:b5:4a:b4:03:18 brd ff:ff:ff:ff:ff:ff
4: veth1@veth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 82:a8:52:f4:81:4e brd ff:ff:ff:ff:ff:ff
5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 02:0a:04:c2:d6:21 brd ff:ff:ff:ff:ff:ff

Here we can see the veth0's mac address is randomized. The reason is in
function bond_enslave(), we set the bond mac address to the same as slave's
if it's the first one.

        /* If this is the first slave, then we need to set the master's hardware
         * address to be the same as the slave's.
         */
        if (!bond_has_slaves(bond) &&
            bond->dev->addr_assign_type == NET_ADDR_RANDOM) {
                res = bond_set_dev_addr(bond->dev, slave_dev);
                if (res)
                        goto err_undo_flags;
        }

And later

       } else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
                   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
                   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
                /* Set slave to random address to avoid duplicate mac
                 * address in later fail over.
                 */
                eth_random_addr(ss.__data);
        } else {

Here we check the bond and slave's mac address, which would be the same
definitely, which cause the first slave's mac got changed.

Thanks
Hangbin

> 
> >The issue is normally hidden since the first slave usually becomes the
> >active one, which restores the bond's MAC address. However, if another
> >slave is selected as the initial active interface, the issue becomes visible.
> >
> >Fix this by assigning a random address only when slaves already exist in
> >the bond.
> >
> >Fixes: 5c3bf6cba791 ("bonding: assign random address if device address is same as bond")
> >Reported-by: Qiuling Ren <qren@redhat.com>
> >Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >---
> > drivers/net/bonding/bond_main.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index 257333c88710..8832bc9f107b 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
> >@@ -2132,6 +2132,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
> > 		memcpy(ss.__data, bond_dev->dev_addr, bond_dev->addr_len);
> > 	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
> > 		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> >+		   bond_has_slaves(bond) &&
> > 		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
> > 		/* Set slave to random address to avoid duplicate mac
> > 		 * address in later fail over.
> >-- 
> >2.50.1
> >
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net
> 

