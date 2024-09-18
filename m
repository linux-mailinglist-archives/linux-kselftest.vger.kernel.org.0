Return-Path: <linux-kselftest+bounces-18112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0105397BCEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1E01F22A72
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A118A6DD;
	Wed, 18 Sep 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ0s5E00"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1237189B9F;
	Wed, 18 Sep 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665457; cv=none; b=UjOUgYTz2jtxcJq+x1jL1TbcsKz16CBsGD0MMD3VU0Qsp9vGURHqXkAbXVL9FgPkF5BSSL2bUqjHT3o9G9zA6PW8Aw7O3GCtk2004L8Lnm72pU3K2Y6IjAlG7m5f2k8jpi/mN1iTU3/wE0tZUAuBBumf5TRlsprU8rL9ylBNbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665457; c=relaxed/simple;
	bh=ddiVg/ZCof9Fc8Z6/UQWstr/Rfs/55bGs9nMmSabZqk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gP0dJbBPFGCDCksp2MQWJ7t8EAxGn3AQS3UuWfvToLhzhbBYlW+zAL4/pc4bLep4aWMhNl/BRf3LKLUZYqhTYjXrACF5g9uV5d144dIvpKfL1h9n2fAKBRv+kvJ1Zfn3M6bwwKKJuzI9n6idqPEhwFnAiJR2RnfyC1XAG/lCLF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ0s5E00; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e1c65eb5bbso3603925eaf.1;
        Wed, 18 Sep 2024 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726665454; x=1727270254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+AjcnUWrTvMalvFIvUO/yMFteny0ikqJRqvvIOwdmY=;
        b=JZ0s5E00h24RCxQi37G+ew1Ra19TvMhzL3/XUg1DwjczpbsndKAyu0YgDBg5YobJ7D
         57r+TivNcuFho13Nmxs8eV1FFnSy57yIDi7pJuQfb8h9UL6PQLwhez/PTqeXyhypOHrG
         K71q8YEmJPBnj5VqySc8niCaaOyFkhNEajMs8WQDSq+h2mS57pfQQgeIkl07kB8KJSTq
         tc8wly204NPlu6v4O6CbF6LNxmpLLBgNgXMEmolRDD34XF4R4UWBC6bBkYj/0bIqsmfa
         i4uRQKlOQbkvV22mI3UxZaRebsk7ZYYf1hBbZQ+tfYXiJl+CfNvBzNR64WwBVTUux04m
         uCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665454; x=1727270254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+AjcnUWrTvMalvFIvUO/yMFteny0ikqJRqvvIOwdmY=;
        b=cV+A3PLcWY96HpXV0Cl58J3oTXOiipI8oqyUVrofItH1N8lSc8ASmoEHTjUAfuG67C
         2ZwzlNk5ChAJzlYgZmZ+6TnNBum6/hjxsG9qD4ufq4o7LkTvJ981Fx4jQy9U8oKdQgoN
         +hXbaAlP110QYWKU7yOMvXFYy219EwmEJoENUZB5vO1IDOjb3ba/pauyfZyevNFjuFz6
         FSsdZYXPe/rD0/+vMq3wjj1RR3kk60YOE9nbxtBjHURisl7X05GzCocBR7cR4lkwmKOe
         SvLGYCDys1iDke90Z9nBRrnIgew7JKUGgENnn4ac0bqaPHtbLoO/piKu7ztmhtkI8c0j
         0YyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1ndqP51duX05RO1OJijLaucN4zbvaS40av10KVzr2G6RMsmNSrMDC/+X8OWd5jBx9s34AJh4A@vger.kernel.org, AJvYcCV1qcLYprCGCi3Ift61Y10+Ys1ZZ5wD5MS8M0/DZdwXIZ01gc0YyTXVkKZt+cI/JB57tdtHHlmR0gfDRKbE@vger.kernel.org, AJvYcCViXL6lhlRrXwzKOK/IFZOJjiExNNDYrEoWbNVfSA60eQdysvQaChevtwwrlKYZ0BNOltU=@vger.kernel.org, AJvYcCW84KZek0uMI/5wEy40JoWxWc2zxx5118+lmcGtf6QZZlzeb2iNifrJCeybJx1Gmm6sTNk0X6rBI1TA8If6XaJo@vger.kernel.org, AJvYcCWvlcXNBfzT3HGt4R/DEAiwNwtsSiI3KB2ahj3fxDOR5K/i32hbmQPxFhgf9fMpPA+4H/pRQE0Kuqqo@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6/fTxFGDdCnJBi0uJHL3hbhXHSDbfdjIJSZc3G9ASpGX0PO0
	3f7AvY2R/i/jA34DGHTbTRZYc9d2UZuCMGYVKVD2/DT9GL/25Y90
