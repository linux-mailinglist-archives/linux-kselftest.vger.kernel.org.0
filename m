Return-Path: <linux-kselftest+bounces-21747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A99C342C
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 19:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83286281122
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 18:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58783139579;
	Sun, 10 Nov 2024 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqiDuSnA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301817C91;
	Sun, 10 Nov 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731263187; cv=none; b=dxsNLb7PLPmxzs/nW+zW2xlwkr9mzHGHK/dhho9jATao8wYWdPUjQZCpZIwGx8gYu4116ZOOZlbg4dofTmGl7KeYiBnBlMweBMYx9+y5BM2aB0aOSl/wPme72I8PQyi24KHqYBKDvDCCyyUWqAWcJ5x2chNlsXTXFKZ4PFZPL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731263187; c=relaxed/simple;
	bh=p+kZUNpOarFYEh5yR1wrgus0MuK0s0NFERVlmBdAwpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmwAvOunXd86R4Lc6xaeOEZFI3MSoEjN2gW+WaAwQ83+SksRRne0Mo7p8TqjTOjPpcqq0wUF3kfh3M3yBj/uqZCWFoOJafUcQgxDXSlwjbISx2+ms0rDGRqc3TFZJPncvNL28Who7AD3osQyaSD3DzmX9y28F4H68FED8v449/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqiDuSnA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315baec69eso33051385e9.2;
        Sun, 10 Nov 2024 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731263183; x=1731867983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emajkWUcoE3Ns+xrK1PnL3V8KRgd8CuiN/X8WerMwf8=;
        b=iqiDuSnAesOCRG0lWX2qSfTIdeB+1w/fWfjmiZ/dfmT37pVdM2S/CO+L+7butaS1aY
         PIUQkbAGBzZR54RVWoWVzjUcyoiEYwkTcLJjh0PtH6ZrsItu8jxNOqJobXRXkdnjbP7v
         JVjBSqraeuZUz/jBUjD5hk8f6I7Fzqd7AfOBp3A+2Vruc1rpXPeJ+8JmN6mBCJj27/sj
         LDMa+x13EE3rIEAR2DkyCGiWhtfwS12fvs1w9z1ObV65o4MW5XqCCrXymqTzMPT1N80t
         581RZxIAt4EyXey+h1q2YDY+PFWoeVITxH73S1XEO75dsjW4zqIeNbDESSM+vY1JnIVw
         L4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731263183; x=1731867983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emajkWUcoE3Ns+xrK1PnL3V8KRgd8CuiN/X8WerMwf8=;
        b=e9uCb4CwsiOezOjieffWWsGlmzwVbaB0NQZXvIeaATCE9ghDPjQ6GnuPUfGazZ7yfr
         vfWHi8lOCvSFzFVXOLWNZlGKbkYpOCblXRRyOe2dY+T7hhltBF5ZyyGX8xdyrcc4PrSH
         xmVzOyGSEQt8vAtcUr3+Bt+xbNn4Fi6zHBqc6R/pxMQbqLtexLJmPAOypUrtyzlZTiAJ
         nmKUEVbo3zgxvsNv7V/750b/yGHBZiWWwne4I1qNzujeDu9C/xjkVcYWaHR2dDvj01fD
         +cy7DghYkgbt7Z2UB7Nv41Bnce7EILBRSl1ch97ghPKCiTpLvLwjT9AyJtACjGjzGyko
         AXDg==
X-Forwarded-Encrypted: i=1; AJvYcCUE2N1g3vMtegLlKYx3BJcQVZP5cCaduWNZgenk7xtJSDk9tMjr4FlpU4mGv8KzgiV1AUszCzmR@vger.kernel.org, AJvYcCVHP7u5XQLLOy5DerzU4scmAf6sK88EHo5HtV6rgbuVoEGjxlzhn8+hBcTNEvmVGgwi3KZ91ANviCwnzzk=@vger.kernel.org, AJvYcCXt/1GvpqzlTDAqaibK9At42t50mXp5bmUqUxP+XNZc2BR5VwXMQs4foCUMpVLbTrnQlnUVDWbaMZRv2WCPYYzQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyBRReflinD9ni2CJMMKAq1epZycvlGo2mkNtUX5tOFVAC7rNGx
	6Mosoe2Ems65WFLvKNzUwbXo6LCBEgwX2plYsKVJI/bG45PWajkK
