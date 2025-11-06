Return-Path: <linux-kselftest+bounces-45016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8237C3C665
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D217349077
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 16:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363AA34B198;
	Thu,  6 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdXehDpj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="isyxLzDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B4316905
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446111; cv=none; b=AUPtLEA7HjO1Bhhv8Y1qaWbRxyL3rM45qktl3FlbowzULkycSxlGzTSb0Zb61ZGSTx1mG+M+1Tfv2XsPxullmgzJt7IMqEHtcLNEM9K3aEiOnofQaDrN0lD2vnwHWO3wc2zBJ3IKCZWVRPSAuBIqi7fDO8YJDKUINplh+EYG8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446111; c=relaxed/simple;
	bh=byB0FjmheU8L8LWGRryKTbWj4FBva6lfo5UvPvvL+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iALnhqkfEgkguaSQdSr6djzTZn6svcKAHbk41Se/PBgvnh5qsBbsUjA1GjbmIDLaT+PjOP6Qgpdr34czQ+saRS8BLW2MLAMZCdrq0R+m8IdPniGSYf4qvkKzzdPwgwBGpfqcMmR4cyxdGsB8Mh8v1enE4q1mLI/HDdf2I09ZHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdXehDpj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=isyxLzDQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762446107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UiHS7Y1QmsB4ooCc/QO12f/u71QqLJQ+iWQOElP8jPM=;
	b=UdXehDpjAj9AgK6pc66EyyZofy8G8kq1+pCa1f8DbTwGIX0OPMYDcHsi1ObI6soMjzw/hG
	vIhGUS4DRtzJ1NwMCL8Gm1km61Z2e8y0Fy0dzKazyiNuh0947Plgh+A2fvb9gEoz+qSGW5
	WNnjFDk21GXzeAgx16JA0MDXRpSDfvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-GPR5QeOFPbSc31SBKELfIw-1; Thu, 06 Nov 2025 11:21:45 -0500
X-MC-Unique: GPR5QeOFPbSc31SBKELfIw-1
X-Mimecast-MFC-AGG-ID: GPR5QeOFPbSc31SBKELfIw_1762446105
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429b7b46eebso1115253f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762446105; x=1763050905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UiHS7Y1QmsB4ooCc/QO12f/u71QqLJQ+iWQOElP8jPM=;
        b=isyxLzDQtGQZWhVikaCeGrJh5O+onYutKC4n/8eBR0C+FoeTosaCDTZy0BMl7Ih8p3
         A3OpWwUKIV8kWJdtI7V0Evi2MHtKsFBsFsqfbufiCC7uIvxNHGPlIcKQN4xgIzzuoc15
         42dMBfTkEb2cdzC5W8klRLtfFzA4Lq7M33oTMcTz+pIqvNEJUZ+MXoecM8EvsV+M4Yd7
         wz+CiBG8TZkX+GZJTY37tUh3/gW22PRQPd9AJh9ElSzQidizcNn21Q4sr0Tjya7OYGB1
         faqidUClLAUQENHt6yRMB6QQ7QfDqGA73tGHwgqia41fqwhlCPNN9iCqMRrhWHSU8gZA
         Y75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446105; x=1763050905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiHS7Y1QmsB4ooCc/QO12f/u71QqLJQ+iWQOElP8jPM=;
        b=I3mU+0iDD7TwKqTT7DMLGpn21OUWWNtSobt7EibJWZr7vfh1dmJmMtDtJyi9+WfmJ3
         pMqrnAO9o/EZmtObpI4512toMFLfACepl1jYGwftKfHzTWjnevy7yGJt8O2G0vNfFTcF
         FlsNKC4oz0oIkYtNk+uMlJHTq21aUG/s+GwvcX/uHnPihBgQkB2BJwhLu285pWy9YWEK
         ALLsJs8G/RDsvcQyRUE0DF5LwsvdxuNMVg88kpsHjhl4mzhqTwSnlu49VxHvC/Og8gZh
         195bMa438eO6fJ5iBHVbJI95z4LWYe6Sr+FuEMg+/f2sG6C7k807AtEgYY9YNMoi1ViU
         2BOA==
