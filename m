Return-Path: <linux-kselftest+bounces-45936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FFC6C390
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7CB94E2258
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FF22B5A3;
	Wed, 19 Nov 2025 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0Giw+JM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D818E1F
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 01:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515061; cv=none; b=l6DVumQZ7el9DaOINoJ3ZEzV4vfJlB/Q1PKiGx0kediucXUWuDuBkSolYok/dQcW3CgMQeyAi8Dur5ayXdBKleMM/DgtW9JINXDoimmg2YVAfhK/LmVjs3QDvOFWvjz9/pIxYCuvU5lBP+IAZ1lmuaCOTHlqWhSU3wlhUbBKE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515061; c=relaxed/simple;
	bh=rT7Doq+l7z7hbFLJv3oOESobuNgHarGO6IKGTw8AtDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEU3HQJVTIEVV8HGaKFUcSHGpRYuomdCgHcFxJ6bXPh3xxKEBVsMdQdKgGrRocLllAfUpcvKuDOjAPfyVCcqqY489hVrd6dCz/+nwAdaeutDquiMIE9Kd8ObZH8v5/CTnh1zn5ykKss9xW9EPKaut6z49gBYltDlXouHCfEMkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0Giw+JM; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-786572c14e3so63201247b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 17:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763515058; x=1764119858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sqe8ncDEknCOi4UhxwOn5EBWZJsrkPpNEM6tqbGLh4=;
        b=K0Giw+JM9QeeH5Z2m9F2bFtocDz/lC2+BjkNUf8VQxjPcn/VeVzKCCaf54jfdAabgc
         1nUF+OsFDHkKUJHG+q8VTQ/j1zhvsJtaWXUCH3pkj/KwOW1qo8bfPikvxt6g5cacG60Y
         YyuM6RsmftBZypBKj9JnI0+1ABHiLLvOTdSNJVuHPilyZqDKz7ZURUTsJ63iRfSR6FM7
         QhUpB7g6k98OlPiiY3hORzd3XDmZk/K9XU5ltyNAPGBm6JQrQuPd0RYRwQUpXaDagZin
         5piIoqZ51v1AGtPQJXGTa0ZkA8T7nMhbYEjOUtTdno8lUz3q1ipTT329WWiN+jfgoBYk
         /5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763515058; x=1764119858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sqe8ncDEknCOi4UhxwOn5EBWZJsrkPpNEM6tqbGLh4=;
        b=SnlfZtdUEbAAnUA2G14hzUrcQ0cITy9LUToxa5MA7ikSrQy6BMv8J2IQFfZuFlbp4N
         q8PZwG1FBpgP5yVRpjqNuV1XcVT5oakRJHcNcpVkbgmrgKZ4Iqi7dODWHZ2hwixP52Ub
         Dy/WlW+A5A9GaW3bmYpfr6yCJVY3OZwHybkKwi3uGBmF3tEcPSsxKlNoljXCHKoYK0X3
         ppGVKloiaM8re3Z6OliSysIICluYHNtVzXLhU+8ljTtgFMTZVebsiB3xzs4pzXWrZEx5
         OtUuEO6PNVhCQGt/RQb/f7ZLEzmv3H4iHltjnUV7rCZFBs5dq5gmrPAaWI9TLEsUFssz
         heNw==
X-Forwarded-Encrypted: i=1; AJvYcCUzJih8ZcS04L4kOLF8cw5JhCyPNdfJobRwJvOTdEIH0r09oej9ZTA/f5arS08dlWPQLe2/oDadnFnLFLpscVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwFoUxHD4fjb3wRUP1dI81NEgtO5oWhQtAkxABdI+S9fmi1aZA
	Ju2gyQ4CkksrcgO7s3spfHyGcngy52j3b2doV71NMjgbryASIGE5sdNT
X-Gm-Gg: ASbGncscsjGXXYLAb6p32Eqm72aYFHGt0pG2DKwkBXoIHuAH1hom6dxS/9eQnhliWWB
	HqaBB+OixfmRhUEI5aK07Ro7Q5eLA9aEAVzx6hb9WwZtv6kEm0qDauokAzc5quey1GhvHc3QAkt
	VwbzM4NWexbKvlvvGRklgsB32yZG5UH9isWuwdd/63fAFPrvb/Op/ZmVw6nJGGehax2mbworVPS
	ILscY6050+LuNIerOU719WxyrF078kzZXBB5+gSmDDrdhQu8PFrsdywXsUaLD3Ufc8dnJYR6YHf
	LyffD4eNUQha/v/GdniCy88WIY4qGfKPBBktUzGMeQv2Prdf/wahuIHTIQ2Nuvlddfa59r5ymsX
	FTk/IOEJg/uQ1d3UA1xoKnLjtLMlQOJP8/0s2IfvYCj+eF8XS725voddzk0Lgjl1WWPMdGYKKNC
	n1Wj8WeUx6yZyJLfA1HUQsOswl5GEY2sgQqRymGM+TsKT5wwXvk78Gf/irGQ==
