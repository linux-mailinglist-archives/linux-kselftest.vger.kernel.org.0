Return-Path: <linux-kselftest+bounces-24698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC9A14BEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 10:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1273A15DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BB1F866C;
	Fri, 17 Jan 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5yc+jvQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E407083E;
	Fri, 17 Jan 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105372; cv=none; b=Kwn4nODTBkkPX34NAmzGStAI3i1tshFjMlJoEDz5RBY7LpoZ4aX3AIe1rZWlAr5g8zovmHexywsEYoyv7dKvjjlirQ+QqY/dVgEWQ0Q4Bb41O22f0we3yuF4VJyL0QOtsiyB1xOiQAr5dTVhPn9RaBTGO9HRH7TVxO+tWM/5naA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105372; c=relaxed/simple;
	bh=KNi0T2jTKBJeJCB3+aMk/ZCvS0hODas9BOgOIjyUabk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BeLK2deu/heLhAMBIWSeii3DNy/SIGbq0bijQkqoSt81a4ctbYpQlbCWspXS+WDeq8mj6lezqb8xwvqP8KM11FYtBOPM/OaJ2IahgLwFOpZeUxd7v3DXVLo1+1ZrOQ2uCJ37KgvvS4IgWeP3RpVbhnRnWcNVg8aIoKWGUK8D1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5yc+jvQ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8e773ad77so16306566d6.2;
        Fri, 17 Jan 2025 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105369; x=1737710169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZTgtHN14KI8oTpVLZZm33nZqE+1xPlPrn8gCitpgCg=;
        b=e5yc+jvQ8NwP1ATfAr7ui+9RR/t0dDPwRfs7diZX20vNnLXDqJLgxSdd19t//zgtab
         0tUmABNyURcxX6NVcGS6cYIAJeLUoWpMdyiYAzNCmi32LDqon0tEuWlOAyU0234QsVRt
         hg1zNcJVXFJTWXEkVLchhrB+AxU+z9RKP8ye7p1JqL0zRUKeEXHQc0UduQ1gt/SL2NJb
         M5DDp/SDvUiQGiE3vMoyHczIIGa4bSy4aVTo7a4b+b/kCvBmz1ViZXWzmHu5QNXCqBoz
         CFfOTzxbtIGcQ4ySKNe77TLKr7gUkEIdwn2mVq7Q3/pbpkaUQz5rZfucgDA5vLSKZ9k8
         1+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105369; x=1737710169;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZTgtHN14KI8oTpVLZZm33nZqE+1xPlPrn8gCitpgCg=;
        b=H8ZjdLwdnjX90HvEuWAf2BsGkAagy1zjWXUGKxYWxDIIREKtuI52nJ82Bkj37lRjpB
         HvLrq3iHw+sWba/amGBJFviQAp+KSEpMQYRQKNjsRsMq/TLXBC8RaoTl1ZczsZTtuPml
         5DAbs13GOGC9hmhP5wX0ZWkjia43HwwfEukulj9WMugC6RRH/ouctNAxUWplqwnT/jXJ
         dKlzNN8wGx739lPLhOKLNRvLjc7ifRpmzrbtNZpgQrN6fHWgV2wGCLdqnP5fdgu9XObx
         ienTSYxVuEHKKj/sVCasXI+Q8Z+m5pZ13sEPkHxNhYBqaNNoLiUzCdyLXLITpHyTfERv
         jRzg==
