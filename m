Return-Path: <linux-kselftest+bounces-20548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2A9AE9F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694801C250BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88691E378A;
	Thu, 24 Oct 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R6UGdaQO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967B1D86C0;
	Thu, 24 Oct 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782691; cv=none; b=VTyGXv0OwzhC7yZ3RZriAZR8Ig4cMqmMu1ncenijld7pfNMV9eX54mXZra2mKbMMZtRgeAhvncdHBoBO5U4Ry6Y9gPFPEEHejLmtuaSOtPyDZblML/PUF5bjtr7esQQnNnwjWI9buPErYT74tq/6CUo1JvjLXVBevVJ1vM0DYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782691; c=relaxed/simple;
	bh=a3TyFKV8bQ2C8AsfpldZwdswGP6i35LA5XbAJ7NzHjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kO8PTsRzBw2bdWpXeeFXSIl/018obda0tu+nBW49qw0M0e3KU2Y+2xWU5X50VsJXMk3NQJlNuRZtYWbV2BEB88p5vrZfOtdvMRWFtzULc3Mz4TPQc2+LA1lJ8jJFyL+CQozSH888DTZbnCq14zxa3acayqGy2asjyJq/SM6e0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R6UGdaQO; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49OFAcd0051743;
	Thu, 24 Oct 2024 10:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729782638;
	bh=Lx0RGIhvjGwcm6FPAAxd+CivzPqBmE5HANWs11llh7w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R6UGdaQO9DZCB7vWxWzLoZ+4H0Dy5Q55in+6fHw3vssJT7047rifKDXQsey2V2pTN
	 vQKh8/aFREz8Pw5Vrwg+VmzVHq9o7CCAdPZLNybMrbsuoINi0XaFiRlS5vVjn97eir
	 uy051Mx5xEtV4iVqoStmBVuXpOl8QDA4c0dVPU6M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49OFAcfW032095
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Oct 2024 10:10:38 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 10:10:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 10:10:38 -0500
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49OFATsf028284;
	Thu, 24 Oct 2024 10:10:30 -0500
Message-ID: <d8cf61e5-2c56-4c48-9cf3-fd54754c3816@ti.com>
Date: Thu, 24 Oct 2024 20:40:28 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: hsr: Add VLAN CTAG filter support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        MD Danish Anwar
	<danishanwar@ti.com>, <geliang@kernel.org>,
        <liuhangbin@gmail.com>, <dan.carpenter@linaro.org>, <jiri@resnulli.us>,
        <n.zhandarovich@fintech.ru>, <aleksander.lobakin@intel.com>,
        <lukma@denx.de>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
        <diogo.ivo@siemens.com>, <shuah@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <m-malladi@ti.com>
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-3-danishanwar@ti.com>
 <6cd4d59d-b635-47a3-8207-c07a18603037@linux.dev>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <6cd4d59d-b635-47a3-8207-c07a18603037@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vadim,

