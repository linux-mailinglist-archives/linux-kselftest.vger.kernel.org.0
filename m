Return-Path: <linux-kselftest+bounces-19440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3B8998789
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88AA1F21651
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033BB1C9B9B;
	Thu, 10 Oct 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjdj2m/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6901C3316;
	Thu, 10 Oct 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566635; cv=none; b=hjqzyaJD4Wn37hUKIv88cDS9MZjhH01vD/FXCdE/MTnz0ZCLHcM7ZO8olQyo1QT7iV6UwHJw+1JUpSJMI6EBg8Qk2qypjfsz532lPUZ7CT/LjMvhZPSA0zJ7m1BEiZQ6FmMdnh40Oo+bv6nzr2ZViaFa8DOPwdUKbLjFKh9ZMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566635; c=relaxed/simple;
	bh=snSjJQ5ptmbiAaOVtkqH6aJWIVL4ZEkAaiP9TOSjaeE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=m9V9UDcQUpCrpvwJ2/vXu4wJ5Nvy0+VFCtbvt9yeUzb95/8AyJI2rFyBHf+NKsNN+08+0bCay+kGLKfqhgAkUcy4EGFarHvE3pC3bXdIYMYYK3M4v9wqR61zGyJwvjjWYp40PdsjUGRpIoir6FSggAXy++wEl5KcVQgVCxKcFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjdj2m/X; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460464090d5so3718031cf.2;
        Thu, 10 Oct 2024 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728566633; x=1729171433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xgas4UKq96jNnf/fhVFzyn4kBLRom+VwWUFcbKspLV4=;
        b=bjdj2m/X11QWzvTMdY5lEzctN7zu+Hor9PnilOjcJXvdKkf5sjvINmlgmFi0z6J5oV
         9KsT4FHD7r77OR42rxIBGTdX8OqWvSzV5E+yfvQW+BhotcvO7UTXKd1/OcNvqMu3dYVx
         CyCzAir/+izfvZsqGUKHnSfInTlKjTLYLHPZzIv2AKZKKTiwaKwwjnHGfkSo9SxpUwas
         9FlVcm/d1+n6X94Pj1xq2Sldzi8OYA5+sJcpz5HRbysym+7f7P+P0aZqbTF7GcE/K8nZ
         mgntl4XB78wmuFdJgXoErkdXJ7fK70F5C/qjdejRTiOleHdne2Qeifx6Icbps32X0Lht
         sQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566633; x=1729171433;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xgas4UKq96jNnf/fhVFzyn4kBLRom+VwWUFcbKspLV4=;
        b=sYKZM6kMWHE90Ux3Uqe8txjMLv7pzmL3OZPUfILa/2RUNlXfOl8QS7Zz61XJOq8CUH
         MZNd5MwRiZpsHxQrovNSAWbNUKv5PEsvS8edDYdnwnjscdyVZ0fbfqAida95VptADUOR
         2gh6TBiDRWS+Tp0vqLcJEeBL3ZDCoOotM60Z/xgPGZtUzT8ji01hSxcJp2qKOa3PLpsf
         rb3QkUik9XYyFaOYJf+Ca5wIr/vtG+E8qYXQuHMBWqdrrj4PoKOqmQrKeNe8S/tB8hm/
         e/2vFIqDNGFIhG7+KsWII9gtY8cC/enWTl/b5xUjWgyxa4dGzRhMfU63hcrz88iBp3pw
         AWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCURLsx8QAsutgyCw4btILzbI5Rs7W8UMtdEYwlewgzntyZ3SQAfKEn76TyuoxHXmzOA+YZfYz8XwM1ACjo=@vger.kernel.org, AJvYcCWzmnmmL5qHSuPt92dJR0rCKk30xP021C8rK0M35pYiMn9PYjPg5MpWwpnGRhKOUmQfr2efiSPy32BuZK+a0baZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIgjOub2mGk3i+bYkocsJIQdNVUHy6qS6yWrircf3O22eL9fk
	QHcn3hT4wlerEuNJgB5rxXACByUJkZ5iQcSW8EExcOrzYyD77AhK
