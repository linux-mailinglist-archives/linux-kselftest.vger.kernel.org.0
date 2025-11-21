Return-Path: <linux-kselftest+bounces-46285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D1C7B6D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 20:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6812B3A61DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34D2F9998;
	Fri, 21 Nov 2025 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DInEEPNr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD32F1FEA
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751719; cv=none; b=sDc3U187IHYBQxWVoeSr/sh98fRxmovc0ncuatjYh+gPP0LWgtG/u4uHCzQzOxfs7TJ97VwMECatwxX6SA5uH5COvYtI58Vuq7W0E+rF4QhnOO9hC7wraW1XVNXp3gHvP+iv3h4Ae83zfse0hFeDcZRiQd9GOej0r5azizNnqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751719; c=relaxed/simple;
	bh=WArVS6ubEMJkQPVCvjCEWR46mrN5QDyyEmvTxtytRNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgfAvVGmBVVn0KbocDJdgQ2ysxmfSPwTmCrU86y452L0wSupJvaGeJ507bCjMnFrQMAyBEqv16JPt1YgagjVzBSAZVwnlOCGHaE3bxghu3OGRYskuk3vQzENreEOKmPdo4zXROWcRKj+50NosOy8/BLX9dIgTrdrA/Woyj+2go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DInEEPNr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787d5555274so24965127b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 11:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763751715; x=1764356515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHNJK9mSt+s0CGUW2/E9GDvGTfl2Ktm309WYTb92GJQ=;
        b=DInEEPNrT5OjHsHKx1gQLyfHe07BkXyzJmiV0okgCYoqbzRBV1UU3biywaP91Cj3v7
         2KI5jmbZQre+/BxTrmRDfDAiFXGjxyUJ5xILxCpc6MZF+qcu1SKwbdJIjhNqjwGxkCyF
         JwhtQeWOeIf5sqVNUHJE2qNYTuk+/prRzC0w9KGK/4UBYrXOwEruzaa/lIvEqP1GXXu8
         Jy02ibpAfqjpxlSM/ntOE5CCMVxA/FlVYZJziWfGjg/nBkZHI4ejoMgoi7aQFdGzpgyS
         JQkCVfQE7cRg+D8JWzHkh2CpLrvwneRQ8Zz4eBZCUHphmazztuFo5gkYo1Th1eGQeMMY
         kB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751715; x=1764356515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHNJK9mSt+s0CGUW2/E9GDvGTfl2Ktm309WYTb92GJQ=;
        b=UrNDFQ9j25AIa1r8BNoUmIyOa/IJKhoWC3jbLlpvoyVjRvn4T9C6WPorqxHB0PPk3O
         86PKAgiinS0D+i/e8W2025/y+JNcNL9Bdr++apE0KDqmNfsi2ibnB0ZF4Q4P+AdHZaXK
         nbeiSNdO+m0BXop5viz5G7sfFc1hSnQdhmVllXHpF5tNA84PGQjrlWioBiq/n6dTBOw8
         QIAabEQ283rw2cr6tmU0WYFtAfBj7Oa9ftCa6hp/6bSsigMDVmNTj/Uu3zjTC4L4+7I/
         nT1MrIo8l6rz63MsbWtOklQrK7/ybOM+gcfPXPEk5+xhum2Vs9Vd4qA4MgtuCGKss4o3
         AJRg==
X-Forwarded-Encrypted: i=1; AJvYcCU4a0YsA7qfOxlBdOlglTMCO6SDBP8i4k0k5WKIzSHR+Azxw2QzQVSdSD6H98U6+X14jyvKMbpEdS/S7ic6OTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWOcyWeHm/o+H7ERDUc420gMVvr8qFSofR9cRy0mOrHAiQq5F
	GGnKX5uVA8M/0azwO7GgM7LnYphFwH4DyVpX12XF3jwIForTnJ3GlrYe
X-Gm-Gg: ASbGncthMkd4IOenWiJnAnl7s6liNODBvHA+29VU39k6/1D4Zws0JbMfIv5BjaT3h/P
	FFH0HQT415HheAFqbPNRAszs5WTiFVTlpOe8bEnWITVWNxCjJ7R2un8FwihyxAl+FEjIyAoSzTC
	iipndqSWMncR2TKG1EJ1iwpgQjTikRTmqwrynmLhBUMTTjzZZ5uJPdLj7hAYAvdm5SmA8Hyr+++
	sTHzICycsHG9go5pbgv7mUwHH0THS0Ya08NJMxfqd/sV+g17otsCkiwK5L6HaWQVMiGiUmatk1H
	LczcaXGY2kvoi1LI5PJytaYV04IoVkrU8qO+XYN5v/mE4jqrFRGKbsaGJfgJpbX3t1PjNUOubiC
	8muTdpz2qffnbLiWipVreIH3XO5sI7HYt/N1mMk+bJ88Qx2ydyhN9b3gL1GY95hLLBdA88Dvw77
	zFcxW7wpLLVgZewm+2V+BWZh5lhqvwxJe5dkt9ozr2XysEnaQ=
