Return-Path: <linux-kselftest+bounces-19919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD4E9A1AC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 08:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C45E1C21813
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9410192B8E;
	Thu, 17 Oct 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m4n1nSte"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611C18EFE4
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147157; cv=none; b=QDI7mqDzEjDBo35kUCbbVllXgMwzctDmSQvLPnH9OkxFijkim95VhSd+knRZyaDkwkEEjC6d8rg8mG7KX7Bi68yebP2oiBAzgBmF7IiGG5GOq6XRau6hIS3aQnqthG4LlLbQX+GgJ8CzVeIQlK1gEmAAaF2t7LyzMA0Oct/NGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147157; c=relaxed/simple;
	bh=YxGBP5qB28KyXHJhHR0stIVif08BwaeJD4A4swWc/xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq53TkOrkHZ7O4W2RyjPrDg4HJoOYm+OYVhecvJNA08g+sfoiLHtclUH7RDijSPAeo6ljy1MmBpsmjbEoEubn89x5zm5g5+sCSOZB6VV47bbgsvLaT3fsRhjs1nRdkh5vxRTRsNIbSOdllyVnA7PUCWdM45BhVb+Q7eQ1cdr/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=m4n1nSte; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1054806a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729147151; x=1729751951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csfDmDQkSk7HpYvIcRc6H5/F/K1BFuuble0kVC6M8WI=;
        b=m4n1nSteyrIdVJGYxg5ptJaOq+ERMIRNh+rrQJt0BOvDwVvbQFHBPKgTSGF50eU0U4
         DxCKhpVYdrN/zzksou9aI3dnMWlc6mcZW6WYXxOdWSeF510AzVrJY2em20Fyltzksu3q
         uPiGSCQ5JK8Kde+DNJsDAmM/dvc9z29B2PzyfQGyfaUuvqu1F51FBwEox7ewU8/SBDqT
         VrTXO45ZDmPraTKudRsFjKXzVPHlLHk/XC08fxBrrU3TVRps0svNVlpzFP5pMBt2CJTy
         v5fMckEkil39cPwfSkyvhZ7oxLp39+E/0REIzG3sRxYvJBPULl8onk7cl5RhwQyu6Ar6
         +IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147151; x=1729751951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csfDmDQkSk7HpYvIcRc6H5/F/K1BFuuble0kVC6M8WI=;
        b=wdVgEvhWs6ppIxVT87NnRhxLRq6zH4jrUEv0JQJDebT66TNSl6S5ohpelfnd7PQBVs
         dPdeCJY30u24h87O9CWEeG5nLwSv0UyIeU5GEl+PmBu3lHyQL82+cEKQGGE7KX6hs3YM
         +160L5/fG9YxD3+E3RDM2ZVaKiT+ByrGZYe0qgZnmlOKvYxZkjE/1RyKCG1u6rrXDAVe
         XE8YRy5g0WADxARFg/LgyZhCFMMWEvyBoVNRhxtChESz1CDq+vZGOS9CoxSfVG4xicno
         XTVwngfjFUOkmB0V9KuVBQ/hpd/BNWh2HOSjRFxTnCuP8chTeNC19cxc5MB/l5NAHHb7
         yKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmukHj4IKvhyvSMVLzFRTgZtlELgB4zsPPQTgw5dq9mD9oXm7LXfsnlSOdSzpq4ILn82OuWPguNrKe56CI9N0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2G5NXmgmM1gZ6FtF5s6atfxsPXe8xokbChLqG+huarTGjlbjv
	iy8259ODh/kswBMlUWx5tvCFqcoWJMQcqyGL1l42bpYWB37LD8mqN8mD7nmID38=
X-Google-Smtp-Source: AGHT+IElBcfw3tI4eq3ZHM3Z9QnLO8XAdmnOWoe0Rm9oJOi1mRnmmfzhfzgTZCfMbAetS9aN/n/qrw==
X-Received: by 2002:a05:6402:2551:b0:5c9:7cd8:7aef with SMTP id 4fb4d7f45d1cf-5c97cd8bb8emr7950835a12.9.1729147150953;
        Wed, 16 Oct 2024 23:39:10 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4f8b92sm2341206a12.27.2024.10.16.23.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 23:39:08 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:39:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 04/23] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <ZxCxCJk6RFtc-g0F@nanopsycho.orion>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-4-aabe9d225ad5@openvpn.net>
 <Zw947Jb637o-I4RV@nanopsycho.orion>
 <e8e46092-c954-4579-9bdc-563bf30f68f5@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e46092-c954-4579-9bdc-563bf30f68f5@openvpn.net>