X-Google-Smtp-Source: AGHT+IFFyJBTpArUnvpJ1SxmGPt1lWLwPAaklksTtG4EfUqWjhfRq8eGD8gx54vZlmPSPAKGZaelCg==
X-Received: by 2002:a05:622a:2985:b0:460:3b66:c599 with SMTP id d75a77b69052e-4603b66c6ccmr68276391cf.17.1728566633015;
        Thu, 10 Oct 2024 06:23:53 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4604287df23sm5271701cf.67.2024.10.10.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:23:52 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:23:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <6707d56835f42_2029212942b@willemb.c.googlers.com.notmuch>
In-Reply-To: <9e15c0c2cd19d94207a1791de0dc9051a5abb95a.1728555449.git.gur.stavi@huawei.com>
References: <cover.1728555449.git.gur.stavi@huawei.com>
 <9e15c0c2cd19d94207a1791de0dc9051a5abb95a.1728555449.git.gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v03 1/3] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> PACKET socket can retain its fanout membership through link down and up
> and leave a fanout while closed regardless of link state.
> However, socket was forbidden from joining a fanout while it was not
> RUNNING.
> 
> This patch allows PACKET socket to join fanout while not RUNNING.
> 
> The previous test for RUNNING also implicitly tested that the socket is
> bound to a device. An explicit test of ifindex was added instead.
> 
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
> ---
>  net/packet/af_packet.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index f8942062f776..8137c33ab0fd 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1843,26 +1843,29 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  		match->prot_hook.ignore_outgoing = type_flags & PACKET_FANOUT_FLAG_IGNORE_OUTGOING;
>  		list_add(&match->list, &fanout_list);
>  	}
> -	err = -EINVAL;
>  
>  	spin_lock(&po->bind_lock);
> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> -	    match->type == type &&
> -	    match->prot_hook.type == po->prot_hook.type &&
> -	    match->prot_hook.dev == po->prot_hook.dev) {
> +	if (po->ifindex == -1 || po->num == 0) {

This patch is more complex than it needs to be.

No need to block the case of ETH_P_NONE or not bound to a socket.

I would have discussed that in v2, but you already respun.

> +		/* Socket can not receive packets */
> +		err = -ENXIO;
> +	} else if (match->type != type ||
> +		   match->prot_hook.type != po->prot_hook.type ||
> +		   match->prot_hook.dev != po->prot_hook.dev) {
> +		/* Joining an existing group, properties must be identical */
> +		err = -EINVAL;
> +	} else if (refcount_read(&match->sk_ref) >= match->max_num_members) {
>  		err = -ENOSPC;
> -		if (refcount_read(&match->sk_ref) < match->max_num_members) {
> +	} else {
> +		/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
> +		WRITE_ONCE(po->fanout, match);
> +		po->rollover = rollover;
> +		rollover = NULL;
> +		refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
> +		if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
>  			__dev_remove_pack(&po->prot_hook);
> -
> -			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
> -			WRITE_ONCE(po->fanout, match);
> -
> -			po->rollover = rollover;
> -			rollover = NULL;
> -			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
>  			__fanout_link(sk, po);
> -			err = 0;
>  		}
> +		err = 0;
>  	}
>  	spin_unlock(&po->bind_lock);
>  
> @@ -3452,8 +3455,12 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
>  	po->prot_hook.af_packet_net = sock_net(sk);
>  
>  	if (proto) {
> +		/* Implicitly bind socket to "any interface" */
> +		po->ifindex = 0;
>  		po->prot_hook.type = proto;
>  		__register_prot_hook(sk);
> +	} else {
> +		po->ifindex = -1;
>  	}
>  
>  	mutex_lock(&net->packet.sklist_lock);
> -- 
> 2.45.2
> 



