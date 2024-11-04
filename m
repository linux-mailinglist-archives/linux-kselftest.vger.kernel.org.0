Return-Path: <linux-kselftest+bounces-21378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61639BB33E
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 12:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40B91C222B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80241C32E4;
	Mon,  4 Nov 2024 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ql0xCViH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782EE18A6BA;
	Mon,  4 Nov 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719284; cv=none; b=o+tX97UhKx37mrINMWPG2k8rAiz9uYJiem6GfwTFmKoLaI/UYedy99/uSeJUPHY4hHTx89gcGBwlBZ6eRb5ohlkJH9QZWEWnfRKDSXr2OmXutnkSYcbtrCOVUJceOsbG02KytEDMB1KxkkO/VgqAJaBxjUFFP5hByvFeDYUU5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719284; c=relaxed/simple;
	bh=5dWmHeM8L+SOWpGeKy8DQhq+sQL1Cc1fMcoqmHjSiCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ihonotw4fMMyvpuVp7NkgEomWfomyCY/39+IYcDPBgofoXng3P5BJCV6HX30yiEQ1HPsnI1hWZ+REX3Gz/AvHc4LdhpPcQyhI35UbKbVHJ6/g6WqIMEo0z+iFmpdRa+BMG6RXsDRYI/Hqpz7WNqAICLHBzWLk52YuZd4UJle8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ql0xCViH; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A4BKtUN015957;
	Mon, 4 Nov 2024 05:20:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730719255;
	bh=p8zpcibKY3hqksAHMVTShQ6+sIn7mqMODAwSQ0CsTEA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ql0xCViHBWFugoltjL0DiHLK5GPOC2702OZOcj2HQFeNnOttIPqkE75n7MR+dci4+
	 DYtiOQvfmoluKpkZdo0qpPIjA8v+c0T6CvY8zjFgMuq07yQMvfrbSZSizuvSeK/Tfg
	 YEPPS7dZakeuifFqFZzdezbbAnKONqT7XekNW37w=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A4BKtlx018500;
	Mon, 4 Nov 2024 05:20:55 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Nov 2024 05:20:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Nov 2024 05:20:54 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A4BKlVs041849;
	Mon, 4 Nov 2024 05:20:48 -0600
Message-ID: <0e661e6a-6057-4a16-bc41-b96cd18e8fe7@ti.com>
Date: Mon, 4 Nov 2024 16:50:47 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: hsr: Add VLAN CTAG filter support
To: Paolo Abeni <pabeni@redhat.com>, <geliang@kernel.org>,
        <liuhangbin@gmail.com>, <dan.carpenter@linaro.org>, <jiri@resnulli.us>,
        <n.zhandarovich@fintech.ru>, <aleksander.lobakin@intel.com>,
        <lukma@denx.de>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
        <diogo.ivo@siemens.com>, <shuah@kernel.org>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <m-malladi@ti.com>
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-3-danishanwar@ti.com>
 <96516e40-5b1b-4bce-a041-7618c03c5de3@redhat.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <96516e40-5b1b-4bce-a041-7618c03c5de3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Paolo,