X-Forwarded-Encrypted: i=1; AJvYcCXf8Aa4eFYh8dqSIpmyuHHdZ36CN1UbOBYsf13hQWJih0ZMPVW6J0HG6vyMju5FF+OwOWRHdbwOwhRCrrJ8jxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsGu7FSzFSy5SnKHfJC+x0qQf2yHDf/vviClNrmNME2EeXj9I
	9CFjSvfz/SWFn2i2tzI1XnU9oZpTOWeH6Bh8vkOdbYgK1ha9MhlzJJm3VG9/3GZuIWawIkyiWuB
	bB7Nsl9vXogbKDVbgTBgHIhIIxCTDp79BgyNAQXDjVnPQq4C4+QC6xe1Wk0crcZC2YdQVCg==
X-Gm-Gg: ASbGnctwxEGrhufFLgNS166ZYsBln7temiTuzgt7dkQNJ/SJlBI5lGVh+USux6Z0Ay1
	TGwAu5zH/RLZv0CpRMj/VFWQxFdZxsl423RX3KtyR9Ue2maHgq65EJ3YO9mktBLd3YrzBsCoIM1
	Ok8cVBRnthz1b6dJYttFDdMn6x3DRAGURVospmpCfO3cBUCRCezNvgheDHDp+ly6oHCyDtSUMhH
	Y9rR5vC6lRhkasz+KCrz5/Ns5+POO0KrlxLrfWYojoeEOxPh6EM6e4eCvIpJNVuaxHFyaYj3yw7
	fKydtt9TrMmaURHkjyrTaJVmuYRvFpkDvlfeudgyefD7lah3h+IQ/c6DAG0BQ6uijgJRw7EciNT
	3+g==
X-Received: by 2002:a5d:5d09:0:b0:429:d66b:50ae with SMTP id ffacd0b85a97d-429e33130d0mr6897561f8f.57.1762446104488;
        Thu, 06 Nov 2025 08:21:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHxdtHsEl0Bz10J9Od6FlZK0pdWzs5w5DcfrRmgPbyiiJc9s2vF+YRjR0Pvqt6+yGoII9VcQ==
X-Received: by 2002:a5d:5d09:0:b0:429:d66b:50ae with SMTP id ffacd0b85a97d-429e33130d0mr6897515f8f.57.1762446103886;
        Thu, 06 Nov 2025 08:21:43 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4106e0sm6253117f8f.11.2025.11.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:21:43 -0800 (PST)
