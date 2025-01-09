Return-Path: <linux-kselftest+bounces-24135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C16A0792E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE471686D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1421A457;
	Thu,  9 Jan 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9wfHCpp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2421A44F;
	Thu,  9 Jan 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432941; cv=none; b=lBmH7H7mroUXigTZme4I2wR2ihQT17JEGmf4ZkJbXsFsQ8DIDd62ecbICi6HB8IC+amssglEcY9O6yFNB5KoY2dNlJOcGvT+NB8lCbIFIISgy8tKETj56BHINyK8nfbw+cBfwUCsrFPsIHs2CvA76WaZpKM1slb7Xfy2+52ujaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432941; c=relaxed/simple;
	bh=z+dpoKcmFJG6DkTqiPnUe227JSo3yBfXuLIj5n05m6E=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CCCjUnk1wasQhhAk78FEsXfx7Fkit3k5+LJvAqyfAH95O8rP1kzCeieJ2GEiQwGR/5a3TnVEbOiDpKDLefwKr8+KAb72Z+RxJNwF9ZWowYwI2JZvBD23VtMgUF5X4cGe4WlaGp+ZRwa9SpcCjj1qgXHTDZ+hEgMt3VA41axxpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9wfHCpp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6e9586b82so73638885a.1;
        Thu, 09 Jan 2025 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736432938; x=1737037738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bnOIfxDR2A+d8+jAMpst0ef/Z4jwGTJEjkwnm7xzGA=;
        b=O9wfHCppoAErDSxCPY92atMwXjIN3FI9dNwltXoOCgmrBaI4qI3SnApVTVM4y7HkEj
         n8Sp2JHaAVPkqyXjQ5/cEw4rcL0aeHqpuk2WUgpofCW8DBtg8BEK2gPv0EApsxjyCZCV
         YakwhjiReSmAQ3FqAERyQB80iymfU3sVPXjQNetWFnWEhRF7NEk/Zv/u0x1Pg+DehzaL
         uU8ihNcNPk4QkmmnSj0OhGLAbVcLSZZO6dc6J/P40w5I+HkwNFumOl4n4f4YylZHfDdq
         GM+FgpG01UPdQL5e/qkLvDjTvg/33FMQc8LeJH/DvS1LjSNWZEz/+u+huEkciVLlcMFs
         n37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432938; x=1737037738;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bnOIfxDR2A+d8+jAMpst0ef/Z4jwGTJEjkwnm7xzGA=;
        b=Nk/+P21OsoTDHXe1N77rYd72vqbZfw2orjzQTr4JPJvYI92p405bgAffQewfwBS+AK
         dhKmP4bwCnEhbhlsfMOyoCiUQu2g5TdWuEZzF9ifnpaupQpgubvFdgj4F1AnjKD3ff67
         TLWBTxKeTNVd0Rdv9Pt71O4j4/zxSFvpGhsLpcvJRJQsgKDTWFKuKxvn/Q8D5JAMUhzf
         tm9XP3492Gpyy8c0d+w+VRuS7FZhhsMM5ThwSIRZ/80jiN0gX3U8qpGXRYONi3duWVWb
         77FTyu0F+W64EKWrrJMSNAERStAMjYsii8AmMOFYWHAZjreoWHX986gcvd1iFup2P46T
         nE7A==
X-Forwarded-Encrypted: i=1; AJvYcCU1COli/vZ/x81bJQ3F+8pROrfm7YXvrnZ4ut+nRxTLN7ZS/BDZgQzaJ3Goj2A2qtD1iOU4itC+2tSNwDPi@vger.kernel.org, AJvYcCUwJzojB8xwkX7K3JA9jVPbWWWPI9wERCTGZSgiiJM6GmXtaetGBM2T0i7eTndrqMaU+XyBJ/Tnl7oo@vger.kernel.org, AJvYcCWSQfs+wpFTpeFa9Xq970A3MKwpcqDkBtUEFGxc8r8TeH6sgAqt4T8H2UOfCbTN1QG0uWyLQnZL64TPik6Gu3Xf@vger.kernel.org, AJvYcCWo6iYq3BugzqaqVYl8YE6xg1YJuNha6tCZFleIKN6WGjeSBS3FCiXZiVVeEOtpWeaIzDFzhi8G@vger.kernel.org, AJvYcCXcuDzwA2nGgUfGZomjBUuXlZkbbzyYtSF84jbhvDkQECxrQI5Ck3tIok3yCR9rxjfZ3f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yUNWnMfJgiVdf2dICc4lVdHP64g9hBnyvCY9eprSn9JEkcbD
	RFXueng46y5DdNnONhy6Qq7ovkUBlNk1I0z48S2uyzBl6gqWSN3YK3X1Czaw