X-Google-Smtp-Source: AGHT+IFaWi4p4hvt6FaTwEeCdQhXnxD0sVm7e3abgqNzS9vWA+/X3QRJPWDqqYIqiUH2nxBH/RCaoQ==
X-Received: by 2002:a05:600c:3ca8:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-432b7509717mr71365405e9.15.1731263183199;
        Sun, 10 Nov 2024 10:26:23 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ceasm10767990f8f.102.2024.11.10.10.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 10:26:22 -0800 (PST)
Message-ID: <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com>
Date: Sun, 10 Nov 2024 20:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> This specific structure is used in the ovpn kernel module
> to wrap and carry around a standard kernel socket.
> 
> ovpn takes ownership of passed sockets and therefore an ovpn
> specific objects is attached to them for status tracking
> purposes.
> 
> Initially only UDP support is introduced. TCP will come in a later
> patch.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

[...]

> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..090a3232ab0ec19702110f1a90f45c7f10889f6f
> --- /dev/null
> +++ b/drivers/net/ovpn/socket.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/net.h>
> +#include <linux/netdevice.h>
> +
> +#include "ovpnstruct.h"
> +#include "main.h"
> +#include "io.h"
> +#include "peer.h"
> +#include "socket.h"
> +#include "udp.h"
> +
> +static void ovpn_socket_detach(struct socket *sock)
> +{
> +	if (!sock)
> +		return;
> +
> +	sockfd_put(sock);
> +}
> +
> +/**
> + * ovpn_socket_release_kref - kref_put callback
> + * @kref: the kref object
> + */
> +void ovpn_socket_release_kref(struct kref *kref)
> +{
> +	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
> +						refcount);
> +
> +	ovpn_socket_detach(sock->sock);
> +	kfree_rcu(sock, rcu);
> +}
> +
> +static bool ovpn_socket_hold(struct ovpn_socket *sock)
> +{
> +	return kref_get_unless_zero(&sock->refcount);

Why do we need to wrap this kref acquiring call into the function. Why 
we cannot simply call kref_get_unless_zero() from ovpn_socket_get()?

> +}
> +
> +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +
> +	rcu_read_lock();
> +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
> +	if (!ovpn_socket_hold(ovpn_sock)) {
> +		pr_warn("%s: found ovpn_socket with ref = 0\n", __func__);

Should we be more specific here and print warning with 
netdev_warn(ovpn_sock->ovpn->dev, ...)?

And, BTW, how we can pick-up a half-destroyed socket?

> +		ovpn_sock = NULL;
> +	}
> +	rcu_read_unlock();
> +
> +	return ovpn_sock;
> +}
> +
> +static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	int ret = -EOPNOTSUPP;
> +
> +	if (!sock || !peer)
> +		return -EINVAL;
> +
> +	if (sock->sk->sk_protocol == IPPROTO_UDP)
> +		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
> +
> +	return ret;
> +}
> +
> +/**
> + * ovpn_socket_new - create a new socket and initialize it
> + * @sock: the kernel socket to embed
> + * @peer: the peer reachable via this socket
> + *
> + * Return: an openvpn socket on success or a negative error code otherwise
> + */
> +struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
> +{
> +	struct ovpn_socket *ovpn_sock;
> +	int ret;
> +
> +	ret = ovpn_socket_attach(sock, peer);
> +	if (ret < 0 && ret != -EALREADY)
> +		return ERR_PTR(ret);
> +
> +	/* if this socket is already owned by this interface, just increase the
> +	 * refcounter and use it as expected.
> +	 *
> +	 * Since UDP sockets can be used to talk to multiple remote endpoints,
> +	 * openvpn normally instantiates only one socket and shares it among all
> +	 * its peers. For this reason, when we find out that a socket is already
> +	 * used for some other peer in *this* instance, we can happily increase
> +	 * its refcounter and use it normally.
> +	 */
> +	if (ret == -EALREADY) {
> +		/* caller is expected to increase the sock refcounter before
> +		 * passing it to this function. For this reason we drop it if
> +		 * not needed, like when this socket is already owned.
> +		 */
> +		ovpn_sock = ovpn_socket_get(sock);
> +		sockfd_put(sock);
> +		return ovpn_sock;
> +	}
> +
> +	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
> +	if (!ovpn_sock)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ovpn_sock->ovpn = peer->ovpn;
> +	ovpn_sock->sock = sock;
> +	kref_init(&ovpn_sock->refcount);
> +
> +	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
> +
> +	return ovpn_sock;
> +}
> diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..5ad9c5073b085482da95ee8ebf40acf20bf2e4b3
> --- /dev/null
> +++ b/drivers/net/ovpn/socket.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
> + *
> + *  Author:	James Yonan <james@openvpn.net>
> + *		Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#ifndef _NET_OVPN_SOCK_H_
> +#define _NET_OVPN_SOCK_H_
> +
> +#include <linux/net.h>
> +#include <linux/kref.h>
> +#include <net/sock.h>
> +
> +struct ovpn_struct;
> +struct ovpn_peer;
> +
> +/**
> + * struct ovpn_socket - a kernel socket referenced in the ovpn code
> + * @ovpn: ovpn instance owning this socket (UDP only)
> + * @sock: the low level sock object
> + * @refcount: amount of contexts currently referencing this object
> + * @rcu: member used to schedule RCU destructor callback
> + */
> +struct ovpn_socket {
> +	struct ovpn_struct *ovpn;
> +	struct socket *sock;
> +	struct kref refcount;
> +	struct rcu_head rcu;
> +};
> +
> +void ovpn_socket_release_kref(struct kref *kref);
> +
> +/**
> + * ovpn_socket_put - decrease reference counter
> + * @sock: the socket whose reference counter should be decreased
> + */
> +static inline void ovpn_socket_put(struct ovpn_socket *sock)
> +{
> +	kref_put(&sock->refcount, ovpn_socket_release_kref);
> +}
> +
> +struct ovpn_socket *ovpn_socket_new(struct socket *sock,
> +				    struct ovpn_peer *peer);
> +
> +#endif /* _NET_OVPN_SOCK_H_ */
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c10474d252e19a0626d17a6f5dd328a5e5811551
> --- /dev/null
> +++ b/drivers/net/ovpn/udp.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  OpenVPN data channel offload
> + *
> + *  Copyright (C) 2019-2024 OpenVPN, Inc.
> + *
> + *  Author:	Antonio Quartulli <antonio@openvpn.net>
> + */
> +
> +#include <linux/netdevice.h>
> +#include <linux/socket.h>
> +#include <net/udp.h>
> +
> +#include "ovpnstruct.h"
> +#include "main.h"
> +#include "socket.h"
> +#include "udp.h"
> +
> +/**
> + * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
> + * @sock: socket to configure
> + * @ovpn: the openvp instance to link
> + *
> + * After invoking this function, the sock will be controlled by ovpn so that
> + * any incoming packet may be processed by ovpn first.
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
> +{
> +	struct ovpn_socket *old_data;
> +	int ret = 0;
> +
> +	/* sanity check */
> +	if (sock->sk->sk_protocol != IPPROTO_UDP) {

The function will be called only for a UDP socket. The caller makes sure 
this is truth. So, why do we need this check?

> +		DEBUG_NET_WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure no pre-existing encapsulation handler exists */
> +	rcu_read_lock();
> +	old_data = rcu_dereference_sk_user_data(sock->sk);
> +	if (!old_data) {
> +		/* socket is currently unused - we can take it */
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	/* socket is in use. We need to understand if it's owned by this ovpn
> +	 * instance or by something else.
> +	 * In the former case, we can increase the refcounter and happily
> +	 * use it, because the same UDP socket is expected to be shared among
> +	 * different peers.
> +	 *
> +	 * Unlikely TCP, a single UDP socket can be used to talk to many remote
> +	 * hosts and therefore openvpn instantiates one only for all its peers
> +	 */
> +	if ((READ_ONCE(udp_sk(sock->sk)->encap_type) == UDP_ENCAP_OVPNINUDP) &&
> +	    old_data->ovpn == ovpn) {
> +		netdev_dbg(ovpn->dev,
> +			   "%s: provided socket already owned by this interface\n",
> +			   __func__);

Why do we need the function name being printed here?

> +		ret = -EALREADY;
> +	} else {
> +		netdev_err(ovpn->dev,
> +			   "%s: provided socket already taken by other user\n",
> +			   __func__);

The same comment regarding the function name printing.

And why 'error' level? There is a few ways to fall into this case and 
each of them implies a user-space screw up. But why we consider these 
user-space screw ups our (kernel) problem? I suggesting to reduce level 
at least to 'warning' or maybe even 'notice'. See level definitions in 
include/linux/kern_levels.h

> +		ret = -EBUSY;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}

--
Sergey

