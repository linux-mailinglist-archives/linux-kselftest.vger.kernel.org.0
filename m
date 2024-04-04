Return-Path: <linux-kselftest+bounces-7192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0C8988FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877C11C25AC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE1128804;
	Thu,  4 Apr 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lky0dgl1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBC6F068
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238043; cv=none; b=eYozdWXiN3Us6/pzxwy0WY8CwccpAb9YIkUfkMFVTrj0lj0+ktmke2+Ahg59fxcgrS3iZGlgLr4jzzajOCHp1oD1OyQnM8y2B9nKhh+Pmiv6dINfTFjdqGUaYaxG5BEMO6q3JROARVq3FD0fRtIAtFngDsZ9GoF+b2JIpzTqYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238043; c=relaxed/simple;
	bh=mLHMkcj9jzCp00BNnW+DGEYKpHoB55o1zUjDUMFkga8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NexXcQTSaBcbLcaa3lCzbgFGkYB5wIyL+ZbZMA9/5Wmu+Lba+lXhivaBQZ0EosDYeVNGDbGTPiAylzHp312Jc8bhsCsiVaQ0t25EI/Rtr2FJd3KPQidMC0n+CSYcX9Ou8bVCQtXAtclppRDgfkUDizTA8ctKYLojX8bv/5bGwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lky0dgl1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712238041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ydNpZgJGUN/c7ZZ+ebkTEZ8UGqmOS66oXrcLME26ouM=;
	b=Lky0dgl14NhCZhfnQOVncdujsWIoK8UQel+Z2QG8+Oiv0nRAOcJokX06u+eQbsEmh8N24c
	IJPS+h9u9uIC2tA1ysvn9eoQfMnw7ikqGoiKrWDRHgu8m5F+7DGMeQ72wy7rkfsBc4Krzi
	Na8I5ADUlQqN8LDBMyBZuh7v+44P/ow=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-wbYEnRcnMx2p7axX-Sn0kQ-1; Thu, 04 Apr 2024 09:40:37 -0400
X-MC-Unique: wbYEnRcnMx2p7axX-Sn0kQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4155db7b540so2298775e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 06:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712238036; x=1712842836;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydNpZgJGUN/c7ZZ+ebkTEZ8UGqmOS66oXrcLME26ouM=;
        b=dJyjZDry23Bb/LEYAoKJyeeqpz/jHM+kV4Tcww8W+eUOwxSsYqFhnrxXTn0tQx7XQU
         680XsvkpXgfsddecYsJl6/CdoeKH2n//aUYSHnkY+v9DmXPAQAJVyTCDL3/xYz2LowPz
         zUnXH1LEY4shC59Q770QERMN94kos0+xy7RYnbfYpsFMP9jtKHqm2uYma8zdLSYi/kaf
         fuq5UeZm/viwoAHa+5uBIqKdC0n1lRr4wHcOTh0Q669A1e6sRXWRBOoHlWiUy7WfpsHY
         Zl4xeT5ZF10N9C5F5ZbHZtOuxgje4XLkLQHsqUwNv1wI5lNchaMLmyiws91PpDUOOqka
         xEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxht6TjeY/mGDRkpnKtC81kEffkCnFobgTK7pbzwDVMmC/orkodA+ckTlnWMIDMGi+TSiCYvvPCHbiTACj40vstG6+pPii2irrKWi1YvtI
X-Gm-Message-State: AOJu0YwcEUlkJLGqbgYrbpMDTIQrvNvVLNbGciUHiaC6fJVyEnxldfUh
	9Yg1hkP+8EMN9WUeZFUe7YGUrhBgj4pknGpCHxwlZU5wssffrt9BOwsl+6M6SG0+zDjpXJHPssM
	lXPK5BdotQJHcPe77mV8GPuFx6tZoFQZfOZIZ7QChiahihcPJve3G/w1YAN9C4ElCJA==
X-Received: by 2002:a05:6000:1887:b0:343:bccb:af41 with SMTP id a7-20020a056000188700b00343bccbaf41mr1788969wri.4.1712238036698;
        Thu, 04 Apr 2024 06:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1y/4Mn0kSMYlfW3CITygo49lgmgaIzEWyV7zOV6fNZKjT7Hg+ro5S/E+NuwYSX1CKxUjsEw==
