Return-Path: <linux-kselftest+bounces-24189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04AA08A1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAEA188D2EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0302080DF;
	Fri, 10 Jan 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ibSmOIFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F91F9428
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736497729; cv=none; b=pYiwi6kP1jdWoWr9oTdVoa6d7t5glO/is5NTEfLadshfTOzGRMP/A1fXTnb1AaeXGGNR4wUaFGYo1BkY091VXDbHRQ7rjuSzgJ0ut6Gw3QhruL1f7fKl9CKy3bujb7BoLKbXc+aVhEeiXu/cxO9rcZ7NGmID+Sd5STtM57G+XwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736497729; c=relaxed/simple;
	bh=mpE7hYntObRlHLj2s8ybBavAi+cZh37RwpDamWOgN40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CLgv+e97YQ11NiW7TpTqXcYEnJDaNkUKKtjad0ewsO08nA8wlpWINma85FjMTLfas/ATRHlP0+bOGqzL4TF8jqmiknLZrHyTh+fZ5m9mcjq5frCmKAie/gWlyUgmJsA2b5dzsTnfVn90M5FbO2eOUx7FIZ3e2O+7IYJCsisaVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ibSmOIFU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso29296395ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736497725; x=1737102525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMHAnr47gYJmPF4Dg6UKLdQQ9r7gUgpmT9CNdLeTBRg=;
        b=ibSmOIFU95uLATydrlyBKwidi+SiBBJLTbHROLEupNuyUdhtsPo3JPxU1iBTcry3Fd
         Y3sh+sXTQ54mu063/v8sDikWMRzTPNMPlj4T0fMvhzjKyqUQSUnUKDEjOwRrXk0XkVh5
         zKvEI5+Y2dGpMMXdaXAeddnE08xaeLFOlOlRRV4pXq2xUmzWOZF68D94xeLjfmmgY4cW
         uNpL4wu2pFrEf5ql8q4QogNgiSzOwwh2j9lfMup4CLPMlqotjagZLNuWj8ViTR8FbM9k
         jfuveoSIx3pOMk/nzwYvdeDYrp3YWpAe59RktpbQRTv/5tpLtPOtEOj5o8YuI2MYxD9G
         5ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736497725; x=1737102525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMHAnr47gYJmPF4Dg6UKLdQQ9r7gUgpmT9CNdLeTBRg=;
        b=ku+Nc2zRobeXta0DAQ639QPyRCuIvBgplKpRY65UuMtgWIqJPaSLT/0TeURQLhogI4
         xsn71IXKpaLd8pN3ca6eBZvbUsWJ5quHp0ZEF/u7UYOqwAt5HLMP7uvzUNIQMiY1XXzT
         6Cbr9NufnM29zcgv0TCSdaGdMlu2ZyzvpavJyGhhodAmu4u13wU8zq0VlGtPeipH91P1
         W6dJByebawCX11DA3+rfiSEyf/APs8rzk8Lin8yi+45IXTeGPeg0rT1ofW8QDn3Zj+A9
         S9XjMCkjNQG+nlpGS78qHLYjK8j5cO7OGNSyScd7ziVTd8XkuwODU3h8iz5izRkMvHb/
         xWTg==
X-Forwarded-Encrypted: i=1; AJvYcCVHmxX7y4CrINT7sXWC+vgd4Hkb1T62+pi/56ntpIj2ZhW7Sk7IKp/ubBP0Mfy2nncDrBZ30TNaR674pfq5vOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1pBwOC/hcyCKYrRl3GSgD7UuauiLOwDhc64RrijD/o22xJ7B
	xYkoizPAzJv0MCIH+nEDl6YnapYtuVDDsvna2i8cAl6SN8sx/eBFKfNxcQg3E6E=
X-Gm-Gg: ASbGncvmg2XCptf4dxJr+5QYh5Nk8u3JUxW1rnqZSfDJPhyWSL9PEJTo9uVvPMr8gi6
	FBPSDE6IG7GFrllDs+ebJuC8WxscrNpQ6+ESBpakJMj21d2O6CzHhA2DutO+GwDi8Cu5/yI2BIF
	+n/IRQxrx6K1FHnMcG6gN7ADjV+NisxGGCjVpaQfIJon9pkPZe7paLYkSUezuVWrApj4jAZU3t6
	qC8XhAiA6HGz8I0VShxOrZe2PQUfXuAxsPousDEVS4/C7/rPF/reEugae8bMAT1P8Q=
X-Google-Smtp-Source: AGHT+IF1ZJ34S8wHfK4e0giFWrsLi/td4d5wyPmgupD6AicJN1a26QYSVhI7ULzCco4C0ujTpbXL5A==
X-Received: by 2002:a05:6a20:c70a:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e88cfd5b94mr16188605637.21.1736497725427;
        Fri, 10 Jan 2025 00:28:45 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40569fddsm1067441b3a.39.2025.01.10.00.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 00:28:44 -0800 (PST)
Message-ID: <aeb2bd68-f5b9-49b7-81ff-18472bd8b7b0@daynix.com>
Date: Fri, 10 Jan 2025 17:28:38 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tun: Unify vnet implementation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-1-388d7d5a287a@daynix.com>
 <677fd7d26e090_362bc129432@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <677fd7d26e090_362bc129432@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 23:06, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> Both tun and tap exposes the same set of virtio-net-related features.