Date: Thu, 6 Nov 2025 17:21:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 07/14] vhost/vsock: add netns support
Message-ID: <juxkmz3vskdopukejobv745j6qqx45hhcdjtjw7gcpgz6fj5ws@ckz7dvyup6mq>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-7-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-7-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:46AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the ability to isolate vhost-vsock flows using namespaces.
>
>The VM, via the vhost_vsock struct, inherits its namespace from the
>process that opens the vhost-vsock device. vhost_vsock lookup functions
>are modified to take into account the mode (e.g., if CIDs are matching
>but modes don't align, then return NULL).
>
>vhost_vsock now acquires a reference to the namespace.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v7:
>- remove the check_global flag of vhost_vsock_get(), that logic was both
>  wrong and not necessary, reuse vsock_net_check_mode() instead
>- remove 'delete me' comment
>Changes in v5:
>- respect pid namespaces when assigning namespace to vhost_vsock
>---
> drivers/vhost/vsock.c | 44 ++++++++++++++++++++++++++++++++++----------
> 1 file changed, 34 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 34adf0cf9124..df6136633cd8 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -46,6 +46,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
> struct vhost_vsock {
> 	struct vhost_dev dev;
> 	struct vhost_virtqueue vqs[2];
>+	struct net *net;
>+	netns_tracker ns_tracker;
>+
>+	/* The ns mode at the time vhost_vsock was created */
>+	enum vsock_net_mode net_mode;
>
> 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
> 	struct hlist_node hash;
>@@ -67,7 +72,8 @@ static u32 vhost_transport_get_local_cid(void)
> /* Callers that dereference the return value must hold vhost_vsock_mutex or the
>  * RCU read lock.
>  */
>-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net,
>+					   enum vsock_net_mode mode)
> {
> 	struct vhost_vsock *vsock;
>
>@@ -78,9 +84,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
> 		if (other_cid == 0)
> 			continue;
>
>-		if (other_cid == guest_cid)
>+		if (other_cid == guest_cid &&
>+		    vsock_net_check_mode(net, mode, vsock->net, vsock->net_mode))
> 			return vsock;
>-
> 	}
>
> 	return NULL;
>@@ -271,14 +277,16 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
> static int
> vhost_transport_send_pkt(struct sk_buff *skb)
> {
>+	enum vsock_net_mode mode = virtio_vsock_skb_net_mode(skb);
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct net *net = virtio_vsock_skb_net(skb);
> 	struct vhost_vsock *vsock;
> 	int len = skb->len;
>
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
>+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, mode);
> 	if (!vsock) {
> 		rcu_read_unlock();
> 		kfree_skb(skb);
>@@ -305,7 +313,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
>+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
>+				sock_net(sk_vsock(vsk)), vsk->net_mode);
> 	if (!vsock)
> 		goto out;
>
>@@ -327,7 +336,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static struct sk_buff *
>-vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>+vhost_vsock_alloc_skb(struct vhost_vsock *vsock, struct vhost_virtqueue *vq,
> 		      unsigned int out, unsigned int in)
> {
> 	struct virtio_vsock_hdr *hdr;
>@@ -353,6 +362,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 	if (!skb)
> 		return NULL;
>
>+	virtio_vsock_skb_set_net(skb, vsock->net);
>+	virtio_vsock_skb_set_net_mode(skb, vsock->net_mode);
>+
> 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
>
> 	hdr = virtio_vsock_hdr(skb);
>@@ -462,11 +474,12 @@ static struct virtio_transport vhost_transport = {
>
> static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> {
>+	struct net *net = sock_net(sk_vsock(vsk));
> 	struct vhost_vsock *vsock;
> 	bool seqpacket_allow = false;
>
> 	rcu_read_lock();
>-	vsock = vhost_vsock_get(remote_cid);
>+	vsock = vhost_vsock_get(remote_cid, net, vsk->net_mode);
>
> 	if (vsock)
> 		seqpacket_allow = vsock->seqpacket_allow;
>@@ -520,7 +533,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 			break;
> 		}
>
>-		skb = vhost_vsock_alloc_skb(vq, out, in);
>+		skb = vhost_vsock_alloc_skb(vsock, vq, out, in);
> 		if (!skb) {
> 			vq_err(vq, "Faulted on pkt\n");
> 			continue;
>@@ -652,8 +665,10 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
>
> static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> {
>+
> 	struct vhost_virtqueue **vqs;
> 	struct vhost_vsock *vsock;
>+	struct net *net;
> 	int ret;
>
> 	/* This struct is large and allocation could fail, fall back to vmalloc
>@@ -669,6 +684,14 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> 		goto out;
> 	}
>
>+	net = current->nsproxy->net_ns;
>+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
>+
>+	/* Cache the mode of the namespace so that if that netns mode changes,
>+	 * the vhost_vsock will continue to function as expected.
>+	 */

I think we should document this in the commit description and in both we 
should add also the reason. (IIRC, it was to simplify everything and 
prevent a VM from changing modes when running and then tracking all its 
packets)

>+	vsock->net_mode = vsock_net_mode(net);
>+
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>
>@@ -708,7 +731,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> 	 */
>
> 	/* If the peer is still valid, no need to reset connection */
>-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), vsk->net_mode))
> 		return;
>
> 	/* If the close timeout is pending, let it expire.  This avoids races
>@@ -753,6 +776,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>
> 	vhost_dev_cleanup(&vsock->dev);
>+	put_net_track(vsock->net, &vsock->ns_tracker);

Doing this after virtio_vsock_skb_queue_purge() should ensure that all 
skbs have been drained, so there should be no one flying with this 
netns. Perhaps this clarifies my doubts about the skb net, but should we 
do something similar for loopback as well?

And maybe we should document that also in the virtio_vsock_skb_cb.

The rest LGTM.

Thanks,
Stefano

> 	kfree(vsock->dev.vqs);
> 	vhost_vsock_free(vsock);
> 	return 0;
>@@ -779,7 +803,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>
> 	/* Refuse if CID is already in use */
> 	mutex_lock(&vhost_vsock_mutex);
>-	other = vhost_vsock_get(guest_cid);
>+	other = vhost_vsock_get(guest_cid, vsock->net, vsock->net_mode);
> 	if (other && other != vsock) {
> 		mutex_unlock(&vhost_vsock_mutex);
> 		return -EADDRINUSE;
>
>-- 
>2.47.3
>