X-Gm-Gg: ASbGncsmUOP6V+75A3JMEYhZUEYEG0JlpJ9Py1Lkc+cR2f/G71Dw9pXYB0m17S8RhDk
	dAZMriZGrf/xgbD2JuuPi1T0ZeSHK6Ssv0wMqFuQYX9ysCVa9bS/ooUspZ1rOsXtXm64tM/+7gi
	ReGBnMPk3pZ35tE+CPRLoXC+RK0IB1S+bgaBz3co1S6MxjXh/VmrL5z2yEJdXDOAdmzRKH+me0M
	1wz5NWsyUDva5fTYAmVLXG/OhEv4/8DZ69NVZyZ8cWLb1RYzXg5G0MJdvUj2db5koPC4REWmmlE
	aPkBY5jSgayGNWd7Cxauh4yEu1IV
X-Google-Smtp-Source: AGHT+IFsyq89aohnltSSmZiyByrsek1x1OnPWuk6QZx1Xnk31vTjGfwx4D9IskzmAlfR8YrBNFdX7g==
X-Received: by 2002:a05:620a:4052:b0:7b6:d1e1:a22e with SMTP id af79cd13be357-7bcd9715c0dmr1055641485a.29.1736432938220;
        Thu, 09 Jan 2025 06:28:58 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3503196sm71233185a.92.2025.01.09.06.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:28:57 -0800 (PST)
Date: Thu, 09 Jan 2025 09:28:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fdd2968737_362bc129467@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-rss-v6-3-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
 <20250109-rss-v6-3-b1c90ad708f6@daynix.com>
Subject: Re: [PATCH v6 3/6] tun: Introduce virtio-net hash feature
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Hash reporting
> --------------
> 
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> RSS
> ---
> 
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
> 
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  Documentation/networking/tuntap.rst |   7 ++
>  drivers/net/Kconfig                 |   1 +
>  drivers/net/tap.c                   |  50 ++++++++++-
>  drivers/net/tun.c                   |  93 +++++++++++++++-----
>  drivers/net/tun_vnet.c              | 167 +++++++++++++++++++++++++++++++++---
>  drivers/net/tun_vnet.h              |  33 ++++++-
>  include/linux/if_tap.h              |   2 +
>  include/linux/skbuff.h              |   3 +
>  include/uapi/linux/if_tun.h         |  75 ++++++++++++++++
>  net/core/skbuff.c                   |   4 +
>  10 files changed, 397 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
> index 4d7087f727be..86b4ae8caa8a 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>        return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>    }
>  
> +3.4 Reference
> +-------------
> +
> +``linux/if_tun.h`` defines the interface described below:
> +
> +.. kernel-doc:: include/uapi/linux/if_tun.h
> +
>  Universal TUN/TAP device driver Frequently Asked Question
>  =========================================================
>  
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 255c8f9f1d7c..f7b0d9a89a71 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select SKB_EXTENSIONS
>  	select TUN_VNET
>  	help
>  	  TUN/TAP provides packet reception and transmission for user space
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index fe9554ee5b8b..27659df1f96e 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -179,6 +179,16 @@ static void tap_put_queue(struct tap_queue *q)
>  	sock_put(&q->sk);
>  }
>  
> +static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
> +{
> +	return (struct virtio_net_hash *)skb->cb;
> +}
> +
> +static const struct virtio_net_hash *tap_find_hash(const struct sk_buff *skb)
> +{
> +	return (const struct virtio_net_hash *)skb->cb;
> +}
> +

If introducing a cb for tap, define a struct tuntap_skb_cb.

So that we do not have to change types if we ever need to extend it further.

And in line with your other patch that deduplicates between tun and tap,
define only one new struct, not two (as this patch currently does).

