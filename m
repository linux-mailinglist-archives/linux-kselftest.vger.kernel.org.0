Return-Path: <linux-kselftest+bounces-20542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBCB9AE6D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EB61C23CA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232301D90AE;
	Thu, 24 Oct 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SQzhPISO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF51D5AD7
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776983; cv=none; b=dgOJRLr60mh9zQ3MtMx0Dm81iF0fOmzUb532CQDyYH58oy9e/B46iyH/Tro43kI6TtZrLH4G0Bi9fv9XNBp56vMBjwytZUuLp2ZG/M/tui8LBbpnXHTsEtbBMQFS4zqClFp92soBddPG2uxOSyTnGZ3Wihcg5ZJm9IGXKGN1PpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776983; c=relaxed/simple;
	bh=dNw4yiNxvN3RffVsXURN65ZdLfgHK4tC7Yc1e224ELQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHFlFQUKG4U5oWz79lReEvyoQKTCGh/nSEhj64xTF6qiP1lfZ3nZvTzw4esIEkLjSPPy6ZZy/vOqumAHCIS4jsLVlL+9tzG0oR1miWvEzg36rqSVnA8gqf15JcRnvfGQnRSaLP4JQr5PPOdyifzERKycW/W9gkeHt5hSW3zhlqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SQzhPISO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6cd4d59d-b635-47a3-8207-c07a18603037@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729776978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wf2g1jKmKuGEGD90gcjJ+D3Suvt0meADVKnkeTAAty8=;
	b=SQzhPISO9aL3GFavgXIE7050rMHRPRmuAJ3mGuvOQ+2Ez/w/a6dHS2GZ3kyN/KScT0+qM0
	ofsmXgFBSnGggJ6baSLnbUNsrY2IjkFMzlnzpUkMHCGSooSA1ydnKQ8iVP/MT8LhP1qYEe
	ZEc9cu5NBsr6tXwn2cqqmQgZhF9/wrI=
Date: Thu, 24 Oct 2024 14:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/4] net: hsr: Add VLAN CTAG filter support
To: MD Danish Anwar <danishanwar@ti.com>, geliang@kernel.org,
 liuhangbin@gmail.com, dan.carpenter@linaro.org, jiri@resnulli.us,
 n.zhandarovich@fintech.ru, aleksander.lobakin@intel.com, lukma@denx.de,
 horms@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 m-malladi@ti.com
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-3-danishanwar@ti.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241024103056.3201071-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/10/2024 11:30, MD Danish Anwar wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> This patch adds support for VLAN ctag based filtering at slave devices.
> The slave ethernet device may be capable of filtering ethernet packets
> based on VLAN ID. This requires that when the VLAN interface is created
> over an HSR/PRP interface, it passes the VID information to the
> associated slave ethernet devices so that it updates the hardware
> filters to filter ethernet frames based on VID. This patch adds the
> required functions to propagate the vid information to the slave
> devices.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>   net/hsr/hsr_device.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 0ca47ebb01d3..ff586bdc2bde 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -515,6 +515,68 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
>   	}
>   }
>   
> +static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
> +				   __be16 proto, u16 vid)
> +{
> +	struct hsr_port *port;
> +	struct hsr_priv *hsr;
> +	int ret = 0;
> +
> +	hsr = netdev_priv(dev);
> +
> +	hsr_for_each_port(hsr, port) {
> +		if (port->type == HSR_PT_MASTER)
> +			continue;
> +
> +		ret = vlan_vid_add(port->dev, proto, vid);
> +		switch (port->type) {
> +		case HSR_PT_SLAVE_A:
> +			if (ret) {
> +				netdev_err(dev, "add vid failed for Slave-A\n");
> +				return ret;
> +			}
> +			break;
> +
> +		case HSR_PT_SLAVE_B:
> +			if (ret) {
> +				/* clean up Slave-A */
> +				netdev_err(dev, "add vid failed for Slave-B\n");
> +				vlan_vid_del(port->dev, proto, vid);
> +				return ret;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}

This function doesn't match with hsr_ndo_vlan_rx_kill_vid().
vlan_vid_add() can potentially be executed for port->type
equals to HSR_PT_INTERLINK, but the result will be ignored. And
the vlan_vid_del() will never happen in this case. Is it desired
behavior? Maybe it's better to synchronize add/del code and refactor
error path to avoid coping the code?

> +
> +static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
> +				    __be16 proto, u16 vid)
> +{
> +	struct hsr_port *port;
> +	struct hsr_priv *hsr;
> +
> +	hsr = netdev_priv(dev);
> +
> +	hsr_for_each_port(hsr, port) {
> +		if (port->type == HSR_PT_MASTER)
> +			continue;
> +		switch (port->type) {
> +		case HSR_PT_SLAVE_A:
> +		case HSR_PT_SLAVE_B:
> +			vlan_vid_del(port->dev, proto, vid);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct net_device_ops hsr_device_ops = {
>   	.ndo_change_mtu = hsr_dev_change_mtu,
>   	.ndo_open = hsr_dev_open,
> @@ -523,6 +585,8 @@ static const struct net_device_ops hsr_device_ops = {
>   	.ndo_change_rx_flags = hsr_change_rx_flags,
>   	.ndo_fix_features = hsr_fix_features,
>   	.ndo_set_rx_mode = hsr_set_rx_mode,
> +	.ndo_vlan_rx_add_vid = hsr_ndo_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = hsr_ndo_vlan_rx_kill_vid,
>   };
>   
>   static const struct device_type hsr_type = {
> @@ -569,7 +633,8 @@ void hsr_dev_setup(struct net_device *dev)
>   
>   	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
>   			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
> -			   NETIF_F_HW_VLAN_CTAG_TX;
> +			   NETIF_F_HW_VLAN_CTAG_TX |
> +			   NETIF_F_HW_VLAN_CTAG_FILTER;
>   
>   	dev->features = dev->hw_features;
>   }
> @@ -647,6 +712,10 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>   	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
>   		hsr->fwd_offloaded = true;
>   
> +	if ((slave[0]->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
> +	    (slave[1]->features & NETIF_F_HW_VLAN_CTAG_FILTER))
> +		hsr_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +
>   	res = register_netdevice(hsr_dev);
>   	if (res)
>   		goto err_unregister;