X-Google-Smtp-Source: AGHT+IE+l2e227udRixUaMV1OD0fbSyMRTRhSYspYsqsrhrAm7qQBfwUi7+G0snVl8c4IqgyshR/vA==
X-Received: by 2002:a05:690e:240c:b0:63f:ba88:e8f9 with SMTP id 956f58d0204a3-641e75e62f4mr11153561d50.41.1763515058001;
        Tue, 18 Nov 2025 17:17:38 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410e9e8f76sm6410956d50.4.2025.11.18.17.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 17:17:37 -0800 (PST)
Date: Tue, 18 Nov 2025 17:17:35 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 03/11] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <aR0arw2F/DmbIrzY@devvm11784.nha0.facebook.com>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-3-df08f165bf3e@meta.com>
 <vsyzveqyufaquwx3xgahsh3stb6i5u3xa4kubpvesfzcuj6dry@sn4kx5ctgpbz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vsyzveqyufaquwx3xgahsh3stb6i5u3xa4kubpvesfzcuj6dry@sn4kx5ctgpbz>

On Tue, Nov 18, 2025 at 07:10:28PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 17, 2025 at 06:00:26PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 2c937a2df83b..c8319cd1c232 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -64,6 +64,11 @@ static u32 vhost_transport_get_local_cid(void)
> > 	return VHOST_VSOCK_DEFAULT_HOST_CID;
> > }
> > 
> > +static bool vhost_transport_supports_local_mode(void)
> > +{
> > +	return true;
> 
> Should we enable this later, when we really add support, or it doesn't
> affect anything if vhost-vsock is not really supporting it in this PR
> (thinking about bisection issues).

sgtm!

> 
> > +}
> > +
> > /* Callers that dereference the return value must hold vhost_vsock_mutex or the
> >  * RCU read lock.
> >  */
> > @@ -412,6 +417,7 @@ static struct virtio_transport vhost_transport = {
> > 		.module                   = THIS_MODULE,
> > 
> > 		.get_local_cid            = vhost_transport_get_local_cid,
> > +		.supports_local_mode	  = vhost_transport_supports_local_mode,
> > 
> > 		.init                     = virtio_transport_do_socket_init,
> > 		.destruct                 = virtio_transport_destruct,
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index 59d97a143204..824d89657d41 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -180,6 +180,11 @@ struct vsock_transport {
> > 	/* Addressing. */
> > 	u32 (*get_local_cid)(void);
> > 
> > +	/* Return true if this transport supports VSOCK_NET_MODE_LOCAL.
> 
> nit: Here I would make it clearer that rather than supporting MODE_LOCAL,
> the transport is not compatible with it, etc.
> A summary of the excellent description we have in the commit.
> 

sounds good!

> > +	 * Otherwise, return false.
> > +	 */
> > +	bool (*supports_local_mode)(void);
> > +
> > 	/* Read a single skb */
> > 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
> > 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 54373ae101c3..7a235bb94437 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -91,6 +91,12 @@
> >  *   and locked down by a namespace manager. The default is "global". The mode
> >  *   is set per-namespace.
> >  *
> > + *   Note: LOCAL mode is only supported when using namespace-aware transports
> > + *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
> > + *   hyperv-vsock, vmci-vsock) is loaded, attempts to set LOCAL mode will fail
> > + *   with EOPNOTSUPP, as these transports do not support per-namespace
> > + *   isolation.
> 
> Okay, maybe this is fine, so if you don't need to resend, feel free to
> ignore the previous comment.
> 
> > + *
> >  *   The modes affect the allocation and accessibility of CIDs as follows:
> >  *
> >  *   - global - access and allocation are all system-wide
> > @@ -2765,17 +2771,30 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> > 	if (*lenp >= sizeof(data))
> > 		return -EINVAL;
> > 
> > -	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
> > +	ret = 0;
> 
> IIUC `ret` should already be 0 at this point, no?
> 
> > +	mutex_lock(&vsock_register_mutex);
> 
> I honestly don't like to mix the parsing, with this new check, so what
> about leaving the parsing as before this patch (also without the mutex),
> then just (untested):
> 
> 	mutex_lock(&vsock_register_mutex);
> 	if (mode == VSOCK_NET_MODE_LOCAL && transport_g2h &&
> 	    transport_g2h->supports_local_mode &&
> 	    !transport_g2h->supports_local_mode()) {
> 		ret = -EOPNOTSUPP;
> 		goto out;
> 	}
> 
> 	if (!vsock_net_write_mode(net, mode)) {
> 		ret = -EPERM;
> 	}
> out:
> 	mutex_unlock(&vsock_register_mutex);
> 	return ret;
> }

