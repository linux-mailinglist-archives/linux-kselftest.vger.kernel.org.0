Return-Path: <linux-kselftest+bounces-19824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9969A0430
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 10:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730D01C21EBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921D1CEADB;
	Wed, 16 Oct 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fc+pDScL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB61862AE
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067252; cv=none; b=V/0osQB5sc4BnhESTJuUqCJ3v7vsUnPA22OzrigfP4xbHxX5n2kcDDG7T7eX/h0mSAvJDrexPxyBWK4eyA8AI4TJbPblhdy7QoX0r77DdH0Ab9VTVlnHoCZ2+lcVpPa02PtYIuUx8jrDhJ1S1+307NN97jpnl1OGvbJOEiTwbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067252; c=relaxed/simple;
	bh=PVa+FJXTDWZeoxAqKHBZCp7maASc8TfoL8hAtOc6GlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVcAATNpfCdEGC3rmZIKF/zCVyU5ExABKLbO7AlZMabwfc2i48NZ1qdRUuhmjwuCNwO9ErcL90jO9Oa12p+/IAhDSbJBVVf5/saW/CweJ28IAoBuD5/WIc4DFhXYd6uH1oM/xWfCbvBOl0n6qeDm6V8UU33hd5WysjZ0Ny62XvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fc+pDScL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so46623305e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1729067249; x=1729672049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g28iCX0O5SYkdDCU+JsYvIfeHBkuIrm9r0ykt0NO+9k=;
        b=fc+pDScL3abGiXe83W+w8fg/MkPF/zYvLkGkdEFW8s0DJVKIpsI0bTh64Mg1Jc5aSX
         I3ixyF+LXBqW29D/5LFFfg19X6AXgQCowmDzsibLrowdCexaA3Bjoq9aM30grWFMVoAa
         83MCYg/Tt/+NH04tX7iqt5GSk/uLyMut0HTvWIhvQL3+qE6tcYCk3UP/arzHiboKEKfI
         ZnJnHuMJvHE0kvJP9aJ6o6Xj75b4PwIV2znhtUw4ZKd67RFPjshlLglLrIBifhzaD8xb
         5Si4taiAfCOXgGcfEqPkzDS0fNRpMeHc/N77Vp5AQmvCWNc2erADVjGaMYjcWyYDTlXr
         QAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067249; x=1729672049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g28iCX0O5SYkdDCU+JsYvIfeHBkuIrm9r0ykt0NO+9k=;
        b=b2IgjYtNVJOP561FhMBKs3MD2LIfxST0qT2SMQ1sbIrOw1ZIYlI4QQZCA/WIy/1TMf
         nISF71ZoprgrwQqyfuCp6Pg6UThT8Riy0A/Mhonbywq23meJIhPACO84rQ84o4I9b1m+
         LuoEjmMFt4D+HPpsP11/H0TQbjNNFNywss2jM5CqMS1iElaUtB4nP+c4u0z4JxJz63ev
         QXuyYIU8LPoh3uMPPBCFjz7AifbXNaRVaU1of0DLwNIGvJvE/brpsCegWuHchm/xMJvu
         Rnis/6rd8xbKl70GF8ftqtU0M/DW5aoMJM1uCV1N0Q3/M0uZS1bleAGA+//3kzN7wt29
         sXow==
X-Forwarded-Encrypted: i=1; AJvYcCUyBJ9dPUwPx1fTWSRURhPv4+1XTZo6v2OtVpAkDGF/BPjttju9tZI8etlqJ9fxXikOMEg1aWLk5HcQ1ExRkYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJHI4FMYwQ+9TpSpROKKxdbwIYAbNB+E+fECEFU52lnqxBDp9
	P4uXjlLWrlO0K6VK4wX/CWopYBgFE77A5/ddDDkCExiIBT6m8algUlyyo+OX0pw=
X-Google-Smtp-Source: AGHT+IERexqRaMF2wo6pgIqzaWfNekkvkAvO40P+daGklxVCAETU0FoDFC6Q5O/KGhVi2SAiAuuztQ==
X-Received: by 2002:a05:600c:5122:b0:42f:8d36:855e with SMTP id 5b1f17b1804b1-4311deb5f47mr177561545e9.5.1729067248934;
        Wed, 16 Oct 2024 01:27:28 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314bf60fc4sm24841625e9.38.2024.10.16.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:27:28 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:27:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	openvpn-devel@lists.sourceforge.net,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v9 04/23] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <Zw947Jb637o-I4RV@nanopsycho.orion>
References: <20241016-b4-ovpn-v9-0-aabe9d225ad5@openvpn.net>
 <20241016-b4-ovpn-v9-4-aabe9d225ad5@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-b4-ovpn-v9-4-aabe9d225ad5@openvpn.net>