X-Forwarded-Encrypted: i=1; AJvYcCUIIZKPX9qHbjAh3VMIwsTtq31uC5YGK2b+TIOYz4c5kHc2O5Sc8iByQj43iMWkh9NGybPQxtaGlgDdxh0L@vger.kernel.org, AJvYcCV3Fh28JvUvvdQqTc4bDFv74Mi1EYWHWDd8R9dd0ZFgtvHFoEP0S3ffmohQYLTIC2rZTk1bmnY7@vger.kernel.org, AJvYcCVVJq8Tz+d9MXOhesRnb4Hc3A0f1AkVaFLRWgEGgC+4TxkEB/22R7vgapAxlgFIkZi/eJKmmEFvuTjz@vger.kernel.org, AJvYcCWKHLZCrz8rK8H4J4/cik+0p69N4/X7USxERgYn1VktrBmuC6f8ydvaSBxFmYKNAT4BpfQ=@vger.kernel.org, AJvYcCX8uc6dUYRwnYUquaymeZdPUvnNMPlRozEH8oTaTFbTaJJEDTUwxmXE+oyBuBu3M4jOxMW2Ke3k5zy5oDToFPek@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YuwQpk/0i142zSW/JssrJlsBxQa13Ii3+2Z6rsYhDC9mDUy+
	DnqB/0e3Ni3262XLXZpakXT1kQ/c8smyS8uAZpbWiWkG3ehmFLxs
X-Gm-Gg: ASbGncspTEwRFGLR/sOamMPO6Goni6NeULffbKx1e4PpPQk8gTLedpcV9kyb/xMZVKQ
	OwkLjCsPM1txSyePnhJy0cbAgwodcvJwdvLv6U4gIPQMjbFULIQRmfJKg1hhou0vj4n1b6mXbIf
	5GKp0F498PCPREMHCYuODfQ34JDFFc7RA/926HHVhL8XSxDXuSdddLhbJhr752pShfRFFkp2lFF
	TmRdgrJQH07Ewf1wSGn+5ZQm4b0AyyoTt5LJ/xzWkRoSWNjFYzbG6i3X0T/B/qnMOTN7uIpZ19o
	RscfMIojxcCIGMI0/dTCmyRTLYr6
X-Google-Smtp-Source: AGHT+IHN8TErnIji3r8Qq5buiozYuzN7Fv/FHh3X7BOlSf/UuB6xpajfD/Tj2rE5wqRrGsGj45mPCA==
X-Received: by 2002:a05:6214:4b0f:b0:6d4:36ff:4356 with SMTP id 6a1803df08f44-6e1b217dc6emr37454886d6.19.1737105368950;
        Fri, 17 Jan 2025 01:16:08 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc0ff47sm9627386d6.29.2025.01.17.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:16:08 -0800 (PST)