Makes sense, I can move that around for next rev.

> 
> > +	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data))) {
> > 		mode = VSOCK_NET_MODE_GLOBAL;
> > -	else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
> > +	} else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data))) {
> > +		if (transport_g2h && transport_g2h->supports_local_mode &&
> > +		    !transport_g2h->supports_local_mode()) {
> > +			ret = -EOPNOTSUPP;
> > +			goto out;
> > +		}
> > 		mode = VSOCK_NET_MODE_LOCAL;
> > -	else
> > -		return -EINVAL;
> > +	} else {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > 
> > -	if (!vsock_net_write_mode(net, mode))
> > -		return -EPERM;
> > +	if (!vsock_net_write_mode(net, mode)) {
> > +		ret = -EPERM;
> > +		goto out;
> > +	}
> > 
> > -	return 0;
> > +out:
> > +	mutex_unlock(&vsock_register_mutex);
> > +	return ret;
> > }
> > 
> > static struct ctl_table vsock_table[] = {
> > @@ -2916,6 +2935,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> > {
> > 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
> > 	int err = mutex_lock_interruptible(&vsock_register_mutex);
> > +	struct net *net;
> > 
> > 	if (err)
> > 		return err;
> > @@ -2938,6 +2958,22 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> > 			err = -EBUSY;
> > 			goto err_busy;
> > 		}
> > +
> > +		/* G2H sockets break in LOCAL mode namespaces because G2H
> > +		 * transports don't support them yet. Block registering new G2H
> > +		 * transports if we already have local mode namespaces on the
> > +		 * system.
> > +		 */
> > +		rcu_read_lock();
> > +		for_each_net_rcu(net) {
> > +			if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL) {
> > +				rcu_read_unlock();
> > +				err = -EOPNOTSUPP;
> > +				goto err_busy;
> > +			}
> > +		}
> > +		rcu_read_unlock();
> > +
> > 		t_g2h = t;
> > 	}
> > 
> > diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> > index 432fcbbd14d4..279f04fcd81a 100644
> > --- a/net/vmw_vsock/hyperv_transport.c
> > +++ b/net/vmw_vsock/hyperv_transport.c
> > @@ -833,10 +833,16 @@ int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
> > 	return -EOPNOTSUPP;
> > }
> > 
> > +static bool hvs_supports_local_mode(void)
> > +{
> > +	return false;
> > +}
> > +
> > static struct vsock_transport hvs_transport = {
> > 	.module                   = THIS_MODULE,
> > 
> > 	.get_local_cid            = hvs_get_local_cid,
> > +	.supports_local_mode      = hvs_supports_local_mode,
> > 
> > 	.init                     = hvs_sock_init,
> > 	.destruct                 = hvs_destruct,
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 5d379ccf3770..e585cb66c6f5 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -94,6 +94,18 @@ static u32 virtio_transport_get_local_cid(void)
> > 	return ret;
> > }
> > 
> > +static bool virtio_transport_supports_local_mode(void)
> > +{
> > +	struct virtio_vsock *vsock;
> > +
> > +	rcu_read_lock();
> > +	vsock = rcu_dereference(the_virtio_vsock);
> > +	rcu_read_unlock();
> > +
> > +	/* Local mode is supported only when no G2H device is present. */
> > +	return vsock ? false : true;
> > +}
> > +
> > /* Caller need to hold vsock->tx_lock on vq */
> > static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
> > 				     struct virtio_vsock *vsock, gfp_t gfp)
> > @@ -544,6 +556,7 @@ static struct virtio_transport virtio_transport = {
> > 		.module                   = THIS_MODULE,
> > 
> > 		.get_local_cid            = virtio_transport_get_local_cid,
> > +		.supports_local_mode      = virtio_transport_supports_local_mode,
> > 
> > 		.init                     = virtio_transport_do_socket_init,
> > 		.destruct                 = virtio_transport_destruct,
> > diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> > index 7eccd6708d66..da7c52ad7b2a 100644
> > --- a/net/vmw_vsock/vmci_transport.c
> > +++ b/net/vmw_vsock/vmci_transport.c
> > @@ -2033,6 +2033,12 @@ static u32 vmci_transport_get_local_cid(void)
> > 	return vmci_get_context_id();
> > }
> > 
> > +static bool vmci_transport_supports_local_mode(void)
> > +{
> > +	/* Local mode is supported only when no device is present. */
> > +	return vmci_transport_get_local_cid() == VMCI_INVALID_ID;
> 
> IIRC vmci can be registered both as H2G and G2H, so should we filter out
> the H2G case?

In fact, I'm realizing now that this should probably just be:

static bool vmci_transport_supports_local_mode(void)
{
	return false;
}


... because even for H2G there is no mechanism for attaching a namespace
to a VM (unlike w/ vhost_vsock device open).

Does that seem right?

Best,
Bobby

