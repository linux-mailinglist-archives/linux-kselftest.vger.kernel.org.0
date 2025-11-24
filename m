Return-Path: <linux-kselftest+bounces-46372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB5C7FD17
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A099B342ED5
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7638B2F9987;
	Mon, 24 Nov 2025 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Is9SHJWh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5YnxEjL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1B2F7462
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979034; cv=none; b=iK9fIXApDfYcE0Vn+TBxFcQcr+NwSZUbVUyZfkiFBZSjANx3CixgmrsT6TXqAukLNMCFqcwG+KOjc0mnzkGHXnAbmAUu1AFBvryQkmDjxLFUJZxMDCUtmE1Xev3wC910muHC6v6wglTO1nWySSXdE6u05hATHIo59MI2Clp7+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979034; c=relaxed/simple;
	bh=Ns6LfH0psojXT7Bh+E2CKXpJNrIUwj78AFA2Jq4LOk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR4xflbd+Ob2wzw2dq1kX6E6WkyDMoFJalzDsgoGZNJrVHxPUwk5xwtWrSPcMDwMVKx3R5A2oBJlHJ2U+nylCqQ8tIIDp5EInJj1qBf2+89lDWv5MeVibRluSoIomlwHmGpV7yDzyQMC0LV7wLTdWYMJEeA8XlrlINesds9Sf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Is9SHJWh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5YnxEjL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763979030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5u6sQSNL++dp7mJ0fNqBXPU6F3Qeuu2qX0vGBMLsEc4=;
	b=Is9SHJWhmhYlVZZRzpkzJVFa+ipQfqyKv2WzUqKO7Kc6qr/l3OOVDKREKnrWERe0haafhO
	I1BnOG1hj8j26Pb+uSstZWUrHECLtCUwMwB1geS7SnQELI1cVIkgrteai+GjPrqrCMxAmk
	Ttb+z91slzAWGmS6liGvYXQnE7YZH70=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-PUP2kAisNyu-AZmCydsaRA-1; Mon, 24 Nov 2025 05:10:28 -0500
X-MC-Unique: PUP2kAisNyu-AZmCydsaRA-1
X-Mimecast-MFC-AGG-ID: PUP2kAisNyu-AZmCydsaRA_1763979028
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3339cab7so2759727f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 02:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763979027; x=1764583827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5u6sQSNL++dp7mJ0fNqBXPU6F3Qeuu2qX0vGBMLsEc4=;
        b=G5YnxEjL3fJtNY2LBIbbcQ1URhM6IZRWXMErN/ZZNcW0DOejO08bhXhFEiCb+3Fuen
         qACF9GiNVAg3uuQVOmTk3dtf6AkLduBT1QAIJxSNu5vDolGKen3tLeHb2zUBgSR9/Z6s
         V6ElgTSGkxbnuwm/rGqql/4LZ0q7ZmVgHXm9zBaiw07voXIvzqm8bok1SpHS4X31S/4I
         zPA53zE7pnunb+vcq83ii+yo9SxxqLTZI0AoTV6kB1KWf8U46CT/zBO67ehRb24cMbrI
         95X9UMcDNeTDI01vPYmjN8kWGQJ2AADyTvr/IK98ldNdaAH2bnvXKQyz13dnOVzQx6J/
         hzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763979027; x=1764583827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5u6sQSNL++dp7mJ0fNqBXPU6F3Qeuu2qX0vGBMLsEc4=;
        b=T+sfIdTd+VXs837a2nqJfqurVU0NYP2c8JqWEULQTI3gwQ6r5tj6CW7m+z4/5hkQHw
         ga9atLiGu2AekuiONcT73D310GYTxbIvabrRQMniqegE/DxRcBT4biPh+DfETYeoN2Is
         5UYz1cgXdb/IFqK8HfRfkYVLq4uDgV/AMbqGdje35Ac/URmI7H7Nt0WYK3gowb7MTWvm
         HMrqHimuUokRcIvF8a3ouQ+svF4X1BIn39oSpudDejh7FDYV0QdvEBjESvCGhYOS6h3X
         i2uPZzWOgwYc3Q4yj8SI8M5b2ug2lEViLsZsYZQ5H18Lc5Ti3tSwjpIBSsLOJaZrDYoG
         ZMdg==