>  /*
>   * Select a queue based on the rxq of the device on which this packet
>   * arrived. If the incoming device is not mq, calculate a flow hash
> @@ -189,6 +199,7 @@ static void tap_put_queue(struct tap_queue *q)
>  static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>  				       struct sk_buff *skb)
>  {
> +	struct flow_keys_basic keys_basic;
>  	struct tap_queue *queue = NULL;
>  	/* Access to taps array is protected by rcu, but access to numvtaps
>  	 * isn't. Below we use it to lookup a queue, but treat it as a hint
> @@ -196,17 +207,41 @@ static struct tap_queue *tap_get_queue(struct tap_dev *tap,
>  	 * racing against queue removal.
>  	 */
>  	int numvtaps = READ_ONCE(tap->numvtaps);
> +	struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tap->vnet_hash);
>  	__u32 rxq;
>  
> +	*tap_add_hash(skb) = (struct virtio_net_hash) { .report = VIRTIO_NET_HASH_REPORT_NONE };
> +
>  	if (!numvtaps)
>  		goto out;
>  
>  	if (numvtaps == 1)
>  		goto single;
>  
> +	if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
> +		rxq = tun_vnet_rss_select_queue(numvtaps, vnet_hash, skb, tap_add_hash);
> +		queue = rcu_dereference(tap->taps[rxq]);
> +		goto out;
> +	}
> +
> +	if (!skb->l4_hash && !skb->sw_hash) {
> +		struct flow_keys keys;
> +
> +		skb_flow_dissect_flow_keys(skb, &keys, FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
> +		rxq = flow_hash_from_keys(&keys);
> +		keys_basic = (struct flow_keys_basic) {
> +			.control = keys.control,
> +			.basic = keys.basic
> +		};
> +	} else {
> +		skb_flow_dissect_flow_keys_basic(NULL, skb, &keys_basic, NULL, 0, 0, 0,
> +						 FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
> +		rxq = skb->hash;
> +	}
> +
>  	/* Check if we can use flow to select a queue */
> -	rxq = skb_get_hash(skb);
>  	if (rxq) {
> +		tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, tap_add_hash);

This seems to be introducing multiple new functionalities in one patch:
support for RSS to select a queue, hash report, and possibly more.

Please have one feature change per patch. It's much easier to review
than when code for multiple features is interleaved.


>  		queue = rcu_dereference(tap->taps[rxq % numvtaps]);
>  		goto out;
>  	}
> @@ -713,11 +748,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	int total;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr_v1 vnet_hdr;
> +		struct virtio_net_hdr_v1_hash vnet_hdr;
>  
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>  
> -		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
> +		ret = tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, NULL, skb,
> +					    tap_find_hash, &vnet_hdr);
>  		if (ret < 0)
>  			goto done;
>  
> @@ -1025,7 +1061,13 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>  		return ret;
>  
>  	default:
> -		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
> +		rtnl_lock();
> +		tap = rtnl_dereference(q->tap);
> +		ret = tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
> +				     tap ? &tap->vnet_hash : NULL, -EINVAL,
> +				     true, cmd, sp);
> +		rtnl_unlock();
> +		return ret;
>  	}
>  }
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f211d0580887..efdbd2f65100 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -209,6 +209,7 @@ struct tun_struct {
>  	struct bpf_prog __rcu *xdp_prog;
>  	struct tun_prog __rcu *steering_prog;
>  	struct tun_prog __rcu *filter_prog;
> +	struct tun_vnet_hash_container __rcu *vnet_hash;
>  	struct ethtool_link_ksettings link_ksettings;
>  	/* init args */
>  	struct file *file;
> @@ -451,20 +452,37 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
>  		e->rps_rxhash = hash;
>  }
>  
> +static struct virtio_net_hash *tun_add_hash(struct sk_buff *skb)
> +{
> +	return skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
> +}
> +
> +static const struct virtio_net_hash *tun_find_hash(const struct sk_buff *skb)
> +{
> +	return skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
> +}
> +
>  /* We try to identify a flow through its rxhash. The reason that
>   * we do not check rxq no. is because some cards(e.g 82599), chooses
>   * the rxq based on the txq where the last packet of the flow comes. As
>   * the userspace application move between processors, we may get a
>   * different rxq no. here.
>   */
> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
> +static u16 tun_automq_select_queue(struct tun_struct *tun,
> +				   const struct tun_vnet_hash_container *vnet_hash,
> +				   struct sk_buff *skb)
>  {
> +	struct flow_keys keys;
> +	struct flow_keys_basic keys_basic;
>  	struct tun_flow_entry *e;
>  	u32 txq, numqueues;
>  
>  	numqueues = READ_ONCE(tun->numqueues);
>  
> -	txq = __skb_get_hash_symmetric(skb);
> +	memset(&keys, 0, sizeof(keys));
> +	skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys, 0);
> +
> +	txq = flow_hash_from_keys(&keys);
>  	e = tun_flow_find(&tun->flows[tun_hashfn(txq)], txq);
>  	if (e) {
>  		tun_flow_save_rps_rxhash(e, txq);
> @@ -473,6 +491,13 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  		txq = reciprocal_scale(txq, numqueues);
>  	}
>  
> +	keys_basic = (struct flow_keys_basic) {
> +		.control = keys.control,
> +		.basic = keys.basic
> +	};
> +	tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? skb->hash : txq,
> +			     tun_add_hash);
> +
>  	return txq;
>  }
>  
> @@ -500,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>  	u16 ret;
>  
>  	rcu_read_lock();
> -	if (rcu_dereference(tun->steering_prog))
> +	if (rcu_dereference(tun->steering_prog)) {
>  		ret = tun_ebpf_select_queue(tun, skb);
> -	else
> -		ret = tun_automq_select_queue(tun, skb);
> +	} else {
> +		struct tun_vnet_hash_container *vnet_hash = rcu_dereference(tun->vnet_hash);
> +
> +		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS))
> +			ret = tun_vnet_rss_select_queue(READ_ONCE(tun->numqueues), vnet_hash,
> +							skb, tun_add_hash);
> +		else
> +			ret = tun_automq_select_queue(tun, vnet_hash, skb);
> +	}
>  	rcu_read_unlock();
>  
>  	return ret;
> @@ -1991,8 +2023,8 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
>  	size_t total;
>  
>  	if (tun->flags & IFF_VNET_HDR) {
> -		struct virtio_net_hdr_v1 gso = {
> -			.num_buffers = __virtio16_to_cpu(true, 1)
> +		struct virtio_net_hdr_v1_hash gso = {
> +			.hdr = { .num_buffers = __virtio16_to_cpu(true, 1) }
>  		};
>  
>  		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> @@ -2021,7 +2053,6 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	int vlan_offset = 0;
>  	int vlan_hlen = 0;
>  	int vnet_hdr_sz = 0;
> -	int ret;
>  
>  	if (skb_vlan_tag_present(skb))
>  		vlan_hlen = VLAN_HLEN;
> @@ -2046,9 +2077,11 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr_v1 gso;
> +		struct virtio_net_hdr_v1_hash gso;
> +		int ret;
>  
> -		ret = tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, &gso);
> +		ret = tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tun->dev,
> +					    skb, tun_find_hash, &gso);
>  		if (ret < 0)
>  			goto done;
>  
> @@ -2229,6 +2262,9 @@ static void tun_free_netdev(struct net_device *dev)
>  	security_tun_dev_free_security(tun->security);
>  	__tun_set_ebpf(tun, &tun->steering_prog, NULL);
>  	__tun_set_ebpf(tun, &tun->filter_prog, NULL);
> +	rtnl_lock();
> +	kfree_rcu_mightsleep(rtnl_dereference(tun->vnet_hash));
> +	rtnl_unlock();
>  }
>  
>  static void tun_setup(struct net_device *dev)
> @@ -2927,13 +2963,9 @@ static int tun_set_queue(struct file *file, struct ifreq *ifr)
>  }
>  
>  static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **prog_p,
> -			void __user *data)
> +			int fd)
>  {
>  	struct bpf_prog *prog;
> -	int fd;
> -
> -	if (copy_from_user(&fd, data, sizeof(fd)))
> -		return -EFAULT;
>  
>  	if (fd == -1) {
>  		prog = NULL;
> @@ -3000,6 +3032,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  	int sndbuf;
>  	int ret;
>  	bool do_notify = false;
> +	struct tun_vnet_hash_container *vnet_hash;
>  
>  	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>  	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
> @@ -3058,9 +3091,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		goto unlock;
>  	}
>  
> -	ret = -EBADFD;
> -	if (!tun)
> +	if (!tun) {
> +		ret = tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, true, cmd, argp);
>  		goto unlock;
> +	}
>  
>  	netif_info(tun, drv, tun->dev, "tun_chr_ioctl cmd %u\n", cmd);
>  
> @@ -3236,11 +3270,27 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  
>  	case TUNSETSTEERINGEBPF:
> -		ret = tun_set_ebpf(tun, &tun->steering_prog, argp);
> +		if (get_user(ret, (int __user *)argp)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		vnet_hash = rtnl_dereference(tun->vnet_hash);
> +		if (ret != -1 && vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		ret = tun_set_ebpf(tun, &tun->steering_prog, ret);
>  		break;
>  
>  	case TUNSETFILTEREBPF:
> -		ret = tun_set_ebpf(tun, &tun->filter_prog, argp);
> +		if (get_user(ret, (int __user *)argp)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		ret = tun_set_ebpf(tun, &tun->filter_prog, ret);
>  		break;
>  
>  	case TUNSETCARRIER:
> @@ -3259,7 +3309,10 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  
>  	default:
> -		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags, cmd, argp);
> +		ret = tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
> +				     &tun->vnet_hash, -EINVAL,
> +				     !rtnl_dereference(tun->steering_prog),
> +				     cmd, argp);
>  	}
>  
>  	if (do_notify)
> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> index a7a7989fae56..d36ca3b23265 100644
> --- a/drivers/net/tun_vnet.c
> +++ b/drivers/net/tun_vnet.c
> @@ -58,18 +58,33 @@ static __virtio16 cpu_to_tun_vnet16(unsigned int flags, u16 val)
>  }
>  
>  long tun_vnet_ioctl(int *sz, unsigned int *flags,
> -		    unsigned int cmd, int __user *sp)
> +		    struct tun_vnet_hash_container __rcu **hashp,
> +		    long fallback, bool can_rss,
> +		    unsigned int cmd, void __user *argp)
>  {
> +	static const struct tun_vnet_hash cap = {
> +		.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
> +		.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
> +	};
> +	struct tun_vnet_hash hash_buf;
> +	struct tun_vnet_hash_container *hash;
> +	int __user *sp = argp;
>  	int s;
>  
>  	switch (cmd) {
>  	case TUNGETVNETHDRSZ:
> +		if (!sz)
> +			return -EBADFD;
> +
>  		s = *sz;
>  		if (put_user(s, sp))
>  			return -EFAULT;
>  		return 0;
>  
>  	case TUNSETVNETHDRSZ:
> +		if (!sz)
> +			return -EBADFD;
> +

Here and above: why is this newly needed with this patch?

Same for flags below.

>  		if (get_user(s, sp))
>  			return -EFAULT;
>  		if (s < (int)sizeof(struct virtio_net_hdr))
> @@ -79,12 +94,18 @@ long tun_vnet_ioctl(int *sz, unsigned int *flags,
>  		return 0;
>  
>  	case TUNGETVNETLE:
> +		if (!flags)
> +			return -EBADFD;
> +
>  		s = !!(*flags & TUN_VNET_LE);
>  		if (put_user(s, sp))
>  			return -EFAULT;
>  		return 0;
>  
>  	case TUNSETVNETLE:
> +		if (!flags)
> +			return -EBADFD;
> +
>  		if (get_user(s, sp))
>  			return -EFAULT;
>  		if (s)
> @@ -94,17 +115,132 @@ long tun_vnet_ioctl(int *sz, unsigned int *flags,
>  		return 0;
>  
>  	case TUNGETVNETBE:
> +		if (!flags)
> +			return -EBADFD;
> +
>  		return tun_vnet_get_be(*flags, sp);
>  
>  	case TUNSETVNETBE:
> +		if (!flags)
> +			return -EBADFD;
> +
>  		return tun_vnet_set_be(flags, sp);