Wed, Oct 16, 2024 at 04:24:09PM CEST, antonio@openvpn.net wrote:
>On 16/10/2024 10:27, Jiri Pirko wrote:
>> Wed, Oct 16, 2024 at 03:03:04AM CEST, antonio@openvpn.net wrote:
>> > Add basic infrastructure for handling ovpn interfaces.
>> > 
>> > Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> > ---
>> > drivers/net/ovpn/main.c       | 115 ++++++++++++++++++++++++++++++++++++++++--
>> > drivers/net/ovpn/main.h       |   7 +++
>> > drivers/net/ovpn/ovpnstruct.h |   8 +++
>> > drivers/net/ovpn/packet.h     |  40 +++++++++++++++
>> > include/uapi/linux/if_link.h  |  15 ++++++
>> > 5 files changed, 180 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> > index d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101..eead7677b8239eb3c48bb26ca95492d88512b8d4 100644
>> > --- a/drivers/net/ovpn/main.c
>> > +++ b/drivers/net/ovpn/main.c
>> > @@ -10,18 +10,52 @@
>> > #include <linux/genetlink.h>
>> > #include <linux/module.h>
>> > #include <linux/netdevice.h>
>> > +#include <linux/inetdevice.h>
>> > +#include <net/ip.h>
>> > #include <net/rtnetlink.h>
>> > -#include <uapi/linux/ovpn.h>
>> > +#include <uapi/linux/if_arp.h>
>> > 
>> > #include "ovpnstruct.h"
>> > #include "main.h"
>> > #include "netlink.h"
>> > #include "io.h"
>> > +#include "packet.h"
>> > 
>> > /* Driver info */
>> > #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
>> > #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
>> > 
>> > +static void ovpn_struct_free(struct net_device *net)
>> > +{
>> > +}
>> > +
>> > +static int ovpn_net_open(struct net_device *dev)
>> > +{
>> > +	netif_tx_start_all_queues(dev);
>> > +	return 0;
>> > +}
>> > +
>> > +static int ovpn_net_stop(struct net_device *dev)
>> > +{
>> > +	netif_tx_stop_all_queues(dev);
>> > +	return 0;
>> > +}
>> > +
>> > +static const struct net_device_ops ovpn_netdev_ops = {
>> > +	.ndo_open		= ovpn_net_open,
>> > +	.ndo_stop		= ovpn_net_stop,
>> > +	.ndo_start_xmit		= ovpn_net_xmit,
>> > +};
>> > +
>> > +static const struct device_type ovpn_type = {
>> > +	.name = OVPN_FAMILY_NAME,
>> > +};
>> > +
>> > +static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
>> > +	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
>> > +					    OVPN_MODE_MP),
>> > +};
>> > +
>> > /**
>> >   * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
>> >   * @dev: the interface to check
>> > @@ -33,16 +67,76 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
>> > 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
>> > }
>> > 
>> > +static void ovpn_setup(struct net_device *dev)
>> > +{
>> > +	/* compute the overhead considering AEAD encryption */
>> > +	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
>> > +			     sizeof(struct udphdr) +
>> > +			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
>> > +
>> > +	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
>> > +				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
>> > +				 NETIF_F_HIGHDMA;
>> > +
>> > +	dev->needs_free_netdev = true;
>> > +
>> > +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>> > +
>> > +	dev->netdev_ops = &ovpn_netdev_ops;
>> > +
>> > +	dev->priv_destructor = ovpn_struct_free;
>> > +
>> > +	dev->hard_header_len = 0;
>> > +	dev->addr_len = 0;
>> > +	dev->mtu = ETH_DATA_LEN - overhead;
>> > +	dev->min_mtu = IPV4_MIN_MTU;
>> > +	dev->max_mtu = IP_MAX_MTU - overhead;
>> > +
>> > +	dev->type = ARPHRD_NONE;
>> > +	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
>> > +	dev->priv_flags |= IFF_NO_QUEUE;
>> > +
>> > +	dev->lltx = true;
>> > +	dev->features |= feat;
>> > +	dev->hw_features |= feat;
>> > +	dev->hw_enc_features |= feat;
>> > +
>> > +	dev->needed_headroom = OVPN_HEAD_ROOM;
>> > +	dev->needed_tailroom = OVPN_MAX_PADDING;
>> > +
>> > +	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
>> > +}
>> > +
>> > static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>> > 			struct nlattr *tb[], struct nlattr *data[],
>> > 			struct netlink_ext_ack *extack)
>> > {
>> > -	return -EOPNOTSUPP;
>> > +	struct ovpn_struct *ovpn = netdev_priv(dev);
>> > +	enum ovpn_mode mode = OVPN_MODE_P2P;
>> > +
>> > +	if (data && data[IFLA_OVPN_MODE]) {
>> > +		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
>> 
>> Some sanity check perhaps? "validate" op is here for that purpose.
>
>Isn't the parsing happening here enough
>
>https://elixir.bootlin.com/linux/v6.12-rc3/source/net/core/rtnetlink.c#L3659
>
>The IFINFO_DATA is parsed using the policy I provided (which comes with
>limits for the mode attribute).

You are right, that seems enough for mode.

>
>Or am I misreading the code and I still need to provide an implementation for
>.validate?
>
>Regards,
>
>> 
>> 
>> > +		netdev_dbg(dev, "setting device mode: %u\n", mode);
>> > +	}
>> > +
>> > +	ovpn->dev = dev;
>> > +	ovpn->mode = mode;
>> > +
>> > +	/* turn carrier explicitly off after registration, this way state is
>> > +	 * clearly defined
>> > +	 */
>> > +	netif_carrier_off(dev);
>> > +
>> > +	return register_netdevice(dev);
>> 
>> [...]
>
>-- 
>Antonio Quartulli
>OpenVPN Inc.
>