X-Forwarded-Encrypted: i=1; AJvYcCU2YRXm3MrN0djbMM4rrP4BScRdMGCgP2IxLQbvhD4WqQmzej7zbJSs6V2gBIIpLjtw6Xnu+yIXGL1cIJ9uqI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxl9EwwjQfabP0sGfOS3TC1YoONgmYFBPoa4LDO+C7M2MjFq25
	5e16+20JaJhPEy9BuHEUfW2Pqni+umF52sqmjnt9mKj3K3UqTJxRyd/ZkHnYQb9A3L0/45uYeME
	rS8Q1UsE7Vbo1Qcxm0roDqu9Wsxel9moigJUH61NlXIPN/HBIw63/iOY/++tEb9wJIWzbFw==
X-Gm-Gg: ASbGncvVlxWWUhcyxcXH9B3npGUcrygQsEKQSHBNd+nbeBkN4ljt5nU7Uas5DPnXjb9
	AJeG42rl+yTIBKS6EZVbe8Ce+ro0FeFvq+lw27+B0dYjNeuyu4reEfeKPGRWz6im/4/C71UOkTs
	I1rWd55yU8DKhLQshVdyVIgca6JFT7WPAImJ4LI6By1ScHPC/29dqcnqhSqfvN4cxgXDg2/Bl0/
	3/8wXpnFnlihuNYMOfJlkHdbUBtkaUd3XJ+XnwZ5jLlv+FRPZGDWTWFKYsQcT2g3IfOjFdbJDpO
	T43BRLw7ympq0Pyzs8NefCNnez8pi7HbZC+NUP9B+hjn/xJ0Zgafp+NEdLdMeZpGwNWv8ZRNOJ3
	6vJco4GSxvdmIh2rAahGzFtSjTX4mcHdHeExaV0GeFr31ll6S44zKGWDMBcqgew==
X-Received: by 2002:a05:6000:40da:b0:42b:3e60:18cd with SMTP id ffacd0b85a97d-42cc1cd5cccmr12145471f8f.11.1763979027380;
        Mon, 24 Nov 2025 02:10:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyUT90+gJ9f1dKanVENzRuq3J7mmdAzbMAoIPoT3+96b1SckYvJyZjhh16MBsnzjUYf99sZA==
X-Received: by 2002:a05:6000:40da:b0:42b:3e60:18cd with SMTP id ffacd0b85a97d-42cc1cd5cccmr12145417f8f.11.1763979026810;
        Mon, 24 Nov 2025 02:10:26 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5a3sm27522572f8f.6.2025.11.24.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:10:26 -0800 (PST)
Date: Mon, 24 Nov 2025 11:10:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 03/13] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <g4xir3lupnjybh7fqig6xonp32ubotdf3emmrozdm52tpaxvxn@2t4ueynb7hqr>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-3-55cbc80249a7@meta.com>
 <swa5xpovczqucynffqgfotyx34lziccwpqomnm5a7iwmeyixfv@uehtzbdj53b4>
 <aSC3IX81A3UhtD3N@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aSC3IX81A3UhtD3N@devvm11784.nha0.facebook.com>