X-Google-Smtp-Source: AGHT+IEt2gQ+5dsw6SHDyvOzeq6o0BOI0FdXwXlSspRz1PzHxr5y+AkqJhqweY9iUcUOU8bkua4aPA==
X-Received: by 2002:a05:6358:7247:b0:1b1:ac7f:51d5 with SMTP id e5c5f4694b2df-1bb23dd2f6bmr937437755d.22.1726665453816;
        Wed, 18 Sep 2024 06:17:33 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e95bce0sm456519385a.3.2024.09.18.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:17:33 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:17:32 -0400
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <66ead2ecddf14_29b986294d5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-6-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-6-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 6/9] tun: Introduce virtio-net hash reporting
 feature
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
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  Documentation/networking/tuntap.rst |   7 ++
>  drivers/net/Kconfig                 |   1 +
>  drivers/net/tun.c                   | 146 +++++++++++++++++++++++++++++++-----
>  include/uapi/linux/if_tun.h         |  44 +++++++++++
>  4 files changed, 180 insertions(+), 18 deletions(-)
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
> index 9920b3a68ed1..e2a7bd703550 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select SKB_EXTENSIONS
>  	help
>  	  TUN/TAP provides packet reception and transmission for user space
>  	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9d93ab9ee58f..b8fcd71becac 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -173,6 +173,10 @@ struct tun_prog {
>  	struct bpf_prog *prog;
>  };
>  
> +struct tun_vnet_hash_container {
> +	struct tun_vnet_hash common;
> +};
> +
>  /* Since the socket were moved to tun_file, to preserve the behavior of persist
>   * device, socket filter, sndbuf and vnet header size were restore when the
>   * file were attached to a persist device.
> @@ -210,6 +214,7 @@ struct tun_struct {
>  	struct bpf_prog __rcu *xdp_prog;
>  	struct tun_prog __rcu *steering_prog;
>  	struct tun_prog __rcu *filter_prog;
> +	struct tun_vnet_hash_container __rcu *vnet_hash;

This is just

+struct tun_vnet_hash {
+       u32 value;
+       u16 report;
+};

Can just be fields in the struct directly.

Also, only one bit really used for report, so probably can be
condensed further.

>  	struct ethtool_link_ksettings link_ksettings;
>  	/* init args */
>  	struct file *file;
> @@ -221,6 +226,11 @@ struct veth {
>  	__be16 h_vlan_TCI;
>  };
>  
> +static const struct tun_vnet_hash tun_vnet_hash_cap = {
> +	.flags = TUN_VNET_HASH_REPORT,
> +	.types = VIRTIO_NET_SUPPORTED_HASH_TYPES
> +};
> +
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> @@ -322,10 +332,17 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>  	if (get_user(be, argp))
>  		return -EFAULT;
>  
> -	if (be)
> +	if (be) {
> +		struct tun_vnet_hash_container *vnet_hash = rtnl_dereference(tun->vnet_hash);
> +
> +		if (!(tun->flags & TUN_VNET_LE) &&
> +		    vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
> +			return -EBUSY;
> +

Doesn't be here imply !tun->flags & TUN_VNET_LE? Same again below.

>  		tun->flags |= TUN_VNET_BE;
> -	else
> +	} else {
>  		tun->flags &= ~TUN_VNET_BE;
> +	}
>  
>  	return 0;
>  }
> @@ -522,14 +539,20 @@ static inline void tun_flow_save_rps_rxhash(struct tun_flow_entry *e, u32 hash)
>   * the userspace application move between processors, we may get a
>   * different rxq no. here.
>   */
> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
> +static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb,
> +				   const struct tun_vnet_hash_container *vnet_hash)
>  {
> +	struct tun_vnet_hash_ext *ext;
> +	struct flow_keys keys;
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
> @@ -538,6 +561,16 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  		txq = reciprocal_scale(txq, numqueues);
>  	}
>  
> +	if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT)) {
> +		ext = skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
> +		if (ext) {
> +			u32 types = vnet_hash->common.types;
> +
> +			ext->report = virtio_net_hash_report(types, keys.basic);
> +			ext->value = skb->l4_hash ? skb->hash : txq;
> +		}
> +	}
> +
>  	return txq;
>  }
>  
> @@ -565,10 +598,13 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
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
> +		ret = tun_automq_select_queue(tun, skb, vnet_hash);