Date: Fri, 17 Jan 2025 04:16:07 -0500
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
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <678a1fd7d7c85_3e503c29449@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-4-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-4-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 4/9] tun: Decouple vnet from tun_struct
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
> Decouple vnet-related functions from tun_struct so that we can reuse
> them for tap in the future.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tun.c | 53 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ec56ac865848..add09dfdada5 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -298,16 +298,16 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
>  	return tfile->napi_frags_enabled;
>  }
>  
> -static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
> +static inline bool tun_legacy_is_little_endian(unsigned int flags)
>  {
>  	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> -		 (tun->flags & TUN_VNET_BE)) &&
> +		 (flags & TUN_VNET_BE)) &&
>  		virtio_legacy_is_little_endian();
>  }
>  
> -static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
> +static long tun_get_vnet_be(unsigned int flags, int __user *argp)
>  {
> -	int be = !!(tun->flags & TUN_VNET_BE);
> +	int be = !!(flags & TUN_VNET_BE);
>  
>  	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
>  		return -EINVAL;
> @@ -318,7 +318,7 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
>  	return 0;
>  }
>  
> -static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
> +static long tun_set_vnet_be(unsigned int *flags, int __user *argp)
>  {
>  	int be;
>  
> @@ -329,27 +329,26 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>  		return -EFAULT;
>  
>  	if (be)
> -		tun->flags |= TUN_VNET_BE;
> +		*flags |= TUN_VNET_BE;
>  	else
> -		tun->flags &= ~TUN_VNET_BE;
> +		*flags &= ~TUN_VNET_BE;
>  
>  	return 0;
>  }
>  
> -static inline bool tun_is_little_endian(struct tun_struct *tun)
> +static inline bool tun_is_little_endian(unsigned int flags)
>  {
> -	return tun->flags & TUN_VNET_LE ||
> -		tun_legacy_is_little_endian(tun);
> +	return flags & TUN_VNET_LE || tun_legacy_is_little_endian(flags);
>  }
>  
> -static inline u16 tun16_to_cpu(struct tun_struct *tun, __virtio16 val)
> +static inline u16 tun16_to_cpu(unsigned int flags, __virtio16 val)
>  {
> -	return __virtio16_to_cpu(tun_is_little_endian(tun), val);
> +	return __virtio16_to_cpu(tun_is_little_endian(flags), val);
>  }
>  
> -static inline __virtio16 cpu_to_tun16(struct tun_struct *tun, u16 val)
> +static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
>  {
> -	return __cpu_to_virtio16(tun_is_little_endian(tun), val);
> +	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
>  }
>  
>  static inline u32 tun_hashfn(u32 rxhash)
> @@ -1764,6 +1763,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  
>  	if (tun->flags & IFF_VNET_HDR) {
>  		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
> +		int flags = tun->flags;

Here and elsewhere: instead of passing around and repeatedly parsing
flags, have a variable is_little_endian (or is_le)?
>  
>  		if (iov_iter_count(from) < vnet_hdr_sz)
>  			return -EINVAL;
> @@ -1772,12 +1772,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			return -EFAULT;
>  
>  		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> -		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
> -			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
> +		    tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2 > tun16_to_cpu(flags, gso.hdr_len))
> +			gso.hdr_len = cpu_to_tun16(flags, tun16_to_cpu(flags, gso.csum_start) + tun16_to_cpu(flags, gso.csum_offset) + 2);
>  
> -		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
> +		if (tun16_to_cpu(flags, gso.hdr_len) > iov_iter_count(from))
>  			return -EINVAL;
> -		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
> +		hdr_len = tun16_to_cpu(flags, gso.hdr_len);
>  		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
>  	}
>  
> @@ -1854,7 +1854,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		}
>  	}
>  
> -	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun))) {
> +	if (virtio_net_hdr_to_skb(skb, &gso, tun_is_little_endian(tun->flags))) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
> @@ -2108,23 +2108,24 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  
>  	if (vnet_hdr_sz) {
>  		struct virtio_net_hdr gso;
> +		int flags = tun->flags;
>  
>  		if (iov_iter_count(iter) < vnet_hdr_sz)
>  			return -EINVAL;
>  
>  		if (virtio_net_hdr_from_skb(skb, &gso,
> -					    tun_is_little_endian(tun), true,
> +					    tun_is_little_endian(flags), true,
>  					    vlan_hlen)) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
>  
>  			if (net_ratelimit()) {
>  				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> -					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -					   tun16_to_cpu(tun, gso.hdr_len));
> +					   sinfo->gso_type, tun16_to_cpu(flags, gso.gso_size),
> +					   tun16_to_cpu(flags, gso.hdr_len));
>  				print_hex_dump(KERN_ERR, "tun: ",
>  					       DUMP_PREFIX_NONE,
>  					       16, 1, skb->head,
> -					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +					       min((int)tun16_to_cpu(flags, gso.hdr_len), 64), true);
>  			}
>  			WARN_ON_ONCE(1);
>  			return -EINVAL;
> @@ -2493,7 +2494,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>  	skb_put(skb, xdp->data_end - xdp->data);
>  
> -	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
> +	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun->flags))) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret = -EINVAL;
> @@ -3322,11 +3323,11 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  
>  	case TUNGETVNETBE:
> -		ret = tun_get_vnet_be(tun, argp);
> +		ret = tun_get_vnet_be(tun->flags, argp);
>  		break;
>  
>  	case TUNSETVNETBE:
> -		ret = tun_set_vnet_be(tun, argp);
> +		ret = tun_set_vnet_be(&tun->flags, argp);
>  		break;
>  
>  	case TUNATTACHFILTER:
> 
> -- 
> 2.47.1
> 



