Return-Path: <linux-kselftest+bounces-24790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72748A16B79
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 12:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F15B163902
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CED1DF244;
	Mon, 20 Jan 2025 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk49HB7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DC167DAC;
	Mon, 20 Jan 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372183; cv=none; b=QThxzZHh1KZn7TwXzgnFJ+l9zrQbdJq43vbUaX4aPY0XGUhFHnNNRPpoCOMYAd87ZvVHV80mjC2ahVNhqlzb7kwCL2HBzMcVVM7wXD/KPWlUQu/9OUsiiKmLH+IsjEtQ7LwzzU0qSoOpo/gkB03PTdSMCtpVsgC/7WqEt5O0Nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372183; c=relaxed/simple;
	bh=HL4NOIBIqDr6Darnum6YQxEjBaAyuTmyhd02SeFQ4Xs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=peIAa/r2VAhnK7A5iwRikuJGqWkT/7t6mTbFI17cSS4ayzJETn4WP0KlCLkPR9fyPrayDKs2SLN446sTM/Mf5sNHpwrYqV8Z5mA4rirics9xO8eGXgDdZpGX08mHWpPWN2srlC8o1IGcU7vrH4Zh8waKwDVEjIB4IIP+D1r6Ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk49HB7d; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b9bc648736so429478785a.1;
        Mon, 20 Jan 2025 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737372181; x=1737976981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LmLNrJ6dN/z3G0kjzC1LxBo8C1cL6y8Q3pCQOJZRpo=;
        b=kk49HB7dv/bvmrJ5H+9b0qw72Zae8hbt4lgR4mwtZgeElrO9FgJcl7Fk/fguqccDX2
         CbOg3B9EEgrT7fmCNswCbtT3ptUzfEx6jr/dAGTEJC8acKdD8OSA/H8l9edeelcsrVYQ
         V4+qH8uYBH+1m35F5TAmIl5rOw4I8XZboceBW9khm2dwMyCw88rak0w2Qfnpr1O/4Tfr
         ErGiF2KrY/QDuoEFiVLDskBHzpKwlIlJevfg/EI82+N8Qxa9BuxxogL7iMmzyULLPCY6
         nuXiywkDTDjto7JqyRf+k8SmL8L4HFLoHkN8RgFKfN3VCH3d3hSfg6wHxYZrdMcA1asF
         vGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372181; x=1737976981;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LmLNrJ6dN/z3G0kjzC1LxBo8C1cL6y8Q3pCQOJZRpo=;
        b=IHVxXBnd6tiGEg0vv0OmexzQoM2scftHXext+t8mdSfowo9vET8GYqQhIg76/CJEuE
         PmMJj2+RkKzUsLa7ovw6MdCl3XgoftsAqCvtSqoYK7ChDwNa+YccrsOPGz7OCZoK9dGJ
         wQ5EYxg6jRPRzwxSC6+Fl42hrWz6T3Xkm+obDYkcXGR2/LsXlW3PUW4oZo1G07a+7LVt
         I7o3Hh4Mlu1UPYamoPpgzbI3EReMNEl1tKmLv2+xccyrJz0k891HuvEVXMSQJQUeEyTW
         Zy4ZZimUXcplpguBmmyD4mNHXSFZnmDqSzLryo/atAEKHYgkA+CEZt/S+haMN2ryLVM0
         pS+A==
X-Forwarded-Encrypted: i=1; AJvYcCVCsT5VRFz5TIqtRKldC17zGVUIN4IAzDscNT/x2q1XBGoGg45taAkzuU2M85KUGAd/JpU=@vger.kernel.org, AJvYcCVG8OVgMSMkXPJYbCdWmuSdju74yirxtiQ3gf0UGb08r/ovIkGe8jYAsKNkZlosLQGAe0Q1hwAdA5hH@vger.kernel.org, AJvYcCWcwPgZXobPF1mjrjPIvmprpCHdMgs5GLTRpRbSyqtihZssUeNfar06atrUgup4BMt9pymM3MFt29JGlkaI@vger.kernel.org, AJvYcCXeo58/9o8znYy1V8eCrOjmuGjudnY5nWredrpweWfSpCoTvgVB33P/5tu8WoSP9syO/nvao8gC@vger.kernel.org, AJvYcCXg9K1O0PdLq3zlfjspCwLnpIWzgM/wrJ0n6Gv1CQj7LXHWSvzS9y7dnQq2hrz42mP134Li8lmCMzmmvttsIw9J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9amNNbNy4Qj6yM20N7WOlAQBOBNjASIogog5psceD10bJwt/8
	K9LWixBYnybh5Fq/hE+b74nxPusxjPRXS+D32F6mp0SxzZ8Gz1SG
X-Gm-Gg: ASbGncv13qaLXOFap8ykRYDhTMhKxmPh93CbtCvC+S0oqTMbnt7gQuvgvRCk+YESERD
	3sNhKmSAe0B0Me2vWQPwcNOCOqXzDJr6nuZBdNaMSAeoa1fegvEZYKlpk5IdkdjmRwjw4gguFDZ
	OVGRp1U7R1N35QM4eBl4zYHbPkVcfa/vb64+aKD4uzVQ9WRwflHTRGvZYCTMTcZZLZkdwFGRa+m
	rJiChzbXp2n/kpRxqaXw+56AU20NXM2oVScnDWYrzLpPtoDyhXegnbMgkQlYX8mobukXQhq4BE4
	Tcq/GmT3MIILETfyznlaYzvvSZjpV/O0cwFLeJ6E9A==
X-Google-Smtp-Source: AGHT+IE9/KsqlakxdkIjJQLNUAmeevdFGSUQQ85Q/xSP4kAbWM2K4qAj7YFEOy9G3QE7BawLS+XjRA==
X-Received: by 2002:a05:620a:2848:b0:7b6:dedf:b6c2 with SMTP id af79cd13be357-7be631e51e0mr2045349785a.5.1737372180817;
        Mon, 20 Jan 2025 03:23:00 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147591bsm434654785a.4.2025.01.20.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:23:00 -0800 (PST)
Date: Mon, 20 Jan 2025 06:23:00 -0500
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
Message-ID: <678e321430c77_19c737294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-7-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-7-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 7/9] tap: Avoid double-tracking iov_iter
 length changes
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
> tap_get_user() used to track the length of iov_iter with another
> variable. We can use iov_iter_count() to determine the current length
> to avoid such chores.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -641,7 +641,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	struct sk_buff *skb;
>  	struct tap_dev *tap;
>  	unsigned long total_len = iov_iter_count(from);
> -	unsigned long len = total_len;
> +	unsigned long len;
>  	int err;
>  	struct virtio_net_hdr vnet_hdr = { 0 };
>  	int vnet_hdr_len = 0;
> @@ -655,9 +655,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>  
>  		err = -EINVAL;
> -		if (len < vnet_hdr_len)
> +		if (iov_iter_count(from) < vnet_hdr_len)
>  			goto err;
> -		len -= vnet_hdr_len;
>  
>  		err = -EFAULT;
>  		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
> @@ -671,10 +670,12 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  				 tap16_to_cpu(q, vnet_hdr.csum_start) +
>  				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
>  		err = -EINVAL;
> -		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
> +		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
>  			goto err;
>  	}
>  
> +	len = iov_iter_count(from);
> +

Since len is still used in the rest of the function, might as well use
it from the start. I'd drop this patch.