Wed, Oct 16, 2024 at 03:03:04AM CEST, antonio@openvpn.net wrote:
>Add basic infrastructure for handling ovpn interfaces.
>
>Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>---
> drivers/net/ovpn/main.c       | 115 ++++++++++++++++++++++++++++++++++++++++--
> drivers/net/ovpn/main.h       |   7 +++
> drivers/net/ovpn/ovpnstruct.h |   8 +++
> drivers/net/ovpn/packet.h     |  40 +++++++++++++++
> include/uapi/linux/if_link.h  |  15 ++++++
> 5 files changed, 180 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>index d5bdb0055f4dd3a6e32dc6e792bed1e7fd59e101..eead7677b8239eb3c48bb26ca95492d88512b8d4 100644
>--- a/drivers/net/ovpn/main.c
>+++ b/drivers/net/ovpn/main.c
>@@ -10,18 +10,52 @@
> #include <linux/genetlink.h>
> #include <linux/module.h>
> #include <linux/netdevice.h>
>+#include <linux/inetdevice.h>
>+#include <net/ip.h>
> #include <net/rtnetlink.h>
>-#include <uapi/linux/ovpn.h>
>+#include <uapi/linux/if_arp.h>
> 
> #include "ovpnstruct.h"
> #include "main.h"
> #include "netlink.h"
> #include "io.h"
>+#include "packet.h"
> 
> /* Driver info */
> #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
> #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
> 
>+static void ovpn_struct_free(struct net_device *net)
>+{
>+}
>+
>+static int ovpn_net_open(struct net_device *dev)
>+{
>+	netif_tx_start_all_queues(dev);
>+	return 0;
>+}
>+
>+static int ovpn_net_stop(struct net_device *dev)
>+{
>+	netif_tx_stop_all_queues(dev);
>+	return 0;
>+}
>+
>+static const struct net_device_ops ovpn_netdev_ops = {
>+	.ndo_open		= ovpn_net_open,
>+	.ndo_stop		= ovpn_net_stop,
>+	.ndo_start_xmit		= ovpn_net_xmit,
>+};
>+
>+static const struct device_type ovpn_type = {
>+	.name = OVPN_FAMILY_NAME,
>+};
>+
>+static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
>+	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
>+					    OVPN_MODE_MP),
>+};
>+
> /**
>  * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
>  * @dev: the interface to check
>@@ -33,16 +67,76 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
> 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
> }
> 
>+static void ovpn_setup(struct net_device *dev)
>+{
>+	/* compute the overhead considering AEAD encryption */
>+	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
>+			     sizeof(struct udphdr) +
>+			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
>+
>+	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
>+				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
>+				 NETIF_F_HIGHDMA;
>+
>+	dev->needs_free_netdev = true;
>+
>+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>+
>+	dev->netdev_ops = &ovpn_netdev_ops;
>+
>+	dev->priv_destructor = ovpn_struct_free;
>+
>+	dev->hard_header_len = 0;
>+	dev->addr_len = 0;
>+	dev->mtu = ETH_DATA_LEN - overhead;
>+	dev->min_mtu = IPV4_MIN_MTU;
>+	dev->max_mtu = IP_MAX_MTU - overhead;
>+
>+	dev->type = ARPHRD_NONE;
>+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
>+	dev->priv_flags |= IFF_NO_QUEUE;
>+
>+	dev->lltx = true;
>+	dev->features |= feat;
>+	dev->hw_features |= feat;
>+	dev->hw_enc_features |= feat;
>+
>+	dev->needed_headroom = OVPN_HEAD_ROOM;
>+	dev->needed_tailroom = OVPN_MAX_PADDING;
>+
>+	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
>+}
>+
> static int ovpn_newlink(struct net *src_net, struct net_device *dev,
> 			struct nlattr *tb[], struct nlattr *data[],
> 			struct netlink_ext_ack *extack)
> {
>-	return -EOPNOTSUPP;
>+	struct ovpn_struct *ovpn = netdev_priv(dev);
>+	enum ovpn_mode mode = OVPN_MODE_P2P;
>+
>+	if (data && data[IFLA_OVPN_MODE]) {
>+		mode = nla_get_u8(data[IFLA_OVPN_MODE]);

Some sanity check perhaps? "validate" op is here for that purpose.


>+		netdev_dbg(dev, "setting device mode: %u\n", mode);
>+	}
>+
>+	ovpn->dev = dev;
>+	ovpn->mode = mode;
>+
>+	/* turn carrier explicitly off after registration, this way state is
>+	 * clearly defined
>+	 */
>+	netif_carrier_off(dev);
>+
>+	return register_netdevice(dev);

[...]