X-Google-Smtp-Source: AGHT+IH2bgXNRHCjXtFd+F/4K//ws1Kt32CYb3+hrGk5Xkpq6C71Ai7eb5mCRwKQxje9HmmiDX3mIg==
X-Received: by 2002:a05:690c:6ac7:b0:784:8994:297c with SMTP id 00721157ae682-78a8b499908mr27522337b3.24.1763751715362;
        Fri, 21 Nov 2025 11:01:55 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7992599bsm18071747b3.34.2025.11.21.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:01:54 -0800 (PST)
Date: Fri, 21 Nov 2025 11:01:53 -0800
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
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 03/13] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <aSC3IX81A3UhtD3N@devvm11784.nha0.facebook.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-3-55cbc80249a7@meta.com>
 <swa5xpovczqucynffqgfotyx34lziccwpqomnm5a7iwmeyixfv@uehtzbdj53b4>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swa5xpovczqucynffqgfotyx34lziccwpqomnm5a7iwmeyixfv@uehtzbdj53b4>

On Fri, Nov 21, 2025 at 03:24:25PM +0100, Stefano Garzarella wrote:
> On Thu, Nov 20, 2025 at 09:44:35PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Reject setting VSOCK_NET_MODE_LOCAL with -EOPNOTSUPP if a G2H transport
> > is operational. Additionally, reject G2H transport registration if there
> > already exists a namespace in local mode.
> > 
> > G2H sockets break in local mode because the G2H transports don't support
> > namespacing yet. The current approach is to coerce packets coming out of
> > G2H transports into VSOCK_NET_MODE_GLOBAL mode, but it is not possible
> > to coerce sockets in the same way because it cannot be deduced which
> > transport will be used by the socket. Specifically, when bound to
> > VMADDR_CID_ANY in a nested VM (both G2H and H2G available), it is not
> > until a packet is received and matched to the bound socket that we
> > assign the transport. This presents a chicken-and-egg problem, because
> > we need the namespace to lookup the socket and resolve the transport,
> > but we need the transport to know how to use the namespace during
> > lookup.
> > 
> > For that reason, this patch prevents VSOCK_NET_MODE_LOCAL from being
> > used on systems that support G2H, even nested systems that also have H2G
> > transports.
> > 
> > Local mode is blocked based on detecting the presence of G2H devices
> > (when possible, as hyperv is special). This means that a host kernel
> > with G2H support compiled in (or has the module loaded), will still
> > support local mode if there is no G2H (e.g., virtio-vsock) device
> > detected. This enables using the same kernel in the host and in the
> > guest, as we do in kselftest.
> > 
> > Systems with only namespace-aware transports (vhost-vsock, loopback) can
> > still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
> > intended.
> > 
> > Add supports_local_mode() transport callback to indicate
> > transport-specific local mode support.
> > 
> > These restrictions can be lifted in a future patch series when G2H
> > transports gain namespace support.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v11:
> > - vhost_transport_supports_local_mode() returns false to keep things
> >  disabled until support comes online (Stefano)
> > - add comment above supports_local_mode() cb to clarify (Stefano)
> > - Remove redundant `ret = 0` initialization in vsock_net_mode_string()
> >  (Stefano)
> > - Refactor vsock_net_mode_string() to separate parsing from validation
> >  (Stefano)
> > - vmci returns false for supports_local_mode(), with comment
> > 
> > Changes in v10:
> > - move this patch before any transports bring online namespacing (Stefano)
> > - move vsock_net_mode_string into critical section (Stefano)
> > - add ->supports_local_mode() callback to transports (Stefano)
> > ---
> > drivers/vhost/vsock.c            |  6 ++++++
> > include/net/af_vsock.h           | 11 +++++++++++
> > net/vmw_vsock/af_vsock.c         | 32 ++++++++++++++++++++++++++++++++
> > net/vmw_vsock/hyperv_transport.c |  6 ++++++
> > net/vmw_vsock/virtio_transport.c | 13 +++++++++++++
> > net/vmw_vsock/vmci_transport.c   | 12 ++++++++++++
> > net/vmw_vsock/vsock_loopback.c   |  6 ++++++
> > 7 files changed, 86 insertions(+)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 69074656263d..4e3856aa2479 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -64,6 +64,11 @@ static u32 vhost_transport_get_local_cid(void)
> > 	return VHOST_VSOCK_DEFAULT_HOST_CID;
> > }
> > 
> > +static bool vhost_transport_supports_local_mode(void)
> > +{
> > +	return false;
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
> > index 59d97a143204..e24ef1d9fe02 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -180,6 +180,17 @@ struct vsock_transport {
> > 	/* Addressing. */
> > 	u32 (*get_local_cid)(void);
> > 
> > +	/* Return true if the transport is compatible with
> > +	 * VSOCK_NET_MODE_LOCAL. Otherwise, return false.
> > +	 *
> > +	 * Transports should return false if they lack local-mode namespace
> > +	 * support (e.g., G2H transports like hyperv-vsock and vmci-vsock).
> > +	 * virtio-vsock returns true only if no device is present in order to
> > +	 * enable local mode in nested scenarios in which virtio-vsock is
> > +	 * loaded or built-in, but nonetheless unusable by sockets.
> > +	 */
> > +	bool (*supports_local_mode)(void);
> > +
> > 	/* Read a single skb */
> > 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
> > 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 243c0d588682..120adb9dad9f 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -91,6 +91,12 @@
> >  *   and locked down by a namespace manager. The default is "global". The mode
> >  *   is set per-namespace.
> >  *
> > + *   Note: LOCAL mode is only supported when using namespace-aware transports
> > + *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
> > + *   hyperv-vsock, vmci-vsock) is operational, attempts to set LOCAL mode will
> > + *   fail with EOPNOTSUPP, as these transports do not support per-namespace
> > + *   isolation.
> > + *
> >  *   The modes affect the allocation and accessibility of CIDs as follows:
> >  *
> >  *   - global - access and allocation are all system-wide
> > @@ -2794,6 +2800,15 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> > 	else
> > 		return -EINVAL;
> > 
> > +	mutex_lock(&vsock_register_mutex);
> > +	if (mode == VSOCK_NET_MODE_LOCAL &&
> > +	    transport_g2h && transport_g2h->supports_local_mode &&
> > +	    !transport_g2h->supports_local_mode()) {
> > +		mutex_unlock(&vsock_register_mutex);
> > +		return -EOPNOTSUPP;
> > +	}
> > +	mutex_unlock(&vsock_register_mutex);
> 
> Wait, I think we already discussed about this, vsock_net_write_mode() must
> be called with the lock held.
> 
> See
> https://lore.kernel.org/netdev/aRTTwuuXSz5CvNjt@devvm11784.nha0.facebook.com/
> 

Ah right, oversight on my part.

> Since I guess we need another version of this patch, can you check the
> commit description to see if it reflects what we are doing now
> (e.g vhost is not enabled)?
> 
> Also I don't understand why for vhost we will enable it later, but for
> virtio_transport and vsock_loopback we are enabling it now, also if this
> patch is before the support on that transports. I'm a bit confused.
> 
> If something is unclear, let's discuss it before sending a new version.
> 
> 
> What I had in mind was, add this patch and explain why we need this new
> callback (like you did), but enable the support in the patches that
> really enable it for any transport. But maybe what is not clear to me is
> that we need this only for G2H. But now I'm confused about the discussion
> around vmci H2G. We decided to discard also that one, but here we are not
> checking that?
> I mean here we are calling supports_local_mode() only on G2H IIUC.

Ah right, VMCI broke my original mental model of only needing this check
for G2H (originally I didn't realize VMCI was H2G too).

I think now, we actually need to do this check for all of the transports
no? Including h2g, g2h, local, and dgram?

Additionally, the commit description needs to be updated to reflect that.

With this, we then end up with two commits:

	commit 1) This commit which adds the callbacks and gives each
	transport stubs to return false. Checks all transports (not just
	G2H). Update the commit. Fix vsock_net_write_mode() race above.

	commit 2) change the virtio-vsock/vhost-vsock/vsock-loopback to
	add the real implementations (vhost + loopback return true,
	virtio detects device). The other transports keep their return
	false stubs so no changes.

Does that seem about right?

> 
> > +
> > 	if (!vsock_net_write_mode(net, mode))
> > 		return -EPERM;
> > 
> > @@ -2938,6 +2953,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> > {
> > 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
> > 	int err = mutex_lock_interruptible(&vsock_register_mutex);
> > +	struct net *net;
> > 
> > 	if (err)
> > 		return err;
> > @@ -2960,6 +2976,22 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> > 			err = -EBUSY;
> > 			goto err_busy;
> > 		}
> > +
> > +		/* G2H sockets break in LOCAL mode namespaces because G2H
> 
> And also here we are talking about only of G2H, so what happen if vmci is
> loaded as H2G?
> 
> IMO we should discuss this a bit more and make it a bit more generic, like
> check all the transports.
> 
> Thanks,
> Stefano

Agreed.

Best,
Bobby