On 31/10/24 8:07 pm, Paolo Abeni wrote:
> 
> 
> On 10/24/24 12:30, MD Danish Anwar wrote:
>> From: Murali Karicheri <m-karicheri2@ti.com>
>>
>> This patch adds support for VLAN ctag based filtering at slave devices.
>> The slave ethernet device may be capable of filtering ethernet packets
>> based on VLAN ID. This requires that when the VLAN interface is created
>> over an HSR/PRP interface, it passes the VID information to the
>> associated slave ethernet devices so that it updates the hardware
>> filters to filter ethernet frames based on VID. This patch adds the
>> required functions to propagate the vid information to the slave
>> devices.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  net/hsr/hsr_device.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>> index 0ca47ebb01d3..ff586bdc2bde 100644
>> --- a/net/hsr/hsr_device.c
>> +++ b/net/hsr/hsr_device.c
>> @@ -515,6 +515,68 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
>>  	}
>>  }
>>  
>> +static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>> +				   __be16 proto, u16 vid)
>> +{
>> +	struct hsr_port *port;
>> +	struct hsr_priv *hsr;
>> +	int ret = 0;
>> +
>> +	hsr = netdev_priv(dev);
>> +
>> +	hsr_for_each_port(hsr, port) {
>> +		if (port->type == HSR_PT_MASTER)
>> +			continue;
> 
> If the desired behavior is to ignore INTERLINK port, I think you should
> explicitly skip them here, otherwise you will end-up in a
> nondeterministic state.
> 

Sure, I will change this to

	hsr_for_each_port(hsr, port) {
		if (port->type == HSR_PT_MASTER ||
		    port->type = HSR_PT_INTERLINK)
			continue;

>> +		ret = vlan_vid_add(port->dev, proto, vid);
>> +		switch (port->type) {
>> +		case HSR_PT_SLAVE_A:
>> +			if (ret) {
>> +				netdev_err(dev, "add vid failed for Slave-A\n");
>> +				return ret;
>> +			}
>> +			break;
>> +
>> +		case HSR_PT_SLAVE_B:
>> +			if (ret) {
>> +				/* clean up Slave-A */
>> +				netdev_err(dev, "add vid failed for Slave-B\n");
>> +				vlan_vid_del(port->dev, proto, vid);
> 
> This code relies on a specific port_list order - which is actually
> respected at list creation time. Still such assumption looks fragile and
> may lead to long term bugs.
> 

Agreed. The code is expecting HSR_PT_SLAVE_A to come first and add vid
for it. Then vid is added for HSR_PT_SLAVE_B. if vlan_vid_add fails for
HSR_PT_SLAVE_B, vid is deleted for HSR_PT_SLAVE_A before returning.

> I think would be better to refactor the above loop handling arbitrary
> HSR_PT_SLAVE_A, HSR_PT_SLAVE_B order. Guestimate is that the complexity
> will not increase measurably.
> 

I understand this will be better. But how would I figure out which port
came first.

The current implementation is to add vid for first port. If it fails it
returns. If it passes it adds vid for second port. If it fails it clears
vid of first port and returns. If it passes function returns 0.

Now how do I keep this behavior and also handle ports arbitrary. If the
same order is not guaranteed to be preserved, how would I know which
port came first so that it can be deleted if second port fails?

One idea I have is to keep two boolean flags is_slave_a_added,
is_slave_b_added. And based on these flags we can determine if cleanup
is needed or not.

The add function will then look like this,

static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
				   __be16 proto, u16 vid)
{
	bool is_slave_a_added, is_slave_b_added;
	struct hsr_port *port;
	struct hsr_priv *hsr;
	int ret = 0;

	hsr = netdev_priv(dev);

	hsr_for_each_port(hsr, port) {
		if (port->type == HSR_PT_MASTER ||
		    port->type = HSR_PT_INTERLINK)
			continue;

		ret = vlan_vid_add(port->dev, proto, vid);
		switch (port->type) {
		case HSR_PT_SLAVE_A:
			if (ret) {
				/* clean up Slave-B */
				netdev_err(dev, "add vid failed for Slave-A\n");
				if (is_slave_b_added)
					vlan_vid_del(port->dev, proto, vid);
				return ret;
			} else {
				is_slave_a_added = true;
			}
			break;

		case HSR_PT_SLAVE_B:
			if (ret) {
				/* clean up Slave-A */
				netdev_err(dev, "add vid failed for Slave-B\n");
				if (is_slave_a_added)
					vlan_vid_del(port->dev, proto, vid);
				return ret;
			} else {
				is_slave_b_added = true;
			}
			break;
		default:
			break;
		}
	}

	return 0;
}

Let me know if this is OK. Or if you have some other method to handle
the ports arbitrary.

>> +				return ret;
>> +			}
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
>> +				    __be16 proto, u16 vid)
>> +{
>> +	struct hsr_port *port;
>> +	struct hsr_priv *hsr;
>> +
>> +	hsr = netdev_priv(dev);
>> +
>> +	hsr_for_each_port(hsr, port) {
>> +		if (port->type == HSR_PT_MASTER)
>> +			continue;
> 
> I think it would be more consistent just removing the above statement...
> 

Sure. I'll do it.

>> +		switch (port->type) {
>> +		case HSR_PT_SLAVE_A:
>> +		case HSR_PT_SLAVE_B:
>> +			vlan_vid_del(port->dev, proto, vid);
>> +			break;
>> +		default:> +			break;
> 
> ... MASTER and INTERLINK port will be ignored anyway.
> 

Sure.

>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct net_device_ops hsr_device_ops = {
>>  	.ndo_change_mtu = hsr_dev_change_mtu,
>>  	.ndo_open = hsr_dev_open,
> 
> Cheers,
> 
> Paolo
> 

-- 
Thanks and Regards,
Danish