On 10/24/2024 7:06 PM, Vadim Fedorenko wrote:
> On 24/10/2024 11:30, MD Danish Anwar wrote:
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
>>   net/hsr/hsr_device.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
>> index 0ca47ebb01d3..ff586bdc2bde 100644
>> --- a/net/hsr/hsr_device.c
>> +++ b/net/hsr/hsr_device.c
>> @@ -515,6 +515,68 @@ static void hsr_change_rx_flags(struct net_device
>> *dev, int change)
>>       }
>>   }
>>   +static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
>> +                   __be16 proto, u16 vid)
>> +{
>> +    struct hsr_port *port;
>> +    struct hsr_priv *hsr;
>> +    int ret = 0;
>> +
>> +    hsr = netdev_priv(dev);
>> +
>> +    hsr_for_each_port(hsr, port) {
>> +        if (port->type == HSR_PT_MASTER)
>> +            continue;
>> +
>> +        ret = vlan_vid_add(port->dev, proto, vid);
>> +        switch (port->type) {
>> +        case HSR_PT_SLAVE_A:
>> +            if (ret) {
>> +                netdev_err(dev, "add vid failed for Slave-A\n");
>> +                return ret;
>> +            }
>> +            break;
>> +
>> +        case HSR_PT_SLAVE_B:
>> +            if (ret) {
>> +                /* clean up Slave-A */
>> +                netdev_err(dev, "add vid failed for Slave-B\n");
>> +                vlan_vid_del(port->dev, proto, vid);
>> +                return ret;
>> +            }
>> +            break;
>> +        default:
>> +            break;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
> 
> This function doesn't match with hsr_ndo_vlan_rx_kill_vid().
> vlan_vid_add() can potentially be executed for port->type
> equals to HSR_PT_INTERLINK, but the result will be ignored. And
> the vlan_vid_del() will never happen in this case. Is it desired
> behavior? Maybe it's better to synchronize add/del code and refactor
> error path to avoid coping the code?
> 

The kill_vid / add_vid is not similar because during add_vid, if
vlan_vid_add() succeeds for one port but fails for other, we need to
delete it for the earlier port. We can only continue if vlan_vid_add()
succeeds for both ports. That's the reason the switch case handling of
add_vid can not match the same for kill_vid. Since cleanup of port is
needed, it's not possible to synchronize add/kill code

We only care about HSR_PT_SLAVE_A and HSR_PT_SLAVE_B here. So it's okay
to ignore HSR_PT_INTERLINK. It's a desired behaviour here.

>> +
>> +static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
>> +                    __be16 proto, u16 vid)
>> +{
>> +    struct hsr_port *port;
>> +    struct hsr_priv *hsr;
>> +
>> +    hsr = netdev_priv(dev);
>> +
>> +    hsr_for_each_port(hsr, port) {
>> +        if (port->type == HSR_PT_MASTER)
>> +            continue;
>> +        switch (port->type) {
>> +        case HSR_PT_SLAVE_A:
>> +        case HSR_PT_SLAVE_B:
>> +            vlan_vid_del(port->dev, proto, vid);
>> +            break;
>> +        default:
>> +            break;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct net_device_ops hsr_device_ops = {
>>       .ndo_change_mtu = hsr_dev_change_mtu,
>>       .ndo_open = hsr_dev_open,
>> @@ -523,6 +585,8 @@ static const struct net_device_ops hsr_device_ops = {
>>       .ndo_change_rx_flags = hsr_change_rx_flags,
>>       .ndo_fix_features = hsr_fix_features,
>>       .ndo_set_rx_mode = hsr_set_rx_mode,
>> +    .ndo_vlan_rx_add_vid = hsr_ndo_vlan_rx_add_vid,
>> +    .ndo_vlan_rx_kill_vid = hsr_ndo_vlan_rx_kill_vid,
>>   };
>>     static const struct device_type hsr_type = {
>> @@ -569,7 +633,8 @@ void hsr_dev_setup(struct net_device *dev)
>>         dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
>> NETIF_F_HIGHDMA |
>>                  NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
>> -               NETIF_F_HW_VLAN_CTAG_TX;
>> +               NETIF_F_HW_VLAN_CTAG_TX |
>> +               NETIF_F_HW_VLAN_CTAG_FILTER;
>>         dev->features = dev->hw_features;
>>   }
>> @@ -647,6 +712,10 @@ int hsr_dev_finalize(struct net_device *hsr_dev,
>> struct net_device *slave[2],
>>           (slave[1]->features & NETIF_F_HW_HSR_FWD))
>>           hsr->fwd_offloaded = true;
>>   +    if ((slave[0]->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
>> +        (slave[1]->features & NETIF_F_HW_VLAN_CTAG_FILTER))
>> +        hsr_dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>> +
>>       res = register_netdevice(hsr_dev);
>>       if (res)
>>           goto err_unregister;
> 

-- 
Thanks and Regards,
Md Danish Anwar