>> Unify their implementations to ease future changes.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   MAINTAINERS            |   1 +
>>   drivers/net/Kconfig    |   5 ++
>>   drivers/net/Makefile   |   1 +
>>   drivers/net/tap.c      | 172 ++++++----------------------------------
>>   drivers/net/tun.c      | 208 ++++++++-----------------------------------------
>>   drivers/net/tun_vnet.c | 186 +++++++++++++++++++++++++++++++++++++++++++
>>   drivers/net/tun_vnet.h |  24 ++++++
>>   7 files changed, 273 insertions(+), 324 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 910305c11e8a..1be8a452d11f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23903,6 +23903,7 @@ F:	Documentation/networking/tuntap.rst
>>   F:	arch/um/os-Linux/drivers/
>>   F:	drivers/net/tap.c
>>   F:	drivers/net/tun.c
>> +F:	drivers/net/tun_vnet.h
>>   
>>   TURBOCHANNEL SUBSYSTEM
>>   M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 1fd5acdc73c6..255c8f9f1d7c 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -395,6 +395,7 @@ config TUN
>>   	tristate "Universal TUN/TAP device driver support"
>>   	depends on INET
>>   	select CRC32
>> +	select TUN_VNET
> 
> No need for this new Kconfig

I will merge tun_vnet.c into TAP.

> 
>>   static struct proto tap_proto = {
>>   	.name = "tap",
>> @@ -641,10 +576,10 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	struct sk_buff *skb;
>>   	struct tap_dev *tap;
>>   	unsigned long total_len = iov_iter_count(from);
>> -	unsigned long len = total_len;
>> +	unsigned long len;
>>   	int err;
>>   	struct virtio_net_hdr vnet_hdr = { 0 };
>> -	int vnet_hdr_len = 0;
>> +	int hdr_len;
>>   	int copylen = 0;
>>   	int depth;
>>   	bool zerocopy = false;
>> @@ -652,38 +587,20 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	enum skb_drop_reason drop_reason;
>>   
>>   	if (q->flags & IFF_VNET_HDR) {
>> -		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>> -
>> -		err = -EINVAL;
>> -		if (len < vnet_hdr_len)
>> -			goto err;
>> -		len -= vnet_hdr_len;
>> -
>> -		err = -EFAULT;
>> -		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
>> -			goto err;
>> -		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
>> -		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>> -		     tap16_to_cpu(q, vnet_hdr.csum_start) +
>> -		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
>> -			     tap16_to_cpu(q, vnet_hdr.hdr_len))
>> -			vnet_hdr.hdr_len = cpu_to_tap16(q,
>> -				 tap16_to_cpu(q, vnet_hdr.csum_start) +
>> -				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
>> -		err = -EINVAL;
>> -		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
>> +		hdr_len = tun_vnet_hdr_get(READ_ONCE(q->vnet_hdr_sz), q->flags, from, &vnet_hdr);
>> +		if (hdr_len < 0) {
>> +			err = hdr_len;
>>   			goto err;
>> +		}
>> +	} else {
>> +		hdr_len = 0;
>>   	}
>>   
>> -	err = -EINVAL;
>> -	if (unlikely(len < ETH_HLEN))
>> -		goto err;
>> -
> 
> Is this check removal intentional?

No, I'm not sure what this check is for, but it is irrlevant with vnet 
header and shouldn't be modified with this patch. I'll restore the check 
with the next version.

> 
>> +	len = iov_iter_count(from);
>>   	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>>   		struct iov_iter i;
>>   
>> -		copylen = vnet_hdr.hdr_len ?
>> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
>> +		copylen = hdr_len ? hdr_len : GOODCOPY_LEN;
>>   		if (copylen > good_linear)
>>   			copylen = good_linear;
>>   		else if (copylen < ETH_HLEN)
>> @@ -697,7 +614,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   
>>   	if (!zerocopy) {
>>   		copylen = len;
>> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
>> +		linear = hdr_len;
>>   		if (linear > good_linear)
>>   			linear = good_linear;
>>   		else if (linear < ETH_HLEN)
>> @@ -732,9 +649,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	}
>>   	skb->dev = tap->dev;
>>   
>> -	if (vnet_hdr_len) {
>> -		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
>> -					    tap_is_little_endian(q));
>> +	if (q->flags & IFF_VNET_HDR) {
>> +		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
>>   		if (err) {
>>   			rcu_read_unlock();
>>   			drop_reason = SKB_DROP_REASON_DEV_HDR;
>> @@ -797,23 +713,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
>>   	int total;
>>   
>>   	if (q->flags & IFF_VNET_HDR) {
>> -		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>>   		struct virtio_net_hdr vnet_hdr;
>>   
>>   		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>> -		if (iov_iter_count(iter) < vnet_hdr_len)
>> -			return -EINVAL;
>> -
>> -		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
>> -					    tap_is_little_endian(q), true,
>> -					    vlan_hlen))
>> -			BUG();
>>   
>> -		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
>> -		    sizeof(vnet_hdr))
>> -			return -EFAULT;
>> +		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
>> +		if (ret < 0)
>> +			goto done;
>>   
>> -		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
>> +		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
>> +		if (ret < 0)
>> +			goto done;
> 
> Please split this patch in to a series of smaller patches.
> 
> If feasible:
> 
> 1. one that move the head of tun.c into tun_vnet.[hc].
> 2. then one that uses that also in tap.c.
> 3. then a separate patch for the ioctl changes.
> 4. then introduce tun_vnet_hdr_from_skb, tun_vnet_hdr_put
> and friends in (a) follow-up patch(es).

I will do so.

> 
> This is subtle code. Please report what tests you ran to ensure
> that it does not introduce behavioral changes / regressions.

I tried:
- curl on QEMU with macvtap (vhost=on)
- curl on QEMU with macvtap (vhost=off)