On Fri, Nov 21, 2025 at 11:01:53AM -0800, Bobby Eshleman wrote:
>On Fri, Nov 21, 2025 at 03:24:25PM +0100, Stefano Garzarella wrote:
>> On Thu, Nov 20, 2025 at 09:44:35PM -0800, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Reject setting VSOCK_NET_MODE_LOCAL with -EOPNOTSUPP if a G2H transport
>> > is operational. Additionally, reject G2H transport registration if there
>> > already exists a namespace in local mode.
>> >
>> > G2H sockets break in local mode because the G2H transports don't support
>> > namespacing yet. The current approach is to coerce packets coming out of
>> > G2H transports into VSOCK_NET_MODE_GLOBAL mode, but it is not possible
>> > to coerce sockets in the same way because it cannot be deduced which
>> > transport will be used by the socket. Specifically, when bound to
>> > VMADDR_CID_ANY in a nested VM (both G2H and H2G available), it is not
>> > until a packet is received and matched to the bound socket that we
>> > assign the transport. This presents a chicken-and-egg problem, because
>> > we need the namespace to lookup the socket and resolve the transport,
>> > but we need the transport to know how to use the namespace during
>> > lookup.
>> >
>> > For that reason, this patch prevents VSOCK_NET_MODE_LOCAL from being
>> > used on systems that support G2H, even nested systems that also have H2G
>> > transports.
>> >
>> > Local mode is blocked based on detecting the presence of G2H devices
>> > (when possible, as hyperv is special). This means that a host kernel
>> > with G2H support compiled in (or has the module loaded), will still
>> > support local mode if there is no G2H (e.g., virtio-vsock) device
>> > detected. This enables using the same kernel in the host and in the
>> > guest, as we do in kselftest.
>> >
>> > Systems with only namespace-aware transports (vhost-vsock, loopback) can
>> > still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
>> > intended.
>> >
>> > Add supports_local_mode() transport callback to indicate
>> > transport-specific local mode support.
>> >
>> > These restrictions can be lifted in a future patch series when G2H
>> > transports gain namespace support.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v11:
>> > - vhost_transport_supports_local_mode() returns false to keep things
>> >  disabled until support comes online (Stefano)
>> > - add comment above supports_local_mode() cb to clarify (Stefano)
>> > - Remove redundant `ret = 0` initialization in vsock_net_mode_string()
>> >  (Stefano)
>> > - Refactor vsock_net_mode_string() to separate parsing from validation
>> >  (Stefano)
>> > - vmci returns false for supports_local_mode(), with comment
>> >
>> > Changes in v10:
>> > - move this patch before any transports bring online namespacing (Stefano)
>> > - move vsock_net_mode_string into critical section (Stefano)
>> > - add ->supports_local_mode() callback to transports (Stefano)
>> > ---
>> > drivers/vhost/vsock.c            |  6 ++++++
>> > include/net/af_vsock.h           | 11 +++++++++++
>> > net/vmw_vsock/af_vsock.c         | 32 ++++++++++++++++++++++++++++++++
>> > net/vmw_vsock/hyperv_transport.c |  6 ++++++
>> > net/vmw_vsock/virtio_transport.c | 13 +++++++++++++
>> > net/vmw_vsock/vmci_transport.c   | 12 ++++++++++++
>> > net/vmw_vsock/vsock_loopback.c   |  6 ++++++
>> > 7 files changed, 86 insertions(+)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 69074656263d..4e3856aa2479 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -64,6 +64,11 @@ static u32 vhost_transport_get_local_cid(void)
>> > 	return VHOST_VSOCK_DEFAULT_HOST_CID;
>> > }
>> >
>> > +static bool vhost_transport_supports_local_mode(void)
>> > +{
>> > +	return false;
>> > +}
>> > +
>> > /* Callers that dereference the return value must hold vhost_vsock_mutex or the
>> >  * RCU read lock.
>> >  */
>> > @@ -412,6 +417,7 @@ static struct virtio_transport vhost_transport = {
>> > 		.module                   = THIS_MODULE,
>> >
>> > 		.get_local_cid            = vhost_transport_get_local_cid,
>> > +		.supports_local_mode	  = vhost_transport_supports_local_mode,
>> >
>> > 		.init                     = virtio_transport_do_socket_init,
>> > 		.destruct                 = virtio_transport_destruct,
>> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > index 59d97a143204..e24ef1d9fe02 100644
>> > --- a/include/net/af_vsock.h
>> > +++ b/include/net/af_vsock.h
>> > @@ -180,6 +180,17 @@ struct vsock_transport {
>> > 	/* Addressing. */
>> > 	u32 (*get_local_cid)(void);
>> >
>> > +	/* Return true if the transport is compatible with
>> > +	 * VSOCK_NET_MODE_LOCAL. Otherwise, return false.
>> > +	 *
>> > +	 * Transports should return false if they lack local-mode namespace
>> > +	 * support (e.g., G2H transports like hyperv-vsock and vmci-vsock).
>> > +	 * virtio-vsock returns true only if no device is present in order to
>> > +	 * enable local mode in nested scenarios in which virtio-vsock is
>> > +	 * loaded or built-in, but nonetheless unusable by sockets.
>> > +	 */
>> > +	bool (*supports_local_mode)(void);
>> > +
>> > 	/* Read a single skb */
>> > 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>> >
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index 243c0d588682..120adb9dad9f 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -91,6 +91,12 @@
>> >  *   and locked down by a namespace manager. The default is "global". The mode
>> >  *   is set per-namespace.
>> >  *
>> > + *   Note: LOCAL mode is only supported when using namespace-aware transports
>> > + *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
>> > + *   hyperv-vsock, vmci-vsock) is operational, attempts to set LOCAL mode will
>> > + *   fail with EOPNOTSUPP, as these transports do not support per-namespace
>> > + *   isolation.
>> > + *
>> >  *   The modes affect the allocation and accessibility of CIDs as follows:
>> >  *
>> >  *   - global - access and allocation are all system-wide
>> > @@ -2794,6 +2800,15 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
>> > 	else
>> > 		return -EINVAL;
>> >
>> > +	mutex_lock(&vsock_register_mutex);
>> > +	if (mode == VSOCK_NET_MODE_LOCAL &&
>> > +	    transport_g2h && transport_g2h->supports_local_mode &&
>> > +	    !transport_g2h->supports_local_mode()) {
>> > +		mutex_unlock(&vsock_register_mutex);
>> > +		return -EOPNOTSUPP;
>> > +	}
>> > +	mutex_unlock(&vsock_register_mutex);
>>
>> Wait, I think we already discussed about this, vsock_net_write_mode() must
>> be called with the lock held.
>>
>> See
>> https://lore.kernel.org/netdev/aRTTwuuXSz5CvNjt@devvm11784.nha0.facebook.com/
>>
>
>Ah right, oversight on my part.
>
>> Since I guess we need another version of this patch, can you check the
>> commit description to see if it reflects what we are doing now
>> (e.g vhost is not enabled)?
>>
>> Also I don't understand why for vhost we will enable it later, but for
>> virtio_transport and vsock_loopback we are enabling it now, also if this
>> patch is before the support on that transports. I'm a bit confused.
>>
>> If something is unclear, let's discuss it before sending a new version.
>>
>>
>> What I had in mind was, add this patch and explain why we need this new
>> callback (like you did), but enable the support in the patches that
>> really enable it for any transport. But maybe what is not clear to me is
>> that we need this only for G2H. But now I'm confused about the discussion
>> around vmci H2G. We decided to discard also that one, but here we are not
>> checking that?
>> I mean here we are calling supports_local_mode() only on G2H IIUC.
>
>Ah right, VMCI broke my original mental model of only needing this check
>for G2H (originally I didn't realize VMCI was H2G too).
>
>I think now, we actually need to do this check for all of the transports
>no? Including h2g, g2h, local, and dgram?
>
>Additionally, the commit description needs to be updated to reflect that.

Let's take a step back, though, because I tried to understand the 
problem better and I'm confused.

For example, in vmci (G2H side), when a packet arrives, we always use 
vsock_find_connected_socket(), which only searches in GLOBAL. So 
connections originating from the host can only reach global sockets in 
the guest. In this direction (host -> guest), we should be fine, right?

Now let's consider the other direction, from guest to host, so the 
connection should be generated via vsock_connect().
Here I see that we are not doing anything with regard to the source 
namespace. At this point, my question is whether we should modify 
vsock_assign_transport() or transport->stream_allow() to do this for 
each stream, and not prevent loading a G2H module a priori.

For example, stream_allow() could check that the socket namespace is 
supported by the assigned transport. E.g., vmci can check that if the 
namespace mode is not GLOBAL, then it returns false. (Same thing in 
virtio-vsock, I mean the G2H driver).

This should solve the guest -> host direction, but at this point I 
wonder if I'm missing something.

>
>With this, we then end up with two commits:
>
>	commit 1) This commit which adds the callbacks and gives each
>	transport stubs to return false. Checks all transports (not just
>	G2H). Update the commit. Fix vsock_net_write_mode() race above.
>
>	commit 2) change the virtio-vsock/vhost-vsock/vsock-loopback to
>	add the real implementations (vhost + loopback return true,
>	virtio detects device). The other transports keep their return
>	false stubs so no changes.
>
>Does that seem about right?

If we really need this approach, this should be fine.

Thanks,
Stefano