Already passing tun, no need to pass tun->vnet_hash separately.
> +	}
>  	rcu_read_unlock();
>  
>  	return ret;
> @@ -2120,33 +2156,63 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr gso;
> +		struct tun_vnet_hash_ext *ext;
> +		size_t vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
> +		union {
> +			struct virtio_net_hdr hdr;
> +			struct virtio_net_hdr_v1_hash hdr_v1_hash;
> +		} vnet_hdr;
> +		int ret;
>  
>  		if (iov_iter_count(iter) < vnet_hdr_sz)
>  			return -EINVAL;
>  
> -		if (virtio_net_hdr_from_skb(skb, &gso,
> -					    tun_is_little_endian(tun), true,
> -					    vlan_hlen)) {
> +		ext = vnet_hdr_sz < sizeof(vnet_hdr.hdr_v1_hash) ?
> +		      NULL : skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
> +
> +		if (ext) {
> +			struct virtio_net_hash hash = {
> +				.value = ext->value,
> +				.report = ext->report,
> +			};
> +
> +			vnet_hdr_content_sz = sizeof(vnet_hdr.hdr_v1_hash);
> +			ret = virtio_net_hdr_v1_hash_from_skb(skb,
> +							      &vnet_hdr.hdr_v1_hash,
> +							      true,
> +							      vlan_hlen,
> +							      &hash);
> +		} else {
> +			vnet_hdr_content_sz = sizeof(struct virtio_net_hdr);
> +			ret = virtio_net_hdr_from_skb(skb,
> +						      &vnet_hdr.hdr,
> +						      tun_is_little_endian(tun),
> +						      true,
> +						      vlan_hlen);
> +		}
> +

This is why just setting the fields directly rather than adding
virtio_net_hdr_v1_hash_from_skb is actually simpler.

> +		if (ret) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
>  			if (net_ratelimit()) {
>  				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> -					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -					   tun16_to_cpu(tun, gso.hdr_len));
> +					   sinfo->gso_type,
> +					   tun16_to_cpu(tun, vnet_hdr.hdr.gso_size),
> +					   tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len));
>  				print_hex_dump(KERN_ERR, "tun: ",
>  					       DUMP_PREFIX_NONE,
>  					       16, 1, skb->head,
> -					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +					       min(tun16_to_cpu(tun, vnet_hdr.hdr.hdr_len), 64),
> +					       true);
>  			}
>  			WARN_ON_ONCE(1);
>  			return -EINVAL;
>  		}
>  
> -		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
> +		if (copy_to_iter(&vnet_hdr, vnet_hdr_content_sz, iter) != vnet_hdr_content_sz)
>  			return -EFAULT;
>  
> -		iov_iter_zero(vnet_hdr_sz - sizeof(gso), iter);
> +		iov_iter_zero(vnet_hdr_sz - vnet_hdr_content_sz, iter);
>  	}
>  
>  	if (vlan_hlen) {
> @@ -3094,6 +3160,8 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  	int le;
>  	int ret;
>  	bool do_notify = false;
> +	struct tun_vnet_hash vnet_hash_common;
> +	struct tun_vnet_hash_container *vnet_hash;
>  
>  	if (cmd == TUNSETIFF || cmd == TUNSETQUEUE ||
>  	    (_IOC_TYPE(cmd) == SOCK_IOC_TYPE && cmd != SIOCGSKNS)) {
> @@ -3115,6 +3183,9 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>  			return -EPERM;
>  		return open_related_ns(&net->ns, get_net_ns);
> +	} else if (cmd == TUNGETVNETHASHCAP) {
> +		return copy_to_user(argp, &tun_vnet_hash_cap, sizeof(tun_vnet_hash_cap)) ?
> +		       -EFAULT : 0;
>  	}
>  
>  	rtnl_lock();
> @@ -3314,6 +3385,13 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			break;
>  		}
>  
> +		vnet_hash = rtnl_dereference(tun->vnet_hash);
> +		if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
> +		    vnet_hdr_sz < (int)sizeof(struct virtio_net_hdr_v1_hash)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
>  		tun->vnet_hdr_sz = vnet_hdr_sz;
>  		break;
>  
> @@ -3328,10 +3406,18 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  			ret = -EFAULT;
>  			break;
>  		}
> -		if (le)
> +		if (le) {
>  			tun->flags |= TUN_VNET_LE;
> -		else
> +		} else {
> +			vnet_hash = rtnl_dereference(tun->vnet_hash);
> +			if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_REPORT) &&
> +			    !tun_legacy_is_little_endian(tun)) {
> +				ret = -EBUSY;
> +				break;
> +			}
> +
>  			tun->flags &= ~TUN_VNET_LE;
> +		}
>  		break;
>  
>  	case TUNGETVNETBE:
> @@ -3396,6 +3482,30 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		ret = open_related_ns(&net->ns, get_net_ns);
>  		break;
>  
> +	case TUNSETVNETHASH:
> +		if (copy_from_user(&vnet_hash_common, argp, sizeof(vnet_hash_common))) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		argp = (struct tun_vnet_hash __user *)argp + 1;
> +
> +		if ((vnet_hash_common.flags & TUN_VNET_HASH_REPORT) &&
> +		    (tun->vnet_hdr_sz < sizeof(struct virtio_net_hdr_v1_hash) ||
> +		     !tun_is_little_endian(tun))) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		vnet_hash = kmalloc(sizeof(vnet_hash->common), GFP_KERNEL);
> +		if (!vnet_hash) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		vnet_hash->common = vnet_hash_common;
> +		kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(tun->vnet_hash, vnet_hash));
> +		break;
> +
>  	default:
>  		ret = -EINVAL;
>  		break;
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..1561e8ce0a0a 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -62,6 +62,30 @@
>  #define TUNSETCARRIER _IOW('T', 226, int)
>  #define TUNGETDEVNETNS _IO('T', 227)
>  
> +/**
> + * define TUNGETVNETHASHCAP - ioctl to get virtio_net hashing capability.
> + *
> + * The argument is a pointer to &struct tun_vnet_hash which will store the
> + * maximal virtio_net hashing configuration.
> + */
> +#define TUNGETVNETHASHCAP _IOR('T', 228, struct tun_vnet_hash)
> +
> +/**
> + * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
> + *
> + * The argument is a pointer to &struct tun_vnet_hash.
> + *
> + * %TUNSETVNETHDRSZ ioctl must be called with a number greater than or equal to
> + * the size of &struct virtio_net_hdr_v1_hash before calling this ioctl with
> + * %TUN_VNET_HASH_REPORT.
> + *
> + * The virtio_net header must be configured as little-endian before calling this
> + * ioctl with %TUN_VNET_HASH_REPORT.
> + *
> + * This ioctl currently has no effect on XDP packets.
> + */
> +#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
> +
>  /* TUNSETIFF ifr flags */
>  #define IFF_TUN		0x0001
>  #define IFF_TAP		0x0002
> @@ -115,4 +139,24 @@ struct tun_filter {
>  	__u8   addr[][ETH_ALEN];
>  };
>  
> +/**
> + * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting for vhost
> + */
> +#define TUN_VNET_HASH_REPORT	0x0001
> +
> +/**
> + * struct tun_vnet_hash - virtio_net hashing configuration
> + * @flags:
> + *		Bitmask consists of %TUN_VNET_HASH_REPORT and %TUN_VNET_HASH_RSS
> + * @pad:
> + *		Should be filled with zero before passing to %TUNSETVNETHASH
> + * @types:
> + *		Bitmask of allowed hash types
> + */
> +struct tun_vnet_hash {
> +	__u16 flags;
> +	__u8 pad[2];
> +	__u32 types;
> +};
> +

The values for flags and types should probably be defined here.

>  #endif /* _UAPI__IF_TUN_H */
> 
> -- 
> 2.46.0
> 



