Return-Path: <linux-kselftest+bounces-21221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE99B7D07
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9738B20B45
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860B1A08CC;
	Thu, 31 Oct 2024 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRTvOd23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645F127B56
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385434; cv=none; b=A/E4iwrseJorT/3RGuM8Ebgje0XcnXWD5r/jpCqAIsjVLmgs8ZWrAYU2zf1XDTF/ELBufymBM01Pwsixg7RHgP4hHFdB0shLG5vq0bKzl/HBNp8+oLose4IdK2J4VUSoXBMIiwTrftrHvOpZGp4Kb/kESgOvrtrd7r3+DwrJfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385434; c=relaxed/simple;
	bh=YEUISV/64SzjZW8yf+F9ak/Z634GVYmrT+x+0I2OYqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX7wplFBMRJXLQdubogn76NKu37wQKWgAsrTqVPXYjZWOH8DL9ngX9+AwlNuSZV7aqFRzJVMd+lUkeaUOJRDbS1T4GSX2MB7swGUCqub2p4bJAEW4075jI3zT7y3BufTE+L2zt8xhwGWF7YCotubSn9xYf0I+M5cmU4aiuyXSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRTvOd23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730385431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6O/3GBw63p0l5BBCUi73LPu6bFx6muuGDbHydYXVPs=;
	b=DRTvOd23LsUsnlhT8t8EmZsa91pRNSz9+alapXE80oMItZ3qLf75iX0hS4wAzF34HD5/48
	XplLBstFUsfImuqCPs6VUdJ2S8Db4l/A+ovnEkf1Pr2BExnQufgrhqmlyW8t5JKaOlvHw+
	R2cJmeO4CJTfUS9xR/a7bL8RwAzYioc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-hikZf_fXMKy2QVhzST7hig-1; Thu, 31 Oct 2024 10:37:09 -0400
X-MC-Unique: hikZf_fXMKy2QVhzST7hig-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316e350d6aso6193525e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 07:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730385428; x=1730990228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6O/3GBw63p0l5BBCUi73LPu6bFx6muuGDbHydYXVPs=;
        b=MAC8CqqnENQa8odPejHr/S5van0hF79Ah6ZGCW5/nJ4vtrVlhegL9gXgtjdqEjnXQf
         s5lr/lQv14KTVQEsMZmFoPgUmCXsSkROIHnwYHxdU4ElO14zYuQpR5NRXbp0h9Ayo1Nb
         FwkWAKg4TUKncp08AgxEMhNNdCJKIZxilap90gZQ440e8p0/L4N/7sLitRk1NcWZfped
         UcE5f8FF7G+hBgcwqwAXUFxyIdGV0XHO2I1R5wRhR84UZAd/n5Q7GjW5TzrfrLd50y1V
         fauAXKzkxCArL7PpAeEHeK5UvBLUvm3+VThDNxK7Fwdze8nIsYtqt1QnQvUKuaG/k6Jj
         XpYg==
X-Gm-Message-State: AOJu0YyS1Bo5YeavdFLFL3N31ap0UGBaM9ay1wkSBhg9HAyFN6l3SGuZ
	XMYoduQzVrgjIwSoKQRtW+GacDyOj/wqY1DbQ3yxTRQHJLyocmbJ5Fic1f/dtEL0rxteKawKkKg
	zFR+kmvy/3qYnaThZtWhrTEKwtmLyremPuPUYEyGFAswm44jpiXrQ957/lpoRyXl5GA==
X-Received: by 2002:a05:600c:1ca9:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-4328323f576mr840125e9.2.1730385428470;
        Thu, 31 Oct 2024 07:37:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF4O9nwX/ru8zq05nFqcPwDY9v0i5+K7TjXF+z12dzOML3szYJAwB82EVvIHl/2zaVGkEuAw==
X-Received: by 2002:a05:600c:1ca9:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-4328323f576mr839685e9.2.1730385428000;
        Thu, 31 Oct 2024 07:37:08 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7387sm2268534f8f.51.2024.10.31.07.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:37:07 -0700 (PDT)
Message-ID: <96516e40-5b1b-4bce-a041-7618c03c5de3@redhat.com>
Date: Thu, 31 Oct 2024 15:37:05 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: hsr: Add VLAN CTAG filter support
To: MD Danish Anwar <danishanwar@ti.com>, geliang@kernel.org,
 liuhangbin@gmail.com, dan.carpenter@linaro.org, jiri@resnulli.us,
 n.zhandarovich@fintech.ru, aleksander.lobakin@intel.com, lukma@denx.de,
 horms@kernel.org, jan.kiszka@siemens.com, diogo.ivo@siemens.com,
 shuah@kernel.org, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 m-malladi@ti.com
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-3-danishanwar@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241024103056.3201071-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/24 12:30, MD Danish Anwar wrote:
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
>  net/hsr/hsr_device.c | 71 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 0ca47ebb01d3..ff586bdc2bde 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -515,6 +515,68 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
>  	}
>  }
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

If the desired behavior is to ignore INTERLINK port, I think you should
explicitly skip them here, otherwise you will end-up in a
nondeterministic state.

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

This code relies on a specific port_list order - which is actually
respected at list creation time. Still such assumption looks fragile and
may lead to long term bugs.

I think would be better to refactor the above loop handling arbitrary
HSR_PT_SLAVE_A, HSR_PT_SLAVE_B order. Guestimate is that the complexity
will not increase measurably.

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

I think it would be more consistent just removing the above statement...

> +		switch (port->type) {
> +		case HSR_PT_SLAVE_A:
> +		case HSR_PT_SLAVE_B:
> +			vlan_vid_del(port->dev, proto, vid);
> +			break;
> +		default:> +			break;

... MASTER and INTERLINK port will be ignored anyway.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct net_device_ops hsr_device_ops = {
>  	.ndo_change_mtu = hsr_dev_change_mtu,
>  	.ndo_open = hsr_dev_open,

Cheers,

Paolo