X-Received: by 2002:a05:6000:1887:b0:343:bccb:af41 with SMTP id a7-20020a056000188700b00343bccbaf41mr1788945wri.4.1712238036338;
        Thu, 04 Apr 2024 06:40:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id dj11-20020a0560000b0b00b003437799a373sm6661391wrb.83.2024.04.04.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:40:35 -0700 (PDT)
Message-ID: <8f84ab63488c2283108ff08689a1fb2001a70f0a.camel@redhat.com>
Subject: Re: [PATCH net-next v2 5/7] netdevsim: report stats by default,
 like a real device
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, shuah@kernel.org,
 sdf@google.com,  donald.hunter@gmail.com, linux-kselftest@vger.kernel.org,
 petrm@nvidia.com
Date: Thu, 04 Apr 2024 15:40:33 +0200
In-Reply-To: <20240403023426.1762996-6-kuba@kernel.org>
References: <20240403023426.1762996-1-kuba@kernel.org>
	 <20240403023426.1762996-6-kuba@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 19:34 -0700, Jakub Kicinski wrote:
> Real devices should implement qstats. Devices which support
> pause or FEC configuration should also report the relevant stats.
>=20
> nsim was missing FEC stats completely, some of the qstats
> and pause stats required toggling a debugfs knob.
>=20
> Note that the tests which used pause always initialize the setting
> so they shouldn't be affected by the different starting value.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/ethtool.c | 11 ++++++++
>  drivers/net/netdevsim/netdev.c  | 45 +++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>=20
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/etht=
ool.c
> index bd546d4d26c6..3f9c9327f149 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -140,6 +140,13 @@ nsim_set_fecparam(struct net_device *dev, struct eth=
tool_fecparam *fecparam)
>  	return 0;
>  }
> =20
> +static void
> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec=
_stats)
> +{
> +	fec_stats->corrected_blocks.total =3D 123;
> +	fec_stats->uncorrectable_blocks.total =3D 4;
> +}
> +
>  static int nsim_get_ts_info(struct net_device *dev,
>  			    struct ethtool_ts_info *info)
>  {
> @@ -163,6 +170,7 @@ static const struct ethtool_ops nsim_ethtool_ops =3D =
{
>  	.set_channels			=3D nsim_set_channels,
>  	.get_fecparam			=3D nsim_get_fecparam,
>  	.set_fecparam			=3D nsim_set_fecparam,
> +	.get_fec_stats			=3D nsim_get_fec_stats,
>  	.get_ts_info			=3D nsim_get_ts_info,
>  };
> =20
> @@ -182,6 +190,9 @@ void nsim_ethtool_init(struct netdevsim *ns)
> =20
>  	nsim_ethtool_ring_init(ns);
> =20
> +	ns->ethtool.pauseparam.report_stats_rx =3D true;
> +	ns->ethtool.pauseparam.report_stats_tx =3D true;
> +
>  	ns->ethtool.fec.fec =3D ETHTOOL_FEC_NONE;
>  	ns->ethtool.fec.active_fec =3D ETHTOOL_FEC_NONE;
> =20
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
> index 8330bc0bcb7e..096ac0abbc02 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
> +#include <net/netdev_queues.h>
>  #include <net/netlink.h>
>  #include <net/pkt_cls.h>
>  #include <net/rtnetlink.h>
> @@ -330,6 +331,49 @@ static const struct net_device_ops nsim_vf_netdev_op=
s =3D {
>  	.ndo_set_features	=3D nsim_set_features,
>  };
> =20
> +/* We don't have true par-queue stats, yet, so do some random fakery her=
e. */
> +static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_rx *stats)
> +{
> +	struct rtnl_link_stats64 rtstats =3D {};
> +
> +	nsim_get_stats64(dev, &rtstats);
> +
> +	stats->packets =3D rtstats.rx_packets - !!rtstats.rx_packets;
> +	stats->bytes =3D rtstats.rx_bytes;
> +}
> +
> +static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_tx *stats)
> +{
> +	struct rtnl_link_stats64 rtstats =3D {};
> +
> +	nsim_get_stats64(dev, &rtstats);
> +
> +	stats->packets =3D rtstats.tx_packets - !!rtstats.tx_packets;
> +	stats->bytes =3D rtstats.tx_bytes;

It looks the stats will not be self-consistent with multiple queues
enabled.=20

What about zeroing 'stats' when idx > 0 ?

/P


